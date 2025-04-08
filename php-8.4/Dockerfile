FROM php:8.4

RUN apt-get update --fix-missing

RUN apt-get upgrade -qy

RUN apt-get install -qy ssh git curl tzdata less

RUN apt-get autoremove -qy

RUN curl -Lo install-php-extensions https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    && chmod +x ./install-php-extensions

RUN ./install-php-extensions pdo_mysql pcntl gd zip redis memcached intl soap bcmath imap

RUN rm -f install-php-extensions

ENV COMPOSER_HOME /composer

ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

RUN composer --version

