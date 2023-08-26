#!/bin/bash

# Copyright(c) 2023 Alex313031

YEL='\033[1;33m' # Yellow
CYA='\033[1;96m' # Cyan
RED='\033[1;31m' # Red
GRE='\033[1;32m' # Green
c0='\033[0m' # Reset Text
bold='\033[1m' # Bold Text
underline='\033[4m' # Underline Text

# Error handling
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "${RED}Failed $*"; }

# --help
displayHelp () {
	printf "\n" &&
	printf "${bold}${GRE}Script to build Codium for Linux or Windows.${c0}\n" &&
	printf "${bold}${YEL}Use the --deps flag to install build dependencies.${c0}\n" &&
	printf "${bold}${YEL}Use the --clean flag to remove all artifacts.\n" &&
	printf "${bold}${YEL}Use the --help flag to show this help.${c0}\n" &&
	printf "\n"
}
case $1 in
	--help) displayHelp; exit 0;;
esac

# Install prerequisites
installDeps () {
	sudo apt-get install build-essential git g++ pkg-config automake make gcc libsecret-1-dev fakeroot rpm dpkg dpkg-dev imagemagick libx11-dev libxkbfile-dev nodejs npm node-gyp node-istanbul jq python3
}
case $1 in
	--deps) installDeps; exit 0;;
esac

cleanCodium () {
	printf "\n" &&
	printf "${bold}${YEL} Cleaning assets, artifacts, and build directory...${c0}\n" &&
	printf "\n" &&
	
	rm -r -f assets &&
	rm -r -f vscode &&
	rm -r -f VSCode-linux-x64 &&
	rm -r -f vscode-reh-linux-x64 &&
	rm -r -f VSCode-win-x64 &&
	rm -r -f vscode-reh-win-x64
}
case $1 in
	--clean) cleanCodium; exit 0;;
esac

printf "\n" &&
printf "${bold}${GRE}Script to build Codium for Linux or Windows.${c0}\n" &&
printf "${bold}${YEL}Use the --deps flag to install build dependencies.${c0}\n" &&
printf "${bold}${YEL}Use the --clean flag to remove all artifacts.\n" &&
printf "${bold}${YEL}Use the --help flag to show this help.${c0}\n" &&
printf "\n" &&
tput sgr0 &&

# Set msvs_version for node-gyp on Windows
export MSVS_VERSION="2022" &&
export GYP_MSVS_VERSION="2022" &&

set CFLAGS="-DNDEBUG -msse3 -O3 -g0 -s" &&
set CXXFLAGS="-DNDEBUG -msse3 -O3 -g0 -s" &&
set CPPFLAGS="-DNDEBUG -msse3 -O3 -g0 -s" &&
set LDFLAGS="-Wl,-O3 -msse3 -s" &&

export CFLAGS="-DNDEBUG -msse3 -O3 -g0 -s" &&
export CXXFLAGS="-DNDEBUG -msse3 -O3 -g0 -s" &&
export CPPFLAGS="-DNDEBUG -msse3 -O3 -g0 -s" &&
export LDFLAGS="-Wl,-O3 -msse3 -s" &&

./build/build.sh

exit 0
