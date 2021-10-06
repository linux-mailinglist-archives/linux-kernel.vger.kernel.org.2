Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57153423637
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 05:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhJFDLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 23:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhJFDLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 23:11:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D977D6120D;
        Wed,  6 Oct 2021 03:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633489760;
        bh=WytL5qgvi0F8RBIbgyCQQPRl2at0wZnEv4zrALRwx/0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HAxUYhU7W3mCppBHHB+SsMi45xPUqxh3mUW9c1gaUoY+74DENpAkzMrZDR11ciCnA
         khp1GEJUnegrZQXmt571ucYET1AaQIHzpSGNRLqcmj6J1Z951qVDFelTjR95xo5kgv
         a7bZebfs7ao3630kmjmYw6hqlGjiKeN82/sbILAaMZtR9EmjzJ2ZignP+KbkZFjloO
         aD2WNDdpF9UHG/esvSwIqSm9//R2z3CT4/7y2hNOjCWVXt58m8YeAncv6hW5BVJnWz
         srhxdZ9+SQhuAScnPoRYGEsAfEcKCRnXIOp9ns1ZjBTwBG8AgE23ZA4yQDkbKMyLzD
         //h/+5p5yaECg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A4B485C0921; Tue,  5 Oct 2021 20:09:20 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:09:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [rcutorture]  be6350ccbb: WARNING:bad_unlock_balance_detected
Message-ID: <20211006030920.GC880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211002154023.GB22347@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002154023.GB22347@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2021 at 11:40:23PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: be6350ccbb78fbc8186f4b3265ed331654ef3ad9 ("rcutorture: Sanitize rcutorture_one_extend() use of idxold")
> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2021.09.22a

This commit had several problems and has since been replaced by
be6350ccbb78 ("rcutorture: Sanitize RCUTORTURE_RDR_MASK").

							Thanx, Paul

> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 	torture_type: rcu
> 
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +--------------------------------------------------------------------------------------------------------+------------+------------+
> |                                                                                                        | 1ae66df91a | be6350ccbb |
> +--------------------------------------------------------------------------------------------------------+------------+------------+
> | WARNING:bad_unlock_balance_detected                                                                    | 0          | 58         |
> | is_trying_to_release_lock(rcu_read_lock_sched)at                                                       | 0          | 33         |
> | WARNING:at_kernel/time/timer.c:#call_timer_fn                                                          | 0          | 55         |
> | BUG:KFENCE:invalid_write_in_handle_exception_return                                                    | 0          | 1          |
> | BUG:KFENCE:out-of-bounds_write_in_handle_exception_return                                              | 0          | 1          |
> | BUG:KFENCE:use-after-free_write_in_handle_exception_return                                             | 0          | 1          |
> | WARNING:at_kernel/softirq.c:#__local_bh_disable_ip                                                     | 0          | 53         |
> | EIP:__local_bh_disable_ip                                                                              | 0          | 53         |
> | WARNING:at_kernel/softirq.c:#__local_bh_enable_ip                                                      | 0          | 57         |
> | EIP:__local_bh_enable_ip                                                                               | 0          | 57         |
> | WARNING:suspicious_RCU_usage                                                                           | 0          | 10         |
> | include/trace/events/lock.h:#suspicious_rcu_dereference_check()usage                                   | 0          | 10         |
> | WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_one_read[rcutorture]                                   | 0          | 57         |
> | EIP:rcu_torture_one_read                                                                               | 0          | 56         |
> | BUG:scheduling_while_atomic                                                                            | 0          | 55         |
> | EIP:call_timer_fn                                                                                      | 0          | 54         |
> | Kernel_panic-not_syncing:Aiee,killing_interrupt_handler                                                | 0          | 29         |
> | is_trying_to_release_lock(rcu_read_lock_bh)at                                                          | 0          | 24         |
> | BUG:sleeping_function_called_from_invalid_context_at_kernel/torture.c                                  | 0          | 46         |
> | BUG:kernel_NULL_pointer_dereference,address                                                            | 0          | 19         |
> | Oops:#[##]                                                                                             | 0          | 24         |
> | WARNING:stack_recursion                                                                                | 0          | 26         |
> | Kernel_panic-not_syncing:Fatal_exception                                                               | 0          | 24         |
> | BUG:unable_to_handle_page_fault_for_address                                                            | 0          | 5          |
> | EIP:update_group_capacity                                                                              | 0          | 1          |
> | kernel_BUG_at_kernel/sched/core.c                                                                      | 0          | 3          |
> | invalid_opcode:#[##]                                                                                   | 0          | 3          |
> | EIP:__sched_setscheduler                                                                               | 0          | 3          |
> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt                                                  | 0          | 3          |
> | Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:vprintk_store                    | 0          | 1          |
> | WARNING:inconsistent_lock_state                                                                        | 0          | 1          |
> | inconsistent{IN-SOFTIRQ-W}->{SOFTIRQ-ON-W}usage                                                        | 0          | 1          |
> | WARNING:at_kernel/module.c:#module_assert_mutex_or_preempt                                             | 0          | 1          |
> | EIP:module_assert_mutex_or_preempt                                                                     | 0          | 1          |
> | Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:rcu_torture_one_read[rcutorture] | 0          | 1          |
> +--------------------------------------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> 
> [   27.567579][  T496] rcu-torture: rcu_torture_reader task started
> [   27.570786][  T496]
> [   27.571020][  T496] =====================================
> [   27.571561][  T496] WARNING: bad unlock balance detected!
> [   27.572095][  T496] 5.15.0-rc1-00093-gbe6350ccbb78 #1 Not tainted
> [   27.572689][  T496] -------------------------------------
> [   27.573260][  T496] rcu_torture_rea/496 is trying to release lock (rcu_read_lock_sched) at:
> [   27.574076][  T496] [<f6c5a490>] rcutorture_one_extend+0x190/0x480 [rcutorture]
> [   27.574781][  T496] but there are no more locks to release!
> [   27.575398][  T496]
> [   27.575398][  T496] other info that might help us debug this:
> [   27.576141][  T496] no locks held by rcu_torture_rea/496.
> [   27.576648][  T496]
> [   27.576648][  T496] stack backtrace:
> [   27.577186][  T496] CPU: 0 PID: 496 Comm: rcu_torture_rea Not tainted 5.15.0-rc1-00093-gbe6350ccbb78 #1 9163dea460308125cc5b8cc0f1df3eca089bc795
> [   27.578407][  T496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   27.579294][  T496] Call Trace:
> [   27.579612][  T496]  dump_stack_lvl+0x55/0x79
> [   27.579924][  T488] rcu-torture: Creating torture_shuffle task
> [   27.580060][  T496]  ? rcutorture_one_extend+0x190/0x480 [rcutorture 26936e0d59ae68533deba419b7fc8ae986e561cf]
> [   27.580773][  T497] rcu-torture: rcu_torture_stats task started
> [   27.581665][  T496]  dump_stack+0xd/0x10
> [   27.581674][  T496]  print_unlock_imbalance_bug.cold+0x96/0x9e
> [   27.581684][  T496]  ? rcutorture_one_extend+0x190/0x480 [rcutorture 26936e0d59ae68533deba419b7fc8ae986e561cf]
> [   27.581712][  T496]  ? rcutorture_one_extend+0x190/0x480 [rcutorture 26936e0d59ae68533deba419b7fc8ae986e561cf]
> [   27.581719][  T496]  ? rcutorture_one_extend+0x190/0x480 [rcutorture 26936e0d59ae68533deba419b7fc8ae986e561cf]
> [   27.581726][  T496]  lock_release+0x1b4/0x440
> [   27.581731][  T496]  ? rcu_read_delay+0x1f/0x180 [rcutorture 26936e0d59ae68533deba419b7fc8ae986e561cf]
> [   27.581738][  T496]  rcutorture_one_extend+0x19f/0x480 [rcutorture 26936e0d59ae68533deba419b7fc8ae986e561cf]
> [   27.581746][  T496]  rcu_torture_one_read+0x438/0x700 [rcutorture 26936e0d59ae68533deba419b7fc8ae986e561cf]
> [   27.581758][  T496]  rcu_torture_reader+0x8d/0x200 [rcutorture 26936e0d59ae68533deba419b7fc8ae986e561cf]
> [   27.581766][  T496]  ? rcutorture_booster_init+0x1c0/0x1c0 [rcutorture 26936e0d59ae68533deba419b7fc8ae986e561cf]
> [   27.581775][  T496]  ? __kthread_parkme+0x5c/0x80
> [   27.581781][  T496]  kthread+0x10d/0x140
> [   27.581785][  T496]  ? rcu_torture_one_read+0x700/0x700 [rcutorture 26936e0d59ae68533deba419b7fc8ae986e561cf]
> [   27.581792][  T496]  ? set_kthread_struct+0x40/0x40
> [   27.581796][  T496]  ret_from_fork+0x1c/0x28
> 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.15.0-rc1-00093-gbe6350ccbb78 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/i386 5.15.0-rc1 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=90300
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23502
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23502
> CONFIG_LLD_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_CAN_LINK_STATIC=y
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_CONSTRUCTORS=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> # CONFIG_KERNEL_GZIP is not set
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> CONFIG_KERNEL_LZ4=y
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_WATCH_QUEUE=y
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_TIME_KUNIT_TEST=m
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=y
> CONFIG_BPF_JIT=y
> # CONFIG_BPF_JIT_ALWAYS_ON is not set
> CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
> CONFIG_USERMODE_DRIVER=y
> # CONFIG_BPF_PRELOAD is not set
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> # CONFIG_SCHED_CORE is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> CONFIG_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_SCHED_AVG_IRQ=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> CONFIG_PSI=y
> CONFIG_PSI_DEFAULT_DISABLED=y
> # end of CPU/Task time and stats accounting
> 
> # CONFIG_CPU_ISOLATION is not set
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> CONFIG_RCU_EXPERT=y
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_FANOUT=32
> CONFIG_RCU_FANOUT_LEAF=16
> CONFIG_RCU_FAST_NO_HZ=y
> CONFIG_RCU_NOCB_CPU=y
> # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_IKHEADERS=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # end of Scheduler features
> 
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CGROUPS=y
> # CONFIG_MEMCG is not set
> # CONFIG_BLK_CGROUP is not set
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_RDMA is not set
> # CONFIG_CGROUP_FREEZER is not set
> # CONFIG_CGROUP_HUGETLB is not set
> # CONFIG_CPUSETS is not set
> # CONFIG_CGROUP_DEVICE is not set
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_PERF is not set
> # CONFIG_CGROUP_BPF is not set
> # CONFIG_CGROUP_MISC is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_NAMESPACES=y
> # CONFIG_UTS_NS is not set
> # CONFIG_TIME_NS is not set
> # CONFIG_IPC_NS is not set
> CONFIG_USER_NS=y
> # CONFIG_PID_NS is not set
> CONFIG_NET_NS=y
> CONFIG_CHECKPOINT_RESTORE=y
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_EXPERT=y
> # CONFIG_UID16 is not set
> CONFIG_MULTIUSER=y
> # CONFIG_SGETMASK_SYSCALL is not set
> # CONFIG_SYSFS_SYSCALL is not set
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> # CONFIG_PCSPKR_PLATFORM is not set
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> # CONFIG_IO_URING is not set
> # CONFIG_ADVISE_SYSCALLS is not set
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> # CONFIG_USERFAULTFD is not set
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_KCMP=y
> # CONFIG_RSEQ is not set
> CONFIG_EMBEDDED=y
> CONFIG_HAVE_PERF_EVENTS=y
> # CONFIG_PC104 is not set
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
> 
> # CONFIG_VM_EVENT_COUNTERS is not set
> # CONFIG_SLUB_DEBUG is not set
> CONFIG_COMPAT_BRK=y
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLOB is not set
> CONFIG_SLAB_MERGE_DEFAULT=y
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> CONFIG_SLAB_FREELIST_HARDENED=y
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> # CONFIG_SLUB_CPU_PARTIAL is not set
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> # CONFIG_PROFILING is not set
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_X86_32=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf32-i386"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_X86_32_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=2
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> # CONFIG_X86_MPPARSE is not set
> CONFIG_GOLDFISH=y
> CONFIG_RETPOLINE=y
> CONFIG_X86_CPU_RESCTRL=y
> CONFIG_X86_BIGSMP=y
> CONFIG_X86_EXTENDED_PLATFORM=y
> # CONFIG_X86_GOLDFISH is not set
> CONFIG_X86_INTEL_MID=y
> # CONFIG_X86_INTEL_QUARK is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> # CONFIG_IOSF_MBI_DEBUG is not set
> # CONFIG_X86_RDC321X is not set
> CONFIG_X86_32_NON_STANDARD=y
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_STA2X11 is not set
> CONFIG_X86_32_IRIS=m
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> # CONFIG_PARAVIRT_SPINLOCKS is not set
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> # CONFIG_PVH is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_M486SX is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> CONFIG_MPENTIUMIII=y
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MELAN is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MGEODE_LX is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_MVIAC7 is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_X86_GENERIC=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=6
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_PROCESSOR_SELECT=y
> CONFIG_CPU_SUP_INTEL=y
> # CONFIG_CPU_SUP_CYRIX_32 is not set
> # CONFIG_CPU_SUP_AMD is not set
> # CONFIG_CPU_SUP_HYGON is not set
> # CONFIG_CPU_SUP_CENTAUR is not set
> CONFIG_CPU_SUP_TRANSMETA_32=y
> # CONFIG_CPU_SUP_UMC_32 is not set
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> CONFIG_NR_CPUS_RANGE_BEGIN=2
> CONFIG_NR_CPUS_RANGE_END=64
> CONFIG_NR_CPUS_DEFAULT=32
> CONFIG_NR_CPUS=32
> CONFIG_SCHED_SMT=y
> CONFIG_SCHED_MC=y
> # CONFIG_SCHED_MC_PRIO is not set
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> # CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCELOG_LEGACY is not set
> CONFIG_X86_MCE_INTEL=y
> # CONFIG_X86_ANCIENT_MCE is not set
> CONFIG_X86_MCE_THRESHOLD=y
> CONFIG_X86_MCE_INJECT=m
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=m
> # CONFIG_PERF_EVENTS_INTEL_RAPL is not set
> # CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
> # end of Performance monitoring
> 
> # CONFIG_X86_LEGACY_VM86 is not set
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX32=y
> CONFIG_X86_IOPL_IOPERM=y
> # CONFIG_TOSHIBA is not set
> CONFIG_I8K=y
> # CONFIG_X86_REBOOTFIXUPS is not set
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=m
> CONFIG_X86_CPUID=y
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> CONFIG_VMSPLIT_3G=y
> # CONFIG_VMSPLIT_3G_OPT is not set
> # CONFIG_VMSPLIT_2G is not set
> # CONFIG_VMSPLIT_2G_OPT is not set
> # CONFIG_VMSPLIT_1G is not set
> CONFIG_PAGE_OFFSET=0xC0000000
> CONFIG_HIGHMEM=y
> # CONFIG_X86_CPA_STATISTICS is not set
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0
> # CONFIG_HIGHPTE is not set
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> CONFIG_MTRR=y
> # CONFIG_MTRR_SANITIZER is not set
> # CONFIG_X86_PAT is not set
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_UMIP=y
> # CONFIG_X86_INTEL_TSX_MODE_OFF is not set
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> CONFIG_X86_INTEL_TSX_MODE_AUTO=y
> # CONFIG_EFI is not set
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_300=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=300
> CONFIG_SCHED_HRTICK=y
> CONFIG_KEXEC=y
> # CONFIG_CRASH_DUMP is not set
> # CONFIG_KEXEC_JUMP is not set
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_HOTPLUG_CPU=y
> CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> CONFIG_COMPAT_VDSO=y
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> # end of Processor type and features
> 
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=y
> # CONFIG_SUSPEND is not set
> CONFIG_HIBERNATE_CALLBACKS=y
> CONFIG_HIBERNATION=y
> CONFIG_HIBERNATION_SNAPSHOT_DEV=y
> CONFIG_PM_STD_PARTITION=""
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> CONFIG_PM_AUTOSLEEP=y
> CONFIG_PM_WAKELOCKS=y
> CONFIG_PM_WAKELOCKS_LIMIT=100
> # CONFIG_PM_WAKELOCKS_GC is not set
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> CONFIG_PM_CLK=y
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_SLEEP=y
> # CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
> CONFIG_ACPI_EC_DEBUGFS=y
> CONFIG_ACPI_AC=m
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=y
> # CONFIG_ACPI_VIDEO is not set
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_TAD=m
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_IPMI=m
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
> CONFIG_ACPI_THERMAL=m
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> # CONFIG_ACPI_PCI_SLOT is not set
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> # CONFIG_ACPI_SBS is not set
> CONFIG_ACPI_HED=y
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> CONFIG_ACPI_APEI=y
> CONFIG_ACPI_APEI_GHES=y
> CONFIG_ACPI_APEI_EINJ=m
> CONFIG_ACPI_APEI_ERST_DEBUG=y
> # CONFIG_ACPI_DPTF is not set
> CONFIG_ACPI_CONFIGFS=m
> CONFIG_PMIC_OPREGION=y
> CONFIG_XPOWER_PMIC_OPREGION=y
> CONFIG_BXT_WC_PMIC_OPREGION=y
> CONFIG_X86_PM_TIMER=y
> CONFIG_X86_APM_BOOT=y
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> CONFIG_APM_DO_ENABLE=y
> CONFIG_APM_CPU_IDLE=y
> # CONFIG_APM_DISPLAY_BLANK is not set
> # CONFIG_APM_ALLOW_INTS is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> 
> CONFIG_INTEL_IDLE=y
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> # CONFIG_PCI_CNB20LE_QUIRK is not set
> # CONFIG_ISA_BUS is not set
> CONFIG_ISA_DMA_API=y
> CONFIG_ISA=y
> CONFIG_SCx200=m
> # CONFIG_SCx200HR_TIMER is not set
> # CONFIG_OLPC is not set
> CONFIG_ALIX=y
> CONFIG_NET5501=y
> CONFIG_GEOS=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_COMPAT_32=y
> # end of Binary Emulations
> 
> CONFIG_HAVE_ATOMIC_IOMAP=y
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
> 
> CONFIG_EDD=y
> CONFIG_EDD_OFF=y
> # CONFIG_FIRMWARE_MEMMAP is not set
> CONFIG_DMIID=y
> CONFIG_DMI_SYSFS=y
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> # CONFIG_FW_CFG_SYSFS is not set
> CONFIG_SYSFB=y
> # CONFIG_SYSFB_SIMPLEFB is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> CONFIG_UEFI_CPER=y
> CONFIG_UEFI_CPER_X86=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> CONFIG_HAVE_KVM=y
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQFD=y
> CONFIG_HAVE_KVM_IRQ_ROUTING=y
> CONFIG_HAVE_KVM_EVENTFD=y
> CONFIG_KVM_MMIO=y
> CONFIG_KVM_ASYNC_PF=y
> CONFIG_HAVE_KVM_MSI=y
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> CONFIG_KVM_VFIO=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_HAVE_KVM_IRQ_BYPASS=y
> CONFIG_HAVE_KVM_NO_POLL=y
> CONFIG_KVM_XFER_TO_GUEST_WORK=y
> CONFIG_HAVE_KVM_PM_NOTIFIER=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM=y
> # CONFIG_KVM_WERROR is not set
> # CONFIG_KVM_INTEL is not set
> # CONFIG_KVM_AMD is not set
> # CONFIG_KVM_XEN is not set
> # CONFIG_KVM_MMU_AUDIT is not set
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_HOTPLUG_SMT=y
> CONFIG_GENERIC_ENTRY=y
> # CONFIG_KPROBES is not set
> CONFIG_JUMP_LABEL=y
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_WANTS_NO_INSTR=y
> CONFIG_ARCH_32BIT_OFF_T=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> # CONFIG_SECCOMP is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=8
> CONFIG_ISA_BUS_API=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_SPLIT_ARG64=y
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
> 
> #
> # GCOV-based kernel profiling
> #
> CONFIG_GCOV_KERNEL=y
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # CONFIG_GCOV_PROFILE_ALL is not set
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> # CONFIG_MODULE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_COMPRESS_NONE=y
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> # CONFIG_TRIM_UNUSED_KSYMS is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_DEV_BSG_COMMON=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_DEV_INTEGRITY_T10=y
> # CONFIG_BLK_DEV_ZONED is not set
> CONFIG_BLK_WBT=y
> CONFIG_BLK_WBT_MQ=y
> # CONFIG_BLK_DEBUG_FS is not set
> CONFIG_BLK_SED_OPAL=y
> CONFIG_BLK_INLINE_ENCRYPTION=y
> # CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> CONFIG_ACORN_PARTITION=y
> CONFIG_ACORN_PARTITION_CUMANA=y
> # CONFIG_ACORN_PARTITION_EESOX is not set
> # CONFIG_ACORN_PARTITION_ICS is not set
> # CONFIG_ACORN_PARTITION_ADFS is not set
> # CONFIG_ACORN_PARTITION_POWERTEC is not set
> # CONFIG_ACORN_PARTITION_RISCIX is not set
> CONFIG_AIX_PARTITION=y
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> CONFIG_ATARI_PARTITION=y
> # CONFIG_MAC_PARTITION is not set
> # CONFIG_MSDOS_PARTITION is not set
> # CONFIG_LDM_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> CONFIG_SUN_PARTITION=y
> CONFIG_KARMA_PARTITION=y
> # CONFIG_EFI_PARTITION is not set
> # CONFIG_SYSV68_PARTITION is not set
> CONFIG_CMDLINE_PARTITION=y
> # end of Partition Types
> 
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> 
> #
> # IO Schedulers
> #
> # CONFIG_MQ_IOSCHED_DEADLINE is not set
> # CONFIG_MQ_IOSCHED_KYBER is not set
> # CONFIG_IOSCHED_BFQ is not set
> # end of IO Schedulers
> 
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_PADATA=y
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=y
> # CONFIG_COREDUMP is not set
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_COMPACTION=y
> # CONFIG_PAGE_REPORTING is not set
> CONFIG_MIGRATION=y
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_MEMORY_FAILURE is not set
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> CONFIG_CLEANCACHE=y
> CONFIG_FRONTSWAP=y
> # CONFIG_CMA is not set
> # CONFIG_ZSWAP is not set
> # CONFIG_ZPOOL is not set
> CONFIG_ZSMALLOC=y
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_PAGE_IDLE_FLAG=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_ZONE_DMA_SET=y
> # CONFIG_ZONE_DMA is not set
> CONFIG_PERCPU_STATS=y
> CONFIG_GUP_TEST=y
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_KMAP_LOCAL=y
> 
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> CONFIG_NET=y
> CONFIG_NET_INGRESS=y
> CONFIG_NET_EGRESS=y
> CONFIG_SKB_EXTENSIONS=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_DIAG=m
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> CONFIG_AF_UNIX_OOB=y
> CONFIG_UNIX_DIAG=y
> # CONFIG_TLS is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_ALGO=m
> CONFIG_XFRM_USER=m
> CONFIG_XFRM_INTERFACE=m
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> # CONFIG_XFRM_STATISTICS is not set
> CONFIG_XFRM_AH=m
> CONFIG_XFRM_IPCOMP=m
> # CONFIG_NET_KEY is not set
> CONFIG_XDP_SOCKETS=y
> CONFIG_XDP_SOCKETS_DIAG=m
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_ROUTE_CLASSID=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> CONFIG_IP_PNP_RARP=y
> CONFIG_NET_IPIP=y
> CONFIG_NET_IPGRE_DEMUX=m
> CONFIG_NET_IP_TUNNEL=y
> CONFIG_NET_IPGRE=m
> # CONFIG_NET_IPGRE_BROADCAST is not set
> CONFIG_IP_MROUTE_COMMON=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_PIMSM_V1=y
> # CONFIG_IP_PIMSM_V2 is not set
> CONFIG_SYN_COOKIES=y
> CONFIG_NET_IPVTI=m
> CONFIG_NET_UDP_TUNNEL=y
> CONFIG_NET_FOU=m
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_XFRM_TUNNEL=m
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> CONFIG_INET_UDP_DIAG=y
> CONFIG_INET_RAW_DIAG=y
> # CONFIG_INET_DIAG_DESTROY is not set
> CONFIG_TCP_CONG_ADVANCED=y
> # CONFIG_TCP_CONG_BIC is not set
> CONFIG_TCP_CONG_CUBIC=m
> CONFIG_TCP_CONG_WESTWOOD=y
> CONFIG_TCP_CONG_HTCP=m
> # CONFIG_TCP_CONG_HSTCP is not set
> CONFIG_TCP_CONG_HYBLA=y
> CONFIG_TCP_CONG_VEGAS=y
> CONFIG_TCP_CONG_NV=m
> # CONFIG_TCP_CONG_SCALABLE is not set
> CONFIG_TCP_CONG_LP=y
> CONFIG_TCP_CONG_VENO=y
> CONFIG_TCP_CONG_YEAH=y
> CONFIG_TCP_CONG_ILLINOIS=m
> # CONFIG_TCP_CONG_DCTCP is not set
> CONFIG_TCP_CONG_CDG=m
> CONFIG_TCP_CONG_BBR=m
> # CONFIG_DEFAULT_HYBLA is not set
> # CONFIG_DEFAULT_VEGAS is not set
> CONFIG_DEFAULT_VENO=y
> # CONFIG_DEFAULT_WESTWOOD is not set
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG="veno"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> CONFIG_INET6_AH=m
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> CONFIG_IPV6_MIP6=y
> CONFIG_IPV6_ILA=m
> CONFIG_INET6_TUNNEL=y
> CONFIG_IPV6_VTI=y
> # CONFIG_IPV6_SIT is not set
> CONFIG_IPV6_TUNNEL=y
> CONFIG_IPV6_GRE=m
> CONFIG_IPV6_FOU=m
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> CONFIG_IPV6_SEG6_HMAC=y
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> # CONFIG_NETLABEL is not set
> CONFIG_MPTCP=y
> CONFIG_INET_MPTCP_DIAG=y
> CONFIG_MPTCP_IPV6=y
> # CONFIG_MPTCP_KUNIT_TEST is not set
> CONFIG_NETWORK_SECMARK=y
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> CONFIG_BRIDGE_NETFILTER=m
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_NETLINK=y
> CONFIG_NETFILTER_FAMILY_BRIDGE=y
> CONFIG_NETFILTER_FAMILY_ARP=y
> CONFIG_NETFILTER_NETLINK_HOOK=m
> CONFIG_NETFILTER_NETLINK_ACCT=y
> CONFIG_NETFILTER_NETLINK_QUEUE=y
> CONFIG_NETFILTER_NETLINK_LOG=y
> # CONFIG_NETFILTER_NETLINK_OSF is not set
> CONFIG_NF_CONNTRACK=y
> CONFIG_NF_LOG_SYSLOG=m
> CONFIG_NETFILTER_CONNCOUNT=y
> CONFIG_NF_CONNTRACK_MARK=y
> # CONFIG_NF_CONNTRACK_SECMARK is not set
> CONFIG_NF_CONNTRACK_ZONES=y
> CONFIG_NF_CONNTRACK_PROCFS=y
> CONFIG_NF_CONNTRACK_EVENTS=y
> CONFIG_NF_CONNTRACK_TIMEOUT=y
> CONFIG_NF_CONNTRACK_TIMESTAMP=y
> # CONFIG_NF_CONNTRACK_LABELS is not set
> # CONFIG_NF_CT_PROTO_DCCP is not set
> CONFIG_NF_CT_PROTO_SCTP=y
> # CONFIG_NF_CT_PROTO_UDPLITE is not set
> # CONFIG_NF_CONNTRACK_AMANDA is not set
> # CONFIG_NF_CONNTRACK_FTP is not set
> CONFIG_NF_CONNTRACK_H323=m
> CONFIG_NF_CONNTRACK_IRC=m
> # CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
> # CONFIG_NF_CONNTRACK_SNMP is not set
> # CONFIG_NF_CONNTRACK_PPTP is not set
> # CONFIG_NF_CONNTRACK_SANE is not set
> # CONFIG_NF_CONNTRACK_SIP is not set
> # CONFIG_NF_CONNTRACK_TFTP is not set
> CONFIG_NF_CT_NETLINK=m
> CONFIG_NF_CT_NETLINK_TIMEOUT=y
> CONFIG_NF_CT_NETLINK_HELPER=m
> CONFIG_NETFILTER_NETLINK_GLUE_CT=y
> CONFIG_NF_NAT=y
> CONFIG_NF_NAT_IRC=m
> CONFIG_NF_NAT_REDIRECT=y
> CONFIG_NF_NAT_MASQUERADE=y
> CONFIG_NETFILTER_SYNPROXY=y
> CONFIG_NF_TABLES=y
> # CONFIG_NF_TABLES_INET is not set
> CONFIG_NF_TABLES_NETDEV=y
> CONFIG_NFT_NUMGEN=m
> # CONFIG_NFT_CT is not set
> CONFIG_NFT_FLOW_OFFLOAD=m
> CONFIG_NFT_COUNTER=y
> # CONFIG_NFT_CONNLIMIT is not set
> CONFIG_NFT_LOG=m
> # CONFIG_NFT_LIMIT is not set
> CONFIG_NFT_MASQ=m
> CONFIG_NFT_REDIR=y
> CONFIG_NFT_NAT=y
> CONFIG_NFT_TUNNEL=y
> CONFIG_NFT_OBJREF=y
> # CONFIG_NFT_QUEUE is not set
> CONFIG_NFT_QUOTA=y
> CONFIG_NFT_REJECT=m
> CONFIG_NFT_COMPAT=y
> CONFIG_NFT_HASH=y
> CONFIG_NFT_FIB=y
> CONFIG_NFT_XFRM=y
> CONFIG_NFT_SOCKET=y
> # CONFIG_NFT_OSF is not set
> # CONFIG_NFT_TPROXY is not set
> CONFIG_NFT_SYNPROXY=y
> CONFIG_NF_DUP_NETDEV=y
> CONFIG_NFT_DUP_NETDEV=y
> # CONFIG_NFT_FWD_NETDEV is not set
> CONFIG_NF_FLOW_TABLE_INET=m
> CONFIG_NF_FLOW_TABLE=m
> CONFIG_NETFILTER_XTABLES=y
> 
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=y
> CONFIG_NETFILTER_XT_CONNMARK=m
> CONFIG_NETFILTER_XT_SET=m
> 
> #
> # Xtables targets
> #
> # CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
> # CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
> CONFIG_NETFILTER_XT_TARGET_CT=m
> CONFIG_NETFILTER_XT_TARGET_DSCP=m
> CONFIG_NETFILTER_XT_TARGET_HL=m
> CONFIG_NETFILTER_XT_TARGET_HMARK=m
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
> CONFIG_NETFILTER_XT_TARGET_LED=y
> # CONFIG_NETFILTER_XT_TARGET_LOG is not set
> CONFIG_NETFILTER_XT_TARGET_MARK=m
> CONFIG_NETFILTER_XT_NAT=m
> CONFIG_NETFILTER_XT_TARGET_NETMAP=y
> # CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
> # CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
> CONFIG_NETFILTER_XT_TARGET_RATEEST=m
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
> # CONFIG_NETFILTER_XT_TARGET_TEE is not set
> CONFIG_NETFILTER_XT_TARGET_TPROXY=m
> CONFIG_NETFILTER_XT_TARGET_TRACE=m
> # CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
> # CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
> # CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set
> 
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
> CONFIG_NETFILTER_XT_MATCH_BPF=y
> # CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
> CONFIG_NETFILTER_XT_MATCH_COMMENT=m
> # CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
> # CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
> CONFIG_NETFILTER_XT_MATCH_CPU=m
> CONFIG_NETFILTER_XT_MATCH_DCCP=m
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
> CONFIG_NETFILTER_XT_MATCH_DSCP=y
> CONFIG_NETFILTER_XT_MATCH_ECN=y
> # CONFIG_NETFILTER_XT_MATCH_ESP is not set
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
> CONFIG_NETFILTER_XT_MATCH_HELPER=m
> CONFIG_NETFILTER_XT_MATCH_HL=y
> CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
> CONFIG_NETFILTER_XT_MATCH_IPVS=m
> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> # CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
> # CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
> # CONFIG_NETFILTER_XT_MATCH_MAC is not set
> CONFIG_NETFILTER_XT_MATCH_MARK=y
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
> CONFIG_NETFILTER_XT_MATCH_NFACCT=y
> # CONFIG_NETFILTER_XT_MATCH_OSF is not set
> # CONFIG_NETFILTER_XT_MATCH_OWNER is not set
> # CONFIG_NETFILTER_XT_MATCH_POLICY is not set
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
> CONFIG_NETFILTER_XT_MATCH_QUOTA=m
> # CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
> # CONFIG_NETFILTER_XT_MATCH_REALM is not set
> CONFIG_NETFILTER_XT_MATCH_RECENT=m
> # CONFIG_NETFILTER_XT_MATCH_SCTP is not set
> CONFIG_NETFILTER_XT_MATCH_SOCKET=m
> # CONFIG_NETFILTER_XT_MATCH_STATE is not set
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
> # CONFIG_NETFILTER_XT_MATCH_STRING is not set
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
> CONFIG_NETFILTER_XT_MATCH_TIME=y
> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> # end of Core Netfilter Configuration
> 
> CONFIG_IP_SET=m
> CONFIG_IP_SET_MAX=256
> CONFIG_IP_SET_BITMAP_IP=m
> # CONFIG_IP_SET_BITMAP_IPMAC is not set
> # CONFIG_IP_SET_BITMAP_PORT is not set
> # CONFIG_IP_SET_HASH_IP is not set
> CONFIG_IP_SET_HASH_IPMARK=m
> CONFIG_IP_SET_HASH_IPPORT=m
> CONFIG_IP_SET_HASH_IPPORTIP=m
> # CONFIG_IP_SET_HASH_IPPORTNET is not set
> CONFIG_IP_SET_HASH_IPMAC=m
> CONFIG_IP_SET_HASH_MAC=m
> CONFIG_IP_SET_HASH_NETPORTNET=m
> # CONFIG_IP_SET_HASH_NET is not set
> CONFIG_IP_SET_HASH_NETNET=m
> CONFIG_IP_SET_HASH_NETPORT=m
> CONFIG_IP_SET_HASH_NETIFACE=m
> CONFIG_IP_SET_LIST_SET=m
> CONFIG_IP_VS=m
> # CONFIG_IP_VS_IPV6 is not set
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=12
> 
> #
> # IPVS transport protocol load balancing support
> #
> # CONFIG_IP_VS_PROTO_TCP is not set
> CONFIG_IP_VS_PROTO_UDP=y
> CONFIG_IP_VS_PROTO_AH_ESP=y
> # CONFIG_IP_VS_PROTO_ESP is not set
> CONFIG_IP_VS_PROTO_AH=y
> # CONFIG_IP_VS_PROTO_SCTP is not set
> 
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=m
> # CONFIG_IP_VS_WRR is not set
> # CONFIG_IP_VS_LC is not set
> CONFIG_IP_VS_WLC=m
> # CONFIG_IP_VS_FO is not set
> CONFIG_IP_VS_OVF=m
> CONFIG_IP_VS_LBLC=m
> # CONFIG_IP_VS_LBLCR is not set
> CONFIG_IP_VS_DH=m
> CONFIG_IP_VS_SH=m
> CONFIG_IP_VS_MH=m
> CONFIG_IP_VS_SED=m
> CONFIG_IP_VS_NQ=m
> CONFIG_IP_VS_TWOS=m
> 
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=8
> 
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=12
> 
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_NFCT=y
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=y
> CONFIG_NF_SOCKET_IPV4=y
> CONFIG_NF_TPROXY_IPV4=m
> CONFIG_NF_TABLES_IPV4=y
> CONFIG_NFT_REJECT_IPV4=m
> # CONFIG_NFT_DUP_IPV4 is not set
> CONFIG_NFT_FIB_IPV4=y
> # CONFIG_NF_TABLES_ARP is not set
> CONFIG_NF_FLOW_TABLE_IPV4=m
> # CONFIG_NF_DUP_IPV4 is not set
> # CONFIG_NF_LOG_ARP is not set
> # CONFIG_NF_LOG_IPV4 is not set
> CONFIG_NF_REJECT_IPV4=y
> CONFIG_NF_NAT_H323=m
> CONFIG_IP_NF_IPTABLES=y
> # CONFIG_IP_NF_MATCH_AH is not set
> CONFIG_IP_NF_MATCH_ECN=y
> CONFIG_IP_NF_MATCH_RPFILTER=m
> CONFIG_IP_NF_MATCH_TTL=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_SYNPROXY=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_NETMAP=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> CONFIG_IP_NF_MANGLE=m
> # CONFIG_IP_NF_TARGET_CLUSTERIP is not set
> # CONFIG_IP_NF_TARGET_ECN is not set
> CONFIG_IP_NF_TARGET_TTL=m
> CONFIG_IP_NF_RAW=y
> # CONFIG_IP_NF_SECURITY is not set
> CONFIG_IP_NF_ARPTABLES=y
> CONFIG_IP_NF_ARPFILTER=m
> # CONFIG_IP_NF_ARP_MANGLE is not set
> # end of IP: Netfilter Configuration
> 
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_NF_SOCKET_IPV6=m
> CONFIG_NF_TPROXY_IPV6=m
> # CONFIG_NF_TABLES_IPV6 is not set
> CONFIG_NF_FLOW_TABLE_IPV6=m
> # CONFIG_NF_DUP_IPV6 is not set
> CONFIG_NF_REJECT_IPV6=y
> CONFIG_NF_LOG_IPV6=m
> CONFIG_IP6_NF_IPTABLES=m
> # CONFIG_IP6_NF_MATCH_AH is not set
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> # CONFIG_IP6_NF_MATCH_OPTS is not set
> CONFIG_IP6_NF_MATCH_HL=m
> # CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
> # CONFIG_IP6_NF_MATCH_MH is not set
> CONFIG_IP6_NF_MATCH_RT=m
> # CONFIG_IP6_NF_MATCH_SRH is not set
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_REJECT=m
> # CONFIG_IP6_NF_TARGET_SYNPROXY is not set
> # CONFIG_IP6_NF_MANGLE is not set
> # CONFIG_IP6_NF_RAW is not set
> # CONFIG_IP6_NF_SECURITY is not set
> CONFIG_IP6_NF_NAT=m
> CONFIG_IP6_NF_TARGET_MASQUERADE=m
> CONFIG_IP6_NF_TARGET_NPT=m
> # end of IPv6: Netfilter Configuration
> 
> CONFIG_NF_DEFRAG_IPV6=y
> CONFIG_NF_TABLES_BRIDGE=m
> CONFIG_NFT_BRIDGE_META=m
> CONFIG_NFT_BRIDGE_REJECT=m
> CONFIG_NF_CONNTRACK_BRIDGE=m
> # CONFIG_BRIDGE_NF_EBTABLES is not set
> CONFIG_BPFILTER=y
> CONFIG_BPFILTER_UMH=m
> # CONFIG_IP_DCCP is not set
> CONFIG_IP_SCTP=m
> # CONFIG_SCTP_DBG_OBJCNT is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_SCTP_COOKIE_HMAC_MD5=y
> CONFIG_SCTP_COOKIE_HMAC_SHA1=y
> CONFIG_INET_SCTP_DIAG=m
> # CONFIG_RDS is not set
> CONFIG_TIPC=m
> # CONFIG_TIPC_MEDIA_UDP is not set
> CONFIG_TIPC_CRYPTO=y
> CONFIG_TIPC_DIAG=m
> CONFIG_ATM=y
> CONFIG_ATM_CLIP=y
> CONFIG_ATM_CLIP_NO_ICMP=y
> CONFIG_ATM_LANE=y
> CONFIG_ATM_MPOA=m
> CONFIG_ATM_BR2684=y
> CONFIG_ATM_BR2684_IPFILTER=y
> CONFIG_L2TP=y
> CONFIG_L2TP_DEBUGFS=y
> # CONFIG_L2TP_V3 is not set
> CONFIG_STP=m
> CONFIG_BRIDGE=m
> CONFIG_BRIDGE_IGMP_SNOOPING=y
> CONFIG_BRIDGE_MRP=y
> CONFIG_BRIDGE_CFM=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> CONFIG_LLC=y
> # CONFIG_LLC2 is not set
> CONFIG_ATALK=y
> CONFIG_DEV_APPLETALK=m
> # CONFIG_LTPC is not set
> # CONFIG_COPS is not set
> CONFIG_IPDDP=m
> # CONFIG_IPDDP_ENCAP is not set
> CONFIG_X25=y
> # CONFIG_LAPB is not set
> CONFIG_PHONET=y
> CONFIG_6LOWPAN=m
> # CONFIG_6LOWPAN_DEBUGFS is not set
> CONFIG_6LOWPAN_NHC=m
> # CONFIG_6LOWPAN_NHC_DEST is not set
> CONFIG_6LOWPAN_NHC_FRAGMENT=m
> CONFIG_6LOWPAN_NHC_HOP=m
> CONFIG_6LOWPAN_NHC_IPV6=m
> CONFIG_6LOWPAN_NHC_MOBILITY=m
> CONFIG_6LOWPAN_NHC_ROUTING=m
> CONFIG_6LOWPAN_NHC_UDP=m
> CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
> # CONFIG_6LOWPAN_GHC_UDP is not set
> CONFIG_6LOWPAN_GHC_ICMPV6=m
> CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=m
> CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=m
> # CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
> CONFIG_IEEE802154=m
> CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
> CONFIG_IEEE802154_SOCKET=m
> CONFIG_IEEE802154_6LOWPAN=m
> CONFIG_MAC802154=m
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=m
> # CONFIG_NET_SCH_HTB is not set
> # CONFIG_NET_SCH_HFSC is not set
> CONFIG_NET_SCH_ATM=m
> CONFIG_NET_SCH_PRIO=y
> CONFIG_NET_SCH_MULTIQ=m
> CONFIG_NET_SCH_RED=m
> CONFIG_NET_SCH_SFB=y
> # CONFIG_NET_SCH_SFQ is not set
> CONFIG_NET_SCH_TEQL=m
> CONFIG_NET_SCH_TBF=m
> CONFIG_NET_SCH_CBS=m
> CONFIG_NET_SCH_ETF=m
> # CONFIG_NET_SCH_TAPRIO is not set
> CONFIG_NET_SCH_GRED=y
> # CONFIG_NET_SCH_DSMARK is not set
> CONFIG_NET_SCH_NETEM=y
> CONFIG_NET_SCH_DRR=m
> CONFIG_NET_SCH_MQPRIO=y
> CONFIG_NET_SCH_SKBPRIO=y
> CONFIG_NET_SCH_CHOKE=y
> CONFIG_NET_SCH_QFQ=m
> # CONFIG_NET_SCH_CODEL is not set
> CONFIG_NET_SCH_FQ_CODEL=m
> CONFIG_NET_SCH_CAKE=y
> # CONFIG_NET_SCH_FQ is not set
> CONFIG_NET_SCH_HHF=m
> # CONFIG_NET_SCH_PIE is not set
> CONFIG_NET_SCH_INGRESS=y
> # CONFIG_NET_SCH_PLUG is not set
> CONFIG_NET_SCH_ETS=m
> # CONFIG_NET_SCH_DEFAULT is not set
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_BASIC=y
> # CONFIG_NET_CLS_TCINDEX is not set
> CONFIG_NET_CLS_ROUTE4=y
> CONFIG_NET_CLS_FW=m
> CONFIG_NET_CLS_U32=m
> # CONFIG_CLS_U32_PERF is not set
> CONFIG_CLS_U32_MARK=y
> CONFIG_NET_CLS_RSVP=y
> CONFIG_NET_CLS_RSVP6=y
> CONFIG_NET_CLS_FLOW=y
> # CONFIG_NET_CLS_CGROUP is not set
> CONFIG_NET_CLS_BPF=m
> # CONFIG_NET_CLS_FLOWER is not set
> # CONFIG_NET_CLS_MATCHALL is not set
> CONFIG_NET_EMATCH=y
> CONFIG_NET_EMATCH_STACK=32
> CONFIG_NET_EMATCH_CMP=y
> CONFIG_NET_EMATCH_NBYTE=m
> # CONFIG_NET_EMATCH_U32 is not set
> # CONFIG_NET_EMATCH_META is not set
> # CONFIG_NET_EMATCH_TEXT is not set
> # CONFIG_NET_EMATCH_CANID is not set
> CONFIG_NET_EMATCH_IPSET=m
> # CONFIG_NET_EMATCH_IPT is not set
> CONFIG_NET_CLS_ACT=y
> CONFIG_NET_ACT_POLICE=y
> CONFIG_NET_ACT_GACT=m
> # CONFIG_GACT_PROB is not set
> CONFIG_NET_ACT_MIRRED=m
> CONFIG_NET_ACT_SAMPLE=m
> CONFIG_NET_ACT_IPT=y
> CONFIG_NET_ACT_NAT=m
> # CONFIG_NET_ACT_PEDIT is not set
> # CONFIG_NET_ACT_SIMP is not set
> CONFIG_NET_ACT_SKBEDIT=m
> CONFIG_NET_ACT_CSUM=m
> CONFIG_NET_ACT_MPLS=y
> CONFIG_NET_ACT_VLAN=y
> CONFIG_NET_ACT_BPF=m
> CONFIG_NET_ACT_CONNMARK=m
> CONFIG_NET_ACT_CTINFO=m
> CONFIG_NET_ACT_SKBMOD=y
> # CONFIG_NET_ACT_IFE is not set
> CONFIG_NET_ACT_TUNNEL_KEY=y
> CONFIG_NET_ACT_CT=m
> CONFIG_NET_ACT_GATE=y
> # CONFIG_NET_TC_SKB_EXT is not set
> CONFIG_NET_SCH_FIFO=y
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=y
> CONFIG_BATMAN_ADV=y
> CONFIG_BATMAN_ADV_BATMAN_V=y
> CONFIG_BATMAN_ADV_BLA=y
> # CONFIG_BATMAN_ADV_DAT is not set
> CONFIG_BATMAN_ADV_NC=y
> # CONFIG_BATMAN_ADV_DEBUG is not set
> # CONFIG_BATMAN_ADV_TRACING is not set
> CONFIG_OPENVSWITCH=y
> # CONFIG_OPENVSWITCH_GRE is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> CONFIG_MPLS=y
> CONFIG_NET_MPLS_GSO=y
> # CONFIG_MPLS_ROUTING is not set
> CONFIG_NET_NSH=y
> CONFIG_HSR=m
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> CONFIG_QRTR=m
> CONFIG_QRTR_SMD=m
> CONFIG_QRTR_TUN=m
> # CONFIG_QRTR_MHI is not set
> # CONFIG_NET_NCSI is not set
> # CONFIG_PCPU_DEV_REFCNT is not set
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_SOCK_RX_QUEUE_MAPPING=y
> CONFIG_XPS=y
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NET_DROP_MONITOR is not set
> # end of Network testing
> # end of Networking options
> 
> CONFIG_HAMRADIO=y
> 
> #
> # Packet Radio protocols
> #
> # CONFIG_AX25 is not set
> CONFIG_CAN=m
> # CONFIG_CAN_RAW is not set
> CONFIG_CAN_BCM=m
> CONFIG_CAN_GW=m
> CONFIG_CAN_J1939=m
> CONFIG_CAN_ISOTP=m
> 
> #
> # CAN Device Drivers
> #
> # CONFIG_CAN_VCAN is not set
> CONFIG_CAN_VXCAN=m
> # CONFIG_CAN_SLCAN is not set
> CONFIG_CAN_DEV=m
> # CONFIG_CAN_CALC_BITTIMING is not set
> CONFIG_CAN_JANZ_ICAN3=m
> CONFIG_CAN_KVASER_PCIEFD=m
> CONFIG_PCH_CAN=m
> CONFIG_CAN_C_CAN=m
> CONFIG_CAN_C_CAN_PLATFORM=m
> # CONFIG_CAN_C_CAN_PCI is not set
> CONFIG_CAN_CC770=m
> CONFIG_CAN_CC770_ISA=m
> # CONFIG_CAN_CC770_PLATFORM is not set
> # CONFIG_CAN_IFI_CANFD is not set
> # CONFIG_CAN_M_CAN is not set
> # CONFIG_CAN_PEAK_PCIEFD is not set
> # CONFIG_CAN_SJA1000 is not set
> CONFIG_CAN_SOFTING=m
> 
> #
> # CAN SPI interfaces
> #
> CONFIG_CAN_HI311X=m
> CONFIG_CAN_MCP251X=m
> CONFIG_CAN_MCP251XFD=m
> # CONFIG_CAN_MCP251XFD_SANITY is not set
> # end of CAN SPI interfaces
> 
> # CONFIG_CAN_DEBUG_DEVICES is not set
> # end of CAN Device Drivers
> 
> # CONFIG_BT is not set
> CONFIG_AF_RXRPC=y
> # CONFIG_AF_RXRPC_IPV6 is not set
> CONFIG_AF_RXRPC_INJECT_LOSS=y
> # CONFIG_AF_RXRPC_DEBUG is not set
> CONFIG_RXKAD=y
> CONFIG_AF_KCM=y
> CONFIG_STREAM_PARSER=y
> # CONFIG_MCTP is not set
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> CONFIG_RFKILL=m
> CONFIG_RFKILL_LEDS=y
> # CONFIG_RFKILL_INPUT is not set
> CONFIG_RFKILL_GPIO=m
> CONFIG_NET_9P=y
> CONFIG_NET_9P_VIRTIO=m
> CONFIG_NET_9P_DEBUG=y
> # CONFIG_CAIF is not set
> CONFIG_CEPH_LIB=m
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> # CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
> CONFIG_NFC=m
> CONFIG_NFC_DIGITAL=m
> CONFIG_NFC_NCI=m
> CONFIG_NFC_NCI_SPI=m
> # CONFIG_NFC_NCI_UART is not set
> # CONFIG_NFC_HCI is not set
> 
> #
> # Near Field Communication (NFC) devices
> #
> CONFIG_NFC_TRF7970A=m
> # CONFIG_NFC_SIM is not set
> CONFIG_NFC_VIRTUAL_NCI=m
> # CONFIG_NFC_FDP is not set
> # CONFIG_NFC_PN533_I2C is not set
> # CONFIG_NFC_ST_NCI_I2C is not set
> # CONFIG_NFC_ST_NCI_SPI is not set
> CONFIG_NFC_NXP_NCI=m
> CONFIG_NFC_NXP_NCI_I2C=m
> CONFIG_NFC_S3FWRN5=m
> CONFIG_NFC_S3FWRN5_I2C=m
> CONFIG_NFC_ST95HF=m
> # end of Near Field Communication (NFC) devices
> 
> CONFIG_PSAMPLE=m
> CONFIG_NET_IFE=m
> CONFIG_LWTUNNEL=y
> # CONFIG_LWTUNNEL_BPF is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_NET_SOCK_MSG=y
> CONFIG_FAILOVER=m
> # CONFIG_ETHTOOL_NETLINK is not set
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PTM=y
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_STUB is not set
> CONFIG_PCI_ATS=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> # CONFIG_PCI_IOV is not set
> # CONFIG_PCI_PRI is not set
> CONFIG_PCI_PASID=y
> CONFIG_PCI_LABEL=y
> # CONFIG_PCIE_BUS_TUNE_OFF is not set
> # CONFIG_PCIE_BUS_DEFAULT is not set
> # CONFIG_PCIE_BUS_SAFE is not set
> CONFIG_PCIE_BUS_PERFORMANCE=y
> # CONFIG_PCIE_BUS_PEER2PEER is not set
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # PCI controller drivers
> #
> 
> #
> # DesignWare PCI Core Support
> #
> CONFIG_PCIE_DW=y
> CONFIG_PCIE_DW_HOST=y
> CONFIG_PCIE_DW_PLAT=y
> CONFIG_PCIE_DW_PLAT_HOST=y
> # CONFIG_PCI_MESON is not set
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> CONFIG_PCI_SW_SWITCHTEC=m
> # end of PCI switch controller drivers
> 
> # CONFIG_CXL_BUS is not set
> CONFIG_PCCARD=m
> # CONFIG_PCMCIA is not set
> # CONFIG_CARDBUS is not set
> 
> #
> # PC-card bridges
> #
> CONFIG_YENTA=m
> # CONFIG_YENTA_O2 is not set
> CONFIG_YENTA_RICOH=y
> # CONFIG_YENTA_TI is not set
> # CONFIG_YENTA_TOSHIBA is not set
> CONFIG_PCMCIA_PROBE=y
> CONFIG_RAPIDIO=m
> CONFIG_RAPIDIO_DISC_TIMEOUT=30
> CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
> # CONFIG_RAPIDIO_DEBUG is not set
> CONFIG_RAPIDIO_ENUM_BASIC=m
> # CONFIG_RAPIDIO_CHMAN is not set
> CONFIG_RAPIDIO_MPORT_CDEV=m
> 
> #
> # RapidIO Switch drivers
> #
> CONFIG_RAPIDIO_TSI57X=m
> # CONFIG_RAPIDIO_CPS_XX is not set
> # CONFIG_RAPIDIO_TSI568 is not set
> CONFIG_RAPIDIO_CPS_GEN2=m
> CONFIG_RAPIDIO_RXS_GEN3=m
> # end of RapidIO Switch drivers
> 
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=y
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_FW_LOADER_USER_HELPER is not set
> CONFIG_FW_LOADER_COMPRESS=y
> CONFIG_FW_CACHE=y
> # end of Firmware loader
> 
> CONFIG_WANT_DEV_COREDUMP=y
> # CONFIG_ALLOW_DEV_COREDUMP is not set
> # CONFIG_DEBUG_DRIVER is not set
> CONFIG_DEBUG_DEVRES=y
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_PM_QOS_KUNIT_TEST=y
> CONFIG_TEST_ASYNC_DRIVER_PROBE=m
> CONFIG_DRIVER_PE_KUNIT_TEST=y
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SLIMBUS=m
> CONFIG_REGMAP_SPI=y
> CONFIG_REGMAP_SPMI=m
> CONFIG_REGMAP_W1=m
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_REGMAP_SOUNDWIRE=m
> CONFIG_REGMAP_SOUNDWIRE_MBQ=m
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> CONFIG_MHI_BUS=y
> # CONFIG_MHI_BUS_DEBUG is not set
> CONFIG_MHI_BUS_PCI_GENERIC=y
> # end of Bus devices
> 
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> CONFIG_GNSS=m
> CONFIG_MTD=y
> CONFIG_MTD_TESTS=m
> 
> #
> # Partition parsers
> #
> CONFIG_MTD_AR7_PARTS=y
> # CONFIG_MTD_CMDLINE_PARTS is not set
> CONFIG_MTD_REDBOOT_PARTS=y
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=y
> # CONFIG_MTD_BLOCK is not set
> CONFIG_MTD_BLOCK_RO=y
> 
> #
> # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> #
> CONFIG_FTL=m
> # CONFIG_NFTL is not set
> CONFIG_INFTL=m
> CONFIG_RFD_FTL=y
> CONFIG_SSFDC=y
> CONFIG_SM_FTL=m
> CONFIG_MTD_OOPS=y
> CONFIG_MTD_SWAP=m
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> CONFIG_MTD_JEDECPROBE=y
> CONFIG_MTD_GEN_PROBE=y
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_CFI_INTELEXT is not set
> CONFIG_MTD_CFI_AMDSTD=y
> # CONFIG_MTD_CFI_STAA is not set
> CONFIG_MTD_CFI_UTIL=y
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> CONFIG_MTD_ABSENT=m
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=y
> CONFIG_MTD_PHYSMAP=m
> CONFIG_MTD_PHYSMAP_COMPAT=y
> CONFIG_MTD_PHYSMAP_START=0x8000000
> CONFIG_MTD_PHYSMAP_LEN=0
> CONFIG_MTD_PHYSMAP_BANKWIDTH=2
> # CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
> # CONFIG_MTD_SCx200_DOCFLASH is not set
> # CONFIG_MTD_AMD76XROM is not set
> CONFIG_MTD_ICHXROM=m
> CONFIG_MTD_ESB2ROM=m
> # CONFIG_MTD_CK804XROM is not set
> CONFIG_MTD_SCB2_FLASH=y
> # CONFIG_MTD_NETtel is not set
> CONFIG_MTD_L440GX=m
> CONFIG_MTD_PCI=y
> CONFIG_MTD_INTEL_VR_NOR=y
> CONFIG_MTD_PLATRAM=y
> # end of Mapping drivers for chip access
> 
> #
> # Self-contained MTD device drivers
> #
> CONFIG_MTD_PMC551=m
> CONFIG_MTD_PMC551_BUGFIX=y
> CONFIG_MTD_PMC551_DEBUG=y
> CONFIG_MTD_DATAFLASH=y
> # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> CONFIG_MTD_DATAFLASH_OTP=y
> # CONFIG_MTD_MCHP23K256 is not set
> # CONFIG_MTD_MCHP48L640 is not set
> CONFIG_MTD_SST25L=m
> CONFIG_MTD_SLRAM=m
> # CONFIG_MTD_PHRAM is not set
> CONFIG_MTD_MTDRAM=y
> CONFIG_MTDRAM_TOTAL_SIZE=4096
> CONFIG_MTDRAM_ERASE_SIZE=128
> CONFIG_MTD_BLOCK2MTD=m
> 
> #
> # Disk-On-Chip Device Drivers
> #
> CONFIG_MTD_DOCG3=m
> CONFIG_BCH_CONST_M=14
> CONFIG_BCH_CONST_T=4
> # end of Self-contained MTD device drivers
> 
> #
> # NAND
> #
> CONFIG_MTD_NAND_CORE=y
> CONFIG_MTD_ONENAND=m
> # CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
> # CONFIG_MTD_ONENAND_GENERIC is not set
> # CONFIG_MTD_ONENAND_OTP is not set
> CONFIG_MTD_ONENAND_2X_PROGRAM=y
> # CONFIG_MTD_RAW_NAND is not set
> CONFIG_MTD_SPI_NAND=y
> 
> #
> # ECC engine support
> #
> CONFIG_MTD_NAND_ECC=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
> CONFIG_MTD_NAND_ECC_SW_BCH=y
> # end of ECC engine support
> # end of NAND
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=m
> CONFIG_MTD_QINFO_PROBE=m
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> CONFIG_MTD_SPI_NOR=m
> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> # CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
> # CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE is not set
> CONFIG_MTD_SPI_NOR_SWP_KEEP=y
> CONFIG_SPI_INTEL_SPI=m
> CONFIG_SPI_INTEL_SPI_PCI=m
> # CONFIG_SPI_INTEL_SPI_PLATFORM is not set
> CONFIG_MTD_UBI=m
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> # CONFIG_MTD_UBI_FASTMAP is not set
> CONFIG_MTD_UBI_GLUEBI=m
> CONFIG_MTD_UBI_BLOCK=y
> CONFIG_MTD_HYPERBUS=y
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PARPORT=m
> # CONFIG_PARPORT_PC is not set
> # CONFIG_PARPORT_AX88796 is not set
> CONFIG_PARPORT_1284=y
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG_MESSAGES is not set
> 
> #
> # Protocols
> #
> CONFIG_ISAPNP=y
> # CONFIG_PNPBIOS is not set
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> CONFIG_BLK_DEV_NULL_BLK=m
> CONFIG_BLK_DEV_FD=y
> CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
> # CONFIG_ZRAM is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=y
> CONFIG_BLK_DEV_SX8=m
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=4096
> # CONFIG_CDROM_PKTCDVD is not set
> CONFIG_ATA_OVER_ETH=m
> CONFIG_VIRTIO_BLK=m
> CONFIG_BLK_DEV_RBD=m
> # CONFIG_BLK_DEV_RSXX is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=y
> CONFIG_BLK_DEV_NVME=y
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=y
> CONFIG_NVME_FC=y
> # CONFIG_NVME_TCP is not set
> CONFIG_NVME_TARGET=m
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> CONFIG_NVME_TARGET_LOOP=m
> CONFIG_NVME_TARGET_FC=m
> CONFIG_NVME_TARGET_FCLOOP=m
> # CONFIG_NVME_TARGET_TCP is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_AD525X_DPOT=m
> CONFIG_AD525X_DPOT_I2C=m
> # CONFIG_AD525X_DPOT_SPI is not set
> CONFIG_DUMMY_IRQ=y
> # CONFIG_IBM_ASM is not set
> CONFIG_PHANTOM=m
> CONFIG_TIFM_CORE=m
> CONFIG_TIFM_7XX1=m
> CONFIG_ICS932S401=y
> # CONFIG_ENCLOSURE_SERVICES is not set
> CONFIG_CS5535_MFGPT=y
> CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
> # CONFIG_CS5535_CLOCK_EVENT_SRC is not set
> CONFIG_HP_ILO=y
> CONFIG_APDS9802ALS=m
> CONFIG_ISL29003=m
> CONFIG_ISL29020=y
> CONFIG_SENSORS_TSL2550=m
> CONFIG_SENSORS_BH1770=m
> CONFIG_SENSORS_APDS990X=y
> CONFIG_HMC6352=m
> CONFIG_DS1682=m
> # CONFIG_VMWARE_BALLOON is not set
> CONFIG_PCH_PHUB=y
> CONFIG_LATTICE_ECP3_CONFIG=m
> CONFIG_SRAM=y
> CONFIG_DW_XDATA_PCIE=m
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_MISC_RTSX=m
> CONFIG_C2PORT=m
> CONFIG_C2PORT_DURAMAR_2150=m
> 
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=y
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_LEGACY=m
> CONFIG_EEPROM_MAX6875=y
> CONFIG_EEPROM_93CX6=y
> CONFIG_EEPROM_93XX46=m
> CONFIG_EEPROM_IDT_89HPESX=y
> CONFIG_EEPROM_EE1004=m
> # end of EEPROM support
> 
> CONFIG_CB710_CORE=m
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> # CONFIG_SENSORS_LIS3_I2C is not set
> CONFIG_ALTERA_STAPL=y
> CONFIG_INTEL_MEI=m
> CONFIG_INTEL_MEI_ME=m
> CONFIG_INTEL_MEI_TXE=m
> CONFIG_VMWARE_VMCI=y
> # CONFIG_ECHO is not set
> CONFIG_BCM_VK=m
> # CONFIG_BCM_VK_TTY is not set
> CONFIG_MISC_ALCOR_PCI=m
> CONFIG_MISC_RTSX_PCI=m
> # CONFIG_HABANA_AI is not set
> CONFIG_PVPANIC=y
> CONFIG_PVPANIC_MMIO=m
> # CONFIG_PVPANIC_PCI is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=m
> CONFIG_RAID_ATTRS=m
> CONFIG_SCSI_COMMON=m
> CONFIG_SCSI=m
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_NETLINK=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=m
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=m
> CONFIG_BLK_DEV_BSG=y
> CONFIG_CHR_DEV_SCH=m
> CONFIG_SCSI_CONSTANTS=y
> # CONFIG_SCSI_LOGGING is not set
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=m
> CONFIG_SCSI_FC_ATTRS=m
> CONFIG_SCSI_ISCSI_ATTRS=m
> # CONFIG_SCSI_SAS_ATTRS is not set
> # CONFIG_SCSI_SAS_LIBSAS is not set
> CONFIG_SCSI_SRP_ATTRS=m
> # end of SCSI Transports
> 
> # CONFIG_SCSI_LOWLEVEL is not set
> # CONFIG_SCSI_DH is not set
> # end of SCSI device support
> 
> CONFIG_ATA=m
> CONFIG_SATA_HOST=y
> CONFIG_PATA_TIMINGS=y
> # CONFIG_ATA_VERBOSE_ERROR is not set
> CONFIG_ATA_FORCE=y
> CONFIG_ATA_ACPI=y
> CONFIG_SATA_ZPODD=y
> # CONFIG_SATA_PMP is not set
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=m
> CONFIG_SATA_MOBILE_LPM_POLICY=0
> # CONFIG_SATA_AHCI_PLATFORM is not set
> CONFIG_SATA_INIC162X=m
> # CONFIG_SATA_ACARD_AHCI is not set
> CONFIG_SATA_SIL24=m
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> CONFIG_SATA_QSTOR=m
> # CONFIG_SATA_SX4 is not set
> # CONFIG_ATA_BMDMA is not set
> 
> #
> # PIO-only SFF controllers
> #
> CONFIG_PATA_CMD640_PCI=m
> CONFIG_PATA_ISAPNP=m
> CONFIG_PATA_MPIIX=m
> CONFIG_PATA_NS87410=m
> CONFIG_PATA_OPTI=m
> # CONFIG_PATA_PLATFORM is not set
> CONFIG_PATA_QDI=m
> CONFIG_PATA_RZ1000=m
> CONFIG_PATA_WINBOND_VLB=m
> 
> #
> # Generic fallback / legacy drivers
> #
> CONFIG_PATA_LEGACY=m
> # CONFIG_MD is not set
> CONFIG_TARGET_CORE=m
> # CONFIG_TCM_IBLOCK is not set
> CONFIG_TCM_FILEIO=m
> CONFIG_TCM_PSCSI=m
> CONFIG_TCM_USER2=m
> CONFIG_LOOPBACK_TARGET=m
> CONFIG_ISCSI_TARGET=m
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> CONFIG_FIREWIRE_NOSY=m
> # end of IEEE 1394 (FireWire) support
> 
> CONFIG_MACINTOSH_DRIVERS=y
> # CONFIG_MAC_EMUMOUSEBTN is not set
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_IFB is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_RIONET is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> CONFIG_VIRTIO_NET=m
> # CONFIG_NLMON is not set
> # CONFIG_MHI_NET is not set
> # CONFIG_ARCNET is not set
> CONFIG_ATM_DRIVERS=y
> # CONFIG_ATM_DUMMY is not set
> # CONFIG_ATM_TCP is not set
> # CONFIG_ATM_LANAI is not set
> # CONFIG_ATM_ENI is not set
> # CONFIG_ATM_FIRESTREAM is not set
> # CONFIG_ATM_ZATM is not set
> # CONFIG_ATM_NICSTAR is not set
> # CONFIG_ATM_IDT77252 is not set
> # CONFIG_ATM_AMBASSADOR is not set
> # CONFIG_ATM_HORIZON is not set
> # CONFIG_ATM_IA is not set
> # CONFIG_ATM_FORE200E is not set
> # CONFIG_ATM_HE is not set
> # CONFIG_ATM_SOLOS is not set
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL3 is not set
> # CONFIG_3C515 is not set
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_ENA_ETHERNET is not set
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_LANCE is not set
> # CONFIG_PCNET32 is not set
> # CONFIG_NI65 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CIRRUS=y
> # CONFIG_CS89x0_ISA is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_NET_VENDOR_GOOGLE=y
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> # CONFIG_E1000E is not set
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> # CONFIG_IXGBE is not set
> # CONFIG_IXGBEVF is not set
> # CONFIG_I40E is not set
> # CONFIG_I40EVF is not set
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> # CONFIG_IGC is not set
> CONFIG_NET_VENDOR_MICROSOFT=y
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_LITEX=y
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> # CONFIG_NFP is not set
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2000 is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_ULTRA is not set
> # CONFIG_WD80x3 is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_ATP is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_SMC9194 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_MICREL_KS8995MA is not set
> # CONFIG_MDIO_DEVICE is not set
> 
> #
> # PCS device drivers
> #
> # end of PCS device drivers
> 
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K_PCI is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> CONFIG_WLAN_VENDOR_BROADCOM=y
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_WLAN_VENDOR_INTEL=y
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_WLAN_VENDOR_RSI=y
> CONFIG_WLAN_VENDOR_ST=y
> CONFIG_WLAN_VENDOR_TI=y
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> # CONFIG_WAN is not set
> CONFIG_IEEE802154_DRIVERS=m
> # CONFIG_IEEE802154_FAKELB is not set
> # CONFIG_IEEE802154_AT86RF230 is not set
> # CONFIG_IEEE802154_MRF24J40 is not set
> # CONFIG_IEEE802154_CC2520 is not set
> # CONFIG_IEEE802154_ADF7242 is not set
> # CONFIG_IEEE802154_CA8210 is not set
> # CONFIG_IEEE802154_MCR20A is not set
> # CONFIG_IEEE802154_HWSIM is not set
> 
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
> 
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_USB4_NET is not set
> # CONFIG_NETDEVSIM is not set
> CONFIG_NET_FAILOVER=m
> # CONFIG_ISDN is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=y
> # CONFIG_INPUT_FF_MEMLESS is not set
> CONFIG_INPUT_SPARSEKMAP=m
> # CONFIG_INPUT_MATRIXKMAP is not set
> 
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_TWL4030 is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CROS_EC is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_LIFEBOOK=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> # CONFIG_MOUSE_PS2_ELANTECH is not set
> # CONFIG_MOUSE_PS2_SENTELIC is not set
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=y
> # CONFIG_MOUSE_PS2_VMMOUSE is not set
> CONFIG_MOUSE_PS2_SMBUS=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_ELAN_I2C is not set
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_MOUSE_GPIO is not set
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> # CONFIG_RMI4_CORE is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> CONFIG_SERIO_CT82C710=y
> CONFIG_SERIO_PARKBD=m
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=m
> # CONFIG_SERIO_ALTERA_PS2 is not set
> CONFIG_SERIO_PS2MULT=m
> # CONFIG_SERIO_ARC_PS2 is not set
> # CONFIG_SERIO_GPIO_PS2 is not set
> CONFIG_USERIO=y
> CONFIG_GAMEPORT=y
> CONFIG_GAMEPORT_NS558=m
> CONFIG_GAMEPORT_L4=m
> CONFIG_GAMEPORT_EMU10K1=m
> CONFIG_GAMEPORT_FM801=m
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> # CONFIG_VT is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> # CONFIG_SERIAL_8250_MEN_MCB is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> CONFIG_SERIAL_8250_DWLIB=y
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> # CONFIG_SERIAL_BCM63XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_PCH_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_MEN_Z135 is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_GOLDFISH_TTY is not set
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_NULL_TTY is not set
> # CONFIG_SERIAL_DEV_BUS is not set
> # CONFIG_TTY_PRINTK is not set
> CONFIG_PRINTER=m
> CONFIG_LP_CONSOLE=y
> CONFIG_PPDEV=m
> # CONFIG_VIRTIO_CONSOLE is not set
> CONFIG_IPMI_HANDLER=m
> CONFIG_IPMI_DMI_DECODE=y
> CONFIG_IPMI_PLAT_DATA=y
> CONFIG_IPMI_PANIC_EVENT=y
> # CONFIG_IPMI_PANIC_STRING is not set
> # CONFIG_IPMI_DEVICE_INTERFACE is not set
> CONFIG_IPMI_SI=m
> # CONFIG_IPMI_SSIF is not set
> CONFIG_IPMI_WATCHDOG=m
> # CONFIG_IPMI_POWEROFF is not set
> CONFIG_IPMB_DEVICE_INTERFACE=m
> # CONFIG_HW_RANDOM is not set
> CONFIG_DTLK=y
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> # CONFIG_MWAVE is not set
> # CONFIG_SCx200_GPIO is not set
> CONFIG_PC8736x_GPIO=m
> CONFIG_NSC_GPIO=m
> # CONFIG_DEVMEM is not set
> CONFIG_NVRAM=y
> CONFIG_DEVPORT=y
> CONFIG_HPET=y
> CONFIG_HPET_MMAP=y
> CONFIG_HPET_MMAP_DEFAULT=y
> CONFIG_HANGCHECK_TIMER=m
> # CONFIG_TCG_TPM is not set
> # CONFIG_TELCLOCK is not set
> CONFIG_XILLYBUS_CLASS=m
> CONFIG_XILLYBUS=m
> CONFIG_XILLYBUS_PCIE=m
> CONFIG_RANDOM_TRUST_CPU=y
> CONFIG_RANDOM_TRUST_BOOTLOADER=y
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> # CONFIG_ACPI_I2C_OPREGION is not set
> CONFIG_I2C_BOARDINFO=y
> # CONFIG_I2C_COMPAT is not set
> # CONFIG_I2C_CHARDEV is not set
> CONFIG_I2C_MUX=m
> 
> #
> # Multiplexer I2C Chip support
> #
> CONFIG_I2C_MUX_GPIO=m
> CONFIG_I2C_MUX_LTC4306=m
> CONFIG_I2C_MUX_PCA9541=m
> # CONFIG_I2C_MUX_PCA954x is not set
> CONFIG_I2C_MUX_REG=m
> CONFIG_I2C_MUX_MLXCPLD=m
> # end of Multiplexer I2C Chip support
> 
> # CONFIG_I2C_HELPER_AUTO is not set
> CONFIG_I2C_SMBUS=y
> 
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=m
> CONFIG_I2C_ALGOPCF=y
> CONFIG_I2C_ALGOPCA=y
> # end of I2C Algorithms
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_ALI1535=m
> CONFIG_I2C_ALI1563=y
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> CONFIG_I2C_AMD8111=m
> CONFIG_I2C_AMD_MP2=y
> CONFIG_I2C_I801=y
> CONFIG_I2C_ISCH=y
> CONFIG_I2C_ISMT=m
> CONFIG_I2C_PIIX4=y
> CONFIG_I2C_NFORCE2=y
> # CONFIG_I2C_NFORCE2_S4985 is not set
> CONFIG_I2C_NVIDIA_GPU=y
> CONFIG_I2C_SIS5595=m
> CONFIG_I2C_SIS630=m
> CONFIG_I2C_SIS96X=y
> # CONFIG_I2C_VIA is not set
> CONFIG_I2C_VIAPRO=m
> 
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=m
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=y
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> CONFIG_I2C_DESIGNWARE_PCI=y
> # CONFIG_I2C_EG20T is not set
> CONFIG_I2C_EMEV2=y
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_KEMPLD is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PCA_PLATFORM=y
> # CONFIG_I2C_SIMTEC is not set
> CONFIG_I2C_XILINX=m
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_PARPORT=m
> # CONFIG_I2C_TAOS_EVM is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_PCA_ISA=m
> # CONFIG_I2C_CROS_EC_TUNNEL is not set
> # CONFIG_SCx200_ACB is not set
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
> 
> CONFIG_I2C_STUB=m
> CONFIG_I2C_SLAVE=y
> # CONFIG_I2C_SLAVE_EEPROM is not set
> CONFIG_I2C_SLAVE_TESTUNIT=y
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> # CONFIG_I3C is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> CONFIG_SPI_MEM=y
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> CONFIG_SPI_AXI_SPI_ENGINE=y
> CONFIG_SPI_BITBANG=y
> CONFIG_SPI_BUTTERFLY=m
> CONFIG_SPI_CADENCE=m
> CONFIG_SPI_DESIGNWARE=m
> CONFIG_SPI_DW_DMA=y
> CONFIG_SPI_DW_PCI=m
> CONFIG_SPI_DW_MMIO=m
> # CONFIG_SPI_NXP_FLEXSPI is not set
> CONFIG_SPI_GPIO=y
> CONFIG_SPI_LM70_LLP=m
> # CONFIG_SPI_LANTIQ_SSC is not set
> CONFIG_SPI_OC_TINY=y
> CONFIG_SPI_PXA2XX=y
> CONFIG_SPI_PXA2XX_PCI=y
> # CONFIG_SPI_ROCKCHIP is not set
> CONFIG_SPI_SC18IS602=y
> CONFIG_SPI_SIFIVE=y
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_TOPCLIFF_PCH is not set
> # CONFIG_SPI_XCOMM is not set
> CONFIG_SPI_XILINX=m
> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> CONFIG_SPI_AMD=y
> 
> #
> # SPI Multiplexer support
> #
> CONFIG_SPI_MUX=y
> 
> #
> # SPI Protocol Masters
> #
> CONFIG_SPI_SPIDEV=m
> CONFIG_SPI_LOOPBACK_TEST=m
> CONFIG_SPI_TLE62X0=m
> CONFIG_SPI_SLAVE=y
> CONFIG_SPI_SLAVE_TIME=m
> # CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
> CONFIG_SPI_DYNAMIC=y
> CONFIG_SPMI=y
> # CONFIG_SPMI_HISI3670 is not set
> CONFIG_HSI=y
> CONFIG_HSI_BOARDINFO=y
> 
> #
> # HSI controllers
> #
> 
> #
> # HSI clients
> #
> # CONFIG_HSI_CHAR is not set
> # CONFIG_PPS is not set
> 
> #
> # PTP clock support
> #
> # CONFIG_PTP_1588_CLOCK is not set
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> # CONFIG_PINCTRL_AMD is not set
> CONFIG_PINCTRL_DA9062=m
> CONFIG_PINCTRL_MCP23S08_I2C=y
> CONFIG_PINCTRL_MCP23S08_SPI=y
> CONFIG_PINCTRL_MCP23S08=y
> CONFIG_PINCTRL_SX150X=y
> CONFIG_PINCTRL_BAYTRAIL=y
> CONFIG_PINCTRL_CHERRYVIEW=m
> # CONFIG_PINCTRL_LYNXPOINT is not set
> CONFIG_PINCTRL_MERRIFIELD=y
> CONFIG_PINCTRL_INTEL=y
> CONFIG_PINCTRL_ALDERLAKE=m
> CONFIG_PINCTRL_BROXTON=y
> CONFIG_PINCTRL_CANNONLAKE=y
> # CONFIG_PINCTRL_CEDARFORK is not set
> CONFIG_PINCTRL_DENVERTON=y
> CONFIG_PINCTRL_ELKHARTLAKE=m
> # CONFIG_PINCTRL_EMMITSBURG is not set
> CONFIG_PINCTRL_GEMINILAKE=y
> CONFIG_PINCTRL_ICELAKE=y
> # CONFIG_PINCTRL_JASPERLAKE is not set
> CONFIG_PINCTRL_LAKEFIELD=m
> CONFIG_PINCTRL_LEWISBURG=y
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> CONFIG_PINCTRL_TIGERLAKE=y
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_PINCTRL_MADERA=m
> CONFIG_PINCTRL_CS47L85=y
> CONFIG_PINCTRL_CS47L92=y
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> CONFIG_DEBUG_GPIO=y
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_CDEV=y
> # CONFIG_GPIO_CDEV_V1 is not set
> CONFIG_GPIO_GENERIC=m
> CONFIG_GPIO_MAX730X=m
> 
> #
> # Memory mapped GPIO drivers
> #
> CONFIG_GPIO_AMDPT=m
> CONFIG_GPIO_DWAPB=m
> # CONFIG_GPIO_EXAR is not set
> CONFIG_GPIO_GENERIC_PLATFORM=m
> CONFIG_GPIO_ICH=m
> CONFIG_GPIO_MB86S7X=m
> CONFIG_GPIO_MENZ127=m
> CONFIG_GPIO_SIOX=y
> # CONFIG_GPIO_VX855 is not set
> CONFIG_GPIO_AMD_FCH=y
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_F7188X=y
> CONFIG_GPIO_IT87=m
> CONFIG_GPIO_SCH=y
> CONFIG_GPIO_SCH311X=m
> # CONFIG_GPIO_WINBOND is not set
> CONFIG_GPIO_WS16C48=m
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> CONFIG_GPIO_MAX7300=m
> # CONFIG_GPIO_MAX732X is not set
> CONFIG_GPIO_PCA953X=y
> CONFIG_GPIO_PCA953X_IRQ=y
> CONFIG_GPIO_PCA9570=m
> # CONFIG_GPIO_PCF857X is not set
> CONFIG_GPIO_TPIC2810=m
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> # CONFIG_GPIO_ARIZONA is not set
> CONFIG_GPIO_BD9571MWV=m
> # CONFIG_GPIO_CS5535 is not set
> CONFIG_GPIO_DA9055=m
> CONFIG_GPIO_JANZ_TTL=m
> # CONFIG_GPIO_KEMPLD is not set
> CONFIG_GPIO_LP3943=m
> CONFIG_GPIO_MADERA=m
> CONFIG_GPIO_PALMAS=y
> # CONFIG_GPIO_RC5T583 is not set
> # CONFIG_GPIO_TIMBERDALE is not set
> # CONFIG_GPIO_TPS65086 is not set
> CONFIG_GPIO_TPS6586X=y
> # CONFIG_GPIO_TPS65912 is not set
> # CONFIG_GPIO_TQMX86 is not set
> # CONFIG_GPIO_TWL4030 is not set
> CONFIG_GPIO_TWL6040=y
> CONFIG_GPIO_WHISKEY_COVE=m
> CONFIG_GPIO_WM8994=m
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_MERRIFIELD is not set
> CONFIG_GPIO_ML_IOH=m
> CONFIG_GPIO_PCH=y
> CONFIG_GPIO_PCI_IDIO_16=y
> CONFIG_GPIO_PCIE_IDIO_24=m
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> CONFIG_GPIO_MAX3191X=y
> CONFIG_GPIO_MAX7301=m
> # CONFIG_GPIO_MC33880 is not set
> CONFIG_GPIO_PISOSR=m
> CONFIG_GPIO_XRA1403=y
> # end of SPI GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> CONFIG_GPIO_AGGREGATOR=m
> CONFIG_GPIO_MOCKUP=y
> # CONFIG_GPIO_VIRTIO is not set
> # end of Virtual GPIO drivers
> 
> CONFIG_W1=m
> CONFIG_W1_CON=y
> 
> #
> # 1-wire Bus Masters
> #
> # CONFIG_W1_MASTER_MATROX is not set
> CONFIG_W1_MASTER_DS2482=m
> # CONFIG_W1_MASTER_DS1WM is not set
> # CONFIG_W1_MASTER_GPIO is not set
> CONFIG_W1_MASTER_SGI=m
> # end of 1-wire Bus Masters
> 
> #
> # 1-wire Slaves
> #
> # CONFIG_W1_SLAVE_THERM is not set
> CONFIG_W1_SLAVE_SMEM=m
> CONFIG_W1_SLAVE_DS2405=m
> CONFIG_W1_SLAVE_DS2408=m
> CONFIG_W1_SLAVE_DS2408_READBACK=y
> # CONFIG_W1_SLAVE_DS2413 is not set
> CONFIG_W1_SLAVE_DS2406=m
> CONFIG_W1_SLAVE_DS2423=m
> CONFIG_W1_SLAVE_DS2805=m
> CONFIG_W1_SLAVE_DS2430=m
> # CONFIG_W1_SLAVE_DS2431 is not set
> CONFIG_W1_SLAVE_DS2433=m
> CONFIG_W1_SLAVE_DS2433_CRC=y
> CONFIG_W1_SLAVE_DS2438=m
> CONFIG_W1_SLAVE_DS250X=m
> CONFIG_W1_SLAVE_DS2780=m
> CONFIG_W1_SLAVE_DS2781=m
> CONFIG_W1_SLAVE_DS28E04=m
> CONFIG_W1_SLAVE_DS28E17=m
> # end of 1-wire Slaves
> 
> CONFIG_POWER_RESET=y
> CONFIG_POWER_RESET_RESTART=y
> # CONFIG_POWER_RESET_TPS65086 is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=y
> # CONFIG_PDA_POWER is not set
> CONFIG_GENERIC_ADC_BATTERY=m
> CONFIG_TEST_POWER=y
> CONFIG_BATTERY_88PM860X=m
> # CONFIG_CHARGER_ADP5061 is not set
> CONFIG_BATTERY_CW2015=y
> # CONFIG_BATTERY_DS2760 is not set
> # CONFIG_BATTERY_DS2780 is not set
> CONFIG_BATTERY_DS2781=m
> CONFIG_BATTERY_DS2782=m
> CONFIG_BATTERY_SBS=m
> CONFIG_CHARGER_SBS=m
> CONFIG_MANAGER_SBS=m
> # CONFIG_BATTERY_BQ27XXX is not set
> CONFIG_BATTERY_DA9030=m
> CONFIG_CHARGER_AXP20X=m
> CONFIG_BATTERY_AXP20X=m
> CONFIG_AXP20X_POWER=m
> CONFIG_AXP288_FUEL_GAUGE=m
> # CONFIG_BATTERY_MAX17040 is not set
> CONFIG_BATTERY_MAX17042=m
> CONFIG_BATTERY_MAX1721X=m
> CONFIG_BATTERY_TWL4030_MADC=y
> # CONFIG_CHARGER_88PM860X is not set
> CONFIG_CHARGER_PCF50633=y
> # CONFIG_BATTERY_RX51 is not set
> CONFIG_CHARGER_MAX8903=y
> # CONFIG_CHARGER_TWL4030 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_MANAGER is not set
> CONFIG_CHARGER_LT3651=y
> CONFIG_CHARGER_LTC4162L=m
> CONFIG_CHARGER_MAX14577=y
> CONFIG_CHARGER_MP2629=m
> # CONFIG_CHARGER_MT6360 is not set
> CONFIG_CHARGER_BQ2415X=m
> CONFIG_CHARGER_BQ24190=y
> CONFIG_CHARGER_BQ24257=m
> # CONFIG_CHARGER_BQ24735 is not set
> CONFIG_CHARGER_BQ2515X=y
> CONFIG_CHARGER_BQ25890=m
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> CONFIG_CHARGER_SMB347=m
> CONFIG_BATTERY_GAUGE_LTC2941=y
> CONFIG_BATTERY_GOLDFISH=m
> CONFIG_BATTERY_RT5033=y
> CONFIG_CHARGER_RT9455=y
> # CONFIG_CHARGER_CROS_USBPD is not set
> CONFIG_CHARGER_CROS_PCHG=m
> CONFIG_CHARGER_BD99954=y
> # CONFIG_CHARGER_WILCO is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> # CONFIG_SENSORS_ABITUGURU is not set
> CONFIG_SENSORS_ABITUGURU3=y
> # CONFIG_SENSORS_AD7314 is not set
> CONFIG_SENSORS_AD7414=y
> CONFIG_SENSORS_AD7418=y
> CONFIG_SENSORS_ADM1021=m
> CONFIG_SENSORS_ADM1025=m
> CONFIG_SENSORS_ADM1026=m
> # CONFIG_SENSORS_ADM1029 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> CONFIG_SENSORS_ADM1177=y
> CONFIG_SENSORS_ADM9240=y
> # CONFIG_SENSORS_ADT7310 is not set
> # CONFIG_SENSORS_ADT7410 is not set
> CONFIG_SENSORS_ADT7411=y
> # CONFIG_SENSORS_ADT7462 is not set
> # CONFIG_SENSORS_ADT7470 is not set
> CONFIG_SENSORS_ADT7475=m
> CONFIG_SENSORS_AHT10=m
> CONFIG_SENSORS_AS370=y
> CONFIG_SENSORS_ASC7621=y
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> # CONFIG_SENSORS_K8TEMP is not set
> # CONFIG_SENSORS_APPLESMC is not set
> CONFIG_SENSORS_ASB100=y
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=y
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> CONFIG_SENSORS_DRIVETEMP=m
> # CONFIG_SENSORS_DS620 is not set
> CONFIG_SENSORS_DS1621=m
> CONFIG_SENSORS_DELL_SMM=y
> # CONFIG_SENSORS_DA9055 is not set
> CONFIG_SENSORS_I5K_AMB=m
> CONFIG_SENSORS_F71805F=m
> # CONFIG_SENSORS_F71882FG is not set
> CONFIG_SENSORS_F75375S=m
> # CONFIG_SENSORS_MC13783_ADC is not set
> CONFIG_SENSORS_FSCHMD=m
> # CONFIG_SENSORS_FTSTEUTATES is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_G760A is not set
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IBMAEM=m
> # CONFIG_SENSORS_IBMPEX is not set
> CONFIG_SENSORS_IIO_HWMON=m
> CONFIG_SENSORS_I5500=y
> CONFIG_SENSORS_CORETEMP=y
> CONFIG_SENSORS_IT87=y
> CONFIG_SENSORS_JC42=y
> CONFIG_SENSORS_POWR1220=m
> CONFIG_SENSORS_LINEAGE=m
> # CONFIG_SENSORS_LTC2945 is not set
> CONFIG_SENSORS_LTC2947=y
> CONFIG_SENSORS_LTC2947_I2C=y
> CONFIG_SENSORS_LTC2947_SPI=y
> CONFIG_SENSORS_LTC2990=y
> CONFIG_SENSORS_LTC2992=y
> # CONFIG_SENSORS_LTC4151 is not set
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=m
> CONFIG_SENSORS_LTC4260=y
> CONFIG_SENSORS_LTC4261=y
> CONFIG_SENSORS_MAX1111=m
> CONFIG_SENSORS_MAX127=y
> # CONFIG_SENSORS_MAX16065 is not set
> CONFIG_SENSORS_MAX1619=m
> CONFIG_SENSORS_MAX1668=y
> # CONFIG_SENSORS_MAX197 is not set
> CONFIG_SENSORS_MAX31722=y
> # CONFIG_SENSORS_MAX31730 is not set
> CONFIG_SENSORS_MAX6621=y
> # CONFIG_SENSORS_MAX6639 is not set
> # CONFIG_SENSORS_MAX6642 is not set
> # CONFIG_SENSORS_MAX6650 is not set
> CONFIG_SENSORS_MAX6697=m
> CONFIG_SENSORS_MAX31790=m
> CONFIG_SENSORS_MCP3021=y
> CONFIG_SENSORS_TC654=y
> # CONFIG_SENSORS_TPS23861 is not set
> # CONFIG_SENSORS_MENF21BMC_HWMON is not set
> CONFIG_SENSORS_MR75203=m
> # CONFIG_SENSORS_ADCXX is not set
> CONFIG_SENSORS_LM63=m
> CONFIG_SENSORS_LM70=y
> CONFIG_SENSORS_LM73=y
> # CONFIG_SENSORS_LM75 is not set
> CONFIG_SENSORS_LM77=m
> # CONFIG_SENSORS_LM78 is not set
> CONFIG_SENSORS_LM80=y
> CONFIG_SENSORS_LM83=m
> CONFIG_SENSORS_LM85=m
> CONFIG_SENSORS_LM87=y
> CONFIG_SENSORS_LM90=m
> CONFIG_SENSORS_LM92=m
> CONFIG_SENSORS_LM93=y
> # CONFIG_SENSORS_LM95234 is not set
> # CONFIG_SENSORS_LM95241 is not set
> CONFIG_SENSORS_LM95245=m
> CONFIG_SENSORS_PC87360=y
> CONFIG_SENSORS_PC87427=m
> CONFIG_SENSORS_NTC_THERMISTOR=y
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775=y
> CONFIG_SENSORS_NCT7802=m
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> CONFIG_SENSORS_PCF8591=m
> CONFIG_PMBUS=m
> CONFIG_SENSORS_PMBUS=m
> CONFIG_SENSORS_ADM1266=m
> CONFIG_SENSORS_ADM1275=m
> CONFIG_SENSORS_BEL_PFE=m
> CONFIG_SENSORS_BPA_RS600=m
> CONFIG_SENSORS_FSP_3Y=m
> CONFIG_SENSORS_IBM_CFFPS=m
> # CONFIG_SENSORS_DPS920AB is not set
> CONFIG_SENSORS_INSPUR_IPSPS=m
> CONFIG_SENSORS_IR35221=m
> # CONFIG_SENSORS_IR36021 is not set
> # CONFIG_SENSORS_IR38064 is not set
> CONFIG_SENSORS_IRPS5401=m
> # CONFIG_SENSORS_ISL68137 is not set
> CONFIG_SENSORS_LM25066=m
> CONFIG_SENSORS_LTC2978=m
> CONFIG_SENSORS_LTC2978_REGULATOR=y
> # CONFIG_SENSORS_LTC3815 is not set
> CONFIG_SENSORS_MAX15301=m
> CONFIG_SENSORS_MAX16064=m
> CONFIG_SENSORS_MAX16601=m
> # CONFIG_SENSORS_MAX20730 is not set
> CONFIG_SENSORS_MAX20751=m
> CONFIG_SENSORS_MAX31785=m
> # CONFIG_SENSORS_MAX34440 is not set
> # CONFIG_SENSORS_MAX8688 is not set
> CONFIG_SENSORS_MP2888=m
> # CONFIG_SENSORS_MP2975 is not set
> # CONFIG_SENSORS_PIM4328 is not set
> CONFIG_SENSORS_PM6764TR=m
> # CONFIG_SENSORS_PXE1610 is not set
> CONFIG_SENSORS_Q54SJ108A2=m
> CONFIG_SENSORS_STPDDC60=m
> # CONFIG_SENSORS_TPS40422 is not set
> # CONFIG_SENSORS_TPS53679 is not set
> # CONFIG_SENSORS_UCD9000 is not set
> # CONFIG_SENSORS_UCD9200 is not set
> CONFIG_SENSORS_XDPE122=m
> CONFIG_SENSORS_ZL6100=m
> CONFIG_SENSORS_SBTSI=y
> # CONFIG_SENSORS_SBRMI is not set
> # CONFIG_SENSORS_SHT15 is not set
> CONFIG_SENSORS_SHT21=m
> # CONFIG_SENSORS_SHT3x is not set
> CONFIG_SENSORS_SHT4x=y
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=m
> # CONFIG_SENSORS_DME1737 is not set
> CONFIG_SENSORS_EMC1403=m
> # CONFIG_SENSORS_EMC2103 is not set
> CONFIG_SENSORS_EMC6W201=m
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_SMSC47M192 is not set
> CONFIG_SENSORS_SMSC47B397=m
> CONFIG_SENSORS_SCH56XX_COMMON=y
> CONFIG_SENSORS_SCH5627=m
> CONFIG_SENSORS_SCH5636=y
> CONFIG_SENSORS_STTS751=m
> CONFIG_SENSORS_SMM665=y
> CONFIG_SENSORS_ADC128D818=m
> # CONFIG_SENSORS_ADS7828 is not set
> CONFIG_SENSORS_ADS7871=y
> # CONFIG_SENSORS_AMC6821 is not set
> # CONFIG_SENSORS_INA209 is not set
> # CONFIG_SENSORS_INA2XX is not set
> CONFIG_SENSORS_INA3221=m
> CONFIG_SENSORS_TC74=m
> # CONFIG_SENSORS_THMC50 is not set
> CONFIG_SENSORS_TMP102=m
> # CONFIG_SENSORS_TMP103 is not set
> CONFIG_SENSORS_TMP108=m
> # CONFIG_SENSORS_TMP401 is not set
> # CONFIG_SENSORS_TMP421 is not set
> CONFIG_SENSORS_TMP513=y
> # CONFIG_SENSORS_VIA_CPUTEMP is not set
> CONFIG_SENSORS_VIA686A=y
> CONFIG_SENSORS_VT1211=m
> CONFIG_SENSORS_VT8231=m
> CONFIG_SENSORS_W83773G=m
> CONFIG_SENSORS_W83781D=m
> CONFIG_SENSORS_W83791D=y
> # CONFIG_SENSORS_W83792D is not set
> # CONFIG_SENSORS_W83793 is not set
> CONFIG_SENSORS_W83795=m
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=y
> CONFIG_SENSORS_W83L786NG=y
> # CONFIG_SENSORS_W83627HF is not set
> CONFIG_SENSORS_W83627EHF=y
> CONFIG_SENSORS_XGENE=m
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=m
> CONFIG_SENSORS_ATK0110=m
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_NETLINK is not set
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> # CONFIG_THERMAL_EMULATION is not set
> 
> #
> # Intel thermal drivers
> #
> # CONFIG_INTEL_POWERCLAMP is not set
> CONFIG_X86_THERMAL_VECTOR=y
> CONFIG_X86_PKG_TEMP_THERMAL=m
> CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
> CONFIG_INTEL_SOC_DTS_THERMAL=m
> 
> #
> # ACPI INT340X thermal drivers
> #
> CONFIG_INT340X_THERMAL=y
> CONFIG_ACPI_THERMAL_REL=y
> # end of ACPI INT340X thermal drivers
> 
> CONFIG_INTEL_BXT_PMIC_THERMAL=m
> CONFIG_INTEL_PCH_THERMAL=m
> CONFIG_INTEL_TCC_COOLING=m
> # CONFIG_INTEL_MENLOW is not set
> # end of Intel thermal drivers
> 
> # CONFIG_GENERIC_ADC_THERMAL is not set
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> # CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
> CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> CONFIG_WATCHDOG_SYSFS=y
> CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y
> 
> #
> # Watchdog Pretimeout Governors
> #
> CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
> CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
> # CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
> 
> #
> # Watchdog Device Drivers
> #
> # CONFIG_SOFT_WATCHDOG is not set
> CONFIG_DA9055_WATCHDOG=y
> CONFIG_DA9063_WATCHDOG=m
> CONFIG_DA9062_WATCHDOG=y
> # CONFIG_MENF21BMC_WATCHDOG is not set
> # CONFIG_MENZ069_WATCHDOG is not set
> # CONFIG_WDAT_WDT is not set
> CONFIG_XILINX_WATCHDOG=m
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> CONFIG_CADENCE_WATCHDOG=y
> # CONFIG_DW_WATCHDOG is not set
> CONFIG_TWL4030_WATCHDOG=y
> # CONFIG_MAX63XX_WATCHDOG is not set
> CONFIG_RETU_WATCHDOG=m
> # CONFIG_ACQUIRE_WDT is not set
> CONFIG_ADVANTECH_WDT=m
> CONFIG_ALIM1535_WDT=y
> CONFIG_ALIM7101_WDT=m
> CONFIG_EBC_C384_WDT=y
> # CONFIG_F71808E_WDT is not set
> # CONFIG_SP5100_TCO is not set
> CONFIG_GEODE_WDT=m
> # CONFIG_SBC_FITPC2_WATCHDOG is not set
> # CONFIG_EUROTECH_WDT is not set
> CONFIG_IB700_WDT=y
> # CONFIG_IBMASR is not set
> CONFIG_WAFER_WDT=y
> CONFIG_I6300ESB_WDT=y
> # CONFIG_IE6XX_WDT is not set
> # CONFIG_INTEL_MID_WATCHDOG is not set
> CONFIG_ITCO_WDT=m
> CONFIG_ITCO_VENDOR_SUPPORT=y
> # CONFIG_IT8712F_WDT is not set
> CONFIG_IT87_WDT=y
> CONFIG_HP_WATCHDOG=y
> # CONFIG_HPWDT_NMI_DECODING is not set
> CONFIG_KEMPLD_WDT=m
> CONFIG_SC1200_WDT=m
> CONFIG_SCx200_WDT=m
> CONFIG_PC87413_WDT=y
> CONFIG_NV_TCO=m
> CONFIG_60XX_WDT=m
> CONFIG_SBC8360_WDT=y
> CONFIG_SBC7240_WDT=y
> # CONFIG_CPU5_WDT is not set
> # CONFIG_SMSC_SCH311X_WDT is not set
> CONFIG_SMSC37B787_WDT=y
> # CONFIG_TQMX86_WDT is not set
> CONFIG_VIA_WDT=y
> # CONFIG_W83627HF_WDT is not set
> # CONFIG_W83877F_WDT is not set
> CONFIG_W83977F_WDT=y
> CONFIG_MACHZ_WDT=m
> CONFIG_SBC_EPX_C3_WATCHDOG=y
> CONFIG_INTEL_MEI_WDT=m
> CONFIG_NI903X_WDT=m
> CONFIG_NIC7018_WDT=y
> CONFIG_MEN_A21_WDT=m
> 
> #
> # ISA-based Watchdog Cards
> #
> # CONFIG_PCWATCHDOG is not set
> # CONFIG_MIXCOMWD is not set
> # CONFIG_WDT is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=y
> # CONFIG_WDTPCI is not set
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> # CONFIG_SSB_PCIHOST is not set
> CONFIG_SSB_DRIVER_GPIO=y
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=y
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> # CONFIG_BCMA_HOST_PCI is not set
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=y
> # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> CONFIG_BCMA_DRIVER_GPIO=y
> CONFIG_BCMA_DEBUG=y
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> CONFIG_MFD_CS5535=y
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> CONFIG_MFD_BCM590XX=m
> CONFIG_MFD_BD9571MWV=m
> CONFIG_MFD_AXP20X=y
> CONFIG_MFD_AXP20X_I2C=y
> CONFIG_MFD_CROS_EC_DEV=m
> CONFIG_MFD_MADERA=m
> # CONFIG_MFD_MADERA_I2C is not set
> CONFIG_MFD_MADERA_SPI=m
> # CONFIG_MFD_CS47L15 is not set
> # CONFIG_MFD_CS47L35 is not set
> CONFIG_MFD_CS47L85=y
> # CONFIG_MFD_CS47L90 is not set
> CONFIG_MFD_CS47L92=y
> CONFIG_PMIC_DA903X=y
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> CONFIG_MFD_DA9055=y
> CONFIG_MFD_DA9062=y
> CONFIG_MFD_DA9063=m
> # CONFIG_MFD_DA9150 is not set
> CONFIG_MFD_MC13XXX=y
> CONFIG_MFD_MC13XXX_SPI=m
> CONFIG_MFD_MC13XXX_I2C=y
> CONFIG_MFD_MP2629=m
> CONFIG_HTC_PASIC3=y
> CONFIG_HTC_I2CPLD=y
> CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
> CONFIG_LPC_ICH=y
> CONFIG_LPC_SCH=y
> CONFIG_INTEL_SOC_PMIC_BXTWC=m
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> CONFIG_INTEL_SOC_PMIC_MRFLD=m
> CONFIG_MFD_INTEL_LPSS=y
> CONFIG_MFD_INTEL_LPSS_ACPI=y
> CONFIG_MFD_INTEL_LPSS_PCI=y
> CONFIG_MFD_INTEL_PMC_BXT=m
> CONFIG_MFD_INTEL_PMT=y
> # CONFIG_MFD_IQS62X is not set
> CONFIG_MFD_JANZ_CMODIO=y
> CONFIG_MFD_KEMPLD=m
> CONFIG_MFD_88PM800=y
> CONFIG_MFD_88PM805=y
> CONFIG_MFD_88PM860X=y
> CONFIG_MFD_MAX14577=y
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> CONFIG_MFD_MAX8907=y
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> CONFIG_MFD_MT6360=m
> # CONFIG_MFD_MT6397 is not set
> CONFIG_MFD_MENF21BMC=m
> # CONFIG_EZX_PCAP is not set
> CONFIG_MFD_RETU=m
> CONFIG_MFD_PCF50633=y
> # CONFIG_PCF50633_ADC is not set
> CONFIG_PCF50633_GPIO=m
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> CONFIG_MFD_RT5033=m
> CONFIG_MFD_RC5T583=y
> CONFIG_MFD_SI476X_CORE=y
> # CONFIG_MFD_SM501 is not set
> CONFIG_MFD_SKY81452=m
> CONFIG_MFD_SYSCON=y
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> CONFIG_MFD_LP3943=m
> # CONFIG_MFD_LP8788 is not set
> CONFIG_MFD_TI_LMU=y
> CONFIG_MFD_PALMAS=y
> CONFIG_TPS6105X=y
> # CONFIG_TPS65010 is not set
> CONFIG_TPS6507X=y
> CONFIG_MFD_TPS65086=m
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TI_LP873X is not set
> CONFIG_MFD_TPS6586X=y
> # CONFIG_MFD_TPS65910 is not set
> CONFIG_MFD_TPS65912=y
> # CONFIG_MFD_TPS65912_I2C is not set
> CONFIG_MFD_TPS65912_SPI=y
> CONFIG_MFD_TPS80031=y
> CONFIG_TWL4030_CORE=y
> CONFIG_MFD_TWL4030_AUDIO=y
> CONFIG_TWL6040_CORE=y
> CONFIG_MFD_WL1273_CORE=m
> CONFIG_MFD_LM3533=m
> CONFIG_MFD_TIMBERDALE=y
> CONFIG_MFD_TQMX86=m
> CONFIG_MFD_VX855=y
> CONFIG_MFD_ARIZONA=m
> CONFIG_MFD_ARIZONA_I2C=m
> # CONFIG_MFD_ARIZONA_SPI is not set
> CONFIG_MFD_CS47L24=y
> CONFIG_MFD_WM5102=y
> # CONFIG_MFD_WM5110 is not set
> # CONFIG_MFD_WM8997 is not set
> CONFIG_MFD_WM8998=y
> CONFIG_MFD_WM8400=y
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> CONFIG_MFD_WM8994=m
> CONFIG_MFD_WCD934X=m
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_INTEL_M10_BMC is not set
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> # CONFIG_REGULATOR_DEBUG is not set
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> CONFIG_REGULATOR_88PG86X=m
> CONFIG_REGULATOR_88PM800=m
> CONFIG_REGULATOR_88PM8607=m
> CONFIG_REGULATOR_ACT8865=m
> # CONFIG_REGULATOR_AD5398 is not set
> # CONFIG_REGULATOR_ARIZONA_LDO1 is not set
> CONFIG_REGULATOR_ARIZONA_MICSUPP=m
> # CONFIG_REGULATOR_AXP20X is not set
> # CONFIG_REGULATOR_BCM590XX is not set
> CONFIG_REGULATOR_BD9571MWV=m
> CONFIG_REGULATOR_DA903X=y
> # CONFIG_REGULATOR_DA9055 is not set
> # CONFIG_REGULATOR_DA9062 is not set
> CONFIG_REGULATOR_DA9210=y
> CONFIG_REGULATOR_DA9211=y
> CONFIG_REGULATOR_FAN53555=m
> CONFIG_REGULATOR_GPIO=y
> CONFIG_REGULATOR_ISL9305=y
> # CONFIG_REGULATOR_ISL6271A is not set
> CONFIG_REGULATOR_LM363X=m
> CONFIG_REGULATOR_LP3971=y
> CONFIG_REGULATOR_LP3972=y
> CONFIG_REGULATOR_LP872X=y
> CONFIG_REGULATOR_LP8755=m
> # CONFIG_REGULATOR_LTC3589 is not set
> CONFIG_REGULATOR_LTC3676=y
> CONFIG_REGULATOR_MAX14577=y
> CONFIG_REGULATOR_MAX1586=m
> CONFIG_REGULATOR_MAX8649=m
> CONFIG_REGULATOR_MAX8660=y
> # CONFIG_REGULATOR_MAX8893 is not set
> # CONFIG_REGULATOR_MAX8907 is not set
> CONFIG_REGULATOR_MAX8952=y
> # CONFIG_REGULATOR_MAX77826 is not set
> CONFIG_REGULATOR_MC13XXX_CORE=y
> CONFIG_REGULATOR_MC13783=y
> CONFIG_REGULATOR_MC13892=m
> # CONFIG_REGULATOR_MP8859 is not set
> CONFIG_REGULATOR_MT6311=m
> CONFIG_REGULATOR_MT6315=m
> # CONFIG_REGULATOR_MT6360 is not set
> CONFIG_REGULATOR_PALMAS=y
> # CONFIG_REGULATOR_PCA9450 is not set
> # CONFIG_REGULATOR_PCF50633 is not set
> # CONFIG_REGULATOR_PV88060 is not set
> # CONFIG_REGULATOR_PV88080 is not set
> CONFIG_REGULATOR_PV88090=y
> CONFIG_REGULATOR_QCOM_SPMI=y
> # CONFIG_REGULATOR_QCOM_USB_VBUS is not set
> # CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
> CONFIG_REGULATOR_RC5T583=y
> CONFIG_REGULATOR_RT4801=y
> # CONFIG_REGULATOR_RT5033 is not set
> # CONFIG_REGULATOR_RT6160 is not set
> CONFIG_REGULATOR_RT6245=y
> # CONFIG_REGULATOR_RTQ2134 is not set
> # CONFIG_REGULATOR_RTMV20 is not set
> # CONFIG_REGULATOR_RTQ6752 is not set
> # CONFIG_REGULATOR_SKY81452 is not set
> CONFIG_REGULATOR_SLG51000=m
> CONFIG_REGULATOR_TPS51632=m
> CONFIG_REGULATOR_TPS6105X=y
> CONFIG_REGULATOR_TPS62360=y
> CONFIG_REGULATOR_TPS65023=m
> # CONFIG_REGULATOR_TPS6507X is not set
> CONFIG_REGULATOR_TPS65086=m
> CONFIG_REGULATOR_TPS65132=m
> CONFIG_REGULATOR_TPS6524X=y
> # CONFIG_REGULATOR_TPS6586X is not set
> # CONFIG_REGULATOR_TPS65912 is not set
> CONFIG_REGULATOR_TPS80031=y
> # CONFIG_REGULATOR_TWL4030 is not set
> CONFIG_REGULATOR_WM8400=y
> CONFIG_REGULATOR_WM8994=m
> CONFIG_REGULATOR_QCOM_LABIBB=y
> # CONFIG_RC_CORE is not set
> CONFIG_CEC_CORE=m
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> CONFIG_MEDIA_SUPPORT=m
> CONFIG_MEDIA_SUPPORT_FILTER=y
> CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
> 
> #
> # Media device types
> #
> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> # CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> CONFIG_MEDIA_SDR_SUPPORT=y
> # CONFIG_MEDIA_PLATFORM_SUPPORT is not set
> CONFIG_MEDIA_TEST_SUPPORT=y
> # end of Media device types
> 
> CONFIG_VIDEO_DEV=m
> CONFIG_MEDIA_CONTROLLER=y
> 
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2=m
> CONFIG_VIDEO_V4L2_I2C=y
> CONFIG_VIDEO_V4L2_SUBDEV_API=y
> # CONFIG_VIDEO_ADV_DEBUG is not set
> CONFIG_VIDEO_FIXED_MINOR_RANGES=y
> CONFIG_V4L2_MEM2MEM_DEV=m
> CONFIG_V4L2_FWNODE=m
> CONFIG_V4L2_ASYNC=m
> # end of Video4Linux options
> 
> #
> # Media controller options
> #
> CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
> 
> #
> # Please notice that the enabled Media controller Request API is EXPERIMENTAL
> #
> # end of Media controller options
> 
> #
> # Media drivers
> #
> 
> #
> # Drivers filtered as selected at 'Filter media drivers'
> #
> CONFIG_MEDIA_PCI_SUPPORT=y
> CONFIG_VIDEO_IPU3_CIO2=m
> # CONFIG_CIO2_BRIDGE is not set
> CONFIG_VIDEOBUF2_CORE=m
> CONFIG_VIDEOBUF2_V4L2=m
> CONFIG_VIDEOBUF2_MEMOPS=m
> CONFIG_VIDEOBUF2_VMALLOC=m
> CONFIG_VIDEOBUF2_DMA_SG=m
> CONFIG_VIDEO_V4L2_TPG=m
> CONFIG_V4L_TEST_DRIVERS=y
> CONFIG_VIDEO_VIMC=m
> # CONFIG_VIDEO_VIM2M is not set
> CONFIG_VIDEO_VICODEC=m
> # end of Media drivers
> 
> #
> # Media ancillary drivers
> #
> 
> #
> # Audio decoders, processors and mixers
> #
> CONFIG_VIDEO_TVAUDIO=m
> CONFIG_VIDEO_TDA7432=m
> # CONFIG_VIDEO_TDA9840 is not set
> CONFIG_VIDEO_TDA1997X=m
> CONFIG_VIDEO_TEA6415C=m
> CONFIG_VIDEO_TEA6420=m
> CONFIG_VIDEO_MSP3400=m
> CONFIG_VIDEO_CS3308=m
> # CONFIG_VIDEO_CS5345 is not set
> # CONFIG_VIDEO_CS53L32A is not set
> # CONFIG_VIDEO_TLV320AIC23B is not set
> CONFIG_VIDEO_UDA1342=m
> CONFIG_VIDEO_WM8775=m
> # CONFIG_VIDEO_WM8739 is not set
> CONFIG_VIDEO_VP27SMPX=m
> CONFIG_VIDEO_SONY_BTF_MPX=m
> # end of Audio decoders, processors and mixers
> 
> #
> # RDS decoders
> #
> CONFIG_VIDEO_SAA6588=m
> # end of RDS decoders
> 
> #
> # Video decoders
> #
> # CONFIG_VIDEO_ADV7180 is not set
> CONFIG_VIDEO_ADV7183=m
> # CONFIG_VIDEO_ADV7604 is not set
> CONFIG_VIDEO_ADV7842=m
> CONFIG_VIDEO_ADV7842_CEC=y
> # CONFIG_VIDEO_BT819 is not set
> # CONFIG_VIDEO_BT856 is not set
> # CONFIG_VIDEO_BT866 is not set
> CONFIG_VIDEO_KS0127=m
> CONFIG_VIDEO_ML86V7667=m
> CONFIG_VIDEO_SAA7110=m
> CONFIG_VIDEO_SAA711X=m
> CONFIG_VIDEO_TC358743=m
> CONFIG_VIDEO_TC358743_CEC=y
> CONFIG_VIDEO_TVP514X=m
> CONFIG_VIDEO_TVP5150=m
> CONFIG_VIDEO_TVP7002=m
> CONFIG_VIDEO_TW2804=m
> CONFIG_VIDEO_TW9903=m
> CONFIG_VIDEO_TW9906=m
> CONFIG_VIDEO_TW9910=m
> CONFIG_VIDEO_VPX3220=m
> 
> #
> # Video and audio decoders
> #
> CONFIG_VIDEO_SAA717X=m
> CONFIG_VIDEO_CX25840=m
> # end of Video decoders
> 
> #
> # Video encoders
> #
> CONFIG_VIDEO_SAA7127=m
> CONFIG_VIDEO_SAA7185=m
> # CONFIG_VIDEO_ADV7170 is not set
> CONFIG_VIDEO_ADV7175=m
> # CONFIG_VIDEO_ADV7343 is not set
> CONFIG_VIDEO_ADV7393=m
> CONFIG_VIDEO_ADV7511=m
> # CONFIG_VIDEO_ADV7511_CEC is not set
> CONFIG_VIDEO_AD9389B=m
> CONFIG_VIDEO_AK881X=m
> CONFIG_VIDEO_THS8200=m
> # end of Video encoders
> 
> #
> # Video improvement chips
> #
> CONFIG_VIDEO_UPD64031A=m
> CONFIG_VIDEO_UPD64083=m
> # end of Video improvement chips
> 
> #
> # Audio/Video compression chips
> #
> # CONFIG_VIDEO_SAA6752HS is not set
> # end of Audio/Video compression chips
> 
> #
> # SDR tuner chips
> #
> CONFIG_SDR_MAX2175=m
> # end of SDR tuner chips
> 
> #
> # Miscellaneous helper chips
> #
> # CONFIG_VIDEO_THS7303 is not set
> CONFIG_VIDEO_M52790=m
> # CONFIG_VIDEO_I2C is not set
> CONFIG_VIDEO_ST_MIPID02=m
> # end of Miscellaneous helper chips
> 
> #
> # SPI helper chips
> #
> # CONFIG_VIDEO_GS1662 is not set
> # end of SPI helper chips
> 
> #
> # Media SPI Adapters
> #
> # end of Media SPI Adapters
> 
> CONFIG_MEDIA_TUNER=m
> 
> #
> # Customize TV tuners
> #
> CONFIG_MEDIA_TUNER_SIMPLE=m
> # CONFIG_MEDIA_TUNER_TDA18250 is not set
> CONFIG_MEDIA_TUNER_TDA8290=m
> CONFIG_MEDIA_TUNER_TDA827X=m
> CONFIG_MEDIA_TUNER_TDA18271=m
> CONFIG_MEDIA_TUNER_TDA9887=m
> CONFIG_MEDIA_TUNER_TEA5761=m
> # CONFIG_MEDIA_TUNER_TEA5767 is not set
> CONFIG_MEDIA_TUNER_MSI001=m
> CONFIG_MEDIA_TUNER_MT20XX=m
> # CONFIG_MEDIA_TUNER_MT2060 is not set
> # CONFIG_MEDIA_TUNER_MT2063 is not set
> CONFIG_MEDIA_TUNER_MT2266=m
> CONFIG_MEDIA_TUNER_MT2131=m
> CONFIG_MEDIA_TUNER_QT1010=m
> CONFIG_MEDIA_TUNER_XC2028=m
> CONFIG_MEDIA_TUNER_XC5000=m
> CONFIG_MEDIA_TUNER_XC4000=m
> CONFIG_MEDIA_TUNER_MXL5005S=m
> CONFIG_MEDIA_TUNER_MXL5007T=m
> CONFIG_MEDIA_TUNER_MC44S803=m
> # CONFIG_MEDIA_TUNER_MAX2165 is not set
> CONFIG_MEDIA_TUNER_TDA18218=m
> # CONFIG_MEDIA_TUNER_FC0011 is not set
> # CONFIG_MEDIA_TUNER_FC0012 is not set
> CONFIG_MEDIA_TUNER_FC0013=m
> # CONFIG_MEDIA_TUNER_TDA18212 is not set
> # CONFIG_MEDIA_TUNER_E4000 is not set
> CONFIG_MEDIA_TUNER_FC2580=m
> CONFIG_MEDIA_TUNER_M88RS6000T=m
> # CONFIG_MEDIA_TUNER_TUA9001 is not set
> CONFIG_MEDIA_TUNER_SI2157=m
> # CONFIG_MEDIA_TUNER_IT913X is not set
> CONFIG_MEDIA_TUNER_R820T=m
> CONFIG_MEDIA_TUNER_MXL301RF=m
> CONFIG_MEDIA_TUNER_QM1D1C0042=m
> CONFIG_MEDIA_TUNER_QM1D1B0004=m
> # end of Customize TV tuners
> 
> #
> # Tools to develop new frontends
> #
> # end of Media ancillary drivers
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> CONFIG_VGA_SWITCHEROO=y
> # CONFIG_DRM is not set
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> #
> # Frame buffer Devices
> #
> # CONFIG_FB is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=y
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_ILI922X is not set
> CONFIG_LCD_ILI9320=m
> CONFIG_LCD_TDO24M=y
> CONFIG_LCD_VGG2432A4=m
> CONFIG_LCD_PLATFORM=y
> CONFIG_LCD_AMS369FG06=y
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> CONFIG_LCD_OTM3225A=y
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_KTD253=y
> CONFIG_BACKLIGHT_LM3533=m
> CONFIG_BACKLIGHT_DA903X=y
> # CONFIG_BACKLIGHT_APPLE is not set
> CONFIG_BACKLIGHT_QCOM_WLED=m
> CONFIG_BACKLIGHT_SAHARA=y
> CONFIG_BACKLIGHT_ADP8860=m
> CONFIG_BACKLIGHT_ADP8870=m
> CONFIG_BACKLIGHT_88PM860X=m
> CONFIG_BACKLIGHT_PCF50633=m
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_PANDORA=y
> CONFIG_BACKLIGHT_SKY81452=m
> CONFIG_BACKLIGHT_GPIO=m
> CONFIG_BACKLIGHT_LV5207LP=m
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # end of Backlight & LCD device support
> 
> CONFIG_HDMI=y
> # end of Graphics support
> 
> CONFIG_SOUND=y
> CONFIG_SND=y
> CONFIG_SND_TIMER=y
> CONFIG_SND_PCM=y
> CONFIG_SND_DMAENGINE_PCM=y
> CONFIG_SND_HWDEP=y
> CONFIG_SND_SEQ_DEVICE=y
> CONFIG_SND_RAWMIDI=y
> CONFIG_SND_COMPRESS_OFFLOAD=y
> CONFIG_SND_JACK=y
> CONFIG_SND_JACK_INPUT_DEV=y
> # CONFIG_SND_OSSEMUL is not set
> # CONFIG_SND_PCM_TIMER is not set
> CONFIG_SND_HRTIMER=y
> CONFIG_SND_DYNAMIC_MINORS=y
> CONFIG_SND_MAX_CARDS=32
> # CONFIG_SND_SUPPORT_OLD_API is not set
> CONFIG_SND_PROC_FS=y
> CONFIG_SND_VERBOSE_PROCFS=y
> CONFIG_SND_VERBOSE_PRINTK=y
> CONFIG_SND_DEBUG=y
> CONFIG_SND_DEBUG_VERBOSE=y
> # CONFIG_SND_PCM_XRUN_DEBUG is not set
> CONFIG_SND_CTL_VALIDATION=y
> CONFIG_SND_JACK_INJECTION_DEBUG=y
> CONFIG_SND_DMA_SGBUF=y
> CONFIG_SND_SEQUENCER=y
> CONFIG_SND_SEQ_DUMMY=y
> # CONFIG_SND_SEQ_HRTIMER_DEFAULT is not set
> CONFIG_SND_SEQ_MIDI_EVENT=y
> CONFIG_SND_SEQ_MIDI=y
> CONFIG_SND_SEQ_MIDI_EMUL=y
> CONFIG_SND_MPU401_UART=y
> CONFIG_SND_OPL3_LIB=y
> CONFIG_SND_OPL4_LIB=m
> CONFIG_SND_OPL3_LIB_SEQ=y
> CONFIG_SND_OPL4_LIB_SEQ=m
> # CONFIG_SND_DRIVERS is not set
> CONFIG_SND_WSS_LIB=y
> CONFIG_SND_SB_COMMON=y
> CONFIG_SND_SB8_DSP=y
> CONFIG_SND_SB16_DSP=y
> CONFIG_SND_ISA=y
> CONFIG_SND_ADLIB=m
> CONFIG_SND_AD1816A=m
> CONFIG_SND_AD1848=y
> # CONFIG_SND_ALS100 is not set
> CONFIG_SND_AZT1605=y
> # CONFIG_SND_AZT2316 is not set
> CONFIG_SND_AZT2320=y
> # CONFIG_SND_CMI8328 is not set
> CONFIG_SND_CMI8330=y
> CONFIG_SND_CS4231=m
> CONFIG_SND_CS4236=y
> # CONFIG_SND_ES1688 is not set
> # CONFIG_SND_ES18XX is not set
> CONFIG_SND_SC6000=y
> CONFIG_SND_GUSCLASSIC=m
> CONFIG_SND_GUSEXTREME=y
> CONFIG_SND_GUSMAX=y
> CONFIG_SND_INTERWAVE=m
> # CONFIG_SND_INTERWAVE_STB is not set
> # CONFIG_SND_JAZZ16 is not set
> CONFIG_SND_OPL3SA2=y
> CONFIG_SND_OPTI92X_AD1848=m
> CONFIG_SND_OPTI92X_CS4231=m
> CONFIG_SND_OPTI93X=m
> CONFIG_SND_MIRO=m
> CONFIG_SND_SB8=y
> # CONFIG_SND_SB16 is not set
> # CONFIG_SND_SBAWE is not set
> CONFIG_SND_SSCAPE=y
> CONFIG_SND_WAVEFRONT=y
> CONFIG_SND_MSND_PINNACLE=m
> # CONFIG_SND_MSND_CLASSIC is not set
> # CONFIG_SND_PCI is not set
> 
> #
> # HD-Audio
> #
> # end of HD-Audio
> 
> CONFIG_SND_HDA_PREALLOC_SIZE=0
> CONFIG_SND_INTEL_NHLT=y
> CONFIG_SND_INTEL_DSP_CONFIG=y
> CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
> CONFIG_SND_SPI=y
> CONFIG_SND_SOC=y
> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> CONFIG_SND_SOC_COMPRESS=y
> CONFIG_SND_SOC_TOPOLOGY=y
> CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST=y
> CONFIG_SND_SOC_ACPI=y
> CONFIG_SND_SOC_ADI=y
> # CONFIG_SND_SOC_ADI_AXI_I2S is not set
> CONFIG_SND_SOC_ADI_AXI_SPDIF=y
> # CONFIG_SND_SOC_AMD_ACP is not set
> CONFIG_SND_SOC_AMD_ACP3x=y
> # CONFIG_SND_SOC_AMD_RV_RT5682_MACH is not set
> CONFIG_SND_SOC_AMD_RENOIR=y
> CONFIG_SND_SOC_AMD_RENOIR_MACH=y
> # CONFIG_SND_SOC_AMD_ACP5x is not set
> CONFIG_SND_ATMEL_SOC=y
> # CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
> # CONFIG_SND_DESIGNWARE_I2S is not set
> 
> #
> # SoC Audio for Freescale CPUs
> #
> 
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> CONFIG_SND_SOC_FSL_ASRC=y
> # CONFIG_SND_SOC_FSL_SAI is not set
> CONFIG_SND_SOC_FSL_AUDMIX=y
> # CONFIG_SND_SOC_FSL_SSI is not set
> CONFIG_SND_SOC_FSL_SPDIF=m
> # CONFIG_SND_SOC_FSL_ESAI is not set
> CONFIG_SND_SOC_FSL_MICFIL=y
> # CONFIG_SND_SOC_FSL_EASRC is not set
> CONFIG_SND_SOC_FSL_XCVR=m
> # CONFIG_SND_SOC_FSL_RPMSG is not set
> # CONFIG_SND_SOC_IMX_AUDMUX is not set
> # end of SoC Audio for Freescale CPUs
> 
> CONFIG_SND_I2S_HI6210_I2S=y
> CONFIG_SND_SOC_IMG=y
> # CONFIG_SND_SOC_IMG_I2S_IN is not set
> # CONFIG_SND_SOC_IMG_I2S_OUT is not set
> CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
> CONFIG_SND_SOC_IMG_SPDIF_IN=y
> # CONFIG_SND_SOC_IMG_SPDIF_OUT is not set
> CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
> # CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
> CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
> CONFIG_SND_SOC_INTEL_MACH=y
> CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
> # CONFIG_SND_SOC_INTEL_SOF_WM8804_MACH is not set
> # CONFIG_SND_SOC_MTK_BTCVSD is not set
> CONFIG_SND_SOC_SOF_TOPLEVEL=y
> CONFIG_SND_SOC_SOF_PCI_DEV=m
> CONFIG_SND_SOC_SOF_PCI=m
> CONFIG_SND_SOC_SOF_ACPI=y
> CONFIG_SND_SOC_SOF_ACPI_DEV=y
> CONFIG_SND_SOC_SOF_DEBUG_PROBES=y
> # CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set
> CONFIG_SND_SOC_SOF=y
> CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
> CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=y
> CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=y
> CONFIG_SND_SOC_SOF_INTEL_COMMON=y
> CONFIG_SND_SOC_SOF_BAYTRAIL=y
> # CONFIG_SND_SOC_SOF_BROADWELL is not set
> CONFIG_SND_SOC_SOF_MERRIFIELD=m
> CONFIG_SND_SOC_SOF_INTEL_APL=m
> CONFIG_SND_SOC_SOF_APOLLOLAKE=m
> CONFIG_SND_SOC_SOF_GEMINILAKE=m
> CONFIG_SND_SOC_SOF_INTEL_CNL=m
> # CONFIG_SND_SOC_SOF_CANNONLAKE is not set
> CONFIG_SND_SOC_SOF_COFFEELAKE=m
> CONFIG_SND_SOC_SOF_COMETLAKE=m
> CONFIG_SND_SOC_SOF_INTEL_ICL=m
> CONFIG_SND_SOC_SOF_ICELAKE=m
> CONFIG_SND_SOC_SOF_JASPERLAKE=m
> CONFIG_SND_SOC_SOF_INTEL_TGL=m
> CONFIG_SND_SOC_SOF_TIGERLAKE=m
> CONFIG_SND_SOC_SOF_ELKHARTLAKE=m
> CONFIG_SND_SOC_SOF_ALDERLAKE=m
> CONFIG_SND_SOC_SOF_HDA_COMMON=m
> # CONFIG_SND_SOC_SOF_HDA_LINK is not set
> CONFIG_SND_SOC_SOF_HDA_PROBES=y
> CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
> CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=m
> # CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE is not set
> CONFIG_SND_SOC_SOF_XTENSA=y
> 
> #
> # STMicroelectronics STM32 SOC audio support
> #
> # end of STMicroelectronics STM32 SOC audio support
> 
> # CONFIG_SND_SOC_XILINX_I2S is not set
> CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
> CONFIG_SND_SOC_XILINX_SPDIF=y
> CONFIG_SND_SOC_XTFPGA_I2S=y
> CONFIG_SND_SOC_I2C_AND_SPI=y
> 
> #
> # CODEC drivers
> #
> # CONFIG_SND_SOC_AC97_CODEC is not set
> CONFIG_SND_SOC_ADAU_UTILS=y
> CONFIG_SND_SOC_ADAU1372=y
> CONFIG_SND_SOC_ADAU1372_I2C=y
> CONFIG_SND_SOC_ADAU1372_SPI=m
> CONFIG_SND_SOC_ADAU1701=y
> CONFIG_SND_SOC_ADAU17X1=m
> CONFIG_SND_SOC_ADAU1761=m
> CONFIG_SND_SOC_ADAU1761_I2C=m
> # CONFIG_SND_SOC_ADAU1761_SPI is not set
> CONFIG_SND_SOC_ADAU7002=m
> CONFIG_SND_SOC_ADAU7118=m
> CONFIG_SND_SOC_ADAU7118_HW=m
> CONFIG_SND_SOC_ADAU7118_I2C=m
> CONFIG_SND_SOC_AK4104=m
> # CONFIG_SND_SOC_AK4118 is not set
> CONFIG_SND_SOC_AK4458=y
> # CONFIG_SND_SOC_AK4554 is not set
> CONFIG_SND_SOC_AK4613=y
> # CONFIG_SND_SOC_AK4642 is not set
> CONFIG_SND_SOC_AK5386=m
> CONFIG_SND_SOC_AK5558=m
> # CONFIG_SND_SOC_ALC5623 is not set
> # CONFIG_SND_SOC_BD28623 is not set
> CONFIG_SND_SOC_BT_SCO=y
> CONFIG_SND_SOC_CROS_EC_CODEC=y
> CONFIG_SND_SOC_CS35L32=m
> CONFIG_SND_SOC_CS35L33=y
> CONFIG_SND_SOC_CS35L34=m
> CONFIG_SND_SOC_CS35L35=y
> CONFIG_SND_SOC_CS35L36=y
> CONFIG_SND_SOC_CS42L42=m
> CONFIG_SND_SOC_CS42L51=m
> CONFIG_SND_SOC_CS42L51_I2C=m
> # CONFIG_SND_SOC_CS42L52 is not set
> # CONFIG_SND_SOC_CS42L56 is not set
> CONFIG_SND_SOC_CS42L73=y
> CONFIG_SND_SOC_CS4234=m
> CONFIG_SND_SOC_CS4265=m
> # CONFIG_SND_SOC_CS4270 is not set
> # CONFIG_SND_SOC_CS4271_I2C is not set
> # CONFIG_SND_SOC_CS4271_SPI is not set
> CONFIG_SND_SOC_CS42XX8=y
> CONFIG_SND_SOC_CS42XX8_I2C=y
> CONFIG_SND_SOC_CS43130=m
> # CONFIG_SND_SOC_CS4341 is not set
> # CONFIG_SND_SOC_CS4349 is not set
> # CONFIG_SND_SOC_CS53L30 is not set
> CONFIG_SND_SOC_CX2072X=y
> CONFIG_SND_SOC_DA7213=y
> CONFIG_SND_SOC_DMIC=y
> CONFIG_SND_SOC_ES7134=m
> CONFIG_SND_SOC_ES7241=y
> CONFIG_SND_SOC_ES8316=y
> CONFIG_SND_SOC_ES8328=m
> # CONFIG_SND_SOC_ES8328_I2C is not set
> CONFIG_SND_SOC_ES8328_SPI=m
> CONFIG_SND_SOC_GTM601=y
> CONFIG_SND_SOC_ICS43432=y
> CONFIG_SND_SOC_INNO_RK3036=m
> CONFIG_SND_SOC_MAX98088=y
> CONFIG_SND_SOC_MAX98357A=y
> CONFIG_SND_SOC_MAX98504=m
> CONFIG_SND_SOC_MAX9867=y
> CONFIG_SND_SOC_MAX98927=m
> CONFIG_SND_SOC_MAX98373=m
> CONFIG_SND_SOC_MAX98373_I2C=m
> CONFIG_SND_SOC_MAX98373_SDW=m
> # CONFIG_SND_SOC_MAX98390 is not set
> CONFIG_SND_SOC_MAX9860=m
> CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
> CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
> CONFIG_SND_SOC_PCM1681=y
> # CONFIG_SND_SOC_PCM1789_I2C is not set
> CONFIG_SND_SOC_PCM179X=y
> CONFIG_SND_SOC_PCM179X_I2C=y
> # CONFIG_SND_SOC_PCM179X_SPI is not set
> CONFIG_SND_SOC_PCM186X=m
> CONFIG_SND_SOC_PCM186X_I2C=m
> # CONFIG_SND_SOC_PCM186X_SPI is not set
> CONFIG_SND_SOC_PCM3060=m
> # CONFIG_SND_SOC_PCM3060_I2C is not set
> CONFIG_SND_SOC_PCM3060_SPI=m
> CONFIG_SND_SOC_PCM3168A=m
> CONFIG_SND_SOC_PCM3168A_I2C=m
> # CONFIG_SND_SOC_PCM3168A_SPI is not set
> # CONFIG_SND_SOC_PCM5102A is not set
> CONFIG_SND_SOC_PCM512x=y
> CONFIG_SND_SOC_PCM512x_I2C=y
> CONFIG_SND_SOC_PCM512x_SPI=y
> CONFIG_SND_SOC_RK3328=m
> CONFIG_SND_SOC_RL6231=y
> CONFIG_SND_SOC_RT1308_SDW=m
> CONFIG_SND_SOC_RT1316_SDW=m
> CONFIG_SND_SOC_RT5616=y
> CONFIG_SND_SOC_RT5631=y
> # CONFIG_SND_SOC_RT5640 is not set
> CONFIG_SND_SOC_RT5659=y
> CONFIG_SND_SOC_RT5682=m
> CONFIG_SND_SOC_RT5682_SDW=m
> # CONFIG_SND_SOC_RT700_SDW is not set
> # CONFIG_SND_SOC_RT711_SDW is not set
> CONFIG_SND_SOC_RT711_SDCA_SDW=m
> CONFIG_SND_SOC_RT715=m
> CONFIG_SND_SOC_RT715_SDW=m
> CONFIG_SND_SOC_RT715_SDCA_SDW=m
> # CONFIG_SND_SOC_SDW_MOCKUP is not set
> CONFIG_SND_SOC_SGTL5000=m
> CONFIG_SND_SOC_SIGMADSP=y
> CONFIG_SND_SOC_SIGMADSP_I2C=y
> CONFIG_SND_SOC_SIGMADSP_REGMAP=m
> CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
> CONFIG_SND_SOC_SIMPLE_MUX=m
> CONFIG_SND_SOC_SPDIF=m
> CONFIG_SND_SOC_SSM2305=m
> CONFIG_SND_SOC_SSM2518=y
> CONFIG_SND_SOC_SSM2602=y
> CONFIG_SND_SOC_SSM2602_SPI=y
> # CONFIG_SND_SOC_SSM2602_I2C is not set
> # CONFIG_SND_SOC_SSM4567 is not set
> # CONFIG_SND_SOC_STA32X is not set
> CONFIG_SND_SOC_STA350=y
> CONFIG_SND_SOC_STI_SAS=y
> # CONFIG_SND_SOC_TAS2552 is not set
> CONFIG_SND_SOC_TAS2562=m
> CONFIG_SND_SOC_TAS2764=m
> CONFIG_SND_SOC_TAS2770=m
> # CONFIG_SND_SOC_TAS5086 is not set
> CONFIG_SND_SOC_TAS571X=y
> CONFIG_SND_SOC_TAS5720=m
> CONFIG_SND_SOC_TAS6424=m
> CONFIG_SND_SOC_TDA7419=y
> CONFIG_SND_SOC_TFA9879=m
> # CONFIG_SND_SOC_TFA989X is not set
> CONFIG_SND_SOC_TLV320AIC23=m
> CONFIG_SND_SOC_TLV320AIC23_I2C=m
> # CONFIG_SND_SOC_TLV320AIC23_SPI is not set
> CONFIG_SND_SOC_TLV320AIC31XX=y
> CONFIG_SND_SOC_TLV320AIC32X4=m
> CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
> CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
> CONFIG_SND_SOC_TLV320AIC3X=y
> CONFIG_SND_SOC_TLV320AIC3X_I2C=m
> CONFIG_SND_SOC_TLV320AIC3X_SPI=y
> # CONFIG_SND_SOC_TLV320ADCX140 is not set
> CONFIG_SND_SOC_TS3A227E=m
> CONFIG_SND_SOC_TSCS42XX=m
> # CONFIG_SND_SOC_TSCS454 is not set
> # CONFIG_SND_SOC_UDA1334 is not set
> # CONFIG_SND_SOC_WCD9335 is not set
> CONFIG_SND_SOC_WCD_MBHC=m
> CONFIG_SND_SOC_WCD934X=m
> CONFIG_SND_SOC_WCD938X=m
> CONFIG_SND_SOC_WCD938X_SDW=m
> # CONFIG_SND_SOC_WM8510 is not set
> CONFIG_SND_SOC_WM8523=y
> CONFIG_SND_SOC_WM8524=y
> # CONFIG_SND_SOC_WM8580 is not set
> CONFIG_SND_SOC_WM8711=m
> # CONFIG_SND_SOC_WM8728 is not set
> CONFIG_SND_SOC_WM8731=y
> # CONFIG_SND_SOC_WM8737 is not set
> # CONFIG_SND_SOC_WM8741 is not set
> CONFIG_SND_SOC_WM8750=y
> CONFIG_SND_SOC_WM8753=y
> CONFIG_SND_SOC_WM8770=m
> CONFIG_SND_SOC_WM8776=m
> # CONFIG_SND_SOC_WM8782 is not set
> # CONFIG_SND_SOC_WM8804_I2C is not set
> # CONFIG_SND_SOC_WM8804_SPI is not set
> CONFIG_SND_SOC_WM8903=m
> CONFIG_SND_SOC_WM8904=y
> # CONFIG_SND_SOC_WM8960 is not set
> # CONFIG_SND_SOC_WM8962 is not set
> CONFIG_SND_SOC_WM8974=y
> # CONFIG_SND_SOC_WM8978 is not set
> # CONFIG_SND_SOC_WM8985 is not set
> CONFIG_SND_SOC_WSA881X=m
> CONFIG_SND_SOC_ZL38060=m
> CONFIG_SND_SOC_MAX9759=m
> # CONFIG_SND_SOC_MT6351 is not set
> CONFIG_SND_SOC_MT6358=y
> CONFIG_SND_SOC_MT6660=m
> CONFIG_SND_SOC_NAU8315=y
> CONFIG_SND_SOC_NAU8540=m
> CONFIG_SND_SOC_NAU8810=m
> CONFIG_SND_SOC_NAU8822=y
> CONFIG_SND_SOC_NAU8824=y
> # CONFIG_SND_SOC_TPA6130A2 is not set
> # CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
> CONFIG_SND_SOC_LPASS_VA_MACRO=y
> CONFIG_SND_SOC_LPASS_RX_MACRO=m
> CONFIG_SND_SOC_LPASS_TX_MACRO=m
> # end of CODEC drivers
> 
> CONFIG_SND_SIMPLE_CARD_UTILS=y
> CONFIG_SND_SIMPLE_CARD=y
> # CONFIG_SND_X86 is not set
> # CONFIG_SND_VIRTIO is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> # CONFIG_HIDRAW is not set
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> # CONFIG_HID_ACRUX is not set
> # CONFIG_HID_APPLE is not set
> # CONFIG_HID_AUREAL is not set
> # CONFIG_HID_BELKIN is not set
> # CONFIG_HID_CHERRY is not set
> # CONFIG_HID_CHICONY is not set
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> # CONFIG_HID_PRODIKEYS is not set
> # CONFIG_HID_CMEDIA is not set
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_HID_DRAGONRISE is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELECOM is not set
> # CONFIG_HID_EZKEY is not set
> # CONFIG_HID_GEMBIRD is not set
> # CONFIG_HID_GFRM is not set
> # CONFIG_HID_GLORIOUS is not set
> # CONFIG_HID_VIVALDI is not set
> # CONFIG_HID_KEYTOUCH is not set
> # CONFIG_HID_KYE is not set
> # CONFIG_HID_WALTOP is not set
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_GYRATION is not set
> # CONFIG_HID_ICADE is not set
> # CONFIG_HID_ITE is not set
> # CONFIG_HID_JABRA is not set
> # CONFIG_HID_TWINHAN is not set
> # CONFIG_HID_KENSINGTON is not set
> # CONFIG_HID_LCPOWER is not set
> # CONFIG_HID_LED is not set
> # CONFIG_HID_LENOVO is not set
> # CONFIG_HID_LOGITECH is not set
> # CONFIG_HID_MAGICMOUSE is not set
> # CONFIG_HID_MALTRON is not set
> # CONFIG_HID_MAYFLASH is not set
> # CONFIG_HID_REDRAGON is not set
> # CONFIG_HID_MICROSOFT is not set
> # CONFIG_HID_MONTEREY is not set
> # CONFIG_HID_MULTITOUCH is not set
> # CONFIG_HID_NTI is not set
> # CONFIG_HID_ORTEK is not set
> # CONFIG_HID_PANTHERLORD is not set
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_PICOLCD is not set
> # CONFIG_HID_PLANTRONICS is not set
> # CONFIG_HID_PLAYSTATION is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_SAITEK is not set
> # CONFIG_HID_SAMSUNG is not set
> # CONFIG_HID_SEMITEK is not set
> # CONFIG_HID_SPEEDLINK is not set
> # CONFIG_HID_STEAM is not set
> # CONFIG_HID_STEELSERIES is not set
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_HID_RMI is not set
> # CONFIG_HID_GREENASIA is not set
> # CONFIG_HID_SMARTJOYPLUS is not set
> # CONFIG_HID_TIVO is not set
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_HID_THINGM is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_WIIMOTE is not set
> # CONFIG_HID_XINMO is not set
> # CONFIG_HID_ZEROPLUS is not set
> # CONFIG_HID_ZYDACRON is not set
> # CONFIG_HID_SENSOR_HUB is not set
> # CONFIG_HID_ALPS is not set
> # end of Special HID drivers
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID_ACPI is not set
> # end of I2C HID support
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> # CONFIG_USB_LED_TRIG is not set
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> # CONFIG_USB is not set
> CONFIG_USB_PCI=y
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_TAHVO_USB is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> # CONFIG_USB_ROLE_SWITCH is not set
> CONFIG_MMC=m
> CONFIG_MMC_BLOCK=m
> CONFIG_MMC_BLOCK_MINORS=8
> # CONFIG_SDIO_UART is not set
> # CONFIG_MMC_TEST is not set
> # CONFIG_MMC_CRYPTO is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=m
> CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> CONFIG_MMC_SDHCI_PCI=m
> CONFIG_MMC_RICOH_MMC=y
> CONFIG_MMC_SDHCI_ACPI=m
> CONFIG_MMC_SDHCI_PLTFM=m
> CONFIG_MMC_SDHCI_F_SDH30=m
> CONFIG_MMC_WBSD=m
> CONFIG_MMC_ALCOR=m
> CONFIG_MMC_TIFM_SD=m
> CONFIG_MMC_SPI=m
> CONFIG_MMC_CB710=m
> CONFIG_MMC_VIA_SDMMC=m
> CONFIG_MMC_USDHI6ROL0=m
> CONFIG_MMC_REALTEK_PCI=m
> CONFIG_MMC_CQHCI=m
> CONFIG_MMC_HSQ=m
> CONFIG_MMC_TOSHIBA_PCI=m
> CONFIG_MMC_MTK=m
> # CONFIG_MMC_SDHCI_XENON is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> CONFIG_LEDS_CLASS_MULTICOLOR=m
> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> 
> #
> # LED drivers
> #
> CONFIG_LEDS_88PM860X=y
> CONFIG_LEDS_APU=y
> CONFIG_LEDS_LM3530=m
> # CONFIG_LEDS_LM3532 is not set
> CONFIG_LEDS_LM3533=m
> CONFIG_LEDS_LM3642=y
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=y
> # CONFIG_LEDS_LP3952 is not set
> CONFIG_LEDS_LP50XX=m
> # CONFIG_LEDS_CLEVO_MAIL is not set
> CONFIG_LEDS_PCA955X=m
> # CONFIG_LEDS_PCA955X_GPIO is not set
> CONFIG_LEDS_PCA963X=y
> # CONFIG_LEDS_DA903X is not set
> # CONFIG_LEDS_DAC124S085 is not set
> CONFIG_LEDS_REGULATOR=m
> # CONFIG_LEDS_BD2802 is not set
> # CONFIG_LEDS_INTEL_SS4200 is not set
> # CONFIG_LEDS_LT3593 is not set
> CONFIG_LEDS_MC13783=y
> CONFIG_LEDS_TCA6507=y
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
> CONFIG_LEDS_OT200=m
> CONFIG_LEDS_MENF21BMC=m
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> CONFIG_LEDS_MLXCPLD=y
> CONFIG_LEDS_MLXREG=m
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> # CONFIG_LEDS_TPS6105X is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> # CONFIG_LEDS_TRIGGER_TIMER is not set
> CONFIG_LEDS_TRIGGER_ONESHOT=y
> # CONFIG_LEDS_TRIGGER_DISK is not set
> # CONFIG_LEDS_TRIGGER_MTD is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> CONFIG_LEDS_TRIGGER_BACKLIGHT=m
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> CONFIG_LEDS_TRIGGER_CAMERA=y
> CONFIG_LEDS_TRIGGER_PANIC=y
> CONFIG_LEDS_TRIGGER_NETDEV=y
> CONFIG_LEDS_TRIGGER_PATTERN=y
> CONFIG_LEDS_TRIGGER_AUDIO=y
> # CONFIG_LEDS_TRIGGER_TTY is not set
> CONFIG_ACCESSIBILITY=y
> 
> #
> # Speakup console speech
> #
> # end of Speakup console speech
> 
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> # CONFIG_RTC_SYSTOHC is not set
> CONFIG_RTC_DEBUG=y
> # CONFIG_RTC_LIB_KUNIT_TEST is not set
> # CONFIG_RTC_NVMEM is not set
> 
> #
> # RTC interfaces
> #
> # CONFIG_RTC_INTF_SYSFS is not set
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> CONFIG_RTC_INTF_DEV_UIE_EMUL=y
> CONFIG_RTC_DRV_TEST=m
> 
> #
> # I2C RTC drivers
> #
> CONFIG_RTC_DRV_88PM860X=m
> # CONFIG_RTC_DRV_88PM80X is not set
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> CONFIG_RTC_DRV_ABX80X=m
> CONFIG_RTC_DRV_DS1307=y
> CONFIG_RTC_DRV_DS1307_CENTURY=y
> CONFIG_RTC_DRV_DS1374=y
> CONFIG_RTC_DRV_DS1374_WDT=y
> # CONFIG_RTC_DRV_DS1672 is not set
> CONFIG_RTC_DRV_MAX6900=m
> CONFIG_RTC_DRV_MAX8907=m
> CONFIG_RTC_DRV_RS5C372=y
> CONFIG_RTC_DRV_ISL1208=m
> # CONFIG_RTC_DRV_ISL12022 is not set
> CONFIG_RTC_DRV_X1205=y
> # CONFIG_RTC_DRV_PCF8523 is not set
> # CONFIG_RTC_DRV_PCF85063 is not set
> CONFIG_RTC_DRV_PCF85363=y
> CONFIG_RTC_DRV_PCF8563=m
> CONFIG_RTC_DRV_PCF8583=y
> CONFIG_RTC_DRV_M41T80=m
> CONFIG_RTC_DRV_M41T80_WDT=y
> CONFIG_RTC_DRV_BQ32K=m
> CONFIG_RTC_DRV_PALMAS=m
> CONFIG_RTC_DRV_TPS6586X=y
> CONFIG_RTC_DRV_TPS80031=m
> CONFIG_RTC_DRV_RC5T583=y
> CONFIG_RTC_DRV_S35390A=m
> CONFIG_RTC_DRV_FM3130=y
> CONFIG_RTC_DRV_RX8010=y
> # CONFIG_RTC_DRV_RX8581 is not set
> CONFIG_RTC_DRV_RX8025=m
> # CONFIG_RTC_DRV_EM3027 is not set
> # CONFIG_RTC_DRV_RV3028 is not set
> CONFIG_RTC_DRV_RV3032=m
> # CONFIG_RTC_DRV_RV8803 is not set
> # CONFIG_RTC_DRV_SD3078 is not set
> 
> #
> # SPI RTC drivers
> #
> CONFIG_RTC_DRV_M41T93=m
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> CONFIG_RTC_DRV_DS1343=m
> CONFIG_RTC_DRV_DS1347=y
> CONFIG_RTC_DRV_DS1390=m
> # CONFIG_RTC_DRV_MAX6916 is not set
> CONFIG_RTC_DRV_R9701=m
> CONFIG_RTC_DRV_RX4581=y
> # CONFIG_RTC_DRV_RS5C348 is not set
> CONFIG_RTC_DRV_MAX6902=m
> CONFIG_RTC_DRV_PCF2123=m
> CONFIG_RTC_DRV_MCP795=m
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=m
> # CONFIG_RTC_DRV_DS3232_HWMON is not set
> CONFIG_RTC_DRV_PCF2127=y
> # CONFIG_RTC_DRV_RV3029C2 is not set
> CONFIG_RTC_DRV_RX6110=y
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=y
> CONFIG_RTC_DRV_DS1286=y
> CONFIG_RTC_DRV_DS1511=m
> CONFIG_RTC_DRV_DS1553=y
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=m
> CONFIG_RTC_DRV_DS2404=y
> CONFIG_RTC_DRV_DA9055=m
> CONFIG_RTC_DRV_DA9063=m
> CONFIG_RTC_DRV_STK17TA8=m
> CONFIG_RTC_DRV_M48T86=y
> # CONFIG_RTC_DRV_M48T35 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_MSM6242 is not set
> CONFIG_RTC_DRV_BQ4802=m
> CONFIG_RTC_DRV_RP5C01=y
> # CONFIG_RTC_DRV_V3020 is not set
> CONFIG_RTC_DRV_PCF50633=m
> CONFIG_RTC_DRV_CROS_EC=y
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
> CONFIG_RTC_DRV_MC13XXX=y
> 
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_GOLDFISH is not set
> # CONFIG_RTC_DRV_WILCO_EC is not set
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> # CONFIG_SYNC_FILE is not set
> CONFIG_UDMABUF=y
> CONFIG_DMABUF_MOVE_NOTIFY=y
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> CONFIG_DMABUF_HEAPS=y
> # CONFIG_DMABUF_SYSFS_STATS is not set
> # CONFIG_DMABUF_HEAPS_SYSTEM is not set
> # end of DMABUF options
> 
> CONFIG_AUXDISPLAY=y
> CONFIG_CHARLCD=m
> CONFIG_HD44780_COMMON=m
> # CONFIG_HD44780 is not set
> # CONFIG_IMG_ASCII_LCD is not set
> CONFIG_LCD2S=m
> CONFIG_PARPORT_PANEL=m
> CONFIG_PANEL_PARPORT=0
> CONFIG_PANEL_PROFILE=5
> CONFIG_PANEL_CHANGE_MESSAGE=y
> CONFIG_PANEL_BOOT_MESSAGE=""
> CONFIG_CHARLCD_BL_OFF=y
> # CONFIG_CHARLCD_BL_ON is not set
> # CONFIG_CHARLCD_BL_FLASH is not set
> CONFIG_PANEL=m
> CONFIG_UIO=m
> CONFIG_UIO_CIF=m
> CONFIG_UIO_PDRV_GENIRQ=m
> # CONFIG_UIO_DMEM_GENIRQ is not set
> CONFIG_UIO_AEC=m
> CONFIG_UIO_SERCOS3=m
> # CONFIG_UIO_PCI_GENERIC is not set
> CONFIG_UIO_NETX=m
> CONFIG_UIO_PRUSS=m
> # CONFIG_UIO_MF624 is not set
> # CONFIG_VFIO is not set
> CONFIG_IRQ_BYPASS_MANAGER=y
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=m
> # CONFIG_VIRTIO_MENU is not set
> # CONFIG_VDPA is not set
> # CONFIG_VHOST_MENU is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_HYPERV is not set
> # end of Microsoft Hyper-V guest support
> 
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> CONFIG_ACPI_WMI=m
> # CONFIG_WMI_BMOF is not set
> # CONFIG_MXM_WMI is not set
> # CONFIG_PEAQ_WMI is not set
> # CONFIG_XIAOMI_WMI is not set
> CONFIG_GIGABYTE_WMI=m
> CONFIG_ACERHDF=m
> # CONFIG_ACER_WIRELESS is not set
> # CONFIG_ACER_WMI is not set
> CONFIG_AMD_PMC=m
> # CONFIG_ADV_SWBUTTON is not set
> CONFIG_APPLE_GMUX=y
> # CONFIG_ASUS_LAPTOP is not set
> # CONFIG_ASUS_WIRELESS is not set
> # CONFIG_MERAKI_MX100 is not set
> CONFIG_X86_PLATFORM_DRIVERS_DELL=y
> # CONFIG_ALIENWARE_WMI is not set
> CONFIG_DCDBAS=m
> # CONFIG_DELL_LAPTOP is not set
> # CONFIG_DELL_RBU is not set
> CONFIG_DELL_RBTN=m
> CONFIG_DELL_SMBIOS=m
> CONFIG_DELL_SMBIOS_WMI=y
> # CONFIG_DELL_SMBIOS_SMM is not set
> # CONFIG_DELL_SMO8800 is not set
> CONFIG_DELL_WMI=m
> # CONFIG_DELL_WMI_PRIVACY is not set
> CONFIG_DELL_WMI_AIO=m
> CONFIG_DELL_WMI_DESCRIPTOR=m
> CONFIG_DELL_WMI_LED=m
> CONFIG_DELL_WMI_SYSMAN=m
> CONFIG_AMILO_RFKILL=m
> # CONFIG_FUJITSU_LAPTOP is not set
> # CONFIG_FUJITSU_TABLET is not set
> CONFIG_GPD_POCKET_FAN=m
> # CONFIG_HP_ACCEL is not set
> # CONFIG_WIRELESS_HOTKEY is not set
> # CONFIG_HP_WMI is not set
> # CONFIG_TC1100_WMI is not set
> # CONFIG_IBM_RTL is not set
> # CONFIG_IDEAPAD_LAPTOP is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_THINKPAD_LMI is not set
> # CONFIG_X86_PLATFORM_DRIVERS_INTEL is not set
> # CONFIG_MSI_LAPTOP is not set
> # CONFIG_MSI_WMI is not set
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_SAMSUNG_LAPTOP is not set
> CONFIG_SAMSUNG_Q10=y
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_TOSHIBA_BT_RFKILL is not set
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> # CONFIG_ACPI_CMPC is not set
> CONFIG_COMPAL_LAPTOP=m
> # CONFIG_LG_LAPTOP is not set
> # CONFIG_PANASONIC_LAPTOP is not set
> # CONFIG_SONY_LAPTOP is not set
> CONFIG_SYSTEM76_ACPI=m
> # CONFIG_TOPSTAR_LAPTOP is not set
> CONFIG_I2C_MULTI_INSTANTIATE=m
> CONFIG_MLX_PLATFORM=m
> CONFIG_FW_ATTR_CLASS=m
> CONFIG_INTEL_IPS=y
> CONFIG_INTEL_SCU_IPC=y
> CONFIG_INTEL_SCU=y
> CONFIG_INTEL_SCU_PCI=y
> # CONFIG_INTEL_SCU_PLATFORM is not set
> CONFIG_INTEL_SCU_IPC_UTIL=y
> CONFIG_PMC_ATOM=y
> # CONFIG_GOLDFISH_PIPE is not set
> CONFIG_CHROME_PLATFORMS=y
> CONFIG_CHROMEOS_LAPTOP=y
> CONFIG_CHROMEOS_PSTORE=m
> # CONFIG_CHROMEOS_TBMC is not set
> CONFIG_CROS_EC=y
> CONFIG_CROS_EC_I2C=m
> CONFIG_CROS_EC_SPI=m
> CONFIG_CROS_EC_LPC=y
> CONFIG_CROS_EC_PROTO=y
> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> # CONFIG_CROS_EC_CHARDEV is not set
> CONFIG_CROS_EC_LIGHTBAR=m
> # CONFIG_CROS_EC_DEBUGFS is not set
> CONFIG_CROS_EC_SENSORHUB=m
> CONFIG_CROS_EC_SYSFS=m
> CONFIG_CROS_USBPD_NOTIFY=m
> CONFIG_WILCO_EC=m
> CONFIG_WILCO_EC_DEBUGFS=m
> CONFIG_WILCO_EC_EVENTS=m
> CONFIG_WILCO_EC_TELEMETRY=m
> # CONFIG_MELLANOX_PLATFORM is not set
> # CONFIG_SURFACE_PLATFORMS is not set
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> 
> #
> # Clock driver for ARM Reference designs
> #
> # CONFIG_ICST is not set
> CONFIG_CLK_SP810=y
> # end of Clock driver for ARM Reference designs
> 
> CONFIG_LMK04832=m
> CONFIG_COMMON_CLK_MAX9485=y
> # CONFIG_COMMON_CLK_SI5341 is not set
> CONFIG_COMMON_CLK_SI5351=y
> CONFIG_COMMON_CLK_SI544=y
> CONFIG_COMMON_CLK_CDCE706=y
> CONFIG_COMMON_CLK_CS2000_CP=m
> CONFIG_CLK_TWL6040=y
> # CONFIG_COMMON_CLK_PALMAS is not set
> CONFIG_XILINX_VCU=m
> CONFIG_HWSPINLOCK=y
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKSRC_I8253=y
> CONFIG_CLKEVT_I8253=y
> CONFIG_CLKBLD_I8253=y
> CONFIG_DW_APB_TIMER=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> # CONFIG_ALTERA_MBOX is not set
> # CONFIG_IOMMU_SUPPORT is not set
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> # CONFIG_RPMSG_CHAR is not set
> CONFIG_RPMSG_NS=m
> CONFIG_RPMSG_QCOM_GLINK=y
> CONFIG_RPMSG_QCOM_GLINK_RPM=y
> CONFIG_RPMSG_VIRTIO=m
> # end of Rpmsg drivers
> 
> CONFIG_SOUNDWIRE=m
> 
> #
> # SoundWire Devices
> #
> CONFIG_SOUNDWIRE_CADENCE=m
> CONFIG_SOUNDWIRE_INTEL=m
> CONFIG_SOUNDWIRE_QCOM=m
> CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=m
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> # CONFIG_PM_DEVFREQ is not set
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_ADC_JACK is not set
> # CONFIG_EXTCON_AXP288 is not set
> # CONFIG_EXTCON_FSA9480 is not set
> # CONFIG_EXTCON_GPIO is not set
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> CONFIG_EXTCON_INTEL_MRFLD=m
> # CONFIG_EXTCON_MAX14577 is not set
> # CONFIG_EXTCON_MAX3355 is not set
> CONFIG_EXTCON_PALMAS=y
> CONFIG_EXTCON_PTN5150=m
> CONFIG_EXTCON_RT8973A=m
> CONFIG_EXTCON_SM5502=y
> CONFIG_EXTCON_USB_GPIO=m
> CONFIG_EXTCON_USBC_CROS_EC=m
> CONFIG_EXTCON_USBC_TUSB320=y
> # CONFIG_MEMORY is not set
> CONFIG_IIO=y
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=y
> CONFIG_IIO_BUFFER_DMA=m
> # CONFIG_IIO_BUFFER_DMAENGINE is not set
> CONFIG_IIO_BUFFER_HW_CONSUMER=y
> CONFIG_IIO_KFIFO_BUF=y
> CONFIG_IIO_TRIGGERED_BUFFER=y
> CONFIG_IIO_CONFIGFS=y
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> # CONFIG_IIO_SW_DEVICE is not set
> # CONFIG_IIO_SW_TRIGGER is not set
> CONFIG_IIO_TRIGGERED_EVENT=m
> 
> #
> # Accelerometers
> #
> CONFIG_ADIS16201=y
> # CONFIG_ADIS16209 is not set
> CONFIG_ADXL345=y
> CONFIG_ADXL345_I2C=y
> CONFIG_ADXL345_SPI=y
> CONFIG_ADXL372=m
> CONFIG_ADXL372_SPI=m
> # CONFIG_ADXL372_I2C is not set
> # CONFIG_BMA180 is not set
> CONFIG_BMA220=m
> CONFIG_BMA400=y
> CONFIG_BMA400_I2C=y
> CONFIG_BMA400_SPI=y
> # CONFIG_BMC150_ACCEL is not set
> CONFIG_BMI088_ACCEL=m
> CONFIG_BMI088_ACCEL_SPI=m
> CONFIG_DA280=y
> CONFIG_DA311=m
> CONFIG_DMARD09=m
> # CONFIG_DMARD10 is not set
> CONFIG_FXLS8962AF=y
> CONFIG_FXLS8962AF_I2C=y
> # CONFIG_FXLS8962AF_SPI is not set
> CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
> CONFIG_IIO_ST_ACCEL_3AXIS=m
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
> CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
> CONFIG_KXSD9=m
> CONFIG_KXSD9_SPI=m
> CONFIG_KXSD9_I2C=m
> CONFIG_KXCJK1013=y
> # CONFIG_MC3230 is not set
> CONFIG_MMA7455=y
> CONFIG_MMA7455_I2C=m
> CONFIG_MMA7455_SPI=y
> CONFIG_MMA7660=m
> CONFIG_MMA8452=y
> CONFIG_MMA9551_CORE=y
> CONFIG_MMA9551=y
> CONFIG_MMA9553=y
> # CONFIG_MXC4005 is not set
> CONFIG_MXC6255=y
> CONFIG_SCA3000=m
> CONFIG_SCA3300=y
> # CONFIG_STK8312 is not set
> # CONFIG_STK8BA50 is not set
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD_SIGMA_DELTA=y
> CONFIG_AD7091R5=m
> CONFIG_AD7124=y
> # CONFIG_AD7192 is not set
> # CONFIG_AD7266 is not set
> # CONFIG_AD7291 is not set
> # CONFIG_AD7292 is not set
> # CONFIG_AD7298 is not set
> # CONFIG_AD7476 is not set
> # CONFIG_AD7606_IFACE_PARALLEL is not set
> # CONFIG_AD7606_IFACE_SPI is not set
> # CONFIG_AD7766 is not set
> # CONFIG_AD7768_1 is not set
> # CONFIG_AD7780 is not set
> # CONFIG_AD7791 is not set
> CONFIG_AD7793=y
> # CONFIG_AD7887 is not set
> # CONFIG_AD7923 is not set
> CONFIG_AD7949=y
> CONFIG_AD799X=m
> CONFIG_AXP20X_ADC=m
> # CONFIG_AXP288_ADC is not set
> CONFIG_CC10001_ADC=y
> CONFIG_HI8435=m
> # CONFIG_HX711 is not set
> CONFIG_INA2XX_ADC=y
> CONFIG_INTEL_MRFLD_ADC=m
> CONFIG_LTC2471=m
> CONFIG_LTC2485=m
> CONFIG_LTC2496=m
> CONFIG_LTC2497=y
> CONFIG_MAX1027=m
> CONFIG_MAX11100=m
> # CONFIG_MAX1118 is not set
> CONFIG_MAX1241=m
> # CONFIG_MAX1363 is not set
> CONFIG_MAX9611=y
> CONFIG_MCP320X=m
> # CONFIG_MCP3422 is not set
> CONFIG_MCP3911=m
> CONFIG_MEDIATEK_MT6360_ADC=m
> # CONFIG_MEN_Z188_ADC is not set
> CONFIG_MP2629_ADC=m
> CONFIG_NAU7802=m
> # CONFIG_PALMAS_GPADC is not set
> CONFIG_QCOM_VADC_COMMON=m
> # CONFIG_QCOM_SPMI_IADC is not set
> CONFIG_QCOM_SPMI_VADC=m
> # CONFIG_QCOM_SPMI_ADC5 is not set
> CONFIG_TI_ADC081C=m
> CONFIG_TI_ADC0832=y
> CONFIG_TI_ADC084S021=y
> CONFIG_TI_ADC12138=m
> CONFIG_TI_ADC108S102=y
> # CONFIG_TI_ADC128S052 is not set
> # CONFIG_TI_ADC161S626 is not set
> CONFIG_TI_ADS1015=y
> CONFIG_TI_ADS7950=m
> # CONFIG_TI_ADS131E08 is not set
> # CONFIG_TI_TLC4541 is not set
> CONFIG_TI_TSC2046=y
> CONFIG_TWL4030_MADC=y
> # CONFIG_TWL6030_GPADC is not set
> CONFIG_XILINX_XADC=m
> # end of Analog to digital converters
> 
> #
> # Analog Front Ends
> #
> # end of Analog Front Ends
> 
> #
> # Amplifiers
> #
> CONFIG_AD8366=m
> CONFIG_HMC425=m
> # end of Amplifiers
> 
> #
> # Capacitance to digital converters
> #
> CONFIG_AD7150=m
> # end of Capacitance to digital converters
> 
> #
> # Chemical Sensors
> #
> # CONFIG_ATLAS_PH_SENSOR is not set
> # CONFIG_ATLAS_EZO_SENSOR is not set
> # CONFIG_BME680 is not set
> # CONFIG_CCS811 is not set
> CONFIG_IAQCORE=y
> # CONFIG_SCD30_CORE is not set
> CONFIG_SENSIRION_SGP30=y
> # CONFIG_SENSIRION_SGP40 is not set
> CONFIG_SPS30=y
> CONFIG_SPS30_I2C=y
> # CONFIG_VZ89X is not set
> # end of Chemical Sensors
> 
> CONFIG_IIO_CROS_EC_SENSORS_CORE=m
> CONFIG_IIO_CROS_EC_SENSORS=m
> CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m
> 
> #
> # Hid Sensor IIO Common
> #
> # end of Hid Sensor IIO Common
> 
> CONFIG_IIO_MS_SENSORS_I2C=y
> 
> #
> # IIO SCMI Sensors
> #
> # end of IIO SCMI Sensors
> 
> #
> # SSP Sensor Common
> #
> # CONFIG_IIO_SSP_SENSORHUB is not set
> # end of SSP Sensor Common
> 
> CONFIG_IIO_ST_SENSORS_I2C=y
> CONFIG_IIO_ST_SENSORS_SPI=y
> CONFIG_IIO_ST_SENSORS_CORE=y
> 
> #
> # Digital to analog converters
> #
> # CONFIG_AD5064 is not set
> # CONFIG_AD5360 is not set
> CONFIG_AD5380=y
> CONFIG_AD5421=m
> CONFIG_AD5446=m
> CONFIG_AD5449=m
> CONFIG_AD5592R_BASE=y
> CONFIG_AD5592R=y
> CONFIG_AD5593R=y
> # CONFIG_AD5504 is not set
> # CONFIG_AD5624R_SPI is not set
> CONFIG_AD5686=y
> # CONFIG_AD5686_SPI is not set
> CONFIG_AD5696_I2C=y
> CONFIG_AD5755=m
> # CONFIG_AD5758 is not set
> CONFIG_AD5761=m
> CONFIG_AD5764=m
> # CONFIG_AD5766 is not set
> # CONFIG_AD5770R is not set
> CONFIG_AD5791=m
> # CONFIG_AD7303 is not set
> # CONFIG_AD8801 is not set
> CONFIG_DS4424=m
> CONFIG_LTC1660=m
> CONFIG_LTC2632=m
> CONFIG_M62332=y
> CONFIG_MAX517=m
> CONFIG_MCP4725=m
> # CONFIG_MCP4922 is not set
> CONFIG_TI_DAC082S085=m
> CONFIG_TI_DAC5571=m
> CONFIG_TI_DAC7311=m
> CONFIG_TI_DAC7612=y
> # end of Digital to analog converters
> 
> #
> # IIO dummy driver
> #
> # end of IIO dummy driver
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> CONFIG_AD9523=y
> # end of Clock Generator/Distribution
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> CONFIG_ADF4350=m
> CONFIG_ADF4371=y
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
> 
> #
> # Digital gyroscope sensors
> #
> CONFIG_ADIS16080=y
> CONFIG_ADIS16130=m
> CONFIG_ADIS16136=y
> # CONFIG_ADIS16260 is not set
> CONFIG_ADXRS290=m
> CONFIG_ADXRS450=y
> CONFIG_BMG160=m
> CONFIG_BMG160_I2C=m
> CONFIG_BMG160_SPI=m
> CONFIG_FXAS21002C=m
> CONFIG_FXAS21002C_I2C=m
> CONFIG_FXAS21002C_SPI=m
> CONFIG_MPU3050=m
> CONFIG_MPU3050_I2C=m
> CONFIG_IIO_ST_GYRO_3AXIS=y
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
> CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
> CONFIG_ITG3200=y
> # end of Digital gyroscope sensors
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> CONFIG_AFE4403=m
> CONFIG_AFE4404=y
> CONFIG_MAX30100=m
> # CONFIG_MAX30102 is not set
> # end of Heart Rate Monitors
> # end of Health Sensors
> 
> #
> # Humidity sensors
> #
> # CONFIG_AM2315 is not set
> # CONFIG_DHT11 is not set
> # CONFIG_HDC100X is not set
> CONFIG_HDC2010=m
> # CONFIG_HTS221 is not set
> # CONFIG_HTU21 is not set
> # CONFIG_SI7005 is not set
> CONFIG_SI7020=m
> # end of Humidity sensors
> 
> #
> # Inertial measurement units
> #
> CONFIG_ADIS16400=m
> # CONFIG_ADIS16460 is not set
> CONFIG_ADIS16475=m
> # CONFIG_ADIS16480 is not set
> CONFIG_BMI160=y
> CONFIG_BMI160_I2C=y
> CONFIG_BMI160_SPI=y
> # CONFIG_FXOS8700_I2C is not set
> # CONFIG_FXOS8700_SPI is not set
> CONFIG_KMX61=m
> CONFIG_INV_ICM42600=m
> # CONFIG_INV_ICM42600_I2C is not set
> CONFIG_INV_ICM42600_SPI=m
> CONFIG_INV_MPU6050_IIO=y
> # CONFIG_INV_MPU6050_I2C is not set
> CONFIG_INV_MPU6050_SPI=y
> # CONFIG_IIO_ST_LSM6DSX is not set
> CONFIG_IIO_ST_LSM9DS0=m
> CONFIG_IIO_ST_LSM9DS0_I2C=m
> CONFIG_IIO_ST_LSM9DS0_SPI=m
> # end of Inertial measurement units
> 
> CONFIG_IIO_ADIS_LIB=y
> CONFIG_IIO_ADIS_LIB_BUFFER=y
> 
> #
> # Light sensors
> #
> # CONFIG_ACPI_ALS is not set
> CONFIG_ADJD_S311=m
> CONFIG_ADUX1020=m
> CONFIG_AL3010=m
> CONFIG_AL3320A=m
> # CONFIG_APDS9300 is not set
> # CONFIG_APDS9960 is not set
> CONFIG_AS73211=y
> # CONFIG_BH1750 is not set
> # CONFIG_BH1780 is not set
> # CONFIG_CM32181 is not set
> CONFIG_CM3232=y
> CONFIG_CM3323=m
> CONFIG_CM36651=m
> CONFIG_IIO_CROS_EC_LIGHT_PROX=m
> CONFIG_GP2AP002=m
> CONFIG_GP2AP020A00F=y
> CONFIG_SENSORS_ISL29018=m
> CONFIG_SENSORS_ISL29028=m
> CONFIG_ISL29125=y
> CONFIG_JSA1212=y
> CONFIG_RPR0521=y
> CONFIG_SENSORS_LM3533=m
> CONFIG_LTR501=y
> CONFIG_LV0104CS=m
> # CONFIG_MAX44000 is not set
> # CONFIG_MAX44009 is not set
> # CONFIG_NOA1305 is not set
> # CONFIG_OPT3001 is not set
> CONFIG_PA12203001=m
> # CONFIG_SI1133 is not set
> CONFIG_SI1145=y
> # CONFIG_STK3310 is not set
> CONFIG_ST_UVIS25=m
> CONFIG_ST_UVIS25_I2C=m
> CONFIG_ST_UVIS25_SPI=m
> CONFIG_TCS3414=m
> CONFIG_TCS3472=y
> CONFIG_SENSORS_TSL2563=y
> CONFIG_TSL2583=y
> CONFIG_TSL2591=y
> # CONFIG_TSL2772 is not set
> CONFIG_TSL4531=m
> CONFIG_US5182D=y
> CONFIG_VCNL4000=m
> CONFIG_VCNL4035=y
> # CONFIG_VEML6030 is not set
> CONFIG_VEML6070=y
> # CONFIG_VL6180 is not set
> CONFIG_ZOPT2201=m
> # end of Light sensors
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8975=m
> # CONFIG_AK09911 is not set
> CONFIG_BMC150_MAGN=m
> # CONFIG_BMC150_MAGN_I2C is not set
> CONFIG_BMC150_MAGN_SPI=m
> CONFIG_MAG3110=m
> CONFIG_MMC35240=m
> CONFIG_IIO_ST_MAGN_3AXIS=y
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
> CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
> CONFIG_SENSORS_HMC5843=y
> CONFIG_SENSORS_HMC5843_I2C=y
> CONFIG_SENSORS_HMC5843_SPI=y
> CONFIG_SENSORS_RM3100=y
> CONFIG_SENSORS_RM3100_I2C=y
> # CONFIG_SENSORS_RM3100_SPI is not set
> CONFIG_YAMAHA_YAS530=m
> # end of Magnetometer sensors
> 
> #
> # Multiplexers
> #
> # end of Multiplexers
> 
> #
> # Inclinometer sensors
> #
> # end of Inclinometer sensors
> 
> CONFIG_IIO_TEST_FORMAT=y
> 
> #
> # Triggers - standalone
> #
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> CONFIG_IIO_SYSFS_TRIGGER=y
> # end of Triggers - standalone
> 
> #
> # Linear and angular position sensors
> #
> # end of Linear and angular position sensors
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> CONFIG_AD5272=y
> CONFIG_DS1803=m
> # CONFIG_MAX5432 is not set
> CONFIG_MAX5481=y
> CONFIG_MAX5487=m
> CONFIG_MCP4018=m
> # CONFIG_MCP4131 is not set
> # CONFIG_MCP4531 is not set
> CONFIG_MCP41010=m
> CONFIG_TPL0102=m
> # end of Digital potentiometers
> 
> #
> # Digital potentiostats
> #
> CONFIG_LMP91000=m
> # end of Digital potentiostats
> 
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> CONFIG_BMP280=m
> CONFIG_BMP280_I2C=m
> CONFIG_BMP280_SPI=m
> CONFIG_IIO_CROS_EC_BARO=m
> CONFIG_DLHL60D=m
> # CONFIG_DPS310 is not set
> CONFIG_HP03=m
> CONFIG_ICP10100=y
> CONFIG_MPL115=y
> CONFIG_MPL115_I2C=y
> CONFIG_MPL115_SPI=m
> CONFIG_MPL3115=m
> CONFIG_MS5611=y
> # CONFIG_MS5611_I2C is not set
> # CONFIG_MS5611_SPI is not set
> CONFIG_MS5637=m
> # CONFIG_IIO_ST_PRESS is not set
> # CONFIG_T5403 is not set
> CONFIG_HP206C=m
> # CONFIG_ZPA2326 is not set
> # end of Pressure sensors
> 
> #
> # Lightning sensors
> #
> # CONFIG_AS3935 is not set
> # end of Lightning sensors
> 
> #
> # Proximity and distance sensors
> #
> CONFIG_CROS_EC_MKBP_PROXIMITY=y
> CONFIG_ISL29501=m
> CONFIG_LIDAR_LITE_V2=y
> # CONFIG_MB1232 is not set
> CONFIG_PING=m
> CONFIG_RFD77402=m
> CONFIG_SRF04=y
> CONFIG_SX9310=m
> CONFIG_SX9500=m
> # CONFIG_SRF08 is not set
> CONFIG_VCNL3020=y
> # CONFIG_VL53L0X_I2C is not set
> # end of Proximity and distance sensors
> 
> #
> # Resolver to digital converters
> #
> CONFIG_AD2S90=y
> CONFIG_AD2S1200=m
> # end of Resolver to digital converters
> 
> #
> # Temperature sensors
> #
> # CONFIG_LTC2983 is not set
> CONFIG_MAXIM_THERMOCOUPLE=m
> CONFIG_MLX90614=m
> CONFIG_MLX90632=y
> CONFIG_TMP006=y
> # CONFIG_TMP007 is not set
> CONFIG_TMP117=y
> CONFIG_TSYS01=y
> CONFIG_TSYS02D=m
> # CONFIG_MAX31856 is not set
> # end of Temperature sensors
> 
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> CONFIG_MADERA_IRQ=m
> # end of IRQ chip support
> 
> CONFIG_IPACK_BUS=m
> # CONFIG_BOARD_TPCI200 is not set
> # CONFIG_SERIAL_IPOCTAL is not set
> CONFIG_RESET_CONTROLLER=y
> CONFIG_RESET_TI_SYSCON=m
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_USB_LGM_PHY is not set
> CONFIG_PHY_CAN_TRANSCEIVER=m
> # CONFIG_BCM_KONA_USB2_PHY is not set
> CONFIG_PHY_PXA_28NM_HSIC=m
> CONFIG_PHY_PXA_28NM_USB2=y
> # CONFIG_PHY_CPCAP_USB is not set
> CONFIG_PHY_INTEL_LGM_EMMC=y
> # end of PHY Subsystem
> 
> # CONFIG_POWERCAP is not set
> CONFIG_MCB=y
> CONFIG_MCB_PCI=m
> # CONFIG_MCB_LPC is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> # CONFIG_RAS is not set
> CONFIG_USB4=y
> # CONFIG_USB4_DEBUGFS_WRITE is not set
> # CONFIG_USB4_KUNIT_TEST is not set
> # CONFIG_USB4_DMA_TEST is not set
> 
> #
> # Android
> #
> CONFIG_ANDROID=y
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
> 
> CONFIG_DAX=y
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> # CONFIG_NVMEM_NINTENDO_OTP is not set
> # CONFIG_NVMEM_SPMI_SDAM is not set
> CONFIG_NVMEM_RMEM=y
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> CONFIG_INTEL_TH=m
> CONFIG_INTEL_TH_PCI=m
> CONFIG_INTEL_TH_ACPI=m
> CONFIG_INTEL_TH_GTH=m
> # CONFIG_INTEL_TH_MSU is not set
> CONFIG_INTEL_TH_PTI=m
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
> 
> CONFIG_FPGA=y
> CONFIG_ALTERA_PR_IP_CORE=y
> CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
> CONFIG_FPGA_MGR_ALTERA_CVP=y
> CONFIG_FPGA_MGR_XILINX_SPI=m
> CONFIG_FPGA_MGR_MACHXO2_SPI=m
> # CONFIG_FPGA_BRIDGE is not set
> # CONFIG_FPGA_DFL is not set
> CONFIG_MULTIPLEXER=y
> 
> #
> # Multiplexer drivers
> #
> CONFIG_MUX_ADG792A=m
> CONFIG_MUX_ADGS1408=m
> CONFIG_MUX_GPIO=y
> # end of Multiplexer drivers
> 
> CONFIG_SIOX=y
> CONFIG_SIOX_BUS_GPIO=m
> CONFIG_SLIMBUS=m
> CONFIG_SLIM_QCOM_CTRL=m
> # CONFIG_INTERCONNECT is not set
> CONFIG_COUNTER=y
> # CONFIG_INTERRUPT_CNT is not set
> CONFIG_INTEL_QEP=y
> CONFIG_MOST=y
> # CONFIG_MOST_CDEV is not set
> # CONFIG_MOST_SND is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> # CONFIG_EXT2_FS is not set
> CONFIG_EXT3_FS=y
> # CONFIG_EXT3_FS_POSIX_ACL is not set
> CONFIG_EXT3_FS_SECURITY=y
> CONFIG_EXT4_FS=y
> # CONFIG_EXT4_USE_FOR_EXT2 is not set
> # CONFIG_EXT4_FS_POSIX_ACL is not set
> CONFIG_EXT4_FS_SECURITY=y
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_EXT4_KUNIT_TESTS=m
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> CONFIG_JFS_FS=m
> CONFIG_JFS_POSIX_ACL=y
> # CONFIG_JFS_SECURITY is not set
> # CONFIG_JFS_DEBUG is not set
> # CONFIG_JFS_STATISTICS is not set
> CONFIG_XFS_FS=m
> # CONFIG_XFS_SUPPORT_V4 is not set
> CONFIG_XFS_QUOTA=y
> CONFIG_XFS_POSIX_ACL=y
> CONFIG_XFS_RT=y
> # CONFIG_XFS_ONLINE_SCRUB is not set
> CONFIG_XFS_WARN=y
> # CONFIG_XFS_DEBUG is not set
> CONFIG_GFS2_FS=y
> CONFIG_OCFS2_FS=m
> # CONFIG_OCFS2_FS_O2CB is not set
> # CONFIG_OCFS2_FS_USERSPACE_CLUSTER is not set
> # CONFIG_OCFS2_FS_STATS is not set
> # CONFIG_OCFS2_DEBUG_MASKLOG is not set
> # CONFIG_OCFS2_DEBUG_FS is not set
> CONFIG_BTRFS_FS=y
> CONFIG_BTRFS_FS_POSIX_ACL=y
> CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> CONFIG_BTRFS_ASSERT=y
> CONFIG_BTRFS_FS_REF_VERIFY=y
> # CONFIG_NILFS2_FS is not set
> CONFIG_F2FS_FS=m
> CONFIG_F2FS_STAT_FS=y
> # CONFIG_F2FS_FS_XATTR is not set
> CONFIG_F2FS_CHECK_FS=y
> CONFIG_F2FS_FAULT_INJECTION=y
> # CONFIG_F2FS_FS_COMPRESSION is not set
> CONFIG_F2FS_IOSTAT=y
> # CONFIG_FS_DAX is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> CONFIG_FILE_LOCKING=y
> # CONFIG_FS_ENCRYPTION is not set
> CONFIG_FS_VERITY=y
> CONFIG_FS_VERITY_DEBUG=y
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> # CONFIG_FANOTIFY is not set
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> # CONFIG_PRINT_QUOTA_WARNING is not set
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=m
> # CONFIG_QFMT_V1 is not set
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=y
> # CONFIG_AUTOFS4_FS is not set
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=m
> # CONFIG_CUSE is not set
> CONFIG_VIRTIO_FS=m
> CONFIG_OVERLAY_FS=y
> CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> # CONFIG_OVERLAY_FS_INDEX is not set
> CONFIG_OVERLAY_FS_METACOPY=y
> 
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=y
> # CONFIG_NETFS_STATS is not set
> # CONFIG_FSCACHE is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> # CONFIG_ZISOFS is not set
> CONFIG_UDF_FS=y
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> # CONFIG_MSDOS_FS is not set
> CONFIG_VFAT_FS=m
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> # CONFIG_FAT_KUNIT_TEST is not set
> # CONFIG_EXFAT_FS is not set
> CONFIG_NTFS_FS=m
> CONFIG_NTFS_DEBUG=y
> CONFIG_NTFS_RW=y
> # CONFIG_NTFS3_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_PROC_CPU_RESCTRL=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> CONFIG_TMPFS_XATTR=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_MEMFD_CREATE=y
> CONFIG_CONFIGFS_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_ORANGEFS_FS=y
> CONFIG_ADFS_FS=y
> # CONFIG_ADFS_FS_RW is not set
> CONFIG_AFFS_FS=y
> CONFIG_ECRYPT_FS=m
> # CONFIG_ECRYPT_FS_MESSAGING is not set
> # CONFIG_HFS_FS is not set
> CONFIG_HFSPLUS_FS=y
> CONFIG_BEFS_FS=m
> CONFIG_BEFS_DEBUG=y
> CONFIG_BFS_FS=m
> CONFIG_EFS_FS=m
> CONFIG_JFFS2_FS=m
> CONFIG_JFFS2_FS_DEBUG=0
> # CONFIG_JFFS2_FS_WRITEBUFFER is not set
> CONFIG_JFFS2_SUMMARY=y
> # CONFIG_JFFS2_FS_XATTR is not set
> CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> CONFIG_JFFS2_ZLIB=y
> CONFIG_JFFS2_LZO=y
> CONFIG_JFFS2_RTIME=y
> CONFIG_JFFS2_RUBIN=y
> # CONFIG_JFFS2_CMODE_NONE is not set
> # CONFIG_JFFS2_CMODE_PRIORITY is not set
> CONFIG_JFFS2_CMODE_SIZE=y
> # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
> CONFIG_UBIFS_FS=m
> # CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
> CONFIG_UBIFS_FS_LZO=y
> CONFIG_UBIFS_FS_ZLIB=y
> CONFIG_UBIFS_FS_ZSTD=y
> # CONFIG_UBIFS_ATIME_SUPPORT is not set
> # CONFIG_UBIFS_FS_XATTR is not set
> CONFIG_UBIFS_FS_AUTHENTICATION=y
> CONFIG_CRAMFS=m
> # CONFIG_CRAMFS_BLOCKDEV is not set
> # CONFIG_CRAMFS_MTD is not set
> # CONFIG_SQUASHFS is not set
> # CONFIG_VXFS_FS is not set
> CONFIG_MINIX_FS=m
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_QNX4FS_FS=m
> CONFIG_QNX6FS_FS=m
> # CONFIG_QNX6FS_DEBUG is not set
> CONFIG_ROMFS_FS=m
> # CONFIG_ROMFS_BACKED_BY_BLOCK is not set
> # CONFIG_ROMFS_BACKED_BY_MTD is not set
> CONFIG_ROMFS_BACKED_BY_BOTH=y
> CONFIG_ROMFS_ON_BLOCK=y
> CONFIG_ROMFS_ON_MTD=y
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=m
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> CONFIG_PSTORE_LZ4_COMPRESS=m
> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> CONFIG_PSTORE_842_COMPRESS=y
> CONFIG_PSTORE_ZSTD_COMPRESS=y
> CONFIG_PSTORE_COMPRESS=y
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> # CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
> # CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
> # CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
> CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> CONFIG_PSTORE_CONSOLE=y
> CONFIG_PSTORE_PMSG=y
> CONFIG_PSTORE_RAM=m
> CONFIG_SYSV_FS=y
> # CONFIG_UFS_FS is not set
> CONFIG_EROFS_FS=m
> CONFIG_EROFS_FS_DEBUG=y
> # CONFIG_EROFS_FS_XATTR is not set
> # CONFIG_EROFS_FS_ZIP is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=m
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
> CONFIG_PNFS_FILE_LAYOUT=m
> CONFIG_PNFS_FLEXFILE_LAYOUT=m
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> CONFIG_NFS_V4_SECURITY_LABEL=y
> # CONFIG_ROOT_NFS is not set
> CONFIG_NFS_USE_LEGACY_DNS=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFS_V4_2_READ_PLUS is not set
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_NFS_V4_2_SSC_HELPER=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=m
> CONFIG_SUNRPC_BACKCHANNEL=y
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=m
> CONFIG_CIFS_STATS2=y
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> # CONFIG_CIFS_UPCALL is not set
> # CONFIG_CIFS_XATTR is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_SWN_UPCALL is not set
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS_COMMON=m
> # CONFIG_CODA_FS is not set
> CONFIG_AFS_FS=y
> # CONFIG_AFS_DEBUG is not set
> # CONFIG_AFS_DEBUG_CURSOR is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_CODEPAGE_737=y
> CONFIG_NLS_CODEPAGE_775=y
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> CONFIG_NLS_CODEPAGE_857=y
> CONFIG_NLS_CODEPAGE_860=m
> # CONFIG_NLS_CODEPAGE_861 is not set
> CONFIG_NLS_CODEPAGE_862=m
> CONFIG_NLS_CODEPAGE_863=y
> CONFIG_NLS_CODEPAGE_864=m
> CONFIG_NLS_CODEPAGE_865=y
> CONFIG_NLS_CODEPAGE_866=y
> # CONFIG_NLS_CODEPAGE_869 is not set
> CONFIG_NLS_CODEPAGE_936=y
> CONFIG_NLS_CODEPAGE_950=y
> CONFIG_NLS_CODEPAGE_932=y
> CONFIG_NLS_CODEPAGE_949=m
> # CONFIG_NLS_CODEPAGE_874 is not set
> CONFIG_NLS_ISO8859_8=m
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> # CONFIG_NLS_ISO8859_1 is not set
> CONFIG_NLS_ISO8859_2=m
> CONFIG_NLS_ISO8859_3=m
> CONFIG_NLS_ISO8859_4=y
> CONFIG_NLS_ISO8859_5=y
> CONFIG_NLS_ISO8859_6=m
> CONFIG_NLS_ISO8859_7=y
> CONFIG_NLS_ISO8859_9=y
> CONFIG_NLS_ISO8859_13=y
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=y
> CONFIG_NLS_KOI8_R=y
> CONFIG_NLS_KOI8_U=y
> CONFIG_NLS_MAC_ROMAN=y
> CONFIG_NLS_MAC_CELTIC=y
> CONFIG_NLS_MAC_CENTEURO=m
> CONFIG_NLS_MAC_CROATIAN=m
> CONFIG_NLS_MAC_CYRILLIC=m
> CONFIG_NLS_MAC_GAELIC=m
> CONFIG_NLS_MAC_GREEK=m
> CONFIG_NLS_MAC_ICELAND=y
> # CONFIG_NLS_MAC_INUIT is not set
> CONFIG_NLS_MAC_ROMANIAN=y
> # CONFIG_NLS_MAC_TURKISH is not set
> CONFIG_NLS_UTF8=y
> CONFIG_DLM=m
> CONFIG_DLM_DEBUG=y
> CONFIG_UNICODE=y
> CONFIG_UNICODE_NORMALIZATION_SELFTEST=m
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=y
> CONFIG_BIG_KEYS=y
> CONFIG_ENCRYPTED_KEYS=m
> CONFIG_KEY_DH_OPERATIONS=y
> CONFIG_KEY_NOTIFICATIONS=y
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> # CONFIG_SECURITYFS is not set
> # CONFIG_SECURITY_NETWORK is not set
> # CONFIG_SECURITY_PATH is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_HARDENED_USERCOPY_FALLBACK=y
> CONFIG_HARDENED_USERCOPY_PAGESPAN=y
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_LOADPIN is not set
> # CONFIG_SECURITY_YAMA is not set
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> CONFIG_INTEGRITY=y
> # CONFIG_INTEGRITY_SIGNATURE is not set
> # CONFIG_IMA is not set
> # CONFIG_EVM is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=y
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=m
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> CONFIG_CRYPTO_USER=y
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_PCRYPT=m
> # CONFIG_CRYPTO_CRYPTD is not set
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_ECC=y
> CONFIG_CRYPTO_ECDH=m
> CONFIG_CRYPTO_ECDSA=y
> # CONFIG_CRYPTO_ECRDSA is not set
> CONFIG_CRYPTO_SM2=y
> # CONFIG_CRYPTO_CURVE25519 is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=m
> CONFIG_CRYPTO_GCM=y
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> # CONFIG_CRYPTO_AEGIS128 is not set
> CONFIG_CRYPTO_SEQIV=m
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=m
> CONFIG_CRYPTO_CFB=m
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=m
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=m
> # CONFIG_CRYPTO_OFB is not set
> CONFIG_CRYPTO_PCBC=y
> CONFIG_CRYPTO_XTS=y
> # CONFIG_CRYPTO_KEYWRAP is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
> # CONFIG_CRYPTO_ESSIV is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> CONFIG_CRYPTO_VMAC=y
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=m
> CONFIG_CRYPTO_CRC32=m
> # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> CONFIG_CRYPTO_XXHASH=y
> CONFIG_CRYPTO_BLAKE2B=y
> # CONFIG_CRYPTO_BLAKE2S is not set
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=y
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=m
> CONFIG_CRYPTO_MICHAEL_MIC=y
> CONFIG_CRYPTO_RMD160=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=m
> # CONFIG_CRYPTO_SHA3 is not set
> CONFIG_CRYPTO_SM3=y
> # CONFIG_CRYPTO_STREEBOG is not set
> CONFIG_CRYPTO_WP512=m
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=m
> # CONFIG_CRYPTO_AES_TI is not set
> # CONFIG_CRYPTO_AES_NI_INTEL is not set
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_CAMELLIA is not set
> CONFIG_CRYPTO_CAST_COMMON=m
> # CONFIG_CRYPTO_CAST5 is not set
> CONFIG_CRYPTO_CAST6=m
> # CONFIG_CRYPTO_DES is not set
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_CHACHA20=m
> CONFIG_CRYPTO_SERPENT=y
> # CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
> CONFIG_CRYPTO_SM4=m
> # CONFIG_CRYPTO_TWOFISH is not set
> CONFIG_CRYPTO_TWOFISH_COMMON=m
> CONFIG_CRYPTO_TWOFISH_586=m
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_LZO=m
> CONFIG_CRYPTO_842=y
> CONFIG_CRYPTO_LZ4=y
> CONFIG_CRYPTO_LZ4HC=y
> CONFIG_CRYPTO_ZSTD=y
> 
> #
> # Random Number Generation
> #
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> CONFIG_CRYPTO_DRBG_MENU=m
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=m
> CONFIG_CRYPTO_JITTERENTROPY=m
> CONFIG_CRYPTO_USER_API=y
> CONFIG_CRYPTO_USER_API_HASH=m
> CONFIG_CRYPTO_USER_API_SKCIPHER=m
> CONFIG_CRYPTO_USER_API_RNG=y
> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> # CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
> # CONFIG_CRYPTO_STATS is not set
> CONFIG_CRYPTO_HASH_INFO=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=m
> # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> CONFIG_CRYPTO_LIB_CURVE25519=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
> CONFIG_CRYPTO_LIB_SHA256=y
> CONFIG_CRYPTO_LIB_SM4=m
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> CONFIG_SYSTEM_REVOCATION_LIST=y
> CONFIG_SYSTEM_REVOCATION_KEYS=""
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=y
> # CONFIG_RAID6_PQ_BENCHMARK is not set
> CONFIG_LINEAR_RANGES=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_CORDIC=y
> CONFIG_PRIME_NUMBERS=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> CONFIG_CRC32_SELFTEST=y
> # CONFIG_CRC32_SLICEBY8 is not set
> CONFIG_CRC32_SLICEBY4=y
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=y
> CONFIG_CRC4=y
> CONFIG_CRC7=m
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4HC_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> # CONFIG_XZ_DEC_SPARC is not set
> CONFIG_XZ_DEC_BCJ=y
> CONFIG_XZ_DEC_TEST=m
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=m
> CONFIG_REED_SOLOMON_ENC8=y
> CONFIG_REED_SOLOMON_DEC8=y
> CONFIG_BCH=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> # CONFIG_DMA_API_DEBUG is not set
> CONFIG_DMA_MAP_BENCHMARK=y
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> CONFIG_GLOB_SELFTEST=m
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_OID_REGISTRY=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_32=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=m
> CONFIG_FONT_8x16=y
> CONFIG_FONT_AUTOSELECT=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_STACK_HASH_ORDER=20
> CONFIG_SBITMAP=y
> # end of Library routines
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_PRINTK_CALLER=y
> CONFIG_STACKTRACE_BUILD_ID=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> # CONFIG_SYMBOLIC_ERRNAME is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=1024
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
> CONFIG_FRAME_POINTER=y
> CONFIG_VMLINUX_MAP=y
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> # CONFIG_DEBUG_FS_ALLOW_ALL is not set
> CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> CONFIG_UBSAN_BOUNDS=y
> CONFIG_UBSAN_ONLY_BOUNDS=y
> CONFIG_UBSAN_SHIFT=y
> # CONFIG_UBSAN_DIV_ZERO is not set
> CONFIG_UBSAN_UNREACHABLE=y
> # CONFIG_UBSAN_BOOL is not set
> # CONFIG_UBSAN_ENUM is not set
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_UBSAN_SANITIZE_ALL=y
> CONFIG_TEST_UBSAN=m
> # end of Generic Kernel Debugging Instruments
> 
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_MISC is not set
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_PAGE_OWNER=y
> CONFIG_PAGE_POISONING=y
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> CONFIG_DEBUG_WX=y
> CONFIG_GENERIC_PTDUMP=y
> CONFIG_PTDUMP_CORE=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> CONFIG_SLUB_STATS=y
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> CONFIG_DEBUG_STACK_USAGE=y
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> CONFIG_DEBUG_VM=y
> CONFIG_DEBUG_VM_VMACACHE=y
> CONFIG_DEBUG_VM_RB=y
> CONFIG_DEBUG_VM_PGFLAGS=y
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_MEMORY_INIT is not set
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_DEBUG_KMAP_LOCAL=y
> CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
> CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
> # CONFIG_DEBUG_HIGHMEM is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_HAVE_ARCH_KFENCE=y
> CONFIG_KFENCE=y
> CONFIG_KFENCE_STATIC_KEYS=y
> CONFIG_KFENCE_SAMPLE_INTERVAL=100
> CONFIG_KFENCE_NUM_OBJECTS=255
> CONFIG_KFENCE_STRESS_TEST_FAULTS=0
> # CONFIG_KFENCE_KUNIT_TEST is not set
> # end of Memory Debugging
> 
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
> CONFIG_WQ_WATCHDOG=y
> CONFIG_TEST_LOCKUP=m
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> CONFIG_DEBUG_TIMEKEEPING=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> # CONFIG_PROVE_RAW_LOCK_NESTING is not set
> CONFIG_LOCK_STAT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCKDEP_BITS=15
> CONFIG_LOCKDEP_CHAINS_BITS=16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> CONFIG_LOCK_TORTURE_TEST=m
> CONFIG_WW_MUTEX_SELFTEST=y
> # CONFIG_SCF_TORTURE_TEST is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_TRACE_IRQFLAGS_NMI=y
> CONFIG_DEBUG_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> # CONFIG_DEBUG_LIST is not set
> CONFIG_DEBUG_PLIST=y
> CONFIG_DEBUG_SG=y
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Debug kernel data structures
> 
> CONFIG_DEBUG_CREDENTIALS=y
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> # CONFIG_PROVE_RCU_LIST is not set
> CONFIG_TORTURE_TEST=m
> CONFIG_RCU_SCALE_TEST=m
> CONFIG_RCU_TORTURE_TEST=m
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
> CONFIG_LATENCYTOP=y
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> CONFIG_TRACING=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_SAMPLES is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> # CONFIG_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_EARLY_PRINTK_USB=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_EARLY_PRINTK_USB_XDBC=y
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> # CONFIG_IO_DELAY_0X80 is not set
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> CONFIG_IO_DELAY_NONE=y
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> CONFIG_KUNIT=y
> # CONFIG_KUNIT_DEBUGFS is not set
> CONFIG_KUNIT_TEST=m
> CONFIG_KUNIT_EXAMPLE_TEST=m
> # CONFIG_KUNIT_ALL_TESTS is not set
> CONFIG_NOTIFIER_ERROR_INJECTION=m
> CONFIG_PM_NOTIFIER_ERROR_INJECT=m
> CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_RUNTIME_TESTING_MENU is not set
> CONFIG_ARCH_USE_MEMTEST=y
> # CONFIG_MEMTEST is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='rcutorture'
> 	export testcase='rcutorture'
> 	export category='functional'
> 	export need_memory='300MB'
> 	export runtime=300
> 	export job_origin='rcutorture.yaml'
> 	export queue_cmdline_keys='branch
> commit'
> 	export queue='bisect'
> 	export testbox='vm-snb-i386-2'
> 	export tbox_group='vm-snb-i386'
> 	export branch='paulmck-rcu/dev.2021.09.22a'
> 	export commit='be6350ccbb78fbc8186f4b3265ed331654ef3ad9'
> 	export kconfig='i386-randconfig-a003-20210930'
> 	export nr_vm=160
> 	export submit_id='615611e8545c7c63db15174a'
> 	export job_file='/lkp/jobs/scheduled/vm-snb-i386-2/rcutorture-300s-cpuhotplug-rcu-debian-i386-20191205.cgz-be6350ccbb78fbc8186f4b3265ed331654ef3ad9-20211001-91099-1s0bqgb-4.yaml'
> 	export id='61746895b3d08b6e8af40a15517207d134ba7649'
> 	export queuer_version='/lkp-src'
> 	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
> 	export nr_cpu=2
> 	export memory='4G'
> 	export need_kconfig=\{\"RCU_TORTURE_TEST\"\=\>\"m\"\}'
> '\{\"SECURITY_LOADPIN_ENABLED\"\=\>\"n,\ \<\=\ v4.19\"\}'
> '\{\"SECURITY_LOADPIN_ENFORCE\"\=\>\"n,\ v4.20\"\}'
> '\{\"KVM_GUEST\"\=\>\"y\"\}
> 	export ssh_base_port=23400
> 	export kernel_cmdline='vmalloc=128M initramfs_async=0 page_owner=on'
> 	export rootfs='debian-i386-20191205.cgz'
> 	export compiler='gcc-9'
> 	export enqueue_time='2021-10-01 03:37:12 +0800'
> 	export _id='61561816545c7c63db15174e'
> 	export _rt='/result/rcutorture/300s-cpuhotplug-rcu/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a003-20210930/gcc-9/be6350ccbb78fbc8186f4b3265ed331654ef3ad9'
> 	export user='lkp'
> 	export LKP_SERVER='internal-lkp-server'
> 	export result_root='/result/rcutorture/300s-cpuhotplug-rcu/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a003-20210930/gcc-9/be6350ccbb78fbc8186f4b3265ed331654ef3ad9/3'
> 	export scheduler_version='/lkp/lkp/.src-20210930-100745'
> 	export arch='i386'
> 	export max_uptime=2100
> 	export initrd='/osimage/debian/debian-i386-20191205.cgz'
> 	export bootloader_append='root=/dev/ram0
> user=lkp
> job=/lkp/jobs/scheduled/vm-snb-i386-2/rcutorture-300s-cpuhotplug-rcu-debian-i386-20191205.cgz-be6350ccbb78fbc8186f4b3265ed331654ef3ad9-20211001-91099-1s0bqgb-4.yaml
> ARCH=i386
> kconfig=i386-randconfig-a003-20210930
> branch=paulmck-rcu/dev.2021.09.22a
> commit=be6350ccbb78fbc8186f4b3265ed331654ef3ad9
> BOOT_IMAGE=/pkg/linux/i386-randconfig-a003-20210930/gcc-9/be6350ccbb78fbc8186f4b3265ed331654ef3ad9/vmlinuz-5.15.0-rc1-00093-gbe6350ccbb78
> vmalloc=128M initramfs_async=0 page_owner=on
> max_uptime=2100
> RESULT_ROOT=/result/rcutorture/300s-cpuhotplug-rcu/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a003-20210930/gcc-9/be6350ccbb78fbc8186f4b3265ed331654ef3ad9/3
> LKP_SERVER=internal-lkp-server
> selinux=0
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/i386-randconfig-a003-20210930/gcc-9/be6350ccbb78fbc8186f4b3265ed331654ef3ad9/modules.cgz'
> 	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export kernel='/pkg/linux/i386-randconfig-a003-20210930/gcc-9/be6350ccbb78fbc8186f4b3265ed331654ef3ad9/vmlinuz-5.15.0-rc1-00093-gbe6350ccbb78'
> 	export dequeue_time='2021-10-01 04:04:01 +0800'
> 	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-2/rcutorture-300s-cpuhotplug-rcu-debian-i386-20191205.cgz-be6350ccbb78fbc8186f4b3265ed331654ef3ad9-20211001-91099-1s0bqgb-4.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test test='cpuhotplug' torture_type='rcu' $LKP_SRC/tests/wrapper rcutorture
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	env test='cpuhotplug' torture_type='rcu' $LKP_SRC/stats/wrapper rcutorture
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper meminfo
> 
> 	$LKP_SRC/stats/wrapper time rcutorture.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
> 
> "$@"


