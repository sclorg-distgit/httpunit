#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: ./create-tarball.sh VERSION"
    exit 1
fi

VERSION=${1}
NAME="httpunit"

wget http://download.sourceforge.net/${NAME}/${NAME}-${VERSION}.zip
unzip ${NAME}-${VERSION}.zip
rm ${NAME}-${VERSION}.zip

( cd ${NAME}-${VERSION}
  # remove bundled jars
  find . -name "*.jar" -delete
  # remove non-free XML DTD files
  rm -f META-INF/web-app_2_2.dtd META-INF/web-app_2_3.dtd META-INF/web-app_2_4.xsd
  # remove pre-generated javadoc
  rm -Rf doc/api
)

tar czvf ${NAME}-${VERSION}-clean.tar.gz ./${NAME}-${VERSION}

