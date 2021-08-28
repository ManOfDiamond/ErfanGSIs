#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

# Copy changes in system folder
rsync -ra $thispath/system/ $1/

# Include prebuilt overlays by default
cat $thispath/rw-system.add.sh >> $1/bin/rw-system.sh

# Append usefull stuff
echo "ro.support_one_handed_mode=true" >> $1/build.prop
echo "ro.boot.vendor.overlay.theme=com.google.android.systemui.gxoverlay" >> $1/product/etc/build.prop
echo "ro.config.ringtone=The_big_adventure.ogg" >> $1/product/etc/build.prop
echo "ro.config.notification_sound=Popcorn.ogg" >> $1/product/etc/build.prop
echo "ro.config.alarm_alert=Bright_morning.ogg" >> $1/product/etc/build.prop
echo "persist.sys.overlay.pixelrecents=true" >> $1/product/etc/build.prop
echo "qemu.hw.mainkeys=0" >> $1/product/etc/build.prop
echo "ro.opa.eligible_device=true" >> $1/product/etc/build.prop
echo "ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent" >> $1/product/etc/build.prop
echo "ro.com.android.dataroaming=false" >> $1/product/etc/build.prop
echo "ro.com.google.clientidbase=android-google" >> $1/product/etc/build.prop
echo "ro.error.receiver.system.apps=com.google.android.gms" >> $1/product/etc/build.prop
echo "ro.com.google.ime.theme_id=5" >> $1/product/etc/build.prop
echo "ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms" >> $1/product/etc/build.prop
echo "ro.com.google.ime.height_ratio=1.0" >> $1/product/etc/build.prop

# Drop some services
sed -i "/dataservice_app/d" $1/product/etc/selinux/product_seapp_contexts
sed -i "/dataservice_app/d" $1/system_ext/etc/selinux/system_ext_seapp_contexts
sed -i "/ro.sys.sdcardfs/d" $1/product/etc/build.prop

# Workaround for decrypted issue
echo "rm -rf /data/system/storage.xml" >> $1/bin/cppreopts.sh
rm -rf $1/product/etc/security/avb
