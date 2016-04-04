#!/bin/bash

set -e

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OUT_DIR="${ROOT_DIR}/out/ultima-http-server"
TOOLCHAIN="${ROOT_DIR}/../mipsel-toolchain"
ROOTFS="${ROOT_DIR}/../rootfs"

export PATH="${TOOLCHAIN}/bin:${PATH}"

rm -rf build

make \
  SHOW=1 \
  ARCH=mips \
  OS=linux \
  CC=mipsel-linux-gcc \
  IFLAGS=" -I${ROOTFS}/include -I${ROOTFS}/usr/include -I${ROOT_DIR}/build/linux-mips-static/inc " \
  LIBPATHS=" -L${ROOTFS}/lib -L${ROOTFS}/usr/lib -L${ROOT_DIR}/build/linux-mips-static/bin " \
  PROFILE=static \
  ME_COM_SSL=0 \
  ME_COM_MBEDTLS=0 \
  ME_COM_OPENSSL=0 \
  ME_GOAHEAD_LIMIT_POST=200000000 \
  ME_GOAHEAD_LIMIT_PUT=200000000 \
  ME_GOAHEAD_LIMIT_UPLOAD=200000000 \
  ME_GOAHEAD_SSL=0 \
  ME_GOAHEAD_STATIC=1 \
  ME_GOAHEAD_UPLOAD=1

rm -rf "${OUT_DIR}"
mkdir -p "${OUT_DIR}"
cp "${ROOT_DIR}/build/linux-mips-static/bin/goahead" \
  "${ROOT_DIR}/src/"*".txt" \
  "${ROOT_DIR}/src/web/ultima-upgrade.html" \
  "${OUT_DIR}"
