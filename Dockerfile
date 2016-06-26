FROM 1and1internet/ubuntu-16:latest
MAINTAINER mark.hawkins@fasthosts.com
ARG DEBIAN_FRONTEND=noninteractive
COPY files /

RUN \
  apt-get update && \
  apt-get install -y python-software-properties software-properties-common && \
  LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && \
  apt-get update && \
  apt-get install -y libapache2-mod-php5.6 php5.6-cli php5.6-common php5.6-curl php5.6-gd php5.6-mysql php5.6-sqlite php5.6-xml php5.6-zip php5.6-mbstring php5.6-gettext \
    php7.0-cli php7.0-fpm php7.0-common php7.0-curl php7.0-gd php7.0-mysql php7.0-sqlite3 php7.0-xml php7.0-zip php7.0-gettext php7.0-mbstring mysql-client perl ruby rake \
    git vim traceroute telnet nano dnsutils curl wget iputils-ping openssh-client openssh-sftp-server && \
  apt-get remove -y python-software-properties software-properties-common supervisor && \
  apt-get autoremove -y && apt-get autoclean -y && \
  mkdir /tmp/composer/ && \
  mkdir --mode 0777 /data && \
  cd /tmp/composer && \
  curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer && \
  rm -rf /tmp/composer /etc/supervisor /init/supervisord /hooks/supervisord-pre.d && \
  rm -rf /var/lib/apt/lists/* && \
  chmod 0755 /usr/local/bin/composer && \
  chmod 0755 -R /hooks /init && \
  chmod 0777 /etc/passwd /etc/group && \
  mkdir --mode 0777 /var/www /usr/local/composer && \
  COMPOSER_HOME=/usr/local/composer /usr/local/bin/composer global require drush/drush:8.*

ENV COMPOSER_HOME=/var/www \
    HOME=/var/www

WORKDIR /var/www
