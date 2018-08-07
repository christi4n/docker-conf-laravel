FROM php:7.2.8-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev \
    && pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt.so

RUN apt-get update && \
	apt-get install -y libmcrypt-dev \
    mysql-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
&& docker-php-ext-install pdo_mysql

RUN apt-get install -y libfreetype6-dev \
	curl \
	php7.0-cli \
    php7.0-json \
    php7.0-curl \
 	libpng-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ======= composer =======
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chmod 755 /var/www

RUN addgroup -g 1000 web && \
  adduser -G web -g web -s /bin/sh -D /var/www

# Define composer cache directory
RUN mkdir -p /tmp/composer && chmod 777 /tmp/composer
ENV COMPOSER_CACHE_DIR=/tmp/composer