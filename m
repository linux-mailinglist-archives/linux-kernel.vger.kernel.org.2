Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7943308A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhCHHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:10:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:31008 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235130AbhCHHKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:10:02 -0500
IronPort-SDR: NLyUi/T36fjOfaaavVGtDvnYPqwkB40TloJsLNLz3s1jDFadokKYiQ0Tlyg8PihSJI/wnX7eod
 qS16LNmvhd7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="187340056"
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="xz'?yaml'?scan'208";a="187340056"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 23:10:00 -0800
IronPort-SDR: S9sNZYEt2rxT5oWiUwB22U1LH7fxw8gFEs6wT3Bdx7bL909IF+yxjLs/FMP610GwoqFMRaMP3F
 MqPejfqzCx7A==
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="xz'?yaml'?scan'208";a="402719933"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 23:09:55 -0800
Date:   Mon, 8 Mar 2021 15:25:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "huangjianan@oppo.com" <huangjianan@oppo.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Guo Weichao <guoweichao@oppo.com>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ltp@lists.linux.it
Subject: [f2fs]  02eb84b96b: ltp.swapon03.fail
Message-ID: <20210308072510.GA902@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 02eb84b96bc1b382dd138bf60724edbefe77b025 ("f2fs: check if swapfile =
is section-alligned")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


in testcase: ltp
version: ltp-x86_64-14c1f76-1_20210101
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

2021-03-07 13:10:24 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-03-07 13:10:24 ./runltp -f syscalls-04 -d /fs/sda1/tmpdir
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
Linux lkp-skl-d02 5.12.0-rc1-00035-g02eb84b96bc1 #1 SMP Sun Mar 7 16:22:41 =
CST 2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=3D0xe2-debian-10.4-x86_64=
-20200603.cgz-02eb84b96bc1b382dd138bf60724edbefe77b025-20210307-16679-r5zcd=
x-5.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinux-next/master=
 commit=3D02eb84b96bc1b382dd138bf60724edbefe77b025 BOOT_IMAGE=3D/pkg/linux/=
x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/vmlinuz-5.12=
=2E0-rc1-00035-g02eb84b96bc1 max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1H=
DD-f2fs-syscalls-04-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cg=
z/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/3 LKP_SERV=
ER=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_alway=
s_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkm=
sg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic l=
oad_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=
=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3D=
ttyS0,115200 vga=3Dnormal rw

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
ntel_powerclamp coretemp i915 kvm_intel kvm irqbypass crct10dif_pclmul crc3=
2_pclmul crc32c_intel intel_gtt ghash_clmulni_intel mei_wdt wmi_bmof drm_km=
s_helper ahci libahci rapl syscopyarea sysfillrect intel_cstate sysimgblt f=
b_sys_fops intel_uncore libata drm mei_me mei intel_pch_thermal wmi video i=
ntel_pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32754220      348480    29902736       21784     2503004    2967=
3932
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
CPU MHz:             422.643
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
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2555     -n 2555 -=
p -f /fs/sda1/tmpdir/ltp-7md7OvElFS/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_03_07-13h_10m_24s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_03_07-13h_10m_24s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_03_07-13h_10m_24s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_03_07-13h_10m_24s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_03_07-13h_1=
0m_24s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_03_07-13h_10=
m_24s.tconf
Running tests.......
<<<test_start>>>
tag=3Daccess01 stime=3D1615122624
cmdline=3D"access01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dcapset04 stime=3D1615122624
cmdline=3D"capset04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dchown03_16 stime=3D1615122624
cmdline=3D"chown03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chown03_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/c=
hown/../utils/compat_16.h:166: 16-bit version of chown() is not supported o=
n your platform
chown03_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/c=
hown/../utils/compat_16.h:166: Remaining cases not appropriate for configur=
ation
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchroot01 stime=3D1615122624
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
tag=3Dclock_nanosleep03 stime=3D1615122624
cmdline=3D"clock_nanosleep03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:63: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:53: TINFO: Testing variant: vDSO or syscall with libc s=
pec
clock_nanosleep03.c:100: TPASS: clock_nanosleep() slept correctly 100227
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:53: TINFO: Testing variant: syscall with old kernel spec
clock_nanosleep03.c:100: TPASS: clock_nanosleep() slept correctly 100188

Summary:
passed   2
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
tag=3Dclock_gettime01 stime=3D1615122625
cmdline=3D"clock_gettime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_settime02 stime=3D1615122625
cmdline=3D"clock_settime02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dclone02 stime=3D1615122625
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
tag=3Dclone04 stime=3D1615122625
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
tag=3Dclone08 stime=3D1615122625
cmdline=3D"clone08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dconnect02 stime=3D1615122625
cmdline=3D"connect02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Ddelete_module01 stime=3D1615122625
cmdline=3D"delete_module01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Ddup01 stime=3D1615122625
cmdline=3D"dup01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Ddup07 stime=3D1615122625
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
tag=3Ddup3_01 stime=3D1615122625
cmdline=3D"dup3_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dup3_01     1  TPASS  :  dup3(O_CLOEXEC) PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexecl01 stime=3D1615122625
cmdline=3D"execl01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dexecvp01 stime=3D1615122625
cmdline=3D"execvp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfchown04_16 stime=3D1615122625
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
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dfchownat02 stime=3D1615122625
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
tag=3Dfcntl08_64 stime=3D1615122625
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
tag=3Dfcntl14_64 stime=3D1615122625
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
cutime=3D3 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl23_64 stime=3D1615122630
cmdline=3D"fcntl23_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl23     1  TPASS  :  fcntl(tfile_2999, F_SETLEASE, F_RDLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl37_64 stime=3D1615122630
cmdline=3D"fcntl37_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dfdatasync01 stime=3D1615122630
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
tag=3Dfdatasync02 stime=3D1615122630
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dflock02 stime=3D1615122630
cmdline=3D"flock02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dflock04 stime=3D1615122631
cmdline=3D"flock04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dfmtmsg01 stime=3D1615122631
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
tag=3Dfork01 stime=3D1615122631
cmdline=3D"fork01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork01      1  TPASS  :  fork() returned 3014
fork01      2  TPASS  :  child pid and fork() return agree: 3014
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork13 stime=3D1615122631
cmdline=3D"fork13 -i 1000000"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork13      1  TPASS  :  1000000 pids forked, all passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D103 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D6911 cstime=3D3760
<<<test_end>>>
<<<test_start>>>
tag=3Dfsopen02 stime=3D1615122734
cmdline=3D"fsopen02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfstatat01 stime=3D1615122734
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
tag=3Dfsync02 stime=3D1615122734
cmdline=3D"fsync02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync02.c:99: TPASS: fsync succeeded in an acceptable amount of time

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dfsync04 stime=3D1615122735
cmdline=3D"fsync04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: TINFO: Kernel supports ext2
tst_supported_fs_types.c:44: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext3
tst_supported_fs_types.c:44: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext4
tst_supported_fs_types.c:44: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports xfs
tst_supported_fs_types.c:44: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:44: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports vfat
tst_supported_fs_types.c:44: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:83: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:92: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:44: TINFO: mkfs.ntfs does exist
tst_test.c:1329: TINFO: Testing on ext2
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on ext3
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on ext4
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on xfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on btrfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on vfat
tst_test.c:859: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on ntfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:870: TINFO: Trying FUSE...
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D8 cstime=3D115
<<<test_end>>>
<<<test_start>>>
tag=3Dgetdomainname01 stime=3D1615122741
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
tag=3Dgeteuid01_16 stime=3D1615122741
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
tag=3Dgetitimer01 stime=3D1615122741
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
tag=3Dgetitimer02 stime=3D1615122741
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
tag=3Dgetresgid03_16 stime=3D1615122741
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
tag=3Dgetresuid03_16 stime=3D1615122741
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
tag=3Dgetsid01 stime=3D1615122741
cmdline=3D"getsid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getsid01    1  TPASS  :  session ID is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsockopt02 stime=3D1615122741
cmdline=3D"getsockopt02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dgetxattr03 stime=3D1615122741
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
tag=3Dioctl_loop07 stime=3D1615122741
cmdline=3D"ioctl_loop07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D14
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_ns03 stime=3D1615122743
cmdline=3D"ioctl_ns03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dfanotify09 stime=3D1615122743
cmdline=3D"fanotify09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fanotify09.c:242: TINFO: Test #0: Events on non-dir child with both parent =
and mount marks
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/tfile_858
fanotify09.c:331: TPASS: group 1 got no event
fanotify09.c:331: TPASS: group 2 got no event
fanotify09.c:242: TINFO: Test #1: Events on non-dir child and subdir with b=
oth parent and mount marks
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/tfile_858
fanotify09.c:187: TPASS: group 0 got event: mask 10 pid=3D858 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testdir
fanotify09.c:331: TPASS: group 1 got no event
fanotify09.c:331: TPASS: group 2 got no event
fanotify09.c:242: TINFO: Test #2: Events on non-dir child and parent with b=
oth parent and mount marks
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/tfile_858
fanotify09.c:187: TPASS: group 0 got event: mask 10 pid=3D858 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint
fanotify09.c:331: TPASS: group 1 got no event
fanotify09.c:331: TPASS: group 2 got no event
fanotify09.c:242: TINFO: Test #3: Events on non-dir child and subdir with b=
oth parent and subdir marks
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/tfile_858
fanotify09.c:187: TPASS: group 0 got event: mask 10 pid=3D858 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testdir
fanotify09.c:331: TPASS: group 1 got no event
fanotify09.c:331: TPASS: group 2 got no event
fanotify09.c:242: TINFO: Test #4: Events on non-dir children with both pare=
nt and mount marks
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/tfile_858
fanotify09.c:187: TPASS: group 0 got event: mask 10 pid=3D858 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testfile
fanotify09.c:187: TPASS: group 1 got event: mask 10 pid=3D858 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testfile
fanotify09.c:187: TPASS: group 2 got event: mask 10 pid=3D858 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testfile
fanotify09.c:242: TINFO: Test #5: Events on non-dir child with both parent =
and mount marks and filename info
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D-1 filena=
me=3Dtfile_858
fanotify09.c:187: TPASS: group 0 got event: mask 10 pid=3D858 fd=3D-1 filen=
ame=3Dtestfile
fanotify09.c:187: TPASS: group 1 got event: mask 10 pid=3D858 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testfile
fanotify09.c:187: TPASS: group 2 got event: mask 10 pid=3D858 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testfile

Summary:
passed   23
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dkeyctl06 stime=3D1615122743
cmdline=3D"keyctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkcmp01 stime=3D1615122743
cmdline=3D"kcmp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dkill08 stime=3D1615122743
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
tag=3Dkill09 stime=3D1615122743
cmdline=3D"kill09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill09      1  TPASS  :  kill(880, SIGKILL) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown01_16 stime=3D1615122743
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown02_16 stime=3D1615122743
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
tag=3Dlgetxattr01 stime=3D1615122743
cmdline=3D"lgetxattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dlgetxattr02 stime=3D1615122743
cmdline=3D"lgetxattr02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dlink04 stime=3D1615122743
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
tag=3Dlink05 stime=3D1615122743
cmdline=3D"link05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link05      1  TPASS  :  link(lkfile_888, lkfile_888[1-1000]) ret 0 for 100=
0 files,stat linkcounts match 1000
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dlstat02 stime=3D1615122743
cmdline=3D"lstat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmbind01 stime=3D1615122744
cmdline=3D"mbind01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmemcpy01 stime=3D1615122744
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
tag=3Dmknod01 stime=3D1615122744
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
tag=3Dmknod07 stime=3D1615122744
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
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap06 stime=3D1615122744
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
tag=3Dmmap07 stime=3D1615122744
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
tag=3Dmount06 stime=3D1615122744
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
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages03 stime=3D1615122744
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages11 stime=3D1615122744
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
duration=3D1 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_timedreceive01 stime=3D1615122745
cmdline=3D"mq_timedreceive01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap02 stime=3D1615122745
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
tag=3Dmsgctl04 stime=3D1615122745
cmdline=3D"msgctl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
msgctl04.c:59: TPASS: msgctl(1, 2, 0x555c217a9740): EACCES (13)
msgctl04.c:59: TPASS: msgctl(2, 2, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, 1, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, -1, 0x555c217a9740): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 2, 0x555c217a9740): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 1, 0x555c217a9740): EINVAL (22)
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
tag=3Dmsgget01 stime=3D1615122745
cmdline=3D"msgget01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dmsgrcv01 stime=3D1615122745
cmdline=3D"msgrcv01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
msgrcv01.c:38: TPASS: message received(hello) =3D message sent(hello)
msgrcv01.c:45: TPASS: queue bytes and number of queues matched
msgrcv01.c:49: TPASS: PID of last msgrcv(2) matched
msgrcv01.c:56: TPASS: msg_rtime =3D 1615122745 in [1615122745, 1615122745]

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
tag=3Dmunmap03 stime=3D1615122745
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
tag=3Dnice02 stime=3D1615122745
cmdline=3D"nice02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dnice03 stime=3D1615122745
cmdline=3D"nice03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dopen08 stime=3D1615122745
cmdline=3D"open08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dopen09 stime=3D1615122745
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
tag=3Dopenat02 stime=3D1615122745
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
tag=3Dopenat202 stime=3D1615122745
cmdline=3D"openat202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dopen_by_handle_at02 stime=3D1615122745
cmdline=3D"open_by_handle_at02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
tst_buffers.c:55: TINFO: Test is using guarded buffers
open_by_handle_at02.c:100: TPASS: invalid-dfd: open_by_handle_at() failed a=
s expected: EBADF (9)
open_by_handle_at02.c:100: TPASS: stale-dfd: open_by_handle_at() failed as =
expected: ESTALE (116)
open_by_handle_at02.c:100: TPASS: invalid-file-handle: open_by_handle_at() =
failed as expected: EFAULT (14)
open_by_handle_at02.c:100: TPASS: high-file-handle-size: open_by_handle_at(=
) failed as expected: EINVAL (22)
open_by_handle_at02.c:100: TPASS: zero-file-handle-size: open_by_handle_at(=
) failed as expected: EINVAL (22)
tst_capability.c:29: TINFO: Dropping CAP_DAC_READ_SEARCH(2)
tst_capability.c:41: TINFO: Permitting CAP_DAC_READ_SEARCH(2)
open_by_handle_at02.c:100: TPASS: no-capability: open_by_handle_at() failed=
 as expected: EPERM (1)
open_by_handle_at02.c:100: TPASS: symlink: open_by_handle_at() failed as ex=
pected: ELOOP (40)

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
tag=3Dmincore01 stime=3D1615122745
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dnewuname01 stime=3D1615122745
cmdline=3D"newuname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
newuname01    1  TPASS  :  newuname call succeed: return value =3D 0=20
newuname01    0  TINFO  :  This system is Linux
newuname01    0  TINFO  :  The system infomation is :
newuname01    0  TINFO  :  System is Linux on x86_64 hardware
newuname01    0  TINFO  :  Nodename is lkp-skl-d02
newuname01    0  TINFO  :  Version is 5.12.0-rc1-00035-g02eb84b96bc1, #1 SM=
P Sun Mar 7 16:22:41 CST 2021
newuname01    0  TINFO  :  Domainname is (none)=20
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe02 stime=3D1615122745
cmdline=3D"pipe02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe03 stime=3D1615122745
cmdline=3D"pipe03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dpivot_root01 stime=3D1615122745
cmdline=3D"pivot_root01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dprctl03 stime=3D1615122745
cmdline=3D"prctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
prctl03.c:73: TPASS: prctl(PR_SET_CHILD_SUBREAPER) succeeded
prctl03.c:46: TPASS: prctl(PR_GET_CHILD_SUBREAPER) got expected 0
prctl03.c:88: TPASS: PPID of orphaned process was reparented
prctl03.c:101: TPASS: wait() got orphaned process, pid 960, status 0
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
tag=3Dprctl05 stime=3D1615122745
cmdline=3D"prctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est
prctl05.c:62: TPASS: /proc/self/task/962/comm =3D 'prctl05_test'
prctl05.c:63: TPASS: /proc/self/comm =3D 'prctl05_test'
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test_xxxxx') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est_xx
prctl05.c:62: TPASS: /proc/self/task/962/comm =3D 'prctl05_test_xx'
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
tag=3Dpread02 stime=3D1615122745
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
tag=3Dpreadv01_64 stime=3D1615122745
cmdline=3D"preadv01_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dpreadv02_64 stime=3D1615122745
cmdline=3D"preadv02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dprot_hsymlinks stime=3D1615122745
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
prot_hsymlinks  392  TPASS  :  Expect: can create userdel: hsym mail spool =
(/var/mail/hsym) not found
userdel: hsym home directory (/home/hsym) not found
hardlink '.../tmp_hsym/hsym/local_hsym.hs' to '.../link_248', owner 'hsym',=
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
prot_hsymlinks    0  TINFO  :  All test-cases have been completed, summary:
 - symlinks  test:	PASS
 - hardlinks test:	PASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace08 stime=3D1615122745
cmdline=3D"ptrace08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
tst_kernel.c:79: TINFO: uname.machine=3Dx86_64 kernel is 64bit
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev01 stime=3D1615122745
cmdline=3D"pwritev01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dpwritev01_64 stime=3D1615122745
cmdline=3D"pwritev01_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dquotactl03 stime=3D1615122745
cmdline=3D"quotactl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:63: TINFO: Parsing kernel config '/proc/config.gz'
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D5
<<<test_end>>>
<<<test_start>>>
tag=3Dreadlink01A stime=3D1615122745
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
tag=3Dreboot02 stime=3D1615122745
cmdline=3D"reboot02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
reboot02    1  TPASS  :  reboot(2) expected failure; Got errno - EINVAL : I=
nvalid flag
reboot02    1  TPASS  :  reboot(2) expected failure; Got errno - EPERM  : P=
ermission denied
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dremap_file_pages01 stime=3D1615122745
cmdline=3D"remap_file_pages01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
remap_file_pages01    1  TPASS  :  Non-Linear shm file OK
remap_file_pages01    2  TPASS  :  Non-Linear /tmp/ file OK
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dremap_file_pages02 stime=3D1615122745
cmdline=3D"remap_file_pages02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Drename04 stime=3D1615122745
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
tag=3Drenameat201 stime=3D1615122745
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Drmdir02 stime=3D1615122745
cmdline=3D"rmdir02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drt_tgsigqueueinfo01 stime=3D1615122746
cmdline=3D"rt_tgsigqueueinfo01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_rr_get_interval02 stime=3D1615122746
cmdline=3D"sched_rr_get_interval02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
sched_rr_get_interval02.c:34: TINFO: Testing variant: vDSO or syscall with =
libc spec
sched_rr_get_interval02.c:52: TPASS: sched_rr_get_interval() passed
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setparam02 stime=3D1615122746
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
tag=3Dsched_setscheduler02 stime=3D1615122746
cmdline=3D"sched_setscheduler02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_setscheduler02    1  TPASS  :  got EPERM
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setaffinity01 stime=3D1615122746
cmdline=3D"sched_setaffinity01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dsched_getaffinity01 stime=3D1615122746
cmdline=3D"sched_getaffinity01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dselect03 stime=3D1615122746
cmdline=3D"select03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
select_var.h:118: TINFO: Testing SYS_pselect6 time64 syscall
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemctl05 stime=3D1615122746
cmdline=3D"semctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
semctl05    1  TPASS  :  expected failure - errno =3D 34 : Numerical result=
 out of range
semctl05    2  TPASS  :  expected failure - errno =3D 34 : Numerical result=
 out of range
semctl05    3  TPASS  :  expected failure - errno =3D 34 : Numerical result=
 out of range
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile02 stime=3D1615122746
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile09_64 stime=3D1615122746
cmdline=3D"sendfile09_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile09_64    1  TPASS  :  Test sendfile(2) with offset at 0
sendfile09_64    2  TPASS  :  Test sendfile(2) with offset at 3GB
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D111
<<<test_end>>>
<<<test_start>>>
tag=3Dsendmsg03 stime=3D1615122747
cmdline=3D"sendmsg03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:507: TINFO: Minimum sampling period =
ended
=2E./../../../include/tst_fuzzy_sync.h:331: TINFO: loop =3D 1024, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: start_a - start_b: { avg=
 =3D   -43ns, avg_dev =3D     9ns, dev_ratio =3D 0.20 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - start_a  : { avg=
 =3D  1420ns, avg_dev =3D    38ns, dev_ratio =3D 0.03 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_b - start_b  : { avg=
 =3D   761ns, avg_dev =3D    12ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - end_b    : { avg=
 =3D   615ns, avg_dev =3D    36ns, dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: spins            : { avg=
 =3D   401  , avg_dev =3D    24  , dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:519: TINFO: Reached deviation ratios=
 < 0.10, introducing randomness
=2E./../../../include/tst_fuzzy_sync.h:522: TINFO: Delay range is [-489, 91=
2]
=2E./../../../include/tst_fuzzy_sync.h:331: TINFO: loop =3D 1069, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: start_a - start_b: { avg=
 =3D   -40ns, avg_dev =3D     4ns, dev_ratio =3D 0.10 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - start_a  : { avg=
 =3D  1413ns, avg_dev =3D    27ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_b - start_b  : { avg=
 =3D   759ns, avg_dev =3D    14ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - end_b    : { avg=
 =3D   615ns, avg_dev =3D    31ns, dev_ratio =3D 0.05 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: spins            : { avg=
 =3D   397  , avg_dev =3D    18  , dev_ratio =3D 0.05 }
=2E./../../../include/tst_fuzzy_sync.h:643: TINFO: Exceeded execution loops=
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
cutime=3D115 cstime=3D44
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsgid01 stime=3D1615122748
cmdline=3D"setfsgid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsgid01    1  TPASS  :  setfsgid() returned expected value : 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsgid01_16 stime=3D1615122748
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
tag=3Dsetfsuid04_16 stime=3D1615122748
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
tag=3Dsetgid03_16 stime=3D1615122748
cmdline=3D"setgid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgid03_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
setgid/../utils/compat_16.h:97: 16-bit version of setgid() is not supported=
 on your platform
setgid03_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
setgid/../utils/compat_16.h:97: Remaining cases not appropriate for configu=
ration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetregid01_16 stime=3D1615122748
cmdline=3D"setregid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dsetresgid03_16 stime=3D1615122748
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
tag=3Dsetresuid03 stime=3D1615122748
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
tag=3Dsetresuid03_16 stime=3D1615122748
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
tag=3Dsetresuid05 stime=3D1615122748
cmdline=3D"setresuid05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresuid05    1  TPASS  :  setresuid succeeded as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetreuid01 stime=3D1615122748
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
tag=3Dsetreuid04_16 stime=3D1615122748
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
tag=3Dsetsockopt07 stime=3D1615122748
cmdline=3D"setsockopt07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:63: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:643: TINFO: Exceeded execution loops=
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
cutime=3D1315 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsetxattr03 stime=3D1615122767
cmdline=3D"setxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dshmat01 stime=3D1615122767
cmdline=3D"shmat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
shmat01.c:124: TPASS: shmat() succeeded to attach NULL address
shmat01.c:124: TPASS: shmat() succeeded to attach aligned address
shmat01.c:124: TPASS: shmat() succeeded to attach unaligned address with SH=
M_RND
tst_coredump.c:32: TINFO: Avoid dumping corefile for process(pid=3D1182)
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
tag=3Dshmctl04 stime=3D1615122767
cmdline=3D"shmctl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmget01 stime=3D1615122767
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
tag=3Dsigaltstack01 stime=3D1615122767
cmdline=3D"sigaltstack01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sigaltstack01    1  TPASS  :  Functionality of sigaltstack() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsighold02 stime=3D1615122767
cmdline=3D"sighold02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sighold02    1  TPASS  :  All signals were hold
sighold02    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsignal01 stime=3D1615122768
cmdline=3D"signal01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal01    1  TPASS  :  signal(SIGKILL, 0x1(SIG_IGN)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, (nil)(SIG_DFL)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, 0x562310700f00(catchsig())) failed=
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
tag=3Dsocketcall03 stime=3D1615122768
cmdline=3D"socketcall03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dstat02 stime=3D1615122768
cmdline=3D"stat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dstat02_64 stime=3D1615122768
cmdline=3D"stat02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dstat03 stime=3D1615122768
cmdline=3D"stat03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dstatfs01 stime=3D1615122768
cmdline=3D"statfs01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs01    1  TPASS  :  statfs(tfile_1207, ..) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatvfs02 stime=3D1615122768
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
tag=3Dswapon03 stime=3D1615122768
cmdline=3D"swapon03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_ioctl.c:30: TINFO: FIBMAP ioctl is supported
swapon03    1  TFAIL  :  ../swapon/libswapon.c:81: swapon on F2FS failed: e=
rrno=3DEINVAL(22): Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsync_file_range01 stime=3D1615122768
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
tag=3Dsysfs02 stime=3D1615122768
cmdline=3D"sysfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sysfs02     1  TPASS  :  sysfs(2) Passed for option 2
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsysfs04 stime=3D1615122768
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
tag=3Dsyslog01 stime=3D1615122768
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
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog09 stime=3D1615122774
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
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dtimes03 stime=3D1615122780
cmdline=3D"times03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
times03.c:89: TPASS: buf1.tms_utime <=3D 5
times03.c:94: TPASS: buf1.tms_stime <=3D 5
times03.c:105: TPASS: buf2.tms_utime =3D 237
times03.c:112: TPASS: buf1.tms_utime (0) < buf2.tms_utime (237)
times03.c:118: TPASS: buf2.tms_stime =3D 106
times03.c:125: TPASS: buf1.tms_stime (0) < buf2.tms_stime (106)
times03.c:131: TPASS: buf2.tms_cutime =3D 0
times03.c:136: TPASS: buf2.tms_cstime =3D 0
times03.c:156: TPASS: buf2.tms_utime (237) <=3D buf3.tms_utime (237)
times03.c:164: TPASS: buf2.tms_stime (106) <=3D buf3.tms_stime (106)
times03.c:170: TPASS: buf3.tms_cutime =3D 264
times03.c:175: TPASS: buf3.tms_cstime =3D 135

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D8 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D502 cstime=3D242
<<<test_end>>>
<<<test_start>>>
tag=3Dtimer_getoverrun01 stime=3D1615122788
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
tag=3Dtkill02 stime=3D1615122788
cmdline=3D"tkill02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tkill02     1  TPASS  :  tkill(-1, SIGUSR1) failed as expected: TEST_ERRNO=
=3DEINVAL(22): Invalid argument
tkill02     2  TPASS  :  tkill(32768, SIGUSR1) failed as expected: TEST_ERR=
NO=3DESRCH(3): No such process
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dtruncate03 stime=3D1615122788
cmdline=3D"truncate03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dumask01 stime=3D1615122788
cmdline=3D"umask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dunlink05 stime=3D1615122788
cmdline=3D"unlink05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dumount2_02 stime=3D1615122788
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
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dustat01 stime=3D1615122788
cmdline=3D"ustat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dutime01A stime=3D1615122788
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
tag=3Dvmsplice01 stime=3D1615122788
cmdline=3D"vmsplice01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dwaitpid03 stime=3D1615122788
cmdline=3D"waitpid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitpid03    1  TPASS  :  Got correct child PID
waitpid03    2  TPASS  :  Condition 2 test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid04 stime=3D1615122788
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
tag=3Dwaitid02 stime=3D1615122788
cmdline=3D"waitid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(2, 1401, 0x7ffee3f2a430, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1403 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(2, 1401, 0x7ffee3f2a430, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1403 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(1, 1404, 0x7ffee3f2a430, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1404 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(2, 1401, 0x7ffee3f2a430, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1403 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(1, 1404, 0x7ffee3f2a430, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1404 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1401) waitid(1, 1405, 0x7ffee3f2a430, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1405 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(2, 1401, 0x7ffee3f2a430, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1403 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(1, 1404, 0x7ffee3f2a430, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1404 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1401) waitid(1, 1405, 0x7ffee3f2a430, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1405 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1401) waitid(1, 1406, 0x7ffee3f2a430, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1406 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(2, 1401, 0x7ffee3f2a430, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1403 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(1, 1404, 0x7ffee3f2a430, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1404 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1401) waitid(1, 1405, 0x7ffee3f2a430, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1405 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1401) waitid(1, 1406, 0x7ffee3f2a430, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1406 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  P_PID, WEXITED not a child of the calling process
waitid02    0  TINFO  :  (1401) waitid(1, 1, 0x7ffee3f2a430, 4)
waitid02    8  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite02 stime=3D1615122788
cmdline=3D"write02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite04 stime=3D1615122788
cmdline=3D"write04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dwritev01 stime=3D1615122788
cmdline=3D"writev01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dfutex_cmp_requeue02 stime=3D1615122788
cmdline=3D"futex_cmp_requeue02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dmemfd_create04 stime=3D1615122788
cmdline=3D"memfd_create04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
memfd_create04.c:68: TINFO: Attempt to create file using 64kB huge page size
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 512kB huge page si=
ze
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 2048kB huge page s=
ize
memfd_create04.c:82: TPASS: memfd_create succeeded for 2048kB page size

memfd_create04.c:68: TINFO: Attempt to create file using 8192kB huge page s=
ize
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 16384kB huge page =
size
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 262144kB huge page=
 size
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 1048576kB huge pag=
e size
memfd_create04.c:82: TPASS: memfd_create succeeded for 1048576kB page size

memfd_create04.c:68: TINFO: Attempt to create file using 2097152kB huge pag=
e size
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 16777216kB huge pa=
ge size
memfd_create04.c:73: TPASS: Test failed as expected


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
tag=3Dstatx06 stime=3D1615122788
cmdline=3D"statx06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'-I 256' extr=
a opts=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D3
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20200930-258-g35cb4055d

       ###############################################################

            Done executing testcases.
            LTP Version:  20200930-258-g35cb4055d
       ###############################################################




To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in =
this email
        bin/lkp split-job --compatible job.yaml
        bin/lkp run                    compatible-job.yaml



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Cent=
er
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporati=
on

Thanks,
Oliver Sang


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-rc1-00035-g02eb84b96bc1"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0-rc1 Kernel Configuration
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
CONFIG_MAPPING_DIRTY_HELPERS=y
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
# CONFIG_IGC is not set
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
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
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

--RnlQjJ0d97Da+TV1
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
	export submit_id='6044ce158391824127fc28cf'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-02eb84b96bc1b382dd138bf60724edbefe77b025-20210307-16679-r5zcdx-5.yaml'
	export id='e47a18b750f0de3a17cff6462fb714dd0fa7d7f4'
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
	export commit='02eb84b96bc1b382dd138bf60724edbefe77b025'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export ucode='0xe2'
	export enqueue_time='2021-03-07 20:59:01 +0800'
	export _id='6044ce1c8391824127fc28d3'
	export _rt='/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='80ff4f64e062d50de5f2a1081cbe4ef1cedbcae8'
	export base_commit='fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8'
	export branch='linux-next/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/3'
	export scheduler_version='/lkp/lkp/.src-20210307-130948'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-02eb84b96bc1b382dd138bf60724edbefe77b025-20210307-16679-r5zcdx-5.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-next/master
commit=02eb84b96bc1b382dd138bf60724edbefe77b025
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/vmlinuz-5.12.0-rc1-00035-g02eb84b96bc1
max_uptime=2100
RESULT_ROOT=/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.12.0-rc1-04423-g80ff4f64e062'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/vmlinuz-5.12.0-rc1-00035-g02eb84b96bc1'
	export dequeue_time='2021-03-07 21:08:52 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-02eb84b96bc1b382dd138bf60724edbefe77b025-20210307-16679-r5zcdx-5.cgz'

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

--RnlQjJ0d97Da+TV1
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ltp
Content-Transfer-Encoding: quoted-printable

2021-03-07 13:10:24 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-03-07 13:10:24 ./runltp -f syscalls-04 -d /fs/sda1/tmpdir
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
Linux lkp-skl-d02 5.12.0-rc1-00035-g02eb84b96bc1 #1 SMP Sun Mar 7 16:22:41 =
CST 2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=3D0xe2-debian-10.4-x86_64=
-20200603.cgz-02eb84b96bc1b382dd138bf60724edbefe77b025-20210307-16679-r5zcd=
x-5.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinux-next/master=
 commit=3D02eb84b96bc1b382dd138bf60724edbefe77b025 BOOT_IMAGE=3D/pkg/linux/=
x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/vmlinuz-5.12=
=2E0-rc1-00035-g02eb84b96bc1 max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1H=
DD-f2fs-syscalls-04-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cg=
z/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/3 LKP_SERV=
ER=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_alway=
s_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkm=
sg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic l=
oad_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=
=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3D=
ttyS0,115200 vga=3Dnormal rw

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
ntel_powerclamp coretemp i915 kvm_intel kvm irqbypass crct10dif_pclmul crc3=
2_pclmul crc32c_intel intel_gtt ghash_clmulni_intel mei_wdt wmi_bmof drm_km=
s_helper ahci libahci rapl syscopyarea sysfillrect intel_cstate sysimgblt f=
b_sys_fops intel_uncore libata drm mei_me mei intel_pch_thermal wmi video i=
ntel_pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32754220      348480    29902736       21784     2503004    2967=
3932
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
CPU MHz:             422.643
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
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2555     -n 2555 -=
p -f /fs/sda1/tmpdir/ltp-7md7OvElFS/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_03_07-13h_10m_24s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_03_07-13h_10m_24s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_03_07-13h_10m_24s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_03_07-13h_10m_24s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_03_07-13h_1=
0m_24s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_03_07-13h_10=
m_24s.tconf
Running tests.......
<<<test_start>>>
tag=3Daccess01 stime=3D1615122624
cmdline=3D"access01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dcapset04 stime=3D1615122624
cmdline=3D"capset04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dchown03_16 stime=3D1615122624
cmdline=3D"chown03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chown03_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/c=
hown/../utils/compat_16.h:166: 16-bit version of chown() is not supported o=
n your platform
chown03_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/c=
hown/../utils/compat_16.h:166: Remaining cases not appropriate for configur=
ation
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchroot01 stime=3D1615122624
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
tag=3Dclock_nanosleep03 stime=3D1615122624
cmdline=3D"clock_nanosleep03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:63: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:53: TINFO: Testing variant: vDSO or syscall with libc s=
pec
clock_nanosleep03.c:100: TPASS: clock_nanosleep() slept correctly 100227
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:53: TINFO: Testing variant: syscall with old kernel spec
clock_nanosleep03.c:100: TPASS: clock_nanosleep() slept correctly 100188

Summary:
passed   2
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
tag=3Dclock_gettime01 stime=3D1615122625
cmdline=3D"clock_gettime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_settime02 stime=3D1615122625
cmdline=3D"clock_settime02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dclone02 stime=3D1615122625
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
tag=3Dclone04 stime=3D1615122625
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
tag=3Dclone08 stime=3D1615122625
cmdline=3D"clone08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dconnect02 stime=3D1615122625
cmdline=3D"connect02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Ddelete_module01 stime=3D1615122625
cmdline=3D"delete_module01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Ddup01 stime=3D1615122625
cmdline=3D"dup01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Ddup07 stime=3D1615122625
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
tag=3Ddup3_01 stime=3D1615122625
cmdline=3D"dup3_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dup3_01     1  TPASS  :  dup3(O_CLOEXEC) PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexecl01 stime=3D1615122625
cmdline=3D"execl01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dexecvp01 stime=3D1615122625
cmdline=3D"execvp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfchown04_16 stime=3D1615122625
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
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dfchownat02 stime=3D1615122625
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
tag=3Dfcntl08_64 stime=3D1615122625
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
tag=3Dfcntl14_64 stime=3D1615122625
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
cutime=3D3 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl23_64 stime=3D1615122630
cmdline=3D"fcntl23_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl23     1  TPASS  :  fcntl(tfile_2999, F_SETLEASE, F_RDLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl37_64 stime=3D1615122630
cmdline=3D"fcntl37_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dfdatasync01 stime=3D1615122630
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
tag=3Dfdatasync02 stime=3D1615122630
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dflock02 stime=3D1615122630
cmdline=3D"flock02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dflock04 stime=3D1615122631
cmdline=3D"flock04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dfmtmsg01 stime=3D1615122631
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
tag=3Dfork01 stime=3D1615122631
cmdline=3D"fork01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork01      1  TPASS  :  fork() returned 3014
fork01      2  TPASS  :  child pid and fork() return agree: 3014
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork13 stime=3D1615122631
cmdline=3D"fork13 -i 1000000"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork13      1  TPASS  :  1000000 pids forked, all passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D103 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D6911 cstime=3D3760
<<<test_end>>>
<<<test_start>>>
tag=3Dfsopen02 stime=3D1615122734
cmdline=3D"fsopen02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfstatat01 stime=3D1615122734
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
tag=3Dfsync02 stime=3D1615122734
cmdline=3D"fsync02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync02.c:99: TPASS: fsync succeeded in an acceptable amount of time

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dfsync04 stime=3D1615122735
cmdline=3D"fsync04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: TINFO: Kernel supports ext2
tst_supported_fs_types.c:44: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext3
tst_supported_fs_types.c:44: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext4
tst_supported_fs_types.c:44: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports xfs
tst_supported_fs_types.c:44: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:44: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports vfat
tst_supported_fs_types.c:44: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:83: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:92: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:44: TINFO: mkfs.ntfs does exist
tst_test.c:1329: TINFO: Testing on ext2
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on ext3
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on ext4
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on xfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on btrfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on vfat
tst_test.c:859: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device
tst_test.c:1329: TINFO: Testing on ntfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:870: TINFO: Trying FUSE...
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsync04.c:50: TPASS: Test file synced to device

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D8 cstime=3D115
<<<test_end>>>
<<<test_start>>>
tag=3Dgetdomainname01 stime=3D1615122741
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
tag=3Dgeteuid01_16 stime=3D1615122741
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
tag=3Dgetitimer01 stime=3D1615122741
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
tag=3Dgetitimer02 stime=3D1615122741
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
tag=3Dgetresgid03_16 stime=3D1615122741
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
tag=3Dgetresuid03_16 stime=3D1615122741
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
tag=3Dgetsid01 stime=3D1615122741
cmdline=3D"getsid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getsid01    1  TPASS  :  session ID is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsockopt02 stime=3D1615122741
cmdline=3D"getsockopt02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dgetxattr03 stime=3D1615122741
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
tag=3Dioctl_loop07 stime=3D1615122741
cmdline=3D"ioctl_loop07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D14
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_ns03 stime=3D1615122743
cmdline=3D"ioctl_ns03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dfanotify09 stime=3D1615122743
cmdline=3D"fanotify09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fanotify09.c:242: TINFO: Test #0: Events on non-dir child with both parent =
and mount marks
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/tfile_858
fanotify09.c:331: TPASS: group 1 got no event
fanotify09.c:331: TPASS: group 2 got no event
fanotify09.c:242: TINFO: Test #1: Events on non-dir child and subdir with b=
oth parent and mount marks
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/tfile_858
fanotify09.c:187: TPASS: group 0 got event: mask 10 pid=3D858 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testdir
fanotify09.c:331: TPASS: group 1 got no event
fanotify09.c:331: TPASS: group 2 got no event
fanotify09.c:242: TINFO: Test #2: Events on non-dir child and parent with b=
oth parent and mount marks
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/tfile_858
fanotify09.c:187: TPASS: group 0 got event: mask 10 pid=3D858 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint
fanotify09.c:331: TPASS: group 1 got no event
fanotify09.c:331: TPASS: group 2 got no event
fanotify09.c:242: TINFO: Test #3: Events on non-dir child and subdir with b=
oth parent and subdir marks
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/tfile_858
fanotify09.c:187: TPASS: group 0 got event: mask 10 pid=3D858 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testdir
fanotify09.c:331: TPASS: group 1 got no event
fanotify09.c:331: TPASS: group 2 got no event
fanotify09.c:242: TINFO: Test #4: Events on non-dir children with both pare=
nt and mount marks
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/tfile_858
fanotify09.c:187: TPASS: group 0 got event: mask 10 pid=3D858 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testfile
fanotify09.c:187: TPASS: group 1 got event: mask 10 pid=3D858 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testfile
fanotify09.c:187: TPASS: group 2 got event: mask 10 pid=3D858 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testfile
fanotify09.c:242: TINFO: Test #5: Events on non-dir child with both parent =
and mount marks and filename info
fanotify09.c:187: TPASS: group 0 got event: mask 2 pid=3D858 fd=3D-1 filena=
me=3Dtfile_858
fanotify09.c:187: TPASS: group 0 got event: mask 10 pid=3D858 fd=3D-1 filen=
ame=3Dtestfile
fanotify09.c:187: TPASS: group 1 got event: mask 10 pid=3D858 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testfile
fanotify09.c:187: TPASS: group 2 got event: mask 10 pid=3D858 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-7md7OvElFS/jAHQ34/mntpoint/testfile

Summary:
passed   23
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dkeyctl06 stime=3D1615122743
cmdline=3D"keyctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkcmp01 stime=3D1615122743
cmdline=3D"kcmp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dkill08 stime=3D1615122743
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
tag=3Dkill09 stime=3D1615122743
cmdline=3D"kill09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill09      1  TPASS  :  kill(880, SIGKILL) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown01_16 stime=3D1615122743
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown02_16 stime=3D1615122743
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
tag=3Dlgetxattr01 stime=3D1615122743
cmdline=3D"lgetxattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dlgetxattr02 stime=3D1615122743
cmdline=3D"lgetxattr02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dlink04 stime=3D1615122743
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
tag=3Dlink05 stime=3D1615122743
cmdline=3D"link05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link05      1  TPASS  :  link(lkfile_888, lkfile_888[1-1000]) ret 0 for 100=
0 files,stat linkcounts match 1000
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dlstat02 stime=3D1615122743
cmdline=3D"lstat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmbind01 stime=3D1615122744
cmdline=3D"mbind01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmemcpy01 stime=3D1615122744
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
tag=3Dmknod01 stime=3D1615122744
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
tag=3Dmknod07 stime=3D1615122744
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
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap06 stime=3D1615122744
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
tag=3Dmmap07 stime=3D1615122744
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
tag=3Dmount06 stime=3D1615122744
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
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages03 stime=3D1615122744
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages11 stime=3D1615122744
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
duration=3D1 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_timedreceive01 stime=3D1615122745
cmdline=3D"mq_timedreceive01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap02 stime=3D1615122745
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
tag=3Dmsgctl04 stime=3D1615122745
cmdline=3D"msgctl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
msgctl04.c:59: TPASS: msgctl(1, 2, 0x555c217a9740): EACCES (13)
msgctl04.c:59: TPASS: msgctl(2, 2, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, 1, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, -1, 0x555c217a9740): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 2, 0x555c217a9740): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 1, 0x555c217a9740): EINVAL (22)
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
tag=3Dmsgget01 stime=3D1615122745
cmdline=3D"msgget01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dmsgrcv01 stime=3D1615122745
cmdline=3D"msgrcv01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
msgrcv01.c:38: TPASS: message received(hello) =3D message sent(hello)
msgrcv01.c:45: TPASS: queue bytes and number of queues matched
msgrcv01.c:49: TPASS: PID of last msgrcv(2) matched
msgrcv01.c:56: TPASS: msg_rtime =3D 1615122745 in [1615122745, 1615122745]

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
tag=3Dmunmap03 stime=3D1615122745
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
tag=3Dnice02 stime=3D1615122745
cmdline=3D"nice02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dnice03 stime=3D1615122745
cmdline=3D"nice03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dopen08 stime=3D1615122745
cmdline=3D"open08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dopen09 stime=3D1615122745
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
tag=3Dopenat02 stime=3D1615122745
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
tag=3Dopenat202 stime=3D1615122745
cmdline=3D"openat202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dopen_by_handle_at02 stime=3D1615122745
cmdline=3D"open_by_handle_at02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
tst_buffers.c:55: TINFO: Test is using guarded buffers
open_by_handle_at02.c:100: TPASS: invalid-dfd: open_by_handle_at() failed a=
s expected: EBADF (9)
open_by_handle_at02.c:100: TPASS: stale-dfd: open_by_handle_at() failed as =
expected: ESTALE (116)
open_by_handle_at02.c:100: TPASS: invalid-file-handle: open_by_handle_at() =
failed as expected: EFAULT (14)
open_by_handle_at02.c:100: TPASS: high-file-handle-size: open_by_handle_at(=
) failed as expected: EINVAL (22)
open_by_handle_at02.c:100: TPASS: zero-file-handle-size: open_by_handle_at(=
) failed as expected: EINVAL (22)
tst_capability.c:29: TINFO: Dropping CAP_DAC_READ_SEARCH(2)
tst_capability.c:41: TINFO: Permitting CAP_DAC_READ_SEARCH(2)
open_by_handle_at02.c:100: TPASS: no-capability: open_by_handle_at() failed=
 as expected: EPERM (1)
open_by_handle_at02.c:100: TPASS: symlink: open_by_handle_at() failed as ex=
pected: ELOOP (40)

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
tag=3Dmincore01 stime=3D1615122745
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dnewuname01 stime=3D1615122745
cmdline=3D"newuname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
newuname01    1  TPASS  :  newuname call succeed: return value =3D 0=20
newuname01    0  TINFO  :  This system is Linux
newuname01    0  TINFO  :  The system infomation is :
newuname01    0  TINFO  :  System is Linux on x86_64 hardware
newuname01    0  TINFO  :  Nodename is lkp-skl-d02
newuname01    0  TINFO  :  Version is 5.12.0-rc1-00035-g02eb84b96bc1, #1 SM=
P Sun Mar 7 16:22:41 CST 2021
newuname01    0  TINFO  :  Domainname is (none)=20
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe02 stime=3D1615122745
cmdline=3D"pipe02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe03 stime=3D1615122745
cmdline=3D"pipe03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dpivot_root01 stime=3D1615122745
cmdline=3D"pivot_root01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dprctl03 stime=3D1615122745
cmdline=3D"prctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
prctl03.c:73: TPASS: prctl(PR_SET_CHILD_SUBREAPER) succeeded
prctl03.c:46: TPASS: prctl(PR_GET_CHILD_SUBREAPER) got expected 0
prctl03.c:88: TPASS: PPID of orphaned process was reparented
prctl03.c:101: TPASS: wait() got orphaned process, pid 960, status 0
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
tag=3Dprctl05 stime=3D1615122745
cmdline=3D"prctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est
prctl05.c:62: TPASS: /proc/self/task/962/comm =3D 'prctl05_test'
prctl05.c:63: TPASS: /proc/self/comm =3D 'prctl05_test'
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test_xxxxx') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est_xx
prctl05.c:62: TPASS: /proc/self/task/962/comm =3D 'prctl05_test_xx'
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
tag=3Dpread02 stime=3D1615122745
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
tag=3Dpreadv01_64 stime=3D1615122745
cmdline=3D"preadv01_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dpreadv02_64 stime=3D1615122745
cmdline=3D"preadv02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dprot_hsymlinks stime=3D1615122745
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
prot_hsymlinks  392  TPASS  :  Expect: can create userdel: hsym mail spool =
(/var/mail/hsym) not found
userdel: hsym home directory (/home/hsym) not found
hardlink '.../tmp_hsym/hsym/local_hsym.hs' to '.../link_248', owner 'hsym',=
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
prot_hsymlinks    0  TINFO  :  All test-cases have been completed, summary:
 - symlinks  test:	PASS
 - hardlinks test:	PASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace08 stime=3D1615122745
cmdline=3D"ptrace08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
tst_kernel.c:79: TINFO: uname.machine=3Dx86_64 kernel is 64bit
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev01 stime=3D1615122745
cmdline=3D"pwritev01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dpwritev01_64 stime=3D1615122745
cmdline=3D"pwritev01_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dquotactl03 stime=3D1615122745
cmdline=3D"quotactl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:63: TINFO: Parsing kernel config '/proc/config.gz'
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D5
<<<test_end>>>
<<<test_start>>>
tag=3Dreadlink01A stime=3D1615122745
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
tag=3Dreboot02 stime=3D1615122745
cmdline=3D"reboot02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
reboot02    1  TPASS  :  reboot(2) expected failure; Got errno - EINVAL : I=
nvalid flag
reboot02    1  TPASS  :  reboot(2) expected failure; Got errno - EPERM  : P=
ermission denied
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dremap_file_pages01 stime=3D1615122745
cmdline=3D"remap_file_pages01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
remap_file_pages01    1  TPASS  :  Non-Linear shm file OK
remap_file_pages01    2  TPASS  :  Non-Linear /tmp/ file OK
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dremap_file_pages02 stime=3D1615122745
cmdline=3D"remap_file_pages02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Drename04 stime=3D1615122745
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
tag=3Drenameat201 stime=3D1615122745
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Drmdir02 stime=3D1615122745
cmdline=3D"rmdir02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drt_tgsigqueueinfo01 stime=3D1615122746
cmdline=3D"rt_tgsigqueueinfo01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_rr_get_interval02 stime=3D1615122746
cmdline=3D"sched_rr_get_interval02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
sched_rr_get_interval02.c:34: TINFO: Testing variant: vDSO or syscall with =
libc spec
sched_rr_get_interval02.c:52: TPASS: sched_rr_get_interval() passed
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setparam02 stime=3D1615122746
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
tag=3Dsched_setscheduler02 stime=3D1615122746
cmdline=3D"sched_setscheduler02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_setscheduler02    1  TPASS  :  got EPERM
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setaffinity01 stime=3D1615122746
cmdline=3D"sched_setaffinity01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dsched_getaffinity01 stime=3D1615122746
cmdline=3D"sched_getaffinity01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dselect03 stime=3D1615122746
cmdline=3D"select03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
select_var.h:118: TINFO: Testing SYS_pselect6 time64 syscall
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemctl05 stime=3D1615122746
cmdline=3D"semctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
semctl05    1  TPASS  :  expected failure - errno =3D 34 : Numerical result=
 out of range
semctl05    2  TPASS  :  expected failure - errno =3D 34 : Numerical result=
 out of range
semctl05    3  TPASS  :  expected failure - errno =3D 34 : Numerical result=
 out of range
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile02 stime=3D1615122746
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile09_64 stime=3D1615122746
cmdline=3D"sendfile09_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile09_64    1  TPASS  :  Test sendfile(2) with offset at 0
sendfile09_64    2  TPASS  :  Test sendfile(2) with offset at 3GB
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D111
<<<test_end>>>
<<<test_start>>>
tag=3Dsendmsg03 stime=3D1615122747
cmdline=3D"sendmsg03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:507: TINFO: Minimum sampling period =
ended
=2E./../../../include/tst_fuzzy_sync.h:331: TINFO: loop =3D 1024, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: start_a - start_b: { avg=
 =3D   -43ns, avg_dev =3D     9ns, dev_ratio =3D 0.20 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - start_a  : { avg=
 =3D  1420ns, avg_dev =3D    38ns, dev_ratio =3D 0.03 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_b - start_b  : { avg=
 =3D   761ns, avg_dev =3D    12ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - end_b    : { avg=
 =3D   615ns, avg_dev =3D    36ns, dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: spins            : { avg=
 =3D   401  , avg_dev =3D    24  , dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:519: TINFO: Reached deviation ratios=
 < 0.10, introducing randomness
=2E./../../../include/tst_fuzzy_sync.h:522: TINFO: Delay range is [-489, 91=
2]
=2E./../../../include/tst_fuzzy_sync.h:331: TINFO: loop =3D 1069, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: start_a - start_b: { avg=
 =3D   -40ns, avg_dev =3D     4ns, dev_ratio =3D 0.10 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - start_a  : { avg=
 =3D  1413ns, avg_dev =3D    27ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_b - start_b  : { avg=
 =3D   759ns, avg_dev =3D    14ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - end_b    : { avg=
 =3D   615ns, avg_dev =3D    31ns, dev_ratio =3D 0.05 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: spins            : { avg=
 =3D   397  , avg_dev =3D    18  , dev_ratio =3D 0.05 }
=2E./../../../include/tst_fuzzy_sync.h:643: TINFO: Exceeded execution loops=
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
cutime=3D115 cstime=3D44
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsgid01 stime=3D1615122748
cmdline=3D"setfsgid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsgid01    1  TPASS  :  setfsgid() returned expected value : 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsgid01_16 stime=3D1615122748
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
tag=3Dsetfsuid04_16 stime=3D1615122748
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
tag=3Dsetgid03_16 stime=3D1615122748
cmdline=3D"setgid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgid03_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
setgid/../utils/compat_16.h:97: 16-bit version of setgid() is not supported=
 on your platform
setgid03_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
setgid/../utils/compat_16.h:97: Remaining cases not appropriate for configu=
ration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetregid01_16 stime=3D1615122748
cmdline=3D"setregid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dsetresgid03_16 stime=3D1615122748
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
tag=3Dsetresuid03 stime=3D1615122748
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
tag=3Dsetresuid03_16 stime=3D1615122748
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
tag=3Dsetresuid05 stime=3D1615122748
cmdline=3D"setresuid05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresuid05    1  TPASS  :  setresuid succeeded as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetreuid01 stime=3D1615122748
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
tag=3Dsetreuid04_16 stime=3D1615122748
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
tag=3Dsetsockopt07 stime=3D1615122748
cmdline=3D"setsockopt07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:63: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:643: TINFO: Exceeded execution loops=
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
cutime=3D1315 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsetxattr03 stime=3D1615122767
cmdline=3D"setxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dshmat01 stime=3D1615122767
cmdline=3D"shmat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
shmat01.c:124: TPASS: shmat() succeeded to attach NULL address
shmat01.c:124: TPASS: shmat() succeeded to attach aligned address
shmat01.c:124: TPASS: shmat() succeeded to attach unaligned address with SH=
M_RND
tst_coredump.c:32: TINFO: Avoid dumping corefile for process(pid=3D1182)
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
tag=3Dshmctl04 stime=3D1615122767
cmdline=3D"shmctl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmget01 stime=3D1615122767
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
tag=3Dsigaltstack01 stime=3D1615122767
cmdline=3D"sigaltstack01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sigaltstack01    1  TPASS  :  Functionality of sigaltstack() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsighold02 stime=3D1615122767
cmdline=3D"sighold02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sighold02    1  TPASS  :  All signals were hold
sighold02    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsignal01 stime=3D1615122768
cmdline=3D"signal01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal01    1  TPASS  :  signal(SIGKILL, 0x1(SIG_IGN)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, (nil)(SIG_DFL)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, 0x562310700f00(catchsig())) failed=
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
tag=3Dsocketcall03 stime=3D1615122768
cmdline=3D"socketcall03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dstat02 stime=3D1615122768
cmdline=3D"stat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dstat02_64 stime=3D1615122768
cmdline=3D"stat02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dstat03 stime=3D1615122768
cmdline=3D"stat03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dstatfs01 stime=3D1615122768
cmdline=3D"statfs01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs01    1  TPASS  :  statfs(tfile_1207, ..) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatvfs02 stime=3D1615122768
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
tag=3Dswapon03 stime=3D1615122768
cmdline=3D"swapon03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_ioctl.c:30: TINFO: FIBMAP ioctl is supported
swapon03    1  TFAIL  :  ../swapon/libswapon.c:81: swapon on F2FS failed: e=
rrno=3DEINVAL(22): Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsync_file_range01 stime=3D1615122768
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
tag=3Dsysfs02 stime=3D1615122768
cmdline=3D"sysfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sysfs02     1  TPASS  :  sysfs(2) Passed for option 2
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsysfs04 stime=3D1615122768
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
tag=3Dsyslog01 stime=3D1615122768
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
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog09 stime=3D1615122774
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
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dtimes03 stime=3D1615122780
cmdline=3D"times03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
times03.c:89: TPASS: buf1.tms_utime <=3D 5
times03.c:94: TPASS: buf1.tms_stime <=3D 5
times03.c:105: TPASS: buf2.tms_utime =3D 237
times03.c:112: TPASS: buf1.tms_utime (0) < buf2.tms_utime (237)
times03.c:118: TPASS: buf2.tms_stime =3D 106
times03.c:125: TPASS: buf1.tms_stime (0) < buf2.tms_stime (106)
times03.c:131: TPASS: buf2.tms_cutime =3D 0
times03.c:136: TPASS: buf2.tms_cstime =3D 0
times03.c:156: TPASS: buf2.tms_utime (237) <=3D buf3.tms_utime (237)
times03.c:164: TPASS: buf2.tms_stime (106) <=3D buf3.tms_stime (106)
times03.c:170: TPASS: buf3.tms_cutime =3D 264
times03.c:175: TPASS: buf3.tms_cstime =3D 135

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D8 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D502 cstime=3D242
<<<test_end>>>
<<<test_start>>>
tag=3Dtimer_getoverrun01 stime=3D1615122788
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
tag=3Dtkill02 stime=3D1615122788
cmdline=3D"tkill02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tkill02     1  TPASS  :  tkill(-1, SIGUSR1) failed as expected: TEST_ERRNO=
=3DEINVAL(22): Invalid argument
tkill02     2  TPASS  :  tkill(32768, SIGUSR1) failed as expected: TEST_ERR=
NO=3DESRCH(3): No such process
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dtruncate03 stime=3D1615122788
cmdline=3D"truncate03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dumask01 stime=3D1615122788
cmdline=3D"umask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dunlink05 stime=3D1615122788
cmdline=3D"unlink05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dumount2_02 stime=3D1615122788
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
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dustat01 stime=3D1615122788
cmdline=3D"ustat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dutime01A stime=3D1615122788
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
tag=3Dvmsplice01 stime=3D1615122788
cmdline=3D"vmsplice01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dwaitpid03 stime=3D1615122788
cmdline=3D"waitpid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitpid03    1  TPASS  :  Got correct child PID
waitpid03    2  TPASS  :  Condition 2 test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid04 stime=3D1615122788
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
tag=3Dwaitid02 stime=3D1615122788
cmdline=3D"waitid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(2, 1401, 0x7ffee3f2a430, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1403 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(2, 1401, 0x7ffee3f2a430, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1403 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(1, 1404, 0x7ffee3f2a430, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1404 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(2, 1401, 0x7ffee3f2a430, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1403 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(1, 1404, 0x7ffee3f2a430, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1404 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1401) waitid(1, 1405, 0x7ffee3f2a430, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1405 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(2, 1401, 0x7ffee3f2a430, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1403 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(1, 1404, 0x7ffee3f2a430, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1404 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1401) waitid(1, 1405, 0x7ffee3f2a430, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1405 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1401) waitid(1, 1406, 0x7ffee3f2a430, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1406 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1401) waitid(0, 0, 0x7ffee3f2a430, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(2, 1401, 0x7ffee3f2a430, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1403 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1401) waitid(1, 1404, 0x7ffee3f2a430, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1404 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1401) waitid(1, 1405, 0x7ffee3f2a430, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1405 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1401) waitid(1, 1406, 0x7ffee3f2a430, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1406 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  P_PID, WEXITED not a child of the calling process
waitid02    0  TINFO  :  (1401) waitid(1, 1, 0x7ffee3f2a430, 4)
waitid02    8  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite02 stime=3D1615122788
cmdline=3D"write02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite04 stime=3D1615122788
cmdline=3D"write04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dwritev01 stime=3D1615122788
cmdline=3D"writev01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dfutex_cmp_requeue02 stime=3D1615122788
cmdline=3D"futex_cmp_requeue02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dmemfd_create04 stime=3D1615122788
cmdline=3D"memfd_create04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
memfd_create04.c:68: TINFO: Attempt to create file using 64kB huge page size
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 512kB huge page si=
ze
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 2048kB huge page s=
ize
memfd_create04.c:82: TPASS: memfd_create succeeded for 2048kB page size

memfd_create04.c:68: TINFO: Attempt to create file using 8192kB huge page s=
ize
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 16384kB huge page =
size
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 262144kB huge page=
 size
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 1048576kB huge pag=
e size
memfd_create04.c:82: TPASS: memfd_create succeeded for 1048576kB page size

memfd_create04.c:68: TINFO: Attempt to create file using 2097152kB huge pag=
e size
memfd_create04.c:73: TPASS: Test failed as expected

memfd_create04.c:68: TINFO: Attempt to create file using 16777216kB huge pa=
ge size
memfd_create04.c:73: TPASS: Test failed as expected


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
tag=3Dstatx06 stime=3D1615122788
cmdline=3D"statx06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'-I 256' extr=
a opts=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D0 cstime=3D3
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20200930-258-g35cb4055d

       ###############################################################

            Done executing testcases.
            LTP Version:  20200930-258-g35cb4055d
       ###############################################################


--RnlQjJ0d97Da+TV1
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
submit_id: 60448b7883918235e939d3f6
job_file: "/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-02eb84b96bc1b382dd138bf60724edbefe77b025-20210307-13801-eo5zfm-0.yaml"
id: 5b4651132ca1e533807392e312daaf71fffd2d46
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
commit: 02eb84b96bc1b382dd138bf60724edbefe77b025

#! include/testbox/lkp-skl-d02
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'

#! include/fs/OTHERS
enqueue_time: 2021-03-07 16:14:49.208469761 +08:00
_id: 60448b7883918235e939d3f6
_rt: "/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 80ff4f64e062d50de5f2a1081cbe4ef1cedbcae8
base_commit: fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
branch: linux-devel/devel-hourly-20210305-014501
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/0"
scheduler_version: "/lkp/lkp/.src-20210307-130948"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-02eb84b96bc1b382dd138bf60724edbefe77b025-20210307-13801-eo5zfm-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210305-014501
- commit=02eb84b96bc1b382dd138bf60724edbefe77b025
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/vmlinuz-5.12.0-rc1-00035-g02eb84b96bc1
- max_uptime=2100
- RESULT_ROOT=/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210304-151455/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.12.0-rc1

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/02eb84b96bc1b382dd138bf60724edbefe77b025/vmlinuz-5.12.0-rc1-00035-g02eb84b96bc1"
dequeue_time: 2021-03-07 18:19:03.611921747 +08:00

#! /lkp/lkp/.src-20210307-130948/include/site/inn
job_state: finished
loadavg: 1.64 0.87 0.35 1/206 1548
start_time: '1615112418'
end_time: '1615112582'
version: "/lkp/lkp/.src-20210307-131023:f10abbd6:924a0de28"

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sda1
mkfs -t f2fs /dev/sda1
mkdir -p /fs/sda1
mount -t f2fs /dev/sda1 /fs/sda1
ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
./runltp -f syscalls-04 -d /fs/sda1/tmpdir

--RnlQjJ0d97Da+TV1--
