# # Use the official PHP image with Apache
# FROM php:8.3-apache

# # Install system dependencies and PHP extensions
# RUN apt-get update && apt-get install -y \
#     libicu-dev \
#     libpng-dev \
#     libjpeg-dev \
#     libfreetype6-dev \
#     git \
#     unzip \
#     nano \
#     && docker-php-ext-configure gd --with-freetype --with-jpeg \
#     && docker-php-ext-install gd intl pdo pdo_mysql

# # Install Composer
# RUN curl -sS https://getcomposer.org/installer -o /usr/local/bin/composer-installer.php \
#     && php /usr/local/bin/composer-installer.php --install-dir=/usr/local/bin --filename=composer \
#     && rm /usr/local/bin/composer-installer.php

# # Copy Apache configuration file
# COPY ./docker-compose/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

# # Set ServerName to suppress warnings
# RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# # Set working directory
# WORKDIR /var/www/html

# # Expose port 80
# EXPOSE 80

# # Set permissions and ownership
# RUN chown -R www-data:www-data /var/www/html \
#     && find /var/www/html -type d -exec chmod 755 {} \; \
#     && find /var/www/html -type f -exec chmod 644 {} \;

# # Start Apache
# CMD ["apache2-foreground"]


# Use the official PHP image with CLI
FROM php:8.3-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    unzip \
    nano \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd intl pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer -o /usr/local/bin/composer-installer.php \
    && php /usr/local/bin/composer-installer.php --install-dir=/usr/local/bin --filename=composer \
    && rm /usr/local/bin/composer-installer.php

# Set working directory
WORKDIR /var/www/html

# Expose port 9000 (for PHP-FPM)
EXPOSE 9000

# Set permissions and ownership
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

# Start PHP-FPM
CMD ["php-fpm"]
