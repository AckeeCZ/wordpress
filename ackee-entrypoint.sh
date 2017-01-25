#!/bin/bash
set -x
# add WP memory limits
configFile=/var/www/html/wp-config.php
#grep 'WP_MAX_MEMORY_LIMIT' $configFile || echo "define( 'WP_MAX_MEMORY_LIMIT', '256M' );" >>$configFile
#grep 'WP_MEMORY_LIMIT' $configFile || echo "define( 'WP_MEMORY_LIMIT', '96M' );" >>$configFile

# make symbolic links to persistent volume storage
storagePath=/var/app-storage
wpContentPath=/var/www/html/wp-content

wp='wp --allow-root'

for i in plugins themes;
do
   mkdir -p ${storagePath}/$i
   rm -rf -- ${wpContentPath}/$i
   ln -s ${storagePath}/$i ${wpContentPath}/$i
done

# install wordpress
#WP_URL="${WP_URL:-`hostname`}"
WP_TITLE="${WP_TITLE:-Example}"
WP_USER="${WP_USER:-test}"
WP_PASSWORD="${WP_PASSWORD:-ackeetest}"
WP_EMAIL="${WP_EMAIL:-info@example.com}"
$wp core is-installed || $wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_USER" --admin_password="$WP_PASSWORD" --admin_email="$WP_EMAIL"

# add plugins
plugins=(wp-stateless)
for i in ${plugins[*]}
do
   $wp plugin install $i
   $wp plugin activate $i
done

# add default themes
for i in twentyseventeen twentysixteen twentyfifteen 
do
   $wp theme is-installed $i || $wp theme install $i
done

# hotfix URL
[[ $WP_URL != "" ]] && echo "define('WP_HOME','$WP_URL');" >> wp-config.php
[[ $WP_URL != "" ]] && echo "define('WP_SITEURL','$WP_URL');" >> wp-config.php

chown -R www-data:www-data /var/www/html $storagePath

set +x
