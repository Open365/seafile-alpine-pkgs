#!/bin/sh

set -e
set -u
set -x

THISDIR="$(cd "$(dirname "$0")" && pwd)"

cd $THISDIR/libsearpc/
abuild -r

cd $THISDIR/ccnet/
abuild -r

cd $THISDIR/seafile/
abuild checksum
abuild -r

cd $THISDIR/seafobj/
abuild checksum
abuild -r

cd $THISDIR/seafdav/
abuild checksum
abuild -r

echo "All packges built in /packages"
