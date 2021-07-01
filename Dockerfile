# Pull php:7.3-apache and set environment
FROM php:7.3-apache
ENV DEBIAN_FRONTEND noninteractive

# Composer install
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer self-update 1.9.3
RUN apt-get update

# MSSQL server Setup
RUN apt-get -y --fix-missing install gnupg
RUN curl -o /etc/apt/sources.list.d/mssql-server.list https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list
RUN curl -o /etc/apt/sources.list.d/msprod.list https://packages.microsoft.com/config/ubuntu/16.04/prod.list
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN apt-get -y --fix-missing install apt-transport-https ca-certificates
RUN apt-get update
RUN apt-get -y --fix-missing install wget
RUN wget http://ftp.osuosl.org/pub/ubuntu/pool/universe/j/jemalloc/libjemalloc1_3.6.0-11_amd64.deb
RUN dpkg -i libjemalloc1_3.6.0-11_amd64.deb
RUN apt-get -y --fix-missing install multiarch-support
RUN wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb
RUN dpkg -i libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb
RUN apt-get -y --fix-missing install mssql-server=14.0.3192.2-2
RUN sed -i 's@sudo, "-EH", @@;s@"sudo", @@g' /opt/mssql/lib/mssql-conf/mssqlconfhelper.py
RUN sed -i 's@sudo -EH@su@' /opt/mssql/lib/mssql-conf/invokesqlservr.sh
RUN rm libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb libjemalloc1_3.6.0-11_amd64.deb

# ODBC Driver
RUN apt-get update
RUN env ACCEPT_EULA=Y apt-get -y --fix-missing install mssql-tools unixodbc-dev
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN chmod 777 ~/.bashrc
RUN ~/.bashrc

RUN pecl install sqlsrv pdo_sqlsrv
RUN echo "<?php phpinfo();" >> /var/www/html/index.php
RUN echo "extension=sqlsrv.so" > /usr/local/etc/php/conf.d/docker-php-ext-sodium.ini
RUN echo "extension=pdo_sqlsrv.so" > /usr/local/etc/php/conf.d/docker-php-ext-sodium.ini

# Additional packages for php
RUN apt-get update
RUN env ACCEPT_EULA=Y apt-get -y --fix-missing install git libxml2-dev
RUN docker-php-ext-install soap

# Install git and nano editor
RUN apt-get -y --fix-missing install git nano

# Set timeout to 2000 for composer
RUN export COMPOSER_PROCESS_TIMEOUT=2000