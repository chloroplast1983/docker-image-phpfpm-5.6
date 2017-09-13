FROM php:5.6-fpm
COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf
RUN apt-get update && apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng12-dev \
	&& rm -r /var/lib/apt/lists/* \ 
	&& docker-php-ext-install -j$(nproc) iconv mcrypt \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install mysql \
        && docker-php-ext-install mysqli \
        && docker-php-ext-install pdo_mysql \
        && set -ex \
        && { \
                echo 'zend_extension=opcache.so'; \
        } | tee /usr/local/etc/php/conf.d/opcache.ini \
        && { \
                echo 'upload_max_filesize = 5M'; \
        } | tee /usr/local/etc/php/conf.d/upload.ini \
        && { \
                echo "date.timezone = 'PRC'"; \
        } | tee /usr/local/etc/php/conf.d/timezone.ini \
        && { \
                echo "memory_limit = '256'"; \
        } | tee /usr/local/etc/php/conf.d/memorylimit.ini \
        && { \
                echo "display_errors = off"; \
                echo "error_reporting = E_ALL"; \
                echo "log_errors = on"; \
        } | tee /usr/local/etc/php/conf.d/error.ini \
