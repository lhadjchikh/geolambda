#!/bin/bash

# directory used for deployment
export DEPLOY_DIR=lambda

# make deployment directory and add lambda handler
mkdir -p $DEPLOY_DIR/lib

# copy libs
cp -P ${PREFIX}/lib/*.so* $DEPLOY_DIR/lib/
cp -P ${PREFIX}/lib64/libjpeg*.so* $DEPLOY_DIR/lib/

strip $DEPLOY_DIR/lib/* || true

# copy GDAL_DATA files over
mkdir -p $DEPLOY_DIR/share
rsync -ax $PREFIX/share/gdal $DEPLOY_DIR/share/
rsync -ax $PREFIX/share/proj $DEPLOY_DIR/share/

# copy sqlite3
mkdir -p $DEPLOY_DIR/python
cp /root/.pyenv/versions/$PYVERSION/lib/python3.8/lib-dynload/_sqlite3.cpython-38-x86_64-linux-gnu.so $DEPLOY_DIR/python/

# zip up deploy package
cd $DEPLOY_DIR
zip --symlinks -ruq ../lambda-deploy.zip ./
