#!/bin/bash
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
CDIR=`pwd`

PKG_NAME="shell-fm"

make clean
make

touch /tmp/mark
make DESTDIR=/tmp/$PKG_NAME install

cd /tmp
mksquashfs $PKG_NAME $PKG_NAME.tcz
cd /tmp/$PKG_NAME
mv ../$PKG_NAME.tcz .

find usr -not -type d > $PKG_NAME.tcz.list

rm -rf usr

chmod 664 /tmp/$PKG_NAME/$PKG_NAME.tcz /tmp/$PKG_NAME/$PKG_NAME.tcz.list

mv /tmp/$PKG_NAME/$PKG_NAME.tcz /tmp/$PKG_NAME/$PKG_NAME.tcz.list $CDIR/..
