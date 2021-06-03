Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C979A3997DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhFCCHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:07:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:60672 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFCCHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:07:31 -0400
IronPort-SDR: WkvYzAXTLhVVrX4npJjqbaSBBkOZgZQOOPS6vajJhGSOT/eYzFyy5kk3ipHdcA6V+P6gyvqVtm
 MEb1RAMz/c3A==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="200930284"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="xz'?yaml'?scan'208";a="200930284"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:05:46 -0700
IronPort-SDR: mfrZn2d95SI2qW40DBAfysrnoHc/XDBmqUbcmuTUWjXw3P5ZDxxvqrThX4SFmFEm6bnPDOZELP
 VyoU1hUlj4zQ==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="xz'?yaml'?scan'208";a="447655476"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:05:42 -0700
Date:   Thu, 3 Jun 2021 10:22:16 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     0day robot <lkp@intel.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        shuah@kernel.org, peterz@infradead.org, luto@kernel.org,
        linux-kselftest@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [selftest]  51001dc340: kernel-selftests.soft-dirty.make_fail
Message-ID: <20210603022216.GB21290@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210528181413.2795332-1-krisman@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 51001dc3401827a612f986357b9bbc69bad17c1d ("[PATCH] selftest: Add test for Soft-Dirty PTE bit")
url: https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/selftest-Add-test-for-Soft-Dirty-PTE-bit/20210529-021608
base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next

in testcase: kernel-selftests
version: kernel-selftests-x86_64-0d95472a-1_20210507
with following parameters:

	group: group-s
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-51001dc3401827a612f986357b9bbc69bad17c1d
2021-05-29 14:16:07 ln -sf /usr/bin/clang
2021-05-29 14:16:07 ln -sf /usr/bin/llc
2021-05-29 14:16:08 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2021-05-29 14:16:08 sed -i s/default_timeout=45/default_timeout=300/ /kselftests/kselftest/runner.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:16:08 /kselftests/run_kselftest.sh -c safesetid
TAP version 13
1..1
# selftests: safesetid: safesetid-test.sh
# mounting securityfs failed
# safesetid-test.sh: done
ok 1 selftests: safesetid: safesetid-test.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:16:08 /kselftests/run_kselftest.sh -c seccomp
TAP version 13
1..2
# selftests: seccomp: seccomp_bpf
# TAP version 13
# 1..87
# # Starting 87 tests from 7 test cases.
# #  RUN           global.kcmp ...
# #            OK  global.kcmp
# ok 1 global.kcmp
# #  RUN           global.mode_strict_support ...
# #            OK  global.mode_strict_support
# ok 2 global.mode_strict_support
# #  RUN           global.mode_strict_cannot_call_prctl ...
# #            OK  global.mode_strict_cannot_call_prctl
# ok 3 global.mode_strict_cannot_call_prctl
# #  RUN           global.no_new_privs_support ...
# #            OK  global.no_new_privs_support
# ok 4 global.no_new_privs_support
# #  RUN           global.mode_filter_support ...
# #            OK  global.mode_filter_support
# ok 5 global.mode_filter_support
# #  RUN           global.mode_filter_without_nnp ...
# #            OK  global.mode_filter_without_nnp
# ok 6 global.mode_filter_without_nnp
# #  RUN           global.filter_size_limits ...
# #            OK  global.filter_size_limits
# ok 7 global.filter_size_limits
# #  RUN           global.filter_chain_limits ...
# #            OK  global.filter_chain_limits
# ok 8 global.filter_chain_limits
# #  RUN           global.mode_filter_cannot_move_to_strict ...
# #            OK  global.mode_filter_cannot_move_to_strict
# ok 9 global.mode_filter_cannot_move_to_strict
# #  RUN           global.mode_filter_get_seccomp ...
# #            OK  global.mode_filter_get_seccomp
# ok 10 global.mode_filter_get_seccomp
# #  RUN           global.ALLOW_all ...
# #            OK  global.ALLOW_all
# ok 11 global.ALLOW_all
# #  RUN           global.empty_prog ...
# #            OK  global.empty_prog
# ok 12 global.empty_prog
# #  RUN           global.log_all ...
# #            OK  global.log_all
# ok 13 global.log_all
# #  RUN           global.unknown_ret_is_kill_inside ...
# #            OK  global.unknown_ret_is_kill_inside
# ok 14 global.unknown_ret_is_kill_inside
# #  RUN           global.unknown_ret_is_kill_above_allow ...
# #            OK  global.unknown_ret_is_kill_above_allow
# ok 15 global.unknown_ret_is_kill_above_allow
# #  RUN           global.KILL_all ...
# #            OK  global.KILL_all
# ok 16 global.KILL_all
# #  RUN           global.KILL_one ...
# #            OK  global.KILL_one
# ok 17 global.KILL_one
# #  RUN           global.KILL_one_arg_one ...
# #            OK  global.KILL_one_arg_one
# ok 18 global.KILL_one_arg_one
# #  RUN           global.KILL_one_arg_six ...
# #            OK  global.KILL_one_arg_six
# ok 19 global.KILL_one_arg_six
# #  RUN           global.KILL_thread ...
# #            OK  global.KILL_thread
# ok 20 global.KILL_thread
# #  RUN           global.KILL_process ...
# #            OK  global.KILL_process
# ok 21 global.KILL_process
# #  RUN           global.KILL_unknown ...
# #            OK  global.KILL_unknown
# ok 22 global.KILL_unknown
# #  RUN           global.arg_out_of_range ...
# #            OK  global.arg_out_of_range
# ok 23 global.arg_out_of_range
# #  RUN           global.ERRNO_valid ...
# #            OK  global.ERRNO_valid
# ok 24 global.ERRNO_valid
# #  RUN           global.ERRNO_zero ...
# #            OK  global.ERRNO_zero
# ok 25 global.ERRNO_zero
# #  RUN           global.ERRNO_capped ...
# #            OK  global.ERRNO_capped
# ok 26 global.ERRNO_capped
# #  RUN           global.ERRNO_order ...
# #            OK  global.ERRNO_order
# ok 27 global.ERRNO_order
# #  RUN           global.negative_ENOSYS ...
# #            OK  global.negative_ENOSYS
# ok 28 global.negative_ENOSYS
# #  RUN           global.seccomp_syscall ...
# #            OK  global.seccomp_syscall
# ok 29 global.seccomp_syscall
# #  RUN           global.seccomp_syscall_mode_lock ...
# #            OK  global.seccomp_syscall_mode_lock
# ok 30 global.seccomp_syscall_mode_lock
# #  RUN           global.detect_seccomp_filter_flags ...
# #            OK  global.detect_seccomp_filter_flags
# ok 31 global.detect_seccomp_filter_flags
# #  RUN           global.TSYNC_first ...
# #            OK  global.TSYNC_first
# ok 32 global.TSYNC_first
# #  RUN           global.syscall_restart ...
# #            OK  global.syscall_restart
# ok 33 global.syscall_restart
# #  RUN           global.filter_flag_log ...
# #            OK  global.filter_flag_log
# ok 34 global.filter_flag_log
# #  RUN           global.get_action_avail ...
# #            OK  global.get_action_avail
# ok 35 global.get_action_avail
# #  RUN           global.get_metadata ...
# #            OK  global.get_metadata
# ok 36 global.get_metadata
# #  RUN           global.user_notification_basic ...
# #            OK  global.user_notification_basic
# ok 37 global.user_notification_basic
# #  RUN           global.user_notification_with_tsync ...
# #            OK  global.user_notification_with_tsync
# ok 38 global.user_notification_with_tsync
# #  RUN           global.user_notification_kill_in_middle ...
# #            OK  global.user_notification_kill_in_middle
# ok 39 global.user_notification_kill_in_middle
# #  RUN           global.user_notification_signal ...
# #            OK  global.user_notification_signal
# ok 40 global.user_notification_signal
# #  RUN           global.user_notification_closed_listener ...
# #            OK  global.user_notification_closed_listener
# ok 41 global.user_notification_closed_listener
# #  RUN           global.user_notification_child_pid_ns ...
# #            OK  global.user_notification_child_pid_ns
# ok 42 global.user_notification_child_pid_ns
# #  RUN           global.user_notification_sibling_pid_ns ...
# #            OK  global.user_notification_sibling_pid_ns
# ok 43 global.user_notification_sibling_pid_ns
# #  RUN           global.user_notification_fault_recv ...
# #            OK  global.user_notification_fault_recv
# ok 44 global.user_notification_fault_recv
# #  RUN           global.seccomp_get_notif_sizes ...
# #            OK  global.seccomp_get_notif_sizes
# ok 45 global.seccomp_get_notif_sizes
# #  RUN           global.user_notification_continue ...
# #            OK  global.user_notification_continue
# ok 46 global.user_notification_continue
# #  RUN           global.user_notification_filter_empty ...
# #            OK  global.user_notification_filter_empty
# ok 47 global.user_notification_filter_empty
# #  RUN           global.user_notification_filter_empty_threaded ...
# #            OK  global.user_notification_filter_empty_threaded
# ok 48 global.user_notification_filter_empty_threaded
# #  RUN           global.user_notification_addfd ...
# #            OK  global.user_notification_addfd
# ok 49 global.user_notification_addfd
# #  RUN           global.user_notification_addfd_rlimit ...
# #            OK  global.user_notification_addfd_rlimit
# ok 50 global.user_notification_addfd_rlimit
# #  RUN           TRAP.dfl ...
# #            OK  TRAP.dfl
# ok 51 TRAP.dfl
# #  RUN           TRAP.ign ...
# #            OK  TRAP.ign
# ok 52 TRAP.ign
# #  RUN           TRAP.handler ...
# #            OK  TRAP.handler
# ok 53 TRAP.handler
# #  RUN           precedence.allow_ok ...
# #            OK  precedence.allow_ok
# ok 54 precedence.allow_ok
# #  RUN           precedence.kill_is_highest ...
# #            OK  precedence.kill_is_highest
# ok 55 precedence.kill_is_highest
# #  RUN           precedence.kill_is_highest_in_any_order ...
# #            OK  precedence.kill_is_highest_in_any_order
# ok 56 precedence.kill_is_highest_in_any_order
# #  RUN           precedence.trap_is_second ...
# #            OK  precedence.trap_is_second
# ok 57 precedence.trap_is_second
# #  RUN           precedence.trap_is_second_in_any_order ...
# #            OK  precedence.trap_is_second_in_any_order
# ok 58 precedence.trap_is_second_in_any_order
# #  RUN           precedence.errno_is_third ...
# #            OK  precedence.errno_is_third
# ok 59 precedence.errno_is_third
# #  RUN           precedence.errno_is_third_in_any_order ...
# #            OK  precedence.errno_is_third_in_any_order
# ok 60 precedence.errno_is_third_in_any_order
# #  RUN           precedence.trace_is_fourth ...
# #            OK  precedence.trace_is_fourth
# ok 61 precedence.trace_is_fourth
# #  RUN           precedence.trace_is_fourth_in_any_order ...
# #            OK  precedence.trace_is_fourth_in_any_order
# ok 62 precedence.trace_is_fourth_in_any_order
# #  RUN           precedence.log_is_fifth ...
# #            OK  precedence.log_is_fifth
# ok 63 precedence.log_is_fifth
# #  RUN           precedence.log_is_fifth_in_any_order ...
# #            OK  precedence.log_is_fifth_in_any_order
# ok 64 precedence.log_is_fifth_in_any_order
# #  RUN           TRACE_poke.read_has_side_effects ...
# #            OK  TRACE_poke.read_has_side_effects
# ok 65 TRACE_poke.read_has_side_effects
# #  RUN           TRACE_poke.getpid_runs_normally ...
# #            OK  TRACE_poke.getpid_runs_normally
# ok 66 TRACE_poke.getpid_runs_normally
# #  RUN           TRACE_syscall.ptrace.negative_ENOSYS ...
# #            OK  TRACE_syscall.ptrace.negative_ENOSYS
# ok 67 TRACE_syscall.ptrace.negative_ENOSYS
# #  RUN           TRACE_syscall.ptrace.syscall_allowed ...
# #            OK  TRACE_syscall.ptrace.syscall_allowed
# ok 68 TRACE_syscall.ptrace.syscall_allowed
# #  RUN           TRACE_syscall.ptrace.syscall_redirected ...
# #            OK  TRACE_syscall.ptrace.syscall_redirected
# ok 69 TRACE_syscall.ptrace.syscall_redirected
# #  RUN           TRACE_syscall.ptrace.syscall_errno ...
# #            OK  TRACE_syscall.ptrace.syscall_errno
# ok 70 TRACE_syscall.ptrace.syscall_errno
# #  RUN           TRACE_syscall.ptrace.syscall_faked ...
# #            OK  TRACE_syscall.ptrace.syscall_faked
# ok 71 TRACE_syscall.ptrace.syscall_faked
# #  RUN           TRACE_syscall.ptrace.skip_after ...
# #            OK  TRACE_syscall.ptrace.skip_after
# ok 72 TRACE_syscall.ptrace.skip_after
# #  RUN           TRACE_syscall.ptrace.kill_after ...
# #            OK  TRACE_syscall.ptrace.kill_after
# ok 73 TRACE_syscall.ptrace.kill_after
# #  RUN           TRACE_syscall.seccomp.negative_ENOSYS ...
# #            OK  TRACE_syscall.seccomp.negative_ENOSYS
# ok 74 TRACE_syscall.seccomp.negative_ENOSYS
# #  RUN           TRACE_syscall.seccomp.syscall_allowed ...
# #            OK  TRACE_syscall.seccomp.syscall_allowed
# ok 75 TRACE_syscall.seccomp.syscall_allowed
# #  RUN           TRACE_syscall.seccomp.syscall_redirected ...
# #            OK  TRACE_syscall.seccomp.syscall_redirected
# ok 76 TRACE_syscall.seccomp.syscall_redirected
# #  RUN           TRACE_syscall.seccomp.syscall_errno ...
# #            OK  TRACE_syscall.seccomp.syscall_errno
# ok 77 TRACE_syscall.seccomp.syscall_errno
# #  RUN           TRACE_syscall.seccomp.syscall_faked ...
# #            OK  TRACE_syscall.seccomp.syscall_faked
# ok 78 TRACE_syscall.seccomp.syscall_faked
# #  RUN           TRACE_syscall.seccomp.skip_after ...
# #            OK  TRACE_syscall.seccomp.skip_after
# ok 79 TRACE_syscall.seccomp.skip_after
# #  RUN           TRACE_syscall.seccomp.kill_after ...
# #            OK  TRACE_syscall.seccomp.kill_after
# ok 80 TRACE_syscall.seccomp.kill_after
# #  RUN           TSYNC.siblings_fail_prctl ...
# #            OK  TSYNC.siblings_fail_prctl
# ok 81 TSYNC.siblings_fail_prctl
# #  RUN           TSYNC.two_siblings_with_ancestor ...
# #            OK  TSYNC.two_siblings_with_ancestor
# ok 82 TSYNC.two_siblings_with_ancestor
# #  RUN           TSYNC.two_sibling_want_nnp ...
# #            OK  TSYNC.two_sibling_want_nnp
# ok 83 TSYNC.two_sibling_want_nnp
# #  RUN           TSYNC.two_siblings_with_no_filter ...
# #            OK  TSYNC.two_siblings_with_no_filter
# ok 84 TSYNC.two_siblings_with_no_filter
# #  RUN           TSYNC.two_siblings_with_one_divergence ...
# #            OK  TSYNC.two_siblings_with_one_divergence
# ok 85 TSYNC.two_siblings_with_one_divergence
# #  RUN           TSYNC.two_siblings_with_one_divergence_no_tid_in_err ...
# #            OK  TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# ok 86 TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# #  RUN           TSYNC.two_siblings_not_under_filter ...
# #            OK  TSYNC.two_siblings_not_under_filter
# ok 87 TSYNC.two_siblings_not_under_filter
# # PASSED: 87 / 87 tests passed.
# # Totals: pass:87 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: seccomp: seccomp_bpf
# selftests: seccomp: seccomp_benchmark
# net.core.bpf_jit_enable = 1
# net.core.bpf_jit_harden = 0
# Current BPF sysctl settings:
# Calibrating sample size for 15 seconds worth of syscalls ...
# Benchmarking 18250590 syscalls...
# 15.671098000 - 1.000871323 = 14670226677 (14.7s)
# getpid native: 803 ns
# 30.660267505 - 15.671370913 = 14988896592 (15.0s)
# getpid RET_ALLOW 1 filter (bitmap): 821 ns
# 45.403350482 - 30.660471377 = 14742879105 (14.7s)
# getpid RET_ALLOW 2 filters (bitmap): 807 ns
# 62.521709238 - 45.403552362 = 17118156876 (17.1s)
# getpid RET_ALLOW 3 filters (full): 937 ns
# 79.152560752 - 62.521923393 = 16630637359 (16.6s)
# getpid RET_ALLOW 4 filters (full): 911 ns
# Estimated total seccomp overhead for 1 bitmapped filter: 18 ns
# Estimated total seccomp overhead for 2 bitmapped filters: 4 ns
# Estimated total seccomp overhead for 3 full filters: 134 ns
# Estimated total seccomp overhead for 4 full filters: 108 ns
# Estimated seccomp entry overhead: 32 ns
# Estimated seccomp per-filter overhead (last 2 diff): 18446744073709551590 ns
# Saw unexpected benchmark result. Try running again with more samples?
ok 2 selftests: seccomp: seccomp_benchmark
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:29 /kselftests/run_kselftest.sh -c sigaltstack
TAP version 13
1..1
# selftests: sigaltstack: sas
# TAP version 13
# 1..3
# ok 1 Initial sigaltstack state was SS_DISABLE
# # [RUN]	signal USR1
# ok 2 sigaltstack is disabled in sighandler
# # [RUN]	switched to user ctx
# # [RUN]	signal USR2
# # [OK]	Stack preserved
# ok 3 sigaltstack is still SS_AUTODISARM after signal
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sigaltstack: sas
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:29 /kselftests/run_kselftest.sh -c size
TAP version 13
1..1
# selftests: size: get_size
# TAP version 13
# # Testing system size.
# ok 1 get runtime memory use
# # System runtime memory report (units in Kilobytes):
#  ---
#  Total:  32738052
#  Free:   29397508
#  Buffer: 12
#  In use: 3340532
#  ...
# 1..1
ok 1 selftests: size: get_size
LKP WARN miss target soft-dirty
2021-05-29 14:17:29 make run_tests -C soft-dirty
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-51001dc3401827a612f986357b9bbc69bad17c1d/tools/testing/selftests/soft-dirty'
gcc -Wall -I../../../../usr/include/ -O0 -g3    soft-dirty.c  -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-51001dc3401827a612f986357b9bbc69bad17c1d/tools/testing/selftests/soft-dirty/soft-dirty
soft-dirty.c: In function ‘touch_page’:
soft-dirty.c:41:7: error: ‘page_size’ undeclared (first use in this function); did you mean ‘pagesize’?
  map[(page_size * n) + 1]++;
       ^~~~~~~~~
       pagesize
soft-dirty.c:41:7: note: each undeclared identifier is reported only once for each function it appears in
soft-dirty.c: In function ‘test_simple’:
soft-dirty.c:70:22: error: ‘page_size’ undeclared (first use in this function); did you mean ‘pagesize’?
  map = aligned_alloc(page_size, mmap_size);
                      ^~~~~~~~~
                      pagesize
soft-dirty.c: In function ‘main’:
soft-dirty.c:247:19: error: called object ‘pagesize’ is not a function or function pointer
  mmap_size = 10 * pagesize();
                   ^~~~~~~~
soft-dirty.c:30:5: note: declared here
 int pagesize;
     ^~~~~~~~
make: *** [../lib.mk:144: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-51001dc3401827a612f986357b9bbc69bad17c1d/tools/testing/selftests/soft-dirty/soft-dirty] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-51001dc3401827a612f986357b9bbc69bad17c1d/tools/testing/selftests/soft-dirty'
LKP SKIP sparc64
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:29 /kselftests/run_kselftest.sh -c splice
TAP version 13
1..2
# selftests: splice: default_file_splice_read.sh
ok 1 selftests: splice: default_file_splice_read.sh
# selftests: splice: short_splice_read.sh
# splice: Invalid argument
# FAIL: /proc/1957/limits 4096
# splice: Invalid argument
# FAIL: /proc/1957/limits 2
# splice: Invalid argument
# FAIL: /proc/1957/comm 4096
# splice: Invalid argument
# FAIL: /proc/1957/comm 2
# ok: /proc/sys/fs/nr_open 4096
# ok: /proc/sys/fs/nr_open 2
# ok: /proc/sys/kernel/modprobe 4096
# ok: /proc/sys/kernel/modprobe 2
# ok: /proc/sys/kernel/version 4096
# ok: /proc/sys/kernel/version 2
# ok: /sys/module/test_module/coresize 4096
# ok: /sys/module/test_module/coresize 2
# ok: /sys/module/test_module/sections/.init.text 4096
# ok: /sys/module/test_module/sections/.init.text 2
not ok 2 selftests: splice: short_splice_read.sh # exit=1
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:30 /kselftests/run_kselftest.sh -c static_keys
TAP version 13
1..1
# selftests: static_keys: test_static_keys.sh
# static_key: ok
ok 1 selftests: static_keys: test_static_keys.sh
LKP WARN miss config CONFIG_SYNC= of sync/config
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:30 /kselftests/run_kselftest.sh -c sync
TAP version 13
1..1
# selftests: sync: sync_test
# TAP version 13
# 1..10
# # [RUN]	Testing sync framework
# ok 1 [RUN]	test_alloc_timeline
# ok 2 [RUN]	test_alloc_fence
# ok 3 [RUN]	test_alloc_fence_negative
# ok 4 [RUN]	test_fence_one_timeline_wait
# ok 5 [RUN]	test_fence_one_timeline_merge
# ok 6 [RUN]	test_fence_merge_same_fence
# ok 7 [RUN]	test_fence_multi_timeline_wait
# ok 8 [RUN]	test_stress_two_threads_shared_timeline
# ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
# ok 10 [RUN]	test_merge_stress_random_merge
# # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sync: sync_test
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:33 /kselftests/run_kselftest.sh -c syscall_user_dispatch
TAP version 13
1..2
# selftests: syscall_user_dispatch: sud_test
# TAP version 13
# 1..6
# # Starting 6 tests from 1 test cases.
# #  RUN           global.dispatch_trigger_sigsys ...
# #            OK  global.dispatch_trigger_sigsys
# ok 1 global.dispatch_trigger_sigsys
# #  RUN           global.bad_prctl_param ...
# #            OK  global.bad_prctl_param
# ok 2 global.bad_prctl_param
# #  RUN           global.dispatch_and_return ...
# #            OK  global.dispatch_and_return
# ok 3 global.dispatch_and_return
# #  RUN           global.bad_selector ...
# #            OK  global.bad_selector
# ok 4 global.bad_selector
# #  RUN           global.disable_dispatch ...
# #            OK  global.disable_dispatch
# ok 5 global.disable_dispatch
# #  RUN           global.direct_dispatch_range ...
# #            OK  global.direct_dispatch_range
# ok 6 global.direct_dispatch_range
# # PASSED: 6 / 6 tests passed.
# # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: syscall_user_dispatch: sud_test
# selftests: syscall_user_dispatch: sud_benchmark
# Enabling syscall trapping.
# Caught sys_ff00
# Calibrating test set to last ~5 seconds...
# test iterations = 4000000
# Avg syscall time 1314ns.
# trapped_call_count 1, native_call_count 0.
# Avg syscall time 1346ns.
# Interception overhead: 2.4% (+31ns).
ok 2 selftests: syscall_user_dispatch: sud_benchmark
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:45 /kselftests/run_kselftest.sh -c sysctl
TAP version 13
1..1
# selftests: sysctl: sysctl.sh
# Checking production write strict setting ... ok
# Sat May 29 14:17:45 UTC 2021
# Running test: sysctl_test_0001 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Sat May 29 14:17:45 UTC 2021
# Running test: sysctl_test_0002 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/string_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Writing entire sysctl in short writes ... ok
# Writing middle of sysctl after unsynchronized seek ... ok
# Checking sysctl maxlen is at least 65 ... ok
# Checking sysctl keeps original string on overflow append ... ok
# Checking sysctl stays NULL terminated on write ... ok
# Checking sysctl stays NULL terminated on overwrite ... ok
# Sat May 29 14:17:45 UTC 2021
# Running test: sysctl_test_0003 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0002 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing INT_MAX works ...ok
# Testing INT_MAX + 1 will fail as expected...ok
# Testing negative values will work as expected...ok
# Sat May 29 14:17:46 UTC 2021
# Running test: sysctl_test_0004 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing UINT_MAX works ...ok
# Testing UINT_MAX + 1 will fail as expected...ok
# Testing negative values will not work as expected ...ok
# Sat May 29 14:17:46 UTC 2021
# Running test: sysctl_test_0005 - run #0
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sat May 29 14:17:46 UTC 2021
# Running test: sysctl_test_0005 - run #1
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sat May 29 14:17:47 UTC 2021
# Running test: sysctl_test_0005 - run #2
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sat May 29 14:17:47 UTC 2021
# Running test: sysctl_test_0006 - run #0
# Checking bitmap handler... ok
# Sat May 29 14:17:47 UTC 2021
# Running test: sysctl_test_0006 - run #1
# Checking bitmap handler... ok
# Sat May 29 14:17:49 UTC 2021
# Running test: sysctl_test_0006 - run #2
# Checking bitmap handler... ok
# Sat May 29 14:17:49 UTC 2021
# Running test: sysctl_test_0006 - run #3
# Checking bitmap handler... ok
# Sat May 29 14:17:50 UTC 2021
# Running test: sysctl_test_0006 - run #4
# Checking bitmap handler... ok
# Sat May 29 14:17:52 UTC 2021
# Running test: sysctl_test_0006 - run #5
# Checking bitmap handler... ok
# Sat May 29 14:17:52 UTC 2021
# Running test: sysctl_test_0006 - run #6
# Checking bitmap handler... ok
# Sat May 29 14:17:52 UTC 2021
# Running test: sysctl_test_0006 - run #7
# Checking bitmap handler... ok
# Sat May 29 14:17:53 UTC 2021
# Running test: sysctl_test_0006 - run #8
# Checking bitmap handler... ok
# Sat May 29 14:17:53 UTC 2021
# Running test: sysctl_test_0006 - run #9
# Checking bitmap handler... ok
# Sat May 29 14:17:54 UTC 2021
# Running test: sysctl_test_0006 - run #10
# Checking bitmap handler... ok
# Sat May 29 14:17:54 UTC 2021
# Running test: sysctl_test_0006 - run #11
# Checking bitmap handler... ok
# Sat May 29 14:17:56 UTC 2021
# Running test: sysctl_test_0006 - run #12
# Checking bitmap handler... ok
# Sat May 29 14:17:57 UTC 2021
# Running test: sysctl_test_0006 - run #13
# Checking bitmap handler... ok
# Sat May 29 14:17:57 UTC 2021
# Running test: sysctl_test_0006 - run #14
# Checking bitmap handler... ok
# Sat May 29 14:17:58 UTC 2021
# Running test: sysctl_test_0006 - run #15
# Checking bitmap handler... ok
# Sat May 29 14:18:00 UTC 2021
# Running test: sysctl_test_0006 - run #16
# Checking bitmap handler... ok
# Sat May 29 14:18:00 UTC 2021
# Running test: sysctl_test_0006 - run #17
# Checking bitmap handler... ok
# Sat May 29 14:18:01 UTC 2021
# Running test: sysctl_test_0006 - run #18
# Checking bitmap handler... ok
# Sat May 29 14:18:02 UTC 2021
# Running test: sysctl_test_0006 - run #19
# Checking bitmap handler... ok
# Sat May 29 14:18:03 UTC 2021
# Running test: sysctl_test_0006 - run #20
# Checking bitmap handler... ok
# Sat May 29 14:18:05 UTC 2021
# Running test: sysctl_test_0006 - run #21
# Checking bitmap handler... ok
# Sat May 29 14:18:06 UTC 2021
# Running test: sysctl_test_0006 - run #22
# Checking bitmap handler... ok
# Sat May 29 14:18:06 UTC 2021
# Running test: sysctl_test_0006 - run #23
# Checking bitmap handler... ok
# Sat May 29 14:18:08 UTC 2021
# Running test: sysctl_test_0006 - run #24
# Checking bitmap handler... ok
# Sat May 29 14:18:08 UTC 2021
# Running test: sysctl_test_0006 - run #25
# Checking bitmap handler... ok
# Sat May 29 14:18:09 UTC 2021
# Running test: sysctl_test_0006 - run #26
# Checking bitmap handler... ok
# Sat May 29 14:18:09 UTC 2021
# Running test: sysctl_test_0006 - run #27
# Checking bitmap handler... ok
# Sat May 29 14:18:10 UTC 2021
# Running test: sysctl_test_0006 - run #28
# Checking bitmap handler... ok
# Sat May 29 14:18:12 UTC 2021
# Running test: sysctl_test_0006 - run #29
# Checking bitmap handler... ok
# Sat May 29 14:18:12 UTC 2021
# Running test: sysctl_test_0006 - run #30
# Checking bitmap handler... ok
# Sat May 29 14:18:12 UTC 2021
# Running test: sysctl_test_0006 - run #31
# Checking bitmap handler... ok
# Sat May 29 14:18:13 UTC 2021
# Running test: sysctl_test_0006 - run #32
# Checking bitmap handler... ok
# Sat May 29 14:18:13 UTC 2021
# Running test: sysctl_test_0006 - run #33
# Checking bitmap handler... ok
# Sat May 29 14:18:13 UTC 2021
# Running test: sysctl_test_0006 - run #34
# Checking bitmap handler... ok
# Sat May 29 14:18:14 UTC 2021
# Running test: sysctl_test_0006 - run #35
# Checking bitmap handler... ok
# Sat May 29 14:18:15 UTC 2021
# Running test: sysctl_test_0006 - run #36
# Checking bitmap handler... ok
# Sat May 29 14:18:15 UTC 2021
# Running test: sysctl_test_0006 - run #37
# Checking bitmap handler... ok
# Sat May 29 14:18:16 UTC 2021
# Running test: sysctl_test_0006 - run #38
# Checking bitmap handler... ok
# Sat May 29 14:18:17 UTC 2021
# Running test: sysctl_test_0006 - run #39
# Checking bitmap handler... ok
# Sat May 29 14:18:18 UTC 2021
# Running test: sysctl_test_0006 - run #40
# Checking bitmap handler... ok
# Sat May 29 14:18:19 UTC 2021
# Running test: sysctl_test_0006 - run #41
# Checking bitmap handler... ok
# Sat May 29 14:18:20 UTC 2021
# Running test: sysctl_test_0006 - run #42
# Checking bitmap handler... ok
# Sat May 29 14:18:20 UTC 2021
# Running test: sysctl_test_0006 - run #43
# Checking bitmap handler... ok
# Sat May 29 14:18:21 UTC 2021
# Running test: sysctl_test_0006 - run #44
# Checking bitmap handler... ok
# Sat May 29 14:18:21 UTC 2021
# Running test: sysctl_test_0006 - run #45
# Checking bitmap handler... ok
# Sat May 29 14:18:22 UTC 2021
# Running test: sysctl_test_0006 - run #46
# Checking bitmap handler... ok
# Sat May 29 14:18:22 UTC 2021
# Running test: sysctl_test_0006 - run #47
# Checking bitmap handler... ok
# Sat May 29 14:18:24 UTC 2021
# Running test: sysctl_test_0006 - run #48
# Checking bitmap handler... ok
# Sat May 29 14:18:24 UTC 2021
# Running test: sysctl_test_0006 - run #49
# Checking bitmap handler... ok
# Sat May 29 14:18:24 UTC 2021
# Running test: sysctl_test_0007 - run #0
# Testing if /proc/sys/debug/test_sysctl/boot_int is set to 1 ...ok
ok 1 selftests: sysctl: sysctl.sh



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


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.13.0-rc2-00001-g51001dc34018"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.13.0-rc2 Kernel Configuration
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

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

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
CONFIG_BPF=y
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
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_X86_SGX_KVM is not set
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
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
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
CONFIG_IO_MAPPING=y
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
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
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
# CONFIG_SPI_ALTERA_CORE is not set
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
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
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
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

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
CONFIG_SW_SYNC=y
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
CONFIG_IRQ_BYPASS_MANAGER=y
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
# CONFIG_KPC2000 is not set
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
# CONFIG_SECURITY_PATH is not set
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
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
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
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
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
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
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
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
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
CONFIG_TEST_FIRMWARE=m
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
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export need_memory='3G'
	export need_cpu=2
	export kernel_cmdline='sysctl.debug.test_sysctl.boot_int=1'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d05'
	export tbox_group='lkp-skl-d05'
	export submit_id='60b24bcce319ba41a634fd32'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-51001dc3401827a612f986357b9bbc69bad17c1d-20210529-16806-1co6ruu-8.yaml'
	export id='a628144dd7dde8b529c657c2e86d06c2ec12520d'
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
	export commit='51001dc3401827a612f986357b9bbc69bad17c1d'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI
CONFIG_DRM_I915'
	export ucode='0xe2'
	export need_linux_headers=true
	export need_linux_selftests=true
	export need_kselftests=true
	export need_kconfig='CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_PID_NS=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_USER_NS=y
CONFIG_TEST_LKM=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_STAGING=y
CONFIG_ANDROID=y
CONFIG_SYNC=y ~ "<= v4.7"
CONFIG_SW_SYNC=y
CONFIG_GENERIC_ENTRY=y
CONFIG_TEST_SYSCTL=y
CONFIG_X86_SGX=y ~ ">= v5.11-rc1"'
	export enqueue_time='2021-05-29 22:12:28 +0800'
	export _id='60b24bcce319ba41a634fd32'
	export _rt='/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='c51b0accdc42a3ca2a5a0ea2a08f0eaa050d529d'
	export base_commit='c4681547bcce777daf576925a966ffa824edd09d'
	export branch='linux-review/Gabriel-Krisman-Bertazi/selftest-Add-test-for-Soft-Dirty-PTE-bit/20210529-021608'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/8'
	export scheduler_version='/lkp/lkp/.src-20210528-200739'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-51001dc3401827a612f986357b9bbc69bad17c1d-20210529-16806-1co6ruu-8.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
branch=linux-review/Gabriel-Krisman-Bertazi/selftest-Add-test-for-Soft-Dirty-PTE-bit/20210529-021608
commit=51001dc3401827a612f986357b9bbc69bad17c1d
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/vmlinuz-5.13.0-rc2-00001-g51001dc34018
sysctl.debug.test_sysctl.boot_int=1
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/8
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/linux-selftests.cgz'
	export kselftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/kselftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210507.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-0d95472a-1_20210507.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.13.0-rc3-03449-g5c6e72619b00'
	export repeat_to=9
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/vmlinuz-5.13.0-rc2-00001-g51001dc34018'
	export dequeue_time='2021-05-29 22:14:56 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-51001dc3401827a612f986357b9bbc69bad17c1d-20210529-16806-1co6ruu-8.cgz'

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

	run_test group='group-s' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='group-s' $LKP_SRC/stats/wrapper kernel-selftests
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

--JYK4vJDZwFMowpUq
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel-selftests
Content-Transfer-Encoding: 8bit

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-51001dc3401827a612f986357b9bbc69bad17c1d
2021-05-29 14:16:07 ln -sf /usr/bin/clang
2021-05-29 14:16:07 ln -sf /usr/bin/llc
2021-05-29 14:16:08 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2021-05-29 14:16:08 sed -i s/default_timeout=45/default_timeout=300/ /kselftests/kselftest/runner.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:16:08 /kselftests/run_kselftest.sh -c safesetid
TAP version 13
1..1
# selftests: safesetid: safesetid-test.sh
# mounting securityfs failed
# safesetid-test.sh: done
ok 1 selftests: safesetid: safesetid-test.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:16:08 /kselftests/run_kselftest.sh -c seccomp
TAP version 13
1..2
# selftests: seccomp: seccomp_bpf
# TAP version 13
# 1..87
# # Starting 87 tests from 7 test cases.
# #  RUN           global.kcmp ...
# #            OK  global.kcmp
# ok 1 global.kcmp
# #  RUN           global.mode_strict_support ...
# #            OK  global.mode_strict_support
# ok 2 global.mode_strict_support
# #  RUN           global.mode_strict_cannot_call_prctl ...
# #            OK  global.mode_strict_cannot_call_prctl
# ok 3 global.mode_strict_cannot_call_prctl
# #  RUN           global.no_new_privs_support ...
# #            OK  global.no_new_privs_support
# ok 4 global.no_new_privs_support
# #  RUN           global.mode_filter_support ...
# #            OK  global.mode_filter_support
# ok 5 global.mode_filter_support
# #  RUN           global.mode_filter_without_nnp ...
# #            OK  global.mode_filter_without_nnp
# ok 6 global.mode_filter_without_nnp
# #  RUN           global.filter_size_limits ...
# #            OK  global.filter_size_limits
# ok 7 global.filter_size_limits
# #  RUN           global.filter_chain_limits ...
# #            OK  global.filter_chain_limits
# ok 8 global.filter_chain_limits
# #  RUN           global.mode_filter_cannot_move_to_strict ...
# #            OK  global.mode_filter_cannot_move_to_strict
# ok 9 global.mode_filter_cannot_move_to_strict
# #  RUN           global.mode_filter_get_seccomp ...
# #            OK  global.mode_filter_get_seccomp
# ok 10 global.mode_filter_get_seccomp
# #  RUN           global.ALLOW_all ...
# #            OK  global.ALLOW_all
# ok 11 global.ALLOW_all
# #  RUN           global.empty_prog ...
# #            OK  global.empty_prog
# ok 12 global.empty_prog
# #  RUN           global.log_all ...
# #            OK  global.log_all
# ok 13 global.log_all
# #  RUN           global.unknown_ret_is_kill_inside ...
# #            OK  global.unknown_ret_is_kill_inside
# ok 14 global.unknown_ret_is_kill_inside
# #  RUN           global.unknown_ret_is_kill_above_allow ...
# #            OK  global.unknown_ret_is_kill_above_allow
# ok 15 global.unknown_ret_is_kill_above_allow
# #  RUN           global.KILL_all ...
# #            OK  global.KILL_all
# ok 16 global.KILL_all
# #  RUN           global.KILL_one ...
# #            OK  global.KILL_one
# ok 17 global.KILL_one
# #  RUN           global.KILL_one_arg_one ...
# #            OK  global.KILL_one_arg_one
# ok 18 global.KILL_one_arg_one
# #  RUN           global.KILL_one_arg_six ...
# #            OK  global.KILL_one_arg_six
# ok 19 global.KILL_one_arg_six
# #  RUN           global.KILL_thread ...
# #            OK  global.KILL_thread
# ok 20 global.KILL_thread
# #  RUN           global.KILL_process ...
# #            OK  global.KILL_process
# ok 21 global.KILL_process
# #  RUN           global.KILL_unknown ...
# #            OK  global.KILL_unknown
# ok 22 global.KILL_unknown
# #  RUN           global.arg_out_of_range ...
# #            OK  global.arg_out_of_range
# ok 23 global.arg_out_of_range
# #  RUN           global.ERRNO_valid ...
# #            OK  global.ERRNO_valid
# ok 24 global.ERRNO_valid
# #  RUN           global.ERRNO_zero ...
# #            OK  global.ERRNO_zero
# ok 25 global.ERRNO_zero
# #  RUN           global.ERRNO_capped ...
# #            OK  global.ERRNO_capped
# ok 26 global.ERRNO_capped
# #  RUN           global.ERRNO_order ...
# #            OK  global.ERRNO_order
# ok 27 global.ERRNO_order
# #  RUN           global.negative_ENOSYS ...
# #            OK  global.negative_ENOSYS
# ok 28 global.negative_ENOSYS
# #  RUN           global.seccomp_syscall ...
# #            OK  global.seccomp_syscall
# ok 29 global.seccomp_syscall
# #  RUN           global.seccomp_syscall_mode_lock ...
# #            OK  global.seccomp_syscall_mode_lock
# ok 30 global.seccomp_syscall_mode_lock
# #  RUN           global.detect_seccomp_filter_flags ...
# #            OK  global.detect_seccomp_filter_flags
# ok 31 global.detect_seccomp_filter_flags
# #  RUN           global.TSYNC_first ...
# #            OK  global.TSYNC_first
# ok 32 global.TSYNC_first
# #  RUN           global.syscall_restart ...
# #            OK  global.syscall_restart
# ok 33 global.syscall_restart
# #  RUN           global.filter_flag_log ...
# #            OK  global.filter_flag_log
# ok 34 global.filter_flag_log
# #  RUN           global.get_action_avail ...
# #            OK  global.get_action_avail
# ok 35 global.get_action_avail
# #  RUN           global.get_metadata ...
# #            OK  global.get_metadata
# ok 36 global.get_metadata
# #  RUN           global.user_notification_basic ...
# #            OK  global.user_notification_basic
# ok 37 global.user_notification_basic
# #  RUN           global.user_notification_with_tsync ...
# #            OK  global.user_notification_with_tsync
# ok 38 global.user_notification_with_tsync
# #  RUN           global.user_notification_kill_in_middle ...
# #            OK  global.user_notification_kill_in_middle
# ok 39 global.user_notification_kill_in_middle
# #  RUN           global.user_notification_signal ...
# #            OK  global.user_notification_signal
# ok 40 global.user_notification_signal
# #  RUN           global.user_notification_closed_listener ...
# #            OK  global.user_notification_closed_listener
# ok 41 global.user_notification_closed_listener
# #  RUN           global.user_notification_child_pid_ns ...
# #            OK  global.user_notification_child_pid_ns
# ok 42 global.user_notification_child_pid_ns
# #  RUN           global.user_notification_sibling_pid_ns ...
# #            OK  global.user_notification_sibling_pid_ns
# ok 43 global.user_notification_sibling_pid_ns
# #  RUN           global.user_notification_fault_recv ...
# #            OK  global.user_notification_fault_recv
# ok 44 global.user_notification_fault_recv
# #  RUN           global.seccomp_get_notif_sizes ...
# #            OK  global.seccomp_get_notif_sizes
# ok 45 global.seccomp_get_notif_sizes
# #  RUN           global.user_notification_continue ...
# #            OK  global.user_notification_continue
# ok 46 global.user_notification_continue
# #  RUN           global.user_notification_filter_empty ...
# #            OK  global.user_notification_filter_empty
# ok 47 global.user_notification_filter_empty
# #  RUN           global.user_notification_filter_empty_threaded ...
# #            OK  global.user_notification_filter_empty_threaded
# ok 48 global.user_notification_filter_empty_threaded
# #  RUN           global.user_notification_addfd ...
# #            OK  global.user_notification_addfd
# ok 49 global.user_notification_addfd
# #  RUN           global.user_notification_addfd_rlimit ...
# #            OK  global.user_notification_addfd_rlimit
# ok 50 global.user_notification_addfd_rlimit
# #  RUN           TRAP.dfl ...
# #            OK  TRAP.dfl
# ok 51 TRAP.dfl
# #  RUN           TRAP.ign ...
# #            OK  TRAP.ign
# ok 52 TRAP.ign
# #  RUN           TRAP.handler ...
# #            OK  TRAP.handler
# ok 53 TRAP.handler
# #  RUN           precedence.allow_ok ...
# #            OK  precedence.allow_ok
# ok 54 precedence.allow_ok
# #  RUN           precedence.kill_is_highest ...
# #            OK  precedence.kill_is_highest
# ok 55 precedence.kill_is_highest
# #  RUN           precedence.kill_is_highest_in_any_order ...
# #            OK  precedence.kill_is_highest_in_any_order
# ok 56 precedence.kill_is_highest_in_any_order
# #  RUN           precedence.trap_is_second ...
# #            OK  precedence.trap_is_second
# ok 57 precedence.trap_is_second
# #  RUN           precedence.trap_is_second_in_any_order ...
# #            OK  precedence.trap_is_second_in_any_order
# ok 58 precedence.trap_is_second_in_any_order
# #  RUN           precedence.errno_is_third ...
# #            OK  precedence.errno_is_third
# ok 59 precedence.errno_is_third
# #  RUN           precedence.errno_is_third_in_any_order ...
# #            OK  precedence.errno_is_third_in_any_order
# ok 60 precedence.errno_is_third_in_any_order
# #  RUN           precedence.trace_is_fourth ...
# #            OK  precedence.trace_is_fourth
# ok 61 precedence.trace_is_fourth
# #  RUN           precedence.trace_is_fourth_in_any_order ...
# #            OK  precedence.trace_is_fourth_in_any_order
# ok 62 precedence.trace_is_fourth_in_any_order
# #  RUN           precedence.log_is_fifth ...
# #            OK  precedence.log_is_fifth
# ok 63 precedence.log_is_fifth
# #  RUN           precedence.log_is_fifth_in_any_order ...
# #            OK  precedence.log_is_fifth_in_any_order
# ok 64 precedence.log_is_fifth_in_any_order
# #  RUN           TRACE_poke.read_has_side_effects ...
# #            OK  TRACE_poke.read_has_side_effects
# ok 65 TRACE_poke.read_has_side_effects
# #  RUN           TRACE_poke.getpid_runs_normally ...
# #            OK  TRACE_poke.getpid_runs_normally
# ok 66 TRACE_poke.getpid_runs_normally
# #  RUN           TRACE_syscall.ptrace.negative_ENOSYS ...
# #            OK  TRACE_syscall.ptrace.negative_ENOSYS
# ok 67 TRACE_syscall.ptrace.negative_ENOSYS
# #  RUN           TRACE_syscall.ptrace.syscall_allowed ...
# #            OK  TRACE_syscall.ptrace.syscall_allowed
# ok 68 TRACE_syscall.ptrace.syscall_allowed
# #  RUN           TRACE_syscall.ptrace.syscall_redirected ...
# #            OK  TRACE_syscall.ptrace.syscall_redirected
# ok 69 TRACE_syscall.ptrace.syscall_redirected
# #  RUN           TRACE_syscall.ptrace.syscall_errno ...
# #            OK  TRACE_syscall.ptrace.syscall_errno
# ok 70 TRACE_syscall.ptrace.syscall_errno
# #  RUN           TRACE_syscall.ptrace.syscall_faked ...
# #            OK  TRACE_syscall.ptrace.syscall_faked
# ok 71 TRACE_syscall.ptrace.syscall_faked
# #  RUN           TRACE_syscall.ptrace.skip_after ...
# #            OK  TRACE_syscall.ptrace.skip_after
# ok 72 TRACE_syscall.ptrace.skip_after
# #  RUN           TRACE_syscall.ptrace.kill_after ...
# #            OK  TRACE_syscall.ptrace.kill_after
# ok 73 TRACE_syscall.ptrace.kill_after
# #  RUN           TRACE_syscall.seccomp.negative_ENOSYS ...
# #            OK  TRACE_syscall.seccomp.negative_ENOSYS
# ok 74 TRACE_syscall.seccomp.negative_ENOSYS
# #  RUN           TRACE_syscall.seccomp.syscall_allowed ...
# #            OK  TRACE_syscall.seccomp.syscall_allowed
# ok 75 TRACE_syscall.seccomp.syscall_allowed
# #  RUN           TRACE_syscall.seccomp.syscall_redirected ...
# #            OK  TRACE_syscall.seccomp.syscall_redirected
# ok 76 TRACE_syscall.seccomp.syscall_redirected
# #  RUN           TRACE_syscall.seccomp.syscall_errno ...
# #            OK  TRACE_syscall.seccomp.syscall_errno
# ok 77 TRACE_syscall.seccomp.syscall_errno
# #  RUN           TRACE_syscall.seccomp.syscall_faked ...
# #            OK  TRACE_syscall.seccomp.syscall_faked
# ok 78 TRACE_syscall.seccomp.syscall_faked
# #  RUN           TRACE_syscall.seccomp.skip_after ...
# #            OK  TRACE_syscall.seccomp.skip_after
# ok 79 TRACE_syscall.seccomp.skip_after
# #  RUN           TRACE_syscall.seccomp.kill_after ...
# #            OK  TRACE_syscall.seccomp.kill_after
# ok 80 TRACE_syscall.seccomp.kill_after
# #  RUN           TSYNC.siblings_fail_prctl ...
# #            OK  TSYNC.siblings_fail_prctl
# ok 81 TSYNC.siblings_fail_prctl
# #  RUN           TSYNC.two_siblings_with_ancestor ...
# #            OK  TSYNC.two_siblings_with_ancestor
# ok 82 TSYNC.two_siblings_with_ancestor
# #  RUN           TSYNC.two_sibling_want_nnp ...
# #            OK  TSYNC.two_sibling_want_nnp
# ok 83 TSYNC.two_sibling_want_nnp
# #  RUN           TSYNC.two_siblings_with_no_filter ...
# #            OK  TSYNC.two_siblings_with_no_filter
# ok 84 TSYNC.two_siblings_with_no_filter
# #  RUN           TSYNC.two_siblings_with_one_divergence ...
# #            OK  TSYNC.two_siblings_with_one_divergence
# ok 85 TSYNC.two_siblings_with_one_divergence
# #  RUN           TSYNC.two_siblings_with_one_divergence_no_tid_in_err ...
# #            OK  TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# ok 86 TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# #  RUN           TSYNC.two_siblings_not_under_filter ...
# #            OK  TSYNC.two_siblings_not_under_filter
# ok 87 TSYNC.two_siblings_not_under_filter
# # PASSED: 87 / 87 tests passed.
# # Totals: pass:87 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: seccomp: seccomp_bpf
# selftests: seccomp: seccomp_benchmark
# net.core.bpf_jit_enable = 1
# net.core.bpf_jit_harden = 0
# Current BPF sysctl settings:
# Calibrating sample size for 15 seconds worth of syscalls ...
# Benchmarking 18250590 syscalls...
# 15.671098000 - 1.000871323 = 14670226677 (14.7s)
# getpid native: 803 ns
# 30.660267505 - 15.671370913 = 14988896592 (15.0s)
# getpid RET_ALLOW 1 filter (bitmap): 821 ns
# 45.403350482 - 30.660471377 = 14742879105 (14.7s)
# getpid RET_ALLOW 2 filters (bitmap): 807 ns
# 62.521709238 - 45.403552362 = 17118156876 (17.1s)
# getpid RET_ALLOW 3 filters (full): 937 ns
# 79.152560752 - 62.521923393 = 16630637359 (16.6s)
# getpid RET_ALLOW 4 filters (full): 911 ns
# Estimated total seccomp overhead for 1 bitmapped filter: 18 ns
# Estimated total seccomp overhead for 2 bitmapped filters: 4 ns
# Estimated total seccomp overhead for 3 full filters: 134 ns
# Estimated total seccomp overhead for 4 full filters: 108 ns
# Estimated seccomp entry overhead: 32 ns
# Estimated seccomp per-filter overhead (last 2 diff): 18446744073709551590 ns
# Saw unexpected benchmark result. Try running again with more samples?
ok 2 selftests: seccomp: seccomp_benchmark
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:29 /kselftests/run_kselftest.sh -c sigaltstack
TAP version 13
1..1
# selftests: sigaltstack: sas
# TAP version 13
# 1..3
# ok 1 Initial sigaltstack state was SS_DISABLE
# # [RUN]	signal USR1
# ok 2 sigaltstack is disabled in sighandler
# # [RUN]	switched to user ctx
# # [RUN]	signal USR2
# # [OK]	Stack preserved
# ok 3 sigaltstack is still SS_AUTODISARM after signal
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sigaltstack: sas
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:29 /kselftests/run_kselftest.sh -c size
TAP version 13
1..1
# selftests: size: get_size
# TAP version 13
# # Testing system size.
# ok 1 get runtime memory use
# # System runtime memory report (units in Kilobytes):
#  ---
#  Total:  32738052
#  Free:   29397508
#  Buffer: 12
#  In use: 3340532
#  ...
# 1..1
ok 1 selftests: size: get_size
LKP WARN miss target soft-dirty
2021-05-29 14:17:29 make run_tests -C soft-dirty
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-51001dc3401827a612f986357b9bbc69bad17c1d/tools/testing/selftests/soft-dirty'
gcc -Wall -I../../../../usr/include/ -O0 -g3    soft-dirty.c  -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-51001dc3401827a612f986357b9bbc69bad17c1d/tools/testing/selftests/soft-dirty/soft-dirty
soft-dirty.c: In function ‘touch_page’:
soft-dirty.c:41:7: error: ‘page_size’ undeclared (first use in this function); did you mean ‘pagesize’?
  map[(page_size * n) + 1]++;
       ^~~~~~~~~
       pagesize
soft-dirty.c:41:7: note: each undeclared identifier is reported only once for each function it appears in
soft-dirty.c: In function ‘test_simple’:
soft-dirty.c:70:22: error: ‘page_size’ undeclared (first use in this function); did you mean ‘pagesize’?
  map = aligned_alloc(page_size, mmap_size);
                      ^~~~~~~~~
                      pagesize
soft-dirty.c: In function ‘main’:
soft-dirty.c:247:19: error: called object ‘pagesize’ is not a function or function pointer
  mmap_size = 10 * pagesize();
                   ^~~~~~~~
soft-dirty.c:30:5: note: declared here
 int pagesize;
     ^~~~~~~~
make: *** [../lib.mk:144: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-51001dc3401827a612f986357b9bbc69bad17c1d/tools/testing/selftests/soft-dirty/soft-dirty] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-51001dc3401827a612f986357b9bbc69bad17c1d/tools/testing/selftests/soft-dirty'
LKP SKIP sparc64
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:29 /kselftests/run_kselftest.sh -c splice
TAP version 13
1..2
# selftests: splice: default_file_splice_read.sh
ok 1 selftests: splice: default_file_splice_read.sh
# selftests: splice: short_splice_read.sh
# splice: Invalid argument
# FAIL: /proc/1957/limits 4096
# splice: Invalid argument
# FAIL: /proc/1957/limits 2
# splice: Invalid argument
# FAIL: /proc/1957/comm 4096
# splice: Invalid argument
# FAIL: /proc/1957/comm 2
# ok: /proc/sys/fs/nr_open 4096
# ok: /proc/sys/fs/nr_open 2
# ok: /proc/sys/kernel/modprobe 4096
# ok: /proc/sys/kernel/modprobe 2
# ok: /proc/sys/kernel/version 4096
# ok: /proc/sys/kernel/version 2
# ok: /sys/module/test_module/coresize 4096
# ok: /sys/module/test_module/coresize 2
# ok: /sys/module/test_module/sections/.init.text 4096
# ok: /sys/module/test_module/sections/.init.text 2
not ok 2 selftests: splice: short_splice_read.sh # exit=1
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:30 /kselftests/run_kselftest.sh -c static_keys
TAP version 13
1..1
# selftests: static_keys: test_static_keys.sh
# static_key: ok
ok 1 selftests: static_keys: test_static_keys.sh
LKP WARN miss config CONFIG_SYNC= of sync/config
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:30 /kselftests/run_kselftest.sh -c sync
TAP version 13
1..1
# selftests: sync: sync_test
# TAP version 13
# 1..10
# # [RUN]	Testing sync framework
# ok 1 [RUN]	test_alloc_timeline
# ok 2 [RUN]	test_alloc_fence
# ok 3 [RUN]	test_alloc_fence_negative
# ok 4 [RUN]	test_fence_one_timeline_wait
# ok 5 [RUN]	test_fence_one_timeline_merge
# ok 6 [RUN]	test_fence_merge_same_fence
# ok 7 [RUN]	test_fence_multi_timeline_wait
# ok 8 [RUN]	test_stress_two_threads_shared_timeline
# ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
# ok 10 [RUN]	test_merge_stress_random_merge
# # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sync: sync_test
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:33 /kselftests/run_kselftest.sh -c syscall_user_dispatch
TAP version 13
1..2
# selftests: syscall_user_dispatch: sud_test
# TAP version 13
# 1..6
# # Starting 6 tests from 1 test cases.
# #  RUN           global.dispatch_trigger_sigsys ...
# #            OK  global.dispatch_trigger_sigsys
# ok 1 global.dispatch_trigger_sigsys
# #  RUN           global.bad_prctl_param ...
# #            OK  global.bad_prctl_param
# ok 2 global.bad_prctl_param
# #  RUN           global.dispatch_and_return ...
# #            OK  global.dispatch_and_return
# ok 3 global.dispatch_and_return
# #  RUN           global.bad_selector ...
# #            OK  global.bad_selector
# ok 4 global.bad_selector
# #  RUN           global.disable_dispatch ...
# #            OK  global.disable_dispatch
# ok 5 global.disable_dispatch
# #  RUN           global.direct_dispatch_range ...
# #            OK  global.direct_dispatch_range
# ok 6 global.direct_dispatch_range
# # PASSED: 6 / 6 tests passed.
# # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: syscall_user_dispatch: sud_test
# selftests: syscall_user_dispatch: sud_benchmark
# Enabling syscall trapping.
# Caught sys_ff00
# Calibrating test set to last ~5 seconds...
# test iterations = 4000000
# Avg syscall time 1314ns.
# trapped_call_count 1, native_call_count 0.
# Avg syscall time 1346ns.
# Interception overhead: 2.4% (+31ns).
ok 2 selftests: syscall_user_dispatch: sud_benchmark
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-05-29 14:17:45 /kselftests/run_kselftest.sh -c sysctl
TAP version 13
1..1
# selftests: sysctl: sysctl.sh
# Checking production write strict setting ... ok
# Sat May 29 14:17:45 UTC 2021
# Running test: sysctl_test_0001 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Sat May 29 14:17:45 UTC 2021
# Running test: sysctl_test_0002 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/string_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Writing entire sysctl in short writes ... ok
# Writing middle of sysctl after unsynchronized seek ... ok
# Checking sysctl maxlen is at least 65 ... ok
# Checking sysctl keeps original string on overflow append ... ok
# Checking sysctl stays NULL terminated on write ... ok
# Checking sysctl stays NULL terminated on overwrite ... ok
# Sat May 29 14:17:45 UTC 2021
# Running test: sysctl_test_0003 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0002 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing INT_MAX works ...ok
# Testing INT_MAX + 1 will fail as expected...ok
# Testing negative values will work as expected...ok
# Sat May 29 14:17:46 UTC 2021
# Running test: sysctl_test_0004 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing UINT_MAX works ...ok
# Testing UINT_MAX + 1 will fail as expected...ok
# Testing negative values will not work as expected ...ok
# Sat May 29 14:17:46 UTC 2021
# Running test: sysctl_test_0005 - run #0
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sat May 29 14:17:46 UTC 2021
# Running test: sysctl_test_0005 - run #1
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sat May 29 14:17:47 UTC 2021
# Running test: sysctl_test_0005 - run #2
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sat May 29 14:17:47 UTC 2021
# Running test: sysctl_test_0006 - run #0
# Checking bitmap handler... ok
# Sat May 29 14:17:47 UTC 2021
# Running test: sysctl_test_0006 - run #1
# Checking bitmap handler... ok
# Sat May 29 14:17:49 UTC 2021
# Running test: sysctl_test_0006 - run #2
# Checking bitmap handler... ok
# Sat May 29 14:17:49 UTC 2021
# Running test: sysctl_test_0006 - run #3
# Checking bitmap handler... ok
# Sat May 29 14:17:50 UTC 2021
# Running test: sysctl_test_0006 - run #4
# Checking bitmap handler... ok
# Sat May 29 14:17:52 UTC 2021
# Running test: sysctl_test_0006 - run #5
# Checking bitmap handler... ok
# Sat May 29 14:17:52 UTC 2021
# Running test: sysctl_test_0006 - run #6
# Checking bitmap handler... ok
# Sat May 29 14:17:52 UTC 2021
# Running test: sysctl_test_0006 - run #7
# Checking bitmap handler... ok
# Sat May 29 14:17:53 UTC 2021
# Running test: sysctl_test_0006 - run #8
# Checking bitmap handler... ok
# Sat May 29 14:17:53 UTC 2021
# Running test: sysctl_test_0006 - run #9
# Checking bitmap handler... ok
# Sat May 29 14:17:54 UTC 2021
# Running test: sysctl_test_0006 - run #10
# Checking bitmap handler... ok
# Sat May 29 14:17:54 UTC 2021
# Running test: sysctl_test_0006 - run #11
# Checking bitmap handler... ok
# Sat May 29 14:17:56 UTC 2021
# Running test: sysctl_test_0006 - run #12
# Checking bitmap handler... ok
# Sat May 29 14:17:57 UTC 2021
# Running test: sysctl_test_0006 - run #13
# Checking bitmap handler... ok
# Sat May 29 14:17:57 UTC 2021
# Running test: sysctl_test_0006 - run #14
# Checking bitmap handler... ok
# Sat May 29 14:17:58 UTC 2021
# Running test: sysctl_test_0006 - run #15
# Checking bitmap handler... ok
# Sat May 29 14:18:00 UTC 2021
# Running test: sysctl_test_0006 - run #16
# Checking bitmap handler... ok
# Sat May 29 14:18:00 UTC 2021
# Running test: sysctl_test_0006 - run #17
# Checking bitmap handler... ok
# Sat May 29 14:18:01 UTC 2021
# Running test: sysctl_test_0006 - run #18
# Checking bitmap handler... ok
# Sat May 29 14:18:02 UTC 2021
# Running test: sysctl_test_0006 - run #19
# Checking bitmap handler... ok
# Sat May 29 14:18:03 UTC 2021
# Running test: sysctl_test_0006 - run #20
# Checking bitmap handler... ok
# Sat May 29 14:18:05 UTC 2021
# Running test: sysctl_test_0006 - run #21
# Checking bitmap handler... ok
# Sat May 29 14:18:06 UTC 2021
# Running test: sysctl_test_0006 - run #22
# Checking bitmap handler... ok
# Sat May 29 14:18:06 UTC 2021
# Running test: sysctl_test_0006 - run #23
# Checking bitmap handler... ok
# Sat May 29 14:18:08 UTC 2021
# Running test: sysctl_test_0006 - run #24
# Checking bitmap handler... ok
# Sat May 29 14:18:08 UTC 2021
# Running test: sysctl_test_0006 - run #25
# Checking bitmap handler... ok
# Sat May 29 14:18:09 UTC 2021
# Running test: sysctl_test_0006 - run #26
# Checking bitmap handler... ok
# Sat May 29 14:18:09 UTC 2021
# Running test: sysctl_test_0006 - run #27
# Checking bitmap handler... ok
# Sat May 29 14:18:10 UTC 2021
# Running test: sysctl_test_0006 - run #28
# Checking bitmap handler... ok
# Sat May 29 14:18:12 UTC 2021
# Running test: sysctl_test_0006 - run #29
# Checking bitmap handler... ok
# Sat May 29 14:18:12 UTC 2021
# Running test: sysctl_test_0006 - run #30
# Checking bitmap handler... ok
# Sat May 29 14:18:12 UTC 2021
# Running test: sysctl_test_0006 - run #31
# Checking bitmap handler... ok
# Sat May 29 14:18:13 UTC 2021
# Running test: sysctl_test_0006 - run #32
# Checking bitmap handler... ok
# Sat May 29 14:18:13 UTC 2021
# Running test: sysctl_test_0006 - run #33
# Checking bitmap handler... ok
# Sat May 29 14:18:13 UTC 2021
# Running test: sysctl_test_0006 - run #34
# Checking bitmap handler... ok
# Sat May 29 14:18:14 UTC 2021
# Running test: sysctl_test_0006 - run #35
# Checking bitmap handler... ok
# Sat May 29 14:18:15 UTC 2021
# Running test: sysctl_test_0006 - run #36
# Checking bitmap handler... ok
# Sat May 29 14:18:15 UTC 2021
# Running test: sysctl_test_0006 - run #37
# Checking bitmap handler... ok
# Sat May 29 14:18:16 UTC 2021
# Running test: sysctl_test_0006 - run #38
# Checking bitmap handler... ok
# Sat May 29 14:18:17 UTC 2021
# Running test: sysctl_test_0006 - run #39
# Checking bitmap handler... ok
# Sat May 29 14:18:18 UTC 2021
# Running test: sysctl_test_0006 - run #40
# Checking bitmap handler... ok
# Sat May 29 14:18:19 UTC 2021
# Running test: sysctl_test_0006 - run #41
# Checking bitmap handler... ok
# Sat May 29 14:18:20 UTC 2021
# Running test: sysctl_test_0006 - run #42
# Checking bitmap handler... ok
# Sat May 29 14:18:20 UTC 2021
# Running test: sysctl_test_0006 - run #43
# Checking bitmap handler... ok
# Sat May 29 14:18:21 UTC 2021
# Running test: sysctl_test_0006 - run #44
# Checking bitmap handler... ok
# Sat May 29 14:18:21 UTC 2021
# Running test: sysctl_test_0006 - run #45
# Checking bitmap handler... ok
# Sat May 29 14:18:22 UTC 2021
# Running test: sysctl_test_0006 - run #46
# Checking bitmap handler... ok
# Sat May 29 14:18:22 UTC 2021
# Running test: sysctl_test_0006 - run #47
# Checking bitmap handler... ok
# Sat May 29 14:18:24 UTC 2021
# Running test: sysctl_test_0006 - run #48
# Checking bitmap handler... ok
# Sat May 29 14:18:24 UTC 2021
# Running test: sysctl_test_0006 - run #49
# Checking bitmap handler... ok
# Sat May 29 14:18:24 UTC 2021
# Running test: sysctl_test_0007 - run #0
# Testing if /proc/sys/debug/test_sysctl/boot_int is set to 1 ...ok
ok 1 selftests: sysctl: sysctl.sh

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-8.3-kselftests
need_memory: 3G
need_cpu: 2
kernel-selftests:
  group: group-s
kernel_cmdline: sysctl.debug.test_sysctl.boot_int=1
job_origin: kernel-selftests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d05
tbox_group: lkp-skl-d05
submit_id: 60b1c1b882a8e85c9fddb910
job_file: "/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-51001dc3401827a612f986357b9bbc69bad17c1d-20210529-89247-uv8bpo-0.yaml"
id: 13db3754234bb994c6e3a57ed10e5e605599f066
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d05
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/queue/cyclic
commit: 51001dc3401827a612f986357b9bbc69bad17c1d

#! include/testbox/lkp-skl-d05
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
- CONFIG_DRM_I915
ucode: '0xe2'

# for sysctl

#! include/kernel-selftests
need_linux_headers: true
need_linux_selftests: true
need_kselftests: true
need_kconfig:
- CONFIG_SECURITY=y
- CONFIG_SECURITYFS=y
- CONFIG_PID_NS=y
- CONFIG_SECCOMP=y
- CONFIG_SECCOMP_FILTER=y
- CONFIG_USER_NS=y
- CONFIG_TEST_LKM=m
- CONFIG_TEST_STATIC_KEYS=m
- CONFIG_STAGING=y
- CONFIG_ANDROID=y
- CONFIG_SYNC=y ~ "<= v4.7"
- CONFIG_SW_SYNC=y
- CONFIG_GENERIC_ENTRY=y
- CONFIG_TEST_SYSCTL=y
- CONFIG_X86_SGX=y ~ ">= v5.11-rc1"
enqueue_time: 2021-05-29 12:23:20.273709851 +08:00
_id: 60b1c1b882a8e85c9fddb910
_rt: "/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 97ca22aa4ae0c286be5bc7c5e42f545bc1ed6a45
base_commit: c4681547bcce777daf576925a966ffa824edd09d
branch: linux-devel/devel-hourly-20210529-040709
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/0"
scheduler_version: "/lkp/lkp/.src-20210528-200739"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-51001dc3401827a612f986357b9bbc69bad17c1d-20210529-89247-uv8bpo-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- branch=linux-devel/devel-hourly-20210529-040709
- commit=51001dc3401827a612f986357b9bbc69bad17c1d
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/vmlinuz-5.13.0-rc2-00001-g51001dc34018
- sysctl.debug.test_sysctl.boot_int=1
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/linux-selftests.cgz"
kselftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/kselftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210507.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-0d95472a-1_20210507.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210528-200739/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.13.0-rc3-gd533c83f6fcd

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/51001dc3401827a612f986357b9bbc69bad17c1d/vmlinuz-5.13.0-rc2-00001-g51001dc34018"
dequeue_time: 2021-05-29 13:21:01.629157960 +08:00
job_state: finished
loadavg: 0.91 0.52 0.21 1/142 3438
start_time: '1622265759'
end_time: '1622265897'
version: "/lkp/lkp/.src-20210528-200811:0e6e15c0-dirty:826a45b20"

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

ln -sf /usr/bin/clang
ln -sf /usr/bin/llc
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
sed -i s/default_timeout=45/default_timeout=300/ /kselftests/kselftest/runner.sh
/kselftests/run_kselftest.sh -c safesetid
/kselftests/run_kselftest.sh -c seccomp
/kselftests/run_kselftest.sh -c sigaltstack
/kselftests/run_kselftest.sh -c size
make run_tests -C soft-dirty
/kselftests/run_kselftest.sh -c splice
/kselftests/run_kselftest.sh -c static_keys
/kselftests/run_kselftest.sh -c sync
/kselftests/run_kselftest.sh -c syscall_user_dispatch
/kselftests/run_kselftest.sh -c sysctl

--JYK4vJDZwFMowpUq--
