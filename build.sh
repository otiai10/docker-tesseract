#!/bin/bash

# Compatible Tesseract / Leptonica versions
# see this for more information
# https://github.com/tesseract-ocr/tesseract/wiki/Compiling#leptonica
V_TESSERACT=(
  ["400"]="4.00.00dev"
  ["305"]="3.05.00"
)
V_LEPTONICA=(
  ["400"]="1.74.2"
  ["305"]="1.74.0"
)

VERSION="400"
if [ -n "${1}" ]; then
  VERSION=${1}
fi

if [ -z "${V_TESSERACT[VERSION]}" ]; then
  echo "No compatible tesseract version for ${VERSION}"
  exit 1
fi

if [ -z "${V_LEPTONICA[VERSION]}" ]; then
  echo "No compatible leptonica version for ${VERSION}"
  exit 1
fi

docker build . \
  -t otiai10/tesseract:${V_TESSERACT[VERSION]} \
  --build-arg TESS=${V_TESSERACT[VERSION]} \
  --build-arg LEPTO=${V_LEPTONICA[VERSION]}
