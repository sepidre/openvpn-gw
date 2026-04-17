#!/bin/sh

# Generate TOTP only if needed
if [ "$AUTH_MODE" != "pwd" ]; then
  TOTP=$(oathtool --totp -b "$TOTP_SECRET")
fi

# Build password string based on mode
case "$AUTH_MODE" in
  pwd)
    PASSWORD="$VPN_PASS"
    ;;
  pwd+token)
    PASSWORD="${VPN_PASS}${TOTP}"
    ;;
  token+pwd)
    PASSWORD="${TOTP}${VPN_PASS}"
    ;;
  *)
    echo "ERROR: Unknown AUTH_MODE '$AUTH_MODE'. Use: pwd, pwd+token, token+pwd"
    exit 1
    ;;
esac

echo "$VPN_USER" > /vpn/auth.txt
echo "$PASSWORD" >> /vpn/auth.txt
chmod 600 /vpn/auth.txt

openvpn --config /vpn/client.ovpn \
        --auth-user-pass /vpn/auth.txt \
        --socks-proxy $PROXY $PROXYPORT \
        --daemon

sleep 5
exec microsocks -p 1056