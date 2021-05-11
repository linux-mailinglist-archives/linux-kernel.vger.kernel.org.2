Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02556379F61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhEKFze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:55:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:54204 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhEKFzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:55:32 -0400
IronPort-SDR: WMraoioWgm9cu2lf3Iaa5a3mSXxzqHRqYrnWfvJl2nHWOi5FYdJqfeuNp6buI3sNGRaR2uLu0Y
 KPiTVMdqh27A==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="196269958"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="xz'?yaml'?scan'208";a="196269958"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:54:25 -0700
IronPort-SDR: B9oPFdJUKYrRjRpYEOfgkSxz464CPX2OpAuFc3US/Gz3Zigw7oEVDWSBsG69g7sITpxCYUyA3X
 Bay0+kphYOoA==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="xz'?yaml'?scan'208";a="624538713"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:54:20 -0700
Date:   Tue, 11 May 2021 14:11:21 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "huangjianan@oppo.com" <huangjianan@oppo.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Guo Weichao <guoweichao@oppo.com>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ltp@lists.linux.it
Subject: [f2fs]  36e4d95891: ltp.swapon03.fail
Message-ID: <20210511061121.GD8539@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 36e4d95891ed37eb98a660babec749be3fb35fd9 ("f2fs: check if swapfile =
is section-alligned")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: ltp
version: ltp-x86_64-14c1f76-1_20210318
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: syscalls-04
	ucode: 0xe2

test-description: The LTP testsuite contains a collection of tools for test=
ing the Linux kernel and related features.
test-url: http://linux-test-project.github.io/


on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G=
 memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

2021-05-07 06:09:26 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-05-07 06:09:26 ./runltp -f syscalls-04 -d /fs/sda1/tmpdir
INFO: creating /lkp/benchmarks/ltp/output directory
INFO: creating /lkp/benchmarks/ltp/results directory
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

/etc/os-release
PRETTY_NAME=3D"Debian GNU/Linux 10 (buster)"
NAME=3D"Debian GNU/Linux"
VERSION_ID=3D"10"
VERSION=3D"10 (buster)"
VERSION_CODENAME=3Dbuster
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"

uname:
Linux lkp-skl-d02 5.12.0-rc2-00408-g36e4d95891ed #1 SMP Sun Apr 18 15:27:41=
 CST 2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=3D0xe2-debian-10.4-x86_64=
-20200603.cgz-36e4d95891ed37eb98a660babec749be3fb35fd9-20210507-21194-1abea=
5d-8.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinus/master com=
mit=3D36e4d95891ed37eb98a660babec749be3fb35fd9 BOOT_IMAGE=3D/pkg/linux/x86_=
64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/vmlinuz-5.12.0-r=
c2-00408-g36e4d95891ed max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1HDD-f2f=
s-syscalls-04-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_=
64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/8 LKP_SERVER=3Di=
nternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enab=
led rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Do=
n panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ra=
mdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr i=
gnore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,11=
5200 vga=3Dnormal rw

Gnu C                  gcc (Debian 8.3.0-6) 8.3.0
Clang                =20
Gnu make               4.2.1
util-linux             2.33.1
mount                  linux 2.33.1 (libmount 2.33.1: selinux, smack, btrfs=
, namespaces, assert, debug)
modutils               26
e2fsprogs              1.44.5
Linux C Library        > libc.2.28
Dynamic linker (ldd)   2.28
Procps                 3.3.15
Net-tools              2.10-alpha
iproute2               iproute2-ss190107
iputils                iputils-s20180629
ethtool                4.19
Kbd                    119:
Sh-utils               8.30
Modules Loaded         dm_mod f2fs xfs libcrc32c ipmi_devintf ipmi_msghandl=
er sd_mod t10_pi sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal i=
ntel_powerclamp coretemp kvm_intel i915 kvm intel_gtt drm_kms_helper irqbyp=
ass crct10dif_pclmul crc32_pclmul mei_wdt crc32c_intel ghash_clmulni_intel =
wmi_bmof syscopyarea ahci sysfillrect sysimgblt libahci mei_me fb_sys_fops =
rapl intel_cstate mei libata drm intel_uncore intel_pch_thermal wmi video i=
ntel_pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32754220      343508    29823812       21796     2586900    2959=
5396
Swap:             0           0           0

cpuinfo:
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
Address sizes:       39 bits physical, 48 bits virtual
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               94
Model name:          Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
Stepping:            3
CPU MHz:             3200.000
CPU max MHz:         3600.0000
CPU min MHz:         800.0000
BogoMIPS:            6399.96
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            6144K
NUMA node0 CPU(s):   0-3
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m=
ca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vm=
x smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe=
 popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefe=
tch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi=
 flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 e=
rms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xge=
tbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp m=
d_clear flush_l1d

AppArmor enabled

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2546     -n 2546 -=
p -f /fs/sda1/tmpdir/ltp-ctEC1rCkVQ/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_05_07-06h_09m_26s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_05_07-06h_09m_26s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_05_07-06h_09m_26s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_05_07-06h_09m_26s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_05_07-06h_0=
9m_26s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_05_07-06h_09=
m_26s.tconf
Running tests.......
<<<test_start>>>
tag=3Daccess01 stime=3D1620367766
cmdline=3D"access01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
access01.c:241: TPASS: access(accessfile_rwx, F_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, F_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, X_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, X_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, W_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, W_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|W_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|W_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|X_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|X_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, W_OK|X_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, W_OK|X_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|W_OK|X_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|W_OK|X_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessfile_x, X_OK) as root passed
access01.c:241: TPASS: access(accessfile_x, X_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_w, W_OK) as root passed
access01.c:241: TPASS: access(accessfile_w, W_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_r, R_OK) as root passed
access01.c:241: TPASS: access(accessfile_r, R_OK) as nobody passed
access01.c:238: TPASS: access(accessfile_r, X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_r, X_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_r, W_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_w, R_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_w, X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_w, X_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_x, R_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_x, W_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_r, W_OK|X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_r, W_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_r, R_OK|X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_r, R_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_r, R_OK|W_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_r, R_OK|W_OK|X_OK) as root: EACCES=
 (13)
access01.c:238: TPASS: access(accessfile_r, R_OK|W_OK|X_OK) as nobody: EACC=
ES (13)
access01.c:238: TPASS: access(accessfile_w, W_OK|X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_w, W_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_w, R_OK|X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_w, R_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_w, R_OK|W_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_w, R_OK|W_OK|X_OK) as root: EACCES=
 (13)
access01.c:238: TPASS: access(accessfile_w, R_OK|W_OK|X_OK) as nobody: EACC=
ES (13)
access01.c:238: TPASS: access(accessfile_x, W_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_x, R_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_x, R_OK|W_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_x, R_OK|W_OK|X_OK) as nobody: EACC=
ES (13)
access01.c:241: TPASS: access(accessfile_r, W_OK) as root passed
access01.c:241: TPASS: access(accessfile_r, R_OK|W_OK) as root passed
access01.c:241: TPASS: access(accessfile_w, R_OK) as root passed
access01.c:241: TPASS: access(accessfile_w, R_OK|W_OK) as root passed
access01.c:241: TPASS: access(accessfile_x, R_OK) as root passed
access01.c:241: TPASS: access(accessfile_x, W_OK) as root passed
access01.c:241: TPASS: access(accessfile_x, R_OK|W_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_r, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_r, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_r, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_w, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_w, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_w, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_x, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_x, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_x, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_x, X_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_r, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_r, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_r, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_w, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_w, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_w, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_x, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_x, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_x, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_x, X_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_r, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_r, F_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_x/accessfile_r, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_r, R_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_x/accessfile_r, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_w, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_w, F_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_x/accessfile_w, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_w, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_w, W_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, F_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, X_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, X_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_rw/accessfile_r, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_r, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_r, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_w, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_w, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_w, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_x, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_x, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_x, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_x, X_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_r, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_r, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_rx/accessfile_r, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_r, R_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_rx/accessfile_r, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_w, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_w, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_rx/accessfile_w, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_w, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_w, W_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, X_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, X_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_r, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_r, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_r, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_r, R_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_r, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_w, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_w, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_w, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_w, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_w, W_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, X_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, X_OK) as nobody pa=
ssed
access01.c:238: TPASS: access(accessdir_r/accessfile_r, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_r, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_r, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_r, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_r, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_w, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_w, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_w, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_w, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_w, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_x, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_x, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_x, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_x, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_r, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_r, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_r, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_r, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_r, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_w, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_w, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_w, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_w, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_w, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_x, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_x, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_x, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_x, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_r, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_r, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_r, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_w, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_w, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_w, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_x, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_x, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_r, F_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_r, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_r, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_r, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_r, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_w, F_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_w, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_w, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_w, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_w, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_x, F_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_x, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_x, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_x, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_r, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_r, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_r, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_w, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_w, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_w, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_x, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_x, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_r, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_r, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_r, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_w, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_w, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_w, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_x, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_x, W_OK) as nobody: E=
ACCES (13)

Summary:
passed   199
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dcapset04 stime=3D1620367766
cmdline=3D"capset04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
capset04.c:27: TINFO: Test capset() for a different process
capset04.c:31: TPASS: capset(): EPERM (1)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchown03_16 stime=3D1620367766
cmdline=3D"chown03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/chown/../utils/compat_tst_16=
=2Eh:153: TCONF: 16-bit version of chown() is not supported on your platform

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dchroot01 stime=3D1620367766
cmdline=3D"chroot01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chroot01    1  TPASS  :  chroot set errno to EPERM.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_nanosleep03 stime=3D1620367766
cmdline=3D"clock_nanosleep03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:53: TINFO: Testing variant: vDSO or syscall with libc s=
pec
clock_nanosleep03.c:100: TPASS: clock_nanosleep() slept correctly 100210
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:53: TINFO: Testing variant: syscall with old kernel spec
clock_nanosleep03.c:100: TPASS: clock_nanosleep() slept correctly 100183

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_gettime01 stime=3D1620367766
cmdline=3D"clock_gettime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_gettime01.c:76: TINFO: Testing variant: vDSO or syscall with libc spec
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_REALTIME passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_PROCESS_CPUTIME=
_ID passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_THREAD_CPUTIME_=
ID passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_REALTIME_COARSE=
 passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC_COARS=
E passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC_RAW p=
assed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_BOOTTIME passed
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_gettime01.c:76: TINFO: Testing variant: syscall with old kernel spec
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_REALTIME passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_PROCESS_CPUTIME=
_ID passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_THREAD_CPUTIME_=
ID passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_REALTIME_COARSE=
 passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC_COARS=
E passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC_RAW p=
assed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_BOOTTIME passed

Summary:
passed   16
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_settime02 stime=3D1620367766
cmdline=3D"clock_settime02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_settime02.c:107: TINFO: Testing variant: syscall with old kernel spec
clock_settime02.c:152: TPASS: clock_settime(CLOCK_REALTIME): failed as expe=
cted: EFAULT (14)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_REALTIME): failed as expe=
cted: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_REALTIME): failed as expe=
cted: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_REALTIME): failed as expe=
cted: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_MONOTONIC): failed as exp=
ected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(INVALID/UNKNOWN CLOCK): failed =
as expected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(INVALID/UNKNOWN CLOCK): failed =
as expected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_MONOTONIC_COARSE): failed=
 as expected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_MONOTONIC_RAW): failed as=
 expected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_BOOTTIME): failed as expe=
cted: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_PROCESS_CPUTIME_ID): fail=
ed as expected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_THREAD_CPUTIME_ID): faile=
d as expected: EINVAL (22)

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclone02 stime=3D1620367766
cmdline=3D"clone02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
clone02     1  TPASS  :  Test Passed
clone02     2  TPASS  :  Test Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclone04 stime=3D1620367766
cmdline=3D"clone04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
clone04     1  TPASS  :  expected failure; Got EINVAL
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclone08 stime=3D1620367766
cmdline=3D"clone08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clone08.c:72: TINFO: running CLONE_PARENT
clone08.c:116: TPASS: clone and forked child has the same parent
clone08.c:72: TINFO: running CLONE_CHILD_SETTID
clone08.c:134: TPASS: clone() correctly set ctid
clone08.c:72: TINFO: running CLONE_PARENT_SETTID
clone08.c:144: TPASS: clone() correctly set ptid
clone08.c:72: TINFO: running CLONE_THREAD
clone08.c:223: TPASS: clone has the same thread id
clone08.c:213: TPASS: futex exit on ctid change, ctid: 0

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dclose_range01 stime=3D1620367766
cmdline=3D"close_range01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports ext3
tst_supported_fs_types.c:51: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports ext4
tst_supported_fs_types.c:51: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports xfs
tst_supported_fs_types.c:51: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:51: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports vfat
tst_supported_fs_types.c:51: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:115: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:119: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:51: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:38: TINFO: mkfs is not needed for tmpfs
tst_test.c:1379: TINFO: Testing on ext2
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on ext3
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on ext4
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on xfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on btrfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on vfat
tst_test.c:889: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on ntfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
=3D''
The partition start sector was not specified for /dev/loop0 and it could no=
t be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it cou=
ld not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be ob=
tained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sec=
tors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:900: TINFO: Trying FUSE...
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on tmpfs
tst_test.c:889: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints

Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D8 cstime=3D93
<<<test_end>>>
<<<test_start>>>
tag=3Dconnect02 stime=3D1620367771
cmdline=3D"connect02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
connect02.c:125: TPASS: Nothing bad happened, probably

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Ddelete_module01 stime=3D1620367771
cmdline=3D"delete_module01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_module.c:70: TCONF: Failed to find module 'dummy_del_mod.ko'

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Ddup01 stime=3D1620367771
cmdline=3D"dup01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
dup01.c:23: TPASS: dup(4) returned 5

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Ddup07 stime=3D1620367771
cmdline=3D"dup07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dup07       1  TPASS  :  Passed in read mode.
dup07       2  TPASS  :  Passed in write mode.
dup07       3  TPASS  :  Passed in read/write mode.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Ddup3_01 stime=3D1620367771
cmdline=3D"dup3_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dup3_01     1  TPASS  :  dup3(O_CLOEXEC) PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexecl01 stime=3D1620367771
cmdline=3D"execl01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
execl01_child.c:20: TPASS: execl01_child executed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexecvp01 stime=3D1620367771
cmdline=3D"execvp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
execvp01_child.c:20: TPASS: execvp01_child executed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfchown04_16 stime=3D1620367771
cmdline=3D"fchown04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
fchown04_16    0  TINFO  :  Found free device 0 '/dev/loop0'
fchown04_16    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra=
 opts=3D''
fchown04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
fchown/../utils/compat_16.h:156: 16-bit version of fchown() is not supporte=
d on your platform
fchown04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
fchown/../utils/compat_16.h:156: Remaining cases not appropriate for config=
uration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dfchownat02 stime=3D1620367772
cmdline=3D"fchownat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fchownat02    1  TPASS  :  fchownat() test AT_SYMLINK_NOFOLLOW success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl08_64 stime=3D1620367772
cmdline=3D"fcntl08_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl08     1  TPASS  :  fcntl returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl14_64 stime=3D1620367772
cmdline=3D"fcntl14_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl14     0  TINFO  :  Enter block 1: without mandatory locking
fcntl14     1  TPASS  :  testcase:1 PASSED
fcntl14     2  TPASS  :  testcase:2 PASSED
fcntl14     3  TPASS  :  testcase:3 PASSED
fcntl14     4  TPASS  :  testcase:4 PASSED
fcntl14     5  TPASS  :  testcase:5 PASSED
fcntl14     6  TPASS  :  testcase:6 PASSED
fcntl14     7  TPASS  :  testcase:7 PASSED
fcntl14     8  TPASS  :  testcase:8 PASSED
fcntl14     9  TPASS  :  testcase:9 PASSED
fcntl14    10  TPASS  :  testcase:10 PASSED
fcntl14    11  TPASS  :  testcase:11 PASSED
fcntl14    12  TPASS  :  testcase:12 PASSED
fcntl14    13  TPASS  :  testcase:13 PASSED
fcntl14    14  TPASS  :  testcase:14 PASSED
fcntl14    15  TPASS  :  testcase:15 PASSED
fcntl14    16  TPASS  :  testcase:16 PASSED
fcntl14    17  TPASS  :  testcase:17 PASSED
fcntl14    18  TPASS  :  testcase:18 PASSED
fcntl14    19  TPASS  :  testcase:19 PASSED
fcntl14    20  TPASS  :  testcase:20 PASSED
fcntl14    21  TPASS  :  testcase:21 PASSED
fcntl14    22  TPASS  :  testcase:22 PASSED
fcntl14    23  TPASS  :  testcase:23 PASSED
fcntl14    24  TPASS  :  testcase:24 PASSED
fcntl14    25  TPASS  :  testcase:25 PASSED
fcntl14    26  TPASS  :  testcase:26 PASSED
fcntl14    27  TPASS  :  testcase:27 PASSED
fcntl14    28  TPASS  :  testcase:28 PASSED
fcntl14    29  TPASS  :  testcase:29 PASSED
fcntl14    30  TPASS  :  testcase:30 PASSED
fcntl14    31  TPASS  :  testcase:31 PASSED
fcntl14    32  TPASS  :  testcase:32 PASSED
fcntl14    33  TPASS  :  testcase:33 PASSED
fcntl14    34  TPASS  :  testcase:34 PASSED
fcntl14    35  TPASS  :  testcase:35 PASSED
fcntl14    36  TPASS  :  testcase:36 PASSED
fcntl14    37  TPASS  :  Block 1, test 1 PASSED
fcntl14    38  TPASS  :  testcase:37 PASSED
fcntl14    39  TPASS  :  testcase:38 PASSED
fcntl14    40  TPASS  :  testcase:39 PASSED
fcntl14    41  TPASS  :  testcase:40 PASSED
fcntl14    42  TPASS  :  testcase:41 PASSED
fcntl14    43  TPASS  :  testcase:42 PASSED
fcntl14    44  TPASS  :  testcase:43 PASSED
fcntl14    45  TPASS  :  testcase:44 PASSED
fcntl14    46  TPASS  :  testcase:45 PASSED
fcntl14    47  TPASS  :  Block 1, test 2 PASSED
fcntl14     0  TINFO  :  Exit block 1
fcntl14     0  TINFO  :  Enter block 2: with mandatory locking
fcntl14    48  TPASS  :  testcase:1 PASSED
fcntl14    49  TPASS  :  testcase:2 PASSED
fcntl14    50  TPASS  :  testcase:3 PASSED
fcntl14    51  TPASS  :  testcase:4 PASSED
fcntl14    52  TPASS  :  testcase:5 PASSED
fcntl14    53  TPASS  :  testcase:6 PASSED
fcntl14    54  TPASS  :  testcase:7 PASSED
fcntl14    55  TPASS  :  testcase:8 PASSED
fcntl14    56  TPASS  :  testcase:9 PASSED
fcntl14    57  TPASS  :  testcase:10 PASSED
fcntl14    58  TPASS  :  testcase:11 PASSED
fcntl14    59  TPASS  :  testcase:12 PASSED
fcntl14    60  TPASS  :  testcase:13 PASSED
fcntl14    61  TPASS  :  testcase:14 PASSED
fcntl14    62  TPASS  :  testcase:15 PASSED
fcntl14    63  TPASS  :  testcase:16 PASSED
fcntl14    64  TPASS  :  testcase:17 PASSED
fcntl14    65  TPASS  :  testcase:18 PASSED
fcntl14    66  TPASS  :  testcase:19 PASSED
fcntl14    67  TPASS  :  testcase:20 PASSED
fcntl14    68  TPASS  :  testcase:21 PASSED
fcntl14    69  TPASS  :  testcase:22 PASSED
fcntl14    70  TPASS  :  testcase:23 PASSED
fcntl14    71  TPASS  :  testcase:24 PASSED
fcntl14    72  TPASS  :  testcase:25 PASSED
fcntl14    73  TPASS  :  testcase:26 PASSED
fcntl14    74  TPASS  :  testcase:27 PASSED
fcntl14    75  TPASS  :  testcase:28 PASSED
fcntl14    76  TPASS  :  testcase:29 PASSED
fcntl14    77  TPASS  :  testcase:30 PASSED
fcntl14    78  TPASS  :  testcase:31 PASSED
fcntl14    79  TPASS  :  testcase:32 PASSED
fcntl14    80  TPASS  :  testcase:33 PASSED
fcntl14    81  TPASS  :  testcase:34 PASSED
fcntl14    82  TPASS  :  testcase:35 PASSED
fcntl14    83  TPASS  :  testcase:36 PASSED
fcntl14    84  TPASS  :  Block 2, test 1 PASSED
fcntl14    85  TPASS  :  testcase:37 PASSED
fcntl14    86  TPASS  :  testcase:38 PASSED
fcntl14    87  TPASS  :  testcase:39 PASSED
fcntl14    88  TPASS  :  testcase:40 PASSED
fcntl14    89  TPASS  :  testcase:41 PASSED
fcntl14    90  TPASS  :  testcase:42 PASSED
fcntl14    91  TPASS  :  testcase:43 PASSED
fcntl14    92  TPASS  :  testcase:44 PASSED
fcntl14    93  TPASS  :  testcase:45 PASSED
fcntl14    94  TPASS  :  Block 2, test 2 PASSED
fcntl14     0  TINFO  :  Exit block 2
fcntl14     0  TINFO  :  Enter block 3
fcntl14    95  TPASS  :  Test with negative whence locking PASSED
fcntl14     0  TINFO  :  Exit block 3
fcntl14     0  TINFO  :  Enter block 4
fcntl14    96  TPASS  :  Test of locks on file PASSED
fcntl14     0  TINFO  :  Exit block 4
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl23_64 stime=3D1620367777
cmdline=3D"fcntl23_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl23     1  TPASS  :  fcntl(tfile_3130, F_SETLEASE, F_RDLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl37_64 stime=3D1620367777
cmdline=3D"fcntl37_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_RESOURCE(24)
fcntl37.c:42: TINFO: F_SETPIPE_SZ and size is beyond 1<<31
fcntl37.c:50: TPASS: F_SETPIPE_SZ failed as expected: EINVAL (22)
fcntl37.c:42: TINFO: F_SETPIPE_SZ and size < data stored in pipe
fcntl37.c:50: TPASS: F_SETPIPE_SZ failed as expected: EBUSY (16)
fcntl37.c:42: TINFO: F_SETPIPE_SZ and size is over limit for unpriviledged =
user
fcntl37.c:50: TPASS: F_SETPIPE_SZ failed as expected: EPERM (1)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfdatasync01 stime=3D1620367777
cmdline=3D"fdatasync01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fdatasync01    1  TPASS  :  fdatasync() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfdatasync02 stime=3D1620367777
cmdline=3D"fdatasync02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fdatasync02    1  TPASS  :  Expected failure for invalid file descriptor, e=
rrno: 9
fdatasync02    2  TPASS  :  Expected failure for file descriptor to a speci=
al file, errno: 22
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dflock02 stime=3D1620367777
cmdline=3D"flock02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
flock02.c:46: TPASS: flock() failed expectedly: EBADF (9)
flock02.c:46: TPASS: flock() failed expectedly: EINVAL (22)
flock02.c:46: TPASS: flock() failed expectedly: EINVAL (22)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dflock04 stime=3D1620367777
cmdline=3D"flock04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
flock04.c:61: TPASS: Parent had shared lock
flock04.c:36: TPASS:  Child acquiring shared lock got 0
flock04.c:39: TPASS:  Child acquiring exclusive lock got -1
flock04.c:61: TPASS: Parent had exclusive lock
flock04.c:39: TPASS:  Child acquiring shared lock got -1
flock04.c:39: TPASS:  Child acquiring exclusive lock got -1

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfmtmsg01 stime=3D1620367777
cmdline=3D"fmtmsg01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fmtms01     1  TPASS  :  Test passed
fmtms01     2  TPASS  :  Test passed
fmtms01     3  TPASS  :  Test passed
fmtms01     4  TPASS  :  Test passed
fmtms01     5  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork01 stime=3D1620367777
cmdline=3D"fork01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork01      1  TPASS  :  fork() returned 3148
fork01      2  TPASS  :  child pid and fork() return agree: 3148
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork13 stime=3D1620367777
cmdline=3D"fork13 -i 1000000"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork13      1  TPASS  :  1000000 pids forked, all passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D101 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D6642 cstime=3D3759
<<<test_end>>>
<<<test_start>>>
tag=3Dfsopen02 stime=3D1620367878
cmdline=3D"fsopen02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsopen02.c:49: TPASS: invalid-fs: fsopen() failed as expected: ENODEV (19)
fsopen02.c:49: TPASS: invalid-flags: fsopen() failed as expected: EINVAL (2=
2)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfstatat01 stime=3D1620367878
cmdline=3D"fstatat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fstatat01    1  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DSUCCESS(=
0): Success
fstatat01    2  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DSUCCESS(=
0): Success
fstatat01    3  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DENOTDIR(=
20): Not a directory
fstatat01    4  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DEBADF(9)=
: Bad file descriptor
fstatat01    5  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DEINVAL(2=
2): Invalid argument
fstatat01    6  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DSUCCESS(=
0): Success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfsync02 stime=3D1620367878
cmdline=3D"fsync02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync02.c:99: TPASS: fsync succeeded in an acceptable amount of time

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dfsync04 stime=3D1620367878
cmdline=3D"fsync04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports ext3
tst_supported_fs_types.c:51: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports ext4
tst_supported_fs_types.c:51: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports xfs
tst_supported_fs_types.c:51: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:51: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports vfat
tst_supported_fs_types.c:51: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:115: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:119: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:51: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:148: TINFO: Skipping tmpfs as requested by the test
tst_test.c:1379: TINFO: Testing on ext2
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on ext3
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on ext4
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on xfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on btrfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on vfat
tst_test.c:889: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on ntfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
=3D''
The partition start sector was not specified for /dev/loop0 and it could no=
t be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it cou=
ld not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be ob=
tained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sec=
tors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:900: TINFO: Trying FUSE...
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D7 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7 cstime=3D114
<<<test_end>>>
<<<test_start>>>
tag=3Dgetdomainname01 stime=3D1620367885
cmdline=3D"getdomainname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getdomainname01    1  TPASS  :  getdomainname() returned 0=20
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgeteuid01_16 stime=3D1620367885
cmdline=3D"geteuid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
geteuid01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: 16-bit version of geteuid() is not suppo=
rted on your platform
geteuid01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: Remaining cases not appropriate for conf=
iguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetitimer01 stime=3D1620367885
cmdline=3D"getitimer01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getitimer01    1  TPASS  :  functionality is ok
getitimer01    2  TPASS  :  functionality is ok
getitimer01    3  TPASS  :  functionality is ok
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetitimer02 stime=3D1620367885
cmdline=3D"getitimer02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getitimer02    1  TPASS  :  expected failure - errno =3D 14 - Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresgid03_16 stime=3D1620367885
cmdline=3D"getresgid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresgid03    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresgid/../utils/compat_16.h:151: 16-bit version of getresgid() is not su=
pported on your platform
getresgid03    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresgid/../utils/compat_16.h:151: Remaining cases not appropriate for con=
figuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresuid03_16 stime=3D1620367885
cmdline=3D"getresuid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid03    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresuid/../utils/compat_16.h:141: 16-bit version of getresuid() is not su=
pported on your platform
getresuid03    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresuid/../utils/compat_16.h:141: Remaining cases not appropriate for con=
figuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dget_mempolicy02 stime=3D1620367885
cmdline=3D"get_mempolicy02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:191: TINFO: Found 1 NUMA memory nodes
get_mempolicy02.c:79: TPASS: policy: MPOL_DEFAULT, invalid address: EFAULT =
(14)
get_mempolicy02.c:79: TPASS: policy: MPOL_DEFAULT, invalid flags, no target=
: EINVAL (22)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsid01 stime=3D1620367885
cmdline=3D"getsid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getsid01    1  TPASS  :  session ID is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsockopt02 stime=3D1620367885
cmdline=3D"getsockopt02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
getsockopt02.c:66: TPASS: Test passed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetxattr03 stime=3D1620367885
cmdline=3D"getxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getxattr03    1  TPASS  :  getxattr(2) returned correct value
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_loop07 stime=3D1620367885
cmdline=3D"ioctl_loop07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
ioctl_loop07.c:125: TINFO: original loop size 2048 sectors
ioctl_loop07.c:83: TINFO: When sizelimit is greater than loopsize by using =
LOOP_SET_STATUS64
ioctl_loop07.c:62: TPASS: /sys/block/loop0/size =3D 2048
ioctl_loop07.c:63: TPASS: /sys/block/loop0/loop/sizelimit =3D 4194304
ioctl_loop07.c:66: TPASS: LOOP_GET_STATUS64 gets correct lo_sizelimit(41943=
04)
ioctl_loop07.c:83: TINFO: When sizelimit is less than loopsize by using LOO=
P_SET_STATUS64
ioctl_loop07.c:62: TPASS: /sys/block/loop0/size =3D 1024
ioctl_loop07.c:63: TPASS: /sys/block/loop0/loop/sizelimit =3D 524288
ioctl_loop07.c:66: TPASS: LOOP_GET_STATUS64 gets correct lo_sizelimit(52428=
8)
ioctl_loop07.c:83: TINFO: When sizelimit is greater than loopsize by using =
LOOP_CONFIGURE
ioctl_loop07.c:62: TPASS: /sys/block/loop0/size =3D 2048
ioctl_loop07.c:63: TPASS: /sys/block/loop0/loop/sizelimit =3D 4194304
ioctl_loop07.c:66: TPASS: LOOP_GET_STATUS64 gets correct lo_sizelimit(41943=
04)
ioctl_loop07.c:83: TINFO: When sizelimit is less than loopsize by using LOO=
P_CONFIGURE
ioctl_loop07.c:62: TPASS: /sys/block/loop0/size =3D 1024
ioctl_loop07.c:63: TPASS: /sys/block/loop0/loop/sizelimit =3D 524288
ioctl_loop07.c:66: TPASS: LOOP_GET_STATUS64 gets correct lo_sizelimit(52428=
8)

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D10
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_ns03 stime=3D1620367886
cmdline=3D"ioctl_ns03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
ioctl_ns03.c:42: TPASS: NS_GET_OWNER_UID fails, UTS namespace

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify09 stime=3D1620367886
cmdline=3D"fanotify09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fanotify09.c:246: TINFO: Test #0: Events on non-dir child with both parent =
and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/tfile_992
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #1: Events on non-dir child and subdir with b=
oth parent and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/tfile_992
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D992 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testdir
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #2: Events on non-dir child and parent with b=
oth parent and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/tfile_992
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D992 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #3: Events on non-dir child and subdir with b=
oth parent and subdir marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/tfile_992
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D992 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testdir
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #4: Events on non-dir children with both pare=
nt and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/tfile_992
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D992 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testfile
fanotify09.c:191: TPASS: group 1 got event: mask 10 pid=3D992 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testfile
fanotify09.c:191: TPASS: group 2 got event: mask 10 pid=3D992 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testfile
fanotify09.c:246: TINFO: Test #5: Events on non-dir child with both parent =
and mount marks and filename info
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D-1 filena=
me=3Dtfile_992
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D992 fd=3D-1 filen=
ame=3Dtestfile
fanotify09.c:191: TPASS: group 1 got event: mask 10 pid=3D992 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testfile
fanotify09.c:191: TPASS: group 2 got event: mask 10 pid=3D992 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testfile

Summary:
passed   23
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify17 stime=3D1620367887
cmdline=3D"fanotify17"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fanotify17.c:243: TINFO: max_fanotify_groups=3D129 max_fanotify_marks=3D8192
fanotify17.c:176: TINFO: Test #0: Global groups limit in init user ns
fanotify17.c:133: TPASS: Created 129 groups - below groups limit (129)
fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
fanotify17.c:179: TCONF: fanotify inside user namespace is not supported
fanotify17.c:176: TINFO: Test #2: Local groups limit in unprivileged user ns
fanotify17.c:179: TCONF: fanotify inside user namespace is not supported
fanotify17.c:176: TINFO: Test #3: Local marks limit in unprivileged user ns
fanotify17.c:179: TCONF: fanotify inside user namespace is not supported

Summary:
passed   1
failed   0
broken   0
skipped  3
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dkeyctl06 stime=3D1620367887
cmdline=3D"keyctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
keyctl06.c:60: TPASS: KEYCTL_READ returned full count but didn't overrun th=
e buffer

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dkcmp01 stime=3D1620367887
cmdline=3D"kcmp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
kcmp01.c:86: TPASS: kcmp() returned the expected value
kcmp01.c:86: TPASS: kcmp() returned the expected value
kcmp01.c:86: TPASS: kcmp() returned the expected value
kcmp01.c:86: TPASS: kcmp() returned the expected value
kcmp01.c:86: TPASS: kcmp() returned the expected value

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkill08 stime=3D1620367887
cmdline=3D"kill08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill08      1  TPASS  :  received expected signal 9
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkill09 stime=3D1620367887
cmdline=3D"kill09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill09      1  TPASS  :  kill(1025, SIGKILL) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown01_16 stime=3D1620367887
cmdline=3D"lchown01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
lchown01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
lchown/../utils/compat_16.h:161: 16-bit version of lchown() is not supporte=
d on your platform
lchown01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
lchown/../utils/compat_16.h:161: Remaining cases not appropriate for config=
uration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown02_16 stime=3D1620367887
cmdline=3D"lchown02_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
lchown02_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
lchown/../utils/compat_16.h:161: 16-bit version of lchown() is not supporte=
d on your platform
lchown02_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
lchown/../utils/compat_16.h:161: Remaining cases not appropriate for config=
uration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlgetxattr01 stime=3D1620367887
cmdline=3D"lgetxattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
lgetxattr01.c:77: TPASS: lgetxattr() got expected value
lgetxattr01.c:90: TPASS: lgetxattr() failed as expected: ENODATA (61)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlgetxattr02 stime=3D1620367887
cmdline=3D"lgetxattr02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
lgetxattr02.c:63: TPASS: lgetxattr() failed as expected: ENODATA (61)
lgetxattr02.c:63: TPASS: lgetxattr() failed as expected: ERANGE (34)
lgetxattr02.c:63: TPASS: lgetxattr() failed as expected: EFAULT (14)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlink04 stime=3D1620367887
cmdline=3D"link04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link04      1  TPASS  :  link(<non-existent file>, <nefile>): TEST_ERRNO=3D=
ENOENT(2): No such file or directory
link04      2  TPASS  :  link(<path is empty string>, <nefile>): TEST_ERRNO=
=3DENOENT(2): No such file or directory
link04      3  TPASS  :  link(<path contains a non-existent file>, <nefile>=
): TEST_ERRNO=3DENOENT(2): No such file or directory
link04      4  TPASS  :  link(<path contains a regular file>, <nefile>): TE=
ST_ERRNO=3DENOTDIR(20): Not a directory
link04      5  TPASS  :  link(<pathname too long>, <nefile>): TEST_ERRNO=3D=
ENAMETOOLONG(36): File name too long
link04      6  TPASS  :  link(<invalid address>, <nefile>): TEST_ERRNO=3DEF=
AULT(14): Bad address
link04      7  TPASS  :  link(<regfile>, <empty string>): TEST_ERRNO=3DENOE=
NT(2): No such file or directory
link04      8  TPASS  :  link(<regfile>, <path contains a non-existent file=
>): TEST_ERRNO=3DENOENT(2): No such file or directory
link04      9  TPASS  :  link(<regfile>, <path contains a regular file>): T=
EST_ERRNO=3DENOENT(2): No such file or directory
link04     10  TPASS  :  link(<regfile>, <pathname too long>): TEST_ERRNO=
=3DENAMETOOLONG(36): File name too long
link04     11  TPASS  :  link(<regfile>, <invalid address>): TEST_ERRNO=3DE=
FAULT(14): Bad address
link04     12  TPASS  :  link(<regfile>, <regfile2>): TEST_ERRNO=3DEEXIST(1=
7): File exists
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlink05 stime=3D1620367887
cmdline=3D"link05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link05      1  TPASS  :  link(lkfile_1033, lkfile_1033[1-1000]) ret 0 for 1=
000 files,stat linkcounts match 1000
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dlstat02 stime=3D1620367887
cmdline=3D"lstat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
lstat02.c:72: TPASS: lstat() failed as expected: EACCES (13)
lstat02.c:72: TPASS: lstat() failed as expected: ENOENT (2)
lstat02.c:72: TPASS: lstat() failed as expected: EFAULT (14)
lstat02.c:72: TPASS: lstat() failed as expected: ENAMETOOLONG (36)
lstat02.c:72: TPASS: lstat() failed as expected: ENOTDIR (20)
lstat02.c:72: TPASS: lstat() failed as expected: ELOOP (40)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmbind01 stime=3D1620367887
cmdline=3D"mbind01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
mbind01.c:169: TINFO: case MPOL_DEFAULT
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_DEFAULT (target exists)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_BIND (no target)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_BIND
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_INTERLEAVE (no target)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_INTERLEAVE
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_PREFERRED (no target)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_PREFERRED
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case UNKNOWN_POLICY
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_DEFAULT (invalid flags)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_PREFERRED (invalid nodemask)
mbind01.c:216: TPASS: Test passed

Summary:
passed   11
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dmemcpy01 stime=3D1620367887
cmdline=3D"memcpy01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
memcpy1     1  TPASS  :  Test passed
memcpy1     2  TPASS  :  Test passed
memcpy1     3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmknod01 stime=3D1620367887
cmdline=3D"mknod01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mknod01     1  TPASS  :  mknod(test_node, 0100777, 0) returned 0
mknod01     2  TPASS  :  mknod(test_node, 010777, 0) returned 0
mknod01     3  TPASS  :  mknod(test_node, 020777, 259) returned 0
mknod01     4  TPASS  :  mknod(test_node, 060777, 0) returned 0
mknod01     5  TPASS  :  mknod(test_node, 0104700, 0) returned 0
mknod01     6  TPASS  :  mknod(test_node, 0102700, 0) returned 0
mknod01     7  TPASS  :  mknod(test_node, 0106700, 0) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmknod07 stime=3D1620367887
cmdline=3D"mknod07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
mknod07     0  TINFO  :  Found free device 0 '/dev/loop0'
mknod07     0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
mknod07     1  TPASS  :  mknod failed as expected: TEST_ERRNO=3DEACCES(13):=
 Permission denied
mknod07     2  TPASS  :  mknod failed as expected: TEST_ERRNO=3DEACCES(13):=
 Permission denied
mknod07     3  TPASS  :  mknod failed as expected: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
mknod07     4  TPASS  :  mknod failed as expected: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
mknod07     5  TPASS  :  mknod failed as expected: TEST_ERRNO=3DEROFS(30): =
Read-only file system
mknod07     6  TPASS  :  mknod failed as expected: TEST_ERRNO=3DELOOP(40): =
Too many levels of symbolic links
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap06 stime=3D1620367888
cmdline=3D"mmap06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap06      1  TPASS  :  mmap failed with EACCES
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap07 stime=3D1620367888
cmdline=3D"mmap07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap07      1  TPASS  :  mmap failed with EACCES
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmount06 stime=3D1620367888
cmdline=3D"mount06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
mount06     0  TINFO  :  Found free device 0 '/dev/loop0'
mount06     0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
mount06     1  TPASS  :  move mount is ok
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages03 stime=3D1620367888
cmdline=3D"move_pages03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
move_pages03    1  TCONF  :  move_pages_support.c:407: at least 2 allowed N=
UMA nodes are required
move_pages03    2  TCONF  :  move_pages_support.c:407: Remaining cases not =
appropriate for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages11 stime=3D1620367888
cmdline=3D"move_pages11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
move_pages11    1  TCONF  :  move_pages_support.c:407: at least 2 allowed N=
UMA nodes are required
move_pages11    2  TCONF  :  move_pages_support.c:407: Remaining cases not =
appropriate for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_timedreceive01 stime=3D1620367888
cmdline=3D"mq_timedreceive01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
mq_timedreceive01.c:140: TINFO: Testing variant: vDSO or syscall with libc =
spec
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 0, priority 0, l=
ength: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 1, priority 0, l=
ength: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 8192, priority 0=
, length: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 1, priority 3276=
7, length: 8192
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_timedreceive/../utils/mq.=
h:70: TINFO: receive 1/1 message
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EMSGSI=
ZE (90)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EAGAIN=
/EWOULDBLOCK (11)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: ETIMED=
OUT (110)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINTR =
(4)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EFAULT=
 (14)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
mq_timedreceive01.c:140: TINFO: Testing variant: syscall with old kernel sp=
ec
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 0, priority 0, l=
ength: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 1, priority 0, l=
ength: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 8192, priority 0=
, length: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 1, priority 3276=
7, length: 8192
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_timedreceive/../utils/mq.=
h:70: TINFO: receive 1/1 message
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EMSGSI=
ZE (90)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EAGAIN=
/EWOULDBLOCK (11)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: ETIMED=
OUT (110)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINTR =
(4)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EFAULT=
 (14)

Summary:
passed   30
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap02 stime=3D1620367889
cmdline=3D"mremap02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mremap02    1  TPASS  :  mremap() Failed, 'invalid argument specified' - er=
rno 22
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgctl04 stime=3D1620367889
cmdline=3D"msgctl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
msgctl04.c:59: TPASS: msgctl(1, 2, 0x5593a295f840): EACCES (13)
msgctl04.c:59: TPASS: msgctl(2, 2, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, 1, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, -1, 0x5593a295f840): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 2, 0x5593a295f840): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 1, 0x5593a295f840): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(0, 0, (nil)): EPERM (1)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgget01 stime=3D1620367889
cmdline=3D"msgget01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
msgget01.c:45: TPASS: message received =3D message sent

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgrcv01 stime=3D1620367889
cmdline=3D"msgrcv01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
msgrcv01.c:38: TPASS: message received(hello) =3D message sent(hello)
msgrcv01.c:45: TPASS: queue bytes and number of queues matched
msgrcv01.c:49: TPASS: PID of last msgrcv(2) matched
msgrcv01.c:56: TPASS: msg_rtime =3D 1620367889 in [1620367889, 1620367889]

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmunmap03 stime=3D1620367889
cmdline=3D"munmap03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
munmap03    1  TPASS  :  failed as expected: TEST_ERRNO=3DEINVAL(22): Inval=
id argument
munmap03    2  TPASS  :  failed as expected: TEST_ERRNO=3DEINVAL(22): Inval=
id argument
munmap03    3  TPASS  :  failed as expected: TEST_ERRNO=3DEINVAL(22): Inval=
id argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dnice02 stime=3D1620367889
cmdline=3D"nice02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
nice02.c:46: TPASS: nice(50) passed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dnice03 stime=3D1620367889
cmdline=3D"nice03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
nice03.c:47: TPASS: nice(2) passed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen08 stime=3D1620367889
cmdline=3D"open08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
open08.c:84: TPASS: expected failure - errno =3D 17 : File exists
open08.c:84: TPASS: expected failure - errno =3D 21 : Is a directory
open08.c:84: TPASS: expected failure - errno =3D 20 : Not a directory
open08.c:84: TPASS: expected failure - errno =3D 36 : File name too long
open08.c:84: TPASS: expected failure - errno =3D 13 : Permission denied
open08.c:84: TPASS: expected failure - errno =3D 14 : Bad address

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen09 stime=3D1620367889
cmdline=3D"open09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open09      1  TPASS  :  Test passed in O_WRONLY.
open09      2  TPASS  :  Test passed in O_RDONLY.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopenat02 stime=3D1620367889
cmdline=3D"openat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
openat02    1  TPASS  :  test O_APPEND for openat success
openat02    2  TPASS  :  test O_CLOEXEC for openat success
openat02    3  TPASS  :  test O_LARGEFILE for openat success
openat02    4  TCONF  :  openat02.c:237: test O_NOATIME flag for openat nee=
ds filesystems which are mounted without noatime and relatime
openat02    5  TPASS  :  test O_NOFOLLOW for openat success
openat02    6  TPASS  :  test O_TRUNC for openat success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopenat202 stime=3D1620367889
cmdline=3D"openat202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
openat202.c:58: TPASS: open /proc/version: openat2() passed
openat202.c:58: TPASS: open magiclinks: openat2() passed
openat202.c:58: TPASS: open symlinks: openat2() passed
openat202.c:74: TPASS: resolve-no-xdev: openat2() failed as expected: EXDEV=
 (18)
openat202.c:74: TPASS: resolve-no-magiclinks: openat2() failed as expected:=
 ELOOP (40)
openat202.c:74: TPASS: resolve-no-symlinks: openat2() failed as expected: E=
LOOP (40)
openat202.c:74: TPASS: resolve-beneath: openat2() failed as expected: EXDEV=
 (18)
openat202.c:74: TPASS: resolve-beneath: openat2() failed as expected: EXDEV=
 (18)
openat202.c:74: TPASS: resolve-no-in-root: openat2() failed as expected: EN=
OENT (2)

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen_by_handle_at02 stime=3D1620367889
cmdline=3D"open_by_handle_at02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_buffers.c:55: TINFO: Test is using guarded buffers
open_by_handle_at02.c:99: TPASS: invalid-dfd: open_by_handle_at() failed as=
 expected: EBADF (9)
open_by_handle_at02.c:99: TPASS: stale-dfd: open_by_handle_at() failed as e=
xpected: ESTALE (116)
open_by_handle_at02.c:99: TPASS: invalid-file-handle: open_by_handle_at() f=
ailed as expected: EFAULT (14)
open_by_handle_at02.c:99: TPASS: high-file-handle-size: open_by_handle_at()=
 failed as expected: EINVAL (22)
open_by_handle_at02.c:99: TPASS: zero-file-handle-size: open_by_handle_at()=
 failed as expected: EINVAL (22)
tst_capability.c:29: TINFO: Dropping CAP_DAC_READ_SEARCH(2)
tst_capability.c:41: TINFO: Permitting CAP_DAC_READ_SEARCH(2)
open_by_handle_at02.c:99: TPASS: no-capability: open_by_handle_at() failed =
as expected: EPERM (1)
open_by_handle_at02.c:99: TPASS: symlink: open_by_handle_at() failed as exp=
ected: ELOOP (40)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmincore01 stime=3D1620367889
cmdline=3D"mincore01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mincore01    1  TPASS  :  failed as expected: TEST_ERRNO=3DEINVAL(22): Inva=
lid argument
mincore01    2  TPASS  :  failed as expected: TEST_ERRNO=3DEFAULT(14): Bad =
address
mincore01    3  TPASS  :  failed as expected: TEST_ERRNO=3DENOMEM(12): Cann=
ot allocate memory
mincore01    4  TPASS  :  failed as expected: TEST_ERRNO=3DENOMEM(12): Cann=
ot allocate memory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dnewuname01 stime=3D1620367889
cmdline=3D"newuname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
newuname01    1  TPASS  :  newuname call succeed: return value =3D 0=20
newuname01    0  TINFO  :  This system is Linux
newuname01    0  TINFO  :  The system infomation is :
newuname01    0  TINFO  :  System is Linux on x86_64 hardware
newuname01    0  TINFO  :  Nodename is lkp-skl-d02
newuname01    0  TINFO  :  Version is 5.12.0-rc2-00408-g36e4d95891ed, #1 SM=
P Sun Apr 18 15:27:41 CST 2021
newuname01    0  TINFO  :  Domainname is (none)=20
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe02 stime=3D1620367889
cmdline=3D"pipe02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
pipe02.c:86: TPASS: Child killed by SIGPIPE

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe03 stime=3D1620367889
cmdline=3D"pipe03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
pipe03.c:30: TPASS: expected failure writing to read end of pipe: EBADF (9)
pipe03.c:39: TPASS: expected failure reading from write end of pipe: EBADF =
(9)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpivot_root01 stime=3D1620367889
cmdline=3D"pivot_root01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
pivot_root01.c:158: TPASS: pivot_root succeeded
pivot_root01.c:173: TPASS: pivot_root failed as expectedly: EBUSY (16)
pivot_root01.c:173: TPASS: pivot_root failed as expectedly: EINVAL (22)
pivot_root01.c:173: TPASS: pivot_root failed as expectedly: ENOTDIR (20)
pivot_root01.c:173: TPASS: pivot_root failed as expectedly: EPERM (1)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dprctl03 stime=3D1620367889
cmdline=3D"prctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
prctl03.c:73: TPASS: prctl(PR_SET_CHILD_SUBREAPER) succeeded
prctl03.c:46: TPASS: prctl(PR_GET_CHILD_SUBREAPER) got expected 0
prctl03.c:88: TPASS: PPID of orphaned process was reparented
prctl03.c:101: TPASS: wait() got orphaned process, pid 1099, status 0
prctl03.c:108: TPASS: received SIGCHLD from orphaned process
prctl03.c:46: TPASS: prctl(PR_GET_CHILD_SUBREAPER) got expected 1

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dprctl05 stime=3D1620367889
cmdline=3D"prctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est
prctl05.c:62: TPASS: /proc/self/task/1101/comm =3D 'prctl05_test'
prctl05.c:63: TPASS: /proc/self/comm =3D 'prctl05_test'
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test_xxxxx') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est_xx
prctl05.c:62: TPASS: /proc/self/task/1101/comm =3D 'prctl05_test_xx'
prctl05.c:63: TPASS: /proc/self/comm =3D 'prctl05_test_xx'

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpread02 stime=3D1620367889
cmdline=3D"pread02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pread02     1  TPASS  :  pread() fails, file descriptor is a PIPE or FIFO, =
errno:29
pread02     2  TPASS  :  pread() fails, specified offset is -ve or invalid,=
 errno:22
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpreadv01_64 stime=3D1620367889
cmdline=3D"preadv01_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
preadv01.c:81: TPASS: Preadv(2) read 64 bytes successfully with content 'a'=
 expectedly
preadv01.c:81: TPASS: Preadv(2) read 64 bytes successfully with content 'a'=
 expectedly
preadv01.c:81: TPASS: Preadv(2) read 32 bytes successfully with content 'b'=
 expectedly

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpreadv02_64 stime=3D1620367889
cmdline=3D"preadv02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
preadv02.c:89: TPASS: preadv() failed as expected: EINVAL (22)
preadv02.c:89: TPASS: preadv() failed as expected: EINVAL (22)
preadv02.c:89: TPASS: preadv() failed as expected: EINVAL (22)
preadv02.c:89: TPASS: preadv() failed as expected: EFAULT (14)
preadv02.c:89: TPASS: preadv() failed as expected: EBADF (9)
preadv02.c:89: TPASS: preadv() failed as expected: EBADF (9)
preadv02.c:89: TPASS: preadv() failed as expected: EISDIR (21)
preadv02.c:89: TPASS: preadv() failed as expected: ESPIPE (29)

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dprot_hsymlinks stime=3D1620367889
cmdline=3D"prot_hsymlinks"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
prot_hsymlinks    0  TINFO  :   --- HARDLINKS AND SYMLINKS RESTRICTIONS TES=
T ---
prot_hsymlinks    1  TPASS  :  Expect: can follow symlink '.../link_1', own=
er 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks    2  TPASS  :  Expect: can follow symlink '.../link_1', own=
er 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks    3  TPASS  :  Expect: can follow symlink '.../link_2', own=
er 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks    4  TPASS  :  Expect: can follow symlink '.../link_2', own=
er 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks    5  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_3', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks    6  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_3', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks    7  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_4', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks    8  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_4', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks    9  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_5', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   10  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_5', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   11  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_6', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   12  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_6', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   13  TPASS  :  Expect: can create hardlink '.../root.hs' to=
 '.../link_7', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   14  TPASS  :  Expect: can't create hardlink '.../root.hs' =
to '.../link_8', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   15  TPASS  :  Expect: can create hardlink '.../root.hs' to=
 '.../tmp_root/link_9', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   16  TPASS  :  Expect: can't create hardlink '.../root.hs' =
to '.../tmp_root/link_10', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   17  TPASS  :  Expect: can create hardlink '.../root.hs' to=
 '.../tmp_hsym/link_11', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   18  TPASS  :  Expect: can't create hardlink '.../root.hs' =
to '.../tmp_hsym/link_12', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   19  TPASS  :  Expect: can follow symlink '.../link_13', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   20  TPASS  :  Expect: can follow symlink '.../link_13', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   21  TPASS  :  Expect: can follow symlink '.../link_14', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   22  TPASS  :  Expect: can follow symlink '.../link_14', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   23  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_15', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   24  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_15', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   25  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_16', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   26  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_16', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   27  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_17', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   28  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_17', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   29  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_18', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   30  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_18', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   31  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../link_19', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   32  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../link_20', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks   33  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../tmp_root/link_21', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   34  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../tmp_root/link_22', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks   35  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../tmp_hsym/link_23', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   36  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../tmp_hsym/link_24', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks   37  TPASS  :  Expect: can follow symlink '.../link_25', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   38  TPASS  :  Expect: can follow symlink '.../link_25', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   39  TPASS  :  Expect: can follow symlink '.../link_26', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   40  TPASS  :  Expect: can follow symlink '.../link_26', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   41  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_27', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   42  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_27', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   43  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_28', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   44  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_28', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   45  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_29', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   46  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_29', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   47  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_30', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   48  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_30', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   49  TPASS  :  Expect: can follow symlink '.../link_31', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   50  TPASS  :  Expect: can follow symlink '.../link_31', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   51  TPASS  :  Expect: can follow symlink '.../link_32', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   52  TPASS  :  Expect: can follow symlink '.../link_32', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   53  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_33', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   54  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_33', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   55  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_34', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   56  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_34', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   57  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_35', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   58  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_35', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   59  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_36', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   60  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_36', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   61  TPASS  :  Expect: can create hardlink '.../root/local_=
root.hs' to '.../link_37', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   62  TPASS  :  Expect: can't create hardlink '.../root/loca=
l_root.hs' to '.../link_38', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   63  TPASS  :  Expect: can create hardlink '.../root/local_=
root.hs' to '.../tmp_root/link_39', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   64  TPASS  :  Expect: can't create hardlink '.../root/loca=
l_root.hs' to '.../tmp_root/link_40', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   65  TPASS  :  Expect: can create hardlink '.../root/local_=
root.hs' to '.../tmp_hsym/link_41', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   66  TPASS  :  Expect: can't create hardlink '.../root/loca=
l_root.hs' to '.../tmp_hsym/link_42', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   67  TPASS  :  Expect: can follow symlink '.../link_43', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   68  TPASS  :  Expect: can follow symlink '.../link_43', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   69  TPASS  :  Expect: can follow symlink '.../link_44', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   70  TPASS  :  Expect: can follow symlink '.../link_44', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   71  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_45', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   72  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_45', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   73  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_46', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   74  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_46', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   75  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_47', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   76  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_47', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   77  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_48', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   78  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_48', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   79  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs' to '.../link_49', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   80  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root.hs' to '.../link_50', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   81  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs' to '.../tmp_root/link_51', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   82  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root.hs' to '.../tmp_root/link_52', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   83  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs' to '.../tmp_hsym/link_53', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   84  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root.hs' to '.../tmp_hsym/link_54', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   85  TPASS  :  Expect: can follow symlink '.../link_55', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   86  TPASS  :  Expect: can follow symlink '.../link_55', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   87  TPASS  :  Expect: can follow symlink '.../link_56', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   88  TPASS  :  Expect: can follow symlink '.../link_56', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   89  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_57', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   90  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_57', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   91  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_58', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   92  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_58', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   93  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_59', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   94  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_59', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   95  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_60', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   96  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_60', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   97  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../link_61', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   98  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../link_62', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks   99  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../tmp_root/link_63', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  100  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../tmp_root/link_64', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks  101  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../tmp_hsym/link_65', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  102  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../tmp_hsym/link_66', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks  103  TPASS  :  Expect: can follow symlink '.../link_67', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  104  TPASS  :  Expect: can follow symlink '.../link_67', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  105  TPASS  :  Expect: can follow symlink '.../link_68', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  106  TPASS  :  Expect: can follow symlink '.../link_68', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  107  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_69', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  108  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_69', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  109  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_70', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  110  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_70', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  111  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_71', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  112  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_71', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  113  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_72', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  114  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_72', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  115  TPASS  :  Expect: can follow symlink '.../link_73', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  116  TPASS  :  Expect: can follow symlink '.../link_73', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  117  TPASS  :  Expect: can follow symlink '.../link_74', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  118  TPASS  :  Expect: can follow symlink '.../link_74', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  119  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_75', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  120  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_75', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  121  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_76', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  122  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_76', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  123  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_77', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  124  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_77', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  125  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_78', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  126  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_78', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  127  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot/local_root.hs' to '.../link_79', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  128  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root/local_root.hs' to '.../link_80', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks  129  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot/local_root.hs' to '.../tmp_root/link_81', owner 'root', curr.user 'root'=
, w(1)
prot_hsymlinks  130  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root/local_root.hs' to '.../tmp_root/link_82', owner 'root', curr.user 'hsy=
m', w(0)
prot_hsymlinks  131  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot/local_root.hs' to '.../tmp_hsym/link_83', owner 'root', curr.user 'root'=
, w(1)
prot_hsymlinks  132  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root/local_root.hs' to '.../tmp_hsym/link_84', owner 'root', curr.user 'hsy=
m', w(0)
prot_hsymlinks  133  TPASS  :  Expect: can follow symlink '.../link_85', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  134  TPASS  :  Expect: can follow symlink '.../link_85', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  135  TPASS  :  Expect: can follow symlink '.../link_86', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  136  TPASS  :  Expect: can follow symlink '.../link_86', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  137  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_87', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  138  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_87', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  139  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_88', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  140  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_88', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  141  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_89', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  142  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_89', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  143  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_90', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  144  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_90', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  145  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs' to '.../link_91', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  146  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root.hs' to '.../link_92', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks  147  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs' to '.../tmp_root/link_93', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  148  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root.hs' to '.../tmp_root/link_94', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks  149  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs' to '.../tmp_hsym/link_95', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  150  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root.hs' to '.../tmp_hsym/link_96', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks  151  TPASS  :  Expect: can follow symlink '.../link_97', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  152  TPASS  :  Expect: can follow symlink '.../link_97', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  153  TPASS  :  Expect: can follow symlink '.../link_98', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  154  TPASS  :  Expect: can follow symlink '.../link_98', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  155  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_99', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  156  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_99', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  157  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_100', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  158  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_100', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  159  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_101', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  160  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_101', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  161  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_102', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  162  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_102', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  163  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../link_103', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  164  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../link_104', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks  165  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../tmp_root/link_105', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  166  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../tmp_root/link_106', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks  167  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../tmp_hsym/link_107', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  168  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../tmp_hsym/link_108', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks  169  TPASS  :  Expect: can follow symlink '.../link_109', o=
wner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  170  TPASS  :  Expect: can follow symlink '.../link_109', o=
wner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  171  TPASS  :  Expect: can follow symlink '.../link_110', o=
wner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  172  TPASS  :  Expect: can follow symlink '.../link_110', o=
wner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  173  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_111', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  174  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_111', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  175  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_112', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  176  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_112', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  177  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_113', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  178  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_113', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  179  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_114', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  180  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_114', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  181  TPASS  :  Expect: can follow symlink '.../link_115', o=
wner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  182  TPASS  :  Expect: can follow symlink '.../link_115', o=
wner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  183  TPASS  :  Expect: can follow symlink '.../link_116', o=
wner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  184  TPASS  :  Expect: can follow symlink '.../link_116', o=
wner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  185  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_117', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  186  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_117', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  187  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_118', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  188  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_118', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  189  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_119', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  190  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_119', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  191  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_120', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  192  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_120', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  193  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot/local_root.hs' to '.../link_121', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  194  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root/local_root.hs' to '.../link_122', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks  195  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot/local_root.hs' to '.../tmp_root/link_123', owner 'root', curr.user 'root=
', w(1)
prot_hsymlinks  196  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root/local_root.hs' to '.../tmp_root/link_124', owner 'root', curr.user 'hs=
ym', w(0)
prot_hsymlinks  197  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot/local_root.hs' to '.../tmp_hsym/link_125', owner 'root', curr.user 'root=
', w(1)
prot_hsymlinks  198  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root/local_root.hs' to '.../tmp_hsym/link_126', owner 'root', curr.user 'hs=
ym', w(0)
prot_hsymlinks  199  TPASS  :  Expect: can follow symlink '.../link_127', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  200  TPASS  :  Expect: can follow symlink '.../link_127', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  201  TPASS  :  Expect: can follow symlink '.../link_128', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  202  TPASS  :  Expect: can follow symlink '.../link_128', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  203  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_129', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  204  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_129', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  205  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_130', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  206  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_130', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  207  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_131', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  208  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_131', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  209  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_132', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  210  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_132', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  211  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../link_133', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  212  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../link_134', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  213  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../tmp_root/link_135', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  214  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../tmp_root/link_136', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  215  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../tmp_hsym/link_137', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  216  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../tmp_hsym/link_138', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  217  TPASS  :  Expect: can follow symlink '.../link_139', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  218  TPASS  :  Expect: can follow symlink '.../link_139', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  219  TPASS  :  Expect: can follow symlink '.../link_140', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  220  TPASS  :  Expect: can follow symlink '.../link_140', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  221  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_141', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  222  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_141', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  223  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_142', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  224  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_142', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  225  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_143', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  226  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_143', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  227  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_144', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  228  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_144', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  229  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../link_145', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  230  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../link_146', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  231  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../tmp_root/link_147', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  232  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../tmp_root/link_148', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  233  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../tmp_hsym/link_149', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  234  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../tmp_hsym/link_150', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  235  TPASS  :  Expect: can follow symlink '.../link_151', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  236  TPASS  :  Expect: can follow symlink '.../link_151', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  237  TPASS  :  Expect: can follow symlink '.../link_152', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  238  TPASS  :  Expect: can follow symlink '.../link_152', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  239  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_153', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  240  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_153', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  241  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_154', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  242  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_154', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  243  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_155', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  244  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_155', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  245  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_156', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  246  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_156', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  247  TPASS  :  Expect: can follow symlink '.../link_157', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  248  TPASS  :  Expect: can follow symlink '.../link_157', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  249  TPASS  :  Expect: can follow symlink '.../link_158', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  250  TPASS  :  Expect: can follow symlink '.../link_158', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  251  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_159', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  252  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_159', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  253  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_160', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  254  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_160', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  255  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_161', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  256  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_161', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  257  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_162', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  258  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_162', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  259  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../link_163', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  260  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../link_164', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  261  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../tmp_root/link_165', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  262  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../tmp_root/link_166', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  263  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../tmp_hsym/link_167', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  264  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../tmp_hsym/link_168', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  265  TPASS  :  Expect: can follow symlink '.../link_169', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  266  TPASS  :  Expect: can follow symlink '.../link_169', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  267  TPASS  :  Expect: can follow symlink '.../link_170', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  268  TPASS  :  Expect: can follow symlink '.../link_170', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  269  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_171', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  270  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_171', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  271  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_172', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  272  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_172', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  273  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_173', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  274  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_173', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  275  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_174', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  276  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_174', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  277  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../link_175', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  278  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../link_176', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  279  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../tmp_root/link_177', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  280  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../tmp_root/link_178', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  281  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../tmp_hsym/link_179', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  282  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../tmp_hsym/link_180', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  283  TPASS  :  Expect: can follow symlink '.../link_181', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  284  TPASS  :  Expect: can follow symlink '.../link_181', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  285  TPASS  :  Expect: can follow symlink '.../link_182', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  286  TPASS  :  Expect: can follow symlink '.../link_182', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  287  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_183', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  288  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_183', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  289  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_184', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  290  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_184', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  291  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_185', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  292  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_185', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  293  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_186', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  294  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_186', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  295  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../link_187', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  296  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../link_188', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  297  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../tmp_root/link_189', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  298  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../tmp_root/link_190', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  299  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../tmp_hsym/link_191', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  300  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../tmp_hsym/link_192', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  301  TPASS  :  Expect: can follow symlink '.../link_193', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  302  TPASS  :  Expect: can follow symlink '.../link_193', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  303  TPASS  :  Expect: can follow symlink '.../link_194', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  304  TPASS  :  Expect: can follow symlink '.../link_194', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  305  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_195', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  306  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_195', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  307  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_196', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  308  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_196', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  309  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_197', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  310  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_197', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  311  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_198', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  312  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_198', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  313  TPASS  :  Expect: can follow symlink '.../link_199', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  314  TPASS  :  Expect: can follow symlink '.../link_199', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  315  TPASS  :  Expect: can follow symlink '.../link_200', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  316  TPASS  :  Expect: can follow symlink '.../link_200', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  317  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_201', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  318  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_201', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  319  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_202', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  320  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_202', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  321  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_203', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  322  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_203', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  323  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_204', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  324  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_204', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  325  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../link_205', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  326  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../link_206', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  327  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../tmp_root/link_207', owner 'hsym', curr.user 'root=
', w(1)
prot_hsymlinks  328  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../tmp_root/link_208', owner 'hsym', curr.user 'hsym=
', w(1)
prot_hsymlinks  329  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../tmp_hsym/link_209', owner 'hsym', curr.user 'root=
', w(1)
prot_hsymlinks  330  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../tmp_hsym/link_210', owner 'hsym', curr.user 'hsym=
', w(1)
prot_hsymlinks  331  TPASS  :  Expect: can follow symlink '.../link_211', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  332  TPASS  :  Expect: can follow symlink '.../link_211', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  333  TPASS  :  Expect: can follow symlink '.../link_212', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  334  TPASS  :  Expect: can follow symlink '.../link_212', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  335  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_213', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  336  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_213', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  337  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_214', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  338  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_214', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  339  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_215', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  340  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_215', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  341  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_216', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  342  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_216', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  343  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../link_217', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  344  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../link_218', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  345  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../tmp_root/link_219', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  346  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../tmp_root/link_220', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  347  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../tmp_hsym/link_221', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  348  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../tmp_hsym/link_222', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  349  TPASS  :  Expect: can follow symlink '.../link_223', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  350  TPASS  :  Expect: can follow symlink '.../link_223', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  351  TPASS  :  Expect: can follow symlink '.../link_224', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  352  TPASS  :  Expect: can follow symlink '.../link_224', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  353  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_225', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  354  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_225', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  355  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_226', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  356  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_226', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  357  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_227', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  358  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_227', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  359  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_228', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  360  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_228', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  361  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../link_229', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  362  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../link_230', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  363  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../tmp_root/link_231', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  364  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../tmp_root/link_232', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  365  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../tmp_hsym/link_233', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  366  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../tmp_hsym/link_234', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  367  TPASS  :  Expect: can follow symlink '.../link_235', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  368  TPASS  :  Expect: can follow symlink '.../link_235', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  369  TPASS  :  Expect: can follow symlink '.../link_236', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  370  TPASS  :  Expect: can follow symlink '.../link_236', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  371  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_237', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  372  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_237', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  373  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_238', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  374  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_238', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  375  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_239', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  376  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_239', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  377  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_240', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  378  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_240', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  379  TPASS  :  Expect: can follow symlink '.../link_241', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  380  TPASS  :  Expect: can follow symlink '.../link_241', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  381  TPASS  :  Expect: can follow symlink '.../link_242', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  382  TPASS  :  Expect: can follow symlink '.../link_242', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  383  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_243', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  384  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_243', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  385  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_244', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  386  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_244', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  387  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_245', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  388  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_245', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  389  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_246', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  390  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_246', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  391  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym/local_hsym.hs' to '.../link_247', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  392  TPASS  :  Expect: can create huserdel: hsym mail spool=
 (/var/mail/hsym) not found
userdel: hsym home directory (/home/hsym) not found
ardlink '.../tmp_hsym/hsym/local_hsym.hs' to '.../link_248', owner 'hsym', =
curr.user 'hsym', w(1)
prot_hsymlinks  393  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym/local_hsym.hs' to '.../tmp_root/link_249', owner 'hsym', curr.user 'root=
', w(1)
prot_hsymlinks  394  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym/local_hsym.hs' to '.../tmp_root/link_250', owner 'hsym', curr.user 'hsym=
', w(1)
prot_hsymlinks  395  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym/local_hsym.hs' to '.../tmp_hsym/link_251', owner 'hsym', curr.user 'root=
', w(1)
prot_hsymlinks  396  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym/local_hsym.hs' to '.../tmp_hsym/link_252', owner 'hsym', curr.user 'hsym=
', w(1)
prot_hsymlinks    0  TINFO  :  All test-cases have been completed, summary:=
 - symlinks  test:	PASS - hardlinks test:	PASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace08 stime=3D1620367889
cmdline=3D"ptrace08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_kernel.c:83: TINFO: uname.machine=3Dx86_64 kernel is 64bit
ptrace08.c:99: TINFO: Trying address 0xffff800000000000
ptrace08.c:129: TPASS: ptrace() breakpoint with kernel addr failed: EINVAL =
(22)
ptrace08.c:99: TINFO: Trying address 0xffffffffffffffff
ptrace08.c:129: TPASS: ptrace() breakpoint with kernel addr failed: EINVAL =
(22)
ptrace08.c:99: TINFO: Trying address 0xffffbfffffffffff
ptrace08.c:129: TPASS: ptrace() breakpoint with kernel addr failed: EINVAL =
(22)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev01 stime=3D1620367889
cmdline=3D"pwritev01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev01_64 stime=3D1620367889
cmdline=3D"pwritev01_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dquotactl03 stime=3D1620367889
cmdline=3D"quotactl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
quotactl03.c:64: TPASS: quotactl() failed with ENOENT as expected

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dreadlink01A stime=3D1620367889
cmdline=3D"symlink01 -T readlink01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
readlink01    1  TPASS  :  Reading of symbolic link file contents checks ou=
t ok
readlink01    2  TPASS  :  Reading of symbolic link file contents checks ou=
t ok
readlink01    3  TPASS  :  Reading a symbolic link which exceeds maximum pa=
thname error is caught
readlink01    4  TPASS  :  Reading a nonsymbolic link file error condition =
is caught.  EINVAL is returned
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreboot02 stime=3D1620367889
cmdline=3D"reboot02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
reboot02.c:49: TPASS: INVALID_PARAMETER: EINVAL (22)
reboot02.c:55: TPASS: LINUX_REBOOT_CMD_CAD_ON: EPERM (1)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dremap_file_pages01 stime=3D1620367889
cmdline=3D"remap_file_pages01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
remap_file_pages01    1  TPASS  :  Non-Linear shm file OK
remap_file_pages01    2  TPASS  :  Non-Linear /tmp/ file OK
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dremap_file_pages02 stime=3D1620367889
cmdline=3D"remap_file_pages02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
remap_file_pages02.c:86: TPASS: remap_file_pages(2) start is not valid MAP_=
SHARED mapping: EINVAL (22)
remap_file_pages02.c:86: TPASS: remap_file_pages(2) start is invalid: EINVA=
L (22)
remap_file_pages02.c:86: TPASS: remap_file_pages(2) size is invalid: EINVAL=
 (22)
remap_file_pages02.c:86: TPASS: remap_file_pages(2) prot is invalid: EINVAL=
 (22)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drename04 stime=3D1620367889
cmdline=3D"rename04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
rename04    1  TPASS  :  rename() returned ENOTEMPTY
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drenameat201 stime=3D1620367889
cmdline=3D"renameat201"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
renameat201    1  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DEEXIST(17): File exists
renameat201    2  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DSUCCESS(0): Success
renameat201    3  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DENOENT(2): No such file or directory
renameat201    4  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DSUCCESS(0): Success
renameat201    5  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DEINVAL(22): Invalid argument
renameat201    6  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DEINVAL(22): Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drmdir02 stime=3D1620367889
cmdline=3D"rmdir02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
rmdir02.c:92: TPASS: rmdir() failed as expected: ENOTEMPTY (39)
rmdir02.c:92: TPASS: rmdir() failed as expected: ENAMETOOLONG (36)
rmdir02.c:92: TPASS: rmdir() failed as expected: ENOENT (2)
rmdir02.c:92: TPASS: rmdir() failed as expected: ENOTDIR (20)
rmdir02.c:92: TPASS: rmdir() failed as expected: EFAULT (14)
rmdir02.c:92: TPASS: rmdir() failed as expected: ELOOP (40)
rmdir02.c:92: TPASS: rmdir() failed as expected: EROFS (30)
rmdir02.c:92: TPASS: rmdir() failed as expected: EBUSY (16)
rmdir02.c:92: TPASS: rmdir() failed as expected: EINVAL (22)

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drt_tgsigqueueinfo01 stime=3D1620367889
cmdline=3D"rt_tgsigqueueinfo01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
rt_tgsigqueueinfo01.c:65: TPASS: Test signal to self succeeded
rt_tgsigqueueinfo01.c:96: TPASS: Test signal to different thread succeeded
rt_tgsigqueueinfo01.c:96: TPASS: Test signal to different thread succeeded

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_rr_get_interval02 stime=3D1620367889
cmdline=3D"sched_rr_get_interval02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
sched_rr_get_interval02.c:34: TINFO: Testing variant: vDSO or syscall with =
libc spec
sched_rr_get_interval02.c:52: TPASS: sched_rr_get_interval() passed
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
sched_rr_get_interval02.c:34: TINFO: Testing variant: syscall with old kern=
el spec
sched_rr_get_interval02.c:52: TPASS: sched_rr_get_interval() passed

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setparam02 stime=3D1620367890
cmdline=3D"sched_setparam02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_setparam02    1  TPASS  :  Test with policy SCHED_FIFO Passed
sched_setparam02    2  TPASS  :  Test with policy SCHED_RR Passed
sched_setparam02    3  TPASS  :  Test with SCHED_OTHER Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setscheduler02 stime=3D1620367890
cmdline=3D"sched_setscheduler02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_setscheduler02    1  TPASS  :  got EPERM
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setaffinity01 stime=3D1620367890
cmdline=3D"sched_setaffinity01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: EFAULT (14)
sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: EINVAL (22)
sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: ESRCH (3)
sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: EPERM (1)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_getaffinity01 stime=3D1620367890
cmdline=3D"sched_getaffinity01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
sched_getaffinity01.c:88: TINFO: system has 4 processor(s).
sched_getaffinity01.c:76: TPASS: cpuset size =3D 128, enabled cpus 4
sched_getaffinity01.c:39: TPASS: sched_getaffinity() failed: EFAULT (14)
sched_getaffinity01.c:39: TPASS: sched_getaffinity() failed: EINVAL (22)
sched_getaffinity01.c:39: TPASS: sched_getaffinity() failed: ESRCH (3)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dselect03 stime=3D1620367890
cmdline=3D"select03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
select_var.h:109: TINFO: Testing libc select()
select03.c:65: TPASS: Negative nfds: select() failed as expected: EINVAL (2=
2)
select03.c:65: TPASS: Invalid readfds: select() failed as expected: EBADF (=
9)
select03.c:65: TPASS: Invalid writefds: select() failed as expected: EBADF =
(9)
select03.c:65: TPASS: Invalid exceptfds: select() failed as expected: EBADF=
 (9)
select03.c:65: TPASS: Faulty readfds: select() failed as expected: EFAULT (=
14)
select03.c:65: TPASS: Faulty writefds: select() failed as expected: EFAULT =
(14)
select03.c:65: TPASS: Faulty exceptfds: select() failed as expected: EFAULT=
 (14)
select03.c:65: TPASS: Faulty timeout: select() failed as expected: EFAULT (=
14)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
select_var.h:112: TINFO: Testing SYS_select syscall
select03.c:65: TPASS: Negative nfds: select() failed as expected: EINVAL (2=
2)
select03.c:65: TPASS: Invalid readfds: select() failed as expected: EBADF (=
9)
select03.c:65: TPASS: Invalid writefds: select() failed as expected: EBADF =
(9)
select03.c:65: TPASS: Invalid exceptfds: select() failed as expected: EBADF=
 (9)
select03.c:65: TPASS: Faulty readfds: select() failed as expected: EFAULT (=
14)
select03.c:65: TPASS: Faulty writefds: select() failed as expected: EFAULT =
(14)
select03.c:65: TPASS: Faulty exceptfds: select() failed as expected: EFAULT=
 (14)
select03.c:65: TPASS: Faulty timeout: select() failed as expected: EFAULT (=
14)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
select_var.h:115: TINFO: Testing SYS_pselect6 syscall
select03.c:65: TPASS: Negative nfds: select() failed as expected: EINVAL (2=
2)
select03.c:65: TPASS: Invalid readfds: select() failed as expected: EBADF (=
9)
select03.c:65: TPASS: Invalid writefds: select() failed as expected: EBADF =
(9)
select03.c:65: TPASS: Invalid exceptfds: select() failed as expected: EBADF=
 (9)
select03.c:65: TPASS: Faulty readfds: select() failed as expected: EFAULT (=
14)
select03.c:65: TPASS: Faulty writefds: select() failed as expected: EFAULT =
(14)
select03.c:65: TPASS: Faulty exceptfds: select() failed as expected: EFAULT=
 (14)
select03.c:65: TPASS: Faulty timeout: select() failed as expected: EFAULT (=
14)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
select_var.h:118: TINFO: Testing SYS_pselect6 time64 syscall
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
select_var.h:121: TINFO: Testing SYS__newselect syscall
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported

Summary:
passed   24
failed   0
broken   0
skipped  16
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemctl05 stime=3D1620367890
cmdline=3D"semctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
semctl05.c:45: TPASS: semctl() with the value to set is less than zero: ERA=
NGE (34)
semctl05.c:45: TPASS: semctl() with the value to set are too large: ERANGE =
(34)
semctl05.c:45: TPASS: semctl() with the value to set is too large: ERANGE (=
34)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile02 stime=3D1620367890
cmdline=3D"sendfile02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile02    1  TPASS  :  functionality of sendfile() is correct
sendfile02    2  TPASS  :  functionality of sendfile() is correct
sendfile02    3  TPASS  :  functionality of sendfile() is correct
sendfile02    4  TPASS  :  functionality of sendfile() is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile09_64 stime=3D1620367890
cmdline=3D"sendfile09_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile09_64    1  TPASS  :  Test sendfile(2) with offset at 0
sendfile09_64    2  TPASS  :  Test sendfile(2) with offset at 3GB
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D113
<<<test_end>>>
<<<test_start>>>
tag=3Dsendmsg03 stime=3D1620367891
cmdline=3D"sendmsg03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:522: TINFO: Minimum sampling period =
ended
=2E./../../../include/tst_fuzzy_sync.h:346: TINFO: loop =3D 1024, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg=
 =3D   -37ns, avg_dev =3D    12ns, dev_ratio =3D 0.32 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D  1845ns, avg_dev =3D   205ns, dev_ratio =3D 0.11 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D   797ns, avg_dev =3D   163ns, dev_ratio =3D 0.20 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D  1011ns, avg_dev =3D   154ns, dev_ratio =3D 0.15 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   645  , avg_dev =3D    98  , dev_ratio =3D 0.15 }
=2E./../../../include/tst_fuzzy_sync.h:534: TINFO: Reached deviation ratios=
 < 0.10, introducing randomness
=2E./../../../include/tst_fuzzy_sync.h:537: TINFO: Delay range is [-487, 94=
8]
=2E./../../../include/tst_fuzzy_sync.h:346: TINFO: loop =3D 1050, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg=
 =3D   -53ns, avg_dev =3D     5ns, dev_ratio =3D 0.09 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D  1519ns, avg_dev =3D    82ns, dev_ratio =3D 0.05 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D   782ns, avg_dev =3D    59ns, dev_ratio =3D 0.08 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D   685ns, avg_dev =3D    39ns, dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   428  , avg_dev =3D    26  , dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops=
, requesting exit
sendmsg03.c:100: TPASS: Nothing bad happened, probably

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D111 cstime=3D51
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsgid01 stime=3D1620367892
cmdline=3D"setfsgid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsgid01    1  TPASS  :  setfsgid() returned expected value : 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsgid01_16 stime=3D1620367892
cmdline=3D"setfsgid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsgid01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setfsgid/../utils/compat_16.h:122: 16-bit version of setfsgid() is not su=
pported on your platform
setfsgid01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setfsgid/../utils/compat_16.h:122: Remaining cases not appropriate for co=
nfiguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsuid04_16 stime=3D1620367892
cmdline=3D"setfsuid04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsuid04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setfsuid/../utils/compat_16.h:117: 16-bit version of setfsuid() is not su=
pported on your platform
setfsuid04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setfsuid/../utils/compat_16.h:117: Remaining cases not appropriate for co=
nfiguration
setfsuid04_16    0  TINFO  :  Child process returned TCONF
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgid03_16 stime=3D1620367892
cmdline=3D"setgid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/setgid/../utils/compat_tst_1=
6.h:94: TCONF: 16-bit version of setgid() is not supported on your platform

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetregid01_16 stime=3D1620367892
cmdline=3D"setregid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/setregid/../utils/compat_tst=
_16.h:128: TCONF: 16-bit version of setregid() is not supported on your pla=
tform

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresgid03_16 stime=3D1620367892
cmdline=3D"setresgid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresgid03_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresgid/../utils/compat_16.h:146: 16-bit version of setresgid() is not=
 supported on your platform
setresgid03_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresgid/../utils/compat_16.h:146: Remaining cases not appropriate for =
configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresuid03 stime=3D1620367892
cmdline=3D"setresuid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresuid03    1  TPASS  :  setresuid(65534, -1, -1) failed as expected.
setresuid03    0  TINFO  :  real uid =3D 0, effective uid =3D 2, and saved =
uid =3D 2 as expected
setresuid03    2  TPASS  :  setresuid(-1, -1, 65534) failed as expected.
setresuid03    0  TINFO  :  real uid =3D 0, effective uid =3D 2, and saved =
uid =3D 2 as expected
setresuid03    3  TPASS  :  setresuid(-1, 65534, -1) failed as expected.
setresuid03    0  TINFO  :  real uid =3D 0, effective uid =3D 2, and saved =
uid =3D 2 as expected
setresuid03    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresuid03_16 stime=3D1620367892
cmdline=3D"setresuid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresuid03_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresuid/../utils/compat_16.h:136: 16-bit version of setresuid() is not=
 supported on your platform
setresuid03_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresuid/../utils/compat_16.h:136: Remaining cases not appropriate for =
configuration
setresuid03_16    0  TINFO  :  Child process returned TCONF
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresuid05 stime=3D1620367892
cmdline=3D"setresuid05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresuid05    1  TPASS  :  setresuid succeeded as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetreuid01 stime=3D1620367892
cmdline=3D"setreuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setreuid01    1  TPASS  :  setreuid -  Don't change either real or effectiv=
e uid returned 0
setreuid01    2  TPASS  :  setreuid -  change effective to effective uid re=
turned 0
setreuid01    3  TPASS  :  setreuid -  change real to real uid returned 0
setreuid01    4  TPASS  :  setreuid -  change effective to real uid returne=
d 0
setreuid01    5  TPASS  :  setreuid -  try to change real to current real r=
eturned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetreuid04_16 stime=3D1620367892
cmdline=3D"setreuid04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setreuid04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setreuid/../utils/compat_16.h:127: 16-bit version of setreuid() is not su=
pported on your platform
setreuid04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setreuid/../utils/compat_16.h:127: Remaining cases not appropriate for co=
nfiguration
setreuid04_16    0  TINFO  :  Child process returned TCONF
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetsockopt07 stime=3D1620367892
cmdline=3D"setsockopt07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops=
, requesting exit
setsockopt07.c:120: TPASS: Cannot reproduce bug

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D19 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1289 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsetxattr03 stime=3D1620367911
cmdline=3D"setxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
setxattr03.c:98: TPASS: Set attr to immutable file: EPERM (1)
setxattr03.c:98: TPASS: Set attr to append-only file: EPERM (1)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmat01 stime=3D1620367911
cmdline=3D"shmat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
shmat01.c:124: TPASS: shmat() succeeded to attach NULL address
shmat01.c:124: TPASS: shmat() succeeded to attach aligned address
shmat01.c:124: TPASS: shmat() succeeded to attach unaligned address with SH=
M_RND
tst_coredump.c:32: TINFO: Avoid dumping corefile for process(pid=3D1327)
shmat01.c:124: TPASS: shmat() succeeded to attach aligned address with SHM_=
READONLY, and got SIGSEGV on write

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dshmctl04 stime=3D1620367911
cmdline=3D"shmctl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
shmctl04.c:119: TINFO: Test SHM_STAT_ANY with nobody user
shmctl04.c:137: TPASS: SHM_INFO returned valid index 3 maps to shmid 3
shmctl04.c:146: TPASS: Counted used =3D 2
shmctl04.c:85: TPASS: used_ids =3D 2
shmctl04.c:92: TPASS: shm_rss =3D 1007
shmctl04.c:99: TPASS: shm_swp =3D 0
shmctl04.c:106: TPASS: shm_tot =3D 1008
shmctl04.c:119: TINFO: Test SHM_STAT_ANY with root user
shmctl04.c:137: TPASS: SHM_INFO returned valid index 3 maps to shmid 3
shmctl04.c:146: TPASS: Counted used =3D 2
shmctl04.c:85: TPASS: used_ids =3D 2
shmctl04.c:92: TPASS: shm_rss =3D 1007
shmctl04.c:99: TPASS: shm_swp =3D 0
shmctl04.c:106: TPASS: shm_tot =3D 1008

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmget01 stime=3D1620367911
cmdline=3D"shmget01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
shmget01    1  TPASS  :  size, pid & mode are correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsigaltstack01 stime=3D1620367911
cmdline=3D"sigaltstack01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sigaltstack01    1  TPASS  :  Functionality of sigaltstack() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsighold02 stime=3D1620367911
cmdline=3D"sighold02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sighold02    1  TPASS  :  All signals were hold
sighold02    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsignal01 stime=3D1620367911
cmdline=3D"signal01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal01    1  TPASS  :  signal(SIGKILL, 0x1(SIG_IGN)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, (nil)(SIG_DFL)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, 0x55ee69fa1f60(catchsig())) failed=
 with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  Child killed with SIGKILL
signal01    2  TPASS  :  Child killed with SIGKILL
signal01    3  TPASS  :  Child killed with SIGKILL
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsocketcall03 stime=3D1620367911
cmdline=3D"socketcall03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
socketcall03.c:32: TCONF: syscall(-1) __NR_socketcall not supported

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstat02 stime=3D1620367911
cmdline=3D"stat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
stat02.c:67: TPASS: File size reported as expected
stat02.c:67: TPASS: File size reported as expected

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstat02_64 stime=3D1620367911
cmdline=3D"stat02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
stat02.c:67: TPASS: File size reported as expected
stat02.c:67: TPASS: File size reported as expected

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstat03 stime=3D1620367911
cmdline=3D"stat03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
stat03.c:55: TPASS: stat() failed as expected: EACCES (13)
stat03.c:55: TPASS: stat() failed as expected: EFAULT (14)
stat03.c:55: TPASS: stat() failed as expected: ENAMETOOLONG (36)
stat03.c:55: TPASS: stat() failed as expected: ENOENT (2)
stat03.c:55: TPASS: stat() failed as expected: ENOTDIR (20)
stat03.c:55: TPASS: stat() failed as expected: ELOOP (40)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatfs01 stime=3D1620367911
cmdline=3D"statfs01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs01    1  TPASS  :  statfs(tfile_1349, ..) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dstatvfs02 stime=3D1620367911
cmdline=3D"statvfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statvfs02    1  TPASS  :  statvfs() failed as expected: TEST_ERRNO=3DEFAULT=
(14): Bad address
statvfs02    2  TPASS  :  statvfs() failed as expected: TEST_ERRNO=3DELOOP(=
40): Too many levels of symbolic links
statvfs02    3  TPASS  :  statvfs() failed as expected: TEST_ERRNO=3DENAMET=
OOLONG(36): File name too long
statvfs02    4  TPASS  :  statvfs() failed as expected: TEST_ERRNO=3DENOENT=
(2): No such file or directory
statvfs02    5  TPASS  :  statvfs() failed as expected: TEST_ERRNO=3DENOTDI=
R(20): Not a directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dswapon03 stime=3D1620367911
cmdline=3D"swapon03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_ioctl.c:30: TINFO: FIBMAP ioctl is supported
libswap.c:59: TFAIL: swapon on f2fs failed: EINVAL (22)

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsync_file_range01 stime=3D1620367911
cmdline=3D"sync_file_range01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sync_file_range01    1  TPASS  :  got expected error: TEST_ERRNO=3DEBADF(9)=
: Bad file descriptor
sync_file_range01    2  TPASS  :  got expected error: TEST_ERRNO=3DESPIPE(2=
9): Illegal seek
sync_file_range01    3  TPASS  :  got expected error: TEST_ERRNO=3DEINVAL(2=
2): Invalid argument
sync_file_range01    4  TPASS  :  got expected error: TEST_ERRNO=3DEINVAL(2=
2): Invalid argument
sync_file_range01    5  TPASS  :  got expected error: TEST_ERRNO=3DEINVAL(2=
2): Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsysfs02 stime=3D1620367911
cmdline=3D"sysfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sysfs02     1  TPASS  :  sysfs(2) Passed for option 2
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsysfs04 stime=3D1620367911
cmdline=3D"sysfs04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sysfs04     1  TPASS  :  sysfs(2) expected failure; Got errno - EINVAL : In=
valid option
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog01 stime=3D1620367911
cmdline=3D"syslog01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog01    0  TINFO  :  Send messages to syslogd at some level=20
syslog01    0  TINFO  :  and facility and grep for those messages.
syslog01    0  TINFO  :  testing whether messages are logged into log file
syslog01    0  TINFO  :  restarting syslog daemon
syslog01    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D7 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog09 stime=3D1620367918
cmdline=3D"syslog09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog09    0  TINFO  :   Test setlogmask() with LOG_UPTO macro.
syslog09    0  TINFO  :   o Use setlogmask() with LOG_UPTO macro to set som=
e priority
syslog09    0  TINFO  :     level.
syslog09    0  TINFO  :   o Send message which is lower priority than the o=
ne
syslog09    0  TINFO  :     set above, which should not be logged
syslog09    0  TINFO  :  syslog: Testing setlogmask() with LOG_UPTO macro
syslog09    0  TINFO  :  restarting syslog daemon
syslog09    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dtimes03 stime=3D1620367924
cmdline=3D"times03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
times03.c:89: TPASS: buf1.tms_utime <=3D 5
times03.c:94: TPASS: buf1.tms_stime <=3D 5
times03.c:105: TPASS: buf2.tms_utime =3D 249
times03.c:112: TPASS: buf1.tms_utime (0) < buf2.tms_utime (249)
times03.c:118: TPASS: buf2.tms_stime =3D 141
times03.c:125: TPASS: buf1.tms_stime (0) < buf2.tms_stime (141)
times03.c:131: TPASS: buf2.tms_cutime =3D 0
times03.c:136: TPASS: buf2.tms_cstime =3D 0
times03.c:156: TPASS: buf2.tms_utime (249) <=3D buf3.tms_utime (249)
times03.c:164: TPASS: buf2.tms_stime (141) <=3D buf3.tms_stime (141)
times03.c:170: TPASS: buf3.tms_cutime =3D 262
times03.c:175: TPASS: buf3.tms_cstime =3D 137

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D8 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D512 cstime=3D279
<<<test_end>>>
<<<test_start>>>
tag=3Dtimer_getoverrun01 stime=3D1620367932
cmdline=3D"timer_getoverrun01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
timer_getoverrun01    1  TPASS  :  timer_getoverrun(CLOCK_REALTIME) Passed
timer_getoverrun01    2  TPASS  :  timer_gettime(-1) Failed: EINVAL
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dtkill02 stime=3D1620367932
cmdline=3D"tkill02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tkill02.c:48: TPASS: tst_syscall(__NR_tkill) expecting EINVAL: EINVAL (22)
tkill02.c:48: TPASS: tst_syscall(__NR_tkill) expecting ESRCH: ESRCH (3)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dtruncate03 stime=3D1620367932
cmdline=3D"truncate03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
truncate03.c:132: TPASS: truncate() failed as expected: EACCES (13)
truncate03.c:132: TPASS: truncate() failed as expected: ENOTDIR (20)
truncate03.c:132: TPASS: truncate() failed as expected: EFAULT (14)
truncate03.c:132: TPASS: truncate() failed as expected: ENAMETOOLONG (36)
truncate03.c:132: TPASS: truncate() failed as expected: ENOENT (2)
truncate03.c:132: TPASS: truncate() failed as expected: EISDIR (21)
truncate03.c:132: TPASS: truncate() failed as expected: EFBIG (27)
truncate03.c:132: TPASS: truncate() failed as expected: ELOOP (40)

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dumask01 stime=3D1620367932
cmdline=3D"umask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
umask01.c:57: TPASS: All files created with correct mode

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dunlink05 stime=3D1620367932
cmdline=3D"unlink05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
unlink05.c:61: TPASS: unlink(file) succeeded
unlink05.c:61: TPASS: unlink(fifo) succeeded

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dumount2_02 stime=3D1620367932
cmdline=3D"umount2_02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
umount2_02    0  TINFO  :  Found free device 0 '/dev/loop0'
umount2_02    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra =
opts=3D''
umount2_02    1  TPASS  :  umount2(2) failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
umount2_02    2  TPASS  :  umount2(2) failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
umount2_02    3  TPASS  :  umount2(2) failed as expected: TEST_ERRNO=3DEAGA=
IN/EWOULDBLOCK(11): Resource temporarily unavailable
umount2_02    4  TPASS  :  umount2(2) failed as expected: TEST_ERRNO=3DEAGA=
IN/EWOULDBLOCK(11): Resource temporarily unavailable
umount2_02    5  TPASS  :  umount2(2) succeeded as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dustat01 stime=3D1620367932
cmdline=3D"ustat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
ustat01.c:31: TPASS: ustat(2) passed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dutime01A stime=3D1620367932
cmdline=3D"symlink01 -T utime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
utime01     1  TPASS  :  utime(2) change of object file access and modify t=
imes through symbolic link file is ok
utime01     2  TPASS  :  utime(2) error when accessing non-existent object =
through symbolic link is caught
utime01     3  TPASS  :  Nested symbolic link access condition caught.  ELO=
OP is returned
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dvmsplice01 stime=3D1620367932
cmdline=3D"vmsplice01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_test.c:1063: TINFO: f2fs is supported by the test
vmsplice01.c:45: TPASS: Written data has been read back correctly

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid03 stime=3D1620367932
cmdline=3D"waitpid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitpid03    1  TPASS  :  Got correct child PID
waitpid03    2  TPASS  :  Condition 2 test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid04 stime=3D1620367932
cmdline=3D"waitpid04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitpid04    1  TPASS  :  condition 1 test passed
waitpid04    2  TPASS  :  condition 2 test passed
waitpid04    3  TPASS  :  condition 3 test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitid02 stime=3D1620367932
cmdline=3D"waitid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(2, 1548, 0x7fffe02d2d60, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1550 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(2, 1548, 0x7fffe02d2d60, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1550 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(1, 1551, 0x7fffe02d2d60, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1551 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(2, 1548, 0x7fffe02d2d60, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1550 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(1, 1551, 0x7fffe02d2d60, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1551 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1548) waitid(1, 1552, 0x7fffe02d2d60, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1552 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(2, 1548, 0x7fffe02d2d60, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1550 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(1, 1551, 0x7fffe02d2d60, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1551 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1548) waitid(1, 1552, 0x7fffe02d2d60, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1552 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1548) waitid(1, 1553, 0x7fffe02d2d60, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1553 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(2, 1548, 0x7fffe02d2d60, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1550 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(1, 1551, 0x7fffe02d2d60, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1551 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1548) waitid(1, 1552, 0x7fffe02d2d60, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1552 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1548) waitid(1, 1553, 0x7fffe02d2d60, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1553 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  P_PID, WEXITED not a child of the calling process
waitid02    0  TINFO  :  (1548) waitid(1, 1, 0x7fffe02d2d60, 4)
waitid02    8  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite02 stime=3D1620367932
cmdline=3D"write02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
write02.c:25: TPASS: write(fd, NULL, 0) =3D=3D 0

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite04 stime=3D1620367932
cmdline=3D"write04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
write04.c:46: TPASS: write() failed expectedly: EAGAIN/EWOULDBLOCK (11)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwritev01 stime=3D1620367932
cmdline=3D"writev01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
writev01.c:127: TPASS: invalid iov_len, expected: -1 (EINVAL), got: -1 (EIN=
VAL)
writev01.c:127: TPASS: invalid fd, expected: -1 (EBADF), got: -1 (EBADF)
writev01.c:127: TPASS: invalid iovcnt, expected: -1 (EINVAL), got: -1 (EINV=
AL)
writev01.c:131: TPASS: zero iovcnt, expected: 0, got: 0
writev01.c:131: TPASS: NULL and zero length iovec, expected: 64, got: 64
writev01.c:127: TPASS: write to closed pipe, expected: -1 (EPIPE), got: -1 =
(EPIPE)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfutex_cmp_requeue02 stime=3D1620367932
cmdline=3D"futex_cmp_requeue02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
futex_cmp_requeue02.c:71: TINFO: Testing variant: syscall with old kernel s=
pec
futex_cmp_requeue02.c:64: TPASS: futex_cmp_requeue() failed as expected: EI=
NVAL (22)
futex_cmp_requeue02.c:64: TPASS: futex_cmp_requeue() failed as expected: EI=
NVAL (22)
futex_cmp_requeue02.c:64: TPASS: futex_cmp_requeue() failed as expected: EA=
GAIN/EWOULDBLOCK (11)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmemfd_create04 stime=3D1620367932
cmdline=3D"memfd_create04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
memfd_create04.c:67: TINFO: Attempt to create file using 64kB huge page size
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 512kB huge page si=
ze
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 2048kB huge page s=
ize
memfd_create04.c:81: TPASS: memfd_create succeeded for 2048kB page size
memfd_create04.c:67: TINFO: Attempt to create file using 8192kB huge page s=
ize
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 16384kB huge page =
size
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 262144kB huge page=
 size
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 1048576kB huge pag=
e size
memfd_create04.c:81: TPASS: memfd_create succeeded for 1048576kB page size
memfd_create04.c:67: TINFO: Attempt to create file using 2097152kB huge pag=
e size
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 16777216kB huge pa=
ge size
memfd_create04.c:72: TPASS: Test failed as expected

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatx06 stime=3D1620367932
cmdline=3D"statx06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext4 opts=3D'-I 256' extr=
a opts=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
statx06.c:156: TPASS: Birth time Passed
statx06.c:156: TPASS: Modified time Passed
statx06.c:156: TPASS: Access time Passed
statx06.c:156: TPASS: Change time Passed

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20210121-303-gfad5cecb2

       ###############################################################

            Done executing testcases.
            LTP Version:  20210121-303-gfad5cecb2
       ###############################################################




To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in =
this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file f=
or lkp run
        bin/lkp run                    generated-yaml-file



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Cent=
er
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporati=
on

Thanks,
Oliver Sang


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-rc2-00408-g36e4d95891ed"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=19
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# LED Blink
#
# CONFIG_LEDS_BLINK is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_BITFIELD_KUNIT is not set
# CONFIG_RESOURCE_KUNIT_TEST is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_CMDLINE_KUNIT_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='ltp'
	export testcase='ltp'
	export category='functional'
	export need_modules=true
	export need_memory='4G'
	export job_origin='ltp-syscalls.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d02'
	export tbox_group='lkp-skl-d02'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='6094d5fe5273a552ca13b390'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-36e4d95891ed37eb98a660babec749be3fb35fd9-20210507-21194-1abea5d-8.yaml'
	export id='2a12635195f81f834ef415b79920d7efb364d987'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c500746fa0cc-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e41514d5105-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e41514d5105-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_BLK_DEV_LOOP
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_VCAN=m
CONFIG_IPV6_VTI=m
CONFIG_MINIX_FS=m
CONFIG_F2FS_FS'
	export commit='36e4d95891ed37eb98a660babec749be3fb35fd9'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI
CONFIG_DRM_I915'
	export ucode='0xe2'
	export enqueue_time='2021-05-07 13:54:07 +0800'
	export _id='6094d5fe5273a552ca13b390'
	export _rt='/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='c9bfb70ee8db91ba422f5ba886de59e9ab507fb6'
	export base_commit='9f4ad9e425a1d3b6a34617b8ea226d56a119a717'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/8'
	export scheduler_version='/lkp/lkp/.src-20210506-110429'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-36e4d95891ed37eb98a660babec749be3fb35fd9-20210507-21194-1abea5d-8.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=36e4d95891ed37eb98a660babec749be3fb35fd9
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/vmlinuz-5.12.0-rc2-00408-g36e4d95891ed
max_uptime=2100
RESULT_ROOT=/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/8
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210506.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210506.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.12.0-intel-next-01082-g0b58c8d94272'
	export repeat_to=9
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/vmlinuz-5.12.0-rc2-00408-g36e4d95891ed'
	export dequeue_time='2021-05-07 14:07:58 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-36e4d95891ed37eb98a660babec749be3fb35fd9-20210507-21194-1abea5d-8.cgz'

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

	run_setup fs='f2fs' $LKP_SRC/setup/fs

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='syscalls-04' $LKP_SRC/tests/wrapper ltp
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='syscalls-04' $LKP_SRC/stats/wrapper ltp
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time ltp.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--7AUc2qLy4jB3hD7Z
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
MyAAAZ+iBOreHELKLwWxxGf7AgAAAAAEWVo=

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ltp
Content-Transfer-Encoding: quoted-printable

2021-05-07 06:09:26 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-05-07 06:09:26 ./runltp -f syscalls-04 -d /fs/sda1/tmpdir
INFO: creating /lkp/benchmarks/ltp/output directory
INFO: creating /lkp/benchmarks/ltp/results directory
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

/etc/os-release
PRETTY_NAME=3D"Debian GNU/Linux 10 (buster)"
NAME=3D"Debian GNU/Linux"
VERSION_ID=3D"10"
VERSION=3D"10 (buster)"
VERSION_CODENAME=3Dbuster
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"

uname:
Linux lkp-skl-d02 5.12.0-rc2-00408-g36e4d95891ed #1 SMP Sun Apr 18 15:27:41=
 CST 2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=3D0xe2-debian-10.4-x86_64=
-20200603.cgz-36e4d95891ed37eb98a660babec749be3fb35fd9-20210507-21194-1abea=
5d-8.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinus/master com=
mit=3D36e4d95891ed37eb98a660babec749be3fb35fd9 BOOT_IMAGE=3D/pkg/linux/x86_=
64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/vmlinuz-5.12.0-r=
c2-00408-g36e4d95891ed max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1HDD-f2f=
s-syscalls-04-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_=
64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/8 LKP_SERVER=3Di=
nternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enab=
led rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Do=
n panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ra=
mdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr i=
gnore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,11=
5200 vga=3Dnormal rw

Gnu C                  gcc (Debian 8.3.0-6) 8.3.0
Clang                =20
Gnu make               4.2.1
util-linux             2.33.1
mount                  linux 2.33.1 (libmount 2.33.1: selinux, smack, btrfs=
, namespaces, assert, debug)
modutils               26
e2fsprogs              1.44.5
Linux C Library        > libc.2.28
Dynamic linker (ldd)   2.28
Procps                 3.3.15
Net-tools              2.10-alpha
iproute2               iproute2-ss190107
iputils                iputils-s20180629
ethtool                4.19
Kbd                    119:
Sh-utils               8.30
Modules Loaded         dm_mod f2fs xfs libcrc32c ipmi_devintf ipmi_msghandl=
er sd_mod t10_pi sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal i=
ntel_powerclamp coretemp kvm_intel i915 kvm intel_gtt drm_kms_helper irqbyp=
ass crct10dif_pclmul crc32_pclmul mei_wdt crc32c_intel ghash_clmulni_intel =
wmi_bmof syscopyarea ahci sysfillrect sysimgblt libahci mei_me fb_sys_fops =
rapl intel_cstate mei libata drm intel_uncore intel_pch_thermal wmi video i=
ntel_pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32754220      343508    29823812       21796     2586900    2959=
5396
Swap:             0           0           0

cpuinfo:
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
Address sizes:       39 bits physical, 48 bits virtual
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               94
Model name:          Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
Stepping:            3
CPU MHz:             3200.000
CPU max MHz:         3600.0000
CPU min MHz:         800.0000
BogoMIPS:            6399.96
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            6144K
NUMA node0 CPU(s):   0-3
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m=
ca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vm=
x smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe=
 popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefe=
tch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi=
 flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 e=
rms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xge=
tbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp m=
d_clear flush_l1d

AppArmor enabled

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2546     -n 2546 -=
p -f /fs/sda1/tmpdir/ltp-ctEC1rCkVQ/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_05_07-06h_09m_26s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_05_07-06h_09m_26s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_05_07-06h_09m_26s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_05_07-06h_09m_26s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_05_07-06h_0=
9m_26s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_05_07-06h_09=
m_26s.tconf
Running tests.......
<<<test_start>>>
tag=3Daccess01 stime=3D1620367766
cmdline=3D"access01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
access01.c:241: TPASS: access(accessfile_rwx, F_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, F_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, X_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, X_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, W_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, W_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|W_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|W_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|X_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|X_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, W_OK|X_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, W_OK|X_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|W_OK|X_OK) as root passed
access01.c:241: TPASS: access(accessfile_rwx, R_OK|W_OK|X_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessfile_x, X_OK) as root passed
access01.c:241: TPASS: access(accessfile_x, X_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_w, W_OK) as root passed
access01.c:241: TPASS: access(accessfile_w, W_OK) as nobody passed
access01.c:241: TPASS: access(accessfile_r, R_OK) as root passed
access01.c:241: TPASS: access(accessfile_r, R_OK) as nobody passed
access01.c:238: TPASS: access(accessfile_r, X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_r, X_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_r, W_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_w, R_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_w, X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_w, X_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_x, R_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_x, W_OK) as nobody: EACCES (13)
access01.c:238: TPASS: access(accessfile_r, W_OK|X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_r, W_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_r, R_OK|X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_r, R_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_r, R_OK|W_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_r, R_OK|W_OK|X_OK) as root: EACCES=
 (13)
access01.c:238: TPASS: access(accessfile_r, R_OK|W_OK|X_OK) as nobody: EACC=
ES (13)
access01.c:238: TPASS: access(accessfile_w, W_OK|X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_w, W_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_w, R_OK|X_OK) as root: EACCES (13)
access01.c:238: TPASS: access(accessfile_w, R_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_w, R_OK|W_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_w, R_OK|W_OK|X_OK) as root: EACCES=
 (13)
access01.c:238: TPASS: access(accessfile_w, R_OK|W_OK|X_OK) as nobody: EACC=
ES (13)
access01.c:238: TPASS: access(accessfile_x, W_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_x, R_OK|X_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_x, R_OK|W_OK) as nobody: EACCES (1=
3)
access01.c:238: TPASS: access(accessfile_x, R_OK|W_OK|X_OK) as nobody: EACC=
ES (13)
access01.c:241: TPASS: access(accessfile_r, W_OK) as root passed
access01.c:241: TPASS: access(accessfile_r, R_OK|W_OK) as root passed
access01.c:241: TPASS: access(accessfile_w, R_OK) as root passed
access01.c:241: TPASS: access(accessfile_w, R_OK|W_OK) as root passed
access01.c:241: TPASS: access(accessfile_x, R_OK) as root passed
access01.c:241: TPASS: access(accessfile_x, W_OK) as root passed
access01.c:241: TPASS: access(accessfile_x, R_OK|W_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_r, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_r, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_r, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_w, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_w, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_w, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_x, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_x, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_x, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_r/accessfile_x, X_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_r, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_r, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_r, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_w, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_w, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_w, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_x, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_x, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_x, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_w/accessfile_x, X_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_r, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_r, F_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_x/accessfile_r, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_r, R_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_x/accessfile_r, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_w, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_w, F_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_x/accessfile_w, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_w, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_w, W_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, F_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, F_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, R_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, W_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, X_OK) as root passed
access01.c:241: TPASS: access(accessdir_x/accessfile_x, X_OK) as nobody pas=
sed
access01.c:241: TPASS: access(accessdir_rw/accessfile_r, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_r, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_r, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_w, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_w, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_w, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_x, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_x, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_x, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rw/accessfile_x, X_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_r, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_r, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_rx/accessfile_r, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_r, R_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_rx/accessfile_r, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_w, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_w, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_rx/accessfile_w, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_w, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_w, W_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, X_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_rx/accessfile_x, X_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_r, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_r, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_r, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_r, R_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_r, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_w, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_w, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_w, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_w, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_w, W_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, F_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, F_OK) as nobody pa=
ssed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, R_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, W_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, X_OK) as root pass=
ed
access01.c:241: TPASS: access(accessdir_wx/accessfile_x, X_OK) as nobody pa=
ssed
access01.c:238: TPASS: access(accessdir_r/accessfile_r, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_r, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_r, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_r, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_r, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_w, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_w, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_w, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_w, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_w, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_x, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_x, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_x, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_r/accessfile_x, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_r, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_r, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_r, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_r, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_r, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_w, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_w, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_w, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_w, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_w, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_x, F_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_x, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_x, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_w/accessfile_x, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_r, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_r, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_r, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_w, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_w, X_OK) as root: EACC=
ES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_w, X_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_x, R_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_x/accessfile_x, W_OK) as nobody: EA=
CCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_r, F_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_r, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_r, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_r, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_r, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_w, F_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_w, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_w, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_w, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_w, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_x, F_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_x, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_x, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rw/accessfile_x, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_r, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_r, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_r, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_w, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_w, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_w, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_x, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_rx/accessfile_x, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_r, W_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_r, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_r, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_w, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_w, X_OK) as root: EAC=
CES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_w, X_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_x, R_OK) as nobody: E=
ACCES (13)
access01.c:238: TPASS: access(accessdir_wx/accessfile_x, W_OK) as nobody: E=
ACCES (13)

Summary:
passed   199
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dcapset04 stime=3D1620367766
cmdline=3D"capset04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
capset04.c:27: TINFO: Test capset() for a different process
capset04.c:31: TPASS: capset(): EPERM (1)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchown03_16 stime=3D1620367766
cmdline=3D"chown03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/chown/../utils/compat_tst_16=
=2Eh:153: TCONF: 16-bit version of chown() is not supported on your platform

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dchroot01 stime=3D1620367766
cmdline=3D"chroot01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chroot01    1  TPASS  :  chroot set errno to EPERM.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_nanosleep03 stime=3D1620367766
cmdline=3D"clock_nanosleep03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:53: TINFO: Testing variant: vDSO or syscall with libc s=
pec
clock_nanosleep03.c:100: TPASS: clock_nanosleep() slept correctly 100210
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:53: TINFO: Testing variant: syscall with old kernel spec
clock_nanosleep03.c:100: TPASS: clock_nanosleep() slept correctly 100183

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_gettime01 stime=3D1620367766
cmdline=3D"clock_gettime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_gettime01.c:76: TINFO: Testing variant: vDSO or syscall with libc spec
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_REALTIME passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_PROCESS_CPUTIME=
_ID passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_THREAD_CPUTIME_=
ID passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_REALTIME_COARSE=
 passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC_COARS=
E passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC_RAW p=
assed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_BOOTTIME passed
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_gettime01.c:76: TINFO: Testing variant: syscall with old kernel spec
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_REALTIME passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_PROCESS_CPUTIME=
_ID passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_THREAD_CPUTIME_=
ID passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_REALTIME_COARSE=
 passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC_COARS=
E passed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_MONOTONIC_RAW p=
assed
clock_gettime01.c:104: TPASS: clock_gettime(2): clock CLOCK_BOOTTIME passed

Summary:
passed   16
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_settime02 stime=3D1620367766
cmdline=3D"clock_settime02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_settime02.c:107: TINFO: Testing variant: syscall with old kernel spec
clock_settime02.c:152: TPASS: clock_settime(CLOCK_REALTIME): failed as expe=
cted: EFAULT (14)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_REALTIME): failed as expe=
cted: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_REALTIME): failed as expe=
cted: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_REALTIME): failed as expe=
cted: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_MONOTONIC): failed as exp=
ected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(INVALID/UNKNOWN CLOCK): failed =
as expected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(INVALID/UNKNOWN CLOCK): failed =
as expected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_MONOTONIC_COARSE): failed=
 as expected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_MONOTONIC_RAW): failed as=
 expected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_BOOTTIME): failed as expe=
cted: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_PROCESS_CPUTIME_ID): fail=
ed as expected: EINVAL (22)
clock_settime02.c:152: TPASS: clock_settime(CLOCK_THREAD_CPUTIME_ID): faile=
d as expected: EINVAL (22)

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclone02 stime=3D1620367766
cmdline=3D"clone02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
clone02     1  TPASS  :  Test Passed
clone02     2  TPASS  :  Test Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclone04 stime=3D1620367766
cmdline=3D"clone04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
clone04     1  TPASS  :  expected failure; Got EINVAL
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclone08 stime=3D1620367766
cmdline=3D"clone08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clone08.c:72: TINFO: running CLONE_PARENT
clone08.c:116: TPASS: clone and forked child has the same parent
clone08.c:72: TINFO: running CLONE_CHILD_SETTID
clone08.c:134: TPASS: clone() correctly set ctid
clone08.c:72: TINFO: running CLONE_PARENT_SETTID
clone08.c:144: TPASS: clone() correctly set ptid
clone08.c:72: TINFO: running CLONE_THREAD
clone08.c:223: TPASS: clone has the same thread id
clone08.c:213: TPASS: futex exit on ctid change, ctid: 0

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dclose_range01 stime=3D1620367766
cmdline=3D"close_range01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports ext3
tst_supported_fs_types.c:51: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports ext4
tst_supported_fs_types.c:51: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports xfs
tst_supported_fs_types.c:51: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:51: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports vfat
tst_supported_fs_types.c:51: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:115: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:119: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:51: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:38: TINFO: mkfs is not needed for tmpfs
tst_test.c:1379: TINFO: Testing on ext2
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on ext3
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on ext4
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on xfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on btrfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on vfat
tst_test.c:889: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on ntfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
=3D''
The partition start sector was not specified for /dev/loop0 and it could no=
t be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it cou=
ld not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be ob=
tained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sec=
tors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:900: TINFO: Trying FUSE...
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
tst_test.c:1379: TINFO: Testing on tmpfs
tst_test.c:889: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
close_range01.c:134: TINFO: Plain close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:138: TINFO: Set UNSHARE and close range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:142: TINFO: Set CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints
close_range01.c:146: TINFO: Set UNSHARE and CLOEXEC on range
close_range01.c:188: TPASS: No kernel taints

Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D8 cstime=3D93
<<<test_end>>>
<<<test_start>>>
tag=3Dconnect02 stime=3D1620367771
cmdline=3D"connect02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
connect02.c:125: TPASS: Nothing bad happened, probably

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Ddelete_module01 stime=3D1620367771
cmdline=3D"delete_module01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_module.c:70: TCONF: Failed to find module 'dummy_del_mod.ko'

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Ddup01 stime=3D1620367771
cmdline=3D"dup01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
dup01.c:23: TPASS: dup(4) returned 5

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Ddup07 stime=3D1620367771
cmdline=3D"dup07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dup07       1  TPASS  :  Passed in read mode.
dup07       2  TPASS  :  Passed in write mode.
dup07       3  TPASS  :  Passed in read/write mode.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Ddup3_01 stime=3D1620367771
cmdline=3D"dup3_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dup3_01     1  TPASS  :  dup3(O_CLOEXEC) PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexecl01 stime=3D1620367771
cmdline=3D"execl01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
execl01_child.c:20: TPASS: execl01_child executed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexecvp01 stime=3D1620367771
cmdline=3D"execvp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
execvp01_child.c:20: TPASS: execvp01_child executed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfchown04_16 stime=3D1620367771
cmdline=3D"fchown04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
fchown04_16    0  TINFO  :  Found free device 0 '/dev/loop0'
fchown04_16    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra=
 opts=3D''
fchown04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
fchown/../utils/compat_16.h:156: 16-bit version of fchown() is not supporte=
d on your platform
fchown04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
fchown/../utils/compat_16.h:156: Remaining cases not appropriate for config=
uration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dfchownat02 stime=3D1620367772
cmdline=3D"fchownat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fchownat02    1  TPASS  :  fchownat() test AT_SYMLINK_NOFOLLOW success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl08_64 stime=3D1620367772
cmdline=3D"fcntl08_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl08     1  TPASS  :  fcntl returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl14_64 stime=3D1620367772
cmdline=3D"fcntl14_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl14     0  TINFO  :  Enter block 1: without mandatory locking
fcntl14     1  TPASS  :  testcase:1 PASSED
fcntl14     2  TPASS  :  testcase:2 PASSED
fcntl14     3  TPASS  :  testcase:3 PASSED
fcntl14     4  TPASS  :  testcase:4 PASSED
fcntl14     5  TPASS  :  testcase:5 PASSED
fcntl14     6  TPASS  :  testcase:6 PASSED
fcntl14     7  TPASS  :  testcase:7 PASSED
fcntl14     8  TPASS  :  testcase:8 PASSED
fcntl14     9  TPASS  :  testcase:9 PASSED
fcntl14    10  TPASS  :  testcase:10 PASSED
fcntl14    11  TPASS  :  testcase:11 PASSED
fcntl14    12  TPASS  :  testcase:12 PASSED
fcntl14    13  TPASS  :  testcase:13 PASSED
fcntl14    14  TPASS  :  testcase:14 PASSED
fcntl14    15  TPASS  :  testcase:15 PASSED
fcntl14    16  TPASS  :  testcase:16 PASSED
fcntl14    17  TPASS  :  testcase:17 PASSED
fcntl14    18  TPASS  :  testcase:18 PASSED
fcntl14    19  TPASS  :  testcase:19 PASSED
fcntl14    20  TPASS  :  testcase:20 PASSED
fcntl14    21  TPASS  :  testcase:21 PASSED
fcntl14    22  TPASS  :  testcase:22 PASSED
fcntl14    23  TPASS  :  testcase:23 PASSED
fcntl14    24  TPASS  :  testcase:24 PASSED
fcntl14    25  TPASS  :  testcase:25 PASSED
fcntl14    26  TPASS  :  testcase:26 PASSED
fcntl14    27  TPASS  :  testcase:27 PASSED
fcntl14    28  TPASS  :  testcase:28 PASSED
fcntl14    29  TPASS  :  testcase:29 PASSED
fcntl14    30  TPASS  :  testcase:30 PASSED
fcntl14    31  TPASS  :  testcase:31 PASSED
fcntl14    32  TPASS  :  testcase:32 PASSED
fcntl14    33  TPASS  :  testcase:33 PASSED
fcntl14    34  TPASS  :  testcase:34 PASSED
fcntl14    35  TPASS  :  testcase:35 PASSED
fcntl14    36  TPASS  :  testcase:36 PASSED
fcntl14    37  TPASS  :  Block 1, test 1 PASSED
fcntl14    38  TPASS  :  testcase:37 PASSED
fcntl14    39  TPASS  :  testcase:38 PASSED
fcntl14    40  TPASS  :  testcase:39 PASSED
fcntl14    41  TPASS  :  testcase:40 PASSED
fcntl14    42  TPASS  :  testcase:41 PASSED
fcntl14    43  TPASS  :  testcase:42 PASSED
fcntl14    44  TPASS  :  testcase:43 PASSED
fcntl14    45  TPASS  :  testcase:44 PASSED
fcntl14    46  TPASS  :  testcase:45 PASSED
fcntl14    47  TPASS  :  Block 1, test 2 PASSED
fcntl14     0  TINFO  :  Exit block 1
fcntl14     0  TINFO  :  Enter block 2: with mandatory locking
fcntl14    48  TPASS  :  testcase:1 PASSED
fcntl14    49  TPASS  :  testcase:2 PASSED
fcntl14    50  TPASS  :  testcase:3 PASSED
fcntl14    51  TPASS  :  testcase:4 PASSED
fcntl14    52  TPASS  :  testcase:5 PASSED
fcntl14    53  TPASS  :  testcase:6 PASSED
fcntl14    54  TPASS  :  testcase:7 PASSED
fcntl14    55  TPASS  :  testcase:8 PASSED
fcntl14    56  TPASS  :  testcase:9 PASSED
fcntl14    57  TPASS  :  testcase:10 PASSED
fcntl14    58  TPASS  :  testcase:11 PASSED
fcntl14    59  TPASS  :  testcase:12 PASSED
fcntl14    60  TPASS  :  testcase:13 PASSED
fcntl14    61  TPASS  :  testcase:14 PASSED
fcntl14    62  TPASS  :  testcase:15 PASSED
fcntl14    63  TPASS  :  testcase:16 PASSED
fcntl14    64  TPASS  :  testcase:17 PASSED
fcntl14    65  TPASS  :  testcase:18 PASSED
fcntl14    66  TPASS  :  testcase:19 PASSED
fcntl14    67  TPASS  :  testcase:20 PASSED
fcntl14    68  TPASS  :  testcase:21 PASSED
fcntl14    69  TPASS  :  testcase:22 PASSED
fcntl14    70  TPASS  :  testcase:23 PASSED
fcntl14    71  TPASS  :  testcase:24 PASSED
fcntl14    72  TPASS  :  testcase:25 PASSED
fcntl14    73  TPASS  :  testcase:26 PASSED
fcntl14    74  TPASS  :  testcase:27 PASSED
fcntl14    75  TPASS  :  testcase:28 PASSED
fcntl14    76  TPASS  :  testcase:29 PASSED
fcntl14    77  TPASS  :  testcase:30 PASSED
fcntl14    78  TPASS  :  testcase:31 PASSED
fcntl14    79  TPASS  :  testcase:32 PASSED
fcntl14    80  TPASS  :  testcase:33 PASSED
fcntl14    81  TPASS  :  testcase:34 PASSED
fcntl14    82  TPASS  :  testcase:35 PASSED
fcntl14    83  TPASS  :  testcase:36 PASSED
fcntl14    84  TPASS  :  Block 2, test 1 PASSED
fcntl14    85  TPASS  :  testcase:37 PASSED
fcntl14    86  TPASS  :  testcase:38 PASSED
fcntl14    87  TPASS  :  testcase:39 PASSED
fcntl14    88  TPASS  :  testcase:40 PASSED
fcntl14    89  TPASS  :  testcase:41 PASSED
fcntl14    90  TPASS  :  testcase:42 PASSED
fcntl14    91  TPASS  :  testcase:43 PASSED
fcntl14    92  TPASS  :  testcase:44 PASSED
fcntl14    93  TPASS  :  testcase:45 PASSED
fcntl14    94  TPASS  :  Block 2, test 2 PASSED
fcntl14     0  TINFO  :  Exit block 2
fcntl14     0  TINFO  :  Enter block 3
fcntl14    95  TPASS  :  Test with negative whence locking PASSED
fcntl14     0  TINFO  :  Exit block 3
fcntl14     0  TINFO  :  Enter block 4
fcntl14    96  TPASS  :  Test of locks on file PASSED
fcntl14     0  TINFO  :  Exit block 4
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl23_64 stime=3D1620367777
cmdline=3D"fcntl23_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl23     1  TPASS  :  fcntl(tfile_3130, F_SETLEASE, F_RDLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl37_64 stime=3D1620367777
cmdline=3D"fcntl37_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_capability.c:29: TINFO: Dropping CAP_SYS_RESOURCE(24)
fcntl37.c:42: TINFO: F_SETPIPE_SZ and size is beyond 1<<31
fcntl37.c:50: TPASS: F_SETPIPE_SZ failed as expected: EINVAL (22)
fcntl37.c:42: TINFO: F_SETPIPE_SZ and size < data stored in pipe
fcntl37.c:50: TPASS: F_SETPIPE_SZ failed as expected: EBUSY (16)
fcntl37.c:42: TINFO: F_SETPIPE_SZ and size is over limit for unpriviledged =
user
fcntl37.c:50: TPASS: F_SETPIPE_SZ failed as expected: EPERM (1)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfdatasync01 stime=3D1620367777
cmdline=3D"fdatasync01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fdatasync01    1  TPASS  :  fdatasync() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfdatasync02 stime=3D1620367777
cmdline=3D"fdatasync02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fdatasync02    1  TPASS  :  Expected failure for invalid file descriptor, e=
rrno: 9
fdatasync02    2  TPASS  :  Expected failure for file descriptor to a speci=
al file, errno: 22
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dflock02 stime=3D1620367777
cmdline=3D"flock02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
flock02.c:46: TPASS: flock() failed expectedly: EBADF (9)
flock02.c:46: TPASS: flock() failed expectedly: EINVAL (22)
flock02.c:46: TPASS: flock() failed expectedly: EINVAL (22)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dflock04 stime=3D1620367777
cmdline=3D"flock04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
flock04.c:61: TPASS: Parent had shared lock
flock04.c:36: TPASS:  Child acquiring shared lock got 0
flock04.c:39: TPASS:  Child acquiring exclusive lock got -1
flock04.c:61: TPASS: Parent had exclusive lock
flock04.c:39: TPASS:  Child acquiring shared lock got -1
flock04.c:39: TPASS:  Child acquiring exclusive lock got -1

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfmtmsg01 stime=3D1620367777
cmdline=3D"fmtmsg01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fmtms01     1  TPASS  :  Test passed
fmtms01     2  TPASS  :  Test passed
fmtms01     3  TPASS  :  Test passed
fmtms01     4  TPASS  :  Test passed
fmtms01     5  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork01 stime=3D1620367777
cmdline=3D"fork01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork01      1  TPASS  :  fork() returned 3148
fork01      2  TPASS  :  child pid and fork() return agree: 3148
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork13 stime=3D1620367777
cmdline=3D"fork13 -i 1000000"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork13      1  TPASS  :  1000000 pids forked, all passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D101 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D6642 cstime=3D3759
<<<test_end>>>
<<<test_start>>>
tag=3Dfsopen02 stime=3D1620367878
cmdline=3D"fsopen02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsopen02.c:49: TPASS: invalid-fs: fsopen() failed as expected: ENODEV (19)
fsopen02.c:49: TPASS: invalid-flags: fsopen() failed as expected: EINVAL (2=
2)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfstatat01 stime=3D1620367878
cmdline=3D"fstatat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fstatat01    1  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DSUCCESS(=
0): Success
fstatat01    2  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DSUCCESS(=
0): Success
fstatat01    3  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DENOTDIR(=
20): Not a directory
fstatat01    4  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DEBADF(9)=
: Bad file descriptor
fstatat01    5  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DEINVAL(2=
2): Invalid argument
fstatat01    6  TPASS  :  fstatat failed as expected: TEST_ERRNO=3DSUCCESS(=
0): Success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfsync02 stime=3D1620367878
cmdline=3D"fsync02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync02.c:99: TPASS: fsync succeeded in an acceptable amount of time

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dfsync04 stime=3D1620367878
cmdline=3D"fsync04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports ext3
tst_supported_fs_types.c:51: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports ext4
tst_supported_fs_types.c:51: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports xfs
tst_supported_fs_types.c:51: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:51: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports vfat
tst_supported_fs_types.c:51: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:115: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:119: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:51: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:148: TINFO: Skipping tmpfs as requested by the test
tst_test.c:1379: TINFO: Testing on ext2
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on ext3
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on ext4
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on xfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on btrfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on vfat
tst_test.c:889: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1379: TINFO: Testing on ntfs
tst_test.c:889: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
=3D''
The partition start sector was not specified for /dev/loop0 and it could no=
t be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it cou=
ld not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be ob=
tained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sec=
tors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:900: TINFO: Trying FUSE...
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D7 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7 cstime=3D114
<<<test_end>>>
<<<test_start>>>
tag=3Dgetdomainname01 stime=3D1620367885
cmdline=3D"getdomainname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getdomainname01    1  TPASS  :  getdomainname() returned 0=20
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgeteuid01_16 stime=3D1620367885
cmdline=3D"geteuid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
geteuid01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: 16-bit version of geteuid() is not suppo=
rted on your platform
geteuid01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: Remaining cases not appropriate for conf=
iguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetitimer01 stime=3D1620367885
cmdline=3D"getitimer01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getitimer01    1  TPASS  :  functionality is ok
getitimer01    2  TPASS  :  functionality is ok
getitimer01    3  TPASS  :  functionality is ok
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetitimer02 stime=3D1620367885
cmdline=3D"getitimer02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getitimer02    1  TPASS  :  expected failure - errno =3D 14 - Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresgid03_16 stime=3D1620367885
cmdline=3D"getresgid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresgid03    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresgid/../utils/compat_16.h:151: 16-bit version of getresgid() is not su=
pported on your platform
getresgid03    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresgid/../utils/compat_16.h:151: Remaining cases not appropriate for con=
figuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresuid03_16 stime=3D1620367885
cmdline=3D"getresuid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid03    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresuid/../utils/compat_16.h:141: 16-bit version of getresuid() is not su=
pported on your platform
getresuid03    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresuid/../utils/compat_16.h:141: Remaining cases not appropriate for con=
figuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dget_mempolicy02 stime=3D1620367885
cmdline=3D"get_mempolicy02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:191: TINFO: Found 1 NUMA memory nodes
get_mempolicy02.c:79: TPASS: policy: MPOL_DEFAULT, invalid address: EFAULT =
(14)
get_mempolicy02.c:79: TPASS: policy: MPOL_DEFAULT, invalid flags, no target=
: EINVAL (22)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsid01 stime=3D1620367885
cmdline=3D"getsid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getsid01    1  TPASS  :  session ID is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsockopt02 stime=3D1620367885
cmdline=3D"getsockopt02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
getsockopt02.c:66: TPASS: Test passed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetxattr03 stime=3D1620367885
cmdline=3D"getxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getxattr03    1  TPASS  :  getxattr(2) returned correct value
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_loop07 stime=3D1620367885
cmdline=3D"ioctl_loop07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
ioctl_loop07.c:125: TINFO: original loop size 2048 sectors
ioctl_loop07.c:83: TINFO: When sizelimit is greater than loopsize by using =
LOOP_SET_STATUS64
ioctl_loop07.c:62: TPASS: /sys/block/loop0/size =3D 2048
ioctl_loop07.c:63: TPASS: /sys/block/loop0/loop/sizelimit =3D 4194304
ioctl_loop07.c:66: TPASS: LOOP_GET_STATUS64 gets correct lo_sizelimit(41943=
04)
ioctl_loop07.c:83: TINFO: When sizelimit is less than loopsize by using LOO=
P_SET_STATUS64
ioctl_loop07.c:62: TPASS: /sys/block/loop0/size =3D 1024
ioctl_loop07.c:63: TPASS: /sys/block/loop0/loop/sizelimit =3D 524288
ioctl_loop07.c:66: TPASS: LOOP_GET_STATUS64 gets correct lo_sizelimit(52428=
8)
ioctl_loop07.c:83: TINFO: When sizelimit is greater than loopsize by using =
LOOP_CONFIGURE
ioctl_loop07.c:62: TPASS: /sys/block/loop0/size =3D 2048
ioctl_loop07.c:63: TPASS: /sys/block/loop0/loop/sizelimit =3D 4194304
ioctl_loop07.c:66: TPASS: LOOP_GET_STATUS64 gets correct lo_sizelimit(41943=
04)
ioctl_loop07.c:83: TINFO: When sizelimit is less than loopsize by using LOO=
P_CONFIGURE
ioctl_loop07.c:62: TPASS: /sys/block/loop0/size =3D 1024
ioctl_loop07.c:63: TPASS: /sys/block/loop0/loop/sizelimit =3D 524288
ioctl_loop07.c:66: TPASS: LOOP_GET_STATUS64 gets correct lo_sizelimit(52428=
8)

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D10
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_ns03 stime=3D1620367886
cmdline=3D"ioctl_ns03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
ioctl_ns03.c:42: TPASS: NS_GET_OWNER_UID fails, UTS namespace

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify09 stime=3D1620367886
cmdline=3D"fanotify09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fanotify09.c:246: TINFO: Test #0: Events on non-dir child with both parent =
and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/tfile_992
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #1: Events on non-dir child and subdir with b=
oth parent and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/tfile_992
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D992 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testdir
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #2: Events on non-dir child and parent with b=
oth parent and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/tfile_992
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D992 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #3: Events on non-dir child and subdir with b=
oth parent and subdir marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/tfile_992
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D992 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testdir
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #4: Events on non-dir children with both pare=
nt and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/tfile_992
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D992 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testfile
fanotify09.c:191: TPASS: group 1 got event: mask 10 pid=3D992 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testfile
fanotify09.c:191: TPASS: group 2 got event: mask 10 pid=3D992 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testfile
fanotify09.c:246: TINFO: Test #5: Events on non-dir child with both parent =
and mount marks and filename info
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D992 fd=3D-1 filena=
me=3Dtfile_992
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D992 fd=3D-1 filen=
ame=3Dtestfile
fanotify09.c:191: TPASS: group 1 got event: mask 10 pid=3D992 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testfile
fanotify09.c:191: TPASS: group 2 got event: mask 10 pid=3D992 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-ctEC1rCkVQ/kMCgwq/mntpoint/testfile

Summary:
passed   23
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify17 stime=3D1620367887
cmdline=3D"fanotify17"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fanotify17.c:243: TINFO: max_fanotify_groups=3D129 max_fanotify_marks=3D8192
fanotify17.c:176: TINFO: Test #0: Global groups limit in init user ns
fanotify17.c:133: TPASS: Created 129 groups - below groups limit (129)
fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
fanotify17.c:179: TCONF: fanotify inside user namespace is not supported
fanotify17.c:176: TINFO: Test #2: Local groups limit in unprivileged user ns
fanotify17.c:179: TCONF: fanotify inside user namespace is not supported
fanotify17.c:176: TINFO: Test #3: Local marks limit in unprivileged user ns
fanotify17.c:179: TCONF: fanotify inside user namespace is not supported

Summary:
passed   1
failed   0
broken   0
skipped  3
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dkeyctl06 stime=3D1620367887
cmdline=3D"keyctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
keyctl06.c:60: TPASS: KEYCTL_READ returned full count but didn't overrun th=
e buffer

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dkcmp01 stime=3D1620367887
cmdline=3D"kcmp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
kcmp01.c:86: TPASS: kcmp() returned the expected value
kcmp01.c:86: TPASS: kcmp() returned the expected value
kcmp01.c:86: TPASS: kcmp() returned the expected value
kcmp01.c:86: TPASS: kcmp() returned the expected value
kcmp01.c:86: TPASS: kcmp() returned the expected value

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkill08 stime=3D1620367887
cmdline=3D"kill08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill08      1  TPASS  :  received expected signal 9
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkill09 stime=3D1620367887
cmdline=3D"kill09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill09      1  TPASS  :  kill(1025, SIGKILL) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown01_16 stime=3D1620367887
cmdline=3D"lchown01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
lchown01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
lchown/../utils/compat_16.h:161: 16-bit version of lchown() is not supporte=
d on your platform
lchown01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
lchown/../utils/compat_16.h:161: Remaining cases not appropriate for config=
uration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown02_16 stime=3D1620367887
cmdline=3D"lchown02_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
lchown02_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
lchown/../utils/compat_16.h:161: 16-bit version of lchown() is not supporte=
d on your platform
lchown02_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
lchown/../utils/compat_16.h:161: Remaining cases not appropriate for config=
uration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlgetxattr01 stime=3D1620367887
cmdline=3D"lgetxattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
lgetxattr01.c:77: TPASS: lgetxattr() got expected value
lgetxattr01.c:90: TPASS: lgetxattr() failed as expected: ENODATA (61)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlgetxattr02 stime=3D1620367887
cmdline=3D"lgetxattr02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
lgetxattr02.c:63: TPASS: lgetxattr() failed as expected: ENODATA (61)
lgetxattr02.c:63: TPASS: lgetxattr() failed as expected: ERANGE (34)
lgetxattr02.c:63: TPASS: lgetxattr() failed as expected: EFAULT (14)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlink04 stime=3D1620367887
cmdline=3D"link04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link04      1  TPASS  :  link(<non-existent file>, <nefile>): TEST_ERRNO=3D=
ENOENT(2): No such file or directory
link04      2  TPASS  :  link(<path is empty string>, <nefile>): TEST_ERRNO=
=3DENOENT(2): No such file or directory
link04      3  TPASS  :  link(<path contains a non-existent file>, <nefile>=
): TEST_ERRNO=3DENOENT(2): No such file or directory
link04      4  TPASS  :  link(<path contains a regular file>, <nefile>): TE=
ST_ERRNO=3DENOTDIR(20): Not a directory
link04      5  TPASS  :  link(<pathname too long>, <nefile>): TEST_ERRNO=3D=
ENAMETOOLONG(36): File name too long
link04      6  TPASS  :  link(<invalid address>, <nefile>): TEST_ERRNO=3DEF=
AULT(14): Bad address
link04      7  TPASS  :  link(<regfile>, <empty string>): TEST_ERRNO=3DENOE=
NT(2): No such file or directory
link04      8  TPASS  :  link(<regfile>, <path contains a non-existent file=
>): TEST_ERRNO=3DENOENT(2): No such file or directory
link04      9  TPASS  :  link(<regfile>, <path contains a regular file>): T=
EST_ERRNO=3DENOENT(2): No such file or directory
link04     10  TPASS  :  link(<regfile>, <pathname too long>): TEST_ERRNO=
=3DENAMETOOLONG(36): File name too long
link04     11  TPASS  :  link(<regfile>, <invalid address>): TEST_ERRNO=3DE=
FAULT(14): Bad address
link04     12  TPASS  :  link(<regfile>, <regfile2>): TEST_ERRNO=3DEEXIST(1=
7): File exists
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlink05 stime=3D1620367887
cmdline=3D"link05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link05      1  TPASS  :  link(lkfile_1033, lkfile_1033[1-1000]) ret 0 for 1=
000 files,stat linkcounts match 1000
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dlstat02 stime=3D1620367887
cmdline=3D"lstat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
lstat02.c:72: TPASS: lstat() failed as expected: EACCES (13)
lstat02.c:72: TPASS: lstat() failed as expected: ENOENT (2)
lstat02.c:72: TPASS: lstat() failed as expected: EFAULT (14)
lstat02.c:72: TPASS: lstat() failed as expected: ENAMETOOLONG (36)
lstat02.c:72: TPASS: lstat() failed as expected: ENOTDIR (20)
lstat02.c:72: TPASS: lstat() failed as expected: ELOOP (40)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmbind01 stime=3D1620367887
cmdline=3D"mbind01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
mbind01.c:169: TINFO: case MPOL_DEFAULT
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_DEFAULT (target exists)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_BIND (no target)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_BIND
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_INTERLEAVE (no target)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_INTERLEAVE
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_PREFERRED (no target)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_PREFERRED
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case UNKNOWN_POLICY
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_DEFAULT (invalid flags)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_PREFERRED (invalid nodemask)
mbind01.c:216: TPASS: Test passed

Summary:
passed   11
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dmemcpy01 stime=3D1620367887
cmdline=3D"memcpy01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
memcpy1     1  TPASS  :  Test passed
memcpy1     2  TPASS  :  Test passed
memcpy1     3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmknod01 stime=3D1620367887
cmdline=3D"mknod01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mknod01     1  TPASS  :  mknod(test_node, 0100777, 0) returned 0
mknod01     2  TPASS  :  mknod(test_node, 010777, 0) returned 0
mknod01     3  TPASS  :  mknod(test_node, 020777, 259) returned 0
mknod01     4  TPASS  :  mknod(test_node, 060777, 0) returned 0
mknod01     5  TPASS  :  mknod(test_node, 0104700, 0) returned 0
mknod01     6  TPASS  :  mknod(test_node, 0102700, 0) returned 0
mknod01     7  TPASS  :  mknod(test_node, 0106700, 0) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmknod07 stime=3D1620367887
cmdline=3D"mknod07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
mknod07     0  TINFO  :  Found free device 0 '/dev/loop0'
mknod07     0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
mknod07     1  TPASS  :  mknod failed as expected: TEST_ERRNO=3DEACCES(13):=
 Permission denied
mknod07     2  TPASS  :  mknod failed as expected: TEST_ERRNO=3DEACCES(13):=
 Permission denied
mknod07     3  TPASS  :  mknod failed as expected: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
mknod07     4  TPASS  :  mknod failed as expected: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
mknod07     5  TPASS  :  mknod failed as expected: TEST_ERRNO=3DEROFS(30): =
Read-only file system
mknod07     6  TPASS  :  mknod failed as expected: TEST_ERRNO=3DELOOP(40): =
Too many levels of symbolic links
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap06 stime=3D1620367888
cmdline=3D"mmap06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap06      1  TPASS  :  mmap failed with EACCES
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap07 stime=3D1620367888
cmdline=3D"mmap07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap07      1  TPASS  :  mmap failed with EACCES
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmount06 stime=3D1620367888
cmdline=3D"mount06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
mount06     0  TINFO  :  Found free device 0 '/dev/loop0'
mount06     0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
mount06     1  TPASS  :  move mount is ok
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages03 stime=3D1620367888
cmdline=3D"move_pages03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
move_pages03    1  TCONF  :  move_pages_support.c:407: at least 2 allowed N=
UMA nodes are required
move_pages03    2  TCONF  :  move_pages_support.c:407: Remaining cases not =
appropriate for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages11 stime=3D1620367888
cmdline=3D"move_pages11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
move_pages11    1  TCONF  :  move_pages_support.c:407: at least 2 allowed N=
UMA nodes are required
move_pages11    2  TCONF  :  move_pages_support.c:407: Remaining cases not =
appropriate for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_timedreceive01 stime=3D1620367888
cmdline=3D"mq_timedreceive01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
mq_timedreceive01.c:140: TINFO: Testing variant: vDSO or syscall with libc =
spec
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 0, priority 0, l=
ength: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 1, priority 0, l=
ength: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 8192, priority 0=
, length: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 1, priority 3276=
7, length: 8192
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_timedreceive/../utils/mq.=
h:70: TINFO: receive 1/1 message
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EMSGSI=
ZE (90)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EAGAIN=
/EWOULDBLOCK (11)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: ETIMED=
OUT (110)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINTR =
(4)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EFAULT=
 (14)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
mq_timedreceive01.c:140: TINFO: Testing variant: syscall with old kernel sp=
ec
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 0, priority 0, l=
ength: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 1, priority 0, l=
ength: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 8192, priority 0=
, length: 8192
mq_timedreceive01.c:224: TPASS: mq_timedreceive() returned 1, priority 3276=
7, length: 8192
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_timedreceive/../utils/mq.=
h:70: TINFO: receive 1/1 message
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EMSGSI=
ZE (90)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF =
(9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EAGAIN=
/EWOULDBLOCK (11)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL=
 (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: ETIMED=
OUT (110)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINTR =
(4)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EFAULT=
 (14)

Summary:
passed   30
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap02 stime=3D1620367889
cmdline=3D"mremap02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mremap02    1  TPASS  :  mremap() Failed, 'invalid argument specified' - er=
rno 22
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgctl04 stime=3D1620367889
cmdline=3D"msgctl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
msgctl04.c:59: TPASS: msgctl(1, 2, 0x5593a295f840): EACCES (13)
msgctl04.c:59: TPASS: msgctl(2, 2, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, 1, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, -1, 0x5593a295f840): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 2, 0x5593a295f840): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 1, 0x5593a295f840): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(0, 0, (nil)): EPERM (1)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgget01 stime=3D1620367889
cmdline=3D"msgget01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
msgget01.c:45: TPASS: message received =3D message sent

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgrcv01 stime=3D1620367889
cmdline=3D"msgrcv01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
msgrcv01.c:38: TPASS: message received(hello) =3D message sent(hello)
msgrcv01.c:45: TPASS: queue bytes and number of queues matched
msgrcv01.c:49: TPASS: PID of last msgrcv(2) matched
msgrcv01.c:56: TPASS: msg_rtime =3D 1620367889 in [1620367889, 1620367889]

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmunmap03 stime=3D1620367889
cmdline=3D"munmap03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
munmap03    1  TPASS  :  failed as expected: TEST_ERRNO=3DEINVAL(22): Inval=
id argument
munmap03    2  TPASS  :  failed as expected: TEST_ERRNO=3DEINVAL(22): Inval=
id argument
munmap03    3  TPASS  :  failed as expected: TEST_ERRNO=3DEINVAL(22): Inval=
id argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dnice02 stime=3D1620367889
cmdline=3D"nice02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
nice02.c:46: TPASS: nice(50) passed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dnice03 stime=3D1620367889
cmdline=3D"nice03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
nice03.c:47: TPASS: nice(2) passed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen08 stime=3D1620367889
cmdline=3D"open08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
open08.c:84: TPASS: expected failure - errno =3D 17 : File exists
open08.c:84: TPASS: expected failure - errno =3D 21 : Is a directory
open08.c:84: TPASS: expected failure - errno =3D 20 : Not a directory
open08.c:84: TPASS: expected failure - errno =3D 36 : File name too long
open08.c:84: TPASS: expected failure - errno =3D 13 : Permission denied
open08.c:84: TPASS: expected failure - errno =3D 14 : Bad address

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen09 stime=3D1620367889
cmdline=3D"open09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open09      1  TPASS  :  Test passed in O_WRONLY.
open09      2  TPASS  :  Test passed in O_RDONLY.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopenat02 stime=3D1620367889
cmdline=3D"openat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
openat02    1  TPASS  :  test O_APPEND for openat success
openat02    2  TPASS  :  test O_CLOEXEC for openat success
openat02    3  TPASS  :  test O_LARGEFILE for openat success
openat02    4  TCONF  :  openat02.c:237: test O_NOATIME flag for openat nee=
ds filesystems which are mounted without noatime and relatime
openat02    5  TPASS  :  test O_NOFOLLOW for openat success
openat02    6  TPASS  :  test O_TRUNC for openat success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopenat202 stime=3D1620367889
cmdline=3D"openat202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
openat202.c:58: TPASS: open /proc/version: openat2() passed
openat202.c:58: TPASS: open magiclinks: openat2() passed
openat202.c:58: TPASS: open symlinks: openat2() passed
openat202.c:74: TPASS: resolve-no-xdev: openat2() failed as expected: EXDEV=
 (18)
openat202.c:74: TPASS: resolve-no-magiclinks: openat2() failed as expected:=
 ELOOP (40)
openat202.c:74: TPASS: resolve-no-symlinks: openat2() failed as expected: E=
LOOP (40)
openat202.c:74: TPASS: resolve-beneath: openat2() failed as expected: EXDEV=
 (18)
openat202.c:74: TPASS: resolve-beneath: openat2() failed as expected: EXDEV=
 (18)
openat202.c:74: TPASS: resolve-no-in-root: openat2() failed as expected: EN=
OENT (2)

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen_by_handle_at02 stime=3D1620367889
cmdline=3D"open_by_handle_at02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_buffers.c:55: TINFO: Test is using guarded buffers
open_by_handle_at02.c:99: TPASS: invalid-dfd: open_by_handle_at() failed as=
 expected: EBADF (9)
open_by_handle_at02.c:99: TPASS: stale-dfd: open_by_handle_at() failed as e=
xpected: ESTALE (116)
open_by_handle_at02.c:99: TPASS: invalid-file-handle: open_by_handle_at() f=
ailed as expected: EFAULT (14)
open_by_handle_at02.c:99: TPASS: high-file-handle-size: open_by_handle_at()=
 failed as expected: EINVAL (22)
open_by_handle_at02.c:99: TPASS: zero-file-handle-size: open_by_handle_at()=
 failed as expected: EINVAL (22)
tst_capability.c:29: TINFO: Dropping CAP_DAC_READ_SEARCH(2)
tst_capability.c:41: TINFO: Permitting CAP_DAC_READ_SEARCH(2)
open_by_handle_at02.c:99: TPASS: no-capability: open_by_handle_at() failed =
as expected: EPERM (1)
open_by_handle_at02.c:99: TPASS: symlink: open_by_handle_at() failed as exp=
ected: ELOOP (40)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmincore01 stime=3D1620367889
cmdline=3D"mincore01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mincore01    1  TPASS  :  failed as expected: TEST_ERRNO=3DEINVAL(22): Inva=
lid argument
mincore01    2  TPASS  :  failed as expected: TEST_ERRNO=3DEFAULT(14): Bad =
address
mincore01    3  TPASS  :  failed as expected: TEST_ERRNO=3DENOMEM(12): Cann=
ot allocate memory
mincore01    4  TPASS  :  failed as expected: TEST_ERRNO=3DENOMEM(12): Cann=
ot allocate memory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dnewuname01 stime=3D1620367889
cmdline=3D"newuname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
newuname01    1  TPASS  :  newuname call succeed: return value =3D 0=20
newuname01    0  TINFO  :  This system is Linux
newuname01    0  TINFO  :  The system infomation is :
newuname01    0  TINFO  :  System is Linux on x86_64 hardware
newuname01    0  TINFO  :  Nodename is lkp-skl-d02
newuname01    0  TINFO  :  Version is 5.12.0-rc2-00408-g36e4d95891ed, #1 SM=
P Sun Apr 18 15:27:41 CST 2021
newuname01    0  TINFO  :  Domainname is (none)=20
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe02 stime=3D1620367889
cmdline=3D"pipe02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
pipe02.c:86: TPASS: Child killed by SIGPIPE

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe03 stime=3D1620367889
cmdline=3D"pipe03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
pipe03.c:30: TPASS: expected failure writing to read end of pipe: EBADF (9)
pipe03.c:39: TPASS: expected failure reading from write end of pipe: EBADF =
(9)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpivot_root01 stime=3D1620367889
cmdline=3D"pivot_root01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
pivot_root01.c:158: TPASS: pivot_root succeeded
pivot_root01.c:173: TPASS: pivot_root failed as expectedly: EBUSY (16)
pivot_root01.c:173: TPASS: pivot_root failed as expectedly: EINVAL (22)
pivot_root01.c:173: TPASS: pivot_root failed as expectedly: ENOTDIR (20)
pivot_root01.c:173: TPASS: pivot_root failed as expectedly: EPERM (1)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dprctl03 stime=3D1620367889
cmdline=3D"prctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
prctl03.c:73: TPASS: prctl(PR_SET_CHILD_SUBREAPER) succeeded
prctl03.c:46: TPASS: prctl(PR_GET_CHILD_SUBREAPER) got expected 0
prctl03.c:88: TPASS: PPID of orphaned process was reparented
prctl03.c:101: TPASS: wait() got orphaned process, pid 1099, status 0
prctl03.c:108: TPASS: received SIGCHLD from orphaned process
prctl03.c:46: TPASS: prctl(PR_GET_CHILD_SUBREAPER) got expected 1

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dprctl05 stime=3D1620367889
cmdline=3D"prctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est
prctl05.c:62: TPASS: /proc/self/task/1101/comm =3D 'prctl05_test'
prctl05.c:63: TPASS: /proc/self/comm =3D 'prctl05_test'
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test_xxxxx') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est_xx
prctl05.c:62: TPASS: /proc/self/task/1101/comm =3D 'prctl05_test_xx'
prctl05.c:63: TPASS: /proc/self/comm =3D 'prctl05_test_xx'

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpread02 stime=3D1620367889
cmdline=3D"pread02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pread02     1  TPASS  :  pread() fails, file descriptor is a PIPE or FIFO, =
errno:29
pread02     2  TPASS  :  pread() fails, specified offset is -ve or invalid,=
 errno:22
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpreadv01_64 stime=3D1620367889
cmdline=3D"preadv01_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
preadv01.c:81: TPASS: Preadv(2) read 64 bytes successfully with content 'a'=
 expectedly
preadv01.c:81: TPASS: Preadv(2) read 64 bytes successfully with content 'a'=
 expectedly
preadv01.c:81: TPASS: Preadv(2) read 32 bytes successfully with content 'b'=
 expectedly

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpreadv02_64 stime=3D1620367889
cmdline=3D"preadv02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
preadv02.c:89: TPASS: preadv() failed as expected: EINVAL (22)
preadv02.c:89: TPASS: preadv() failed as expected: EINVAL (22)
preadv02.c:89: TPASS: preadv() failed as expected: EINVAL (22)
preadv02.c:89: TPASS: preadv() failed as expected: EFAULT (14)
preadv02.c:89: TPASS: preadv() failed as expected: EBADF (9)
preadv02.c:89: TPASS: preadv() failed as expected: EBADF (9)
preadv02.c:89: TPASS: preadv() failed as expected: EISDIR (21)
preadv02.c:89: TPASS: preadv() failed as expected: ESPIPE (29)

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dprot_hsymlinks stime=3D1620367889
cmdline=3D"prot_hsymlinks"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
prot_hsymlinks    0  TINFO  :   --- HARDLINKS AND SYMLINKS RESTRICTIONS TES=
T ---
prot_hsymlinks    1  TPASS  :  Expect: can follow symlink '.../link_1', own=
er 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks    2  TPASS  :  Expect: can follow symlink '.../link_1', own=
er 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks    3  TPASS  :  Expect: can follow symlink '.../link_2', own=
er 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks    4  TPASS  :  Expect: can follow symlink '.../link_2', own=
er 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks    5  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_3', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks    6  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_3', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks    7  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_4', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks    8  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_4', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks    9  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_5', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   10  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_5', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   11  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_6', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   12  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_6', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   13  TPASS  :  Expect: can create hardlink '.../root.hs' to=
 '.../link_7', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   14  TPASS  :  Expect: can't create hardlink '.../root.hs' =
to '.../link_8', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   15  TPASS  :  Expect: can create hardlink '.../root.hs' to=
 '.../tmp_root/link_9', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   16  TPASS  :  Expect: can't create hardlink '.../root.hs' =
to '.../tmp_root/link_10', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   17  TPASS  :  Expect: can create hardlink '.../root.hs' to=
 '.../tmp_hsym/link_11', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   18  TPASS  :  Expect: can't create hardlink '.../root.hs' =
to '.../tmp_hsym/link_12', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   19  TPASS  :  Expect: can follow symlink '.../link_13', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   20  TPASS  :  Expect: can follow symlink '.../link_13', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   21  TPASS  :  Expect: can follow symlink '.../link_14', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   22  TPASS  :  Expect: can follow symlink '.../link_14', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   23  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_15', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   24  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_15', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   25  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_16', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   26  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_16', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   27  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_17', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   28  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_17', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   29  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_18', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   30  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_18', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   31  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../link_19', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   32  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../link_20', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks   33  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../tmp_root/link_21', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   34  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../tmp_root/link_22', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks   35  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../tmp_hsym/link_23', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   36  TPASS  :  Expect: can create hardlink '.../root.hs_w' =
to '.../tmp_hsym/link_24', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks   37  TPASS  :  Expect: can follow symlink '.../link_25', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   38  TPASS  :  Expect: can follow symlink '.../link_25', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   39  TPASS  :  Expect: can follow symlink '.../link_26', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   40  TPASS  :  Expect: can follow symlink '.../link_26', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   41  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_27', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   42  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_27', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   43  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_28', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   44  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_28', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   45  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_29', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   46  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_29', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   47  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_30', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   48  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_30', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   49  TPASS  :  Expect: can follow symlink '.../link_31', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   50  TPASS  :  Expect: can follow symlink '.../link_31', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   51  TPASS  :  Expect: can follow symlink '.../link_32', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   52  TPASS  :  Expect: can follow symlink '.../link_32', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   53  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_33', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   54  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_33', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   55  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_34', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   56  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_34', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   57  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_35', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   58  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_35', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   59  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_36', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   60  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_36', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   61  TPASS  :  Expect: can create hardlink '.../root/local_=
root.hs' to '.../link_37', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   62  TPASS  :  Expect: can't create hardlink '.../root/loca=
l_root.hs' to '.../link_38', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   63  TPASS  :  Expect: can create hardlink '.../root/local_=
root.hs' to '.../tmp_root/link_39', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   64  TPASS  :  Expect: can't create hardlink '.../root/loca=
l_root.hs' to '.../tmp_root/link_40', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   65  TPASS  :  Expect: can create hardlink '.../root/local_=
root.hs' to '.../tmp_hsym/link_41', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   66  TPASS  :  Expect: can't create hardlink '.../root/loca=
l_root.hs' to '.../tmp_hsym/link_42', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   67  TPASS  :  Expect: can follow symlink '.../link_43', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   68  TPASS  :  Expect: can follow symlink '.../link_43', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   69  TPASS  :  Expect: can follow symlink '.../link_44', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   70  TPASS  :  Expect: can follow symlink '.../link_44', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   71  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_45', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   72  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_45', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   73  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_46', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   74  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_46', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   75  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_47', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   76  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_47', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   77  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_48', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   78  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_48', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   79  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs' to '.../link_49', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   80  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root.hs' to '.../link_50', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   81  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs' to '.../tmp_root/link_51', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   82  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root.hs' to '.../tmp_root/link_52', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   83  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs' to '.../tmp_hsym/link_53', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   84  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root.hs' to '.../tmp_hsym/link_54', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks   85  TPASS  :  Expect: can follow symlink '.../link_55', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   86  TPASS  :  Expect: can follow symlink '.../link_55', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   87  TPASS  :  Expect: can follow symlink '.../link_56', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   88  TPASS  :  Expect: can follow symlink '.../link_56', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   89  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_57', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   90  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_57', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   91  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_58', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks   92  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_58', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks   93  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_59', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   94  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_59', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   95  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_60', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks   96  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_60', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks   97  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../link_61', owner 'root', curr.user 'root', w(1)
prot_hsymlinks   98  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../link_62', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks   99  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../tmp_root/link_63', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  100  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../tmp_root/link_64', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks  101  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../tmp_hsym/link_65', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  102  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot.hs_w' to '.../tmp_hsym/link_66', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks  103  TPASS  :  Expect: can follow symlink '.../link_67', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  104  TPASS  :  Expect: can follow symlink '.../link_67', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  105  TPASS  :  Expect: can follow symlink '.../link_68', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  106  TPASS  :  Expect: can follow symlink '.../link_68', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  107  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_69', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  108  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_69', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  109  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_70', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  110  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_70', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  111  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_71', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  112  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_71', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  113  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_72', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  114  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_72', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  115  TPASS  :  Expect: can follow symlink '.../link_73', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  116  TPASS  :  Expect: can follow symlink '.../link_73', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  117  TPASS  :  Expect: can follow symlink '.../link_74', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  118  TPASS  :  Expect: can follow symlink '.../link_74', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  119  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_75', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  120  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_75', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  121  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_76', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  122  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_76', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  123  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_77', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  124  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_77', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  125  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_78', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  126  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_78', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  127  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot/local_root.hs' to '.../link_79', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  128  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root/local_root.hs' to '.../link_80', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks  129  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot/local_root.hs' to '.../tmp_root/link_81', owner 'root', curr.user 'root'=
, w(1)
prot_hsymlinks  130  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root/local_root.hs' to '.../tmp_root/link_82', owner 'root', curr.user 'hsy=
m', w(0)
prot_hsymlinks  131  TPASS  :  Expect: can create hardlink '.../tmp_root/ro=
ot/local_root.hs' to '.../tmp_hsym/link_83', owner 'root', curr.user 'root'=
, w(1)
prot_hsymlinks  132  TPASS  :  Expect: can't create hardlink '.../tmp_root/=
root/local_root.hs' to '.../tmp_hsym/link_84', owner 'root', curr.user 'hsy=
m', w(0)
prot_hsymlinks  133  TPASS  :  Expect: can follow symlink '.../link_85', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  134  TPASS  :  Expect: can follow symlink '.../link_85', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  135  TPASS  :  Expect: can follow symlink '.../link_86', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  136  TPASS  :  Expect: can follow symlink '.../link_86', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  137  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_87', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  138  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_87', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  139  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_88', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  140  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_88', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  141  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_89', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  142  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_89', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  143  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_90', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  144  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_90', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  145  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs' to '.../link_91', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  146  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root.hs' to '.../link_92', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks  147  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs' to '.../tmp_root/link_93', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  148  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root.hs' to '.../tmp_root/link_94', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks  149  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs' to '.../tmp_hsym/link_95', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  150  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root.hs' to '.../tmp_hsym/link_96', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks  151  TPASS  :  Expect: can follow symlink '.../link_97', ow=
ner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  152  TPASS  :  Expect: can follow symlink '.../link_97', ow=
ner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  153  TPASS  :  Expect: can follow symlink '.../link_98', ow=
ner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  154  TPASS  :  Expect: can follow symlink '.../link_98', ow=
ner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  155  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_99', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  156  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_99', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  157  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_100', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  158  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_100', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  159  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_101', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  160  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_101', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  161  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_102', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  162  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_102', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  163  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../link_103', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  164  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../link_104', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks  165  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../tmp_root/link_105', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  166  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../tmp_root/link_106', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks  167  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../tmp_hsym/link_107', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  168  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot.hs_w' to '.../tmp_hsym/link_108', owner 'root', curr.user 'hsym', w(1)
prot_hsymlinks  169  TPASS  :  Expect: can follow symlink '.../link_109', o=
wner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  170  TPASS  :  Expect: can follow symlink '.../link_109', o=
wner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  171  TPASS  :  Expect: can follow symlink '.../link_110', o=
wner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  172  TPASS  :  Expect: can follow symlink '.../link_110', o=
wner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  173  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_111', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  174  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_111', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  175  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_112', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  176  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_112', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  177  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_113', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  178  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_113', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  179  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_114', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  180  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_114', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  181  TPASS  :  Expect: can follow symlink '.../link_115', o=
wner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  182  TPASS  :  Expect: can follow symlink '.../link_115', o=
wner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  183  TPASS  :  Expect: can follow symlink '.../link_116', o=
wner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  184  TPASS  :  Expect: can follow symlink '.../link_116', o=
wner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  185  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_117', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  186  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_117', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  187  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_118', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'root'
prot_hsymlinks  188  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_118', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  189  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_119', owner 'root', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  190  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_119', owner 'root', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  191  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_120', owner 'hsym', src.owner 'root', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  192  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_120', owner 'hsym', src.owner 'root', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  193  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot/local_root.hs' to '.../link_121', owner 'root', curr.user 'root', w(1)
prot_hsymlinks  194  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root/local_root.hs' to '.../link_122', owner 'root', curr.user 'hsym', w(0)
prot_hsymlinks  195  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot/local_root.hs' to '.../tmp_root/link_123', owner 'root', curr.user 'root=
', w(1)
prot_hsymlinks  196  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root/local_root.hs' to '.../tmp_root/link_124', owner 'root', curr.user 'hs=
ym', w(0)
prot_hsymlinks  197  TPASS  :  Expect: can create hardlink '.../tmp_hsym/ro=
ot/local_root.hs' to '.../tmp_hsym/link_125', owner 'root', curr.user 'root=
', w(1)
prot_hsymlinks  198  TPASS  :  Expect: can't create hardlink '.../tmp_hsym/=
root/local_root.hs' to '.../tmp_hsym/link_126', owner 'root', curr.user 'hs=
ym', w(0)
prot_hsymlinks  199  TPASS  :  Expect: can follow symlink '.../link_127', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  200  TPASS  :  Expect: can follow symlink '.../link_127', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  201  TPASS  :  Expect: can follow symlink '.../link_128', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  202  TPASS  :  Expect: can follow symlink '.../link_128', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  203  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_129', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  204  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_129', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  205  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_130', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  206  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_130', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  207  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_131', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  208  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_131', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  209  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_132', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  210  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_132', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  211  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../link_133', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  212  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../link_134', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  213  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../tmp_root/link_135', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  214  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../tmp_root/link_136', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  215  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../tmp_hsym/link_137', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  216  TPASS  :  Expect: can create hardlink '.../hsym.hs' to=
 '.../tmp_hsym/link_138', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  217  TPASS  :  Expect: can follow symlink '.../link_139', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  218  TPASS  :  Expect: can follow symlink '.../link_139', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  219  TPASS  :  Expect: can follow symlink '.../link_140', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  220  TPASS  :  Expect: can follow symlink '.../link_140', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  221  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_141', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  222  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_141', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  223  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_142', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  224  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_142', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  225  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_143', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  226  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_143', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  227  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_144', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  228  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_144', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  229  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../link_145', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  230  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../link_146', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  231  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../tmp_root/link_147', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  232  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../tmp_root/link_148', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  233  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../tmp_hsym/link_149', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  234  TPASS  :  Expect: can create hardlink '.../hsym.hs_w' =
to '.../tmp_hsym/link_150', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  235  TPASS  :  Expect: can follow symlink '.../link_151', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  236  TPASS  :  Expect: can follow symlink '.../link_151', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  237  TPASS  :  Expect: can follow symlink '.../link_152', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  238  TPASS  :  Expect: can follow symlink '.../link_152', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  239  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_153', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  240  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_153', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  241  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_154', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  242  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_154', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  243  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_155', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  244  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_155', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  245  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_156', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  246  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_156', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  247  TPASS  :  Expect: can follow symlink '.../link_157', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  248  TPASS  :  Expect: can follow symlink '.../link_157', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  249  TPASS  :  Expect: can follow symlink '.../link_158', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  250  TPASS  :  Expect: can follow symlink '.../link_158', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  251  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_159', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  252  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_159', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  253  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_160', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  254  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_160', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  255  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_161', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  256  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_161', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  257  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_162', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  258  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_162', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  259  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../link_163', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  260  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../link_164', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  261  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../tmp_root/link_165', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  262  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../tmp_root/link_166', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  263  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../tmp_hsym/link_167', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  264  TPASS  :  Expect: can create hardlink '.../hsym/local_=
hsym.hs' to '.../tmp_hsym/link_168', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  265  TPASS  :  Expect: can follow symlink '.../link_169', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  266  TPASS  :  Expect: can follow symlink '.../link_169', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  267  TPASS  :  Expect: can follow symlink '.../link_170', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  268  TPASS  :  Expect: can follow symlink '.../link_170', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  269  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_171', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  270  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_171', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  271  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_172', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  272  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_172', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  273  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_173', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  274  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_173', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  275  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_174', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  276  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_174', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  277  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../link_175', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  278  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../link_176', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  279  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../tmp_root/link_177', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  280  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../tmp_root/link_178', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  281  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../tmp_hsym/link_179', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  282  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs' to '.../tmp_hsym/link_180', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  283  TPASS  :  Expect: can follow symlink '.../link_181', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  284  TPASS  :  Expect: can follow symlink '.../link_181', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  285  TPASS  :  Expect: can follow symlink '.../link_182', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  286  TPASS  :  Expect: can follow symlink '.../link_182', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  287  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_183', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  288  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_183', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  289  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_184', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  290  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_184', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  291  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_185', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  292  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_185', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  293  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_186', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  294  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_186', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  295  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../link_187', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  296  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../link_188', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  297  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../tmp_root/link_189', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  298  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../tmp_root/link_190', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  299  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../tmp_hsym/link_191', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  300  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym.hs_w' to '.../tmp_hsym/link_192', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  301  TPASS  :  Expect: can follow symlink '.../link_193', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  302  TPASS  :  Expect: can follow symlink '.../link_193', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  303  TPASS  :  Expect: can follow symlink '.../link_194', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  304  TPASS  :  Expect: can follow symlink '.../link_194', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  305  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_195', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  306  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_195', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  307  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_196', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  308  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_196', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  309  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_197', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  310  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_197', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  311  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_198', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  312  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_198', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  313  TPASS  :  Expect: can follow symlink '.../link_199', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  314  TPASS  :  Expect: can follow symlink '.../link_199', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  315  TPASS  :  Expect: can follow symlink '.../link_200', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  316  TPASS  :  Expect: can follow symlink '.../link_200', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  317  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_201', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  318  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_201', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  319  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_202', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  320  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_202', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  321  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_203', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  322  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_203', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  323  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_204', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  324  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_204', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  325  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../link_205', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  326  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../link_206', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  327  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../tmp_root/link_207', owner 'hsym', curr.user 'root=
', w(1)
prot_hsymlinks  328  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../tmp_root/link_208', owner 'hsym', curr.user 'hsym=
', w(1)
prot_hsymlinks  329  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../tmp_hsym/link_209', owner 'hsym', curr.user 'root=
', w(1)
prot_hsymlinks  330  TPASS  :  Expect: can create hardlink '.../tmp_root/hs=
ym/local_hsym.hs' to '.../tmp_hsym/link_210', owner 'hsym', curr.user 'hsym=
', w(1)
prot_hsymlinks  331  TPASS  :  Expect: can follow symlink '.../link_211', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  332  TPASS  :  Expect: can follow symlink '.../link_211', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  333  TPASS  :  Expect: can follow symlink '.../link_212', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  334  TPASS  :  Expect: can follow symlink '.../link_212', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  335  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_213', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  336  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_213', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  337  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_214', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  338  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_214', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  339  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_215', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  340  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_215', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  341  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_216', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  342  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_216', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  343  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../link_217', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  344  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../link_218', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  345  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../tmp_root/link_219', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  346  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../tmp_root/link_220', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  347  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../tmp_hsym/link_221', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  348  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs' to '.../tmp_hsym/link_222', owner 'hsym', curr.user 'hsym', w(1)
prot_hsymlinks  349  TPASS  :  Expect: can follow symlink '.../link_223', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  350  TPASS  :  Expect: can follow symlink '.../link_223', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  351  TPASS  :  Expect: can follow symlink '.../link_224', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  352  TPASS  :  Expect: can follow symlink '.../link_224', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  353  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_225', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  354  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_225', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  355  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_226', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  356  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_226', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  357  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_227', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  358  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_227', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  359  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_228', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  360  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_228', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  361  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../link_229', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  362  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../link_230', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  363  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../tmp_root/link_231', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  364  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../tmp_root/link_232', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  365  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../tmp_hsym/link_233', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  366  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym.hs_w' to '.../tmp_hsym/link_234', owner 'hsym', curr.user 'hsym', w(0)
prot_hsymlinks  367  TPASS  :  Expect: can follow symlink '.../link_235', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  368  TPASS  :  Expect: can follow symlink '.../link_235', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  369  TPASS  :  Expect: can follow symlink '.../link_236', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  370  TPASS  :  Expect: can follow symlink '.../link_236', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  371  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_237', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  372  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_237', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  373  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_238', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  374  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_238', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  375  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_239', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  376  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_239', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  377  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_240', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  378  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_240', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  379  TPASS  :  Expect: can follow symlink '.../link_241', o=
wner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  380  TPASS  :  Expect: can follow symlink '.../link_241', o=
wner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  381  TPASS  :  Expect: can follow symlink '.../link_242', o=
wner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  382  TPASS  :  Expect: can follow symlink '.../link_242', o=
wner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  383  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_243', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  384  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_243', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  385  TPASS  :  Expect: can't follow symlink '.../tmp_root/l=
ink_244', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'root'
prot_hsymlinks  386  TPASS  :  Expect: can follow symlink '.../tmp_root/lin=
k_244', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'root'
prot_hsymlinks  387  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_245', owner 'root', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  388  TPASS  :  Expect: can't follow symlink '.../tmp_hsym/l=
ink_245', owner 'root', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  389  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_246', owner 'hsym', src.owner 'hsym', curr.user 'root', dir.owner 'hsym'
prot_hsymlinks  390  TPASS  :  Expect: can follow symlink '.../tmp_hsym/lin=
k_246', owner 'hsym', src.owner 'hsym', curr.user 'hsym', dir.owner 'hsym'
prot_hsymlinks  391  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym/local_hsym.hs' to '.../link_247', owner 'hsym', curr.user 'root', w(1)
prot_hsymlinks  392  TPASS  :  Expect: can create huserdel: hsym mail spool=
 (/var/mail/hsym) not found
userdel: hsym home directory (/home/hsym) not found
ardlink '.../tmp_hsym/hsym/local_hsym.hs' to '.../link_248', owner 'hsym', =
curr.user 'hsym', w(1)
prot_hsymlinks  393  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym/local_hsym.hs' to '.../tmp_root/link_249', owner 'hsym', curr.user 'root=
', w(1)
prot_hsymlinks  394  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym/local_hsym.hs' to '.../tmp_root/link_250', owner 'hsym', curr.user 'hsym=
', w(1)
prot_hsymlinks  395  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym/local_hsym.hs' to '.../tmp_hsym/link_251', owner 'hsym', curr.user 'root=
', w(1)
prot_hsymlinks  396  TPASS  :  Expect: can create hardlink '.../tmp_hsym/hs=
ym/local_hsym.hs' to '.../tmp_hsym/link_252', owner 'hsym', curr.user 'hsym=
', w(1)
prot_hsymlinks    0  TINFO  :  All test-cases have been completed, summary:=
 - symlinks  test:	PASS - hardlinks test:	PASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace08 stime=3D1620367889
cmdline=3D"ptrace08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_kernel.c:83: TINFO: uname.machine=3Dx86_64 kernel is 64bit
ptrace08.c:99: TINFO: Trying address 0xffff800000000000
ptrace08.c:129: TPASS: ptrace() breakpoint with kernel addr failed: EINVAL =
(22)
ptrace08.c:99: TINFO: Trying address 0xffffffffffffffff
ptrace08.c:129: TPASS: ptrace() breakpoint with kernel addr failed: EINVAL =
(22)
ptrace08.c:99: TINFO: Trying address 0xffffbfffffffffff
ptrace08.c:129: TPASS: ptrace() breakpoint with kernel addr failed: EINVAL =
(22)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev01 stime=3D1620367889
cmdline=3D"pwritev01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev01_64 stime=3D1620367889
cmdline=3D"pwritev01_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20
pwritev01.c:85: TPASS: writev() wrote 64 bytes successfully with content 'a=
' expectedly=20

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dquotactl03 stime=3D1620367889
cmdline=3D"quotactl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
quotactl03.c:64: TPASS: quotactl() failed with ENOENT as expected

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dreadlink01A stime=3D1620367889
cmdline=3D"symlink01 -T readlink01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
readlink01    1  TPASS  :  Reading of symbolic link file contents checks ou=
t ok
readlink01    2  TPASS  :  Reading of symbolic link file contents checks ou=
t ok
readlink01    3  TPASS  :  Reading a symbolic link which exceeds maximum pa=
thname error is caught
readlink01    4  TPASS  :  Reading a nonsymbolic link file error condition =
is caught.  EINVAL is returned
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreboot02 stime=3D1620367889
cmdline=3D"reboot02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
reboot02.c:49: TPASS: INVALID_PARAMETER: EINVAL (22)
reboot02.c:55: TPASS: LINUX_REBOOT_CMD_CAD_ON: EPERM (1)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dremap_file_pages01 stime=3D1620367889
cmdline=3D"remap_file_pages01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
remap_file_pages01    1  TPASS  :  Non-Linear shm file OK
remap_file_pages01    2  TPASS  :  Non-Linear /tmp/ file OK
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dremap_file_pages02 stime=3D1620367889
cmdline=3D"remap_file_pages02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
remap_file_pages02.c:86: TPASS: remap_file_pages(2) start is not valid MAP_=
SHARED mapping: EINVAL (22)
remap_file_pages02.c:86: TPASS: remap_file_pages(2) start is invalid: EINVA=
L (22)
remap_file_pages02.c:86: TPASS: remap_file_pages(2) size is invalid: EINVAL=
 (22)
remap_file_pages02.c:86: TPASS: remap_file_pages(2) prot is invalid: EINVAL=
 (22)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drename04 stime=3D1620367889
cmdline=3D"rename04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
rename04    1  TPASS  :  rename() returned ENOTEMPTY
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drenameat201 stime=3D1620367889
cmdline=3D"renameat201"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
renameat201    1  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DEEXIST(17): File exists
renameat201    2  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DSUCCESS(0): Success
renameat201    3  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DENOENT(2): No such file or directory
renameat201    4  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DSUCCESS(0): Success
renameat201    5  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DEINVAL(22): Invalid argument
renameat201    6  TPASS  :  renameat2() returned the expected value: TEST_E=
RRNO=3DEINVAL(22): Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drmdir02 stime=3D1620367889
cmdline=3D"rmdir02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
rmdir02.c:92: TPASS: rmdir() failed as expected: ENOTEMPTY (39)
rmdir02.c:92: TPASS: rmdir() failed as expected: ENAMETOOLONG (36)
rmdir02.c:92: TPASS: rmdir() failed as expected: ENOENT (2)
rmdir02.c:92: TPASS: rmdir() failed as expected: ENOTDIR (20)
rmdir02.c:92: TPASS: rmdir() failed as expected: EFAULT (14)
rmdir02.c:92: TPASS: rmdir() failed as expected: ELOOP (40)
rmdir02.c:92: TPASS: rmdir() failed as expected: EROFS (30)
rmdir02.c:92: TPASS: rmdir() failed as expected: EBUSY (16)
rmdir02.c:92: TPASS: rmdir() failed as expected: EINVAL (22)

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drt_tgsigqueueinfo01 stime=3D1620367889
cmdline=3D"rt_tgsigqueueinfo01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
rt_tgsigqueueinfo01.c:65: TPASS: Test signal to self succeeded
rt_tgsigqueueinfo01.c:96: TPASS: Test signal to different thread succeeded
rt_tgsigqueueinfo01.c:96: TPASS: Test signal to different thread succeeded

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_rr_get_interval02 stime=3D1620367889
cmdline=3D"sched_rr_get_interval02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
sched_rr_get_interval02.c:34: TINFO: Testing variant: vDSO or syscall with =
libc spec
sched_rr_get_interval02.c:52: TPASS: sched_rr_get_interval() passed
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
sched_rr_get_interval02.c:34: TINFO: Testing variant: syscall with old kern=
el spec
sched_rr_get_interval02.c:52: TPASS: sched_rr_get_interval() passed

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setparam02 stime=3D1620367890
cmdline=3D"sched_setparam02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_setparam02    1  TPASS  :  Test with policy SCHED_FIFO Passed
sched_setparam02    2  TPASS  :  Test with policy SCHED_RR Passed
sched_setparam02    3  TPASS  :  Test with SCHED_OTHER Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setscheduler02 stime=3D1620367890
cmdline=3D"sched_setscheduler02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_setscheduler02    1  TPASS  :  got EPERM
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setaffinity01 stime=3D1620367890
cmdline=3D"sched_setaffinity01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: EFAULT (14)
sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: EINVAL (22)
sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: ESRCH (3)
sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: EPERM (1)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_getaffinity01 stime=3D1620367890
cmdline=3D"sched_getaffinity01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
sched_getaffinity01.c:88: TINFO: system has 4 processor(s).
sched_getaffinity01.c:76: TPASS: cpuset size =3D 128, enabled cpus 4
sched_getaffinity01.c:39: TPASS: sched_getaffinity() failed: EFAULT (14)
sched_getaffinity01.c:39: TPASS: sched_getaffinity() failed: EINVAL (22)
sched_getaffinity01.c:39: TPASS: sched_getaffinity() failed: ESRCH (3)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dselect03 stime=3D1620367890
cmdline=3D"select03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
select_var.h:109: TINFO: Testing libc select()
select03.c:65: TPASS: Negative nfds: select() failed as expected: EINVAL (2=
2)
select03.c:65: TPASS: Invalid readfds: select() failed as expected: EBADF (=
9)
select03.c:65: TPASS: Invalid writefds: select() failed as expected: EBADF =
(9)
select03.c:65: TPASS: Invalid exceptfds: select() failed as expected: EBADF=
 (9)
select03.c:65: TPASS: Faulty readfds: select() failed as expected: EFAULT (=
14)
select03.c:65: TPASS: Faulty writefds: select() failed as expected: EFAULT =
(14)
select03.c:65: TPASS: Faulty exceptfds: select() failed as expected: EFAULT=
 (14)
select03.c:65: TPASS: Faulty timeout: select() failed as expected: EFAULT (=
14)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
select_var.h:112: TINFO: Testing SYS_select syscall
select03.c:65: TPASS: Negative nfds: select() failed as expected: EINVAL (2=
2)
select03.c:65: TPASS: Invalid readfds: select() failed as expected: EBADF (=
9)
select03.c:65: TPASS: Invalid writefds: select() failed as expected: EBADF =
(9)
select03.c:65: TPASS: Invalid exceptfds: select() failed as expected: EBADF=
 (9)
select03.c:65: TPASS: Faulty readfds: select() failed as expected: EFAULT (=
14)
select03.c:65: TPASS: Faulty writefds: select() failed as expected: EFAULT =
(14)
select03.c:65: TPASS: Faulty exceptfds: select() failed as expected: EFAULT=
 (14)
select03.c:65: TPASS: Faulty timeout: select() failed as expected: EFAULT (=
14)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
select_var.h:115: TINFO: Testing SYS_pselect6 syscall
select03.c:65: TPASS: Negative nfds: select() failed as expected: EINVAL (2=
2)
select03.c:65: TPASS: Invalid readfds: select() failed as expected: EBADF (=
9)
select03.c:65: TPASS: Invalid writefds: select() failed as expected: EBADF =
(9)
select03.c:65: TPASS: Invalid exceptfds: select() failed as expected: EBADF=
 (9)
select03.c:65: TPASS: Faulty readfds: select() failed as expected: EFAULT (=
14)
select03.c:65: TPASS: Faulty writefds: select() failed as expected: EFAULT =
(14)
select03.c:65: TPASS: Faulty exceptfds: select() failed as expected: EFAULT=
 (14)
select03.c:65: TPASS: Faulty timeout: select() failed as expected: EFAULT (=
14)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
select_var.h:118: TINFO: Testing SYS_pselect6 time64 syscall
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
select_var.h:121: TINFO: Testing SYS__newselect syscall
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported

Summary:
passed   24
failed   0
broken   0
skipped  16
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemctl05 stime=3D1620367890
cmdline=3D"semctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
semctl05.c:45: TPASS: semctl() with the value to set is less than zero: ERA=
NGE (34)
semctl05.c:45: TPASS: semctl() with the value to set are too large: ERANGE =
(34)
semctl05.c:45: TPASS: semctl() with the value to set is too large: ERANGE (=
34)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile02 stime=3D1620367890
cmdline=3D"sendfile02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile02    1  TPASS  :  functionality of sendfile() is correct
sendfile02    2  TPASS  :  functionality of sendfile() is correct
sendfile02    3  TPASS  :  functionality of sendfile() is correct
sendfile02    4  TPASS  :  functionality of sendfile() is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile09_64 stime=3D1620367890
cmdline=3D"sendfile09_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile09_64    1  TPASS  :  Test sendfile(2) with offset at 0
sendfile09_64    2  TPASS  :  Test sendfile(2) with offset at 3GB
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D113
<<<test_end>>>
<<<test_start>>>
tag=3Dsendmsg03 stime=3D1620367891
cmdline=3D"sendmsg03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:522: TINFO: Minimum sampling period =
ended
=2E./../../../include/tst_fuzzy_sync.h:346: TINFO: loop =3D 1024, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg=
 =3D   -37ns, avg_dev =3D    12ns, dev_ratio =3D 0.32 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D  1845ns, avg_dev =3D   205ns, dev_ratio =3D 0.11 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D   797ns, avg_dev =3D   163ns, dev_ratio =3D 0.20 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D  1011ns, avg_dev =3D   154ns, dev_ratio =3D 0.15 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   645  , avg_dev =3D    98  , dev_ratio =3D 0.15 }
=2E./../../../include/tst_fuzzy_sync.h:534: TINFO: Reached deviation ratios=
 < 0.10, introducing randomness
=2E./../../../include/tst_fuzzy_sync.h:537: TINFO: Delay range is [-487, 94=
8]
=2E./../../../include/tst_fuzzy_sync.h:346: TINFO: loop =3D 1050, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg=
 =3D   -53ns, avg_dev =3D     5ns, dev_ratio =3D 0.09 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D  1519ns, avg_dev =3D    82ns, dev_ratio =3D 0.05 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D   782ns, avg_dev =3D    59ns, dev_ratio =3D 0.08 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D   685ns, avg_dev =3D    39ns, dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   428  , avg_dev =3D    26  , dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops=
, requesting exit
sendmsg03.c:100: TPASS: Nothing bad happened, probably

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D111 cstime=3D51
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsgid01 stime=3D1620367892
cmdline=3D"setfsgid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsgid01    1  TPASS  :  setfsgid() returned expected value : 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsgid01_16 stime=3D1620367892
cmdline=3D"setfsgid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsgid01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setfsgid/../utils/compat_16.h:122: 16-bit version of setfsgid() is not su=
pported on your platform
setfsgid01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setfsgid/../utils/compat_16.h:122: Remaining cases not appropriate for co=
nfiguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsuid04_16 stime=3D1620367892
cmdline=3D"setfsuid04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsuid04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setfsuid/../utils/compat_16.h:117: 16-bit version of setfsuid() is not su=
pported on your platform
setfsuid04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setfsuid/../utils/compat_16.h:117: Remaining cases not appropriate for co=
nfiguration
setfsuid04_16    0  TINFO  :  Child process returned TCONF
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgid03_16 stime=3D1620367892
cmdline=3D"setgid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/setgid/../utils/compat_tst_1=
6.h:94: TCONF: 16-bit version of setgid() is not supported on your platform

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetregid01_16 stime=3D1620367892
cmdline=3D"setregid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/setregid/../utils/compat_tst=
_16.h:128: TCONF: 16-bit version of setregid() is not supported on your pla=
tform

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresgid03_16 stime=3D1620367892
cmdline=3D"setresgid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresgid03_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresgid/../utils/compat_16.h:146: 16-bit version of setresgid() is not=
 supported on your platform
setresgid03_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresgid/../utils/compat_16.h:146: Remaining cases not appropriate for =
configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresuid03 stime=3D1620367892
cmdline=3D"setresuid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresuid03    1  TPASS  :  setresuid(65534, -1, -1) failed as expected.
setresuid03    0  TINFO  :  real uid =3D 0, effective uid =3D 2, and saved =
uid =3D 2 as expected
setresuid03    2  TPASS  :  setresuid(-1, -1, 65534) failed as expected.
setresuid03    0  TINFO  :  real uid =3D 0, effective uid =3D 2, and saved =
uid =3D 2 as expected
setresuid03    3  TPASS  :  setresuid(-1, 65534, -1) failed as expected.
setresuid03    0  TINFO  :  real uid =3D 0, effective uid =3D 2, and saved =
uid =3D 2 as expected
setresuid03    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresuid03_16 stime=3D1620367892
cmdline=3D"setresuid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresuid03_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresuid/../utils/compat_16.h:136: 16-bit version of setresuid() is not=
 supported on your platform
setresuid03_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresuid/../utils/compat_16.h:136: Remaining cases not appropriate for =
configuration
setresuid03_16    0  TINFO  :  Child process returned TCONF
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresuid05 stime=3D1620367892
cmdline=3D"setresuid05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresuid05    1  TPASS  :  setresuid succeeded as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetreuid01 stime=3D1620367892
cmdline=3D"setreuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setreuid01    1  TPASS  :  setreuid -  Don't change either real or effectiv=
e uid returned 0
setreuid01    2  TPASS  :  setreuid -  change effective to effective uid re=
turned 0
setreuid01    3  TPASS  :  setreuid -  change real to real uid returned 0
setreuid01    4  TPASS  :  setreuid -  change effective to real uid returne=
d 0
setreuid01    5  TPASS  :  setreuid -  try to change real to current real r=
eturned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetreuid04_16 stime=3D1620367892
cmdline=3D"setreuid04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setreuid04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setreuid/../utils/compat_16.h:127: 16-bit version of setreuid() is not su=
pported on your platform
setreuid04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscall=
s/setreuid/../utils/compat_16.h:127: Remaining cases not appropriate for co=
nfiguration
setreuid04_16    0  TINFO  :  Child process returned TCONF
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetsockopt07 stime=3D1620367892
cmdline=3D"setsockopt07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops=
, requesting exit
setsockopt07.c:120: TPASS: Cannot reproduce bug

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D19 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1289 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsetxattr03 stime=3D1620367911
cmdline=3D"setxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
setxattr03.c:98: TPASS: Set attr to immutable file: EPERM (1)
setxattr03.c:98: TPASS: Set attr to append-only file: EPERM (1)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmat01 stime=3D1620367911
cmdline=3D"shmat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
shmat01.c:124: TPASS: shmat() succeeded to attach NULL address
shmat01.c:124: TPASS: shmat() succeeded to attach aligned address
shmat01.c:124: TPASS: shmat() succeeded to attach unaligned address with SH=
M_RND
tst_coredump.c:32: TINFO: Avoid dumping corefile for process(pid=3D1327)
shmat01.c:124: TPASS: shmat() succeeded to attach aligned address with SHM_=
READONLY, and got SIGSEGV on write

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dshmctl04 stime=3D1620367911
cmdline=3D"shmctl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
shmctl04.c:119: TINFO: Test SHM_STAT_ANY with nobody user
shmctl04.c:137: TPASS: SHM_INFO returned valid index 3 maps to shmid 3
shmctl04.c:146: TPASS: Counted used =3D 2
shmctl04.c:85: TPASS: used_ids =3D 2
shmctl04.c:92: TPASS: shm_rss =3D 1007
shmctl04.c:99: TPASS: shm_swp =3D 0
shmctl04.c:106: TPASS: shm_tot =3D 1008
shmctl04.c:119: TINFO: Test SHM_STAT_ANY with root user
shmctl04.c:137: TPASS: SHM_INFO returned valid index 3 maps to shmid 3
shmctl04.c:146: TPASS: Counted used =3D 2
shmctl04.c:85: TPASS: used_ids =3D 2
shmctl04.c:92: TPASS: shm_rss =3D 1007
shmctl04.c:99: TPASS: shm_swp =3D 0
shmctl04.c:106: TPASS: shm_tot =3D 1008

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmget01 stime=3D1620367911
cmdline=3D"shmget01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
shmget01    1  TPASS  :  size, pid & mode are correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsigaltstack01 stime=3D1620367911
cmdline=3D"sigaltstack01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sigaltstack01    1  TPASS  :  Functionality of sigaltstack() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsighold02 stime=3D1620367911
cmdline=3D"sighold02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sighold02    1  TPASS  :  All signals were hold
sighold02    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsignal01 stime=3D1620367911
cmdline=3D"signal01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal01    1  TPASS  :  signal(SIGKILL, 0x1(SIG_IGN)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, (nil)(SIG_DFL)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, 0x55ee69fa1f60(catchsig())) failed=
 with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  Child killed with SIGKILL
signal01    2  TPASS  :  Child killed with SIGKILL
signal01    3  TPASS  :  Child killed with SIGKILL
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsocketcall03 stime=3D1620367911
cmdline=3D"socketcall03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
socketcall03.c:32: TCONF: syscall(-1) __NR_socketcall not supported

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstat02 stime=3D1620367911
cmdline=3D"stat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
stat02.c:67: TPASS: File size reported as expected
stat02.c:67: TPASS: File size reported as expected

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstat02_64 stime=3D1620367911
cmdline=3D"stat02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
stat02.c:67: TPASS: File size reported as expected
stat02.c:67: TPASS: File size reported as expected

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstat03 stime=3D1620367911
cmdline=3D"stat03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
stat03.c:55: TPASS: stat() failed as expected: EACCES (13)
stat03.c:55: TPASS: stat() failed as expected: EFAULT (14)
stat03.c:55: TPASS: stat() failed as expected: ENAMETOOLONG (36)
stat03.c:55: TPASS: stat() failed as expected: ENOENT (2)
stat03.c:55: TPASS: stat() failed as expected: ENOTDIR (20)
stat03.c:55: TPASS: stat() failed as expected: ELOOP (40)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatfs01 stime=3D1620367911
cmdline=3D"statfs01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs01    1  TPASS  :  statfs(tfile_1349, ..) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dstatvfs02 stime=3D1620367911
cmdline=3D"statvfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statvfs02    1  TPASS  :  statvfs() failed as expected: TEST_ERRNO=3DEFAULT=
(14): Bad address
statvfs02    2  TPASS  :  statvfs() failed as expected: TEST_ERRNO=3DELOOP(=
40): Too many levels of symbolic links
statvfs02    3  TPASS  :  statvfs() failed as expected: TEST_ERRNO=3DENAMET=
OOLONG(36): File name too long
statvfs02    4  TPASS  :  statvfs() failed as expected: TEST_ERRNO=3DENOENT=
(2): No such file or directory
statvfs02    5  TPASS  :  statvfs() failed as expected: TEST_ERRNO=3DENOTDI=
R(20): Not a directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dswapon03 stime=3D1620367911
cmdline=3D"swapon03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_ioctl.c:30: TINFO: FIBMAP ioctl is supported
libswap.c:59: TFAIL: swapon on f2fs failed: EINVAL (22)

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsync_file_range01 stime=3D1620367911
cmdline=3D"sync_file_range01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sync_file_range01    1  TPASS  :  got expected error: TEST_ERRNO=3DEBADF(9)=
: Bad file descriptor
sync_file_range01    2  TPASS  :  got expected error: TEST_ERRNO=3DESPIPE(2=
9): Illegal seek
sync_file_range01    3  TPASS  :  got expected error: TEST_ERRNO=3DEINVAL(2=
2): Invalid argument
sync_file_range01    4  TPASS  :  got expected error: TEST_ERRNO=3DEINVAL(2=
2): Invalid argument
sync_file_range01    5  TPASS  :  got expected error: TEST_ERRNO=3DEINVAL(2=
2): Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsysfs02 stime=3D1620367911
cmdline=3D"sysfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sysfs02     1  TPASS  :  sysfs(2) Passed for option 2
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsysfs04 stime=3D1620367911
cmdline=3D"sysfs04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sysfs04     1  TPASS  :  sysfs(2) expected failure; Got errno - EINVAL : In=
valid option
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog01 stime=3D1620367911
cmdline=3D"syslog01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog01    0  TINFO  :  Send messages to syslogd at some level=20
syslog01    0  TINFO  :  and facility and grep for those messages.
syslog01    0  TINFO  :  testing whether messages are logged into log file
syslog01    0  TINFO  :  restarting syslog daemon
syslog01    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D7 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog09 stime=3D1620367918
cmdline=3D"syslog09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog09    0  TINFO  :   Test setlogmask() with LOG_UPTO macro.
syslog09    0  TINFO  :   o Use setlogmask() with LOG_UPTO macro to set som=
e priority
syslog09    0  TINFO  :     level.
syslog09    0  TINFO  :   o Send message which is lower priority than the o=
ne
syslog09    0  TINFO  :     set above, which should not be logged
syslog09    0  TINFO  :  syslog: Testing setlogmask() with LOG_UPTO macro
syslog09    0  TINFO  :  restarting syslog daemon
syslog09    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dtimes03 stime=3D1620367924
cmdline=3D"times03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
times03.c:89: TPASS: buf1.tms_utime <=3D 5
times03.c:94: TPASS: buf1.tms_stime <=3D 5
times03.c:105: TPASS: buf2.tms_utime =3D 249
times03.c:112: TPASS: buf1.tms_utime (0) < buf2.tms_utime (249)
times03.c:118: TPASS: buf2.tms_stime =3D 141
times03.c:125: TPASS: buf1.tms_stime (0) < buf2.tms_stime (141)
times03.c:131: TPASS: buf2.tms_cutime =3D 0
times03.c:136: TPASS: buf2.tms_cstime =3D 0
times03.c:156: TPASS: buf2.tms_utime (249) <=3D buf3.tms_utime (249)
times03.c:164: TPASS: buf2.tms_stime (141) <=3D buf3.tms_stime (141)
times03.c:170: TPASS: buf3.tms_cutime =3D 262
times03.c:175: TPASS: buf3.tms_cstime =3D 137

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D8 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D512 cstime=3D279
<<<test_end>>>
<<<test_start>>>
tag=3Dtimer_getoverrun01 stime=3D1620367932
cmdline=3D"timer_getoverrun01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
timer_getoverrun01    1  TPASS  :  timer_getoverrun(CLOCK_REALTIME) Passed
timer_getoverrun01    2  TPASS  :  timer_gettime(-1) Failed: EINVAL
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dtkill02 stime=3D1620367932
cmdline=3D"tkill02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tkill02.c:48: TPASS: tst_syscall(__NR_tkill) expecting EINVAL: EINVAL (22)
tkill02.c:48: TPASS: tst_syscall(__NR_tkill) expecting ESRCH: ESRCH (3)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dtruncate03 stime=3D1620367932
cmdline=3D"truncate03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
truncate03.c:132: TPASS: truncate() failed as expected: EACCES (13)
truncate03.c:132: TPASS: truncate() failed as expected: ENOTDIR (20)
truncate03.c:132: TPASS: truncate() failed as expected: EFAULT (14)
truncate03.c:132: TPASS: truncate() failed as expected: ENAMETOOLONG (36)
truncate03.c:132: TPASS: truncate() failed as expected: ENOENT (2)
truncate03.c:132: TPASS: truncate() failed as expected: EISDIR (21)
truncate03.c:132: TPASS: truncate() failed as expected: EFBIG (27)
truncate03.c:132: TPASS: truncate() failed as expected: ELOOP (40)

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dumask01 stime=3D1620367932
cmdline=3D"umask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
umask01.c:57: TPASS: All files created with correct mode

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dunlink05 stime=3D1620367932
cmdline=3D"unlink05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
unlink05.c:61: TPASS: unlink(file) succeeded
unlink05.c:61: TPASS: unlink(fifo) succeeded

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dumount2_02 stime=3D1620367932
cmdline=3D"umount2_02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
umount2_02    0  TINFO  :  Found free device 0 '/dev/loop0'
umount2_02    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra =
opts=3D''
umount2_02    1  TPASS  :  umount2(2) failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
umount2_02    2  TPASS  :  umount2(2) failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
umount2_02    3  TPASS  :  umount2(2) failed as expected: TEST_ERRNO=3DEAGA=
IN/EWOULDBLOCK(11): Resource temporarily unavailable
umount2_02    4  TPASS  :  umount2(2) failed as expected: TEST_ERRNO=3DEAGA=
IN/EWOULDBLOCK(11): Resource temporarily unavailable
umount2_02    5  TPASS  :  umount2(2) succeeded as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dustat01 stime=3D1620367932
cmdline=3D"ustat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
ustat01.c:31: TPASS: ustat(2) passed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dutime01A stime=3D1620367932
cmdline=3D"symlink01 -T utime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
utime01     1  TPASS  :  utime(2) change of object file access and modify t=
imes through symbolic link file is ok
utime01     2  TPASS  :  utime(2) error when accessing non-existent object =
through symbolic link is caught
utime01     3  TPASS  :  Nested symbolic link access condition caught.  ELO=
OP is returned
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dvmsplice01 stime=3D1620367932
cmdline=3D"vmsplice01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_test.c:1063: TINFO: f2fs is supported by the test
vmsplice01.c:45: TPASS: Written data has been read back correctly

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid03 stime=3D1620367932
cmdline=3D"waitpid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitpid03    1  TPASS  :  Got correct child PID
waitpid03    2  TPASS  :  Condition 2 test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid04 stime=3D1620367932
cmdline=3D"waitpid04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitpid04    1  TPASS  :  condition 1 test passed
waitpid04    2  TPASS  :  condition 2 test passed
waitpid04    3  TPASS  :  condition 3 test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitid02 stime=3D1620367932
cmdline=3D"waitid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(2, 1548, 0x7fffe02d2d60, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1550 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(2, 1548, 0x7fffe02d2d60, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1550 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(1, 1551, 0x7fffe02d2d60, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1551 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(2, 1548, 0x7fffe02d2d60, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1550 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(1, 1551, 0x7fffe02d2d60, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1551 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1548) waitid(1, 1552, 0x7fffe02d2d60, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1552 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(2, 1548, 0x7fffe02d2d60, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1550 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(1, 1551, 0x7fffe02d2d60, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1551 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1548) waitid(1, 1552, 0x7fffe02d2d60, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1552 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1548) waitid(1, 1553, 0x7fffe02d2d60, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1553 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1548) waitid(0, 0, 0x7fffe02d2d60, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(2, 1548, 0x7fffe02d2d60, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1550 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1548) waitid(1, 1551, 0x7fffe02d2d60, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1551 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1548) waitid(1, 1552, 0x7fffe02d2d60, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1552 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1548) waitid(1, 1553, 0x7fffe02d2d60, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1553 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  P_PID, WEXITED not a child of the calling process
waitid02    0  TINFO  :  (1548) waitid(1, 1, 0x7fffe02d2d60, 4)
waitid02    8  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite02 stime=3D1620367932
cmdline=3D"write02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
write02.c:25: TPASS: write(fd, NULL, 0) =3D=3D 0

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite04 stime=3D1620367932
cmdline=3D"write04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
write04.c:46: TPASS: write() failed expectedly: EAGAIN/EWOULDBLOCK (11)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwritev01 stime=3D1620367932
cmdline=3D"writev01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
writev01.c:127: TPASS: invalid iov_len, expected: -1 (EINVAL), got: -1 (EIN=
VAL)
writev01.c:127: TPASS: invalid fd, expected: -1 (EBADF), got: -1 (EBADF)
writev01.c:127: TPASS: invalid iovcnt, expected: -1 (EINVAL), got: -1 (EINV=
AL)
writev01.c:131: TPASS: zero iovcnt, expected: 0, got: 0
writev01.c:131: TPASS: NULL and zero length iovec, expected: 64, got: 64
writev01.c:127: TPASS: write to closed pipe, expected: -1 (EPIPE), got: -1 =
(EPIPE)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfutex_cmp_requeue02 stime=3D1620367932
cmdline=3D"futex_cmp_requeue02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
futex_cmp_requeue02.c:71: TINFO: Testing variant: syscall with old kernel s=
pec
futex_cmp_requeue02.c:64: TPASS: futex_cmp_requeue() failed as expected: EI=
NVAL (22)
futex_cmp_requeue02.c:64: TPASS: futex_cmp_requeue() failed as expected: EI=
NVAL (22)
futex_cmp_requeue02.c:64: TPASS: futex_cmp_requeue() failed as expected: EA=
GAIN/EWOULDBLOCK (11)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmemfd_create04 stime=3D1620367932
cmdline=3D"memfd_create04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
memfd_create04.c:67: TINFO: Attempt to create file using 64kB huge page size
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 512kB huge page si=
ze
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 2048kB huge page s=
ize
memfd_create04.c:81: TPASS: memfd_create succeeded for 2048kB page size
memfd_create04.c:67: TINFO: Attempt to create file using 8192kB huge page s=
ize
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 16384kB huge page =
size
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 262144kB huge page=
 size
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 1048576kB huge pag=
e size
memfd_create04.c:81: TPASS: memfd_create succeeded for 1048576kB page size
memfd_create04.c:67: TINFO: Attempt to create file using 2097152kB huge pag=
e size
memfd_create04.c:72: TPASS: Test failed as expected
memfd_create04.c:67: TINFO: Attempt to create file using 16777216kB huge pa=
ge size
memfd_create04.c:72: TPASS: Test failed as expected

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatx06 stime=3D1620367932
cmdline=3D"statx06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext4 opts=3D'-I 256' extr=
a opts=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
statx06.c:156: TPASS: Birth time Passed
statx06.c:156: TPASS: Modified time Passed
statx06.c:156: TPASS: Access time Passed
statx06.c:156: TPASS: Change time Passed

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20210121-303-gfad5cecb2

       ###############################################################

            Done executing testcases.
            LTP Version:  20210121-303-gfad5cecb2
       ###############################################################


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/ltp-syscalls.yaml
suite: ltp
testcase: ltp
category: functional
need_modules: true
need_memory: 4G
disk: 1HDD
fs: f2fs
ltp:
  test: syscalls-04
job_origin: ltp-syscalls.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d02
tbox_group: lkp-skl-d02
kconfig: x86_64-rhel-8.3
submit_id: 6052a38ca0301b6ef167e17c
job_file: "/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-36e4d95891ed37eb98a660babec749be3fb35fd9-20210318-28401-1xvina9-0.yaml"
id: 30319a4cc91d102416ce5ad17f76b88943ec9684
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d02
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c500746fa0cc-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e41514d5105-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e41514d5105-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

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
- CONFIG_BLK_DEV_LOOP
- CONFIG_CAN=m
- CONFIG_CAN_RAW=m
- CONFIG_CAN_VCAN=m
- CONFIG_IPV6_VTI=m
- CONFIG_MINIX_FS=m
- CONFIG_F2FS_FS

#! include/ltp

#! include/queue/cyclic
commit: 36e4d95891ed37eb98a660babec749be3fb35fd9

#! include/testbox/lkp-skl-d02
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'

#! include/fs/OTHERS
enqueue_time: 2021-03-18 08:49:17.322713927 +08:00
_id: 6052a38ca0301b6ef167e17c
_rt: "/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: b17d1962eaed02561770a6b9535970c09d94e809
base_commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
branch: linux-devel/devel-hourly-20210315-211352
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/0"
scheduler_version: "/lkp/lkp/.src-20210317-223051"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-36e4d95891ed37eb98a660babec749be3fb35fd9-20210318-28401-1xvina9-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210315-211352
- commit=36e4d95891ed37eb98a660babec749be3fb35fd9
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/vmlinuz-5.12.0-rc2-00408-g36e4d95891ed
- max_uptime=2100
- RESULT_ROOT=/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210318.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210318.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210315-185726/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.12.0-rc2-00404-g72f85881249e

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/36e4d95891ed37eb98a660babec749be3fb35fd9/vmlinuz-5.12.0-rc2-00408-g36e4d95891ed"
dequeue_time: 2021-03-18 09:08:03.817514422 +08:00

#! /lkp/lkp/.src-20210317-223051/include/site/inn
job_state: finished
loadavg: 1.52 0.83 0.34 1/205 1666
start_time: '1616029769'
end_time: '1616029943'
version: "/lkp/lkp/.src-20210317-223123:97355abf:667abbe78"

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sda1
mkfs -t f2fs /dev/sda1
mkdir -p /fs/sda1
mount -t f2fs /dev/sda1 /fs/sda1
ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
./runltp -f syscalls-04 -d /fs/sda1/tmpdir

--7AUc2qLy4jB3hD7Z--
