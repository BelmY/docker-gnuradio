# GNU Radio Docker image
#
# Copyright (C) 2020 Libre Space Foundation <https://libre.space/>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

FROM debian:buster
MAINTAINER Vasilis Tsiligiannis <acinonyx@openwrt.gr>

ARG GNURADIO_VERSION
ARG SATNOGS_APT_REPOSITORY="deb http://download.opensuse.org/repositories/home:/librespace:/satnogs/Debian_10/ /"
ARG SATNOGS_APT_KEY_URL="https://download.opensuse.org/repositories/home:librespace:satnogs/Debian_10/Release.key"

# Add SatNOGS repository
RUN apt-get -q update \
	&& apt-get -qy install gnupg libcurl4 \
	&& echo "${SATNOGS_APT_REPOSITORY}" > /etc/apt/sources.list.d/satnogs.list \
	&& apt-key adv --fetch-keys "${SATNOGS_APT_KEY_URL}"

# Install development packages
RUN apt-get -qy install \
	build-essential \
	cmake \
	gnuradio-dev${GNURADIO_VERSION:+=${GNURADIO_VERSION}-*} \
	libsoapysdr-dev \
	libuhd-dev \
	git
