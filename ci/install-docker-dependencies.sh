#!/bin/sh
#
# Install dependencies required to build and test Git inside container
#

. ${0%/*}/lib.sh

begin_group "Install dependencies"

# Required so that apt doesn't wait for user input on certain packages.
export DEBIAN_FRONTEND=noninteractive

case "$jobname" in
linux32)
	linux32 --32bit i386 sh -c '
		apt update >/dev/null &&
		apt install -y build-essential libcurl4-openssl-dev \
			libssl-dev libexpat-dev gettext python >/dev/null
	'
	;;
linux-musl)
	apk add --update git shadow sudo build-base curl-dev openssl-dev expat-dev gettext \
		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
	;;
linux-*)
	apt update -q &&
	apt install -q -y sudo git make language-pack-is libsvn-perl apache2 libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl ${CC_PACKAGE:-${CC:-gcc}}
	;;
pedantic)
	dnf -yq update >/dev/null &&
	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
	;;
esac

end_group "Install dependencies"
