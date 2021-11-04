Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE0744556F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKDOlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:41:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:44930 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDOlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:41:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="292549518"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="xz'?scan'208";a="292549518"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 07:38:22 -0700
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="xz'?scan'208";a="489980244"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 07:38:13 -0700
Date:   Thu, 4 Nov 2021 22:38:09 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     lkp@lists.01.org, lkp@intel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        ppandit@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [mm/page_alloc]  5541e53659: BUG:spinlock_bad_magic_on_CPU
Message-ID: <20211104143809.GB6499@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20211103170512.2745765-3-nsaenzju@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 5541e5365954069e4c7b649831c0e41bc9e5e081 ("[PATCH v2 2/3] mm/page_alloc: Convert per-cpu lists' local locks to per-cpu spin locks")
url: https://github.com/0day-ci/linux/commits/Nicolas-Saenz-Julienne/mm-page_alloc-Remote-per-cpu-page-list-drain-support/20211104-010825
base: https://github.com/hnaz/linux-mm master
patch link: https://lore.kernel.org/lkml/20211103170512.2745765-3-nsaenzju@redhat.com

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+--------------------------------------------+------------+------------+
|                                            | 69c421f2b4 | 5541e53659 |
+--------------------------------------------+------------+------------+
| boot_successes                             | 11         | 0          |
| boot_failures                              | 0          | 11         |
| BUG:spinlock_bad_magic_on_CPU              | 0          | 11         |
| BUG:using_smp_processor_id()in_preemptible | 0          | 11         |
+--------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[    0.161872][    T0] BUG: spinlock bad magic on CPU#0, swapper/0
[    0.162248][    T0]  lock: 0xeb24bef0, .magic: 00000000, .owner: swapper/0, .owner_cpu: 0
[    0.162767][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc7-mm1-00437-g5541e5365954 #1
[    0.163325][    T0] Call Trace:
[ 0.163524][ T0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 0.163802][ T0] dump_stack (lib/dump_stack.c:114) 
[ 0.164050][ T0] spin_bug (kernel/locking/spinlock_debug.c:70 kernel/locking/spinlock_debug.c:77) 
[ 0.164296][ T0] do_raw_spin_unlock (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/asm-generic/qspinlock.h:28 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140) 
[ 0.164624][ T0] _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:194) 
[ 0.164971][ T0] free_unref_page (include/linux/spinlock.h:423 mm/page_alloc.c:3400) 
[ 0.165253][ T0] free_the_page (mm/page_alloc.c:699) 
[ 0.165521][ T0] __free_pages (mm/page_alloc.c:5453) 
[ 0.165785][ T0] add_highpages_with_active_regions (include/linux/mm.h:2511 arch/x86/mm/init_32.c:416) 
[ 0.166179][ T0] set_highmem_pages_init (arch/x86/mm/highmem_32.c:30) 
[ 0.166501][ T0] mem_init (arch/x86/mm/init_32.c:749 (discriminator 2)) 
[ 0.166749][ T0] start_kernel (init/main.c:842 init/main.c:988) 
[ 0.167026][ T0] ? early_idt_handler_common (arch/x86/kernel/head_32.S:417) 
[ 0.167369][ T0] i386_start_kernel (arch/x86/kernel/head32.c:57) 
[ 0.167662][ T0] startup_32_smp (arch/x86/kernel/head_32.S:328) 
[    1.272601][    T0] Initializing Movable for node 0 (00000000:00000000)
[    1.563704][    T0] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    1.564312][    T0] Memory: 2895940K/3145208K available (8028K kernel code, 4874K rwdata, 4088K rodata, 2016K init, 8452K bss, 249268K reserved, 0K cma-reserved, 2252680K highmem)
[ 1.565333][ T0] random: get_random_u32 called from __kmem_cache_create+0x13/0x3b8 with crng_init=0 
[    1.565532][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    1.566585][    T0] Stack Depot allocating hash table with kvmalloc
[    1.567566][    T0] Node 0, zone      DMA: page owner found early allocated 0 pages
[    1.569258][    T0] Node 0, zone   Normal: page owner found early allocated 1057 pages
[    1.574666][    T0] Node 0, zone  HighMem: page owner found early allocated 0 pages
[    1.575421][    T0] ODEBUG: selftest passed
[    1.575737][    T0] trace event string verifier disabled
[    1.576126][    T0] Dynamic Preempt: none
[    1.576450][    T0] Running RCU self tests
[    1.576727][    T0] rcu: Preemptible hierarchical RCU implementation.
[    1.577149][    T0] rcu: 	RCU event tracing is enabled.
[    1.577483][    T0] rcu: 	RCU lockdep checking is enabled.
[    1.577833][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
[    1.578294][    T0] rcu: 	RCU callback double-/use-after-free debug enabled.
[    1.578744][    T0] rcu: 	RCU debug extended QS entry/exit.
[    1.579100][    T0] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
[    1.579611][    T0] 	Trampoline variant of Tasks RCU enabled.
[    1.579978][    T0] 	Rude variant of Tasks RCU enabled.
[    1.580311][    T0] 	Tracing variant of Tasks RCU enabled.
[    1.580666][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    1.581199][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    1.583788][    T0] NR_IRQS: 2304, nr_irqs: 56, preallocated irqs: 16
[    1.584542][    T0] kfence: initialized - using 2097152 bytes for 255 objects at 0x(ptrval)-0x(ptrval)
[    1.585258][    T0] printk: console [ttyS0] enabled
[    1.585891][    T0] printk: bootconsole [earlyser0] disabled
[    1.586621][    T0] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    1.587173][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    1.587491][    T0] ... MAX_LOCK_DEPTH:          48
[    1.587814][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    1.588146][    T0] ... CLASSHASH_SIZE:          4096
[    1.588477][    T0] ... MAX_LOCKDEP_ENTRIES:     32768
[    1.588821][    T0] ... MAX_LOCKDEP_CHAINS:      65536
[    1.589167][    T0] ... CHAINHASH_SIZE:          32768
[    1.589504][    T0]  memory used by lock dependency info: 4061 kB
[    1.589904][    T0]  memory used for stack traces: 2112 kB
[    1.590264][    T0]  per task-struct memory footprint: 2112 bytes
[    1.590671][    T0] ACPI: Core revision 20210930
[    1.591135][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    1.591886][    T0] APIC: Switch to symmetric I/O mode setup
[    1.592284][    T0] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    1.592710][    T0] masked ExtINT on CPU#0
[    1.593593][    T0] ENABLING IO-APIC IRQs
[    1.593859][    T0] init IO_APIC IRQs
[    1.594227][    T0]  apic 0 pin 0 not connected
[    1.594688][    T0] IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 ActiveLow:0)
[    1.595534][    T0] IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 0 Level:0 ActiveLow:0)
[    1.596221][    T0] IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3 Level:0 ActiveLow:0)
[    1.596774][    T0] IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4 Level:0 ActiveLow:0)
[    1.597320][    T0] IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5 Level:1 ActiveLow:0)
[    1.597865][    T0] IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6 Level:0 ActiveLow:0)
[    1.598409][    T0] IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7 Level:0 ActiveLow:0)
[    1.598954][    T0] IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8 Level:0 ActiveLow:0)
[    1.599498][    T0] IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9 Level:1 ActiveLow:0)
[    1.600052][    T0] IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ 10 Level:1 ActiveLow:0)
[    1.600618][    T0] IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ 11 Level:1 ActiveLow:0)
[    1.601195][    T0] IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ 12 Level:0 ActiveLow:0)
[    1.601760][    T0] IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ 13 Level:0 ActiveLow:0)
[    1.602312][    T0] IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ 14 Level:0 ActiveLow:0)
[    1.602865][    T0] IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ 15 Level:0 ActiveLow:0)
[    1.603415][    T0]  apic 0 pin 16 not connected
[    1.603712][    T0]  apic 0 pin 17 not connected
[    1.604020][    T0]  apic 0 pin 18 not connected
[    1.604316][    T0]  apic 0 pin 19 not connected
[    1.604617][    T0]  apic 0 pin 20 not connected
[    1.604922][    T0]  apic 0 pin 21 not connected
[    1.605219][    T0]  apic 0 pin 22 not connected
[    1.605516][    T0]  apic 0 pin 23 not connected
[    1.605913][    T0] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.606361][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fa3704c1a9, max_idle_ns: 440795296692 ns
[    1.607077][    T0] Calibrating delay loop (skipped) preset value.. 4389.83 BogoMIPS (lpj=8779664)
[    1.607658][    T0] pid_max: default: 4096 minimum: 301
[    1.611130][    T0] LSM: Security Framework initializing
[    1.611497][    T0] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    1.613263][    T0] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    1.615945][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    1.616341][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    1.616763][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.617348][    T0] Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
[    1.617350][    T0] Speculative Store Bypass: Vulnerable
[    1.618335][    T0] L1TF: Kernel not compiled for PAE. No mitigation for L1TF
[    1.618788][    T0] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.619423][    T0] Freeing SMP alternatives memory: 16K
[    1.619943][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)


To reproduce:

        # build kernel
	cd linux
	cp config-5.15.0-rc7-mm1-00437-g5541e5365954 .config
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.15.0-rc7-mm1-00437-g5541e5365954"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.15.0-rc7-mm1 Kernel Configuration
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
# CONFIG_WERROR is not set
CONFIG_UAPI_HEADER_TEST=y
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
# CONFIG_POSIX_MQUEUE is not set
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
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
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
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BEHAVIOUR=y
# CONFIG_PREEMPT_VOLUNTARY_BEHAVIOUR is not set
# CONFIG_PREEMPT_BEHAVIOUR is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
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
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
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
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_KCMP is not set
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_SLUB_DEBUG is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_SLUB_CPU_PARTIAL is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
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
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=512
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
CONFIG_M586=y
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
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
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_F00F_BUG=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
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
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

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
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=y
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
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

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_SCx200=m
# CONFIG_SCx200HR_TIMER is not set
# CONFIG_OLPC is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
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
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
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
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
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
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
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
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
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
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
# CONFIG_ACORN_PARTITION_ICS is not set
# CONFIG_ACORN_PARTITION_ADFS is not set
CONFIG_ACORN_PARTITION_POWERTEC=y
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=m
CONFIG_MQ_IOSCHED_KYBER=m
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

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
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_ZSWAP is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=m
# CONFIG_Z3FOLD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
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
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
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
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_CACHE is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=m
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=m
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=y
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_OTP=y
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SCx200_DOCFLASH is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLOCK2MTD is not set

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
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=y
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
# CONFIG_MTD_NAND_ARASAN is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=m
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=y
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_FC=y
# CONFIG_NVME_TARGET_FCLOOP is not set
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=m
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_EEPROM_EE1004 is not set
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
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
CONFIG_ECHO=m
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=m
# CONFIG_HABANA_AI is not set
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_BLK_DEV_BSG is not set
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
# CONFIG_ATA_FORCE is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
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
CONFIG_NET_VENDOR_ASIX=y
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
# CONFIG_CS89x0_ISA is not set
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
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
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
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
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
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_USB_NET_DRIVERS=m
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
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

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
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
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

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
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
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
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_RPMSG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_BA431=m
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_XIPHERA=m
CONFIG_DTLK=m
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
# CONFIG_DEVMEM is not set
# CONFIG_NVRAM is not set
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_I2C_CR50=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS_CLASS=m
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=m
# CONFIG_RANDOM_TRUST_CPU is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=m
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
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=m
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_CP2615=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
# CONFIG_CDNS_I3C_MASTER is not set
CONFIG_DW_I3C_MASTER=m
CONFIG_SVC_I3C_MASTER=m
# CONFIG_MIPI_I3C_HCI is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_MCP23S08 is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_PINCTRL_CS47L92=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_SIOX=m
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_IT87=m
CONFIG_GPIO_SCH311X=m
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TQMX86=m
# CONFIG_GPIO_WM8994 is not set
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
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=m
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2430 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
CONFIG_BATTERY_CW2015=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=m
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_CHARGER_DA9150=m
# CONFIG_BATTERY_DA9150 is not set
CONFIG_AXP20X_POWER=m
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_MP2629=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=m
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_CROS_PCHG=m
CONFIG_CHARGER_BD99954=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=m
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX127=m
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_TPS23861=m
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1266=m
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_BEL_PFE=m
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_DPS920AB=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
# CONFIG_SENSORS_IR36021 is not set
CONFIG_SENSORS_IR38064=m
CONFIG_SENSORS_IRPS5401=m
CONFIG_SENSORS_ISL68137=m
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX15301=m
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
CONFIG_SENSORS_MP2975=m
CONFIG_SENSORS_PIM4328=m
CONFIG_SENSORS_PM6764TR=m
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_Q54SJ108A2=m
CONFIG_SENSORS_STPDDC60=m
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
# CONFIG_SENSORS_UCD9000 is not set
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE122=m
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_SBTSI=m
CONFIG_SENSORS_SBRMI=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=m
# CONFIG_INTEL_MENLOW is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC_DEV=m
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
CONFIG_MFD_CS47L92=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=m
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=m
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=m
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=m
CONFIG_MFD_RT5033=m
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=m
CONFIG_MFD_TI_LMU=m
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8994=m
CONFIG_MFD_WCD934X=y
# CONFIG_MFD_ATC260X_I2C is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA9210=m
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=m
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MP8859=m
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6315=y
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=m
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RT4831=m
CONFIG_REGULATOR_RT5033=m
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=m
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=m
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_WM8994=m
# CONFIG_REGULATOR_QCOM_LABIBB is not set
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=m
# CONFIG_CEC_CROS_EC is not set
CONFIG_CEC_GPIO=y
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
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
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=y
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
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=m
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
# CONFIG_BACKLIGHT_RT4831 is not set
CONFIG_BACKLIGHT_SAHARA=m
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GOOGLE_HAMMER is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PLAYSTATION is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=m
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_FEW_INIT_RETRIES=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=m
CONFIG_USB_XHCI_PCI_RENESAS=m
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=m
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=m
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_BCMA=m
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=m
CONFIG_USB_CDNS3=m
# CONFIG_USB_CDNS3_GADGET is not set
# CONFIG_USB_CDNS3_HOST is not set
CONFIG_USB_CDNS3_PCI_WRAP=m
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_GADGET is not set
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_ULPI is not set
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_HAPS=m
CONFIG_USB_DWC2=m
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
# CONFIG_USB_DWC2_DUAL_ROLE is not set
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_APPLE_MFI_FASTCHARGE=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=m
CONFIG_USB_ISP1301=m
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FUSB300 is not set
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
CONFIG_USB_M66592=m
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_DUMMY_HCD=m
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
CONFIG_USB_CONFIGFS_F_HID=y
CONFIG_USB_CONFIGFS_F_PRINTER=y

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=m
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=m
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_G_SERIAL is not set
CONFIG_USB_G_PRINTER=m
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=m
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
CONFIG_TYPEC_RT1711H=m
CONFIG_TYPEC_TCPCI_MAXIM=m
# CONFIG_TYPEC_FUSB302 is not set
# CONFIG_TYPEC_UCSI is not set
CONFIG_TYPEC_TPS6598X=m
# CONFIG_TYPEC_HD3SS3220 is not set
CONFIG_TYPEC_STUSB160X=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=m
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=m
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=m
# CONFIG_MMC_USHC is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_NET48XX is not set
CONFIG_LEDS_WRAP=m
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=m
CONFIG_LEDS_MENF21BMC=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_PCH_DMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=m
# CONFIG_HD44780 is not set
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
CONFIG_LCD2S=m
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=m
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
CONFIG_GREYBUS_ES2=m
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
CONFIG_COMEDI_TEST=m
# CONFIG_COMEDI_PARPORT is not set
CONFIG_COMEDI_SSV_DNP=m
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=m
CONFIG_COMEDI_PCL724=m
# CONFIG_COMEDI_PCL726 is not set
# CONFIG_COMEDI_PCL730 is not set
CONFIG_COMEDI_PCL812=m
# CONFIG_COMEDI_PCL816 is not set
CONFIG_COMEDI_PCL818=m
CONFIG_COMEDI_PCM3724=m
CONFIG_COMEDI_AMPLC_DIO200_ISA=m
CONFIG_COMEDI_AMPLC_PC236_ISA=m
CONFIG_COMEDI_AMPLC_PC263_ISA=m
CONFIG_COMEDI_RTI800=m
# CONFIG_COMEDI_RTI802 is not set
CONFIG_COMEDI_DAC02=m
# CONFIG_COMEDI_DAS16M1 is not set
# CONFIG_COMEDI_DAS08_ISA is not set
CONFIG_COMEDI_DAS16=m
CONFIG_COMEDI_DAS800=m
CONFIG_COMEDI_DAS1800=m
# CONFIG_COMEDI_DAS6402 is not set
# CONFIG_COMEDI_DT2801 is not set
CONFIG_COMEDI_DT2811=m
# CONFIG_COMEDI_DT2814 is not set
# CONFIG_COMEDI_DT2815 is not set
CONFIG_COMEDI_DT2817=m
CONFIG_COMEDI_DT282X=m
CONFIG_COMEDI_DMM32AT=m
CONFIG_COMEDI_FL512=m
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=m
# CONFIG_COMEDI_II_PCI20KC is not set
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=m
CONFIG_COMEDI_ADQ12B=m
CONFIG_COMEDI_NI_AT_A2150=m
# CONFIG_COMEDI_NI_AT_AO is not set
CONFIG_COMEDI_NI_ATMIO=m
CONFIG_COMEDI_NI_ATMIO16D=m
CONFIG_COMEDI_NI_LABPC_ISA=m
CONFIG_COMEDI_PCMAD=m
CONFIG_COMEDI_PCMDA12=m
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=m
# CONFIG_COMEDI_S526 is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_USB_DRIVERS=m
CONFIG_COMEDI_DT9812=m
CONFIG_COMEDI_NI_USB6501=m
# CONFIG_COMEDI_USBDUX is not set
# CONFIG_COMEDI_USBDUXFAST is not set
CONFIG_COMEDI_USBDUXSIGMA=m
CONFIG_COMEDI_VMK80XX=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_LABPC_ISADMA=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
# CONFIG_ADT7316_I2C is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=m
CONFIG_ADE7854_I2C=m
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
CONFIG_STAGING_MEDIA=y

#
# Android
#
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_GS_FPGABOOT=y
CONFIG_UNISYSSPAR=y
CONFIG_MOST_COMPONENTS=m
# CONFIG_MOST_NET is not set
# CONFIG_MOST_I2C is not set
# CONFIG_KS7010 is not set
CONFIG_GREYBUS_BOOTROM=m
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_POWER=m
# CONFIG_GREYBUS_RAW is not set
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_PWM=m
CONFIG_GREYBUS_SDIO=m
# CONFIG_GREYBUS_UART is not set
CONFIG_GREYBUS_USB=m
CONFIG_FIELDBUS_DEV=y
# CONFIG_QLGE is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_X86_PLATFORM_DRIVERS_INTEL is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=m
CONFIG_CROS_EC_I2C=m
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_DEBUGFS=m
CONFIG_CROS_EC_SENSORHUB=m
# CONFIG_CROS_EC_SYSFS is not set
# CONFIG_CROS_USBPD_NOTIFY is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_MAX9485=m
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_XILINX_VCU=m
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_NS=m
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=m
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

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=m
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_EXTCON_USBC_TUSB320=m
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=m
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
# CONFIG_ADXL355_I2C is not set
CONFIG_ADXL372=m
CONFIG_ADXL372_I2C=m
CONFIG_BMA180=m
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
# CONFIG_DA280 is not set
CONFIG_DA311=m
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=m
CONFIG_FXLS8962AF=m
CONFIG_FXLS8962AF_I2C=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_KXSD9=m
# CONFIG_KXSD9_I2C is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=m
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7291 is not set
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
# CONFIG_AD799X is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=m
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=m
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP3422=m
CONFIG_MP2629_ADC=m
# CONFIG_NAU7802 is not set
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_QCOM_SPMI_ADC5 is not set
CONFIG_TI_ADC081C=m
CONFIG_TI_ADS1015=m
CONFIG_TI_AM335X_ADC=m
CONFIG_VIPERBOARD_ADC=m
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_ATLAS_EZO_SENSOR=m
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_CCS811=m
# CONFIG_IAQCORE is not set
CONFIG_SCD30_CORE=m
CONFIG_SCD30_I2C=m
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=m
# CONFIG_SENSIRION_SGP40 is not set
CONFIG_SPS30=m
CONFIG_SPS30_I2C=m
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=m
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
# CONFIG_IIO_CROS_EC_SENSORS is not set
CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
CONFIG_AD5064=m
# CONFIG_AD5380 is not set
CONFIG_AD5446=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5593R=m
# CONFIG_AD5696_I2C is not set
# CONFIG_CIO_DAC is not set
# CONFIG_DS4424 is not set
CONFIG_M62332=m
CONFIG_MAX517=m
CONFIG_MCP4725=m
# CONFIG_TI_DAC5571 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_BMG160 is not set
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
CONFIG_MAX30100=m
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
CONFIG_HDC100X=m
# CONFIG_HDC2010 is not set
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_FXOS8700_I2C is not set
CONFIG_KMX61=m
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
# CONFIG_ADUX1020 is not set
CONFIG_AL3010=m
# CONFIG_AL3320A is not set
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
CONFIG_AS73211=m
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
CONFIG_CM3232=m
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=m
CONFIG_IQS621_ALS=m
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=m
CONFIG_JSA1212=m
CONFIG_RPR0521=m
# CONFIG_SENSORS_LM3533 is not set
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=m
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=m
CONFIG_NOA1305=m
CONFIG_OPT3001=m
CONFIG_PA12203001=m
CONFIG_SI1133=m
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=m
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=m
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=m
CONFIG_TSL4531=m
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=m
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_MAG3110=m
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
CONFIG_YAMAHA_YAS530=m
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=m
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=m
# CONFIG_AD5272 is not set
CONFIG_DS1803=m
# CONFIG_MAX5432 is not set
CONFIG_MCP4018=m
CONFIG_MCP4531=m
CONFIG_TPL0102=m
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_IIO_CROS_EC_BARO=m
CONFIG_DLHL60D=m
CONFIG_DPS310=m
CONFIG_HP03=m
CONFIG_ICP10100=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL3115=m
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_CROS_EC_MKBP_PROXIMITY=m
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=m
# CONFIG_MB1232 is not set
CONFIG_PING=m
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX9310=m
CONFIG_SX9500=m
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_IQS620AT_TEMP is not set
CONFIG_MLX90614=m
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
CONFIG_TMP117=m
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CROS_EC is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_IQS620A=m
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_USB_LGM_PHY=m
CONFIG_PHY_CAN_TRANSCEIVER=m

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=m
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=m
CONFIG_PHY_QCOM_USB_HS=m
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_TUSB1210=m
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y
CONFIG_NVMEM_RMEM=m

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=m
# CONFIG_FPGA_DFL is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
CONFIG_MOST=m
CONFIG_MOST_USB_HDM=m
CONFIG_MOST_CDEV=m
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_NILFS2_FS=m
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=m
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
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
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=m
CONFIG_ADFS_FS_RW=y
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
CONFIG_BEFS_DEBUG=y
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
# CONFIG_JFFS2_ZLIB is not set
# CONFIG_JFFS2_LZO is not set
# CONFIG_JFFS2_RTIME is not set
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_JFFS2_CMODE_FAVOURLZO=y
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
CONFIG_CRAMFS_MTD=y
# CONFIG_SQUASHFS is not set
CONFIG_VXFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=m
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=m
CONFIG_UFS_FS_WRITE=y
CONFIG_UFS_DEBUG=y
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=m
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_KEY_NOTIFICATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=m
CONFIG_CRYPTO_ECRDSA=m
CONFIG_CRYPTO_SM2=m
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=m
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_STREEBOG=m
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=m
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=y
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM4=m
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
# CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_SBITMAP=y
# end of Library routines

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
# CONFIG_DEBUG_SYNCHRO_TEST is not set
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
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_FRAME_POINTER=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_UNREACHABLE is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

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
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

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
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
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

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
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
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

#
# x86 Debugging
#
# CONFIG_DEBUG_AID_FOR_SYZBOT is not set
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
CONFIG_TEST_DIV64=m
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=m
# CONFIG_TEST_HEXDUMP is not set
CONFIG_STRING_SELFTEST=m
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
CONFIG_TEST_SCANF=y
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
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_STACKINIT=y
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_FREE_PAGES=y
CONFIG_TEST_FPU=y
CONFIG_TEST_CLOCKSOURCE_WATCHDOG=m
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-40'
	export tbox_group='vm-snb'
	export branch='linux-review/Nicolas-Saenz-Julienne/mm-page_alloc-Remote-per-cpu-page-list-drain-support/20211104-010825'
	export commit='5541e5365954069e4c7b649831c0e41bc9e5e081'
	export kconfig='i386-randconfig-a012-20211103'
	export repeat_to=9
	export nr_vm=160
	export submit_id='6183e62f79e5567a5e542cf1'
	export job_file='/lkp/jobs/scheduled/vm-snb-40/boot-1-debian-i386-20191205.cgz-5541e5365954069e4c7b649831c0e41bc9e5e081-20211104-31326-163qzoy-8.yaml'
	export id='9a38499005504504499ae1e50c7525222324cc0a'
	export queuer_version='/lkp-src'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=128M initramfs_async=0 page_owner=on'
	export rootfs='debian-i386-20191205.cgz'
	export compiler='gcc-9'
	export enqueue_time='2021-11-04 21:54:55 +0800'
	export _id='6183e62f79e5567a5e542cf1'
	export _rt='/result/boot/1/vm-snb/debian-i386-20191205.cgz/i386-randconfig-a012-20211103/gcc-9/5541e5365954069e4c7b649831c0e41bc9e5e081'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/debian-i386-20191205.cgz/i386-randconfig-a012-20211103/gcc-9/5541e5365954069e4c7b649831c0e41bc9e5e081/8'
	export scheduler_version='/lkp/lkp/.src-20211104-201404'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/debian/debian-i386-20191205.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-40/boot-1-debian-i386-20191205.cgz-5541e5365954069e4c7b649831c0e41bc9e5e081-20211104-31326-163qzoy-8.yaml
ARCH=i386
kconfig=i386-randconfig-a012-20211103
branch=linux-review/Nicolas-Saenz-Julienne/mm-page_alloc-Remote-per-cpu-page-list-drain-support/20211104-010825
commit=5541e5365954069e4c7b649831c0e41bc9e5e081
BOOT_IMAGE=/pkg/linux/i386-randconfig-a012-20211103/gcc-9/5541e5365954069e4c7b649831c0e41bc9e5e081/vmlinuz-5.15.0-rc7-mm1-00437-g5541e5365954
vmalloc=128M initramfs_async=0 page_owner=on
max_uptime=600
RESULT_ROOT=/result/boot/1/vm-snb/debian-i386-20191205.cgz/i386-randconfig-a012-20211103/gcc-9/5541e5365954069e4c7b649831c0e41bc9e5e081/8
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
	export modules_initrd='/pkg/linux/i386-randconfig-a012-20211103/gcc-9/5541e5365954069e4c7b649831c0e41bc9e5e081/modules.cgz'
	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/i386-randconfig-a012-20211103/gcc-9/5541e5365954069e4c7b649831c0e41bc9e5e081/vmlinuz-5.15.0-rc7-mm1-00437-g5541e5365954'
	export dequeue_time='2021-11-04 21:55:30 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-40/boot-1-debian-i386-20191205.cgz-5541e5365954069e4c7b649831c0e41bc9e5e081-20211104-31326-163qzoy-8.cgz'

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

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--5vNYLRcllDrimb99
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
WVo=

--5vNYLRcllDrimb99--
