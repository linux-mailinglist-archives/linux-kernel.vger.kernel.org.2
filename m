Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA6539D607
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFGHeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:34:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:5335 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGHdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:33:55 -0400
IronPort-SDR: cDdP/bz5XFsZbp910BZIh5Pd6ltn0UQJAvsGT9obH5bFZ096s2xuSH5yjEmfN5I/dw6O6gUdB2
 3GexT4sGCqqA==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="204546457"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="xz'?yaml'?scan'208";a="204546457"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 00:32:01 -0700
IronPort-SDR: HGcdl9+CqVYBqkeEKkwUNRQqB3rh7jnNIifyWlaNNrMKzFPMcLUO9CMuT3X7kwz8krjuEhUBlj
 gKKyFr9o4HQg==
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="xz'?yaml'?scan'208";a="449000878"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 00:31:47 -0700
Date:   Mon, 7 Jun 2021 15:48:15 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     0day robot <lkp@intel.com>, Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ltp@lists.linux.it, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [mm/mempolicy]  7463fff037: ltp.mbind01.fail
Message-ID: <20210607074815.GC16270@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <1622560492-1294-3-git-send-email-feng.tang@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 7463fff0372f733229a9384f509943357e4e5caf ("[v4 PATCH 2/3] mm/mempol=
icy: don't handle MPOL_LOCAL like a fake MPOL_PREFERRED policy")
url: https://github.com/0day-ci/linux/commits/Feng-Tang/mm-mempolicy-some-f=
ix-and-semantics-cleanup/20210601-231653
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git c2131=
f7e73c9e9365613e323d65c7b9e5b910f56

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20210522
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

2021-06-07 02:51:43 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-06-07 02:51:43 ./runltp -f syscalls-04 -d /fs/sda1/tmpdir
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
Linux lkp-skl-d02 5.13.0-rc4-00013-g7463fff0372f #1 SMP Mon Jun 7 09:17:57 =
CST 2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=3D0xe2-debian-10.4-x86_64=
-20200603.cgz-7463fff0372f733229a9384f509943357e4e5caf-20210607-24016-jxviv=
b-2.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinux-review/Feng=
-Tang/mm-mempolicy-some-fix-and-semantics-cleanup/20210601-231653 commit=3D=
7463fff0372f733229a9384f509943357e4e5caf BOOT_IMAGE=3D/pkg/linux/x86_64-rhe=
l-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/vmlinuz-5.13.0-rc4-000=
13-g7463fff0372f max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1HDD-f2fs-sysc=
alls-04-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhe=
l-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/3 LKP_SERVER=3Dinterna=
l-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rc=
update.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don pani=
c=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=
=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore=
_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 =
vga=3Dnormal rw

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
ntel_powerclamp coretemp i915 kvm_intel kvm ahci irqbypass crct10dif_pclmul=
 libahci crc32_pclmul mei_wdt crc32c_intel intel_gtt ghash_clmulni_intel wm=
i_bmof drm_kms_helper rapl syscopyarea intel_cstate sysfillrect sysimgblt l=
ibata fb_sys_fops mei_me mei intel_pch_thermal intel_uncore drm wmi video i=
ntel_pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32754216      350748    29801416       21788     2602052    2957=
3124
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
CPU MHz:             3495.241
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
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2538     -n 2538 -=
p -f /fs/sda1/tmpdir/ltp-msRK2VdkT2/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_06_07-02h_51m_43s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_06_07-02h_51m_43s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_06_07-02h_51m_43s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_06_07-02h_51m_43s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_06_07-02h_5=
1m_43s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_06_07-02h_51=
m_43s.tconf
Running tests.......
<<<test_start>>>
tag=3Daccess01 stime=3D1623034303
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
tag=3Dcapset04 stime=3D1623034303
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
tag=3Dchown03_16 stime=3D1623034303
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchroot01 stime=3D1623034303
cmdline=3D"chroot01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chroot01    1  TPASS  :  chroot set errno to EPERM.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_nanosleep03 stime=3D1623034303
cmdline=3D"clock_nanosleep03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:52: TINFO: Testing variant: vDSO or syscall with libc s=
pec
clock_nanosleep03.c:99: TPASS: clock_nanosleep() slept correctly 100220
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:52: TINFO: Testing variant: syscall with old kernel spec
clock_nanosleep03.c:99: TPASS: clock_nanosleep() slept correctly 100220

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
tag=3Dclock_gettime01 stime=3D1623034304
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
tag=3Dclock_settime02 stime=3D1623034304
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
tag=3Dclone02 stime=3D1623034304
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
tag=3Dclone04 stime=3D1623034304
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
tag=3Dclone08 stime=3D1623034304
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclose_range01 stime=3D1623034304
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
cutime=3D9 cstime=3D90
<<<test_end>>>
<<<test_start>>>
tag=3Dconnect02 stime=3D1623034309
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
tag=3Ddelete_module01 stime=3D1623034309
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Ddup01 stime=3D1623034309
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
tag=3Ddup07 stime=3D1623034309
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
tag=3Ddup3_01 stime=3D1623034309
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
tag=3Dexecl01 stime=3D1623034309
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dexecvp01 stime=3D1623034309
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
tag=3Dfchown04_16 stime=3D1623034309
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
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dfchownat02 stime=3D1623034309
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
tag=3Dfcntl08_64 stime=3D1623034309
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
tag=3Dfcntl14_64 stime=3D1623034309
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
cutime=3D2 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl23_64 stime=3D1623034314
cmdline=3D"fcntl23_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl23     1  TPASS  :  fcntl(tfile_3124, F_SETLEASE, F_RDLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl37_64 stime=3D1623034314
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfdatasync01 stime=3D1623034314
cmdline=3D"fdatasync01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fdatasync01    1  TPASS  :  fdatasync() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfdatasync02 stime=3D1623034315
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
tag=3Dflock02 stime=3D1623034315
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
tag=3Dflock04 stime=3D1623034315
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfmtmsg01 stime=3D1623034315
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
tag=3Dfork01 stime=3D1623034315
cmdline=3D"fork01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork01      1  TPASS  :  fork() returned 3139
fork01      2  TPASS  :  child pid and fork() return agree: 3139
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork13 stime=3D1623034315
cmdline=3D"fork13 -i 1000000"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork13      1  TPASS  :  1000000 pids forked, all passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D106 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7032 cstime=3D3897
<<<test_end>>>
<<<test_start>>>
tag=3Dfsopen02 stime=3D1623034421
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfstatat01 stime=3D1623034421
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
tag=3Dfsync02 stime=3D1623034421
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
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfsync04 stime=3D1623034421
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
cutime=3D8 cstime=3D112
<<<test_end>>>
<<<test_start>>>
tag=3Dgetdomainname01 stime=3D1623034428
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
tag=3Dgeteuid01_16 stime=3D1623034428
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
tag=3Dgetitimer01 stime=3D1623034428
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
tag=3Dgetitimer02 stime=3D1623034428
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
tag=3Dgetresgid03_16 stime=3D1623034428
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
tag=3Dgetresuid03_16 stime=3D1623034428
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
tag=3Dget_mempolicy02 stime=3D1623034428
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
tag=3Dgetsid01 stime=3D1623034428
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
tag=3Dgetsockopt02 stime=3D1623034428
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetxattr03 stime=3D1623034428
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
tag=3Dioctl_loop07 stime=3D1623034428
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
cutime=3D0 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_ns03 stime=3D1623034429
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
tag=3Dfanotify09 stime=3D1623034429
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
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/tfile_909
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #1: Events on non-dir child and subdir with b=
oth parent and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/tfile_909
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D909 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testdir
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #2: Events on non-dir child and parent with b=
oth parent and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/tfile_909
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D909 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #3: Events on non-dir child and subdir with b=
oth parent and subdir marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/tfile_909
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D909 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testdir
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #4: Events on non-dir children with both pare=
nt and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/tfile_909
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D909 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testfile
fanotify09.c:191: TPASS: group 1 got event: mask 10 pid=3D909 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testfile
fanotify09.c:191: TPASS: group 2 got event: mask 10 pid=3D909 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testfile
fanotify09.c:246: TINFO: Test #5: Events on non-dir child with both parent =
and mount marks and filename info
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D-1 filena=
me=3Dtfile_909
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D909 fd=3D-1 filen=
ame=3Dtestfile
fanotify09.c:191: TPASS: group 1 got event: mask 10 pid=3D909 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testfile
fanotify09.c:191: TPASS: group 2 got event: mask 10 pid=3D909 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testfile

Summary:
passed   23
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
tag=3Dfanotify17 stime=3D1623034429
cmdline=3D"fanotify17"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fanotify17.c:243: TINFO: max_fanotify_groups=3D128 max_fanotify_marks=3D279=
983
fanotify17.c:176: TINFO: Test #0: Global groups limit in init user ns
fanotify17.c:133: TPASS: Created 128 groups - below groups limit (128)
fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
fanotify17.c:133: TPASS: Created 128 groups - below groups limit (128)
fanotify17.c:176: TINFO: Test #2: Local groups limit in unprivileged user ns
fanotify17.c:133: TPASS: Created 10 groups - below groups limit (10)
fanotify17.c:176: TINFO: Test #3: Local marks limit in unprivileged user ns
fanotify17.c:125: TPASS: Created 10 marks - below marks limit (10)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dkeyctl06 stime=3D1623034430
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkcmp01 stime=3D1623034430
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
tag=3Dkill08 stime=3D1623034430
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
tag=3Dkill09 stime=3D1623034430
cmdline=3D"kill09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill09      1  TPASS  :  kill(945, SIGKILL) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown01_16 stime=3D1623034430
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
tag=3Dlchown02_16 stime=3D1623034430
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
tag=3Dlgetxattr01 stime=3D1623034430
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
tag=3Dlgetxattr02 stime=3D1623034430
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
tag=3Dlink04 stime=3D1623034430
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
tag=3Dlink05 stime=3D1623034430
cmdline=3D"link05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link05      1  TPASS  :  link(lkfile_953, lkfile_953[1-1000]) ret 0 for 100=
0 files,stat linkcounts match 1000
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dlstat02 stime=3D1623034430
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
tag=3Dmbind01 stime=3D1623034430
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
mbind01.c:188: TFAIL: Wrong policy: 1, expected: 4
mbind01.c:169: TINFO: case MPOL_PREFERRED
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case UNKNOWN_POLICY
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_DEFAULT (invalid flags)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_PREFERRED (invalid nodemask)
mbind01.c:216: TPASS: Test passed

Summary:
passed   10
failed   1
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dmemcpy01 stime=3D1623034430
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
tag=3Dmknod01 stime=3D1623034430
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
tag=3Dmknod07 stime=3D1623034430
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
tag=3Dmmap06 stime=3D1623034430
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
tag=3Dmmap07 stime=3D1623034430
cmdline=3D"mmap07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap07      1  TPASS  :  mmap failed with EACCES
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmount06 stime=3D1623034431
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
tag=3Dmove_pages03 stime=3D1623034431
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
tag=3Dmove_pages11 stime=3D1623034431
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_timedreceive01 stime=3D1623034431
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
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap02 stime=3D1623034431
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
tag=3Dmsgctl04 stime=3D1623034431
cmdline=3D"msgctl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
msgctl04.c:59: TPASS: msgctl(1, 2, 0x561d3cb40840): EACCES (13)
msgctl04.c:59: TPASS: msgctl(2, 2, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, 1, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, -1, 0x561d3cb40840): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 2, 0x561d3cb40840): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 1, 0x561d3cb40840): EINVAL (22)
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
tag=3Dmsgget01 stime=3D1623034431
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
tag=3Dmsgrcv01 stime=3D1623034431
cmdline=3D"msgrcv01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
msgrcv01.c:38: TPASS: message received(hello) =3D message sent(hello)
msgrcv01.c:45: TPASS: queue bytes and number of queues matched
msgrcv01.c:49: TPASS: PID of last msgrcv(2) matched
msgrcv01.c:56: TPASS: msg_rtime =3D 1623034431 in [1623034431, 1623034431]

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
tag=3Dmunmap03 stime=3D1623034431
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
tag=3Dnice02 stime=3D1623034431
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
tag=3Dnice03 stime=3D1623034431
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
tag=3Dopen08 stime=3D1623034431
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
tag=3Dopen09 stime=3D1623034431
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
tag=3Dopenat02 stime=3D1623034431
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
tag=3Dopenat202 stime=3D1623034431
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen_by_handle_at02 stime=3D1623034431
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
tag=3Dmincore01 stime=3D1623034431
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dnewuname01 stime=3D1623034431
cmdline=3D"newuname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
newuname01    1  TPASS  :  newuname call succeed: return value =3D 0=20
newuname01    0  TINFO  :  This system is Linux
newuname01    0  TINFO  :  The system infomation is :
newuname01    0  TINFO  :  System is Linux on x86_64 hardware
newuname01    0  TINFO  :  Nodename is lkp-skl-d02
newuname01    0  TINFO  :  Version is 5.13.0-rc4-00013-g7463fff0372f, #1 SM=
P Mon Jun 7 09:17:57 CST 2021
newuname01    0  TINFO  :  Domainname is (none)=20
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe02 stime=3D1623034431
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe03 stime=3D1623034431
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
tag=3Dpivot_root01 stime=3D1623034431
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
tag=3Dprctl03 stime=3D1623034431
cmdline=3D"prctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
prctl03.c:73: TPASS: prctl(PR_SET_CHILD_SUBREAPER) succeeded
prctl03.c:46: TPASS: prctl(PR_GET_CHILD_SUBREAPER) got expected 0
prctl03.c:88: TPASS: PPID of orphaned process was reparented
prctl03.c:101: TPASS: wait() got orphaned process, pid 1019, status 0
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
tag=3Dprctl05 stime=3D1623034431
cmdline=3D"prctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est
prctl05.c:62: TPASS: /proc/self/task/1021/comm =3D 'prctl05_test'
prctl05.c:63: TPASS: /proc/self/comm =3D 'prctl05_test'
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test_xxxxx') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est_xx
prctl05.c:62: TPASS: /proc/self/task/1021/comm =3D 'prctl05_test_xx'
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dpread02 stime=3D1623034431
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
tag=3Dpreadv01_64 stime=3D1623034431
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
tag=3Dpreadv02_64 stime=3D1623034431
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
tag=3Dprot_hsymlinks stime=3D1623034431
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
cutime=3D2 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace08 stime=3D1623034431
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev01 stime=3D1623034431
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev01_64 stime=3D1623034431
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
tag=3Dquotactl03 stime=3D1623034431
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
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dreadlink01A stime=3D1623034432
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreboot02 stime=3D1623034432
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dremap_file_pages01 stime=3D1623034432
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
tag=3Dremap_file_pages02 stime=3D1623034432
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
tag=3Drename04 stime=3D1623034432
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
tag=3Drenameat201 stime=3D1623034432
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
tag=3Drmdir02 stime=3D1623034432
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
tag=3Drt_tgsigqueueinfo01 stime=3D1623034432
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_rr_get_interval02 stime=3D1623034432
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
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setparam02 stime=3D1623034432
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
tag=3Dsched_setscheduler02 stime=3D1623034432
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
tag=3Dsched_setaffinity01 stime=3D1623034432
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_getaffinity01 stime=3D1623034432
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
tag=3Dselect03 stime=3D1623034432
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
tag=3Dsemctl05 stime=3D1623034432
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile02 stime=3D1623034432
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
tag=3Dsendfile09_64 stime=3D1623034432
cmdline=3D"sendfile09_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile09_64    1  TPASS  :  Test sendfile(2) with offset at 0
sendfile09_64    2  TPASS  :  Test sendfile(2) with offset at 3GB
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D112
<<<test_end>>>
<<<test_start>>>
tag=3Dsendmsg03 stime=3D1623034433
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
 =3D   -36ns, avg_dev =3D     8ns, dev_ratio =3D 0.22 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D  1718ns, avg_dev =3D   117ns, dev_ratio =3D 0.07 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D   733ns, avg_dev =3D    12ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D   949ns, avg_dev =3D   120ns, dev_ratio =3D 0.13 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   609  , avg_dev =3D    79  , dev_ratio =3D 0.13 }
=2E./../../../include/tst_fuzzy_sync.h:534: TINFO: Reached deviation ratios=
 < 0.10, introducing randomness
=2E./../../../include/tst_fuzzy_sync.h:537: TINFO: Delay range is [-464, 11=
44]
=2E./../../../include/tst_fuzzy_sync.h:346: TINFO: loop =3D 1073, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg=
 =3D   -42ns, avg_dev =3D     4ns, dev_ratio =3D 0.09 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D  1801ns, avg_dev =3D    89ns, dev_ratio =3D 0.05 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D   731ns, avg_dev =3D    11ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D  1028ns, avg_dev =3D    97ns, dev_ratio =3D 0.09 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   653  , avg_dev =3D    60  , dev_ratio =3D 0.09 }
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
tag=3Dsetfsgid01 stime=3D1623034434
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
tag=3Dsetfsgid01_16 stime=3D1623034434
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
tag=3Dsetfsuid04_16 stime=3D1623034434
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
tag=3Dsetgid03_16 stime=3D1623034434
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
tag=3Dsetregid01_16 stime=3D1623034434
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresgid03_16 stime=3D1623034434
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
tag=3Dsetresuid03 stime=3D1623034434
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
tag=3Dsetresuid03_16 stime=3D1623034434
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
tag=3Dsetresuid05 stime=3D1623034434
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
tag=3Dsetreuid01 stime=3D1623034434
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
tag=3Dsetreuid04_16 stime=3D1623034434
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
tag=3Dsetsockopt07 stime=3D1623034434
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
duration=3D22 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1411 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsetxattr03 stime=3D1623034456
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
tag=3Dshmat01 stime=3D1623034456
cmdline=3D"shmat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
shmat01.c:124: TPASS: shmat() succeeded to attach NULL address
shmat01.c:124: TPASS: shmat() succeeded to attach aligned address
shmat01.c:124: TPASS: shmat() succeeded to attach unaligned address with SH=
M_RND
tst_coredump.c:32: TINFO: Avoid dumping corefile for process(pid=3D1253)
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
tag=3Dshmctl04 stime=3D1623034456
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmget01 stime=3D1623034456
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
tag=3Dsigaltstack01 stime=3D1623034456
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
tag=3Dsighold02 stime=3D1623034456
cmdline=3D"sighold02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sighold02    1  TPASS  :  All signals were hold
sighold02    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsignal01 stime=3D1623034456
cmdline=3D"signal01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal01    1  TPASS  :  signal(SIGKILL, 0x1(SIG_IGN)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, (nil)(SIG_DFL)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, 0x5608abfa4f70(catchsig())) failed=
 with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  Child killed with SIGKILL
signal01    2  TPASS  :  Child killed with SIGKILL
signal01    3  TPASS  :  Child killed with SIGKILL
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsocketcall03 stime=3D1623034456
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
tag=3Dstat02 stime=3D1623034456
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
tag=3Dstat02_64 stime=3D1623034456
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
tag=3Dstat03 stime=3D1623034456
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
tag=3Dstatfs01 stime=3D1623034456
cmdline=3D"statfs01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs01    1  TPASS  :  statfs(tfile_1275, ..) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatvfs02 stime=3D1623034456
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
tag=3Dswapon03 stime=3D1623034456
cmdline=3D"swapon03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_ioctl.c:30: TINFO: FIBMAP ioctl is supported
Successfully created 27 swapfiles
swapon03.c:53: TPASS: swapon(2) got expected failure (1),

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7 cstime=3D47
<<<test_end>>>
<<<test_start>>>
tag=3Dsync_file_range01 stime=3D1623034459
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
tag=3Dsysfs02 stime=3D1623034459
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
tag=3Dsysfs04 stime=3D1623034459
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
tag=3Dsyslog01 stime=3D1623034459
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
cutime=3D2 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog09 stime=3D1623034465
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
cutime=3D3 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dtimes03 stime=3D1623034471
cmdline=3D"times03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
times03.c:89: TPASS: buf1.tms_utime <=3D 5
times03.c:94: TPASS: buf1.tms_stime <=3D 5
times03.c:105: TPASS: buf2.tms_utime =3D 252
times03.c:112: TPASS: buf1.tms_utime (0) < buf2.tms_utime (252)
times03.c:118: TPASS: buf2.tms_stime =3D 127
times03.c:125: TPASS: buf1.tms_stime (0) < buf2.tms_stime (127)
times03.c:131: TPASS: buf2.tms_cutime =3D 0
times03.c:136: TPASS: buf2.tms_cstime =3D 0
times03.c:156: TPASS: buf2.tms_utime (252) <=3D buf3.tms_utime (252)
times03.c:164: TPASS: buf2.tms_stime (127) <=3D buf3.tms_stime (127)
times03.c:170: TPASS: buf3.tms_cutime =3D 260
times03.c:175: TPASS: buf3.tms_cstime =3D 139

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D8 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D513 cstime=3D267
<<<test_end>>>
<<<test_start>>>
tag=3Dtimer_getoverrun01 stime=3D1623034479
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
tag=3Dtkill02 stime=3D1623034479
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
tag=3Dtruncate03 stime=3D1623034479
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
tag=3Dumask01 stime=3D1623034479
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dunlink05 stime=3D1623034479
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
tag=3Dumount2_02 stime=3D1623034479
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
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dustat01 stime=3D1623034479
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
tag=3Dutime01A stime=3D1623034479
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
tag=3Dvmsplice01 stime=3D1623034479
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
tag=3Dwaitpid03 stime=3D1623034479
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
tag=3Dwaitpid04 stime=3D1623034479
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitid02 stime=3D1623034479
cmdline=3D"waitid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(2, 1581, 0x7ffdb6e40e10, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1583 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(2, 1581, 0x7ffdb6e40e10, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1583 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(1, 1584, 0x7ffdb6e40e10, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1584 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(2, 1581, 0x7ffdb6e40e10, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1583 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(1, 1584, 0x7ffdb6e40e10, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1584 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1581) waitid(1, 1585, 0x7ffdb6e40e10, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1585 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(2, 1581, 0x7ffdb6e40e10, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1583 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(1, 1584, 0x7ffdb6e40e10, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1584 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1581) waitid(1, 1585, 0x7ffdb6e40e10, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1585 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1581) waitid(1, 1586, 0x7ffdb6e40e10, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1586 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(2, 1581, 0x7ffdb6e40e10, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1583 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(1, 1584, 0x7ffdb6e40e10, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1584 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1581) waitid(1, 1585, 0x7ffdb6e40e10, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1585 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1581) waitid(1, 1586, 0x7ffdb6e40e10, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1586 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  P_PID, WEXITED not a child of the calling process
waitid02    0  TINFO  :  (1581) waitid(1, 1, 0x7ffdb6e40e10, 4)
waitid02    8  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite02 stime=3D1623034479
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite04 stime=3D1623034479
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
tag=3Dwritev01 stime=3D1623034479
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
tag=3Dfutex_cmp_requeue02 stime=3D1623034479
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
tag=3Dmemfd_create04 stime=3D1623034479
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
tag=3Dstatx06 stime=3D1623034479
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
cutime=3D0 cstime=3D3
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20210121-363-g9dcbf4e96

       ###############################################################

            Done executing testcases.
            LTP Version:  20210121-363-g9dcbf4e96
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


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.13.0-rc4-00013-g7463fff0372f"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.13.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
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

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

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
# CONFIG_CGROUP_MISC is not set
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
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
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
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

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
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
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
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
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
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
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
# CONFIG_CMA_SYSFS is not set
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
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
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
CONFIG_IO_MAPPING=y
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
CONFIG_NF_LOG_SYSLOG=m
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
CONFIG_NETFILTER_XTABLES_COMPAT=y

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
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
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
# CONFIG_CAN_ETAS_ES58X is not set
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
# CONFIG_BT_AOSPEXT is not set
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
# CONFIG_BT_VIRTIO is not set
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
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

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
# CONFIG_DRIVER_PE_KUNIT_TEST is not set
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
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
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
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
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
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
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
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
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
# CONFIG_WWAN is not set
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
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
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
# CONFIG_I2C_CP2615 is not set
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
# CONFIG_BATTERY_GOLDFISH is not set
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
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
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
# CONFIG_SENSORS_STPDDC60 is not set
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
# CONFIG_INTEL_TCC_COOLING is not set
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
# CONFIG_MFD_ATC260X_I2C is not set
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
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
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
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
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
# CONFIG_HID_FT260 is not set
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
# CONFIG_RTC_DRV_GOLDFISH is not set
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
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
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
# CONFIG_COMEDI is not set
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
# CONFIG_GIGABYTE_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
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
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
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
# CONFIG_SECURITY_LANDLOCK is not set
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
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

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
# CONFIG_CRYPTO_ECDSA is not set
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
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
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
CONFIG_CRYPTO_SHA512=m
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
# CONFIG_SYSTEM_REVOCATION_LIST is not set
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

CONFIG_ASN1_ENCODER=y

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
# CONFIG_TEST_DIV64 is not set
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
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--PuGuTyElPB9bOcsM
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
	export submit_id='60bd81d57727ff5dd0fc4b5d'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-7463fff0372f733229a9384f509943357e4e5caf-20210607-24016-jxvivb-2.yaml'
	export id='f76cdf7348916d6861b98921d53a59d3e6b54ab0'
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
	export commit='7463fff0372f733229a9384f509943357e4e5caf'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI
CONFIG_DRM_I915'
	export ucode='0xe2'
	export enqueue_time='2021-06-07 10:17:57 +0800'
	export _id='60bd81d77727ff5dd0fc4b5e'
	export _rt='/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='cec913fe690e09abc77f7f0dd9f560a94e5391c5'
	export base_commit='8124c8a6b35386f73523d27eacb71b5364a68c4c'
	export branch='linux-review/Feng-Tang/mm-mempolicy-some-fix-and-semantics-cleanup/20210601-231653'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/3'
	export scheduler_version='/lkp/lkp/.src-20210604-065253'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-7463fff0372f733229a9384f509943357e4e5caf-20210607-24016-jxvivb-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Feng-Tang/mm-mempolicy-some-fix-and-semantics-cleanup/20210601-231653
commit=7463fff0372f733229a9384f509943357e4e5caf
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/vmlinuz-5.13.0-rc4-00013-g7463fff0372f
max_uptime=2100
RESULT_ROOT=/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210522.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210522.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.13.0-rc4-07812-gcec913fe690e'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/vmlinuz-5.13.0-rc4-00013-g7463fff0372f'
	export dequeue_time='2021-06-07 10:50:12 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-7463fff0372f733229a9384f509943357e4e5caf-20210607-24016-jxvivb-2.cgz'

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

--PuGuTyElPB9bOcsM
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj5lDu8AFdACIZSGcigsEOvS5SJPSSiEZN91kUwkoE
oc4Cr7bBXWVIIW1d8ua7xL90VOjS12pSkksYKGnr3QZkrpcjQY85mvAb7yj9lWdQr5WS2URV
5y7Dfi2JAH4x3h5XJDyK6woIAQ/XmJbpXa0G7HFLB0TplG+TdM0TVQNIZ1SX6C99UO/AVht2
RoSQ4ckil7pIHE/0d7qD0M+ZLt5nj3+BhUc6LMUEqh+6dDlHC7gU4w3Lbus4Y3JYB7qsw75u
nd/Pl6xDECogjEvTAKWsSSGADnXvf1x7K06uCv1E33Fd2LFhz77vnTMNHgm5anLTW+Bw4qJJ
NnmsUOW6E9Hz+mrcnBvBeq2eAcKGRlNyJ/AwDvrR/BIpV4eECXFuQSpl97y1V9c03oWOBhSj
WdtIFjm+ySnypvzH39Fm1yojJMsld6e8j+vxtyhZKkmM/1CeZwuIWJuMI8QWbn+zbsCqkGvz
l0rFPH3KIsI9N5A5ts+8yjSYy7ycJ2J+3/xdxxyaDEWbsix148axlJuMZMc1A8XOd07uS/4b
XMSyckbmc2rcraaE2NJUkacPgcgSvkJAPf+1O04laUW+CHa5bXHQEhAvP4lDSsCe5emAgNmv
1uODfJyWJw739UH00GBSNP1M8pDluU+hnw85TmY1e9HtV7jV2MKZVla5htIIhJveJsS56EDh
qh5oIJCv4Mo0WREGkQtGsNRnEeIjZGQx0OO4tlo3UA8GFNVarScDDNQYcLHQuW54Nh+WvqvO
d6HbZX/KmiMAprJNzanm8QVA1hGbazVDDfiJIrjQjgJOrd3uWoYFu5n6jCxYz8d3YGCYOZAK
ed0eylgSvAZg4Wu56yKu0uUVFMt8aZnfJ4dh50U02L+Qs/49hI/v9StjRXOyR7wcvwSxDFtF
axjjjmNu8y5MqhYTf+0bVnt1qn8APg+g16XRauXpYGpThM8ArirHNV837hMizF5kdvo0GaAy
nXVOFBxhsHatRgaswJeIO3sMUmeRWy7cxYnx/AX1T3giwai6jtBgPhL2aDwXCmmbn3KLio8G
suIUYfRoHFVXAeLTCEMHKqQNC4yC/jNIgr6GzALTn9kuJKL+YiADgWUwV/g1hsWYUE24Mpd6
4nXpmiF3tvDkxCVsbkhPnd5ke23cCMvDPizYyjrP/zu9Ww/vDNXaxh+GdQWXsrxXFKfcwaEB
/3X3DfxWj8nbp6r3C8TVMCrx35RWr3BjfVUs1b1oyzU1rRO6XaYrwTmhjgXhHkBro4Y5la9t
XNvM52pxuMfhXXboVk0AW+OJW2+xUnUXcLbhMXE+0JGwp+XCkBfWq+wW/8+vwe4L9M6fLqc4
93ss9ePs6uf72PtmFarz9vN2M+PV4Rlc7uHBueIngh9kVZ4B81VGREPDpUgbvT3q/A2PAIy1
YWdQImB3BWGBU5hsbp7p4Wr9R53B6Ss03Yh3i0kGCW8LVGjv3fb4+z2Rc66uPcbvShbWlKrH
V/+4PCyGwms4QvoiNFc2aTnF4NvC2V0ASezXswx6oKQUkj2cV/9kxp6flaqUkPjUlVigkq8V
uVgBT0rvdXynvgtJ6rNIaJitFyAr++Dcn3LyQWiIaNSdTruo6VLm1/chiT6dTm5hkhSjg8SS
HflSCbbvZVT1DWNVDfUcuMfWmDIXAZOKQvDICRPbsdeUMLXOrtFqlpw0BhNDU+XCVQR83m90
tptfiq2900fUk4MnPbs3I1RgyM/by/JmpeOEvjCBagyr2TSu09BGpthLHl/ZIAb2HcbXNhRL
W+3rf0Pc0nTQNdI7plR+Uc7MNe+E1acGn7/CXAr7RfiMN0PeXcYUMpZ9ssMysjBsO8hobA++
nzu4+eT131AUhFW/FlEDoTtDv+xq6o3/DOuMpr3vmUMo+ukOQeScy6Hjix7pRE3ZVvPbCWa8
aaZKEiIDbqYV0bTee4XbgFbePonU2kSNaDf0qWCLalxH5TC55ectr23EsFE9Bb/MPQpxTY9W
F5095DAPrlwIj4Lq7pxZ6Tk7o56yyXdXLuhNONtDhVSw5rtDE2aKXduFf994R2t6eW/kaJw+
VDUJ1Eigu0gWL46AyAd/RvmHDCqPfpzUMaR0q2YlETBCWKC/uzIxk14gFEIfbNk5ymvdvBs4
tDVIllYQfhPNWYrg5aPCgjyqqfhX1XaOwmUA/ziqre73T443buM07Bzv/WMjgI1wokYeev9A
qG5CD3BXyaiytjc9dWe8KUWg1/hCS4uETeC3EeJm9IGl/9oHOoOscQQ1iDNVmkYbcqCC99Ji
ZPrJfKjjs71AMNAxTs6Y5vS4dXUKjGsyZBHIKiUUFyvLfOJdJhE3QPP9b4KZyqc+C/X1gV+N
3fzLwlUxdarDyDcEuvr75imjCTwlDi/mTmVtiGK3VlvcRgQxi5kFDTUVitJlkqmgwq9gu/bM
8Eou0Ay7DIVqO5LiL8C4y2pSlHgo7MOaBXhJ8KvcCsvHNnWrlntiKKEyxzql9bdsG64JdGWG
SN588tqlssbgAToADzjfPoK0m2zjqlcd7dgr8PfK/rMkEUsL5Gkil8nFIiaQWoH1Gvn/KT4p
n+0Vq0mFFrzhKrTeOutuGWD6HJss6rKnDJPyx8QqUVFKv5qjhM3jNJSAfQj5QDonfhxrpuRR
vkxYodBLVAR9b6YM6w7jO1wIs3PwqXayn0Na4Ew/qkpZ2CGIx638KPG9hjcaCdj0BlDCvxc+
7Ln4SgIr0hNg2QEhyDWmvHqLaoNYaROvAmvLYKs4pLd3MY4BjeQDA5mr6O5JIhdsuChkBVHf
otic1JAAlqFLD5IGSVgian9qe0XeRTtRxzpYCc+eK/nyrP4fILMPHN421f+7++bTSNY7Nxkl
7d1mun6Cj0QRO4Wtis1yIftVA+Fd99zbUsgxRsC53fVWUZLsyC6ZLyC0SAwxHFXxcJCnghfN
7STtCpJQVAqGgatuK5N7Vvyo0oRoFyH8yXGgQrp1BC5sEIH3FfxR+vzCPfLfGn/fEpUAlNIB
pqIinZeioBhXtbqaehVDR69dGWWxKouloWkGtxXHY2dP2nCaHtXUGWmXFP92CB9frM/vOMVo
1FANZCkhOL4oa5CJbfD4dfhjgwHvfpyHj4ev1zOGePRKTuP4e759yZuY0dD0vzi3juJzP7Ai
rHZWvaHNAgTX2ylTxQ4FH7USTehHlBYfW0wm7N4GkznLC/QljMW0hRNLXNg+ylkoPb5hRlrG
/SFzXcR8FGnr3PDxhHds9WGxLm7wvQVkLIXcOLSZM3mgLmyYNy7MPGspKIwXg41Cs9j6fni9
q8OkajS8JJdWhX3ktr6t6rrXIRYzRSrqfkXhrCyajK5l/KFEy/TdzjorpxVB2jv92jV6PZPs
vsAYuJUSBCVXPyurqw/JKCI8OVgZyO8YZxELwOQ9ErYiR4eOe3oiVGuhS03S3Tv91cZdhz4j
HPQWmZszHaqGT6cRQ/kbge/dGwH8sicXhNoFc0GBAgr+MtzGSPEN3WLZ96HIeiPPbjC8ZQkB
CSj0YX3pU+lE/PS95TxW0FJCCYBEmf1GMH4MiN/4+8Htd5JtUX6kNX7J+oUzyeATURqkibYD
2rAg++caDGXaOSL2WSCr8IKMDwAazz9oRxE1MggGXOfGPvhK91NCrl9AiXwMDfFi7t1Vr4Xq
08olcYRqh3oexwDtI607d9z5vH2NjB6mppVd+rR17cqxrGAVSU8WWziSGoeBmATviQoW/Sci
UTFWcYIuvQIsBKzELmWTfYUbWjbWF802VT4YYdNnzNy2Eq4gzhHE04ofC+afNgnmzPkg4+h4
NcoT1C1iLP8tMGkDLgiutRO9J9ROBSpi0ySiXAIfYhrMciFooHdt7ieOI/nt8SXgeJ+lTnLt
YxRwCQygfdNY4oyFI5PzTNh1Ag8ZIaIEqBKEHg7m8+8jR+DOrR8y7KLtJGmpvtTlNXpfVcUF
zZ4lx7sp4b8/g41zrypKZmw/jMS7LWCt1amAAk3J1+w2OW5v0jOUdwrbMBdl6z8Cp9nxxAS4
KwILcgduZCgZGHAvQ9OJmxhHcv/1MxdXyrvQ6HR6Yg7Wb8m1xzHRZRD/Xx/izUbEP6q3jt6+
sW335dy1QKuZHhEpn3f5lqRut2SgUKRJb/f8myAHuTtjh85rJjzOllzwDBEbTQAA+XKFGXsQ
8V8qSmIl+4owNI6aiErzVo8xyC5xmNEjn2lyswxXdOTfwWdmm8j+59z884jSSid6ZAbYpmwq
sNVh/ab4LCgWciBeYfGJcJX6LwCdXVEW1QTid/Oagra6wGIqS6fMz25dLaJN2wLNCJ9gV4J4
vR+bp8IrhUP9A8JOejArHEpaDT2C6tZaiNEvkOyTOn252LEzDh+qC5cgIhyPF1bblpEMpHud
67lup7n2TSiegmqaw+L2QNCfyxoslL/jlYugNfGO6WvCFKVPYY9O+0Xlp7aq1yQSqRVK/gTj
NRLRRaJzSLFrx5Tc2OwcoA/PAwmk0i34q6I13MfG2mwJPXP2cErhZeYssTHNN3kSBiUkU2Tx
tM53kkvbXjt7FPTK5x4jE5zly3Xsw/yYJIOi+5HY/NU7X0iAmQI448oDC6OTg8PKFzrDCiez
1z/BynVVbScBlgnJXSD82pJ+nfw4ENdETG9GeUnNrtUNGRcjOZuRb4KXVoyjPyX2UfZiXweg
emml8J+wZhwM0QL+3VZaoavduRKCMZPgc52I6xz2uudUeie8lQ7yhZ7dv7M5NOvphk63lCxy
8R1R7NRFS2NvJfpsqaQfGR2CBE5EHyYkWJC0ZMBdFTeIp/VTNl/1GjaUH5q0ngWrM2iAqGGw
e0Xj/VMOokD9j/5ekhX9VqJuTp8uvvuYi67QCWKp50fk6ZbxL91NH7/khHXlg2gyakfReUA1
LtVfoeL1FXtZsL0LNZrDPmd2O9yQrROInvoyf7Xg7RunHLi3OXyB1KW6Gbm0EK7gbhRxTEVH
oazNxK3VgKRPYASPsdklu2TK3LSBIbbbiCSmiA76/K5qedSNFPM9MtodORcm9wuFysN0WQzQ
tg5mYb/e3dSU2so2tmbZlEnJixpOWP+ZjvEXZHZcGE6KAoRa76oLblYlJUP1qn/qdvLbBdSW
Lh8ErnyNWbFMjUh+KSYA8AtxfvTj3ubGSC0TpqRscelOg8C9+0NqRxE4Jvia+3N1k6dd9bwT
oiM44Jqgii5ep5U268Jo6qQS0DOMiIVRN/l5jRjyepbpZFHXGFpIM8613itAhTqCWZKxZ4wT
FdwpEg1unhak4gx0uSQgObEhMrxrptlvpkmzM2zCtPVIium78vX2ApwnPoqZK/gzL2bLXjHX
ARaiFnSmR9yxoIwRqdgsiVbizv7mF2pwXspKVC8AT3Yrq1GKRFdWRhiEs2Re0TLAXorC8S5P
PeS7X712JRwlqO+A1dtswbyNAac5kMzFSJk2J6KkwuFYrXhZD8xK6tEO8LmalZQjD8oBDwM+
k9gNVlJJVzbRVHj6eFaUjYz7zwuEN/ctmQjI2pqBvxWeFCJ2YPE0RbD8wniSjaQ+biBCdtUb
OCNgXej3G6PMyId5xQu/GPLt+HA9GDimYgmk1+gzniT4VxRkbfDF4yfkKWBmzjkobis8Xm5e
GZ46QHeU8oj83NSp64MQ0z+sWoNFpHBdTuKKMa6a5zuPHQYdsmbUWQcM6bXUgKALLvBwhJvm
HsaeD6mnjIFGs5kjtUawH/ScDNXJKZF/w9ctqqO7tdeGagOSMq2PTKpEqPnJ+/6TYNknoByY
i2mGBPe7b7771Vi2F2eCaLCasJeofwCe4bvvKSdQ6A0iIBAv+8Ggye6hCwHnuFpVktbIbN5l
BcfkhaMIpRLt8bSt+Y0aFCcY82Vf59A2qR49eEm5zjtx1BWw9DJATd9wqoNvStrR/v0WInv3
MVmF/xGP4XYtQhinJOPOG5M9FzmEllGH5V0J30pDXp1es1Y7+7PwS6/vk8udx0vZUIJ9qbwE
RRuhQNmP7+lzOlboLC3WWkVbmy8RNcWDBqI7mwELw2v+ZmiNhjj0axW1lVp0bmp5fTfFabcv
yqvExQpBFYFNFSGDbhb+ImWpZvkPUdheO3C+YqKV0McrFXr6Yg+MO5/kFwYUEjJK0jKDbQ4f
WuPHYuHx6f4vwRZXYy8HDd112sn+/VdcuKMolKUvkvG3rA5BOcLTtiyyHF6WR8N20C9RKNW/
ROjoqD/vlPt5z/cl3giMFsv5UZY+NQ2IOHmLESsVZKCbgSQyc1Mxj0ICqjDKiHK4LKsHHUio
T5Hl9T/60yd1FXr9lPfkiiTMm7y/LswjUjUzdfUwL93lJOngVcwV9Q8BrB1duzaqnH5fcfn4
TtoRXI+vvSWu8FixNrbEOa6EtUo0Ima0UswxIIwssnlas3Ci2G4pekUh6dfGRSMdd76/s1c4
4fDew55HLh7XKUjYUfu4X10hqvyXqg/lHcBVf+HQu7BMK+Yg1up6ifrD9upAasDtwUGmYekT
BEjPATiyW56WuPxKFRBUYyOSzSP4RmbDjViMii3S/WO3Cs6f7PK/2Vvq/UrL31SRCFUrAxrw
VrSquCrcpU4mNFlEBzncseXKt6g8Pnf7aeEp/dg2Y6IKBBewyi6CNJ4+JHQkSkj2W3rGe9Zi
PvhlNbwQZyX9gnbg666XevL4GVjl/twEVsFyge6uZZ/mVgesb7VYddx3ugLg95spzBBlW6jL
zb/XpiBIes+lGqRoK9FLmpW3fJ07JuyHfozs6003OcfEgR9d0KttDnzy/JHkyOnLxmK53okp
23ajKzej8ZBkX1D5B3Y35mBQw3sCAl1HvUKqC3O5aIjLHinac66V7o53f5vcxuWgE3aA+FFh
opfMEdFnCa0z51GfVULSI+Q22dZ3+L0DP3fzcUKbU+whpTFRp5/53ojaq2VsJhj8I4uO1+Vv
uhSV/hJo8mf9CALT0M0q10QiA8V9WkZP1G4Prg7p8pGGhudUgglbIXRnAPovtDjsMhpbHKpi
/FRJgb6vIdWZTwerDFv+ip2gaSZOieFQrJzWmx6/6FLtEOi1Uar3PHLJdNU+DtYG4VPrZgN6
j3BOpuBgShEwtWstBMdUNCKyKGu2WVgyXYj80G0ZKiITqnrqvWwPOJGpRGf0b3F9GTj+cesr
y308baDef98tnxxjYkJCnai8Z7b4mdlvu0GbW9uU8kpzLBFQoOEVogKln+pJtsCJUdJDtmNz
lgorrQE3WDzfDinjeDByVrreY8Mfcyr9fjb3AsRZ2ArbiGCkKcGgBcabB5Vskq6ONpjK8R/i
cXfwl65iEZ3Nf4e9JgkdTX7thMhxeOdkOCDOCC9El0wjjhstvinXDbDTCSvFn1yLeeEqiIZD
PST7IMzjz3UWYvrWIBkJmK4cUL/n2GDhNb7TpuM4oPn+dpwEqVMDUlN4sS7/KN7le0lBlQ4D
3gfIiiHW0okWhx1sS1B7uASkgz5xKjno3ueyiCmxWGeP/zBkM9QItcyVK0bwKK6GtTxvD+Nw
60guFRF5CPKzJrHtZQEXlYgDorTOEaRX9RJl/bggUF82rWNFTn5hp+EqH/kuYkscq1oS6XqQ
iVzkXeuoWYUriVSMDWKCxSXH97hHtIKgl96FUvHNLtLuXKtq+RaEGtXjeDxa592f5ZmWxBbO
3j4h8vsleBQAzLeOXpIkiymm197j/5ZPPy9xZJiVzeHWJeLcXZHWl82vBbWrFDvuzq/zcU09
V8uNE5bXS/MjzsvltzXGK9WiS/OQgvQ8Lk8Ts4lyOc98v7Es59TS/d1EucbBgNlKzenWLfPd
ylPnJgLFNGMan+lWjHkzsGZ7IAUXjxZK0wiv0I6o364AFr9qy02IavHlCn3BHhsFDomFfRmN
KDCeWHTN8w+r9ljbEshSMFrGayfNFMdPxh69VlV8FoX5MUX02dq0DJbE2TCUT95Xk/NOgvYA
q9IH3soDIMlOno+nPigp+rMNm/m9mep/m8bgo4/78oCL7Pe5a7cLjptK6v6aRaRvL1Zq6LOY
YyQm6iSWx6/5Xvb5H7qbPJHRNONkfOo+/e/7/GXywv6hUQ+1zH+6br07mzrg5y2vYr4e3z/M
7TQVFSSJJLvtgFry+fOBfUSAtuZpAj+DpLXLwF+fhBdu+ky4mbwiswMxvGCPu1+mqnNPZUvq
/kt9/rP+C3nK0BX2oeFHJSogcBirC1GUv8Dm6XTIjP6e9H5Uh9rUE+jprS3JVRvNc6HZuFk6
EciqEQB3zQki+WFq7uKnwDquAo/snLN+G27pwBat3NsFFyVrkMLrOn96+T3WAzBAPkKrpXx0
cY5BvTHBLCIvPXhktr91zhXJBtXHNJwFUf19w+bHfwhP51HZ47mMxshvAoADPl03WArrcULt
ejI8wTPwjIRqUs4XMBB3C2Dk5d/Ob7SwkGiKKpYLJ137z3lsNj9OcZ6rJijw/hxWn2SMO9p/
w6aH1enpXE4KNyc1KD6kyKoAODqM6AC9ohO7xOGZxC5Q+sm/liMKAwtUpo3ODfD3ycfiILew
XK3McXuIDbwo7bMcuN+TQxdZNXW78SWHb/00ZwySoHI8n0LDlK2fkJG9+RiF3qky1q+KOXfi
lb3YuUIBIzfwjaZOjt0Q4hnUuyfCK5fBvAdwAeEpqDpFGnxX1dH716GQbVDKZKk8uyf9fIas
sQaS2BsR82HVTZuwyNyNJc+Og5q7RrrsiXGcB8s605egPshqKnhSIJy/azO5ZDCZrGk9UWh9
IFrGrrNswM3Gq0XoBqzsMpeXXkN/qS3mTc6GRdq7RObF6DsO09kORXedyaK8zW+/hYq8m5PM
5MkWn3hHUi4ff59myC7XZgLTGosFi8uh6ZtLzLWZ+zL1ezLREReclKDHsytbKnJcpZjTt+sf
0wp28u8tRjBN8mRnb1Pi0EiSRjeYCytgd1l6+tPxoEAYHAyTkPHKcIP+3kxVtPlL04KZD0gt
KuKIbXBPFTGB0Jb4TC0gpFmIa6NHb39kvYgMQTefY2apYjM3nNnRoQab6buBAWBnOMkucc+s
FzgOGo3Cb2CCpOkE31TOphb2ylZ3eAlTL/XLZieYU6OOUbuMhkHDrpGHVHSf3Eq5W/DyRGwb
cUtEsQiIIMUArGzyEHeYCFjJFrfO8pdEgKwtNmks6cT+uEImn2zj/nQC52I5E5YcOK6GEraF
B3RlJh32dfyoFUi61LvdOBMqS7FhhoCnpmB65oq0RFUR+UJ/JnQ9jd7R+RAmEcW0zuNa91Fg
IFJyspDs1H1FkLzqZgaDIm8kYEEjqFXVDFTaodJUjvIcRwh4W3JEcgfC0QJELoXgoL8kg4U8
up0SRDYiTu6nHgQHydQ3TtO8gHUn/jLXSqRHBr2NmifkLewrkQxAmsD3cOAPYdOSZbEJYPmL
q6WN5v5H2utHuqUn8HUcP9c9yXbOPqOVg3ZfobPS7LsK/CWURHBPxty1aYgirIERT7o0whKO
pijImGoDeN4blOn8TshH1jGr0wyXUpN7QTDyTvOQt56p7TABkBX92kKgPMywXnJSkdGW/Ooa
btpHIG+SME0tNpGEFl4l4qRfVQ2oo4pelMiilgvA+XJ+2hSujjf0k87X1Te2rOdzHArLNnhU
NgeaNtoOu+oNiBQ6W6n3EGlpHCHocCLOI0SyBQBgCmCCYtNZWmFMGoGxigKou0kkPtz4Azex
hXVdoGFniXL2IKo8VC5EGpSwuqLsz1OAytv2yPPNNrUDJvJovk/2tn55loeutFTofuxHGZbJ
65aKPzS5H4+wENNH8iGQRrZoIaVkTOOnmQuXFvkKgESl/8aLuEDtrT3EX6xNqsuR6wEHq0nV
rh3kIJD1XjUM5pTLjukDwRtvz/ZrF2wrefTDSRD7369mVHZAoMdqMoHMY+95ekCoTs35Mnoa
QGipf8e0Mg7jg2QmIClo0WrUacaZ7LPrO0WTHzjxjOWc6hHDJ20o62w+EUhzziSutt8QGqlj
pCmalR1hGbELHq06o1XrBJTzUJM75xkgoCmTa/vjOiL4cJRzAFV8OgdI2wAgrpFjDI14Q0tS
9ADops3ytXKcyFiHec0+TJzZL79iSb/N+7Rsufn8GXXja1lroVZVAhRPpqg6cCIrvGQnMBmJ
MJ1GHXrDxBA5j5RiET+Hp06ijymI0GCQCN+FJAoRkfp4317LRWyYHRC3rD41Og1VY4UNP3w4
/nT+s7t3MMXWQQFs8Cfd41m4MFDn27v7a7AenIEKIOSkOqqPiuAttfCfk0y7JsSy4CoYZHxg
C5rK5IQm0YS+F6Px5iuhZToedyk9VD9bP0FLxXI8BVKKtBSJgt6ZQMINGnshx649MXSf3rh1
sL8xpbP9ub2sgaSfKRBljG51RSjx11lUWQyK8qY6W00gYmrDCuaGTPkj2U7Y5FBjA6V4GbQl
wLcEFG4lHYF6pufhUC+Ta/TbBAugXUNJPl9PL8x6hPd1KOn3asulw8a4aC2WmkrSdgohumW6
3ke/FDWQOkMZqVd8cX0qAFa2hRX5ZmW76N9n8MAO4IXxobwHU1l2QtO45V1isxwOuqqm7rno
ezJidEhaLrJUTNW3fNccQ9zsRmSOPUPJhsu0/WgitZmkcl6CofMBxWdvftyimQDbQAw/3rXA
3sJDRRrZyQ5Sy37C6APW7LZYIh5ro5AnegS8NSy8f42Q4+vXPQXP8g/UEwRlv++UxhuRb4yr
R6dWlzXDWtVlTRxvLEivJYWZ7ORtFHlJCnezO0dlePG73rdxvr99HktBSPjfEoBKXZObwIM7
5qshbYORfGhAJCbv1pWhESy9t6shI6dbKfhDbqeCW+magMbb9cDUr9FRCne8P3qhHWl+BAah
RVzaYbpdZH9nC2NsPICz2hOPQY3ccwtPKec4CpSxMrGi9XcTRGwbhxjTkjTsgWOOw2nyqSgW
11itFGlwQ2dgNdYbO9Ms/+sVUY0H1TfAN3jjb5OJKbGx8iG7YjRTNvQqKua2pS70HYCfLa9I
PQpiS7JZ7sAFhfVwl8Tuj2iffGl1NaY7PBKu6EoFQK1mfMqynXatj97/HSlnN2hIQnJwcRbc
RydFFfGZugFds/pk6RwuCxAUyUgWGUoufu3Rb/Nn9rWiIo6XUDDSe03k8EhY0ykgVnJzfjkx
vChH7NplQlK+a2WLVZp+ItLo1aWWuLJDVChzqZWDwMDDEQABI6UqRtly8l8UJRoRBnPLip4+
PPX34ao/qaWPyptmu+5aJWBFfkj9kZF4LkzNjhrQiA5uYWTiLQaLU5J91N4G1IFMggQimnWT
a40nl8Vfb3PfZTh6/qGgI06F46shxi7kroQPJbBuAJIGwSqJPdo+16KQWuoJ/KYCcOyvfoLk
CDuB3aWu3mFnVlHMkuVfVwZ+4/4VMmW5xULLd+0KE3OLxE5VamK/Xq9z+cZ13tRfrv1GQQwp
Nh9hsW7BOT/kp5J5KPn4ISfq3rUUFXhwhc/HtiGLOwm6LYRpesDg3F63w2kp8VMlGozIwOYC
IIn/dd/gBF3cmVj7n2chavr6JkOEr/2LjICrqsuSBiC0CR+1qlkrkTXmodzKFFjUoQgDibYY
4WSBp6I6w1CtFfgBmSI+lr4fPxehB7fC4/w/4ndQ7horMKcTsPOzsxQmJUCdTy4SO8dlV8Xq
1Hto8Pe/o3Nox+XOVTV99y57LVzkfSCw1hxBR/BjCQWUwO4upp2eYBMlOxcAmUspoqpb9w0j
yZVNy8LKWAtaeCULh81AJnyoI/NJUk6VRIxVsgFi7K6wK3A9ByoBLt32Klmo8RhtDTSms7Gz
GIsPXJHJzw0UggvchUbgipXXjBd77rR/kK/nBw2l9yjREP2e22b5yECl7h3jKwJUC9Ul9SFB
o8PV4ja5dvbQTYwAD0lZuxbCH7e1Iivvefd739V87r0maKOWZccWe3GQ+qeI9SN6A3K7y2Dd
dWjIXc+WZ/ZoktsJdDW3gx/PyT2/W3tp0E56bUyERKMclsk7g0murIfnBRgnBbPGZJfo/mCu
BVljKqmYU0DOVAoSbo4Oy9BwI8Oo70UciRwIHpNr7zXueolvdANt27CqY5piRlGfJ3XvcfpJ
ofAtuli4b11Az1zgtbMR5ZeSNTl6zX1Df1pqqXNoLSCzi0tf1WpmQL68OljaHcaDdiStWYD1
M3fPlgcqsJmZrVy+A6UuVdriaQp1RvQr/qAUGBFpwgqEePnJiTYXVzgftbTbCaF+ZRbQ22Gw
cYocfaWuLxKeGH0ktAmivRWgz/mrqqOPlc0L23Dhwp6wpxc8J//ogw4n8FztABMQM9mcuyVe
ERLEhRovO46Up1xUGAE/i9pGxnfgZ1+skqckA8k1b6C+FyhpDaJNNTBXTp3BSHrD+LXnLI5t
YRKzMVYtr1bwvTpZwRoGVuLlZV07U0lFSV+MDnOuef8owW26jzdo1e1TmCE3OQCUZkMT/W9X
8rAqqUT/uYcFf6aYULkP4An4fa4QNgb5PqDcVG1LPvbSBbjXZtxp6rUTFFYTWnxJqeyuHMNo
Dfs3s11DjdhtP/lFDmci84GtNEEllYN7+K0uV3eX+SkoLw90T9RhwMtNKliRKW3JO2j1nPHe
KmVFLFRc/Foqz9Fb9FMOvnC+nhrt5cvRVzlWrG06BgbpmeT8DzS6kUFH83MC0GqKJUs1/KDP
tCht/WuWKOrSeIJokGMAefMX4DoFSDKCtIsDnG8Pjo41hPCQ7ExRCwiFDwhlM0oI8oMXGaQn
Dx2/C6mc3c6ghq0SYF3SIIs/Rlh1xjeTr5xEyJhYVswq1IQWEXjy3i2zjSHYxSnfedQ+5E97
caWvOxmXyvsB583K2TRDA0F4XpnFbjLwyH80H7QclB08LyXoGwr37MRiDoSiF5bYpGlbNhXZ
w2dgvdZZiHmRRMeQYng/JEtTvSWNZACu2q59uhBXPcCZVizopasbIHdfNtFWquDsZo3G72Kz
xLLDzUILohf7Vg0uxVbGv+gEGAQBCiQ6Om9z2cVyLKZJYXhVeTEU9vdDPaoP5NKtWehVXkXB
hRK5J9CN0IYJguEDkqNpaNQxWA2B2J5+RGvSY+egTxf4imyCkAl5q58poYsFwfGWkKY2DSJU
oQ2rcqQ2GZ5UygdOzAOZN5uSX+aZyQ6U2Y9+X06/HniV7F81mcz/fn38a8+zFY/lXP5Qnfy+
YUa7tKCHbmooxZss5fbkPkx+rk2H9wIGKzJgzkY+0gBl54pDaCJlTozaWZ4ygUMjSQhg+mWq
53vsO13EBru+emyl1i0uj6bU1e6TnISXIZhdIiy7JA89/1T31ItvKL0K6rMjzk2IxFn7KAPu
sGi9QDXbxUREQpU2HgP47oPgiUIT58S8kgVBMpT9TG80uiCdXOyUBl2IuWThtsodSO6mNEzJ
p4esUXXuR5vi9iMww2BDb9+zdqGT3h3XXGtOBC2Vxv8QKJPe2pS1okjdKs5UrukG00EfQqtU
om3yfZWiJUixUTsLTugxm8c5JpkYqlkocpse1Jl4NaZ1Mq8QidjnD2/bzDe6mnVZgpXnCNjd
GBUdpgpRz909kEyj7M6+KxknEs/a7kVJTiERCBkY5BwgXFsXM/vaAVGO8mOGpiUQNbGIvwQp
lDXfr8iWy4sgr/0ay4n/9xpGljXZl9ZaaMt9JB7KFIRp0AfPDol++4JGbxluXweuLI6Znlmj
BpCoP84+r3KDCtgD0GkitKqZmPE9GQUoMiGOhgHK+CtQg9IKOUlWtOER7q2RF17urd6lfiy/
kqBj4Fy+lRebT8wlPvUQrgm8S36jwuzZGQOwus/G1fRLG+FGinpBAd8BQlBtX57CVZ8izo+j
/9Aff36bSx+Toc7IrgYMCcm3HueBz4CBHaWjCvHp6qDr9reLwudy8lDbVBsnfJXtFioVOXkb
yWfo7n3Yai0es6uHY8RxWunFXxRLDvyr2ZtlT+hIaNm1vdPRLJh8x/rcCNPNztLn+jwY0r7h
Wg8+6HO+9uWOpr8qUA2Q/aar86XAjseMGDEHbgf9Qp3GZgGCF5w0tvTarQy2DrRtijEcCDpD
S/adccPQ9Huj7WS6dT5ifz/Jgz914CzW1bnb7CYa5SBtGEICzoV1gLvirnB11pAazUjlCWJI
XsnZW9X+8GZ7ck9iUh4E4z4HuYyfrp4UCydjz/btlh+7eqmOfQx2AsXYep8cJFzLvVTDCRxI
7Ty9dwm4NI4en041EHvzxl5a/YGyUqIufnNTpMREoaXarXdK45KTHuuiZulfZPetk4z62aN0
ETFOnoiuTWjcV+JHfvjkHlJT+DUsD/GKueGEZcYbHkhNEvAwxdHTXPos/8u1JiefvZJs9OWY
6zJMx/8ePAgF3PFL/qb4o7+FdKnSZ5cQiD4OQ6x8DaxXeXqx12cCpDMsziVgaD7vgMJC9YmG
hBaRO9iUAZhYDb0r7r4LX9BhqjgNjghwEWOz7MpIQoizBx51VRq8IBdWpzsd2JL3pnygNbvj
PMQeU2jyZ3H1q7A3BIY4Rgrxyj8oAtGGb6pfJ5vjSiqgewsMSlAk0gT306C3PzGOLEYq/Xrm
rXXcIel9Q7ul/xdFKL6YJaOW8RFsRc0bGoP/3pfb6YXTvevlyT3xW2N70YxSl3YPkTPri7U3
s0sPCY8rO4CnYxAxv415nxscTngakd4wjb3zGwFw+og11mlh6O/KoXuHvCIPaZGoFtLqcfST
QIMaGKjR/4uQiPey9nsl+6z+Ee0fpf1t2/8fsmypd+oIqbZmw0JwWeAFlktZiNb0Ob+sjK/9
7tvEStOeGwd7gsuHHS4zdGgvoTxE8xkK54BCUBJrokUEN8BDSrpr+4wvWdumrzxAg4ccVq4t
kx9ZSalzq7od0nsrjuXiAt0BReTTPfx5DPa62Yx2RrNuduEAHdWIb36Ka/Hgpiep7ifoibDB
92y0+qpA+M3rcfkUXlLjEqqvbBdKsrNftVsdFa/kmmlS0ZbYcVIKooEB97rV5tPY354l/b9o
onsvJuMEYPX0YdEebwKzg5olgiOoXbR9FzNKWd33p5HGSWYf12oQXm7cbUH/fUPz7srWGrAP
nNCZ3cIdgW62gBOK3zhlMsQnsEGRz48M5CCsMLffZArN0Kl6MKj8nvC5QACzYY5KuJvtFbAA
K9ZFBYfE+MZEFJB6QrK0YbRlXoPuadWXpSu8lyexEjfbcQsu2SPzaofTN4vKKyslTftuwU9Y
8luHQl1MraIt84UNunKR9Afhrl/QEhxRvI99Mxh4KrvbLsSpmOppHQ2QaoVepHtRHchpFGPI
ABO6ucJYKEpxLgimlTUkcT9dY9xoTALi1Fp8TF7S6GZyG83pGV09aKhD9PV5fJWnUtm+4QLW
uLGS6GTYMdhB8C2uZwj4I3YvnQejBZz065k8Gf2EHegOS7FJNhpv+BQmIwWTgUIStyFw32Ob
EY12mqoSzdTX8RDPKGgjMY7A51qd3oVAvQdq80TlTzLHaWj9CpMHa/g0VISRcJJXHYJu4E48
xAsdmowg8KVNIqxwMmr6jrxdHNifJJK5IYNB1a9pkUrzerNp85fFjYh0QTD6vYJzXz9UWLLW
jYZkpFh/lJA76dvUPSQY5WpGlfRhwPqgnKqzM7mSmg6P3D6vmiQ9bAiWEh4wacJS0Sp9VE28
KJd7o75WhsgEXNnpFHe6IbyowsvrJkEcZAfXSUWv0GBx8bWsxBUI01D9OvDefj8hadxrF8cn
nvas+O16QemlcyIyrKlpFIbRt5C2oj26tq49BbsyuwAuLMSzcRO23IK0Z6jc2T746d6zeO07
s97o+jXqeLHGa+vbflMcBBP12jfIGJDb74Z82myVohXenqdlop0wSCvmLk1yN5PyzlWupfU2
NQW0vozIsm8bsvzPaizoa42/2U89LCGfGy2BDkni7/B8Ae4Dq9JgaBgV8/xVKYpPbH0sQJ9b
nwmP+neuc7ajrCHE7EelWydZsL+yNozXhVgyuZ3QWVEANeJLd22o2iSw8s2pA12200gLZ2z2
Rj/4AmoRQ9RtXLCAmlVNMLFyDxg/GjLWHQerLwiOKvDik49hwUCVQPw83K8gyAc9VG+4nKgP
XCCtSKUoWK9d3C/4edmcj/puOiwP576cqawG6eRzD6ddbObDEnj0oqYGBNnmJ0RI0jbSySUY
EoY1mm83qkTtwEOp86lvKl6DBcJkU4M8lliOewmmeeU3FdFuIsaarOMaqaigW7oxw3Claidz
5IHuYMmfzKQUQdxGbuHxDdoWOPdytzCMmVikvDz7n+wJE9P8h1GQvFuVY+P/f6ZFTEWFW7S4
UCOYo9StJfoDU6V+3jXpwewsbrY5EfVkwLTdpAvWnD4Or8Myla1tel9gp5jsAJMy4PWAJEVo
QFZ2kKLPyE1QYyRAWhJTILHOqQbEmVSVjJeKpgiTgubWG/qYpC+hoB1IG6NatEL5DnybggyF
cc4oz5Kv7TWGpyrp5eUYe2vCWZBQSjJmUeQ2VR/Fh9iXkY6pkLiRCSb1iGhPpsYWIRtPd5ED
wawaM5UXIcvk5I63rbsD1Br717yY1h87oRMNC+DRo97pe9dWuhisuegqvoJQMpWPXgWEmpVz
u2JdrwATO0I4fL8ec/vmXBSuRYnE3kL7/WGu78mIkmWqblwiZm8+60ccppZ7kU+8LNmTNIQ6
m3GMA+HDMRHF2hexADAN+Of7lNOGDJ6K4QBv21U+4hXmSb4v6pNzIsJ4ZprmxMhzAm/ptQan
TOc3C5+3KN6UJgQsR3WuiGCsaNu+CgfUWKm9k4Okrmbuiq6uiXub6G/YlsG29O4XPB6+r30d
MUquz9rCmkuOfWxKUsJ3HAvvN5hmPCF9kKEPmyv1l32w6FP52zZ9iqGDCrCpr1hIiHrv4e4N
48hsUNOvVvtHFUQKQMhmqHsFKBgeVQ/5G4NB/cXN2Mbadd3FCRq71QPwn33fcuJMoE00Uw+q
dpG9qMPmcPvi+YEfpDzaOHGfaT23oop7cA08IJzm6X3ofMga74jo4HzxWe2It9QdZ/bt9kZR
4ni2kZ6UNdbcOZr52R1zrnHjuET/cQnmotheve0WeZkqx/BJ4YDIA/SqWhtQczTsC6uIFvrz
/DL32reG08HPPUvUVPdTiGKMzU0ClmymlFLWkN52Wv8Ef4PeFVcE8v4PvQ14h+dUTbBB6KRF
F9IhrB5cJMe7bx/9VeHz2nCk/p6qszsWLK3uA+wGFovyov9+5IcXOR7irfP5PCKpybIDV1jr
+zE53hg0NyFtlrINioHWIpXKvlCM/prCmTu7szVqsHa1YTBzzXCXExPQSqZLdeuzXjWbOI27
HsEZ8ibSMM72ESCPwLOf30ozXDzteDjhgEnCB2NM+zJ2DXuUtpwdU/6YRsBVzch7S0ithdE+
vbifZpjLMxhCJBfYW3+bQ/ELv7FsQOu75HAZvUJ7gZCNEIhRa5/5R00+AueoW+6cxUEvaz1M
BVYZwpYAIk4t/9wdiJ2mFv18L/q/3ELZhExsGWdCAALRuZF1jwfKinIcuagxPkUMMVXORNV9
YADGKdvhIkMFJ4AjUyjve9G4EYlfx31xvndcLpqt/n3Verf/4DCxglIU+TD0TrnJ4BOYeIhJ
2vaZFHpjc97FHNn8AyB6fikxVq9u+uZe0zkxAfe/EfkmGUf65r6Xg3As6uodl6qZxUrT1mSG
vBdFKGxlPO3qBpCTQX2n/ToIIcFttxdCQYJQDYGMJQSJIPKsZQgY0BF71/HwGFvA5dBowD4d
DSRHDIa19D1h3Qdq4JjhxsxMWGZCwg/3/xMzWic1dBgQZC24tfK67F6fuw202sftw2w+GsdB
ZfPb9XmsHqyk+dJuWdinfzUYZt9KYclAOP+MYlyAc+F73j39UBRzC1CMGBoIBcKPI8tkcHqe
xlTfaBUdfCdniDK56zFOAKHXcgykD1+Fwbu0OUiGz+yMwd0SHvT4a0OEyv+M0H1fNzygA06b
3xyuZxmp+EqQMZ5yoaEWyuRK8zsIEVBjWDGF+QwuXhnDrD8Z6SEAfInyug+9JTGc9f9W8fFr
4xvH2otCbHjmX+mizXJAEkYlvPbnAUub5FLd8usLvZfKUfMnZ1vMS3dMI5+oiCwy3my7VY+P
lufi+fQW/3GoP48XpKgXMpkmZFcCFefi1WDdgUh9MyQkZU5VH4TID6W9EFdECrrf4ahe1PHb
t/iSGNB3m/BnBnmjsWDAHGrBEjFW4ZAmBlJt1ro+TF3fGrtv0kys2Y3eUh5UtGK1XZRb0aRD
jlZgXV+p4Y5YkaLi6WYEpvVoeZiYZiBgv9qsO1BNNsllKJWOreCv79q/rmA7/Mh828CuTnx9
rPWEGd+4wAaf9qiNVmdcrAIRpD1sWhUm86ioNLjR8FrE6h4Ohpg6Cc3N/UxnBZxoLnhDPOsg
gx14QzcwvDKKFW9aagEunjaExTy6nWz3HWafNuR4/QOH8Ik4JTfsuEFdUoRZBqTHsoRR5JUN
3etXdum36/CZFRGvnqI7HGnIhCNskrpB2thkLHtiaCv2btjkOIEL/dyAyJYcq+w3oH2rvEaj
TpUlXmILpDBOA3LJQ3JlkdlHHqxM083hTvID9kn0wuxIuSSihfDKZdp8EHyHpEKQQUxTdfKS
QOmZFDuaRSM5bVy/whyzLv8lYrj2cdAQE38hUhEybqEZYImg9AoQux+oF9thhcdDdIbZYuCr
iMBx3n//d/qagtoaI5GtsfyxbaB8LTHqCe4rjH3LcrAkxrsKUdy93HQVl21ftPLj75uNHwL0
UaAUfo9LFtS6CSSb8NClwr+q2TTnIXXZO2Bg0VCwS78oEpemEYdmS/oAZX6a4FMOCPVvYrHO
kcQzzvL1q0cYxWHaxE9WWNcDOiRWqxNd3oOGZSw41F2/8j03mzfneU+F8o4Hv+xEfUlAe+ol
xNQgAm5LIDNhJuE6u0rqCQFMjSQr+oq8IQlEKG4tn9kZ5oDqOn/FhPZPEk9IJJcXF3pUYn3f
u5rZgbhhRwMv6HiUtHDhoPZwF3ZYCoKbONMZ97RU/akKvy+/kDJPRnZB1D2sfzrEeBM1qyY/
0RIK0LP9NOpjdTHUICo2l1RruFi9rzJJF0VFximfVMZKihJYvrPnjC17ceAniEXTtwmMvnGn
ZdfzoPdGtc9C8gjyZZtaR/jnFx8FhHGQ5Ja9KfSpkGFr6F+jhW+wIxIUEF03GyT106fLHlc1
DTeWRZLzq1FBhRvYfrgyJa3yFrkftzsZhv0Ch9NZUSPQ61bIGw7U3xPhTVkI6wikbmHuj3LK
EdOnwtLic+yL0tSuQRmNUhTT+jfu30FlndE1DlItBonv6F3B8vzWqtad4hcGWcbOuKpkbw0W
v0xV73us26/3fWzXSyDzXNbJkDAEypwXb+RPi2j0pwBvsnhUayqlhWadm58yRpFTrcHulgs/
/Z7hedNmELeJCAyyyrdBu2Fh9hf8L5qnV6fEPD03zbIkDNb7Lo3DtGCmVrLDDABohzVLfhOR
Hx8k/f+vO4iCfpeEdXuwxzqVfO0+bwuhJpTFKt5KB/TS5nh/zOOlMeTXo+uasFuOe+asWGCY
MppU77LNZGbHy1Fgz/OG03j1HVdW4v4ra9ZRdZVV6hhdiX18L8HCMXLh5Xnm4vgMtpgCtVik
CLlogE/lmNSLJXo0hgTIpLwQSL9hZ8Zz44uw8y7adyGtDf37J2zLLrWNFykV1pe7J7A2Rax0
p7mSQynpqBiK4arTmp0PxkfrVDCe3nbsK1T0+7uE10ugR472bamDPuVOS3AXLGVDfTK1vq7d
c52koTPUzBykXEj3MvQv1Q5FN1OCmLjQtqZ6M8wzGmHoXFoSLMJv1tDPY3jfj1hEOfSu6Xn3
ebH4FZVs6X55vnd8oKZjdESlYWVISlDqwvHe2iih5LC71G1RkDaQVgzqox1hlCLhGPfHiotK
EccP5PgOa4opi4pd7nvqzVmo+JIF6TkxuGklK4yVy0cZJTw6PAscEGd2cnIhtyovh9ShD1yG
0hEC96I+IOtaxYRaxAabeLKFYDg40yfDUfVHeL1t///U2OYOTd24ypUYptZR9nvZwfW/0XEV
oxa2Ng6E7cFPfzH0YMS71t3wWYASEFAfihB8pVY94/L56j/ycHDszziLWfejIs3F0puBWkYp
kdDRH/MV/36mKPvpyu47k4Q+uo5wQFljFmQLdWyFyQRH/rBrGXzw/gjiS8c7lYXDpvFWlIDT
xh9XLH6vXkDNT89UmkY7IfzF2AvjHd8nA8+DPzmZ1QxjZbT8jqu1+WzjV8NohMC5SOHP5Zay
B0/o+lCxt3li3ds3UquVTj6ZcT/lJLnjBITiq6+evimP2cSR+cua2Rc2NFzQQjPJZ4sF4QJZ
VvpkCTaErXy5CcaJ9Ua8C77TDKI7YkMBixKD9L0aXX3t7jQg//H6LDvrEn8Iay/sNbOzkJEZ
Kl+Dj5z2nJo3r6CDNj/srPXE5k/uBPOO14WeFhzCRV05xDgGfj9tNPzfIE6dnHhZpuzcXuhq
IHgowr9+P9MXtBJ0g2UwxGV3UO/IDLqiMwQzifikkh2xaGKMx6Hk1kKQzD4B/KDJVdgQCPIx
WGr8+v0K7YcukzUPv3rYn8v7yj8fpIrjFiVMqCvEvwshkjUF/pLl8nnMJry1eIpQ8meFYcyr
ApmqA4SweuwI0T61u9TOgBotM9gNAVo4VG6lUYMVeDQdgWR6WBmM2rXvuNbJ9YBQerVvRl59
UFST9YrzBwI8PKTQCqITsI/AjjiTXEoLfuTeMqKxJ7GNtD5MQw4NiL9d3bpYO7PB0NeuNHkt
WK0cdsm8k4LctetbGhddxKdM4wX83qmZKBiOy5uXGYIn74cKQT/itWV4g3xo5MhexHMbvbH+
1iaG/6S/vTSpxsOWSpuhnmGI9QgVXcOeRZ/GYcTRXimX4Ey6dbB2ZJckwrTuRHKrY9wxXPDa
iyHB9RuaK4Xv19Ugp4cndXCo65tweJZ8WmZ9HMxHMx3EvDLTzu2TMs712Erfgxt1xan41N5b
BnzDIo54Sl0Z6eGYycZLYS/cnO7y2EDtBt70vcADWvZbLJyCW5AmGFDNINXg2PK6cxXQ8Gek
j/IHKu74PrhEUmV8pInWv+s89CkBgOXNduAJFWUlPYnUPLTezYTWLYGQUODhPW0HH2rasoqY
j93rE0xx3j43i5ZZgDbiE9/tfJ7TIkbmiolV6038UXlvNwvGQAFoO4jnTFL7K3lXGKDIky5I
PswRzrZey92weaHvzdvA0yWaFUMtObqwbw6YkZDziXS6f9YrbDHDytJf3KvSqkXvdGKPpqfm
EbIT5kWv1eUqMVnQLcsF6Fma8jM9mYQPaCu66t74LUUY2kl+307GjxcFYDSbUA/4b6Fapyr9
zhTnw9zni92KLHY+ZsCfy6nrlK5r8O45pCy5QetkmUEh8Q/689RNxvIwJevNGCwio1cBI3ey
Pvs8kVuPxKUMZG7Hw0T0LawMkl2b1YDkXSQxQBLPdyHLwsUnWv7IrFqCyvwMtWyZo0yPNmO0
klnTeSnPPLWAC8i7EcLdTEs0MciZZdQtnpAPfkXNPdRg198vIPAyz6C4s37Q/4j6aSQ2F0Hj
QRJknRCuPzUR0WNgftyaYe76yfAKEQn0iPprZej0cRvhcpFPbZVPsr17Nv1Ne6WIrtzguERh
Z/lpIcr7hd+JbdeJwcfMIdwtEc04aDakSWz0c7+n2SlI/KBWFLBHFYf+gfuSjT+552FMGUzY
wdRA4JN1PEScV00mr6sREQLUCHM29d/RgOVXJ4Ju2TEtXn0ErPlOkblAP3gZK5rVwCf831WP
Q2Y8yUsOIeezO32hWFlTm7NlXv7tOach5/Dvj7srVgE0e85MQbeEGgBcO4NhkoS71DL7DaAz
H1SpuIutue2hApKIOCkONtEd8SLXRRDhyxdF078NnzADaV6gUdVxQsMOUhCTnoPoqG0qhSK5
4Ylg+pxBkqs+NqqY6+gdh+O2xIRxuTamnI+huVwP/PsXgiJAn1z1kEiwnOreOr7YmtS+wzeo
of+Os9s30apo5U8jfT6OilD1yn5N011m/NhLrWHGB+OZcVNrYp2aG/guqHh84yq/X1oh1I0i
77pbtAf0J+6TmwMSAU56E5Cz8xs+9OBOf6pj4ODnVG0W8Jjqy1yjC7eCeDoEHJOGLjPPZPVS
0ljyQjBsJtEofZzXadxFUa8zkXJBCYNEBoo2B3juz0K84qHHczds+SO9N7tkiF+7KIDjV0gU
Y4Aikjv2bdUIQaEyiZiOpP6+C282opwRyTqng4ZU+ZPnUNSQioy3Vq+V8vpd0wdO+SpM3cUE
X7Vnu6GOIvSY3kkgtWOvIDH8h5LApIghTbpafY8HF1VLpKyxzgfCYDtyf7vLuMZMuSYZ4nh9
tCELhNokX4dsPeoFsNkgit8crSJveIriKIIVLxwx6MZccjzQMpeVxqLeMsT38GWf0uzF+rbh
/oja/BWsI/aes8/yLaW+X6bIFpdFV0H+W5PjBK/Y8TePN0lsb1J3bpTvp42+TtLjNaux7ELg
+Q4pgwlE96roEw2uVvZtbO4sdoneCdMzT63BjFV4zjAGEoLIUZuA6o/fAuMHMFAaBCuSZbx2
kna2wwIxIQxgegUcWmAkXxM8Wmfy3bQoRimtFWwaL1fcUfoeaMmZtxRobdYGOqg80XwwxRT0
WwgwWQN3rRKuASEh96SuEGJtUBxM4k6rtQykePPQNzDnving9Sf9PI2ch8shiEU/kQaJBYeR
mxTbvatfO7pho8kjnHL8i14gd91TwfoP2QI7v9SMUFEVedBNP0r1DgBFKOJciTng6iZZ+n9q
tpUYzIjj9CdVJiXkeDa2MpJH5Eho7QKxFdgt6obQqllvBs/HZheqWjKIqulR39yJTy+T/5Ju
X2Hx7S9hcAoL5ADDC1I0xep7EesEJ3Cn/NEGBHx/7+WD2Eq/rWrtM4kvJP0sIGvF0qwc45CA
3DX9NJ94FmNtdhiu1WZvANlVYUGSJ5xwwl1bQSYoreNz9OMDhVdYA2RJFd4wypEXd6AZxXdz
2mJEWbX5ezX1+jnfla75kobPK6iak1Z+aV0FziCcfprI8rflUMpmyFsnAR2lBeCLjYjW18v2
k6xKXgtZfuZtNA4L6Tnk0wykZwWM/hcTjsyoNFbSFVVUXhNmlp7YOO8qv3RPM0w/X2cOKAHX
80lzJLx6vLjkYkWK+1FxDkkEy+VVI1urYH/HVGiK9nJDdoSSbZ19enHKUZo0I4XXUMSlC5iq
cbJ44jmjR+nzm+1R5Kc8hrnWqiDUl5druZTZ3F4LbTIABEUdxrwNfQIqqAt3uy3K1zStO179
50IkUa/On2ItlaWl66M5H3UD3PTq0CVNUbhVkiVjZxYRtlafaDqT7KlpS8w2RoO+owSO1bJk
36WzQqnOAJAOVkjDbmr9ny3wUTe65lxzMAzR5lWjg9tdTAhdoUUGhcwaEL0FQVhGEwRye1E9
hVsPqtDnJIj31Y+f2y0+nKH0biIpzAapR6Lc4KU6UQLyufydTQjI3ZSjNu22GyKLOWMY8Dat
XfO0ZF3QGYwFbpzz6LKr9W0Bn8SWc0VwL1rITMOWO0EKPFkWCN/OfuvB+EtKYjRXBDNDkC+B
gzm8C/pfO/i/4kMwPEWY/xN82ZNmQYW9lBG68D1Tlnb0WxHnhPa71aCjkc7DKGN8E7rfF9+h
mbagz7JiaFz05MD4C0mO4aKi43r93C8Ik44m5dt2dnUW5Ye0/Hj9pE674AaqM83OXsiZ6Ymq
Bsh/si0YvsRl61uHvlnfNOAzQ/IEAFo0ANraW8sCOjGAks/mlS9IR5KNSBLQ8EKQPSZKzI4h
mT81+5Er2K6qGEYQq5nunxQaNe4PuOhZZIlttH4tHvtiEEeKJlCzLJTxD9At8TR3PsKrwas3
a+Xl0G+F3ECJJaj8ZnSzrDkBQkytbcF0Y5qGdehkVFFUhmeaWTMAkhcHAwHmtak1+JO2InJO
KvXlWBqGjKHeftJh9iPRhpE2ywUdQ2thVawiz0ntx84IBAZgW4mrLqG/3dX75C8OO+It9HOa
z+7dYPa9MPv75lQCUrnke/TsuFUk002wVCovSj7bbHGkyVsvN7q6eYe4vn04Gj92gdGwnWqz
32S4dh9G0CVcpqbk1O0bkko5JvblSoujGjXijHE/iSUi5Z9P/EaWZu05lhEAiNod0r23Gsdj
rvOCB45x99mGRnYz2UZRKlcqKt1oosibu2goav9Dlp+jFLrhjJ056PFe1Af5lgHl+5n4QvYz
RLor5TCcQWGXO0FA95ZctpjBAMnMqJ6rd0TuWXRdyeQLgYi2nfuUb9MVrJ7vZdPZk9WCJzwX
PeLwW+RDJdS7RXWHIRtC5UehKXJkd6NVeOU6wchRwwnbuRg7zbaEeNWBX4a6hibCp1knbTTA
2LJLZ4oUtFlGLWipgjBQfdClP8lhSRe6hPMMJLcNA6GG9RA1N69UAPk0YbEKMBFOa6dyc9Cn
CAjrKV9I5awq2zJPrMCll5bq9dT0rNIMIPWqiZUOrZacf4c8r6KN2d35Nvc1KTqGgvNA5hWp
rmXYoUaZ+PpJAyN5WNsEY/5+Cm94by3ZTn7hrfdmMfMjEFPTK2SlhurQoYlZ8TtI3nOmwdmy
aG2aOV/PqVwdMRI1g0WdusvR/mQWlgX1hIV8rpTakMuxZ41DuQbaJ59gR4jZ/G+DcJxIgXQ+
HoYkZQ6lfRLBnsa3m/HdDSigGhegB/x4xkvQbgGj++iP5Mk4U9EyAa4715GEtXaook++M2ks
5Iw5LffTfBaRx95ErV4R6ALJbFAVsr0O0PU/xtKmInQYgshmjvDtbWymq7/Ip//mVjuGaXBs
IVyl+uwkSLoEvzywb5OrBmQIhk2Lmq09AyROY7kGVyM+RGhSt8b+DH1cSScW9z5UPIVNdeTC
2kcGkL45HJMSohJe9lOa6i8dxAohtASeOcCa8QX/xxVitqu+kT2tlxk1+0YYhNtTNPOrTQ3b
cKwJYPMHxDnVNNfEvqNYHu5p60ygyf5Nx3JD5H3fJT7wCbN8kAFbUM8Ruh9BN/REp5pB0N6U
zJW5z7WJfDJ7w1txvb3/I49jeGLJtAhYPaCVgUPymQF2KvhxftVBZxtTuydcEoxrZdXs9uwo
H54AxF+YJXng3idcHYGcJmTn/hcJaTzdOjGiAaqOx0Y9lRicBi4jcRr6NQJvsGKQOwUEohSH
ZHq3c0pwcxbLNz3e+LPXF3qtaG7qRsLvTlsGj61Z9Rvy+03dpDX2mrBoe1HF8OgDgOpF1PEX
Z3Jo1UTJnWMIn0GWTak/08JvZ+yQQCGx3fsjQmPA88S2vajsFUENwl1y56xpksqNSHlrLLW8
fwBPK9j5YPTtN4wyMvAUfm/OS0cWfMo+pXAb0SggwyryfnDCz/0cuyAO+Dv6+SzBhfD8bnbl
Pwxv+eP2suvJrr7n3i4lIwrLQCbYf+ksQXBDm0sNedRPbcsq695OKvqTF9BiG4v4S0OGqe9H
AwSFeRDyfXEyC9w9c1g06WJeM5/aHjUKFF0FJHQ9MSPCz+nT483oxlmK+fDPTHUrk53ozuxF
3R6/DDj2bWNfR5M71PBdgnNdlsiXRo9wd+rN6GzesK0xN7HQ7FsKd1d/8bl4uFiASwb3dgHJ
o1ZjYckZWPsS9umGWmHlxdmNd/9nUcB+MjWQef9vut8vI2d2seFTcO4bb5PA00ydgaxQR4dn
oqf0MiCbvoNjQJLFRc6lvNLKR1cZ6wtGQBsc2n3v4B3KweTAPU025VfCma6bBkBqtpQz9/Oo
5vgAuy547u8DtJhx+6fBFT9gQdoZNYfpSoIEw00r81Mql/p/KTA54qFDbkPETgLRpe7yNqY8
wkdri+ge+skphPbBtwzotSqebAZkW1t+K885hHZfWfCc5b8bUCuvWmC7sPVASLdzMrHDWTWj
sizBR7jqNHXmbK+WMzzjwdcvR6QfxErlSnSgdSqRrBDo4Dzq5ACN3gkb4z17SAkxASspwkpm
EZ0d2ApEBgKJBE4tux4fprh6NUOV9o1dJl2yt/D9T0hcQXz+Wuy1bvOOm2sjr1XcDBc1DVD0
wH/QnOAD2xXJ8XG3Wh9YlLpjr7LrKkZbG7AO67qnuHKur/MlCd3wCugcpFt7GTPJVMAOZ53a
lo99SOy8QwG9Is7S0iBGh82eIK+i4sqJdkl9zXhJaNoHwBHRWlTwpqITcemnJtuOVUbpZRTN
JDnYVzxkcUTvJdObCCjwY8a41p0dnGbnkdTIMgrDCAPhdjeHXzLjGJK42l0B9qYqxQIPyNKv
MkS0Zu7WqneMy5pUHDLz+PUjdVPmPs3vC3bCFGQ/AnSbLgak06njCv5tcDwIMpmvtHT/F0Ir
fVtnEm5CZ2DwjdavHdvmmpLdUfRVLKIN0WOUHe5BwMy6zq09jSko2ncaJW/QkAGTnjeq9rJJ
upRuF6S9t48gg+ShN2j9hjzvNNfO+uM6b4MR0VpIeNrU87n9BiJiyN4rAOuTwAw4CFVBQwoP
qhfsLw3i55KKlJJ/qJm9TR2+Vg601MUZhrJylITf+dmJCndBYwQ5WGePCj/TD13weWXlc+2M
O5m5QRxq3SJcGdhKawGNYQSPf2rbwtZGdB5gWZ2rBEkXVJ7ljBLgFnN2gEt2K3SZwuvNgmEE
+iXeX7cQsUdqUYWb5STeDWMEKoEx6zxrXpYRn4XXsLhik0cBmZTr1/eM3QORIn86CZAI7y0N
IET7KK4d2hUD4KPdCLt/+uX6NfoBX9stli8QrSQUU8j3AIV4Pry1HOrcSdhfAyiQYLvm2PuZ
0TBH2+TDY2QP0YInLTA0sSZPEb5LP2AVDGAdHaATkEzVnEDQevM3BIgAWGe3HYOjyfmCvG3C
KgBYRU/+TcfSJ5jbHcSKQm1jalcH/XGvzb7qK3aO2ih/XK5WD2B9/YwoSMLjhefCuCQwzYPI
0oKKMP89bbDA0PjBtZnQuR4HQwsmxQ18SFqjBx8eqJOAuu8d8yg3aRLxboBuYAyj8MVipa0k
EzCYWcz5O79XY0+4jOwPXxnoMM5zAnbvOzwmI1FGvz7Cx/xcB+G28qHQHQSGbV3MkAVWrCBl
WTlDPgjVvP2mQDUqDAqUrGV2JlRx4iHbDZHTpt0ikn9KIx8Q/uQbKagyKFi9gw14pkdKfMpS
/NHWxsTf8n/NxrMICEXqsXXz2Rr/iWdCfbDJYgwL6MYScc2e/fBNai2KFiOMUHY7ia03fbKc
cXN3zyepBf0inw40Y3XOtMtbXNUJAhCyqbHk15nzzTgP/Vss+KcvC/z/GmZWAI20FwSR+XMo
PLPSFv5x36SZihIMOHtWQI4qNg1hYEumO4Lk3luuT+UP5EHuiakak9ngUTUPm5CIG5d/CTKC
ZAgCyz4WZ0deV/b6324AUsVMptc63pFEn6MpoKBqcDX7Toke3yMb3cO7KGeGalk1hWPJWNar
M+vwtw0oIq4Bc+bKWVxZyD0Oe+G0F3M0euvv4OSpcIGlzv+ZBfvyRY0w318zRYzQOPtTZRT8
EN+Vk9Z2AcIzoNgA5q2j8DU5uF6f6EY33vUToaNoN7D8ywopocLsuWEEPdLcyBG4vsMRV40V
AO84F4TrNKEb+uTMNMlA3x6hzqdt14UGUmt97bDIi2tUKiy8JZkVSmufNRjGOXvlIJO5mlti
U70PdGAr2ILgPFyFPwB+nxzVXiot990dl99SIuFj0HH4kT/axhBqYhnXkob1q0v+ChqsvIZ+
xq1vU016C6+W/LoRDWfK2hPGu5xYihlkRYYctHXa/6duB+Z2RFOlZgKAToIXSrLSNK573y/Y
b6pnMbkYZgnwLMCW/KrY/002aRx5pvwycJfsHirTED9pg2Mr8I6fM96DuEf6RiRrLVSoYkLI
MWOSEmCap2cV+uHnsTpDPrvx5/8W7+XdHwI20wJrAwREBtxt0dVdeeyajGjdl2fwP+atvo9/
jS6uvN8DvRJzrsgNNvQ5JduvMLwizDnpCRR8F7Y/q6heQ2JpgGkF9JhWMMkUEGK1QPg9Z0b+
PiTr+KnWdk8sPvRZSPfnYDQ63K5DaOP3Xi7UFqyT4NYsIDH4cTWLAdeuBCS/o1EFnHdon0fs
bkP9jWqpbwhsxEYf0MdbEwVCDf1xFttSkanp7HL+88jlovsYTTAVOORn57Qtiwp+cn+5xelQ
wBrhDaUTb7M7bm2qrvh6HWu7Ue256gNGLAksTItyceDCDtgu9cqBFtxckRhwxnENt+dhkOsg
HSweG86ZaugYqva+qhEbaWF6AZUQOrLFX4+enQImAor/HHTx2uaEY7f43Ag0LNVEVeJYHGtL
ID3YRb2blTJPoCM462YwfHUHFmJEvRq/JLziXVbgeg5kDh+hnHE6N0x+Nc+uneZ6oaQ0AYY1
1xBOnN0PII7NtL6otN9f8WPtr4UIZDCcXlh9mfKyYCL9gm6h6tX+nqSFeETE0sFZQZ4s1fO0
wUdJ0jpXkktuevtlGaL7Zwb09ddHRF+jmBKggl8lCUNpuPmo58R6OFhVVhlGolmAKNSFeZba
sq9qNfrIk8BnfJEmHawWET+a97KWhmFFSFDAP5O+T1c+43WF3Gmd5ZBJ6cvLGBAwQwEzGPF9
6naGwZHuhWsg8vasuuEunH0TWH6SjqfpyIiX3rxKnatwYVdTX9EimmSZRmS0NSKg1ucdBsNC
sRNdUBkcrlV7RJMhNXYd3EIfqiWwx4EuVNg8k8QPmLCejSJWYo768HuHLb9Xh4V4yHL41YHr
e8Mi5hRNutQ4/d3dXzWvrll4cD62sac0ESx5/9aR3HbkFWUwPMVDxl5xrJvQD2zbhFXzszB0
lc7HsZom4TgQDGnwoh/kw7KtCmBmsJTNjdBrxQKbsSbmoYLd+DAcZ+d1Z1t5n1OJMaYa59Az
7PuGKBJsjxwnKCq/7RAViC5vEpXu1oHBPic3hARCVrc7ttHZ/qf9jU5RvMJwm0icLuFEgl3x
9ioVjuaDrVbBgdQcchxbxLucD23zbgsyJwEfR6eh7bZtXvv1kDnilAfvbh/1tdxHsxTwRPS3
tukZx9Mt1twKm+hI3kpFTB/c8/ORWN/rTc449g80wX4NUxOUpTV1CJDfpwLOZg99onwT3CvM
lxz/m0P5WLtFp/HV0a7vyyqVMR+w79fUIyQiJlqud+FFJyFLXKZuCyXozNRUk9R8k92b56gU
WILbMVcK5zewFgw3uxDVWzycIPkpGoyPSwgA2yYc/CncduTxtcEw7MXJyqb/PZGJmf6aZvnB
uWMPtkFbqjvooueyHrTGpsM+ffljAcXGgfFfc9NiK+A7A+jE0bPqWLWbx8pIWOZPt+rrdamW
mhFVh6g7Ja8p2CZlK7MfvRHL5VcZXj8i0+T6kADVadqZIYz9EPAYMOY8g9nP87HJ1IYlPNao
xhHCFRLXXPrcZkFnYrCFbeH7EXGRpoTrHQbkH+ivWuD9ySVNjv69hNXW3X+70gFjrrXkhchM
XFf5aybDTabVQqprMylta2+XlOebeekTjHl/6em4dpaKLJfYM6ZmEToJBtZxIB28Q6ii7DqI
elvPl7Z//XJNgiWlCOWNDTWncFsgvWxR6EAzhCYApCn51bIosp+nI8gBHBs+uYQgsaWfQD3O
sv1yDgYU5rRI3ZO0LVzG8vCDebX2lauH9iJCPDLxdutrh8WTstAg+qyCTZvpmT9zOjOBKDPc
CsUPnbcIPDA9DlR+5AXwP7ujpZuuot2UTo2Tr28gpYgFfkNnMXdQysu6hTlYTnPma5MEAzvD
/HukqeDCrQ9XgkCy4ig6THqipUpGyslv7ZY2mnUqzkSQnhVWH3UQZYdw9BmiyXv5CpzgbXfO
L1hx/IKe2PBTrOjtAmtwBwRJP/TBN1H3+hsd5ebQEigx77PwNcsh5vqPJl9DUqKBd0JIrBNY
EZ4OB9DBXLqM8skkr6dHbyEe9xkjolXmfWSednFEiBRMhL0O82tcH189kGwcttLi83OPBADO
Eng6xupHF6JG2oE1m7e04O+Mq/djupxyTw+cBtoKFl5C+R9/tx6j13YM25z5Tzh7Fu7iy14g
tTWubF/D0m2nOdRBFZIDHY8ILlFfv0m559UbwcCLwj4702XMeniQanQjLSiQJD8J34ZqAIIm
nZrFuV1OrBINC/KnTuSTJTtDZo5E9GuW+3EAT3hI07MyXaGUz9yqzMGtyAg7Q4IICn2usm1G
NKdHPwBjVLZg/pvt5BWXGOK7s6qMl4EB9JWrswxhW35dkbQ1SowSs3JaCTf5HFdzBxA43pYX
9zjI8HvJcf7WTNgGYODUSLzY1A/J0YZUjaPU3SuvNFL3Cz7pQA+GihFKG2oMSmweCfHNLxE1
6UD6GD4HroFmXu91EyHVyK5W2lTqXhGukhBMQr2Ti3PhUmC0g6hP+dopfM+k6HhroTJlprb0
tZr8BQ8ItdCRoQqttZhx7bUPkKa8WpGzI3O+CezXYVoSlzFMjNQ59x5sPGp+6V/4BAVGL+K1
7q4q+9ThJPK/gcnFIV1B+FZ1G5UNqmGQWTln0aVhVTlxxCwjKodY0voEFfK+R+yPz9Dsd6d+
zbtEdsROuqNqn/r6X1ij1di1bySPNJIsiUQkb0SlfMzn0otZER3WcF9MTFAkNsphYeTMl3vJ
6hnHfilCcyqt3NVXY9JKJ5v743M/VW2QHfhDbywqJiL/dPpFq5Bylj597pqEPddIC9ITzKwO
NMnJuU5NsjhLoHx5Nh1nbAI5Y+SBjbFFXCBTJWREKtcMeo6aS3TQOcuu4c+JfheKsmcRLHlk
zHHDh1KrxoDOsllowgg7kRQl7BwHeLS/YzsJEQm/xRIzL8MoOBftxICoEHBKuZsh/22VWXIc
AgLvsbXGij+B60PG2bIm04RDC6aPsSAJ2HxPkUAVAKEGqDO+uQZz1ofsCnvak2KHJ3IzMKp8
kmePrsBxIxqaH7//DpfuYU+15f3mTqAFnHI5zrMuzVXGrGrWpKQBg/3BVTaGWg7lF7vHB5H/
ujgUETuu9n+Nl6dgmttsQxCheDFFY5u58aZ5e+j6jtag8xhyg3e7tCuvaFwNlN6NstqvbK4P
t82i1bHFhnZvX7TCESEpMQjG+L+928XE6En5o81FSOXoLUDla+RLp9Git4Z/GbpHy09jSHth
ytwfPubzUTOp0Pxhch32SgU2dJuFXU2B26Gr/3Q+ZVK9KPdyjJzj6NQfxj2jRw1nIAUe8Ygb
DTISVKSF0IG0x80BGs01KZhmgufg7HU5nu3hHp/Mt3mbtPoIFcXCnwUv6znCiOB5TmyuJuDI
t3h3unxBCmrTJnL7pJh1SmC6YIP1b4A4kevpDe70F2UmD61ZncuLbg9odWAkOdznO1+KDNe0
Flmrt2Wv01WobL+UeVZBnSzf1sscbi9BxgWyY39izo5nC0aK0zmWvfd+U0FS3du3xbHXmC5S
iqTMk6WA9R1KB87gualVOycF09kh59WYY2E5bLlEOWz46NS2OXvI+OAk7w3h+fK2MovQr94D
/R11G6aN4W3LMZtVZotY9MCOKAOwbcWyNqGmTfxm+6RG9vVQOUDsbEXFaDHpLQi9HV4df9lc
szfFd40gt7FjwbhPOkIeY5tZHoAeVJufQXVdnMe869U5v2dVMT0fBde72EUEz9W5t+YziJoT
yEhe+ujVtvdN/G0gejLAWB0uYqM4u8q18QU4eRDOvmksqChTKeBqiKoR6IsDZS/yloglHj7t
nrGVhL4o0Y0acaXHC2+rbKJOr4dOwIIYuC9rCH3uHUK5qJ8581j0Iwkg1KURK25r5pXN988O
AZN7Ih0PV6kvk/V60DV50X1gbiuQSKbtTju7DGivAs76ffjKT27K+Vs54hKamlan0Z82iuUE
0Ff6eDE75indjI7GGw8hB5Srgf6oPKOM7UGawc+q/5EO9rvSveLjOKG0ev86siTPDiXtQAUa
Ijgjn8JHPL8Pt54wXaoJPlHMN+Gmw8h/RZ4IdyoZ5LT3FNTHBUJ/W2ccDdlyB0j29NnrWR+f
It6tvCqxv+M/KiQvDpwOPOPpNQLai1bqjEtvA5aASsaLtTXRs9ybXUdaRqnZQDV8xBdYTSFV
xDLR+ElTKLotOiO7EjPHl/oSF1+86FUQqaw0ED20HZjJBy405xjt3K0iRtO4kHr4andJvYJJ
VYWlt5szHaxULgp/PgNt6JmuGcIUBd/Yn9I2Cj9Y4nzrBosDBp9lLrKNW4MIXRuK1BJYWR7Y
5md+TxhyBFFPxqtUjPv6yljYB/+19+yuvBW21ZLQtjsZSHp9KzKqcDmbEq/kstKajMAPpL0y
epFjUX+SHmi/7t6ffVS0Q5lp2myjH3FZJGt5uBBa+q0hgPI/ol3pa0QUXuLVm1AHi+agh3cO
nQorSqJX7uaDLUSI2+++hK3yl8aJE/rOXrDiPoq8FvvI2VIHy6K+SCUDIxECPyAtMTOtCMxV
EfyOnhp3nOsb11oERRb9DnXr0u8ZJser1lA25iZNiE0H1tKw2jzfJ5QjCyugSasGx8YXp+3r
IiIlN7J0fBbbTt0cUXRbZ7xdrqdh0Chhz/bH3sZTres/9E4NX7pAXmi8WNoyXNgYmAommCUt
6qLTRwBOHE1XGk+aU2jaNmQ+eukvj34+HyZph1N9yj0e80HDnkjnIlGZ0darhKEZM7MDsqxO
Cdy0gRpFR9JL3wF+bNfgS5ii1UBlWwJ7LKHFSIH4olW/BOUVnqmOMJIaVwNo7OanWl5cjJvH
jcHI9NIGdGMhjxaYlmfuBwVA0WPSKF5s/jHKzxl3ELtPmniH7aFRuNvAH+azruNhA8WJdnAm
UMtL9h3m2QIXyBndzgIfz7Q6RHAAl/9xBoQjlFZksEnFgw4A1O9ob99cFdW1ueH33O8hXeEO
7btIxqzxWUkL0uz+WCP/MfEYU5dY+egh048i++YdEzQ0qS/fVSz0URHkWmxhHKsynUeKTk+r
2DkhZ+6uSG3+dOf3F+tq/2fuTCerYvlCxz/dVWOvAizWuKujiRVxjqT3UrdrfXERv2Nfl8r3
vC6r0lGzLP3I/EtFVAteHUtm+/Jofv82WoQ6pNEoWqu6qv4FdVW5BcfttHwSrDiJ1XIzKgAg
tzl1rai6eosMJfma5wNhLMR6FFNMeJsBShiEF5L4ktN2uu7BCokkbiymtmHha/98SrqhyZvQ
LI85xcadd5T/2uSrCANh9aIfYRpgi2pRoXoEYZf6cz+nX/ZLPWhUZ5ZzGKr4FyX6Q1Ms7epw
nDVifdY36xGCQJTpTqSWwQZPgFI0qZKLclIaIwFotiS9ijh1YjDvofFplV4j2enJhhEU3hSg
FwKgAOzY1Y6tuAim27vwJMdTyEe2qM88NTIxPzpJ0nBNozEGjGJ0EROhb/LNJ4SGZk2MNAdH
5ayydICe7Y5RS5U7kFVT3HE8ejM/KqP1SQK4VNrXJgfg5gS/oZWRNoH+SURVHr7NAs0RXMJ/
CiyIQbTqRbHTq4lUfJsIy8UIgp/YG5OORmnOSiEjBbfsRNA/NkRSdRwhRNPC/4FjD1uMmY7L
S4z37fimZ79Eilvk7dhGDMbeaOsyIKo5oiCFfsQNoGELX9B5F10teCvJNSj5qfyJy8oOxox7
xDl8a/IIDT02G7Y68Yfl5RuZJqzoOgkFv0QcvflrtR30Remjii7EUpewo/Sf40CtRf/2dyzx
etPa7EZwgRf9ktmpKy4s6U2QOIa7lwG95ggvtSDJSmYI2RIneI9kLQxJedbxbxRDShMgRcL8
KgT5/Jfq4dy+pP6oJyRzWUmPhlvTKSC14SfZ2WEZBRO8Hgsm4dnKvavLqaIzUaSwkBnK91XJ
o9rwhR3ZIJGKxr4ueFEGIULEkwi5sIKYELAsJm9lys3VGHgF9QCAiCcZQR36q9juejwjH0T0
yojiVKSG2FzNT77xK7B2b1PaPRIfA0cZCR+w0HE+3Joo+dMOOTS9MUO22gcHA1RbwtQOHKg8
ST5EgLRZMz2UjbiWLtXLgQeXAwKZ37BQTiwnFVTE6QsBURF5fvFMwPdQiinjXLWvo04kPmnN
YvD32BihIqVjJGKkelDCjSORcIMq++SAiEz5cU5TfXrqsETUgBgtCln0SU5YBHggYMa1FhTT
KaWhRxrxql0t9sW5H6/cEb0yuOWr8clKEGG7g8ik8GgreRSwBpQxMt1XaWpgBze0/zEwByao
S2s/65y2zqt58ZwSa+/IlfHjXnJcdNqORlACb0BaaY1fDuUQZVFk71B9O57r1GSSBXkWrhQ7
EvmI0qaWYyVUofdJC1xg1EoxkOMlh3kXcQaUNELFvxrneQdspcFjKU0Mn0eCCvbg+reA6gJR
7Sbk+JpsHwgHGL1i7gjCG9LDq1MY2a37aywQURZVHEtdrXmvQrP+9woBuHv/ev66kPYsx5EQ
4yPBSeXiFEZ2fUSir5Oq93JHK87MQ0kB69EbQKNbt2TPmFTi7Ag8IdL9zcba6yg/UOKBaaoI
cwCtfYgSzw/9sZ61OfNmK7dmt0agS+RCRyTjQIXUhhaYZ6gRF0yY2apRNCfL47oxl7Bf2ois
lRrSlbiK9MjPeZ/6QsJ8aWqbQV/CvEMrB7wnPfmCSfnBhPu/XHcuySYlkmjaIcjKIkhJXR+H
CP57I1CBkA0uLOWPO5OGLdoAZ9kHGrWVDpf9nIOoh3/Y3pa9Q6KWwe4uHX5fIq5xGR157MvO
qeW2F7qljFvFNoNy7d2GxnoabC0Pw+FU9YSFXnv5W0Nd9o/XRFRMQz+JCHcQ9oTpNHx8IPFc
UYUe3omDKcJVALWbXvZh8dukFp3gTYrVco0RKkAMtf0sRTR8KA3FfipInwOckTEb/RYLl8Hv
4NrBWlOLLHStJSNqsaTSlBGIkM0ZLV/1vYvKiwIdU9OWe7CutzltMEZtqU6cs7bgr07HVeok
yKWeB6hKw9Kl1HrcJRW3xZsNnz/X3eDHk9WlkKeaOc8XOI05VbfkqTXne25nasAFndAAtg/B
X/L3sb3Zr0+kMOVJYhc2ZJwvelmhF+THBujQ6MSKgknLdAiDPmOAUHZsWz0tP021FvlDt8Up
kT8btb5mijWAT0Bf04f2Cu79fgkp8wM2DUQeaN0zANn38zt2gEA/eoDG0dkv/PsVC58Nz7tm
y0/aUAJzNb4CuiESnPfO9vu5No3xUhl0kmpZgf/PjsiSqu6ZpgIIznO6UKY3b8eyGNpuLUJ8
B36HeKWZP53HI2uAHRd0D0hzlYP+trBKVnUD+yjQoUM1yGX5oOOi35QaXxjyj4DJRniMtvFO
bqHgeY50Zqods2suJe+S+tEB59KrYe9aDmTu48FUpNHJBDddZrn01kgrHtvlzCq8WUlvH150
/FlZeN2TU53V7IckCdaJQ4QpR1Z+LwZ0oUAKcpnn6ov/67VNEVtIPIitARiT4B4ZJOKnBlTO
mGoYdQQaVE4mxVCb/Eoxry1IiEnepPMK6a1rBstW5lE/9mPPoFYE7VauptKViPJbC/SUGdZB
GqAXDYtJzYC6Lgzu5pPkIcD9pGpLaGYFdwyAsQXbaKn/CYWK4quXEkCquA3e4lLlGeEKqCOG
jwsTDo+WfCo8/FhXWgwoYZC5mV7FsrrGPXcKxn08HLk6pyF6xXf6xf2Ch96tmIg4/VWGoDdH
QOxOatG3Fxq6cBabLQtHwh2F4oVqkWZxqVeYkqdo2Ao1k5/ZHAfoXIaMg8ukkhvqtb42Q0Nl
R21tj6/ytZRms6UTG5nkxII0APQwsLDjXXHU0b9Xu7RMjaTfl1fVkbYGt8ktvZuBxWVCrSgw
jHueT6SXAJkoVLb32efmbRMFSNmLyfYwie5++AI3WqlI2VgtFfWZ+oNgDP4qP1U5EArU+Tad
LT1Iz+FTo8kCl0G5VafSgIeUV1Sb+glXLjJ2DTKvp/9ukA7UDMCvpZznK3rK2xCERj2m+0zK
KHP06LlahY/56jmCwwdZiR/0V0e49Vu7k6s2uYGo6MDNQuGP8kn4WY6DboUgvagZtlNMyxqh
K/P7daz605c0KEWrcDpao5+383xVwO9UZY+d/9b/924S/BHG2e5RSByD+rNRHI9QdNVF1NdT
w90JF/DnrawxVF+aWp+I4SOQJnjHK4zIdGvMHccnVf7b3GvTpHlDU/PKawvwWvIm1lE45Cga
sjuxlE/acLzGhDkDVpaM656EGG/wb29fSm0IFw/7xU+SKIi4fdkVlSUXferwUsN7mBNTVEYV
djFcFHrBfiN4lxGwBctUX2TDxm/MhgbrSwcewjniU7+taVTHppr9klg+gQ+LPvQ2as72DQmU
K4Jps+vAfJUt3z4QF4sraAPRqJu+wMMF8mVvGQRzDbZKhKpJr22+bvRR4Y1eapU+ecGjDalb
1D0W4SmygM57jBdGeXp3sfM8uh8kiLTyue6vYZHqK6ZcIucEuPrew3gjoAPDm5Z7VUnbtIG2
LFD+ya4XWxrXLpI8/95b+ygPO3IRd8pSEUl0aKidployOYkNrTWckqECHt1OtlMAmfOlJjxN
ew5tIJuMhVdtDzQxgvuG8qTWMn7splDjtmM3lFxHdrNqqf5WOhyPVGv5TpYtF8bq+wMlzzJM
U5r/TCOBebtH9hHhx0ywqtVkuSO8noe+ElXFqVKoirkeSVCSjb9t/fvkn9AWtY5eIrySf8LG
EDPwtfdgY65XiUoSvFsyvoa2cm6Mv7cPvYyfVIN+EaDgXf0abs/tKLMfeaT2reJiqz6nZVac
QJxIXVD3uYVC6teggjaTCTFQDJ10S/y12+2wN3PbRp/HzxRpO2kTsohV4dwke7GHk8z6TwiO
wzgFAhmD8Tl+ZfNFqz0igNReFNtm5UWLow8khPuzx3vAfqDE5ElCFVfOIU+uXLEgPX/932Zm
gr/eOsLU/MtdrFWd61ZgtbEfZjsw6G6NHlY30QecLopERZHSBioPG+d5vHblDEGsovvYJiDV
vxVfqfY9Td4OxOZI5hrTA1l/YMD2FZ78bVEwFsdl8oPmys780lBYMs7dfuUdHlejACu3nSgF
2fF4/xt4m6EfulkJtgTalYD6bMN93YgcbDI6jOxA8UzMgHB1NKo65E1EPDESExrHgyR7XFpg
2UGXGLlHAiUx0otNoL6MW1VRHADHDju+a/N5ZDdxsK8OnqCTPFb+dAkC8PLYOpU9lrDSXeS4
1EVy3ypbMEh5x0IWFk5SJ1P1wIXpVnGE6SOehK4Y/WOAraKZoDHnY1Ce39pmCzI2eIk8eO1w
9Rthxs0cSBLxmhLpaDTBBCh856mDdjR5U8bF1KqxPXXmBqbZj/7pttMIH7N1Z6laHG3JuIzP
AUv66VgcPr/Z2cNc++P8zxaAEwbr8fP8Plv6Ma4VHj2oaHwpBGmeMTudJ8Bs+MgMOk+h+PWu
tel68I5IwrvjdHny81GJAT53GV/mqbyy/d+TnZaDVqTN7CUG1eHY1kWJPtNUFXrqFg3C4WtQ
tOFPcYfraY0M1KHi9jYUMs2s6c/vn42f033fT411C5YF6bLDuPxBrl9+UXdvRpEN+n8XNRiM
mKKarqXIK6SvmExXQKxephmUAhciY3imdUzAGOZf2sFNeRuP2/YmdoWAQ6fGZ6LJHDKOIB/s
obcWeUzV+86X85ukAoL3HNFlYv6zlzhejyMKzIfeTcir/ud2NU8xnN4NorhiGzVzai0QJlVL
eeB4onp/JejdNO8b8mwuxJXX2fTpFPrcVk0ptRARaa+QZ1fffyWW5sthTPRaYRynDjsncI3h
QYI76kUz5U5v76anRIReOpERhq9CpNFmn3zNKhu0rFccJ/Ve/ov3BHMaFh4rjzuLHjVnvFc4
0TsM0yNtWRjY1dhEoxQUfydY2PHrnI/GocPLBZgfxYUB0lkgbtc3o2B61A8N++kLEUJYGru3
wmVM0av1ih0cb3j301kl8nOUDpuvkWbFEGtOWvlzXv2AcEzI5zyhItm4I3yXD1DLe1w1a1GC
npDneRT0mM0uPoSvF0azuOWtk5hbW/a3KGO5tRU56tFLGdX586XA9EJPZGVZQQ2KtcnwdqxX
kIQdEfCdRV4UeDAay9sJ0oM+qj3eq1EFZnoTBUUxnKcqYPfFJUJ6ewtVPB8ywbWjpJb2CEPR
VATLwmmUxxCaI6r4M/X8Z9B9Yc0cY+/Ut1ipGVycVB9Ijn50X4eePAXEdqMoicTfc0NR2FTV
IB55O7vYdkJAVIy4WTB7jJaq/os4EINN+rpRTojGSikIojVw5xrTecoMKhIpnbfDgKWniqtw
QVh6ciB/I7loY1WyenWhK6KlFE2f8DAKTwDcXL/r0mkiv7qN+zW+GTN+0dW+nsy+q5zaoqLU
cpl5SHrjhUwXz5hIMWjZuoUp396wbTjMPcdT1sv/mSAZt3un6PGSwlwEb/VYL/VKeDzgnrFG
ZWBN+NBCHBu6ZIL8pbZDkLY6hSopolHPLelqWMLHued5jehdJ6xp2l9qPziYTtFd4QvFX/1c
Fcv59XSQo9epAHjKTYmGa05nPxk70HZ6SpKLCg8Zf9maY0EVYvQJoKuDpSlLOHj/kIM7ws7I
mVZVEGC9kfc+ZoKLizfaX+DKTlrE4HHYHqkeW1J/1MhWrX1kPysjUO9Tk0SLsn8VyAHw44Sa
Zz+a4aFjfoAvegj8RPcVxPDViRJnPnh1u64PDi3kqZSwmuIy1xI1uDkHv3OtbrJGaWd2AENZ
UNee8chHz7Guqk+nq5jjExpK0419nC94JP6t06rAV7OmR69pIGNjAG9h3oviukDhw6zMkPc2
fTW8/5RQJeZENyFgW6Ujrw9PJaQw14UH93Khb4SkM1zUemIWcLnFDnu8E1Vl9Y3T0beSarwy
eTKlxbhs9yLKoEwZiUPF4uj4eqbYmGybt8/cpiRRJYaxnpd7sNiFOmbaW2YnEQPHBbWGmJKk
cqVaeBRqo+pOnPCpgv8dorxVloJdcQdXq77HBbxXlrc9eQj8ZYVKUf0sORXjwUtwrPqE782G
Z4Di+v83nOufgmBlP8GUA7M98WpdaQy/qCogESq1rK8jFYN4mM06fmImtgBg2czONS0iN79m
EVV4Z2e+eSMdBBnYL999CVr70mEvRAkY3hYUb3adIgRzOJqHMkdAr7BKGn5TrzmZPkNchll+
goQjTQUTv05mfQqZJUwKqTMpRgKapj8IlBfyytdCQ1rQBClN6DRQ2i4ncjs4nJ0mSWILHQS6
tS959ytXss5Oj8UekrxoppqJPz2lDSlZ4ejcuV0ug+pW2p8rOjPHx2r41HKSewQMkbwofhup
iwcSi2JQWIULKKvu0d9FE392qnvyky8Ito6QVGPDBifvQ3UtODoziDOoE+jDA20MftdrAZQh
6ua+AAkZS3LOLtRdgBMUkIg3oNS7xflJAQocKyCGNrfSX8X0tPrPOxvj4TH2IQwbw30wnXDQ
uI8MnfLMU0HHHdFmUC5pYh/Eb0D2YS7oDOUy96Fc7xU7q+WzK+JwXaqpaHH7LY+nc5GAgYWg
PqzkjfLXs5a9BVnPcVJ7oLC37Zv3kdG4KtbJ8EGqMlXCwLpRtiMmMSF0sqLxZQzn9gi/6YnW
lvR6FhthsXlSmArqgov4UKPwKFFwq8OMv4FcgyZkHXjJX8Dk6i3XMlbruPaT5b2V7rmbfhhL
ClOZEbd5ndZU2I2MEnVFwqNpnH2MVccxlQRdZOqcZHFMTU/IJb4+W/sjUuxDvJN2+gxiTZzI
VBP0JUWuu8mJnMakG+evULN9ZquXi1u5Ab4CDzx9qEoEpHV9+Lg4wdlnE1r5hcjrUBLvTD+L
2bXV4tsuLxUQvx78JoCwR0vj0N4XiAxx3/zA4NOa0I0xoQQGvOcyN5KyHgyH79nu3OA8rDMR
KeUAf9e+fqPtPQiNwWKGYYYNxA16UhfHiMRaJK8pWRCaqNttziUzvjORd/mL+ge5713HDtXe
3YNOgikatwuasLlcwns4y1eJOdOcgsud3WG58J7lRxPYUc38AUO9i/sc7Dmx4HsAkZwJfDb+
K3nnDDkFWY1D/nrrP3JjRsXMbjTdHFkCxpQ9ApRBqm+XdK8awSe7/agCM/jrOnTBZa5tt8RB
v+7eaXxlAIrrv0D6p17Jrhzbv5o9Noh+fdrY0gUXBxrI7VilZHwKhgs5K0E6gKm+rymK2Qq5
iTNUV3oPEjbpJg02msbA8M0UtjENlGePXYZaBCBGAJWG2QdcF+9vVVDNnEbEwJ/MYWmLBFoO
d1cY7NfN1kKl6lPp3sdvuYH6dtDrN3VVaWrk60a/f4pVNuI9v3sAVEDBj9sFOo9J01zU6oo5
g2HCjt49+P/NVTrq1CzIXhCFU+DV2g49E6L6GmUvR/YKiZhVsd6O1pRdmO4stV37CnULfo7Q
jR/EcVxvDGYj4dADg0i7dmRqciV7kqVkTo67e+xA6gnwNWjMEG2g6T6Ea2SVaJaIyej6OD5j
ErheCGa0IAC0lWzjKnU2ASY0RcJ9HmS9cRTqsd4cWit9JNtiau820kMLHK0sFCDoZ0pTseLz
T3qBuR2zFIaDNg14azEPHjwLQl3mtrv01iE2Pc3Y8o0oVnmA2kw1OdE39kz15Jo11RLnzpFz
NM2bNDcZij0wJOfcL0y2T6bqh67Te9nYntVyDqVV+fAWeQ9S0bnJ+2Y1brNME2eRwKicFNbx
6UAgQ3vM8oxsFviWY7EtNC9BmF2MSAX8we7oTwwb4i/6gMl16oHHDBF6L5tDg2R4klElRLKy
x5rL4r/mr1jAUs3UmnUaqoVNwd+qqMsy4d5IHtlK0lvrTcNHHO7LU20RI+U7NS8lfFGcjvqb
+XRGbyi4Zzup2k5PCvD0QNxoNehd8cq/CYWRWvZ+15edgGyXZv3+Shyis+sF8v0IIJFTAoGX
klDBKw3T4fKbggGEOhjCh2xC4UntSFd6wwSCpe9dOmCygf6n/SHWXGWPG3n08EhsB/vcK9vN
FKFUGGhBKusXto0WB30+ZGLBlvXn3c5r+C5SrN5KxbqJgT6IGg6zY5P77QiagVR6jLjBMPho
fnI6A/lYPqn9jnUdUmubrQEqoIWRbGQduMxU9xY81mQVgRCTK5W79BndBrNEoAgDCjn/eYOZ
jNo+sR4h8Qt6bkrktp/k8e+CaEa0SSLpWQOOiXmwHRAE8E1zIUeLM3K6OFv8CYcV1XGpouGu
K31+xIHK7etpumAUmGfycyuu05m3tb/5mGrdjkKPgf1fSRMpFHgP/HY9CeFsEWIlF7j/wxYq
Lt0sqm7j1oQzHSruXyrmk2f4R0jyj69hFE/RAvUyftBDd+GnROM2JtA6Fj9cMS4iAsH/zsKY
6yd92Xq64rMmzcPadoWBUnD7H/Hst5OUGRmfytKijtDrbR9+xuiJUZHAviZcxYeB0T1CiT5Y
HB3Eta5wy4yfh9YCkEmhOond7DK9mWRvgiZjHhbliURhMkaolPVWLW6A9Ay5jztR9/lEGPHW
SUSnDoWXbxcgNpcUAcp5M9cbcHcyQLEagfNx3kmCnIm2ALLJOazp0KUSb3lhkXhQRcbwvqla
94ZTUhn1LSFKB0h4wySgVNmY7OsBvlnWCy2ibJ8bs/LK3ozP1+ikk+04DlbxfEDEK4eilxhM
DCW+wPdLbEY75QcL8U7ADgDjPLmZNVGw8CugIlVigBPGXiOUKdULv6FSrj0mnhV31Blk0V7a
NYGB/LYjtKwMoi386Hk58EbRndG+T/WJ3rsDQYhS3mIhcS3fDEyxbVjDMSKSu9fEDE0uq2sg
2UJZZD9NZOLrBmHd+XanNpCPT9sqRl/hGvk4MjqSbOdisSJUYqJMeUTroC7WW180smmAZeXy
3c48Eq49+VJWTmb//+OUmzXCDcJ4N7Vb3euE4/5mceMNBLHHnkWbr4ThTf76ofhVDp7qD+de
3ANDpMf2PN3pkjvDjo81KMGC26hP/PVto39e4M/aiDAWMYxYob5Ow7rDqH5uP3s+2Y/Xi5Ob
vaI3RlbfEcVs0ytM51AZrXXqHO/PtwzOKydnLQsrpeMQD83WnXqdjALHB/HYM8GJCz1rd0LY
7NwcIvpXBdaVJ4GEFO0CqVlFWjIRlwub7Hk/YE6qy9TH/+sPKWekdwcAFVWX18Gi07Yv2sqw
Hg7yCsDyd7iCET+gZ7QO4NQ97crpi1J9zueIOsLfXB7V1Ftw5LuVvKFf2zlzv45z/24nGaY2
HobKZRpgczBuyy5T6Bj35iCqnDRNYpsAezTrPZ6fPILTfOf1Osn/yf8rMoHH5lOXHBFGz9ke
WkOjoWCu3WVU6V6GhisrQcnrr+jH6GUrh+vs0iwcJc8b3ZFClLjSkz/2QAtiJq61+3T6W3YF
WmzEhR2TlEpiFMDntKMf2Kk5yg4fQOKroSOJ2Tmf5ONQuTk14Rmi+8UwFRjkZ5D3nsCKURJF
SEIthit57gWUtgDQ3AKrLEmKoq6v97lH/cccfbrv8mqkwbCC2Rmb0zgOVkd6P2GktgNkbOf7
m2mdhWlrdpD8DBvEHQoqUF1kKj4zjCcoZq9Agi2xnTrLNyEqcnswgVIkbDg6NsPFUcu4+NKt
6g0QRutzj/mfAu/YgulPKkfKziJUaKd6DvpjX++ae2NSFIusUltWSE0XVs/j46w0ElxOPh8c
jgd6WnbFWErPeWUHB434o4ew+DW+9fLH3IgW/Mo6n8cJah3s54tGs3L8dexbXVyor3/y8U9W
P/i3HUVCrKCS27YpLXkJNxZHqQLRUkZI4uifm32IhIJCIAKol0ovSL0IRKRzFjO05ueNbDg6
jxQSyrXz95rLJ8wprgoBQ+PHu81Y1SxNWt0fsMfYUE+1Kl+McAx/ocCmFb4SyG7RDJ/gGS8g
EG73ZzWA6z92k4xisMu+lwPCZT+WUIxmUH4CcbCO80S9FfA5aMkerChP2nBA6dwxNGKuWch3
ZbgZUbqyKI2DXWjTun89FGp5whZXCQCQMCv+i7Y7H8AWGqyU78NslP0VCIQYK6ywTO9Atgmi
0r2AZdwCZYdslSCk0wvbPQphoPcxzSeHeo4czOdzJxj9bsJtMLux0FFJDMFRqL5VmKl/qpso
lYl+gpnn6l9v8dVErBTK1YvuGN6DZYBM3OvHxZgqVRitr+3JoP1BRpWoWtpFWWydhsaqdiGs
W4KcozbFozJOsv4KYXHgXJ3pt8DOO+eOCXKE0zwbROm3jxlQvxMBOkNTA4pgoNjRClmY1iMe
59ozg50KLcgesnx2+mPGYrVrQGCos8nU/MoE88yA+lFC6xolB6IaLHSLVUTNA0lMyCJ6XnMm
jpTKipWdfw5/ga9z98mPtmoqG9a5BH2F/SYhBVxzd9Uk8qsRUTy/fk8IZ52hgrcb+DYlzAYe
P7kJobG9plYESBmmVGHrZ2BDoboJCvqcAEkb3fL+MACmqMjDCuphiXXruAGOtQBFunc95BoY
e2kWHC2cNGiatwFPxR806e/fJ9L7K4YuuYwldQFPD43n7xGsSbuyMmWhF1XQQ8ddx3N0nYz0
W1iI44TiepT192VoHeeSFjC023wVUVzR3kqISU5iiiPHPjjShhCTpB5GvS4RtAS10xZeLdbs
okN2BunqAWiWV0w48bvLhjGPloEdTzp4cgBuiLd7QQr7wzMq5iUZvvMDZw1wNehQttCMoVj0
2yrQOPBN6zbRZ2H3xK/Jw9VleV1hpjAuLihlUdOEBBXc92x8l3zjpDo1PjgHSVfSaSvo6LEJ
+vB2FapKm01Baxb7QrxzkHa+RPgG4JhS9hdGgkn6laqrBkFPycJTBvr1CFe3Hyimt5CAr/c3
DoHTEYGdwZTTfOw0x0sLY1QUNBqusbTtb+L7gyDiE90L0xsweAvasH3xqeOiM8XY5NX3iSIk
Q6WANlCGfLh1tdZKDh/NBlpsQcqx/Gcdy1KIJVvXcXI7v2moiRs0Wmz/YWSSB4SOdc6fi/iY
s0K45cEBlEaP4q95nclloLkpXIslfdI9kzWnKLtLNFyCeWeIaraYtXoeoWoz/IsbYGEFAwNs
mGNz9plFlGvqPKCA/JuWwo8CzjpbG+Zszl/Zwu60b6Apm6rTf0VXnUR/1pzyOTCqFwlLtcpQ
G2DJqf5ZGDKhSE8JMoegdgeEKFL6coPK3Rs53jBMzzgkfKubU21LDFTafkmblzW6vZFFEXdF
boRq54wtohQqditvT8WACSn4sGlEIXYyo2auBPbY/Cr0ni8lpcCf12CDx1cFoy3BTgq62lU7
9lr0geJE7FqazUEsItM9J896ybg2S3YtyT4DW2/M0qsMKUSA+q9cqKeK/x4wFC3GIBScxY1t
2m2VIGSuoWxuSLAHMzBKT5Fu7AlFyKgYPz3Q5/l0wbM/IHghHsuyCQ/RPDwrYN/QwPG3VEGv
jKpwNy1zQBJp9CdBbD2+9OnzQeNICcvYvNjpfRXxIZG6pmj68cQlg1OtWRTmKkibai4UE3og
For7yoCisxgy605p5PqSRhTxpTddFK4o2XXjXVJVhLkV06aD/IRIcU3C005P9gMmj84al6U0
C1iVH5FfR3QOWOFZc2d/3ZIFeFaq5otrGOTBZmA+xhFQ3Pg5fSx9ZC4g2S7snlcxbS1qyKb2
zvelN/9peDuUCPIix2ap2iZhFG/x7ynWJGnxvzS4FHnA4esHADASes+Iov6kXP1Dad5ejmod
kEXMCRKBhWA+fVoXHlnbX1uYlZwg93//3cdyPw3oGPiUseQYGO6nE472Rsm0kG9qEt3InuQJ
1DU3+n90wE2sDH/nzYCickaJG4luVir7HIhfvb2e241irfulQcAZE8Feqa4g0KOjR8QXwIXb
wFtptc+kzG9q7V00XbQewPn8A7v2kmv5ZFnz5h7+iNNKcmFEsH8Xwi1YVYb+5r+8PDRb3DDG
RNejh3gRGOoQXxDBW7epnvZf1E79q+wUCClF+kHKGhN8f/k3Meoi1dDcmEidbjfFtEXaPF44
3VKWecLX6ipSu69FOFXOeqebN9oY7aCzWwFYePgs3t5brErCdd/iHDiTW+ELgotz9L3Wlz4a
M5QZVkXaiGL47UIxxwuoV39ZGM6K/4cWXBuVRjPfeLXeUZMC5AjRvGk4pxR2+DdC6GXOajCM
8tFzMF53qxPOmtcq4lAoOG3W1fMF/wJ7g6X3TzMVegxnzzUdfFJnZoARBLJrx6jF3kzByQJr
eb3fkDo6fKY4mxwdU1t2pvLDrkRTFNMPY7ZLqdIe8Pty5qSzaMPRbf13JJR6C8a9ZSNIt6Pw
Y0Y3TpS1ksmfKjSneQSIOR5YdsQ3v5fyYomi3Q8waQqDPujuEdGZt7cO0KGiacGnMCnHUcmd
mQ5wVuQqyxn0ydDxitHhZksRqsNgPwqkEBV1fEo03h2D4rZ2MUjL+hXUtQ4kH7Bhuerl+Ptk
Acz48fp9j5THhInD+W7G7RTqgdnD5JhSsKBupTKzadAfPWo9gPghOYx3+cKUhr2n0vEvc5a5
oh9Ju+2STjqDA00OmiiwTzofxdzjLnkWj80EiRAACvxvEGAc9JOA5tw8II6dM7xND1yrUqjT
Hb1gzLnMDKeifjffbYUtnajO7T0i8J5AdIzDlI5fnAi1o/9kPZdM3vW6ExmhbVJNr95xNZNF
rZZGc4IX+LoGqweYIQQPva8rL2Q2sTjpO5BpL8Je6Rrd6rT6oEgymXVVdy3ErpBWxFg+8nk8
Ke2qCRBZjY4cE6HEoJuT+9GHY2SFswTf8KJROc1ZQ/H4vMLt77JtZnai3ZpPJz15DORyNAGe
DbIET3yBiMHJA2PzdUoRTDtibgOCfUXrFqm70E/E3XUBF7svnzO6hZyCuyygcz+wuIysDd7h
gHzn3bw+1bbhiRCDLB0E8YvVJ25xsnyewjJmrqGhPWfzql4hA/ftWbXmVHh4CSafvZ3MFGta
BHoS9UKuHwnrWYRt7p0TWQf501giQbAOoUpT77AWyl7l2vmTMacu6P+vuuq1nivQ4a7VrHE3
JtUzBZXCiVAXr+J3r4rXN2v4P8kUjaIQDs8w6IjxJ7xzUDPLeQ3cIIx/r21wd2jLVdt+es9g
Dit1p+U33sETLVPD/KiOC2Tl4nw0vjX0ZQtyNmfGdKeiloNnp7EhRD8vRQZVFKsgY/lOqQ6M
7iL6ixM5k1xIebeZ0jNS80CVrvwPFGX3n8YhDrb0J9Ba5X+jrlBeWQQtjiy+l9l/YS/Jk6WF
QzinhR6I9KBk61aGCxjNPiZWYq3cVc0rDy2BIeVudOsbix1G2FW7Mv1kk2kS2cqntvW7zgUg
Ka6VhgdS5M42gwtUKVs02X670EeqXV1PatqkBzfv1/I5rPTVkd2ebuhkJvjtPHfRH57J4gqO
Wr8/sw+K5fjrvHIbwmMQUlspAQuvow19XAfqIAYG0fcc4tRcjCENc8TjCj+cpRA/Jajmkb66
KHFAd/TfQiWEIus0wu0sKmGsThuKZJa7e9uzoctdJPcUn7TORm8Ml7c/oYV+haOTlI2VWdzv
g1P71QOswCkwxwuuW2zrwwQH6H76gUEggtwGHP2wRXx9WY13Br9P9Vuwr8UaX4YuA8hV/xeR
br1ZqBh/Ioj1nhAuNAqUiKLtpY1ypx6NPStrW1OTjMkkUFkndwRnWqQKGm7yUKuXt4HB+woU
a5I4Ns4yV0brB7crJYPIUqYtV9rAR6s5Nuz35CNhsydWsfGyf1Vlql1+w0ORGlxwCUQ6Ch4v
7doMYWJuxIsS+SaFInjPnlOnt1bvFT96bReOyFg6tNJQx3emRsLZYpKhjOFcnUX50N3QREyn
NWJx7UfB1kEVKLQiZsGFLS3Rj1hkysKRW/aCaTUe10OgkcW59skKbl8CxfQV7cyGngXS1V9P
FuGBSh0Y9PmOFbFquTvIYT87LbFvNBeuediX2T9CwLTL0w7ncHVpF4AOCSYH1pm9/eUq9tmo
bgltw3CN2GZLBghIpy3wJ36S7Xl3XCNeTk41/6E7fux+9KBDPPRfrIxhkzBpt7zhlfBwi9gr
83rg0iswjVuwOFxdoicaaIGJbHhB+AvN1mPVaWeU2qTy627lC5f00u+y9LUgNUraiVCphwLz
9OetehKDcQP4Ijy6KlmYAU3vSOtWkioRP+34RvGcA7SL9zwAb8Z7TwWSUtxZAEGDggCjSUAB
RtA0tOF3ULKVJAvV/cOO9AeMUY0qax3h6Hw6sr47OmETueEvL0eaKqICkjxOHScZ9lNaTPd2
tWSy5qMTQepTs3mR6+zFb0VrKe1B3y4+IDtR7NExsBKfxMiUBtwPoHuZJnannTmP+nfEijV9
Ay2aHJm6wr3PZ68KjDXRLGfiKf3VfG+G0zNzqIOJ+ICQY58QsR93KTH9TW1ZY2SCVo3Bgmhp
aTx++F74lQBE20pP26CE1fo+J8pOVoF7m70Zc7xJjCrr12DCYS9y54ATVizDCLcNqv9UnlWb
2Y87JAh1VmCOXlC4ciWr9VvpU9GtO9mLgxnUKjKiLGj4tZ0mhAKAKax9QQTjNzhL3DSZKkTq
FGHp35BUwccZmqVPqmXIkiz2NwIXtyqta9k6jbK1mrLclrR31m3941ufHWWxKU26djKhUnZr
qPkKs1q3ghMKvb33KwFWDLqs/DY2/azGfQ0XFu0YrWjjaqD5dHjjzHZ3MeJdJ+ZfnswwPdtB
+hIrf7qsLVt43ud6I5J9T+XXsHmFnkxAxqVZinBxk2Ucx/3bO63Hyo5M0H9F622teLeTo8KB
gI+nhDtLLrM3xbPaOUdXxAgkz96y3Gxg+fVhTAqiOiUdZvvMw3mk8whzLOOaDUPFa/NPOeu9
CiFEJiRLDoGxo36/8LBo+efPrE7dnSKgwlB4wmZ9e0TwL3AiiXqiLp0xXN84gh1TAqaF+3Kl
AA/n00uT7ityq+FLRMIshJc7vIELbbociUzzS+qAdMskg9vrKou+d2nCsPDuYEQotzZELRUf
67uX0KxsxKioRMMYjS8xnlujoBebcWpyTUHolZaxRuq/iiPjZN99cGEUZM0W49sjbf+0Y14Y
LWVWY3Glc+IaFJAmzLE1sbqlDLTxlFCGhksBh63purMGe7ePxXCFFp8JUicaK72ZZgXfPFf2
H9ABaGoWFgpabcvvhtZNKv+wmISRpsOAFyRuWN9G7499kgH2q12rdWfU+YAcMBaP4riQp0tx
G8VsNBt/MxyHhEs59BnaIbSBM4O+/EeK9Pc33ddD9lHCD4Z8DpQbx9u1htSdmVDUQqKAI1CK
/ZTQVSfxQj5Dnvxd8iVzQqZi47OFCJguyjoO7lawmaJsGkAwDw3XCt9JImrpqxJfCuezVpd6
/dEhT1Kq3+PiETHb3AGxpxDR2X3Lfqlsi11xQmkjrGodb1+sx+H7f74IBGpM1WwkVIQzfIv9
HnJdX7pX08puGVFKOU9yfxWiD8ZfWTHnKYf2VeuomtaDlQtfB0VSFXzJQFCGnnbbDnY9Cq4I
DcCxyApMC0+pzcnA62zFVAl12Lpc2LB5UOLLQsfJ/q53EnvMlXS/W+KWyF9LiY77NrDWPgXa
53x0vR35EpSy2VgcdY1uPUloAT+lCcboGkmBRmDY3yOrd1qzXq2cAHSdwER94ph/RQC8SvPI
de7S8ntsj0qy9qQ6ApWrwfmzPvtvMrSI/gFTtHsIEWQZDIJ6wSSOrLchI3HKxn83gRSdxHNQ
+JIb9O8LDjMC7H67l1ww4QTd5O8FqzlVBRzFyLC0RVgEA9ioQHK0wLoa94xNGKEpIiwR50wI
GzoZk4Rf9p5LYih3tl2434KpT63LREJq6P9IqzhvXYm5ABTP1dhlwWpWOjuMitiyZRqzxBAq
UHn8jiGi3mX7/wdf4cpzWWdyOucFsgmxDPmqvvj+ijjeezUw2wBY6UmLrHwmfdWhVLf4HVec
lJwlixWSsTd2H68FVf0AtB1lB4ZM0NODg9D4k6l/MnFB48A9Z/JQykwl+/meo44Bzu6+lIV4
7YhGNNmEKp5u4Vmy1Yqj1AF90D+C9j1vdmB9x0mUJKTqmcSfp3uS9vLKOHvP7ZycJlSO6s4I
zrhCZBkFznVAJApSWH32+gzwZejAC5q5GbFTVmRHqms7fi6R/8LzqSa9owZUCKLPvrFKw5xs
b/+6wNBwNsqXUrDY1BtUndtk7Q8/cAjck63Gvawnwjc1GL9a3QxGZmJZ+T6kK5CYHZI5i7xj
51zuGCSwaeDD9C2dLdDo6N01a4I5tbuYhbbnwweJwpdnnNVCrQN4Lol2nksUrmGTzJ18d1OB
Oem4rhSRi8A+UGXg8FPE1ltNn8Pye9Uu9rGKWdoqTL2AoHlmGI4rtLXbbH/ilBHTvMGRDUO+
5sy39Rtl5msBjbtbagPYaLbyKlP4L3Vdmz1mzAyB90i8h8g+EEk8031+xTH5YnfzBbEhI8xe
FZp9A4bI82WeSkX7+BHbSjmUktmJHcHfS0rKx4H/wm3e2ny1dCoKhLp4z9i1BwuWs5oK2RMv
c/5yRIeVVQGxK7IhEkeIejrLtCKvE4WEe2KNq7zUyWhHfdsuz/D/ZM2d8cH96Yl97nwPgnBJ
GxMq6TNaehpKhyYJuS6ujgJXhvaEKkKwiE+0q0ojMuibiMf3fpQ/B1cVudBY8DV37l3QGpAx
jRchOtTYSKXe3lEaKAvrkKqZ0k98dcNGr77E5yzdXN/V4QMQwWvdajIzbMYCiNcmJQr5SlUB
n7nJyWZlFk+KdfVXtjhP2i/S9j7USjLytDdLfUMKNt5S+eXR7HvJUv8knE4mlPNno15EwT22
avZXlufZ//UgdCufg1TlVw3v1htx3y9nsNPyQETe7nzi6eZpDStLQlIw9qh1Gg/iJ9MaRl+k
RdFG4f647CzgsIPezbD3l7BRqbNw4ED49VYjGWYmmWZfJxLvUnR3zZ9dctK3L7J6YiTCW8Vf
zaZhsAIsXPNdMr5+5awhohHlJ88u+5oHoeKKnsOFRmkwG8ydXdp5Zo8Vxi17OA7jTAs7uF0K
KPH2d/q2yNmHtxCHu0FDmouIbB6RXJRxa85/bEFmqqKqjl0gVMSDcRWvN6+MgM4eSUD83KX5
6aJoDeGBu5Cswz31z/yKx5nCwb51/VXzeCxoP+JrBNQo8wcVUgoGwuSGrynhQGXRwjGNEh1L
SMwdUyY8gJj9kcLvespdraTI9qw6AfEXEwBXQHO/1/j2TgZgsxazZUCTMhE4by//k3TQRH2Z
U/FIPhzqukBdjZzVXH6iZBK5mKQoFbT/OLntGgg8wIL+kXWjcXq/KZf3g6pHwbgMfCRtrAse
/c1k+vSYsFugtaE+kbjYE9TcGZYg6rjgCB8jYHSSka4QYwOtdgSxGj96sUYipF21fLxZHa1q
P9VM9yxVP+PZsDTOmqXB0in5RrkyAkFaFZpnnFHVzTd/ynlUXzPHmZxfcqRbNUmFKG4ko9h0
OE7ithf2saMnwkznusiS4DSlvbykzWavqwTjzl/i8nEWHoQB4RUrOncGm9sA7qavtV1zLMLH
yiwQFyYGYahDxPR2CyUb/39v+rnyWDiP8Qh42PCXWs1NAu5bwi1gQTlstspcLDqfqGMX4wBx
1TZpJUoDYYb4SMClEiGeAT1yv/x0ePhfLd8Zl9V9Tl9lguFcQBsvoebeGix+FT+dALpARtai
EKpqU/F9mNVJt8JQosVMb5mJySItVwfP/l+xUP/9kb4c+qSu9eggiPELOSMVGfO5zANc+htd
wCM7UYttVpLsQvSMH/+5HYddbqZSeIryK+J53p9kzPXWjEzlhDCwaV8XXQGOmd5J33micbTm
9Xt8mMT90IJZbrP9v1auuQiWFETEoU1MPJESNQkzNWfbpqU2BXI0NnKCQJUYJ60fSxT/2Dq6
R8/eeOKtaM/m20uJVx7EPanGLDe2XO9AVYWxXheyiVcKUT6Xw9DfQa+OVUimEGrGRIugnHXH
CWCaL4DqugbhAyJYL1FNx/oBdu1CYsvuICcDn0VekzFO7VvhQq/ceJ1HMmxFkMvJr0a+1BkW
l21PbFZSVeJxx5tZzwQIVDae3gjV/LrLiSogNwIcUXWD1o/ZtCLUG/16Z/nRteuxNmWWeX7o
MUQKBpH8wc+tonyn8kHWv478l+vlfK5OJo4jrJO+1KMrOx/y8LLOb5nED5YhChP8MdhnMIcC
qn/naKpsLLhI15dKdHUY0SvqK+lQvYQ0aqLplj7OPDGJqBMz2/gxlivJibWbNPAlG/wqN5Vv
igkJ0EHZ8N2TYrxoQbylqVeyoQtfY/3l0dNKKyjVeHzrixKhcEEQHhlbA8aJmjkcsYHn5jnB
cuTJK595DXbYk65NRZz5SwflvNXwE4ey0EeV7LQauu7Mq6j63b8wF+kDf2IrhGYbxX+cbZ7P
y3YHWJJqNQDTBMWLhtgLc2efaZy4R+sqB5eHtv86OwTTiRCml2iUhHvLKJVm4kWouTErxymO
NR9c08J1Ze3dpc9A+QcR6LjaL5VT2NTqltela0ieJuXvA78q1oCXVg4E4t0prICQ44Eol4Vg
IV84cw0JhKHJuZaIJySH8Qfj6SIyemUTR4onqt2Uwp31vxUrAsgtLJQ2H6In2ScQsph/GOpe
qF3gXuT5sbSZ/XA4PpMmDJPNXojAxAEx4XROhEcUnB3yIhhjBh1Dgwc/we2EX90HedpN75li
wM4V36C39P2UIuGoExUqZezHyMqRef1COmTiWUPnw/GJpbsDk0FmquaSAuQJlajoa4FmqnqW
VxyqOW9KIzQ0cNskBVROxsH3sIM5tYh0FZ8q0vfof1QnxnnikL48iy12NFB+DnwkiRWvkbKU
Ck0GkpHWt9exwyJrrBLf9HWyt5G7+lnkQ6KnnMTGi0Mi18kTWHrqe+xRgunHzamso8ZVpWI7
N0NmqGO/29eXmM2675/ilnoWnDy79T5tqq0ibVlnwfHDkwTFA9Sa3wH/sRtC+QcBfFBJJ0Ud
uaenvzN1A2zff3D/tQrhDUj85qx4tvKCLDmX870l/cZ7LfBj8nPAeWzw26lxJaxu1U0qSQpU
aT37GwUe26OA9mDV8JU35bqeNpAUF8upIIny2LaWnJnAYOUNmzvtGCBkLl3FyhdOjAOu1rnW
/2p0ZFM8F12xkgdHG9/58YBM28xf3B+oihBVWRqt63940y+Js4LL17fvtO2ZCm52WL0iZfGK
7AlVZTRFtWjM0JbVLnUZ0vBR00jXFWrCyiH/0dFSNRnD0FbMkjhlTsqIC6ZgMRo8dufBNS9b
S5mIkEI3T8XVUCwVTtQgJnBOAdNOaVMLqYEsvCQ4VBTfXNjEUWPkDPsLlpoV/f7XFvHmEAlN
sn6sbAETy1ZgVc9y0WJL3FLkG6rHYQukA9WSL1y7zBVsIT5YUgcJ/7iRlT3N4vKTKuRFMYna
MRVOY2Iq6yJHag5D3TxiELMPCAxbJeoYWuxSKrBbQ/4Pvytw8FXbin+XT+RdzRNY8/3K61r7
n+TnlRKPTRahFM+thoaCBKMVKk/p3iHm7yNmpIAjrfxu4ocEYpIpSDdqSraib+3Q44DhDh00
1zKlbTOzlW1wmdhN/oxR9zBbQ4BzCkzuu8x71sIbYf39iWMOoHVFEcP+TwhxkLYpjnRg5+7B
T0Rgnrt/mH/pB3srp+fNwLhsH0y+8CiJgE39FWDAc+61YP90qOvYWMihdAuYpCihr3sBRoui
+guKBQZxvmH+AWeM2+tg/p8wal+N1nf8943Y+kMkLl54Y/h4JdFtZi2uCaAWYTUEYLpdHBPD
zNTb7Mj79C2+9rRn3b43iaV5ukMZz33GzvkT54/JSL0qGngAv+AlXtiNoExVHgPRHq9tDrnq
Ejv1fy+YaVJKD1zbasrFOa+MRFuRF0HiOzJ6i5/rhanb43T1h5Hgwry9KV5jxcmylNvmnvB6
HUXdiH6u4/NMPnVHGep21DsGeGyGTbZ/cZw0uipETJCGxrxZVYQeKRaXPqg0shhyLLk1Y9E6
5zSLIgrfVmRwofp+VcCGMrD9oy1dIFyaB6ta+GJSluVqvWb/m+Zn64OcL9k0ETGojy9CZ99f
TAaxyTRIoUQHKfYEa9DS5H+8/h/OHu/0YQ/reUFnwlEU29tqXh6u5YqfhYmc+zThg3xHTKKW
vq5Aokt6jtNG1tKjcy67YZQNvMx+xIWCBgmCtnnlLQkhg6btGCHrDoncEfGt30GTP6fPmkMz
x+KABuaMGktfdgF9SIVFJLLAHXWZfGZQPHwlFgMB0Vd1XMLkzv6TImp0AjcchS2dv/BAgwvZ
mESwu83hTWrmfOJih3PhLjYsHnOKb3dwTIolkMI2Ijr07dbNdMJWFHfB5/IBdPCI9AYfAWyF
2DMsPHZ3ZV2s2AFVK8U+zqTuGdzPHAnPEnwlwHs6MT8RShE6i2Jt7xwkYJi+ModbV2zGe30y
fbkI//hxO1H2RpNUlHmL2rYTXWbBpuiJgZ6ZCNd1SaOQxla7hY+LcL53vvMQQI1G5Dyex0mA
AtmFS6qwdJK1Fi0rtC0Zwpqgpfq9sD05bEWLpGcXwCcfu6YeUyPW5rdWgyoXB1iuKU9RoWaE
CovVPDQOZ+G4ZrNUb8lEpBP+f8tMw9VawiYZ2LBNxc9ENwInFHlkck3mJTNm0xZAZww+qDDU
3v3U02jpPyIXnyPylSX1r3gNEdWk9kdb45T0xrOm/o3VKXGfxT5RWXDhvqIa3ci1M/i8Q0i9
AhKFJs2xdxUdeVQkkeSsv2bZ6o393OYAstnemjBAfK5zOoycubpkOm5KBWaeXbQG8DZ9cSP4
X/gFwUSI80yNtgUW3bJJS2uIcsdBlbqDd+jLHCyGlCvbX9RUYAn11Vk8rcBcMHceFB0jYEys
d3adFS2y/cMOLP/up/NzOKpK02aE2oJCofSCN5bYEhAlj8uXZ2a+/WxLuaL+E0fPX9bdfw5m
6PnViIPP1NJ+TEwaeBkf4FBeN60z71RqdZHIJ5WCdTX1snuvoaGIp0XKtdOLOz1hExlv3bCb
CrwGZen3Qp9NXRslcUWPpAgKnbU6FQuNfWzwdBYgFDuS7UoeoESKvlsNrWolPDKUU33CBUx0
SCkf3v5Wt1aTYHUVGQFB5Xj1aipchnu4V5zzSpwTOUDi0rF+zY8IWGvG9Tr8aKGkG8W0d4P5
P1TN5RuUMKjZIAEFg3jHEg5HZX9FzZ8Gh5QwDJfcBS7eSrLjOjVsgDZsbe3WT2OLcPlIKH0X
ZEkiCpfMhliF+q2BqxkpvEwYbnH1AtCSgKn88y6wwv2/wsnmQpFGdRP7bkWnIH92+o0hPs4V
+t56JXNFzF09X/M1eEl233tC42LgTgNll50yT5OBNIgvaXoZOQFzwrvZBoK2jwjcqCsY32JH
8SbOvaqI+SMlqJ+7BgRmZ1wymYfx76oTHUquVBdF8YbMjzsFHwIKHjvCCPafFbwEPBzFhjTC
/pk9zohzIns+Ydo/Kc2Wvhk+mOYXKCa5CKMSgFIxez3/Egq/z8fpVRNhFnkO4REp3p3TFVBo
++3JgxP7V34jTTk+p/dMn46rW490sL3ORFz2UysYEIrh84KLRo8raSdCNnyUIabkuFBlpBM8
n0sZ1X/uHy5/Me6myGlLnL+d/k2GP6qzo9t2w+EuHwpofiSmMDP+aZ2WhDtU83C1yI3eqxjE
SHfvY+G9hdMrpGuTuFWTpEw0Mn4KyuWszD9p+/ul4r0xx9odTeyJo+/crP2i3W6GxO72uYQE
Iyld15GOJ2BH3w1yQGKupIUHPAOBSJsuCJ8MY/ZiMs1bu9q15craXv8xicWrt/cLUrjmJJRQ
e2rma5+vxvT/z9Y69v8NiaUFYxwLZQ3AyrLcBV5VVNemnRI8gY24q6GoctsBTGg10sdLBh2Z
DJVjvq/DA1aAr5Ml5uzURaItTM3h4iuPF1cfcsCNmEv5lFccVeIZN7IScNLyZrm4albKtqlB
XfKjS4P9SgFkv3OQI4G65kiICs3XEBLqw+cC4OjI/m6L58n3jMAbjXqI7wNduoB1sXLkmMwa
15UlFyd91IZFGP5Sb+xe4US9QWk7VTKTHddsFqCiD2K3nVssl5QxnETEOC1xa67DAbZBPNw/
oQWlCwYjacZVbCjdabFdwzPBEGGZ1b3eIlzaOGfn0evI3ShaFNlwmcOUdTCHLaphC4GX4Z7w
Eek/eMTk0LqafXtg3chEITNupDGbx8KbWtFamNIArakrONi9gGl0RAZReljWXDi56IdAuFAm
XPXNw8p/eGcvWoaW+BDDLb+A7PtAJAcjV/dScW9FRY09mUxIQjNnk5z7lA5VQE+SCZ+Jb8eY
RrDHHTnWPrNhjOQ7VpxPCOQ67e9PqQ5dmKEiVj0GA+a9bkqJNesp3Dzj1o30Pl6v92SQ3Us/
duaO75LK/8g/CcUXVik4bu3P1sUneARbA8VGoMOK5pnSsZTcOu8xM47jf/VpKKj/2+xAShSS
0hKOrRkuznrNNYlSxBBtCWuoT6XFr2oB7VUtR7AV3nQRwd6Da8HJAhkeIxNzP3tllouvlmDX
ICDJmVYHxsp0Gmni1sLNGYIGo5MnUJc8ijE69nwvWfIU4TiXzRGnymsHhMmWMjnW0Fk/6ADy
x61mIFbMBS26aUic5n8I7woCKY9lJo0UTKVSMz6D9UvKUbHov7vgAoa+JF1mt5Z+Kddz//yl
nFzy5nZ+l38eta7kPjyNFOUEBq+aR53LnE2JJSi3KBU+iyfNCO9BCD3c+rKzEhEOffTzLAW9
bE3eCVE5r8+UbaZXWQgIYzndp8cYDG/OC77ggGTY/V1fkU8+hYLLjjdZJhrGiOJAAuQo8fye
NZvQkC3XL9uEFXIJ+WvBKd7H2G6NdKX/ThuKKgA3qmodrNtdb6h9IYGvG/4FClijaXipsVzq
KC4gSo+Bd9BUwu4ys7ONgqhGHBWHpxzUo/fgebBSc1ntaqepd6MIzhPKb1Rrj1y2Tc1RUhyD
0arvrlCcIAvhc73Ozf3Ve0ONEcod3ujPTRdJvBqfxAunNbQmKNdvOvgYhscp+FJCippqGxaC
iGDzm/kkjy4R5xkEFlFcRO8Jkyd0tbFatHuUcgyoWO0ehh2ras0SV1tev1MniqGQHqMnSPzR
zNiz4LMDGkpMTBvKb+5JJVK/D+f/QpuH30gPGyiEFPZkKbvNn5XGgw4DjavN0J/x9R01Cdyv
1uXyki9bSXn/Kzcg2zcCjlU7x1vc4LrvnsdQoOcqfy31QC7ECwWFFWsVspNlAONkUSUPFgkQ
aiYktMfeYpV2TolhhWglgRgOBy0xrgXUrDk9wnSbMXdmJpAxwcGxm7bXXL4ZweyXSjCbSyu7
4Zbabh6rFypoiUN2xZbb/RNchnzSeoyuUumUT+Ex1O1GN1vL0Y1vllU8cyto+z0UalQf3+5Y
HiuyRcVRfJNs3zrTGqHReYHyvGYf6TkXUUBgeqaJ+kh9WeyrqrXrZpUDeEeRfQbh5uY5TlYL
X8008v3cxRK7po8tFgUuNFwznjSE2E8sYytCfYaIuvfF7q0OxT1GO0awuNFx9JidbMj7bDa/
5yQ9FMKktHhgDEFj3cxrRqH0+Tpa1ivxa2iQYjLjwyc4wHHb2uj+LNcYFeybrRF9Bmhb1l28
IQFnaZpgODs7dQzHd4Fn+Qt/rMu7E2catD4enf1xbANmdVXAJz/TcUt2UAJ4RPEo7xzoPl+1
BdInhltCo/UiEj8UkJrP1I0Sochnx5TWeCCQ5/B83IzRemvrlzRykiQEfmZnk9SbOQb7uNnS
BxZl5tugJ/ldCaTnmkUAMlyOXkNI9xPl6Sb1s5E+KBfidKm4nrQcAYxUaN+80HF9yrrPzPwB
smyJnJQCnnBps976VeIQJPx8GJrOpL9lFCS2T8wNZJyeDQaNrSA+/nxrM9iZFPp1UgeM0o1/
UsHbChh6bL2khGtZLa2SSeIDIbqQQWLRFTvCc3SzonsgsdfPqqaC/GW8S3cn4XG8cFlpTcP1
UHkdVmmyloe3ZFDtud2kQ6aeAXwKDXrdrhV8gUUOz8Jeb9AKvJCwtxlhSHi/H0sZXzxsaRXW
8WjKPmR9Oat4R+gpi2oLRH/YAOnDBaIfP8ybQ+5MTp8rDT68OHoAj1RTOoj4uWMfdSP15yLN
qKC9ooaK/lmRAGOmmy3QBirQTmqGfu4wSR1mYlsI6bkXGoUlJLATFMHcsT4J8bEoP/Gmo3gJ
rubKUir6KvvA66KgLi1M1yRwzSBmonm6DndKTXTEqXXTMhP6bC3jePRmXazry+IdureAkMth
H238DwMTd2jLcbMfCZ+20kfC+7JJMzrBpdyW6lvzIRmOY6H5WTOH2dWQBRSMkf/Qkpj4f9VJ
McmMQL8OYzdvRCOHVUX2I0q8Mc9iz7Zro60L003OfRrBc7Aeb/ITESVNFxZUkkAJ/rK8ttx5
/iU/bCdmNcDwftymoKdGcbz+jjQqynCpa3YEVzYI7EetAJ6oFxLoyr6+nAR/sKZM2DVODRAP
dd6o0NnPjU0PelhtJsM003kB/1X9F6FOewZMr4CQgqgWuIUVtDH+MjQ3sZGjb8+f+ahNPQWz
OqJm8OJYvnTYQpBnan7RJwr5HFfCmVlhPfFloHZsxgv5KXgOaSqNdriM9cTAbwMGOaH7T8Rn
ZQ61kB6jOQ316M4oUlPZhSA4gMRmX2ktPta3ofg5Em46uNxGSL8GMKuVZENoJhTQ0HVaZXAD
i61eXoZZasGQygx2rOte+uCgZgbbfsx2a74ZUOaggsd3Ng+HDilEMTA3zMxmCTF1Cyh5Vrz5
snqIJvpU/yQXkrSze6KWJLyrU/XBp53O9abd+OHVBaX/hVe/rsuDvgLNWj23NjI+0Y4yVlsd
nyttpW2LnNNZO7FUmYb6K48LMBI+77M0j49h+KT0bcCqcSydzt9bBmeQqSWbcj+Zk1qT7L1x
x27D92jcsOqvNzYpjaiuM3u2hx8+8ev16NAFTZL8UPbttlhCfAPA+XzZzDjGjJKoLNaR3gmQ
wtdMBtv4ITCcl3lpKTH93j1/JHWMiVif5wlP1kTakHfaCGAITgKdircWGy+bbvQl1Z7frTZ/
nMrl7MRvyy5NVk7RHBwqD/lhJnsmOpsTiqms1fATnAPnLGSnpkSRP/oKykMEItpWaRj7w7CK
dqQ4PnDbT/qxGpdgbwHzBLlbOC8u7qtUesKGQfGgxkFLn/l5mfQDKGijNIzy4EVexpbHyl4Q
4ECWS0tL7tUbSldvau//uFRzM8OZWspfxzwUF6UygUzuKuu7YoCt1Sf5dqtFvmdA6pnea2pN
tYrZpJLuVPskTqONjlo8Z0jc/45/TOugLSwf58GjB9JwfF7c1H+w2QnGpSpJXrMz/E4Lofer
S1oqm7lSpyxwrK1AQnRwbmqgEFhSZnt2JF0aAjI7vSwNNYe+arZ1Z4n8FPGdZeP8BPG8EpHW
UPgXaJzqabr2A1Kfqa5apddxOLFOULUPNSP2MhMpdEs4OYWMHGgo/hh3TsLnhxCuAw1SS6AR
MtIL0lscA4GHAUK0/oaAyf0jnO7PRGXZDQiN8/pNyYxFO5b2vLmaWbjr5uXOhC0QOCdgBd3U
Dvov5G6FG4MIBrSTUxntpOKIGndzYrqzjLAXNL6ojZw9ua8SOp0y47sMhTMQH8cKdBeae6p9
IO4BaYMBFurNlCAhbtEKpJU5MOIWJYevuLQDXX2imUQSj7PsgWwn9n8mZMiGeGaUCM4bJR7x
lOVUsewvDvn+1Rn9e56mPf71VKcZWWuTVsc/N8RoQ6ojQlw8QaEsUQlhj4t0kH9Qk5jNEwTZ
IuRlCob9cD50Wx0muLiIrMk1Bytjba1oU0YgbGS/jHbBrK85QoetoNE2FG8YqMSQhWh8ohky
Koug+lEBh9OZMfmczMIrdz8gtVouwF3e2MtSyr6f5F1G4RyzHeYr0WQOz5CcdhRr/iBW6Yp3
ErK3e+R5sCHACIgSdxRmwSp1YSqV1ySXKQwUb+R1Cd/8XLgHRm0jeqPXACe0flIx0Zd0jo8J
9VFi1iGpFPgF/EoOluiLuZvDVZa1PDpY8OSzctIzf0EDBcjSDNBwA11+qb+OTjqW0VaTABuj
jypRDcAaJl+FupZYFlOMQT9Hks25hxGEVwAHVSsWU3gHehoO3CkMN6+odMveg3q4uXGvBkTU
hwfntC70XtTzRF2JonsuHBF6I+V4OFjwainJM6AajYrkwZFZolxSN1XvzRX8YuJEFU6kjug+
zJM21s/gMqFixOnj/13AVUwfeUGyl26mQFD9fKKAgLzCny+QKu8hmOV+XIdGHPWwOvEYgsWn
s1KR2Nba9b8uW/NrChEE09YcjkMRSOwFm/7lx7uaEAsh705xxm0O/Lb0McuxiDIAG4M+Spsp
l5LfLIFc1VZoV/pg6G+hgVBosV52yVInkxRhbd1UggTzLKgOOwmvwHwBERsRS2cOVe0xPKm/
BA0t5q98lOMve2cumPd2D5CrmdE36udh1HHP80W1nUdxU830Ix6COzrw5cssMJhaFjv1YNpZ
e8O3mQLFHxDI6euT8ELYYuyVBe6djnZUoCJVE9zPIPHKDgbb9MtLqi4WhuRNrIBh3G/1YIzK
3cOydqy7ETp1L8ZcQ3bfHxiywTdZ+scLXzT7Vy/xDLpYUXgulEb4+0UztDVojhLOY+PfXey3
2zX8iKOTOZYjL+14PTJAWyGx3PUEZb/nbAknO1fACv/0hz2VtMmRUD9nyDfIf9t+HcwIoTL3
OLgd+LO6SL0EPdGZceCYW7p4u8wz0fObwvpjLVDBQ1ETymoN07xRSkb87xEdqTWAkwZyDuiy
EKuBFTCNANeEHaTBKSkofHEHxelIQu6t3iarqAqFuMb68fGrMUvmDneDlMapFjaHheUcLZD4
7qGsKFE5Hp4jKWEbidoKf5YpijF57LBjM9KsUSwHMeuxbrckIlHQ2+nBsF6VsJKoXpUNZwpH
Eyf/SduQLuSCm1NtJzbmyWEejyuTwGwzaRzo7JpYCYzUWam0rTodZJYyafNULEALfLCULN4G
Yw7l5pGteSSsMRmLhmxULtV9zgPna/2xJugykj2Dm6BBXItVEaRHRdBQIYk86V3Ml79WIBIm
ojDU9wfirR/NoPX4sQAZkUuQDE/1kQdTyKwylQQtVssQhxBZ5xfF9EBh9OIuXJdGz/bwoc/q
pYEt6VwKXGGof9afhYOsZJo8B7DhRW3MAuKGsCnJiYEkjAqW/7jP14ZF+tdeNy3fkA68WOa9
vj3Z1IZgGaxSZH9dxajgbZ16/0SJYqrXmVjMM7VDGBWiFBRqmKR1eOqB3BJxli7sRu04PwL0
n4f0NsWbr1l4VO8k6Iv0k1P1T3uFrs42575UUmHcj2sbBCxkJ+g4UU++u4vopIvHiCN284kW
7K+lbc4ePmDcWIQ9U/SSkqZp+QOsyL4QWl5mRuqW5qn9mX7+8quTmJvjoGszw2jx2qQBgmqN
uTs9bJXtJnJkVW7WigKopDQfFobz6nFbe9LNM6QnnO/As7/XskV2b9QrNKw5pDXNI/+410jf
Ete5XxHltnZ125/hyHn81NBRT9B2AlTHTVJF+EnBhX/Bww1MWS91iJ8PuQRj8lA76+coyyLp
KcFvhlhoUbSr9a3KRPVuVGyIpSVOZwwDNKIvbm4ZzNJwFhCgqkDQHWBbXoRFLjKx3EYIbKqX
tEQn5CvzXF/TCE+bg+hXdD7vM3BQsa2i2mU8FBmh4RGZbokhvFNpGMxeuRB+DszEpmUcfu2r
k27R7w2JRD+oVyYV0qgqlQMPesPGJLTstar3DWRh6ZCl0QvfpTSB+lf8oqxa4wMfJgQht+QB
3IGZWMpwLpQuM3W+nI+QactsDzqFz1sMQ5QGT6wM5hUjHqZjX/kUaxAe7kDZZ9uNW7SQ1NR5
vdCOIqKJsHkd0Qyb3IgmvC0vwH2hNgJYl/FooSc9y4xjJi9C6anIhHDJ1+nMT3uL1mt64Au+
epKu+t/TGXjWhGdn7fhyVQ6a5BiYVt6pbOLU2D5q+M2r4AJ3h9/NhMY+NSbdwYenngBqYtON
WdetwgIN21eiAr89Qz+uy4tpo/SR+BVWvgU8/PcQzwHnGDWSfHBWb9ZLJzi8B1Uf3iosWaR8
O0JQGptrBAiVRh4oCCioi4cBuiDf8Ksx5YNYX1IZOXX1bTwkPMjgSdMx7JTuQO9ul4/uUuV1
RksNwgA6vsadjW8M0YQ0IkMAeXURGo3DCiu32ImaAefbO0vYvntWEturtyd9MuGX3xU1cKAB
HGwA4zkxMkfM/f6uR+0OCgmOcjHg0YxjA8ZcDDrcCTfKotJTVcLv5rfQ39wLmLH3x9rpXEF0
Zft53hWP4CfQf+aW/SbusbznMmwF13Vqhp7Jvlgg6pZBkekca1L3T4CGm4Pdr7oCGRm6fnFo
QFxtLxNeJZh/+Jt6qKMtFb1iczZheuTnwoMqKx39mhDc8vup8Nfymyv1ILHoG0J9Lf2LWBVL
UIF1mHinwM/k1coFuu0jixAkayuPqdQpvebJ897EOouKqz8gDmNV87FUF5rvsKmUoPUSjloT
/fegTovteGVaimpJz46pJ3njYy1VQfLVZdaXv0nRofLaL+v9r9MufkzAUicNcHUiXldY7s7K
JtRkFVLP2bLbQK58+WUjfGn1eG/95YXyi3BOObpzv4r9mNTyGhobaeEaVhxAxhQtALQC/tzQ
tyS8Vd9UJwldMpT84a3mgXOshB+MAdxz6TmWT1CrFJ57pzxay0AGugaFgPMMeoUtmSFh0r0c
B7M6e02yyquTzmOprQSBztA38c+njbpdmAEdosKCDz3fsbLu641kkKMlevVGdJ1Lu2lgV3eC
NTUpQ12DKbw7OIAF2a9D3J+eKlemdz2VGwS/cKweXYHD9hiT58qQsuW/HVoD5wPVEA+eS5C7
etD/o5FBklkbA5zx54KPZwAaDD8aOwv3Y2wDDB/FDp+6ki/hfoHasxlZgUhMfm8YW1jDOu6U
hgE72KL8/emxOkSpkYgV7YilW8IfEveJ3qA+rcDqqXw6gfreFTIAjecfQLVUh35GQLBiTmVV
5KVKiqcCJlOXoDK4HSGPs8V1u3tE0tsjKvkq4nToB9Gs37qKz2g7fVQlNXuvIW8t/9iBXjvw
SLoE9aSbXp2PR7I1sTDsX60RD+NTDm19EL1HQ9bEc9RzOGXUHhlfvTiVy8gArm5laOSB4HA5
S1Fl81Hhd1l1oNaEcy04ZIsHA5WzLrK8jyIMCbvXYs6vTq9pGxNXykHY8H8XA+YXwaXc0XNX
jafE12RyWEYvaMm0y431rvcy+pFj9Q6bs2ysbcjB4JNpTdaxK1AGJGVfQ51FeC1bS4XfrFTQ
3jUPjao7e3rraf+gT7eK38hNNG6e5+0o1/OglzPOlyk6erbeFbMKfYoWKffK1guaLzfqfrb2
qE+asopSdu8tCQsg/5wJ/mmQyM4959TI5NUiKy2ezC0As2b/cTQrrIyZW0L/4p01Z0mPu7QD
q8FfBcBuwdP/Y8hgXI55abDUUgDr9Qi5qk0QWXO+K4S9uu5RS7Zf1Lh6njWSY0udmFi0l2Bt
ZpkgbrHTNr0VwWXXlOeQrGROGny56dYjROZQB3KZvcNbyWhhck+jcBFOE08lUVp1tDSa/OUk
NOlVDwRkUycDamqd6Pr4mwdLqgq+XZOlgGFnjVTeytJrJT4QAp+79QUvJ69c9I7VOhG0bUgQ
iVyS62sPQgM6cEMq4GNSapUQjJqRxIXKGYBD2d1ItrAqWD0D2rie8CTI464AxdmkEo6riata
rhBpQtELG8ncvCP9bWBOAbS5h7OMo/9kmyrb4L+UR/V4FwQgGdzLr97z/ayZ79a+3e+26qkj
0u2NyVPGoYqGqYLGKhrNBOcXL9l3rSRpwFEwLt1M0O0pvChOSw9ZfyKaQ5TR/0nBVek3S19e
lxpGNgDFjhNqhimGhLdtYRCiOwZXmFOyVUH3j/dJ7i61o/LVMjSZBNMCMXb+kOibkKY1YqHA
X8Ec5xWDd/VP/PC3ShdHxdFv9bwMUpbxE+qTtMFE3iYLXEHrfklJ0FmJhafuww98DsIYiEe1
Bcn4IwdMG6VT1U42RZSLnXNbzuEAKILRUwaG3qIBzoE6/KesqtO8839FLSjTcfEVEoKK49x8
QeGYrmC135nErLGoeqvZxjOoCEwSL0WG12sec1Je1740qv8lAAN92GTUnJ7UKKMXT/HtVhyZ
QM9cr6l50A1Li/qzpXrqKOd6IxSGLACK40QdlhBE+mPTi1ZLbML7UFtQMWoxCi7ke+2ll5Mk
x4oPg/BRvgTBhvQXuQK64nn1PWzFCGUmBb5ule/Fkqum+NMJ2+vaDSZXrUxxrifCq+Ji4kbi
P6tvpFq6e7PnoQEiJ1OAnG97YBKi9DngcvQYtAlOPQqqSIV3tMSx3yzkrrc9vU5xbNA4krbC
OX0Be4zhuKLqzyq0yWL15PAoqaUbdwCW+Sw+2mHVfM8Fxli3WYkdzSfSEbFVvjHgudBa/lsD
jggi8HKcvDamzaYCC+A7fc07IzwlNfgGelfhOqi2AdzduUwV0ge33ZzKSmizXMbdcTr+AebM
mDd8WkIJgKtlxgH/GmRPQaU4dmhhUzFBSM8fcLfCl10bmFY2NuqQbonaGrtSC+wzC2DN0TZV
sTTkpNc3el810EgmyjYn9sDFq0GZayK6tl/Hs+QubsuRelv98loAKCiGD5OIDqK3Gt9FU6UH
ORdqjtrj8Z/r34O5kKEkrxnIGltZrMn81RDd+2Zck6DHRzXfHs9x1NgsGoGhYGjhIeYh+8nr
Icp85YtfEIU9j37as1HxXiRI10YRWAwskGlVFOt5M3tFZ9WJIwc806dH6rvKlo0bL3ZpSBhq
lh2ZQQaOPpmcd/Gvx+vWL5MHAKMKRlN8cbeNxrJp19SiMwjz14ELzr1bNJ5ZnCKzfWJwfIr9
2nV8dj1uBZRO07DLDCj8cfS5m0VAHWulvbBx8JG2VyUudP1VHeRJK6nqLS7zpEcFLAkXtejc
oDzeSagQof1YAw52V/hizEiTptFBRqsPxJYEpHJiZh18FztHpFiY04ltjB+WDngHg1rpoQKT
cV8MwawcsxGX+3h6n+sjdBakwI8r7pEe/KpmhSiRmaCYaSsR2gVjn74eI04MBcF5imOlCNKT
ydydYE3R1a99nlRQh8g8/fM+91s8yc2YwWWg9cCo/VxU9PzXUEuIEhYOCSyVSpPmuZowQSl3
NlgYl2xqgi/ay8M3KV2wGIvWbFsYoPVeR+HfiX4viGFdGWpFDQd3pIgUyrxUTmEp1KumS84Q
8jMjbRpKNgwHLdr0kisdjvW4UB8j9u3wvq9R9UOYDplzfNooqNw3gLsTtvpFppxH+1a49543
dfCgkE/pK0Zhk89bw94zYBBaoqGvZYrgJ7uTIz3BNHEEC83Fp2ykd6llUjYdBBivShbvY3XF
bfpPgoR8AruzM3vnSKYzZbF+ytqIH5C8qXQtNOBNTMiVDX5RhBHzbtQJyVSpfoSWb2L1lpnu
cbAvUJFWtMJlclgFfxtL21Pnz/1bQ9OtD8g2lKESCpXmBZg6tnzld5CjBy6eosMaGqdNgEs8
ATVmg1xp5ezP8mJKkNVMO5QMj91Y9BBlOj7Ps6WHssyxfK44enTrre0v1ym/PLIeczxmtfeq
LGBiipqJ9R5wLpMlezhmHQl/5ppkwlLj5P4nW62X3W9sLYXJNf8BawuQxbaaD6LmPY+QZbKG
sIcCGKPnCnaOqmhOyxku6HNg/T9NrRG8zhEiO0+zwxeUdDqsQ2mTqTU84CdcnR25LDxK+L80
mAkTig3OYz3BMMel0LtVJM5oiwypIsdUxPChWMLKA0wU+OMPJzwQwtCMMGUfrTo6dPTq6SUu
loBHrsLCNiQVzTawl/7wPyy34NeyL06cucCcoLc+S2F0cuc3H0rPxcrwL97owEFU3SLxAs3r
pSkVWK+jK8BumiMW1XQ90xKIBuq0h0l/4pkXAw+lJ321WYcxmUPL/TludOnMMGEmhuzMV0Vv
kq8C8FPBKigWpO9mqlhSEAVdQcswqR0Pn3irjid3uioBuRHld2SLSwiuNarkeRPq4nQTvxKB
Jo1J6QTjduJqZy2BkX9eCcjf25CE9xoIqOf0ShHVvUUPYL2P6CDqrIwIUbgA8W4a5Jw/zRIN
JHBvoyrimmiURMFt5Av0QjvKNdjhR882f5BES/lzEyt+WvHvLtxBbj+g9oHV8EvEWhnEi1T6
y1uPtYrGoXFMgsUnZlyx0gBXWxSyM4OPA2x7DuGLM3gO994c+jV8eGqWT6pidvxCD5BzN+LW
bdfj1TJqNYJ33e5MfpJtwlHnPMfjUHnlKFnd4YdGmKbj9b3DKo5lt2wQyj4VJMAfpBAQDF9z
IEcPt7dUVY8TsBegNL2WgccLvNPwYLn18aMmXUDw2Jta89GCHzspqA39pyNANKAwO/KlsBWW
8HiLFz0p2o24YDTaKXB8E1TmLA5zeKBNi07Jiqd7EVRtkEjaQOA2FqiaHHmuOdzutg+p72Q0
l9Ziz9iybBOp2qsZoJFw4ds0MEs5fpybAhKVs793bbYfo+SHsVLvIWWBNN+dGzoJ13+QGLWR
dJj1AP2qDcIVLAZxJRJYPQD63UedAKqBqxjbi1lv0heLwl4B4OKTPGdBkoHOTy3jX1Kqbt+w
MxXhx5qEWvyzTM7Mhh61jTjcqAYGU6IDNIMnW89huGwRk8FIfe8VIk/3dhbj7gXU1obalxUq
+2BS6+r5Tlaxh4NIfctayDoP8tPFvJc6FoYtsGs2r7q3AwwkL08MqFz8EOm56SMH2jxp0Mzj
Np3cZz1xu6j7kIhmuC2hjhGJ0LrE0yH23wcktr/OIEFsjmaHBfja/1fRsSppGHegeipp42nX
pYuLcaNabkS15Dq18c9Z9tP9WKoB+QcGyx57VWWN56866f3a2kMWLpEL6CQ4OnFmvfricn6S
fA4udYvYFgxP5/kvYYhiCQRk9P9a1XPYS8NRtq1V+xCtUh+G039QB01ztd1Ucjyqf7psqnbu
1TH+62Y8HOf0BCZuarOQXKR+vgPDqlVNf2b8TRPGxUl3yQ9fG93kqKID290ckiIHG1I9XJt3
mzxYUz42aJoXEnIsPB/oGt9ZjaXmulPdGcqfAook3YUA+WBCxXie6CtOSlCr9UyPcFPkg3yx
4PM6B7CckwPjJqptBo8NDPRuG7xTgWKoQFlATtsmuUEXU2eF3wjCuUZRIM4Df+4e5v1qomB7
FUFZWuNZVPMom8YXTOVc7Xx6kJJE4rjkK14lAL3qwm1lCXybKwRwq5dZGCgAhv5ufMtpnXnz
WAqL+a4hh/7E2BpsCudHmC14MID3F4kU2rePGOMPFUNJmsxIS9NGulw70CmIpKeXoUOxHApw
ph7veEKwftp3gqRYhdfz1I9wYphMv8psQte9Xvh5uFRC+Gu3fLBj+eAPrgDHmyTTXAt3iRPw
8KxGv9TQLx5rPzwbRpZgiuSB1FM0+NQTRISvkzxPYFVG/tQj1hpbN8lybZAz9u2W6PuiTPk7
7g+LpzP7+ie/CJc3BqeFdyd0AvWejjYmT9bIDboibGiLGYhFH5Sw4TPFL7iZot6Fjt0IOgCI
wzGUk/+HGSWRY4cjc32kPww1e0ng++PE+b3q7l9q1cqXtCwzTmPF9yR3Srdf9bNoBugccFkP
pfK9fvlM10VvuqHXDbkLxUS0odp1JoFiE+ZItF1z8tv6i0jJ6V0dpmB5Qui3fXb1LWmUPbnA
iU4lH/SFvzL+GL9XF7XP28J+YF8J7Ht4kkygC7FKc/eke4yBDE/8KLOCrIkZW2vyRprxThn3
Nmtl0HnN8wEdRIVmXFEoWalXq1fx1iEPC5jw8ukZ82VWkS9WzQ67FrwglnFoIIxcDRJ8jooA
4z7nY5zXLFAZuGUWFkPRigdCoxFH/u/uwWYTI+mbls/B+2A7p3E+DjcRl5c5PjpZf3GBCy42
KcBwMzSdrlIlwdEFeoXvCt21ryfngn5vJHA4tznbUW0WTblxQPUXv/DXxL2qD9s25BNwnpzb
rsWF3sjycztJrzlP1ppmBq5ZvmHt3lr8pD0DTpAYJHpvzuAS2RHlq+GuG3SckiJQz99MneGr
s92Ptl68eUbAwUjmUZ2mOabSWl8ELb/Hdnt4UfdoTBeBaHLw9sXWeIwQk1Ot67tI0NLYU4j4
grhTd4Uz3/DIhw9ncBjhzIwRj0ZcAlXYYklXwa1o3i3V3b0su6fQYcWGr93y82BuSdq9BLnZ
5zaPKMnxsHi3Vau6AcvYVa+6gBqIyLo/9xPk0tvJPMfUCNhYoJh1XMcwAm1m9/DX36c53SoH
z0z7dCzC8STs8UxwI02r69PhoRlVwNT+PKutNI+mEikJX6FoE7a53YyIDy5TrWaYEQR0O1Io
4/cluBmPUbB1eFXJLMFjp0ePDdQe0VNLKhaO2MkM6q8vSobrUv4dyXZdJs1I0xyvRO6weK5M
fa0LemZM/pT0RpH8qxUrA9m2Mikj8x1682/IcIS/pAJ4BEuLGPG/ouC9F2dMYZq8zaKPu1Ny
c+rqxz7F8/KFZu6OKWjnONAGhHaqNrG8uG2lLoDEa4A6mMHDinnOZLuYJBK0eXq/NRczJ9yB
B9LxNgLcf45gZLOdMsoLBCw3/Uu39fJJp14I/k2lL9ERXmkc5WB2CyAqTkN606av8YHK2iZ9
FUjfNUyAifPKd0cuPU+T2iLEXXbc0ib98fMIOziv3hacdAKEDjg+wJ3U/6Uck8VDv6yMUjkz
bZ0ORWJd+WOn59aNxBwnQXRO7uXG20VmbkW6e0GavBi7CmzAKyIGikaLX8cFZxe7W8Rd8nEX
r68qOpDVI2r5N8FiAvL2sbkBSjCtDUDEsNI6KVHH1L1chwO8QsM9NrEA8gan+GLNJH/gSRwC
Zx2td8XrcDIAbdrn7VgWwY4O2DaK6wv06+lwcPauiJzZdxtoDD1IOk0piEUla5TgX4yH8KiZ
q7zmKB/ftXA7e33Ds0QdqN8jnYpmpZHAIhwzHL6ZwWlUKUuUafvZGztcCWJFJ0uC9kr9id32
tAHLZaJcVIwqT4rbyPx/poif6k5qnOc9KjS+LIGOYFZPuzrn6/A/4uE90tvIh9F+ZvI1rCwG
kIA85rXSSBo/t0Gh+scnlqC7rrDqGOPrUyLMgZaRrDLbwVTb27S8MOiybvR1RqQ683RIUvEn
yKeURfmWjbZwD09zQhbuH4Y4XBy2VgYoots+TDXT4SflzkxVSfVa8rjM/NHrbJBsFQ4Imw2m
WD8L5/Hr/vGOKs2mmz1R7ScCT4V1IIp3sibDrN8b+UQHMs8RtR/NxLQPILTTP+ahSnowy1pF
AyvXr55pXYEKOcIoJg6RU/Cn9o//vzQfy40DfeDL1Eaih7dRtSvhFnWU2Txp1Y7K8xz296xx
4a3tHbOacADFzoDpFcdKsVA6jROBz+DlBa2UOesZ5N9W4RDhiOO6ygu0ul5y3X2lRWeQWohV
89W7p6HtE3+PLzdQ8wDk8EUEe/lfyLYDSAhB6ignp6fKj+NUJWDZSeHW4kTeOkXAO2hFdbE9
peS9rjSBjmhLoGrTKUvc824anMYuIT72LZzG8OUO9DOka5fP5Lj/WddrceO10LDp+BBymTSC
cMkXNtGqPtn52lzuS6I9JPvEX7EkHbQi9tDGkPLgpAdt/fBfbrOVGMwM/Bse+Q1cwC3a8ypN
D7YdJ0yu+WWsd3kvgqe1Q4kqKowHTSe/MJC+6GLUeZOZgveRy9gZSOn8dP6pAbXpuRBo8pgh
Ro4OZxnB49PuuvHKQ9Ppw7z3vi9j9Y0DIURSM5HVH1GWdzsTM5j/2ZloJdkaSD4JWc4Pj1B1
CCRcG62C3Pr88QcSxYKHjE/PUQHd2cRsB7DBvt6GS8bYN5fU5KInZZqkR7sQEzDNMuay+kcn
UUsGcVRJNYlup1F4eKB4x9n0uxvhLBAO/fOHU6XX1/xAiSQ6oDlHsYmt9eY4Xc3UhjBx/5L0
wP6cNnjKSprceJJXH9LrmDz5M8LXnsFmF43xGVhdu30JaBjK9v7X9PFrTt0SxWZztjDCCzux
fErv7iDdC02j219UDl33pJM4bU1qbDeVqHGz5Ot9kj/KQapAT1GEIhcnozTJsm7Yx/QkM3eq
a2qLm7dDk/4sy1zV1VKrRyN8Q7rBbj+LQbqDocAACTxTIUNxTNn6ju/sSLzKOFW4uvnvcjFp
wENxOG7oNSUMxmljXdmeIwQ/ssYLZ1aCe7CnVcMBvEF7+C6Op3hf+190ewVRoxOyRsSXU2tD
Y/TO0x9/bxuZtYZ4dTDiU00/mRc7dg1DufVjhHeY3GVgEh+FVV3LJUC4MnXax/ygXUX7Csal
3aUvJGhrPfRdpnvOp6RZ6b5mxtDEfaeKk+lUNYPmEaGKx0nbu5rGiO8RpkHLFMOVio+gruzo
PKS17NxfrzXHo0R1objvCt/nn8+w5nkUmyBY8tapBLKKl2EwyVcBwe058uCAD6jMFPygEHZ1
QTXw/LYtYn/Es9OlhGH8pxpon7lZZ3+ePfK9P0vs1t0ixBpe7pF0x73sVeYMIyZ3a+KnCE0P
KA0HcdzlTjaxr6Kf8myyvE9DYHAFtzWdzac+zgX5amhtqja/Em43M6D3SVj7OWcxyImZ8GcH
ww6FJqd9nMfgNAYnBsEsCy6qY36OHgs0gzbYeGtmBU1x9uxmWnKXxuNXwc9xMCWGwLTglaJn
qfNQKAarTJbdj9NuSBmXYDRnkW3qF+Xv5uQ/w7E2JqeWjauvanIYh/gTvcOnL5ei76L0QE1i
qWLwD16ZPW4vQxinmguSVEuQMHz0saWwRpYn8taup1u8e16Y2IOeKY/ISE6C9ZiS0CrpCnCY
Ee9JQLWGiZJdJ1ZNwkwJu3jlAKSr6tnSH/5BWmxEyDYypdpIDH8IkuZxBUCLSf80Z1DR5iAP
jVWhUUAfDLDfq1EOPdcUYom+j21f4OJKpPNesN17bnR9uWdiKJJNrkxHVTxzonWYyp/RmpRU
ZjhOl8qm2zwNNecL1os7fHuPSEAmxi/cK+3GgRa+2oGxKdM727Im2Zvj/g/HjOIwp7vDfd7V
2wiDPsc9HtF1ylCZLl3TXmU7cX2PaxNp0dkWlhns3DrkmvUmQ9/+G5BIZ9eXZH1itFG4u9yO
qKjAk5ZsXsBPwVI/fNv2RmjK+xhr8kheGMMJO5rSQHFMDf7OBOP1zyjnV2DVIr7BC/aq5px6
Jvf8D0MHgBBylf02WV+Mi4Ps+tyzGYxSYq3t8rvmSmhUAtbbgzuh+aFd+HAa6d8g5T7Z++2f
yYs6aFFWwlp3QuQvtkKXNzWJl+ugzljOvOzWCY8owrd6M05iyoW5RJQZ6qzCbdosafvvAaqO
TCjdtGXf8SV8R8JcGblPxG1t2je7d3XZcDTkB4HWmNADwEwMlnNqkVkCvRz6dDshTcR07Agv
V1cxf+wDHJ/4TslCeKPr1/tq1S3we2fHxZiIDOiP7nWa/XAl2FbeUisjC0Qqz9LhQxkzWlbR
OP0xSOCGICCvTxo7L9QRtNYpFiOm1/Wu1cve7oGq447Npv4Bpbk3qJcSmB+fwUeqfRE47PMJ
jXVPP246CCO5/LsMSQWkDnRHzYE101dJWtsO14jddkl2lQ0+RfViPQCmTDe2xCYDhFSKUjzk
aaHnCZ8G5UJODA+fBoB5hwQnTPI5bqJVPuuT2hhefZOZrRTf3gJu+VDy8h4KtoNdKW7/kWO7
De975iT/XLG3FeWiOC+9MlniiD7U5EFbrF8hQEAA7vdP6OFHmCY8/TYo8He184yUgH6z30wV
Ssa/h6ISFUdDsvRL46GoTk3HuJFio7KuN5xn5BQpxgyPzRSmraa3zUKkZL41drQd6gtfVMVI
DhvkNjZAtRQ2wNZ5CewP7P7QvKOQ7cLS9J2v9H8YjcPqGxCuZNm48exjnbnYR5PNr3M9t88w
Guxio74Owz7TJSi9aV7TRsGaFR+WyzGj7dF632AnEndCw0u0AeKBH4y428W+emcaxRfv+HG0
EqrHV5z8p8rr12p5r2kjiR+lStgvQy1e3pPnCRqT73ct8+HD7UJ1ZQa8xvZmf6+BegruZ8+j
oDfbz9q91EE+OO285dnUfPDlBRq9mJPhnvqna4r9jRnZvxnRozQIlGy6HBaneeWEl527Qlz6
rVGGlRsUnHdf5CgVO5A54QPsnoLRjH9WpmBkzINX1OY7sRpnjW/0sSOUlL78kZLLmPcZEOo0
s1hCO5L5nPHePY/Hu7QzEBcbsO9botGGiZzSZJ7cUTR6VAEDs/fCiqEESHH/gQcd9iEcIt2j
cCHdRwn6VTZcpuT2ufHHcgMe8yocoAv1PGv3/DvM2aqW0rNWkS8I+UcaqTfTbFlR/Zka6HDh
kfldTeClCNXsgXVGS7vNvPfE5cNX5WWBwazMGKkkMeIEmx2bCs5Oo6dYw87EDD0v7rRG+SK5
F+AeZccXSwn6cksT9vncVwP6p8G5y1d/k8Y18gJ/KP0a08s6vJ5BmH3GxOKCjPdTGLjwGYP0
P9hm4oB+yoEFYhk3ozgpUOJbVjB68IiTPWXpY2OmHzHuJp7lSVETQqPZWXf1181BAV7BFz4D
K+PZzXYYJYvFd/rtc/VIxLFxNd4BAwNIagsAvXzBxVpSZFBvXUG1H/ncO7xbgb3C/RZ+8wwf
1/VMll9EHfEjGHxwLOcP3snHvInocpxWqrYH7pQo72wQeL7LtVlpHufIHlIbuRpKxIZ0/3sN
d4rrqjYd+fkZtkC1zlSkYzo530GUUwoaGaLhO2CQB387bxrgBGb2o04ParKM0CF2IM0/F4vP
JaZcQtUTtnZw8ps/4z6cwYNwwqUX4kggdESLHiyge0MXUt2O8wSz1JrcwVpHqhzoxt24U20V
pk2FVmy2eK1gk1Z0K+dcyfmVi3ik4XzKxtRi9bjQ7/rkCHiTnkc6khq+KyiQDJ9Vt2iAqCc9
Qu7Yeteuq1waTtMW9CZmiNEBMMaBQ2mzknJGXwf9bV4miH3ELkY+LvBymiXFjoL0dmey5bI6
1fStf4EOQpnXIQeshIKs47tnTnA7AvdAPcPaaaHruAE8ZFxi4k0EYVruPgRCk94aPvfMfHCr
RkajiekCyhZh0m78FT2xTjIFLdevZ1lN3cGQd+7EiuImjFA+wrVWWE5dIsjD/S/Ks1Xunjb4
2LEXqKZPLR99J2GaPF5KnH63nlNCNs00TdWXnjfDaU97H/UyIcaJvMC2jYPvsMRouYBHgrkF
FseBJtSZl1yRC+mBOexHyiRlNJlph2WXX9H6HiMPxpvmstHHovxx/a7sUAs/mPzo1OwPQ0M6
tQzVMrbbJMrI3ooFovWufAQRoX6fNWuIHfU9z8KELXiaz7NV+kSD7XdsYMzqzVTY6OSVDDrB
GqfBifKyO5VJAdDtEfjbM003zBf1VNXF/8+xDH0vhf+lZoxJAaVU9ea2JfSFM9wm0ZVtoE57
CB87mw2IBjBrmYmqIm+r9kjJHPGuycEg/IxTVTPF67ZI/+FX2jcNbFtOd7ROnGbVOoXS/1Ww
YcNhBYvtzBoAzsx673LcLFbLOGjQFak00L1eq1kDEAB9U+fBhJLEANBeGC4MAGeRgsMHX/0/
JO/2DBgy1sfJPVpdfabLMOIGmLv0Ht4XgVfGqZm0G8zOKtzM6H69SKHkf2z+ZIRlLyN27Dbw
f3nyUt/axnYw/AVsnEKBHPoDG+6SBqR6fqZXGgX4vMZBil1VcYTi9GGrglr/9Ie21QRpe+3C
vveMKwx79tc3IxPAJRdIfu4igbmXoNJGiS5oaMGycAlAgLIAA/Nh/Xf5HllrJn6fxa98hUv0
WFrtqaXG/2ak0m4suqdvee4o6oztLdHzhQBr15UxDTaE4K42jS5E7TWrGTh+SgjUfALC0mUJ
Mtv7Vb4UQ/Y1lyd8NYcZUijWKThnAHyctz3cGUdyyeyT8GEVX6PImSG8NHyiURj9LqfR8NgZ
UxTrQL65tzmNNLsjU1iA5ovDjFZa+aVg17Pr6WNyGtLUExTgwAjfb3kvYaETT08cQ0f31Otj
HMRZHITF5YmsuAlsQC7EEl/VoCbiOhHwx5wN3DxoQaSbZ9bdOnAXL9gV4FMttgw+IFwrXtLc
g6KyxtrmYqVqPOictj3HMN8j2gy50+cVE7oSmYEK51LA1ZRwddqFYzuCcvs7Af3XRnlI2QMu
ul9LSmcXa3DxLk5/t2NS2SBij8Zc6JdnRmVddr+ZQr7m/9R3xLv4Te9aV5r634V7V0LSOg6q
KzGJZF2U/Mypt/rhIsKxGQLLlSRWrDkssa+4JNtyVJcqt5MmHtM1JANGN+yh8aYeRTdTyXOO
DQEB/m6NpzwCmq/6zWKHzKcPA1ykIf+ntJLuEXVCBg5mivNj/+t5rsfFiOepaXlcOKYip7TK
0RZ94Yf/NzhDmnuOUmC0JE/4q0kZCqJnP8tTeHS6ucSonMbuF17OVkbpMXiPP7Br7ollPkAA
mb/1KZFvVVBdtwNi4qg6IfnomSTRkctV1pc7Qd1eMG/enkRE8auLLslI3GF0132r9WOt+EPV
KYPKgMFkr6XeW4MYW8BtMIh+g2w93pRYvnBnJwmebFBP44iMVgMxDtso9GZ3qkbnpf858+Om
h1HsZ7wrsogxvE48ta+dH8oC2A8uPWKdHQU1GutsPTo/R7+Bb52q6gVMdFvlDZbWIXD+P/Jr
59jtjvuEI4DT67ztt9B3ljQKYmvFXNHv7YUv6iwKb8ub8jWCJoX/NBycTV0FqvWZP9oD7t2m
hzzGmPKNiUfTPmuSeNqK348yzVQ4LfRLrMPbOaBSlVaZ8cAm4eLO5CXRaV0k4e1YPy+7X3ZN
OYOsg4tkHbkmhkW4ump01zrkdNuh4jfy/lsnglccw+N8qHhw6jCQnnSKniNj4qEqp9OuMAGi
XSh6LPrVO2MZnPx670G+y23Fr9LxjDg3DedTi4YVXwsRJ7yVvuOoUeR4auglzY6zpVx+tDCX
w79p/a4yXhIyGMstfJF5gk52u21u4UeMzKTi6onQPmKt0VZdeln6cou53MkjEidLXrPn7N9r
Dlgl3c6zGDkIBc2mWuOcUJwYlDo0II12CQFYkqFVSp9WWtRZVyjrpeDD4dBev+ml+X3FC28X
HgdnkzgClLmFpTy8Ry63L1Fc1fEygPcS4mUc8+qO19WfdX71tJ+tJI17qaobUHxrxNGiEEkO
ju1FxUA8xLsOeqvbN+hzDS0GLUc4iOSslccIDtcpxUFERXJFZA/pJJhtrbfAMC6u6n1EMGrJ
qRV8C/pZeXhrROQlvDtP4l0sa33PYDaIsB79auhW7pSRQUp5dh04K4+jBR1WDAO8vKQllZVz
uWQJfHUMSuCxONt6GpIvZ/B6n8tH75Dnq09hSi8Wupc8B0DpX5RO19Z2GsoH13yIBsJazSNF
FGLiqo1jYPg0zPNJNxQdKAr1LtrOuUmtlvcAeHMcDbuwtmGhM8pKKIACquO9pq8IWgUy5q23
K9hMiUYljXOq5oAhMzNcx+WeCvoH0QFfTrSX2K2mlB1UHYrG/L5DeSxMn0SQEmXCb/tF+hBz
DCFeH8Z47vFulG7LTY983IrrmKoKpox7jkCop5iRQCmbDqsDElzLuyzKY6Oh3I1hSZ64V8x2
z28Vw7iajioyHFAhuXlSkbKRydBgD6mvlsrryMz17mbjVjW0fxO/ZLFfvIDjU08cstQiKkDt
l+Vz1ztTeE5JTcZvaRCcdKK99iH33Hs6hqPTs2OJkU4BZxd4uadGQGk1pVlPD3OFPFxXdr5e
4VnQGknAAPRDRnyX0df/Q3zrEBt3Px0A+3+MBRy3r3E7kIPdIoF4M9+YNj5uaRFFJN+Mxw1s
hAPgUkC/kYJHOlpED40ZgxbBR+jnj/aAvI7nDlSMtMeKtfj+4gKNPuiDy/7XUo6vbUmExnby
Ub0cdKVVdk/el+SMF3B8Ke3Er8jyuvkD57QF/JqTkRjXuXmv9lQ5V5nAXiQooDiGGxoaK2B1
dRbNtTsyRLH25grpWle6AMaAxbhvXfSUNYyeQXYTi10t8tUwFYXekF20KBfylx9syZq7q6tQ
CWbh2DlZvuiglRJy70ihTr5U8O7hIH+wMinBHqNyCrYQ1iesc2e2VnKpkF4TYsvOm3G3nlrT
CZjooIl1sbk/AL2mjH5SHqUjdS13QcKoQo7hqonbbpTqEhV3kzfl1WzIQ5j9ea3xUvNMHN1M
l0VTeMH9JvZ2eSz/n+JOWdOjyjMGXgqo5l2GhIYLyDzAO+zRc3kkfjMd9tGnRjmGVsHMukZR
C5jdP4/cGn2ewCO2H2Xh95PEnfA/8Og9QBwiSGeyhV38snQFfdAUbZxpErBOpaBLKl+v8aFk
6B7R8PpjSKi3pkWZs5jH8je5hT9MSjpIZtZQS6V0b85uJm5CCKM28ZaKHbhD8ni/c5kiw9Rv
yiUaVYwSjR7eDpZT8AlgCC2khg4HwviWymBqmyukNleJiHLqCii2y4Lo8ZJRGgKlbs9RTnZq
e6bVVt2zxRsBoaqQi50qGWO6UEyQuXBGL2Yoeyc3sqD3A2ozbbqJN3icBXY2gUnhD8NgX8+Y
mKbodg2jc38/OBOq/pBDQnd/343chuO7tMs6BQKvFFyyA8pR9LlTkAd880tuBCyv+U2A1PqD
EHhlkjzgOCsNZA+mKSAhMK88K7qj/ajvuIsTmanMQSswdG+B3QlRpZBs7KvoCKcl7n1dSFN8
GS8UX6LeTVXGW0W0MzGD+g96jY86H+Uw8D4RnOjc05jAQI59ftnUEBslcB2PP1eh+K+ma7yI
kQu5qQm0R4NWZYA4D3sgjEnC+5uY+0aAYQIJ4ISLJQ8/nyZThRBMMcAdb3TCmjuX821Y6IYM
gPkTx0ian8i2TdPRdFJQH110zaC3zTdX9Q9irbsT06zXyXTftbM9jxfL3yJrvjySvMuBCvnL
1sTRkAzus+JgcBTPR6lf68WWcFzBtQjz5avwMVod17nXkATU/cZMbLatlw7uw4QQZFr/KHyf
LZ9okOEcocg/z22JpAtbhwZV/fyHbbdALe27NVcQffujkJ39HkOy+MQdiXQbek7J71twGxVm
sIwBgvnMJ42gxhHHPEGHgo2zq6gXaRfUB7ty159enx9eQakj0JKQhzC9YNj/9f6qjywNp8AA
25BRdp2mnSYt389d4u8k0aZ0PCbFyLbwbWf2FdMIXuKTurDvsYaN7HWlj/aAPx+zpJGypIgW
aR4liy28tyqL5rlNFV0Rhle0vCRPLg1cHbj21sosyQ5Gro+bx8WMbW4XAk7IXcrPRmHG8Uds
sFHconvZY+fkHQsIKl8vZnqTkxciUzmfFDrGIBQwCktoF6KzrG0I4HYSHj6wL1D3hSK4Bntb
UwVUNDenJQVqRD64N0lnJlRRqFy26oyhhGtjoOfoM0x151GpwOrTpgAKpkbW+pgM36WNz9p5
Y2rHFWM/IWhZkUE2dqwx5cLfHYkYrsM91YnwE1w8Ptl719rHUQeNarfrMGD5JitPnvXegYPa
Ugey2T7VEcwI93EcLT2/aqrWZrgvvkli663u8ghy8upWOfoUWHxOHIFLSCVCtRpSb9AdAnOe
meYP/5/7p0/27+TsB9jM7BDyi4K/y+kS9ZdRCAdIFGfBlIfznQ2glv9fouaS05bY04iGufsP
83kygYPrFhEHjzHd9bSrDyA7tRHbvYTfF+XKuCevEFeD+uqKAh0v5bK63/dZMQY7KjAWQ+6Z
ohArJce9Uxqj0nL8eUBQFjGHlXxMbbgtL1/JJfQHc1G3Vpo7RzQM8OQPsTPKq5VnedHH96/9
5v6cYLmm+7fynVKKef3a0NVlAvviXLQHtXdpqkPQpS7/do2xnezkKt+pskA4KfXGimXwkgJc
VeD3q1DgAt5OFJMjFzt+7+A80VuqVA9q8im/YyIEz+W8RRYB/GCeTrLxq4KjO0qrqeJKcsrF
2QMB3Of/n6rA6ZjAVLOwId9JII60+MpXByNQMpjnezJpn5EaiiVAM/AKBLcbFao8TGumMTQo
KXpskigupj8M8m3rGCd19XGINjmOG3icGmWe1H1bRyc0TE39TNZf6BwLI/8EDPgN0BN82o/m
wYRwAHvc6s1DW1olGyvc8fyjKXwTQKzfUxNBM0CAPoKb3aqF+R5Il6Nw8kjLPoWQUHD/73YH
RmNzW7EEdVQ6fGawFopaumTEUBzl3uWSe5Pg5oUqWcbZusyDC0k6YIGNZdzYFVlkhTMF8bfj
ojqQdVaDpsbtq5YTSoqO5tLRULTzhlSd+hRs7JqLBDauPYLgdcAtFCw6XwgV/IvaR9e/nRvU
FlhQoVOJG/rpw7SN48KUhSwbtp+NqCjAG4V8Qfbz1N0Z/zB2QYsnQvrR1y14Z2eZvRNFNKYE
3w5RpwYHFPJKtr5XLOg9LDlzVGiTHSLOMRMQTXB7Vg3xQ0WyQ/b24ddrxfPmh+my4261+Rxf
EGG22UDFh28IAhlkyTki5WbqF5ES0SXQ38r9RDzEYM1iCdT0T1OkfrBztr6EB/rAxGpQdDG8
ZZRsRIWybKEOaDvSw2cPBUWB01ZmtjfVE/rSW0DVN9bj2UQ94oUdXpMlQ1M2XBXtRPv+FLs8
3bvK4VKoNnyZZPVydAVXjKkoNvIIVjpG7OeY+SHr+gIAD3W2D6aIq8vP0is3YW3e32/sXrap
c/U9sKd6MIuX+VYVsFrURHbaztI0CY1GuSDXtfpzOGpmzgnbxGlOCXTryYqBnVHZhDYwnQV4
BrQyZ1CcR++bqOzCudPJ5ovo0BaOCMMMH6adSANhVUb+bxVrLMOKw3pceCLLG6cswppPSLlQ
L04s3kGkIKUacKRpCRVcSZzz+Zf4ynfCoFEFwSG7L2ej+0efoIgqQC40v0CwH6eZnW6z9Xkt
V2t4olnaDR6NRsQPgb4CZDn1Exxg3iWy12CQjSsOOou/XThcwTvttKINTxCGcbdYKzpuP8Ub
FwPz34SKfgHNwwu7bhkxkFfizJCe9TYJdobUu+I2ehCETBQqqyRmqwccjSf5xe43ptz3ddQz
CaqKiv1XbcH9CuL4mYT2AkkCfp2Zq8jsg4HSp2AdL8nAUMkAfFQ6srujv1JA2VwJMCyhIVOu
Kib2a5/cIupNtj0PAO/yyZQebro88G5teL7rq77HxiIGv5FSubmxgfFMZNO66bl+5w/5/jbF
3koyykGWL7Wt1HnoQ7kpW2H8z/lIx2+PHvqfMIPBm7yQZd0E1066OMpdBEMxrMO61Qe7YSak
94tZKgkI9t+nTfa3/Ak5YtVIVUtwHP8s70EFQXRkD7SUH7exHJUms1f8DLNWLaBFRHq1XORo
IAAvCWbqyZk6efYmoh9rm5Id/pXqQuw356yp0CfuL80FTcmdZglKV+ZoeHDjj/GsM6hA4Hej
n1vmFw/KQ309gdoaFUgDZAk/bEvOlPfOcZLOL+HlNr7xbCJnM2FJp+fPNsM4vbakGCS752Se
BQg41iMnyrKBQ6c2WYQpEueEy2TP+30JsRCberLDZzp/f2zhd+c1KK9eOmFyNYMV9/c5YG1M
q/e9mgogxJdD270zNgWBZ8NiREDhnTXfiOeEuTnEBzEPRKF14ylTql2Lv5N1UiCvDJ+XWeap
gY4Irl1SMcxZgpNj3a5zNdtl9FR/bZkZLaFSJT5lpJ3juwgKU9lpf6SSA/tArdwDlfZtlsKk
izLpKwH21LwjHX5PN+IOkrnrych16FO9fkg/UREMpTXAsOd1GAskFv6VGvQFirtp3qhdeU7h
Kfc1PYswYR8UYK9yUo0CjcQaWsbRrCUIxBEhYgsB9YVWKzPh9Vb0ZS8xSkr/V10g/QLRsRfo
GMKJH924EEY4quOFq7It+CNJAsOU2tjc+nQ9hY9QxpKazxZlxnC8wtxCddu8VNAfd24+5xDR
9pKnh3tA98f11ocCMPJwe40maY/KYYLogTqpgFSFeeAMjh0VV/IaqeirhtB8XHE/C4DYl8Wz
2EnNV9+bdgnh80sixBKucldV/CrjHM7/At3PVMPqGimG6WediWzi4QV1Z5ScSTtcXKz24TgB
WhssAUKu7+foiK7CamkZRsaYb62YV5cGV1JwbiW5IZ3VFqsnaDQpVbHPDGvrY1Yx7ZpyrNsM
mpDrbI69b3A23QQ4X1dVAqJ+nRmmUy4ZptwNsH/cgB2FfGCrJ5SO1qfuWoyjAOOS/zTA5FOY
7qk6zThtTYot3E8pXu4dL1TauKnuxEW0ZNVoSSjHSMqrjo0lQfajY4MqokkRYVkcPx//jdSi
OkBU4enBxeInYfmfyfQOZKAjT5S/9OzZSwp9nNHGWdFtidhXZ1lFwZKARnJeNciM3NMIYSxN
vtR0tIBHxTlXie+hNa+dXeXZ/7j1rfP09z5Easesp/TC4fGwmhNWkIKO58VIYuaHM8cun66I
Ptq7K/0+JTvXGS/jhx7tkyZhks1mHKBfUiqL//bTO12Ss0N1nSpAYLhvbRMvyNZ6PckpEtuj
E7YqWu/Ek5WgV7b3TRi2Zz7Sy6hCKBfWFA+IHS58mjSzuUvXCu1vj7HaNAeo4Mty5ntwPXw5
1+EYDwIKYmkl4o+9DhZOK6lK/Q1C2tE/M20lNmMhOwyNQSiqabOpOcdoq9EkFG+y4t9i1+i4
QRcfmEPJqhS3PqIHtXtqR4//xNPOi2/Zz5vpeZiuQMiZ2yAj/Hd6XAhp8XDYiTZv0UXq2oDE
xMqEeYD0ikmKuvabbknQ0CRp5l+PJ8UR5XqXYDyzrP27ZO3/mzl3iytfO1/SYwub3XaOuBiX
ZoYKIMj6APq+5t9u++UQ24czvDnA32ZK8uwYGjS7c92tGzjv2qLcG4M7CIdF1EpULUBT9U20
Pkb2hy8msf7xnaXZXWxiJUyE2nIYWpoCVg1PZhTus7KOWEUM05Jfh3jddyWQgk6CmrsKlqqP
G1VeXYZwCBuB2q+K1yCf9XVRtWRUA00NgFUe8yC0u9eJLA/n026a5eDoTsl37G3HelU8py3/
uCkxvD2098EsnLWkBBGEAsY0+XVgR4O+0GZHSiZSPM9LaNiYYPz3MtraNTRKBfPz2GwS9dWE
gnrQNVtSlc6MsI4VMT5XvkYmuvxZPuJqBvdJA9wvr2M4c17dfVz3kP4mE9dIXOtbngnTJzkB
yIGrm825pm8sOXVT+fyEW6rKtVF+a8Egu6nm2+ZQmsd91nULeVlAw2bw8AKL8+/uuc/nPaiB
w/kjnUWDl2OXlW2vNDYFkDJ9wCwC4y2ZlKOr6rbpXi+9gdrHxc8HWppyRflzGN8gP91iJvPY
RZp8UPv3e6fDEaMXHqRt8PfLny84ckPPWZBoNpgis0vmCeAlsoRvuS6crFn6XL3LqfEG2+Z2
w4rojY94qY5704VAs8Gm97IK8HjhMYA/ITyqpjb8lPsMujQ2mXHxsIWNc1qAur1XHSSdLg2q
A4qYs7dJhL+A2LGKg9JVc076SzFBA4XRQ1aX0RD/TGw+MYlSQ6y1obljCYn53Hetx/q4jFXP
9wTo0xKruDIZkqXG49OQoo0z4JhA2LkmGfQfDptk6cEYXFCO07a3UoIsxGykDvcoR9mYTVSW
ZeCZ5zOUfF0/zvaKgt9Cq0Sr0oz/oEKLZqKcuJ9+cqNfoACaTmZs0olMIL2W2ZRT5AAr0cIb
TA0wssVks2H/uUMeu24dUIoPB5WWpfmSTSydLLflrhoc0P0mfLMJi0mPLuj8WUhGnZd8Nbv8
8uPfkM4LU3caDtEH6DZUXLfiZVdsdoWeO08jkv6R4Y3YGgB4GOYBtJq0pkMb+7POg/R+uWXD
6gvMHhazpj6BLrrHeIK1takwrFeFE9lRkEEEyKF1igt9ArIGmYV2YxQP9J6SCJ6jhInzHoxA
hOLRT5/ECja9Ny4DbVOljQbwKRjJleIGHj8lLZLpnWT4dRwHzKRpfRlshSJq/1BtD/3wIBoc
0C91CdoHSb8Ng03Ww76TrxGdjBfaCdTLp+IuVQkl133OHb0B/SgJw2c++piaTrtRdP6eeqrq
nbbgYl3v373hqWJuqC4Ch4wP0ExRW5TnhHniV7uAsYnRV5ojYqIH63DRMs77iLwccLJqEtYK
W2eQtYP6LtGkH8KLkz5XjNM4/R/iZQdybmjHqWuhJfW7J38ElULlIFJMtEGe/coJ389jqtfM
sL+rMHxMshyNgnx5DnHGzWU9Bg1VpJxz+r1CkQH5JTSF+tK8HarTG6s4nbazLn8aKLy9GGN7
GCMJ0Oa7lQTNJWztgYBmyyZLwIF/VIks3D7kQAJ8rSlV920whBZim+b8F/NNiE/EkgSAYraU
ETMuUm8qe43I1wj1sPENgTdtGY6ulXyMJwERyvehulZGshjCRIP01CJXPXcuqYJEAMWvYjD8
OnFgdvXazaNO2xZhdgXxhx/Rfb2UYAuxm4aD/W9lrU02vaR7Hjwc+SJ3J8wA1TghoGbTQyRG
iySEWoskZqQoUHhn4C8LL7dfDgzGvEiGJykVOex+giyXeSIXMfXRJ3msAn4JiBl7/Pc80T7o
r9qVZNqNAT4TDlAHPmGNEZF39Imn5KCNOU4z3WSzeUvgvw6vZlud789Civmdn4EHcM5vyvmi
NnSlKjpN2AlQOGWHEjhkXRfVYtWDgNSpDBbNVCoTc+sRGtSpmEEBUcryxW3knAu0lvZILdCf
X6fiy/kChQYcrlFGmMS+UyCFBlEC3MbWQfK8InUtdBjvJ+CibnDZpQpVosQcxiTPSEI+CFQo
HaIzXFS39aq+a4kzSKV6vfNUjS0gQRYbf24rMSkylOmySW40MR7qhpQ3nhfHSG20Z3zv05pW
6ahh0+BufBRk09luie+6t3e916WnHCGW9eXYEtzk5pGc7DP2SlxIM4BHOfMWFgXW5a8kkmxr
0/adKSM97NMxHNjqdxhFKTR1DQdkTIfWAoxLZJ1K21KxYoq5OvHEeA0+ugUL7JZzBU9KMdZT
sPRTodBN/0rVxEg2Yyla1YRn8paMq2hFec0DEvqHPlWIR5kc1yiZFF0B+owbF5mq8qH5+sYd
1IWAAcRMUEloRGaiQl5GN5VY5ZWhFwdPVhglHB4w2k6DL85insmOCiWgBlriWCq7Z5jBseY6
Jgx3Zf4BJhh2Asq1lR0bfBnRo/Er8/POhe21Ddau6D2gB4iHg84OEuegW8bWKg6loOA9hoaK
lQCxx3weAY8I+9gSQNFzrLLoX8RipvL+qbo15QbyQ97aT7rFcK1ASj/UGAaHTZ3I2Leel+eL
f997LloJVWQTNA1qwxLyGqB/z3tTM6YhtG7WZ7XqKoAaPVtTrZhesx6HFogCcMZgFTuXSoCU
1Hj5O/wiMRIIW/afSlS46JC/9LBsBMFVLQGMXkH3N3cJwgecct4BW0nkTXnh4qDPTTd7WiAV
1ZGhtaXTZzuVlC+8rnG8CBLJcxFJtcbQUxNnQvaSU/rzdWbYyhbfGwVB6zp/TTK8fe6QtNLL
hmuatdYlONChPanjP9Tu/S00h+BfVQgMDTPvhKmmQvPsez9BK0wwc5uCp7YuYpgn68Ck8ptp
TQTlBqgFagZWMt5XdIpGDbDZpmmBBP8kqwBtYa26V2zDN6y80ANvYN8EjDOYfhnBG0tClH0p
9lr7s/L8Q1L3spTFaJCB9ZDzd4Xjcs9pn8vODpXND0TGmvZwMpBZ5PeouvJkh1igocUlxKjf
VeyJCHy96NLhbND1wl0c/YmqPxs3ppLWNq03albROL7DiQFVqlVKN447W5VC850Mox4w6HiZ
axnVYjqlIR+lJd/4oi6efiVdgFWWPR5bekK5GP1q5Q6ptdJKH/Mr/1JR+iA55sXqYmGy569r
U+K4ZunC7lbRtZHfObCWeXwDDeqCb0/AyDES/aq6Nptuj6ttey063oxtiliu2pX+aF9atQxP
T9G/JpNydFiltvNZb01kpU+H6qghiIe4VvfbuGmox82fi4MmArCjDAmYGpcSgRMnoorsXCWa
9+72zp7bogikldeLwZm+/iXyPhCv5cBhc7q/8cWjxDVr0tH99ClFEdde1urv+o9BnitpBWmU
NCBBuXwCI9e+9rh97vtnWV6rdTwD+6OBLrNJl4vj/IiarQUs9QNqy2jKRGfCOfd0Nbbhnn0m
NKQoJc5i+HlYO0DcBgoX9M0PNPfAn5pkMNWYAqHmF49oAu9mm6N08g39zFVYOMtLjxdUP1Xo
iSrdNJ5OJBqnmW5+lRvUx/XbuLVQIz+btmD6kkweTUgdEYM2ZMFP72bPaIkIyZg7yG2GJp5W
26rKlBUC8+764ueqsAvVLqk5rnbhlTfSfizPZ/Wr/w7gIEUn9HJ/pxH0Ff+e9ZcOflVnNeVJ
vBqosqbHpC5UTyINZH5jcBFfK7tx9SFJyfl2F5I7O9e6NRbycuuZ61A7Pj//FcVhH+25Tbv0
XJt9CLSCgHEuKm0i5p2i09OhLVBGdWQIAi15etf0iLfqEKW6Mn51wGG9k8fLW1tVYGMlOPXM
q3QPhDt+UiQq28/NSk7xbeQMCCmsBV/wiEpjGNirfbvcA6JtJVG2+LSdxFOogb2y6mOH9ztM
aqIEjynoJnQH/KzRgtjoJnveecjlVEj/GFA6ixkY+oyC/hnb0v2LjxuwdHsDB8H29V4mPMXD
2rWA4mnfk7LkxpwE0xNtISRs/wtQw4JZFmQYenkYSctyBhJhgsemz5rw7HBK/jWrfb3X5+hZ
a1OAIDRHgrArFEHuDEXvd9UchdG5/8c1WOL1jKyRnPuiYrpoS0b7CY6G686TJKO/cj33e70x
hGK5IXkS/XsEiG/Tog5d2pzLd8DdynJ9SaNy1fa0wRFQw7c48ZFkfDKPUqLJz6iy+7JphIhT
N4GCGxk0e4xeLMn2ZbQ1AAtl86o9v2GelpybO+9C3TBEz0muaWlmJqlxEgc+tRoe/qg1BWxV
vSJJDHiI1/vX1t7qZnB7uOBh88z3KiKOYrQdP+bBaFR6zk/Wej4Yz34SAB82fFvQOOkyLPcJ
uo9wxJq9zRMkxyAAgsol7bPmeFJ8VtTqVaAflXN1UMVuGWtyHIOyEbuhBkXzXS3X5CflZV40
1AHqkLutJbWgsBbKv9/ZV99bu798YM7FKDxQD6vneNATHF3B+w+1o4WNOQ5dZNMjimVNzFQz
gLJlgl74V0rbpGnCzE9aikJxcADFPALUlwkSmuRLE85MsxfmjZBjaVN8mZxdtouw/k+VigKl
rteJBFDNbRE0INwunaIpR7SwnC/Mtt3eNsIMt6B87cBjEz/odlWOxD41TYxA7zWhLq33DONK
fSTwPD1qav3IjzXrM2T+Sss92CVs8K3CLxAaxSGBzo2+3O45mmOZRrX5+RsmuDIdBf8iB9So
zQ4Ol3stGAfAYQ9JIaANlbcXw+ucJBmXa2a6VFw8Gtr2U3Xxu3SGMssbdMa+9R8VErNsbUro
KMv3XqrxkUOuUUuC7ii/0cGh6tnrL0aFli0rRa9ZMoRqC7akVdIuYWnRzqp8EjwtC/a5mwdR
LsibEBo32ZbeUCNCNoL90tuc+N0xWtnaPUQzTjVvla3MrhoCO1ddPFsELc0kRp7kOc6+EqxS
mgYxXZR3ggrmPoxuzbQsJAILk/xNQWa2bqo+QeB2A+TbEBVYIchwoRxaYGHGjt2iNq/X1nPf
ToPqsX4Zvw6a16p7TJY22lHwVKAq1qyVf9e+bkxUpT6pOJnDt+5RQ9iHBv1Hjck/2ybzxNRb
iqU7BhNRMmDeMLmNXURQXTm/Ijoz13k9pOdTKb4XhFsciwwFdmfbWGONsDgNYyRW8BoRoNJg
8vutlhLtCgtH2swCDOMCYr0RMMIhQv4iRmMCfd31S5WjbonIXkR8fIHalfXbrCzaxpE42te/
W5F17juM56JrqNVknODkPFx1Xi1Ws6U+q1dEv9to0j5fvONZsogYW1nJ15djj5WFaDoRUmvq
bKFdmqltz9ePa0c6Dy7qtJ9NzFGRp26FshAqKhPpmJG0yn43vK5oSwBvD9VOqTyGWz5Z0OZO
hVC5wdCDTdLs7gvYgBVcyMf0sC6nJgvfEMVe7eUOYab4KNkxkmENTHTejdxy42iFIB1vAKrK
f8ACxasXHSIYxzMeC+Fa/qTeZ5eUKJc7k/H71BziHEA4IbLGASqjYXQnLMI46NV/Glr9bzk2
0Nb0EL86WjtKtxb9vrhrtU6V+c3ulkm6FGeGD9x462OCZEf3ToWe9xUOFowhYNoNY87J3hgj
/ZK7l3rPJzoWg0yczX0JABwK19LjynKn6lf4z1RHag0PgYDtk+2stM5lWoBIeayR0J+6XSw5
Yx2dCPTzwET1iRYpZL6RvVg+n/bfQLls5ke+l8Ic+cDCMatysUXy62Be0+DRuRXYRHPPvi6l
tqLU8ZvodBvD4eQHjLOKB4rLtYMZCd9IFL+fw+Z7kmYHPszwoprT/Z8+sSiXKKgNMt3VglY9
XoRo4S12q1N900M0HXhRDRLktBOodw/iNjQ/pMgk8/B1ap6knCcsEIDSOIIDgYfXJ75isuSR
YOeC2uJpBIFsrdUK1meBkOqGUN8AcNGAAdV8i9amwsFHNkClCBacHWLFk89qzncUvWiLvcN0
fJlDU/JfRxyQvohLrclDvuF9b/tjUTGuuMFFoDrIbWwAEww0O7gDRt9cszUN4MKfwM/zWwli
h1oNR3FK5h5QFsl05Qo2Q8j9YBq4On6qrMErM7mFQkUT/9n1QVil/p+bJtwWZOLhHNlRyJuA
0ScrQZWtGETemNZhTcPDF9TmKi4QkEFdAPd9mgO6QFmkCR0hiEV9pK+lkg+UqO9MCblmVYCi
xICPwvRopacvy1Lr+C+RgiQk+lLSCK68pj8sQakfkr33NHqpixopZGdnFiJsxvgR3+UDze5L
OBveal8b4o3TFTp92emjO6DOGBHW5OUlc+AlfTHLx3IPCK04F7fIXNXahwtbA5dpqqbnhQga
1oVkK4Uz4clOP5RHLVQPos8D+UebcfVNVK+VltS4hJqKI4tyyg/9NqbUX19Pg1Wn15TfMcP1
k8sCgdDi0RydAp/LrhU1ahbJ4k5d7QGx/+gzxbyNFF9VkMUP52ULg7XZ88Jm0kWLu3HCmS1R
kZJlBF1l06iSSbD4QrQCGIdUHq/StQLWk6lraq/NGJa/yfSGw8hScOzgA0ioA2R13Xdgye8F
TrKh/f8sdk1dQxoOsk6++p9DRIBOXUAgHSrL5hghnWy5lPXIobQbJPPAnIfaHoKY9OSHr8hn
ioBpDMvcytR+zvNK8AnaJsdjc+qhAcbTuwwtFQkNzE2mMkiCxMFC2ryuGfor/mY6iiWh+qkA
IUHeL5mcJfIYGb0VOzqnrHxmwEy/1fOgbNXTibStXAph7x+BcLYt0pL+Q0Hhc4/jTdwB5ODM
A5mnsaoQKhrM3aTY7BQvVr36sjI2eC7m/x75+dKCU+7U4FuEzwXDozyghRSoedUtO0jBQ8BW
HY1SdTmybZivbIRiNN0gngn1mtWnQkLIXj2mHmnJXGVoMG9vbyixmCV1nyWsX3phyBC8FYzZ
uB3442dx3Xhk2+w/pPoCCow0N41EzteWiFIGGcPfrPi3HZ/VRbrEGEl3PsKkzkWFtKaoQmdF
yFKFVoSG6ol3vgUsTIc8mtT9ifu3o/TiAop1dULRxZ/YEwrV+DQyvKayoWWB+Up7LlLwwg9S
M4G75qWUTQKlatIinbzFbmRWQF1kOmEzXwM6cvND2pbTgbCxZUOHRkJq3++7RldPvz7X/rrl
p9XOIPqRqoR5AydWdyJbdDlltwYRQVTRzy5ZDedyt93Jz0f7rcZZtA5JVkzjzQJ5hnyhj5gY
/kYAsPQFIS20O5r42Dadx7T2qnLEKdxnkOjmpB2RksN3jDEPLW0rA3ymF1Z0nYEq0WO26fyH
ccncC1Cv7pxn3q1whM7hCStmgimKlVtDWdTNzP6CAuPJMGEXo9XTl08YEgMCuZEPt/T+GOBU
o5G66BMNBesVOB6+j7a5rIvKyvsZ/BqCEpuZ05zhxidAP26CPeoyymsbuVne+dE7YbFGduOx
Q7dUbC5czhrySpfN/GkUEa/rnjJo2+MqDqaQGlLaW7wTpAzoSgnYSF6XVOjpTKNGjH2x7s35
WGmYOcP0XYPc1EeDn+aW2wHaSAajIGRtSYAPgbiU9+D5q/fcrD+gnKsHvlAjOaDhfnC9ix7W
kNnT/Y7ySFTixEeBDf5Ef8al37Wg8DV2FaRNQmc4oGUpaMmFpNjPgeSR0EVcPLI7Ya32jOjf
vtJhxHNU41ST7T6DMCL5/cPB2q3hrIT7dPGctBZhRpE0ozmz12W5hXLmuFS6tua1SknaQBfg
nH8vtHSbMS0ajRRmV+bIwN9qqXG4+m122uOMU2vgp9qAU9Y8Q+biiHmaPPFYpo1suyeR16Kx
KYKDMbbdBJXhrC4wtSgjLPD1yqpdXkzFAgH9CeQ7rCoFNOTNU64WkivwcBvTARK6+eqVUrUF
fDis2PQU1UVmFy01kerCv2/ZonOFIU6+OBLAH7Ub70FTWucrpvEW/GkxCsINtsxmxU67QPq/
Oj5bg0gDRXrQJkqFZ4eixA+qBPRryAkEXJV2AEiswiuRzyevufNXfifvOGtWs9IPX6o82Spl
J1vOA4lQAz+1WYkBRjUExZMLapUZ6fd3clEScho/PadrlFUStU4NAg3kg5NcDoPf+g+F3E71
mW6/jTii2H8MoH8KI3Vc4MdnihUI8gtcMcoeDidLXKbDRwcLbS/aork4F8UcXjflTfcXpEr+
yP1KHJ40zvs2J/qJ63KsmFN+AnyEYI5oVwpKVNyAAbC7cG1iA+FGfBsXI+lKPralFX1nSod3
DHsxQrZfzbMqMYBeqOtOT1WZPy0JYRPKd3jCDX+vD0luCX6Xihf6USk4PJsn+tOm1rMdVx03
Oh1f1MzrIeWetd7FN+0Dwv1GczX03Ht8IcNnkmc5jKBQyKUYDsUOgDYzARm1Yf6X61TxUA9n
0JjvIfRXFI5f//MJDratf/ruCznxuPaboCuzsir3SbUGx4Di5C7rVpU4yo08ze3Wa+nCcIpM
4zaH/84h3HOqF9fjCRcwyM3MNWpIjtFafKdJVMCsflFwqV6pn+Y3/OCg/f3rDk/k+rGI6Xsj
AgSJ5+FNYaQym61VQkbTG7SfeIieaDX+72nk6/+NWaimQyzYGYrcUGFa4A0W0pHa1X0qWFo6
T2G0NqJT19UM+iPxJyhDtJ/qxzUeCpoXAlsSveBuqi44qbNI6t1P7a9yvu35yevnp6jaJf3Z
kze/3mqU5nS0C2E5o9Z5xr70cxC57EF2jb9PrmvqAQuYlEEGE1JGcTqMpPsEzKAdTodCMYfs
K/e2JBVNCqLkbgAvOsVFw+KWyb7w2plN+d6fVpHKrHqjokh7R9UfZMiTFDvczQoF6e+p8uTM
AAFF16QiWosRzOb/JHmtt/RKu0GfYeh4hFY5XiBi1gqopLkwGf3gaFdhP/hSt1st3vdw/Jo+
g9087knQwePl+aR0zx+XYq0c0Z0XmZAMpXr75V+X6OaRhZF0C91PE7wap0BMDJwZBXi16huI
YyFrTxmpNVvJgFf/1XbkqAwfahQg2H807kY2rk0fGfiFWggUsEqUWUgBJT5Ot2wMcBsE3ShO
T5GEGkMNafPUxCV1SVRr8wSAAAwdAdVub87TOoUkXK0Y4ZKIP48FNyZTOCgUxSQJKq0VJRZ9
5RCn6b3xNoK/JtLbLli5lei/R7N0egZAqV3ooAH1GfKH575OYBea5XoEXc4AjGgwCTbXOugZ
p4E0vY2mgmQpMbdqfFvI+kzeaTrVYmxzxGC+ex0Atdeq/G4HJEP4tSJh/LIlgmg/jqWJd23U
Lp1loie0uPizJNFjeIOqGZoH8t4sAqaarouryObSrQTNSmXLEEysPg0TWfoKDMNMcLFilbLL
5sjCZ6A/AU606h9HmjhKCM96xRS3rSH8tul/Ix7IrB0/9k8z7LX7oH9uXYu8o2rZV9+O/lgC
PUR1McA1GL8WR1ueGXyy5KStqp8ckPKbEGrxK2rzaBMAzLWUHcm0Jiu3Rqzm11QLccbfRGvo
7zJJNec34iotqEX9was846qVbIoUwBuUb/F+e3L/yzWODKJj3NMvyRyEac+AJOI4bI0hRvUn
3nG7VkzNUyWvTh3aPHHOuATV30McQ5dz8OQZQBOJS2Ch6T78EZwbbFuQUpxe9MnxkAmxN7tF
xVuKJz1FpxjbZ3agegg5Lx/U9c9u+O9nJGRyqIgGuoyaxHPL6mHL1Pxoygf0Q2pjbxPqKRoI
VbNvK6vDPHjWHbHTGfg+mWfY/cURr95esWDbwygZgLXE9mmJa/qJBCdIKHE+l2BLTYpAQel+
cXU3gEf6l+gTD3ybievNr62vlrgFsdcEWyrPLHuRFvvBOp5Ffwxk+Zd5HynLUbRpeOYZtxiy
WJhBIOPxAtxTzAwEsD/bpFXE2VLSHom5hbpDPU5vZoUYGiEP8GzjB3kSmPZJv9wQKrNdnG8D
9RrpM3Q1ny1L3PUYPF7YlQgJ5vrahBxzx7xatSrkDNCByF0SVGyZOSJZSB5HoUkFceHCBa1y
Oc/kuROy5u0WAbi8fpNpPJLfwX2VveUj8vVGoLBfGUTxGK9xCrFN9PwsD/RD6OdaBGBMPegH
x9K34H3HAsNaYPiL/aB+R8Z6VMV9NeZ0NpL4+JkVzHPCC6he2VUHhlmcxdNqjK4BJoFqAkq6
U8GdfeTsvoky2eahOfO/Xq1hELn3KK1nEM7ZbP0cT6HG76dvqhfuK1voHzopB1AfMy3bsJqO
asqS2zomb1vOj3aEUvMSTinKwRP3aISl9Z1gYQRAMfDrYJ+1g0r3Xci3cCoMyHmMLTivan42
IioEwhs+4ltDiqRoDvyvktyUANEXiKWjjH/FGbstMvU6IFc6zCdNZtACmvjfrxt6zgfUEVvF
YR1ZWvfKEALx5/0HrLahbI7FiWaiblOmSkS6eqlLRpJpqOJ020AVj1fp7SwfG1w1pPHKO1Hh
qhO+4F26Nn20d+9MRGj6UNVX7ToPA23KfdcMbeRBmnNxuJduxse8Ate7csOKPxlFpncMQboA
jLPQ76JhK/A7jQ372zuOiQNleNBQuRBEWu6fhKU+VUfwcPQLJahnbpk3oRonhExMV9FlzVyb
VLO0ERBil8IZOHNFzUpcMb4+enyVJvccuXywZNmtfobamkZfQ8aOOYWDEDzYlq1Kq/s6BNEE
oWMyMfvdAda9pqHLTN+fxLdfdwqemOxwzEfvoLkKliiUALVOFdcxXAvczr7sAq5jxULKevmp
fO5NnrxtTQj2y5++ffx5qC7myZram/fjEXTyfcgRgcm3gBMy2URikrzlHLZKg0uy6haR32Se
SsQUtm8XK8Qdy1fZdauU4rdsShN15mRMEYjdhXoAHVBl5tcD+x8l3MxyH02D3mLO6CVisWY3
Cf+8BxduVue8VcZLNvm1NwckFHtGdxJFHi67KOMDsLALCv3CfkTuXAiq85Mf+cBC0amJ/t9d
BwYUPPtJjgA8coCYwOkW2AvQya71C8VwJNvOhhfotRrNFbCiiPLhfqiG3H8/otXzUx1XXXgF
5WwrYXbuX+CWsYWB7VscjTkpBkDZSEMPFX5YhR5BRP4FHZQnc1yKKFI8cxkRTGvKeGqmiyGD
3NCC5brntmk4vkekCpWaWSZtJMW/MYKhaIDRWC9+zjY1+UTapZz+azTujLXWztNUhig0fl1E
yXkzft16AI/h1JWp3h4hCnOcfBr1+ZbafFjDhBPFRGXbA6FqOeugd8k0Cgju69SAyZdsj3Pa
bVc/5vZLwGZTELk0QvFP0ADtGZ2Efz/18vMMn2lJzosjJ/ShvmY2yNMU/YUYVWZwkrudvUmO
YYjB89e/QyJwCTg2ArLm10cRlam1Q5Tjr/3l+FO7T4n0JmHTURBNooOVkmjlNFoY2S0yMNDr
gYUyDZOj2IF3+aN7kVuJH9sn/oV9O7JfvDoNP2w+WpalQU03LxbpZ0Uz87m9HFbbEz0tltIL
2AiOTsrLUNUSYBMqwYAgPbWP0qGz8PLto82zL4oUsoJXNU8CvZG3DDYj5ydW/5S8rI1Fb913
dDcSdHycgoHgzwx2MUI8AnHORE4nEWKMNwcOwmcUT7KkUILd7bc/Qg1I5alZLj0DHEH+d0/Z
sGmGJPgXU9And09tnwkV1KhQjk5k09E09L/MNBOeJP3LbMm7Cd2vQx0fBCEinR54w3+a9x+q
8XsCGzHbY+ThGhv6H06rMBLBvKLEbeYWbB03D8Ua7FxHYIKem9aqQXASEf57FsJIPVxrssJK
YaT4oEaHDzGjjP7Ln6JqRiqhkLXhwidtkOfXmJAsbXUfWLtLrsx0MmKJSF8S3lbyGfvAjA5T
Ynw8ZuQ/05hQZCQu4oV6cwWyExRZLBfAxzFbrMSpmzMdnoTzKhZ2bCX2W2BLRZIgHLHW5uid
HG6ajTnSVFbklBaEsaxhUJKOXhhE/EMj9qOWa0KyjO4aHbejpG4qsdOPM6wPLuzHk6BbRf/4
tnKDtJnlKemXsUUksZkL7OX5Et3Rum8UM+7/EvZhbQUR9geAQnhWv93XNBDuU+EbgQYliZRM
PXgl1CVsQow8ZLd/Gb2l3LvCu7T1zwC/L2OB+hCEWhvY0+EbWuYH/rFXlFn/iZlC8xLdC7pu
0n292pif2BrpmT7dTRtNd0rqliswHmFPO0bqe9BdOqA4BDmDDjY5ylQmkr4Lbotcmq1I+mGN
hmUVcdYPQbqbDJWeg/vZsZU4I9+djAcuWeU/JaIwkg2fzV/IbTEqjqa1DNJt5MLm2EOISL3D
wo6JnYfRQkkFuVUjhDUNRI8Eq2EB9aGxBK+XJzUz4wZ6ISQ/2w0hxOKl1WKACv8e9WysXIdj
HE1D7TZraiNUCzWYfRD11PWOaxYPic+FJojgmXk30lRbfEAZN3RUWe+s8y0IPJcOQvsMKhrq
4Nw1ZgP6ERfAcdpt4Jx/Y4nZyFiiFp4pWBml7rOEINAht744fUZI7kE4pE9830L2VFAcnGQC
jZyC2wVzmdSwutDVkHTlKAU3C3E88hlpKr6suJQC43yhBzxufzmH009c3DOdkB7qdhfTyzph
tzEG1FWp6Ix9hO5TzUWXXoGwGqdZWVgfyNsjk7Hjkm86AzJu6yYQVGXvPup3RWV3hBHSD9TI
/4wTVy9jG70HzyCdmiUDlTw6WU2Nf6BrnMbLYYY71eTU7qy7bbHafgU2U4zOR82Kj1xBDDhV
QF7NX3unQpp6m4CcxKMxRngtEqECx0+f2/4f/leOtJPFAH1ZFQmSLlADX4+M+QrpR4KgvAMM
sWQ0t0qmCm9JWJFdWbdFsIeVgFcfVHaapdFYZpSqsWxEjRjQhD5mzD8VXHJ3S8X1tup7ZISN
5IVKJPJ8Gx6TElCCEcU6hh5xtq/2plvfN1lrnzhoBX6n9ofImDchtDu0OswE+0Ms4D8cjBox
x3weEeF2eY60XloWYtNOk5NloHv48700pjwHm0zlePxoW+MGizsbjWT8LeyVj/UusGmNAr/0
4/RsFDc1U9Df3fJ81Oq53F42LIAsgG/UebEYST3s/sNY3ozaVaqN8WgdXxBShWSWPbaHtGvo
RtP3+HBEi0EEHvFjBNjCG16N1zIffb2jmfb1WCPXNp9YJXlh45Oh2xsYUyb//B3I5yE9R618
VwgGpsGy86k/rXZ2vkl56XuL+8X90HCEw0yDT5zcfoWnU1XznppFZyCveYO3H/yEHFoRCSSs
i2870IO+wXs0qF0kocrYJDcg9YODbB4QhmBepiu6r2yss43qS0pc+AYwE9H2uFVhF9B5daUA
u956NO3H1CD0BgGQ0Wn+9pjOcNPv62gCCmQBxeNhMucFeZ7xoNDyNt0MS8sCVfJPh00+trb+
vwOl1K+bBUTJgyfKY68WP9+C5pDU8cuqTzUqfwdiMZSeXvN3VFCKn4INQZ8V6yVrOwfbdPul
KndGqiujtUy65HRGxydbN2/gLht047TB+zJ/BTk7NsmMx4gEKOiwI65BWjmJWbIQ/f5ksAUi
aF0xCPjgNykdH8cD9G7UojmSTDn4leIIeeN5ZsBCp9V6c+0uuiQMVD9W7xXcCJusHZE15CIY
mFgq57EJ2Hn2y/Zd9Wo+vCBIpnjJvmfOJFnM9t3qLqBVLD88cJBWg7jwYdJySjYEM9f1TcDE
28gVpIh26GpIJ55H31glxFyTMcxbkkz6okb3wq089s7xdffiOk7XzwPgyPG4FH3hdxOXNv+V
OpL2GINOiINO9qGK/UlTGVOnm1izeE3aAH2sO36Cv9sP1FmGG8cn+FQ1v0x/KSP1NG2Vomqk
GMxee5cFfhqSSXDVrEWR12LmU5OA5iBFhuGnonCYhNLj9tPVIpcijdjnALx3sZ+GxLoSHIvQ
a2mbzVQBQHiWlhLhZ5aNf5vK1TnLsHLX1WJxW5lcX6TJbcNEdBreq12vDhE+D7V+gUUjhrqY
tZb7EpGLzek+hmey0HlCDNy/LooHD+s9Qr3mwv2M1t1qW6qSXXTOu3FymeoRFNCX0qnOCxk2
WSHUUy3lD94Jh1huhclnYSAB2J8wY5NmJa8k6rmQl16GN5FSgveWkbo3PX/rmGgNYL/6p94o
Mye8bTvhgHGDrKCeLHzF3TXTj8jFiqB7UcO+QU7T3BtBAee6J0Ve2zapsL+0M1sVZs76g08h
tKV1tznxrp5WQ6KwKf/BrMLj9/hahM1gUIfN3xjtPgDH3cYS2yigDv859fNlY5a9jc3Imo24
2T3AptWDlg4uZucvy5rqhklY7asLKA53ouuO7ZrKrXznYwDPpnKGZYGYvydXvuT+MqhNqTBC
SgtOXERUOb7EJwq5kyV+teL37OpVaYq/H/sW1j4I5fI1yWZZAoorvLwYxueKHxWMey7sSE5C
vf3wQbn8X1UQBMnG3z3cOkT1U6qum51TpzILzX5e34SGa2ReAAQVtcvA3o5SvVnRpRsuqaZR
B3Znl6ZnldQTR7AK8V5UiXMMnN84cVcSEFtHP7iL7Al4vQxSlUjaUiEg+bH/BzXvD4CY6Dns
5Dsuu1Q7u5IiggkxhYrirYViUFPnhqITHPFMBkVDEByfuCnYK/1m+7CuLNcYbds5WHU3m7JG
jTJd3TE0TFmQXB13dlgQy9VoLTxqQRgp3feaMzS8qMPX54yYfCDGrzRDJfq8d8/GSiJSVcGo
HyJPjCqbrzheGzfyyDONjzFXt+fP2NsoxIctW3E0Oj919wQHVnVkzekXgA23eLbGXrR7PLuG
g3ZngSdOYjyhyGSYSgeTi9YI+myX7ZT6jiPC7rTge2pLzWUWSgtT+dIGrpboMKz0yrRDdVqB
gllrvQctqt/SqConXzNI3JCjDW4379dAWqQJLSwUpr6yNgyTmX1lHVSnVEePsZL97DLQt5yw
zXIEiYtu7vjRFkdIZ2amw8Jttnh2PV/A5nJjZxV8Qlj0I6rOn2yWE5oafrV4c7uq2OOav741
hdEjxr0LkXWqgLa5cH1eKUxsQZtCSsSEqjhtLMKqUBXftELrfgyWM8+CYRkn2DRNf+NvuB+h
nSnuecdKvu1CU3mQs0k9xE0T+iFATenJNv0QvUFggd8cw1NmmGklBinPkHNJ83ySkfH3uJLF
DWgAYmVyqV4CUYzrHPttNs54GpshnD9uoKwUcm//PnVSBc97BppH0xj8RMuAsJ+xE8XQrruH
WysryggG71fyu6j2uumyP4hGOW6dNmuKrozWo4+nS0L5GvtPJGCxtN3nquq5VhKURiJvNUiK
3nIfNvndOpF9prY3sGIdnjGpHQlgfc0Uv3qvwlvjR03nbI1W2EPkDmw/Vkz/KgoCc2gXPrdU
plzML9Farv5/XIZKlgpc+APNIlsgPKqpYl80thSMpLq8Cg4/fRLkg5VboN1qSWTNsensw6WQ
F48aNFukJcKGAuemdeSPn/h1GB1piUXWIisSTCfHKgpeGaWVlZ8aeRQ7G+z/4bC+n07KEu+Z
El7qdUdrj6gvAoS7F8WoSb30pUft4lkWp/mwFcj7wimbYrq7tD6P7uzGldyvUCMv9xlEV9el
SIkt0/W7/nkrBN9Tut8L22ZCF5+V33A88nu0p0ngZgtp5/5PTUanwpv+yhSQxfn1NRZLDADN
LbSJN3JfEnLqykEx79+sD/QAAAD8IprvhTJAbgABzqkE76sdz1+plrHEZ/sCAAAAAARZWg==

--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ltp
Content-Transfer-Encoding: quoted-printable

2021-06-07 02:51:43 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-06-07 02:51:43 ./runltp -f syscalls-04 -d /fs/sda1/tmpdir
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
Linux lkp-skl-d02 5.13.0-rc4-00013-g7463fff0372f #1 SMP Mon Jun 7 09:17:57 =
CST 2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=3D0xe2-debian-10.4-x86_64=
-20200603.cgz-7463fff0372f733229a9384f509943357e4e5caf-20210607-24016-jxviv=
b-2.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinux-review/Feng=
-Tang/mm-mempolicy-some-fix-and-semantics-cleanup/20210601-231653 commit=3D=
7463fff0372f733229a9384f509943357e4e5caf BOOT_IMAGE=3D/pkg/linux/x86_64-rhe=
l-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/vmlinuz-5.13.0-rc4-000=
13-g7463fff0372f max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1HDD-f2fs-sysc=
alls-04-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhe=
l-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/3 LKP_SERVER=3Dinterna=
l-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rc=
update.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don pani=
c=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=
=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore=
_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 =
vga=3Dnormal rw

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
ntel_powerclamp coretemp i915 kvm_intel kvm ahci irqbypass crct10dif_pclmul=
 libahci crc32_pclmul mei_wdt crc32c_intel intel_gtt ghash_clmulni_intel wm=
i_bmof drm_kms_helper rapl syscopyarea intel_cstate sysfillrect sysimgblt l=
ibata fb_sys_fops mei_me mei intel_pch_thermal intel_uncore drm wmi video i=
ntel_pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32754216      350748    29801416       21788     2602052    2957=
3124
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
CPU MHz:             3495.241
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
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2538     -n 2538 -=
p -f /fs/sda1/tmpdir/ltp-msRK2VdkT2/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_06_07-02h_51m_43s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_06_07-02h_51m_43s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_06_07-02h_51m_43s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_06_07-02h_51m_43s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_06_07-02h_5=
1m_43s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_06_07-02h_51=
m_43s.tconf
Running tests.......
<<<test_start>>>
tag=3Daccess01 stime=3D1623034303
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
tag=3Dcapset04 stime=3D1623034303
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
tag=3Dchown03_16 stime=3D1623034303
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchroot01 stime=3D1623034303
cmdline=3D"chroot01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chroot01    1  TPASS  :  chroot set errno to EPERM.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_nanosleep03 stime=3D1623034303
cmdline=3D"clock_nanosleep03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:52: TINFO: Testing variant: vDSO or syscall with libc s=
pec
clock_nanosleep03.c:99: TPASS: clock_nanosleep() slept correctly 100220
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep03.c:52: TINFO: Testing variant: syscall with old kernel spec
clock_nanosleep03.c:99: TPASS: clock_nanosleep() slept correctly 100220

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
tag=3Dclock_gettime01 stime=3D1623034304
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
tag=3Dclock_settime02 stime=3D1623034304
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
tag=3Dclone02 stime=3D1623034304
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
tag=3Dclone04 stime=3D1623034304
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
tag=3Dclone08 stime=3D1623034304
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclose_range01 stime=3D1623034304
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
cutime=3D9 cstime=3D90
<<<test_end>>>
<<<test_start>>>
tag=3Dconnect02 stime=3D1623034309
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
tag=3Ddelete_module01 stime=3D1623034309
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Ddup01 stime=3D1623034309
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
tag=3Ddup07 stime=3D1623034309
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
tag=3Ddup3_01 stime=3D1623034309
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
tag=3Dexecl01 stime=3D1623034309
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dexecvp01 stime=3D1623034309
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
tag=3Dfchown04_16 stime=3D1623034309
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
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dfchownat02 stime=3D1623034309
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
tag=3Dfcntl08_64 stime=3D1623034309
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
tag=3Dfcntl14_64 stime=3D1623034309
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
cutime=3D2 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl23_64 stime=3D1623034314
cmdline=3D"fcntl23_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl23     1  TPASS  :  fcntl(tfile_3124, F_SETLEASE, F_RDLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl37_64 stime=3D1623034314
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfdatasync01 stime=3D1623034314
cmdline=3D"fdatasync01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fdatasync01    1  TPASS  :  fdatasync() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfdatasync02 stime=3D1623034315
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
tag=3Dflock02 stime=3D1623034315
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
tag=3Dflock04 stime=3D1623034315
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfmtmsg01 stime=3D1623034315
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
tag=3Dfork01 stime=3D1623034315
cmdline=3D"fork01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork01      1  TPASS  :  fork() returned 3139
fork01      2  TPASS  :  child pid and fork() return agree: 3139
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork13 stime=3D1623034315
cmdline=3D"fork13 -i 1000000"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork13      1  TPASS  :  1000000 pids forked, all passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D106 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7032 cstime=3D3897
<<<test_end>>>
<<<test_start>>>
tag=3Dfsopen02 stime=3D1623034421
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfstatat01 stime=3D1623034421
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
tag=3Dfsync02 stime=3D1623034421
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
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfsync04 stime=3D1623034421
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
cutime=3D8 cstime=3D112
<<<test_end>>>
<<<test_start>>>
tag=3Dgetdomainname01 stime=3D1623034428
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
tag=3Dgeteuid01_16 stime=3D1623034428
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
tag=3Dgetitimer01 stime=3D1623034428
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
tag=3Dgetitimer02 stime=3D1623034428
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
tag=3Dgetresgid03_16 stime=3D1623034428
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
tag=3Dgetresuid03_16 stime=3D1623034428
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
tag=3Dget_mempolicy02 stime=3D1623034428
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
tag=3Dgetsid01 stime=3D1623034428
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
tag=3Dgetsockopt02 stime=3D1623034428
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetxattr03 stime=3D1623034428
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
tag=3Dioctl_loop07 stime=3D1623034428
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
cutime=3D0 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_ns03 stime=3D1623034429
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
tag=3Dfanotify09 stime=3D1623034429
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
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/tfile_909
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #1: Events on non-dir child and subdir with b=
oth parent and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/tfile_909
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D909 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testdir
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #2: Events on non-dir child and parent with b=
oth parent and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/tfile_909
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D909 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #3: Events on non-dir child and subdir with b=
oth parent and subdir marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/tfile_909
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D909 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testdir
fanotify09.c:335: TPASS: group 1 got no event
fanotify09.c:335: TPASS: group 2 got no event
fanotify09.c:246: TINFO: Test #4: Events on non-dir children with both pare=
nt and mount marks
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D7 filenam=
e=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/tfile_909
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D909 fd=3D8 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testfile
fanotify09.c:191: TPASS: group 1 got event: mask 10 pid=3D909 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testfile
fanotify09.c:191: TPASS: group 2 got event: mask 10 pid=3D909 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testfile
fanotify09.c:246: TINFO: Test #5: Events on non-dir child with both parent =
and mount marks and filename info
fanotify09.c:191: TPASS: group 0 got event: mask 2 pid=3D909 fd=3D-1 filena=
me=3Dtfile_909
fanotify09.c:191: TPASS: group 0 got event: mask 10 pid=3D909 fd=3D-1 filen=
ame=3Dtestfile
fanotify09.c:191: TPASS: group 1 got event: mask 10 pid=3D909 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testfile
fanotify09.c:191: TPASS: group 2 got event: mask 10 pid=3D909 fd=3D7 filena=
me=3D/fs/sda1/tmpdir/ltp-msRK2VdkT2/qtEeTx/mntpoint/testfile

Summary:
passed   23
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
tag=3Dfanotify17 stime=3D1623034429
cmdline=3D"fanotify17"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
fanotify17.c:243: TINFO: max_fanotify_groups=3D128 max_fanotify_marks=3D279=
983
fanotify17.c:176: TINFO: Test #0: Global groups limit in init user ns
fanotify17.c:133: TPASS: Created 128 groups - below groups limit (128)
fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
fanotify17.c:133: TPASS: Created 128 groups - below groups limit (128)
fanotify17.c:176: TINFO: Test #2: Local groups limit in unprivileged user ns
fanotify17.c:133: TPASS: Created 10 groups - below groups limit (10)
fanotify17.c:176: TINFO: Test #3: Local marks limit in unprivileged user ns
fanotify17.c:125: TPASS: Created 10 marks - below marks limit (10)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dkeyctl06 stime=3D1623034430
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkcmp01 stime=3D1623034430
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
tag=3Dkill08 stime=3D1623034430
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
tag=3Dkill09 stime=3D1623034430
cmdline=3D"kill09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill09      1  TPASS  :  kill(945, SIGKILL) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown01_16 stime=3D1623034430
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
tag=3Dlchown02_16 stime=3D1623034430
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
tag=3Dlgetxattr01 stime=3D1623034430
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
tag=3Dlgetxattr02 stime=3D1623034430
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
tag=3Dlink04 stime=3D1623034430
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
tag=3Dlink05 stime=3D1623034430
cmdline=3D"link05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link05      1  TPASS  :  link(lkfile_953, lkfile_953[1-1000]) ret 0 for 100=
0 files,stat linkcounts match 1000
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dlstat02 stime=3D1623034430
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
tag=3Dmbind01 stime=3D1623034430
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
mbind01.c:188: TFAIL: Wrong policy: 1, expected: 4
mbind01.c:169: TINFO: case MPOL_PREFERRED
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case UNKNOWN_POLICY
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_DEFAULT (invalid flags)
mbind01.c:216: TPASS: Test passed
mbind01.c:169: TINFO: case MPOL_PREFERRED (invalid nodemask)
mbind01.c:216: TPASS: Test passed

Summary:
passed   10
failed   1
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dmemcpy01 stime=3D1623034430
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
tag=3Dmknod01 stime=3D1623034430
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
tag=3Dmknod07 stime=3D1623034430
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
tag=3Dmmap06 stime=3D1623034430
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
tag=3Dmmap07 stime=3D1623034430
cmdline=3D"mmap07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap07      1  TPASS  :  mmap failed with EACCES
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmount06 stime=3D1623034431
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
tag=3Dmove_pages03 stime=3D1623034431
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
tag=3Dmove_pages11 stime=3D1623034431
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_timedreceive01 stime=3D1623034431
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
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap02 stime=3D1623034431
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
tag=3Dmsgctl04 stime=3D1623034431
cmdline=3D"msgctl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
msgctl04.c:59: TPASS: msgctl(1, 2, 0x561d3cb40840): EACCES (13)
msgctl04.c:59: TPASS: msgctl(2, 2, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, 1, 0xffffffffffffffff): EFAULT (14)
msgctl04.c:59: TPASS: msgctl(2, -1, 0x561d3cb40840): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 2, 0x561d3cb40840): EINVAL (22)
msgctl04.c:59: TPASS: msgctl(-1, 1, 0x561d3cb40840): EINVAL (22)
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
tag=3Dmsgget01 stime=3D1623034431
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
tag=3Dmsgrcv01 stime=3D1623034431
cmdline=3D"msgrcv01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
msgrcv01.c:38: TPASS: message received(hello) =3D message sent(hello)
msgrcv01.c:45: TPASS: queue bytes and number of queues matched
msgrcv01.c:49: TPASS: PID of last msgrcv(2) matched
msgrcv01.c:56: TPASS: msg_rtime =3D 1623034431 in [1623034431, 1623034431]

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
tag=3Dmunmap03 stime=3D1623034431
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
tag=3Dnice02 stime=3D1623034431
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
tag=3Dnice03 stime=3D1623034431
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
tag=3Dopen08 stime=3D1623034431
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
tag=3Dopen09 stime=3D1623034431
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
tag=3Dopenat02 stime=3D1623034431
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
tag=3Dopenat202 stime=3D1623034431
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen_by_handle_at02 stime=3D1623034431
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
tag=3Dmincore01 stime=3D1623034431
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dnewuname01 stime=3D1623034431
cmdline=3D"newuname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
newuname01    1  TPASS  :  newuname call succeed: return value =3D 0=20
newuname01    0  TINFO  :  This system is Linux
newuname01    0  TINFO  :  The system infomation is :
newuname01    0  TINFO  :  System is Linux on x86_64 hardware
newuname01    0  TINFO  :  Nodename is lkp-skl-d02
newuname01    0  TINFO  :  Version is 5.13.0-rc4-00013-g7463fff0372f, #1 SM=
P Mon Jun 7 09:17:57 CST 2021
newuname01    0  TINFO  :  Domainname is (none)=20
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe02 stime=3D1623034431
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe03 stime=3D1623034431
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
tag=3Dpivot_root01 stime=3D1623034431
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
tag=3Dprctl03 stime=3D1623034431
cmdline=3D"prctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
prctl03.c:73: TPASS: prctl(PR_SET_CHILD_SUBREAPER) succeeded
prctl03.c:46: TPASS: prctl(PR_GET_CHILD_SUBREAPER) got expected 0
prctl03.c:88: TPASS: PPID of orphaned process was reparented
prctl03.c:101: TPASS: wait() got orphaned process, pid 1019, status 0
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
tag=3Dprctl05 stime=3D1623034431
cmdline=3D"prctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est
prctl05.c:62: TPASS: /proc/self/task/1021/comm =3D 'prctl05_test'
prctl05.c:63: TPASS: /proc/self/comm =3D 'prctl05_test'
prctl05.c:43: TPASS: prctl(PR_SET_NAME, 'prctl05_test_xxxxx') succeeded
prctl05.c:57: TPASS: prctl(PR_GET_NAME) succeeded, thread name is prctl05_t=
est_xx
prctl05.c:62: TPASS: /proc/self/task/1021/comm =3D 'prctl05_test_xx'
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dpread02 stime=3D1623034431
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
tag=3Dpreadv01_64 stime=3D1623034431
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
tag=3Dpreadv02_64 stime=3D1623034431
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
tag=3Dprot_hsymlinks stime=3D1623034431
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
cutime=3D2 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace08 stime=3D1623034431
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev01 stime=3D1623034431
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev01_64 stime=3D1623034431
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
tag=3Dquotactl03 stime=3D1623034431
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
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dreadlink01A stime=3D1623034432
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreboot02 stime=3D1623034432
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dremap_file_pages01 stime=3D1623034432
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
tag=3Dremap_file_pages02 stime=3D1623034432
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
tag=3Drename04 stime=3D1623034432
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
tag=3Drenameat201 stime=3D1623034432
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
tag=3Drmdir02 stime=3D1623034432
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
tag=3Drt_tgsigqueueinfo01 stime=3D1623034432
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_rr_get_interval02 stime=3D1623034432
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
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setparam02 stime=3D1623034432
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
tag=3Dsched_setscheduler02 stime=3D1623034432
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
tag=3Dsched_setaffinity01 stime=3D1623034432
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_getaffinity01 stime=3D1623034432
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
tag=3Dselect03 stime=3D1623034432
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
tag=3Dsemctl05 stime=3D1623034432
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile02 stime=3D1623034432
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
tag=3Dsendfile09_64 stime=3D1623034432
cmdline=3D"sendfile09_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile09_64    1  TPASS  :  Test sendfile(2) with offset at 0
sendfile09_64    2  TPASS  :  Test sendfile(2) with offset at 3GB
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D112
<<<test_end>>>
<<<test_start>>>
tag=3Dsendmsg03 stime=3D1623034433
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
 =3D   -36ns, avg_dev =3D     8ns, dev_ratio =3D 0.22 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D  1718ns, avg_dev =3D   117ns, dev_ratio =3D 0.07 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D   733ns, avg_dev =3D    12ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D   949ns, avg_dev =3D   120ns, dev_ratio =3D 0.13 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   609  , avg_dev =3D    79  , dev_ratio =3D 0.13 }
=2E./../../../include/tst_fuzzy_sync.h:534: TINFO: Reached deviation ratios=
 < 0.10, introducing randomness
=2E./../../../include/tst_fuzzy_sync.h:537: TINFO: Delay range is [-464, 11=
44]
=2E./../../../include/tst_fuzzy_sync.h:346: TINFO: loop =3D 1073, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg=
 =3D   -42ns, avg_dev =3D     4ns, dev_ratio =3D 0.09 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D  1801ns, avg_dev =3D    89ns, dev_ratio =3D 0.05 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D   731ns, avg_dev =3D    11ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D  1028ns, avg_dev =3D    97ns, dev_ratio =3D 0.09 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   653  , avg_dev =3D    60  , dev_ratio =3D 0.09 }
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
tag=3Dsetfsgid01 stime=3D1623034434
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
tag=3Dsetfsgid01_16 stime=3D1623034434
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
tag=3Dsetfsuid04_16 stime=3D1623034434
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
tag=3Dsetgid03_16 stime=3D1623034434
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
tag=3Dsetregid01_16 stime=3D1623034434
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresgid03_16 stime=3D1623034434
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
tag=3Dsetresuid03 stime=3D1623034434
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
tag=3Dsetresuid03_16 stime=3D1623034434
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
tag=3Dsetresuid05 stime=3D1623034434
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
tag=3Dsetreuid01 stime=3D1623034434
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
tag=3Dsetreuid04_16 stime=3D1623034434
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
tag=3Dsetsockopt07 stime=3D1623034434
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
duration=3D22 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1411 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsetxattr03 stime=3D1623034456
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
tag=3Dshmat01 stime=3D1623034456
cmdline=3D"shmat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
shmat01.c:124: TPASS: shmat() succeeded to attach NULL address
shmat01.c:124: TPASS: shmat() succeeded to attach aligned address
shmat01.c:124: TPASS: shmat() succeeded to attach unaligned address with SH=
M_RND
tst_coredump.c:32: TINFO: Avoid dumping corefile for process(pid=3D1253)
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
tag=3Dshmctl04 stime=3D1623034456
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmget01 stime=3D1623034456
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
tag=3Dsigaltstack01 stime=3D1623034456
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
tag=3Dsighold02 stime=3D1623034456
cmdline=3D"sighold02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sighold02    1  TPASS  :  All signals were hold
sighold02    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsignal01 stime=3D1623034456
cmdline=3D"signal01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal01    1  TPASS  :  signal(SIGKILL, 0x1(SIG_IGN)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, (nil)(SIG_DFL)) failed with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  signal(SIGKILL, 0x5608abfa4f70(catchsig())) failed=
 with EINVAL
signal01    0  TINFO  :  Child process returned TPASS
signal01    1  TPASS  :  Child killed with SIGKILL
signal01    2  TPASS  :  Child killed with SIGKILL
signal01    3  TPASS  :  Child killed with SIGKILL
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsocketcall03 stime=3D1623034456
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
tag=3Dstat02 stime=3D1623034456
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
tag=3Dstat02_64 stime=3D1623034456
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
tag=3Dstat03 stime=3D1623034456
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
tag=3Dstatfs01 stime=3D1623034456
cmdline=3D"statfs01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs01    1  TPASS  :  statfs(tfile_1275, ..) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatvfs02 stime=3D1623034456
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
tag=3Dswapon03 stime=3D1623034456
cmdline=3D"swapon03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
tst_ioctl.c:30: TINFO: FIBMAP ioctl is supported
Successfully created 27 swapfiles
swapon03.c:53: TPASS: swapon(2) got expected failure (1),

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7 cstime=3D47
<<<test_end>>>
<<<test_start>>>
tag=3Dsync_file_range01 stime=3D1623034459
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
tag=3Dsysfs02 stime=3D1623034459
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
tag=3Dsysfs04 stime=3D1623034459
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
tag=3Dsyslog01 stime=3D1623034459
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
cutime=3D2 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog09 stime=3D1623034465
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
cutime=3D3 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dtimes03 stime=3D1623034471
cmdline=3D"times03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1313: TINFO: Timeout per run is 0h 25m 00s
times03.c:89: TPASS: buf1.tms_utime <=3D 5
times03.c:94: TPASS: buf1.tms_stime <=3D 5
times03.c:105: TPASS: buf2.tms_utime =3D 252
times03.c:112: TPASS: buf1.tms_utime (0) < buf2.tms_utime (252)
times03.c:118: TPASS: buf2.tms_stime =3D 127
times03.c:125: TPASS: buf1.tms_stime (0) < buf2.tms_stime (127)
times03.c:131: TPASS: buf2.tms_cutime =3D 0
times03.c:136: TPASS: buf2.tms_cstime =3D 0
times03.c:156: TPASS: buf2.tms_utime (252) <=3D buf3.tms_utime (252)
times03.c:164: TPASS: buf2.tms_stime (127) <=3D buf3.tms_stime (127)
times03.c:170: TPASS: buf3.tms_cutime =3D 260
times03.c:175: TPASS: buf3.tms_cstime =3D 139

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D8 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D513 cstime=3D267
<<<test_end>>>
<<<test_start>>>
tag=3Dtimer_getoverrun01 stime=3D1623034479
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
tag=3Dtkill02 stime=3D1623034479
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
tag=3Dtruncate03 stime=3D1623034479
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
tag=3Dumask01 stime=3D1623034479
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dunlink05 stime=3D1623034479
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
tag=3Dumount2_02 stime=3D1623034479
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
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dustat01 stime=3D1623034479
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
tag=3Dutime01A stime=3D1623034479
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
tag=3Dvmsplice01 stime=3D1623034479
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
tag=3Dwaitpid03 stime=3D1623034479
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
tag=3Dwaitpid04 stime=3D1623034479
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
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitid02 stime=3D1623034479
cmdline=3D"waitid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(2, 1581, 0x7ffdb6e40e10, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1583 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(2, 1581, 0x7ffdb6e40e10, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1583 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(1, 1584, 0x7ffdb6e40e10, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1584 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(2, 1581, 0x7ffdb6e40e10, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1583 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(1, 1584, 0x7ffdb6e40e10, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1584 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1581) waitid(1, 1585, 0x7ffdb6e40e10, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1585 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(2, 1581, 0x7ffdb6e40e10, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1583 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(1, 1584, 0x7ffdb6e40e10, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1584 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1581) waitid(1, 1585, 0x7ffdb6e40e10, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1585 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1581) waitid(1, 1586, 0x7ffdb6e40e10, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1586 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  WNOHANG
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 1)
waitid02    1  TPASS  :  exp_errno=3D22
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED no child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    2  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  WNOHANG | WEXITED with child
waitid02    0  TINFO  :  (1581) waitid(0, 0, 0x7ffdb6e40e10, 5)
waitid02    3  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
waitid02    0  TINFO  :  P_PGID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(2, 1581, 0x7ffdb6e40e10, 4)
waitid02    4  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1583 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WEXITED wait for child
waitid02    0  TINFO  :  (1581) waitid(1, 1584, 0x7ffdb6e40e10, 4)
waitid02    5  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1584 ; si_code =3D 1 ; si_status =3D 0
waitid02    0  TINFO  :  P_PID, WSTOPPED | WNOWAIT
waitid02    0  TINFO  :  (1581) waitid(1, 1585, 0x7ffdb6e40e10, 16777218)
waitid02    6  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1585 ; si_code =3D 5 ; si_status =3D 19
waitid02    0  TINFO  :  P_PID, WCONTINUED
waitid02    0  TINFO  :  (1581) waitid(1, 1586, 0x7ffdb6e40e10, 8)
waitid02    7  TPASS  :  ret: 0
waitid02    0  TINFO  :  si_pid =3D 1586 ; si_code =3D 6 ; si_status =3D 18
waitid02    0  TINFO  :  P_PID, WEXITED not a child of the calling process
waitid02    0  TINFO  :  (1581) waitid(1, 1, 0x7ffdb6e40e10, 4)
waitid02    8  TPASS  :  exp_errno=3D10
waitid02    0  TINFO  :  si_pid =3D 0 ; si_code =3D 0 ; si_status =3D 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite02 stime=3D1623034479
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
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwrite04 stime=3D1623034479
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
tag=3Dwritev01 stime=3D1623034479
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
tag=3Dfutex_cmp_requeue02 stime=3D1623034479
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
tag=3Dmemfd_create04 stime=3D1623034479
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
tag=3Dstatx06 stime=3D1623034479
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
cutime=3D0 cstime=3D3
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20210121-363-g9dcbf4e96

       ###############################################################

            Done executing testcases.
            LTP Version:  20210121-363-g9dcbf4e96
       ###############################################################


--PuGuTyElPB9bOcsM
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
submit_id: 60bd72757727ff59ae80b598
job_file: "/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-7463fff0372f733229a9384f509943357e4e5caf-20210607-22958-63uss3-0.yaml"
id: e6149435a2bbdcf9c9703f3576cc06439b01e346
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
commit: 7463fff0372f733229a9384f509943357e4e5caf

#! include/testbox/lkp-skl-d02
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
- CONFIG_DRM_I915
ucode: '0xe2'

#! include/fs/OTHERS
enqueue_time: 2021-06-07 09:12:22.469055189 +08:00
_id: 60bd72757727ff59ae80b598
_rt: "/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: cec913fe690e09abc77f7f0dd9f560a94e5391c5
base_commit: 8124c8a6b35386f73523d27eacb71b5364a68c4c
branch: linux-devel/devel-hourly-20210606-085218
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/0"
scheduler_version: "/lkp/lkp/.src-20210604-065253"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-syscalls-04-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-7463fff0372f733229a9384f509943357e4e5caf-20210607-22958-63uss3-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210606-085218
- commit=7463fff0372f733229a9384f509943357e4e5caf
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/vmlinuz-5.13.0-rc4-00013-g7463fff0372f
- max_uptime=2100
- RESULT_ROOT=/result/ltp/1HDD-f2fs-syscalls-04-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210522.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210522.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210604-065253/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 4.20.0

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/7463fff0372f733229a9384f509943357e4e5caf/vmlinuz-5.13.0-rc4-00013-g7463fff0372f"
dequeue_time: 2021-06-07 10:05:03.946026845 +08:00
job_state: finished
loadavg: 1.47 0.89 0.37 1/206 1769
start_time: '1623031567'
end_time: '1623031743'
version: "/lkp/lkp/.src-20210604-065325:2133b04b-dirty:10c9d103e"

--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sda1
mkfs -t f2fs /dev/sda1
mkdir -p /fs/sda1
mount -t f2fs /dev/sda1 /fs/sda1
ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
./runltp -f syscalls-04 -d /fs/sda1/tmpdir

--PuGuTyElPB9bOcsM--
