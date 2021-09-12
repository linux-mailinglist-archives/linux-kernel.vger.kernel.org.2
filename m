Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976F4407D31
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 14:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhILMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 08:18:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:55945 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234934AbhILMSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 08:18:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10104"; a="200956131"
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="xz'?yaml'?scan'208";a="200956131"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 05:17:18 -0700
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="xz'?yaml'?scan'208";a="542326988"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 05:17:12 -0700
Date:   Sun, 12 Sep 2021 20:34:29 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Chi Wu <wuchi.zero@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, Jens Axboe <axboe@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ltp@lists.linux.it
Subject: [mm/page]  ab19939a6a: ltp.msync04.fail
Message-ID: <20210912123429.GA25450@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: ab19939a6a5010cba4e9cb04dd8bee03c72edcbd ("mm/page-writeback: Fix p=
erformance when BDI's share of ratio is 0.")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: ltp
version: ltp-x86_64-14c1f76-1_20210907
with following parameters:

	disk: 1HDD
	fs: xfs
	test: syscalls-03
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

2021-09-10 04:45:22 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-09-10 04:45:22 ./runltp -f syscalls-03 -d /fs/sda1/tmpdir
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
Linux lkp-skl-d02 5.13.0-00043-gab19939a6a50 #1 SMP Thu Sep 9 02:30:48 CST =
2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-03-ucode=3D0xe2-debian-10.4-x86_64-=
20200603.cgz-ab19939a6a5010cba4e9cb04dd8bee03c72edcbd-20210910-74453-188pg5=
j-8.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinus/master comm=
it=3Dab19939a6a5010cba4e9cb04dd8bee03c72edcbd BOOT_IMAGE=3D/pkg/linux/x86_6=
4-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/vmlinuz-5.13.0-00=
043-gab19939a6a50 max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1HDD-xfs-sysc=
alls-03-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhe=
l-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/27 LKP_SERVER=3Dintern=
al-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enabled r=
cupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don pan=
ic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=
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
Modules Loaded         dm_mod xfs libcrc32c ipmi_devintf ipmi_msghandler sd=
_mod t10_pi sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_=
powerclamp coretemp i915 kvm_intel kvm intel_gtt drm_kms_helper syscopyarea=
 irqbypass mei_wdt sysfillrect crct10dif_pclmul sysimgblt crc32_pclmul fb_s=
ys_fops ahci crc32c_intel ghash_clmulni_intel libahci mei_me wmi_bmof drm r=
apl mei intel_cstate intel_pch_thermal libata intel_uncore wmi video intel_=
pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32753716      299200    29831728       21804     2622788    2959=
7568
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
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2619     -n 2619 -=
p -f /fs/sda1/tmpdir/ltp-vnAWy9vVxl/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_09_10-04h_45m_22s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_09_10-04h_45m_22s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_09_10-04h_45m_22s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_09_10-04h_45m_22s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_09_10-04h_4=
5m_22s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_09_10-04h_45=
m_22s.tconf
Running tests.......
<<<test_start>>>
tag=3Dadd_key01 stime=3D1631249122
cmdline=3D"add_key01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
add_key01.c:63: TINFO: The key type is keyrings and plen is 0
add_key01.c:79: TPASS: add_key call succeeded as expected
add_key01.c:63: TINFO: the key type is keyrings and plen is 1
add_key01.c:83: TPASS: add_key call failed as expected: EINVAL (22)
add_key01.c:63: TINFO: The key type is user and plen is 32767
add_key01.c:79: TPASS: add_key call succeeded as expected
add_key01.c:63: TINFO: The key type is user and plen is 32768
add_key01.c:83: TPASS: add_key call failed as expected: EINVAL (22)
add_key01.c:63: TINFO: The key type is logon and plen is 32767
add_key01.c:79: TPASS: add_key call succeeded as expected
add_key01.c:63: TINFO: The key type is logon and plen is 32768
add_key01.c:83: TPASS: add_key call failed as expected: EINVAL (22)
add_key01.c:63: TINFO: The key type is big_key and plen is 1048575
add_key01.c:70: TCONF: skipping unsupported big_key key
add_key01.c:63: TINFO: The key type is big_key and plen is 1048576
add_key01.c:70: TCONF: skipping unsupported big_key key

Summary:
passed   6
failed   0
broken   0
skipped  2
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dalarm07 stime=3D1631249122
cmdline=3D"alarm07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
alarm07.c:43: TPASS: Got 1 sigalarm in parent
alarm07.c:32: TPASS: alarm() request cleared in child

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dbpf_map01 stime=3D1631249125
cmdline=3D"bpf_map01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
bpf_common.c:17: TINFO: Raising RLIMIT_MEMLOCK to 2162688
bpf_map01.c:53: TPASS: Created hash map
bpf_map01.c:70: TPASS: Empty hash map lookup: ENOENT (2)
bpf_map01.c:104: TPASS: Update hash map element
bpf_map01.c:122: TPASS: hash map lookup
bpf_map01.c:53: TPASS: Created array map
bpf_map01.c:104: TPASS: Update array map element
bpf_map01.c:122: TPASS: array map lookup

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
tag=3Dbpf_prog02 stime=3D1631249125
cmdline=3D"bpf_prog02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
bpf_common.c:17: TINFO: Raising RLIMIT_MEMLOCK to 2162688
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
bpf_common.c:114: TPASS: Loaded program
bpf_prog02.c:93: TPASS: val =3D 1152921504606846976 + 1
bpf_prog02.c:103: TPASS: val =3D 1152921504606846976 - 1

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
tag=3Dbrk02 stime=3D1631249125
cmdline=3D"brk02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
brk02.c:55: TPASS: munmap at least two VMAs of brk() passed

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
tag=3Dcapget02 stime=3D1631249125
cmdline=3D"capget02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
capget02.c:59: TPASS: capget() with bad address header : EFAULT (14)
capget02.c:59: TPASS: capget() with bad address data : EFAULT (14)
capget02.c:59: TPASS: capget() with bad version : EINVAL (22)
capget02.c:59: TPASS: capget() with bad pid : EINVAL (22)
capget02.c:59: TPASS: capget() with unused pid : ESRCH (3)

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
tag=3Dcapset03 stime=3D1631249125
cmdline=3D"capset03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
capset03.c:24: TINFO: Test bad value data(when pI is not old pP or old pI w=
ithout CAP_SETPCAP)
capset03.c:26: TPASS: capset() : EPERM (1)

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
tag=3Dchown02 stime=3D1631249125
cmdline=3D"chown02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
chown02.c:46: TPASS: chown(testfile2, 0, 0) passed

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
tag=3Dchown04 stime=3D1631249125
cmdline=3D"chown04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
chown04.c:78: TPASS: chown() without permissions : EPERM (1)
chown04.c:78: TPASS: chown() without full permissions of the path prefix : =
EACCES (13)
chown04.c:78: TPASS: chown() with unaccessible pathname points : EFAULT (14)
chown04.c:78: TPASS: chown() when pathname is too long : ENAMETOOLONG (36)
chown04.c:78: TPASS: chown() when file does not exist : ENOENT (2)
chown04.c:78: TPASS: chown() when the path prefix is not a directory : ENOT=
DIR (20)
chown04.c:78: TPASS: chown() with too many symbolic links : ELOOP (40)
chown04.c:78: TPASS: chown() when the named file resides on a read-only fil=
esystem : EROFS (30)

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
tag=3Dclock_nanosleep04 stime=3D1631249125
cmdline=3D"clock_nanosleep04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep04.c:33: TINFO: Testing variant: vDSO or syscall with libc s=
pec
clock_nanosleep04.c:58: TPASS: clock_nanosleep(2) passed for clock CLOCK_MO=
NOTONIC
clock_nanosleep04.c:58: TPASS: clock_nanosleep(2) passed for clock CLOCK_RE=
ALTIME
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep04.c:33: TINFO: Testing variant: syscall with old kernel spec
clock_nanosleep04.c:58: TPASS: clock_nanosleep(2) passed for clock CLOCK_MO=
NOTONIC
clock_nanosleep04.c:58: TPASS: clock_nanosleep(2) passed for clock CLOCK_RE=
ALTIME

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
tag=3Dclose02 stime=3D1631249125
cmdline=3D"close02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
close02.c:20: TPASS: close(-1) : EBADF (9)

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
tag=3Dcreat03 stime=3D1631249125
cmdline=3D"creat03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
creat03.c:36: TINFO: Created file has mode =3D 0100674
creat03.c:41: TPASS: save text bit cleared

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
tag=3Dcreat05 stime=3D1631249125
cmdline=3D"creat05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
creat05.c:49: TINFO: getdtablesize() =3D 1024
creat05.c:59: TINFO: Opened additional #1020 fds
creat05.c:36: TPASS: creat() failed with EMFILE

Summary:
passed   1
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
tag=3Dcreat09 stime=3D1631249125
cmdline=3D"creat09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
creat09.c:55: TINFO: User nobody: uid =3D 65534, gid =3D 65534
creat09.c:56: TINFO: Found unused GID 11: SUCCESS (0)
creat09.c:87: TPASS: testdir/creat.tmp: Owned by correct group
creat09.c:93: TPASS: testdir/creat.tmp: Setgid bit not set
creat09.c:87: TPASS: testdir/open.tmp: Owned by correct group
creat09.c:93: TPASS: testdir/open.tmp: Setgid bit not set

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
tag=3Depoll_ctl03 stime=3D1631249125
cmdline=3D"epoll_ctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201f passed

Summary:
passed   256
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Depoll_ctl05 stime=3D1631249125
cmdline=3D"epoll_ctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
epoll_ctl05.c:64: TPASS: epoll_clt(..., EPOLL_CTL_ADD, ...) : ELOOP (40)

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
tag=3Depoll_wait04 stime=3D1631249125
cmdline=3D"epoll_wait04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
epoll_wait04.c:35: TPASS: epoll_wait() returns immediately with a timeout e=
qual to zero

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
tag=3Deventfd01 stime=3D1631249125
cmdline=3D"eventfd01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
eventfd01    1  TPASS  :  counter value matches required
eventfd01    2  TPASS  :  read failed with EAGAIN as expected
eventfd01    3  TPASS  :  counter value matches required
eventfd01    4  TPASS  :  write failed with EAGAIN as expected
eventfd01    5  TPASS  :  read failed with EINVAL as expected
eventfd01    6  TPASS  :  write failed with EINVAL as expected
eventfd01    7  TPASS  :  write failed with EINVAL as expected
eventfd01    8  TPASS  :  fd is set in readfds
eventfd01    9  TPASS  :  fd is not set in readfds
eventfd01   10  TPASS  :  fd is set in writefds
eventfd01   11  TPASS  :  fd is not set in writefds
eventfd01    1  TPASS  :  counter value matches required
eventfd01    2  TPASS  :  read failed with EAGAIN as expected
eventfd01    3  TPASS  :  counter value matches required
eventfd01    4  TPASS  :  write failed with EAGAIN as expected
eventfd01    5  TPASS  :  read failed with EINVAL as expected
eventfd01    6  TPASS  :  write failed with EINVAL as expected
eventfd01    7  TPASS  :  write failed with EINVAL as expected
eventfd01    8  TPASS  :  fd is set in readfds
eventfd01    9  TPASS  :  fd is not set in readfds
eventfd01   10  TPASS  :  fd is set in writefds
eventfd01   11  TPASS  :  fd is not set in writefds
eventfd01   12  TPASS  :  counter value write from child successful
eventfd01   13  TPASS  :  read fd set as expected
eventfd01   14  TPASS  :  POLLERR occurred as expected
eventfd01   15  TPASS  :  overflow occurred as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexecve02 stime=3D1631249126
cmdline=3D"execve02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
execve02.c:54: TPASS: execve() failed expectedly: EACCES (13)

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
tag=3Dexecveat03 stime=3D1631249126
cmdline=3D"execveat03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
execveat_child.c:17: TPASS: execveat_child run as expected

Summary:
passed   1
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
tag=3Dexit_group01 stime=3D1631249126
cmdline=3D"exit_group01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
exit_group01    1  TPASS  :  exit_group() succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfallocate01 stime=3D1631249126
cmdline=3D"fallocate01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fallocate01    1  TPASS  :  fallocate(4, 0, 49152, 4096) returned 0
fallocate01    2  TPASS  :  write operation on fallocated(4, 0, 49152, 4096=
) returned 1
fallocate01    3  TPASS  :  fallocate(5, 1, 49152, 4096) returned 0
fallocate01    4  TPASS  :  write operation on fallocated(5, 1, 49152, 4096=
) returned 1
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfallocate02 stime=3D1631249126
cmdline=3D"fallocate02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fallocate02    1  TPASS  :  fallocate(test_file1:4, 1, 0, 1024) returned 9:=
 TEST_ERRNO=3DEBADF(9): Bad file descriptor
fallocate02    2  TPASS  :  fallocate(test_file2:5, 1, -1024, 1024) returne=
d 22: TEST_ERRNO=3DEINVAL(22): Invalid argument
fallocate02    3  TPASS  :  fallocate(test_file2:5, 1, 1024, -1024) returne=
d 22: TEST_ERRNO=3DEINVAL(22): Invalid argument
fallocate02    4  TPASS  :  fallocate(test_file2:5, 1, 12288, 0) returned 2=
2: TEST_ERRNO=3DEINVAL(22): Invalid argument
fallocate02    5  TPASS  :  fallocate(test_file2:5, 1, 12288, -1024) return=
ed 22: TEST_ERRNO=3DEINVAL(22): Invalid argument
fallocate02    6  TPASS  :  fallocate(test_file2:5, 1, -24576, 1024) return=
ed 22: TEST_ERRNO=3DEINVAL(22): Invalid argument
fallocate02    7  TPASS  :  fallocate(test_file2:5, 1, 9223372036854774784,=
 1024) returned 27: TEST_ERRNO=3DEFBIG(27): File too large
fallocate02    8  TPASS  :  fallocate(test_file2:5, 1, 1024, 92233720368547=
74784) returned 27: TEST_ERRNO=3DEFBIG(27): File too large
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfallocate04 stime=3D1631249126
cmdline=3D"fallocate04"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '3072' bytes
fallocate04.c:86: TCONF: fallocate() not supported
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '3072' bytes
fallocate04.c:86: TCONF: fallocate() not supported
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '3072' bytes
fallocate04.c:96: TPASS: test-case succeeded
fallocate04.c:103: TINFO: read allocated file size '3072'
fallocate04.c:104: TINFO: make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04.c:120: TINFO: check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04.c:137: TINFO: found a hole at '1024' offset
fallocate04.c:143: TINFO: allocated file size before '3072' and after '2048'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:154: TPASS: test-case succeeded
fallocate04.c:159: TINFO: zeroing file space with FALLOC_FL_ZERO_RANGE
fallocate04.c:168: TINFO: read current allocated file size '2048'
fallocate04.c:185: TINFO: allocated file size before '2048' and after '3072'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:196: TPASS: test-case succeeded
fallocate04.c:201: TINFO: collapsing file space with FALLOC_FL_COLLAPSE_RAN=
GE
fallocate04.c:205: TINFO: read current allocated file size '3072'
fallocate04.c:219: TINFO: allocated file size before '3072' and after '2048'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:236: TPASS: test-case succeeded
fallocate04.c:241: TINFO: inserting space with FALLOC_FL_INSERT_RANGE
fallocate04.c:245: TINFO: read current allocated file size '2048'
fallocate04.c:263: TINFO: allocated file size before '2048' and after '3072'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:274: TPASS: test-case succeeded
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '12288' bytes
fallocate04.c:96: TPASS: test-case succeeded
fallocate04.c:103: TINFO: read allocated file size '12288'
fallocate04.c:104: TINFO: make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04.c:120: TINFO: check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04.c:137: TINFO: found a hole at '4096' offset
fallocate04.c:143: TINFO: allocated file size before '12288' and after '819=
2'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:154: TPASS: test-case succeeded
fallocate04.c:159: TINFO: zeroing file space with FALLOC_FL_ZERO_RANGE
fallocate04.c:168: TINFO: read current allocated file size '8192'
fallocate04.c:185: TINFO: allocated file size before '8192' and after '1228=
8'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:196: TPASS: test-case succeeded
fallocate04.c:201: TINFO: collapsing file space with FALLOC_FL_COLLAPSE_RAN=
GE
fallocate04.c:205: TINFO: read current allocated file size '12288'
fallocate04.c:219: TINFO: allocated file size before '12288' and after '819=
2'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:236: TPASS: test-case succeeded
fallocate04.c:241: TINFO: inserting space with FALLOC_FL_INSERT_RANGE
fallocate04.c:245: TINFO: read current allocated file size '8192'
fallocate04.c:263: TINFO: allocated file size before '8192' and after '1228=
8'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:274: TPASS: test-case succeeded
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '12288' bytes
fallocate04.c:96: TPASS: test-case succeeded
fallocate04.c:103: TINFO: read allocated file size '12288'
fallocate04.c:104: TINFO: make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04.c:120: TINFO: check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04.c:137: TINFO: found a hole at '4096' offset
fallocate04.c:143: TINFO: allocated file size before '12288' and after '819=
2'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:154: TPASS: test-case succeeded
fallocate04.c:159: TINFO: zeroing file space with FALLOC_FL_ZERO_RANGE
fallocate04.c:168: TINFO: read current allocated file size '8192'
fallocate04.c:185: TINFO: allocated file size before '8192' and after '1228=
8'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:196: TPASS: test-case succeeded
fallocate04.c:201: TINFO: collapsing file space with FALLOC_FL_COLLAPSE_RAN=
GE
fallocate04.c:205: TINFO: read current allocated file size '12288'
fallocate04.c:211: TCONF: FALLOC_FL_COLLAPSE_RANGE not supported
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '12288' bytes
fallocate04.c:96: TPASS: test-case succeeded
fallocate04.c:103: TINFO: read allocated file size '12288'
fallocate04.c:104: TINFO: make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04.c:115: TCONF: FALLOC_FL_PUNCH_HOLE not supported
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '12288' bytes
fallocate04.c:86: TCONF: fallocate() not supported
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '12288' bytes
fallocate04.c:96: TPASS: test-case succeeded
fallocate04.c:103: TINFO: read allocated file size '12288'
fallocate04.c:104: TINFO: make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04.c:120: TINFO: check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04.c:137: TINFO: found a hole at '4096' offset
fallocate04.c:143: TINFO: allocated file size before '12288' and after '819=
2'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:154: TPASS: test-case succeeded
fallocate04.c:159: TINFO: zeroing file space with FALLOC_FL_ZERO_RANGE
fallocate04.c:168: TINFO: read current allocated file size '8192'
fallocate04.c:174: TCONF: FALLOC_FL_ZERO_RANGE not supported

Summary:
passed   16
failed   0
broken   0
skipped  6
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D8 cstime=3D89
<<<test_end>>>
<<<test_start>>>
tag=3Dposix_fadvise03_64 stime=3D1631249132
cmdline=3D"posix_fadvise03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 0
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 1
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 2
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 3
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 4
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 5
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 6 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 7 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 8 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 9 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 10 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 11 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 12 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 13 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 14 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 15 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 16 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 17 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 18 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 19 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 20 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 21 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 22 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 23 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 24 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 25 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 26 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 27 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 28 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 29 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 30 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 31 : EINVAL

Summary:
passed   32
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
tag=3Dposix_fadvise04 stime=3D1631249132
cmdline=3D"posix_fadvise04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE

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
tag=3Dfchown01_16 stime=3D1631249132
cmdline=3D"fchown01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/fchown/../utils/compat_tst_1=
6.h:143: TCONF: 16-bit version of fchown() is not supported on your platform

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
tag=3Dfchown02_16 stime=3D1631249132
cmdline=3D"fchown02_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/fchown/../utils/compat_tst_1=
6.h:143: TCONF: 16-bit version of fchown() is not supported on your platform

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
tag=3Dfcntl02 stime=3D1631249132
cmdline=3D"fcntl02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 0) returned 5
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 1) returned 5
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 2) returned 5
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 3) returned 5
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 10) returned 10
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 100) returned 100

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
tag=3Dfcntl03_64 stime=3D1631249132
cmdline=3D"fcntl03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fcntl03.c:33: TPASS: fcntl(fcntl03_2938, F_GETFD, 0) returned 0

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
tag=3Dfcntl04 stime=3D1631249132
cmdline=3D"fcntl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fcntl04.c:39: TPASS: fcntl(fcntl04_2940, F_GETFL, 0) returned 8002

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
tag=3Dfcntl08 stime=3D1631249132
cmdline=3D"fcntl08"
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
tag=3Dfcntl13 stime=3D1631249132
cmdline=3D"fcntl13"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl13     1  TPASS  :  got EINVAL
fcntl13     2  TPASS  :  F_SETLK: got EFAULT
fcntl13     3  TPASS  :  F_SETLKW: got EFAULT
fcntl13     4  TPASS  :  F_GETLK: got EFAULT
fcntl13     5  TPASS  :  got EINVAL
fcntl13     6  TPASS  :  got EBADFD
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl15 stime=3D1631249132
cmdline=3D"fcntl15"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl15     1  TPASS  :  Test 1: test with "dup" PASSED
fcntl15     0  TINFO  :  Failed to record test working dir
fcntl15     2  TPASS  :  Test 2: test with "open" PASSED
fcntl15     0  TINFO  :  Failed to record test working dir
fcntl15     3  TPASS  :  Test 3: test with "fork" PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D10 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl17_64 stime=3D1631249142
cmdline=3D"fcntl17_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl17     0  TINFO  :  Enter preparation phase
fcntl17     0  TINFO  :  child 1 starting
fcntl17     0  TINFO  :  child 1 pid 2982 locked
fcntl17     0  TINFO  :  child 1 resuming
fcntl17     0  TINFO  :  child 1 unlocked
fcntl17     0  TINFO  :  child 1 exiting
fcntl17     0  TINFO  :  child 3 starting
fcntl17     0  TINFO  :  child 3 pid 2984 locked
fcntl17     0  TINFO  :  child 3 resuming
fcntl17     0  TINFO  :  child 3 lockw err 35
fcntl17     0  TINFO  :  child 3 exiting
fcntl17     0  TINFO  :  child 2 starting
fcntl17     0  TINFO  :  child 2 pid 2983 locked
fcntl17     0  TINFO  :  child 2 resuming
fcntl17     0  TINFO  :  child 2 lockw locked
fcntl17     0  TINFO  :  child 2 exiting
fcntl17     0  TINFO  :  Exit preparation phase
fcntl17     0  TINFO  :  Enter block 1
fcntl17     1  TPASS  :  Block 1 PASSED
fcntl17     0  TINFO  :  Exit block 1
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl19 stime=3D1631249142
cmdline=3D"fcntl19"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl19     0  TINFO  :  Enter block 1
fcntl19     0  TINFO  :  Test block 1: PASSED
fcntl19     0  TINFO  :  Exit block 1
fcntl19     0  TINFO  :  Enter block 2
fcntl19     0  TINFO  :  Test block 2: PASSED
fcntl19     0  TINFO  :  Exit block 2
fcntl19     0  TINFO  :  Enter block 3
fcntl19     0  TINFO  :  Test block 3: PASSED
fcntl19     0  TINFO  :  Exit block 3
fcntl19     0  TINFO  :  Enter blcok 4
fcntl19     0  TINFO  :  Test block 4: PASSED
fcntl19     0  TINFO  :  Exit block 4
fcntl19     0  TINFO  :  Enter block 5
fcntl19     0  TINFO  :  Test block 5: PASSED
fcntl19     0  TINFO  :  Exit block 5
fcntl19     0  TINFO  :  Enter block 6
fcntl19     0  TINFO  :  Test block 6: PASSED
fcntl19     0  TINFO  :  Exit block 6
fcntl19     0  TINFO  :  Enter block 7
fcntl19     0  TINFO  :  Test block 7: PASSED
fcntl19     0  TINFO  :  Exit block 7
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl20 stime=3D1631249142
cmdline=3D"fcntl20"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl20     0  TINFO  :  Enter block 1
fcntl20     0  TINFO  :  Test block 1: PASSED
fcntl20     0  TINFO  :  Exit block 1
fcntl20     0  TINFO  :  Enter block 2
fcntl20     0  TINFO  :  Test block 2: PASSED
fcntl20     0  TINFO  :  Exit block 2
fcntl20     0  TINFO  :  Enter block 3
fcntl20     0  TINFO  :  Test block 3: PASSED
fcntl20     0  TINFO  :  Exit block 3
fcntl20     0  TINFO  :  Enter blcok 4
fcntl20     0  TINFO  :  Test block 4: PASSED
fcntl20     0  TINFO  :  Exit block 4
fcntl20     0  TINFO  :  Enter block 5
fcntl20     0  TINFO  :  Test block 5: PASSED
fcntl20     0  TINFO  :  Exit block 5
fcntl20     0  TINFO  :  Enter block 6
fcntl20     0  TINFO  :  Test block 6: PASSED
fcntl20     0  TINFO  :  Exit block 6
fcntl20     0  TINFO  :  Enter block 7
fcntl20     0  TINFO  :  Test block 7: PASSED
fcntl20     0  TINFO  :  Exit block 7
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl20_64 stime=3D1631249142
cmdline=3D"fcntl20_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl20     0  TINFO  :  Enter block 1
fcntl20     0  TINFO  :  Test block 1: PASSED
fcntl20     0  TINFO  :  Exit block 1
fcntl20     0  TINFO  :  Enter block 2
fcntl20     0  TINFO  :  Test block 2: PASSED
fcntl20     0  TINFO  :  Exit block 2
fcntl20     0  TINFO  :  Enter block 3
fcntl20     0  TINFO  :  Test block 3: PASSED
fcntl20     0  TINFO  :  Exit block 3
fcntl20     0  TINFO  :  Enter blcok 4
fcntl20     0  TINFO  :  Test block 4: PASSED
fcntl20     0  TINFO  :  Exit block 4
fcntl20     0  TINFO  :  Enter block 5
fcntl20     0  TINFO  :  Test block 5: PASSED
fcntl20     0  TINFO  :  Exit block 5
fcntl20     0  TINFO  :  Enter block 6
fcntl20     0  TINFO  :  Test block 6: PASSED
fcntl20     0  TINFO  :  Exit block 6
fcntl20     0  TINFO  :  Enter block 7
fcntl20     0  TINFO  :  Test block 7: PASSED
fcntl20     0  TINFO  :  Exit block 7
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl26 stime=3D1631249142
cmdline=3D"fcntl26"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl26     1  TPASS  :  fcntl(tfile_2991, F_SETLEASE, F_WRLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl28_64 stime=3D1631249142
cmdline=3D"fcntl28_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl28     1  TPASS  :  fcntl(fd, F_SETLEASE, F_RDLCK) succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl31 stime=3D1631249142
cmdline=3D"fcntl31"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     1  TPASS  :  fcntl test F_GETOWN, F_SETOWN for process ID succe=
ss
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     2  TPASS  :  fcntl test F_GETOWN, F_SETOWN for process group ID=
 success
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     3  TPASS  :  fcntl test F_GETOWN_EX, F_SETOWN_EX for thread ID =
success
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     4  TPASS  :  fcntl test F_GETOWN_EX, F_SETOWN_EX for process ID=
 success
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     5  TPASS  :  fcntl test F_GETOWN_EX, F_SETOWN_EX for process gr=
oup ID success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl34_64 stime=3D1631249142
cmdline=3D"fcntl34_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fcntl34.c:90: TINFO: write to a file inside threads with OFD locks
fcntl34.c:36: TINFO: spawning '12' threads
fcntl34.c:45: TINFO: waiting for '12' threads
fcntl34.c:99: TINFO: verifying file's data
fcntl34.c:127: TPASS: OFD locks synchronized access between threads

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
tag=3Dfcntl37 stime=3D1631249142
cmdline=3D"fcntl37"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dfgetxattr01 stime=3D1631249142
cmdline=3D"fgetxattr01"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:122: TCONF: no xattr support in fs or mounted without user_xa=
ttr option
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:122: TCONF: no xattr support in fs or mounted without user_xa=
ttr option

Summary:
passed   30
failed   0
broken   0
skipped  2
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D9 cstime=3D89
<<<test_end>>>
<<<test_start>>>
tag=3Dfgetxattr02 stime=3D1631249146
cmdline=3D"fgetxattr02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr02.c:174: TPASS: fgetxattr(2) on testfile passed
fgetxattr02.c:188: TPASS: fgetxattr(2) on testfile got the right value
fgetxattr02.c:201: TPASS: fgetxattr(2) on testfile passed: SUCCESS (0)
fgetxattr02.c:174: TPASS: fgetxattr(2) on testdir passed
fgetxattr02.c:188: TPASS: fgetxattr(2) on testdir got the right value
fgetxattr02.c:201: TPASS: fgetxattr(2) on testdir passed: SUCCESS (0)
fgetxattr02.c:174: TPASS: fgetxattr(2) on symlink passed
fgetxattr02.c:188: TPASS: fgetxattr(2) on symlink got the right value
fgetxattr02.c:201: TPASS: fgetxattr(2) on symlink passed: SUCCESS (0)
fgetxattr02.c:201: TPASS: fgetxattr(2) on fifo passed: ENODATA (61)
fgetxattr02.c:201: TPASS: fgetxattr(2) on chr passed: ENODATA (61)
fgetxattr02.c:201: TPASS: fgetxattr(2) on blk passed: ENODATA (61)
fgetxattr02.c:201: TPASS: fgetxattr(2) on sock passed: ENODATA (61)

Summary:
passed   13
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
tag=3Dfork02 stime=3D1631249146
cmdline=3D"fork02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork02      0  TINFO  :  Inside parent
fork02      0  TINFO  :  exit status of wait 0
fork02      1  TPASS  :  test 1 PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork03 stime=3D1631249146
cmdline=3D"fork03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork03      0  TINFO  :  process id in parent of child from fork : 3125
fork03      1  TPASS  :  test 1 PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork14 stime=3D1631249146
cmdline=3D"fork14"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork14      1  TPASS  :  fork failed as expected.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D4 cstime=3D25
<<<test_end>>>
<<<test_start>>>
tag=3Dfpathconf01 stime=3D1631249147
cmdline=3D"fpathconf01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fpathconf01    1  TPASS  :  fpathconf(fd, _PC_MAX_CANON) returned 255
fpathconf01    2  TPASS  :  fpathconf(fd, _PC_MAX_INPUT) returned 255
fpathconf01    3  TPASS  :  fpathconf(fd, _PC_VDISABLE) returned 0
fpathconf01    4  TPASS  :  fpathconf(fd, _PC_LINK_MAX) returned 2147483647
fpathconf01    5  TPASS  :  fpathconf(fd, _PC_NAME_MAX) returned 255
fpathconf01    6  TPASS  :  fpathconf(fd, _PC_PATH_MAX) returned 4096
fpathconf01    7  TPASS  :  fpathconf(fd, _PC_PIPE_BUF) returned 4096
fpathconf01    8  TPASS  :  fpathconf(fd, _PC_CHOWN_RESTRICTED) returned 1
fpathconf01    9  TPASS  :  fpathconf(fd, _PC_NO_TRUNC) returned 1
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetdtablesize01 stime=3D1631249147
cmdline=3D"getdtablesize01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getdtablesize01    0  TINFO  :  Maximum number of files a process can have =
opened is 1024
getdtablesize01    0  TINFO  :  Checking with the value returned by getrlim=
it...RLIMIT_NOFILE
getdtablesize01    1  TPASS  :  got correct dtablesize, value is 1024
getdtablesize01    0  TINFO  :  Checking Max num of files that can be opene=
d by a process.Should be: RLIMIT_NOFILE - 1
getdtablesize01    2  TPASS  :  1023 =3D 1023
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dgetegid02 stime=3D1631249147
cmdline=3D"getegid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getegid02    1  TPASS  :  effective group id 0 is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgethostbyname_r01 stime=3D1631249147
cmdline=3D"gethostbyname_r01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
gethostbyname_r01    1  TPASS  :  not vulnerable
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetpgid01 stime=3D1631249147
cmdline=3D"getpgid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getpgid01    1  TPASS  :  getpgid(0) PASSED
getpgid01    2  TPASS  :  getpgid(getpid()) PASSED
getpgid01    3  TPASS  :  getpgid(getppid()) PASSED
getpgid01    4  TPASS  :  getpgid(3162) PASSED
getpgid01    5  TPASS  :  getpgid(1) PASSED
getpgid01    1  TPASS  :  getpgid01 PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetppid01 stime=3D1631249147
cmdline=3D"getppid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
getppid01.c:25: TPASS: getppid() returned 3164

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
tag=3Dgetpriority01 stime=3D1631249147
cmdline=3D"getpriority01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
getpriority01.c:50: TPASS: getpriority(0, 0) returned 0
getpriority01.c:50: TPASS: getpriority(1, 0) returned 0
getpriority01.c:50: TPASS: getpriority(2, 0) returned -20

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
tag=3Dgetresgid01 stime=3D1631249147
cmdline=3D"getresgid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresgid01    1  TPASS  :  Functionality of getresgid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresgid01_16 stime=3D1631249147
cmdline=3D"getresgid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresgid01    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresgid/../utils/compat_16.h:151: 16-bit version of getresgid() is not su=
pported on your platform
getresgid01    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresgid/../utils/compat_16.h:151: Remaining cases not appropriate for con=
figuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresgid02 stime=3D1631249147
cmdline=3D"getresgid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresgid02    1  TPASS  :  Functionality of getresgid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresuid01_16 stime=3D1631249147
cmdline=3D"getresuid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid01    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresuid/../utils/compat_16.h:141: 16-bit version of getresuid() is not su=
pported on your platform
getresuid01    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresuid/../utils/compat_16.h:141: Remaining cases not appropriate for con=
figuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetrusage03 stime=3D1631249147
cmdline=3D"getrusage03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
getrusage03.c:43: TPASS: initial.self ~=3D child.self
getrusage03.c:57: TPASS: initial.children ~=3D 100MB
getrusage03.c:66: TPASS: child.children =3D=3D 0
getrusage03.c:84: TPASS: child.children ~=3D 300MB
getrusage03.c:104: TPASS: initial.children ~=3D pre_wait.children
getrusage03.c:112: TPASS: post_wait.children ~=3D 400MB
getrusage03.c:133: TPASS: initial.children ~=3D after_zombie.children
getrusage03_child.c:57: TPASS: initial.self ~=3D exec.self
getrusage03_child.c:62: TPASS: initial.children ~=3D exec.children

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D4 cstime=3D11
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsockopt01 stime=3D1631249147
cmdline=3D"getsockopt01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getsockopt01    1  TPASS  :  bad file descriptor successful
getsockopt01    2  TPASS  :  bad file descriptor successful
getsockopt01    3  TPASS  :  invalid option buffer successful
getsockopt01    4  TPASS  :  invalid optlen successful
getsockopt01    5  TPASS  :  invalid level successful
getsockopt01    6  TPASS  :  invalid option name successful
getsockopt01    7  TPASS  :  invalid option name (UDP) successful
getsockopt01    8  TPASS  :  invalid option name (IP) successful
getsockopt01    9  TPASS  :  invalid option name (TCP) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetuid03 stime=3D1631249147
cmdline=3D"getuid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getuid03    1  TPASS  :  values from getuid and getpwuid match
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl03 stime=3D1631249147
cmdline=3D"ioctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
ioctl03.c:76: TINFO: Available features are: 0x7133
ioctl03.c:81: TPASS: TUN 0x1
ioctl03.c:81: TPASS: TAP 0x2
ioctl03.c:81: TPASS: NO_PI 0x1000
ioctl03.c:81: TPASS: ONE_QUEUE 0x2000
ioctl03.c:81: TPASS: VNET_HDR 0x4000
ioctl03.c:81: TPASS: MULTI_QUEUE 0x100
ioctl03.c:81: TPASS: IFF_NAPI 0x10
ioctl03.c:81: TPASS: IFF_NAPI_FRAGS 0x20

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
tag=3Dioctl05 stime=3D1631249147
cmdline=3D"ioctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
ioctl05.c:35: TPASS: BLKGETSIZE returned 524288, BLKGETSIZE64 268435456
ioctl05.c:46: TPASS: Could lseek to the end of the device
ioctl05.c:53: TPASS: Got EOF when trying to read after the end of device

Summary:
passed   3
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
tag=3Dioctl09 stime=3D1631249147
cmdline=3D"ioctl09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
ioctl09.c:45: TPASS: access /sys/block/loop0/loop0p1 succeeds
ioctl09.c:53: TPASS: access /dev/loop0p1 succeeds
ioctl09.c:48: TPASS: access /sys/block/loop0/loop0p2 fails
ioctl09.c:56: TPASS: access /dev/loop0p2 fails
ioctl09.c:45: TPASS: access /sys/block/loop0/loop0p1 succeeds
ioctl09.c:53: TPASS: access /dev/loop0p1 succeeds
ioctl09.c:45: TPASS: access /sys/block/loop0/loop0p2 succeeds
ioctl09.c:53: TPASS: access /dev/loop0p2 succeeds

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D10
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_loop04 stime=3D1631249147
cmdline=3D"ioctl_loop04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
ioctl_loop04.c:35: TPASS: /sys/block/loop0/size =3D 20
ioctl_loop04.c:50: TPASS: LOOP_SET_CAPACITY set loop size to 5120
ioctl_loop04.c:56: TPASS: /sys/block/loop0/size =3D 10

Summary:
passed   3
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
tag=3Dioctl_ns07 stime=3D1631249148
cmdline=3D"ioctl_ns07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
ioctl_ns07.c:33: TPASS: request failed with ENOTTY
ioctl_ns07.c:33: TPASS: request failed with ENOTTY
ioctl_ns07.c:33: TPASS: request failed with ENOTTY
ioctl_ns07.c:33: TPASS: request failed with ENOTTY

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
tag=3Dinotify02 stime=3D1631249148
cmdline=3D"inotify02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D40000004 cookie=3D0     le=
n=3D0  name=3D""
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000100 cookie=3D0     le=
n=3D16 name=3D"test_file1"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000020 cookie=3D0     le=
n=3D16 name=3D"test_file1"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000008 cookie=3D0     le=
n=3D16 name=3D"test_file1"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000040 cookie=3D5369  le=
n=3D16 name=3D"test_file1"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000080 cookie=3D5369  le=
n=3D16 name=3D"test_file2"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000800 cookie=3D0     le=
n=3D0  name=3D""
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000200 cookie=3D0     le=
n=3D16 name=3D"test_file2"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000800 cookie=3D0     le=
n=3D0  name=3D""

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
tag=3Dinotify05 stime=3D1631249148
cmdline=3D"inotify05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
inotify05.c:115: TPASS: get event: wd=3D-1 mask=3D4000 cookie=3D0 len=3D0

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify04 stime=3D1631249148
cmdline=3D"fanotify04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify04.c:71: TPASS: fanotify_mark (4, FAN_MARK_ADD | FAN_MARK_ONLYDIR, =
FAN_OPEN, AT_FDCWD, '.') succeeded
fanotify04.c:71: TPASS: fanotify_mark (4, FAN_MARK_ADD | FAN_MARK_ONLYDIR, =
FAN_OPEN, AT_FDCWD, 'fname_3232') failed
fanotify04.c:71: TPASS: fanotify_mark (4, FAN_MARK_ADD | FAN_MARK_DONT_FOLL=
OW, FAN_OPEN, AT_FDCWD, 'symlink_3232') succeeded
fanotify04.c:163: TPASS: No event as expected
fanotify04.c:71: TPASS: fanotify_mark (4, FAN_MARK_ADD | 0, FAN_OPEN, AT_FD=
CWD, 'symlink_3232') succeeded
fanotify04.c:127: TPASS: event generated properly for type 100000
fanotify04.c:127: TPASS: event generated properly for type 100000
fanotify04.c:127: TPASS: event generated properly for type 40000
fanotify04.c:163: TPASS: No event as expected

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
tag=3Dfanotify13 stime=3D1631249148
cmdline=3D"fanotify13"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D 3a9bf3f6.369ce9a.c.11b880=
35.0...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D 3a9bf3f6.369ce9a.d.11b880=
36.0...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D 3a9bf3f6.369ce9a.8001.11b8=
8037.0...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3257, fid=3D3a9b=
f3f6.369ce9a.11b8803700008001 values returned in event match those returned=
 in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3257, fid=3D3a9b=
f3f6.369ce9a.11b8803700008001 values returned in event match those returned=
 in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3257, fid=3D3a9b=
f3f6.369ce9a.11b8803700008001 values returned in event match those returned=
 in statfs(2) and name_to_handle_at(2)
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D 16e0f68a.b0681152.1801.2a=
a5be63.0...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D 16e0f68a.b0681152.1802.7d=
a4539b.0...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D 16e0f68a.b0681152.d001.6ec=
3c398.0...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3269, fid=3D16e0=
f68a.b0681152.6ec3c3980000d001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3269, fid=3D16e0=
f68a.b0681152.6ec3c3980000d001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3269, fid=3D16e0=
f68a.b0681152.6ec3c3980000d001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D edaf6cb6.7305ba46.c.1b149=
9fa.0...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D edaf6cb6.7305ba46.d.37d1e=
7b7.0...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D edaf6cb6.7305ba46.8001.aef=
06912.0...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3275, fid=3Dedaf=
6cb6.7305ba46.aef0691200008001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3275, fid=3Dedaf=
6cb6.7305ba46.aef0691200008001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3275, fid=3Dedaf=
6cb6.7305ba46.aef0691200008001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D 700.0.83.0.6bf97bb1...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D 700.0.84.0.b0b51c66...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D 700.0.85.0.2e9660c7...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3288, fid=3D700.=
0.85 values returned in event match those returned in statfs(2) and name_to=
_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3288, fid=3D700.=
0.85 values returned in event match those returned in statfs(2) and name_to=
_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3288, fid=3D700.=
0.85 values returned in event match those returned in statfs(2) and name_to=
_handle_at(2)
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D 28ecf5ed.aa028c92.101.0.5=
=2E..
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D 28ecf5ed.aa028c92.102.0.5=
=2E..
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D 28ecf5ed.aa028c92.103.0.5.=
=2E.
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3314, fid=3D28ec=
f5ed.aa028c92.103 values returned in event match those returned in statfs(2=
) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3314, fid=3D28ec=
f5ed.aa028c92.103 values returned in event match those returned in statfs(2=
) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3314, fid=3D28ec=
f5ed.aa028c92.103 values returned in event match those returned in statfs(2=
) and name_to_handle_at(2)
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D 700.0.73.991080e3.0...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D 700.0.74.773a70fb.0...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D 700.0.75.d2ce284a.0...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3316, fid=3D700.=
0.d2ce284a00000075 values returned in event match those returned in statfs(=
2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3316, fid=3D700.=
0.d2ce284a00000075 values returned in event match those returned in statfs(=
2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3316, fid=3D700.=
0.d2ce284a00000075 values returned in event match those returned in statfs(=
2) and name_to_handle_at(2)
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify13.c:262: TCONF: FAN_REPORT_FID not supported on ntfs filesystem
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D e357afa9.6126c96.c5e9315f=
=2E2.0...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D e357afa9.6126c96.4ea2f435=
=2E3.0...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D e357afa9.6126c96.15e1e53a.=
4.0...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3330, fid=3De357=
afa9.6126c96.415e1e53a values returned in event match those returned in sta=
tfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3330, fid=3De357=
afa9.6126c96.415e1e53a values returned in event match those returned in sta=
tfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3330, fid=3De357=
afa9.6126c96.415e1e53a values returned in event match those returned in sta=
tfs(2) and name_to_handle_at(2)

Summary:
passed   105
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D9 cstime=3D90
<<<test_end>>>
<<<test_start>>>
tag=3Dio_getevents02 stime=3D1631249152
cmdline=3D"io_getevents02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
io_getevents02.c:35: TPASS: io_getevents() failed with EINVAL

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
tag=3Dkeyctl01 stime=3D1631249152
cmdline=3D"keyctl01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
keyctl01.c:27: TPASS: KEYCTL_GET_KEYRING_ID succeeded
keyctl01.c:48: TPASS: KEYCTL_REVOKE failed as expected: ENOKEY (126)

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
tag=3Dkcmp02 stime=3D1631249152
cmdline=3D"kcmp02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
kcmp02.c:83: TPASS: kcmp() returned the expected value: ESRCH (3)
kcmp02.c:83: TPASS: kcmp() returned the expected value: EINVAL (22)
kcmp02.c:83: TPASS: kcmp() returned the expected value: EINVAL (22)
kcmp02.c:83: TPASS: kcmp() returned the expected value: EINVAL (22)
kcmp02.c:83: TPASS: kcmp() returned the expected value: EINVAL (22)
kcmp02.c:83: TPASS: kcmp() returned the expected value: EBADF (9)

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
tag=3Dkcmp03 stime=3D1631249152
cmdline=3D"kcmp03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
kcmp03.c:64: TPASS: kcmp() returned the expected value
kcmp03.c:64: TPASS: kcmp() returned the expected value
kcmp03.c:64: TPASS: kcmp() returned the expected value
kcmp03.c:64: TPASS: kcmp() returned the expected value

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
tag=3Dlink06 stime=3D1631249152
cmdline=3D"link06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link06      1  TPASS  :  link() fails with expected error EACCES errno:13
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlink07 stime=3D1631249152
cmdline=3D"link07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link07      1  TPASS  :  link() fails with expected error: TEST_ERRNO=3DEAC=
CES(13): Permission denied
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dllistxattr03 stime=3D1631249152
cmdline=3D"llistxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
llistxattr03.c:55: TPASS: llistxattr() succeed with suitable buffer
llistxattr03.c:55: TPASS: llistxattr() succeed with suitable buffer

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
tag=3Dlremovexattr01 stime=3D1631249152
cmdline=3D"lremovexattr01"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:115: TCONF: symlink() not supported
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected

Summary:
passed   7
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D9 cstime=3D88
<<<test_end>>>
<<<test_start>>>
tag=3Dlseek01 stime=3D1631249157
cmdline=3D"lseek01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lseek01.c:67: TPASS: lseek(tfile, 4, SEEK_SET) read correct data
lseek01.c:67: TPASS: lseek(tfile, -2, SEEK_CUR) read correct data
lseek01.c:67: TPASS: lseek(tfile, -4, SEEK_END) read correct data
lseek01.c:67: TPASS: lseek(tfile, 0, SEEK_END) read correct data

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
tag=3Dlseek07 stime=3D1631249157
cmdline=3D"lseek07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lseek07.c:70: TPASS: lseek(tfile1, 7, SEEK_SET) wrote correct data abcdefgi=
jk
lseek07.c:70: TPASS: lseek(tfile2, 2, SEEK_SET) wrote correct data abijkfg

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
tag=3Dmallinfo02 stime=3D1631249157
cmdline=3D"mallinfo02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
mallinfo02.c:28: TPASS: malloc() uses sbrk when size < 128k
mallinfo02.c:41: TPASS: malloc() uses mmap when size >=3D 128k

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
tag=3Dmallopt01 stime=3D1631249157
cmdline=3D"mallopt01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
mallopt01.c:41: TPASS: mallinfo() succeeded
mallopt01.c:48: TPASS: mallopt(M_MXFAST, 160) succeeded
mallopt01.c:53: TPASS: malloc(1024) succeeded
mallopt01.c:60: TPASS: mallopt(M_MXFAST, 0) succeeded
mallopt01.c:65: TPASS: malloc(1024) succeeded

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
tag=3Dmigrate_pages03 stime=3D1631249157
cmdline=3D"migrate_pages03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
migrate_pages03.c:60: TCONF: requires NUMA with at least 2 node

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
tag=3Dmlockall02 stime=3D1631249157
cmdline=3D"mlockall02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mlockall02    1  TPASS  :  expected failure - errno =3D 12 : Cannot allocat=
e memory
mlockall02    2  TPASS  :  expected failure - errno =3D 1 : Operation not p=
ermitted
mlockall02    3  TPASS  :  expected failure - errno =3D 22 : Invalid argume=
nt
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmkdir02 stime=3D1631249157
cmdline=3D"mkdir02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
mkdir02.c:56: TINFO: Found unused GID 11: SUCCESS (0)
mkdir02.c:46: TPASS: New dir inherited GID and S_ISGID

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
tag=3Dmkdir04 stime=3D1631249157
cmdline=3D"mkdir04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
mkdir04.c:37: TPASS: mkdir() failed expectedly: EACCES (13)

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
tag=3Dmknodat01 stime=3D1631249157
cmdline=3D"mknodat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mknodat01    1  TPASS  :  mknodat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mknodat01    2  TPASS  :  mknodat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mknodat01    3  TPASS  :  mknodat() returned -1: TEST_ERRNO=3DENOTDIR(20): =
Not a directory
mknodat01    4  TPASS  :  mknodat() returned -1: TEST_ERRNO=3DEBADF(9): Bad=
 file descriptor
mknodat01    5  TPASS  :  mknodat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmlock02 stime=3D1631249157
cmdline=3D"mlock02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mlock02     1  TPASS  :  mlock failed as expected: TEST_ERRNO=3DENOMEM(12):=
 Cannot allocate memory
mlock02     2  TPASS  :  mlock failed as expected: TEST_ERRNO=3DENOMEM(12):=
 Cannot allocate memory
mlock02     3  TPASS  :  mlock failed as expected: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmlock04 stime=3D1631249157
cmdline=3D"mlock04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mlock04     0  TINFO  :  locked 40960 bytes from 0x7f5952b33000
mlock04     1  TPASS  :  test succeeded.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dqmm01 stime=3D1631249157
cmdline=3D"mmap001 -m 1"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap001     0  TINFO  :  mmap()ing file of 1 pages or 4096 bytes
mmap001     1  TPASS  :  mmap() completed successfully.
mmap001     0  TINFO  :  touching mmaped memory
mmap001     2  TPASS  :  we're still here, mmaped area must be good
mmap001     3  TPASS  :  synchronizing mmapped page passed
mmap001     4  TPASS  :  munmapping testfile.3462 successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap04 stime=3D1631249157
cmdline=3D"mmap04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap04      1  TPASS  :  Functionality of mmap() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap05 stime=3D1631249157
cmdline=3D"mmap05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap05      1  TPASS  :  Got SIGSEGV as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap12 stime=3D1631249157
cmdline=3D"mmap12"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
mmap12.c:90: TINFO: All pages are present
mmap12.c:114: TPASS: File mapped properly

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
tag=3Dmmap13 stime=3D1631249157
cmdline=3D"mmap13"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap13      1  TPASS  :  Got SIGBUS as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmodify_ldt03 stime=3D1631249157
cmdline=3D"modify_ldt03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
modify_ldt03    1  TCONF  :  modify_ldt03.c:94: modify_ldt is available but=
 not tested on the platform than __i386__
modify_ldt03    2  TCONF  :  modify_ldt03.c:94: Remaining cases not appropr=
iate for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages12 stime=3D1631249157
cmdline=3D"move_pages12"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
move_pages_support.c:407: TCONF: at least 2 allowed NUMA nodes are required

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
tag=3Dmprotect04 stime=3D1631249157
cmdline=3D"mprotect04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mprotect04    1  TPASS  :  test PROT_NONE for mprotect success
mprotect04    0  TINFO  :  exec_func: 0x561688f50d80, page_to_copy: 0x56168=
8f50000
mprotect04    2  TPASS  :  test PROT_EXEC for mprotect success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap05 stime=3D1631249157
cmdline=3D"mremap05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mremap05    1  TPASS  :  MREMAP_FIXED requires MREMAP_MAYMOVE
mremap05    2  TPASS  :  new_addr has to be page aligned
mremap05    3  TPASS  :  old/new area must not overlap
mremap05    4  TPASS  :  mremap #1
mremap05    5  TPASS  :  mremap #1 value OK
mremap05    6  TPASS  :  mremap #2
mremap05    7  TPASS  :  mremap #2 value OK
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgctl03 stime=3D1631249157
cmdline=3D"msgctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msgctl03.c:30: TPASS: msgctl(IPC_RMID)
msgctl03.c:34: TPASS: msgctl(IPC_STAT): EINVAL (22)

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
tag=3Dmsgrcv06 stime=3D1631249157
cmdline=3D"msgrcv06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msgrcv06.c:28: TPASS: msgrcv(1, 0x55a06e983660, 1024, 1, 0) : EIDRM (43)

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
tag=3Dmsync02 stime=3D1631249157
cmdline=3D"msync02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
msync02     1  TPASS  :  Functionality of msync successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmsync04 stime=3D1631249157
cmdline=3D"msync04"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:60: TFAIL: Expected dirty bit to be set after writing to mmap()-e=
d area

Summary:
passed   6
failed   1
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D7 cstime=3D90
<<<test_end>>>
<<<test_start>>>
tag=3Dnice01 stime=3D1631249161
cmdline=3D"nice01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
nice01.c:48: TPASS: nice(-12) passed

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
tag=3Dopen01A stime=3D1631249161
cmdline=3D"symlink01 -T open01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open01      1  TPASS  :  open(2) with (O_CREAT | O_RDWR) to create object f=
ile through symbolic link file and all writes, reads, and lseeks are ok
open01      2  TPASS  :  open(2) with O_RDWR of existing  object file throu=
gh symbolic link file and all writes, reads, and lseeks are ok
open01      3  TPASS  :  open(2) with (O_CREAT | O_EXCL) error  is caught w=
hen creating object file through symbolic link file
open01      4  TPASS  :  open(2) error with O_RDWR is caught when processin=
g symbolic link file which points at no object file
open01      5  TPASS  :  Nested symbolic link access condition caught.  ELO=
OP is returned
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmadvise10 stime=3D1631249161
cmdline=3D"madvise10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
madvise10.c:134: TINFO: MADV_WIPEONFORK zeroes memory in child
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x0)
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x12)
madvise10.c:89: TPASS: In PID 3581, Matched expected pattern
madvise10.c:134: TINFO: MADV_WIPEONFORK with zero length does nothing
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 0, 0x0)
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 0, 0x12)
madvise10.c:89: TPASS: In PID 3582, Matched expected pattern
madvise10.c:134: TINFO: MADV_WIPEONFORK zeroes memory in grand-child
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x0)
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x12)
madvise10.c:89: TPASS: In PID 3584, Matched expected pattern
madvise10.c:134: TINFO: MADV_KEEPONFORK will undo MADV_WIPEONFORK
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x12)
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x13)
madvise10.c:89: TPASS: In PID 3585, Matched expected pattern

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
tag=3Dpause01 stime=3D1631249161
cmdline=3D"pause01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
pause01.c:24: TPASS: pause() interrupted with EINTR

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
tag=3Dpersonality01 stime=3D1631249161
cmdline=3D"personality01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
personality01    1  TPASS  :  personality(PER_LINUX)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_LINUX_32BIT)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_SVR4)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_SVR3)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_SCOSVR3)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_OSR5)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_WYSEV386)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_ISCR4)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_BSD)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_XENIX)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_LINUX32)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_IRIX32)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_IRIXN32)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_IRIX64)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_RISCOS)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_SOLARIS)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_UW7)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_OSF4)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_HPUX)
personality01    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe01 stime=3D1631249161
cmdline=3D"pipe01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
pipe01.c:48: TPASS: pipe() functionality is correct

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
tag=3Dpoll01 stime=3D1631249161
cmdline=3D"poll01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
poll01.c:42: TPASS: poll() POLLOUT
poll01.c:69: TPASS: poll() POLLIN

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
tag=3Dpread03_64 stime=3D1631249161
cmdline=3D"pread03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pread03     1  TPASS  :  pread() fails with expected error EISDIR errno:21
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpreadv202_64 stime=3D1631249161
cmdline=3D"preadv202_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
preadv202.c:82: TPASS: preadv2() failed as expected: EINVAL (22)
preadv202.c:82: TPASS: preadv2() failed as expected: EINVAL (22)
preadv202.c:82: TPASS: preadv2() failed as expected: EOPNOTSUPP (95)
preadv202.c:82: TPASS: preadv2() failed as expected: EFAULT (14)
preadv202.c:82: TPASS: preadv2() failed as expected: EBADF (9)
preadv202.c:82: TPASS: preadv2() failed as expected: EBADF (9)
preadv202.c:82: TPASS: preadv2() failed as expected: EISDIR (21)
preadv202.c:82: TPASS: preadv2() failed as expected: ESPIPE (29)

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
tag=3Dprocess_vm_writev02 stime=3D1631249161
cmdline=3D"process_vm_writev02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
process_vm_writev02    0  TINFO  :  child 2: write to the same memory locat=
ion.
process_vm_writev02    0  TINFO  :  child 0: memory allocated.
process_vm_writev02    1  TPASS  :  child 0: all bytes are expected.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpselect03 stime=3D1631249161
cmdline=3D"pselect03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
pselect03.c:31: TPASS: pselect() succeeded retval=3D0

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
tag=3Dptrace07 stime=3D1631249161
cmdline=3D"ptrace07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
ptrace07.c:138: TINFO: PTRACE_SETREGSET with reserved bits failed with EINV=
AL
ptrace07.c:161: TINFO: test child 3623 exited, retcode: 0
ptrace07.c:174: TPASS: wasn't able to set invalid FPU state

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D168 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dquotactl07 stime=3D1631249162
cmdline=3D"quotactl07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
quotactl07.c:32: TPASS: Q_XQUOTARM has quota type check

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Drealpath01 stime=3D1631249163
cmdline=3D"realpath01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
realpath01.c:35: TPASS: bug not reproduced

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
tag=3Drecvmsg03 stime=3D1631249163
cmdline=3D"recvmsg03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
recvmsg03.c:38: TCONF: rds was not supported

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
tag=3Drename03 stime=3D1631249163
cmdline=3D"rename03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
rename03    1  TPASS  :  functionality is correct for renaming a file
rename03    2  TPASS  :  functionality is correct for renaming a directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Drename11 stime=3D1631249163
cmdline=3D"rename11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
rename11    0  TINFO  :  Found free device 0 '/dev/loop0'
rename11    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
rename11    0  TINFO  :  subdir limit is not availiable for xfs filesystem
rename11    1  TPASS  :  failed as expected: TEST_ERRNO=3DELOOP(40): Too ma=
ny levels of symbolic links
rename11    2  TPASS  :  failed as expected: TEST_ERRNO=3DEROFS(30): Read-o=
nly file system
rename11    3  TCONF  :  rename11.c:167: EMLINK test is not appropriate
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Drequest_key04 stime=3D1631249163
cmdline=3D"request_key04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
request_key04.c:66: TPASS: request_key() failed with EACCES as expected

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
tag=3Dsched_get_priority_min02 stime=3D1631249163
cmdline=3D"sched_get_priority_min02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_get_priority_min02    1  TPASS  :  Test Passed, Got EINVAL
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_getparam03 stime=3D1631249163
cmdline=3D"sched_getparam03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_getparam03.c:53: TINFO: Testing libc variant
sched_getparam03.c:48: TPASS: sched_getparam() with non-existing pid : ESRC=
H (3)
sched_getparam03.c:48: TPASS: sched_getparam() with invalid pid : EINVAL (2=
2)
sched_getparam03.c:48: TPASS: sched_getparam() with invalid address for par=
am : EINVAL (22)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_getparam03.c:53: TINFO: Testing syscall variant
sched_getparam03.c:48: TPASS: sched_getparam() with non-existing pid : ESRC=
H (3)
sched_getparam03.c:48: TPASS: sched_getparam() with invalid pid : EINVAL (2=
2)
sched_getparam03.c:48: TPASS: sched_getparam() with invalid address for par=
am : EINVAL (22)

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
tag=3Dsched_setparam05 stime=3D1631249163
cmdline=3D"sched_setparam05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_setparam05.c:42: TINFO: Testing libc variant
sched_setparam05.c:32: TPASS: sched_setparam(3669, 0) : EPERM (1)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_setparam05.c:42: TINFO: Testing syscall variant
sched_setparam05.c:32: TPASS: sched_setparam(3671, 0) : EPERM (1)

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
tag=3Dsched_setscheduler01 stime=3D1631249163
cmdline=3D"sched_setscheduler01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_setscheduler01.c:59: TINFO: Testing libc variant
sched_setscheduler01.c:71: TPASS: sched_setscheduler(32768, 0, 0x556dd6c949=
54) : ESRCH (3)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(1, 99, 0x556dd6c94954)=
 : EINVAL (22)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(1, 0, 0xffffffffffffff=
ff) : EFAULT (14)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(0, 0, 0x556dd6c94614) =
: EINVAL (22)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_setscheduler01.c:59: TINFO: Testing syscall variant
sched_setscheduler01.c:71: TPASS: sched_setscheduler(32768, 0, 0x556dd6c949=
54) : ESRCH (3)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(1, 99, 0x556dd6c94954)=
 : EINVAL (22)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(1, 0, 0xffffffffffffff=
ff) : EFAULT (14)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(0, 0, 0x556dd6c94614) =
: EINVAL (22)

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
tag=3Dselect04 stime=3D1631249163
cmdline=3D"select04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
select_var.h:109: TINFO: Testing libc select()
select04.c:58: TPASS: No data to read: select() cleared the fd set
select04.c:58: TPASS: No space to write: select() cleared the fd set
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
select_var.h:112: TINFO: Testing SYS_select syscall
select04.c:58: TPASS: No data to read: select() cleared the fd set
select04.c:58: TPASS: No space to write: select() cleared the fd set
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
select_var.h:115: TINFO: Testing SYS_pselect6 syscall
select04.c:58: TPASS: No data to read: select() cleared the fd set
select04.c:58: TPASS: No space to write: select() cleared the fd set
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
select_var.h:118: TINFO: Testing SYS_pselect6 time64 syscall
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
select_var.h:121: TINFO: Testing SYS__newselect syscall
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported

Summary:
passed   6
failed   0
broken   0
skipped  2
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D3 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dsemctl02 stime=3D1631249163
cmdline=3D"semctl02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
semctl02.c:29: TPASS: semctl(IPC_STAT) with nobody user : EACCES (13)

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
tag=3Dsemop01 stime=3D1631249163
cmdline=3D"semop01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
semop01.c:71: TINFO: Testing variant: semop: syscall
semop01.c:58: TPASS: semaphore values are correct
semop01.c:58: TPASS: semaphore values are correct
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
semop01.c:71: TINFO: Testing variant: semtimedop: syscall with old kernel s=
pec
semop01.c:58: TPASS: semaphore values are correct
semop01.c:58: TPASS: semaphore values are correct

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
tag=3Dsendfile05_64 stime=3D1631249163
cmdline=3D"sendfile05_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sendfile05.c:42: TPASS: sendfile(out, in, &offset, ..) with offset=3D-1 : E=
INVAL (22)

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
tag=3Dsendfile06 stime=3D1631249163
cmdline=3D"sendfile06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sendfile06.c:61: TPASS: sendfile() with offset=3DNULL

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
tag=3Dsendmmsg02 stime=3D1631249163
cmdline=3D"sendmmsg02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sendmmsg02.c:56: TINFO: Testing variant: vDSO or syscall with libc spec
sendmmsg02.c:49: TPASS: sendmmsg() bad file descriptor : EBADF (9)
sendmmsg02.c:49: TPASS: sendmmsg() invalid msgvec address : EFAULT (14)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sendmmsg02.c:56: TINFO: Testing variant: syscall with old kernel spec
sendmmsg02.c:49: TPASS: sendmmsg() bad file descriptor : EBADF (9)
sendmmsg02.c:49: TPASS: sendmmsg() invalid msgvec address : EFAULT (14)

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
tag=3Dsendto01 stime=3D1631249163
cmdline=3D"sendto01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendto01    1  TPASS  :  bad file descriptor successful
sendto01    2  TPASS  :  invalid socket successful
sendto01    3  TPASS  :  invalid send buffer successful
sendto01    4  TPASS  :  connected TCP successful
sendto01    5  TPASS  :  not connected TCP successful
sendto01    6  TPASS  :  invalid to buffer length successful
sendto01    7  TPASS  :  invalid to buffer successful
sendto01    8  TPASS  :  UDP message too big successful
sendto01    9  TPASS  :  local endpoint shutdown successful
sendto01   10  TPASS  :  invalid flags set successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dset_mempolicy04 stime=3D1631249163
cmdline=3D"set_mempolicy04"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes

Summary:
passed   0
failed   0
broken   0
skipped  8
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D1 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dsetdomainname03 stime=3D1631249164
cmdline=3D"setdomainname03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:36: TINFO: Testing libc setdomainname()
setdomainname03.c:32: TPASS: expected failure: EPERM (1)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:39: TINFO: Testing __NR_setdomainname syscall
setdomainname03.c:32: TPASS: expected failure: EPERM (1)

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
tag=3Dsetfsuid03 stime=3D1631249164
cmdline=3D"setfsuid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsuid03    1  TPASS  :  setfsuid() returned expected value : 65534
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgid01 stime=3D1631249164
cmdline=3D"setgid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setgid01.c:21: TPASS: SETGID(gid) passed

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
tag=3Dsetegid01 stime=3D1631249164
cmdline=3D"setegid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setegid01    0  TINFO  :  getresgid reports rgid 0, egid 0, sgid 0
setegid01    0  TINFO  :  calling setegid(nobody_gid 65534)
setegid01    0  TINFO  :  getresgid reports rgid 0, egid 65534, sgid 0
setegid01    1  TPASS  :  setegid() passed functional test
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgroups01 stime=3D1631249164
cmdline=3D"setgroups01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgroups01    1  TPASS  :  setgroups(65536, list) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgroups02 stime=3D1631249164
cmdline=3D"setgroups02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgroups02    1  TPASS  :  Functionality of setgroups(1, groups_list) succ=
essful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgroups04 stime=3D1631249164
cmdline=3D"setgroups04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgroups04    1  TPASS  :  setgroups() fails with expected error EFAULT er=
rno:14
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsethostname02 stime=3D1631249164
cmdline=3D"sethostname02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname.h:36: TINFO: Testing libc sethostname()
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing len =3D=3D -1
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EINVAL (22)
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing len > allowed maximum
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EINVAL (22)
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing name =3D=3D NULL
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EFAULT (14)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname.h:39: TINFO: Testing __NR_sethostname syscall
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing len =3D=3D -1
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EINVAL (22)
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing len > allowed maximum
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EINVAL (22)
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing name =3D=3D NULL
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EFAULT (14)

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
tag=3Dsetpgid02 stime=3D1631249164
cmdline=3D"setpgid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setpgid02    1  TPASS  :  expected failure - errno =3D 22 : Invalid argument
setpgid02    2  TPASS  :  expected failure - errno =3D 3 : No such process
setpgid02    3  TPASS  :  expected failure - errno =3D 1 : Operation not pe=
rmitted
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetregid03 stime=3D1631249164
cmdline=3D"setregid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setregid03.c:61: TINFO: getgrnam(nobody) failed - try fallback nogroup
setregid03.c:95: TPASS: setregid(1, 2) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(-1, 1) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(-1, 2) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(2, -1) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(-1, -1) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(-1, 2) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(2, -1) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(2, 2) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:105: TPASS: setregid(1, -1) failed as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:105: TPASS: setregid(-1, 1) failed as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:105: TPASS: setregid(1, 1) failed as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected

Summary:
passed   22
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresgid01_16 stime=3D1631249164
cmdline=3D"setresgid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresgid01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresgid/../utils/compat_16.h:146: 16-bit version of setresgid() is not=
 supported on your platform
setresgid01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresgid/../utils/compat_16.h:146: Remaining cases not appropriate for =
configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresuid01_16 stime=3D1631249164
cmdline=3D"setresuid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresuid01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresuid/../utils/compat_16.h:136: 16-bit version of setresuid() is not=
 supported on your platform
setresuid01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresuid/../utils/compat_16.h:136: Remaining cases not appropriate for =
configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetreuid05 stime=3D1631249164
cmdline=3D"setreuid05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setreuid05    1  TPASS  :  setreuid(65534, 0) succeeded as expected.
setreuid05    2  TPASS  :  setreuid(-1, 65534) succeeded as expected.
setreuid05    3  TPASS  :  setreuid(-1, 0) succeeded as expected.
setreuid05    4  TPASS  :  setreuid(1, -1) succeeded as expected.
setreuid05    5  TPASS  :  setreuid(-1, 2) succeeded as expected.
setreuid05    6  TPASS  :  setreuid(-1, 0) succeeded as expected.
setreuid05    7  TPASS  :  setreuid(-1, 65534) succeeded as expected.
setreuid05    8  TPASS  :  setreuid(-1, 1) succeeded as expected.
setreuid05    9  TPASS  :  setreuid(-1, 2) succeeded as expected.
setreuid05   10  TPASS  :  setreuid(2, 1) succeeded as expected.
setreuid05   11  TPASS  :  setreuid(-1, 2) succeeded as expected.
setreuid05   12  TPASS  :  setreuid(-1, 1) succeeded as expected.
setreuid05   13  TPASS  :  setreuid(1, -1) succeeded as expected.
setreuid05   14  TPASS  :  setreuid(-1, 2) succeeded as expected.
setreuid05    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetrlimit03 stime=3D1631249164
cmdline=3D"setrlimit03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setrlimit03.c:55: TPASS: setrlimit() failed as expected: EPERM (1)
setrlimit03.c:55: TPASS: setrlimit() failed as expected: EINVAL (22)

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
tag=3Dsetrlimit05 stime=3D1631249164
cmdline=3D"setrlimit05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setrlimit05.c:38: TPASS: setrlimit() failed as expected: EFAULT (14)

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
tag=3Dsetrlimit06 stime=3D1631249164
cmdline=3D"setrlimit06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setrlimit06.c:86: TPASS: Got SIGXCPU then SIGKILL after reaching both limit

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D201 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetsockopt04 stime=3D1631249166
cmdline=3D"setsockopt04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setsockopt04.c:39: TINFO: Try to set send buffer size to: 4294967040
setsockopt04.c:40: TINFO: Send buffer size was set to: 4608
setsockopt04.c:45: TPASS: Was unable to set negative send buffer size!

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
tag=3Dsetuid03_16 stime=3D1631249166
cmdline=3D"setuid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/setuid/../utils/compat_tst_1=
6.h:84: TCONF: 16-bit version of setuid() is not supported on your platform

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
tag=3Dshmctl03 stime=3D1631249166
cmdline=3D"shmctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
shmctl03.c:34: TPASS: shmmin =3D 1
shmctl03.c:36: TPASS: /proc/sys/kernel/shmmax =3D 18446744073692774399
shmctl03.c:37: TPASS: /proc/sys/kernel/shmmni =3D 4096
shmctl03.c:38: TPASS: /proc/sys/kernel/shmall =3D 18446744073692774399

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
tag=3Dshmget06 stime=3D1631249166
cmdline=3D"shmget06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
shmget06.c:41: TPASS: shm id 3772 has existed, shmget() returns the new shm=
 id 3773

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
tag=3Dsignal06 stime=3D1631249166
cmdline=3D"signal06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal06    0  TINFO  :  loop =3D 30000
signal06    1  TPASS  :  signal06 call succeeded
signal06    0  TINFO  :  loop =3D 30000
signal06    2  TPASS  :  signal06 call succeeded
signal06    0  TINFO  :  loop =3D 30000
signal06    3  TPASS  :  signal06 call succeeded
signal06    0  TINFO  :  loop =3D 30000
signal06    4  TPASS  :  signal06 call succeeded
signal06    0  TINFO  :  loop =3D 30000
signal06    5  TPASS  :  signal06 call succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D26 cstime=3D162
<<<test_end>>>
<<<test_start>>>
tag=3Dsigtimedwait01 stime=3D1631249167
cmdline=3D"sigtimedwait01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sigwait.c:27: TPASS: Wait interrupted by expected signal
sigwait.c:88: TPASS: struct siginfo is correct
sigwait.c:148: TPASS: struct siginfo is correct
sigwait.c:160: TPASS: sigwaitinfo restored the original mask
sigwait.c:113: TPASS: Wait interrupted by expected signal
sigwait.c:259: TPASS: Wait interrupted by expected signal
sigwait.c:268: TPASS: sigwaitinfo restored the original mask
sigwait.c:302: TPASS: Fault occurred while accessing the buffers
sigwait.c:344: TPASS: Child exited with expected code
sigwait.c:367: TPASS: Fault occurred while accessing the buffers
sigwait.c:57: TPASS: Wait interrupted by timeout

Summary:
passed   11
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
tag=3Dsigwait01 stime=3D1631249168
cmdline=3D"sigwait01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sigwait.c:113: TPASS: Wait interrupted by expected signal
sigwait.c:259: TPASS: Wait interrupted by expected signal
sigwait.c:268: TPASS: sigwaitinfo restored the original mask

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
tag=3Dsocket01 stime=3D1631249169
cmdline=3D"socket01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
socket01.c:66: TPASS: invalid domain successful
socket01.c:66: TPASS: invalid type successful
socket01.c:66: TPASS: UNIX domain dgram successful
socket01.c:66: TPASS: raw open as non-root successful
socket01.c:66: TPASS: UDP socket successful
socket01.c:66: TPASS: UDP stream successful
socket01.c:66: TPASS: TCP dgram successful
socket01.c:66: TPASS: TCP socket successful
socket01.c:66: TPASS: ICMP stream successful

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
tag=3Dstat01 stime=3D1631249169
cmdline=3D"stat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
stat01.c:75: TPASS: stat(test_fileread)
stat01.c:75: TPASS: stat(test_filenoread)

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
tag=3Dstatfs03_64 stime=3D1631249169
cmdline=3D"statfs03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs03    1  TPASS  :  expected failure - errno =3D 13 : Permission denied
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog06 stime=3D1631249169
cmdline=3D"syslog06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog06    0  TINFO  :   Test the logging option: LOG_NDELAY
syslog06    0  TINFO  :   o Do openlog() without LOG_NDELAY option.
syslog06    0  TINFO  :   o open a file and check the returned file descrip=
tor
syslog06    0  TINFO  :     It should be 3.
syslog06    0  TINFO  :   o Now do openlog() with LOG_NDELAY option.
syslog06    0  TINFO  :   o open a file and check the returned file descrip=
tor.
syslog06    0  TINFO  :     It should be greater than 3.
syslog06    0  TINFO  :  syslog: Testing the log option: LOG_NDELAY...
syslog06    0  TINFO  :  restarting syslog daemon
syslog06    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dtimerfd02 stime=3D1631249173
cmdline=3D"timerfd02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
timerfd02    1  TPASS  :  timerfd_create(TFD_CLOEXEC) Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dtimer_create02 stime=3D1631249173
cmdline=3D"timer_create02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
timer_create02.c:73: TPASS: invalid sigevent struct failed as expected: EFA=
ULT (14)
timer_create02.c:73: TPASS: invalid timer ID failed as expected: EFAULT (14)
timer_create02.c:73: TPASS: invalid clock failed as expected: EINVAL (22)
timer_create02.c:73: TPASS: wrong sigev_notify failed as expected: EINVAL (=
22)
timer_create02.c:73: TPASS: wrong sigev_signo failed as expected: EINVAL (2=
2)

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
tag=3Dtruncate02_64 stime=3D1631249173
cmdline=3D"truncate02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
truncate02.c:90: TPASS: truncate(testfile, 256) succeeded
truncate02.c:90: TPASS: truncate(testfile, 512) succeeded

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
tag=3Dunshare01 stime=3D1631249173
cmdline=3D"unshare01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
unshare01.c:47: TPASS: unshare(CLONE_FILES) passed
unshare01.c:47: TPASS: unshare(CLONE_FS) passed
unshare01.c:47: TPASS: unshare(CLONE_NEWNS) passed

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
tag=3Dumount02 stime=3D1631249173
cmdline=3D"umount02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
umount02.c:58: TPASS: umount() fails as expected: Already mounted/busy: EBU=
SY (16)
umount02.c:58: TPASS: umount() fails as expected: Invalid address: EFAULT (=
14)
umount02.c:58: TPASS: umount() fails as expected: Directory not found: ENOE=
NT (2)
umount02.c:58: TPASS: umount() fails as expected: Invalid  device: EINVAL (=
22)
umount02.c:58: TPASS: umount() fails as expected: Pathname too long: ENAMET=
OOLONG (36)

Summary:
passed   5
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
tag=3Dutime06 stime=3D1631249173
cmdline=3D"utime06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
utime06     0  TINFO  :  Found free device 0 '/dev/loop0'
utime06     0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
utime06     1  TPASS  :  utime failed as expected: TEST_ERRNO=3DEACCES(13):=
 Permission denied
utime06     2  TPASS  :  utime failed as expected: TEST_ERRNO=3DENOENT(2): =
No such file or directory
utime06     3  TPASS  :  utime failed as expected: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
utime06     4  TPASS  :  utime failed as expected: TEST_ERRNO=3DEROFS(30): =
Read-only file system
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dwait401 stime=3D1631249174
cmdline=3D"wait401"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
wait401.c:40: TPASS: wait4() returned correct pid 3889
wait401.c:49: TPASS: WIFEXITED() is set in status
wait401.c:54: TPASS: WEXITSTATUS() =3D=3D 0

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
tag=3Dwaitpid10 stime=3D1631249174
cmdline=3D"waitpid10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
waitpid10.c:62: TPASS: Test PASSED

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwritev06 stime=3D1631249176
cmdline=3D"writev06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
writev06    1  TPASS  :  writev returned 2 as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dperf_event_open01 stime=3D1631249176
cmdline=3D"perf_event_open01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 3000=
00080
perf_event_open01    1  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_HW_IN=
STRUCTIONS succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 18
perf_event_open01    2  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_HW_CA=
CHE_REFERENCES succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 0
perf_event_open01    3  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_HW_CA=
CHE_MISSES succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 1000=
00071
perf_event_open01    4  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_HW_BR=
ANCH_INSTRUCTIONS succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 4
perf_event_open01    5  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_HW_BR=
ANCH_MISSES succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 6632=
9861
perf_event_open01    6  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_SW_CP=
U_CLOCK succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 6562=
9962
perf_event_open01    7  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_SW_TA=
SK_CLOCK succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D46 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfutex_wake03 stime=3D1631249176
cmdline=3D"futex_wake03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
futex_wake03.c:97: TINFO: Testing variant: syscall with old kernel spec
futex_wake03.c:61: TPASS: futex_wake() woken up 1 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 2 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 3 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 4 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 5 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 6 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 7 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 8 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 9 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 10 childs
futex_wake03.c:89: TPASS: futex_wake() woken up 0 children

Summary:
passed   11
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
tag=3Dmemfd_create03 stime=3D1631249176
cmdline=3D"memfd_create03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
memfd_create03.c:179: TINFO: --TESTING WRITE CALL IN HUGEPAGES--
memfd_create03.c:184: TINFO: memfd_create() succeeded
memfd_create03.c:80: TPASS: write(4, "LTP", 3) failed as expected

memfd_create03.c:179: TINFO: --TESTING PAGE SIZE OF CREATED FILE--
memfd_create03.c:184: TINFO: memfd_create() succeeded
memfd_create03.c:53: TINFO: mmap((nil), 2097152, 2, 2, 4, 0) succeeded
memfd_create03.c:102: TINFO: munmap(0x7fd0ce000000, 512kB) failed as expect=
ed
memfd_create03.c:102: TINFO: munmap(0x7fd0ce000000, 1024kB) failed as expec=
ted
memfd_create03.c:102: TINFO: munmap(0x7fd0ce000000, 1536kB) failed as expec=
ted
memfd_create03.c:120: TPASS: munmap() fails for page sizes less than 2048kB

memfd_create03.c:179: TINFO: --TESTING HUGEPAGE ALLOCATION LIMIT--
memfd_create03.c:184: TINFO: memfd_create() succeeded
memfd_create03.c:53: TINFO: mmap((nil), 2097152, 2, 2, 4, 0) succeeded
memfd_create03.c:139: TINFO: memfd_create() succeeded
memfd_create03.c:146: TPASS: mmap((nil), 2097152, 0, 2, 5, 0) failed as exp=
ected

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
tag=3Dcopy_file_range01 stime=3D1631249176
cmdline=3D"copy_file_range01"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!

Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D18 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D35 cstime=3D212
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20210524-401-g575276b8c

       ###############################################################

            Done executing testcases.
            LTP Version:  20210524-401-g575276b8c
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


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.13.0-00043-gab19939a6a50"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.13.0 Kernel Configuration
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
CONFIG_CHECKPOINT_RESTORE=y
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
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
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
# CONFIG_PERF_EVENTS_AMD_POWER is not set
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
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
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
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
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
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
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
# CONFIG_MEM_SOFT_DIRTY is not set
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
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_MPTCP_KUNIT_TEST=m
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
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_DRIVER_PE_KUNIT_TEST=y
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
# CONFIG_NET_VENDOR_3COM is not set
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
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
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
# CONFIG_DRM_I915_GVT is not set
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
# CONFIG_HID_SEMITEK is not set
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
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
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
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
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
CONFIG_SECURITY_APPARMOR_KUNIT_TEST=y
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
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
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
CONFIG_LINEAR_RANGES=m
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
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
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
CONFIG_PRINTK_CALLER=y
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
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
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
# CONFIG_LOCK_TORTURE_TEST is not set
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
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
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
CONFIG_KUNIT_DEBUGFS=y
# CONFIG_KUNIT_TEST is not set
# CONFIG_KUNIT_EXAMPLE_TEST is not set
CONFIG_KUNIT_ALL_TESTS=m
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
CONFIG_BITFIELD_KUNIT=m
CONFIG_RESOURCE_KUNIT_TEST=m
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
CONFIG_LINEAR_RANGES_TEST=m
CONFIG_CMDLINE_KUNIT_TEST=m
CONFIG_BITS_TEST=m
CONFIG_SLUB_KUNIT_TEST=m
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

--liOOAslEiF7prFVr
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
	export queue_cmdline_keys=
	export queue='int'
	export testbox='lkp-skl-d02'
	export tbox_group='lkp-skl-d02'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='613ad15b0b9a9322d55a1bb8'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-03-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-ab19939a6a5010cba4e9cb04dd8bee03c72edcbd-20210910-74453-188pg5j-8.yaml'
	export id='d8a5fdf47bbddc8571fef01e8c7091e1f3b9aca4'
	export queuer_version='/lkp/xsang/.src-20210910-105014'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c500746fa0cc-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e41514d5105-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e41514d5105-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
BLK_DEV_LOOP
{"CAN"=>"m"}
{"CAN_RAW"=>"m"}
{"CAN_VCAN"=>"m"}
{"IPV6_VTI"=>"m"}
{"MINIX_FS"=>"m"}
{"CHECKPOINT_RESTORE"=>"y"}
XFS_FS'
	export commit='ab19939a6a5010cba4e9cb04dd8bee03c72edcbd'
	export need_kconfig_hw='{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xe2'
	export enqueue_time='2021-09-10 11:30:35 +0800'
	export _id='613ad15b0b9a9322d55a1bc0'
	export _rt='/result/ltp/1HDD-xfs-syscalls-03-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='9517605f81f76e1ebdd710aa17a8221f8794106c'
	export base_commit='7d2a07b769330c34b4deabeed939325c77a7ec2f'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/ltp/1HDD-xfs-syscalls-03-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/27'
	export scheduler_version='/lkp/lkp/.src-20210909-222519'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-03-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-ab19939a6a5010cba4e9cb04dd8bee03c72edcbd-20210910-74453-188pg5j-8.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=ab19939a6a5010cba4e9cb04dd8bee03c72edcbd
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/vmlinuz-5.13.0-00043-gab19939a6a50
max_uptime=2100
RESULT_ROOT=/result/ltp/1HDD-xfs-syscalls-03-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/27
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210828.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210907.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.14.0-06777-gb20486b51911'
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/vmlinuz-5.13.0-00043-gab19939a6a50'
	export dequeue_time='2021-09-10 12:43:50 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-03-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-ab19939a6a5010cba4e9cb04dd8bee03c72edcbd-20210910-74453-188pg5j-8.cgz'

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

	run_setup fs='xfs' $LKP_SRC/setup/fs

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='syscalls-03' $LKP_SRC/tests/wrapper ltp
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='syscalls-03' $LKP_SRC/stats/wrapper ltp
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

--liOOAslEiF7prFVr
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
WVo=

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ltp
Content-Transfer-Encoding: quoted-printable

2021-09-10 04:45:22 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-09-10 04:45:22 ./runltp -f syscalls-03 -d /fs/sda1/tmpdir
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
Linux lkp-skl-d02 5.13.0-00043-gab19939a6a50 #1 SMP Thu Sep 9 02:30:48 CST =
2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-03-ucode=3D0xe2-debian-10.4-x86_64-=
20200603.cgz-ab19939a6a5010cba4e9cb04dd8bee03c72edcbd-20210910-74453-188pg5=
j-8.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinus/master comm=
it=3Dab19939a6a5010cba4e9cb04dd8bee03c72edcbd BOOT_IMAGE=3D/pkg/linux/x86_6=
4-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/vmlinuz-5.13.0-00=
043-gab19939a6a50 max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1HDD-xfs-sysc=
alls-03-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhe=
l-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/27 LKP_SERVER=3Dintern=
al-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enabled r=
cupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don pan=
ic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=
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
Modules Loaded         dm_mod xfs libcrc32c ipmi_devintf ipmi_msghandler sd=
_mod t10_pi sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_=
powerclamp coretemp i915 kvm_intel kvm intel_gtt drm_kms_helper syscopyarea=
 irqbypass mei_wdt sysfillrect crct10dif_pclmul sysimgblt crc32_pclmul fb_s=
ys_fops ahci crc32c_intel ghash_clmulni_intel libahci mei_me wmi_bmof drm r=
apl mei intel_cstate intel_pch_thermal libata intel_uncore wmi video intel_=
pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32753716      299200    29831728       21804     2622788    2959=
7568
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
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2619     -n 2619 -=
p -f /fs/sda1/tmpdir/ltp-vnAWy9vVxl/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_09_10-04h_45m_22s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_09_10-04h_45m_22s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_09_10-04h_45m_22s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_09_10-04h_45m_22s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_09_10-04h_4=
5m_22s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_09_10-04h_45=
m_22s.tconf
Running tests.......
<<<test_start>>>
tag=3Dadd_key01 stime=3D1631249122
cmdline=3D"add_key01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
add_key01.c:63: TINFO: The key type is keyrings and plen is 0
add_key01.c:79: TPASS: add_key call succeeded as expected
add_key01.c:63: TINFO: the key type is keyrings and plen is 1
add_key01.c:83: TPASS: add_key call failed as expected: EINVAL (22)
add_key01.c:63: TINFO: The key type is user and plen is 32767
add_key01.c:79: TPASS: add_key call succeeded as expected
add_key01.c:63: TINFO: The key type is user and plen is 32768
add_key01.c:83: TPASS: add_key call failed as expected: EINVAL (22)
add_key01.c:63: TINFO: The key type is logon and plen is 32767
add_key01.c:79: TPASS: add_key call succeeded as expected
add_key01.c:63: TINFO: The key type is logon and plen is 32768
add_key01.c:83: TPASS: add_key call failed as expected: EINVAL (22)
add_key01.c:63: TINFO: The key type is big_key and plen is 1048575
add_key01.c:70: TCONF: skipping unsupported big_key key
add_key01.c:63: TINFO: The key type is big_key and plen is 1048576
add_key01.c:70: TCONF: skipping unsupported big_key key

Summary:
passed   6
failed   0
broken   0
skipped  2
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dalarm07 stime=3D1631249122
cmdline=3D"alarm07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
alarm07.c:43: TPASS: Got 1 sigalarm in parent
alarm07.c:32: TPASS: alarm() request cleared in child

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dbpf_map01 stime=3D1631249125
cmdline=3D"bpf_map01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
bpf_common.c:17: TINFO: Raising RLIMIT_MEMLOCK to 2162688
bpf_map01.c:53: TPASS: Created hash map
bpf_map01.c:70: TPASS: Empty hash map lookup: ENOENT (2)
bpf_map01.c:104: TPASS: Update hash map element
bpf_map01.c:122: TPASS: hash map lookup
bpf_map01.c:53: TPASS: Created array map
bpf_map01.c:104: TPASS: Update array map element
bpf_map01.c:122: TPASS: array map lookup

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
tag=3Dbpf_prog02 stime=3D1631249125
cmdline=3D"bpf_prog02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
bpf_common.c:17: TINFO: Raising RLIMIT_MEMLOCK to 2162688
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
bpf_common.c:114: TPASS: Loaded program
bpf_prog02.c:93: TPASS: val =3D 1152921504606846976 + 1
bpf_prog02.c:103: TPASS: val =3D 1152921504606846976 - 1

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
tag=3Dbrk02 stime=3D1631249125
cmdline=3D"brk02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
brk02.c:55: TPASS: munmap at least two VMAs of brk() passed

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
tag=3Dcapget02 stime=3D1631249125
cmdline=3D"capget02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
capget02.c:59: TPASS: capget() with bad address header : EFAULT (14)
capget02.c:59: TPASS: capget() with bad address data : EFAULT (14)
capget02.c:59: TPASS: capget() with bad version : EINVAL (22)
capget02.c:59: TPASS: capget() with bad pid : EINVAL (22)
capget02.c:59: TPASS: capget() with unused pid : ESRCH (3)

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
tag=3Dcapset03 stime=3D1631249125
cmdline=3D"capset03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
capset03.c:24: TINFO: Test bad value data(when pI is not old pP or old pI w=
ithout CAP_SETPCAP)
capset03.c:26: TPASS: capset() : EPERM (1)

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
tag=3Dchown02 stime=3D1631249125
cmdline=3D"chown02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
chown02.c:46: TPASS: chown(testfile2, 0, 0) passed

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
tag=3Dchown04 stime=3D1631249125
cmdline=3D"chown04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
chown04.c:78: TPASS: chown() without permissions : EPERM (1)
chown04.c:78: TPASS: chown() without full permissions of the path prefix : =
EACCES (13)
chown04.c:78: TPASS: chown() with unaccessible pathname points : EFAULT (14)
chown04.c:78: TPASS: chown() when pathname is too long : ENAMETOOLONG (36)
chown04.c:78: TPASS: chown() when file does not exist : ENOENT (2)
chown04.c:78: TPASS: chown() when the path prefix is not a directory : ENOT=
DIR (20)
chown04.c:78: TPASS: chown() with too many symbolic links : ELOOP (40)
chown04.c:78: TPASS: chown() when the named file resides on a read-only fil=
esystem : EROFS (30)

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
tag=3Dclock_nanosleep04 stime=3D1631249125
cmdline=3D"clock_nanosleep04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep04.c:33: TINFO: Testing variant: vDSO or syscall with libc s=
pec
clock_nanosleep04.c:58: TPASS: clock_nanosleep(2) passed for clock CLOCK_MO=
NOTONIC
clock_nanosleep04.c:58: TPASS: clock_nanosleep(2) passed for clock CLOCK_RE=
ALTIME
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
clock_nanosleep04.c:33: TINFO: Testing variant: syscall with old kernel spec
clock_nanosleep04.c:58: TPASS: clock_nanosleep(2) passed for clock CLOCK_MO=
NOTONIC
clock_nanosleep04.c:58: TPASS: clock_nanosleep(2) passed for clock CLOCK_RE=
ALTIME

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
tag=3Dclose02 stime=3D1631249125
cmdline=3D"close02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
close02.c:20: TPASS: close(-1) : EBADF (9)

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
tag=3Dcreat03 stime=3D1631249125
cmdline=3D"creat03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
creat03.c:36: TINFO: Created file has mode =3D 0100674
creat03.c:41: TPASS: save text bit cleared

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
tag=3Dcreat05 stime=3D1631249125
cmdline=3D"creat05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
creat05.c:49: TINFO: getdtablesize() =3D 1024
creat05.c:59: TINFO: Opened additional #1020 fds
creat05.c:36: TPASS: creat() failed with EMFILE

Summary:
passed   1
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
tag=3Dcreat09 stime=3D1631249125
cmdline=3D"creat09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
creat09.c:55: TINFO: User nobody: uid =3D 65534, gid =3D 65534
creat09.c:56: TINFO: Found unused GID 11: SUCCESS (0)
creat09.c:87: TPASS: testdir/creat.tmp: Owned by correct group
creat09.c:93: TPASS: testdir/creat.tmp: Setgid bit not set
creat09.c:87: TPASS: testdir/open.tmp: Owned by correct group
creat09.c:93: TPASS: testdir/open.tmp: Setgid bit not set

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
tag=3Depoll_ctl03 stime=3D1631249125
cmdline=3D"epoll_ctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000000f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00000019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000001f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000000f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80000019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000001f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000000f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40000019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000001f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000000f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0000019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000001f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000200f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D00002019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D0000201f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000200f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D80002019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D8000201f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000200f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D40002019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3D4000201f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002000 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002001 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002004 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002005 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002002 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002003 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002006 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002007 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002008 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002009 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000200f passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002010 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002011 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002014 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002015 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002012 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002013 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002016 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002017 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002018 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc0002019 passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201c passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201d passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201a passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201b passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201e passed
epoll_ctl03.c:44: TPASS: epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.eve=
nts=3Dc000201f passed

Summary:
passed   256
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Depoll_ctl05 stime=3D1631249125
cmdline=3D"epoll_ctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
epoll_ctl05.c:64: TPASS: epoll_clt(..., EPOLL_CTL_ADD, ...) : ELOOP (40)

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
tag=3Depoll_wait04 stime=3D1631249125
cmdline=3D"epoll_wait04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
epoll_wait04.c:35: TPASS: epoll_wait() returns immediately with a timeout e=
qual to zero

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
tag=3Deventfd01 stime=3D1631249125
cmdline=3D"eventfd01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
eventfd01    1  TPASS  :  counter value matches required
eventfd01    2  TPASS  :  read failed with EAGAIN as expected
eventfd01    3  TPASS  :  counter value matches required
eventfd01    4  TPASS  :  write failed with EAGAIN as expected
eventfd01    5  TPASS  :  read failed with EINVAL as expected
eventfd01    6  TPASS  :  write failed with EINVAL as expected
eventfd01    7  TPASS  :  write failed with EINVAL as expected
eventfd01    8  TPASS  :  fd is set in readfds
eventfd01    9  TPASS  :  fd is not set in readfds
eventfd01   10  TPASS  :  fd is set in writefds
eventfd01   11  TPASS  :  fd is not set in writefds
eventfd01    1  TPASS  :  counter value matches required
eventfd01    2  TPASS  :  read failed with EAGAIN as expected
eventfd01    3  TPASS  :  counter value matches required
eventfd01    4  TPASS  :  write failed with EAGAIN as expected
eventfd01    5  TPASS  :  read failed with EINVAL as expected
eventfd01    6  TPASS  :  write failed with EINVAL as expected
eventfd01    7  TPASS  :  write failed with EINVAL as expected
eventfd01    8  TPASS  :  fd is set in readfds
eventfd01    9  TPASS  :  fd is not set in readfds
eventfd01   10  TPASS  :  fd is set in writefds
eventfd01   11  TPASS  :  fd is not set in writefds
eventfd01   12  TPASS  :  counter value write from child successful
eventfd01   13  TPASS  :  read fd set as expected
eventfd01   14  TPASS  :  POLLERR occurred as expected
eventfd01   15  TPASS  :  overflow occurred as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexecve02 stime=3D1631249126
cmdline=3D"execve02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
execve02.c:54: TPASS: execve() failed expectedly: EACCES (13)

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
tag=3Dexecveat03 stime=3D1631249126
cmdline=3D"execveat03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
execveat_child.c:17: TPASS: execveat_child run as expected

Summary:
passed   1
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
tag=3Dexit_group01 stime=3D1631249126
cmdline=3D"exit_group01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
exit_group01    1  TPASS  :  exit_group() succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfallocate01 stime=3D1631249126
cmdline=3D"fallocate01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fallocate01    1  TPASS  :  fallocate(4, 0, 49152, 4096) returned 0
fallocate01    2  TPASS  :  write operation on fallocated(4, 0, 49152, 4096=
) returned 1
fallocate01    3  TPASS  :  fallocate(5, 1, 49152, 4096) returned 0
fallocate01    4  TPASS  :  write operation on fallocated(5, 1, 49152, 4096=
) returned 1
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfallocate02 stime=3D1631249126
cmdline=3D"fallocate02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fallocate02    1  TPASS  :  fallocate(test_file1:4, 1, 0, 1024) returned 9:=
 TEST_ERRNO=3DEBADF(9): Bad file descriptor
fallocate02    2  TPASS  :  fallocate(test_file2:5, 1, -1024, 1024) returne=
d 22: TEST_ERRNO=3DEINVAL(22): Invalid argument
fallocate02    3  TPASS  :  fallocate(test_file2:5, 1, 1024, -1024) returne=
d 22: TEST_ERRNO=3DEINVAL(22): Invalid argument
fallocate02    4  TPASS  :  fallocate(test_file2:5, 1, 12288, 0) returned 2=
2: TEST_ERRNO=3DEINVAL(22): Invalid argument
fallocate02    5  TPASS  :  fallocate(test_file2:5, 1, 12288, -1024) return=
ed 22: TEST_ERRNO=3DEINVAL(22): Invalid argument
fallocate02    6  TPASS  :  fallocate(test_file2:5, 1, -24576, 1024) return=
ed 22: TEST_ERRNO=3DEINVAL(22): Invalid argument
fallocate02    7  TPASS  :  fallocate(test_file2:5, 1, 9223372036854774784,=
 1024) returned 27: TEST_ERRNO=3DEFBIG(27): File too large
fallocate02    8  TPASS  :  fallocate(test_file2:5, 1, 1024, 92233720368547=
74784) returned 27: TEST_ERRNO=3DEFBIG(27): File too large
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfallocate04 stime=3D1631249126
cmdline=3D"fallocate04"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '3072' bytes
fallocate04.c:86: TCONF: fallocate() not supported
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '3072' bytes
fallocate04.c:86: TCONF: fallocate() not supported
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '3072' bytes
fallocate04.c:96: TPASS: test-case succeeded
fallocate04.c:103: TINFO: read allocated file size '3072'
fallocate04.c:104: TINFO: make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04.c:120: TINFO: check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04.c:137: TINFO: found a hole at '1024' offset
fallocate04.c:143: TINFO: allocated file size before '3072' and after '2048'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:154: TPASS: test-case succeeded
fallocate04.c:159: TINFO: zeroing file space with FALLOC_FL_ZERO_RANGE
fallocate04.c:168: TINFO: read current allocated file size '2048'
fallocate04.c:185: TINFO: allocated file size before '2048' and after '3072'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:196: TPASS: test-case succeeded
fallocate04.c:201: TINFO: collapsing file space with FALLOC_FL_COLLAPSE_RAN=
GE
fallocate04.c:205: TINFO: read current allocated file size '3072'
fallocate04.c:219: TINFO: allocated file size before '3072' and after '2048'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:236: TPASS: test-case succeeded
fallocate04.c:241: TINFO: inserting space with FALLOC_FL_INSERT_RANGE
fallocate04.c:245: TINFO: read current allocated file size '2048'
fallocate04.c:263: TINFO: allocated file size before '2048' and after '3072'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:274: TPASS: test-case succeeded
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '12288' bytes
fallocate04.c:96: TPASS: test-case succeeded
fallocate04.c:103: TINFO: read allocated file size '12288'
fallocate04.c:104: TINFO: make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04.c:120: TINFO: check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04.c:137: TINFO: found a hole at '4096' offset
fallocate04.c:143: TINFO: allocated file size before '12288' and after '819=
2'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:154: TPASS: test-case succeeded
fallocate04.c:159: TINFO: zeroing file space with FALLOC_FL_ZERO_RANGE
fallocate04.c:168: TINFO: read current allocated file size '8192'
fallocate04.c:185: TINFO: allocated file size before '8192' and after '1228=
8'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:196: TPASS: test-case succeeded
fallocate04.c:201: TINFO: collapsing file space with FALLOC_FL_COLLAPSE_RAN=
GE
fallocate04.c:205: TINFO: read current allocated file size '12288'
fallocate04.c:219: TINFO: allocated file size before '12288' and after '819=
2'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:236: TPASS: test-case succeeded
fallocate04.c:241: TINFO: inserting space with FALLOC_FL_INSERT_RANGE
fallocate04.c:245: TINFO: read current allocated file size '8192'
fallocate04.c:263: TINFO: allocated file size before '8192' and after '1228=
8'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:274: TPASS: test-case succeeded
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '12288' bytes
fallocate04.c:96: TPASS: test-case succeeded
fallocate04.c:103: TINFO: read allocated file size '12288'
fallocate04.c:104: TINFO: make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04.c:120: TINFO: check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04.c:137: TINFO: found a hole at '4096' offset
fallocate04.c:143: TINFO: allocated file size before '12288' and after '819=
2'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:154: TPASS: test-case succeeded
fallocate04.c:159: TINFO: zeroing file space with FALLOC_FL_ZERO_RANGE
fallocate04.c:168: TINFO: read current allocated file size '8192'
fallocate04.c:185: TINFO: allocated file size before '8192' and after '1228=
8'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:196: TPASS: test-case succeeded
fallocate04.c:201: TINFO: collapsing file space with FALLOC_FL_COLLAPSE_RAN=
GE
fallocate04.c:205: TINFO: read current allocated file size '12288'
fallocate04.c:211: TCONF: FALLOC_FL_COLLAPSE_RANGE not supported
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '12288' bytes
fallocate04.c:96: TPASS: test-case succeeded
fallocate04.c:103: TINFO: read allocated file size '12288'
fallocate04.c:104: TINFO: make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04.c:115: TCONF: FALLOC_FL_PUNCH_HOLE not supported
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '12288' bytes
fallocate04.c:86: TCONF: fallocate() not supported
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fallocate04.c:82: TINFO: allocate '12288' bytes
fallocate04.c:96: TPASS: test-case succeeded
fallocate04.c:103: TINFO: read allocated file size '12288'
fallocate04.c:104: TINFO: make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04.c:120: TINFO: check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04.c:137: TINFO: found a hole at '4096' offset
fallocate04.c:143: TINFO: allocated file size before '12288' and after '819=
2'
fallocate04.c:66: TINFO: reading the file, compare with expected buffer
fallocate04.c:154: TPASS: test-case succeeded
fallocate04.c:159: TINFO: zeroing file space with FALLOC_FL_ZERO_RANGE
fallocate04.c:168: TINFO: read current allocated file size '8192'
fallocate04.c:174: TCONF: FALLOC_FL_ZERO_RANGE not supported

Summary:
passed   16
failed   0
broken   0
skipped  6
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D8 cstime=3D89
<<<test_end>>>
<<<test_start>>>
tag=3Dposix_fadvise03_64 stime=3D1631249132
cmdline=3D"posix_fadvise03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 0
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 1
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 2
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 3
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 4
posix_fadvise03.c:86: TPASS: skipping defined - advise =3D 5
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 6 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 7 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 8 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 9 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 10 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 11 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 12 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 13 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 14 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 15 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 16 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 17 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 18 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 19 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 20 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 21 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 22 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 23 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 24 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 25 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 26 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 27 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 28 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 29 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 30 : EINVAL
posix_fadvise03.c:104: TPASS: expected failure - returned value =3D 22, adv=
ise =3D 31 : EINVAL

Summary:
passed   32
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
tag=3Dposix_fadvise04 stime=3D1631249132
cmdline=3D"posix_fadvise04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE
posix_fadvise04.c:59: TPASS: expected failure - returned value =3D 29 : ESP=
IPE

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
tag=3Dfchown01_16 stime=3D1631249132
cmdline=3D"fchown01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/fchown/../utils/compat_tst_1=
6.h:143: TCONF: 16-bit version of fchown() is not supported on your platform

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
tag=3Dfchown02_16 stime=3D1631249132
cmdline=3D"fchown02_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/fchown/../utils/compat_tst_1=
6.h:143: TCONF: 16-bit version of fchown() is not supported on your platform

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
tag=3Dfcntl02 stime=3D1631249132
cmdline=3D"fcntl02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 0) returned 5
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 1) returned 5
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 2) returned 5
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 3) returned 5
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 10) returned 10
fcntl02.c:42: TPASS: fcntl(fcntl02_2936, F_DUPFD, 100) returned 100

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
tag=3Dfcntl03_64 stime=3D1631249132
cmdline=3D"fcntl03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fcntl03.c:33: TPASS: fcntl(fcntl03_2938, F_GETFD, 0) returned 0

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
tag=3Dfcntl04 stime=3D1631249132
cmdline=3D"fcntl04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fcntl04.c:39: TPASS: fcntl(fcntl04_2940, F_GETFL, 0) returned 8002

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
tag=3Dfcntl08 stime=3D1631249132
cmdline=3D"fcntl08"
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
tag=3Dfcntl13 stime=3D1631249132
cmdline=3D"fcntl13"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl13     1  TPASS  :  got EINVAL
fcntl13     2  TPASS  :  F_SETLK: got EFAULT
fcntl13     3  TPASS  :  F_SETLKW: got EFAULT
fcntl13     4  TPASS  :  F_GETLK: got EFAULT
fcntl13     5  TPASS  :  got EINVAL
fcntl13     6  TPASS  :  got EBADFD
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl15 stime=3D1631249132
cmdline=3D"fcntl15"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl15     1  TPASS  :  Test 1: test with "dup" PASSED
fcntl15     0  TINFO  :  Failed to record test working dir
fcntl15     2  TPASS  :  Test 2: test with "open" PASSED
fcntl15     0  TINFO  :  Failed to record test working dir
fcntl15     3  TPASS  :  Test 3: test with "fork" PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D10 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl17_64 stime=3D1631249142
cmdline=3D"fcntl17_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl17     0  TINFO  :  Enter preparation phase
fcntl17     0  TINFO  :  child 1 starting
fcntl17     0  TINFO  :  child 1 pid 2982 locked
fcntl17     0  TINFO  :  child 1 resuming
fcntl17     0  TINFO  :  child 1 unlocked
fcntl17     0  TINFO  :  child 1 exiting
fcntl17     0  TINFO  :  child 3 starting
fcntl17     0  TINFO  :  child 3 pid 2984 locked
fcntl17     0  TINFO  :  child 3 resuming
fcntl17     0  TINFO  :  child 3 lockw err 35
fcntl17     0  TINFO  :  child 3 exiting
fcntl17     0  TINFO  :  child 2 starting
fcntl17     0  TINFO  :  child 2 pid 2983 locked
fcntl17     0  TINFO  :  child 2 resuming
fcntl17     0  TINFO  :  child 2 lockw locked
fcntl17     0  TINFO  :  child 2 exiting
fcntl17     0  TINFO  :  Exit preparation phase
fcntl17     0  TINFO  :  Enter block 1
fcntl17     1  TPASS  :  Block 1 PASSED
fcntl17     0  TINFO  :  Exit block 1
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl19 stime=3D1631249142
cmdline=3D"fcntl19"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl19     0  TINFO  :  Enter block 1
fcntl19     0  TINFO  :  Test block 1: PASSED
fcntl19     0  TINFO  :  Exit block 1
fcntl19     0  TINFO  :  Enter block 2
fcntl19     0  TINFO  :  Test block 2: PASSED
fcntl19     0  TINFO  :  Exit block 2
fcntl19     0  TINFO  :  Enter block 3
fcntl19     0  TINFO  :  Test block 3: PASSED
fcntl19     0  TINFO  :  Exit block 3
fcntl19     0  TINFO  :  Enter blcok 4
fcntl19     0  TINFO  :  Test block 4: PASSED
fcntl19     0  TINFO  :  Exit block 4
fcntl19     0  TINFO  :  Enter block 5
fcntl19     0  TINFO  :  Test block 5: PASSED
fcntl19     0  TINFO  :  Exit block 5
fcntl19     0  TINFO  :  Enter block 6
fcntl19     0  TINFO  :  Test block 6: PASSED
fcntl19     0  TINFO  :  Exit block 6
fcntl19     0  TINFO  :  Enter block 7
fcntl19     0  TINFO  :  Test block 7: PASSED
fcntl19     0  TINFO  :  Exit block 7
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl20 stime=3D1631249142
cmdline=3D"fcntl20"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl20     0  TINFO  :  Enter block 1
fcntl20     0  TINFO  :  Test block 1: PASSED
fcntl20     0  TINFO  :  Exit block 1
fcntl20     0  TINFO  :  Enter block 2
fcntl20     0  TINFO  :  Test block 2: PASSED
fcntl20     0  TINFO  :  Exit block 2
fcntl20     0  TINFO  :  Enter block 3
fcntl20     0  TINFO  :  Test block 3: PASSED
fcntl20     0  TINFO  :  Exit block 3
fcntl20     0  TINFO  :  Enter blcok 4
fcntl20     0  TINFO  :  Test block 4: PASSED
fcntl20     0  TINFO  :  Exit block 4
fcntl20     0  TINFO  :  Enter block 5
fcntl20     0  TINFO  :  Test block 5: PASSED
fcntl20     0  TINFO  :  Exit block 5
fcntl20     0  TINFO  :  Enter block 6
fcntl20     0  TINFO  :  Test block 6: PASSED
fcntl20     0  TINFO  :  Exit block 6
fcntl20     0  TINFO  :  Enter block 7
fcntl20     0  TINFO  :  Test block 7: PASSED
fcntl20     0  TINFO  :  Exit block 7
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl20_64 stime=3D1631249142
cmdline=3D"fcntl20_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl20     0  TINFO  :  Enter block 1
fcntl20     0  TINFO  :  Test block 1: PASSED
fcntl20     0  TINFO  :  Exit block 1
fcntl20     0  TINFO  :  Enter block 2
fcntl20     0  TINFO  :  Test block 2: PASSED
fcntl20     0  TINFO  :  Exit block 2
fcntl20     0  TINFO  :  Enter block 3
fcntl20     0  TINFO  :  Test block 3: PASSED
fcntl20     0  TINFO  :  Exit block 3
fcntl20     0  TINFO  :  Enter blcok 4
fcntl20     0  TINFO  :  Test block 4: PASSED
fcntl20     0  TINFO  :  Exit block 4
fcntl20     0  TINFO  :  Enter block 5
fcntl20     0  TINFO  :  Test block 5: PASSED
fcntl20     0  TINFO  :  Exit block 5
fcntl20     0  TINFO  :  Enter block 6
fcntl20     0  TINFO  :  Test block 6: PASSED
fcntl20     0  TINFO  :  Exit block 6
fcntl20     0  TINFO  :  Enter block 7
fcntl20     0  TINFO  :  Test block 7: PASSED
fcntl20     0  TINFO  :  Exit block 7
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl26 stime=3D1631249142
cmdline=3D"fcntl26"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl26     1  TPASS  :  fcntl(tfile_2991, F_SETLEASE, F_WRLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl28_64 stime=3D1631249142
cmdline=3D"fcntl28_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl28     1  TPASS  :  fcntl(fd, F_SETLEASE, F_RDLCK) succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl31 stime=3D1631249142
cmdline=3D"fcntl31"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     1  TPASS  :  fcntl test F_GETOWN, F_SETOWN for process ID succe=
ss
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     2  TPASS  :  fcntl test F_GETOWN, F_SETOWN for process group ID=
 success
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     3  TPASS  :  fcntl test F_GETOWN_EX, F_SETOWN_EX for thread ID =
success
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     4  TPASS  :  fcntl test F_GETOWN_EX, F_SETOWN_EX for process ID=
 success
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     5  TPASS  :  fcntl test F_GETOWN_EX, F_SETOWN_EX for process gr=
oup ID success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl34_64 stime=3D1631249142
cmdline=3D"fcntl34_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fcntl34.c:90: TINFO: write to a file inside threads with OFD locks
fcntl34.c:36: TINFO: spawning '12' threads
fcntl34.c:45: TINFO: waiting for '12' threads
fcntl34.c:99: TINFO: verifying file's data
fcntl34.c:127: TPASS: OFD locks synchronized access between threads

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
tag=3Dfcntl37 stime=3D1631249142
cmdline=3D"fcntl37"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dfgetxattr01 stime=3D1631249142
cmdline=3D"fgetxattr01"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:122: TCONF: no xattr support in fs or mounted without user_xa=
ttr option
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ENODATA (61)
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: ERANGE (34)
fgetxattr01.c:88: TPASS: fgetxattr(2) passed
fgetxattr01.c:98: TPASS: got the right value
fgetxattr01.c:102: TPASS: fgetxattr(2) passed: SUCCESS (0)
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr01.c:122: TCONF: no xattr support in fs or mounted without user_xa=
ttr option

Summary:
passed   30
failed   0
broken   0
skipped  2
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D9 cstime=3D89
<<<test_end>>>
<<<test_start>>>
tag=3Dfgetxattr02 stime=3D1631249146
cmdline=3D"fgetxattr02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fgetxattr02.c:174: TPASS: fgetxattr(2) on testfile passed
fgetxattr02.c:188: TPASS: fgetxattr(2) on testfile got the right value
fgetxattr02.c:201: TPASS: fgetxattr(2) on testfile passed: SUCCESS (0)
fgetxattr02.c:174: TPASS: fgetxattr(2) on testdir passed
fgetxattr02.c:188: TPASS: fgetxattr(2) on testdir got the right value
fgetxattr02.c:201: TPASS: fgetxattr(2) on testdir passed: SUCCESS (0)
fgetxattr02.c:174: TPASS: fgetxattr(2) on symlink passed
fgetxattr02.c:188: TPASS: fgetxattr(2) on symlink got the right value
fgetxattr02.c:201: TPASS: fgetxattr(2) on symlink passed: SUCCESS (0)
fgetxattr02.c:201: TPASS: fgetxattr(2) on fifo passed: ENODATA (61)
fgetxattr02.c:201: TPASS: fgetxattr(2) on chr passed: ENODATA (61)
fgetxattr02.c:201: TPASS: fgetxattr(2) on blk passed: ENODATA (61)
fgetxattr02.c:201: TPASS: fgetxattr(2) on sock passed: ENODATA (61)

Summary:
passed   13
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
tag=3Dfork02 stime=3D1631249146
cmdline=3D"fork02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork02      0  TINFO  :  Inside parent
fork02      0  TINFO  :  exit status of wait 0
fork02      1  TPASS  :  test 1 PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork03 stime=3D1631249146
cmdline=3D"fork03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork03      0  TINFO  :  process id in parent of child from fork : 3125
fork03      1  TPASS  :  test 1 PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfork14 stime=3D1631249146
cmdline=3D"fork14"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fork14      1  TPASS  :  fork failed as expected.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D4 cstime=3D25
<<<test_end>>>
<<<test_start>>>
tag=3Dfpathconf01 stime=3D1631249147
cmdline=3D"fpathconf01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fpathconf01    1  TPASS  :  fpathconf(fd, _PC_MAX_CANON) returned 255
fpathconf01    2  TPASS  :  fpathconf(fd, _PC_MAX_INPUT) returned 255
fpathconf01    3  TPASS  :  fpathconf(fd, _PC_VDISABLE) returned 0
fpathconf01    4  TPASS  :  fpathconf(fd, _PC_LINK_MAX) returned 2147483647
fpathconf01    5  TPASS  :  fpathconf(fd, _PC_NAME_MAX) returned 255
fpathconf01    6  TPASS  :  fpathconf(fd, _PC_PATH_MAX) returned 4096
fpathconf01    7  TPASS  :  fpathconf(fd, _PC_PIPE_BUF) returned 4096
fpathconf01    8  TPASS  :  fpathconf(fd, _PC_CHOWN_RESTRICTED) returned 1
fpathconf01    9  TPASS  :  fpathconf(fd, _PC_NO_TRUNC) returned 1
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetdtablesize01 stime=3D1631249147
cmdline=3D"getdtablesize01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getdtablesize01    0  TINFO  :  Maximum number of files a process can have =
opened is 1024
getdtablesize01    0  TINFO  :  Checking with the value returned by getrlim=
it...RLIMIT_NOFILE
getdtablesize01    1  TPASS  :  got correct dtablesize, value is 1024
getdtablesize01    0  TINFO  :  Checking Max num of files that can be opene=
d by a process.Should be: RLIMIT_NOFILE - 1
getdtablesize01    2  TPASS  :  1023 =3D 1023
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dgetegid02 stime=3D1631249147
cmdline=3D"getegid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getegid02    1  TPASS  :  effective group id 0 is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgethostbyname_r01 stime=3D1631249147
cmdline=3D"gethostbyname_r01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
gethostbyname_r01    1  TPASS  :  not vulnerable
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetpgid01 stime=3D1631249147
cmdline=3D"getpgid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getpgid01    1  TPASS  :  getpgid(0) PASSED
getpgid01    2  TPASS  :  getpgid(getpid()) PASSED
getpgid01    3  TPASS  :  getpgid(getppid()) PASSED
getpgid01    4  TPASS  :  getpgid(3162) PASSED
getpgid01    5  TPASS  :  getpgid(1) PASSED
getpgid01    1  TPASS  :  getpgid01 PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetppid01 stime=3D1631249147
cmdline=3D"getppid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
getppid01.c:25: TPASS: getppid() returned 3164

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
tag=3Dgetpriority01 stime=3D1631249147
cmdline=3D"getpriority01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
getpriority01.c:50: TPASS: getpriority(0, 0) returned 0
getpriority01.c:50: TPASS: getpriority(1, 0) returned 0
getpriority01.c:50: TPASS: getpriority(2, 0) returned -20

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
tag=3Dgetresgid01 stime=3D1631249147
cmdline=3D"getresgid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresgid01    1  TPASS  :  Functionality of getresgid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresgid01_16 stime=3D1631249147
cmdline=3D"getresgid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresgid01    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresgid/../utils/compat_16.h:151: 16-bit version of getresgid() is not su=
pported on your platform
getresgid01    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresgid/../utils/compat_16.h:151: Remaining cases not appropriate for con=
figuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresgid02 stime=3D1631249147
cmdline=3D"getresgid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresgid02    1  TPASS  :  Functionality of getresgid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresuid01_16 stime=3D1631249147
cmdline=3D"getresuid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid01    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresuid/../utils/compat_16.h:141: 16-bit version of getresuid() is not su=
pported on your platform
getresuid01    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getresuid/../utils/compat_16.h:141: Remaining cases not appropriate for con=
figuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetrusage03 stime=3D1631249147
cmdline=3D"getrusage03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
getrusage03.c:43: TPASS: initial.self ~=3D child.self
getrusage03.c:57: TPASS: initial.children ~=3D 100MB
getrusage03.c:66: TPASS: child.children =3D=3D 0
getrusage03.c:84: TPASS: child.children ~=3D 300MB
getrusage03.c:104: TPASS: initial.children ~=3D pre_wait.children
getrusage03.c:112: TPASS: post_wait.children ~=3D 400MB
getrusage03.c:133: TPASS: initial.children ~=3D after_zombie.children
getrusage03_child.c:57: TPASS: initial.self ~=3D exec.self
getrusage03_child.c:62: TPASS: initial.children ~=3D exec.children

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D4 cstime=3D11
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsockopt01 stime=3D1631249147
cmdline=3D"getsockopt01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getsockopt01    1  TPASS  :  bad file descriptor successful
getsockopt01    2  TPASS  :  bad file descriptor successful
getsockopt01    3  TPASS  :  invalid option buffer successful
getsockopt01    4  TPASS  :  invalid optlen successful
getsockopt01    5  TPASS  :  invalid level successful
getsockopt01    6  TPASS  :  invalid option name successful
getsockopt01    7  TPASS  :  invalid option name (UDP) successful
getsockopt01    8  TPASS  :  invalid option name (IP) successful
getsockopt01    9  TPASS  :  invalid option name (TCP) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetuid03 stime=3D1631249147
cmdline=3D"getuid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getuid03    1  TPASS  :  values from getuid and getpwuid match
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl03 stime=3D1631249147
cmdline=3D"ioctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
ioctl03.c:76: TINFO: Available features are: 0x7133
ioctl03.c:81: TPASS: TUN 0x1
ioctl03.c:81: TPASS: TAP 0x2
ioctl03.c:81: TPASS: NO_PI 0x1000
ioctl03.c:81: TPASS: ONE_QUEUE 0x2000
ioctl03.c:81: TPASS: VNET_HDR 0x4000
ioctl03.c:81: TPASS: MULTI_QUEUE 0x100
ioctl03.c:81: TPASS: IFF_NAPI 0x10
ioctl03.c:81: TPASS: IFF_NAPI_FRAGS 0x20

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
tag=3Dioctl05 stime=3D1631249147
cmdline=3D"ioctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
ioctl05.c:35: TPASS: BLKGETSIZE returned 524288, BLKGETSIZE64 268435456
ioctl05.c:46: TPASS: Could lseek to the end of the device
ioctl05.c:53: TPASS: Got EOF when trying to read after the end of device

Summary:
passed   3
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
tag=3Dioctl09 stime=3D1631249147
cmdline=3D"ioctl09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
ioctl09.c:45: TPASS: access /sys/block/loop0/loop0p1 succeeds
ioctl09.c:53: TPASS: access /dev/loop0p1 succeeds
ioctl09.c:48: TPASS: access /sys/block/loop0/loop0p2 fails
ioctl09.c:56: TPASS: access /dev/loop0p2 fails
ioctl09.c:45: TPASS: access /sys/block/loop0/loop0p1 succeeds
ioctl09.c:53: TPASS: access /dev/loop0p1 succeeds
ioctl09.c:45: TPASS: access /sys/block/loop0/loop0p2 succeeds
ioctl09.c:53: TPASS: access /dev/loop0p2 succeeds

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D10
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_loop04 stime=3D1631249147
cmdline=3D"ioctl_loop04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
ioctl_loop04.c:35: TPASS: /sys/block/loop0/size =3D 20
ioctl_loop04.c:50: TPASS: LOOP_SET_CAPACITY set loop size to 5120
ioctl_loop04.c:56: TPASS: /sys/block/loop0/size =3D 10

Summary:
passed   3
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
tag=3Dioctl_ns07 stime=3D1631249148
cmdline=3D"ioctl_ns07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
ioctl_ns07.c:33: TPASS: request failed with ENOTTY
ioctl_ns07.c:33: TPASS: request failed with ENOTTY
ioctl_ns07.c:33: TPASS: request failed with ENOTTY
ioctl_ns07.c:33: TPASS: request failed with ENOTTY

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
tag=3Dinotify02 stime=3D1631249148
cmdline=3D"inotify02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D40000004 cookie=3D0     le=
n=3D0  name=3D""
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000100 cookie=3D0     le=
n=3D16 name=3D"test_file1"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000020 cookie=3D0     le=
n=3D16 name=3D"test_file1"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000008 cookie=3D0     le=
n=3D16 name=3D"test_file1"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000040 cookie=3D5369  le=
n=3D16 name=3D"test_file1"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000080 cookie=3D5369  le=
n=3D16 name=3D"test_file2"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000800 cookie=3D0     le=
n=3D0  name=3D""
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000200 cookie=3D0     le=
n=3D16 name=3D"test_file2"
inotify02.c:185: TPASS: get event: wd=3D1 mask=3D00000800 cookie=3D0     le=
n=3D0  name=3D""

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
tag=3Dinotify05 stime=3D1631249148
cmdline=3D"inotify05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
inotify05.c:115: TPASS: get event: wd=3D-1 mask=3D4000 cookie=3D0 len=3D0

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify04 stime=3D1631249148
cmdline=3D"fanotify04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify04.c:71: TPASS: fanotify_mark (4, FAN_MARK_ADD | FAN_MARK_ONLYDIR, =
FAN_OPEN, AT_FDCWD, '.') succeeded
fanotify04.c:71: TPASS: fanotify_mark (4, FAN_MARK_ADD | FAN_MARK_ONLYDIR, =
FAN_OPEN, AT_FDCWD, 'fname_3232') failed
fanotify04.c:71: TPASS: fanotify_mark (4, FAN_MARK_ADD | FAN_MARK_DONT_FOLL=
OW, FAN_OPEN, AT_FDCWD, 'symlink_3232') succeeded
fanotify04.c:163: TPASS: No event as expected
fanotify04.c:71: TPASS: fanotify_mark (4, FAN_MARK_ADD | 0, FAN_OPEN, AT_FD=
CWD, 'symlink_3232') succeeded
fanotify04.c:127: TPASS: event generated properly for type 100000
fanotify04.c:127: TPASS: event generated properly for type 100000
fanotify04.c:127: TPASS: event generated properly for type 40000
fanotify04.c:163: TPASS: No event as expected

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
tag=3Dfanotify13 stime=3D1631249148
cmdline=3D"fanotify13"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D 3a9bf3f6.369ce9a.c.11b880=
35.0...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D 3a9bf3f6.369ce9a.d.11b880=
36.0...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D 3a9bf3f6.369ce9a.8001.11b8=
8037.0...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3257, fid=3D3a9b=
f3f6.369ce9a.11b8803700008001 values returned in event match those returned=
 in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3257, fid=3D3a9b=
f3f6.369ce9a.11b8803700008001 values returned in event match those returned=
 in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880350000000c values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3257, fid=3D3a9bf3f6.3=
69ce9a.11b880360000000d values returned in event match those returned in st=
atfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3257, fid=3D3a9b=
f3f6.369ce9a.11b8803700008001 values returned in event match those returned=
 in statfs(2) and name_to_handle_at(2)
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D 16e0f68a.b0681152.1801.2a=
a5be63.0...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D 16e0f68a.b0681152.1802.7d=
a4539b.0...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D 16e0f68a.b0681152.d001.6ec=
3c398.0...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3269, fid=3D16e0=
f68a.b0681152.6ec3c3980000d001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3269, fid=3D16e0=
f68a.b0681152.6ec3c3980000d001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.2aa5be6300001801 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3269, fid=3D16e0f68a.b=
0681152.7da4539b00001802 values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3269, fid=3D16e0=
f68a.b0681152.6ec3c3980000d001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D edaf6cb6.7305ba46.c.1b149=
9fa.0...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D edaf6cb6.7305ba46.d.37d1e=
7b7.0...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D edaf6cb6.7305ba46.8001.aef=
06912.0...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3275, fid=3Dedaf=
6cb6.7305ba46.aef0691200008001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3275, fid=3Dedaf=
6cb6.7305ba46.aef0691200008001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.1b1499fa0000000c values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3275, fid=3Dedaf6cb6.7=
305ba46.37d1e7b70000000d values returned in event match those returned in s=
tatfs(2) and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3275, fid=3Dedaf=
6cb6.7305ba46.aef0691200008001 values returned in event match those returne=
d in statfs(2) and name_to_handle_at(2)
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D 700.0.83.0.6bf97bb1...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D 700.0.84.0.b0b51c66...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D 700.0.85.0.2e9660c7...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3288, fid=3D700.=
0.85 values returned in event match those returned in statfs(2) and name_to=
_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3288, fid=3D700.=
0.85 values returned in event match those returned in statfs(2) and name_to=
_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.83 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3288, fid=3D700.0.84 v=
alues returned in event match those returned in statfs(2) and name_to_handl=
e_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3288, fid=3D700.=
0.85 values returned in event match those returned in statfs(2) and name_to=
_handle_at(2)
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D 28ecf5ed.aa028c92.101.0.5=
=2E..
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D 28ecf5ed.aa028c92.102.0.5=
=2E..
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D 28ecf5ed.aa028c92.103.0.5.=
=2E.
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3314, fid=3D28ec=
f5ed.aa028c92.103 values returned in event match those returned in statfs(2=
) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3314, fid=3D28ec=
f5ed.aa028c92.103 values returned in event match those returned in statfs(2=
) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.101 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3314, fid=3D28ecf5ed.a=
a028c92.102 values returned in event match those returned in statfs(2) and =
name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3314, fid=3D28ec=
f5ed.aa028c92.103 values returned in event match those returned in statfs(2=
) and name_to_handle_at(2)
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D 700.0.73.991080e3.0...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D 700.0.74.773a70fb.0...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D 700.0.75.d2ce284a.0...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3316, fid=3D700.=
0.d2ce284a00000075 values returned in event match those returned in statfs(=
2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3316, fid=3D700.=
0.d2ce284a00000075 values returned in event match those returned in statfs(=
2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.9910=
80e300000073 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3316, fid=3D700.0.773a=
70fb00000074 values returned in event match those returned in statfs(2) and=
 name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3316, fid=3D700.=
0.d2ce284a00000075 values returned in event match those returned in statfs(=
2) and name_to_handle_at(2)
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify13.c:262: TCONF: FAN_REPORT_FID not supported on ntfs filesystem
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
fanotify.h:240: TINFO: fid(mntpoint/file_one) =3D e357afa9.6126c96.c5e9315f=
=2E2.0...
fanotify.h:240: TINFO: fid(mntpoint/file_two) =3D e357afa9.6126c96.4ea2f435=
=2E3.0...
fanotify.h:240: TINFO: fid(mntpoint/dir_one) =3D e357afa9.6126c96.15e1e53a.=
4.0...
fanotify13.c:146: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_I=
NODE
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3330, fid=3De357=
afa9.6126c96.415e1e53a values returned in event match those returned in sta=
tfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_M=
OUNT
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3330, fid=3De357=
afa9.6126c96.415e1e53a values returned in event match those returned in sta=
tfs(2) and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:146: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_F=
ILESYSTEM
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.2c5e9315f values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D30, pid=3D3330, fid=3De357afa9.6=
126c96.34ea2f435 values returned in event match those returned in statfs(2)=
 and name_to_handle_at(2)
fanotify13.c:254: TPASS: got event: mask=3D40000030, pid=3D3330, fid=3De357=
afa9.6126c96.415e1e53a values returned in event match those returned in sta=
tfs(2) and name_to_handle_at(2)

Summary:
passed   105
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D9 cstime=3D90
<<<test_end>>>
<<<test_start>>>
tag=3Dio_getevents02 stime=3D1631249152
cmdline=3D"io_getevents02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
io_getevents02.c:35: TPASS: io_getevents() failed with EINVAL

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
tag=3Dkeyctl01 stime=3D1631249152
cmdline=3D"keyctl01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
keyctl01.c:27: TPASS: KEYCTL_GET_KEYRING_ID succeeded
keyctl01.c:48: TPASS: KEYCTL_REVOKE failed as expected: ENOKEY (126)

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
tag=3Dkcmp02 stime=3D1631249152
cmdline=3D"kcmp02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
kcmp02.c:83: TPASS: kcmp() returned the expected value: ESRCH (3)
kcmp02.c:83: TPASS: kcmp() returned the expected value: EINVAL (22)
kcmp02.c:83: TPASS: kcmp() returned the expected value: EINVAL (22)
kcmp02.c:83: TPASS: kcmp() returned the expected value: EINVAL (22)
kcmp02.c:83: TPASS: kcmp() returned the expected value: EINVAL (22)
kcmp02.c:83: TPASS: kcmp() returned the expected value: EBADF (9)

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
tag=3Dkcmp03 stime=3D1631249152
cmdline=3D"kcmp03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
kcmp03.c:64: TPASS: kcmp() returned the expected value
kcmp03.c:64: TPASS: kcmp() returned the expected value
kcmp03.c:64: TPASS: kcmp() returned the expected value
kcmp03.c:64: TPASS: kcmp() returned the expected value

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
tag=3Dlink06 stime=3D1631249152
cmdline=3D"link06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link06      1  TPASS  :  link() fails with expected error EACCES errno:13
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlink07 stime=3D1631249152
cmdline=3D"link07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
link07      1  TPASS  :  link() fails with expected error: TEST_ERRNO=3DEAC=
CES(13): Permission denied
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dllistxattr03 stime=3D1631249152
cmdline=3D"llistxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
llistxattr03.c:55: TPASS: llistxattr() succeed with suitable buffer
llistxattr03.c:55: TPASS: llistxattr() succeed with suitable buffer

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
tag=3Dlremovexattr01 stime=3D1631249152
cmdline=3D"lremovexattr01"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:115: TCONF: symlink() not supported
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lremovexattr01.c:107: TPASS: lremovexattr(2) removed attribute as expected

Summary:
passed   7
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D9 cstime=3D88
<<<test_end>>>
<<<test_start>>>
tag=3Dlseek01 stime=3D1631249157
cmdline=3D"lseek01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lseek01.c:67: TPASS: lseek(tfile, 4, SEEK_SET) read correct data
lseek01.c:67: TPASS: lseek(tfile, -2, SEEK_CUR) read correct data
lseek01.c:67: TPASS: lseek(tfile, -4, SEEK_END) read correct data
lseek01.c:67: TPASS: lseek(tfile, 0, SEEK_END) read correct data

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
tag=3Dlseek07 stime=3D1631249157
cmdline=3D"lseek07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
lseek07.c:70: TPASS: lseek(tfile1, 7, SEEK_SET) wrote correct data abcdefgi=
jk
lseek07.c:70: TPASS: lseek(tfile2, 2, SEEK_SET) wrote correct data abijkfg

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
tag=3Dmallinfo02 stime=3D1631249157
cmdline=3D"mallinfo02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
mallinfo02.c:28: TPASS: malloc() uses sbrk when size < 128k
mallinfo02.c:41: TPASS: malloc() uses mmap when size >=3D 128k

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
tag=3Dmallopt01 stime=3D1631249157
cmdline=3D"mallopt01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
mallopt01.c:41: TPASS: mallinfo() succeeded
mallopt01.c:48: TPASS: mallopt(M_MXFAST, 160) succeeded
mallopt01.c:53: TPASS: malloc(1024) succeeded
mallopt01.c:60: TPASS: mallopt(M_MXFAST, 0) succeeded
mallopt01.c:65: TPASS: malloc(1024) succeeded

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
tag=3Dmigrate_pages03 stime=3D1631249157
cmdline=3D"migrate_pages03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
migrate_pages03.c:60: TCONF: requires NUMA with at least 2 node

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
tag=3Dmlockall02 stime=3D1631249157
cmdline=3D"mlockall02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mlockall02    1  TPASS  :  expected failure - errno =3D 12 : Cannot allocat=
e memory
mlockall02    2  TPASS  :  expected failure - errno =3D 1 : Operation not p=
ermitted
mlockall02    3  TPASS  :  expected failure - errno =3D 22 : Invalid argume=
nt
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmkdir02 stime=3D1631249157
cmdline=3D"mkdir02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
mkdir02.c:56: TINFO: Found unused GID 11: SUCCESS (0)
mkdir02.c:46: TPASS: New dir inherited GID and S_ISGID

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
tag=3Dmkdir04 stime=3D1631249157
cmdline=3D"mkdir04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
mkdir04.c:37: TPASS: mkdir() failed expectedly: EACCES (13)

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
tag=3Dmknodat01 stime=3D1631249157
cmdline=3D"mknodat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mknodat01    1  TPASS  :  mknodat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mknodat01    2  TPASS  :  mknodat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mknodat01    3  TPASS  :  mknodat() returned -1: TEST_ERRNO=3DENOTDIR(20): =
Not a directory
mknodat01    4  TPASS  :  mknodat() returned -1: TEST_ERRNO=3DEBADF(9): Bad=
 file descriptor
mknodat01    5  TPASS  :  mknodat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmlock02 stime=3D1631249157
cmdline=3D"mlock02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mlock02     1  TPASS  :  mlock failed as expected: TEST_ERRNO=3DENOMEM(12):=
 Cannot allocate memory
mlock02     2  TPASS  :  mlock failed as expected: TEST_ERRNO=3DENOMEM(12):=
 Cannot allocate memory
mlock02     3  TPASS  :  mlock failed as expected: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmlock04 stime=3D1631249157
cmdline=3D"mlock04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mlock04     0  TINFO  :  locked 40960 bytes from 0x7f5952b33000
mlock04     1  TPASS  :  test succeeded.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dqmm01 stime=3D1631249157
cmdline=3D"mmap001 -m 1"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap001     0  TINFO  :  mmap()ing file of 1 pages or 4096 bytes
mmap001     1  TPASS  :  mmap() completed successfully.
mmap001     0  TINFO  :  touching mmaped memory
mmap001     2  TPASS  :  we're still here, mmaped area must be good
mmap001     3  TPASS  :  synchronizing mmapped page passed
mmap001     4  TPASS  :  munmapping testfile.3462 successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap04 stime=3D1631249157
cmdline=3D"mmap04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap04      1  TPASS  :  Functionality of mmap() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap05 stime=3D1631249157
cmdline=3D"mmap05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap05      1  TPASS  :  Got SIGSEGV as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmmap12 stime=3D1631249157
cmdline=3D"mmap12"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
mmap12.c:90: TINFO: All pages are present
mmap12.c:114: TPASS: File mapped properly

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
tag=3Dmmap13 stime=3D1631249157
cmdline=3D"mmap13"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mmap13      1  TPASS  :  Got SIGBUS as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmodify_ldt03 stime=3D1631249157
cmdline=3D"modify_ldt03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
modify_ldt03    1  TCONF  :  modify_ldt03.c:94: modify_ldt is available but=
 not tested on the platform than __i386__
modify_ldt03    2  TCONF  :  modify_ldt03.c:94: Remaining cases not appropr=
iate for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages12 stime=3D1631249157
cmdline=3D"move_pages12"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
move_pages_support.c:407: TCONF: at least 2 allowed NUMA nodes are required

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
tag=3Dmprotect04 stime=3D1631249157
cmdline=3D"mprotect04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mprotect04    1  TPASS  :  test PROT_NONE for mprotect success
mprotect04    0  TINFO  :  exec_func: 0x561688f50d80, page_to_copy: 0x56168=
8f50000
mprotect04    2  TPASS  :  test PROT_EXEC for mprotect success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap05 stime=3D1631249157
cmdline=3D"mremap05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mremap05    1  TPASS  :  MREMAP_FIXED requires MREMAP_MAYMOVE
mremap05    2  TPASS  :  new_addr has to be page aligned
mremap05    3  TPASS  :  old/new area must not overlap
mremap05    4  TPASS  :  mremap #1
mremap05    5  TPASS  :  mremap #1 value OK
mremap05    6  TPASS  :  mremap #2
mremap05    7  TPASS  :  mremap #2 value OK
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgctl03 stime=3D1631249157
cmdline=3D"msgctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msgctl03.c:30: TPASS: msgctl(IPC_RMID)
msgctl03.c:34: TPASS: msgctl(IPC_STAT): EINVAL (22)

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
tag=3Dmsgrcv06 stime=3D1631249157
cmdline=3D"msgrcv06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msgrcv06.c:28: TPASS: msgrcv(1, 0x55a06e983660, 1024, 1, 0) : EIDRM (43)

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
tag=3Dmsync02 stime=3D1631249157
cmdline=3D"msync02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
msync02     1  TPASS  :  Functionality of msync successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmsync04 stime=3D1631249157
cmdline=3D"msync04"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:72: TPASS: msync() working correctly
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
msync04.c:60: TFAIL: Expected dirty bit to be set after writing to mmap()-e=
d area

Summary:
passed   6
failed   1
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D7 cstime=3D90
<<<test_end>>>
<<<test_start>>>
tag=3Dnice01 stime=3D1631249161
cmdline=3D"nice01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
nice01.c:48: TPASS: nice(-12) passed

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
tag=3Dopen01A stime=3D1631249161
cmdline=3D"symlink01 -T open01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open01      1  TPASS  :  open(2) with (O_CREAT | O_RDWR) to create object f=
ile through symbolic link file and all writes, reads, and lseeks are ok
open01      2  TPASS  :  open(2) with O_RDWR of existing  object file throu=
gh symbolic link file and all writes, reads, and lseeks are ok
open01      3  TPASS  :  open(2) with (O_CREAT | O_EXCL) error  is caught w=
hen creating object file through symbolic link file
open01      4  TPASS  :  open(2) error with O_RDWR is caught when processin=
g symbolic link file which points at no object file
open01      5  TPASS  :  Nested symbolic link access condition caught.  ELO=
OP is returned
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmadvise10 stime=3D1631249161
cmdline=3D"madvise10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
madvise10.c:134: TINFO: MADV_WIPEONFORK zeroes memory in child
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x0)
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x12)
madvise10.c:89: TPASS: In PID 3581, Matched expected pattern
madvise10.c:134: TINFO: MADV_WIPEONFORK with zero length does nothing
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 0, 0x0)
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 0, 0x12)
madvise10.c:89: TPASS: In PID 3582, Matched expected pattern
madvise10.c:134: TINFO: MADV_WIPEONFORK zeroes memory in grand-child
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x0)
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x12)
madvise10.c:89: TPASS: In PID 3584, Matched expected pattern
madvise10.c:134: TINFO: MADV_KEEPONFORK will undo MADV_WIPEONFORK
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x12)
madvise10.c:108: TPASS: madvise(0x7fd76a69c000, 16384, 0x13)
madvise10.c:89: TPASS: In PID 3585, Matched expected pattern

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
tag=3Dpause01 stime=3D1631249161
cmdline=3D"pause01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
pause01.c:24: TPASS: pause() interrupted with EINTR

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
tag=3Dpersonality01 stime=3D1631249161
cmdline=3D"personality01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
personality01    1  TPASS  :  personality(PER_LINUX)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_LINUX_32BIT)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_SVR4)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_SVR3)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_SCOSVR3)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_OSR5)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_WYSEV386)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_ISCR4)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_BSD)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_XENIX)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_LINUX32)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_IRIX32)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_IRIXN32)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_IRIX64)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_RISCOS)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_SOLARIS)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_UW7)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_OSF4)
personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TPASS  :  personality(PER_HPUX)
personality01    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe01 stime=3D1631249161
cmdline=3D"pipe01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
pipe01.c:48: TPASS: pipe() functionality is correct

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
tag=3Dpoll01 stime=3D1631249161
cmdline=3D"poll01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
poll01.c:42: TPASS: poll() POLLOUT
poll01.c:69: TPASS: poll() POLLIN

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
tag=3Dpread03_64 stime=3D1631249161
cmdline=3D"pread03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pread03     1  TPASS  :  pread() fails with expected error EISDIR errno:21
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpreadv202_64 stime=3D1631249161
cmdline=3D"preadv202_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
preadv202.c:82: TPASS: preadv2() failed as expected: EINVAL (22)
preadv202.c:82: TPASS: preadv2() failed as expected: EINVAL (22)
preadv202.c:82: TPASS: preadv2() failed as expected: EOPNOTSUPP (95)
preadv202.c:82: TPASS: preadv2() failed as expected: EFAULT (14)
preadv202.c:82: TPASS: preadv2() failed as expected: EBADF (9)
preadv202.c:82: TPASS: preadv2() failed as expected: EBADF (9)
preadv202.c:82: TPASS: preadv2() failed as expected: EISDIR (21)
preadv202.c:82: TPASS: preadv2() failed as expected: ESPIPE (29)

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
tag=3Dprocess_vm_writev02 stime=3D1631249161
cmdline=3D"process_vm_writev02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
process_vm_writev02    0  TINFO  :  child 2: write to the same memory locat=
ion.
process_vm_writev02    0  TINFO  :  child 0: memory allocated.
process_vm_writev02    1  TPASS  :  child 0: all bytes are expected.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpselect03 stime=3D1631249161
cmdline=3D"pselect03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
pselect03.c:31: TPASS: pselect() succeeded retval=3D0

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
tag=3Dptrace07 stime=3D1631249161
cmdline=3D"ptrace07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
ptrace07.c:138: TINFO: PTRACE_SETREGSET with reserved bits failed with EINV=
AL
ptrace07.c:161: TINFO: test child 3623 exited, retcode: 0
ptrace07.c:174: TPASS: wasn't able to set invalid FPU state

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D168 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dquotactl07 stime=3D1631249162
cmdline=3D"quotactl07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
quotactl07.c:32: TPASS: Q_XQUOTARM has quota type check

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Drealpath01 stime=3D1631249163
cmdline=3D"realpath01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
realpath01.c:35: TPASS: bug not reproduced

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
tag=3Drecvmsg03 stime=3D1631249163
cmdline=3D"recvmsg03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
recvmsg03.c:38: TCONF: rds was not supported

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
tag=3Drename03 stime=3D1631249163
cmdline=3D"rename03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
rename03    1  TPASS  :  functionality is correct for renaming a file
rename03    2  TPASS  :  functionality is correct for renaming a directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Drename11 stime=3D1631249163
cmdline=3D"rename11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
rename11    0  TINFO  :  Found free device 0 '/dev/loop0'
rename11    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
rename11    0  TINFO  :  subdir limit is not availiable for xfs filesystem
rename11    1  TPASS  :  failed as expected: TEST_ERRNO=3DELOOP(40): Too ma=
ny levels of symbolic links
rename11    2  TPASS  :  failed as expected: TEST_ERRNO=3DEROFS(30): Read-o=
nly file system
rename11    3  TCONF  :  rename11.c:167: EMLINK test is not appropriate
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Drequest_key04 stime=3D1631249163
cmdline=3D"request_key04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
request_key04.c:66: TPASS: request_key() failed with EACCES as expected

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
tag=3Dsched_get_priority_min02 stime=3D1631249163
cmdline=3D"sched_get_priority_min02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_get_priority_min02    1  TPASS  :  Test Passed, Got EINVAL
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_getparam03 stime=3D1631249163
cmdline=3D"sched_getparam03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_getparam03.c:53: TINFO: Testing libc variant
sched_getparam03.c:48: TPASS: sched_getparam() with non-existing pid : ESRC=
H (3)
sched_getparam03.c:48: TPASS: sched_getparam() with invalid pid : EINVAL (2=
2)
sched_getparam03.c:48: TPASS: sched_getparam() with invalid address for par=
am : EINVAL (22)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_getparam03.c:53: TINFO: Testing syscall variant
sched_getparam03.c:48: TPASS: sched_getparam() with non-existing pid : ESRC=
H (3)
sched_getparam03.c:48: TPASS: sched_getparam() with invalid pid : EINVAL (2=
2)
sched_getparam03.c:48: TPASS: sched_getparam() with invalid address for par=
am : EINVAL (22)

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
tag=3Dsched_setparam05 stime=3D1631249163
cmdline=3D"sched_setparam05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_setparam05.c:42: TINFO: Testing libc variant
sched_setparam05.c:32: TPASS: sched_setparam(3669, 0) : EPERM (1)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_setparam05.c:42: TINFO: Testing syscall variant
sched_setparam05.c:32: TPASS: sched_setparam(3671, 0) : EPERM (1)

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
tag=3Dsched_setscheduler01 stime=3D1631249163
cmdline=3D"sched_setscheduler01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_setscheduler01.c:59: TINFO: Testing libc variant
sched_setscheduler01.c:71: TPASS: sched_setscheduler(32768, 0, 0x556dd6c949=
54) : ESRCH (3)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(1, 99, 0x556dd6c94954)=
 : EINVAL (22)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(1, 0, 0xffffffffffffff=
ff) : EFAULT (14)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(0, 0, 0x556dd6c94614) =
: EINVAL (22)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sched_setscheduler01.c:59: TINFO: Testing syscall variant
sched_setscheduler01.c:71: TPASS: sched_setscheduler(32768, 0, 0x556dd6c949=
54) : ESRCH (3)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(1, 99, 0x556dd6c94954)=
 : EINVAL (22)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(1, 0, 0xffffffffffffff=
ff) : EFAULT (14)
sched_setscheduler01.c:71: TPASS: sched_setscheduler(0, 0, 0x556dd6c94614) =
: EINVAL (22)

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
tag=3Dselect04 stime=3D1631249163
cmdline=3D"select04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
select_var.h:109: TINFO: Testing libc select()
select04.c:58: TPASS: No data to read: select() cleared the fd set
select04.c:58: TPASS: No space to write: select() cleared the fd set
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
select_var.h:112: TINFO: Testing SYS_select syscall
select04.c:58: TPASS: No data to read: select() cleared the fd set
select04.c:58: TPASS: No space to write: select() cleared the fd set
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
select_var.h:115: TINFO: Testing SYS_pselect6 syscall
select04.c:58: TPASS: No data to read: select() cleared the fd set
select04.c:58: TPASS: No space to write: select() cleared the fd set
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
select_var.h:118: TINFO: Testing SYS_pselect6 time64 syscall
select_var.h:83: TCONF: __NR_pselect6 time64 variant not supported
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
select_var.h:121: TINFO: Testing SYS__newselect syscall
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported

Summary:
passed   6
failed   0
broken   0
skipped  2
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D3 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dsemctl02 stime=3D1631249163
cmdline=3D"semctl02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
semctl02.c:29: TPASS: semctl(IPC_STAT) with nobody user : EACCES (13)

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
tag=3Dsemop01 stime=3D1631249163
cmdline=3D"semop01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
semop01.c:71: TINFO: Testing variant: semop: syscall
semop01.c:58: TPASS: semaphore values are correct
semop01.c:58: TPASS: semaphore values are correct
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
semop01.c:71: TINFO: Testing variant: semtimedop: syscall with old kernel s=
pec
semop01.c:58: TPASS: semaphore values are correct
semop01.c:58: TPASS: semaphore values are correct

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
tag=3Dsendfile05_64 stime=3D1631249163
cmdline=3D"sendfile05_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sendfile05.c:42: TPASS: sendfile(out, in, &offset, ..) with offset=3D-1 : E=
INVAL (22)

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
tag=3Dsendfile06 stime=3D1631249163
cmdline=3D"sendfile06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sendfile06.c:61: TPASS: sendfile() with offset=3DNULL

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
tag=3Dsendmmsg02 stime=3D1631249163
cmdline=3D"sendmmsg02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sendmmsg02.c:56: TINFO: Testing variant: vDSO or syscall with libc spec
sendmmsg02.c:49: TPASS: sendmmsg() bad file descriptor : EBADF (9)
sendmmsg02.c:49: TPASS: sendmmsg() invalid msgvec address : EFAULT (14)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sendmmsg02.c:56: TINFO: Testing variant: syscall with old kernel spec
sendmmsg02.c:49: TPASS: sendmmsg() bad file descriptor : EBADF (9)
sendmmsg02.c:49: TPASS: sendmmsg() invalid msgvec address : EFAULT (14)

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
tag=3Dsendto01 stime=3D1631249163
cmdline=3D"sendto01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendto01    1  TPASS  :  bad file descriptor successful
sendto01    2  TPASS  :  invalid socket successful
sendto01    3  TPASS  :  invalid send buffer successful
sendto01    4  TPASS  :  connected TCP successful
sendto01    5  TPASS  :  not connected TCP successful
sendto01    6  TPASS  :  invalid to buffer length successful
sendto01    7  TPASS  :  invalid to buffer successful
sendto01    8  TPASS  :  UDP message too big successful
sendto01    9  TPASS  :  local endpoint shutdown successful
sendto01   10  TPASS  :  invalid flags set successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dset_mempolicy04 stime=3D1631249163
cmdline=3D"set_mempolicy04"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy04.c:48: TCONF: Test requires at least two NUMA memory nodes

Summary:
passed   0
failed   0
broken   0
skipped  8
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D1 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dsetdomainname03 stime=3D1631249164
cmdline=3D"setdomainname03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:36: TINFO: Testing libc setdomainname()
setdomainname03.c:32: TPASS: expected failure: EPERM (1)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:39: TINFO: Testing __NR_setdomainname syscall
setdomainname03.c:32: TPASS: expected failure: EPERM (1)

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
tag=3Dsetfsuid03 stime=3D1631249164
cmdline=3D"setfsuid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsuid03    1  TPASS  :  setfsuid() returned expected value : 65534
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgid01 stime=3D1631249164
cmdline=3D"setgid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setgid01.c:21: TPASS: SETGID(gid) passed

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
tag=3Dsetegid01 stime=3D1631249164
cmdline=3D"setegid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setegid01    0  TINFO  :  getresgid reports rgid 0, egid 0, sgid 0
setegid01    0  TINFO  :  calling setegid(nobody_gid 65534)
setegid01    0  TINFO  :  getresgid reports rgid 0, egid 65534, sgid 0
setegid01    1  TPASS  :  setegid() passed functional test
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgroups01 stime=3D1631249164
cmdline=3D"setgroups01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgroups01    1  TPASS  :  setgroups(65536, list) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgroups02 stime=3D1631249164
cmdline=3D"setgroups02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgroups02    1  TPASS  :  Functionality of setgroups(1, groups_list) succ=
essful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgroups04 stime=3D1631249164
cmdline=3D"setgroups04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgroups04    1  TPASS  :  setgroups() fails with expected error EFAULT er=
rno:14
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsethostname02 stime=3D1631249164
cmdline=3D"sethostname02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname.h:36: TINFO: Testing libc sethostname()
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing len =3D=3D -1
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EINVAL (22)
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing len > allowed maximum
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EINVAL (22)
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing name =3D=3D NULL
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EFAULT (14)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname.h:39: TINFO: Testing __NR_sethostname syscall
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing len =3D=3D -1
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EINVAL (22)
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing len > allowed maximum
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EINVAL (22)
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:32: TINFO: testing name =3D=3D NULL
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/sethostname/../setdomainname=
/setdomainname02.c:44: TPASS: expected failure: EFAULT (14)

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
tag=3Dsetpgid02 stime=3D1631249164
cmdline=3D"setpgid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setpgid02    1  TPASS  :  expected failure - errno =3D 22 : Invalid argument
setpgid02    2  TPASS  :  expected failure - errno =3D 3 : No such process
setpgid02    3  TPASS  :  expected failure - errno =3D 1 : Operation not pe=
rmitted
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetregid03 stime=3D1631249164
cmdline=3D"setregid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setregid03.c:61: TINFO: getgrnam(nobody) failed - try fallback nogroup
setregid03.c:95: TPASS: setregid(1, 2) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(-1, 1) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(-1, 2) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(2, -1) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(-1, -1) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(-1, 2) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(2, -1) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:95: TPASS: setregid(2, 2) succeeded as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:105: TPASS: setregid(1, -1) failed as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:105: TPASS: setregid(-1, 1) failed as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected
setregid03.c:105: TPASS: setregid(1, 1) failed as expected
setregid03.c:121: TPASS: real or effective gid was modified as expected

Summary:
passed   22
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresgid01_16 stime=3D1631249164
cmdline=3D"setresgid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresgid01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresgid/../utils/compat_16.h:146: 16-bit version of setresgid() is not=
 supported on your platform
setresgid01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresgid/../utils/compat_16.h:146: Remaining cases not appropriate for =
configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetresuid01_16 stime=3D1631249164
cmdline=3D"setresuid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setresuid01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresuid/../utils/compat_16.h:136: 16-bit version of setresuid() is not=
 supported on your platform
setresuid01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setresuid/../utils/compat_16.h:136: Remaining cases not appropriate for =
configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetreuid05 stime=3D1631249164
cmdline=3D"setreuid05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setreuid05    1  TPASS  :  setreuid(65534, 0) succeeded as expected.
setreuid05    2  TPASS  :  setreuid(-1, 65534) succeeded as expected.
setreuid05    3  TPASS  :  setreuid(-1, 0) succeeded as expected.
setreuid05    4  TPASS  :  setreuid(1, -1) succeeded as expected.
setreuid05    5  TPASS  :  setreuid(-1, 2) succeeded as expected.
setreuid05    6  TPASS  :  setreuid(-1, 0) succeeded as expected.
setreuid05    7  TPASS  :  setreuid(-1, 65534) succeeded as expected.
setreuid05    8  TPASS  :  setreuid(-1, 1) succeeded as expected.
setreuid05    9  TPASS  :  setreuid(-1, 2) succeeded as expected.
setreuid05   10  TPASS  :  setreuid(2, 1) succeeded as expected.
setreuid05   11  TPASS  :  setreuid(-1, 2) succeeded as expected.
setreuid05   12  TPASS  :  setreuid(-1, 1) succeeded as expected.
setreuid05   13  TPASS  :  setreuid(1, -1) succeeded as expected.
setreuid05   14  TPASS  :  setreuid(-1, 2) succeeded as expected.
setreuid05    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetrlimit03 stime=3D1631249164
cmdline=3D"setrlimit03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setrlimit03.c:55: TPASS: setrlimit() failed as expected: EPERM (1)
setrlimit03.c:55: TPASS: setrlimit() failed as expected: EINVAL (22)

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
tag=3Dsetrlimit05 stime=3D1631249164
cmdline=3D"setrlimit05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setrlimit05.c:38: TPASS: setrlimit() failed as expected: EFAULT (14)

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
tag=3Dsetrlimit06 stime=3D1631249164
cmdline=3D"setrlimit06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setrlimit06.c:86: TPASS: Got SIGXCPU then SIGKILL after reaching both limit

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D201 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetsockopt04 stime=3D1631249166
cmdline=3D"setsockopt04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
setsockopt04.c:39: TINFO: Try to set send buffer size to: 4294967040
setsockopt04.c:40: TINFO: Send buffer size was set to: 4608
setsockopt04.c:45: TPASS: Was unable to set negative send buffer size!

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
tag=3Dsetuid03_16 stime=3D1631249166
cmdline=3D"setuid03_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/setuid/../utils/compat_tst_1=
6.h:84: TCONF: 16-bit version of setuid() is not supported on your platform

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
tag=3Dshmctl03 stime=3D1631249166
cmdline=3D"shmctl03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
shmctl03.c:34: TPASS: shmmin =3D 1
shmctl03.c:36: TPASS: /proc/sys/kernel/shmmax =3D 18446744073692774399
shmctl03.c:37: TPASS: /proc/sys/kernel/shmmni =3D 4096
shmctl03.c:38: TPASS: /proc/sys/kernel/shmall =3D 18446744073692774399

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
tag=3Dshmget06 stime=3D1631249166
cmdline=3D"shmget06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
shmget06.c:41: TPASS: shm id 3772 has existed, shmget() returns the new shm=
 id 3773

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
tag=3Dsignal06 stime=3D1631249166
cmdline=3D"signal06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal06    0  TINFO  :  loop =3D 30000
signal06    1  TPASS  :  signal06 call succeeded
signal06    0  TINFO  :  loop =3D 30000
signal06    2  TPASS  :  signal06 call succeeded
signal06    0  TINFO  :  loop =3D 30000
signal06    3  TPASS  :  signal06 call succeeded
signal06    0  TINFO  :  loop =3D 30000
signal06    4  TPASS  :  signal06 call succeeded
signal06    0  TINFO  :  loop =3D 30000
signal06    5  TPASS  :  signal06 call succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D26 cstime=3D162
<<<test_end>>>
<<<test_start>>>
tag=3Dsigtimedwait01 stime=3D1631249167
cmdline=3D"sigtimedwait01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sigwait.c:27: TPASS: Wait interrupted by expected signal
sigwait.c:88: TPASS: struct siginfo is correct
sigwait.c:148: TPASS: struct siginfo is correct
sigwait.c:160: TPASS: sigwaitinfo restored the original mask
sigwait.c:113: TPASS: Wait interrupted by expected signal
sigwait.c:259: TPASS: Wait interrupted by expected signal
sigwait.c:268: TPASS: sigwaitinfo restored the original mask
sigwait.c:302: TPASS: Fault occurred while accessing the buffers
sigwait.c:344: TPASS: Child exited with expected code
sigwait.c:367: TPASS: Fault occurred while accessing the buffers
sigwait.c:57: TPASS: Wait interrupted by timeout

Summary:
passed   11
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
tag=3Dsigwait01 stime=3D1631249168
cmdline=3D"sigwait01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
sigwait.c:113: TPASS: Wait interrupted by expected signal
sigwait.c:259: TPASS: Wait interrupted by expected signal
sigwait.c:268: TPASS: sigwaitinfo restored the original mask

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
tag=3Dsocket01 stime=3D1631249169
cmdline=3D"socket01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
socket01.c:66: TPASS: invalid domain successful
socket01.c:66: TPASS: invalid type successful
socket01.c:66: TPASS: UNIX domain dgram successful
socket01.c:66: TPASS: raw open as non-root successful
socket01.c:66: TPASS: UDP socket successful
socket01.c:66: TPASS: UDP stream successful
socket01.c:66: TPASS: TCP dgram successful
socket01.c:66: TPASS: TCP socket successful
socket01.c:66: TPASS: ICMP stream successful

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
tag=3Dstat01 stime=3D1631249169
cmdline=3D"stat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
stat01.c:75: TPASS: stat(test_fileread)
stat01.c:75: TPASS: stat(test_filenoread)

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
tag=3Dstatfs03_64 stime=3D1631249169
cmdline=3D"statfs03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs03    1  TPASS  :  expected failure - errno =3D 13 : Permission denied
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog06 stime=3D1631249169
cmdline=3D"syslog06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog06    0  TINFO  :   Test the logging option: LOG_NDELAY
syslog06    0  TINFO  :   o Do openlog() without LOG_NDELAY option.
syslog06    0  TINFO  :   o open a file and check the returned file descrip=
tor
syslog06    0  TINFO  :     It should be 3.
syslog06    0  TINFO  :   o Now do openlog() with LOG_NDELAY option.
syslog06    0  TINFO  :   o open a file and check the returned file descrip=
tor.
syslog06    0  TINFO  :     It should be greater than 3.
syslog06    0  TINFO  :  syslog: Testing the log option: LOG_NDELAY...
syslog06    0  TINFO  :  restarting syslog daemon
syslog06    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dtimerfd02 stime=3D1631249173
cmdline=3D"timerfd02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
timerfd02    1  TPASS  :  timerfd_create(TFD_CLOEXEC) Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dtimer_create02 stime=3D1631249173
cmdline=3D"timer_create02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
timer_create02.c:73: TPASS: invalid sigevent struct failed as expected: EFA=
ULT (14)
timer_create02.c:73: TPASS: invalid timer ID failed as expected: EFAULT (14)
timer_create02.c:73: TPASS: invalid clock failed as expected: EINVAL (22)
timer_create02.c:73: TPASS: wrong sigev_notify failed as expected: EINVAL (=
22)
timer_create02.c:73: TPASS: wrong sigev_signo failed as expected: EINVAL (2=
2)

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
tag=3Dtruncate02_64 stime=3D1631249173
cmdline=3D"truncate02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
truncate02.c:90: TPASS: truncate(testfile, 256) succeeded
truncate02.c:90: TPASS: truncate(testfile, 512) succeeded

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
tag=3Dunshare01 stime=3D1631249173
cmdline=3D"unshare01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
unshare01.c:47: TPASS: unshare(CLONE_FILES) passed
unshare01.c:47: TPASS: unshare(CLONE_FS) passed
unshare01.c:47: TPASS: unshare(CLONE_NEWNS) passed

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
tag=3Dumount02 stime=3D1631249173
cmdline=3D"umount02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
umount02.c:58: TPASS: umount() fails as expected: Already mounted/busy: EBU=
SY (16)
umount02.c:58: TPASS: umount() fails as expected: Invalid address: EFAULT (=
14)
umount02.c:58: TPASS: umount() fails as expected: Directory not found: ENOE=
NT (2)
umount02.c:58: TPASS: umount() fails as expected: Invalid  device: EINVAL (=
22)
umount02.c:58: TPASS: umount() fails as expected: Pathname too long: ENAMET=
OOLONG (36)

Summary:
passed   5
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
tag=3Dutime06 stime=3D1631249173
cmdline=3D"utime06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
utime06     0  TINFO  :  Found free device 0 '/dev/loop0'
utime06     0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
utime06     1  TPASS  :  utime failed as expected: TEST_ERRNO=3DEACCES(13):=
 Permission denied
utime06     2  TPASS  :  utime failed as expected: TEST_ERRNO=3DENOENT(2): =
No such file or directory
utime06     3  TPASS  :  utime failed as expected: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
utime06     4  TPASS  :  utime failed as expected: TEST_ERRNO=3DEROFS(30): =
Read-only file system
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dwait401 stime=3D1631249174
cmdline=3D"wait401"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
wait401.c:40: TPASS: wait4() returned correct pid 3889
wait401.c:49: TPASS: WIFEXITED() is set in status
wait401.c:54: TPASS: WEXITSTATUS() =3D=3D 0

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
tag=3Dwaitpid10 stime=3D1631249174
cmdline=3D"waitpid10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
waitpid10.c:62: TPASS: Test PASSED

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwritev06 stime=3D1631249176
cmdline=3D"writev06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
writev06    1  TPASS  :  writev returned 2 as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dperf_event_open01 stime=3D1631249176
cmdline=3D"perf_event_open01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 3000=
00080
perf_event_open01    1  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_HW_IN=
STRUCTIONS succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 18
perf_event_open01    2  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_HW_CA=
CHE_REFERENCES succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 0
perf_event_open01    3  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_HW_CA=
CHE_MISSES succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 1000=
00071
perf_event_open01    4  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_HW_BR=
ANCH_INSTRUCTIONS succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 4
perf_event_open01    5  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_HW_BR=
ANCH_MISSES succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 6632=
9861
perf_event_open01    6  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_SW_CP=
U_CLOCK succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 6562=
9962
perf_event_open01    7  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_SW_TA=
SK_CLOCK succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D46 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfutex_wake03 stime=3D1631249176
cmdline=3D"futex_wake03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
futex_wake03.c:97: TINFO: Testing variant: syscall with old kernel spec
futex_wake03.c:61: TPASS: futex_wake() woken up 1 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 2 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 3 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 4 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 5 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 6 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 7 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 8 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 9 childs
futex_wake03.c:61: TPASS: futex_wake() woken up 10 childs
futex_wake03.c:89: TPASS: futex_wake() woken up 0 children

Summary:
passed   11
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
tag=3Dmemfd_create03 stime=3D1631249176
cmdline=3D"memfd_create03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
memfd_create03.c:179: TINFO: --TESTING WRITE CALL IN HUGEPAGES--
memfd_create03.c:184: TINFO: memfd_create() succeeded
memfd_create03.c:80: TPASS: write(4, "LTP", 3) failed as expected

memfd_create03.c:179: TINFO: --TESTING PAGE SIZE OF CREATED FILE--
memfd_create03.c:184: TINFO: memfd_create() succeeded
memfd_create03.c:53: TINFO: mmap((nil), 2097152, 2, 2, 4, 0) succeeded
memfd_create03.c:102: TINFO: munmap(0x7fd0ce000000, 512kB) failed as expect=
ed
memfd_create03.c:102: TINFO: munmap(0x7fd0ce000000, 1024kB) failed as expec=
ted
memfd_create03.c:102: TINFO: munmap(0x7fd0ce000000, 1536kB) failed as expec=
ted
memfd_create03.c:120: TPASS: munmap() fails for page sizes less than 2048kB

memfd_create03.c:179: TINFO: --TESTING HUGEPAGE ALLOCATION LIMIT--
memfd_create03.c:184: TINFO: memfd_create() succeeded
memfd_create03.c:53: TINFO: mmap((nil), 2097152, 2, 2, 4, 0) succeeded
memfd_create03.c:139: TINFO: memfd_create() succeeded
memfd_create03.c:146: TPASS: mmap((nil), 2097152, 0, 2, 5, 0) failed as exp=
ected

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
tag=3Dcopy_file_range01 stime=3D1631249176
cmdline=3D"copy_file_range01"
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:36: TINFO: Testing libc copy_file_range()
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
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
tst_test.c:1421: TINFO: Testing on ext2
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ext3
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ext4
tst_test.c:923: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on xfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on btrfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on vfat
tst_test.c:923: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on ntfs
tst_test.c:923: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:937: TINFO: Trying FUSE...
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!
tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:923: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1355: TINFO: Timeout per run is 0h 25m 00s
copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
copy_file_range01.c:208: TPASS: non cross-device copy_file_range completed =
all 144 copy jobs successfully!
copy_file_range01.c:208: TPASS: cross-device copy_file_range completed all =
144 copy jobs successfully!

Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D18 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D35 cstime=3D212
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20210524-401-g575276b8c

       ###############################################################

            Done executing testcases.
            LTP Version:  20210524-401-g575276b8c
       ###############################################################


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/ltp-syscalls.yaml:
suite: ltp
testcase: ltp
category: functional
need_modules: true
need_memory: 4G
disk: 1HDD
fs: xfs
ltp:
  test: syscalls-03
job_origin: ltp-syscalls.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d02
tbox_group: lkp-skl-d02
kconfig: x86_64-rhel-8.3
submit_id: 6139007f389c2f96e52d4b28
job_file: "/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-03-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-ab19939a6a5010cba4e9cb04dd8bee03c72edcbd-20210909-38629-n23cq6-0.yaml"
id: e7d59c90332acff8ff118a7fc7d0612483dfb7d9
queuer_version: "/lkp-src"
:#! hosts/lkp-skl-d02:
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c500746fa0cc-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e41514d5105-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e41514d5105-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
:#! include/category/functional:
kmsg:
heartbeat:
meminfo:
:#! include/disk/nr_hdd:
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- BLK_DEV_LOOP
- CAN: m
- CAN_RAW: m
- CAN_VCAN: m
- IPV6_VTI: m
- MINIX_FS: m
- CHECKPOINT_RESTORE: y
- XFS_FS
:#! include/ltp:
:#! include/queue/cyclic:
commit: ab19939a6a5010cba4e9cb04dd8bee03c72edcbd
:#! include/testbox/lkp-skl-d02:
need_kconfig_hw:
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xe2'
:#! include/fs/OTHERS:
enqueue_time: 2021-09-09 02:27:11.884189648 +08:00
_id: 6139007f389c2f96e52d4b28
_rt: "/result/ltp/1HDD-xfs-syscalls-03-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 9517605f81f76e1ebdd710aa17a8221f8794106c
base_commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
branch: linux-devel/devel-hourly-20210906-125055
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/ltp/1HDD-xfs-syscalls-03-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/0"
scheduler_version: "/lkp/lkp/.src-20210908-135656"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-03-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-ab19939a6a5010cba4e9cb04dd8bee03c72edcbd-20210909-38629-n23cq6-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210906-125055
- commit=ab19939a6a5010cba4e9cb04dd8bee03c72edcbd
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/vmlinuz-5.13.0-00043-gab19939a6a50
- max_uptime=2100
- RESULT_ROOT=/result/ltp/1HDD-xfs-syscalls-03-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210828.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210907.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210906-182405/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.14.0
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/ab19939a6a5010cba4e9cb04dd8bee03c72edcbd/vmlinuz-5.13.0-00043-gab19939a6a50"
dequeue_time: 2021-09-09 03:02:53.407574124 +08:00
:#! /lkp/lkp/.src-20210908-135656/include/site/inn:
job_state: finished
loadavg: 1.91 0.72 0.27 1/210 4363
start_time: '1631127888'
end_time: '1631127960'
version: "/lkp/lkp/.src-20210908-135746:c5198d6f-dirty:443bf6990"

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sda1
mkfs -t xfs -f /dev/sda1
mkdir -p /fs/sda1
mount -t xfs -o inode64 /dev/sda1 /fs/sda1
ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
./runltp -f syscalls-03 -d /fs/sda1/tmpdir

--liOOAslEiF7prFVr--
