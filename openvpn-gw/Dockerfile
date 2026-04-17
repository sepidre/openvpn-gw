FROM alpine:latest

RUN apk add --no-cache \
    openvpn \
    oathtool \
    git \
    gcc \
    musl-dev \
    make

# Build microsocks from source
RUN git clone https://github.com/rofl0r/microsocks.git /tmp/microsocks && \
    cd /tmp/microsocks && \
    make && \
    cp microsocks /usr/local/bin/microsocks && \
    rm -rf /tmp/microsocks

# Cleanup build deps
RUN apk del git gcc musl-dev make

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]