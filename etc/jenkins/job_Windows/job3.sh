#!C:\msys64\usr\bin\bash.exe --login
source shell mingw64

echo "Job 3"
set -e

# configuration & build
autoreconf -i
./configure --enable-generic --enable-optim --enable-download --enable-maintainer-mode \
  CXXFLAGS=-mtune=generic CFLAGS=-mtune=generic FFLAGS=-mtune=generic \
  --prefix=/e/builds/workspace/freefem-3 \
./3rdparty/getall -a \
make -j4

if [ $? -eq 0 ]
then
  echo "Build process complete"
else
  echo "Build process failed"
  exit 1
fi

# check
make check

if [ $? -eq 0 ]
then
  echo "Check process complete"
else
  echo "Check process failed"
  exit 1
fi

# install
make install

if [ $? -eq 0 ]
then
  echo "Install process complete"
else
  echo "Install process failed"
  exit 1
fi

# uninstall
make uninstall

if [ $? -eq 0 ]
then
  echo "Uninstall process complete"
else
  echo "Uninstall process failed"
exit 1
fi

# visu for jenkins tests results analyser
./etc/jenkins/resultForJenkins/resultForJenkins.sh
