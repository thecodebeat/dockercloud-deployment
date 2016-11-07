#!/usr/bin/env sh

# The purpose of this script is to use `jet decrypt` with a codeship key from an
# environment. One use case would be to keep an encrypted stackfile inside the
# repo and update and redeploy the Docker Cloud stack.
set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [input file]"
    exit 1
fi

keyfile=$(mktemp /tmp/keyfile.XXXXXX)
echo $CODESHIP_AES_KEY > $keyfile

outfile=$(mktemp /tmp/outfile.XXXXXX)

jet decrypt --key-path $keyfile $1 $outfile
rm $keyfile

echo $outfile
