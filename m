Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0990B407DD1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhILOp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 10:45:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:40690 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhILOpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 10:45:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="208570318"
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="xz'?yaml'?scan'208";a="208570318"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 07:44:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="xz'?yaml'?scan'208";a="542401429"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 07:44:33 -0700
Date:   Sun, 12 Sep 2021 23:01:58 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: [x86/platform]  d7109fe3a0: kernel-selftests.gpio.gpio-mockup.sh.fail
Message-ID: <20210912150158.GF25450@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: d7109fe3a0991a0f7b4ac099b78c908e3b619787 ("x86/platform: Increase m=
aximum GPIO number for X86_64")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/urgent


in testcase: kernel-selftests
version: kernel-selftests-x86_64-d0cba0d1-1_20210907
with following parameters:

	group: group-01
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G=
 memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8=
=2E3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787
2021-09-10 00:53:31 ln -sf /usr/bin/clang
2021-09-10 00:53:31 ln -sf /usr/bin/llc
2021-09-10 00:53:31 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2021-09-10 00:53:31 make -j4 -C capabilities
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/capabili=
ties'
gcc -O2 -g -std=3Dgnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c90=
8e3b619787/tools/testing/selftests/capabilities/test_execve
gcc -O2 -g -std=3Dgnu99 -Wall    validate_cap.c -lcap-ng -lrt -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c9=
08e3b619787/tools/testing/selftests/capabilities/validate_cap
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/capabilit=
ies'
2021-09-10 00:53:31 make run_tests -C capabilities
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/capabili=
ties'
TAP version 13
1..1
# selftests: capabilities: test_execve
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# TAP version 13
# 1..12
# # [RUN]	+++ Tests with uid =3D=3D 0 +++
# # [NOTE]	Using global UIDs for tests
# # [RUN]	Root =3D> ep
# ok 1 Passed
# # Check cap_ambient manipulation rules
# ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
# ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
# ok 4 PR_CAP_AMBIENT_RAISE worked
# ok 5 Basic manipulation appears to work
# # [RUN]	Root +i =3D> eip
# ok 6 Passed
# # [RUN]	UID 0 +ia =3D> eipa
# ok 7 Passed
# # [RUN]	Root +ia, suidroot =3D> eipa
# ok 8 Passed
# # [RUN]	Root +ia, suidnonroot =3D> ip
# ok 9 Passed
# # [RUN]	Root +ia, sgidroot =3D> eipa
# ok 10 Passed
# ok 11 Passed
# # [RUN]	Root +ia, sgidnonroot =3D> eip
# ok 12 Passed
# # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
# TAP version 13
# 1..9
# # [RUN]	+++ Tests with uid !=3D 0 +++
# # [NOTE]	Using global UIDs for tests
# # [RUN]	Non-root =3D> no caps
# ok 1 Passed
# # Check cap_ambient manipulation rules
# ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
# ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
# ok 4 PR_CAP_AMBIENT_RAISE worked
# ok 5 Basic manipulation appears to work
# # [RUN]	Non-root +i =3D> i
# ok 6 Passed
# # [RUN]	UID 1 +ia =3D> eipa
# ok 7 Passed
# # [RUN]	Non-root +ia, sgidnonroot =3D> i
# ok 8 Passed
# ok 9 Passed
# # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
# # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
ok 1 selftests: capabilities: test_execve
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/capabilit=
ies'
LKP SKIP cgroup
2021-09-10 00:53:31 make -j4 -C clone3
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/clone3'
gcc -g -std=3Dgnu99 -I../../../../usr/include/    clone3.c -lcap -o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908=
e3b619787/tools/testing/selftests/clone3/clone3
gcc -g -std=3Dgnu99 -I../../../../usr/include/    clone3_clear_sighand.c -l=
cap -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7=
b4ac099b78c908e3b619787/tools/testing/selftests/clone3/clone3_clear_sighand
gcc -g -std=3Dgnu99 -I../../../../usr/include/    clone3_set_tid.c -lcap -o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac09=
9b78c908e3b619787/tools/testing/selftests/clone3/clone3_set_tid
gcc -g -std=3Dgnu99 -I../../../../usr/include/    clone3_cap_checkpoint_res=
tore.c -lcap -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3=
a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/clone3/clone3_cap_=
checkpoint_restore
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/clone3'
2021-09-10 00:53:31 make run_tests -C clone3
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/clone3'
TAP version 13
1..4
# selftests: clone3: clone3
# TAP version 13
# 1..17
# # clone3() syscall supported
# # [1283] Trying clone3() with flags 0 (size 0)
# # I am the parent (1283). My child's pid is 1284
# # [1283] clone3() with flags says: 0 expected 0
# ok 1 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0x20000000 (size 0)
# # I am the parent (1283). My child's pid is 1285
# # [1283] clone3() with flags says: 0 expected 0
# ok 2 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0 (size 64)
# # I am the parent (1283). My child's pid is 1286
# # [1283] clone3() with flags says: 0 expected 0
# ok 3 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0 (size 56)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 4 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0 (size 96)
# # I am the parent (1283). My child's pid is 1287
# # [1283] clone3() with flags says: 0 expected 0
# ok 5 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 6 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 7 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 8 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 9 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0 (size 96)
# # I am the parent (1283). My child's pid is 1288
# # [1283] clone3() with flags says: 0 expected 0
# ok 10 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0 (size 104)
# # Argument list too long - Failed to create new process
# # [1283] clone3() with flags says: -7 expected -7
# ok 11 [1283] Result (-7) matches expectation (-7)
# # [1283] Trying clone3() with flags 0 (size 176)
# # Argument list too long - Failed to create new process
# # [1283] clone3() with flags says: -7 expected -7
# ok 12 [1283] Result (-7) matches expectation (-7)
# # [1283] Trying clone3() with flags 0 (size 4104)
# # Argument list too long - Failed to create new process
# # [1283] clone3() with flags says: -7 expected -7
# ok 13 [1283] Result (-7) matches expectation (-7)
# # [1283] Trying clone3() with flags 0x20000000 (size 64)
# # I am the parent (1283). My child's pid is 1289
# # [1283] clone3() with flags says: 0 expected 0
# ok 14 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0x20000000 (size 56)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 15 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0x20000000 (size 96)
# # I am the parent (1283). My child's pid is 1290
# # [1283] clone3() with flags says: 0 expected 0
# ok 16 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0x20000000 (size 4104)
# # Argument list too long - Failed to create new process
# # [1283] clone3() with flags says: -7 expected -7
# ok 17 [1283] Result (-7) matches expectation (-7)
# # Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: clone3: clone3
# selftests: clone3: clone3_clear_sighand
# TAP version 13
# 1..1
# # clone3() syscall supported
# ok 1 Cleared signal handlers for child process
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: clone3: clone3_clear_sighand
# selftests: clone3: clone3_set_tid
# TAP version 13
# 1..29
# # clone3() syscall supported
# # /proc/sys/kernel/pid_max 32768
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 1 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 2 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 3 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 4 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 5 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 6 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 7 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 8 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 9 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 10 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 11 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 12 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 13 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 14 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 1 and 0x0
# # File exists - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 1 says :-17 - expected -17
# ok 15 [1315] Result (-17) matches expectation (-17)
# # [1315] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # I am the parent (1315). My child's pid is 1316
# # [1315] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 16 [1315] Result (0) matches expectation (0)
# # [1315] Trying clone3() with CLONE_SET_TID to 32768 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 17 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 32768 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 18 [1315] Result (-22) matches expectation (-22)
# # Child has PID 1317
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 18 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 1317 and 0x0
# # I am the child, my PID is 1317 (expected 1317)
# # I am the parent (1315). My child's pid is 1317
# # [1315] clone3() with CLONE_SET_TID 1317 says :0 - expected 0
# ok 19 [1315] Result (0) matches expectation (0)
# # [1315] Trying clone3() with CLONE_SET_TID to 1317 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 1317 says :-22 - expected -22
# ok 20 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # I am the parent (1315). My child's pid is 1317
# # [1315] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 21 [1315] Result (0) matches expectation (0)
# # unshare PID namespace
# # [1315] Trying clone3() with CLONE_SET_TID to 1317 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 1317 says :-22 - expected -22
# ok 22 [1315] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 43 and 0x0
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 43 says :-22 - expected -22
# ok 23 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 43 and 0x0
# # I am the child, my PID is 43 (expected 43)
# # I am the parent (1). My child's pid is 43
# # [1] clone3() with CLONE_SET_TID 43 says :0 - expected 0
# ok 24 [1] Result (0) matches expectation (0)
# # Child in PID namespace has PID 1
# # [1] Trying clone3() with CLONE_SET_TID to 2 and 0x0
# # I am the child, my PID is 2 (expected 2)
# # I am the parent (1). My child's pid is 2
# # [1] clone3() with CLONE_SET_TID 2 says :0 - expected 0
# ok 25 [1] Result (0) matches expectation (0)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 1 says :-22 - expected -22
# ok 26 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 1 says :-22 - expected -22
# ok 27 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # [1] Child is ready and waiting
# # I am the parent (1). My child's pid is 42
# # [1] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 28 [1] Result (0) matches expectation (0)
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 1317 says :-22 - expected -22
# ok 22 [1315] Result (-22) matches expectation (-22)
# # [1315] Child is ready and waiting
# ok 29 PIDs in all namespaces as expected (1317,42,1)
# # Totals: pass:29 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 3 selftests: clone3: clone3_set_tid
# selftests: clone3: clone3_cap_checkpoint_restore
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.clone3_cap_checkpoint_restore ...
# # clone3_cap_checkpoint_restore.c:155:clone3_cap_checkpoint_restore:Child=
 has PID 1333
# # clone3() syscall supported
# # clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[1332]=
 Trying clone3() with CLONE_SET_TID to 1333
# # clone3() syscall supported
# # clone3_cap_checkpoint_restore.c:55:clone3_cap_checkpoint_restore:Operat=
ion not permitted - Failed to create new process
# # clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[1332]=
 clone3() with CLONE_SET_TID 1333 says:-1
# # clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[1332]=
 Trying clone3() with CLONE_SET_TID to 1333
# # clone3_cap_checkpoint_restore.c:70:clone3_cap_checkpoint_restore:I am t=
he parent (1332). My child's pid is 1333
# # clone3_cap_checkpoint_restore.c:63:clone3_cap_checkpoint_restore:I am t=
he child, my PID is 1333 (expected 1333)
# # clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[1332]=
 clone3() with CLONE_SET_TID 1333 says:0
# #            OK  global.clone3_cap_checkpoint_restore
# ok 1 global.clone3_cap_checkpoint_restore
# # PASSED: 1 / 1 tests passed.
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 4 selftests: clone3: clone3_cap_checkpoint_restore
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/clone3'
2021-09-10 00:53:32 make -j4 -C core
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/core'
gcc -g -I../../../../usr/include/    close_range_test.c  -o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b61978=
7/tools/testing/selftests/core/close_range_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/core'
2021-09-10 00:53:32 make run_tests -C core
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/core'
TAP version 13
1..1
# selftests: core: close_range_test
# TAP version 13
# 1..7
# # Starting 7 tests from 1 test cases.
# #  RUN           global.close_range ...
# #            OK  global.close_range
# ok 1 global.close_range
# #  RUN           global.close_range_unshare ...
# #            OK  global.close_range_unshare
# ok 2 global.close_range_unshare
# #  RUN           global.close_range_unshare_capped ...
# #            OK  global.close_range_unshare_capped
# ok 3 global.close_range_unshare_capped
# #  RUN           global.close_range_cloexec ...
# #            OK  global.close_range_cloexec
# ok 4 global.close_range_cloexec
# #  RUN           global.close_range_cloexec_unshare ...
# #            OK  global.close_range_cloexec_unshare
# ok 5 global.close_range_cloexec_unshare
# #  RUN           global.close_range_cloexec_syzbot ...
# #            OK  global.close_range_cloexec_syzbot
# ok 6 global.close_range_cloexec_syzbot
# #  RUN           global.close_range_cloexec_unshare_syzbot ...
# #            OK  global.close_range_cloexec_unshare_syzbot
# ok 7 global.close_range_cloexec_unshare_syzbot
# # PASSED: 7 / 7 tests passed.
# # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: core: close_range_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/core'
2021-09-10 00:53:32 make -j4 -C cpu-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/cpu-hotp=
lug'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/cpu-hotpl=
ug'
2021-09-10 00:53:32 make run_tests -C cpu-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/cpu-hotp=
lug'
TAP version 13
1..1
# selftests: cpu-hotplug: cpu-on-off-test.sh
# pid 1511's current affinity mask: f
# pid 1511's new affinity mask: 1
# CPU online/offline summary:
# present_cpus =3D 0-3 present_max =3D 3
# 	 Cpus in online state: 0-3
# 	 Cpus in offline state: 0
# Limited scope test: one hotplug cpu
# 	 (leaves cpu in the original state):
# 	 online to offline to online: cpu 3
ok 1 selftests: cpu-hotplug: cpu-on-off-test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/cpu-hotpl=
ug'
dma test: not in Makefile
2021-09-10 00:53:32 make TARGETS=3Ddma
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/irdma-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/linux/cxl_mem.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/virtio_bt.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/misc/bcm_vk.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/virtio_pcidev.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/nfnetlink_hook.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/rkisp1-config.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/rpmsg_types.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/virtio_snd.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/spi/spi.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/iio/buffer.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/fsl_mc.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/wwan.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/landlock.h
  HDRINST usr/include/linux/vdpa.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/ccs.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/f2fs.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/acrn.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/surface_aggregator/dtx.h
  HDRINST usr/include/linux/surface_aggregator/cdev.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/cifs/cifs_netlink.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/sgx.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
gcc -I../../../../usr/include/    dma_map_benchmark.c  -o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/=
tools/testing/selftests/dma/dma_map_benchmark
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
2021-09-10 00:53:59 make -j4 -C dma
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
2021-09-10 00:53:59 make run_tests -C dma
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
TAP version 13
1..1
# selftests: dma: dma_map_benchmark
# dma mapping benchmark: threads:1 seconds:20 node:-1 dir:BIDIRECTIONAL gra=
nule: 1
# average map latency(us):0.7 standard deviation:0.9
# average unmap latency(us):0.5 standard deviation:0.8
ok 1 selftests: dma: dma_map_benchmark
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
dmabuf-heaps test: not in Makefile
2021-09-10 00:54:19 make TARGETS=3Ddmabuf-heaps
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabu=
f-heaps'
gcc -static -O3 -Wl,-no-as-needed -Wall    dmabuf-heap.c  -o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b6197=
87/tools/testing/selftests/dmabuf-heaps/dmabuf-heap
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabuf=
-heaps'
2021-09-10 00:54:20 make -j4 -C dmabuf-heaps
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabuf-h=
eaps'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabuf-he=
aps'
2021-09-10 00:54:20 make run_tests -C dmabuf-heaps
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabuf-h=
eaps'
TAP version 13
1..1
# selftests: dmabuf-heaps: dmabuf-heap
# Testing heap: system
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#   Testing allocation and importing:   OK
#   Testing alloced 4k buffers are zeroed:  OK
#   Testing alloced 1024k buffers are zeroed:  OK
#   Testing (theoretical)older alloc compat:  OK
#   Testing (theoretical)newer alloc compat:  OK
#   Testing expected error cases:  OK
ok 1 selftests: dmabuf-heaps: dmabuf-heap
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabuf-he=
aps'
LKP SKIP efivarfs | no /sys/firmware/efi
2021-09-10 00:54:20 touch ./exec/pipe
2021-09-10 00:54:20 make -j4 -C exec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec'
gcc -Wall -Wno-nonnull -D_GNU_SOURCE    execveat.c  -o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/too=
ls/testing/selftests/exec/execveat
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x1000 -pie -s=
tatic load_address.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-=
d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/load_=
address_4096
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x200000 -pie =
-static load_address.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/loa=
d_address_2097152
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x1000000 -pie=
 -static load_address.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftes=
ts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/lo=
ad_address_16777216
gcc -Wall -Wno-nonnull -D_GNU_SOURCE    recursion-depth.c  -o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619=
787/tools/testing/selftests/exec/recursion-depth
echo '#!/bin/sh' > /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109=
fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/script
echo 'exit $*' >> /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109f=
e3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/script
mkdir -p /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0=
f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/subdir
chmod +x /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0=
f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/script
cd /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac=
099b78c908e3b619787/tools/testing/selftests/exec && ln -s -f execveat execv=
eat.symlink
cp /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac=
099b78c908e3b619787/tools/testing/selftests/exec/execveat /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/=
tools/testing/selftests/exec/execveat.denatured
chmod -x /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0=
f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/execveat.denatured
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec'
2021-09-10 00:54:20 make run_tests -C exec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec'
TAP version 13
1..7
# selftests: exec: execveat
# /bin/sh: 0: Can't open /dev/fd/8/usr/src/perf_selftests-x86_64-rhel-8.3-k=
selftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/=
exec/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/yyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyy
# Check success of execveat(5, '../execveat', 0)... [OK]
# Check success of execveat(7, 'execveat', 0)... [OK]
# Check success of execveat(9, 'execveat', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...ftests/exec/execv=
eat', 0)... [OK]
# Check success of execveat(99, '/usr/src/perf_selfte...ftests/exec/execvea=
t', 0)... [OK]
# Check success of execveat(11, '', 4096)... [OK]
# Check success of execveat(20, '', 4096)... [OK]
# Check success of execveat(12, '', 4096)... [OK]
# Check success of execveat(17, '', 4096)... [OK]
# Check success of execveat(17, '', 4096)... [OK]
# Check success of execveat(18, '', 4096)... [OK]
# Check failure of execveat(11, '', 0) with ENOENT... [OK]
# Check failure of execveat(11, '(null)', 4096) with EFAULT... [OK]
# Check success of execveat(7, 'execveat.symlink', 0)... [OK]
# Check success of execveat(9, 'execveat.symlink', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...xec/execveat.syml=
ink', 0)... [OK]
# Check success of execveat(13, '', 4096)... [OK]
# Check success of execveat(13, '', 4352)... [OK]
# Check failure of execveat(7, 'execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(9, 'execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(-100, '/usr/src/perf_selftests-x86_64-rhel-8.3-=
kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests=
/exec/execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(7, 'pipe', 0) with EACCES... [OK]
# Check success of execveat(5, '../script', 0)... [OK]
# Check success of execveat(7, 'script', 0)... [OK]
# Check success of execveat(9, 'script', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...elftests/exec/scr=
ipt', 0)... [OK]
# Check success of execveat(16, '', 4096)... [OK]
# Check success of execveat(16, '', 4352)... [OK]
# Check failure of execveat(21, '', 4096) with ENOENT... [OK]
# Check failure of execveat(10, 'script', 0) with ENOENT... [OK]
# Check success of execveat(19, '', 4096)... [OK]
# Check success of execveat(19, '', 4096)... [OK]
# Check success of execveat(6, '../script', 0)... [OK]
# Check success of execveat(6, 'script', 0)... [OK]
# Check success of execveat(6, '../script', 0)... [OK]
# Check failure of execveat(6, 'script', 0) with ENOENT... [OK]
# Check failure of execveat(7, 'execveat', 65535) with EINVAL... [OK]
# Check failure of execveat(7, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(9, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(-100, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(7, '', 4096) with EACCES... [OK]
# Check failure of execveat(7, 'Makefile', 0) with EACCES... [OK]
# Check failure of execveat(14, '', 4096) with EACCES... [OK]
# Check failure of execveat(15, '', 4096) with EACCES... [OK]
# Check failure of execveat(99, '', 4096) with EBADF... [OK]
# Check failure of execveat(99, 'execveat', 0) with EBADF... [OK]
# Check failure of execveat(11, 'execveat', 0) with ENOTDIR... [OK]
# Invoke copy of 'execveat' via filename of length 4094:
# Check success of execveat(22, '', 4096)... [OK]
# Check success of execveat(8, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy=
', 0)... [OK]
# Invoke copy of 'script' via filename of length 4094:
# Check success of execveat(23, '', 4096)... [OK]
# Check success of execveat(8, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy=
', 0)... [OK]
ok 1 selftests: exec: execveat
# selftests: exec: load_address_4096
# PASS
ok 2 selftests: exec: load_address_4096
# selftests: exec: load_address_2097152
# PASS
ok 3 selftests: exec: load_address_2097152
# selftests: exec: load_address_16777216
# PASS
ok 4 selftests: exec: load_address_16777216
# selftests: exec: recursion-depth
ok 5 selftests: exec: recursion-depth
# selftests: exec: binfmt_script
# TAP version 1.3
# 1..27
# ok 1 - binfmt_script too-big (correctly failed bad exec)
# ok 2 - binfmt_script exact (correctly failed bad exec)
# ok 3 - binfmt_script exact-space (correctly failed bad exec)
# ok 4 - binfmt_script whitespace-too-big (correctly failed bad exec)
# ok 5 - binfmt_script truncated (correctly failed bad exec)
# ok 6 - binfmt_script empty (correctly failed bad exec)
# ok 7 - binfmt_script spaces (correctly failed bad exec)
# ok 8 - binfmt_script newline-prefix (correctly failed bad exec)
# ok 9 - binfmt_script test.pl (successful good exec)
# ok 10 - binfmt_script one-under (successful good exec)
# ok 11 - binfmt_script two-under (successful good exec)
# ok 12 - binfmt_script exact-trunc-whitespace (successful good exec)
# ok 13 - binfmt_script exact-trunc-arg (successful good exec)
# ok 14 - binfmt_script one-under-full-arg (successful good exec)
# ok 15 - binfmt_script one-under-no-nl (successful good exec)
# ok 16 - binfmt_script half-under-no-nl (successful good exec)
# ok 17 - binfmt_script one-under-trunc-arg (successful good exec)
# ok 18 - binfmt_script one-under-leading (successful good exec)
# ok 19 - binfmt_script one-under-leading-trunc-arg (successful good exec)
# ok 20 - binfmt_script two-under-no-nl (successful good exec)
# ok 21 - binfmt_script two-under-trunc-arg (successful good exec)
# ok 22 - binfmt_script two-under-leading (successful good exec)
# ok 23 - binfmt_script two-under-leading-trunc-arg (successful good exec)
# ok 24 - binfmt_script two-under-no-nl (successful good exec)
# ok 25 - binfmt_script two-under-trunc-arg (successful good exec)
# ok 26 - binfmt_script two-under-leading (successful good exec)
# ok 27 - binfmt_script two-under-lead-trunc-arg (successful good exec)
ok 6 selftests: exec: binfmt_script
# selftests: exec: non-regular
# Warning: file non-regular is missing!
not ok 7 selftests: exec: non-regular
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec'
LKP SKIP filesystems
2021-09-10 00:54:21 make -j4 -C fpu
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/fpu'
gcc     test_fpu.c -lm -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/fpu/test=
_fpu
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/fpu'
2021-09-10 00:54:21 make run_tests -C fpu
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/fpu'
TAP version 13
1..2
# selftests: fpu: test_fpu
# [SKIP]	can't access /sys/kernel/debug/selftest_helpers/test_fpu: No such =
file or directory
ok 1 selftests: fpu: test_fpu
# selftests: fpu: run_test_fpu.sh
# ./run_test_fpu.sh: You must have the following enabled in your kernel:
# CONFIG_TEST_FPU=3Dm
ok 2 selftests: fpu: run_test_fpu.sh # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/fpu'
2021-09-10 00:54:21 make -j4 -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ftrace'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ftrace'
2021-09-10 00:54:21 make run_tests -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ftrace'
TAP version 13
1..1
# selftests: ftrace: ftracetest
# =3D=3D=3D Ftrace unit tests =3D=3D=3D
# [1] Basic trace file check	[PASS]
# [2] Basic test for tracers	[PASS]
# [3] Basic trace clock test	[PASS]
# [4] Basic event tracing check	[PASS]
# [5] Change the ringbuffer size	[PASS]
# [6] Snapshot and tracing setting	[PASS]
# [7] trace_pipe and trace_marker	[PASS]
# [8] Test ftrace direct functions against tracers	[PASS]
# [9] Test ftrace direct functions against kprobes	[PASS]
# [10] Generic dynamic event - add/remove kprobe events	[PASS]
# [11] Generic dynamic event - add/remove synthetic events	[PASS]
# [12] Generic dynamic event - selective clear (compatibility)	[PASS]
# [13] Generic dynamic event - generic clear event	[PASS]
# [14] event tracing - enable/disable with event level files	[PASS]
# [15] event tracing - restricts events based on pid notrace filtering	[PAS=
S]
# [16] event tracing - restricts events based on pid	[PASS]
# [17] event tracing - enable/disable with subsystem level files	[PASS]
# [18] event tracing - enable/disable with top level files	[PASS]
# [19] Test trace_printk from module	[PASS]
# [20] ftrace - function graph filters with stack tracer	[PASS]
# [21] ftrace - function graph filters	[PASS]
# [22] ftrace - function glob filters	[PASS]
# [23] ftrace - function pid notrace filters	[PASS]
# [24] ftrace - function pid filters	[PASS]
# [25] ftrace - stacktrace filter command	[PASS]
# [26] ftrace - function trace with cpumask	[PASS]
# [27] ftrace - test for function event triggers	[PASS]
# [28] ftrace - function trace on module	[PASS]
# [29] ftrace - function profiling	[PASS]
# [30] ftrace - function profiler with function tracing	[PASS]
# [31] ftrace - test reading of set_ftrace_filter	[PASS]
# [32] ftrace - Max stack tracer	[PASS]
# [33] ftrace - test for function traceon/off triggers	[PASS]
# [34] ftrace - test tracing error log support	[PASS]
# [35] Test creation and deletion of trace instances while setting an event=
	[PASS]
# [36] Test creation and deletion of trace instances	[PASS]
# [37] Kprobe dynamic event - adding and removing	[PASS]
# [38] Kprobe dynamic event - busy event check	[PASS]
# [39] Kprobe dynamic event with arguments	[PASS]
# [40] Kprobe event with comm arguments	[PASS]
# [41] Kprobe event string type argument	[PASS]
# [42] Kprobe event symbol argument	[PASS]
# [43] Kprobe event argument syntax	[PASS]
# [44] Kprobes event arguments with types	[PASS]
# [45] Kprobe event user-memory access	[PASS]
# [46] Kprobe event auto/manual naming	[PASS]
# [47] Kprobe dynamic event with function tracer	[PASS]
# [48] Kprobe dynamic event - probing module	[PASS]
# [49] Create/delete multiprobe on kprobe event	[PASS]
# [50] Kprobe event parser error log check	[PASS]
# [51] Kretprobe dynamic event with arguments	[PASS]
# [52] Kretprobe dynamic event with maxactive	[PASS]
# [53] Kretprobe %return suffix test	[PASS]
# [54] Register/unregister many kprobe events	[PASS]
# [55] Kprobe events - probe points	[PASS]
# [56] Kprobe dynamic event - adding and removing	[PASS]
# [57] Uprobe event parser error log check	[PASS]
# [58] test for the preemptirqsoff tracer	[PASS]
# [59] Meta-selftest: Checkbashisms	[UNRESOLVED]
# [60] Test wakeup tracer	[PASS]
# [61] Test wakeup RT tracer	[PASS]
# [62] event trigger - test inter-event histogram trigger expected fail act=
ions	[XFAIL]
# [63] event trigger - test field variable support	[PASS]
# [64] event trigger - test inter-event combined histogram trigger	[PASS]
# [65] event trigger - test multiple actions on hist trigger	[PASS]
# [66] event trigger - test inter-event histogram trigger onchange action	[=
PASS]
# [67] event trigger - test inter-event histogram trigger onmatch action	[P=
ASS]
# [68] event trigger - test inter-event histogram trigger onmatch-onmax act=
ion	[PASS]
# [69] event trigger - test inter-event histogram trigger onmax action	[PAS=
S]
# [70] event trigger - test inter-event histogram trigger snapshot action	[=
PASS]
# [71] event trigger - test synthetic event create remove	[PASS]
# [72] event trigger - test inter-event histogram trigger trace action with=
 dynamic string param	[PASS]
# [73] event trigger - test synthetic_events syntax parser	[PASS]
# [74] event trigger - test synthetic_events syntax parser errors	[PASS]
# [75] event trigger - test inter-event histogram trigger trace action	[PAS=
S]
# [76] event trigger - test event enable/disable trigger	[PASS]
# [77] event trigger - test trigger filter	[PASS]
# [78] event trigger - test histogram modifiers	[PASS]
# [79] event trigger - test histogram parser errors	[PASS]
# [80] event trigger - test histogram trigger	[PASS]
# [81] event trigger - test multiple histogram triggers	[PASS]
# [82] event trigger - test snapshot-trigger	[PASS]
# [83] event trigger - test stacktrace-trigger	[PASS]
# [84] trace_marker trigger - test histogram trigger	[PASS]
# [85] trace_marker trigger - test snapshot trigger	[PASS]
# [86] trace_marker trigger - test histogram with synthetic event against k=
ernel event	[PASS]
# [87] trace_marker trigger - test histogram with synthetic event	[PASS]
# [88] event trigger - test traceon/off trigger	[PASS]
# [89] (instance)  Basic test for tracers	[PASS]
# [90] (instance)  Basic trace clock test	[PASS]
# [91] (instance)  Change the ringbuffer size	[PASS]
# [92] (instance)  Snapshot and tracing setting	[PASS]
# [93] (instance)  trace_pipe and trace_marker	[PASS]
# [94] (instance)  event tracing - enable/disable with event level files	[P=
ASS]
# [95] (instance)  event tracing - restricts events based on pid notrace fi=
ltering	[PASS]
# [96] (instance)  event tracing - restricts events based on pid	[PASS]
# [97] (instance)  event tracing - enable/disable with subsystem level file=
s	[PASS]
# [98] (instance)  ftrace - function pid notrace filters	[PASS]
# [99] (instance)  ftrace - function pid filters	[PASS]
# [100] (instance)  ftrace - stacktrace filter command	[PASS]
# [101] (instance)  ftrace - test for function event triggers	[PASS]
# [102] (instance)  ftrace - test for function traceon/off triggers	[PASS]
# [103] (instance)  event trigger - test event enable/disable trigger	[PASS]
# [104] (instance)  event trigger - test trigger filter	[PASS]
# [105] (instance)  event trigger - test histogram modifiers	[PASS]
# [106] (instance)  event trigger - test histogram trigger	[PASS]
# [107] (instance)  event trigger - test multiple histogram triggers	[PASS]
# [108] (instance)  trace_marker trigger - test histogram trigger	[PASS]
# [109] (instance)  trace_marker trigger - test snapshot trigger	[PASS]
#=20
#=20
# # of passed:  107
# # of failed:  0
# # of unresolved:  1
# # of untested:  0
# # of unsupported:  0
# # of xfailed:  1
# # of undefined(test bug):  0
ok 1 selftests: ftrace: ftracetest
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ftrace'
2021-09-10 00:58:43 make -j4 -C futex
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex'
make[1]: warning: jobserver unavailable: using -j1.  Add '+' to parent make=
 rule.
make --no-builtin-rules INSTALL_HDR_PATH=3D$OUTPUT/usr \
	ARCH=3Dx86 -C ../../../../.. headers_install
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a=
0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/usr/inc=
lude
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_wait_timeout.c ../inc=
lude/futextest.h ../include/atomic.h ../include/logging.h -lpthread -lrt -o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac09=
9b78c908e3b619787/tools/testing/selftests/futex/functional/futex_wait_timeo=
ut
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_wait_wouldblock.c ../=
include/futextest.h ../include/atomic.h ../include/logging.h -lpthread -lrt=
 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4a=
c099b78c908e3b619787/tools/testing/selftests/futex/functional/futex_wait_wo=
uldblock
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_requeue_pi.c ../inclu=
de/futextest.h ../include/atomic.h ../include/logging.h -lpthread -lrt -o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b=
78c908e3b619787/tools/testing/selftests/futex/functional/futex_requeue_pi
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_requeue_pi_signal_res=
tart.c ../include/futextest.h ../include/atomic.h ../include/logging.h -lpt=
hread -lrt -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0=
991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/fut=
ex_requeue_pi_signal_restart
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_requeue_pi_mismatched=
_ops.c ../include/futextest.h ../include/atomic.h ../include/logging.h -lpt=
hread -lrt -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0=
991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/fut=
ex_requeue_pi_mismatched_ops
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_wait_uninitialized_he=
ap.c ../include/futextest.h ../include/atomic.h ../include/logging.h -lpthr=
ead -lrt -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a099=
1a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/futex=
_wait_uninitialized_heap
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_wait_private_mapped_f=
ile.c ../include/futextest.h ../include/atomic.h ../include/logging.h -lpth=
read -lrt -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a09=
91a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/fute=
x_wait_private_mapped_file
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_wait.c ../include/fut=
extest.h ../include/atomic.h ../include/logging.h -lpthread -lrt -o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908=
e3b619787/tools/testing/selftests/futex/functional/futex_wait
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_requeue.c ../include/=
futextest.h ../include/atomic.h ../include/logging.h -lpthread -lrt -o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c=
908e3b619787/tools/testing/selftests/futex/functional/futex_requeue
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/=
functional'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex'
2021-09-10 00:58:46 make run_tests -C futex
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex=
/functional'
make --no-builtin-rules INSTALL_HDR_PATH=3D$OUTPUT/usr \
	ARCH=3Dx86 -C ../../../../.. headers_install
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a=
0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/usr/inc=
lude
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/=
functional'
TAP version 13
1..1
# selftests: futex: run.sh
# tput: No value for $TERM and no -T specified
# tput: No value for $TERM and no -T specified
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D1 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D2000000000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D2000000000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
# ok 1 futex-requeue-pi-mismatched-ops
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
# # 	Arguments: <none>
# ok 1 futex-requeue-pi-signal-restart
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..7
# # futex_wait_timeout: Block on a futex and wait for timeout
# # 	Arguments: timeout=3D100000ns
# ok 1 futex_wait relative succeeds
# ok 2 futex_wait_bitset realtime succeeds
# ok 3 futex_wait_bitset monotonic succeeds
# ok 4 futex_wait_requeue_pi realtime succeeds
# ok 5 futex_wait_requeue_pi monotonic succeeds
# ok 6 futex_lock_pi realtime succeeds
# ok 7 futex_lock_pi invalid timeout flag succeeds
# # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
# ok 1 futex-wait-wouldblock
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_wait_uninitialized_heap: Test the uninitialized futex value in FU=
TEX_WAIT
# ok 1 futex-wait-uninitialized-heap
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_wait_private_mapped_file: Test the futex value of private file ma=
ppings in FUTEX_WAIT
# ok 1 futex-wait-private-mapped-file
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..3
# # futex_wait: Test futex_wait
# ok 1 futex_wake private succeeds
# ok 2 futex_wake shared (page anon) succeeds
# ok 3 futex_wake shared (file backed) succeeds
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..2
# # futex_requeue: Test futex_requeue
# ok 1 futex_requeue simple succeeds
# ok 2 futex_requeue many succeeds
# # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: futex: run.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex'
2021-09-10 00:58:56 make -C ../../../tools/gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
mkdir -p include/linux 2>&1 || true
ln -sf /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7=
b4ac099b78c908e3b619787/tools/gpio/../../include/uapi/linux/gpio.h include/=
linux/gpio.h
make -f /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f=
7b4ac099b78c908e3b619787/tools/build/Makefile.build dir=3D. obj=3Dgpio-utils
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  CC      gpio-utils.o
  LD      gpio-utils-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
make -f /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f=
7b4ac099b78c908e3b619787/tools/build/Makefile.build dir=3D. obj=3Dlsgpio
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  CC      lsgpio.o
  LD      lsgpio-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  LINK    lsgpio
make -f /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f=
7b4ac099b78c908e3b619787/tools/build/Makefile.build dir=3D. obj=3Dgpio-hamm=
er
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  CC      gpio-hammer.o
  LD      gpio-hammer-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  LINK    gpio-hammer
make -f /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f=
7b4ac099b78c908e3b619787/tools/build/Makefile.build dir=3D. obj=3Dgpio-even=
t-mon
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  CC      gpio-event-mon.o
  LD      gpio-event-mon-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  LINK    gpio-event-mon
make -f /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f=
7b4ac099b78c908e3b619787/tools/build/Makefile.build dir=3D. obj=3Dgpio-watch
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  CC      gpio-watch.o
  LD      gpio-watch-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  LINK    gpio-watch
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
2021-09-10 00:58:57 make -j4 -C gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/gpio'
gcc -I../../../../usr/include    gpio-mockup-cdev.c  -o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/to=
ols/testing/selftests/gpio/gpio-mockup-cdev
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/gpio'
2021-09-10 00:58:57 make run_tests -C gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/gpio'
TAP version 13
1..1
# selftests: gpio: gpio-mockup.sh
# 1.  Module load tests
# 1.1.  dynamic allocation of gpio
# 2.  Module load error tests
# 2.1 gpio overflow
# test failed: unexpected chip - gpiochip0
# GPIO gpio-mockup test FAIL
not ok 1 selftests: gpio: gpio-mockup.sh # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/gpio'
ia64 test: not in Makefile
2021-09-10 00:58:58 make TARGETS=3Dia64
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:129: warning: ignoring old recipe for target 'clean'
gcc     aliasing-test.c   -o aliasing-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
2021-09-10 00:58:59 make -j4 -C ia64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:129: warning: ignoring old recipe for target 'clean'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
2021-09-10 00:58:59 make run_tests -C ia64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:129: warning: ignoring old recipe for target 'clean'
TAP version 13
1..1
# selftests: ia64: aliasing-test
# PASS: /dev/mem 0x0-0xa0000 is readable
# PASS: /dev/mem 0xa0000-0xc0000 is mappable
# PASS: /dev/mem 0xc0000-0x100000 is readable
# PASS: /dev/mem 0x0-0x100000 is mappable
# PASS: /proc/bus/pci/00/00.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/01.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/02.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/14.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/14.2 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/16.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/17.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/02/00.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/00.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/01.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/02.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/14.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/14.2 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/16.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/17.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/02/00.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/00.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/01.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/02.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.2 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/16.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/17.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/02/00.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/00.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/01.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/02.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.2 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/16.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/17.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/02/00.0 0x0-0x100000 not mappable
ok 1 selftests: ia64: aliasing-test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
2021-09-10 00:58:59 make -j4 -C intel_pstate
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/intel_ps=
tate'
gcc  -Wall -D_GNU_SOURCE    msr.c -lm -o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/sel=
ftests/intel_pstate/msr
gcc  -Wall -D_GNU_SOURCE    aperf.c -lm -o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/s=
elftests/intel_pstate/aperf
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/intel_pst=
ate'
2021-09-10 00:58:59 make run_tests -C intel_pstate
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/intel_ps=
tate'
TAP version 13
1..1
# selftests: intel_pstate: run.sh
# cpupower: error while loading shared libraries: libcpupower.so.0: cannot =
open shared object file: No such file or directory
# ./run.sh: line 90: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
# cpupower: error while loading shared libraries: libcpupower.so.0: cannot =
open shared object file: No such file or directory
# ./run.sh: line 92: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# The marketing frequency of the cpu is 3200 MHz
# The maximum frequency of the cpu is  MHz
# The minimum frequency of the cpu is  MHz
# Target	      Actual	    Difference	  MSR(0x199)	max_perf_pct
ok 1 selftests: intel_pstate: run.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/intel_pst=
ate'
2021-09-10 00:58:59 make -j4 -C ipc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ipc'
gcc -DCONFIG_X86_64 -D__x86_64__ -I../../../../usr/include/    msgque.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac09=
9b78c908e3b619787/tools/testing/selftests/ipc/msgque
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ipc'
2021-09-10 00:58:59 make run_tests -C ipc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ipc'
TAP version 13
1..1
# selftests: ipc: msgque
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ipc: msgque
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ipc'
LKP SKIP ir.ir_loopback_rcmm
2021-09-10 00:58:59 make -j4 -C ir
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ir'
gcc -Wall -O2 -I../../../include/uapi    ir_loopback.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787=
/tools/testing/selftests/ir/ir_loopback
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ir'
2021-09-10 00:59:00 make run_tests -C ir
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ir'
TAP version 13
1..1
# selftests: ir: ir_loopback.sh
# Sending IR on rc0 and receiving IR on rc0.
# Testing protocol rc-5 for decoder rc-5 (1/18)...
# Testing scancode:1f7d
# Testing scancode:1a5c
# Testing scancode:1c02
# Testing scancode:6f
# Testing scancode:424
# Testing scancode:976
# Testing scancode:1c6c
# Testing scancode:621
# Testing scancode:27c
# Testing scancode:51d
# OK
# Testing protocol rc-5x-20 for decoder rc-5 (2/18)...
# Testing scancode:a7238
# Testing scancode:182a19
# Testing scancode:197c10
# Testing scancode:11040a
# Testing scancode:1d4114
# Testing scancode:1d0036
# Testing scancode:2023a
# Testing scancode:64c0a
# Testing scancode:1f1738
# Testing scancode:1b3e3f
# OK
# Testing protocol rc-5-sz for decoder rc-5-sz (3/18)...
# Testing scancode:2da6
# Testing scancode:aa8
# Testing scancode:59d
# Testing scancode:2c0f
# Testing scancode:9ea
# Testing scancode:2eb8
# Testing scancode:2033
# Testing scancode:d54
# Testing scancode:98e
# Testing scancode:347
# OK
# Testing protocol jvc for decoder jvc (4/18)...
# Testing scancode:b9b2
# Testing scancode:f90b
# Testing scancode:5e23
# Testing scancode:1634
# Testing scancode:397a
# Testing scancode:e248
# Testing scancode:202a
# Testing scancode:35e6
# Testing scancode:68e9
# Testing scancode:62a6
# OK
# Testing protocol sony-12 for decoder sony (5/18)...
# Testing scancode:70003
# Testing scancode:140061
# Testing scancode:5007f
# Testing scancode:10014
# Testing scancode:5002b
# Testing scancode:20053
# Testing scancode:1e004a
# Testing scancode:80026
# Testing scancode:9005e
# Testing scancode:1e0002
# OK
# Testing protocol sony-15 for decoder sony (6/18)...
# Testing scancode:c30065
# Testing scancode:3c0004
# Testing scancode:e6002a
# Testing scancode:f00002
# Testing scancode:10013
# Testing scancode:e70014
# Testing scancode:34003a
# Testing scancode:c0046
# Testing scancode:f00069
# Testing scancode:6b0049
# OK
# Testing protocol sony-20 for decoder sony (7/18)...
# Testing scancode:13770d
# Testing scancode:1deb1b
# Testing scancode:15f754
# Testing scancode:15d530
# Testing scancode:4014f
# Testing scancode:2314f
# Testing scancode:18b778
# Testing scancode:f2179
# Testing scancode:156735
# Testing scancode:32061
# OK
# Testing protocol nec for decoder nec (8/18)...
# Testing scancode:8420
# Testing scancode:a2b9
# Testing scancode:fcc3
# Testing scancode:911f
# Testing scancode:da4d
# Testing scancode:dcee
# Testing scancode:5f73
# Testing scancode:9217
# Testing scancode:3f94
# Testing scancode:f9d1
# OK
# Testing protocol nec-x for decoder nec (9/18)...
# Testing scancode:7ae199
# Testing scancode:9e079
# Testing scancode:a9d1d5
# Testing scancode:60fbc3
# Testing scancode:fac6fb
# Testing scancode:ab15e8
# Testing scancode:481fd7
# Testing scancode:2fac36
# Testing scancode:b80a2e
# Testing scancode:385140
# OK
# Testing protocol nec-32 for decoder nec (10/18)...
# Testing scancode:779baaff
# Testing scancode:482b81bb
# Testing scancode:18363c5b
# Testing scancode:3eb1a2d3
# Testing scancode:1781576b
# Testing scancode:643a3daa
# Testing scancode:7e33d422
# Testing scancode:f9a0f64
# Testing scancode:bc95f24
# Testing scancode:6ec93b58
# OK
# Testing protocol sanyo for decoder sanyo (11/18)...
# Testing scancode:1d3045
# Testing scancode:4e344
# Testing scancode:5de11
# Testing scancode:152d08
# Testing scancode:57463
# Testing scancode:3b85e
# Testing scancode:1309f7
# Testing scancode:8d3d6
# Testing scancode:4a75
# Testing scancode:19498b
# OK
# Testing protocol rc-6-0 for decoder rc-6 (12/18)...
# Testing scancode:cda7
# Testing scancode:2c0e
# Testing scancode:2a05
# Testing scancode:9f7c
# Testing scancode:27d1
# Testing scancode:f100
# Testing scancode:b564
# Testing scancode:47a8
# Testing scancode:9d36
# Testing scancode:bf92
# OK
# Testing protocol rc-6-6a-20 for decoder rc-6 (13/18)...
# Testing scancode:c98e9
# Testing scancode:94835
# Testing scancode:e414d
# Testing scancode:2d544
# Testing scancode:aeb09
# Testing scancode:f98b9
# Testing scancode:d12ef
# Testing scancode:ebf2b
# Testing scancode:9a81d
# Testing scancode:67213
# OK
# Testing protocol rc-6-6a-24 for decoder rc-6 (14/18)...
# Testing scancode:97fa83
# Testing scancode:c6d862
# Testing scancode:fb5557
# Testing scancode:3dd894
# Testing scancode:bc056b
# Testing scancode:c0c9ba
# Testing scancode:4190f2
# Testing scancode:8f0f62
# Testing scancode:99d91
# Testing scancode:a1db67
# OK
# Testing protocol rc-6-6a-32 for decoder rc-6 (15/18)...
# Testing scancode:3ba858ed
# Testing scancode:bbf6b38
# Testing scancode:127d0775
# Testing scancode:7fcb82f2
# Testing scancode:1a1f0ab5
# Testing scancode:5eb92f46
# Testing scancode:36e973f3
# Testing scancode:2e29c019
# Testing scancode:623d76ef
# Testing scancode:2e371129
# OK
# Testing protocol rc-6-mce for decoder rc-6 (16/18)...
# Testing scancode:800f7fac
# Testing scancode:800f0fd8
# Testing scancode:800f595f
# Testing scancode:800f40f9
# Testing scancode:800f651c
# Testing scancode:800f4468
# Testing scancode:800f59b2
# Testing scancode:800f780b
# Testing scancode:800f0393
# Testing scancode:800f01cf
# OK
# Testing protocol sharp for decoder sharp (17/18)...
# Testing scancode:a1e
# Testing scancode:1e17
# Testing scancode:1a32
# Testing scancode:1f75
# Testing scancode:16ab
# Testing scancode:1f9d
# Testing scancode:930
# Testing scancode:79e
# Testing scancode:eff
# Testing scancode:6c1
# OK
# Testing protocol imon for decoder imon (18/18)...
# Testing scancode:44434305
# Testing scancode:2e0e47ec
# Testing scancode:799591f9
# Testing scancode:56c04a7b
# Testing scancode:2dd9cadf
# Testing scancode:13b49cae
# Testing scancode:357979c1
# Testing scancode:64c33ed2
# Testing scancode:41de5cc8
# Testing scancode:17b6f0b0
# OK
# # Planned tests !=3D run tests (0 !=3D 180)
# # Totals: pass:180 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ir: ir_loopback.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ir'
2021-09-10 00:59:10 make -j4 -C kcmp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kcmp'
gcc -I../../../../usr/include/    kcmp_test.c  -o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/te=
sting/selftests/kcmp/kcmp_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kcmp'
2021-09-10 00:59:10 make run_tests -C kcmp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kcmp'
TAP version 13
1..1
# selftests: kcmp: kcmp_test
# pid1:  19283 pid2:  19284 FD:  2 FILES:  1 VM:  2 FS:  1 SIGHAND:  2 IO: =
 0 SYSVSEM:  0 INV: -1
# PASS: 0 returned as expected
# PASS: 0 returned as expected
# PASS: 0 returned as expected
# # Planned tests !=3D run tests (0 !=3D 3)
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# # Planned tests !=3D run tests (0 !=3D 3)
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: kcmp: kcmp_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kcmp'
2021-09-10 00:59:10 make -j4 -C kexec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kexec'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kexec'
2021-09-10 00:59:10 make run_tests -C kexec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kexec'
TAP version 13
1..2
# selftests: kexec: test_kexec_load.sh
# [INFO] kexec_load is enabled
# [INFO] IMA enabled
# [INFO] IMA architecture specific policy enabled
# [INFO] efivars is not mounted on /sys/firmware/efi/efivars
# efi_vars is not enabled
#=20
ok 1 selftests: kexec: test_kexec_load.sh # SKIP
# selftests: kexec: test_kexec_file_load.sh
# [INFO] kexec_file_load is enabled
# [INFO] IMA enabled
# [INFO] architecture specific policy enabled
# [INFO] reading IMA policy permitted
# [INFO] efivars is not mounted on /sys/firmware/efi/efivars
# efi_vars is not enabled
#=20
ok 2 selftests: kexec: test_kexec_file_load.sh # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kexec'
kmod test: not in Makefile
2021-09-10 00:59:10 make TARGETS=3Dkmod
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
2021-09-10 00:59:10 make -j4 -C kmod
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
2021-09-10 00:59:10 make run_tests -C kmod
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
TAP version 13
1..1
# selftests: kmod: kmod.sh
# Fri Sep 10 00:59:11 UTC 2021
# Running test: kmod_test_0001 - run #0
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:11 UTC 2021
# Running test: kmod_test_0001 - run #1
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:11 UTC 2021
# Running test: kmod_test_0001 - run #2
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:11 UTC 2021
# Running test: kmod_test_0002 - run #0
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:12 UTC 2021
# Running test: kmod_test_0002 - run #1
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:12 UTC 2021
# Running test: kmod_test_0002 - run #2
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:13 UTC 2021
# Running test: kmod_test_0003 - run #0
# kmod_test_0003: OK! - loading kmod test
# kmod_test_0003: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:13 UTC 2021
# Running test: kmod_test_0004 - run #0
# kmod_test_0004: OK! - loading kmod test
# kmod_test_0004: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:14 UTC 2021
# Running test: kmod_test_0005 - run #0
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:14 UTC 2021
# Running test: kmod_test_0005 - run #1
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:15 UTC 2021
# Running test: kmod_test_0005 - run #2
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:15 UTC 2021
# Running test: kmod_test_0005 - run #3
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:16 UTC 2021
# Running test: kmod_test_0005 - run #4
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:16 UTC 2021
# Running test: kmod_test_0005 - run #5
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:17 UTC 2021
# Running test: kmod_test_0005 - run #6
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:17 UTC 2021
# Running test: kmod_test_0005 - run #7
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:18 UTC 2021
# Running test: kmod_test_0005 - run #8
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:18 UTC 2021
# Running test: kmod_test_0005 - run #9
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:19 UTC 2021
# Running test: kmod_test_0006 - run #0
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:22 UTC 2021
# Running test: kmod_test_0006 - run #1
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:23 UTC 2021
# Running test: kmod_test_0006 - run #2
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:25 UTC 2021
# Running test: kmod_test_0006 - run #3
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:26 UTC 2021
# Running test: kmod_test_0006 - run #4
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:28 UTC 2021
# Running test: kmod_test_0006 - run #5
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:30 UTC 2021
# Running test: kmod_test_0006 - run #6
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:32 UTC 2021
# Running test: kmod_test_0006 - run #7
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:33 UTC 2021
# Running test: kmod_test_0006 - run #8
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:36 UTC 2021
# Running test: kmod_test_0006 - run #9
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:37 UTC 2021
# Running test: kmod_test_0007 - run #0
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:39 UTC 2021
# Running test: kmod_test_0007 - run #1
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:41 UTC 2021
# Running test: kmod_test_0007 - run #2
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:43 UTC 2021
# Running test: kmod_test_0007 - run #3
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:45 UTC 2021
# Running test: kmod_test_0007 - run #4
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:47 UTC 2021
# Running test: kmod_test_0008 - run #0
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:47 UTC 2021
# Running test: kmod_test_0008 - run #1
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:47 UTC 2021
# Running test: kmod_test_0008 - run #2
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:48 UTC 2021
# Running test: kmod_test_0008 - run #3
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:48 UTC 2021
# Running test: kmod_test_0008 - run #4
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:48 UTC 2021
# Running test: kmod_test_0008 - run #5
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:48 UTC 2021
# Running test: kmod_test_0008 - run #6
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:48 UTC 2021
# Running test: kmod_test_0008 - run #7
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:49 UTC 2021
# Running test: kmod_test_0008 - run #8
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:49 UTC 2021
# Running test: kmod_test_0008 - run #9
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:49 UTC 2021
# Running test: kmod_test_0008 - run #10
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:49 UTC 2021
# Running test: kmod_test_0008 - run #11
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:49 UTC 2021
# Running test: kmod_test_0008 - run #12
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:50 UTC 2021
# Running test: kmod_test_0008 - run #13
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:50 UTC 2021
# Running test: kmod_test_0008 - run #14
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:50 UTC 2021
# Running test: kmod_test_0008 - run #15
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:50 UTC 2021
# Running test: kmod_test_0008 - run #16
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:51 UTC 2021
# Running test: kmod_test_0008 - run #17
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:51 UTC 2021
# Running test: kmod_test_0008 - run #18
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:51 UTC 2021
# Running test: kmod_test_0008 - run #19
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:51 UTC 2021
# Running test: kmod_test_0008 - run #20
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:51 UTC 2021
# Running test: kmod_test_0008 - run #21
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:52 UTC 2021
# Running test: kmod_test_0008 - run #22
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:52 UTC 2021
# Running test: kmod_test_0008 - run #23
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:52 UTC 2021
# Running test: kmod_test_0008 - run #24
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:52 UTC 2021
# Running test: kmod_test_0008 - run #25
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:52 UTC 2021
# Running test: kmod_test_0008 - run #26
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:53 UTC 2021
# Running test: kmod_test_0008 - run #27
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:53 UTC 2021
# Running test: kmod_test_0008 - run #28
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:53 UTC 2021
# Running test: kmod_test_0008 - run #29
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:53 UTC 2021
# Running test: kmod_test_0008 - run #30
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:53 UTC 2021
# Running test: kmod_test_0008 - run #31
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:54 UTC 2021
# Running test: kmod_test_0008 - run #32
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:54 UTC 2021
# Running test: kmod_test_0008 - run #33
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:54 UTC 2021
# Running test: kmod_test_0008 - run #34
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:54 UTC 2021
# Running test: kmod_test_0008 - run #35
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:54 UTC 2021
# Running test: kmod_test_0008 - run #36
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:55 UTC 2021
# Running test: kmod_test_0008 - run #37
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:55 UTC 2021
# Running test: kmod_test_0008 - run #38
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:55 UTC 2021
# Running test: kmod_test_0008 - run #39
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:55 UTC 2021
# Running test: kmod_test_0008 - run #40
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:55 UTC 2021
# Running test: kmod_test_0008 - run #41
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:56 UTC 2021
# Running test: kmod_test_0008 - run #42
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:56 UTC 2021
# Running test: kmod_test_0008 - run #43
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:56 UTC 2021
# Running test: kmod_test_0008 - run #44
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:56 UTC 2021
# Running test: kmod_test_0008 - run #45
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:56 UTC 2021
# Running test: kmod_test_0008 - run #46
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:57 UTC 2021
# Running test: kmod_test_0008 - run #47
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:57 UTC 2021
# Running test: kmod_test_0008 - run #48
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:57 UTC 2021
# Running test: kmod_test_0008 - run #49
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:57 UTC 2021
# Running test: kmod_test_0008 - run #50
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:57 UTC 2021
# Running test: kmod_test_0008 - run #51
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:58 UTC 2021
# Running test: kmod_test_0008 - run #52
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:58 UTC 2021
# Running test: kmod_test_0008 - run #53
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:58 UTC 2021
# Running test: kmod_test_0008 - run #54
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:58 UTC 2021
# Running test: kmod_test_0008 - run #55
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:58 UTC 2021
# Running test: kmod_test_0008 - run #56
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:59 UTC 2021
# Running test: kmod_test_0008 - run #57
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:59 UTC 2021
# Running test: kmod_test_0008 - run #58
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:59 UTC 2021
# Running test: kmod_test_0008 - run #59
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:59 UTC 2021
# Running test: kmod_test_0008 - run #60
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:00 UTC 2021
# Running test: kmod_test_0008 - run #61
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:00 UTC 2021
# Running test: kmod_test_0008 - run #62
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:00 UTC 2021
# Running test: kmod_test_0008 - run #63
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:00 UTC 2021
# Running test: kmod_test_0008 - run #64
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:00 UTC 2021
# Running test: kmod_test_0008 - run #65
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:01 UTC 2021
# Running test: kmod_test_0008 - run #66
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:01 UTC 2021
# Running test: kmod_test_0008 - run #67
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:01 UTC 2021
# Running test: kmod_test_0008 - run #68
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:01 UTC 2021
# Running test: kmod_test_0008 - run #69
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:01 UTC 2021
# Running test: kmod_test_0008 - run #70
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:02 UTC 2021
# Running test: kmod_test_0008 - run #71
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:02 UTC 2021
# Running test: kmod_test_0008 - run #72
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:02 UTC 2021
# Running test: kmod_test_0008 - run #73
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:02 UTC 2021
# Running test: kmod_test_0008 - run #74
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:02 UTC 2021
# Running test: kmod_test_0008 - run #75
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:03 UTC 2021
# Running test: kmod_test_0008 - run #76
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:03 UTC 2021
# Running test: kmod_test_0008 - run #77
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:03 UTC 2021
# Running test: kmod_test_0008 - run #78
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:03 UTC 2021
# Running test: kmod_test_0008 - run #79
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:03 UTC 2021
# Running test: kmod_test_0008 - run #80
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:04 UTC 2021
# Running test: kmod_test_0008 - run #81
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:04 UTC 2021
# Running test: kmod_test_0008 - run #82
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:04 UTC 2021
# Running test: kmod_test_0008 - run #83
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:04 UTC 2021
# Running test: kmod_test_0008 - run #84
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:04 UTC 2021
# Running test: kmod_test_0008 - run #85
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:05 UTC 2021
# Running test: kmod_test_0008 - run #86
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:05 UTC 2021
# Running test: kmod_test_0008 - run #87
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:05 UTC 2021
# Running test: kmod_test_0008 - run #88
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:05 UTC 2021
# Running test: kmod_test_0008 - run #89
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:05 UTC 2021
# Running test: kmod_test_0008 - run #90
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:06 UTC 2021
# Running test: kmod_test_0008 - run #91
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:06 UTC 2021
# Running test: kmod_test_0008 - run #92
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:06 UTC 2021
# Running test: kmod_test_0008 - run #93
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:06 UTC 2021
# Running test: kmod_test_0008 - run #94
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:06 UTC 2021
# Running test: kmod_test_0008 - run #95
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:07 UTC 2021
# Running test: kmod_test_0008 - run #96
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:07 UTC 2021
# Running test: kmod_test_0008 - run #97
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:07 UTC 2021
# Running test: kmod_test_0008 - run #98
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:07 UTC 2021
# Running test: kmod_test_0008 - run #99
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:07 UTC 2021
# Running test: kmod_test_0008 - run #100
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:08 UTC 2021
# Running test: kmod_test_0008 - run #101
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:08 UTC 2021
# Running test: kmod_test_0008 - run #102
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:08 UTC 2021
# Running test: kmod_test_0008 - run #103
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:08 UTC 2021
# Running test: kmod_test_0008 - run #104
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:09 UTC 2021
# Running test: kmod_test_0008 - run #105
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:09 UTC 2021
# Running test: kmod_test_0008 - run #106
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:09 UTC 2021
# Running test: kmod_test_0008 - run #107
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:09 UTC 2021
# Running test: kmod_test_0008 - run #108
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:09 UTC 2021
# Running test: kmod_test_0008 - run #109
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:10 UTC 2021
# Running test: kmod_test_0008 - run #110
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:10 UTC 2021
# Running test: kmod_test_0008 - run #111
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:10 UTC 2021
# Running test: kmod_test_0008 - run #112
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:10 UTC 2021
# Running test: kmod_test_0008 - run #113
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:10 UTC 2021
# Running test: kmod_test_0008 - run #114
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:11 UTC 2021
# Running test: kmod_test_0008 - run #115
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:11 UTC 2021
# Running test: kmod_test_0008 - run #116
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:11 UTC 2021
# Running test: kmod_test_0008 - run #117
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:11 UTC 2021
# Running test: kmod_test_0008 - run #118
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:11 UTC 2021
# Running test: kmod_test_0008 - run #119
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:12 UTC 2021
# Running test: kmod_test_0008 - run #120
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:12 UTC 2021
# Running test: kmod_test_0008 - run #121
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:12 UTC 2021
# Running test: kmod_test_0008 - run #122
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:12 UTC 2021
# Running test: kmod_test_0008 - run #123
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:12 UTC 2021
# Running test: kmod_test_0008 - run #124
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:13 UTC 2021
# Running test: kmod_test_0008 - run #125
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:13 UTC 2021
# Running test: kmod_test_0008 - run #126
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:13 UTC 2021
# Running test: kmod_test_0008 - run #127
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:13 UTC 2021
# Running test: kmod_test_0008 - run #128
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:13 UTC 2021
# Running test: kmod_test_0008 - run #129
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:14 UTC 2021
# Running test: kmod_test_0008 - run #130
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:14 UTC 2021
# Running test: kmod_test_0008 - run #131
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:14 UTC 2021
# Running test: kmod_test_0008 - run #132
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:14 UTC 2021
# Running test: kmod_test_0008 - run #133
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:14 UTC 2021
# Running test: kmod_test_0008 - run #134
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:15 UTC 2021
# Running test: kmod_test_0008 - run #135
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:15 UTC 2021
# Running test: kmod_test_0008 - run #136
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:15 UTC 2021
# Running test: kmod_test_0008 - run #137
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:15 UTC 2021
# Running test: kmod_test_0008 - run #138
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:15 UTC 2021
# Running test: kmod_test_0008 - run #139
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:16 UTC 2021
# Running test: kmod_test_0008 - run #140
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:16 UTC 2021
# Running test: kmod_test_0008 - run #141
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:16 UTC 2021
# Running test: kmod_test_0008 - run #142
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:16 UTC 2021
# Running test: kmod_test_0008 - run #143
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:16 UTC 2021
# Running test: kmod_test_0008 - run #144
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:17 UTC 2021
# Running test: kmod_test_0008 - run #145
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:17 UTC 2021
# Running test: kmod_test_0008 - run #146
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:17 UTC 2021
# Running test: kmod_test_0008 - run #147
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:17 UTC 2021
# Running test: kmod_test_0008 - run #148
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:18 UTC 2021
# Running test: kmod_test_0008 - run #149
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:18 UTC 2021
# Running test: kmod_test_0009 - run #0
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:19 UTC 2021
# Running test: kmod_test_0009 - run #1
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:20 UTC 2021
# Running test: kmod_test_0009 - run #2
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:21 UTC 2021
# Running test: kmod_test_0009 - run #3
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:22 UTC 2021
# Running test: kmod_test_0009 - run #4
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:23 UTC 2021
# Running test: kmod_test_0009 - run #5
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:24 UTC 2021
# Running test: kmod_test_0009 - run #6
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:25 UTC 2021
# Running test: kmod_test_0009 - run #7
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:26 UTC 2021
# Running test: kmod_test_0009 - run #8
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:27 UTC 2021
# Running test: kmod_test_0009 - run #9
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:28 UTC 2021
# Running test: kmod_test_0009 - run #10
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:29 UTC 2021
# Running test: kmod_test_0009 - run #11
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:30 UTC 2021
# Running test: kmod_test_0009 - run #12
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:31 UTC 2021
# Running test: kmod_test_0009 - run #13
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:32 UTC 2021
# Running test: kmod_test_0009 - run #14
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:33 UTC 2021
# Running test: kmod_test_0009 - run #15
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:34 UTC 2021
# Running test: kmod_test_0009 - run #16
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:35 UTC 2021
# Running test: kmod_test_0009 - run #17
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:36 UTC 2021
# Running test: kmod_test_0009 - run #18
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:37 UTC 2021
# Running test: kmod_test_0009 - run #19
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:38 UTC 2021
# Running test: kmod_test_0009 - run #20
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:39 UTC 2021
# Running test: kmod_test_0009 - run #21
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:40 UTC 2021
# Running test: kmod_test_0009 - run #22
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:41 UTC 2021
# Running test: kmod_test_0009 - run #23
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:42 UTC 2021
# Running test: kmod_test_0009 - run #24
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:43 UTC 2021
# Running test: kmod_test_0009 - run #25
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:44 UTC 2021
# Running test: kmod_test_0009 - run #26
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:45 UTC 2021
# Running test: kmod_test_0009 - run #27
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:46 UTC 2021
# Running test: kmod_test_0009 - run #28
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:47 UTC 2021
# Running test: kmod_test_0009 - run #29
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:48 UTC 2021
# Running test: kmod_test_0009 - run #30
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:49 UTC 2021
# Running test: kmod_test_0009 - run #31
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:50 UTC 2021
# Running test: kmod_test_0009 - run #32
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:51 UTC 2021
# Running test: kmod_test_0009 - run #33
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:52 UTC 2021
# Running test: kmod_test_0009 - run #34
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:53 UTC 2021
# Running test: kmod_test_0009 - run #35
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:54 UTC 2021
# Running test: kmod_test_0009 - run #36
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:55 UTC 2021
# Running test: kmod_test_0009 - run #37
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:56 UTC 2021
# Running test: kmod_test_0009 - run #38
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:57 UTC 2021
# Running test: kmod_test_0009 - run #39
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:58 UTC 2021
# Running test: kmod_test_0009 - run #40
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:59 UTC 2021
# Running test: kmod_test_0009 - run #41
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:00 UTC 2021
# Running test: kmod_test_0009 - run #42
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:01 UTC 2021
# Running test: kmod_test_0009 - run #43
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:02 UTC 2021
# Running test: kmod_test_0009 - run #44
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:03 UTC 2021
# Running test: kmod_test_0009 - run #45
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:04 UTC 2021
# Running test: kmod_test_0009 - run #46
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:05 UTC 2021
# Running test: kmod_test_0009 - run #47
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:07 UTC 2021
# Running test: kmod_test_0009 - run #48
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:08 UTC 2021
# Running test: kmod_test_0009 - run #49
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:09 UTC 2021
# Running test: kmod_test_0010 - run #0
# kmod_test_0010: OK! - loading kmod test
# kmod_test_0010: OK! - Return value: -2 (-ENOENT), expected -ENOENT
# Fri Sep 10 01:01:09 UTC 2021
# Running test: kmod_test_0011 - run #0
# kmod_test_0011: OK! - loading kmod test
# kmod_test_0011: OK! - Return value: -2 (-ENOENT), expected -ENOENT
# Fri Sep 10 01:01:09 UTC 2021
# Running test: kmod_test_0012 - run #0
# kmod_check_visibility: OK!
# Fri Sep 10 01:01:09 UTC 2021
# Running test: kmod_test_0013 - run #0
# kmod_check_visibility: OK!
# Test completed
ok 1 selftests: kmod: kmod.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
locking test: not in Makefile
2021-09-10 01:01:09 make TARGETS=3Dlocking
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/locki=
ng'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/lockin=
g'
2021-09-10 01:01:09 make -j4 -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/locking'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/locking'
2021-09-10 01:01:09 make run_tests -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/locking'
TAP version 13
1..1
# selftests: locking: ww_mutex.sh
# locking/ww_mutex: ok
ok 1 selftests: locking: ww_mutex.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/locking'



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


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.14.0-gd7109fe3a099"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.14.0 Kernel Configuration
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
CONFIG_IRQ_SIM=y
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
CONFIG_BPF_LSM=y
# end of BPF subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
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
CONFIG_PREEMPT_RCU=y
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
CONFIG_EXPERT=y
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
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

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
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
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
CONFIG_ARCH_NR_GPIO=1024
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
CONFIG_X86_CPU_RESCTRL=y
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
# CONFIG_PROCESSOR_SELECT is not set
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
CONFIG_PERF_EVENTS_AMD_UNCORE=y
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
CONFIG_X86_SGX=y
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
# CONFIG_SUSPEND_SKIP_SYNC is not set
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
# CONFIG_DPM_WATCHDOG is not set
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
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
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
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
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
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_X86_SGX_KVM is not set
CONFIG_KVM_AMD=y
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
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
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
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y

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
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
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
CONFIG_UNINLINE_SPIN_UNLOCK=y
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
# CONFIG_CMA is not set
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
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
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
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
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
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
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
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
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
CONFIG_NFT_FLOW_OFFLOAD=m
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
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
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
CONFIG_NF_FLOW_TABLE_IPV4=m
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
CONFIG_NF_FLOW_TABLE_IPV6=m
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
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
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
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
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
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
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
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
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
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
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
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
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
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
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
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
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
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=y
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
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
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
# CONFIG_SCSI_DEBUG is not set
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
# CONFIG_PATA_PLATFORM is not set
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
# CONFIG_MD_MULTIPATH is not set
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
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
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
# CONFIG_MAC80211_HWSIM is not set
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
# CONFIG_TTY_PRINTK is not set
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
CONFIG_I2C_SMBUS=m
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
CONFIG_I2C_I801=m
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
CONFIG_GPIO_SYSFS=y
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
CONFIG_GPIO_MOCKUP=m
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
CONFIG_LPC_ICH=m
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
CONFIG_IR_SHARP_DECODER=m
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
CONFIG_RC_LOOPBACK=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_GPIO is not set
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
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
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

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
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
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

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
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
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
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
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
# CONFIG_INFINIBAND is not set
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
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
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
CONFIG_IRQ_BYPASS_MANAGER=y
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
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_WFX is not set
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
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
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
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
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
# CONFIG_XFS_ONLINE_REPAIR is not set
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
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
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
CONFIG_OVERLAY_FS=y
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
# CONFIG_MINIX_FS is not set
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
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
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
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
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
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
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
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
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
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
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
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
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
CONFIG_PRIME_NUMBERS=m
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
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
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
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
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
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
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
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
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
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
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
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
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
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
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
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
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
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='kvm-intel.unrestricted_guest=0'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d05'
	export tbox_group='lkp-skl-d05'
	export submit_id='613aa5b2884e310d46cf8c7c'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-01-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d7109fe3a0991a0f7b4ac099b78c908e3b619787-20210910-3398-1t1twot-2.yaml'
	export id='f11a3a3c71d10ff5bd19c67b4a7acfc02ba15e8b'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c50091e544de-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export commit='d7109fe3a0991a0f7b4ac099b78c908e3b619787'
	export need_kconfig_hw='{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xe2'
	export need_kconfig='{"BTRFS_FS"=>"m"}
{"CHECKPOINT_RESTORE"=>"y"}
{"DRM_DEBUG_SELFTEST"=>"m, v4.18-rc1"}
{"EFIVAR_FS"=>"y"}
{"EMBEDDED"=>"y"}
{"EXPERT"=>"y"}
{"FTRACE"=>"y"}
{"FUNCTION_PROFILER"=>"y"}
{"GPIOLIB"=>"y"}
{"GPIO_MOCKUP"=>"v4.9-rc1"}
{"HIST_TRIGGERS"=>"y, v4.7-rc1"}
{"IMA_APPRAISE"=>"y"}
{"IMA_ARCH_POLICY"=>"y, v5.0-rc1"}
{"IRQSOFF_TRACER"=>"y"}
{"IR_IMON_DECODER"=>"m, v4.17-rc1"}
{"IR_SHARP_DECODER"=>"m"}
{"KALLSYMS_ALL"=>"y"}
{"KPROBES"=>"y"}
{"LIRC"=>"y"}
{"LKDTM"=>"y"}
{"MODULES"=>"y"}
{"MODULE_UNLOAD"=>"y"}
{"NOTIFIER_ERROR_INJECTION"=>"y"}
{"PREEMPT"=>"y"}
{"PREEMPTIRQ_DELAY_TEST"=>"m, v5.6-rc1"}
{"PREEMPT_TRACER"=>"y"}
{"SAMPLES"=>"y"}
{"SAMPLE_FTRACE_DIRECT"=>"m, v5.5-rc1"}
{"SAMPLE_TRACE_PRINTK"=>"m"}
{"SCHED_TRACER"=>"y"}
{"SECURITYFS"=>"y"}
{"STACK_TRACER"=>"y"}
TEST_BITMAP
{"TEST_KMOD"=>"m, v4.13-rc1"}
{"TEST_LKM"=>"m"}
TEST_PRINTF
{"TEST_STRSCPY"=>"m, v5.2-rc1"}
{"TRACER_SNAPSHOT"=>"y"}
{"TUN"=>"m"}
{"WW_MUTEX_SELFTEST"=>"m, v4.11-rc1"}
{"XFS_FS"=>"m"}
{"DMA_MAP_BENCHMARK"=>"y, v5.11-rc1"}'
	export initrds='linux_headers
linux_selftests'
	export enqueue_time='2021-09-10 08:24:19 +0800'
	export _id='613aa5c2884e310d46cf8c7d'
	export _rt='/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='29414d6e109d1dd7d5c7002a4078b26f08a79c1a'
	export base_commit='7d2a07b769330c34b4deabeed939325c77a7ec2f'
	export branch='tip/x86/urgent'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/3'
	export scheduler_version='/lkp/lkp/.src-20210909-222519'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-01-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d7109fe3a0991a0f7b4ac099b78c908e3b619787-20210910-3398-1t1twot-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
branch=tip/x86/urgent
commit=d7109fe3a0991a0f7b4ac099b78c908e3b619787
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/vmlinuz-5.14.0-gd7109fe3a099
kvm-intel.unrestricted_guest=0
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210907.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-d0cba0d1-1_20210907.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.14.0-rc3-00002-g8374f43123a5'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/vmlinuz-5.14.0-gd7109fe3a099'
	export dequeue_time='2021-09-10 08:52:01 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-01-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d7109fe3a0991a0f7b4ac099b78c908e3b619787-20210910-3398-1t1twot-2.cgz'

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

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-01' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='group-01' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--lIrNkN/7tmsD/ALM
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8=
=2E3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787
2021-09-10 00:53:31 ln -sf /usr/bin/clang
2021-09-10 00:53:31 ln -sf /usr/bin/llc
2021-09-10 00:53:31 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2021-09-10 00:53:31 make -j4 -C capabilities
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/capabili=
ties'
gcc -O2 -g -std=3Dgnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c90=
8e3b619787/tools/testing/selftests/capabilities/test_execve
gcc -O2 -g -std=3Dgnu99 -Wall    validate_cap.c -lcap-ng -lrt -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c9=
08e3b619787/tools/testing/selftests/capabilities/validate_cap
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/capabilit=
ies'
2021-09-10 00:53:31 make run_tests -C capabilities
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/capabili=
ties'
TAP version 13
1..1
# selftests: capabilities: test_execve
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# TAP version 13
# 1..12
# # [RUN]	+++ Tests with uid =3D=3D 0 +++
# # [NOTE]	Using global UIDs for tests
# # [RUN]	Root =3D> ep
# ok 1 Passed
# # Check cap_ambient manipulation rules
# ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
# ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
# ok 4 PR_CAP_AMBIENT_RAISE worked
# ok 5 Basic manipulation appears to work
# # [RUN]	Root +i =3D> eip
# ok 6 Passed
# # [RUN]	UID 0 +ia =3D> eipa
# ok 7 Passed
# # [RUN]	Root +ia, suidroot =3D> eipa
# ok 8 Passed
# # [RUN]	Root +ia, suidnonroot =3D> ip
# ok 9 Passed
# # [RUN]	Root +ia, sgidroot =3D> eipa
# ok 10 Passed
# ok 11 Passed
# # [RUN]	Root +ia, sgidnonroot =3D> eip
# ok 12 Passed
# # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # validate_cap:: Capabilities after execve were correct
# # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
# TAP version 13
# 1..9
# # [RUN]	+++ Tests with uid !=3D 0 +++
# # [NOTE]	Using global UIDs for tests
# # [RUN]	Non-root =3D> no caps
# ok 1 Passed
# # Check cap_ambient manipulation rules
# ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
# ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
# ok 4 PR_CAP_AMBIENT_RAISE worked
# ok 5 Basic manipulation appears to work
# # [RUN]	Non-root +i =3D> i
# ok 6 Passed
# # [RUN]	UID 1 +ia =3D> eipa
# ok 7 Passed
# # [RUN]	Non-root +ia, sgidnonroot =3D> i
# ok 8 Passed
# ok 9 Passed
# # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
# # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
ok 1 selftests: capabilities: test_execve
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/capabilit=
ies'
LKP SKIP cgroup
2021-09-10 00:53:31 make -j4 -C clone3
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/clone3'
gcc -g -std=3Dgnu99 -I../../../../usr/include/    clone3.c -lcap -o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908=
e3b619787/tools/testing/selftests/clone3/clone3
gcc -g -std=3Dgnu99 -I../../../../usr/include/    clone3_clear_sighand.c -l=
cap -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7=
b4ac099b78c908e3b619787/tools/testing/selftests/clone3/clone3_clear_sighand
gcc -g -std=3Dgnu99 -I../../../../usr/include/    clone3_set_tid.c -lcap -o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac09=
9b78c908e3b619787/tools/testing/selftests/clone3/clone3_set_tid
gcc -g -std=3Dgnu99 -I../../../../usr/include/    clone3_cap_checkpoint_res=
tore.c -lcap -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3=
a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/clone3/clone3_cap_=
checkpoint_restore
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/clone3'
2021-09-10 00:53:31 make run_tests -C clone3
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/clone3'
TAP version 13
1..4
# selftests: clone3: clone3
# TAP version 13
# 1..17
# # clone3() syscall supported
# # [1283] Trying clone3() with flags 0 (size 0)
# # I am the parent (1283). My child's pid is 1284
# # [1283] clone3() with flags says: 0 expected 0
# ok 1 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0x20000000 (size 0)
# # I am the parent (1283). My child's pid is 1285
# # [1283] clone3() with flags says: 0 expected 0
# ok 2 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0 (size 64)
# # I am the parent (1283). My child's pid is 1286
# # [1283] clone3() with flags says: 0 expected 0
# ok 3 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0 (size 56)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 4 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0 (size 96)
# # I am the parent (1283). My child's pid is 1287
# # [1283] clone3() with flags says: 0 expected 0
# ok 5 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 6 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 7 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 8 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 9 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0 (size 96)
# # I am the parent (1283). My child's pid is 1288
# # [1283] clone3() with flags says: 0 expected 0
# ok 10 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0 (size 104)
# # Argument list too long - Failed to create new process
# # [1283] clone3() with flags says: -7 expected -7
# ok 11 [1283] Result (-7) matches expectation (-7)
# # [1283] Trying clone3() with flags 0 (size 176)
# # Argument list too long - Failed to create new process
# # [1283] clone3() with flags says: -7 expected -7
# ok 12 [1283] Result (-7) matches expectation (-7)
# # [1283] Trying clone3() with flags 0 (size 4104)
# # Argument list too long - Failed to create new process
# # [1283] clone3() with flags says: -7 expected -7
# ok 13 [1283] Result (-7) matches expectation (-7)
# # [1283] Trying clone3() with flags 0x20000000 (size 64)
# # I am the parent (1283). My child's pid is 1289
# # [1283] clone3() with flags says: 0 expected 0
# ok 14 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0x20000000 (size 56)
# # Invalid argument - Failed to create new process
# # [1283] clone3() with flags says: -22 expected -22
# ok 15 [1283] Result (-22) matches expectation (-22)
# # [1283] Trying clone3() with flags 0x20000000 (size 96)
# # I am the parent (1283). My child's pid is 1290
# # [1283] clone3() with flags says: 0 expected 0
# ok 16 [1283] Result (0) matches expectation (0)
# # [1283] Trying clone3() with flags 0x20000000 (size 4104)
# # Argument list too long - Failed to create new process
# # [1283] clone3() with flags says: -7 expected -7
# ok 17 [1283] Result (-7) matches expectation (-7)
# # Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: clone3: clone3
# selftests: clone3: clone3_clear_sighand
# TAP version 13
# 1..1
# # clone3() syscall supported
# ok 1 Cleared signal handlers for child process
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: clone3: clone3_clear_sighand
# selftests: clone3: clone3_set_tid
# TAP version 13
# 1..29
# # clone3() syscall supported
# # /proc/sys/kernel/pid_max 32768
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 1 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 2 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 3 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 4 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 5 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 6 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 7 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 8 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 9 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 10 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
# ok 11 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 12 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 13 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to -1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
# ok 14 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 1 and 0x0
# # File exists - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 1 says :-17 - expected -17
# ok 15 [1315] Result (-17) matches expectation (-17)
# # [1315] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # I am the parent (1315). My child's pid is 1316
# # [1315] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 16 [1315] Result (0) matches expectation (0)
# # [1315] Trying clone3() with CLONE_SET_TID to 32768 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 17 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 32768 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 18 [1315] Result (-22) matches expectation (-22)
# # Child has PID 1317
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
# ok 18 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 1317 and 0x0
# # I am the child, my PID is 1317 (expected 1317)
# # I am the parent (1315). My child's pid is 1317
# # [1315] clone3() with CLONE_SET_TID 1317 says :0 - expected 0
# ok 19 [1315] Result (0) matches expectation (0)
# # [1315] Trying clone3() with CLONE_SET_TID to 1317 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 1317 says :-22 - expected -22
# ok 20 [1315] Result (-22) matches expectation (-22)
# # [1315] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # I am the parent (1315). My child's pid is 1317
# # [1315] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 21 [1315] Result (0) matches expectation (0)
# # unshare PID namespace
# # [1315] Trying clone3() with CLONE_SET_TID to 1317 and 0x0
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 1317 says :-22 - expected -22
# ok 22 [1315] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 43 and 0x0
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 43 says :-22 - expected -22
# ok 23 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 43 and 0x0
# # I am the child, my PID is 43 (expected 43)
# # I am the parent (1). My child's pid is 43
# # [1] clone3() with CLONE_SET_TID 43 says :0 - expected 0
# ok 24 [1] Result (0) matches expectation (0)
# # Child in PID namespace has PID 1
# # [1] Trying clone3() with CLONE_SET_TID to 2 and 0x0
# # I am the child, my PID is 2 (expected 2)
# # I am the parent (1). My child's pid is 2
# # [1] clone3() with CLONE_SET_TID 2 says :0 - expected 0
# ok 25 [1] Result (0) matches expectation (0)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 1 says :-22 - expected -22
# ok 26 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # Invalid argument - Failed to create new process
# # [1] clone3() with CLONE_SET_TID 1 says :-22 - expected -22
# ok 27 [1] Result (-22) matches expectation (-22)
# # [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# # I am the child, my PID is 1 (expected 1)
# # [1] Child is ready and waiting
# # I am the parent (1). My child's pid is 42
# # [1] clone3() with CLONE_SET_TID 1 says :0 - expected 0
# ok 28 [1] Result (0) matches expectation (0)
# # Invalid argument - Failed to create new process
# # [1315] clone3() with CLONE_SET_TID 1317 says :-22 - expected -22
# ok 22 [1315] Result (-22) matches expectation (-22)
# # [1315] Child is ready and waiting
# ok 29 PIDs in all namespaces as expected (1317,42,1)
# # Totals: pass:29 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 3 selftests: clone3: clone3_set_tid
# selftests: clone3: clone3_cap_checkpoint_restore
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.clone3_cap_checkpoint_restore ...
# # clone3_cap_checkpoint_restore.c:155:clone3_cap_checkpoint_restore:Child=
 has PID 1333
# # clone3() syscall supported
# # clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[1332]=
 Trying clone3() with CLONE_SET_TID to 1333
# # clone3() syscall supported
# # clone3_cap_checkpoint_restore.c:55:clone3_cap_checkpoint_restore:Operat=
ion not permitted - Failed to create new process
# # clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[1332]=
 clone3() with CLONE_SET_TID 1333 says:-1
# # clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[1332]=
 Trying clone3() with CLONE_SET_TID to 1333
# # clone3_cap_checkpoint_restore.c:70:clone3_cap_checkpoint_restore:I am t=
he parent (1332). My child's pid is 1333
# # clone3_cap_checkpoint_restore.c:63:clone3_cap_checkpoint_restore:I am t=
he child, my PID is 1333 (expected 1333)
# # clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[1332]=
 clone3() with CLONE_SET_TID 1333 says:0
# #            OK  global.clone3_cap_checkpoint_restore
# ok 1 global.clone3_cap_checkpoint_restore
# # PASSED: 1 / 1 tests passed.
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 4 selftests: clone3: clone3_cap_checkpoint_restore
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/clone3'
2021-09-10 00:53:32 make -j4 -C core
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/core'
gcc -g -I../../../../usr/include/    close_range_test.c  -o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b61978=
7/tools/testing/selftests/core/close_range_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/core'
2021-09-10 00:53:32 make run_tests -C core
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/core'
TAP version 13
1..1
# selftests: core: close_range_test
# TAP version 13
# 1..7
# # Starting 7 tests from 1 test cases.
# #  RUN           global.close_range ...
# #            OK  global.close_range
# ok 1 global.close_range
# #  RUN           global.close_range_unshare ...
# #            OK  global.close_range_unshare
# ok 2 global.close_range_unshare
# #  RUN           global.close_range_unshare_capped ...
# #            OK  global.close_range_unshare_capped
# ok 3 global.close_range_unshare_capped
# #  RUN           global.close_range_cloexec ...
# #            OK  global.close_range_cloexec
# ok 4 global.close_range_cloexec
# #  RUN           global.close_range_cloexec_unshare ...
# #            OK  global.close_range_cloexec_unshare
# ok 5 global.close_range_cloexec_unshare
# #  RUN           global.close_range_cloexec_syzbot ...
# #            OK  global.close_range_cloexec_syzbot
# ok 6 global.close_range_cloexec_syzbot
# #  RUN           global.close_range_cloexec_unshare_syzbot ...
# #            OK  global.close_range_cloexec_unshare_syzbot
# ok 7 global.close_range_cloexec_unshare_syzbot
# # PASSED: 7 / 7 tests passed.
# # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: core: close_range_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/core'
2021-09-10 00:53:32 make -j4 -C cpu-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/cpu-hotp=
lug'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/cpu-hotpl=
ug'
2021-09-10 00:53:32 make run_tests -C cpu-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/cpu-hotp=
lug'
TAP version 13
1..1
# selftests: cpu-hotplug: cpu-on-off-test.sh
# pid 1511's current affinity mask: f
# pid 1511's new affinity mask: 1
# CPU online/offline summary:
# present_cpus =3D 0-3 present_max =3D 3
# 	 Cpus in online state: 0-3
# 	 Cpus in offline state: 0
# Limited scope test: one hotplug cpu
# 	 (leaves cpu in the original state):
# 	 online to offline to online: cpu 3
ok 1 selftests: cpu-hotplug: cpu-on-off-test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/cpu-hotpl=
ug'
dma test: not in Makefile
2021-09-10 00:53:32 make TARGETS=3Ddma
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/irdma-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/linux/cxl_mem.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/virtio_bt.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/misc/bcm_vk.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/virtio_pcidev.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/nfnetlink_hook.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/rkisp1-config.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/rpmsg_types.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/virtio_snd.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/spi/spi.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/iio/buffer.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/fsl_mc.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/wwan.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/landlock.h
  HDRINST usr/include/linux/vdpa.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/ccs.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/f2fs.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/acrn.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/surface_aggregator/dtx.h
  HDRINST usr/include/linux/surface_aggregator/cdev.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/cifs/cifs_netlink.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/sgx.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
gcc -I../../../../usr/include/    dma_map_benchmark.c  -o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/=
tools/testing/selftests/dma/dma_map_benchmark
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
2021-09-10 00:53:59 make -j4 -C dma
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
2021-09-10 00:53:59 make run_tests -C dma
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
TAP version 13
1..1
# selftests: dma: dma_map_benchmark
# dma mapping benchmark: threads:1 seconds:20 node:-1 dir:BIDIRECTIONAL gra=
nule: 1
# average map latency(us):0.7 standard deviation:0.9
# average unmap latency(us):0.5 standard deviation:0.8
ok 1 selftests: dma: dma_map_benchmark
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dma'
dmabuf-heaps test: not in Makefile
2021-09-10 00:54:19 make TARGETS=3Ddmabuf-heaps
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabu=
f-heaps'
gcc -static -O3 -Wl,-no-as-needed -Wall    dmabuf-heap.c  -o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b6197=
87/tools/testing/selftests/dmabuf-heaps/dmabuf-heap
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabuf=
-heaps'
2021-09-10 00:54:20 make -j4 -C dmabuf-heaps
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabuf-h=
eaps'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabuf-he=
aps'
2021-09-10 00:54:20 make run_tests -C dmabuf-heaps
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabuf-h=
eaps'
TAP version 13
1..1
# selftests: dmabuf-heaps: dmabuf-heap
# Testing heap: system
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#   Testing allocation and importing:   OK
#   Testing alloced 4k buffers are zeroed:  OK
#   Testing alloced 1024k buffers are zeroed:  OK
#   Testing (theoretical)older alloc compat:  OK
#   Testing (theoretical)newer alloc compat:  OK
#   Testing expected error cases:  OK
ok 1 selftests: dmabuf-heaps: dmabuf-heap
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/dmabuf-he=
aps'
LKP SKIP efivarfs | no /sys/firmware/efi
2021-09-10 00:54:20 touch ./exec/pipe
2021-09-10 00:54:20 make -j4 -C exec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec'
gcc -Wall -Wno-nonnull -D_GNU_SOURCE    execveat.c  -o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/too=
ls/testing/selftests/exec/execveat
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x1000 -pie -s=
tatic load_address.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-=
d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/load_=
address_4096
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x200000 -pie =
-static load_address.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/loa=
d_address_2097152
gcc -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=3D0x1000000 -pie=
 -static load_address.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftes=
ts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/lo=
ad_address_16777216
gcc -Wall -Wno-nonnull -D_GNU_SOURCE    recursion-depth.c  -o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619=
787/tools/testing/selftests/exec/recursion-depth
echo '#!/bin/sh' > /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109=
fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/script
echo 'exit $*' >> /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109f=
e3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/script
mkdir -p /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0=
f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/subdir
chmod +x /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0=
f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/script
cd /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac=
099b78c908e3b619787/tools/testing/selftests/exec && ln -s -f execveat execv=
eat.symlink
cp /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac=
099b78c908e3b619787/tools/testing/selftests/exec/execveat /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/=
tools/testing/selftests/exec/execveat.denatured
chmod -x /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0=
f7b4ac099b78c908e3b619787/tools/testing/selftests/exec/execveat.denatured
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec'
2021-09-10 00:54:20 make run_tests -C exec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec'
TAP version 13
1..7
# selftests: exec: execveat
# /bin/sh: 0: Can't open /dev/fd/8/usr/src/perf_selftests-x86_64-rhel-8.3-k=
selftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/=
exec/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/yyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyy
# Check success of execveat(5, '../execveat', 0)... [OK]
# Check success of execveat(7, 'execveat', 0)... [OK]
# Check success of execveat(9, 'execveat', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...ftests/exec/execv=
eat', 0)... [OK]
# Check success of execveat(99, '/usr/src/perf_selfte...ftests/exec/execvea=
t', 0)... [OK]
# Check success of execveat(11, '', 4096)... [OK]
# Check success of execveat(20, '', 4096)... [OK]
# Check success of execveat(12, '', 4096)... [OK]
# Check success of execveat(17, '', 4096)... [OK]
# Check success of execveat(17, '', 4096)... [OK]
# Check success of execveat(18, '', 4096)... [OK]
# Check failure of execveat(11, '', 0) with ENOENT... [OK]
# Check failure of execveat(11, '(null)', 4096) with EFAULT... [OK]
# Check success of execveat(7, 'execveat.symlink', 0)... [OK]
# Check success of execveat(9, 'execveat.symlink', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...xec/execveat.syml=
ink', 0)... [OK]
# Check success of execveat(13, '', 4096)... [OK]
# Check success of execveat(13, '', 4352)... [OK]
# Check failure of execveat(7, 'execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(9, 'execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(-100, '/usr/src/perf_selftests-x86_64-rhel-8.3-=
kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests=
/exec/execveat.symlink', 256) with ELOOP... [OK]
# Check failure of execveat(7, 'pipe', 0) with EACCES... [OK]
# Check success of execveat(5, '../script', 0)... [OK]
# Check success of execveat(7, 'script', 0)... [OK]
# Check success of execveat(9, 'script', 0)... [OK]
# Check success of execveat(-100, '/usr/src/perf_selfte...elftests/exec/scr=
ipt', 0)... [OK]
# Check success of execveat(16, '', 4096)... [OK]
# Check success of execveat(16, '', 4352)... [OK]
# Check failure of execveat(21, '', 4096) with ENOENT... [OK]
# Check failure of execveat(10, 'script', 0) with ENOENT... [OK]
# Check success of execveat(19, '', 4096)... [OK]
# Check success of execveat(19, '', 4096)... [OK]
# Check success of execveat(6, '../script', 0)... [OK]
# Check success of execveat(6, 'script', 0)... [OK]
# Check success of execveat(6, '../script', 0)... [OK]
# Check failure of execveat(6, 'script', 0) with ENOENT... [OK]
# Check failure of execveat(7, 'execveat', 65535) with EINVAL... [OK]
# Check failure of execveat(7, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(9, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(-100, 'no-such-file', 0) with ENOENT... [OK]
# Check failure of execveat(7, '', 4096) with EACCES... [OK]
# Check failure of execveat(7, 'Makefile', 0) with EACCES... [OK]
# Check failure of execveat(14, '', 4096) with EACCES... [OK]
# Check failure of execveat(15, '', 4096) with EACCES... [OK]
# Check failure of execveat(99, '', 4096) with EBADF... [OK]
# Check failure of execveat(99, 'execveat', 0) with EBADF... [OK]
# Check failure of execveat(11, 'execveat', 0) with ENOTDIR... [OK]
# Invoke copy of 'execveat' via filename of length 4094:
# Check success of execveat(22, '', 4096)... [OK]
# Check success of execveat(8, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy=
', 0)... [OK]
# Invoke copy of 'script' via filename of length 4094:
# Check success of execveat(23, '', 4096)... [OK]
# Check success of execveat(8, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy=
', 0)... [OK]
ok 1 selftests: exec: execveat
# selftests: exec: load_address_4096
# PASS
ok 2 selftests: exec: load_address_4096
# selftests: exec: load_address_2097152
# PASS
ok 3 selftests: exec: load_address_2097152
# selftests: exec: load_address_16777216
# PASS
ok 4 selftests: exec: load_address_16777216
# selftests: exec: recursion-depth
ok 5 selftests: exec: recursion-depth
# selftests: exec: binfmt_script
# TAP version 1.3
# 1..27
# ok 1 - binfmt_script too-big (correctly failed bad exec)
# ok 2 - binfmt_script exact (correctly failed bad exec)
# ok 3 - binfmt_script exact-space (correctly failed bad exec)
# ok 4 - binfmt_script whitespace-too-big (correctly failed bad exec)
# ok 5 - binfmt_script truncated (correctly failed bad exec)
# ok 6 - binfmt_script empty (correctly failed bad exec)
# ok 7 - binfmt_script spaces (correctly failed bad exec)
# ok 8 - binfmt_script newline-prefix (correctly failed bad exec)
# ok 9 - binfmt_script test.pl (successful good exec)
# ok 10 - binfmt_script one-under (successful good exec)
# ok 11 - binfmt_script two-under (successful good exec)
# ok 12 - binfmt_script exact-trunc-whitespace (successful good exec)
# ok 13 - binfmt_script exact-trunc-arg (successful good exec)
# ok 14 - binfmt_script one-under-full-arg (successful good exec)
# ok 15 - binfmt_script one-under-no-nl (successful good exec)
# ok 16 - binfmt_script half-under-no-nl (successful good exec)
# ok 17 - binfmt_script one-under-trunc-arg (successful good exec)
# ok 18 - binfmt_script one-under-leading (successful good exec)
# ok 19 - binfmt_script one-under-leading-trunc-arg (successful good exec)
# ok 20 - binfmt_script two-under-no-nl (successful good exec)
# ok 21 - binfmt_script two-under-trunc-arg (successful good exec)
# ok 22 - binfmt_script two-under-leading (successful good exec)
# ok 23 - binfmt_script two-under-leading-trunc-arg (successful good exec)
# ok 24 - binfmt_script two-under-no-nl (successful good exec)
# ok 25 - binfmt_script two-under-trunc-arg (successful good exec)
# ok 26 - binfmt_script two-under-leading (successful good exec)
# ok 27 - binfmt_script two-under-lead-trunc-arg (successful good exec)
ok 6 selftests: exec: binfmt_script
# selftests: exec: non-regular
# Warning: file non-regular is missing!
not ok 7 selftests: exec: non-regular
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/exec'
LKP SKIP filesystems
2021-09-10 00:54:21 make -j4 -C fpu
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/fpu'
gcc     test_fpu.c -lm -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/fpu/test=
_fpu
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/fpu'
2021-09-10 00:54:21 make run_tests -C fpu
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/fpu'
TAP version 13
1..2
# selftests: fpu: test_fpu
# [SKIP]	can't access /sys/kernel/debug/selftest_helpers/test_fpu: No such =
file or directory
ok 1 selftests: fpu: test_fpu
# selftests: fpu: run_test_fpu.sh
# ./run_test_fpu.sh: You must have the following enabled in your kernel:
# CONFIG_TEST_FPU=3Dm
ok 2 selftests: fpu: run_test_fpu.sh # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/fpu'
2021-09-10 00:54:21 make -j4 -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ftrace'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ftrace'
2021-09-10 00:54:21 make run_tests -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ftrace'
TAP version 13
1..1
# selftests: ftrace: ftracetest
# =3D=3D=3D Ftrace unit tests =3D=3D=3D
# [1] Basic trace file check	[PASS]
# [2] Basic test for tracers	[PASS]
# [3] Basic trace clock test	[PASS]
# [4] Basic event tracing check	[PASS]
# [5] Change the ringbuffer size	[PASS]
# [6] Snapshot and tracing setting	[PASS]
# [7] trace_pipe and trace_marker	[PASS]
# [8] Test ftrace direct functions against tracers	[PASS]
# [9] Test ftrace direct functions against kprobes	[PASS]
# [10] Generic dynamic event - add/remove kprobe events	[PASS]
# [11] Generic dynamic event - add/remove synthetic events	[PASS]
# [12] Generic dynamic event - selective clear (compatibility)	[PASS]
# [13] Generic dynamic event - generic clear event	[PASS]
# [14] event tracing - enable/disable with event level files	[PASS]
# [15] event tracing - restricts events based on pid notrace filtering	[PAS=
S]
# [16] event tracing - restricts events based on pid	[PASS]
# [17] event tracing - enable/disable with subsystem level files	[PASS]
# [18] event tracing - enable/disable with top level files	[PASS]
# [19] Test trace_printk from module	[PASS]
# [20] ftrace - function graph filters with stack tracer	[PASS]
# [21] ftrace - function graph filters	[PASS]
# [22] ftrace - function glob filters	[PASS]
# [23] ftrace - function pid notrace filters	[PASS]
# [24] ftrace - function pid filters	[PASS]
# [25] ftrace - stacktrace filter command	[PASS]
# [26] ftrace - function trace with cpumask	[PASS]
# [27] ftrace - test for function event triggers	[PASS]
# [28] ftrace - function trace on module	[PASS]
# [29] ftrace - function profiling	[PASS]
# [30] ftrace - function profiler with function tracing	[PASS]
# [31] ftrace - test reading of set_ftrace_filter	[PASS]
# [32] ftrace - Max stack tracer	[PASS]
# [33] ftrace - test for function traceon/off triggers	[PASS]
# [34] ftrace - test tracing error log support	[PASS]
# [35] Test creation and deletion of trace instances while setting an event=
	[PASS]
# [36] Test creation and deletion of trace instances	[PASS]
# [37] Kprobe dynamic event - adding and removing	[PASS]
# [38] Kprobe dynamic event - busy event check	[PASS]
# [39] Kprobe dynamic event with arguments	[PASS]
# [40] Kprobe event with comm arguments	[PASS]
# [41] Kprobe event string type argument	[PASS]
# [42] Kprobe event symbol argument	[PASS]
# [43] Kprobe event argument syntax	[PASS]
# [44] Kprobes event arguments with types	[PASS]
# [45] Kprobe event user-memory access	[PASS]
# [46] Kprobe event auto/manual naming	[PASS]
# [47] Kprobe dynamic event with function tracer	[PASS]
# [48] Kprobe dynamic event - probing module	[PASS]
# [49] Create/delete multiprobe on kprobe event	[PASS]
# [50] Kprobe event parser error log check	[PASS]
# [51] Kretprobe dynamic event with arguments	[PASS]
# [52] Kretprobe dynamic event with maxactive	[PASS]
# [53] Kretprobe %return suffix test	[PASS]
# [54] Register/unregister many kprobe events	[PASS]
# [55] Kprobe events - probe points	[PASS]
# [56] Kprobe dynamic event - adding and removing	[PASS]
# [57] Uprobe event parser error log check	[PASS]
# [58] test for the preemptirqsoff tracer	[PASS]
# [59] Meta-selftest: Checkbashisms	[UNRESOLVED]
# [60] Test wakeup tracer	[PASS]
# [61] Test wakeup RT tracer	[PASS]
# [62] event trigger - test inter-event histogram trigger expected fail act=
ions	[XFAIL]
# [63] event trigger - test field variable support	[PASS]
# [64] event trigger - test inter-event combined histogram trigger	[PASS]
# [65] event trigger - test multiple actions on hist trigger	[PASS]
# [66] event trigger - test inter-event histogram trigger onchange action	[=
PASS]
# [67] event trigger - test inter-event histogram trigger onmatch action	[P=
ASS]
# [68] event trigger - test inter-event histogram trigger onmatch-onmax act=
ion	[PASS]
# [69] event trigger - test inter-event histogram trigger onmax action	[PAS=
S]
# [70] event trigger - test inter-event histogram trigger snapshot action	[=
PASS]
# [71] event trigger - test synthetic event create remove	[PASS]
# [72] event trigger - test inter-event histogram trigger trace action with=
 dynamic string param	[PASS]
# [73] event trigger - test synthetic_events syntax parser	[PASS]
# [74] event trigger - test synthetic_events syntax parser errors	[PASS]
# [75] event trigger - test inter-event histogram trigger trace action	[PAS=
S]
# [76] event trigger - test event enable/disable trigger	[PASS]
# [77] event trigger - test trigger filter	[PASS]
# [78] event trigger - test histogram modifiers	[PASS]
# [79] event trigger - test histogram parser errors	[PASS]
# [80] event trigger - test histogram trigger	[PASS]
# [81] event trigger - test multiple histogram triggers	[PASS]
# [82] event trigger - test snapshot-trigger	[PASS]
# [83] event trigger - test stacktrace-trigger	[PASS]
# [84] trace_marker trigger - test histogram trigger	[PASS]
# [85] trace_marker trigger - test snapshot trigger	[PASS]
# [86] trace_marker trigger - test histogram with synthetic event against k=
ernel event	[PASS]
# [87] trace_marker trigger - test histogram with synthetic event	[PASS]
# [88] event trigger - test traceon/off trigger	[PASS]
# [89] (instance)  Basic test for tracers	[PASS]
# [90] (instance)  Basic trace clock test	[PASS]
# [91] (instance)  Change the ringbuffer size	[PASS]
# [92] (instance)  Snapshot and tracing setting	[PASS]
# [93] (instance)  trace_pipe and trace_marker	[PASS]
# [94] (instance)  event tracing - enable/disable with event level files	[P=
ASS]
# [95] (instance)  event tracing - restricts events based on pid notrace fi=
ltering	[PASS]
# [96] (instance)  event tracing - restricts events based on pid	[PASS]
# [97] (instance)  event tracing - enable/disable with subsystem level file=
s	[PASS]
# [98] (instance)  ftrace - function pid notrace filters	[PASS]
# [99] (instance)  ftrace - function pid filters	[PASS]
# [100] (instance)  ftrace - stacktrace filter command	[PASS]
# [101] (instance)  ftrace - test for function event triggers	[PASS]
# [102] (instance)  ftrace - test for function traceon/off triggers	[PASS]
# [103] (instance)  event trigger - test event enable/disable trigger	[PASS]
# [104] (instance)  event trigger - test trigger filter	[PASS]
# [105] (instance)  event trigger - test histogram modifiers	[PASS]
# [106] (instance)  event trigger - test histogram trigger	[PASS]
# [107] (instance)  event trigger - test multiple histogram triggers	[PASS]
# [108] (instance)  trace_marker trigger - test histogram trigger	[PASS]
# [109] (instance)  trace_marker trigger - test snapshot trigger	[PASS]
#=20
#=20
# # of passed:  107
# # of failed:  0
# # of unresolved:  1
# # of untested:  0
# # of unsupported:  0
# # of xfailed:  1
# # of undefined(test bug):  0
ok 1 selftests: ftrace: ftracetest
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ftrace'
2021-09-10 00:58:43 make -j4 -C futex
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex'
make[1]: warning: jobserver unavailable: using -j1.  Add '+' to parent make=
 rule.
make --no-builtin-rules INSTALL_HDR_PATH=3D$OUTPUT/usr \
	ARCH=3Dx86 -C ../../../../.. headers_install
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a=
0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/usr/inc=
lude
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_wait_timeout.c ../inc=
lude/futextest.h ../include/atomic.h ../include/logging.h -lpthread -lrt -o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac09=
9b78c908e3b619787/tools/testing/selftests/futex/functional/futex_wait_timeo=
ut
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_wait_wouldblock.c ../=
include/futextest.h ../include/atomic.h ../include/logging.h -lpthread -lrt=
 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4a=
c099b78c908e3b619787/tools/testing/selftests/futex/functional/futex_wait_wo=
uldblock
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_requeue_pi.c ../inclu=
de/futextest.h ../include/atomic.h ../include/logging.h -lpthread -lrt -o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b=
78c908e3b619787/tools/testing/selftests/futex/functional/futex_requeue_pi
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_requeue_pi_signal_res=
tart.c ../include/futextest.h ../include/atomic.h ../include/logging.h -lpt=
hread -lrt -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0=
991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/fut=
ex_requeue_pi_signal_restart
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_requeue_pi_mismatched=
_ops.c ../include/futextest.h ../include/atomic.h ../include/logging.h -lpt=
hread -lrt -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0=
991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/fut=
ex_requeue_pi_mismatched_ops
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_wait_uninitialized_he=
ap.c ../include/futextest.h ../include/atomic.h ../include/logging.h -lpthr=
ead -lrt -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a099=
1a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/futex=
_wait_uninitialized_heap
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_wait_private_mapped_f=
ile.c ../include/futextest.h ../include/atomic.h ../include/logging.h -lpth=
read -lrt -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a09=
91a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/fute=
x_wait_private_mapped_file
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_wait.c ../include/fut=
extest.h ../include/atomic.h ../include/logging.h -lpthread -lrt -o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908=
e3b619787/tools/testing/selftests/futex/functional/futex_wait
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../../../.=
=2E/../usr/include/ -I/kselftest/usr/include    futex_requeue.c ../include/=
futextest.h ../include/atomic.h ../include/logging.h -lpthread -lrt -o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c=
908e3b619787/tools/testing/selftests/futex/functional/futex_requeue
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/=
functional'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex'
2021-09-10 00:58:46 make run_tests -C futex
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex=
/functional'
make --no-builtin-rules INSTALL_HDR_PATH=3D$OUTPUT/usr \
	ARCH=3Dx86 -C ../../../../.. headers_install
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a=
0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/functional/usr/inc=
lude
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex/=
functional'
TAP version 13
1..1
# selftests: futex: run.sh
# tput: No value for $TERM and no -T specified
# tput: No value for $TERM and no -T specified
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D1 timeout=3D0ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D2000000000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_requeue_pi: Test requeue functionality
# # 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D2000000000ns
# ok 1 futex-requeue-pi
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
# ok 1 futex-requeue-pi-mismatched-ops
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
# # 	Arguments: <none>
# ok 1 futex-requeue-pi-signal-restart
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..7
# # futex_wait_timeout: Block on a futex and wait for timeout
# # 	Arguments: timeout=3D100000ns
# ok 1 futex_wait relative succeeds
# ok 2 futex_wait_bitset realtime succeeds
# ok 3 futex_wait_bitset monotonic succeeds
# ok 4 futex_wait_requeue_pi realtime succeeds
# ok 5 futex_wait_requeue_pi monotonic succeeds
# ok 6 futex_lock_pi realtime succeeds
# ok 7 futex_lock_pi invalid timeout flag succeeds
# # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
# ok 1 futex-wait-wouldblock
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..1
# # futex_wait_uninitialized_heap: Test the uninitialized futex value in FU=
TEX_WAIT
# ok 1 futex-wait-uninitialized-heap
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
# TAP version 13
# 1..1
# # futex_wait_private_mapped_file: Test the futex value of private file ma=
ppings in FUTEX_WAIT
# ok 1 futex-wait-private-mapped-file
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..3
# # futex_wait: Test futex_wait
# ok 1 futex_wake private succeeds
# ok 2 futex_wake shared (page anon) succeeds
# ok 3 futex_wake shared (file backed) succeeds
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
#=20
# TAP version 13
# 1..2
# # futex_requeue: Test futex_requeue
# ok 1 futex_requeue simple succeeds
# ok 2 futex_requeue many succeeds
# # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: futex: run.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/futex'
2021-09-10 00:58:56 make -C ../../../tools/gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
mkdir -p include/linux 2>&1 || true
ln -sf /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7=
b4ac099b78c908e3b619787/tools/gpio/../../include/uapi/linux/gpio.h include/=
linux/gpio.h
make -f /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f=
7b4ac099b78c908e3b619787/tools/build/Makefile.build dir=3D. obj=3Dgpio-utils
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  CC      gpio-utils.o
  LD      gpio-utils-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
make -f /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f=
7b4ac099b78c908e3b619787/tools/build/Makefile.build dir=3D. obj=3Dlsgpio
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  CC      lsgpio.o
  LD      lsgpio-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  LINK    lsgpio
make -f /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f=
7b4ac099b78c908e3b619787/tools/build/Makefile.build dir=3D. obj=3Dgpio-hamm=
er
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  CC      gpio-hammer.o
  LD      gpio-hammer-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  LINK    gpio-hammer
make -f /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f=
7b4ac099b78c908e3b619787/tools/build/Makefile.build dir=3D. obj=3Dgpio-even=
t-mon
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  CC      gpio-event-mon.o
  LD      gpio-event-mon-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  LINK    gpio-event-mon
make -f /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f=
7b4ac099b78c908e3b619787/tools/build/Makefile.build dir=3D. obj=3Dgpio-watch
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  CC      gpio-watch.o
  LD      gpio-watch-in.o
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
  LINK    gpio-watch
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/gpio'
2021-09-10 00:58:57 make -j4 -C gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/gpio'
gcc -I../../../../usr/include    gpio-mockup-cdev.c  -o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/to=
ols/testing/selftests/gpio/gpio-mockup-cdev
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/gpio'
2021-09-10 00:58:57 make run_tests -C gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/gpio'
TAP version 13
1..1
# selftests: gpio: gpio-mockup.sh
# 1.  Module load tests
# 1.1.  dynamic allocation of gpio
# 2.  Module load error tests
# 2.1 gpio overflow
# test failed: unexpected chip - gpiochip0
# GPIO gpio-mockup test FAIL
not ok 1 selftests: gpio: gpio-mockup.sh # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/gpio'
ia64 test: not in Makefile
2021-09-10 00:58:58 make TARGETS=3Dia64
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:129: warning: ignoring old recipe for target 'clean'
gcc     aliasing-test.c   -o aliasing-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
2021-09-10 00:58:59 make -j4 -C ia64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:129: warning: ignoring old recipe for target 'clean'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
2021-09-10 00:58:59 make run_tests -C ia64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:129: warning: ignoring old recipe for target 'clean'
TAP version 13
1..1
# selftests: ia64: aliasing-test
# PASS: /dev/mem 0x0-0xa0000 is readable
# PASS: /dev/mem 0xa0000-0xc0000 is mappable
# PASS: /dev/mem 0xc0000-0x100000 is readable
# PASS: /dev/mem 0x0-0x100000 is mappable
# PASS: /proc/bus/pci/00/00.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/01.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/02.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/14.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/14.2 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/16.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/17.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/02/00.0 0x0-0xa0000 not mappable
# PASS: /proc/bus/pci/00/00.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/01.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/02.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/14.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/14.2 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/16.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/17.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/02/00.0 0xa0000-0xc0000 not mappable
# PASS: /proc/bus/pci/00/00.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/01.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/02.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.2 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/16.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/17.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/02/00.0 0xc0000-0x100000 not mappable
# PASS: /proc/bus/pci/00/00.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/01.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/02.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/14.2 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/16.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/17.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1c.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.0 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.2 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.3 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.4 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/00/1f.6 0x0-0x100000 not mappable
# PASS: /proc/bus/pci/02/00.0 0x0-0x100000 not mappable
ok 1 selftests: ia64: aliasing-test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ia64'
2021-09-10 00:58:59 make -j4 -C intel_pstate
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/intel_ps=
tate'
gcc  -Wall -D_GNU_SOURCE    msr.c -lm -o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/sel=
ftests/intel_pstate/msr
gcc  -Wall -D_GNU_SOURCE    aperf.c -lm -o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/s=
elftests/intel_pstate/aperf
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/intel_pst=
ate'
2021-09-10 00:58:59 make run_tests -C intel_pstate
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/intel_ps=
tate'
TAP version 13
1..1
# selftests: intel_pstate: run.sh
# cpupower: error while loading shared libraries: libcpupower.so.0: cannot =
open shared object file: No such file or directory
# ./run.sh: line 90: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
# cpupower: error while loading shared libraries: libcpupower.so.0: cannot =
open shared object file: No such file or directory
# ./run.sh: line 92: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# The marketing frequency of the cpu is 3200 MHz
# The maximum frequency of the cpu is  MHz
# The minimum frequency of the cpu is  MHz
# Target	      Actual	    Difference	  MSR(0x199)	max_perf_pct
ok 1 selftests: intel_pstate: run.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/intel_pst=
ate'
2021-09-10 00:58:59 make -j4 -C ipc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ipc'
gcc -DCONFIG_X86_64 -D__x86_64__ -I../../../../usr/include/    msgque.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac09=
9b78c908e3b619787/tools/testing/selftests/ipc/msgque
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ipc'
2021-09-10 00:58:59 make run_tests -C ipc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ipc'
TAP version 13
1..1
# selftests: ipc: msgque
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ipc: msgque
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ipc'
LKP SKIP ir.ir_loopback_rcmm
2021-09-10 00:58:59 make -j4 -C ir
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ir'
gcc -Wall -O2 -I../../../include/uapi    ir_loopback.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787=
/tools/testing/selftests/ir/ir_loopback
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ir'
2021-09-10 00:59:00 make run_tests -C ir
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ir'
TAP version 13
1..1
# selftests: ir: ir_loopback.sh
# Sending IR on rc0 and receiving IR on rc0.
# Testing protocol rc-5 for decoder rc-5 (1/18)...
# Testing scancode:1f7d
# Testing scancode:1a5c
# Testing scancode:1c02
# Testing scancode:6f
# Testing scancode:424
# Testing scancode:976
# Testing scancode:1c6c
# Testing scancode:621
# Testing scancode:27c
# Testing scancode:51d
# OK
# Testing protocol rc-5x-20 for decoder rc-5 (2/18)...
# Testing scancode:a7238
# Testing scancode:182a19
# Testing scancode:197c10
# Testing scancode:11040a
# Testing scancode:1d4114
# Testing scancode:1d0036
# Testing scancode:2023a
# Testing scancode:64c0a
# Testing scancode:1f1738
# Testing scancode:1b3e3f
# OK
# Testing protocol rc-5-sz for decoder rc-5-sz (3/18)...
# Testing scancode:2da6
# Testing scancode:aa8
# Testing scancode:59d
# Testing scancode:2c0f
# Testing scancode:9ea
# Testing scancode:2eb8
# Testing scancode:2033
# Testing scancode:d54
# Testing scancode:98e
# Testing scancode:347
# OK
# Testing protocol jvc for decoder jvc (4/18)...
# Testing scancode:b9b2
# Testing scancode:f90b
# Testing scancode:5e23
# Testing scancode:1634
# Testing scancode:397a
# Testing scancode:e248
# Testing scancode:202a
# Testing scancode:35e6
# Testing scancode:68e9
# Testing scancode:62a6
# OK
# Testing protocol sony-12 for decoder sony (5/18)...
# Testing scancode:70003
# Testing scancode:140061
# Testing scancode:5007f
# Testing scancode:10014
# Testing scancode:5002b
# Testing scancode:20053
# Testing scancode:1e004a
# Testing scancode:80026
# Testing scancode:9005e
# Testing scancode:1e0002
# OK
# Testing protocol sony-15 for decoder sony (6/18)...
# Testing scancode:c30065
# Testing scancode:3c0004
# Testing scancode:e6002a
# Testing scancode:f00002
# Testing scancode:10013
# Testing scancode:e70014
# Testing scancode:34003a
# Testing scancode:c0046
# Testing scancode:f00069
# Testing scancode:6b0049
# OK
# Testing protocol sony-20 for decoder sony (7/18)...
# Testing scancode:13770d
# Testing scancode:1deb1b
# Testing scancode:15f754
# Testing scancode:15d530
# Testing scancode:4014f
# Testing scancode:2314f
# Testing scancode:18b778
# Testing scancode:f2179
# Testing scancode:156735
# Testing scancode:32061
# OK
# Testing protocol nec for decoder nec (8/18)...
# Testing scancode:8420
# Testing scancode:a2b9
# Testing scancode:fcc3
# Testing scancode:911f
# Testing scancode:da4d
# Testing scancode:dcee
# Testing scancode:5f73
# Testing scancode:9217
# Testing scancode:3f94
# Testing scancode:f9d1
# OK
# Testing protocol nec-x for decoder nec (9/18)...
# Testing scancode:7ae199
# Testing scancode:9e079
# Testing scancode:a9d1d5
# Testing scancode:60fbc3
# Testing scancode:fac6fb
# Testing scancode:ab15e8
# Testing scancode:481fd7
# Testing scancode:2fac36
# Testing scancode:b80a2e
# Testing scancode:385140
# OK
# Testing protocol nec-32 for decoder nec (10/18)...
# Testing scancode:779baaff
# Testing scancode:482b81bb
# Testing scancode:18363c5b
# Testing scancode:3eb1a2d3
# Testing scancode:1781576b
# Testing scancode:643a3daa
# Testing scancode:7e33d422
# Testing scancode:f9a0f64
# Testing scancode:bc95f24
# Testing scancode:6ec93b58
# OK
# Testing protocol sanyo for decoder sanyo (11/18)...
# Testing scancode:1d3045
# Testing scancode:4e344
# Testing scancode:5de11
# Testing scancode:152d08
# Testing scancode:57463
# Testing scancode:3b85e
# Testing scancode:1309f7
# Testing scancode:8d3d6
# Testing scancode:4a75
# Testing scancode:19498b
# OK
# Testing protocol rc-6-0 for decoder rc-6 (12/18)...
# Testing scancode:cda7
# Testing scancode:2c0e
# Testing scancode:2a05
# Testing scancode:9f7c
# Testing scancode:27d1
# Testing scancode:f100
# Testing scancode:b564
# Testing scancode:47a8
# Testing scancode:9d36
# Testing scancode:bf92
# OK
# Testing protocol rc-6-6a-20 for decoder rc-6 (13/18)...
# Testing scancode:c98e9
# Testing scancode:94835
# Testing scancode:e414d
# Testing scancode:2d544
# Testing scancode:aeb09
# Testing scancode:f98b9
# Testing scancode:d12ef
# Testing scancode:ebf2b
# Testing scancode:9a81d
# Testing scancode:67213
# OK
# Testing protocol rc-6-6a-24 for decoder rc-6 (14/18)...
# Testing scancode:97fa83
# Testing scancode:c6d862
# Testing scancode:fb5557
# Testing scancode:3dd894
# Testing scancode:bc056b
# Testing scancode:c0c9ba
# Testing scancode:4190f2
# Testing scancode:8f0f62
# Testing scancode:99d91
# Testing scancode:a1db67
# OK
# Testing protocol rc-6-6a-32 for decoder rc-6 (15/18)...
# Testing scancode:3ba858ed
# Testing scancode:bbf6b38
# Testing scancode:127d0775
# Testing scancode:7fcb82f2
# Testing scancode:1a1f0ab5
# Testing scancode:5eb92f46
# Testing scancode:36e973f3
# Testing scancode:2e29c019
# Testing scancode:623d76ef
# Testing scancode:2e371129
# OK
# Testing protocol rc-6-mce for decoder rc-6 (16/18)...
# Testing scancode:800f7fac
# Testing scancode:800f0fd8
# Testing scancode:800f595f
# Testing scancode:800f40f9
# Testing scancode:800f651c
# Testing scancode:800f4468
# Testing scancode:800f59b2
# Testing scancode:800f780b
# Testing scancode:800f0393
# Testing scancode:800f01cf
# OK
# Testing protocol sharp for decoder sharp (17/18)...
# Testing scancode:a1e
# Testing scancode:1e17
# Testing scancode:1a32
# Testing scancode:1f75
# Testing scancode:16ab
# Testing scancode:1f9d
# Testing scancode:930
# Testing scancode:79e
# Testing scancode:eff
# Testing scancode:6c1
# OK
# Testing protocol imon for decoder imon (18/18)...
# Testing scancode:44434305
# Testing scancode:2e0e47ec
# Testing scancode:799591f9
# Testing scancode:56c04a7b
# Testing scancode:2dd9cadf
# Testing scancode:13b49cae
# Testing scancode:357979c1
# Testing scancode:64c33ed2
# Testing scancode:41de5cc8
# Testing scancode:17b6f0b0
# OK
# # Planned tests !=3D run tests (0 !=3D 180)
# # Totals: pass:180 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ir: ir_loopback.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/ir'
2021-09-10 00:59:10 make -j4 -C kcmp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kcmp'
gcc -I../../../../usr/include/    kcmp_test.c  -o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/te=
sting/selftests/kcmp/kcmp_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kcmp'
2021-09-10 00:59:10 make run_tests -C kcmp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kcmp'
TAP version 13
1..1
# selftests: kcmp: kcmp_test
# pid1:  19283 pid2:  19284 FD:  2 FILES:  1 VM:  2 FS:  1 SIGHAND:  2 IO: =
 0 SYSVSEM:  0 INV: -1
# PASS: 0 returned as expected
# PASS: 0 returned as expected
# PASS: 0 returned as expected
# # Planned tests !=3D run tests (0 !=3D 3)
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# # Planned tests !=3D run tests (0 !=3D 3)
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: kcmp: kcmp_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kcmp'
2021-09-10 00:59:10 make -j4 -C kexec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kexec'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kexec'
2021-09-10 00:59:10 make run_tests -C kexec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kexec'
TAP version 13
1..2
# selftests: kexec: test_kexec_load.sh
# [INFO] kexec_load is enabled
# [INFO] IMA enabled
# [INFO] IMA architecture specific policy enabled
# [INFO] efivars is not mounted on /sys/firmware/efi/efivars
# efi_vars is not enabled
#=20
ok 1 selftests: kexec: test_kexec_load.sh # SKIP
# selftests: kexec: test_kexec_file_load.sh
# [INFO] kexec_file_load is enabled
# [INFO] IMA enabled
# [INFO] architecture specific policy enabled
# [INFO] reading IMA policy permitted
# [INFO] efivars is not mounted on /sys/firmware/efi/efivars
# efi_vars is not enabled
#=20
ok 2 selftests: kexec: test_kexec_file_load.sh # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kexec'
kmod test: not in Makefile
2021-09-10 00:59:10 make TARGETS=3Dkmod
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
2021-09-10 00:59:10 make -j4 -C kmod
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
2021-09-10 00:59:10 make run_tests -C kmod
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
TAP version 13
1..1
# selftests: kmod: kmod.sh
# Fri Sep 10 00:59:11 UTC 2021
# Running test: kmod_test_0001 - run #0
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:11 UTC 2021
# Running test: kmod_test_0001 - run #1
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:11 UTC 2021
# Running test: kmod_test_0001 - run #2
# kmod_test_0001_driver: OK! - loading kmod test
# kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0001_fs: OK! - loading kmod test
# kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:11 UTC 2021
# Running test: kmod_test_0002 - run #0
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:12 UTC 2021
# Running test: kmod_test_0002 - run #1
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:12 UTC 2021
# Running test: kmod_test_0002 - run #2
# kmod_test_0002_driver: OK! - loading kmod test
# kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expect=
ed MODULE_NOT_FOUND
# kmod_test_0002_fs: OK! - loading kmod test
# kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
# Fri Sep 10 00:59:13 UTC 2021
# Running test: kmod_test_0003 - run #0
# kmod_test_0003: OK! - loading kmod test
# kmod_test_0003: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:13 UTC 2021
# Running test: kmod_test_0004 - run #0
# kmod_test_0004: OK! - loading kmod test
# kmod_test_0004: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:14 UTC 2021
# Running test: kmod_test_0005 - run #0
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:14 UTC 2021
# Running test: kmod_test_0005 - run #1
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:15 UTC 2021
# Running test: kmod_test_0005 - run #2
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:15 UTC 2021
# Running test: kmod_test_0005 - run #3
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:16 UTC 2021
# Running test: kmod_test_0005 - run #4
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:16 UTC 2021
# Running test: kmod_test_0005 - run #5
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:17 UTC 2021
# Running test: kmod_test_0005 - run #6
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:17 UTC 2021
# Running test: kmod_test_0005 - run #7
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:18 UTC 2021
# Running test: kmod_test_0005 - run #8
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:18 UTC 2021
# Running test: kmod_test_0005 - run #9
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:19 UTC 2021
# Running test: kmod_test_0006 - run #0
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:22 UTC 2021
# Running test: kmod_test_0006 - run #1
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:23 UTC 2021
# Running test: kmod_test_0006 - run #2
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:25 UTC 2021
# Running test: kmod_test_0006 - run #3
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:26 UTC 2021
# Running test: kmod_test_0006 - run #4
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:28 UTC 2021
# Running test: kmod_test_0006 - run #5
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:30 UTC 2021
# Running test: kmod_test_0006 - run #6
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:32 UTC 2021
# Running test: kmod_test_0006 - run #7
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:33 UTC 2021
# Running test: kmod_test_0006 - run #8
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:36 UTC 2021
# Running test: kmod_test_0006 - run #9
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:37 UTC 2021
# Running test: kmod_test_0007 - run #0
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:39 UTC 2021
# Running test: kmod_test_0007 - run #1
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:41 UTC 2021
# Running test: kmod_test_0007 - run #2
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:43 UTC 2021
# Running test: kmod_test_0007 - run #3
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:45 UTC 2021
# Running test: kmod_test_0007 - run #4
# kmod_test_0005: OK! - loading kmod test
# kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# kmod_test_0006: OK! - loading kmod test
# kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:47 UTC 2021
# Running test: kmod_test_0008 - run #0
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:47 UTC 2021
# Running test: kmod_test_0008 - run #1
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:47 UTC 2021
# Running test: kmod_test_0008 - run #2
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:48 UTC 2021
# Running test: kmod_test_0008 - run #3
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:48 UTC 2021
# Running test: kmod_test_0008 - run #4
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:48 UTC 2021
# Running test: kmod_test_0008 - run #5
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:48 UTC 2021
# Running test: kmod_test_0008 - run #6
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:48 UTC 2021
# Running test: kmod_test_0008 - run #7
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:49 UTC 2021
# Running test: kmod_test_0008 - run #8
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:49 UTC 2021
# Running test: kmod_test_0008 - run #9
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:49 UTC 2021
# Running test: kmod_test_0008 - run #10
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:49 UTC 2021
# Running test: kmod_test_0008 - run #11
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:49 UTC 2021
# Running test: kmod_test_0008 - run #12
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:50 UTC 2021
# Running test: kmod_test_0008 - run #13
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:50 UTC 2021
# Running test: kmod_test_0008 - run #14
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:50 UTC 2021
# Running test: kmod_test_0008 - run #15
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:50 UTC 2021
# Running test: kmod_test_0008 - run #16
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:51 UTC 2021
# Running test: kmod_test_0008 - run #17
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:51 UTC 2021
# Running test: kmod_test_0008 - run #18
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:51 UTC 2021
# Running test: kmod_test_0008 - run #19
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:51 UTC 2021
# Running test: kmod_test_0008 - run #20
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:51 UTC 2021
# Running test: kmod_test_0008 - run #21
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:52 UTC 2021
# Running test: kmod_test_0008 - run #22
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:52 UTC 2021
# Running test: kmod_test_0008 - run #23
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:52 UTC 2021
# Running test: kmod_test_0008 - run #24
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:52 UTC 2021
# Running test: kmod_test_0008 - run #25
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:52 UTC 2021
# Running test: kmod_test_0008 - run #26
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:53 UTC 2021
# Running test: kmod_test_0008 - run #27
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:53 UTC 2021
# Running test: kmod_test_0008 - run #28
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:53 UTC 2021
# Running test: kmod_test_0008 - run #29
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:53 UTC 2021
# Running test: kmod_test_0008 - run #30
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:53 UTC 2021
# Running test: kmod_test_0008 - run #31
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:54 UTC 2021
# Running test: kmod_test_0008 - run #32
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:54 UTC 2021
# Running test: kmod_test_0008 - run #33
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:54 UTC 2021
# Running test: kmod_test_0008 - run #34
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:54 UTC 2021
# Running test: kmod_test_0008 - run #35
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:54 UTC 2021
# Running test: kmod_test_0008 - run #36
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:55 UTC 2021
# Running test: kmod_test_0008 - run #37
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:55 UTC 2021
# Running test: kmod_test_0008 - run #38
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:55 UTC 2021
# Running test: kmod_test_0008 - run #39
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:55 UTC 2021
# Running test: kmod_test_0008 - run #40
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:55 UTC 2021
# Running test: kmod_test_0008 - run #41
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:56 UTC 2021
# Running test: kmod_test_0008 - run #42
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:56 UTC 2021
# Running test: kmod_test_0008 - run #43
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:56 UTC 2021
# Running test: kmod_test_0008 - run #44
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:56 UTC 2021
# Running test: kmod_test_0008 - run #45
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:56 UTC 2021
# Running test: kmod_test_0008 - run #46
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:57 UTC 2021
# Running test: kmod_test_0008 - run #47
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:57 UTC 2021
# Running test: kmod_test_0008 - run #48
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:57 UTC 2021
# Running test: kmod_test_0008 - run #49
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:57 UTC 2021
# Running test: kmod_test_0008 - run #50
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:57 UTC 2021
# Running test: kmod_test_0008 - run #51
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:58 UTC 2021
# Running test: kmod_test_0008 - run #52
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:58 UTC 2021
# Running test: kmod_test_0008 - run #53
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:58 UTC 2021
# Running test: kmod_test_0008 - run #54
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:58 UTC 2021
# Running test: kmod_test_0008 - run #55
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:58 UTC 2021
# Running test: kmod_test_0008 - run #56
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:59 UTC 2021
# Running test: kmod_test_0008 - run #57
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:59 UTC 2021
# Running test: kmod_test_0008 - run #58
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:59 UTC 2021
# Running test: kmod_test_0008 - run #59
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 00:59:59 UTC 2021
# Running test: kmod_test_0008 - run #60
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:00 UTC 2021
# Running test: kmod_test_0008 - run #61
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:00 UTC 2021
# Running test: kmod_test_0008 - run #62
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:00 UTC 2021
# Running test: kmod_test_0008 - run #63
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:00 UTC 2021
# Running test: kmod_test_0008 - run #64
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:00 UTC 2021
# Running test: kmod_test_0008 - run #65
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:01 UTC 2021
# Running test: kmod_test_0008 - run #66
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:01 UTC 2021
# Running test: kmod_test_0008 - run #67
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:01 UTC 2021
# Running test: kmod_test_0008 - run #68
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:01 UTC 2021
# Running test: kmod_test_0008 - run #69
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:01 UTC 2021
# Running test: kmod_test_0008 - run #70
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:02 UTC 2021
# Running test: kmod_test_0008 - run #71
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:02 UTC 2021
# Running test: kmod_test_0008 - run #72
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:02 UTC 2021
# Running test: kmod_test_0008 - run #73
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:02 UTC 2021
# Running test: kmod_test_0008 - run #74
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:02 UTC 2021
# Running test: kmod_test_0008 - run #75
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:03 UTC 2021
# Running test: kmod_test_0008 - run #76
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:03 UTC 2021
# Running test: kmod_test_0008 - run #77
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:03 UTC 2021
# Running test: kmod_test_0008 - run #78
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:03 UTC 2021
# Running test: kmod_test_0008 - run #79
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:03 UTC 2021
# Running test: kmod_test_0008 - run #80
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:04 UTC 2021
# Running test: kmod_test_0008 - run #81
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:04 UTC 2021
# Running test: kmod_test_0008 - run #82
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:04 UTC 2021
# Running test: kmod_test_0008 - run #83
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:04 UTC 2021
# Running test: kmod_test_0008 - run #84
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:04 UTC 2021
# Running test: kmod_test_0008 - run #85
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:05 UTC 2021
# Running test: kmod_test_0008 - run #86
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:05 UTC 2021
# Running test: kmod_test_0008 - run #87
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:05 UTC 2021
# Running test: kmod_test_0008 - run #88
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:05 UTC 2021
# Running test: kmod_test_0008 - run #89
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:05 UTC 2021
# Running test: kmod_test_0008 - run #90
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:06 UTC 2021
# Running test: kmod_test_0008 - run #91
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:06 UTC 2021
# Running test: kmod_test_0008 - run #92
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:06 UTC 2021
# Running test: kmod_test_0008 - run #93
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:06 UTC 2021
# Running test: kmod_test_0008 - run #94
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:06 UTC 2021
# Running test: kmod_test_0008 - run #95
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:07 UTC 2021
# Running test: kmod_test_0008 - run #96
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:07 UTC 2021
# Running test: kmod_test_0008 - run #97
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:07 UTC 2021
# Running test: kmod_test_0008 - run #98
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:07 UTC 2021
# Running test: kmod_test_0008 - run #99
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:07 UTC 2021
# Running test: kmod_test_0008 - run #100
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:08 UTC 2021
# Running test: kmod_test_0008 - run #101
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:08 UTC 2021
# Running test: kmod_test_0008 - run #102
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:08 UTC 2021
# Running test: kmod_test_0008 - run #103
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:08 UTC 2021
# Running test: kmod_test_0008 - run #104
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:09 UTC 2021
# Running test: kmod_test_0008 - run #105
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:09 UTC 2021
# Running test: kmod_test_0008 - run #106
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:09 UTC 2021
# Running test: kmod_test_0008 - run #107
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:09 UTC 2021
# Running test: kmod_test_0008 - run #108
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:09 UTC 2021
# Running test: kmod_test_0008 - run #109
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:10 UTC 2021
# Running test: kmod_test_0008 - run #110
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:10 UTC 2021
# Running test: kmod_test_0008 - run #111
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:10 UTC 2021
# Running test: kmod_test_0008 - run #112
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:10 UTC 2021
# Running test: kmod_test_0008 - run #113
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:10 UTC 2021
# Running test: kmod_test_0008 - run #114
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:11 UTC 2021
# Running test: kmod_test_0008 - run #115
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:11 UTC 2021
# Running test: kmod_test_0008 - run #116
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:11 UTC 2021
# Running test: kmod_test_0008 - run #117
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:11 UTC 2021
# Running test: kmod_test_0008 - run #118
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:11 UTC 2021
# Running test: kmod_test_0008 - run #119
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:12 UTC 2021
# Running test: kmod_test_0008 - run #120
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:12 UTC 2021
# Running test: kmod_test_0008 - run #121
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:12 UTC 2021
# Running test: kmod_test_0008 - run #122
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:12 UTC 2021
# Running test: kmod_test_0008 - run #123
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:12 UTC 2021
# Running test: kmod_test_0008 - run #124
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:13 UTC 2021
# Running test: kmod_test_0008 - run #125
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:13 UTC 2021
# Running test: kmod_test_0008 - run #126
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:13 UTC 2021
# Running test: kmod_test_0008 - run #127
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:13 UTC 2021
# Running test: kmod_test_0008 - run #128
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:13 UTC 2021
# Running test: kmod_test_0008 - run #129
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:14 UTC 2021
# Running test: kmod_test_0008 - run #130
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:14 UTC 2021
# Running test: kmod_test_0008 - run #131
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:14 UTC 2021
# Running test: kmod_test_0008 - run #132
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:14 UTC 2021
# Running test: kmod_test_0008 - run #133
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:14 UTC 2021
# Running test: kmod_test_0008 - run #134
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:15 UTC 2021
# Running test: kmod_test_0008 - run #135
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:15 UTC 2021
# Running test: kmod_test_0008 - run #136
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:15 UTC 2021
# Running test: kmod_test_0008 - run #137
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:15 UTC 2021
# Running test: kmod_test_0008 - run #138
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:15 UTC 2021
# Running test: kmod_test_0008 - run #139
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:16 UTC 2021
# Running test: kmod_test_0008 - run #140
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:16 UTC 2021
# Running test: kmod_test_0008 - run #141
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:16 UTC 2021
# Running test: kmod_test_0008 - run #142
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:16 UTC 2021
# Running test: kmod_test_0008 - run #143
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:16 UTC 2021
# Running test: kmod_test_0008 - run #144
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:17 UTC 2021
# Running test: kmod_test_0008 - run #145
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:17 UTC 2021
# Running test: kmod_test_0008 - run #146
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:17 UTC 2021
# Running test: kmod_test_0008 - run #147
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:17 UTC 2021
# Running test: kmod_test_0008 - run #148
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:18 UTC 2021
# Running test: kmod_test_0008 - run #149
# kmod_test_0008: OK! - loading kmod test
# kmod_test_0008: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:18 UTC 2021
# Running test: kmod_test_0009 - run #0
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:19 UTC 2021
# Running test: kmod_test_0009 - run #1
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:20 UTC 2021
# Running test: kmod_test_0009 - run #2
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:21 UTC 2021
# Running test: kmod_test_0009 - run #3
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:22 UTC 2021
# Running test: kmod_test_0009 - run #4
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:23 UTC 2021
# Running test: kmod_test_0009 - run #5
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:24 UTC 2021
# Running test: kmod_test_0009 - run #6
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:25 UTC 2021
# Running test: kmod_test_0009 - run #7
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:26 UTC 2021
# Running test: kmod_test_0009 - run #8
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:27 UTC 2021
# Running test: kmod_test_0009 - run #9
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:28 UTC 2021
# Running test: kmod_test_0009 - run #10
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:29 UTC 2021
# Running test: kmod_test_0009 - run #11
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:30 UTC 2021
# Running test: kmod_test_0009 - run #12
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:31 UTC 2021
# Running test: kmod_test_0009 - run #13
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:32 UTC 2021
# Running test: kmod_test_0009 - run #14
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:33 UTC 2021
# Running test: kmod_test_0009 - run #15
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:34 UTC 2021
# Running test: kmod_test_0009 - run #16
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:35 UTC 2021
# Running test: kmod_test_0009 - run #17
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:36 UTC 2021
# Running test: kmod_test_0009 - run #18
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:37 UTC 2021
# Running test: kmod_test_0009 - run #19
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:38 UTC 2021
# Running test: kmod_test_0009 - run #20
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:39 UTC 2021
# Running test: kmod_test_0009 - run #21
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:40 UTC 2021
# Running test: kmod_test_0009 - run #22
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:41 UTC 2021
# Running test: kmod_test_0009 - run #23
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:42 UTC 2021
# Running test: kmod_test_0009 - run #24
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:43 UTC 2021
# Running test: kmod_test_0009 - run #25
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:44 UTC 2021
# Running test: kmod_test_0009 - run #26
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:45 UTC 2021
# Running test: kmod_test_0009 - run #27
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:46 UTC 2021
# Running test: kmod_test_0009 - run #28
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:47 UTC 2021
# Running test: kmod_test_0009 - run #29
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:48 UTC 2021
# Running test: kmod_test_0009 - run #30
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:49 UTC 2021
# Running test: kmod_test_0009 - run #31
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:50 UTC 2021
# Running test: kmod_test_0009 - run #32
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:51 UTC 2021
# Running test: kmod_test_0009 - run #33
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:52 UTC 2021
# Running test: kmod_test_0009 - run #34
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:53 UTC 2021
# Running test: kmod_test_0009 - run #35
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:54 UTC 2021
# Running test: kmod_test_0009 - run #36
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:55 UTC 2021
# Running test: kmod_test_0009 - run #37
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:56 UTC 2021
# Running test: kmod_test_0009 - run #38
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:57 UTC 2021
# Running test: kmod_test_0009 - run #39
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:58 UTC 2021
# Running test: kmod_test_0009 - run #40
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:00:59 UTC 2021
# Running test: kmod_test_0009 - run #41
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:00 UTC 2021
# Running test: kmod_test_0009 - run #42
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:01 UTC 2021
# Running test: kmod_test_0009 - run #43
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:02 UTC 2021
# Running test: kmod_test_0009 - run #44
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:03 UTC 2021
# Running test: kmod_test_0009 - run #45
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:04 UTC 2021
# Running test: kmod_test_0009 - run #46
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:05 UTC 2021
# Running test: kmod_test_0009 - run #47
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:07 UTC 2021
# Running test: kmod_test_0009 - run #48
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:08 UTC 2021
# Running test: kmod_test_0009 - run #49
# kmod_test_0009: OK! - loading kmod test
# kmod_test_0009: OK! - Return value: 0 (SUCCESS), expected SUCCESS
# Fri Sep 10 01:01:09 UTC 2021
# Running test: kmod_test_0010 - run #0
# kmod_test_0010: OK! - loading kmod test
# kmod_test_0010: OK! - Return value: -2 (-ENOENT), expected -ENOENT
# Fri Sep 10 01:01:09 UTC 2021
# Running test: kmod_test_0011 - run #0
# kmod_test_0011: OK! - loading kmod test
# kmod_test_0011: OK! - Return value: -2 (-ENOENT), expected -ENOENT
# Fri Sep 10 01:01:09 UTC 2021
# Running test: kmod_test_0012 - run #0
# kmod_check_visibility: OK!
# Fri Sep 10 01:01:09 UTC 2021
# Running test: kmod_test_0013 - run #0
# kmod_check_visibility: OK!
# Test completed
ok 1 selftests: kmod: kmod.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/kmod'
locking test: not in Makefile
2021-09-10 01:01:09 make TARGETS=3Dlocking
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/locki=
ng'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/lockin=
g'
2021-09-10 01:01:09 make -j4 -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/locking'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/locking'
2021-09-10 01:01:09 make run_tests -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/locking'
TAP version 13
1..1
# selftests: locking: ww_mutex.sh
# locking/ww_mutex: ok
ok 1 selftests: locking: ww_mutex.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/locking'

--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/kernel-selftests.yaml:
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-8.3-kselftests
need_memory: 2G
need_cpu: 2
kernel-selftests:
  group: group-01
kernel_cmdline: kvm-intel.unrestricted_guest=0
job_origin: kernel-selftests.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d05
tbox_group: lkp-skl-d05
submit_id: 6139c927097d9b649b0c9419
job_file: "/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-01-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d7109fe3a0991a0f7b4ac099b78c908e3b619787-20210909-25755-188qwdl-0.yaml"
id: 7694f414fe821d8ea1a679fa5200c27f921cb6a5
queuer_version: "/lkp-src"
:#! hosts/lkp-skl-d05:
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
:#! include/category/functional:
kmsg:
heartbeat:
meminfo:
:#! include/queue/cyclic:
commit: d7109fe3a0991a0f7b4ac099b78c908e3b619787
:#! include/testbox/lkp-skl-d05:
need_kconfig_hw:
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xe2'
:#! include/kernel-selftests:
need_kconfig:
- BTRFS_FS: m
- CHECKPOINT_RESTORE: y
- DRM_DEBUG_SELFTEST: m, v4.18-rc1
- EFIVAR_FS: y
- EMBEDDED: y
- EXPERT: y
- FTRACE: y
- FUNCTION_PROFILER: y
- GPIOLIB: y
- GPIO_MOCKUP: v4.9-rc1
- HIST_TRIGGERS: y, v4.7-rc1
- IMA_APPRAISE: y
- IMA_ARCH_POLICY: y, v5.0-rc1
- IRQSOFF_TRACER: y
- IR_IMON_DECODER: m, v4.17-rc1
- IR_SHARP_DECODER: m
- KALLSYMS_ALL: y
- KPROBES: y
- LIRC: y
- LKDTM: y
- MODULES: y
- MODULE_UNLOAD: y
- NOTIFIER_ERROR_INJECTION: y
- PREEMPT: y
- PREEMPTIRQ_DELAY_TEST: m, v5.6-rc1
- PREEMPT_TRACER: y
- SAMPLES: y
- SAMPLE_FTRACE_DIRECT: m, v5.5-rc1
- SAMPLE_TRACE_PRINTK: m
- SCHED_TRACER: y
- SECURITYFS: y
- STACK_TRACER: y
- TEST_BITMAP
- TEST_KMOD: m, v4.13-rc1
- TEST_LKM: m
- TEST_PRINTF
- TEST_STRSCPY: m, v5.2-rc1
- TRACER_SNAPSHOT: y
- TUN: m
- WW_MUTEX_SELFTEST: m, v4.11-rc1
- XFS_FS: m
- DMA_MAP_BENCHMARK: y, v5.11-rc1
initrds:
- linux_headers
- linux_selftests
enqueue_time: 2021-09-09 16:43:19.572349113 +08:00
_id: 6139c927097d9b649b0c9419
_rt: "/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 29414d6e109d1dd7d5c7002a4078b26f08a79c1a
base_commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
branch: linux-devel/devel-hourly-20210904-000148
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/0"
scheduler_version: "/lkp/lkp/.src-20210909-145711"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-01-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d7109fe3a0991a0f7b4ac099b78c908e3b619787-20210909-25755-188qwdl-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- branch=linux-devel/devel-hourly-20210904-000148
- commit=d7109fe3a0991a0f7b4ac099b78c908e3b619787
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/vmlinuz-5.14.0-gd7109fe3a099
- kvm-intel.unrestricted_guest=0
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/group-01-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210907.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-d0cba0d1-1_20210907.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210903-234613/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.13.0
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7109fe3a0991a0f7b4ac099b78c908e3b619787/vmlinuz-5.14.0-gd7109fe3a099"
dequeue_time: 2021-09-09 17:24:25.043377601 +08:00
:#! /lkp/lkp/.src-20210909-145711/include/site/inn:
job_state: finished
loadavg: 11.72 4.44 1.75 1/174 29830
start_time: '1631179575'
end_time: '1631180034'
version: "/lkp/lkp/.src-20210909-145748:10c349e1:15e9f8709"

--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

ln -sf /usr/bin/clang
ln -sf /usr/bin/llc
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -j4 -C capabilities
make run_tests -C capabilities
make -j4 -C clone3
make run_tests -C clone3
make -j4 -C core
make run_tests -C core
make -j4 -C cpu-hotplug
make run_tests -C cpu-hotplug
make TARGETS=dma
make -j4 -C dma
make run_tests -C dma
make TARGETS=dmabuf-heaps
make -j4 -C dmabuf-heaps
make run_tests -C dmabuf-heaps
touch ./exec/pipe
make -j4 -C exec
make run_tests -C exec
make -j4 -C fpu
make run_tests -C fpu
make -j4 -C ftrace
make run_tests -C ftrace
make -j4 -C futex
make run_tests -C futex
make -C ../../../tools/gpio
make -j4 -C gpio
make run_tests -C gpio
make TARGETS=ia64
make -j4 -C ia64
make run_tests -C ia64
make -j4 -C intel_pstate
make run_tests -C intel_pstate
make -j4 -C ipc
make run_tests -C ipc
make -j4 -C ir
make run_tests -C ir
make -j4 -C kcmp
make run_tests -C kcmp
make -j4 -C kexec
make run_tests -C kexec
make TARGETS=kmod
make -j4 -C kmod
make run_tests -C kmod
make TARGETS=locking
make -j4 -C locking
make run_tests -C locking

--lIrNkN/7tmsD/ALM--
