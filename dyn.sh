#!/bin/bash
# Written By @nnippon!, credits for all peeps ofc
# Kang?, Don't forget to give proper credits!
# Based on Erfan tools so

# Define environment dirs
LOCALDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
extractor="$LOCALDIR/tools/Firmware_extractor/extractor.sh"
working="$LOCALDIR/work"
cachedir="$LOCALDIR/cache"

# Let's GO
echo "Prepare env..."
	bash update.sh
	umount -l $working
	rm -rf $cachedir $working
	mkdir -p "$cachedir" "$working"

echo "Extracting imgs from OTA..."
	bash $extractor $1 $cachedir

echo "Creating tmp img..."
	dd if=/dev/zero of=new.img bs=6k count=1048576
	mkfs.ext4 new.img
	tune2fs -c0 -i0 new.img

echo "Merging process started..."
	echo "system.img"
	mkdir $cachedir/system
	mount -o loop new.img $working
	mount -o ro $cachedir/system.img $cachedir/system
	cp -vrp $cachedir/system/* $working/ &> /dev/null
	sync

if [ -f "$cachedir/product.img" ]; then
	echo "product.img"
	rm -rf $working/product $working/system/product 
	mkdir $working/system/product $cachedir/product 
	mount -o ro $cachedir/product.img $cachedir/product
	ln -s /system/product $working/product
	cp -vrp $cachedir/product/* $working/system/product/ &> /dev/null
	sync
fi

if [ -f "$cachedir/system_ext.img" ]; then
	echo "system_ext.img"
	rm -rf $working/system_ext $working/system/system_ext
	mkdir $working/system/system_ext $cachedir/system_ext
	mount -o ro $cachedir/system_ext.img $cachedir/system_ext/ 
	ln -s /system/system_ext $working/system_ext
	cp -vrp $cachedir/system_ext/* $working/system/system_ext/ &> /dev/n$
	sync
fi

if [ -f "$cachedir/reserve.img" ]; then
	echo "reserve.img"
	rm -rf $working/system/reserve
	mkdir $working/system/reserve $cachedir/reserve
	mount -o ro $cachedir/reserve.img $cachedir/reserve/
	cp -vrp $cachedir/reserve/* $working/system/reserve/ &> /dev/null
	sync
fi

echo "Clearing cache..."
	umount -l $cachedir/*
	rm -rf $cachedir
echo "Done!"

# By @nnippon
