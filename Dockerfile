
FROM gliderlabs/alpine

MAINTAINER Kamil Charlampowicz "kamil.charlampowicz@gmail.com"

RUN apk --update add rtorrent openvpn lighttpd php5 php5-cgi fcgi git php5-json

RUN mkdir /root/.session/

ADD run /root/
RUN chmod +x /root/run

RUN echo 'include "mod_fastcgi.conf"' >> /etc/lighttpd/lighttpd.conf

# setup rutorrent
RUN git init /var/www/localhost/htdocs
RUN cd /var/www/localhost/htdocs && git remote add origin https://github.com/Novik/ruTorrent.git
RUN cd /var/www/localhost/htdocs && git pull origin master
RUN rm -rf /var/www/localhost/htdocs/plugins/*
RUN cd /var/www/localhost/htdocs/plugins && git checkout httprpc
RUN chmod -R 777 /var/www/localhost/htdocs/share/

# setup lighttpd
RUN mkdir -p /var/run/lighttpd /run/lighttpd
RUN chown lighttpd /var/run/lighttpd /run/lighttpd

EXPOSE 49161
EXPOSE 80

VOLUME /download

ENTRYPOINT ["/root/run"]
