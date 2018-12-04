FROM python:3.7.1-alpine3.8 as builder

WORKDIR /tmp

COPY / ./

FROM python:3.7.1-alpine3.8

COPY --from=builder /tmp/prometheus-pve-exporter/build/lib/pve_exporter /usr/local/bin/pve_exporter

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

EXPOSE 9221

USER nobody

VOLUME /config

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["/usr/local/bin/pve_exporter", "/config/pve.yml", "9221" ]
