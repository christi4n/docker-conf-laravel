FROM php:7.2.2-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev \
    && pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt.so

RUN apt-get update && apt-get install -y libmcrypt-dev \
    mysql-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
&& docker-php-ext-install pdo_mysql

RUN chown -R www-data:www-data /var/www

RUN chmod 755 /var/www