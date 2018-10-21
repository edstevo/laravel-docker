FROM php:7.2-fpm

COPY . /var/www
COPY .docker/php/php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/

RUN chown -R www-data:www-data /var/www

RUN apt-get update \
    && apt-get install -y libmcrypt-dev mysql-client libmagickwand-dev --no-install-recommends \
    && apt-get install -y git libzip-dev zip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-install pdo_mysql mbstring zip