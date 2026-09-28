#!/usr/bin/env bash
# mkcert でローカル用のTLS証明書を作成する
set -euo pipefail

HOST="${1:-idp.127.0.0.1.nip.io}"
CERT_DIR="$(cd "$(dirname "$0")/.." && pwd)/certs"

command -v mkcert >/dev/null || { echo "mkcert が必要です: brew install mkcert"; exit 1; }

mkdir -p "$CERT_DIR"
mkcert -install
mkcert -cert-file "$CERT_DIR/$HOST.pem" -key-file "$CERT_DIR/$HOST-key.pem" "$HOST"
chmod 644 "$CERT_DIR"/*.pem
echo "作成しました: $CERT_DIR"
