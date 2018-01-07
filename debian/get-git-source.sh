#!/bin/sh

BASE_REL=$(dpkg-parsechangelog 2>/dev/null | sed -ne 's/Version: \([0-9.]\+\)+\?.*/\1/p')
OLDDIR=${PWD}
GOS_DIR=${OLDDIR}/get-orig-source
GIT_COMMIT='git log --no-color -1 --oneline | cut -d" " -f1'
GIT_DATE='git log --no-color -1 --date=iso | sed -ne "s/Date:\s\+\(.*\).*/\1/p" | cut -d" " -f1 | tr -d "-"'

if [ -z ${BASE_REL} ]; then
	echo 'Please run this script from the sources root directory.'
	exit 1
fi


rm -rf ${GOS_DIR}
mkdir ${GOS_DIR} && cd ${GOS_DIR}
git clone git://github.com/akatrevorjay/nyancat.git
cd nyancat/
NYANCAT_GIT_COMMIT=$(eval "${GIT_COMMIT}")
NYANCAT_GIT_DATE=$(eval "${GIT_DATE}")
cd .. && tar cf \
	${OLDDIR}/nyancat_${BASE_REL}+git${NYANCAT_GIT_DATE}.${NYANCAT_GIT_COMMIT}.orig.tar \
	nyancat --exclude-vcs && gzip -9fn \
	${OLDDIR}/nyancat_${BASE_REL}+git${NYANCAT_GIT_DATE}.${NYANCAT_GIT_COMMIT}.orig.tar
rm -rf ${GOS_DIR}
