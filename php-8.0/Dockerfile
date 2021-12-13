FROM php:8.0.13

RUN apt-get update --fix-missing

RUN apt-get upgrade -qy

RUN apt-get install -qy \
    libonig-dev \
    libpng-dev \
    libmemcached-dev \
    git \
    ssh \
    curl \
    libmcrypt-dev \
    zip \
    unzip \
    libicu-dev \
    libc-client-dev \
    libkrb5-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libzip-dev \
    libxml2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



RUN set -ex \
    && rm -rf /var/lib/apt/lists/* \
    && MEMCACHED="`mktemp -d`" \
    && curl -skL https://github.com/php-memcached-dev/php-memcached/archive/master.tar.gz | tar zxf - --strip-components 1 -C $MEMCACHED \
    && docker-php-ext-configure $MEMCACHED \
    && docker-php-ext-install $MEMCACHED \
    && rm -rf $MEMCACHED

RUN rm /etc/apt/preferences.d/no-debian-php

RUN apt-get update --fix-missing

RUN apt-get upgrade -qy

RUN apt-get autoremove -qy

RUN pecl install mcrypt-1.0.4

RUN docker-php-ext-install soap

RUN docker-php-ext-install pdo_mysql bcmath zip

RUN docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/

RUN PHP_OPENSSL=yes docker-php-ext-configure imap \
    --with-kerberos \
    --with-imap-ssl

RUN docker-php-ext-install -j$(nproc) imap gd

RUN docker-php-ext-configure intl

RUN docker-php-ext-install intl

ENV COMPOSER_HOME /composer

ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH

RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer 

RUN composer --version

