FROM alpine:latest AS builder
RUN apk add --no-cache git gcc musl-dev make
RUN git clone https://github.com/rofl0r/microsocks.git /tmp/microsocks && \
    cd /tmp/microsocks && make

FROM alpine:latest
RUN apk add --no-cache \
    openvpn \
    oath-toolkit \        # <-- try this instead of oathtool
COPY --from=builder /tmp/microsocks/microsocks /usr/local/bin/microsocks
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]