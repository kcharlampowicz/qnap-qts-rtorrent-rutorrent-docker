
FROM vsense/baseimage:alpine

MAINTAINER Kamil Charlampowicz "kamil.charlampowicz@gmail.com"

RUN apk --update add rtorrent openvpn lighttpd php php-cgi php-json curl gzip zip ffmpeg geoip unrar libmediainfo@testing fcgi git

ADD run /root/
RUN chmod +x /root/run

RUN echo 'include "mod_fastcgi.conf"' >> /etc/lighttpd/lighttpd.conf

# setup rutorrent
RUN git init /var/www/localhost/htdocs
RUN cd /var/www/localhost/htdocs && git remote add origin https://github.com/Novik/ruTorrent.git
RUN cd /var/www/localhost/htdocs && git pull origin master
RUN chmod -R 777 /var/www/localhost/htdocs/share/

# setup lighttpd
RUN mkdir -p /var/run/lighttpd /run/lighttpd
RUN chown lighttpd /var/run/lighttpd /run/lighttpd

EXPOSE 49161
EXPOSE 80

VOLUME /download

ENTRYPOINT ["/root/run"]
