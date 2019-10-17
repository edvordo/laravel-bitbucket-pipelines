FROM php:7.2

RUN apt-get update --fix-missing
RUN apt-get upgrade -qy
RUN apt-get install -qy \
    git \
    ssh \
    curl \
    libmcrypt-dev \
    zip \
    unzip \
    libc-client-dev \
    libkrb5-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev

RUN pecl install mcrypt-1.0.2

RUN docker-php-ext-install pdo_mysql bcmath zip

RUN docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/

RUN docker-php-ext-configure imap \
    --with-kerberos \
    --with-imap-ssl

RUN docker-php-ext-install -j$(nproc) imap gd

ENV COMPOSER_HOME /composer

ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH

RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

RUN composer --version

RUN composer global require hirak/prestissimo
