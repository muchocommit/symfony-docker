FROM php:8.3-fpm

# Install required libs and configure php
RUN apt update && apt install -y git libicu-dev g++ libpcre3-dev libzip-dev zip lsof \
    libpq-dev libpng-dev librabbitmq-dev libxslt-dev nano postgresql-client graphviz \
    net-tools iputils-ping htop procps \
    && docker-php-ext-install -j$(nproc) gd xsl opcache pdo_pgsql zip intl pcntl \
    && pecl install xdebug-3.3.2 \
    && docker-php-ext-enable pcntl xdebug

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
# Install symfony-cli
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash && apt install symfony-cli

# Add correct user
RUN chown -R www-data:www-data /var/www /var/run \
    /usr/bin/symfony /usr/bin/composer
