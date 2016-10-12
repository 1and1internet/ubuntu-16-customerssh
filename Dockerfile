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
    git vim traceroute telnet nano dnsutils curl wget iputils-ping openssh-client openssh-sftp-server \
    virtualenv python3-venv python3-virtualenv python3-all python3-setuptools python3-pip python-dev python3-dev python-pip \
    gnupg build-essential ruby2.3-dev libsqlite3-dev && \
    apt-get install -y curl apt-transport-https ca-certificates lsb-release && \
    DISTRO=$(lsb_release -c -s) && \
    NODEREPO="node_6.x" && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://deb.nodesource.com/${NODEREPO} ${DISTRO} main" > /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/${NODEREPO} ${DISTRO} main" >> /etc/apt/sources.list.d/nodesource.list && \
    apt-get update -q && \
    apt-get install -y build-essential nodejs && \
  apt-get remove -y python-software-properties software-properties-common supervisor && \
  apt-get autoremove -y && apt-get autoclean -y && \
  chmod 0777 /var/www && \
  mkdir /tmp/composer/ && \
  cd /tmp/composer && \
  curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer && \
  rm -rf /tmp/composer /etc/supervisor /init/supervisord /hooks/supervisord-pre.d && \
  rm -rf /var/lib/apt/lists/* && \
  chmod 0755 /usr/local/bin/composer && \
  chmod 0755 -R /hooks /init && \
  chmod 0777 /etc/passwd /etc/group && \
  mkdir --mode 0777 /usr/local/composer && \
  COMPOSER_HOME=/usr/local/composer /usr/local/bin/composer global require drush/drush:8.*

ENV COMPOSER_HOME=/var/www \
    HOME=/var/www 

WORKDIR /var/www
