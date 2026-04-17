FROM alpine:latest
RUN apk add --no-cache openvpn oathtool microsocks
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]