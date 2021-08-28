#!/bin/bash
# Install necessarily packages for run tools on Ubuntu-18.04 re

sudo apt install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller device-tree-compiler liblzma-dev brotli liblz4-tool axel gawk aria2 detox cpio rename build-essential simg2img aria2 python3-pip default-jre -y
pip3 install wheel setuptools
pip3 install backports.lzma docopt zstandard bsdiff4 protobuf pycryptodome
sudo pip3 install --upgrade protobuf
