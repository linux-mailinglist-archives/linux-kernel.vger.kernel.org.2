Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4933F6EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 06:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhHYFA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:00:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:63519 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231442AbhHYFAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:00:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="281166139"
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="xz'?yaml'?scan'208";a="281166139"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 21:59:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="xz'?yaml'?scan'208";a="455910499"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 21:59:32 -0700
Date:   Wed, 25 Aug 2021 13:17:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ltp@lists.linux.it
Subject: [fs]  f7e33bdbd6: ltp.ftruncate04_64.fail
Message-ID: <20210825051710.GA5358@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3 ("fs: remove mandatory fil=
e locking support")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git locks-next


in testcase: ltp
version: ltp-x86_64-14c1f76-1_20210821
with following parameters:

	disk: 1HDD
	fs: ext4
	test: syscalls-07
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

2021-08-24 08:10:24 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-08-24 08:10:24 ./runltp -f syscalls-07 -d /fs/sdb1/tmpdir
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
Linux lkp-skl-d02 5.14.0-rc6-00228-gf7e33bdbd6d1 #1 SMP Tue Aug 24 11:42:23=
 CST 2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-ext4-syscalls-07-ucode=3D0xe2-debian-10.4-x86_64=
-20200603.cgz-f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3-20210824-25489-1d81u=
4d-5.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Djlayton/locks-ne=
xt commit=3Df7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3 BOOT_IMAGE=3D/pkg/linu=
x/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/vmlinuz-5.=
14.0-rc6-00228-gf7e33bdbd6d1 max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1H=
DD-ext4-syscalls-07-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cg=
z/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/3 LKP_SERV=
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
Modules Loaded         dm_mod xfs libcrc32c ipmi_devintf ipmi_msghandler sd=
_mod t10_pi sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_=
powerclamp coretemp i915 intel_gtt ttm kvm_intel ahci drm_kms_helper kvm me=
i_wdt libahci syscopyarea sysfillrect irqbypass sysimgblt crct10dif_pclmul =
fb_sys_fops crc32_pclmul wmi_bmof crc32c_intel drm ghash_clmulni_intel rapl=
 libata mei_me intel_cstate mei intel_uncore intel_pch_thermal wmi video in=
tel_pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32753616      356684    29755416       21796     2641516    2952=
2276
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
CPU MHz:             3517.084
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
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2618     -n 2618 -=
p -f /fs/sdb1/tmpdir/ltp-r964nMX0k4/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_08_24-08h_10m_24s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_08_24-08h_10m_24s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_08_24-08h_10m_24s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_08_24-08h_10m_24s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_08_24-08h_1=
0m_24s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_08_24-08h_10=
m_24s.tconf
Running tests.......
<<<test_start>>>
tag=3Dabort01 stime=3D1629792624
cmdline=3D"abort01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
abort01.c:62: TPASS: abort() dumped core
abort01.c:65: TPASS: abort() raised SIGIOT

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
tag=3Daccess02 stime=3D1629792624
cmdline=3D"access02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
access02.c:142: TPASS: access(file_f, F_OK) as root behaviour is correct.
access02.c:142: TPASS: access(file_f, F_OK) as nobody behaviour is correct.
access02.c:142: TPASS: access(file_r, R_OK) as root behaviour is correct.
access02.c:142: TPASS: access(file_r, R_OK) as nobody behaviour is correct.
access02.c:142: TPASS: access(file_w, W_OK) as root behaviour is correct.
access02.c:142: TPASS: access(file_w, W_OK) as nobody behaviour is correct.
access02.c:142: TPASS: access(file_x, X_OK) as root behaviour is correct.
access02.c:142: TPASS: access(file_x, X_OK) as nobody behaviour is correct.
access02.c:142: TPASS: access(symlink_f, F_OK) as root behaviour is correct.
access02.c:142: TPASS: access(symlink_f, F_OK) as nobody behaviour is corre=
ct.
access02.c:142: TPASS: access(symlink_r, R_OK) as root behaviour is correct.
access02.c:142: TPASS: access(symlink_r, R_OK) as nobody behaviour is corre=
ct.
access02.c:142: TPASS: access(symlink_w, W_OK) as root behaviour is correct.
access02.c:142: TPASS: access(symlink_w, W_OK) as nobody behaviour is corre=
ct.
access02.c:142: TPASS: access(symlink_x, X_OK) as root behaviour is correct.
access02.c:142: TPASS: access(symlink_x, X_OK) as nobody behaviour is corre=
ct.

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
tag=3Dalarm02 stime=3D1629792624
cmdline=3D"alarm02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
alarm02.c:62: TPASS: alarm(2147483647) returned 2147483647 as expected for =
value INT_MAX
alarm02.c:62: TPASS: alarm(2147483647) returned 2147483647 as expected for =
value UINT_MAX/2
alarm02.c:62: TPASS: alarm(1073741823) returned 1073741823 as expected for =
value UINT_MAX/4

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
tag=3Dbind01 stime=3D1629792624
cmdline=3D"bind01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
bind01.c:52: TPASS: invalid salen : EINVAL (22)
bind01.c:52: TPASS: invalid socket : ENOTSOCK (88)
bind01.c:55: TPASS: INADDR_ANYPORT passed
bind01.c:52: TPASS: UNIX-domain of current directory : EAFNOSUPPORT (97)
bind01.c:52: TPASS: non-local address : EADDRNOTAVAIL (99)

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
tag=3Dbrk01 stime=3D1629792624
cmdline=3D"brk01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
brk01.c:52: TPASS: brk() works fine

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
tag=3Dchmod01 stime=3D1629792624
cmdline=3D"chmod01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
chmod01.c:57: TINFO: Testing variant: verify permissions of file
chmod01.c:38: TPASS: chmod(testfile, 0000) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D0000
chmod01.c:38: TPASS: chmod(testfile, 0007) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D0007
chmod01.c:38: TPASS: chmod(testfile, 0070) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D0070
chmod01.c:38: TPASS: chmod(testfile, 0700) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D0700
chmod01.c:38: TPASS: chmod(testfile, 0777) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D0777
chmod01.c:38: TPASS: chmod(testfile, 2777) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D2777
chmod01.c:38: TPASS: chmod(testfile, 4777) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D4777
chmod01.c:38: TPASS: chmod(testfile, 6777) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D6777
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
chmod01.c:57: TINFO: Testing variant: verify permissions of directory
chmod01.c:38: TPASS: chmod(testdir_1, 0000) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D0000
chmod01.c:38: TPASS: chmod(testdir_1, 0007) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D0007
chmod01.c:38: TPASS: chmod(testdir_1, 0070) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D0070
chmod01.c:38: TPASS: chmod(testdir_1, 0700) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D0700
chmod01.c:38: TPASS: chmod(testdir_1, 0777) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D0777
chmod01.c:38: TPASS: chmod(testdir_1, 2777) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D2777
chmod01.c:38: TPASS: chmod(testdir_1, 4777) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D4777
chmod01.c:38: TPASS: chmod(testdir_1, 6777) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D6777

Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchmod07 stime=3D1629792624
cmdline=3D"chmod07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
chmod07.c:59: TPASS: Functionality of chmod(testfile, 01777) successful

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
tag=3Dchown01 stime=3D1629792624
cmdline=3D"chown01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
chown01.c:25: TPASS: chown(chown01_testfile,0,0) passed

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
tag=3Dchown04_16 stime=3D1629792624
cmdline=3D"chown04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dchroot02 stime=3D1629792624
cmdline=3D"chroot02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
chroot02.c:30: TPASS: chroot(/fs/sdb1/tmpdir/ltp-r964nMX0k4/chr6byA2e) pass=
ed
chroot02.c:34: TPASS: stat(/chroot02_testfile) passed

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
tag=3Dclock_adjtime01 stime=3D1629792624
cmdline=3D"clock_adjtime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
clock_adjtime01.c:186: TINFO: Testing variant: syscall with old kernel spec
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741072(us)
clock_adjtime.h:160: TINFO: SET
             mode: 32769
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741078(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741081(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D8001)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741100(us)
clock_adjtime.h:160: TINFO: SET
             mode: 40961
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741102(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741104(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3Da001)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741108(us)
clock_adjtime.h:160: TINFO: SET
             mode: 16447
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741111(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741127(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D403f)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741131(us)
clock_adjtime.h:160: TINFO: SET
             mode: 1
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741134(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741136(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D1)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741140(us)
clock_adjtime.h:160: TINFO: SET
             mode: 2
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741143(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741145(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D2)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741150(us)
clock_adjtime.h:160: TINFO: SET
             mode: 4
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741152(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741154(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D4)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741159(us)
clock_adjtime.h:160: TINFO: SET
             mode: 8
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741161(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741164(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D8)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741168(us)
clock_adjtime.h:160: TINFO: SET
             mode: 32
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741170(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741172(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D20)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741177(us)
clock_adjtime.h:160: TINFO: SET
             mode: 16384
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 11000
         raw time: 1629792624(s) 741179(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 11000
         raw time: 1629792624(s) 741182(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D4000)

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
tag=3Dclose01 stime=3D1629792624
cmdline=3D"close01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
close01.c:50: TPASS: close a file fd passed
close01.c:50: TPASS: close a pipe fd passed
close01.c:50: TPASS: close a socket fd passed

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
tag=3Dconfstr01 stime=3D1629792624
cmdline=3D"confstr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
confstr01    1  TPASS  :  confstr PATH =3D '/bin:/usr/bin'
confstr01    2  TPASS  :  confstr XBS5_ILP32_OFF32_CFLAGS =3D ''
confstr01    3  TPASS  :  confstr XBS5_ILP32_OFF32_LDFLAGS =3D ''
confstr01    4  TPASS  :  confstr XBS5_ILP32_OFF32_LIBS =3D ''
confstr01    5  TPASS  :  confstr XBS5_ILP32_OFF32_LINTFLAGS =3D ''
confstr01    6  TPASS  :  confstr XBS5_ILP32_OFFBIG_CFLAGS =3D ''
confstr01    7  TPASS  :  confstr XBS5_ILP32_OFFBIG_LDFLAGS =3D ''
confstr01    8  TPASS  :  confstr XBS5_ILP32_OFFBIG_LIBS =3D ''
confstr01    9  TPASS  :  confstr XBS5_ILP32_OFFBIG_LINTFLAGS =3D ''
confstr01   10  TPASS  :  confstr XBS5_LP64_OFF64_CFLAGS =3D '-m64'
confstr01   11  TPASS  :  confstr XBS5_LP64_OFF64_LDFLAGS =3D '-m64'
confstr01   12  TPASS  :  confstr XBS5_LP64_OFF64_LIBS =3D ''
confstr01   13  TPASS  :  confstr XBS5_LP64_OFF64_LINTFLAGS =3D ''
confstr01   14  TPASS  :  confstr XBS5_LPBIG_OFFBIG_CFLAGS =3D ''
confstr01   15  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LDFLAGS =3D ''
confstr01   16  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LIBS =3D ''
confstr01   17  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LINTFLAGS =3D ''
confstr01   18  TPASS  :  confstr GNU_LIBC_VERSION =3D 'glibc 2.28'
confstr01   19  TPASS  :  confstr GNU_LIBPTHREAD_VERSION =3D 'NPTL 2.28'
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dcreat06 stime=3D1629792624
cmdline=3D"creat06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
creat06.c:105: TPASS: got expected failure: EISDIR (21)
creat06.c:105: TPASS: got expected failure: ENAMETOOLONG (36)
creat06.c:105: TPASS: got expected failure: ENOENT (2)
creat06.c:105: TPASS: got expected failure: ENOTDIR (20)
creat06.c:105: TPASS: got expected failure: EFAULT (14)
creat06.c:105: TPASS: got expected failure: EACCES (13)
creat06.c:105: TPASS: got expected failure: ELOOP (40)
creat06.c:105: TPASS: got expected failure: EROFS (30)

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
tag=3Depoll_create1_01 stime=3D1629792624
cmdline=3D"epoll_create1_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
epoll_create1_01.c:46: TPASS: epoll_create1(EPOLL_CLOEXEC) PASSED

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
tag=3Deventfd2_01 stime=3D1629792624
cmdline=3D"eventfd2_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
eventfd2_01    1  TPASS  :  eventfd2(EFD_CLOEXEC) Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Deventfd2_02 stime=3D1629792624
cmdline=3D"eventfd2_02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
eventfd2_02    1  TPASS  :  eventfd2(EFD_NONBLOCK) PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexecveat01 stime=3D1629792624
cmdline=3D"execveat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected

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
tag=3Dexit01 stime=3D1629792624
cmdline=3D"exit01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
exit01      1  TPASS  :  exit() test PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfsetxattr01 stime=3D1629792624
cmdline=3D"fsetxattr01"
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
tst_test.c:1414: TINFO: Testing on ext2
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on ext3
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on ext4
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on xfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on btrfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on vfat
tst_test.c:916: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:150: TCONF: fsetxattr(2) not supported
tst_test.c:1414: TINFO: Testing on ntfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:930: TINFO: Trying FUSE...
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on tmpfs
tst_test.c:916: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:896: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:150: TCONF: fsetxattr(2) not supported

Summary:
passed   56
failed   0
broken   0
skipped  2
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D10 cstime=3D101
<<<test_end>>>
<<<test_start>>>
tag=3Dfsetxattr02 stime=3D1629792630
cmdline=3D"fsetxattr02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr02.c:170: TPASS: fsetxattr(2) on testfile passed
fsetxattr02.c:170: TPASS: fsetxattr(2) on testdir passed
fsetxattr02.c:192: TPASS: fsetxattr(2) on symlink failed: EEXIST (17)
fsetxattr02.c:192: TPASS: fsetxattr(2) on fifo failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on chr failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on blk failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on sock failed: EPERM (1)

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
tag=3Dposix_fadvise02 stime=3D1629792630
cmdline=3D"posix_fadvise02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF

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
tag=3Dfchmod04 stime=3D1629792630
cmdline=3D"fchmod04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fchmod04    1  TPASS  :  Functionality of fchmod(4, 01777) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfchown04 stime=3D1629792630
cmdline=3D"fchown04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fchown04.c:66: TPASS: fchown(4, 65534, 0) : EPERM (1)
fchown04.c:66: TPASS: fchown(-1, 65534, 0) : EBADF (9)
fchown04.c:66: TPASS: fchown(5, 65534, 0) : EROFS (30)

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
tag=3Dfcntl01 stime=3D1629792630
cmdline=3D"fcntl01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl07 stime=3D1629792630
cmdline=3D"fcntl07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl07     1  TPASS  :  regular file CLOEXEC fd was closed after exec()
fcntl07     2  TPASS  :  pipe (write end) CLOEXEC fd was closed after exec()
fcntl07     3  TPASS  :  pipe (read end) CLOEXEC fd was closed after exec()
fcntl07     4  TPASS  :  fifo CLOEXEC fd was closed after exec()
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl07_64 stime=3D1629792630
cmdline=3D"fcntl07_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl07     1  TPASS  :  regular file CLOEXEC fd was closed after exec()
fcntl07     2  TPASS  :  pipe (write end) CLOEXEC fd was closed after exec()
fcntl07     3  TPASS  :  pipe (read end) CLOEXEC fd was closed after exec()
fcntl07     4  TPASS  :  fifo CLOEXEC fd was closed after exec()
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl10 stime=3D1629792630
cmdline=3D"fcntl10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl10     1  TPASS  :  fcntl(tfile_2933, F_SETLKW, &flocks) flocks.l_type=
 =3D F_WRLCK returned 0
fcntl10     2  TPASS  :  fcntl(tfile_2933, F_SETLKW, &flocks) flocks.l_type=
 =3D F_UNLCK returned 0
fcntl10     1  TPASS  :  fcntl(tfile_2933, F_SETLKW, &flocks) flocks.l_type=
 =3D F_RDLCK returned 0
fcntl10     2  TPASS  :  fcntl(tfile_2933, F_SETLKW, &flocks) flocks.l_type=
 =3D F_UNLCK returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl13_64 stime=3D1629792630
cmdline=3D"fcntl13_64"
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
tag=3Dfcntl16 stime=3D1629792630
cmdline=3D"fcntl16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl16     0  TINFO  :  Entering block 1
fcntl16     0  TINFO  :  Test case 1: without manadatory locking PASSED
fcntl16     0  TINFO  :  Exiting block 1
fcntl16     0  TINFO  :  Entering block 2
fcntl16     0  TINFO  :  Test case 2: with mandatory record locking PASSED
fcntl16     0  TINFO  :  Exiting block 2
fcntl16     0  TINFO  :  Entering block 3
fcntl16     0  TINFO  :  Test case 3: mandatory locking with NODELAY PASSED
fcntl16     0  TINFO  :  Exiting block 3
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl23 stime=3D1629792630
cmdline=3D"fcntl23"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl23     1  TPASS  :  fcntl(tfile_2936, F_SETLEASE, F_RDLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl24_64 stime=3D1629792630
cmdline=3D"fcntl24_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl24     1  TPASS  :  fcntl(tfile_2937, F_SETLEASE, F_WRLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl25 stime=3D1629792630
cmdline=3D"fcntl25"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl25     1  TPASS  :  fcntl(tfile_2938, F_SETLEASE, F_WRLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl29 stime=3D1629792630
cmdline=3D"fcntl29"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl29     1  TPASS  :  fcntl test F_DUPFD_CLOEXEC success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl30_64 stime=3D1629792631
cmdline=3D"fcntl30_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl30     0  TINFO  :  orig_pipe_size: 65536 new_pipe_size: 131072
fcntl30     1  TPASS  :  fcntl test F_GETPIPE_SZ and F_SETPIPE_SZ passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl32 stime=3D1629792631
cmdline=3D"fcntl32"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl32     1  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     2  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     3  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     4  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     5  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     6  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     7  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     8  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     9  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl34 stime=3D1629792631
cmdline=3D"fcntl34"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl38 stime=3D1629792631
cmdline=3D"fcntl38"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fcntl38.c:67: TPASS: Got event on parent as expected
fcntl38.c:71: TPASS: Got event on subdir as expected

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
tag=3Dfcntl38_64 stime=3D1629792631
cmdline=3D"fcntl38_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fcntl38.c:67: TPASS: Got event on parent as expected
fcntl38.c:71: TPASS: Got event on subdir as expected

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
tag=3Dfinit_module02 stime=3D1629792631
cmdline=3D"finit_module02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_module.c:70: TCONF: Failed to find module 'finit_module.ko'

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
tag=3Dfremovexattr01 stime=3D1629792631
cmdline=3D"fremovexattr01"
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
tst_test.c:1414: TINFO: Testing on ext2
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on ext3
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on ext4
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on xfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on btrfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on vfat
tst_test.c:916: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:82: TCONF: fremovexattr(2) not supported
tst_test.c:1414: TINFO: Testing on ntfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:930: TINFO: Trying FUSE...
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on tmpfs
tst_test.c:916: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:896: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:82: TCONF: fremovexattr(2) not supported

Summary:
passed   6
failed   0
broken   0
skipped  2
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7 cstime=3D106
<<<test_end>>>
<<<test_start>>>
tag=3Dfsopen01 stime=3D1629792636
cmdline=3D"fsopen01"
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
tst_supported_fs_types.c:157: TINFO: Skipping FUSE based ntfs as requested =
by the test
tst_supported_fs_types.c:89: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:38: TINFO: mkfs is not needed for tmpfs
tst_test.c:1414: TINFO: Testing on ext2
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on ext3
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on ext4
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on xfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on btrfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on vfat
tst_test.c:916: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on tmpfs
tst_test.c:916: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed

Summary:
passed   14
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D6 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3Dfstat03_64 stime=3D1629792639
cmdline=3D"fstat03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fstat03.c:49: TPASS: fstat() fails with expected error EBADF
fstat03.c:49: TPASS: fstat() fails with expected error EFAULT

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
tag=3Dfstatfs02 stime=3D1629792639
cmdline=3D"fstatfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fstatfs02    1  TPASS  :  expected failure - errno =3D 9 : Bad file descrip=
tor
fstatfs02    2  TPASS  :  expected failure - errno =3D 14 : Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dftruncate03 stime=3D1629792639
cmdline=3D"ftruncate03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EBADF (9)

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
tag=3Dftruncate04_64 stime=3D1629792639
cmdline=3D"ftruncate04_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ftruncate04.c:116: TINFO: Child locks file
ftruncate04.c:49: TFAIL: ftruncate() offset before lock succeeded unexpecte=
dly
ftruncate04.c:49: TFAIL: ftruncate() offset in lock succeeded unexpectedly
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
ftruncate04.c:127: TINFO: Child unlocks file
ftruncate04.c:84: TPASS: ftruncate() offset in lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset before lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded

Summary:
passed   4
failed   2
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D8
<<<test_end>>>
<<<test_start>>>
tag=3Dgetcwd04 stime=3D1629792639
cmdline=3D"getcwd04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
getcwd04.c:60: TPASS: Bug is not reproduced!

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D334 cstime=3D657
<<<test_end>>>
<<<test_start>>>
tag=3Dgeteuid02_16 stime=3D1629792644
cmdline=3D"geteuid02_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
geteuid02_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: 16-bit version of geteuid() is not suppo=
rted on your platform
geteuid02_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: Remaining cases not appropriate for conf=
iguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetgid01_16 stime=3D1629792644
cmdline=3D"getgid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/getgid/../utils/compat_tst_1=
6.h:99: TCONF: 16-bit version of getgid() is not supported on your platform

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
tag=3Dgetgid03 stime=3D1629792644
cmdline=3D"getgid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
getgid03.c:43: TPASS: values from getgid() and getpwuid() match

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
tag=3Dgetrandom03 stime=3D1629792644
cmdline=3D"getrandom03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
getrandom03.c:37: TPASS: getrandom returned 1
getrandom03.c:37: TPASS: getrandom returned 2
getrandom03.c:37: TPASS: getrandom returned 3
getrandom03.c:37: TPASS: getrandom returned 7
getrandom03.c:37: TPASS: getrandom returned 8
getrandom03.c:37: TPASS: getrandom returned 15
getrandom03.c:37: TPASS: getrandom returned 22
getrandom03.c:37: TPASS: getrandom returned 64
getrandom03.c:37: TPASS: getrandom returned 127

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
tag=3Dgetresuid01 stime=3D1629792644
cmdline=3D"getresuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid01    1  TPASS  :  Functionality of getresuid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresuid02 stime=3D1629792644
cmdline=3D"getresuid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid02    1  TPASS  :  Functionality of getresuid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsid02 stime=3D1629792644
cmdline=3D"getsid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getsid02    1  TPASS  :  expected failure - errno =3D 3 - No such process
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetxattr05 stime=3D1629792644
cmdline=3D"getxattr05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice

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
tag=3Dioctl01_02 stime=3D1629792644
cmdline=3D"test_ioctl"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty0
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty0

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty1
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty1

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty10
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty10

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty11
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty11

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty12
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty12

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty13
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty13

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty14
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty14

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty15
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty15

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty16
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty16

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty17
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty17

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty18
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty18

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty19
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty19

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty2
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty2

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty20
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty20

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty21
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty21

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty22
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty22

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty23
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty23

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty24
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty24

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty25
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty25

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty26
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty26

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty27
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty27

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty28
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty28

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty29
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty29

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty3
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty3

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty30
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty30

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty31
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty31

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty32
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty32

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty33
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty33

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty34
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty34

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty35
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty35

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty36
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty36

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty37
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty37

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty38
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty38

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty39
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty39

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty4
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty4

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty40
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty40

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty41
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty41

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty42
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty42

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty43
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty43

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty44
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty44

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty45
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty45

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty46
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty46

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty47
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty47

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty48
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty48

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty49
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty49

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty5
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty5

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty50
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty50

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty51
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty51

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty52
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty52

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty53
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty53

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty54
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty54

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty55
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty55

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty56
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty56

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty57
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty57

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty58
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty58

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty59
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty59

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty6
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty6

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty60
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty60

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty61
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty61

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty62
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty62

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty63
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty63

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty7
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty7

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty8
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty8

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty9
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty9

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty0
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty0

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty1
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty1

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty10
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty10

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty11
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty11

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty12
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty12

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty13
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty13

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty14
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty14

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty15
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty15

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty16
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty16

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty17
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty17

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty18
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty18

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty19
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty19

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty2
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty2

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty20
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty20

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty21
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty21

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty22
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty22

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty23
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty23

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty24
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty24

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty25
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty25

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty26
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty26

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty27
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty27

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty28
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty28

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty29
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty29

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty3
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty3

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty30
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty30

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty31
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty31

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty32
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty32

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty33
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty33

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty34
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty34

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty35
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty35

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty36
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty36

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty37
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty37

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty38
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty38

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty39
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty39

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty4
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty4

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty40
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty40

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty41
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty41

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty42
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty42

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty43
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty43

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty44
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty44

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty45
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty45

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty46
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty46

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty47
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty47

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty48
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty48

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty49
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty49

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty5
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty5

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty50
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty50

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty51
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty51

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty52
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty52

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty53
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty53

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty54
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty54

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty55
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty55

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty56
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty56

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty57
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty57

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty58
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty58

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty59
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty59

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty6
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty6

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty60
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty60

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty61
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty61

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty62
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty62

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty63
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty63

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty7
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty7

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty8
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty8

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty9
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty9

<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D23 cstime=3D21
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl06 stime=3D1629792645
cmdline=3D"ioctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl06.c:26: TINFO: BLKRAGET original value 256
ioctl06.c:33: TPASS: BLKRASET 0 read back correctly
ioctl06.c:33: TPASS: BLKRASET 512 read back correctly
ioctl06.c:33: TPASS: BLKRASET 1024 read back correctly
ioctl06.c:33: TPASS: BLKRASET 1536 read back correctly
ioctl06.c:33: TPASS: BLKRASET 2048 read back correctly
ioctl06.c:33: TPASS: BLKRASET 2560 read back correctly
ioctl06.c:33: TPASS: BLKRASET 3072 read back correctly
ioctl06.c:33: TPASS: BLKRASET 3584 read back correctly
ioctl06.c:33: TPASS: BLKRASET 4096 read back correctly
ioctl06.c:38: TINFO: BLKRASET restoring original value 256

Summary:
passed   9
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
tag=3Dioctl_ns05 stime=3D1629792645
cmdline=3D"ioctl_ns05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl_ns05.c:91: TPASS: child and parent are consistent
ioctl_ns05.c:50: TPASS: child thinks its pid is 1

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
tag=3Dinotify09 stime=3D1629792645
cmdline=3D"inotify09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:522: TINFO: Minimum sampling period =
ended
=2E./../../../include/tst_fuzzy_sync.h:346: TINFO: loop =3D 1024, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg=
 =3D   -29ns, avg_dev =3D    13ns, dev_ratio =3D 0.45 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D  4497ns, avg_dev =3D  2867ns, dev_ratio =3D 0.64 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D  4985ns, avg_dev =3D  2536ns, dev_ratio =3D 0.51 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D  -517ns, avg_dev =3D   453ns, dev_ratio =3D 0.88 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   560  , avg_dev =3D   149  , dev_ratio =3D 0.27 }
=2E./../../../include/tst_fuzzy_sync.h:534: TINFO: Reached deviation ratios=
 < 0.10, introducing randomness
=2E./../../../include/tst_fuzzy_sync.h:537: TINFO: Delay range is [-1002, 5=
37]
=2E./../../../include/tst_fuzzy_sync.h:346: TINFO: loop =3D 1130, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg=
 =3D   -46ns, avg_dev =3D     5ns, dev_ratio =3D 0.10 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D   878ns, avg_dev =3D     8ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D  1640ns, avg_dev =3D    19ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D  -808ns, avg_dev =3D    14ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   494  , avg_dev =3D    16  , dev_ratio =3D 0.03 }
=2E./../../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops=
, requesting exit
inotify09.c:89: TPASS: kernel survived inotify beating

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D15 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1894 cstime=3D980
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify06 stime=3D1629792660
cmdline=3D"fanotify06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fanotify06.c:158: TINFO: Test #0: Fanotify merge mount mark
fanotify06.c:136: TPASS: group 0 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:136: TPASS: group 1 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:136: TPASS: group 2 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:219: TPASS: group 3 got no event
fanotify06.c:219: TPASS: group 4 got no event
fanotify06.c:219: TPASS: group 5 got no event
fanotify06.c:219: TPASS: group 6 got no event
fanotify06.c:219: TPASS: group 7 got no event
fanotify06.c:219: TPASS: group 8 got no event
fanotify06.c:158: TINFO: Test #1: Fanotify merge overlayfs mount mark
fanotify06.c:136: TPASS: group 0 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:136: TPASS: group 1 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:136: TPASS: group 2 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:219: TPASS: group 3 got no event
fanotify06.c:219: TPASS: group 4 got no event
fanotify06.c:219: TPASS: group 5 got no event
fanotify06.c:219: TPASS: group 6 got no event
fanotify06.c:219: TPASS: group 7 got no event
fanotify06.c:219: TPASS: group 8 got no event

Summary:
passed   18
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
tag=3Dfanotify11 stime=3D1629792660
cmdline=3D"fanotify11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fanotify11.c:66: TINFO: Test #0: without FAN_REPORT_TID: tgid=3D3947, tid=
=3D0, event.pid=3D0
fanotify11.c:85: TPASS: event.pid =3D=3D tgid
fanotify11.c:66: TINFO: Test #1: with FAN_REPORT_TID: tgid=3D3947, tid=3D39=
48, event.pid=3D3947
fanotify11.c:83: TPASS: event.pid =3D=3D tid

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
tag=3Dfanotify18 stime=3D1629792660
cmdline=3D"fanotify18"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fanotify18.c:171: TINFO: Running as privileged user, revoking permissions.
fanotify18.c:108: TINFO: Test #0 init_flags: missing FAN_REPORT_FID
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #1 init_flags: FAN_CLASS_CONTENT
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #2 init_flags: FAN_CLASS_PRE_CONTENT
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #3 init_flags: FAN_UNLIMITED_QUEUE
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #4 init_flags: FAN_UNLIMITED_MARKS
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #5 init_flags: FAN_REPORT_TID
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #6 init_flags: FAN_CLASS_NOTIF, mark_flags: F=
AN_MARK_ADD | FAN_MARK_MOUNT
fanotify18.c:138: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #7 init_flags: FAN_CLASS_NOTIF, mark_flags: F=
AN_MARK_ADD | FAN_MARK_FILESYSTEM
fanotify18.c:138: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #8 init_flags: FAN_CLASS_NOTIF, mark_flags: F=
AN_MARK_ADD, mark_mask: FAN_ALL_EVENTS
fanotify18.c:153: TPASS: fanotify_init() and fanotify_mark() returned succe=
ssfully, as expected

Summary:
passed   9
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
tag=3Dioprio_set01 stime=3D1629792661
cmdline=3D"ioprio_set01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioprio_set01.c:66: TINFO: ioprio_get returned class NONE prio 4
ioprio.h:91: TPASS: ioprio_set new class BEST-EFFORT, new prio 5
ioprio.h:91: TPASS: ioprio_set new class BEST-EFFORT, new prio 3

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
tag=3Dio_pgetevents02 stime=3D1629792661
cmdline=3D"io_pgetevents02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
io_pgetevents02.c:57: TINFO: Testing variant: syscall with old kernel spec
io_pgetevents02.c:118: TPASS: invalid ctx: io_pgetevents() failed as expect=
ed: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid min_nr: io_pgetevents() failed as exp=
ected: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid max_nr: io_pgetevents() failed as exp=
ected: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid events: io_pgetevents() failed as exp=
ected: EFAULT (14)
io_pgetevents02.c:118: TPASS: invalid timeout: io_pgetevents() failed as ex=
pected: EFAULT (14)
io_pgetevents02.c:118: TPASS: invalid sigmask: io_pgetevents() failed as ex=
pected: EFAULT (14)

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
tag=3Dkeyctl05 stime=3D1629792661
cmdline=3D"keyctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_fips.c:22: TINFO: FIPS: off
keyctl05.c:131: TINFO: Try to update the 'asymmetric' key...
keyctl05.c:144: TPASS: updating 'asymmetric' key expectedly failed with EOP=
NOTSUPP
keyctl05.c:100: TCONF: kernel doesn't support key type 'dns_resolver'
keyctl05.c:179: TINFO: Try to update the 'user' key...
keyctl05.c:188: TPASS: didn't crash while racing to update 'user' key

Summary:
passed   2
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dkill02 stime=3D1629792661
cmdline=3D"kill02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill02      1  TPASS  :  The signal was sent to all processes in the proces=
s group.
kill02      2  TPASS  :  The signal was not sent to selective processes tha=
t were not in the process group.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D10 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkill03 stime=3D1629792671
cmdline=3D"kill03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
kill03.c:41: TPASS: kill failed as expected: EINVAL (22)
kill03.c:41: TPASS: kill failed as expected: ESRCH (3)
kill03.c:41: TPASS: kill failed as expected: ESRCH (3)

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
tag=3Dlchown03 stime=3D1629792671
cmdline=3D"lchown03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
lchown03    0  TINFO  :  Found free device 0 '/dev/loop0'
lchown03    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
lchown03    1  TPASS  :  lchown() failed as expected: TEST_ERRNO=3DELOOP(40=
): Too many levels of symbolic links
lchown03    2  TPASS  :  lchown() failed as expected: TEST_ERRNO=3DEROFS(30=
): Read-only file system
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dlistxattr03 stime=3D1629792672
cmdline=3D"listxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
listxattr03.c:54: TPASS: listxattr() succeed with suitable buffer
listxattr03.c:54: TPASS: listxattr() succeed with suitable buffer

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
tag=3Dllseek03 stime=3D1629792672
cmdline=3D"llseek03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
llseek03.c:96: TPASS: llseek returned 1
llseek03.c:115: TPASS: SEEK_SET for llseek
llseek03.c:96: TPASS: llseek returned 5
llseek03.c:115: TPASS: SEEK_CUR for llseek
llseek03.c:96: TPASS: llseek returned 7
llseek03.c:115: TPASS: SEEK_END for llseek
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_SET read returned 0
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_CUR read returned 0
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_END read returned 0
llseek03.c:96: TPASS: llseek returned 10
llseek03.c:107: TPASS: SEEK_SET read returned 0
llseek03.c:96: TPASS: llseek returned 12
llseek03.c:107: TPASS: SEEK_CUR read returned 0
llseek03.c:96: TPASS: llseek returned 12
llseek03.c:107: TPASS: SEEK_END read returned 0

Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlseek02 stime=3D1629792672
cmdline=3D"lseek02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
lseek02.c:65: TPASS: lseek(-1, 1, 0) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(-1, 1, 1) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(-1, 1, 2) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(4, 1, 5) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(4, 1, -1) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(4, 1, 7) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(5, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(5, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(5, 1, 2) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 2) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 2) failed as expected: ESPIPE (29)

Summary:
passed   15
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmigrate_pages01 stime=3D1629792672
cmdline=3D"migrate_pages01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
migrate_pages01    0  TINFO  :  test_empty_mask
migrate_pages01    1  TPASS  :  expected ret success: returned value =3D 0
migrate_pages01    0  TINFO  :  test_invalid_pid -1
migrate_pages01    2  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    3  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): No=
 such process
migrate_pages01    0  TINFO  :  test_invalid_pid unused pid
migrate_pages01    4  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    5  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): No=
 such process
migrate_pages01    0  TINFO  :  test_invalid_masksize
migrate_pages01    6  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22): =
Invalid argument
migrate_pages01    0  TINFO  :  test_invalid_mem -1
migrate_pages01    8  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    9  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_mem invalid prot
migrate_pages01   10  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   11  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_mem unmmaped
migrate_pages01   12  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   13  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_nodes
migrate_pages01   14  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   15  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22): =
Invalid argument
migrate_pages01    0  TINFO  :  test_invalid_perm
migrate_pages01   16  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   17  TPASS  :  expected failure: TEST_ERRNO=3DEPERM(1): Op=
eration not permitted
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmkdirat01 stime=3D1629792672
cmdline=3D"mkdirat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mkdirat01    1  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    2  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    3  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    4  TPASS  :  mkdirat() returned -1: TEST_ERRNO=3DENOTDIR(20): =
Not a directory
mkdirat01    5  TPASS  :  mkdirat() returned -1: TEST_ERRNO=3DEBADF(9): Bad=
 file descriptor
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmlock01 stime=3D1629792672
cmdline=3D"mlock01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mlock01     1  TPASS  :  mlock passed
mlock01     2  TPASS  :  mlock passed
mlock01     3  TPASS  :  mlock passed
mlock01     4  TPASS  :  mlock passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages04 stime=3D1629792672
cmdline=3D"move_pages04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
move_pages04    1  TCONF  :  move_pages_support.c:407: at least 2 allowed N=
UMA nodes are required
move_pages04    2  TCONF  :  move_pages_support.c:407: Remaining cases not =
appropriate for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpkey01 stime=3D1629792672
cmdline=3D"pkey01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_hugepage.c:64: TINFO: 1 hugepage(s) reserved
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pkey.h:48: TCONF: pku is not supported on this CPU

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_notify01 stime=3D1629792672
cmdline=3D"mq_notify01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBUSY (16)

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
tag=3Dmq_notify02 stime=3D1629792672
cmdline=3D"mq_notify02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mq_notify02    1  TPASS  :  mq_notify failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
mq_notify02    2  TPASS  :  mq_notify failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap01 stime=3D1629792672
cmdline=3D"mremap01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mremap01    1  TPASS  :  Functionality of mremap() is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgget02 stime=3D1629792672
cmdline=3D"msgget02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
msgget02.c:53: TPASS: msgget(1628504068, 1536) : EEXIST (17)
msgget02.c:53: TPASS: msgget(1645281284, 0) : ENOENT (2)
msgget02.c:53: TPASS: msgget(1645281284, 1024) : ENOENT (2)
msgget02.c:53: TPASS: msgget(1628504068, 256) : EACCES (13)
msgget02.c:53: TPASS: msgget(1628504068, 128) : EACCES (13)
msgget02.c:53: TPASS: msgget(1628504068, 384) : EACCES (13)

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
tag=3Dmsgrcv02 stime=3D1629792672
cmdline=3D"msgrcv02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
msgrcv02.c:63: TPASS: msgrcv(1, 0x55c409922de0, 4, 1, 0) : E2BIG (7)
msgrcv02.c:63: TPASS: msgrcv(2, 0x55c409922de0, 1024, 1, 0) : EACCES (13)
msgrcv02.c:63: TPASS: msgrcv(3, (nil), 1024, 1, 0) : EFAULT (14)
msgrcv02.c:63: TPASS: msgrcv(-1, 0x55c409922de0, 1024, 1, 0) : EINVAL (22)
msgrcv02.c:63: TPASS: msgrcv(5, 0x55c409922de0, -1, 1, 0) : EINVAL (22)
msgrcv02.c:63: TPASS: msgrcv(6, 0x55c409922de0, 1024, 2, 2048) : ENOMSG (42)

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
tag=3Dmsync01 stime=3D1629792672
cmdline=3D"msync01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
msync01     1  TPASS  :  Functionality of msync() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dname_to_handle_at01 stime=3D1629792672
cmdline=3D"name_to_handle_at01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_buffers.c:55: TINFO: Test is using guarded buffers
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (0)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (1)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (2)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (3)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (4)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (5)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (6)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (7)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (8)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (9)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (10)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (11)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (12)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (13)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (14)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (15)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (16)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (17)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (18)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (19)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (20)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (21)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (22)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (23)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (24)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (25)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (26)

Summary:
passed   27
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
tag=3Dopen02 stime=3D1629792672
cmdline=3D"open02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
open02.c:53: TPASS: open() new file without O_CREAT : ENOENT (2)
open02.c:53: TPASS: open() unpriviledget O_RDONLY | O_NOATIME : EPERM (1)

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
tag=3Dopen03 stime=3D1629792672
cmdline=3D"open03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open03      1  TPASS  :  open(tfile_4051, O_RDWR|O_CREAT,0700) returned 4
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen14 stime=3D1629792672
cmdline=3D"open14"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open14      0  TINFO  :  creating a file with O_TMPFILE flag
open14      0  TINFO  :  writing data to the file
open14      0  TINFO  :  file size is '4096'
open14      0  TINFO  :  looking for the file in '.'
open14      0  TINFO  :  file not found, OK
open14      0  TINFO  :  renaming '/fs/sdb1/tmpdir/ltp-r964nMX0k4/openX4CNW=
/#18087941 (deleted)' -> 'tmpfile'
open14      0  TINFO  :  found a file: tmpfile
open14      1  TPASS  :  single file tests passed
open14      0  TINFO  :  create files in multiple directories
open14      0  TINFO  :  removing test directories
open14      0  TINFO  :  writing/reading temporary files
open14      0  TINFO  :  closing temporary files
open14      2  TPASS  :  multiple files tests passed
open14      0  TINFO  :  create multiple directories, link files into them
open14      0  TINFO  :  and check file permissions
open14      0  TINFO  :  remove files, directories
open14      3  TPASS  :  file permission tests passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dopenat01 stime=3D1629792672
cmdline=3D"openat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
openat01    1  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
openat01    2  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
openat01    3  TPASS  :  openat() returned -1: TEST_ERRNO=3DENOTDIR(20): No=
t a directory
openat01    4  TPASS  :  openat() returned -1: TEST_ERRNO=3DEBADF(9): Bad f=
ile descriptor
openat01    5  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmincore03 stime=3D1629792672
cmdline=3D"mincore03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
mincore03.c:66: TPASS: mincore() reports untouched pages are not resident
mincore03.c:66: TPASS: mincore() reports locked pages are resident

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
tag=3Dmincore04 stime=3D1629792672
cmdline=3D"mincore04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
mincore04.c:100: TPASS: mincore reports all 3 pages locked by child process=
 are resident

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
tag=3Dmadvise01 stime=3D1629792672
cmdline=3D"madvise01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
madvise01.c:112: TPASS: madvise test for MADV_NORMAL PASSED
madvise01.c:112: TPASS: madvise test for MADV_RANDOM PASSED
madvise01.c:112: TPASS: madvise test for MADV_SEQUENTIAL PASSED
madvise01.c:112: TPASS: madvise test for MADV_WILLNEED PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTNEED PASSED
madvise01.c:112: TPASS: madvise test for MADV_REMOVE PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_DOFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_HWPOISON PASSED
madvise01.c:112: TPASS: madvise test for MADV_MERGEABLE PASSED
madvise01.c:112: TPASS: madvise test for MADV_UNMERGEABLE PASSED
madvise01.c:112: TPASS: madvise test for MADV_HUGEPAGE PASSED
madvise01.c:112: TPASS: madvise test for MADV_NOHUGEPAGE PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTDUMP PASSED
madvise01.c:112: TPASS: madvise test for MADV_DODUMP PASSED
madvise01.c:112: TPASS: madvise test for MADV_FREE PASSED
madvise01.c:112: TPASS: madvise test for MADV_WIPEONFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_KEEPONFORK PASSED

Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D19
<<<test_end>>>
<<<test_start>>>
tag=3Dmadvise06 stime=3D1629792673
cmdline=3D"madvise06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
madvise06.c:107: TINFO: dropping caches
madvise06.c:118: TCONF: System swap is too small (838860800 bytes needed)

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Dpause02 stime=3D1629792673
cmdline=3D"pause02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pause02     1  TPASS  :  pause was interrupted correctly
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpidfd_open02 stime=3D1629792673
cmdline=3D"pidfd_open02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pidfd_open02.c:50: TPASS: expired pid: pidfd_open() failed as expected: ESR=
CH (3)
pidfd_open02.c:50: TPASS: invalid pid: pidfd_open() failed as expected: EIN=
VAL (22)
pidfd_open02.c:50: TPASS: invalid flags: pidfd_open() failed as expected: E=
INVAL (22)

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
tag=3Dpipe08 stime=3D1629792673
cmdline=3D"pipe08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pipe08      1  TPASS  :  got expected SIGPIPE signal
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe09 stime=3D1629792673
cmdline=3D"pipe09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pipe09      1  TPASS  :  functionality appears to be correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe2_04 stime=3D1629792673
cmdline=3D"pipe2_04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pipe2_04.c:37: TPASS: write failed as expected: EAGAIN/EWOULDBLOCK (11)
pipe2_04.c:53: TPASS: Child process is blocked

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
tag=3Dpreadv202 stime=3D1629792673
cmdline=3D"preadv202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dprocess_vm_readv01 stime=3D1629792673
cmdline=3D"process_vm01 -r"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
process_vm_readv    0  TINFO  :  test_sane_params
process_vm_readv    1  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_flags, flags=3D-2147483647
process_vm_readv    2  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    3  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D-1
process_vm_readv    4  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    5  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D1
process_vm_readv    6  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D2147483647
process_vm_readv    8  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    9  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D0
process_vm_readv   10  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_iov_len_overflow
process_vm_readv   11  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   12  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec->iov_base
process_vm_readv   13  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   14  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec->iov_base
process_vm_readv   15  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   16  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec
process_vm_readv   17  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   18  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec
process_vm_readv   19  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   20  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_pid
process_vm_readv   21  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   22  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv   23  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   24  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv    0  TINFO  :  test_invalid_perm
process_vm_readv   25  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   26  TPASS  :  expected failure: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
process_vm_readv    0  TINFO  :  test_sane_params
process_vm_readv    1  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_flags, flags=3D-2147483647
process_vm_readv    2  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    3  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D-1
process_vm_readv    4  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    5  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D1
process_vm_readv    6  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D2147483647
process_vm_readv    8  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    9  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D0
process_vm_readv   10  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_iov_len_overflow
process_vm_readv   11  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   12  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec->iov_base
process_vm_readv   13  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   14  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec->iov_base
process_vm_readv   15  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   16  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec
process_vm_readv   17  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   18  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec
process_vm_readv   19  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   20  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_pid
process_vm_readv   21  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   22  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv   23  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   24  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv    0  TINFO  :  test_invalid_perm
process_vm_readv    0  TINFO  :  test_invalid_protection lvec
process_vm_readv   25  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   26  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_protection rvec
process_vm_readv   27  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   28  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpselect03_64 stime=3D1629792673
cmdline=3D"pselect03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace03 stime=3D1629792673
cmdline=3D"ptrace03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ptrace03.c:43: TINFO: Trace a process which does not exist
ptrace03.c:56: TPASS: ptrace() failed as expected: ESRCH (3)
ptrace03.c:43: TINFO: Trace a process which is already been traced
ptrace03.c:56: TPASS: ptrace() failed as expected: EPERM (1)

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
tag=3Dptrace11 stime=3D1629792673
cmdline=3D"ptrace11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ptrace11.c:28: TPASS: ptrace() traces init process successfully

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
tag=3Dpwrite03 stime=3D1629792673
cmdline=3D"pwrite03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwrite03.c:25: TPASS: pwrite(fd, NULL, 0) =3D=3D 0

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
tag=3Dpwrite04_64 stime=3D1629792673
cmdline=3D"pwrite04_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pwrite04    1  TPASS  :  O_APPEND test passed.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev02_64 stime=3D1629792673
cmdline=3D"pwritev02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EFAULT (14)
pwritev02.c:84: TPASS: pwritev() failed as expected: EBADF (9)
pwritev02.c:84: TPASS: pwritev() failed as expected: EBADF (9)
pwritev02.c:84: TPASS: pwritev() failed as expected: ESPIPE (29)

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
tag=3Dpwritev03 stime=3D1629792673
cmdline=3D"pwritev03"
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
tst_test.c:1414: TINFO: Testing on ext2
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on ext3
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on ext4
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on xfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on btrfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on vfat
tst_test.c:916: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on ntfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:930: TINFO: Trying FUSE...
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20

Summary:
passed   21
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D8 cstime=3D102
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev201_64 stime=3D1629792679
cmdline=3D"pwritev201_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20

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
tag=3Dpwritev202 stime=3D1629792679
cmdline=3D"pwritev202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev202.c:78: TPASS: pwritev2() failed as expected: EINVAL (22)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EINVAL (22)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EOPNOTSUPP (95)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EFAULT (14)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EBADF (9)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EBADF (9)
pwritev202.c:78: TPASS: pwritev2() failed as expected: ESPIPE (29)

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
tag=3Dquotactl05 stime=3D1629792679
cmdline=3D"quotactl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:916: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
quotactl05.c:73: TINFO: Test #0: QCMD(Q_XGETQSTAT, PRJQUOTA) off
quotactl02.h:68: TPASS: quotactl() succeeded to turn off xfs quota and get =
xfs quota off status for project
quotactl05.c:73: TINFO: Test #1: QCMD(Q_XGETQSTAT, PRJQUOTA) on
quotactl02.h:88: TPASS: quotactl() succeeded to turn on xfs quota and get x=
fs quota on status for project
quotactl05.c:73: TINFO: Test #2: QCMD(Q_XGETQUOTA, PRJQUOTA) qlim
quotactl02.h:162: TPASS: quotactl() succeeded to set and use Q_XGETQUOTA fo=
r project to get xfs disk quota limits
quotactl05.c:73: TINFO: Test #3: QCMD(Q_XGETNEXTQUOTA, PRJQUOTA)
quotactl02.h:162: TPASS: quotactl() succeeded to set and use Q_XGETNEXTQUOT=
A for project to get xfs disk quota limits
quotactl05.c:73: TINFO: Test #4: QCMD(Q_XGETQSTATV, PRJQUOTA) off
quotactl02.h:110: TPASS: quotactl() succeeded to turn off xfs quota and get=
 xfs quota off statv for project
quotactl05.c:73: TINFO: Test #5: QCMD(Q_XGETQSTATV, PRJQUOTA) on
quotactl02.h:132: TPASS: quotactl() succeeded to turn on xfs quota and get =
xfs quota on statv for project

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Dread01 stime=3D1629792680
cmdline=3D"read01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
read01.c:24: TPASS: read(2) returned 512

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
tag=3Dreadlinkat02 stime=3D1629792680
cmdline=3D"readlinkat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
readlinkat02    1  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEI=
NVAL(22): Invalid argument
readlinkat02    2  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEI=
NVAL(22): Invalid argument
readlinkat02    3  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEN=
OTDIR(20): Not a directory
readlinkat02    4  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEN=
OTDIR(20): Not a directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreadv03 stime=3D1629792680
cmdline=3D"readv03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
readv03.c:33: TPASS: readv() got EISDIR : EISDIR (21)

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
tag=3Dreboot01 stime=3D1629792680
cmdline=3D"reboot01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
reboot01.c:34: TPASS: reboot(LINUX_REBOOT_CMD_CAD_ON) passed
reboot01.c:34: TPASS: reboot(LINUX_REBOOT_CMD_CAD_OFF) passed

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
tag=3Dremovexattr01 stime=3D1629792680
cmdline=3D"removexattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
removexattr01    1  TPASS  :  removexattr() succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drename07 stime=3D1629792680
cmdline=3D"rename07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
rename07    1  TPASS  :  rename() returned ENOTDIR
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drequest_key02 stime=3D1629792680
cmdline=3D"request_key02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
request_key02.c:53: TPASS: request_key() failed expectly: ENOKEY (126)
request_key02.c:53: TPASS: request_key() failed expectly: EKEYREVOKED (128)
request_key02.c:53: TPASS: request_key() failed expectly: EKEYEXPIRED (127)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drt_sigsuspend01 stime=3D1629792682
cmdline=3D"rt_sigsuspend01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
rt_sigsuspend01.c:49: TPASS: rt_sigsuspend() returned with -1 and EINTR
rt_sigsuspend01.c:58: TPASS: signal mask preserved

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
tag=3Dsched_get_priority_min01 stime=3D1629792683
cmdline=3D"sched_get_priority_min01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_get_priority_min01    1  TPASS  :  Test for SCHED_OTHER Passed
sched_get_priority_min01    2  TPASS  :  Test for SCHED_FIFO Passed
sched_get_priority_min01    3  TPASS  :  Test for SCHED_RR Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setparam01 stime=3D1629792683
cmdline=3D"sched_setparam01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
sched_setparam01.c:30: TINFO: Testing libc variant
sched_setparam01.c:25: TPASS: sched_setparam(0, 0) passed
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
sched_setparam01.c:30: TINFO: Testing syscall variant
sched_setparam01.c:25: TPASS: sched_setparam(0, 0) passed

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
tag=3Dsched_getattr01 stime=3D1629792683
cmdline=3D"sched_getattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_getattr01    1  TPASS  :  attributes were read back correctly
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemctl06 stime=3D1629792683
cmdline=3D"semctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
semctl06    1  TPASS  :  semctl06 ran successfully!
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemget03 stime=3D1629792683
cmdline=3D"semget03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
semget03    1  TPASS  :  expected failure - errno =3D 2 : No such file or d=
irectory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemop02 stime=3D1629792683
cmdline=3D"semop02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
semop02.c:78: TINFO: Testing variant: semop: syscall
semop02.c:148: TPASS: semop failed as expected: E2BIG (7)
semop02.c:148: TPASS: semop failed as expected: EACCES (13)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: ERANGE (34)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:123: TCONF: Test not supported for variant
semop02.c:123: TCONF: Test not supported for variant
semop02.c:123: TCONF: Test not supported for variant
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
semop02.c:78: TINFO: Testing variant: semtimedop: syscall with old kernel s=
pec
semop02.c:148: TPASS: semop failed as expected: E2BIG (7)
semop02.c:148: TPASS: semop failed as expected: EACCES (13)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: ERANGE (34)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)

Summary:
passed   23
failed   0
broken   0
skipped  3
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsend01 stime=3D1629792683
cmdline=3D"send01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
send01      1  TPASS  :  bad file descriptor successful
send01      2  TPASS  :  invalid socket successful
send01      3  TPASS  :  invalid send buffer successful
send01      4  TPASS  :  UDP message too big successful
send01      5  TPASS  :  local endpoint shutdown successful
send01      6  TPASS  :  invalid flags set successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile03_64 stime=3D1629792683
cmdline=3D"sendfile03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
sendfile03.c:54: TPASS: sendfile(..) with out_fd=3D-1 : EBADF (9)
sendfile03.c:54: TPASS: sendfile(..) with out_fd=3DO_RDONLY : EBADF (9)
sendfile03.c:54: TPASS: sendfile(..) with in_fd=3D-1 : EBADF (9)
sendfile03.c:54: TPASS: sendfile(..) with out_fd=3DO_WRONLY : EBADF (9)

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
tag=3Dsendfile04 stime=3D1629792683
cmdline=3D"sendfile04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
sendfile04.c:63: TPASS: sendfile(..) with pass_mapped_buffer, protection=3D=
0 : EFAULT (14)
sendfile04.c:63: TPASS: sendfile(..) with pass_mapped_buffer, protection=3D=
1 : EFAULT (14)
sendfile04.c:63: TPASS: sendfile(..) with pass_mapped_buffer, protection=3D=
4 : EFAULT (14)
sendfile04.c:63: TPASS: sendfile(..) with pass_mapped_buffer, protection=3D=
5 : EFAULT (14)
sendfile04.c:63: TPASS: sendfile(..) with pass_unmapped_buffer, protection=
=3D3 : EFAULT (14)

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
tag=3Dsendfile07_64 stime=3D1629792683
cmdline=3D"sendfile07_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
sendfile07.c:60: TPASS: sendfile(out_fd, in_fd, NULL, 1) with blocked out_f=
d : EAGAIN/EWOULDBLOCK (11)

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
tag=3Dsendmsg01 stime=3D1629792683
cmdline=3D"sendmsg01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendmsg01    1  TPASS  :  bad file descriptor successful
sendmsg01    2  TPASS  :  invalid socket successful
sendmsg01    3  TPASS  :  invalid send buffer successful
sendmsg01    4  TPASS  :  connected TCP successful
sendmsg01    5  TPASS  :  not connected TCP successful
sendmsg01    6  TPASS  :  invalid to buffer length successful
sendmsg01    7  TPASS  :  invalid to buffer successful
sendmsg01    8  TPASS  :  UDP message too big successful
sendmsg01    9  TPASS  :  local endpoint shutdown successful
sendmsg01   10  TPASS  :  invalid iovec pointer successful
sendmsg01   11  TPASS  :  invalid msghdr pointer successful
sendmsg01   12  TPASS  :  rights passing successful
sendmsg01   13  TPASS  :  invalid flags set successful
sendmsg01   14  TPASS  :  invalid cmsg length successful
sendmsg01   15  TPASS  :  invalid cmsg pointer successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dset_mempolicy02 stime=3D1629792683
cmdline=3D"set_mempolicy02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy02.c:39: TCONF: Test requires at least two NUMA memory nodes

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
tag=3Dset_tid_address01 stime=3D1629792683
cmdline=3D"set_tid_address01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
set_tid_address01    1  TPASS  :  set_tid_address call succeeded:  as expec=
ted 4285
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetdomainname01 stime=3D1629792683
cmdline=3D"setdomainname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:36: TINFO: Testing libc setdomainname()
setdomainname01.c:26: TPASS: setdomainname() succeed
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:39: TINFO: Testing __NR_setdomainname syscall
setdomainname01.c:26: TPASS: setdomainname() succeed

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
tag=3Dsetfsuid01 stime=3D1629792683
cmdline=3D"setfsuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsuid01    1  TPASS  :  setfsuid() returned expected value : 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsgetmask01 stime=3D1629792683
cmdline=3D"sgetmask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sgetmask01    1  TCONF  :  sgetmask01.c:128: syscall(-1) __NR_ssetmask not =
supported on your arch
sgetmask01    2  TCONF  :  sgetmask01.c:128: Remaining cases not appropriat=
e for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgroups04_16 stime=3D1629792683
cmdline=3D"setgroups04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgroups04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setgroups/../utils/compat_16.h:77: 16-bit version of setgroups() is not =
supported on your platform
setgroups04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setgroups/../utils/compat_16.h:77: Remaining cases not appropriate for c=
onfiguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetitimer03 stime=3D1629792683
cmdline=3D"setitimer03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setitimer03    1  TPASS  :  expected failure - errno =3D 22 - Invalid argum=
ent
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetpgrp01 stime=3D1629792683
cmdline=3D"setpgrp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setpgrp01    1  TPASS  :  setpgrp -  Call the setpgrp system call returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetpriority01 stime=3D1629792683
cmdline=3D"setpriority01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
setpriority01.c:75: TPASS: setpriority(PRIO_PROCESS(0), 4303, -20..19) succ=
eeded
setpriority01.c:75: TPASS: setpriority(PRIO_PGRP(1), 4304, -20..19) succeed=
ed
setpriority01.c:75: TPASS: setpriority(PRIO_USER(2), 1091, -20..19) succeed=
ed
userdel: ltp_setpriority01 mail spool (/var/mail/ltp_setpriority01) not fou=
nd
userdel: ltp_setpriority01 home directory (/home/ltp_setpriority01) not fou=
nd

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
tag=3Dsetregid01 stime=3D1629792683
cmdline=3D"setregid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
setregid01.c:49: TPASS: Dont change either real or effective gid
setregid01.c:49: TPASS: Change effective to effective gid
setregid01.c:49: TPASS: Change real to real gid
setregid01.c:49: TPASS: Change effective to real gid
setregid01.c:49: TPASS: Try to change real to current real

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
tag=3Dsetreuid07 stime=3D1629792683
cmdline=3D"setreuid07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open failed with EACCES as expected
open failed with EACCES as expected
open call succeeded
setreuid07    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetuid01 stime=3D1629792683
cmdline=3D"setuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
setuid01.c:30: TPASS: setuid(0) successfully

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
tag=3Dshmctl07 stime=3D1629792683
cmdline=3D"shmctl07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
shmctl07.c:31: TPASS: shmctl(1, SHM_LOCK, NULL)
shmctl07.c:37: TPASS: SMH_LOCKED bit is on in shm_perm.mode
shmctl07.c:46: TPASS: shmctl(1, SHM_UNLOCK, NULL)
shmctl07.c:53: TPASS: SHM_LOCKED bit is off in shm_perm.mode

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
tag=3Dshmget02 stime=3D1629792683
cmdline=3D"shmget02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_hugepage.c:64: TINFO: 0 hugepage(s) reserved
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
shmget02.c:84: TPASS: shmget(1645281285, 2048, 1024) : ENOENT (2)
shmget02.c:84: TPASS: shmget(1628504069, 2048, 1536) : EEXIST (17)
shmget02.c:84: TPASS: shmget(1645281285, 0, 1536) : EINVAL (22)
shmget02.c:84: TPASS: shmget(1645281285, 18446744073692774400, 1536) : EINV=
AL (22)
shmget02.c:84: TPASS: shmget(1628504069, 4096, 1024) : EINVAL (22)
shmget02.c:96: TPASS: shmget(1628504069, 2048, 256) : EACCES (13)
shmget02.c:96: TPASS: shmget(1645281285, 2048, 2560) : EPERM (1)
shmget02.c:84: TPASS: shmget(1645281285, 2048, 2560) : ENOMEM (12)

Summary:
passed   8
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
tag=3Dsignal02 stime=3D1629792683
cmdline=3D"signal02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal02    1  TPASS  :  expected failure - errno =3D 22 - Invalid argument
signal02    2  TPASS  :  expected failure - errno =3D 22 - Invalid argument
signal02    3  TPASS  :  expected failure - errno =3D 22 - Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsplice03 stime=3D1629792683
cmdline=3D"splice03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EINVAL (22)
splice03.c:99: TPASS: splice() failed as expected: EINVAL (22)
splice03.c:99: TPASS: splice() failed as expected: ESPIPE (29)
splice03.c:99: TPASS: splice() failed as expected: ESPIPE (29)

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
tag=3Dssetmask01 stime=3D1629792683
cmdline=3D"ssetmask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
ssetmask01    1  TCONF  :  ssetmask01.c:115: syscall(-1) __NR_ssetmask not =
supported on your arch
ssetmask01    2  TCONF  :  ssetmask01.c:115: Remaining cases not appropriat=
e for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatfs02 stime=3D1629792683
cmdline=3D"statfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs02    1  TPASS  :  expected failure: TEST_ERRNO=3DENOTDIR(20): Not a =
directory
statfs02    2  TPASS  :  expected failure: TEST_ERRNO=3DENOENT(2): No such =
file or directory
statfs02    3  TPASS  :  expected failure: TEST_ERRNO=3DENAMETOOLONG(36): F=
ile name too long
statfs02    4  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): Bad add=
ress
statfs02    5  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): Bad add=
ress
statfs02    6  TPASS  :  expected failure: TEST_ERRNO=3DELOOP(40): Too many=
 levels of symbolic links
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dswapoff01 stime=3D1629792683
cmdline=3D"swapoff01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_ioctl.c:30: TINFO: FIBMAP ioctl is supported
swapoff01.c:35: TPASS: Succeeded to turn off swapfile

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D3 cstime=3D11
<<<test_end>>>
<<<test_start>>>
tag=3Dswitch01 stime=3D1629792684
cmdline=3D"endian_switch01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:941: TCONF: This system does not support running of switch() sys=
call
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsymlink02 stime=3D1629792684
cmdline=3D"symlink02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsymlink05 stime=3D1629792684
cmdline=3D"symlink05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
symlink05    1  TPASS  :  symlink(testfile, slink_file) functionality succe=
ssful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsysinfo02 stime=3D1629792684
cmdline=3D"sysinfo02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sysinfo02    1  TPASS  :  Test to check the error code 14 PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog02 stime=3D1629792684
cmdline=3D"syslog02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog02    0  TINFO  :  Test if messages of all levels are logged.
syslog02    0  TINFO  :  For each level, a separate configuration file is
syslog02    0  TINFO  :  created and that will be used as syslog.conf file.
syslog02    0  TINFO  :  testing whether messages are logged into log file
syslog02    0  TINFO  :  Doing level: emerg...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    1  TPASS  :  ***** Level emerg passed *****
syslog02    0  TINFO  :  Doing level: alert...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    2  TPASS  :  ***** Level alert passed *****
syslog02    0  TINFO  :  Doing level: crit...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    3  TPASS  :  ***** Level crit passed *****
syslog02    0  TINFO  :  Doing level: err...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    4  TPASS  :  ***** Level err passed *****
syslog02    0  TINFO  :  Doing level: warning...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    5  TPASS  :  ***** Level warning passed *****
syslog02    0  TINFO  :  Doing level: notice...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    6  TPASS  :  ***** Level notice passed *****
syslog02    0  TINFO  :  Doing level: info...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    7  TPASS  :  ***** Level info passed *****
syslog02    0  TINFO  :  Doing level: debug...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    8  TPASS  :  ***** Level debug passed *****
syslog02    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D35 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D5 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog10 stime=3D1629792719
cmdline=3D"syslog10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog10    0  TINFO  :   Test setlogmask() with LOG_MASK macro.
syslog10    0  TINFO  :   o Use setlogmask() with LOG_MASK macro to set an
syslog10    0  TINFO  :     individual priority level.
syslog10    0  TINFO  :   o Send the message of above prority and expect it=
 to be
syslog10    0  TINFO  :     logged.
syslog10    0  TINFO  :   o Send message which is at other priority level to
syslog10    0  TINFO  :     the one set above, which should not be logged.
syslog10    0  TINFO  :  syslog: Testing setlogmask() with LOG_MASK macro...
syslog10    0  TINFO  :  restarting syslog daemon
syslog10    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dtimerfd_settime01 stime=3D1629792725
cmdline=3D"timerfd_settime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
timerfd_settime01.c:53: TINFO: Testing variant: syscall with old kernel spec
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EBADF =
(9)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EFAULT=
 (14)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EINVAL=
 (22)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EINVAL=
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
tag=3Dtimer_delete02 stime=3D1629792725
cmdline=3D"timer_delete02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
timer_delete02.c:30: TPASS: Failed as expected: EINVAL (22)

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
tag=3Dutime03 stime=3D1629792725
cmdline=3D"utime03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
utime03     1  TPASS  :  Functionality of utime(tmp_file, NULL) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dutime05 stime=3D1629792729
cmdline=3D"utime05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
utime05     1  TPASS  :  Functionality of utime(tmp_file, &times) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwait02 stime=3D1629792729
cmdline=3D"wait02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
wait02.c:41: TPASS: wait() succeeded

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
tag=3Dwait402 stime=3D1629792729
cmdline=3D"wait402"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
wait402     1  TPASS  :  received expected failure - errno =3D 10 - No chil=
d processes
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid01 stime=3D1629792729
cmdline=3D"waitpid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
waitpid01.c:38: TPASS: waitpid() returned correct pid 4665
waitpid01.c:47: TPASS: WIFSIGNALED() set in status
waitpid01.c:55: TPASS: WTERMSIG() =3D=3D SIGALRM

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
tag=3Dwaitpid06 stime=3D1629792729
cmdline=3D"waitpid06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
waitpid06.c:54: TPASS: Test PASSED

Summary:
passed   1
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
tag=3Dwaitid01 stime=3D1629792730
cmdline=3D"waitid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4679 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4680 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4679 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4680 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4681 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4679 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4680 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4681 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4682 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4683 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4679 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4680 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4681 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4682 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4683 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4684 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4679 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4680 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4681 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4682 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4683 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4684 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4685 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4686 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    1  TPASS  :  waitid(): system call passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwritev02 stime=3D1629792730
cmdline=3D"writev02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
writev02    1  TPASS  :  Received EFAULT as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfutex_wait01 stime=3D1629792730
cmdline=3D"futex_wait01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
futex_wait01.c:69: TINFO: Testing variant: syscall with old kernel spec
futex_wait01.c:62: TPASS: futex_wait() passed: ETIMEDOUT (110)
futex_wait01.c:62: TPASS: futex_wait() passed: EAGAIN/EWOULDBLOCK (11)
futex_wait01.c:62: TPASS: futex_wait() passed: ETIMEDOUT (110)
futex_wait01.c:62: TPASS: futex_wait() passed: EAGAIN/EWOULDBLOCK (11)

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
tag=3Dfutex_wait_bitset01 stime=3D1629792730
cmdline=3D"futex_wait_bitset01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
futex_wait_bitset01.c:99: TINFO: Testing variant: syscall with old kernel s=
pec
futex_wait_bitset01.c:45: TINFO: testing futex_wait_bitset() timeout with C=
LOCK_MONOTONIC
futex_wait_bitset01.c:87: TPASS: futex_wait_bitset() waited 100120us, expec=
ted 100010us
futex_wait_bitset01.c:45: TINFO: testing futex_wait_bitset() timeout with C=
LOCK_REALTIME
futex_wait_bitset01.c:87: TPASS: futex_wait_bitset() waited 100101us, expec=
ted 100010us

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
tag=3Dio_uring02 stime=3D1629792730
cmdline=3D"io_uring02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
io_uring02.c:192: TINFO: IOSQE_ASYNC is supported
io_uring02.c:205: TPASS: Write outside chroot failed as expected: ENOENT (2)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20210524-323-g46263457f

       ###############################################################

            Done executing testcases.
            LTP Version:  20210524-323-g46263457f
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


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.14.0-rc6-00228-gf7e33bdbd6d1"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.14.0-rc6 Kernel Configuration
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
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
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
CONFIG_TIME_KUNIT_TEST=m

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
# CONFIG_SCHED_CORE is not set

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
CONFIG_ACPI_PRMT=y

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
CONFIG_HAVE_KVM_PM_NOTIFIER=y
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
CONFIG_ARCH_WANTS_NO_INSTR=y
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
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
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
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
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
CONFIG_SECRETMEM=y
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
# CONFIG_NETFILTER_NETLINK_HOOK is not set
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
CONFIG_AUXILIARY_BUS=y
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
# CONFIG_SCSI_MPI3MR is not set
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
# CONFIG_SCSI_EFCT is not set
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
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
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
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
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
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
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

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

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
# CONFIG_XILLYUSB is not set
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
# CONFIG_BATTERY_RT5033 is not set
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
# CONFIG_SENSORS_DPS920AB is not set
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
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PIM4328 is not set
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
# CONFIG_SENSORS_SHT4x is not set
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
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

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
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
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
# CONFIG_VIDEO_IMX208 is not set
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
# CONFIG_DRM_SIMPLEDRM is not set
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
# CONFIG_DRM_HYPERV is not set
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
# CONFIG_FB_SSD1307 is not set
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
CONFIG_LEDS_LT3593=m
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
# CONFIG_WIRELESS_HOTKEY is not set
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
# CONFIG_THINKPAD_LMI is not set
CONFIG_X86_PLATFORM_DRIVERS_INTEL=y
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
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_LMK04832 is not set
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
# CONFIG_VIRTIO_IOMMU is not set

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
# CONFIG_PHY_CAN_TRANSCEIVER is not set
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
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
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
CONFIG_CIFS_STATS2=y
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
# CONFIG_IMA_DISABLE_HTABLE is not set
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
# CONFIG_STACKTRACE_BUILD_ID is not set
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
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
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
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
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
CONFIG_RATIONAL_KUNIT_TEST=m
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
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--ReaqsoxgOBHFXBhH
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
	export submit_id='6124a65e47b5276391a07db1'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-ext4-syscalls-07-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3-20210824-25489-1d81u4d-5.yaml'
	export id='1ccad7afc78de7c30a6ddaff1bdcb983241a641a'
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
EXT4_FS'
	export commit='f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3'
	export need_kconfig_hw='{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xe2'
	export enqueue_time='2021-08-24 15:57:18 +0800'
	export _id='6124a66e47b5276391a07db5'
	export _rt='/result/ltp/1HDD-ext4-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='f5ffce8707c9d2ae6fc6a4a4123b247bb4222cf6'
	export base_commit='e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93'
	export branch='jlayton/locks-next'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/ltp/1HDD-ext4-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/3'
	export scheduler_version='/lkp/lkp/.src-20210824-141808'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-ext4-syscalls-07-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3-20210824-25489-1d81u4d-5.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=jlayton/locks-next
commit=f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/vmlinuz-5.14.0-rc6-00228-gf7e33bdbd6d1
max_uptime=2100
RESULT_ROOT=/result/ltp/1HDD-ext4-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210821.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210821.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.14.0-rc7'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/vmlinuz-5.14.0-rc6-00228-gf7e33bdbd6d1'
	export dequeue_time='2021-08-24 16:08:35 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-ext4-syscalls-07-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3-20210824-25489-1d81u4d-5.cgz'

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

	run_setup fs='ext4' $LKP_SRC/setup/fs

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='syscalls-07' $LKP_SRC/tests/wrapper ltp
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='syscalls-07' $LKP_SRC/stats/wrapper ltp
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

--ReaqsoxgOBHFXBhH
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ltp
Content-Transfer-Encoding: quoted-printable

2021-08-24 08:10:24 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-08-24 08:10:24 ./runltp -f syscalls-07 -d /fs/sdb1/tmpdir
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
Linux lkp-skl-d02 5.14.0-rc6-00228-gf7e33bdbd6d1 #1 SMP Tue Aug 24 11:42:23=
 CST 2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-ext4-syscalls-07-ucode=3D0xe2-debian-10.4-x86_64=
-20200603.cgz-f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3-20210824-25489-1d81u=
4d-5.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Djlayton/locks-ne=
xt commit=3Df7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3 BOOT_IMAGE=3D/pkg/linu=
x/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/vmlinuz-5.=
14.0-rc6-00228-gf7e33bdbd6d1 max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1H=
DD-ext4-syscalls-07-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cg=
z/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/3 LKP_SERV=
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
Modules Loaded         dm_mod xfs libcrc32c ipmi_devintf ipmi_msghandler sd=
_mod t10_pi sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_=
powerclamp coretemp i915 intel_gtt ttm kvm_intel ahci drm_kms_helper kvm me=
i_wdt libahci syscopyarea sysfillrect irqbypass sysimgblt crct10dif_pclmul =
fb_sys_fops crc32_pclmul wmi_bmof crc32c_intel drm ghash_clmulni_intel rapl=
 libata mei_me intel_cstate mei intel_uncore intel_pch_thermal wmi video in=
tel_pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32753616      356684    29755416       21796     2641516    2952=
2276
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
CPU MHz:             3517.084
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
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2618     -n 2618 -=
p -f /fs/sdb1/tmpdir/ltp-r964nMX0k4/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_08_24-08h_10m_24s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_08_24-08h_10m_24s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_08_24-08h_10m_24s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_08_24-08h_10m_24s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_08_24-08h_1=
0m_24s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_08_24-08h_10=
m_24s.tconf
Running tests.......
<<<test_start>>>
tag=3Dabort01 stime=3D1629792624
cmdline=3D"abort01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
abort01.c:62: TPASS: abort() dumped core
abort01.c:65: TPASS: abort() raised SIGIOT

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
tag=3Daccess02 stime=3D1629792624
cmdline=3D"access02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
access02.c:142: TPASS: access(file_f, F_OK) as root behaviour is correct.
access02.c:142: TPASS: access(file_f, F_OK) as nobody behaviour is correct.
access02.c:142: TPASS: access(file_r, R_OK) as root behaviour is correct.
access02.c:142: TPASS: access(file_r, R_OK) as nobody behaviour is correct.
access02.c:142: TPASS: access(file_w, W_OK) as root behaviour is correct.
access02.c:142: TPASS: access(file_w, W_OK) as nobody behaviour is correct.
access02.c:142: TPASS: access(file_x, X_OK) as root behaviour is correct.
access02.c:142: TPASS: access(file_x, X_OK) as nobody behaviour is correct.
access02.c:142: TPASS: access(symlink_f, F_OK) as root behaviour is correct.
access02.c:142: TPASS: access(symlink_f, F_OK) as nobody behaviour is corre=
ct.
access02.c:142: TPASS: access(symlink_r, R_OK) as root behaviour is correct.
access02.c:142: TPASS: access(symlink_r, R_OK) as nobody behaviour is corre=
ct.
access02.c:142: TPASS: access(symlink_w, W_OK) as root behaviour is correct.
access02.c:142: TPASS: access(symlink_w, W_OK) as nobody behaviour is corre=
ct.
access02.c:142: TPASS: access(symlink_x, X_OK) as root behaviour is correct.
access02.c:142: TPASS: access(symlink_x, X_OK) as nobody behaviour is corre=
ct.

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
tag=3Dalarm02 stime=3D1629792624
cmdline=3D"alarm02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
alarm02.c:62: TPASS: alarm(2147483647) returned 2147483647 as expected for =
value INT_MAX
alarm02.c:62: TPASS: alarm(2147483647) returned 2147483647 as expected for =
value UINT_MAX/2
alarm02.c:62: TPASS: alarm(1073741823) returned 1073741823 as expected for =
value UINT_MAX/4

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
tag=3Dbind01 stime=3D1629792624
cmdline=3D"bind01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
bind01.c:52: TPASS: invalid salen : EINVAL (22)
bind01.c:52: TPASS: invalid socket : ENOTSOCK (88)
bind01.c:55: TPASS: INADDR_ANYPORT passed
bind01.c:52: TPASS: UNIX-domain of current directory : EAFNOSUPPORT (97)
bind01.c:52: TPASS: non-local address : EADDRNOTAVAIL (99)

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
tag=3Dbrk01 stime=3D1629792624
cmdline=3D"brk01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
brk01.c:52: TPASS: brk() works fine

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
tag=3Dchmod01 stime=3D1629792624
cmdline=3D"chmod01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
chmod01.c:57: TINFO: Testing variant: verify permissions of file
chmod01.c:38: TPASS: chmod(testfile, 0000) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D0000
chmod01.c:38: TPASS: chmod(testfile, 0007) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D0007
chmod01.c:38: TPASS: chmod(testfile, 0070) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D0070
chmod01.c:38: TPASS: chmod(testfile, 0700) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D0700
chmod01.c:38: TPASS: chmod(testfile, 0777) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D0777
chmod01.c:38: TPASS: chmod(testfile, 2777) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D2777
chmod01.c:38: TPASS: chmod(testfile, 4777) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D4777
chmod01.c:38: TPASS: chmod(testfile, 6777) passed
chmod01.c:48: TPASS: stat(testfile) mode=3D6777
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
chmod01.c:57: TINFO: Testing variant: verify permissions of directory
chmod01.c:38: TPASS: chmod(testdir_1, 0000) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D0000
chmod01.c:38: TPASS: chmod(testdir_1, 0007) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D0007
chmod01.c:38: TPASS: chmod(testdir_1, 0070) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D0070
chmod01.c:38: TPASS: chmod(testdir_1, 0700) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D0700
chmod01.c:38: TPASS: chmod(testdir_1, 0777) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D0777
chmod01.c:38: TPASS: chmod(testdir_1, 2777) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D2777
chmod01.c:38: TPASS: chmod(testdir_1, 4777) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D4777
chmod01.c:38: TPASS: chmod(testdir_1, 6777) passed
chmod01.c:48: TPASS: stat(testdir_1) mode=3D6777

Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchmod07 stime=3D1629792624
cmdline=3D"chmod07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
chmod07.c:59: TPASS: Functionality of chmod(testfile, 01777) successful

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
tag=3Dchown01 stime=3D1629792624
cmdline=3D"chown01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
chown01.c:25: TPASS: chown(chown01_testfile,0,0) passed

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
tag=3Dchown04_16 stime=3D1629792624
cmdline=3D"chown04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dchroot02 stime=3D1629792624
cmdline=3D"chroot02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
chroot02.c:30: TPASS: chroot(/fs/sdb1/tmpdir/ltp-r964nMX0k4/chr6byA2e) pass=
ed
chroot02.c:34: TPASS: stat(/chroot02_testfile) passed

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
tag=3Dclock_adjtime01 stime=3D1629792624
cmdline=3D"clock_adjtime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
clock_adjtime01.c:186: TINFO: Testing variant: syscall with old kernel spec
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741072(us)
clock_adjtime.h:160: TINFO: SET
             mode: 32769
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741078(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741081(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D8001)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741100(us)
clock_adjtime.h:160: TINFO: SET
             mode: 40961
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741102(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741104(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3Da001)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741108(us)
clock_adjtime.h:160: TINFO: SET
             mode: 16447
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741111(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741127(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D403f)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741131(us)
clock_adjtime.h:160: TINFO: SET
             mode: 1
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741134(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741136(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D1)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741140(us)
clock_adjtime.h:160: TINFO: SET
             mode: 2
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741143(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741145(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D2)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741150(us)
clock_adjtime.h:160: TINFO: SET
             mode: 4
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741152(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741154(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D4)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741159(us)
clock_adjtime.h:160: TINFO: SET
             mode: 8
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741161(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741164(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D8)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741168(us)
clock_adjtime.h:160: TINFO: SET
             mode: 32
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741170(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741172(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D20)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1629792624(s) 741177(us)
clock_adjtime.h:160: TINFO: SET
             mode: 16384
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 11000
         raw time: 1629792624(s) 741179(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 11000
         raw time: 1629792624(s) 741182(us)
clock_adjtime01.c:177: TPASS: clock_adjtime(): success (mode=3D4000)

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
tag=3Dclose01 stime=3D1629792624
cmdline=3D"close01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
close01.c:50: TPASS: close a file fd passed
close01.c:50: TPASS: close a pipe fd passed
close01.c:50: TPASS: close a socket fd passed

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
tag=3Dconfstr01 stime=3D1629792624
cmdline=3D"confstr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
confstr01    1  TPASS  :  confstr PATH =3D '/bin:/usr/bin'
confstr01    2  TPASS  :  confstr XBS5_ILP32_OFF32_CFLAGS =3D ''
confstr01    3  TPASS  :  confstr XBS5_ILP32_OFF32_LDFLAGS =3D ''
confstr01    4  TPASS  :  confstr XBS5_ILP32_OFF32_LIBS =3D ''
confstr01    5  TPASS  :  confstr XBS5_ILP32_OFF32_LINTFLAGS =3D ''
confstr01    6  TPASS  :  confstr XBS5_ILP32_OFFBIG_CFLAGS =3D ''
confstr01    7  TPASS  :  confstr XBS5_ILP32_OFFBIG_LDFLAGS =3D ''
confstr01    8  TPASS  :  confstr XBS5_ILP32_OFFBIG_LIBS =3D ''
confstr01    9  TPASS  :  confstr XBS5_ILP32_OFFBIG_LINTFLAGS =3D ''
confstr01   10  TPASS  :  confstr XBS5_LP64_OFF64_CFLAGS =3D '-m64'
confstr01   11  TPASS  :  confstr XBS5_LP64_OFF64_LDFLAGS =3D '-m64'
confstr01   12  TPASS  :  confstr XBS5_LP64_OFF64_LIBS =3D ''
confstr01   13  TPASS  :  confstr XBS5_LP64_OFF64_LINTFLAGS =3D ''
confstr01   14  TPASS  :  confstr XBS5_LPBIG_OFFBIG_CFLAGS =3D ''
confstr01   15  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LDFLAGS =3D ''
confstr01   16  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LIBS =3D ''
confstr01   17  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LINTFLAGS =3D ''
confstr01   18  TPASS  :  confstr GNU_LIBC_VERSION =3D 'glibc 2.28'
confstr01   19  TPASS  :  confstr GNU_LIBPTHREAD_VERSION =3D 'NPTL 2.28'
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dcreat06 stime=3D1629792624
cmdline=3D"creat06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
creat06.c:105: TPASS: got expected failure: EISDIR (21)
creat06.c:105: TPASS: got expected failure: ENAMETOOLONG (36)
creat06.c:105: TPASS: got expected failure: ENOENT (2)
creat06.c:105: TPASS: got expected failure: ENOTDIR (20)
creat06.c:105: TPASS: got expected failure: EFAULT (14)
creat06.c:105: TPASS: got expected failure: EACCES (13)
creat06.c:105: TPASS: got expected failure: ELOOP (40)
creat06.c:105: TPASS: got expected failure: EROFS (30)

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
tag=3Depoll_create1_01 stime=3D1629792624
cmdline=3D"epoll_create1_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
epoll_create1_01.c:46: TPASS: epoll_create1(EPOLL_CLOEXEC) PASSED

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
tag=3Deventfd2_01 stime=3D1629792624
cmdline=3D"eventfd2_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
eventfd2_01    1  TPASS  :  eventfd2(EFD_CLOEXEC) Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Deventfd2_02 stime=3D1629792624
cmdline=3D"eventfd2_02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
eventfd2_02    1  TPASS  :  eventfd2(EFD_NONBLOCK) PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexecveat01 stime=3D1629792624
cmdline=3D"execveat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected

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
tag=3Dexit01 stime=3D1629792624
cmdline=3D"exit01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
exit01      1  TPASS  :  exit() test PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfsetxattr01 stime=3D1629792624
cmdline=3D"fsetxattr01"
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
tst_test.c:1414: TINFO: Testing on ext2
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on ext3
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on ext4
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on xfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on btrfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on vfat
tst_test.c:916: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:150: TCONF: fsetxattr(2) not supported
tst_test.c:1414: TINFO: Testing on ntfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:930: TINFO: Trying FUSE...
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1414: TINFO: Testing on tmpfs
tst_test.c:916: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:896: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:150: TCONF: fsetxattr(2) not supported

Summary:
passed   56
failed   0
broken   0
skipped  2
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D10 cstime=3D101
<<<test_end>>>
<<<test_start>>>
tag=3Dfsetxattr02 stime=3D1629792630
cmdline=3D"fsetxattr02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsetxattr02.c:170: TPASS: fsetxattr(2) on testfile passed
fsetxattr02.c:170: TPASS: fsetxattr(2) on testdir passed
fsetxattr02.c:192: TPASS: fsetxattr(2) on symlink failed: EEXIST (17)
fsetxattr02.c:192: TPASS: fsetxattr(2) on fifo failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on chr failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on blk failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on sock failed: EPERM (1)

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
tag=3Dposix_fadvise02 stime=3D1629792630
cmdline=3D"posix_fadvise02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF

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
tag=3Dfchmod04 stime=3D1629792630
cmdline=3D"fchmod04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fchmod04    1  TPASS  :  Functionality of fchmod(4, 01777) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfchown04 stime=3D1629792630
cmdline=3D"fchown04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fchown04.c:66: TPASS: fchown(4, 65534, 0) : EPERM (1)
fchown04.c:66: TPASS: fchown(-1, 65534, 0) : EBADF (9)
fchown04.c:66: TPASS: fchown(5, 65534, 0) : EROFS (30)

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
tag=3Dfcntl01 stime=3D1629792630
cmdline=3D"fcntl01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl07 stime=3D1629792630
cmdline=3D"fcntl07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl07     1  TPASS  :  regular file CLOEXEC fd was closed after exec()
fcntl07     2  TPASS  :  pipe (write end) CLOEXEC fd was closed after exec()
fcntl07     3  TPASS  :  pipe (read end) CLOEXEC fd was closed after exec()
fcntl07     4  TPASS  :  fifo CLOEXEC fd was closed after exec()
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl07_64 stime=3D1629792630
cmdline=3D"fcntl07_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl07     1  TPASS  :  regular file CLOEXEC fd was closed after exec()
fcntl07     2  TPASS  :  pipe (write end) CLOEXEC fd was closed after exec()
fcntl07     3  TPASS  :  pipe (read end) CLOEXEC fd was closed after exec()
fcntl07     4  TPASS  :  fifo CLOEXEC fd was closed after exec()
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl10 stime=3D1629792630
cmdline=3D"fcntl10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl10     1  TPASS  :  fcntl(tfile_2933, F_SETLKW, &flocks) flocks.l_type=
 =3D F_WRLCK returned 0
fcntl10     2  TPASS  :  fcntl(tfile_2933, F_SETLKW, &flocks) flocks.l_type=
 =3D F_UNLCK returned 0
fcntl10     1  TPASS  :  fcntl(tfile_2933, F_SETLKW, &flocks) flocks.l_type=
 =3D F_RDLCK returned 0
fcntl10     2  TPASS  :  fcntl(tfile_2933, F_SETLKW, &flocks) flocks.l_type=
 =3D F_UNLCK returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl13_64 stime=3D1629792630
cmdline=3D"fcntl13_64"
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
tag=3Dfcntl16 stime=3D1629792630
cmdline=3D"fcntl16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl16     0  TINFO  :  Entering block 1
fcntl16     0  TINFO  :  Test case 1: without manadatory locking PASSED
fcntl16     0  TINFO  :  Exiting block 1
fcntl16     0  TINFO  :  Entering block 2
fcntl16     0  TINFO  :  Test case 2: with mandatory record locking PASSED
fcntl16     0  TINFO  :  Exiting block 2
fcntl16     0  TINFO  :  Entering block 3
fcntl16     0  TINFO  :  Test case 3: mandatory locking with NODELAY PASSED
fcntl16     0  TINFO  :  Exiting block 3
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl23 stime=3D1629792630
cmdline=3D"fcntl23"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl23     1  TPASS  :  fcntl(tfile_2936, F_SETLEASE, F_RDLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl24_64 stime=3D1629792630
cmdline=3D"fcntl24_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl24     1  TPASS  :  fcntl(tfile_2937, F_SETLEASE, F_WRLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl25 stime=3D1629792630
cmdline=3D"fcntl25"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl25     1  TPASS  :  fcntl(tfile_2938, F_SETLEASE, F_WRLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl29 stime=3D1629792630
cmdline=3D"fcntl29"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl29     1  TPASS  :  fcntl test F_DUPFD_CLOEXEC success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl30_64 stime=3D1629792631
cmdline=3D"fcntl30_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl30     0  TINFO  :  orig_pipe_size: 65536 new_pipe_size: 131072
fcntl30     1  TPASS  :  fcntl test F_GETPIPE_SZ and F_SETPIPE_SZ passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl32 stime=3D1629792631
cmdline=3D"fcntl32"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl32     1  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     2  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     3  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     4  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     5  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     6  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     7  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     8  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     9  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl34 stime=3D1629792631
cmdline=3D"fcntl34"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl38 stime=3D1629792631
cmdline=3D"fcntl38"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fcntl38.c:67: TPASS: Got event on parent as expected
fcntl38.c:71: TPASS: Got event on subdir as expected

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
tag=3Dfcntl38_64 stime=3D1629792631
cmdline=3D"fcntl38_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fcntl38.c:67: TPASS: Got event on parent as expected
fcntl38.c:71: TPASS: Got event on subdir as expected

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
tag=3Dfinit_module02 stime=3D1629792631
cmdline=3D"finit_module02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_module.c:70: TCONF: Failed to find module 'finit_module.ko'

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
tag=3Dfremovexattr01 stime=3D1629792631
cmdline=3D"fremovexattr01"
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
tst_test.c:1414: TINFO: Testing on ext2
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on ext3
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on ext4
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on xfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on btrfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on vfat
tst_test.c:916: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:82: TCONF: fremovexattr(2) not supported
tst_test.c:1414: TINFO: Testing on ntfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:930: TINFO: Trying FUSE...
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1414: TINFO: Testing on tmpfs
tst_test.c:916: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:896: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:82: TCONF: fremovexattr(2) not supported

Summary:
passed   6
failed   0
broken   0
skipped  2
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7 cstime=3D106
<<<test_end>>>
<<<test_start>>>
tag=3Dfsopen01 stime=3D1629792636
cmdline=3D"fsopen01"
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
tst_supported_fs_types.c:157: TINFO: Skipping FUSE based ntfs as requested =
by the test
tst_supported_fs_types.c:89: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:38: TINFO: mkfs is not needed for tmpfs
tst_test.c:1414: TINFO: Testing on ext2
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on ext3
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on ext4
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on xfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on btrfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on vfat
tst_test.c:916: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1414: TINFO: Testing on tmpfs
tst_test.c:916: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed

Summary:
passed   14
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D6 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3Dfstat03_64 stime=3D1629792639
cmdline=3D"fstat03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fstat03.c:49: TPASS: fstat() fails with expected error EBADF
fstat03.c:49: TPASS: fstat() fails with expected error EFAULT

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
tag=3Dfstatfs02 stime=3D1629792639
cmdline=3D"fstatfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fstatfs02    1  TPASS  :  expected failure - errno =3D 9 : Bad file descrip=
tor
fstatfs02    2  TPASS  :  expected failure - errno =3D 14 : Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dftruncate03 stime=3D1629792639
cmdline=3D"ftruncate03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EBADF (9)

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
tag=3Dftruncate04_64 stime=3D1629792639
cmdline=3D"ftruncate04_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ftruncate04.c:116: TINFO: Child locks file
ftruncate04.c:49: TFAIL: ftruncate() offset before lock succeeded unexpecte=
dly
ftruncate04.c:49: TFAIL: ftruncate() offset in lock succeeded unexpectedly
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
ftruncate04.c:127: TINFO: Child unlocks file
ftruncate04.c:84: TPASS: ftruncate() offset in lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset before lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded

Summary:
passed   4
failed   2
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D8
<<<test_end>>>
<<<test_start>>>
tag=3Dgetcwd04 stime=3D1629792639
cmdline=3D"getcwd04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
getcwd04.c:60: TPASS: Bug is not reproduced!

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D334 cstime=3D657
<<<test_end>>>
<<<test_start>>>
tag=3Dgeteuid02_16 stime=3D1629792644
cmdline=3D"geteuid02_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
geteuid02_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: 16-bit version of geteuid() is not suppo=
rted on your platform
geteuid02_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: Remaining cases not appropriate for conf=
iguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetgid01_16 stime=3D1629792644
cmdline=3D"getgid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/getgid/../utils/compat_tst_1=
6.h:99: TCONF: 16-bit version of getgid() is not supported on your platform

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
tag=3Dgetgid03 stime=3D1629792644
cmdline=3D"getgid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
getgid03.c:43: TPASS: values from getgid() and getpwuid() match

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
tag=3Dgetrandom03 stime=3D1629792644
cmdline=3D"getrandom03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
getrandom03.c:37: TPASS: getrandom returned 1
getrandom03.c:37: TPASS: getrandom returned 2
getrandom03.c:37: TPASS: getrandom returned 3
getrandom03.c:37: TPASS: getrandom returned 7
getrandom03.c:37: TPASS: getrandom returned 8
getrandom03.c:37: TPASS: getrandom returned 15
getrandom03.c:37: TPASS: getrandom returned 22
getrandom03.c:37: TPASS: getrandom returned 64
getrandom03.c:37: TPASS: getrandom returned 127

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
tag=3Dgetresuid01 stime=3D1629792644
cmdline=3D"getresuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid01    1  TPASS  :  Functionality of getresuid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresuid02 stime=3D1629792644
cmdline=3D"getresuid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid02    1  TPASS  :  Functionality of getresuid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsid02 stime=3D1629792644
cmdline=3D"getsid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getsid02    1  TPASS  :  expected failure - errno =3D 3 - No such process
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetxattr05 stime=3D1629792644
cmdline=3D"getxattr05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice

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
tag=3Dioctl01_02 stime=3D1629792644
cmdline=3D"test_ioctl"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty0
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty0

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty1
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty1

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty10
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty10

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty11
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty11

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty12
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty12

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty13
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty13

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty14
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty14

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty15
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty15

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty16
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty16

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty17
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty17

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty18
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty18

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty19
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty19

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty2
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty2

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty20
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty20

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty21
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty21

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty22
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty22

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty23
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty23

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty24
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty24

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty25
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty25

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty26
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty26

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty27
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty27

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty28
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty28

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty29
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty29

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty3
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty3

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty30
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty30

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty31
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty31

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty32
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty32

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty33
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty33

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty34
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty34

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty35
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty35

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty36
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty36

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty37
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty37

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty38
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty38

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty39
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty39

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty4
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty4

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty40
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty40

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty41
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty41

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty42
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty42

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty43
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty43

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty44
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty44

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty45
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty45

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty46
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty46

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty47
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty47

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty48
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty48

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty49
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty49

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty5
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty5

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty50
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty50

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty51
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty51

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty52
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty52

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty53
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty53

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty54
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty54

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty55
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty55

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty56
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty56

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty57
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty57

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty58
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty58

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty59
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty59

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty6
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty6

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty60
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty60

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty61
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty61

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty62
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty62

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty63
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty63

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty7
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty7

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty8
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty8

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty9
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty9

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty0
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty0

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty1
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty1

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty10
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty10

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty11
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty11

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty12
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty12

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty13
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty13

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty14
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty14

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty15
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty15

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty16
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty16

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty17
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty17

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty18
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty18

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty19
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty19

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty2
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty2

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty20
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty20

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty21
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty21

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty22
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty22

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty23
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty23

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty24
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty24

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty25
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty25

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty26
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty26

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty27
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty27

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty28
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty28

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty29
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty29

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty3
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty3

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty30
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty30

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty31
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty31

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty32
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty32

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty33
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty33

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty34
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty34

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty35
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty35

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty36
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty36

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty37
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty37

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty38
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty38

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty39
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty39

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty4
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty4

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty40
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty40

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty41
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty41

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty42
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty42

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty43
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty43

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty44
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty44

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty45
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty45

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty46
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty46

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty47
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty47

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty48
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty48

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty49
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty49

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty5
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty5

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty50
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty50

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty51
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty51

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty52
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty52

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty53
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty53

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty54
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty54

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty55
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty55

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty56
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty56

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty57
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty57

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty58
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty58

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty59
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty59

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty6
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty6

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty60
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty60

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty61
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty61

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty62
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty62

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty63
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty63

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty7
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty7

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty8
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty8

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty9
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty9

<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D23 cstime=3D21
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl06 stime=3D1629792645
cmdline=3D"ioctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl06.c:26: TINFO: BLKRAGET original value 256
ioctl06.c:33: TPASS: BLKRASET 0 read back correctly
ioctl06.c:33: TPASS: BLKRASET 512 read back correctly
ioctl06.c:33: TPASS: BLKRASET 1024 read back correctly
ioctl06.c:33: TPASS: BLKRASET 1536 read back correctly
ioctl06.c:33: TPASS: BLKRASET 2048 read back correctly
ioctl06.c:33: TPASS: BLKRASET 2560 read back correctly
ioctl06.c:33: TPASS: BLKRASET 3072 read back correctly
ioctl06.c:33: TPASS: BLKRASET 3584 read back correctly
ioctl06.c:33: TPASS: BLKRASET 4096 read back correctly
ioctl06.c:38: TINFO: BLKRASET restoring original value 256

Summary:
passed   9
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
tag=3Dioctl_ns05 stime=3D1629792645
cmdline=3D"ioctl_ns05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioctl_ns05.c:91: TPASS: child and parent are consistent
ioctl_ns05.c:50: TPASS: child thinks its pid is 1

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
tag=3Dinotify09 stime=3D1629792645
cmdline=3D"inotify09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:522: TINFO: Minimum sampling period =
ended
=2E./../../../include/tst_fuzzy_sync.h:346: TINFO: loop =3D 1024, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg=
 =3D   -29ns, avg_dev =3D    13ns, dev_ratio =3D 0.45 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D  4497ns, avg_dev =3D  2867ns, dev_ratio =3D 0.64 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D  4985ns, avg_dev =3D  2536ns, dev_ratio =3D 0.51 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D  -517ns, avg_dev =3D   453ns, dev_ratio =3D 0.88 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   560  , avg_dev =3D   149  , dev_ratio =3D 0.27 }
=2E./../../../include/tst_fuzzy_sync.h:534: TINFO: Reached deviation ratios=
 < 0.10, introducing randomness
=2E./../../../include/tst_fuzzy_sync.h:537: TINFO: Delay range is [-1002, 5=
37]
=2E./../../../include/tst_fuzzy_sync.h:346: TINFO: loop =3D 1130, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg=
 =3D   -46ns, avg_dev =3D     5ns, dev_ratio =3D 0.10 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg=
 =3D   878ns, avg_dev =3D     8ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg=
 =3D  1640ns, avg_dev =3D    19ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg=
 =3D  -808ns, avg_dev =3D    14ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg=
 =3D   494  , avg_dev =3D    16  , dev_ratio =3D 0.03 }
=2E./../../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops=
, requesting exit
inotify09.c:89: TPASS: kernel survived inotify beating

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D15 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1894 cstime=3D980
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify06 stime=3D1629792660
cmdline=3D"fanotify06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fanotify06.c:158: TINFO: Test #0: Fanotify merge mount mark
fanotify06.c:136: TPASS: group 0 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:136: TPASS: group 1 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:136: TPASS: group 2 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:219: TPASS: group 3 got no event
fanotify06.c:219: TPASS: group 4 got no event
fanotify06.c:219: TPASS: group 5 got no event
fanotify06.c:219: TPASS: group 6 got no event
fanotify06.c:219: TPASS: group 7 got no event
fanotify06.c:219: TPASS: group 8 got no event
fanotify06.c:158: TINFO: Test #1: Fanotify merge overlayfs mount mark
fanotify06.c:136: TPASS: group 0 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:136: TPASS: group 1 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:136: TPASS: group 2 got event: mask 2 pid=3D3942 fd=3D13
fanotify06.c:219: TPASS: group 3 got no event
fanotify06.c:219: TPASS: group 4 got no event
fanotify06.c:219: TPASS: group 5 got no event
fanotify06.c:219: TPASS: group 6 got no event
fanotify06.c:219: TPASS: group 7 got no event
fanotify06.c:219: TPASS: group 8 got no event

Summary:
passed   18
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
tag=3Dfanotify11 stime=3D1629792660
cmdline=3D"fanotify11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fanotify11.c:66: TINFO: Test #0: without FAN_REPORT_TID: tgid=3D3947, tid=
=3D0, event.pid=3D0
fanotify11.c:85: TPASS: event.pid =3D=3D tgid
fanotify11.c:66: TINFO: Test #1: with FAN_REPORT_TID: tgid=3D3947, tid=3D39=
48, event.pid=3D3947
fanotify11.c:83: TPASS: event.pid =3D=3D tid

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
tag=3Dfanotify18 stime=3D1629792660
cmdline=3D"fanotify18"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
fanotify18.c:171: TINFO: Running as privileged user, revoking permissions.
fanotify18.c:108: TINFO: Test #0 init_flags: missing FAN_REPORT_FID
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #1 init_flags: FAN_CLASS_CONTENT
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #2 init_flags: FAN_CLASS_PRE_CONTENT
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #3 init_flags: FAN_UNLIMITED_QUEUE
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #4 init_flags: FAN_UNLIMITED_MARKS
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #5 init_flags: FAN_REPORT_TID
fanotify18.c:119: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #6 init_flags: FAN_CLASS_NOTIF, mark_flags: F=
AN_MARK_ADD | FAN_MARK_MOUNT
fanotify18.c:138: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #7 init_flags: FAN_CLASS_NOTIF, mark_flags: F=
AN_MARK_ADD | FAN_MARK_FILESYSTEM
fanotify18.c:138: TPASS: Received result EPERM, as expected
fanotify18.c:108: TINFO: Test #8 init_flags: FAN_CLASS_NOTIF, mark_flags: F=
AN_MARK_ADD, mark_mask: FAN_ALL_EVENTS
fanotify18.c:153: TPASS: fanotify_init() and fanotify_mark() returned succe=
ssfully, as expected

Summary:
passed   9
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
tag=3Dioprio_set01 stime=3D1629792661
cmdline=3D"ioprio_set01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ioprio_set01.c:66: TINFO: ioprio_get returned class NONE prio 4
ioprio.h:91: TPASS: ioprio_set new class BEST-EFFORT, new prio 5
ioprio.h:91: TPASS: ioprio_set new class BEST-EFFORT, new prio 3

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
tag=3Dio_pgetevents02 stime=3D1629792661
cmdline=3D"io_pgetevents02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
io_pgetevents02.c:57: TINFO: Testing variant: syscall with old kernel spec
io_pgetevents02.c:118: TPASS: invalid ctx: io_pgetevents() failed as expect=
ed: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid min_nr: io_pgetevents() failed as exp=
ected: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid max_nr: io_pgetevents() failed as exp=
ected: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid events: io_pgetevents() failed as exp=
ected: EFAULT (14)
io_pgetevents02.c:118: TPASS: invalid timeout: io_pgetevents() failed as ex=
pected: EFAULT (14)
io_pgetevents02.c:118: TPASS: invalid sigmask: io_pgetevents() failed as ex=
pected: EFAULT (14)

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
tag=3Dkeyctl05 stime=3D1629792661
cmdline=3D"keyctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_fips.c:22: TINFO: FIPS: off
keyctl05.c:131: TINFO: Try to update the 'asymmetric' key...
keyctl05.c:144: TPASS: updating 'asymmetric' key expectedly failed with EOP=
NOTSUPP
keyctl05.c:100: TCONF: kernel doesn't support key type 'dns_resolver'
keyctl05.c:179: TINFO: Try to update the 'user' key...
keyctl05.c:188: TPASS: didn't crash while racing to update 'user' key

Summary:
passed   2
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dkill02 stime=3D1629792661
cmdline=3D"kill02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill02      1  TPASS  :  The signal was sent to all processes in the proces=
s group.
kill02      2  TPASS  :  The signal was not sent to selective processes tha=
t were not in the process group.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D10 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkill03 stime=3D1629792671
cmdline=3D"kill03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
kill03.c:41: TPASS: kill failed as expected: EINVAL (22)
kill03.c:41: TPASS: kill failed as expected: ESRCH (3)
kill03.c:41: TPASS: kill failed as expected: ESRCH (3)

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
tag=3Dlchown03 stime=3D1629792671
cmdline=3D"lchown03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
lchown03    0  TINFO  :  Found free device 0 '/dev/loop0'
lchown03    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
lchown03    1  TPASS  :  lchown() failed as expected: TEST_ERRNO=3DELOOP(40=
): Too many levels of symbolic links
lchown03    2  TPASS  :  lchown() failed as expected: TEST_ERRNO=3DEROFS(30=
): Read-only file system
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dlistxattr03 stime=3D1629792672
cmdline=3D"listxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
listxattr03.c:54: TPASS: listxattr() succeed with suitable buffer
listxattr03.c:54: TPASS: listxattr() succeed with suitable buffer

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
tag=3Dllseek03 stime=3D1629792672
cmdline=3D"llseek03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
llseek03.c:96: TPASS: llseek returned 1
llseek03.c:115: TPASS: SEEK_SET for llseek
llseek03.c:96: TPASS: llseek returned 5
llseek03.c:115: TPASS: SEEK_CUR for llseek
llseek03.c:96: TPASS: llseek returned 7
llseek03.c:115: TPASS: SEEK_END for llseek
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_SET read returned 0
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_CUR read returned 0
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_END read returned 0
llseek03.c:96: TPASS: llseek returned 10
llseek03.c:107: TPASS: SEEK_SET read returned 0
llseek03.c:96: TPASS: llseek returned 12
llseek03.c:107: TPASS: SEEK_CUR read returned 0
llseek03.c:96: TPASS: llseek returned 12
llseek03.c:107: TPASS: SEEK_END read returned 0

Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlseek02 stime=3D1629792672
cmdline=3D"lseek02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
lseek02.c:65: TPASS: lseek(-1, 1, 0) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(-1, 1, 1) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(-1, 1, 2) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(4, 1, 5) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(4, 1, -1) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(4, 1, 7) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(5, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(5, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(5, 1, 2) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 2) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 2) failed as expected: ESPIPE (29)

Summary:
passed   15
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmigrate_pages01 stime=3D1629792672
cmdline=3D"migrate_pages01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
migrate_pages01    0  TINFO  :  test_empty_mask
migrate_pages01    1  TPASS  :  expected ret success: returned value =3D 0
migrate_pages01    0  TINFO  :  test_invalid_pid -1
migrate_pages01    2  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    3  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): No=
 such process
migrate_pages01    0  TINFO  :  test_invalid_pid unused pid
migrate_pages01    4  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    5  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): No=
 such process
migrate_pages01    0  TINFO  :  test_invalid_masksize
migrate_pages01    6  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22): =
Invalid argument
migrate_pages01    0  TINFO  :  test_invalid_mem -1
migrate_pages01    8  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    9  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_mem invalid prot
migrate_pages01   10  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   11  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_mem unmmaped
migrate_pages01   12  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   13  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_nodes
migrate_pages01   14  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   15  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22): =
Invalid argument
migrate_pages01    0  TINFO  :  test_invalid_perm
migrate_pages01   16  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   17  TPASS  :  expected failure: TEST_ERRNO=3DEPERM(1): Op=
eration not permitted
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmkdirat01 stime=3D1629792672
cmdline=3D"mkdirat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mkdirat01    1  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    2  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    3  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    4  TPASS  :  mkdirat() returned -1: TEST_ERRNO=3DENOTDIR(20): =
Not a directory
mkdirat01    5  TPASS  :  mkdirat() returned -1: TEST_ERRNO=3DEBADF(9): Bad=
 file descriptor
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmlock01 stime=3D1629792672
cmdline=3D"mlock01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mlock01     1  TPASS  :  mlock passed
mlock01     2  TPASS  :  mlock passed
mlock01     3  TPASS  :  mlock passed
mlock01     4  TPASS  :  mlock passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages04 stime=3D1629792672
cmdline=3D"move_pages04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
move_pages04    1  TCONF  :  move_pages_support.c:407: at least 2 allowed N=
UMA nodes are required
move_pages04    2  TCONF  :  move_pages_support.c:407: Remaining cases not =
appropriate for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpkey01 stime=3D1629792672
cmdline=3D"pkey01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_hugepage.c:64: TINFO: 1 hugepage(s) reserved
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pkey.h:48: TCONF: pku is not supported on this CPU

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_notify01 stime=3D1629792672
cmdline=3D"mq_notify01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBUSY (16)

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
tag=3Dmq_notify02 stime=3D1629792672
cmdline=3D"mq_notify02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mq_notify02    1  TPASS  :  mq_notify failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
mq_notify02    2  TPASS  :  mq_notify failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap01 stime=3D1629792672
cmdline=3D"mremap01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mremap01    1  TPASS  :  Functionality of mremap() is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgget02 stime=3D1629792672
cmdline=3D"msgget02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
msgget02.c:53: TPASS: msgget(1628504068, 1536) : EEXIST (17)
msgget02.c:53: TPASS: msgget(1645281284, 0) : ENOENT (2)
msgget02.c:53: TPASS: msgget(1645281284, 1024) : ENOENT (2)
msgget02.c:53: TPASS: msgget(1628504068, 256) : EACCES (13)
msgget02.c:53: TPASS: msgget(1628504068, 128) : EACCES (13)
msgget02.c:53: TPASS: msgget(1628504068, 384) : EACCES (13)

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
tag=3Dmsgrcv02 stime=3D1629792672
cmdline=3D"msgrcv02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
msgrcv02.c:63: TPASS: msgrcv(1, 0x55c409922de0, 4, 1, 0) : E2BIG (7)
msgrcv02.c:63: TPASS: msgrcv(2, 0x55c409922de0, 1024, 1, 0) : EACCES (13)
msgrcv02.c:63: TPASS: msgrcv(3, (nil), 1024, 1, 0) : EFAULT (14)
msgrcv02.c:63: TPASS: msgrcv(-1, 0x55c409922de0, 1024, 1, 0) : EINVAL (22)
msgrcv02.c:63: TPASS: msgrcv(5, 0x55c409922de0, -1, 1, 0) : EINVAL (22)
msgrcv02.c:63: TPASS: msgrcv(6, 0x55c409922de0, 1024, 2, 2048) : ENOMSG (42)

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
tag=3Dmsync01 stime=3D1629792672
cmdline=3D"msync01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
msync01     1  TPASS  :  Functionality of msync() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dname_to_handle_at01 stime=3D1629792672
cmdline=3D"name_to_handle_at01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_buffers.c:55: TINFO: Test is using guarded buffers
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (0)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (1)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (2)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (3)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (4)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (5)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (6)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (7)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (8)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (9)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (10)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (11)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (12)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (13)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (14)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (15)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (16)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (17)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (18)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (19)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (20)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (21)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (22)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (23)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (24)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (25)
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (26)

Summary:
passed   27
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
tag=3Dopen02 stime=3D1629792672
cmdline=3D"open02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
open02.c:53: TPASS: open() new file without O_CREAT : ENOENT (2)
open02.c:53: TPASS: open() unpriviledget O_RDONLY | O_NOATIME : EPERM (1)

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
tag=3Dopen03 stime=3D1629792672
cmdline=3D"open03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open03      1  TPASS  :  open(tfile_4051, O_RDWR|O_CREAT,0700) returned 4
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen14 stime=3D1629792672
cmdline=3D"open14"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open14      0  TINFO  :  creating a file with O_TMPFILE flag
open14      0  TINFO  :  writing data to the file
open14      0  TINFO  :  file size is '4096'
open14      0  TINFO  :  looking for the file in '.'
open14      0  TINFO  :  file not found, OK
open14      0  TINFO  :  renaming '/fs/sdb1/tmpdir/ltp-r964nMX0k4/openX4CNW=
/#18087941 (deleted)' -> 'tmpfile'
open14      0  TINFO  :  found a file: tmpfile
open14      1  TPASS  :  single file tests passed
open14      0  TINFO  :  create files in multiple directories
open14      0  TINFO  :  removing test directories
open14      0  TINFO  :  writing/reading temporary files
open14      0  TINFO  :  closing temporary files
open14      2  TPASS  :  multiple files tests passed
open14      0  TINFO  :  create multiple directories, link files into them
open14      0  TINFO  :  and check file permissions
open14      0  TINFO  :  remove files, directories
open14      3  TPASS  :  file permission tests passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dopenat01 stime=3D1629792672
cmdline=3D"openat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
openat01    1  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
openat01    2  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
openat01    3  TPASS  :  openat() returned -1: TEST_ERRNO=3DENOTDIR(20): No=
t a directory
openat01    4  TPASS  :  openat() returned -1: TEST_ERRNO=3DEBADF(9): Bad f=
ile descriptor
openat01    5  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmincore03 stime=3D1629792672
cmdline=3D"mincore03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
mincore03.c:66: TPASS: mincore() reports untouched pages are not resident
mincore03.c:66: TPASS: mincore() reports locked pages are resident

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
tag=3Dmincore04 stime=3D1629792672
cmdline=3D"mincore04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
mincore04.c:100: TPASS: mincore reports all 3 pages locked by child process=
 are resident

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
tag=3Dmadvise01 stime=3D1629792672
cmdline=3D"madvise01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
madvise01.c:112: TPASS: madvise test for MADV_NORMAL PASSED
madvise01.c:112: TPASS: madvise test for MADV_RANDOM PASSED
madvise01.c:112: TPASS: madvise test for MADV_SEQUENTIAL PASSED
madvise01.c:112: TPASS: madvise test for MADV_WILLNEED PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTNEED PASSED
madvise01.c:112: TPASS: madvise test for MADV_REMOVE PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_DOFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_HWPOISON PASSED
madvise01.c:112: TPASS: madvise test for MADV_MERGEABLE PASSED
madvise01.c:112: TPASS: madvise test for MADV_UNMERGEABLE PASSED
madvise01.c:112: TPASS: madvise test for MADV_HUGEPAGE PASSED
madvise01.c:112: TPASS: madvise test for MADV_NOHUGEPAGE PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTDUMP PASSED
madvise01.c:112: TPASS: madvise test for MADV_DODUMP PASSED
madvise01.c:112: TPASS: madvise test for MADV_FREE PASSED
madvise01.c:112: TPASS: madvise test for MADV_WIPEONFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_KEEPONFORK PASSED

Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D19
<<<test_end>>>
<<<test_start>>>
tag=3Dmadvise06 stime=3D1629792673
cmdline=3D"madvise06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
madvise06.c:107: TINFO: dropping caches
madvise06.c:118: TCONF: System swap is too small (838860800 bytes needed)

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Dpause02 stime=3D1629792673
cmdline=3D"pause02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pause02     1  TPASS  :  pause was interrupted correctly
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpidfd_open02 stime=3D1629792673
cmdline=3D"pidfd_open02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pidfd_open02.c:50: TPASS: expired pid: pidfd_open() failed as expected: ESR=
CH (3)
pidfd_open02.c:50: TPASS: invalid pid: pidfd_open() failed as expected: EIN=
VAL (22)
pidfd_open02.c:50: TPASS: invalid flags: pidfd_open() failed as expected: E=
INVAL (22)

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
tag=3Dpipe08 stime=3D1629792673
cmdline=3D"pipe08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pipe08      1  TPASS  :  got expected SIGPIPE signal
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe09 stime=3D1629792673
cmdline=3D"pipe09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pipe09      1  TPASS  :  functionality appears to be correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe2_04 stime=3D1629792673
cmdline=3D"pipe2_04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pipe2_04.c:37: TPASS: write failed as expected: EAGAIN/EWOULDBLOCK (11)
pipe2_04.c:53: TPASS: Child process is blocked

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
tag=3Dpreadv202 stime=3D1629792673
cmdline=3D"preadv202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
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
tag=3Dprocess_vm_readv01 stime=3D1629792673
cmdline=3D"process_vm01 -r"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
process_vm_readv    0  TINFO  :  test_sane_params
process_vm_readv    1  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_flags, flags=3D-2147483647
process_vm_readv    2  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    3  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D-1
process_vm_readv    4  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    5  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D1
process_vm_readv    6  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D2147483647
process_vm_readv    8  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    9  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D0
process_vm_readv   10  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_iov_len_overflow
process_vm_readv   11  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   12  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec->iov_base
process_vm_readv   13  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   14  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec->iov_base
process_vm_readv   15  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   16  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec
process_vm_readv   17  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   18  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec
process_vm_readv   19  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   20  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_pid
process_vm_readv   21  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   22  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv   23  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   24  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv    0  TINFO  :  test_invalid_perm
process_vm_readv   25  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   26  TPASS  :  expected failure: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
process_vm_readv    0  TINFO  :  test_sane_params
process_vm_readv    1  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_flags, flags=3D-2147483647
process_vm_readv    2  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    3  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D-1
process_vm_readv    4  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    5  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D1
process_vm_readv    6  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D2147483647
process_vm_readv    8  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    9  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D0
process_vm_readv   10  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_iov_len_overflow
process_vm_readv   11  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   12  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec->iov_base
process_vm_readv   13  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   14  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec->iov_base
process_vm_readv   15  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   16  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec
process_vm_readv   17  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   18  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec
process_vm_readv   19  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   20  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_pid
process_vm_readv   21  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   22  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv   23  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   24  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv    0  TINFO  :  test_invalid_perm
process_vm_readv    0  TINFO  :  test_invalid_protection lvec
process_vm_readv   25  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   26  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_protection rvec
process_vm_readv   27  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   28  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpselect03_64 stime=3D1629792673
cmdline=3D"pselect03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
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
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace03 stime=3D1629792673
cmdline=3D"ptrace03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ptrace03.c:43: TINFO: Trace a process which does not exist
ptrace03.c:56: TPASS: ptrace() failed as expected: ESRCH (3)
ptrace03.c:43: TINFO: Trace a process which is already been traced
ptrace03.c:56: TPASS: ptrace() failed as expected: EPERM (1)

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
tag=3Dptrace11 stime=3D1629792673
cmdline=3D"ptrace11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
ptrace11.c:28: TPASS: ptrace() traces init process successfully

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
tag=3Dpwrite03 stime=3D1629792673
cmdline=3D"pwrite03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwrite03.c:25: TPASS: pwrite(fd, NULL, 0) =3D=3D 0

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
tag=3Dpwrite04_64 stime=3D1629792673
cmdline=3D"pwrite04_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pwrite04    1  TPASS  :  O_APPEND test passed.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev02_64 stime=3D1629792673
cmdline=3D"pwritev02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EFAULT (14)
pwritev02.c:84: TPASS: pwritev() failed as expected: EBADF (9)
pwritev02.c:84: TPASS: pwritev() failed as expected: EBADF (9)
pwritev02.c:84: TPASS: pwritev() failed as expected: ESPIPE (29)

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
tag=3Dpwritev03 stime=3D1629792673
cmdline=3D"pwritev03"
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
tst_test.c:1414: TINFO: Testing on ext2
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on ext3
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on ext4
tst_test.c:916: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on xfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on btrfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on vfat
tst_test.c:916: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1414: TINFO: Testing on ntfs
tst_test.c:916: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opts=
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
tst_test.c:930: TINFO: Trying FUSE...
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20

Summary:
passed   21
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D8 cstime=3D102
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev201_64 stime=3D1629792679
cmdline=3D"pwritev201_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20

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
tag=3Dpwritev202 stime=3D1629792679
cmdline=3D"pwritev202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
pwritev202.c:78: TPASS: pwritev2() failed as expected: EINVAL (22)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EINVAL (22)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EOPNOTSUPP (95)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EFAULT (14)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EBADF (9)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EBADF (9)
pwritev202.c:78: TPASS: pwritev2() failed as expected: ESPIPE (29)

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
tag=3Dquotactl05 stime=3D1629792679
cmdline=3D"quotactl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:916: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
quotactl05.c:73: TINFO: Test #0: QCMD(Q_XGETQSTAT, PRJQUOTA) off
quotactl02.h:68: TPASS: quotactl() succeeded to turn off xfs quota and get =
xfs quota off status for project
quotactl05.c:73: TINFO: Test #1: QCMD(Q_XGETQSTAT, PRJQUOTA) on
quotactl02.h:88: TPASS: quotactl() succeeded to turn on xfs quota and get x=
fs quota on status for project
quotactl05.c:73: TINFO: Test #2: QCMD(Q_XGETQUOTA, PRJQUOTA) qlim
quotactl02.h:162: TPASS: quotactl() succeeded to set and use Q_XGETQUOTA fo=
r project to get xfs disk quota limits
quotactl05.c:73: TINFO: Test #3: QCMD(Q_XGETNEXTQUOTA, PRJQUOTA)
quotactl02.h:162: TPASS: quotactl() succeeded to set and use Q_XGETNEXTQUOT=
A for project to get xfs disk quota limits
quotactl05.c:73: TINFO: Test #4: QCMD(Q_XGETQSTATV, PRJQUOTA) off
quotactl02.h:110: TPASS: quotactl() succeeded to turn off xfs quota and get=
 xfs quota off statv for project
quotactl05.c:73: TINFO: Test #5: QCMD(Q_XGETQSTATV, PRJQUOTA) on
quotactl02.h:132: TPASS: quotactl() succeeded to turn on xfs quota and get =
xfs quota on statv for project

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Dread01 stime=3D1629792680
cmdline=3D"read01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
read01.c:24: TPASS: read(2) returned 512

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
tag=3Dreadlinkat02 stime=3D1629792680
cmdline=3D"readlinkat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
readlinkat02    1  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEI=
NVAL(22): Invalid argument
readlinkat02    2  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEI=
NVAL(22): Invalid argument
readlinkat02    3  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEN=
OTDIR(20): Not a directory
readlinkat02    4  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEN=
OTDIR(20): Not a directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreadv03 stime=3D1629792680
cmdline=3D"readv03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
readv03.c:33: TPASS: readv() got EISDIR : EISDIR (21)

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
tag=3Dreboot01 stime=3D1629792680
cmdline=3D"reboot01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
reboot01.c:34: TPASS: reboot(LINUX_REBOOT_CMD_CAD_ON) passed
reboot01.c:34: TPASS: reboot(LINUX_REBOOT_CMD_CAD_OFF) passed

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
tag=3Dremovexattr01 stime=3D1629792680
cmdline=3D"removexattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
removexattr01    1  TPASS  :  removexattr() succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drename07 stime=3D1629792680
cmdline=3D"rename07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
rename07    1  TPASS  :  rename() returned ENOTDIR
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drequest_key02 stime=3D1629792680
cmdline=3D"request_key02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
request_key02.c:53: TPASS: request_key() failed expectly: ENOKEY (126)
request_key02.c:53: TPASS: request_key() failed expectly: EKEYREVOKED (128)
request_key02.c:53: TPASS: request_key() failed expectly: EKEYEXPIRED (127)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drt_sigsuspend01 stime=3D1629792682
cmdline=3D"rt_sigsuspend01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
rt_sigsuspend01.c:49: TPASS: rt_sigsuspend() returned with -1 and EINTR
rt_sigsuspend01.c:58: TPASS: signal mask preserved

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
tag=3Dsched_get_priority_min01 stime=3D1629792683
cmdline=3D"sched_get_priority_min01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_get_priority_min01    1  TPASS  :  Test for SCHED_OTHER Passed
sched_get_priority_min01    2  TPASS  :  Test for SCHED_FIFO Passed
sched_get_priority_min01    3  TPASS  :  Test for SCHED_RR Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setparam01 stime=3D1629792683
cmdline=3D"sched_setparam01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
sched_setparam01.c:30: TINFO: Testing libc variant
sched_setparam01.c:25: TPASS: sched_setparam(0, 0) passed
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
sched_setparam01.c:30: TINFO: Testing syscall variant
sched_setparam01.c:25: TPASS: sched_setparam(0, 0) passed

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
tag=3Dsched_getattr01 stime=3D1629792683
cmdline=3D"sched_getattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_getattr01    1  TPASS  :  attributes were read back correctly
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemctl06 stime=3D1629792683
cmdline=3D"semctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
semctl06    1  TPASS  :  semctl06 ran successfully!
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemget03 stime=3D1629792683
cmdline=3D"semget03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
semget03    1  TPASS  :  expected failure - errno =3D 2 : No such file or d=
irectory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemop02 stime=3D1629792683
cmdline=3D"semop02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
semop02.c:78: TINFO: Testing variant: semop: syscall
semop02.c:148: TPASS: semop failed as expected: E2BIG (7)
semop02.c:148: TPASS: semop failed as expected: EACCES (13)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: ERANGE (34)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:123: TCONF: Test not supported for variant
semop02.c:123: TCONF: Test not supported for variant
semop02.c:123: TCONF: Test not supported for variant
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
semop02.c:78: TINFO: Testing variant: semtimedop: syscall with old kernel s=
pec
semop02.c:148: TPASS: semop failed as expected: E2BIG (7)
semop02.c:148: TPASS: semop failed as expected: EACCES (13)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: ERANGE (34)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)

Summary:
passed   23
failed   0
broken   0
skipped  3
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsend01 stime=3D1629792683
cmdline=3D"send01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
send01      1  TPASS  :  bad file descriptor successful
send01      2  TPASS  :  invalid socket successful
send01      3  TPASS  :  invalid send buffer successful
send01      4  TPASS  :  UDP message too big successful
send01      5  TPASS  :  local endpoint shutdown successful
send01      6  TPASS  :  invalid flags set successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile03_64 stime=3D1629792683
cmdline=3D"sendfile03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
sendfile03.c:54: TPASS: sendfile(..) with out_fd=3D-1 : EBADF (9)
sendfile03.c:54: TPASS: sendfile(..) with out_fd=3DO_RDONLY : EBADF (9)
sendfile03.c:54: TPASS: sendfile(..) with in_fd=3D-1 : EBADF (9)
sendfile03.c:54: TPASS: sendfile(..) with out_fd=3DO_WRONLY : EBADF (9)

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
tag=3Dsendfile04 stime=3D1629792683
cmdline=3D"sendfile04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
sendfile04.c:63: TPASS: sendfile(..) with pass_mapped_buffer, protection=3D=
0 : EFAULT (14)
sendfile04.c:63: TPASS: sendfile(..) with pass_mapped_buffer, protection=3D=
1 : EFAULT (14)
sendfile04.c:63: TPASS: sendfile(..) with pass_mapped_buffer, protection=3D=
4 : EFAULT (14)
sendfile04.c:63: TPASS: sendfile(..) with pass_mapped_buffer, protection=3D=
5 : EFAULT (14)
sendfile04.c:63: TPASS: sendfile(..) with pass_unmapped_buffer, protection=
=3D3 : EFAULT (14)

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
tag=3Dsendfile07_64 stime=3D1629792683
cmdline=3D"sendfile07_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
sendfile07.c:60: TPASS: sendfile(out_fd, in_fd, NULL, 1) with blocked out_f=
d : EAGAIN/EWOULDBLOCK (11)

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
tag=3Dsendmsg01 stime=3D1629792683
cmdline=3D"sendmsg01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendmsg01    1  TPASS  :  bad file descriptor successful
sendmsg01    2  TPASS  :  invalid socket successful
sendmsg01    3  TPASS  :  invalid send buffer successful
sendmsg01    4  TPASS  :  connected TCP successful
sendmsg01    5  TPASS  :  not connected TCP successful
sendmsg01    6  TPASS  :  invalid to buffer length successful
sendmsg01    7  TPASS  :  invalid to buffer successful
sendmsg01    8  TPASS  :  UDP message too big successful
sendmsg01    9  TPASS  :  local endpoint shutdown successful
sendmsg01   10  TPASS  :  invalid iovec pointer successful
sendmsg01   11  TPASS  :  invalid msghdr pointer successful
sendmsg01   12  TPASS  :  rights passing successful
sendmsg01   13  TPASS  :  invalid flags set successful
sendmsg01   14  TPASS  :  invalid cmsg length successful
sendmsg01   15  TPASS  :  invalid cmsg pointer successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dset_mempolicy02 stime=3D1629792683
cmdline=3D"set_mempolicy02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:194: TINFO: Found 1 NUMA memory nodes
set_mempolicy02.c:39: TCONF: Test requires at least two NUMA memory nodes

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
tag=3Dset_tid_address01 stime=3D1629792683
cmdline=3D"set_tid_address01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
set_tid_address01    1  TPASS  :  set_tid_address call succeeded:  as expec=
ted 4285
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetdomainname01 stime=3D1629792683
cmdline=3D"setdomainname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:36: TINFO: Testing libc setdomainname()
setdomainname01.c:26: TPASS: setdomainname() succeed
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:39: TINFO: Testing __NR_setdomainname syscall
setdomainname01.c:26: TPASS: setdomainname() succeed

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
tag=3Dsetfsuid01 stime=3D1629792683
cmdline=3D"setfsuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsuid01    1  TPASS  :  setfsuid() returned expected value : 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsgetmask01 stime=3D1629792683
cmdline=3D"sgetmask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sgetmask01    1  TCONF  :  sgetmask01.c:128: syscall(-1) __NR_ssetmask not =
supported on your arch
sgetmask01    2  TCONF  :  sgetmask01.c:128: Remaining cases not appropriat=
e for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgroups04_16 stime=3D1629792683
cmdline=3D"setgroups04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgroups04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setgroups/../utils/compat_16.h:77: 16-bit version of setgroups() is not =
supported on your platform
setgroups04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setgroups/../utils/compat_16.h:77: Remaining cases not appropriate for c=
onfiguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetitimer03 stime=3D1629792683
cmdline=3D"setitimer03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setitimer03    1  TPASS  :  expected failure - errno =3D 22 - Invalid argum=
ent
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetpgrp01 stime=3D1629792683
cmdline=3D"setpgrp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setpgrp01    1  TPASS  :  setpgrp -  Call the setpgrp system call returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetpriority01 stime=3D1629792683
cmdline=3D"setpriority01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
setpriority01.c:75: TPASS: setpriority(PRIO_PROCESS(0), 4303, -20..19) succ=
eeded
setpriority01.c:75: TPASS: setpriority(PRIO_PGRP(1), 4304, -20..19) succeed=
ed
setpriority01.c:75: TPASS: setpriority(PRIO_USER(2), 1091, -20..19) succeed=
ed
userdel: ltp_setpriority01 mail spool (/var/mail/ltp_setpriority01) not fou=
nd
userdel: ltp_setpriority01 home directory (/home/ltp_setpriority01) not fou=
nd

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
tag=3Dsetregid01 stime=3D1629792683
cmdline=3D"setregid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
setregid01.c:49: TPASS: Dont change either real or effective gid
setregid01.c:49: TPASS: Change effective to effective gid
setregid01.c:49: TPASS: Change real to real gid
setregid01.c:49: TPASS: Change effective to real gid
setregid01.c:49: TPASS: Try to change real to current real

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
tag=3Dsetreuid07 stime=3D1629792683
cmdline=3D"setreuid07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open failed with EACCES as expected
open failed with EACCES as expected
open call succeeded
setreuid07    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetuid01 stime=3D1629792683
cmdline=3D"setuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
setuid01.c:30: TPASS: setuid(0) successfully

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
tag=3Dshmctl07 stime=3D1629792683
cmdline=3D"shmctl07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
shmctl07.c:31: TPASS: shmctl(1, SHM_LOCK, NULL)
shmctl07.c:37: TPASS: SMH_LOCKED bit is on in shm_perm.mode
shmctl07.c:46: TPASS: shmctl(1, SHM_UNLOCK, NULL)
shmctl07.c:53: TPASS: SHM_LOCKED bit is off in shm_perm.mode

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
tag=3Dshmget02 stime=3D1629792683
cmdline=3D"shmget02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_hugepage.c:64: TINFO: 0 hugepage(s) reserved
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_kconfig.c:64: TINFO: Parsing kernel config '/proc/config.gz'
shmget02.c:84: TPASS: shmget(1645281285, 2048, 1024) : ENOENT (2)
shmget02.c:84: TPASS: shmget(1628504069, 2048, 1536) : EEXIST (17)
shmget02.c:84: TPASS: shmget(1645281285, 0, 1536) : EINVAL (22)
shmget02.c:84: TPASS: shmget(1645281285, 18446744073692774400, 1536) : EINV=
AL (22)
shmget02.c:84: TPASS: shmget(1628504069, 4096, 1024) : EINVAL (22)
shmget02.c:96: TPASS: shmget(1628504069, 2048, 256) : EACCES (13)
shmget02.c:96: TPASS: shmget(1645281285, 2048, 2560) : EPERM (1)
shmget02.c:84: TPASS: shmget(1645281285, 2048, 2560) : ENOMEM (12)

Summary:
passed   8
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
tag=3Dsignal02 stime=3D1629792683
cmdline=3D"signal02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal02    1  TPASS  :  expected failure - errno =3D 22 - Invalid argument
signal02    2  TPASS  :  expected failure - errno =3D 22 - Invalid argument
signal02    3  TPASS  :  expected failure - errno =3D 22 - Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsplice03 stime=3D1629792683
cmdline=3D"splice03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EINVAL (22)
splice03.c:99: TPASS: splice() failed as expected: EINVAL (22)
splice03.c:99: TPASS: splice() failed as expected: ESPIPE (29)
splice03.c:99: TPASS: splice() failed as expected: ESPIPE (29)

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
tag=3Dssetmask01 stime=3D1629792683
cmdline=3D"ssetmask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
ssetmask01    1  TCONF  :  ssetmask01.c:115: syscall(-1) __NR_ssetmask not =
supported on your arch
ssetmask01    2  TCONF  :  ssetmask01.c:115: Remaining cases not appropriat=
e for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatfs02 stime=3D1629792683
cmdline=3D"statfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs02    1  TPASS  :  expected failure: TEST_ERRNO=3DENOTDIR(20): Not a =
directory
statfs02    2  TPASS  :  expected failure: TEST_ERRNO=3DENOENT(2): No such =
file or directory
statfs02    3  TPASS  :  expected failure: TEST_ERRNO=3DENAMETOOLONG(36): F=
ile name too long
statfs02    4  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): Bad add=
ress
statfs02    5  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): Bad add=
ress
statfs02    6  TPASS  :  expected failure: TEST_ERRNO=3DELOOP(40): Too many=
 levels of symbolic links
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dswapoff01 stime=3D1629792683
cmdline=3D"swapoff01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
tst_ioctl.c:30: TINFO: FIBMAP ioctl is supported
swapoff01.c:35: TPASS: Succeeded to turn off swapfile

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D3 cstime=3D11
<<<test_end>>>
<<<test_start>>>
tag=3Dswitch01 stime=3D1629792684
cmdline=3D"endian_switch01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:941: TCONF: This system does not support running of switch() sys=
call
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsymlink02 stime=3D1629792684
cmdline=3D"symlink02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsymlink05 stime=3D1629792684
cmdline=3D"symlink05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
symlink05    1  TPASS  :  symlink(testfile, slink_file) functionality succe=
ssful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsysinfo02 stime=3D1629792684
cmdline=3D"sysinfo02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sysinfo02    1  TPASS  :  Test to check the error code 14 PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog02 stime=3D1629792684
cmdline=3D"syslog02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog02    0  TINFO  :  Test if messages of all levels are logged.
syslog02    0  TINFO  :  For each level, a separate configuration file is
syslog02    0  TINFO  :  created and that will be used as syslog.conf file.
syslog02    0  TINFO  :  testing whether messages are logged into log file
syslog02    0  TINFO  :  Doing level: emerg...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    1  TPASS  :  ***** Level emerg passed *****
syslog02    0  TINFO  :  Doing level: alert...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    2  TPASS  :  ***** Level alert passed *****
syslog02    0  TINFO  :  Doing level: crit...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    3  TPASS  :  ***** Level crit passed *****
syslog02    0  TINFO  :  Doing level: err...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    4  TPASS  :  ***** Level err passed *****
syslog02    0  TINFO  :  Doing level: warning...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    5  TPASS  :  ***** Level warning passed *****
syslog02    0  TINFO  :  Doing level: notice...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    6  TPASS  :  ***** Level notice passed *****
syslog02    0  TINFO  :  Doing level: info...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    7  TPASS  :  ***** Level info passed *****
syslog02    0  TINFO  :  Doing level: debug...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    8  TPASS  :  ***** Level debug passed *****
syslog02    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D35 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D5 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog10 stime=3D1629792719
cmdline=3D"syslog10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog10    0  TINFO  :   Test setlogmask() with LOG_MASK macro.
syslog10    0  TINFO  :   o Use setlogmask() with LOG_MASK macro to set an
syslog10    0  TINFO  :     individual priority level.
syslog10    0  TINFO  :   o Send the message of above prority and expect it=
 to be
syslog10    0  TINFO  :     logged.
syslog10    0  TINFO  :   o Send message which is at other priority level to
syslog10    0  TINFO  :     the one set above, which should not be logged.
syslog10    0  TINFO  :  syslog: Testing setlogmask() with LOG_MASK macro...
syslog10    0  TINFO  :  restarting syslog daemon
syslog10    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dtimerfd_settime01 stime=3D1629792725
cmdline=3D"timerfd_settime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
timerfd_settime01.c:53: TINFO: Testing variant: syscall with old kernel spec
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EBADF =
(9)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EFAULT=
 (14)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EINVAL=
 (22)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EINVAL=
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
tag=3Dtimer_delete02 stime=3D1629792725
cmdline=3D"timer_delete02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
timer_delete02.c:30: TPASS: Failed as expected: EINVAL (22)

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
tag=3Dutime03 stime=3D1629792725
cmdline=3D"utime03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
utime03     1  TPASS  :  Functionality of utime(tmp_file, NULL) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dutime05 stime=3D1629792729
cmdline=3D"utime05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
utime05     1  TPASS  :  Functionality of utime(tmp_file, &times) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwait02 stime=3D1629792729
cmdline=3D"wait02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
wait02.c:41: TPASS: wait() succeeded

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
tag=3Dwait402 stime=3D1629792729
cmdline=3D"wait402"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
wait402     1  TPASS  :  received expected failure - errno =3D 10 - No chil=
d processes
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid01 stime=3D1629792729
cmdline=3D"waitpid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
waitpid01.c:38: TPASS: waitpid() returned correct pid 4665
waitpid01.c:47: TPASS: WIFSIGNALED() set in status
waitpid01.c:55: TPASS: WTERMSIG() =3D=3D SIGALRM

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
tag=3Dwaitpid06 stime=3D1629792729
cmdline=3D"waitpid06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
waitpid06.c:54: TPASS: Test PASSED

Summary:
passed   1
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
tag=3Dwaitid01 stime=3D1629792730
cmdline=3D"waitid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4679 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4680 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4679 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4680 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4681 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4679 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4680 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4681 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4682 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4683 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4679 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4680 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4681 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4682 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4683 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4684 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4678 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4679 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4680 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4681 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4682 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4683 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4684 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4685 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4686 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    1  TPASS  :  waitid(): system call passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwritev02 stime=3D1629792730
cmdline=3D"writev02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
writev02    1  TPASS  :  Received EFAULT as expected
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfutex_wait01 stime=3D1629792730
cmdline=3D"futex_wait01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
futex_wait01.c:69: TINFO: Testing variant: syscall with old kernel spec
futex_wait01.c:62: TPASS: futex_wait() passed: ETIMEDOUT (110)
futex_wait01.c:62: TPASS: futex_wait() passed: EAGAIN/EWOULDBLOCK (11)
futex_wait01.c:62: TPASS: futex_wait() passed: ETIMEDOUT (110)
futex_wait01.c:62: TPASS: futex_wait() passed: EAGAIN/EWOULDBLOCK (11)

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
tag=3Dfutex_wait_bitset01 stime=3D1629792730
cmdline=3D"futex_wait_bitset01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
futex_wait_bitset01.c:99: TINFO: Testing variant: syscall with old kernel s=
pec
futex_wait_bitset01.c:45: TINFO: testing futex_wait_bitset() timeout with C=
LOCK_MONOTONIC
futex_wait_bitset01.c:87: TPASS: futex_wait_bitset() waited 100120us, expec=
ted 100010us
futex_wait_bitset01.c:45: TINFO: testing futex_wait_bitset() timeout with C=
LOCK_REALTIME
futex_wait_bitset01.c:87: TPASS: futex_wait_bitset() waited 100101us, expec=
ted 100010us

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
tag=3Dio_uring02 stime=3D1629792730
cmdline=3D"io_uring02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
io_uring02.c:192: TINFO: IOSQE_ASYNC is supported
io_uring02.c:205: TPASS: Write outside chroot failed as expected: ENOENT (2)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20210524-323-g46263457f

       ###############################################################

            Done executing testcases.
            LTP Version:  20210524-323-g46263457f
       ###############################################################


--ReaqsoxgOBHFXBhH
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
fs: ext4
ltp:
  test: syscalls-07
job_origin: ltp-syscalls.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d02
tbox_group: lkp-skl-d02
kconfig: x86_64-rhel-8.3
submit_id: 61246a3147b5272dd86aa173
job_file: "/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-ext4-syscalls-07-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3-20210824-11736-1pc05ka-0.yaml"
id: 616ccf2c90de3e67d822cea2764c89a9baff3fc6
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
- EXT4_FS
:#! include/ltp:
:#! include/queue/cyclic:
commit: f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3
:#! include/testbox/lkp-skl-d02:
need_kconfig_hw:
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xe2'
:#! include/fs/OTHERS:
enqueue_time: 2021-08-24 11:40:33.952764789 +08:00
_id: 61246a3147b5272dd86aa173
_rt: "/result/ltp/1HDD-ext4-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: f5ffce8707c9d2ae6fc6a4a4123b247bb4222cf6
base_commit: e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
branch: linux-devel/devel-hourly-20210824-000018
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/ltp/1HDD-ext4-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/0"
scheduler_version: "/lkp/lkp/.src-20210824-090638"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-ext4-syscalls-07-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3-20210824-11736-1pc05ka-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210824-000018
- commit=f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/vmlinuz-5.14.0-rc6-00228-gf7e33bdbd6d1
- max_uptime=2100
- RESULT_ROOT=/result/ltp/1HDD-ext4-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210821.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210821.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210823-110755/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.14.0-rc7-gfcd974e30302
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3/vmlinuz-5.14.0-rc6-00228-gf7e33bdbd6d1"
dequeue_time: 2021-08-24 12:09:31.988352004 +08:00
:#! /lkp/lkp/.src-20210824-090638/include/site/inn:
job_state: finished
loadavg: 1.29 0.78 0.31 1/207 4783
start_time: '1629778275'
end_time: '1629778382'
version: "/lkp/lkp/.src-20210824-090711:8215f3de:c409f6141"

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sdb1
mkfs -t ext4 -q -F /dev/sdb1
mkdir -p /fs/sdb1
mount -t ext4 /dev/sdb1 /fs/sdb1
ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
./runltp -f syscalls-07 -d /fs/sdb1/tmpdir

--ReaqsoxgOBHFXBhH--
