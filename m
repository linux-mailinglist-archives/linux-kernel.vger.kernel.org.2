Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6694D354BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 07:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbhDFE5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:57:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:47308 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhDFE5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:57:53 -0400
IronPort-SDR: /QwLoc2BxUYX3AtFQwVyYQQL5X9qhB1E8/LdqXlB4YG3xyogSUla1FLwgNKcs7ETjpZYWjQx6f
 6ZwHD1bEARcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="173058054"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="xz'?scan'208";a="173058054"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 21:57:44 -0700
IronPort-SDR: XteVpH8XmU+M6iQbImKpPmqb1SN/rR08Xy6N7ZAMFjpNHJRA3Zs20s4Baq1PPBhzW7TyefIQkX
 7mthGBiGL8RA==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="xz'?scan'208";a="421034664"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 21:57:40 -0700
Date:   Tue, 6 Apr 2021 12:55:28 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: [ACPI]  1a1c130ab7: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20210406045528.GA7352@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 1a1c130ab7575498eed5bcf7220037ae09cd1f8a ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: trinity
version: trinity-i386-4d2343bd-1_20200320
with following parameters:

	number: 99999
	group: group-00

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+---------------------------------------------------------+-----------+------------+
|                                                         | v5.12-rc5 | 1a1c130ab7 |
+---------------------------------------------------------+-----------+------------+
| boot_successes                                          | 16        | 0          |
| BUG:kernel_NULL_pointer_dereference,address             | 0         | 24         |
| Oops:#[##]                                              | 0         | 24         |
| EIP:get_pfnblock_flags_mask                             | 0         | 24         |
| Kernel_panic-not_syncing:Fatal_exception                | 0         | 24         |
+---------------------------------------------------------+-----------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[    0.136065] BUG: kernel NULL pointer dereference, address: 00000004
[    0.136596] #PF: supervisor read access in kernel mode
[    0.137003] #PF: error_code(0x0000) - not-present page
[    0.137431] *pde = 00000000
[    0.137671] Oops: 0000 [#1]
[    0.137908] CPU: 0 PID: 0 Comm: swapper Not tainted 5.12.0-rc5-00001-g1a1c130ab757 #2
[    0.138567] EIP: get_pfnblock_flags_mask (kbuild/src/consumer/mm/page_alloc.c:490 kbuild/src/consumer/mm/page_alloc.c:504) 
[ 0.138971] Code: 55 89 e5 83 ec 08 89 5d f8 89 cb 89 d1 89 75 fc c1 ea 0e c1 e2 04 8b 82 84 77 95 c2 c1 e9 08 83 e1 3c 89 ce 83 e1 1f c1 ee 05 <8b> 04 b0 8b 75 fc d3 e8 21 d8 8b 5d f8 89 ec 5d c3 e8 27 dc e4 ff
All code
========
   0:	55                   	push   %rbp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
   6:	89 5d f8             	mov    %ebx,-0x8(%rbp)
   9:	89 cb                	mov    %ecx,%ebx
   b:	89 d1                	mov    %edx,%ecx
   d:	89 75 fc             	mov    %esi,-0x4(%rbp)
  10:	c1 ea 0e             	shr    $0xe,%edx
  13:	c1 e2 04             	shl    $0x4,%edx
  16:	8b 82 84 77 95 c2    	mov    -0x3d6a887c(%rdx),%eax
  1c:	c1 e9 08             	shr    $0x8,%ecx
  1f:	83 e1 3c             	and    $0x3c,%ecx
  22:	89 ce                	mov    %ecx,%esi
  24:	83 e1 1f             	and    $0x1f,%ecx
  27:	c1 ee 05             	shr    $0x5,%esi
  2a:*	8b 04 b0             	mov    (%rax,%rsi,4),%eax		<-- trapping instruction
  2d:	8b 75 fc             	mov    -0x4(%rbp),%esi
  30:	d3 e8                	shr    %cl,%eax
  32:	21 d8                	and    %ebx,%eax
  34:	8b 5d f8             	mov    -0x8(%rbp),%ebx
  37:	89 ec                	mov    %ebp,%esp
  39:	5d                   	pop    %rbp
  3a:	c3                   	retq   
  3b:	e8 27 dc e4 ff       	callq  0xffffffffffe4dc67

Code starting with the faulting instruction
===========================================
   0:	8b 04 b0             	mov    (%rax,%rsi,4),%eax
   3:	8b 75 fc             	mov    -0x4(%rbp),%esi
   6:	d3 e8                	shr    %cl,%eax
   8:	21 d8                	and    %ebx,%eax
   a:	8b 5d f8             	mov    -0x8(%rbp),%ebx
   d:	89 ec                	mov    %ebp,%esp
   f:	5d                   	pop    %rbp
  10:	c3                   	retq   
  11:	e8 27 dc e4 ff       	callq  0xffffffffffe4dc3d
[    0.140504] EAX: 00000000 EBX: 00000007 ECX: 0000001c EDX: 003faaa0
[    0.141025] ESI: 00000001 EDI: ffffffff EBP: c1c29e18 ESP: c1c29e10
[    0.141544] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210003
[    0.142096] CR0: 80050033 CR2: 00000004 CR3: 02226000 CR4: 00040690
[    0.142620] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.143146] DR6: fffe0ff0 DR7: 00000400
[    0.143473] Call Trace:
[    0.143698] __dump_page (kbuild/src/consumer/mm/debug.c:66) 
[    0.143984] ? find_held_lock (kbuild/src/consumer/kernel/locking/lockdep.c:5003) 
[    0.144300] ? _raw_spin_unlock (kbuild/src/consumer/kernel/locking/spinlock.c:184) 
[    0.144633] ? console_unlock (kbuild/src/consumer/kernel/printk/printk.c:2561) 
[    0.144960] ? __next_mem_range_rev (kbuild/src/consumer/mm/memblock.c:1106) 
[    0.145339] ? memblock_insert_region+0x2a/0x45 
[    0.145762] ? memblock_add_range+0x12d/0x137 
[    0.146242] ? memblock_reserve (kbuild/src/consumer/mm/memblock.c:818 (discriminator 3)) 
[    0.146570] ? should_skip_region (kbuild/src/consumer/mm/memblock.c:935) 
[    0.146905] ? __next_mem_range (kbuild/src/consumer/mm/memblock.c:1002) 
[    0.147245] dump_page (kbuild/src/consumer/arch/x86/include/asm/jump_label.h:25 kbuild/src/consumer/include/linux/page_owner.h:51 kbuild/src/consumer/mm/debug.c:193) 
[    0.147536] reserve_bootmem_region (kbuild/src/consumer/include/linux/page-flags.h:356 kbuild/src/consumer/mm/page_alloc.c:1528) 
[    0.147953] memblock_free_all (kbuild/src/consumer/mm/memblock.c:2013 kbuild/src/consumer/mm/memblock.c:2061) 
[    0.148376] ? memblock_alloc_try_nid (kbuild/src/consumer/mm/memblock.c:1567 (discriminator 3)) 
[    0.148857] mem_init (kbuild/src/consumer/arch/x86/mm/init_32.c:756) 
[    0.149119] start_kernel (kbuild/src/consumer/init/main.c:835 kbuild/src/consumer/init/main.c:908) 
[    0.149421] i386_start_kernel (kbuild/src/consumer/arch/x86/kernel/head32.c:57) 
[    0.149744] startup_32_smp (kbuild/src/consumer/arch/x86/kernel/head_32.S:328) 
[    0.150071] Modules linked in:
[    0.150330] CR2: 0000000000000004
[    0.150589] random: get_random_bytes called from print_oops_end_marker+0x2f/0x50 with crng_init=0 
[    0.150596] ---[ end trace 0000000000000000 ]---
[    0.151694] EIP: get_pfnblock_flags_mask (kbuild/src/consumer/mm/page_alloc.c:490 kbuild/src/consumer/mm/page_alloc.c:504) 
[ 0.152069] Code: 55 89 e5 83 ec 08 89 5d f8 89 cb 89 d1 89 75 fc c1 ea 0e c1 e2 04 8b 82 84 77 95 c2 c1 e9 08 83 e1 3c 89 ce 83 e1 1f c1 ee 05 <8b> 04 b0 8b 75 fc d3 e8 21 d8 8b 5d f8 89 ec 5d c3 e8 27 dc e4 ff
All code
========
   0:	55                   	push   %rbp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
   6:	89 5d f8             	mov    %ebx,-0x8(%rbp)
   9:	89 cb                	mov    %ecx,%ebx
   b:	89 d1                	mov    %edx,%ecx
   d:	89 75 fc             	mov    %esi,-0x4(%rbp)
  10:	c1 ea 0e             	shr    $0xe,%edx
  13:	c1 e2 04             	shl    $0x4,%edx
  16:	8b 82 84 77 95 c2    	mov    -0x3d6a887c(%rdx),%eax
  1c:	c1 e9 08             	shr    $0x8,%ecx
  1f:	83 e1 3c             	and    $0x3c,%ecx
  22:	89 ce                	mov    %ecx,%esi
  24:	83 e1 1f             	and    $0x1f,%ecx
  27:	c1 ee 05             	shr    $0x5,%esi
  2a:*	8b 04 b0             	mov    (%rax,%rsi,4),%eax		<-- trapping instruction
  2d:	8b 75 fc             	mov    -0x4(%rbp),%esi
  30:	d3 e8                	shr    %cl,%eax
  32:	21 d8                	and    %ebx,%eax
  34:	8b 5d f8             	mov    -0x8(%rbp),%ebx
  37:	89 ec                	mov    %ebp,%esp
  39:	5d                   	pop    %rbp
  3a:	c3                   	retq   
  3b:	e8 27 dc e4 ff       	callq  0xffffffffffe4dc67

Code starting with the faulting instruction
===========================================
   0:	8b 04 b0             	mov    (%rax,%rsi,4),%eax
   3:	8b 75 fc             	mov    -0x4(%rbp),%esi
   6:	d3 e8                	shr    %cl,%eax
   8:	21 d8                	and    %ebx,%eax
   a:	8b 5d f8             	mov    -0x8(%rbp),%ebx
   d:	89 ec                	mov    %ebp,%esp
   f:	5d                   	pop    %rbp
  10:	c3                   	retq   
  11:	e8 27 dc e4 ff       	callq  0xffffffffffe4dc3d


To reproduce:

        # build kernel
	cd linux
	cp config-5.12.0-rc5-00001-g1a1c130ab757 .config
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-rc5-00001-g1a1c130ab757"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.12.0-rc5 Kernel Configuration
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
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_UAPI_HEADER_TEST is not set
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
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
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

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
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
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
# CONFIG_TASK_IO_ACCOUNTING is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
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
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
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
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
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
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_QUARK is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
# CONFIG_X86_PAE is not set
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
# CONFIG_X86_UMIP is not set
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
# CONFIG_DPTF_PCH_FIVR is not set
CONFIG_ACPI_CONFIGFS=y
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
CONFIG_X86_P4_CLOCKMOD=y
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
CONFIG_X86_LONGRUN=y
CONFIG_X86_LONGHAUL=m
CONFIG_X86_E_POWERSAVER=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
CONFIG_OLPC_XO15_SCI=y
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=m
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
# CONFIG_GOOGLE_VPD is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_STATIC_CALL_SELFTEST=y
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
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
CONFIG_ARCH_32BIT_OFF_T=y
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
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=m
CONFIG_ZSMALLOC=m
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_ATALK is not set
CONFIG_X25=y
CONFIG_LAPB=m
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
# CONFIG_MPLS is not set
CONFIG_NET_NSH=y
CONFIG_HSR=m
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
CONFIG_BPQETHER=y
# CONFIG_DMASCC is not set
CONFIG_SCC=m
# CONFIG_SCC_DELAY is not set
CONFIG_SCC_TRXECHO=y
CONFIG_BAYCOM_SER_FDX=m
# CONFIG_BAYCOM_SER_HDX is not set
# CONFIG_BAYCOM_PAR is not set
CONFIG_BAYCOM_EPP=y
CONFIG_YAM=y
# end of AX.25 network device drivers

CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
# CONFIG_CAN_BCM is not set
CONFIG_CAN_GW=y
# CONFIG_CAN_J1939 is not set
CONFIG_CAN_ISOTP=y

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
CONFIG_CAN_VXCAN=m
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_FLEXCAN=y
CONFIG_CAN_GRCAN=y
# CONFIG_CAN_KVASER_PCIEFD is not set
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
CONFIG_CAN_IFI_CANFD=y
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
# CONFIG_CAN_EMS_PCI is not set
# CONFIG_CAN_F81601 is not set
# CONFIG_CAN_KVASER_PCI is not set
# CONFIG_CAN_PEAK_PCI is not set
# CONFIG_CAN_PLX_PCI is not set
CONFIG_CAN_SJA1000_ISA=m
CONFIG_CAN_SJA1000_PLATFORM=m
# CONFIG_CAN_TSCAN1 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=y
# CONFIG_CAN_MCP251X is not set
CONFIG_CAN_MCP251XFD=m
# CONFIG_CAN_MCP251XFD_SANITY is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
CONFIG_CAN_ESD_USB2=y
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_MCBA_USB=m
# CONFIG_CAN_PEAK_USB is not set
CONFIG_CAN_UCAN=m
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
# CONFIG_CAIF_NETDEV is not set
CONFIG_CAIF_USB=m
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
CONFIG_NFC_HCI=m
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
CONFIG_NFC_FDP=m
CONFIG_NFC_FDP_I2C=m
CONFIG_NFC_PN533=m
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_PN532_UART=m
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
CONFIG_NFC_MRVL_I2C=m
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
CONFIG_NFC_NXP_NCI=m
# CONFIG_NFC_NXP_NCI_I2C is not set
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
CONFIG_NFC_S3FWRN82_UART=m
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=m
# CONFIG_ETHTOOL_NETLINK is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
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
CONFIG_PCCARD=m
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PCMCIA_PROBE=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_KUNIT_DRIVER_PE_TEST is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MOXTET is not set
CONFIG_MHI_BUS=m
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_PCI_GENERIC is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_MTD=y
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=m
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
# CONFIG_MTD_SBC_GXX is not set
CONFIG_MTD_AMD76XROM=m
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_MCHP23K256=m
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=m
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=m
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
# CONFIG_MTD_RAW_NAND is not set
CONFIG_MTD_SPI_NAND=m

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_NAND_ECC_SW_BCH=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
# CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
CONFIG_SPI_INTEL_SPI=m
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_HYPERBUS=y
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=y
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
CONFIG_LATTICE_ECP3_CONFIG=m
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_PVPANIC is not set
# CONFIG_HISI_HIKEY_USB is not set
CONFIG_C2PORT=m
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module (requires I2C)
#
CONFIG_ALTERA_STAPL=m
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
CONFIG_ECHO=m
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=m
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=m
# end of Misc devices

CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
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
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
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
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_NI65 is not set
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
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
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
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
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
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
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
# CONFIG_SMC9194 is not set
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
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
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
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_INPORT=y
# CONFIG_MOUSE_ATIXL is not set
# CONFIG_MOUSE_LOGIBM is not set
CONFIG_MOUSE_PC110PAD=y
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
CONFIG_MOUSE_SYNAPTICS_USB=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=y
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_JOYSTICK_XPAD=y
# CONFIG_JOYSTICK_XPAD_FF is not set
# CONFIG_JOYSTICK_XPAD_LEDS is not set
CONFIG_JOYSTICK_WALKERA0701=y
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
CONFIG_JOYSTICK_PXRC=y
CONFIG_JOYSTICK_FSIA6B=m
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_HANWANG=m
CONFIG_TABLET_USB_KBTAB=y
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=m
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
# CONFIG_HYPERV_KEYBOARD is not set
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=m
# CONFIG_HW_RANDOM is not set
# CONFIG_DTLK is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y
CONFIG_NVRAM=m
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=m
CONFIG_TCG_TIS_CORE=m
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_SPI_CR50=y
CONFIG_TCG_TIS_I2C_CR50=m
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=m
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=m
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_PXA=m
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_PCA_ISA=m
CONFIG_I2C_CROS_EC_TUNNEL=m
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=m
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
CONFIG_I2C_SLAVE_TESTUNIT=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
CONFIG_CDNS_I3C_MASTER=m
CONFIG_DW_I3C_MASTER=m
CONFIG_SVC_I3C_MASTER=m
# CONFIG_MIPI_I3C_HCI is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
CONFIG_SPI_DESIGNWARE=m
CONFIG_SPI_DW_DMA=y
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_FSI=m
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_LM70_LLP=m
CONFIG_SPI_FSL_LIB=m
CONFIG_SPI_FSL_SPI=m
CONFIG_SPI_LANTIQ_SSC=m
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=m
CONFIG_SPI_SC18IS602=m
CONFIG_SPI_SIFIVE=y
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
CONFIG_SPI_AMD=m

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=m
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AXP209 is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08_SPI=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=m
CONFIG_PINCTRL_RK805=m
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=m
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=m
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=m
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_ELKHARTLAKE=m
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LAKEFIELD=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HLWD=m
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LOGICVC=m
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SYSCON=m
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=m
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=m
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=m
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCA9570=m
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_MAX77650=m
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=m
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m
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
# CONFIG_GPIO_MOCKUP is not set
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=y
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=m
CONFIG_TEST_POWER=y
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=m
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_OLPC=m
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
# CONFIG_BATTERY_BQ27XXX_I2C is not set
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_AXP288_CHARGER is not set
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_LTC4162L=m
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77650=m
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=m
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_BATTERY_GAUGE_LTC2941=m
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_CROS_USBPD=m
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD99954=m
CONFIG_CHARGER_WILCO=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=m
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_AMD_ENERGY=m
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_CORSAIR_PSU=y
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GSC=m
CONFIG_SENSORS_MC13783_ADC=m
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX127=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_MR75203=m
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_INSPUR_IPSPS=m
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_IRPS5401=m
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_MP2975=m
CONFIG_SENSORS_PM6764TR=m
CONFIG_SENSORS_PXE1610=m
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_TPS40422=m
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE122=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SBTSI=m
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_CPU_THERMAL=y
CONFIG_CPU_FREQ_THERMAL=y
# CONFIG_CPU_IDLE_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_THERMAL_MMIO is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_TI_SOC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=m
CONFIG_GPIO_WATCHDOG=y
CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_MENZ069_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=m
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
CONFIG_SC1200_WDT=m
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_RDC321X_WDT is not set
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
# CONFIG_SBC7240_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=m

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
CONFIG_MIXCOMWD=m
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_ATMEL_FLEXCOM=m
CONFIG_MFD_ATMEL_HLCDC=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC_DEV=y
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_GATEWORKS_GSC=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_BXTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
CONFIG_INTEL_SOC_PMIC_MRFLD=m
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_INTEL_PMC_BXT=m
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77650=m
CONFIG_MFD_MAX77686=m
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=m
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=m
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_RETU=m
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_RK808=m
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_ABX500_CORE=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
# CONFIG_MFD_TI_LMU is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=m
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_STMFX=m
# CONFIG_MFD_WCD934X is not set
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_INTEL_M10_BMC=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_ACT8945A=m
CONFIG_REGULATOR_AD5398=m
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BD9571MWV=m
# CONFIG_REGULATOR_CPCAP is not set
# CONFIG_REGULATOR_CROS_EC is not set
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=m
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LTC3589=m
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=m
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX8973=m
CONFIG_REGULATOR_MAX77686=m
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MP5416=m
CONFIG_REGULATOR_MP8859=m
CONFIG_REGULATOR_MP886X=m
CONFIG_REGULATOR_MPQ7920=m
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6315 is not set
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6358=m
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PF8X00=m
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_QCOM_USB_VBUS=m
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=m
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_RT4801=m
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_SY8827N=m
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=m
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65132=m
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_VCTRL=m
CONFIG_REGULATOR_WM8994=m
CONFIG_REGULATOR_QCOM_LABIBB=m
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=m
CONFIG_CEC_NOTIFIER=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=m
CONFIG_CEC_CROS_EC=m
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DBI=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
CONFIG_DRM_VKMS=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=m
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_RCAR_DW_HDMI=m
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ABT_Y030XX067A=m
CONFIG_DRM_PANEL_ARM_VERSATILE=m
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=m
CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
CONFIG_DRM_PANEL_DSI_CM=m
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=m
CONFIG_DRM_PANEL_ELIDA_KD35T133=m
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_KHADAS_TS050=m
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=m
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
CONFIG_DRM_PANEL_LG_LB035Q02=m
CONFIG_DRM_PANEL_LG_LG4573=m
CONFIG_DRM_PANEL_NEC_NL8048HL11=m
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
CONFIG_DRM_PANEL_NOVATEK_NT36672A=m
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
CONFIG_DRM_PANEL_RONBO_RB070D30=m
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI=m
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=m
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
CONFIG_DRM_PANEL_SITRONIX_ST7703=m
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
# CONFIG_DRM_PANEL_SONY_ACX424AKP is not set
CONFIG_DRM_PANEL_SONY_ACX565AKM=m
CONFIG_DRM_PANEL_TDO_TL070WSH30=m
CONFIG_DRM_PANEL_TPO_TD028TTEC1=m
# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
CONFIG_DRM_PANEL_VISIONOX_RM69299=m
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=m
CONFIG_DRM_CHRONTEL_CH7033=m
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
CONFIG_DRM_LONTIUM_LT9611=m
CONFIG_DRM_LONTIUM_LT9611UXC=m
CONFIG_DRM_LVDS_CODEC=m
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
CONFIG_DRM_NWL_MIPI_DSI=m
CONFIG_DRM_NXP_PTN3460=m
CONFIG_DRM_PARADE_PS8622=m
# CONFIG_DRM_PARADE_PS8640 is not set
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
# CONFIG_DRM_SIMPLE_BRIDGE is not set
CONFIG_DRM_THINE_THC63LVD1024=m
# CONFIG_DRM_TOSHIBA_TC358762 is not set
CONFIG_DRM_TOSHIBA_TC358764=m
CONFIG_DRM_TOSHIBA_TC358767=m
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TOSHIBA_TC358775=m
CONFIG_DRM_TI_TFP410=m
CONFIG_DRM_TI_SN65DSI86=m
# CONFIG_DRM_TI_TPD12S015 is not set
CONFIG_DRM_ANALOGIX_ANX6345=m
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# CONFIG_DRM_ANALOGIX_ANX7625 is not set
CONFIG_DRM_I2C_ADV7511=m
# CONFIG_DRM_I2C_ADV7511_CEC is not set
CONFIG_DRM_CDNS_MHDP8546=m
CONFIG_DRM_DW_HDMI=m
# CONFIG_DRM_DW_HDMI_AHB_AUDIO is not set
CONFIG_DRM_DW_HDMI_CEC=m
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_ARCPGU=m
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=m
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_GM12U320=m
CONFIG_TINYDRM_HX8357D=m
CONFIG_TINYDRM_ILI9225=m
CONFIG_TINYDRM_ILI9341=m
CONFIG_TINYDRM_ILI9486=m
# CONFIG_TINYDRM_MI0283QT is not set
CONFIG_TINYDRM_REPAPER=m
CONFIG_TINYDRM_ST7586=m
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
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
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
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
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=y
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=m
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=m
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=y
# CONFIG_LCD_LMS501KF03 is not set
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_APPLE=m
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_HRTIMER=m
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=m
# CONFIG_SND_VIRMIDI is not set
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=m
# CONFIG_SND_ISA is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=2048
# CONFIG_SND_SPI is not set
# CONFIG_SND_USB is not set
# CONFIG_SND_FIREWIRE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=m
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=m
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=m
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_VIVALDI=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=m
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=y
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
# CONFIG_USB_HID is not set
CONFIG_HID_PID=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
CONFIG_USB_MOUSE=y
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=m
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

CONFIG_I2C_HID_CORE=m
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=m
CONFIG_USB_CONN_GPIO=m
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
CONFIG_USB_OTG_PRODUCTLIST=y
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=m
CONFIG_USB_EHCI_FSL=m
CONFIG_USB_EHCI_HCD_PLATFORM=m
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
# CONFIG_USB_SL811_HCD_ISO is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USBIP_CORE=y
CONFIG_USBIP_VHCI_HCD=m
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
CONFIG_USBIP_HOST=m
# CONFIG_USBIP_VUDC is not set
CONFIG_USBIP_DEBUG=y
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS3=y
CONFIG_USB_CDNS3_GADGET=y
# CONFIG_USB_CDNS3_HOST is not set
CONFIG_USB_CDNS3_PCI_WRAP=y
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
# CONFIG_USB_DWC2_DUAL_ROLE is not set
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
CONFIG_USB_CHIPIDEA=m
# CONFIG_USB_CHIPIDEA_UDC is not set
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_MSM=m
CONFIG_USB_CHIPIDEA_IMX=m
# CONFIG_USB_CHIPIDEA_GENERIC is not set
CONFIG_USB_CHIPIDEA_TEGRA=m
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=y
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=y
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=m
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=y
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=y
CONFIG_USB_FOTG210_UDC=m
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=m
CONFIG_USB_SNP_UDC_PLAT=m
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=m
CONFIG_USB_MAX3420_UDC=m
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MIDI=m
CONFIG_USB_F_PRINTER=m
# CONFIG_USB_CONFIGFS is not set

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=m
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_G_SERIAL is not set
CONFIG_USB_MIDI_GADGET=m
CONFIG_USB_G_PRINTER=m
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
CONFIG_USB_RAW_GADGET=m
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_HD3SS3220 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=m
# CONFIG_TYPEC_MUX_INTEL_PMC is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
# CONFIG_TYPEC_NVIDIA_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=m
# CONFIG_MMC_SDHCI_OF_ASPEED is not set
CONFIG_MMC_SDHCI_OF_AT91=y
CONFIG_MMC_SDHCI_OF_DWCMSHC=m
CONFIG_MMC_SDHCI_CADENCE=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_SDHCI_MILBEAUT=m
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SPI=m
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=m
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MMC_SDHCI_OMAP=m
CONFIG_MMC_SDHCI_AM654=y
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_AW2013=m
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CPCAP is not set
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_EL15203000=y
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m
CONFIG_LEDS_SPI_BYTE=m
CONFIG_LEDS_TI_LMU_COMMON=m
CONFIG_LEDS_LM3697=m
CONFIG_LEDS_TPS6105X=m

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# LED Blink
#
# CONFIG_LEDS_BLINK is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_HT16K33=m
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
# CONFIG_UIO is not set
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO=y
# CONFIG_VFIO_NOIOMMU is not set
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VDPA=y
CONFIG_VDPA_SIM=m
CONFIG_VDPA_SIM_NET=m
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_RING=m
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
# CONFIG_HYPERV_UTILS is not set
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
CONFIG_GREYBUS_ES2=m
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
CONFIG_ACERHDF=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_AMD_PMC is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_ASUS_WIRELESS=y
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_AMILO_RFKILL is not set
CONFIG_FUJITSU_LAPTOP=y
# CONFIG_FUJITSU_TABLET is not set
CONFIG_GPD_POCKET_FAN=m
# CONFIG_HP_ACCEL is not set
CONFIG_HP_WIRELESS=y
# CONFIG_IBM_RTL is not set
# CONFIG_IDEAPAD_LAPTOP is not set
CONFIG_SENSORS_HDAPS=y
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_ALSA_SUPPORT is not set
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
# CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set
CONFIG_INTEL_CHT_INT33FE=m
# CONFIG_INTEL_HID_EVENT is not set
CONFIG_INTEL_INT0002_VGPIO=y
CONFIG_INTEL_MENLOW=m
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_MSI_LAPTOP is not set
CONFIG_XO15_EBOOK=y
# CONFIG_XO1_RFKILL is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_TOSHIBA_HAPS=y
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
# CONFIG_SONYPI_COMPAT is not set
CONFIG_SYSTEM76_ACPI=y
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_RST is not set
CONFIG_INTEL_SMARTCONNECT=m
# CONFIG_INTEL_CHTDC_TI_PWRBTN is not set
# CONFIG_INTEL_MRFLD_PWRBTN is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
# CONFIG_INTEL_SCU_PCI is not set
CONFIG_INTEL_SCU_PLATFORM=m
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=m
CONFIG_CROS_EC_RPMSG=y
# CONFIG_CROS_EC_SPI is not set
CONFIG_CROS_EC_LPC=m
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_VBC=y
CONFIG_CROS_EC_DEBUGFS=m
# CONFIG_CROS_EC_SENSORHUB is not set
CONFIG_CROS_EC_SYSFS=y
CONFIG_CROS_EC_TYPEC=m
CONFIG_CROS_USBPD_LOGGER=m
CONFIG_CROS_USBPD_NOTIFY=m
CONFIG_WILCO_EC=m
# CONFIG_WILCO_EC_DEBUGFS is not set
# CONFIG_WILCO_EC_EVENTS is not set
CONFIG_WILCO_EC_TELEMETRY=m
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE_3_POWER_OPREGION=m
# CONFIG_SURFACE_ACPI_NOTIFY is not set
CONFIG_SURFACE_AGGREGATOR_CDEV=m
CONFIG_SURFACE_HOTPLUG=y
CONFIG_SURFACE_PRO3_BUTTON=m
CONFIG_SURFACE_AGGREGATOR=m
# CONFIG_SURFACE_AGGREGATOR_BUS is not set
# CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_RK808=m
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_SI570=m
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CDCE925=m
CONFIG_COMMON_CLK_CS2000_CP=m
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_FIXED_MMIO=y
CONFIG_CLK_LGM_CGU=y
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_MAILBOX_TEST=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_OF_IOMMU=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

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
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
CONFIG_LITEX_SUBREG_SIZE=4
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

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_AXP288=m
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_INTEL_MRFLD=m
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_EXTCON_USBC_TUSB320=m
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_CROS_EC is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_INTEL_LGM is not set
CONFIG_PWM_LP3943=m
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
# end of IRQ chip support

CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=m
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_CADENCE_TORRENT is not set
CONFIG_PHY_CADENCE_DPHY=m
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_MIXEL_MIPI_DPHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=m
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=m
CONFIG_PHY_SAMSUNG_USB2=y
CONFIG_PHY_TUSB1210=m
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=m
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_PROTO_BASIC=m
CONFIG_STM_PROTO_SYS_T=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_MASTER_ASPEED=m
CONFIG_FSI_SCOM=m
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=m
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=m
# CONFIG_FTM_QUADDEC is not set
CONFIG_MICROCHIP_TCB_CAPTURE=m
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=y
CONFIG_MOST_CDEV=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
# CONFIG_JFFS2_ZLIB is not set
CONFIG_JFFS2_LZO=y
# CONFIG_JFFS2_RTIME is not set
CONFIG_JFFS2_RUBIN=y
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
CONFIG_JFFS2_CMODE_SIZE=y
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
CONFIG_UBIFS_FS=m
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
# CONFIG_UBIFS_FS_XATTR is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=m
# CONFIG_CRAMFS_MTD is not set
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_MTD=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=m
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=m
CONFIG_PSTORE_LZO_COMPRESS=m
CONFIG_PSTORE_LZ4_COMPRESS=m
CONFIG_PSTORE_LZ4HC_COMPRESS=m
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_FTRACE=y
# CONFIG_PSTORE_RAM is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=m
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=m
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=m
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=m
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

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
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=y
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_ECRDSA=m
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=m
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=m
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_SHA1 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
# CONFIG_CRC64 is not set
CONFIG_CRC4=y
CONFIG_CRC7=m
# CONFIG_LIBCRC32C is not set
CONFIG_CRC8=m
CONFIG_XXHASH=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_DMA_CMA=y
CONFIG_DMA_PERNUMA_CMA=y

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
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_STRING_SELFTEST=y
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
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
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
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_HARDLOCKUP_DETECTOR is not set
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
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
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
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

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
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
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
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_KPROBE_EVENTS_ON_NOTRACE=y
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
CONFIG_TRACEPOINT_BENCHMARK=y
# CONFIG_RING_BUFFER_BENCHMARK is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
CONFIG_KPROBE_EVENT_GEN_TEST=m
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_SAMPLES=y
CONFIG_SAMPLE_AUXDISPLAY=y
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
CONFIG_SAMPLE_TRACE_ARRAY=m
# CONFIG_SAMPLE_KOBJECT is not set
CONFIG_SAMPLE_KPROBES=m
CONFIG_SAMPLE_KRETPROBES=m
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
CONFIG_SAMPLE_KFIFO=m
CONFIG_SAMPLE_RPMSG_CLIENT=m
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_CONNECTOR is not set
CONFIG_SAMPLE_HIDRAW=y
CONFIG_SAMPLE_PIDFD=y
CONFIG_SAMPLE_SECCOMP=y
# CONFIG_SAMPLE_TIMER is not set
CONFIG_SAMPLE_UHID=y
CONFIG_SAMPLE_VFIO_MDEV_MTTY=m
CONFIG_SAMPLE_VFIO_MDEV_MDPY=m
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
CONFIG_SAMPLE_VFIO_MDEV_MBOCHS=m
CONFIG_SAMPLE_ANDROID_BINDERFS=y
CONFIG_SAMPLE_VFS=y
# CONFIG_SAMPLE_WATCHDOG is not set
# CONFIG_SAMPLE_WATCH_QUEUE is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

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
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=m
# CONFIG_KUNIT_EXAMPLE_TEST is not set
# CONFIG_KUNIT_ALL_TESTS is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
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
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_BITFIELD_KUNIT=m
CONFIG_RESOURCE_KUNIT_TEST=m
CONFIG_SYSCTL_KUNIT_TEST=m
# CONFIG_LIST_KUNIT_TEST is not set
CONFIG_LINEAR_RANGES_TEST=y
# CONFIG_CMDLINE_KUNIT_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_MEMTEST is not set
CONFIG_HYPERV_TESTING=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export job_origin='trinity-vm.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-i386-159'
	export tbox_group='vm-snb-i386'
	export branch='linus/master'
	export commit='1a1c130ab7575498eed5bcf7220037ae09cd1f8a'
	export kconfig='i386-randconfig-a005-20210405'
	export repeat_to=6
	export nr_vm=160
	export submit_id='606b1b890294534995b8568e'
	export job_file='/lkp/jobs/scheduled/vm-snb-i386-159/trinity-group-00-99999-debian-i386-20191205.cgz-1a1c130ab7575498eed5bcf7220037ae09cd1f8a-20210405-18837-x8f8ax-5.yaml'
	export id='52e954aa0e4be84f76ea45f7cfcb8ee1dd31fffa'
	export queuer_version='/lkp-src'
	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export ssh_base_port=23400
	export kernel_cmdline='vmalloc=512M'
	export rootfs='debian-i386-20191205.cgz'
	export compiler='gcc-9'
	export enqueue_time='2021-04-05 22:15:38 +0800'
	export _id='606b1b8d0294534995b85690'
	export _rt='/result/trinity/group-00-99999/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a005-20210405/gcc-9/1a1c130ab7575498eed5bcf7220037ae09cd1f8a'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/group-00-99999/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a005-20210405/gcc-9/1a1c130ab7575498eed5bcf7220037ae09cd1f8a/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='i386'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-i386-20191205.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-i386-159/trinity-group-00-99999-debian-i386-20191205.cgz-1a1c130ab7575498eed5bcf7220037ae09cd1f8a-20210405-18837-x8f8ax-5.yaml
ARCH=i386
kconfig=i386-randconfig-a005-20210405
branch=linus/master
commit=1a1c130ab7575498eed5bcf7220037ae09cd1f8a
BOOT_IMAGE=/pkg/linux/i386-randconfig-a005-20210405/gcc-9/1a1c130ab7575498eed5bcf7220037ae09cd1f8a/vmlinuz-5.12.0-rc5-00001-g1a1c130ab757
vmalloc=512M
max_uptime=2100
RESULT_ROOT=/result/trinity/group-00-99999/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a005-20210405/gcc-9/1a1c130ab7575498eed5bcf7220037ae09cd1f8a/3
LKP_SERVER=internal-lkp-server
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
	export modules_initrd='/pkg/linux/i386-randconfig-a005-20210405/gcc-9/1a1c130ab7575498eed5bcf7220037ae09cd1f8a/modules.cgz'
	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz,/osimage/pkg/debian-i386-20191205.cgz/trinity-i386-4d2343bd-1_20200320.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='d9dbe7c8ccbe'
	export queue_at_least_once=1
	export kernel='/pkg/linux/i386-randconfig-a005-20210405/gcc-9/1a1c130ab7575498eed5bcf7220037ae09cd1f8a/vmlinuz-5.12.0-rc5-00001-g1a1c130ab757'
	export dequeue_time='2021-04-05 22:15:56 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-159/trinity-group-00-99999-debian-i386-20191205.cgz-1a1c130ab7575498eed5bcf7220037ae09cd1f8a-20210405-18837-x8f8ax-5.cgz'

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

	run_test number=99999 group='group-00' $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--rwEMma7ioTxnRzrJ
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
Z/sCAAAAAARZWg==

--rwEMma7ioTxnRzrJ--
