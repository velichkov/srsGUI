FROM ubuntu:trusty

RUN apt-get update && apt-get install -y \
		g++ \
		cmake \
		libboost-thread-dev libboost-test-dev \
		libqwt-dev \
		xvfb

RUN useradd -ms /bin/bash srs
USER srs
WORKDIR /home/srs
COPY ./ srsGUI/

RUN mkdir -p srsGUI_build && cd srsGUI_build && \
		cmake ../srsGUI && \
		make

RUN cd srsGUI_build && ../srsGUI/docker/test.sh

USER root
RUN cd srsGUI_build && \
	make install && \
	ldconfig
