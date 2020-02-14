FROM php:7.4

RUN apt-get update --fix-missing

RUN apt-get upgrade -qy

RUN apt-get install -qy \
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
    libzip-dev

RUN apt-get autoremove -qy

RUN pecl install mcrypt-1.0.3

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

RUN composer global require hirak/prestissimo
