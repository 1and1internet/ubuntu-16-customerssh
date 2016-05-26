FROM 1and1internet/ubuntu-16:unstable
MAINTAINER mark.hawkins@fasthosts.com
ARG DEBIAN_FRONTEND=noninteractive
COPY files /

RUN \
    apt-get update && \
    apt-get install -y php7.0-cli php7.0-fpm php7.0-common php7.0-curl php7.0-gd php7.0-mysql php7.0-sqlite3 php7.0-xml php7.0-zip php7.0-gettext php7.0-mbstring mysql-client perl ruby rake python3-all python-all && \
    apt-get purge -y supervisor && \
    mkdir /tmp/composer/ && \
    cd /tmp/composer && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod a+x /usr/local/bin/composer && \
    rm -rf /tmp/composer && \
    apt-get autoremove -y && apt-get autoclean -y && \
    rm /init/supervisord /etc/supervisor/exit_on_fatal.py && \
    rm -rf /var/lib/apt/lists/* && \
    chmod 755 -R /hooks && \
    mkdir --mode 777 /var/www /usr/local/composer
    
 WORKDIR /home
 