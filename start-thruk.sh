#!/usr/bin/env bash

for d in /etc/thruk /var/lib/thruk; do
    if [ -z "$(ls -A $d)" ]; then
        cp -Rp /orig$d/* $d
    fi
done

chown -R www-data:www-data /etc/thruk

# Start apache server
apache2ctl -D FOREGROUND
