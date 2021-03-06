#!/bin/bash

builddir=$1
destdir=$2

if [ -f $builddir/latex/en/MapServer.pdf ]; then
  scp $builddir/latex/en/MapServer.pdf mapserver@mapserver.org:/osgeo/mapserver.org/pdf/
fi


if [ ! -d $destdir/mapserver.github.io ]; then
  git clone git@github.com:mapserver/mapserver.github.io.git $destdir/mapserver.github.io
fi

cd $builddir/html
cp -rf * $destdir/mapserver.github.io

cd $destdir/mapserver.github.io
git config user.email "mapserverbot@mapserver.bot"
git config user.name "MapServer deploybot"

rm -rf _sources */_sources
rm -rf .doctrees */.doctrees */.buildinfo

git add -A
git commit -m "update with results of commit https://github.com/mapserver/docs/commit/$TRAVIS_COMMIT"
git push origin master

