#!/bin/bash
set -e
echo 'pBuild 1.0'
echo 'Installing Pebble SDK and its Dependencies...'

cd ~
mkdir -p ~/pebble-dev
mkdir -p ~/.pebble-sdk
touch ~/.pebble-sdk/ENABLE_ANALYTICS

# Get the Pebble SDK and toolchain
PEBBLE_SDK_VER='v'
PEBBLE_SDK_VER+=${PEBBLE_SDK}
PEBBLE_SDK_FILE='pebble-sdk-'
PEBBLE_SDK_FILE+=${PEBBLE_SDK}
PEBBLE_SDK_FILE+='-linux64.tar.bz2'
if [ ! -d $HOME/pebble-dev/${PEBBLE_SDK_FILE} ]; then
  wget https://github.com/pebble/pebble-tool/releases/download/v${PEBBLE_SDK_VER}/${PEBBLE_SDK_FILE}.tar.bz2
  wget http://assets.getpebble.com.s3-website-us-east-1.amazonaws.com/sdk/arm-cs-tools-ubuntu-universal.tar.gz

  # Extract the SDK
  tar -jxf ${PEBBLE_SDK_FILE}.tar.bz2 -C ~/pebble-dev/
  # Extract the toolchain
  tar zxf arm-cs-tools-ubuntu-universal.tar.gz -C ~/pebble-dev/${PEBBLE_SDK_FILE}

  # Install the Python library dependencies locally
  cd ~/pebble-dev/${PEBBLE_SDK_FILE}
  virtualenv --no-site-packages .env
  source .env/bin/activate
  pip install -r requirements.txt
  deactivate
fi
