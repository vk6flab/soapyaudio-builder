FROM debian:stable-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get -y upgrade

# Install the dependencies
RUN apt-get -y install \
	autoconf \
	automake \
	build-essential \
	cmake \
	g++ \
	git \
	libasound2-dev \
	libjack-jackd2-dev \
	libpipewire-0.3-dev \
	libpulse-dev \
	libpython3-dev \
	libtool \
	pkgconf \
	python3-numpy \
	swig

WORKDIR /src

# Get the sources
RUN git clone https://github.com/Hamlib/Hamlib.git
RUN git clone https://github.com/thestk/rtaudio.git
RUN git clone https://github.com/pothosware/SoapySDR.git
RUN git clone https://github.com/FallingAnvils/SoapyAudio.git

# Build Hamlib
WORKDIR /src/Hamlib
# Checkout v4.7.0 - SoapyAudio is not (yet) compatible with the latest version of Hamlib
RUN git checkout 4.7.0
RUN ./bootstrap
RUN ./configure
RUN make -j$(nproc)
RUN make check
RUN make install
RUN ldconfig

# Build rtaudio
WORKDIR /src/rtaudio
RUN ./autogen.sh
RUN make -j$(nproc)
RUN make install
RUN ldconfig

# Build SoapySDR
WORKDIR /src/SoapySDR/build
RUN cmake ..
RUN make -j$(nproc)
RUN make test
RUN make install
RUN ldconfig

# Build SoapyAudio
WORKDIR /src/SoapyAudio/build
RUN cmake -DUSE_HAMLIB=ON ..
RUN make -j$(nproc)
RUN make install
RUN ldconfig

# Get all the artefacts in one place
WORKDIR /src/Hamlib
RUN make install DESTDIR=/tmp/Hamlib

WORKDIR /src/rtaudio
RUN make install DESTDIR=/tmp/rtaudio

WORKDIR /src/SoapySDR/build
RUN make install DESTDIR=/tmp/SoapySDR

WORKDIR /src/SoapyAudio/build
RUN make install DESTDIR=/tmp/SoapyAudio

# Put the artefacts together in a single .tgz file.
WORKDIR /tmp
RUN tar -zcvf /src/installed.tgz *
