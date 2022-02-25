FROM debian:bullseye-slim
LABEL org.opencontainers.image.authors="Maxime Mérian <maxime@merian.me>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates curl gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://labs.consol.de/repo/stable/RPM-GPG-KEY | gpg --dearmor > /etc/apt/trusted.gpg.d/thruk.gpg
RUN echo "deb http://labs.consol.de/repo/stable/debian bullseye main" > /etc/apt/sources.list.d/labs-consol-stable.list

RUN apt-get update && \
    apt-get install -y thruk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY start-thruk.sh /usr/local/bin
COPY etc/apache2/sites-available/* /etc/apache2/sites-available/

RUN chmod +x /usr/local/bin/start-thruk.sh

RUN mkdir -p /orig/etc/thruk /orig/var/lib/thruk
RUN cp -r /etc/thruk/* /orig/etc/thruk
RUN cp -r /var/lib/thruk/* /orig/var/lib/thruk

EXPOSE 80

CMD ["/usr/local/bin/start-thruk.sh"]
