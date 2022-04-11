#!/bin/sh
mybbasever="13.1"

pgm="${0##*/}"				# Program basename
progdir="${0%/*}"			# Program directory
progdir=$( realpath ${progdir} )
progdir=$( dirname ${progdir} )

dstdir=$( mktemp -d )

# cleanup old pkg ?
#/var/cache/packages/pkgdir-cpr9ca75 (host) -> /tmp/packages (jail)

cbsd cpr pkglist=/root/myb-build/myb.list dstdir=${dstdir}

if [ -d ${progdir}/cbsd ]; then
	echo "remove old artifact dir: ${progdir}/cbsd"
	rm -rf ${progdir}/cbsd
fi

mkdir -p ${progdir}/cbsd
echo "Sleep"
read p

mv ${dstdir}/* ${progdir}/cbsd/

rm -rf ${dstdir}

[ ! -h ${progdir}/cbsd/pkg.pkg ] && exit 1

exit 0