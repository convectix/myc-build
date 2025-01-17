#!/bin/sh
. /etc/rc.conf          # mybbasever
set +e

pgm="${0##*/}"				# Program basename
progdir="${0%/*}"			# Program directory
progdir=$( realpath ${progdir} )
progdir=$( dirname ${progdir} )

: ${distdir="/usr/local/cbsd"}
[ ! -r "${distdir}/subr/cbsdbootstrap.subr" ] && exit 1
. ${distdir}/subr/cbsdbootstrap.subr || exit 1

SRC_ROOT="${srcdir}/src_${mybbasever}/src"

if [ ! -r ${SRC_ROOT}/Makefile ]; then
	echo "no such src: ${SRC_ROOT}"
	exit 1
fi

#cd ${SRC_ROOT}/usr.sbin/bsdinstall/distextract
#PATCH="${progdir}/patch/14x/patch-usr-sbin-bsdinstall-distextract-distextract.c"
#patch --check -N < ${PATCH} > /dev/null 2>&1
#[ $? -eq 0 ] && echo "apply ${PATCH}.." && patch < ${PATCH}
#find ${SRC_ROOT}/usr.sbin/bsdinstall/distextract -type f -name \*.orig -delete

#cd ${SRC_ROOT}/usr.sbin/bsdinstall/distfetch
#PATCH="${progdir}/patch/14x/patch-usr-sbin-bsdinstall-distfetch-distfetch.c"
#patch --check -N < ${PATCH} > /dev/null 2>&1
#[ $? -eq 0 ] && echo "apply ${PATCH}.." && patch < ${PATCH}
#find ${SRC_ROOT}/usr.sbin/bsdinstall/distfetch -type f -name \*.orig -delete

cd ${SRC_ROOT}/usr.sbin/bsdinstall/scripts
#for i in adduser checksum docsinstall hardening hostname jail keymap mirrorselect mount netconfig netconfig_ipv4 netconfig_ipv6 rootpass services wlanconfig zfsboot bootconfig; do
#for i in netconfig netconfig_ipv4 bootconfig; do
for i in netconfig netconfig_ipv4; do
	PATCH="${progdir}/patch/14x/patch-usr-sbin-bsdinstall-scripts-${i}"
	patch --check -N < ${PATCH} > /dev/null 2>&1
	[ $? -eq 0 ] && echo "apply ${PATCH}.." && patch < ${PATCH}
done
find ${SRC_ROOT}/usr.sbin/bsdinstall/scripts -type f -name \*.orig -delete

# replace, without patch
cp -a ${progdir}/patch/14x/auto ${SRC_ROOT}/usr.sbin/bsdinstall/scripts/auto

exit 0
