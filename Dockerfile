FROM php:8.3-fpm

# Gerekli sistem bağımlılıklarını yükleyin
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip opcache bcmath sockets

# Redis uzantısını yükle
RUN pecl install redis && docker-php-ext-enable redis

# MongoDB uzantısını yükle
RUN pecl install mongodb && docker-php-ext-enable mongodb

# Elasticsearch için PHP istemcisini yüklemek için Composer'ı kullanabilirsiniz.

# Composer'ı yükleyin
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Çalışma dizini ayarlayın
WORKDIR /var/www/html

# Laravel için uygun izinleri ayarlayın
RUN chown -R www-data:www-data /var/www/html
