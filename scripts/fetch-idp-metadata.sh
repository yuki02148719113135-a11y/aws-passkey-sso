#!/usr/bin/env bash
# Keycloak の SAML IdP メタデータを取得する（IAM Identity Center にアップロードする用）
set -euo pipefail

HOST="${1:-idp.127.0.0.1.nip.io}"
REALM="${2:-AWS}"
OUT="${3:-keycloak-idp-metadata.xml}"

curl --fail --cacert "$(mkcert -CAROOT)/rootCA.pem" \
  -o "$OUT" "https://$HOST/realms/$REALM/protocol/saml/descriptor"

echo "保存しました: $OUT"
grep -o 'Location="[^"]*"' "$OUT" | head -n 2
