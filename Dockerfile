# Used for prod build.
FROM php:8.2-fpm as php

# Set environment variables
ENV PHP_OPCACHE_ENABLE=1
ENV PHP_OPCACHE_ENABLE_CLI=1
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS=1
ENV PHP_OPCACHE_REVALIDATE_FREQ=1

# Install dependencies.
RUN apt-get update && apt-get install -y unzip libpq-dev libcurl4-gnutls-dev nginx libonig-dev

# Install PHP extensions.
RUN docker-php-ext-install pdo pdo_mysql bcmath curl mbstring opcache exif

# Copy configuration files.
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini
COPY ./docker/php/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

# Copy composer executable.
COPY --from=composer:2.5.5 /usr/bin/composer /usr/bin/composer

# Set working directory to /var/www.
WORKDIR /var/www

# Copy existing application directory files and permissions
COPY --chown=www-data:www-data . .

# Set correct permissions.
RUN chmod -R 755 /var/www

# Adjust user permission & group
RUN usermod --uid 1000 www-data
RUN groupmod --gid 1000 www-data

ENTRYPOINT [ "docker/entrypoint.sh" ]
