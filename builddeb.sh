#!/bin/sh

VERSION=0.2

DEBFULLNAME="Rumen Bogdanovski"
EMAIL="rumen@skyarchive.org"

__check_file_exits() {
    [ ! -f ${1} ] && { echo "file '${1}' not found"; exit 1; }
}

# Cleanup debian/changelog. it will be generated.
rm -f debian/changelog

# Check for Debian package building executables and tools.
[ ! $(which dch) ] && { echo "executable 'dch' not found install package: 'devscripts'"; exit 1; }
[ ! $(which dpkg-buildpackage) ] && { echo "executable 'dpkg-buildpackage' not found install package: 'dpkg-dev'"; exit 1; }
[ ! $(which cdbs-edit-patch) ] && { echo "executable 'cdbs' not found install package: 'cdbs'"; exit 1; }

# Create entry in debian/changelog.
dch --create --package "indigosky-desktop" --newversion ${VERSION} --distribution unstable --nomultimaint -t "Build from official upstream."

# Finally build the package.
dpkg-buildpackage \-us \-uc \-I.git \-I\*.out[0-9]\* \-I\*.swp

# Cleanup debian/changelog.
rm -f debian/changelog
