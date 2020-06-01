# phpBB Dockerfile

# get latest image for 7.2 as 7.3 is not compatible
FROM php:7.2.31-apache

# Do a dist-upgrade 

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get dist-upgrade -y

# install the required packages:
RUN apt-get install --no-install-recommends --no-install-suggests -y \
    libpng-dev \
    nano \
    libjpeg-dev \
    imagemagick \
    jq \
    bzip2    

# install editor
RUN apt-get install nano 
RUN apt-get install -y vim 
RUN apt-get install -y iputils-ping

# Install required PHP extensions:
RUN docker-php-ext-configure \
    gd --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install \
    gd \
    mysqli
 
  # Uninstall obsolete packages:
RUN apt-get autoremove -y \
    libpng-dev \
    libjpeg-dev
 
  # Remove obsolete files:
RUN apt-get clean \
  && rm -rf \
    /tmp/* \
    /usr/share/doc/* \
    /var/cache/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# Enable the Apache Rewrite module:
RUN ln -s /etc/apache2/mods-available/rewrite.load \
  /etc/apache2/mods-enabled/rewrite.load

# Enable the Apache Headers module:
RUN ln -s /etc/apache2/mods-available/headers.load \
  /etc/apache2/mods-enabled/headers.load

# Add a custom Apache config:
COPY apache.conf /etc/apache2/conf-enabled/custom.conf

# Add the PHP config file:
COPY php.ini /usr/local/etc/php/

# Add the custom Apache run script
# and a script to download and extract the latest stable phpBB version:
COPY bin /usr/local/bin

# Install phpBB into the Apache document root:
RUN download-phpbb /var/www/html

# copy config into installer 
COPY install-config.yml /var/www/html/phpBB3/install
COPY testdb.php /var/www/html/testdb.php

# Expose the phpBB as volume
VOLUME /var/www/html/phpBB3
    
# run apache
CMD ["runapache"]

