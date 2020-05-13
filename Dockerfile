FROM debian:buster-slim
MAINTAINER Maxime Mérian <maxime@merian.me>

RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg ca-certificates

RUN apt-key adv --fetch-keys https://labs.consol.de/repo/stable/RPM-GPG-KEY
RUN echo "deb http://labs.consol.de/repo/stable/debian buster main" > /etc/apt/sources.list.d/labs-consol-stable.list

RUN apt-get update && \
    apt-get install -y thruk && \
    apt-get clean

COPY start-thruk.sh /usr/local/bin
COPY etc/apache2/sites-available/* /etc/apache2/sites-available/

RUN chmod +x /usr/local/bin/start-thruk.sh

RUN mkdir -p /orig/etc/thruk /orig/var/lib/thruk
RUN cp -r /etc/thruk/* /orig/etc/thruk
RUN cp -r /var/lib/thruk/* /orig/var/lib/thruk

EXPOSE 80

CMD ["/usr/local/bin/start-thruk.sh"]
