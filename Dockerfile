FROM debian:stretch

ARG TESS="4.00.00dev"
ARG LEPTO="1.74.4"

RUN apt-get update
RUN apt-get install -y \
  wget \
  make \
  autoconf \
  automake \
  libtool \
  autoconf-archive \
  pkg-config \
  libpng-dev \
  libjpeg-dev \
  libtiff-dev \
  zlib1g-dev \
  libicu-dev \
  libpango1.0-dev \
  libcairo2-dev

RUN mkdir -p /leptonica
RUN mkdir -p /tesseract

WORKDIR /
RUN mkdir -p /tmp/leptonica \
  && wget https://github.com/DanBloomberg/leptonica/archive/${LEPTO}.tar.gz \
  && tar -xzvf ${LEPTO}.tar.gz -C /tmp/leptonica
WORKDIR /leptonica

RUN autoreconf -i \
  && ./autobuild \
  && ./configure \
  && make \
  && make install

WORKDIR /
RUN mkdir /tesseract \
  && wget https://github.com/tesseract-ocr/tesseract/archive/${TESS}.tar.gz \
  && tar -xzvf ${TESS}.tar.gz -C /tesseract \
  && mv /tesseract/*
WORKDIR /tesseract

RUN ./autogen.sh \
  && ./configure \
  && make \
  && make install

WORKDIR /
