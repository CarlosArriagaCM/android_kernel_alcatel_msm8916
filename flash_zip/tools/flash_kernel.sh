#!/sbin/sh
#
# Live ramdisk patching script
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it

cd /tmp/
/sbin/busybox dd if=/dev/block/bootdevice/by-name/boot of=./boot.img
./unpackbootimg -i /tmp/boot.img
./mkbootimg --kernel /tmp/Image --ramdisk /tmp/boot.img-ramdisk.gz --cmdline "sched_enable_hmp=1 console=tty60,115200,n8 androidboot.console=tty60 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 earlyprintk androidboot.emmc=true msm_rtb.filter=0x237 androidboot.hwid=TBD androidboot.selinux=permissive"  --base 0x80000000 --pagesize 2048 --ramdisk_offset 0x01000000 --tags_offset 0x00000100 --dt /tmp/dt.img -o /tmp/newboot.img
/sbin/busybox dd if=/tmp/newboot.img of=/dev/block/bootdevice/by-name/boot
