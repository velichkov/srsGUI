FROM registry.fedoraproject.org/fedora:24

RUN dnf install -y \
		gcc-c++ \
		make \
		cmake \
		boost-devel \
		qwt-devel \
		Xvfb

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
