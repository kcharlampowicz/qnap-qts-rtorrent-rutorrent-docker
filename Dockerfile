
FROM vsense/baseimage:alpine

MAINTAINER Kamil Charlampowicz "kamil.charlampowicz@gmail.com"

RUN apk --update add rtorrent openvpn lighttpd lighttpd-mod_auth php php-cgi php-json curl gzip zip ffmpeg geoip unrar fcgi git tmux

ADD run /root/
ADD httppassword /root
ADD auth-lighthttpd /root

RUN chmod +x /root/run \
  && echo 'include "mod_fastcgi.conf"' >> /etc/lighttpd/lighttpd.conf \
  && cat /root/auth-lighthttpd >> /etc/lighttpd/lighttpd.conf

# setup rutorrent
RUN git init /var/www/localhost/htdocs \
  && cd /var/www/localhost/htdocs \
  && git remote add origin https://github.com/Novik/ruTorrent.git \
  && cd /var/www/localhost/htdocs && git pull origin master \
  && chmod -R 777 /var/www/localhost/htdocs/share/

# setup lighttpd
RUN mkdir -p /var/run/lighttpd /run/lighttpd \
  && chown lighttpd /var/run/lighttpd /run/lighttpd

EXPOSE 49161
EXPOSE 80

VOLUME /download

ENTRYPOINT ["/root/run"]
