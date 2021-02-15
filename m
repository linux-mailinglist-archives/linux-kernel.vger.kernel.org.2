Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F54A31BA6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBONbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:31:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:11808 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhBONav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:30:51 -0500
IronPort-SDR: jmo6qKWYPB7tZ0w6O0uLjHwO5P4fFFqmrdRVpyJPbb5FZcWSm61oTxXHoNBR9WYtGYfx0qo7ZZ
 1soSs7vq9DJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="169812710"
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="xz'?yaml'?scan'208";a="169812710"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 05:29:48 -0800
IronPort-SDR: qPOLabcxcCqnz4y9EOiWU21SBdxn13k2HENLkf+CkHQtfTegS7NP+AW44SM8n6rT7xR8mWZBMV
 uQkxkatu4h3w==
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="xz'?yaml'?scan'208";a="399068603"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 05:29:44 -0800
Date:   Mon, 15 Feb 2021 21:45:23 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     trondmy@kernel.org
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [SUNRPC]  00003c0265:
 BUG:sleeping_function_called_from_invalid_context_at_net/core/sock.c
Message-ID: <20210215134523.GB15834@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20210212214020.4140-1-trondmy@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9 ("SUNRPC: Set TCP_CORK until the transmit queue is empty")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git trondmy-kernel-org/SUNRPC-Set-TCP_CORK-until-the-transmit-queue-is-empty/20210213-054525


in testcase: kernel-selftests
version: kernel-selftests-x86_64-b553cffa-1_20210122
with following parameters:

	group: tc-testing
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[   55.839097] BUG: sleeping function called from invalid context at net/core/sock.c:3048
[   55.847114] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 99, name: kworker/u9:0
[   55.855394] 3 locks held by kworker/u9:0/99:
[   55.859741] #0: ffff888101615938 ((wq_completion)xprtiod){+.+.}-{0:0}, at: process_one_work (kbuild/src/consumer/arch/x86/include/asm/atomic64_64.h:34 kbuild/src/consumer/include/asm-generic/atomic-instrumented.h:856 kbuild/src/consumer/include/asm-generic/atomic-long.h:41 kbuild/src/consumer/kernel/workqueue.c:616 kbuild/src/consumer/kernel/workqueue.c:643 kbuild/src/consumer/kernel/workqueue.c:2246) 
[   55.869364] #1: ffffc90000807e58 ((work_completion)(&(&transport->connect_worker)->work)){+.+.}-{0:0}, at: process_one_work (kbuild/src/consumer/arch/x86/include/asm/atomic64_64.h:34 kbuild/src/consumer/include/asm-generic/atomic-instrumented.h:856 kbuild/src/consumer/include/asm-generic/atomic-long.h:41 kbuild/src/consumer/kernel/workqueue.c:616 kbuild/src/consumer/kernel/workqueue.c:643 kbuild/src/consumer/kernel/workqueue.c:2246) 
[   55.881761] #2: ffff888816a58f08 (k-clock-AF_INET){++..}-{2:2}, at: xs_tcp_setup_socket (kbuild/src/consumer/net/sunrpc/xprtsock.c:1094 kbuild/src/consumer/net/sunrpc/xprtsock.c:2171 kbuild/src/consumer/net/sunrpc/xprtsock.c:2250) 
[   55.891016] Preemption disabled at:
[   55.891032] 0x0 
[   55.898201] CPU: 2 PID: 99 Comm: kworker/u9:0 Not tainted 5.11.0-rc6-00001-g00003c0265c6 #1
[   55.906623] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[   55.914068] Workqueue: xprtiod xs_tcp_setup_socket
[   55.918895] Call Trace:
[   55.921372] dump_stack (kbuild/src/consumer/lib/dump_stack.c:122) 
[   55.924715] ___might_sleep.cold (kbuild/src/consumer/kernel/sched/core.c:7967) 
[   55.928930] lock_sock_nested (kbuild/src/consumer/include/linux/spinlock.h:359 kbuild/src/consumer/net/core/sock.c:3049) 
[   55.932807] tcp_sock_set_nodelay (kbuild/src/consumer/net/ipv4/tcp.c:3160 kbuild/src/consumer/net/ipv4/tcp.c:3171) 
[   55.937025] xs_tcp_setup_socket (kbuild/src/consumer/arch/x86/include/asm/bitops.h:75 kbuild/src/consumer/include/asm-generic/bitops/instrumented-atomic.h:42 kbuild/src/consumer/include/linux/sunrpc/xprt.h:431 kbuild/src/consumer/net/sunrpc/xprtsock.c:2184 kbuild/src/consumer/net/sunrpc/xprtsock.c:2250) 
[   55.941343] process_one_work (kbuild/src/consumer/arch/x86/include/asm/jump_label.h:25 kbuild/src/consumer/include/linux/jump_label.h:200 kbuild/src/consumer/include/trace/events/workqueue.h:108 kbuild/src/consumer/kernel/workqueue.c:2280) 
[   55.945402] worker_thread (kbuild/src/consumer/include/linux/list.h:282 kbuild/src/consumer/kernel/workqueue.c:2422) 
[   55.949096] ? process_one_work (kbuild/src/consumer/kernel/workqueue.c:2364) 
[   55.953308] kthread (kbuild/src/consumer/kernel/kthread.c:292) 
[   55.956578] ? kthread_park (kbuild/src/consumer/kernel/kthread.c:245) 
[   55.960274] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:302) 
[   55.963927]
[   55.965438] ======================================================
[   55.971641] WARNING: possible circular locking dependency detected
[   55.977848] 5.11.0-rc6-00001-g00003c0265c6 #1 Tainted: G        W
[   55.984661] ------------------------------------------------------
[   55.990866] kworker/u9:0/99 is trying to acquire lock:
[   55.996023] ffff888816a58c60 (sk_lock-AF_INET-RPC){+.+.}-{0:0}, at: tcp_sock_set_nodelay (kbuild/src/consumer/net/ipv4/tcp.c:3160 kbuild/src/consumer/net/ipv4/tcp.c:3171) 
[   56.005023]
[   56.005023] but task is already holding lock:
[   56.010878] ffff888816a58f08 (k-clock-AF_INET){++..}-{2:2}, at: xs_tcp_setup_socket (kbuild/src/consumer/net/sunrpc/xprtsock.c:1094 kbuild/src/consumer/net/sunrpc/xprtsock.c:2171 kbuild/src/consumer/net/sunrpc/xprtsock.c:2250) 
[   56.019615]
[   56.019615] which lock already depends on the new lock.
[   56.019615]
[   56.027824]
[   56.027824] the existing dependency chain (in reverse order) is:
[   56.035343]
[   56.035343] -> #2 (k-clock-AF_INET){++..}-{2:2}:
[   56.041475] __lock_acquire (kbuild/src/consumer/kernel/locking/lockdep.c:4832) 
[   56.045852] lock_acquire (kbuild/src/consumer/kernel/locking/lockdep.c:437 kbuild/src/consumer/kernel/locking/lockdep.c:5444 kbuild/src/consumer/kernel/locking/lockdep.c:5407) 
[   56.049964] _raw_read_lock_bh (kbuild/src/consumer/include/linux/rwlock_api_smp.h:177 kbuild/src/consumer/kernel/locking/spinlock.c:247) 
[   56.054426] sock_i_uid (kbuild/src/consumer/net/core/sock.c:2174) 
[   56.058283] inet_csk_update_fastreuse (kbuild/src/consumer/net/ipv4/inet_connection_sock.c:302) 
[   56.063542] inet_csk_get_port (kbuild/src/consumer/net/ipv4/inet_connection_sock.c:400) 
[   56.068178] __inet_bind (kbuild/src/consumer/net/ipv4/af_inet.c:528) 
[   56.072290] xs_bind (kbuild/src/consumer/net/sunrpc/xprtsock.c:1683) 
[   56.075969] xs_create_sock (kbuild/src/consumer/net/sunrpc/xprtsock.c:1792) 
[   56.080256] xs_tcp_setup_socket (kbuild/src/consumer/net/sunrpc/xprtsock.c:2235) 
[   56.085083] process_one_work (kbuild/src/consumer/arch/x86/include/asm/jump_label.h:25 kbuild/src/consumer/include/linux/jump_label.h:200 kbuild/src/consumer/include/trace/events/workqueue.h:108 kbuild/src/consumer/kernel/workqueue.c:2280) 
[   56.089633] worker_thread (kbuild/src/consumer/include/linux/list.h:282 kbuild/src/consumer/kernel/workqueue.c:2422) 
[   56.093832] kthread (kbuild/src/consumer/kernel/kthread.c:292) 
[   56.097597] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:302) 
[   56.101710]
[   56.101710] -> #1 (&tcp_hashinfo.bhash[i].lock){+.-.}-{2:2}:
[   56.108881] __lock_acquire (kbuild/src/consumer/kernel/locking/lockdep.c:4832) 
[   56.113276] lock_acquire (kbuild/src/consumer/kernel/locking/lockdep.c:437 kbuild/src/consumer/kernel/locking/lockdep.c:5444 kbuild/src/consumer/kernel/locking/lockdep.c:5407) 
[   56.117394] _raw_spin_lock_bh (kbuild/src/consumer/include/linux/spinlock_api_smp.h:136 kbuild/src/consumer/kernel/locking/spinlock.c:175) 
[   56.121879] inet_csk_get_port (kbuild/src/consumer/net/ipv4/inet_connection_sock.c:377) 
[   56.126521] __inet_bind (kbuild/src/consumer/net/ipv4/af_inet.c:528) 
[   56.130644] xs_bind (kbuild/src/consumer/net/sunrpc/xprtsock.c:1683) 
[   56.134330] xs_create_sock (kbuild/src/consumer/net/sunrpc/xprtsock.c:1792) 
[   56.138633] xs_tcp_setup_socket (kbuild/src/consumer/net/sunrpc/xprtsock.c:2235) 
[   56.143462] process_one_work (kbuild/src/consumer/arch/x86/include/asm/jump_label.h:25 kbuild/src/consumer/include/linux/jump_label.h:200 kbuild/src/consumer/include/trace/events/workqueue.h:108 kbuild/src/consumer/kernel/workqueue.c:2280) 
[   56.148026] worker_thread (kbuild/src/consumer/include/linux/list.h:282 kbuild/src/consumer/kernel/workqueue.c:2422) 
[   56.152225] kthread (kbuild/src/consumer/kernel/kthread.c:292) 
[   56.155989] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:302) 
[   56.160106]
[   56.160106] -> #0 (sk_lock-AF_INET-RPC){+.+.}-{0:0}:
[   56.166575] check_prev_add (kbuild/src/consumer/kernel/locking/lockdep.c:2869) 
[   56.170860] validate_chain (kbuild/src/consumer/kernel/locking/lockdep.c:2994 kbuild/src/consumer/kernel/locking/lockdep.c:3608) 
[   56.175335] __lock_acquire (kbuild/src/consumer/kernel/locking/lockdep.c:4832) 
[   56.179711] lock_acquire (kbuild/src/consumer/kernel/locking/lockdep.c:437 kbuild/src/consumer/kernel/locking/lockdep.c:5444 kbuild/src/consumer/kernel/locking/lockdep.c:5407) 
[   56.183823] lock_sock_nested (kbuild/src/consumer/include/linux/bottom_half.h:32 kbuild/src/consumer/net/core/sock.c:3058) 
[   56.188197] tcp_sock_set_nodelay (kbuild/src/consumer/net/ipv4/tcp.c:3160 kbuild/src/consumer/net/ipv4/tcp.c:3171) 
[   56.192920] xs_tcp_setup_socket (kbuild/src/consumer/arch/x86/include/asm/bitops.h:75 kbuild/src/consumer/include/asm-generic/bitops/instrumented-atomic.h:42 kbuild/src/consumer/include/linux/sunrpc/xprt.h:431 kbuild/src/consumer/net/sunrpc/xprtsock.c:2184 kbuild/src/consumer/net/sunrpc/xprtsock.c:2250) 
[   56.197731] process_one_work (kbuild/src/consumer/arch/x86/include/asm/jump_label.h:25 kbuild/src/consumer/include/linux/jump_label.h:200 kbuild/src/consumer/include/trace/events/workqueue.h:108 kbuild/src/consumer/kernel/workqueue.c:2280) 
[   56.202290] worker_thread (kbuild/src/consumer/include/linux/list.h:282 kbuild/src/consumer/kernel/workqueue.c:2422) 
[   56.206490] kthread (kbuild/src/consumer/kernel/kthread.c:292) 
[   56.210256] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:302) 
[   56.214383]
[   56.214383] other info that might help us debug this:
[   56.214383]
[   56.222428] Chain exists of:
[   56.222428]   sk_lock-AF_INET-RPC --> &tcp_hashinfo.bhash[i].lock --> k-clock-AF_INET
[   56.222428]
[   56.234656]  Possible unsafe locking scenario:
[   56.234656]
[   56.240602]        CPU0                    CPU1
[   56.245148]        ----                    ----
[   56.249708]   lock(k-clock-AF_INET);
[   56.253296]                                lock(&tcp_hashinfo.bhash[i].lock);
[   56.260492]                                lock(k-clock-AF_INET);
[   56.266612]   lock(sk_lock-AF_INET-RPC);
[   56.270549]
[   56.270549]  *** DEADLOCK ***
[   56.270549]
[   56.276491] 3 locks held by kworker/u9:0/99:
[   56.280779] #0: ffff888101615938 ((wq_completion)xprtiod){+.+.}-{0:0}, at: process_one_work (kbuild/src/consumer/arch/x86/include/asm/atomic64_64.h:34 kbuild/src/consumer/include/asm-generic/atomic-instrumented.h:856 kbuild/src/consumer/include/asm-generic/atomic-long.h:41 kbuild/src/consumer/kernel/workqueue.c:616 kbuild/src/consumer/kernel/workqueue.c:643 kbuild/src/consumer/kernel/workqueue.c:2246) 
[   56.290305] #1: ffffc90000807e58 ((work_completion)(&(&transport->connect_worker)->work)){+.+.}-{0:0}, at: process_one_work (kbuild/src/consumer/arch/x86/include/asm/atomic64_64.h:34 kbuild/src/consumer/include/asm-generic/atomic-instrumented.h:856 kbuild/src/consumer/include/asm-generic/atomic-long.h:41 kbuild/src/consumer/kernel/workqueue.c:616 kbuild/src/consumer/kernel/workqueue.c:643 kbuild/src/consumer/kernel/workqueue.c:2246) 
[   56.302632] #2: ffff888816a58f08 (k-clock-AF_INET){++..}-{2:2}, at: xs_tcp_setup_socket (kbuild/src/consumer/net/sunrpc/xprtsock.c:1094 kbuild/src/consumer/net/sunrpc/xprtsock.c:2171 kbuild/src/consumer/net/sunrpc/xprtsock.c:2250) 
[   56.311810]
[   56.311810] stack backtrace:
[   56.316183] CPU: 2 PID: 99 Comm: kworker/u9:0 Tainted: G        W         5.11.0-rc6-00001-g00003c0265c6 #1
[   56.325963] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[   56.333388] Workqueue: xprtiod xs_tcp_setup_socket
[   56.338202] Call Trace:
[   56.340658] dump_stack (kbuild/src/consumer/lib/dump_stack.c:122) 
[   56.343988] check_noncircular (kbuild/src/consumer/kernel/locking/lockdep.c:2120) 
[   56.348016] ? save_trace (kbuild/src/consumer/kernel/locking/lockdep.c:554) 
[   56.351613] check_prev_add (kbuild/src/consumer/kernel/locking/lockdep.c:2869) 
[   56.355385] validate_chain (kbuild/src/consumer/kernel/locking/lockdep.c:2994 kbuild/src/consumer/kernel/locking/lockdep.c:3608) 
[   56.359344] __lock_acquire (kbuild/src/consumer/kernel/locking/lockdep.c:4832) 
[   56.363217] lock_acquire (kbuild/src/consumer/kernel/locking/lockdep.c:437 kbuild/src/consumer/kernel/locking/lockdep.c:5444 kbuild/src/consumer/kernel/locking/lockdep.c:5407) 
[   56.366810] ? tcp_sock_set_nodelay (kbuild/src/consumer/net/ipv4/tcp.c:3160 kbuild/src/consumer/net/ipv4/tcp.c:3171) 
[   56.371195] lock_sock_nested (kbuild/src/consumer/include/linux/bottom_half.h:32 kbuild/src/consumer/net/core/sock.c:3058) 
[   56.375055] ? tcp_sock_set_nodelay (kbuild/src/consumer/net/ipv4/tcp.c:3160 kbuild/src/consumer/net/ipv4/tcp.c:3171) 
[   56.379434] tcp_sock_set_nodelay (kbuild/src/consumer/net/ipv4/tcp.c:3160 kbuild/src/consumer/net/ipv4/tcp.c:3171) 
[   56.383633] xs_tcp_setup_socket (kbuild/src/consumer/arch/x86/include/asm/bitops.h:75 kbuild/src/consumer/include/asm-generic/bitops/instrumented-atomic.h:42 kbuild/src/consumer/include/linux/sunrpc/xprt.h:431 kbuild/src/consumer/net/sunrpc/xprtsock.c:2184 kbuild/src/consumer/net/sunrpc/xprtsock.c:2250) 
[   56.387927] process_one_work (kbuild/src/consumer/arch/x86/include/asm/jump_label.h:25 kbuild/src/consumer/include/linux/jump_label.h:200 kbuild/src/consumer/include/trace/events/workqueue.h:108 kbuild/src/consumer/kernel/workqueue.c:2280) 
[   56.391955] worker_thread (kbuild/src/consumer/include/linux/list.h:282 kbuild/src/consumer/kernel/workqueue.c:2422) 
[   56.395633] ? process_one_work (kbuild/src/consumer/kernel/workqueue.c:2364) 
[   56.399835] kthread (kbuild/src/consumer/kernel/kthread.c:292) 
[   56.403080] ? kthread_park (kbuild/src/consumer/kernel/kthread.c:245) 
[   56.406758] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:302) 


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml
        bin/lkp run                    compatible-job.yaml



Thanks,
Oliver Sang


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.11.0-rc6-00001-g00003c0265c6"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.11.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
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
CONFIG_USELIB=y
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

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
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
# CONFIG_CGROUP_RDMA is not set
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
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
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
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_512GB=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
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
CONFIG_GART_IOMMU=y
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
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
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
CONFIG_ARCH_MEMORY_PROBE=y
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
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
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
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
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
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
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
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
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
CONFIG_X86_PCC_CPUFREQ=m
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
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
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
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
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
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y

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
# CONFIG_UNUSED_SYMBOLS is not set
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
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
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
# CONFIG_IOSCHED_BFQ is not set
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
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
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
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
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
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
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
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
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
# CONFIG_INET6_ESP_OFFLOAD is not set
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
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
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
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
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
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
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
CONFIG_NETFILTER_XT_TARGET_LED=m
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
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
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
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
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
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

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
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
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
CONFIG_IP_NF_TARGET_CLUSTERIP=m
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
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
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
CONFIG_IP6_NF_TARGET_HL=m
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
# CONFIG_NF_TABLES_BRIDGE is not set
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
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
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
CONFIG_HAVE_NET_DSA=y
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
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
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
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

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
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
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
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
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
CONFIG_BT_CMTP=m
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
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
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
CONFIG_NET_9P_VIRTIO=m
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
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
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

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
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

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
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
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
# CONFIG_ZRAM_WRITEBACK is not set
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
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
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
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
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
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
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
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
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
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
CONFIG_PATA_ACPI=m
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
# CONFIG_MD_CLUSTER is not set
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
# CONFIG_DM_WRITECACHE is not set
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
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

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
CONFIG_BONDING=m
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=y
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
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
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_LXT_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_GPIO is not set
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
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
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
CONFIG_USB_NET_CDCETHER=m
# CONFIG_USB_NET_CDC_EEM is not set
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
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
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_USB_RTL8153_ECM is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
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
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

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
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
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
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
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
# CONFIG_KEYBOARD_ADC is not set
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
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

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
CONFIG_SERIAL_8250_NR_UARTS=32
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
# CONFIG_SERIAL_IFX6X60 is not set
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
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
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
CONFIG_HW_RANDOM_VIRTIO=m
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
# CONFIG_I2C_MUX_MLXCPLD is not set
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
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
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
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
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
CONFIG_DP83640_PHY=m
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
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
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
# CONFIG_GPIO_XILINX is not set
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
CONFIG_GPIO_VIPERBOARD=m
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
# CONFIG_GENERIC_ADC_BATTERY is not set
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
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
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
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
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
# CONFIG_SENSORS_TC654 is not set
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
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
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

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
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
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
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
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
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
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

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
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
CONFIG_TTPCI_EEPROM=m
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
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
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TDA1997X is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
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
CONFIG_VIDEO_SAA711X=m
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
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
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
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
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
CONFIG_VIDEO_M52790=m
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
# CONFIG_CXD2880_SPI_DRV is not set
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
# CONFIG_MEDIA_TUNER_MSI001 is not set
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
# CONFIG_MEDIA_TUNER_MXL301RF is not set
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
# CONFIG_DVB_S5H1432 is not set
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
# CONFIG_DVB_DIB9000 is not set
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
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

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
# CONFIG_DVB_MN88443X is not set

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
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
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
CONFIG_DRM_I915_WERROR=y
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_DEBUG_GEM is not set
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
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
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
# CONFIG_FB_INTEL is not set
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

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=m
# CONFIG_SND_SOC_INTEL_CATPT is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4234 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373_I2C is not set
CONFIG_SND_SOC_MAX98390=m
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM5102A is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8315 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

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
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
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
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
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
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
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
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
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
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

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
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
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
# CONFIG_LEDS_MLXCPLD is not set
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
# CONFIG_LEDS_TRIGGER_MTD is not set
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
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
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
CONFIG_RTC_DRV_RV3029_HWMON=y
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
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
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

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_LCD2S is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
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
CONFIG_VIRTIO=m
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
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
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
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
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_QLGE=m
# CONFIG_WIMAX is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
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
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
# CONFIG_DELL_WMI_SYSMAN is not set
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
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
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
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
CONFIG_ACPI_TOSHIBA=m
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
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PMT_CLASS is not set
# CONFIG_INTEL_PMT_TELEMETRY is not set
# CONFIG_INTEL_PMT_CRASHLOG is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
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
# CONFIG_HWSPINLOCK is not set

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
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_AD9467 is not set
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS290 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9310 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
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
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
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

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
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
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
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
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
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
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
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
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
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
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

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
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
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
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
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
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
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
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
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
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
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
# CONFIG_CRC7 is not set
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
CONFIG_BTREE=y
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
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
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
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
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
CONFIG_DEBUG_RODATA_TEST=y
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
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
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
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
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
# CONFIG_IOMMU_DEBUG is not set
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
CONFIG_X86_DEBUG_FPU=y
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
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-7.6-kselftests'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d05'
	export tbox_group='lkp-skl-d05'
	export submit_id='602940e3c8fde0d67e5e734e'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-tc-testing-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9-20210214-54910-gp5fz9-1.yaml'
	export id='09c9f8c5b2dbc31a2434023421d2c4f62b63c5b3'
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
	export commit='00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export ucode='0xe2'
	export need_linux_headers=true
	export need_linux_selftests=true
	export need_kconfig='CONFIG_BLOCK=y
CONFIG_BTRFS_FS=m
CONFIG_EFI=y
CONFIG_EFIVAR_FS
CONFIG_FTRACE=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT
CONFIG_NOTIFIER_ERROR_INJECTION
CONFIG_RC_CORE=m ~ ">= v4.14-rc1"
CONFIG_RC_DECODERS=y
CONFIG_RC_DEVICES=y
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_STAGING=y
CONFIG_SYNC_FILE=y
CONFIG_TEST_FIRMWARE
CONFIG_TEST_KMOD=m
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY
CONFIG_TUN=m
CONFIG_XFS_FS=m'
	export enqueue_time='2021-02-14 23:25:24 +0800'
	export _id='602940e3c8fde0d67e5e734e'
	export _rt='/result/kernel-selftests/tc-testing-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='2c02aec46c87d4959c3ae7435b58cae94af3126f'
	export base_commit='92bf22614b21a2706f4993b278017e437f7785b3'
	export branch='linux-review/trondmy-kernel-org/SUNRPC-Set-TCP_CORK-until-the-transmit-queue-is-empty/20210213-054525'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/tc-testing-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/3'
	export scheduler_version='/lkp/lkp/.src-20210210-104238'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-tc-testing-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9-20210214-54910-gp5fz9-1.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6-kselftests
branch=linux-review/trondmy-kernel-org/SUNRPC-Set-TCP_CORK-until-the-transmit-queue-is-empty/20210213-054525
commit=00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/vmlinuz-5.11.0-rc6-00001-g00003c0265c6
erst_disable
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/tc-testing-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20201231.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-b553cffa-1_20210122.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.11.0-rc7-08739-g2c02aec46c87'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/vmlinuz-5.11.0-rc6-00001-g00003c0265c6'
	export dequeue_time='2021-02-14 23:33:29 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-tc-testing-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9-20210214-54910-gp5fz9-1.cgz'

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

	run_test group='tc-testing' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='tc-testing' $LKP_SRC/stats/wrapper kernel-selftests
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

--3uo+9/B/ebqu+fSQ
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
XdWxxGf7AgAAAAAEWVo=

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7.6-kselftests-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9
2021-02-14 15:35:10 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2021-02-14 15:35:10 make run_tests -C tc-testing
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/tools/testing/selftests/tc-testing'
make --no-builtin-rules ARCH=x86 -C /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9 headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9'
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
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/rkisp1-config.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/rpmsg_types.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/cifs/cifs_netlink.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/f2fs.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/sgx.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/bootparam.h
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
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9'
clang -I. -I/include/uapi -idirafter /usr/local/include -idirafter /lib/clang/12.0.0/include -idirafter /usr/include/x86_64-linux-gnu -idirafter /include -idirafter /usr/include -Wno-compare-distinct-pointer-types \
	 -O2 -target bpf -emit-llvm -c action.c -o - |      \
llc -march=bpf -mcpu=probe  -filetype=obj -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/tools/testing/selftests/tc-testing/action.o
TAP version 13
1..1
# selftests: tc-testing: tdc.sh
# considering category actions
#  -- buildebpf/SubPlugin.__init__
# Test 2b11: Add tunnel_key set action with mandatory parameters
# Test dc6b: Add tunnel_key set action with missing mandatory src_ip parameter
# Test 7f25: Add tunnel_key set action with missing mandatory dst_ip parameter
# Test a5e0: Add tunnel_key set action with invalid src_ip parameter
# Test eaa8: Add tunnel_key set action with invalid dst_ip parameter
# Test 3b09: Add tunnel_key set action with invalid id parameter
# Test 9625: Add tunnel_key set action with invalid dst_port parameter
# Test 05af: Add tunnel_key set action with optional dst_port parameter
# Test da80: Add tunnel_key set action with index at 32-bit maximum
# Test d407: Add tunnel_key set action with index exceeding 32-bit maximum
# Test 5cba: Add tunnel_key set action with id value at 32-bit maximum
# Test e84a: Add tunnel_key set action with id value exceeding 32-bit maximum
# Test 9c19: Add tunnel_key set action with dst_port value at 16-bit maximum
# Test 3bd9: Add tunnel_key set action with dst_port value exceeding 16-bit maximum
# Test 68e2: Add tunnel_key unset action
# Test 6192: Add tunnel_key unset continue action
# Test 061d: Add tunnel_key set continue action with cookie
# Test 8acb: Add tunnel_key set continue action with invalid cookie
# Test a07e: Add tunnel_key action with no set/unset command specified
# Test b227: Add tunnel_key action with csum option
# Test 58a7: Add tunnel_key action with nocsum option
# Test 2575: Add tunnel_key action with not-supported parameter
# Test 7a88: Add tunnel_key action with cookie parameter
# Test 4f20: Add tunnel_key action with a single geneve option parameter
# Test e33d: Add tunnel_key action with multiple geneve options parameter
# Test 0778: Add tunnel_key action with invalid class geneve option parameter
# Test 4ae8: Add tunnel_key action with invalid type geneve option parameter
# Test 4039: Add tunnel_key action with short data length geneve option parameter
# Test 26a6: Add tunnel_key action with non-multiple of 4 data length geneve option parameter
# Test f44d: Add tunnel_key action with incomplete geneve options parameter
# Test 7afc: Replace tunnel_key set action with all parameters
# Test 364d: Replace tunnel_key set action with all parameters and cookie
# Test 937c: Fetch all existing tunnel_key actions
# Test 6783: Flush all existing tunnel_key actions
# Test 8242: Replace tunnel_key set action with invalid goto chain
# Test 0cd2: Add tunnel_key set action with no_percpu flag
# exit: 255
# exit: 0
# Bad action type no_percpu
# Usage: ... gact <ACTION> [RAND] [INDEX]
# Where: 	ACTION := reclassify | drop | continue | pass | pipe |
#        	          goto chain <CHAIN_INDEX> | jump <JUMP_COUNT>
# 	RAND := random <RANDTYPE> <ACTION> <VAL>
# 	RANDTYPE := netrand | determ
# 	VAL : = value not exceeding 10000
# 	JUMP_COUNT := Absolute jump from start of action list
# 	INDEX := index value used
# 
# 
# Test 6236: Add skbedit action with valid mark
# Test c8cf: Add skbedit action with 32-bit maximum mark
# Test 407b: Add skbedit action with mark exceeding 32-bit maximum
# Test d4cd: Add skbedit action with valid mark and mask
# exit: 255
# exit: 0
# Illegal mark
# bad action parsing
# parse_action: bad value (3:skbedit)!
# Illegal "action"
# 
# Test baa7: Add skbedit action with valid mark and 32-bit maximum mask
# exit: 255
# exit: 0
# Illegal mark
# bad action parsing
# parse_action: bad value (3:skbedit)!
# Illegal "action"
# 
# Test 62a5: Add skbedit action with valid mark and mask exceeding 32-bit maximum
# Test bc15: Add skbedit action with valid mark and mask with invalid format
# Test 57c2: Replace skbedit action with new mask
# returncode 255; expected [0]
# "-----> prepare stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('setup', None, '"-----> prepare stage" did not complete successfully') (caught in test_runner, running test 45 57c2 Replace skbedit action with new mask stage setup)
# ---------------
# traceback
# ---------------
# ---------------
# 
# All test results: 
# 
# 1..489
# ok 1 2b11 - Add tunnel_key set action with mandatory parameters
# ok 2 dc6b - Add tunnel_key set action with missing mandatory src_ip parameter
# ok 3 7f25 - Add tunnel_key set action with missing mandatory dst_ip parameter
# ok 4 a5e0 - Add tunnel_key set action with invalid src_ip parameter
# ok 5 eaa8 - Add tunnel_key set action with invalid dst_ip parameter
# ok 6 3b09 - Add tunnel_key set action with invalid id parameter
# ok 7 9625 - Add tunnel_key set action with invalid dst_port parameter
# ok 8 05af - Add tunnel_key set action with optional dst_port parameter
# ok 9 da80 - Add tunnel_key set action with index at 32-bit maximum
# ok 10 d407 - Add tunnel_key set action with index exceeding 32-bit maximum
# ok 11 5cba - Add tunnel_key set action with id value at 32-bit maximum
# ok 12 e84a - Add tunnel_key set action with id value exceeding 32-bit maximum
# ok 13 9c19 - Add tunnel_key set action with dst_port value at 16-bit maximum
# ok 14 3bd9 - Add tunnel_key set action with dst_port value exceeding 16-bit maximum
# ok 15 68e2 - Add tunnel_key unset action
# ok 16 6192 - Add tunnel_key unset continue action
# ok 17 061d - Add tunnel_key set continue action with cookie
# ok 18 8acb - Add tunnel_key set continue action with invalid cookie
# ok 19 a07e - Add tunnel_key action with no set/unset command specified
# ok 20 b227 - Add tunnel_key action with csum option
# ok 21 58a7 - Add tunnel_key action with nocsum option
# ok 22 2575 - Add tunnel_key action with not-supported parameter
# ok 23 7a88 - Add tunnel_key action with cookie parameter
# ok 24 4f20 - Add tunnel_key action with a single geneve option parameter
# ok 25 e33d - Add tunnel_key action with multiple geneve options parameter
# ok 26 0778 - Add tunnel_key action with invalid class geneve option parameter
# ok 27 4ae8 - Add tunnel_key action with invalid type geneve option parameter
# ok 28 4039 - Add tunnel_key action with short data length geneve option parameter
# ok 29 26a6 - Add tunnel_key action with non-multiple of 4 data length geneve option parameter
# ok 30 f44d - Add tunnel_key action with incomplete geneve options parameter
# ok 31 7afc - Replace tunnel_key set action with all parameters
# ok 32 364d - Replace tunnel_key set action with all parameters and cookie
# ok 33 937c - Fetch all existing tunnel_key actions
# ok 34 6783 - Flush all existing tunnel_key actions
# ok 35 8242 - Replace tunnel_key set action with invalid goto chain
# not ok 36 0cd2 - Add tunnel_key set action with no_percpu flag
# 	Command exited with 255, expected 0
# Bad action type no_percpu
# Usage: ... gact <ACTION> [RAND] [INDEX]
# Where: 	ACTION := reclassify | drop | continue | pass | pipe |
#        	          goto chain <CHAIN_INDEX> | jump <JUMP_COUNT>
# 	RAND := random <RANDTYPE> <ACTION> <VAL>
# 	RANDTYPE := netrand | determ
# 	VAL : = value not exceeding 10000
# 	JUMP_COUNT := Absolute jump from start of action list
# 	INDEX := index value used
# 
# 
# ok 37 6236 - Add skbedit action with valid mark
# ok 38 c8cf - Add skbedit action with 32-bit maximum mark
# ok 39 407b - Add skbedit action with mark exceeding 32-bit maximum
# not ok 40 d4cd - Add skbedit action with valid mark and mask
# 	Command exited with 255, expected 0
# Illegal mark
# bad action parsing
# parse_action: bad value (3:skbedit)!
# Illegal "action"
# 
# not ok 41 baa7 - Add skbedit action with valid mark and 32-bit maximum mask
# 	Command exited with 255, expected 0
# Illegal mark
# bad action parsing
# parse_action: bad value (3:skbedit)!
# Illegal "action"
# 
# ok 42 62a5 - Add skbedit action with valid mark and mask exceeding 32-bit maximum
# ok 43 bc15 - Add skbedit action with valid mark and mask with invalid format
# ok 44 57c2 - Replace skbedit action with new mask # skipped - "-----> prepare stage" did not complete successfully
# 
# ok 45 081d - Add skbedit action with priority # skipped - skipped - previous setup failed 45 57c2
# 
# ok 46 cc37 - Add skbedit action with invalid priority # skipped - skipped - previous setup failed 45 57c2
# 
# ok 47 3c95 - Add skbedit action with queue_mapping # skipped - skipped - previous setup failed 45 57c2
# 
# ok 48 985c - Add skbedit action with queue_mapping exceeding 16-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 49 224f - Add skbedit action with ptype host # skipped - skipped - previous setup failed 45 57c2
# 
# ok 50 d1a3 - Add skbedit action with ptype otherhost # skipped - skipped - previous setup failed 45 57c2
# 
# ok 51 b9c6 - Add skbedit action with invalid ptype # skipped - skipped - previous setup failed 45 57c2
# 
# ok 52 464a - Add skbedit action with control pipe # skipped - skipped - previous setup failed 45 57c2
# 
# ok 53 212f - Add skbedit action with control reclassify # skipped - skipped - previous setup failed 45 57c2
# 
# ok 54 0651 - Add skbedit action with control pass # skipped - skipped - previous setup failed 45 57c2
# 
# ok 55 cc53 - Add skbedit action with control drop # skipped - skipped - previous setup failed 45 57c2
# 
# ok 56 ec16 - Add skbedit action with control jump # skipped - skipped - previous setup failed 45 57c2
# 
# ok 57 db54 - Add skbedit action with control continue # skipped - skipped - previous setup failed 45 57c2
# 
# ok 58 1055 - Add skbedit action with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 59 5172 - List skbedit actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 60 a6d6 - Add skbedit action with index at 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 61 f0f4 - Add skbedit action with index exceeding 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 62 38f3 - Delete skbedit action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 63 ce97 - Flush skbedit actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 64 1b2b - Replace skbedit action with invalid goto_chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 65 630c - Add batch of 32 skbedit actions with all parameters and cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 66 706d - Delete batch of 32 skbedit actions with all parameters # skipped - skipped - previous setup failed 45 57c2
# 
# ok 67 b078 - Add simple action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 68 6d4c - Add simple action with duplicate index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 69 2542 - List simple actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 70 ea67 - Delete simple action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 71 8ff1 - Flush simple actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 72 b776 - Replace simple action with invalid goto chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 73 696a - Add simple ct action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 74 e38c - Add simple ct action with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 75 9f20 - Add ct clear action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 76 0bc1 - Add ct clear action with cookie of max length # skipped - skipped - previous setup failed 45 57c2
# 
# ok 77 5bea - Try ct with zone # skipped - skipped - previous setup failed 45 57c2
# 
# ok 78 d5d6 - Try ct with zone, commit # skipped - skipped - previous setup failed 45 57c2
# 
# ok 79 029f - Try ct with zone, commit, mark # skipped - skipped - previous setup failed 45 57c2
# 
# ok 80 a58d - Try ct with zone, commit, mark, nat # skipped - skipped - previous setup failed 45 57c2
# 
# ok 81 901b - Try ct with full nat ipv4 range syntax # skipped - skipped - previous setup failed 45 57c2
# 
# ok 82 072b - Try ct with full nat ipv6 syntax # skipped - skipped - previous setup failed 45 57c2
# 
# ok 83 3420 - Try ct with full nat ipv6 range syntax # skipped - skipped - previous setup failed 45 57c2
# 
# ok 84 4470 - Try ct with full nat ipv6 range syntax + force # skipped - skipped - previous setup failed 45 57c2
# 
# ok 85 5d88 - Try ct with label # skipped - skipped - previous setup failed 45 57c2
# 
# ok 86 04d4 - Try ct with label with mask # skipped - skipped - previous setup failed 45 57c2
# 
# ok 87 9751 - Try ct with mark + mask # skipped - skipped - previous setup failed 45 57c2
# 
# ok 88 2faa - Try ct with mark + mask and cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 89 3991 - Add simple ct action with no_percpu flag # skipped - skipped - previous setup failed 45 57c2
# 
# ok 90 a933 - Add MPLS dec_ttl action with pipe opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 91 08d1 - Add mpls dec_ttl action with pass opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 92 d786 - Add mpls dec_ttl action with drop opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 93 f334 - Add mpls dec_ttl action with reclassify opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 94 29bd - Add mpls dec_ttl action with continue opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 95 48df - Add mpls dec_ttl action with jump opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 96 62eb - Add mpls dec_ttl action with trap opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 97 09d2 - Add mpls dec_ttl action with opcode and cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 98 c170 - Add mpls dec_ttl action with opcode and cookie of max length # skipped - skipped - previous setup failed 45 57c2
# 
# ok 99 9118 - Add mpls dec_ttl action with invalid opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 100 6ce1 - Add mpls dec_ttl action with label (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 101 352f - Add mpls dec_ttl action with tc (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 102 fa1c - Add mpls dec_ttl action with ttl (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 103 6b79 - Add mpls dec_ttl action with bos (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 104 d4c4 - Add mpls pop action with ip proto # skipped - skipped - previous setup failed 45 57c2
# 
# ok 105 91fb - Add mpls pop action with ip proto and cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 106 92fe - Add mpls pop action with mpls proto # skipped - skipped - previous setup failed 45 57c2
# 
# ok 107 7e23 - Add mpls pop action with no protocol (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 108 6182 - Add mpls pop action with label (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 109 6475 - Add mpls pop action with tc (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 110 067b - Add mpls pop action with ttl (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 111 7316 - Add mpls pop action with bos (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 112 38cc - Add mpls push action with label # skipped - skipped - previous setup failed 45 57c2
# 
# ok 113 c281 - Add mpls push action with mpls_mc protocol # skipped - skipped - previous setup failed 45 57c2
# 
# ok 114 5db4 - Add mpls push action with label, tc and ttl # skipped - skipped - previous setup failed 45 57c2
# 
# ok 115 7c34 - Add mpls push action with label, tc ttl and cookie of max length # skipped - skipped - previous setup failed 45 57c2
# 
# ok 116 16eb - Add mpls push action with label and bos # skipped - skipped - previous setup failed 45 57c2
# 
# ok 117 d69d - Add mpls push action with no label (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 118 e8e4 - Add mpls push action with ipv4 protocol (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 119 ecd0 - Add mpls push action with out of range label (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 120 d303 - Add mpls push action with out of range tc (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 121 fd6e - Add mpls push action with ttl of 0 (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 122 19e9 - Add mpls mod action with mpls label # skipped - skipped - previous setup failed 45 57c2
# 
# ok 123 1fde - Add mpls mod action with max mpls label # skipped - skipped - previous setup failed 45 57c2
# 
# ok 124 0c50 - Add mpls mod action with mpls label exceeding max (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 125 10b6 - Add mpls mod action with mpls label of MPLS_LABEL_IMPLNULL (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 126 57c9 - Add mpls mod action with mpls min tc # skipped - skipped - previous setup failed 45 57c2
# 
# ok 127 6872 - Add mpls mod action with mpls max tc # skipped - skipped - previous setup failed 45 57c2
# 
# ok 128 a70a - Add mpls mod action with mpls tc exceeding max (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 129 6ed5 - Add mpls mod action with mpls ttl # skipped - skipped - previous setup failed 45 57c2
# 
# ok 130 77c1 - Add mpls mod action with mpls ttl and cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 131 b80f - Add mpls mod action with mpls max ttl # skipped - skipped - previous setup failed 45 57c2
# 
# ok 132 8864 - Add mpls mod action with mpls min ttl # skipped - skipped - previous setup failed 45 57c2
# 
# ok 133 6c06 - Add mpls mod action with mpls ttl of 0 (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 134 b5d8 - Add mpls mod action with mpls ttl exceeding max (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 135 451f - Add mpls mod action with mpls max bos # skipped - skipped - previous setup failed 45 57c2
# 
# ok 136 a1ed - Add mpls mod action with mpls min bos # skipped - skipped - previous setup failed 45 57c2
# 
# ok 137 3dcf - Add mpls mod action with mpls bos exceeding max (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 138 db7c - Add mpls mod action with protocol (invalid) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 139 b070 - Replace existing mpls push action with new ID # skipped - skipped - previous setup failed 45 57c2
# 
# ok 140 95a9 - Replace existing mpls push action with new label, tc, ttl and cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 141 6cce - Delete mpls pop action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 142 d138 - Flush mpls actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 143 6d84 - Add csum iph action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 144 1862 - Add csum ip4h action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 145 15c6 - Add csum ipv4h action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 146 bf47 - Add csum icmp action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 147 cc1d - Add csum igmp action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 148 bccc - Add csum foobar action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 149 3bb4 - Add csum tcp action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 150 759c - Add csum udp action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 151 bdb6 - Add csum udp xor iph action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 152 c220 - Add csum udplite action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 153 8993 - Add csum sctp action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 154 b138 - Add csum ip & icmp action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 155 eeda - Add csum ip & sctp action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 156 0017 - Add csum udp or tcp action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 157 b10b - Add all 7 csum actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 158 ce92 - Add csum udp action with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 159 912f - Add csum icmp action with large cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 160 879b - Add batch of 32 csum tcp actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 161 b4e9 - Delete batch of 32 csum actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 162 0015 - Add batch of 32 csum tcp actions with large cookies # skipped - skipped - previous setup failed 45 57c2
# 
# ok 163 989e - Delete batch of 32 csum actions with large cookies # skipped - skipped - previous setup failed 45 57c2
# 
# ok 164 d128 - Replace csum action with invalid goto chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 165 eaf0 - Add csum iph action with no_percpu flag # skipped - skipped - previous setup failed 45 57c2
# 
# ok 166 6f5a - Add vlan pop action with pipe opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 167 df35 - Add vlan pop action with pass opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 168 b0d4 - Add vlan pop action with drop opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 169 95ee - Add vlan pop action with reclassify opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 170 0283 - Add vlan pop action with continue opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 171 b6b9 - Add vlan pop action with jump opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 172 87c3 - Add vlan pop action with trap opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 173 a178 - Add vlan pop action with invalid opcode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 174 ee6f - Add vlan pop action with index at 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 175 0dfa - Add vlan pop action with index exceeding 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 176 2b91 - Add vlan invalid action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 177 57fc - Add vlan push action with invalid protocol type # skipped - skipped - previous setup failed 45 57c2
# 
# ok 178 3989 - Add vlan push action with default protocol and priority # skipped - skipped - previous setup failed 45 57c2
# 
# ok 179 79dc - Add vlan push action with protocol 802.1Q and priority 3 # skipped - skipped - previous setup failed 45 57c2
# 
# ok 180 4d73 - Add vlan push action with protocol 802.1AD # skipped - skipped - previous setup failed 45 57c2
# 
# ok 181 1f4b - Add vlan push action with maximum 12-bit vlan ID # skipped - skipped - previous setup failed 45 57c2
# 
# ok 182 1f7b - Add vlan push action with invalid vlan ID # skipped - skipped - previous setup failed 45 57c2
# 
# ok 183 fe40 - Add vlan push action with maximum 3-bit IEEE 802.1p priority # skipped - skipped - previous setup failed 45 57c2
# 
# ok 184 5d02 - Add vlan push action with invalid IEEE 802.1p priority # skipped - skipped - previous setup failed 45 57c2
# 
# ok 185 6812 - Add vlan modify action for protocol 802.1Q # skipped - skipped - previous setup failed 45 57c2
# 
# ok 186 5a31 - Add vlan modify action for protocol 802.1AD # skipped - skipped - previous setup failed 45 57c2
# 
# ok 187 3deb - Replace existing vlan push action with new ID # skipped - skipped - previous setup failed 45 57c2
# 
# ok 188 9e76 - Replace existing vlan push action with new protocol # skipped - skipped - previous setup failed 45 57c2
# 
# ok 189 ede4 - Replace existing vlan push action with new priority # skipped - skipped - previous setup failed 45 57c2
# 
# ok 190 d413 - Replace existing vlan pop action with new cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 191 83a4 - Delete vlan pop action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 192 ed1e - Delete vlan push action for protocol 802.1Q # skipped - skipped - previous setup failed 45 57c2
# 
# ok 193 a2a3 - Flush vlan actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 194 1d78 - Add vlan push action with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 195 e394 - Replace vlan push action with invalid goto chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 196 294e - Add batch of 32 vlan push actions with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 197 56f7 - Delete batch of 32 vlan push actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 198 759f - Add batch of 32 vlan pop actions with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 199 c84a - Delete batch of 32 vlan pop actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 200 1a3d - Add vlan pop action with no_percpu flag # skipped - skipped - previous setup failed 45 57c2
# 
# ok 201 7682 - Create valid ife encode action with mark and pass control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 202 ef47 - Create valid ife encode action with mark and pipe control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 203 df43 - Create valid ife encode action with mark and continue control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 204 e4cf - Create valid ife encode action with mark and drop control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 205 ccba - Create valid ife encode action with mark and reclassify control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 206 a1cf - Create valid ife encode action with mark and jump control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 207 cb3d - Create valid ife encode action with mark value at 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 208 1efb - Create ife encode action with mark value exceeding 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 209 95ed - Create valid ife encode action with prio and pass control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 210 aa17 - Create valid ife encode action with prio and pipe control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 211 74c7 - Create valid ife encode action with prio and continue control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 212 7a97 - Create valid ife encode action with prio and drop control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 213 f66b - Create valid ife encode action with prio and reclassify control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 214 3056 - Create valid ife encode action with prio and jump control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 215 7dd3 - Create valid ife encode action with prio value at 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 216 2ca1 - Create ife encode action with prio value exceeding 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 217 05bb - Create valid ife encode action with tcindex and pass control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 218 ce65 - Create valid ife encode action with tcindex and pipe control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 219 09cd - Create valid ife encode action with tcindex and continue control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 220 8eb5 - Create valid ife encode action with tcindex and continue control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 221 451a - Create valid ife encode action with tcindex and drop control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 222 d76c - Create valid ife encode action with tcindex and reclassify control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 223 e731 - Create valid ife encode action with tcindex and jump control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 224 b7b8 - Create valid ife encode action with tcindex value at 16-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 225 d0d8 - Create ife encode action with tcindex value exceeding 16-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 226 2a9c - Create valid ife encode action with mac src parameter # skipped - skipped - previous setup failed 45 57c2
# 
# ok 227 cf5c - Create valid ife encode action with mac dst parameter # skipped - skipped - previous setup failed 45 57c2
# 
# ok 228 2353 - Create valid ife encode action with mac src and mac dst parameters # skipped - skipped - previous setup failed 45 57c2
# 
# ok 229 552c - Create valid ife encode action with mark and type parameters # skipped - skipped - previous setup failed 45 57c2
# 
# ok 230 0421 - Create valid ife encode action with prio and type parameters # skipped - skipped - previous setup failed 45 57c2
# 
# ok 231 4017 - Create valid ife encode action with tcindex and type parameters # skipped - skipped - previous setup failed 45 57c2
# 
# ok 232 fac3 - Create valid ife encode action with index at 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 233 7c25 - Create valid ife decode action with pass control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 234 dccb - Create valid ife decode action with pipe control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 235 7bb9 - Create valid ife decode action with continue control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 236 d9ad - Create valid ife decode action with drop control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 237 219f - Create valid ife decode action with reclassify control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 238 8f44 - Create valid ife decode action with jump control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 239 56cf - Create ife encode action with index exceeding 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 240 ee94 - Create ife encode action with invalid control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 241 b330 - Create ife encode action with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 242 bbc0 - Create ife encode action with invalid argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 243 d54a - Create ife encode action with invalid type argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 244 7ee0 - Create ife encode action with invalid mac src argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 245 0a7d - Create ife encode action with invalid mac dst argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 246 a0e2 - Replace ife encode action with invalid goto chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 247 7d50 - Add skbmod action to set destination mac # skipped - skipped - previous setup failed 45 57c2
# 
# ok 248 9b29 - Add skbmod action to set source mac # skipped - skipped - previous setup failed 45 57c2
# 
# ok 249 1724 - Add skbmod action with invalid mac # skipped - skipped - previous setup failed 45 57c2
# 
# ok 250 3cf1 - Add skbmod action with valid etype # skipped - skipped - previous setup failed 45 57c2
# 
# ok 251 a749 - Add skbmod action with invalid etype # skipped - skipped - previous setup failed 45 57c2
# 
# ok 252 bfe6 - Add skbmod action to swap mac # skipped - skipped - previous setup failed 45 57c2
# 
# ok 253 839b - Add skbmod action with control pipe # skipped - skipped - previous setup failed 45 57c2
# 
# ok 254 c167 - Add skbmod action with control reclassify # skipped - skipped - previous setup failed 45 57c2
# 
# ok 255 0c2f - Add skbmod action with control drop # skipped - skipped - previous setup failed 45 57c2
# 
# ok 256 d113 - Add skbmod action with control continue # skipped - skipped - previous setup failed 45 57c2
# 
# ok 257 7242 - Add skbmod action with control pass # skipped - skipped - previous setup failed 45 57c2
# 
# ok 258 6046 - Add skbmod action with control reclassify and cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 259 58cb - List skbmod actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 260 9aa8 - Get a single skbmod action from a list # skipped - skipped - previous setup failed 45 57c2
# 
# ok 261 e93a - Delete an skbmod action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 262 40c2 - Flush skbmod actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 263 b651 - Replace skbmod action with invalid goto_chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 264 2002 - Add valid connmark action with defaults # skipped - skipped - previous setup failed 45 57c2
# 
# ok 265 56a5 - Add valid connmark action with control pass # skipped - skipped - previous setup failed 45 57c2
# 
# ok 266 7c66 - Add valid connmark action with control drop # skipped - skipped - previous setup failed 45 57c2
# 
# ok 267 a913 - Add valid connmark action with control pipe # skipped - skipped - previous setup failed 45 57c2
# 
# ok 268 bdd8 - Add valid connmark action with control reclassify # skipped - skipped - previous setup failed 45 57c2
# 
# ok 269 b8be - Add valid connmark action with control continue # skipped - skipped - previous setup failed 45 57c2
# 
# ok 270 d8a6 - Add valid connmark action with control jump # skipped - skipped - previous setup failed 45 57c2
# 
# ok 271 aae8 - Add valid connmark action with zone argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 272 2f0b - Add valid connmark action with invalid zone argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 273 9305 - Add connmark action with unsupported argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 274 71ca - Add valid connmark action and replace it # skipped - skipped - previous setup failed 45 57c2
# 
# ok 275 5f8f - Add valid connmark action with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 276 c506 - Replace connmark with invalid goto chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 277 7565 - Add nat action on ingress with default control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 278 fd79 - Add nat action on ingress with pipe control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 279 eab9 - Add nat action on ingress with continue control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 280 c53a - Add nat action on ingress with reclassify control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 281 76c9 - Add nat action on ingress with jump control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 282 24c6 - Add nat action on ingress with drop control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 283 2120 - Add nat action on ingress with maximum index value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 284 3e9d - Add nat action on ingress with invalid index value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 285 f6c9 - Add nat action on ingress with invalid IP address # skipped - skipped - previous setup failed 45 57c2
# 
# ok 286 be25 - Add nat action on ingress with invalid argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 287 a7bd - Add nat action on ingress with DEFAULT IP address # skipped - skipped - previous setup failed 45 57c2
# 
# ok 288 ee1e - Add nat action on ingress with ANY IP address # skipped - skipped - previous setup failed 45 57c2
# 
# ok 289 1de8 - Add nat action on ingress with ALL IP address # skipped - skipped - previous setup failed 45 57c2
# 
# ok 290 8dba - Add nat action on egress with default control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 291 19a7 - Add nat action on egress with pipe control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 292 f1d9 - Add nat action on egress with continue control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 293 6d4a - Add nat action on egress with reclassify control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 294 b313 - Add nat action on egress with jump control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 295 d9fc - Add nat action on egress with drop control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 296 a895 - Add nat action on egress with DEFAULT IP address # skipped - skipped - previous setup failed 45 57c2
# 
# ok 297 2572 - Add nat action on egress with ANY IP address # skipped - skipped - previous setup failed 45 57c2
# 
# ok 298 37f3 - Add nat action on egress with ALL IP address # skipped - skipped - previous setup failed 45 57c2
# 
# ok 299 6054 - Add nat action on egress with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 300 79d6 - Add nat action on ingress with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 301 4b12 - Replace nat action with invalid goto chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 302 49aa - Add valid basic police action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 303 3abe - Add police action with duplicate index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 304 49fa - Add valid police action with mtu # skipped - skipped - previous setup failed 45 57c2
# 
# ok 305 7943 - Add valid police action with peakrate # skipped - skipped - previous setup failed 45 57c2
# 
# ok 306 055e - Add police action with peakrate and no mtu # skipped - skipped - previous setup failed 45 57c2
# 
# ok 307 f057 - Add police action with valid overhead # skipped - skipped - previous setup failed 45 57c2
# 
# ok 308 7ffb - Add police action with ethernet linklayer type # skipped - skipped - previous setup failed 45 57c2
# 
# ok 309 3dda - Add police action with atm linklayer type # skipped - skipped - previous setup failed 45 57c2
# 
# ok 310 551b - Add police actions with conform-exceed control continue/drop # skipped - skipped - previous setup failed 45 57c2
# 
# ok 311 0c70 - Add police actions with conform-exceed control pass/reclassify # skipped - skipped - previous setup failed 45 57c2
# 
# ok 312 d946 - Add police actions with conform-exceed control pass/pipe # skipped - skipped - previous setup failed 45 57c2
# 
# ok 313 ddd6 - Add police action with invalid rate value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 314 f61c - Add police action with invalid burst value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 315 6aaf - Add police actions with conform-exceed control pass/pipe [with numeric values] # skipped - skipped - previous setup failed 45 57c2
# 
# ok 316 29b1 - Add police actions with conform-exceed control <invalid>/drop # skipped - skipped - previous setup failed 45 57c2
# 
# ok 317 c26f - Add police action with invalid peakrate value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 318 db04 - Add police action with invalid mtu value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 319 f3c9 - Add police action with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 320 d190 - Add police action with maximum index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 321 336e - Delete police action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 322 77fa - Get single police action from many actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 323 aa43 - Get single police action without specifying index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 324 858b - List police actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 325 1c3a - Flush police actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 326 7326 - Add police action with control continue # skipped - skipped - previous setup failed 45 57c2
# 
# ok 327 34fa - Add police action with control drop # skipped - skipped - previous setup failed 45 57c2
# 
# ok 328 8dd5 - Add police action with control ok # skipped - skipped - previous setup failed 45 57c2
# 
# ok 329 b9d1 - Add police action with control reclassify # skipped - skipped - previous setup failed 45 57c2
# 
# ok 330 c534 - Add police action with control pipe # skipped - skipped - previous setup failed 45 57c2
# 
# ok 331 b48b - Add police action with exceed goto chain control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 332 689e - Replace police action with invalid goto chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 333 d959 - Add cBPF action with valid bytecode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 334 f84a - Add cBPF action with invalid bytecode # skipped - skipped - previous setup failed 45 57c2
# 
# ok 335 e939 - Add eBPF action with valid object-file # skipped - skipped - previous setup failed 45 57c2
# 
# ok 336 282d - Add eBPF action with invalid object-file # skipped - skipped - previous setup failed 45 57c2
# 
# ok 337 d819 - Replace cBPF bytecode and action control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 338 6ae3 - Delete cBPF action  # skipped - skipped - previous setup failed 45 57c2
# 
# ok 339 3e0d - List cBPF actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 340 55ce - Flush BPF actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 341 ccc3 - Add cBPF action with duplicate index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 342 89c7 - Add cBPF action with invalid index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 343 7ab9 - Add cBPF action with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 344 b8a1 - Replace bpf action with invalid goto_chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 345 319a - Add pedit action that mangles IP TTL # skipped - skipped - previous setup failed 45 57c2
# 
# ok 346 7e67 - Replace pedit action with invalid goto chain # skipped - skipped - previous setup failed 45 57c2
# 
# ok 347 377e - Add pedit action with RAW_OP offset u32 # skipped - skipped - previous setup failed 45 57c2
# 
# ok 348 a0ca - Add pedit action with RAW_OP offset u32 (INVALID) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 349 dd8a - Add pedit action with RAW_OP offset u16 u16 # skipped - skipped - previous setup failed 45 57c2
# 
# ok 350 53db - Add pedit action with RAW_OP offset u16 (INVALID) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 351 5c7e - Add pedit action with RAW_OP offset u8 add value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 352 2893 - Add pedit action with RAW_OP offset u8 quad # skipped - skipped - previous setup failed 45 57c2
# 
# ok 353 3a07 - Add pedit action with RAW_OP offset u8-u16-u8 # skipped - skipped - previous setup failed 45 57c2
# 
# ok 354 ab0f - Add pedit action with RAW_OP offset u16-u8-u8 # skipped - skipped - previous setup failed 45 57c2
# 
# ok 355 9d12 - Add pedit action with RAW_OP offset u32 set u16 clear u8 invert # skipped - skipped - previous setup failed 45 57c2
# 
# ok 356 ebfa - Add pedit action with RAW_OP offset overflow u32 (INVALID) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 357 f512 - Add pedit action with RAW_OP offset u16 at offmask shift set # skipped - skipped - previous setup failed 45 57c2
# 
# ok 358 c2cb - Add pedit action with RAW_OP offset u32 retain value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 359 1762 - Add pedit action with RAW_OP offset u8 clear value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 360 bcee - Add pedit action with RAW_OP offset u8 retain value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 361 e89f - Add pedit action with RAW_OP offset u16 retain value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 362 c282 - Add pedit action with RAW_OP offset u32 clear value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 363 c422 - Add pedit action with RAW_OP offset u16 invert value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 364 d3d3 - Add pedit action with RAW_OP offset u32 invert value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 365 57e5 - Add pedit action with RAW_OP offset u8 preserve value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 366 99e0 - Add pedit action with RAW_OP offset u16 preserve value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 367 1892 - Add pedit action with RAW_OP offset u32 preserve value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 368 4b60 - Add pedit action with RAW_OP negative offset u16/u32 set value # skipped - skipped - previous setup failed 45 57c2
# 
# ok 369 a5a7 - Add pedit action with LAYERED_OP eth set src # skipped - skipped - previous setup failed 45 57c2
# 
# ok 370 86d4 - Add pedit action with LAYERED_OP eth set src & dst # skipped - skipped - previous setup failed 45 57c2
# 
# ok 371 f8a9 - Add pedit action with LAYERED_OP eth set dst # skipped - skipped - previous setup failed 45 57c2
# 
# ok 372 c715 - Add pedit action with LAYERED_OP eth set src (INVALID) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 373 8131 - Add pedit action with LAYERED_OP eth set dst (INVALID) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 374 ba22 - Add pedit action with LAYERED_OP eth type set/clear sequence # skipped - skipped - previous setup failed 45 57c2
# 
# ok 375 dec4 - Add pedit action with LAYERED_OP eth set type (INVALID) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 376 ab06 - Add pedit action with LAYERED_OP eth add type # skipped - skipped - previous setup failed 45 57c2
# 
# ok 377 918d - Add pedit action with LAYERED_OP eth invert src # skipped - skipped - previous setup failed 45 57c2
# 
# ok 378 a8d4 - Add pedit action with LAYERED_OP eth invert dst # skipped - skipped - previous setup failed 45 57c2
# 
# ok 379 ee13 - Add pedit action with LAYERED_OP eth invert type # skipped - skipped - previous setup failed 45 57c2
# 
# ok 380 7588 - Add pedit action with LAYERED_OP ip set src # skipped - skipped - previous setup failed 45 57c2
# 
# ok 381 0fa7 - Add pedit action with LAYERED_OP ip set dst # skipped - skipped - previous setup failed 45 57c2
# 
# ok 382 5810 - Add pedit action with LAYERED_OP ip set src & dst # skipped - skipped - previous setup failed 45 57c2
# 
# ok 383 1092 - Add pedit action with LAYERED_OP ip set ihl & dsfield # skipped - skipped - previous setup failed 45 57c2
# 
# ok 384 02d8 - Add pedit action with LAYERED_OP ip set ttl & protocol # skipped - skipped - previous setup failed 45 57c2
# 
# ok 385 3e2d - Add pedit action with LAYERED_OP ip set ttl (INVALID) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 386 31ae - Add pedit action with LAYERED_OP ip ttl clear/set # skipped - skipped - previous setup failed 45 57c2
# 
# ok 387 486f - Add pedit action with LAYERED_OP ip set duplicate fields # skipped - skipped - previous setup failed 45 57c2
# 
# ok 388 e790 - Add pedit action with LAYERED_OP ip set ce, df, mf, firstfrag, nofrag fields # skipped - skipped - previous setup failed 45 57c2
# 
# ok 389 cc8a - Add pedit action with LAYERED_OP ip set tos # skipped - skipped - previous setup failed 45 57c2
# 
# ok 390 7a17 - Add pedit action with LAYERED_OP ip set precedence # skipped - skipped - previous setup failed 45 57c2
# 
# ok 391 c3b6 - Add pedit action with LAYERED_OP ip add tos # skipped - skipped - previous setup failed 45 57c2
# 
# ok 392 43d3 - Add pedit action with LAYERED_OP ip add precedence # skipped - skipped - previous setup failed 45 57c2
# 
# ok 393 438e - Add pedit action with LAYERED_OP ip clear tos # skipped - skipped - previous setup failed 45 57c2
# 
# ok 394 6b1b - Add pedit action with LAYERED_OP ip clear precedence # skipped - skipped - previous setup failed 45 57c2
# 
# ok 395 824a - Add pedit action with LAYERED_OP ip invert tos # skipped - skipped - previous setup failed 45 57c2
# 
# ok 396 106f - Add pedit action with LAYERED_OP ip invert precedence # skipped - skipped - previous setup failed 45 57c2
# 
# ok 397 6829 - Add pedit action with LAYERED_OP beyond ip set dport & sport # skipped - skipped - previous setup failed 45 57c2
# 
# ok 398 afd8 - Add pedit action with LAYERED_OP beyond ip set icmp_type & icmp_code # skipped - skipped - previous setup failed 45 57c2
# 
# ok 399 3143 - Add pedit action with LAYERED_OP beyond ip set dport (INVALID) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 400 815c - Add pedit action with LAYERED_OP ip6 set src # skipped - skipped - previous setup failed 45 57c2
# 
# ok 401 4dae - Add pedit action with LAYERED_OP ip6 set dst # skipped - skipped - previous setup failed 45 57c2
# 
# ok 402 fc1f - Add pedit action with LAYERED_OP ip6 set src & dst # skipped - skipped - previous setup failed 45 57c2
# 
# ok 403 6d34 - Add pedit action with LAYERED_OP ip6 dst retain value (INVALID) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 404 94bb - Add pedit action with LAYERED_OP ip6 traffic_class # skipped - skipped - previous setup failed 45 57c2
# 
# ok 405 6f5e - Add pedit action with LAYERED_OP ip6 flow_lbl # skipped - skipped - previous setup failed 45 57c2
# 
# ok 406 6795 - Add pedit action with LAYERED_OP ip6 set payload_len, nexthdr, hoplimit # skipped - skipped - previous setup failed 45 57c2
# 
# ok 407 1442 - Add pedit action with LAYERED_OP tcp set dport & sport # skipped - skipped - previous setup failed 45 57c2
# 
# ok 408 b7ac - Add pedit action with LAYERED_OP tcp sport set (INVALID) # skipped - skipped - previous setup failed 45 57c2
# 
# ok 409 cfcc - Add pedit action with LAYERED_OP tcp flags set # skipped - skipped - previous setup failed 45 57c2
# 
# ok 410 3bc4 - Add pedit action with LAYERED_OP tcp set dport, sport & flags fields # skipped - skipped - previous setup failed 45 57c2
# 
# ok 411 f1c8 - Add pedit action with LAYERED_OP udp set dport & sport # skipped - skipped - previous setup failed 45 57c2
# 
# ok 412 d784 - Add pedit action with mixed RAW/LAYERED_OP #1 # skipped - skipped - previous setup failed 45 57c2
# 
# ok 413 70ca - Add pedit action with mixed RAW/LAYERED_OP #2 # skipped - skipped - previous setup failed 45 57c2
# 
# ok 414 5124 - Add mirred mirror to egress action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 415 6fb4 - Add mirred redirect to egress action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 416 ba38 - Get mirred actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 417 d7c0 - Add invalid mirred direction # skipped - skipped - previous setup failed 45 57c2
# 
# ok 418 e213 - Add invalid mirred action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 419 2d89 - Add mirred action with invalid device # skipped - skipped - previous setup failed 45 57c2
# 
# ok 420 300b - Add mirred action with duplicate index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 421 8917 - Add mirred mirror action with control pass # skipped - skipped - previous setup failed 45 57c2
# 
# ok 422 1054 - Add mirred mirror action with control pipe # skipped - skipped - previous setup failed 45 57c2
# 
# ok 423 9887 - Add mirred mirror action with control continue # skipped - skipped - previous setup failed 45 57c2
# 
# ok 424 e4aa - Add mirred mirror action with control reclassify # skipped - skipped - previous setup failed 45 57c2
# 
# ok 425 ece9 - Add mirred mirror action with control drop # skipped - skipped - previous setup failed 45 57c2
# 
# ok 426 0031 - Add mirred mirror action with control jump # skipped - skipped - previous setup failed 45 57c2
# 
# ok 427 407c - Add mirred mirror action with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 428 8b69 - Add mirred mirror action with index at 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 429 3f66 - Add mirred mirror action with index exceeding 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 430 a70e - Delete mirred mirror action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 431 3fb3 - Delete mirred redirect action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 432 2a9a - Replace mirred action with invalid goto chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 433 4749 - Add batch of 32 mirred redirect egress actions with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 434 5c69 - Delete batch of 32 mirred redirect egress actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 435 d3c0 - Add batch of 32 mirred mirror ingress actions with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 436 e684 - Delete batch of 32 mirred mirror ingress actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 437 31e3 - Add mirred mirror to egress action with no_percpu flag # skipped - skipped - previous setup failed 45 57c2
# 
# ok 438 e89a - Add valid pass action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 439 a02c - Add valid pipe action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 440 feef - Add valid reclassify action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 441 8a7a - Add valid drop action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 442 9a52 - Add valid continue action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 443 d700 - Add invalid action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 444 9215 - Add action with duplicate index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 445 798e - Add action with index exceeding 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 446 22be - Add action with index at 32-bit maximum # skipped - skipped - previous setup failed 45 57c2
# 
# ok 447 ac2a - List actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 448 3edf - Flush gact actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 449 63ec - Delete pass action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 450 46be - Delete pipe action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 451 2e08 - Delete reclassify action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 452 99c4 - Delete drop action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 453 fb6b - Delete continue action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 454 0eb3 - Delete non-existent action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 455 f02c - Replace gact action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 456 525f - Get gact action by index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 457 1021 - Add batch of 32 gact pass actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 458 da7a - Add batch of 32 gact continue actions with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 459 8aa3 - Delete batch of 32 gact continue actions # skipped - skipped - previous setup failed 45 57c2
# 
# ok 460 8e47 - Add gact action with random determ goto chain control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 461 ca89 - Replace gact action with invalid goto chain control # skipped - skipped - previous setup failed 45 57c2
# 
# ok 462 95ad - Add gact pass action with no_percpu flag # skipped - skipped - previous setup failed 45 57c2
# 
# ok 463 9784 - Add valid sample action with mandatory arguments # skipped - skipped - previous setup failed 45 57c2
# 
# ok 464 5c91 - Add valid sample action with mandatory arguments and continue control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 465 334b - Add valid sample action with mandatory arguments and drop control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 466 da69 - Add valid sample action with mandatory arguments and reclassify control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 467 13ce - Add valid sample action with mandatory arguments and pipe control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 468 1886 - Add valid sample action with mandatory arguments and jump control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 469 7571 - Add sample action with invalid rate # skipped - skipped - previous setup failed 45 57c2
# 
# ok 470 b6d4 - Add sample action with mandatory arguments and invalid control action # skipped - skipped - previous setup failed 45 57c2
# 
# ok 471 a874 - Add invalid sample action without mandatory arguments # skipped - skipped - previous setup failed 45 57c2
# 
# ok 472 ac01 - Add invalid sample action without mandatory argument rate # skipped - skipped - previous setup failed 45 57c2
# 
# ok 473 4203 - Add invalid sample action without mandatory argument group # skipped - skipped - previous setup failed 45 57c2
# 
# ok 474 14a7 - Add invalid sample action without mandatory argument group # skipped - skipped - previous setup failed 45 57c2
# 
# ok 475 8f2e - Add valid sample action with trunc argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 476 45f8 - Add sample action with maximum rate argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 477 ad0c - Add sample action with maximum trunc argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 478 83a9 - Add sample action with maximum group argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 479 ed27 - Add sample action with invalid rate argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 480 2eae - Add sample action with invalid group argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 481 6ff3 - Add sample action with invalid trunc size # skipped - skipped - previous setup failed 45 57c2
# 
# ok 482 2b2a - Add sample action with invalid index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 483 dee2 - Add sample action with maximum allowed index # skipped - skipped - previous setup failed 45 57c2
# 
# ok 484 560e - Add sample action with cookie # skipped - skipped - previous setup failed 45 57c2
# 
# ok 485 704a - Replace existing sample action with new rate argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 486 60eb - Replace existing sample action with new group argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 487 2cce - Replace existing sample action with new trunc argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 488 59d1 - Replace existing sample action with new control argument # skipped - skipped - previous setup failed 45 57c2
# 
# ok 489 0a6e - Replace sample action with invalid goto chain control # skipped - skipped - previous setup failed 45 57c2
# 
# 
# -----> prepare stage *** Could not execute: "$TC actions add action skbedit mark 1/0x11223344 index 1"
# 
# -----> prepare stage *** Error message: "Illegal mark
# bad action parsing
# parse_action: bad value (5:skbedit)!
# Illegal "action"
# "
# 
# -----> prepare stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=5> *** stdout ***
# 
# 
# <_io.BufferedReader name=7> *** stderr ***
#   File "./tdc.py", line 371, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#   File "./tdc.py", line 272, in run_one_test
#     prepare_env(args, pm, 'setup', "-----> prepare stage", tidx["setup"])
#   File "./tdc.py", line 247, in prepare_env
#     '"{}" did not complete successfully'.format(prefix))
# 
# 
# 
# 
# considering category qdisc
#  -- ns/SubPlugin.__init__
# Test 9872: Add ingress qdisc
# Test 5c5e: Add ingress qdisc with unsupported argument
# Test 74f6: Add duplicate ingress qdisc
# Test f769: Delete nonexistent ingress qdisc
# Test 3b88: Delete ingress qdisc twice
# Test ddd9: Add prio qdisc on egress
# Test aa71: Add prio qdisc on egress with handle of maximum value
# Test db37: Add prio qdisc on egress with invalid handle exceeding maximum value
# Test 39d8: Add prio qdisc on egress with unsupported argument
# Test 5769: Add prio qdisc on egress with 4 bands and new priomap
# Test fe0f: Add prio qdisc on egress with 4 bands and priomap exceeding TC_PRIO_MAX entries
# Test 1f91: Add prio qdisc on egress with 4 bands and priomap's values exceeding bands number
# Test d248: Add prio qdisc on egress with invalid bands value (< 2)
# Test 1d0e: Add prio qdisc on egress with invalid bands value exceeding TCQ_PRIO_BANDS
# Test 1971: Replace default prio qdisc on egress with 8 bands and new priomap
# Test d88a: Add duplicate prio qdisc on egress
# Test 5948: Delete nonexistent prio qdisc
# Test 6c0a: Add prio qdisc on egress with invalid format for handles
# Test 0175: Delete prio qdisc twice
# Test e90e: Add ETS qdisc using bands
# exit: 1
# exit: 0
# Unknown qdisc "ets", hence option "bands" is unparsable
# 
# returncode 2; expected [0]
# "-----> teardown stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('teardown', 'Unknown qdisc "ets", hence option "bands" is unparsable\n', '"-----> teardown stage" did not complete successfully') (caught in test_runner, running test 21 e90e Add ETS qdisc using bands stage teardown)
# ---------------
# traceback
# ---------------
# accumulated output for this test:
# Unknown qdisc "ets", hence option "bands" is unparsable
# 
# ---------------
# 
# All test results: 
# 
# 1..91
# ok 1 9872 - Add ingress qdisc
# ok 2 5c5e - Add ingress qdisc with unsupported argument
# ok 3 74f6 - Add duplicate ingress qdisc
# ok 4 f769 - Delete nonexistent ingress qdisc
# ok 5 3b88 - Delete ingress qdisc twice
# ok 6 ddd9 - Add prio qdisc on egress
# ok 7 aa71 - Add prio qdisc on egress with handle of maximum value
# ok 8 db37 - Add prio qdisc on egress with invalid handle exceeding maximum value
# ok 9 39d8 - Add prio qdisc on egress with unsupported argument
# ok 10 5769 - Add prio qdisc on egress with 4 bands and new priomap
# ok 11 fe0f - Add prio qdisc on egress with 4 bands and priomap exceeding TC_PRIO_MAX entries
# ok 12 1f91 - Add prio qdisc on egress with 4 bands and priomap's values exceeding bands number
# ok 13 d248 - Add prio qdisc on egress with invalid bands value (< 2)
# ok 14 1d0e - Add prio qdisc on egress with invalid bands value exceeding TCQ_PRIO_BANDS
# ok 15 1971 - Replace default prio qdisc on egress with 8 bands and new priomap
# ok 16 d88a - Add duplicate prio qdisc on egress
# ok 17 5948 - Delete nonexistent prio qdisc
# ok 18 6c0a - Add prio qdisc on egress with invalid format for handles
# ok 19 0175 - Delete prio qdisc twice
# ok 20 e90e - Add ETS qdisc using bands # skipped - "-----> teardown stage" did not complete successfully
# 
# ok 21 b059 - Add ETS qdisc using quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 22 e8e7 - Add ETS qdisc using strict # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 23 233c - Add ETS qdisc using bands + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 24 3d35 - Add ETS qdisc using bands + strict # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 25 7f3b - Add ETS qdisc using strict + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 26 4593 - Add ETS qdisc using strict 0 + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 27 8938 - Add ETS qdisc using bands + strict + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 28 0782 - Add ETS qdisc with more bands than quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 29 501b - Add ETS qdisc with more bands than strict # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 30 671a - Add ETS qdisc with more bands than strict + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 31 2a23 - Add ETS qdisc with 16 bands # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 32 8daf - Add ETS qdisc with 17 bands # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 33 7f95 - Add ETS qdisc with 17 strict # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 34 837a - Add ETS qdisc with 16 quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 35 65b6 - Add ETS qdisc with 17 quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 36 b9e9 - Add ETS qdisc with 16 strict + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 37 9877 - Add ETS qdisc with 17 strict + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 38 c696 - Add ETS qdisc with priomap # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 39 30c4 - Add ETS qdisc with quanta + priomap # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 40 e8ac - Add ETS qdisc with strict + priomap # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 41 5a7e - Add ETS qdisc with quanta + strict + priomap # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 42 cb8b - Show ETS class :1 # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 43 1b4e - Show ETS class :2 # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 44 f642 - Show ETS class :3 # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 45 0a5f - Show ETS strict class # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 46 f7c8 - Add ETS qdisc with too many quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 47 2389 - Add ETS qdisc with too many strict # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 48 fe3c - Add ETS qdisc with too many strict + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 49 cb04 - Add ETS qdisc with excess priomap elements # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 50 c32e - Add ETS qdisc with priomap above bands # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 51 744c - Add ETS qdisc with priomap above quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 52 7b33 - Add ETS qdisc with priomap above strict # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 53 dbe6 - Add ETS qdisc with priomap above strict + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 54 bdb2 - Add ETS qdisc with priomap within bands with strict + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 55 39a3 - Add ETS qdisc with priomap above bands with strict + quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 56 557c - Unset priorities default to the last band # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 57 a347 - Unset priorities default to the last band -- no priomap # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 58 39c4 - Add ETS qdisc with too few bands # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 59 930b - Add ETS qdisc with too many bands # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 60 406a - Add ETS qdisc without parameters # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 61 e51a - Zero element in quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 62 e7f2 - Sole zero element in quanta # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 63 d6e6 - No values after the quanta keyword # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 64 28c6 - Change ETS band quantum # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 65 4714 - Change ETS band without quantum # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 66 6979 - Change quantum of a strict ETS band # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 67 9a7d - Change ETS strict band without quantum # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 68 a519 - Add bfifo qdisc with system default parameters on egress # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 69 585c - Add pfifo qdisc with system default parameters on egress # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 70 a86e - Add bfifo qdisc with system default parameters on egress with handle of maximum value # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 71 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 72 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 73 b1b1 - Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 74 8d5e - Add bfifo qdisc on egress with unsupported argument # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 75 7787 - Add pfifo qdisc on egress with unsupported argument # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 76 c4b6 - Replace bfifo qdisc on egress with new queue size # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 77 3df6 - Replace pfifo qdisc on egress with new queue size # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 78 7a67 - Add bfifo qdisc on egress with queue size in invalid format # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 79 1298 - Add duplicate bfifo qdisc on egress # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 80 45a0 - Delete nonexistent bfifo qdisc # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 81 972b - Add prio qdisc on egress with invalid format for handles # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 82 4d39 - Delete bfifo qdisc twice # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 83 8b6e - Create RED with no flags # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 84 342e - Create RED with adaptive flag # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 85 2d4b - Create RED with ECN flag # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 86 650f - Create RED with flags ECN, adaptive # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 87 5f15 - Create RED with flags ECN, harddrop # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 88 53e8 - Create RED with flags ECN, nodrop # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 89 d091 - Fail to create RED with only nodrop flag # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 90 af8e - Create RED with flags ECN, nodrop, harddrop # skipped - skipped - previous teardown failed 21 e90e
# 
# ok 91 83be - Create FQ-PIE with invalid number of flows # skipped - skipped - previous teardown failed 21 e90e
# 
# 
# -----> teardown stage *** Could not execute: "$TC qdisc del dev $DUMMY handle 1: root"
# 
# -----> teardown stage *** Error message: "Error: Invalid handle.
# "
# 
# -----> teardown stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=5> *** stdout ***
# 
# 
# <_io.BufferedReader name=7> *** stderr ***
#   File "./tdc.py", line 371, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#   File "./tdc.py", line 311, in run_one_test
#     prepare_env(args, pm, 'teardown', '-----> teardown stage', tidx['teardown'], procout)
#   File "./tdc.py", line 247, in prepare_env
#     '"{}" did not complete successfully'.format(prefix))
# 
# 
# 
# 
ok 1 selftests: tc-testing: tdc.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/tools/testing/selftests/tc-testing'

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-7.6-kselftests
need_memory: 2G
need_cpu: 2
kernel-selftests:
  group: tc-testing
kernel_cmdline: erst_disable
job_origin: kernel-selftests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d05
tbox_group: lkp-skl-d05
submit_id: 60293c15c8fde0d28a3f52cc
job_file: "/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-tc-testing-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9-20210214-53898-1t6t7jq-0.yaml"
id: 19a2e52e00b6832bfac1d9a8f31976cba47250ac
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
commit: 00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9

#! include/testbox/lkp-skl-d05
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'

#! include/kernel-selftests
need_linux_headers: true
need_linux_selftests: true
need_kconfig:
- CONFIG_BLOCK=y
- CONFIG_BTRFS_FS=m
- CONFIG_EFI=y
- CONFIG_EFIVAR_FS
- CONFIG_FTRACE=y
- CONFIG_IP_ADVANCED_ROUTER=y
- CONFIG_IP_MULTIPLE_TABLES=y
- CONFIG_MEMORY_HOTPLUG_SPARSE=y
- CONFIG_MEMORY_NOTIFIER_ERROR_INJECT
- CONFIG_NOTIFIER_ERROR_INJECTION
- CONFIG_RC_CORE=m ~ ">= v4.14-rc1"
- CONFIG_RC_DECODERS=y
- CONFIG_RC_DEVICES=y
- CONFIG_RUNTIME_TESTING_MENU=y
- CONFIG_STAGING=y
- CONFIG_SYNC_FILE=y
- CONFIG_TEST_FIRMWARE
- CONFIG_TEST_KMOD=m
- CONFIG_TEST_LKM=m
- CONFIG_TEST_USER_COPY
- CONFIG_TUN=m
- CONFIG_XFS_FS=m
enqueue_time: 2021-02-14 23:04:53.954725177 +08:00
_id: 60293c15c8fde0d28a3f52cc
_rt: "/result/kernel-selftests/tc-testing-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 2c02aec46c87d4959c3ae7435b58cae94af3126f
base_commit: 92bf22614b21a2706f4993b278017e437f7785b3
branch: linux-devel/devel-hourly-20210213-114554
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/tc-testing-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/0"
scheduler_version: "/lkp/lkp/.src-20210210-104238"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-tc-testing-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9-20210214-53898-1t6t7jq-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6-kselftests
- branch=linux-devel/devel-hourly-20210213-114554
- commit=00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/vmlinuz-5.11.0-rc6-00001-g00003c0265c6
- erst_disable
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/tc-testing-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20201231.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-b553cffa-1_20210122.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210210-104238/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.11.0-rc6-07970-gb72e0c989b60

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/00003c0265c6cb2b6e17e37f3a4b6bbab4e851b9/vmlinuz-5.11.0-rc6-00001-g00003c0265c6"
dequeue_time: 2021-02-14 23:21:02.665524274 +08:00
job_state: finished
loadavg: 1.53 0.51 0.18 2/147 10487
start_time: '1613316194'
end_time: '1613316234'
version: "/lkp/lkp/.src-20210210-104310:cb120521:eb4f0777c"

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make run_tests -C tc-testing

--3uo+9/B/ebqu+fSQ--
