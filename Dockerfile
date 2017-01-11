FROM wordpress
COPY php.ini /usr/local/etc/php/conf.d
# set higher limits
COPY ackee-entrypoint.sh /
RUN sed -i '$i /ackee-entrypoint.sh' /usr/local/bin/docker-entrypoint.sh

# Install wp-cli
RUN curl \
        -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp
