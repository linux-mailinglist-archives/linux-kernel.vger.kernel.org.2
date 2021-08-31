Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245BC3FC211
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 07:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhHaFJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 01:09:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:62989 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhHaFJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 01:09:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="240651392"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="xz'?yaml'?scan'208";a="240651392"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 22:08:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="xz'?yaml'?scan'208";a="530875127"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 22:08:39 -0700
Date:   Tue, 31 Aug 2021 13:26:17 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: [ext4]  21175ca434:
 mdadm-selftests.enchmarks/mdadm-selftests/tests/01r1fail.fail
Message-ID: <20210831052617.GE4286@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 21175ca434c5d49509b73cf473618b01b0b85437 ("ext4: make prefetch_block_bitmaps default")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: mdadm-selftests
version: mdadm-selftests-x86_64-5d518de-1_20201008
with following parameters:

	disk: 1HDD
	test_prefix: 01r1
	ucode: 0x21



on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

2021-04-26 16:59:25 mkdir -p /var/tmp
2021-04-26 16:59:25 mke2fs -t ext3 -b 4096 -J size=4 -q /dev/sda2
2021-04-26 17:00:21 mount -t ext3 /dev/sda2 /var/tmp
sed -e 's/{DEFAULT_METADATA}/1.2/g' \
-e 's,{MAP_PATH},/run/mdadm/map,g'  mdadm.8.in > mdadm.8
/usr/bin/install -D -m 644 mdadm.8 /usr/share/man/man8/mdadm.8
/usr/bin/install -D -m 644 mdmon.8 /usr/share/man/man8/mdmon.8
/usr/bin/install -D -m 644 md.4 /usr/share/man/man4/md.4
/usr/bin/install -D -m 644 mdadm.conf.5 /usr/share/man/man5/mdadm.conf.5
/usr/bin/install -D -m 644 udev-md-raid-creating.rules /lib/udev/rules.d/01-md-raid-creating.rules
/usr/bin/install -D -m 644 udev-md-raid-arrays.rules /lib/udev/rules.d/63-md-raid-arrays.rules
/usr/bin/install -D -m 644 udev-md-raid-assembly.rules /lib/udev/rules.d/64-md-raid-assembly.rules
/usr/bin/install -D -m 644 udev-md-clustered-confirm-device.rules /lib/udev/rules.d/69-md-clustered-confirm-device.rules
/usr/bin/install -D  -m 755 mdadm /sbin/mdadm
/usr/bin/install -D  -m 755 mdmon /sbin/mdmon
Testing on linux-5.12.0-rc4-00017-g21175ca434c5 kernel
/lkp/benchmarks/mdadm-selftests/tests/01r1fail... FAILED - see /var/tmp/01r1fail.log and /var/tmp/fail01r1fail.log for details



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
        bin/lkp run                    generated-yaml-file



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='mdadm-selftests'
	export testcase='mdadm-selftests'
	export category='functional'
	export need_memory='1G'
	export need_modules=true
	export job_origin='mdadm-selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-ivb-d04'
	export tbox_group='lkp-ivb-d04'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='6086f12eaca1a640d4c35b0a'
	export job_file='/lkp/jobs/scheduled/lkp-ivb-d04/mdadm-selftests-1HDD-01r1-ucode=0x21-debian-10.4-x86_64-20200603.cgz-21175ca434c5d49509b73cf473618b01b0b85437-20210427-82132-9wwqw7-21.yaml'
	export id='680103ffd061323a06512b2a34378a89c0c8d335'
	export queuer_version='/lkp-src'
	export model='Ivy Bridge'
	export nr_node=1
	export nr_cpu=4
	export memory='8G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2KB240G8_BTYF836606UQ240AGN-part1'
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part2 /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part3 /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part4 /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part5'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part1'
	export brand='Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD
CONFIG_MD_LINEAR
CONFIG_MD_RAID0
CONFIG_MD_RAID1
CONFIG_MD_RAID10
CONFIG_MD_RAID456
CONFIG_MD_MULTIPATH
CONFIG_BLK_DEV_LOOP'
	export commit='21175ca434c5d49509b73cf473618b01b0b85437'
	export netconsole_port=6676
	export ucode='0x21'
	export need_kconfig_hw='CONFIG_R8169=y
CONFIG_SATA_AHCI
CONFIG_DRM_I915'
	export bisect_dmesg=true
	export enqueue_time='2021-04-27 00:58:22 +0800'
	export _id='6086f12eaca1a640d4c35b0a'
	export _rt='/result/mdadm-selftests/1HDD-01r1-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='a868649f30d4707f608ba79ddda8f628fa350fe3'
	export base_commit='bf05bf16c76bb44ab5156223e1e58e26dfe30a88'
	export branch='linux-next/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/mdadm-selftests/1HDD-01r1-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437/21'
	export scheduler_version='/lkp/lkp/.src-20210425-142307'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-ivb-d04/mdadm-selftests-1HDD-01r1-ucode=0x21-debian-10.4-x86_64-20200603.cgz-21175ca434c5d49509b73cf473618b01b0b85437-20210427-82132-9wwqw7-21.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-next/master
commit=21175ca434c5d49509b73cf473618b01b0b85437
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437/vmlinuz-5.12.0-rc4-00017-g21175ca434c5
max_uptime=2100
RESULT_ROOT=/result/mdadm-selftests/1HDD-01r1-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437/21
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mdadm-selftests_20201008.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/mdadm-selftests-x86_64-5d518de-1_20201008.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export queue_at_least_once=1
	export repeat_to=22
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437/vmlinuz-5.12.0-rc4-00017-g21175ca434c5'
	export dequeue_time='2021-04-27 00:58:41 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-ivb-d04/mdadm-selftests-1HDD-01r1-ucode=0x21-debian-10.4-x86_64-20200603.cgz-21175ca434c5d49509b73cf473618b01b0b85437-20210427-82132-9wwqw7-21.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test_prefix='01r1' $LKP_SRC/tests/wrapper mdadm-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test_prefix='01r1' $LKP_SRC/stats/wrapper mdadm-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time mdadm-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--vA66WO2vHvL/CRSR
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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
AARZWg==

--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mdadm-selftests

2021-04-26 16:59:25 mkdir -p /var/tmp
2021-04-26 16:59:25 mke2fs -t ext3 -b 4096 -J size=4 -q /dev/sda2
2021-04-26 17:00:21 mount -t ext3 /dev/sda2 /var/tmp
sed -e 's/{DEFAULT_METADATA}/1.2/g' \
-e 's,{MAP_PATH},/run/mdadm/map,g'  mdadm.8.in > mdadm.8
/usr/bin/install -D -m 644 mdadm.8 /usr/share/man/man8/mdadm.8
/usr/bin/install -D -m 644 mdmon.8 /usr/share/man/man8/mdmon.8
/usr/bin/install -D -m 644 md.4 /usr/share/man/man4/md.4
/usr/bin/install -D -m 644 mdadm.conf.5 /usr/share/man/man5/mdadm.conf.5
/usr/bin/install -D -m 644 udev-md-raid-creating.rules /lib/udev/rules.d/01-md-raid-creating.rules
/usr/bin/install -D -m 644 udev-md-raid-arrays.rules /lib/udev/rules.d/63-md-raid-arrays.rules
/usr/bin/install -D -m 644 udev-md-raid-assembly.rules /lib/udev/rules.d/64-md-raid-assembly.rules
/usr/bin/install -D -m 644 udev-md-clustered-confirm-device.rules /lib/udev/rules.d/69-md-clustered-confirm-device.rules
/usr/bin/install -D  -m 755 mdadm /sbin/mdadm
/usr/bin/install -D  -m 755 mdmon /sbin/mdmon
Testing on linux-5.12.0-rc4-00017-g21175ca434c5 kernel
/lkp/benchmarks/mdadm-selftests/tests/01r1fail... FAILED - see /var/tmp/01r1fail.log and /var/tmp/fail01r1fail.log for details

--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/mdadm-selftests.yaml
suite: mdadm-selftests
testcase: mdadm-selftests
category: functional
need_memory: 1G
need_modules: true
disk: 1HDD
mdadm-selftests:
  test_prefix: 01r1
job_origin: mdadm-selftests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-ivb-d04
tbox_group: lkp-ivb-d04
kconfig: x86_64-rhel-8.3
submit_id: 60817275223cb5cdfc778771
job_file: "/lkp/jobs/scheduled/lkp-ivb-d04/mdadm-selftests-1HDD-01r1-ucode=0x21-debian-10.4-x86_64-20200603.cgz-21175ca434c5d49509b73cf473618b01b0b85437-20210422-52732-lbj3uy-0.yaml"
id: bc8109d3108864a730a77488900a0c9f9441ef8f
queuer_version: "/lkp-src"

#! hosts/lkp-ivb-d04
model: Ivy Bridge
nr_node: 1
nr_cpu: 4
memory: 8G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2KB240G8_BTYF836606UQ240AGN-part1"
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part2 /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part3
  /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part4 /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part5"
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part1"
brand: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/disk/nr_hdd
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_MD=y
- CONFIG_BLK_DEV_MD
- CONFIG_MD_LINEAR
- CONFIG_MD_RAID0
- CONFIG_MD_RAID1
- CONFIG_MD_RAID10
- CONFIG_MD_RAID456
- CONFIG_MD_MULTIPATH
- CONFIG_BLK_DEV_LOOP

#! include/mdadm-selftests

#! include/queue/cyclic
commit: 21175ca434c5d49509b73cf473618b01b0b85437

#! include/testbox/lkp-ivb-d04
netconsole_port: 6676
ucode: '0x21'
need_kconfig_hw:
- CONFIG_R8169=y
- CONFIG_SATA_AHCI
bisect_dmesg: true
enqueue_time: 2021-04-22 20:56:21.641385069 +08:00
_id: 60817275223cb5cdfc778771
_rt: "/result/mdadm-selftests/1HDD-01r1-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 3a913771a4d4919c6f372c9f630a1294b3f793d6
base_commit: bf05bf16c76bb44ab5156223e1e58e26dfe30a88
branch: linux-devel/devel-hourly-20210422-002542
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/mdadm-selftests/1HDD-01r1-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437/0"
scheduler_version: "/lkp/lkp/.src-20210422-153727"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-ivb-d04/mdadm-selftests-1HDD-01r1-ucode=0x21-debian-10.4-x86_64-20200603.cgz-21175ca434c5d49509b73cf473618b01b0b85437-20210422-52732-lbj3uy-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210422-002542
- commit=21175ca434c5d49509b73cf473618b01b0b85437
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437/vmlinuz-5.12.0-rc4-00017-g21175ca434c5
- max_uptime=2100
- RESULT_ROOT=/result/mdadm-selftests/1HDD-01r1-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mdadm-selftests_20201008.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/mdadm-selftests-x86_64-5d518de-1_20201008.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210421-215145/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 4.20.0

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/21175ca434c5d49509b73cf473618b01b0b85437/vmlinuz-5.12.0-rc4-00017-g21175ca434c5"
dequeue_time: 2021-04-22 20:59:10.269883987 +08:00

#! /lkp/lkp/.src-20210422-153727/include/site/inn
job_state: finished
loadavg: 1.90 0.70 0.26 1/154 1320
start_time: '1619096395'
end_time: '1619096477'
version: "/lkp/lkp/.src-20210422-153759:f8709021-dirty:0042e218c-dirty"

--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

mkdir -p /var/tmp
mke2fs -t ext3 -b 4096 -J size=4 -q /dev/sda2
mount -t ext3 /dev/sda2 /var/tmp

--vA66WO2vHvL/CRSR--
