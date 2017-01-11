# Wordpress docker image
official wordpress based image with:

- persistent storage for `plugins` and `themes`
- wp-cli
- automated wordpress installation
- automated plugin installation
- automated themes installation
- custom php.ini and memory limits
- plugin wp-stateless for storing `uploads` in Cloud Bucket

## ENV variables
`WORDPRESS_DB_HOST`
`WORDPRESS_DB_PASSWORD`
`WP_URL`
`WP_TITLE`
`WP_USER`
`WP_PASSWORD`
`WP_EMAIL`

## Example usage:
`docker run -v $(pwd)/volume:/var/app-storage/ -e WORDPRESS_DB_HOST='mariadb' -e WORDPRESS_DB_PASSWORD='secretpassword' -e WP_URL='example.net' -e WP_TITLE='My Awesome Wordpress Site' -e WP_USER='admin' -e WP_PASSWORD='secretpasswordofadmin' WP_EMAIL='admin@example.net' ackee/wordpress`

