Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FB935BA10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhDLGTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:19:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:4097 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhDLGTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:19:00 -0400
IronPort-SDR: GrArjnOmMxFLf3Pg/lkcQUdE9vok79ik7jXToqMthjfJOgGS3o3y/jmd+jILn38t6X8BvGJKmK
 P9NhTphSS3lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="190933870"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="xz'?scan'208";a="190933870"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 23:18:42 -0700
IronPort-SDR: 8jaUlFyKxl8F/4vTNZeGMQw2WGOkwc4inXKrQZqsqySb8abU7WS2Eo3Divg28kNGufbzFTXR+H
 WP50DUwHpbNA==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="xz'?scan'208";a="423657482"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 23:18:38 -0700
Date:   Mon, 12 Apr 2021 14:16:19 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: [rcu]  933ada2c33:
 WARNING:at_kernel/rcu/tree_stall.h:#rcu_check_gp_start_stall
Message-ID: <20210412061619.GA22051@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 933ada2c3310aa88807e65c8d498b74a2159a9a2 ("rcu: IPI all CPUs at GP start for strict GPs")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: trinity
version: trinity-i386-4d2343bd-1_20200320
with following parameters:

	runtime: 300s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[ 2099.508600] WARNING: CPU: 0 PID: 456 at kernel/rcu/tree_stall.h:752 rcu_check_gp_start_stall+0x12f/0x1c0 
[ 2099.509643] Modules linked in: crc32_pclmul crc32c_intel aesni_intel crypto_simd cryptd rapl input_leds serio_raw bochs_drm button
[ 2099.511042] CPU: 0 PID: 456 Comm: time Not tainted 5.9.0-rc1-00008-g933ada2c3310a #1
[ 2099.511831] EIP: rcu_check_gp_start_stall+0x12f/0x1c0 
[ 2099.512430] Code: 42 39 c7 79 55 a1 d8 11 42 42 01 d0 39 c1 78 4a a1 d4 11 42 42 01 c2 39 d1 78 3f b8 01 00 00 00 87 05 64 5a ce 42 85 c0 75 28 <0f> 0b 81 fb c0 04 42 42 74 0a b8 c0 04 42 42 e8 bd 37 ce 00 89 f2
All code
========
   0:	42 39 c7             	rex.X cmp %eax,%edi
   3:	79 55                	jns    0x5a
   5:	a1 d8 11 42 42 01 d0 	movabs 0xc139d001424211d8,%eax
   c:	39 c1 
   e:	78 4a                	js     0x5a
  10:	a1 d4 11 42 42 01 c2 	movabs 0xd139c201424211d4,%eax
  17:	39 d1 
  19:	78 3f                	js     0x5a
  1b:	b8 01 00 00 00       	mov    $0x1,%eax
  20:	87 05 64 5a ce 42    	xchg   %eax,0x42ce5a64(%rip)        # 0x42ce5a8a
  26:	85 c0                	test   %eax,%eax
  28:	75 28                	jne    0x52
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	81 fb c0 04 42 42    	cmp    $0x424204c0,%ebx
  32:	74 0a                	je     0x3e
  34:	b8 c0 04 42 42       	mov    $0x424204c0,%eax
  39:	e8 bd 37 ce 00       	callq  0xce37fb
  3e:	89 f2                	mov    %esi,%edx

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	81 fb c0 04 42 42    	cmp    $0x424204c0,%ebx
   8:	74 0a                	je     0x14
   a:	b8 c0 04 42 42       	mov    $0x424204c0,%eax
   f:	e8 bd 37 ce 00       	callq  0xce37d1
  14:	89 f2                	mov    %esi,%edx
[ 2099.514260] EAX: 00000000 EBX: 424204c0 ECX: 00083c8b EDX: 00083c43
[ 2099.514920] ESI: 00000246 EDI: 00011ac4 EBP: 40037fa0 ESP: 40037f90
[ 2099.515552] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010046
[ 2099.516250] CR0: 80050033 CR2: 37e343e2 CR3: 99b6b000 CR4: 00040690
[ 2099.516900] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[ 2099.517548] DR6: fffe0ff0 DR7: 00000400
[ 2099.517964] Call Trace:
[ 2099.518228]  <SOFTIRQ>
[ 2099.518493] ? rcu_core (kbuild/src/consumer/kernel/rcu/tree.c:2682) 
[ 2099.518862] ? rcu_core_si (kbuild/src/consumer/kernel/rcu/tree.c:2694) 
[ 2099.519241] ? __do_softirq (kbuild/src/consumer/arch/x86/include/asm/jump_label.h:25 kbuild/src/consumer/include/linux/jump_label.h:200 kbuild/src/consumer/include/trace/events/irq.h:142 kbuild/src/consumer/kernel/softirq.c:299) 
[ 2099.519651] ? __softirqentry_text_start (kbuild/src/consumer/kernel/softirq.c:256) 
[ 2099.520144] ? call_on_stack (kbuild/src/consumer/arch/x86/kernel/irq_32.c:59) 
[ 2099.520547]  </SOFTIRQ>
[ 2099.520816] ? irq_exit_rcu (kbuild/src/consumer/kernel/softirq.c:393 kbuild/src/consumer/kernel/softirq.c:423 kbuild/src/consumer/kernel/softirq.c:435) 
[ 2099.521207] ? sysvec_apic_timer_interrupt (kbuild/src/consumer/arch/x86/kernel/apic/apic.c:1091) 
[ 2099.521722] ? handle_exception (kbuild/src/consumer/arch/x86/entry/entry_32.S:1179) 
[ 2099.522166] ? finish_task_switch (kbuild/src/consumer/kernel/sched/core.c:3634) 
[ 2099.525832] ? rcu_read_unlock (kbuild/src/consumer/include/linux/rcupdate.h:684 (discriminator 5)) 
[ 2099.526254] ? _raw_spin_unlock_irq (kbuild/src/consumer/include/linux/spinlock_api_smp.h:169 kbuild/src/consumer/kernel/locking/spinlock.c:199) 
[ 2099.526730] ? rcu_read_unlock (kbuild/src/consumer/include/linux/rcupdate.h:684 (discriminator 5)) 
[ 2099.527152] ? sysvec_call_function_single (kbuild/src/consumer/arch/x86/kernel/apic/apic.c:1091) 
[ 2099.527674] ? _raw_spin_unlock_irq (kbuild/src/consumer/include/linux/spinlock_api_smp.h:169 kbuild/src/consumer/kernel/locking/spinlock.c:199) 
[ 2099.528134] ? finish_task_switch (kbuild/src/consumer/kernel/sched/core.c:3634) 
[ 2099.528582] ? finish_task_switch (kbuild/src/consumer/kernel/sched/core.c:3488 kbuild/src/consumer/kernel/sched/core.c:3616) 
[ 2099.529033] ? __switch_to (kbuild/src/consumer/arch/x86/kernel/process_32.c:164) 
[ 2099.529424] ? __schedule (kbuild/src/consumer/kernel/sched/core.c:3781 kbuild/src/consumer/kernel/sched/core.c:4527) 
[ 2099.529814] ? sysvec_call_function_single (kbuild/src/consumer/arch/x86/kernel/apic/apic.c:1091) 
[ 2099.530333] ? sysvec_call_function_single (kbuild/src/consumer/arch/x86/kernel/apic/apic.c:1091) 
[ 2099.530850] ? preempt_schedule_irq (kbuild/src/consumer/arch/x86/include/asm/irqflags.h:49 (discriminator 1) kbuild/src/consumer/arch/x86/include/asm/irqflags.h:89 (discriminator 1) kbuild/src/consumer/kernel/sched/core.c:4786 (discriminator 1)) 
[ 2099.531292] ? irqentry_exit_cond_resched (??:?) 
[ 2099.531836] ? irqentry_exit (kbuild/src/consumer/kernel/entry/common.c:374 kbuild/src/consumer/kernel/entry/common.c:362) 
[ 2099.532227] ? sysvec_apic_timer_interrupt (kbuild/src/consumer/arch/x86/kernel/apic/apic.c:1091) 
[ 2099.532746] ? handle_exception (kbuild/src/consumer/arch/x86/entry/entry_32.S:1179) 
[ 2099.533193] ? preempt_schedule (kbuild/src/consumer/kernel/sched/core.c:4709) 
[ 2099.533618] ? preempt_schedule_common (kbuild/src/consumer/arch/x86/include/asm/bitops.h:207 kbuild/src/consumer/include/asm-generic/bitops/instrumented-non-atomic.h:111 kbuild/src/consumer/include/linux/thread_info.h:84 kbuild/src/consumer/include/linux/sched.h:1864 kbuild/src/consumer/kernel/sched/core.c:4691) 
[ 2099.534101] ? sysvec_call_function_single (kbuild/src/consumer/arch/x86/kernel/apic/apic.c:1091) 
[ 2099.534631] ? preempt_schedule_common (kbuild/src/consumer/arch/x86/include/asm/bitops.h:207 kbuild/src/consumer/include/asm-generic/bitops/instrumented-non-atomic.h:111 kbuild/src/consumer/include/linux/thread_info.h:84 kbuild/src/consumer/include/linux/sched.h:1864 kbuild/src/consumer/kernel/sched/core.c:4691) 
[ 2099.535115] ? preempt_schedule (kbuild/src/consumer/kernel/sched/core.c:4709) 
[ 2099.535539] ? preempt_schedule_thunk (kbuild/src/consumer/arch/x86/entry/thunk_32.S:38) 
[ 2099.536012] ? _raw_spin_unlock (kbuild/src/consumer/kernel/locking/spinlock.c:184) 
[ 2099.536439] ? dentry_unlink_inode (kbuild/src/consumer/fs/dcache.c:369) 
[ 2099.536899] ? __dentry_kill (kbuild/src/consumer/fs/dcache.c:582) 
[ 2099.537306] ? shrink_dentry_list (kbuild/src/consumer/include/linux/list.h:282 kbuild/src/consumer/fs/dcache.c:1119) 
[ 2099.537757] ? shrink_dcache_parent (kbuild/src/consumer/fs/dcache.c:1592) 
[ 2099.538227] ? d_invalidate (kbuild/src/consumer/fs/dcache.c:1677 kbuild/src/consumer/fs/dcache.c:1662) 
[ 2099.538632] ? d_find_any_alias (kbuild/src/consumer/fs/dcache.c:989) 
[ 2099.539070] ? proc_invalidate_siblings_dcache (kbuild/src/consumer/fs/proc/inode.c:151) 
[ 2099.539645] ? proc_flush_pid (kbuild/src/consumer/fs/proc/base.c:3319) 
[ 2099.540055] ? release_task (kbuild/src/consumer/kernel/exit.c:222) 
[ 2099.540465] ? wait_task_zombie (kbuild/src/consumer/kernel/exit.c:1088) 
[ 2099.540909] ? wait_consider_task (kbuild/src/consumer/kernel/exit.c:1315) 
[ 2099.541368] ? _raw_read_lock (kbuild/src/consumer/kernel/locking/spinlock.c:224) 
[ 2099.541779] ? do_wait (kbuild/src/consumer/kernel/exit.c:1380 kbuild/src/consumer/kernel/exit.c:1449) 
[ 2099.542140] ? kernel_wait4 (kbuild/src/consumer/kernel/exit.c:1621) 
[ 2099.542562] ? kill_orphaned_pgrp (kbuild/src/consumer/kernel/exit.c:1403) 
[ 2099.543029] ? __ia32_sys_wait4 (kbuild/src/consumer/kernel/exit.c:1649 kbuild/src/consumer/kernel/exit.c:1645 kbuild/src/consumer/kernel/exit.c:1645) 
[ 2099.543443] ? do_int80_syscall_32 (kbuild/src/consumer/arch/x86/entry/common.c:84 kbuild/src/consumer/arch/x86/entry/common.c:94) 
[ 2099.543876] ? entry_INT80_32 (kbuild/src/consumer/arch/x86/entry/entry_32.S:1064) 
[ 2099.544281] irq event stamp: 133715011
[ 2099.544682] hardirqs last enabled at (133715010): rcu_core (kbuild/src/consumer/arch/x86/include/asm/irqflags.h:41 (discriminator 2) kbuild/src/consumer/arch/x86/include/asm/irqflags.h:84 (discriminator 2) kbuild/src/consumer/kernel/rcu/tree.c:2676 (discriminator 2)) 
[ 2099.545470] hardirqs last disabled at (133715011): _raw_spin_lock_irqsave (kbuild/src/consumer/include/linux/spinlock_api_smp.h:109 kbuild/src/consumer/kernel/locking/spinlock.c:159) 
[ 2099.546368] softirqs last enabled at (133714602): __do_softirq (kbuild/src/consumer/arch/x86/include/asm/preempt.h:26 kbuild/src/consumer/kernel/softirq.c:326) 
[ 2099.547218] softirqs last disabled at (133715005): call_on_stack (kbuild/src/consumer/arch/x86/kernel/irq_32.c:59) 
[ 2099.548036] ---[ end trace 74aafb1e11890695 ]---
[ 2099.548569] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: 0x0 delta ->gp_activity 31584 ->gp_req_activity 31512 ->gp_wake_time 31512 ->gp_wake_seq 72388 ->gp_seq 72388 ->gp_seq_needed 72392 ->gp_flags 0x1
[ 2099.550565] rcu: 	rcu_node 0:1 ->gp_seq 72388 ->gp_seq_needed 72392
[ 2099.551239] rcu: RCU callbacks invoked since boot: 151744
[ 2099.551802] rcu_tasks: RTGS_INIT(0) since 539800 g:0 i:0/0 k.
[ 2099.552424] rcu_tasks_rude: RTGS_INIT(0) since 539800 g:0 i:0/0 k.
[ 2099.553077] rcu_tasks_trace: RTGS_INIT(0) since 539800 g:0 i:0/0 k. N0 h:0/0/0
BUG: kernel hang in test stage

Kboot worker: lkp-worker36
Elapsed time: 4020

kvm=(
qemu-system-i386
-enable-kvm
-cpu SandyBridge
-kernel $kernel
-initrd initrd-vm-snb-i386-16.cgz
-m 16384
-smp 2
-device e1000,netdev=net0
-netdev user,id=net0,hostfwd=tcp::32032-:22
-boot order=nc
-no-reboot
-watchdog i6300esb
-watchdog-action debug
-rtc base=localtime
-serial stdio
-display none
-monitor null
)

append=(
ip=::::vm-snb-i386-16::dhcp
root=/dev/ram0
user=lkp
job=/job-script
ARCH=i386
kconfig=i386-randconfig-r005-20210110
branch=linus/master
commit=933ada2c3310aa88807e65c8d498b74a2159a9a2
BOOT_IMAGE=/pkg/linux/i386-randconfig-r005-20210110/gcc-9/933ada2c3310aa88807e65c8d498b74a2159a9a2/vmlinuz-5.9.0-rc1-00008-g933ada2c3310a
vmalloc=512M
max_uptime=2100
RESULT_ROOT=/result/trinity/300s/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-r005-20210110/gcc-9/933ada2c3310aa88807e65c8d498b74a2159a9a2/136
result_service=tmpfs
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1


To reproduce:

        # build kernel
	cd linux
	cp config-5.9.0-rc1-00008-g933ada2c3310a .config
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.9.0-rc1-00008-g933ada2c3310a"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.9.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235020000
CONFIG_CLANG_VERSION=0
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
# CONFIG_SYSVIPC is not set
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
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
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
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
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
CONFIG_RCU_FANOUT_LEAF=2
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_RCU_BOOST is not set
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

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
CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
# CONFIG_UCLAMP_TASK_GROUP is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_TIME_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
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
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=m
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
# CONFIG_X86_32_NON_STANDARD is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
CONFIG_M586MMX=y
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
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_F00F_BUG=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
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
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_OLD_INTERFACE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_UMIP is not set
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=m
# CONFIG_ACPI_SPCR_TABLE is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
# CONFIG_ACPI_TINY_POWER_BUTTON is not set
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=m
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
# CONFIG_ACPI_APEI_EINJ is not set
CONFIG_ACPI_APEI_ERST_DEBUG=m
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

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
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=y
# CONFIG_X86_LONGRUN is not set
CONFIG_X86_LONGHAUL=y
CONFIG_X86_E_POWERSAVER=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
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

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
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
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=m
CONFIG_EFI_ESRT=y
# CONFIG_EFI_VARS_PSTORE is not set
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=m
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH is not set
CONFIG_EFI_TEST=y
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_KVM_WERROR is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
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
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
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
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

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
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
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
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set
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
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_HMM_MIRROR=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
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
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_MPTCP_KUNIT_TESTS is not set
# CONFIG_NETWORK_SECMARK is not set
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
CONFIG_HAVE_NET_DSA=y
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
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
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
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
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
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
# CONFIG_EISA_PCI_EISA is not set
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
CONFIG_PCIEASPM_PERFORMANCE=y
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
CONFIG_HOTPLUG_PCI_IBM=m
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
CONFIG_PCIE_XILINX=y

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCIE_INTEL_GW=y
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
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
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_PCCARD=m
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
# CONFIG_RAPIDIO_ENUM_BASIC is not set
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=m
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_TSI568=m
CONFIG_RAPIDIO_CPS_GEN2=m
CONFIG_RAPIDIO_RXS_GEN3=m
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
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
CONFIG_FW_LOADER_COMPRESS=y
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
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MOXTET is not set
CONFIG_MHI_BUS=y
# end of Bus devices

# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=m
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_CS5535_MFGPT is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_PCH_PHUB is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=m
CONFIG_XILINX_SDFEC=m
CONFIG_PVPANIC=y
CONFIG_C2PORT=m
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
CONFIG_INTEL_MEI_HDCP=m
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

# CONFIG_ECHO is not set
CONFIG_MISC_ALCOR_PCI=y
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HABANA_AI=y
# CONFIG_UACCE is not set
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
CONFIG_FIREWIRE_OHCI=m
# CONFIG_FIREWIRE_NET is not set
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
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
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
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
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
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
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
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
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
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
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

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
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
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_POLLDEV is not set
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
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
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
# CONFIG_MOUSE_PS2_BYD is not set
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
# CONFIG_MOUSE_PS2_CYPRESS is not set
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_PS2_OLPC is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=m
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=m
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_FSIA6B=y
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
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=m
# CONFIG_HYPERV_KEYBOARD is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
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
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
# CONFIG_SERIAL_8250_PNP is not set
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
# CONFIG_SERIAL_8250_PCI is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=m
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_IMX_EARLYCON is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
CONFIG_SERIAL_SCCNXP=m
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_TIMBERDALE=m
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_IFX6X60=m
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_SPRD=m
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=y
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=y
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
CONFIG_SYNCLINK_GT=m
CONFIG_ISI=m
CONFIG_N_HDLC=m
CONFIG_GOLDFISH_TTY=m
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=m
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=m
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_CCTRNG=m
CONFIG_APPLICOM=m
CONFIG_SONYPI=m
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=m
# CONFIG_DEVPORT is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=m
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=m
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_SPI_CR50=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TCG_TIS_ST33ZP24_SPI=m
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_PCIE=m
CONFIG_XILLYBUS_OF=m
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=m
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_DEMUX_PINCTRL is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=m
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
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
CONFIG_SPI_ALTERA=m
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=m
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_FSI is not set
CONFIG_SPI_NXP_FLEXSPI=m
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=m
CONFIG_SPI_AMD=m

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_LOOPBACK_TEST=m
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPMI=m
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

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
# CONFIG_PINCTRL_AS3722 is not set
# CONFIG_PINCTRL_AXP209 is not set
CONFIG_PINCTRL_AMD=m
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08_SPI=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_STMFX=m
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=m
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_EMMITSBURG=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=m
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=m
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=m
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HLWD=m
CONFIG_GPIO_ICH=y
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SIOX=m
# CONFIG_GPIO_SYSCON is not set
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XILINX=m
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=m
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=m
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=m
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD70528=y
# CONFIG_GPIO_BD71828 is not set
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CS5535=m
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MADERA=m
CONFIG_GPIO_MAX77650=m
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TWL6040=m
# CONFIG_GPIO_WHISKEY_COVE is not set
CONFIG_GPIO_WM831X=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_ML_IOH=y
# CONFIG_GPIO_PCH is not set
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=m
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

CONFIG_GPIO_AGGREGATOR=m
# CONFIG_GPIO_MOCKUP is not set
CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=m
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=m
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=m
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=m
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_OLPC=m
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
# CONFIG_CHARGER_DA9150 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
CONFIG_AXP288_FUEL_GAUGE=m
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_PCF50633=m
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=m
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=m
# CONFIG_CHARGER_MAX77650 is not set
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX8997 is not set
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_UCS1002=m
CONFIG_CHARGER_BD70528=m
CONFIG_CHARGER_BD99954=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=m
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_AMD_ENERGY=m
CONFIG_SENSORS_APPLESMC=y
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_MC13783_ADC is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=m
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_ADCXX=m
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=m
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_BEL_PFE=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=m
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX16601=y
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE122=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=m
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CPU_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=y
# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
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
CONFIG_BD70528_WATCHDOG=m
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
# CONFIG_DA9063_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=m
# CONFIG_MENZ069_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=m
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=y
CONFIG_STPMIC1_WATCHDOG=m
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
CONFIG_ALIM1535_WDT=m
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=y
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=m
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
# CONFIG_SC1200_WDT is not set
CONFIG_SCx200_WDT=m
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=y
CONFIG_RDC321X_WDT=m
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=m
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
CONFIG_NIC7018_WDT=y
CONFIG_MEN_A21_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=m
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
# CONFIG_MFD_MADERA_SPI is not set
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=m
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC_BXTWC=y
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
CONFIG_INTEL_SOC_PMIC_MRFLD=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_MSIC is not set
CONFIG_MFD_INTEL_PMC_BXT=y
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=m
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=m
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS65912_SPI=m
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=m
CONFIG_MFD_ROHM_BD70528=y
CONFIG_MFD_ROHM_BD71828=m
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD70528=y
CONFIG_REGULATOR_BD71828=m
CONFIG_REGULATOR_BD718XX=m
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA903X=m
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9055=m
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=m
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=m
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP8788=m
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=m
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8997=m
CONFIG_REGULATOR_MAX77693=m
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=m
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MP886X=y
CONFIG_REGULATOR_MPQ7920=m
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6358=m
CONFIG_REGULATOR_MT6397=m
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCAP=m
CONFIG_REGULATOR_PCF50633=m
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_QCOM_USB_VBUS=m
CONFIG_REGULATOR_ROHM=m
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
# CONFIG_REGULATOR_S5M8767 is not set
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_STPMIC1=m
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_SY8827N=m
CONFIG_REGULATOR_TPS51632=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS6524X=y
# CONFIG_REGULATOR_TPS65910 is not set
# CONFIG_REGULATOR_TPS65912 is not set
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_QCOM_LABIBB=m
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_LIRC=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=y
# CONFIG_IR_HIX5HD2 is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_SPI is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=y
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
CONFIG_IR_PWM_TX=y
CONFIG_IR_SERIAL=y
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_SIR=y
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_MEDIA_CEC_RC=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_PLATFORM_SUPPORT=y
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CAFE_CCIC=m
CONFIG_VIDEO_VIA_CAMERA=m
# CONFIG_VIDEO_CADENCE is not set
CONFIG_VIDEO_ASPEED=m
CONFIG_VIDEO_MUX=m
CONFIG_VIDEO_XILINX=m
CONFIG_VIDEO_XILINX_CSI2RXSS=m
CONFIG_VIDEO_XILINX_TPG=m
CONFIG_VIDEO_XILINX_VTC=m
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
CONFIG_DVB_PLATFORM_DRIVERS=y

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
# CONFIG_VIDEO_IR_I2C is not set

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_SONY_BTF_MPX=m
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
CONFIG_VIDEO_ADV7183=m
# CONFIG_VIDEO_ADV748X is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=m
# CONFIG_VIDEO_SAA711X is not set
CONFIG_VIDEO_TC358743=m
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=m
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set
CONFIG_VIDEO_MAX9286=m

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
CONFIG_VIDEO_ADV7393=m
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
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=m
CONFIG_VIDEO_I2C=m
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

CONFIG_VIDEO_OV7670=m

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
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_TDA18218=m
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=m
# CONFIG_MEDIA_TUNER_TDA18212 is not set
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
# CONFIG_MEDIA_TUNER_R820T is not set
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
# CONFIG_DVB_STV6111 is not set
# CONFIG_DVB_MXL5XX is not set
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
# CONFIG_DVB_TDA18271C2DD is not set
# CONFIG_DVB_SI2165 is not set
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
# CONFIG_DVB_CX24123 is not set
# CONFIG_DVB_MT312 is not set
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
# CONFIG_DVB_STV0288 is not set
# CONFIG_DVB_STB6000 is not set
CONFIG_DVB_STV0299=m
# CONFIG_DVB_STV6110 is not set
# CONFIG_DVB_STV0900 is not set
# CONFIG_DVB_TDA8083 is not set
CONFIG_DVB_TDA10086=m
# CONFIG_DVB_TDA8261 is not set
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
# CONFIG_DVB_TUNER_CX24113 is not set
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
# CONFIG_DVB_CX24117 is not set
# CONFIG_DVB_CX24120 is not set
# CONFIG_DVB_SI21XX is not set
CONFIG_DVB_TS2020=m
# CONFIG_DVB_DS3000 is not set
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
# CONFIG_DVB_DRXD is not set
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
# CONFIG_DVB_TDA10048 is not set
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
# CONFIG_DVB_RTL2832 is not set
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
# CONFIG_DVB_STV0297 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
# CONFIG_DVB_OR51132 is not set
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
# CONFIG_DVB_LNBH25 is not set
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
# CONFIG_DVB_ISL6423 is not set
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_ATI is not set
CONFIG_AGP_AMD=m
CONFIG_AGP_AMD64=m
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_NVIDIA=y
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=y
# CONFIG_AGP_VIA is not set
CONFIG_AGP_EFFICEON=y
CONFIG_INTEL_GTT=m
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

CONFIG_DRM_RADEON=m
# CONFIG_DRM_RADEON_USERPTR is not set
CONFIG_DRM_AMDGPU=y
CONFIG_DRM_AMDGPU_SI=y
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y
# CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_AMD_ACP is not set
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN=y
# CONFIG_DRM_AMD_DC_DCN3_0 is not set
# CONFIG_DRM_AMD_DC_HDCP is not set
# CONFIG_DEBUG_KERNEL_DC is not set
# end of Display Engine Configuration

CONFIG_DRM_NOUVEAU=y
CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=y
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
CONFIG_NOUVEAU_DEBUG_MMU=y
CONFIG_NOUVEAU_DEBUG_PUSH=y
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
CONFIG_DRM_I915_USERPTR=y

#
# drm/i915 Debugging
#
CONFIG_DRM_I915_WERROR=y
# CONFIG_DRM_I915_DEBUG is not set
CONFIG_DRM_I915_DEBUG_MMIO=y
# CONFIG_DRM_I915_DEBUG_GEM is not set
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
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

# CONFIG_DRM_VGEM is not set
CONFIG_DRM_VKMS=y
CONFIG_DRM_VMWGFX=y
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=y
# CONFIG_DRM_GMA600 is not set
# CONFIG_DRM_GMA3600 is not set
CONFIG_DRM_AST=y
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
CONFIG_DRM_RCAR_LVDS=y
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=m
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=m
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
# CONFIG_DRM_PANEL_LVDS is not set
# CONFIG_DRM_PANEL_SIMPLE is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=y
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=m
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
# CONFIG_DRM_PANEL_LG_LG4573 is not set
CONFIG_DRM_PANEL_NEC_NL8048HL11=y
CONFIG_DRM_PANEL_NOVATEK_NT35510=y
CONFIG_DRM_PANEL_NOVATEK_NT39016=y
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=m
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=m
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
CONFIG_DRM_PANEL_SONY_ACX424AKP=m
CONFIG_DRM_PANEL_SONY_ACX565AKM=y
CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=y
CONFIG_DRM_CHRONTEL_CH7033=m
CONFIG_DRM_DISPLAY_CONNECTOR=y
CONFIG_DRM_LVDS_CODEC=y
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NWL_MIPI_DSI=m
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=m
CONFIG_DRM_PARADE_PS8640=y
CONFIG_DRM_SIL_SII8620=y
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=m
# CONFIG_DRM_SIMPLE_BRIDGE is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=m
CONFIG_DRM_TOSHIBA_TC358768=m
CONFIG_DRM_TI_TFP410=m
# CONFIG_DRM_TI_SN65DSI86 is not set
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=m
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=m
CONFIG_DRM_I2C_ADV7511=m
# CONFIG_DRM_I2C_ADV7511_CEC is not set
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_TINYDRM_HX8357D=y
# CONFIG_TINYDRM_ILI9225 is not set
CONFIG_TINYDRM_ILI9341=m
CONFIG_TINYDRM_ILI9486=m
CONFIG_TINYDRM_MI0283QT=m
CONFIG_TINYDRM_REPAPER=y
CONFIG_TINYDRM_ST7586=y
# CONFIG_TINYDRM_ST7735R is not set
CONFIG_DRM_VBOXVIDEO=y
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=y
CONFIG_DRM_MGA=y
CONFIG_DRM_SIS=m
CONFIG_DRM_VIA=m
CONFIG_DRM_SAVAGE=m
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
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
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=m
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=y
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=m
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=m
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_GEODE is not set
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
CONFIG_FB_VIRTUAL=m
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=m
CONFIG_FB_SM712=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
CONFIG_LCD_HX8357=m
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_CARILLO_RANCH=m
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MAX8925=m
CONFIG_BACKLIGHT_APPLE=m
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=m
# CONFIG_BACKLIGHT_ADP5520 is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=m
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
CONFIG_HID_AUREAL=m
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_COUGAR=m
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=m
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
# CONFIG_HID_PICOLCD_LEDS is not set
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID=y
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=m
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_AAT1290 is not set
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=m
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_EL15203000=m
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_NET48XX=m
CONFIG_LEDS_WRAP=m
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA903X=m
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_MAX77693=m
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=m
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m
# CONFIG_LEDS_SPI_BYTE is not set
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_SGM3140=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_AMD76X=m
CONFIG_EDAC_E7XXX=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82875P=m
CONFIG_EDAC_I82975X=m
# CONFIG_EDAC_I3000 is not set
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I82860=m
CONFIG_EDAC_R82600=m
# CONFIG_EDAC_I5000 is not set
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=m
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_AS3722=m
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_CENTURY=y
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=m
CONFIG_RTC_DRV_LP8788=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_MAX8907=y
# CONFIG_RTC_DRV_MAX8925 is not set
# CONFIG_RTC_DRV_MAX8997 is not set
CONFIG_RTC_DRV_RS5C372=m
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BD70528=m
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_TPS65910=y
CONFIG_RTC_DRV_TPS80031=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=m
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_S5M=m
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=y
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=m
CONFIG_RTC_DRV_R9701=m
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=m
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=y
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=m
# CONFIG_RTC_DRV_DA9055 is not set
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_WM831X is not set
# CONFIG_RTC_DRV_PCF50633 is not set
# CONFIG_RTC_DRV_ZYNQMP is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_PCAP=m
CONFIG_RTC_DRV_MC13XXX=y
# CONFIG_RTC_DRV_MT6397 is not set
CONFIG_RTC_DRV_R7301=m

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=m
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=m
CONFIG_PCH_DMA=m
CONFIG_PLX_DMA=m
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=m
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_DW_EDMA=y
CONFIG_DW_EDMA_PCIE=y
CONFIG_SF_PDMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=m
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_HT16K33 is not set
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_CHARLCD=m
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=m
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_BALLOON=y
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
CONFIG_STAGING=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
CONFIG_COMEDI_ADDI_APCI_1500=m
# CONFIG_COMEDI_ADDI_APCI_1516 is not set
CONFIG_COMEDI_ADDI_APCI_1564=m
CONFIG_COMEDI_ADDI_APCI_16XX=m
CONFIG_COMEDI_ADDI_APCI_2032=m
# CONFIG_COMEDI_ADDI_APCI_2200 is not set
# CONFIG_COMEDI_ADDI_APCI_3120 is not set
CONFIG_COMEDI_ADDI_APCI_3501=m
CONFIG_COMEDI_ADDI_APCI_3XXX=m
CONFIG_COMEDI_ADL_PCI6208=m
CONFIG_COMEDI_ADL_PCI7X3X=m
# CONFIG_COMEDI_ADL_PCI8164 is not set
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
CONFIG_COMEDI_ADV_PCI1724=m
# CONFIG_COMEDI_ADV_PCI1760 is not set
CONFIG_COMEDI_ADV_PCI_DIO=m
# CONFIG_COMEDI_AMPLC_DIO200_PCI is not set
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
# CONFIG_COMEDI_AMPLC_PCI224 is not set
CONFIG_COMEDI_AMPLC_PCI230=m
# CONFIG_COMEDI_CONTEC_PCI_DIO is not set
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
# CONFIG_COMEDI_MF6X4 is not set
# CONFIG_COMEDI_ICP_MULTI is not set
CONFIG_COMEDI_DAQBOARD2000=m
# CONFIG_COMEDI_JR3_PCI is not set
# CONFIG_COMEDI_KE_COUNTER is not set
CONFIG_COMEDI_CB_PCIDAS64=m
# CONFIG_COMEDI_CB_PCIDAS is not set
# CONFIG_COMEDI_CB_PCIDDA is not set
# CONFIG_COMEDI_CB_PCIMDAS is not set
CONFIG_COMEDI_CB_PCIMDDA=m
CONFIG_COMEDI_ME4000=m
# CONFIG_COMEDI_ME_DAQ is not set
CONFIG_COMEDI_NI_6527=m
# CONFIG_COMEDI_NI_65XX is not set
CONFIG_COMEDI_NI_660X=m
CONFIG_COMEDI_NI_670X=m
# CONFIG_COMEDI_NI_LABPC_PCI is not set
CONFIG_COMEDI_NI_PCIDIO=m
CONFIG_COMEDI_NI_PCIMIO=m
CONFIG_COMEDI_RTD520=m
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
# CONFIG_COMEDI_KCOMEDILIB is not set
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
# CONFIG_FB_OLPC_DCON is not set
# CONFIG_RTLLIB is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=y
CONFIG_ADIS16240=m
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
CONFIG_AD7280=y
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_SPI=m
CONFIG_ADT7316_I2C=m
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
CONFIG_AD9834=m
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=y
# CONFIG_ADE7854_I2C is not set
CONFIG_ADE7854_SPI=y
# end of Active energy metering IC

#
# Resolver to digital converters
#
CONFIG_AD2S1210=m
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=y
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
CONFIG_ASHMEM=y
# CONFIG_ION is not set
# end of Android

# CONFIG_STAGING_BOARD is not set
CONFIG_FIREWIRE_SERIAL=y
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GOLDFISH_AUDIO is not set
CONFIG_GS_FPGABOOT=y
CONFIG_UNISYSSPAR=y
CONFIG_FB_TFT=m
CONFIG_FB_TFT_AGM1264K_FL=m
CONFIG_FB_TFT_BD663474=m
# CONFIG_FB_TFT_HX8340BN is not set
# CONFIG_FB_TFT_HX8347D is not set
CONFIG_FB_TFT_HX8353D=m
CONFIG_FB_TFT_HX8357D=m
# CONFIG_FB_TFT_ILI9163 is not set
# CONFIG_FB_TFT_ILI9320 is not set
# CONFIG_FB_TFT_ILI9325 is not set
CONFIG_FB_TFT_ILI9340=m
CONFIG_FB_TFT_ILI9341=m
CONFIG_FB_TFT_ILI9481=m
# CONFIG_FB_TFT_ILI9486 is not set
# CONFIG_FB_TFT_PCD8544 is not set
CONFIG_FB_TFT_RA8875=m
CONFIG_FB_TFT_S6D02A1=m
CONFIG_FB_TFT_S6D1121=m
CONFIG_FB_TFT_SEPS525=m
CONFIG_FB_TFT_SH1106=m
CONFIG_FB_TFT_SSD1289=m
# CONFIG_FB_TFT_SSD1305 is not set
CONFIG_FB_TFT_SSD1306=m
CONFIG_FB_TFT_SSD1331=m
CONFIG_FB_TFT_SSD1351=m
CONFIG_FB_TFT_ST7735R=m
# CONFIG_FB_TFT_ST7789V is not set
CONFIG_FB_TFT_TINYLCD=m
# CONFIG_FB_TFT_TLS8204 is not set
CONFIG_FB_TFT_UC1611=m
# CONFIG_FB_TFT_UC1701 is not set
CONFIG_FB_TFT_UPD161704=m
CONFIG_FB_TFT_WATTEROTT=m
CONFIG_MOST_COMPONENTS=m
CONFIG_MOST_CDEV=m
# CONFIG_MOST_NET is not set
CONFIG_MOST_VIDEO=m
CONFIG_MOST_DIM2=m
CONFIG_MOST_I2C=m
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_FIRMWARE=m
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
# CONFIG_GREYBUS_LOG is not set
# CONFIG_GREYBUS_LOOPBACK is not set
CONFIG_GREYBUS_POWER=m
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
# CONFIG_GREYBUS_BRIDGED_PHY is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# end of Gasket devices

# CONFIG_XIL_AXIS_FIFO is not set
CONFIG_FIELDBUS_DEV=y
CONFIG_HMS_ANYBUSS_BUS=m
# CONFIG_ARCX_ANYBUS_CONTROLLER is not set
# CONFIG_HMS_PROFINET is not set
# CONFIG_QLGE is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_INTEL_WMI_SBL_FW_UPDATE=y
CONFIG_INTEL_WMI_THUNDERBOLT=y
CONFIG_MXM_WMI=y
# CONFIG_PEAQ_WMI is not set
CONFIG_XIAOMI_WMI=y
CONFIG_ACERHDF=m
CONFIG_ACER_WIRELESS=m
CONFIG_ACER_WMI=y
CONFIG_APPLE_GMUX=m
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_EEEPC_LAPTOP is not set
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_RBU=y
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI_DESCRIPTOR=m
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_LED is not set
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
# CONFIG_HP_WMI is not set
CONFIG_TC1100_WMI=y
CONFIG_IBM_RTL=y
# CONFIG_SENSORS_HDAPS is not set
CONFIG_INTEL_ATOMISP2_LED=m
# CONFIG_INTEL_HID_EVENT is not set
CONFIG_INTEL_INT0002_VGPIO=m
CONFIG_INTEL_VBTN=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
CONFIG_SURFACE_PRO3_BUTTON=y
# CONFIG_MSI_WMI is not set
# CONFIG_XO15_EBOOK is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=y
CONFIG_ACPI_TOSHIBA=y
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
CONFIG_TOSHIBA_WMI=m
CONFIG_ACPI_CMPC=y
# CONFIG_LG_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
CONFIG_SYSTEM76_ACPI=y
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_I2C_MULTI_INSTANTIATE=y
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=y
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
CONFIG_INTEL_CHTDC_TI_PWRBTN=m
# CONFIG_INTEL_MID_POWER_BUTTON is not set
# CONFIG_INTEL_MRFLD_PWRBTN is not set
CONFIG_INTEL_PMC_CORE=m
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
# CONFIG_INTEL_SCU_PCI is not set
CONFIG_INTEL_SCU_PLATFORM=m
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_MFD_CROS_EC is not set
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CHROMEOS_TBMC=y
# CONFIG_CROS_EC is not set
CONFIG_CROS_KBD_LED_BACKLIGHT=y
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX9485=m
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=m
CONFIG_CLK_TWL6040=y
CONFIG_COMMON_CLK_PWM=m
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_BD718XX=y
CONFIG_COMMON_CLK_FIXED_MMIO=y
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_OF_IOMMU=y
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

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
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

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
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_INTEL_MRFLD=m
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
CONFIG_ADXL372=m
CONFIG_ADXL372_SPI=m
CONFIG_ADXL372_I2C=m
CONFIG_BMA180=m
CONFIG_BMA220=y
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMA400_SPI=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_DA280=m
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
CONFIG_DMARD09=m
CONFIG_DMARD10=y
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=m
CONFIG_MXC4005=y
CONFIG_MXC6255=y
# CONFIG_SCA3000 is not set
CONFIG_STK8312=m
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
# CONFIG_AD7124 is not set
CONFIG_AD7192=y
CONFIG_AD7266=m
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
CONFIG_AD7476=m
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD7606_IFACE_SPI=m
# CONFIG_AD7766 is not set
CONFIG_AD7768_1=y
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
CONFIG_AD7887=m
# CONFIG_AD7923 is not set
CONFIG_AD7949=y
CONFIG_AD799X=y
CONFIG_AD9467=m
CONFIG_ADI_AXI_ADC=y
CONFIG_AXP20X_ADC=m
# CONFIG_AXP288_ADC is not set
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=m
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
CONFIG_INA2XX_ADC=m
CONFIG_INTEL_MRFLD_ADC=m
CONFIG_LP8788_ADC=y
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=m
CONFIG_MAX11100=m
CONFIG_MAX1118=y
CONFIG_MAX1241=y
CONFIG_MAX1363=m
CONFIG_MAX9611=m
# CONFIG_MCP320X is not set
CONFIG_MCP3422=m
CONFIG_MCP3911=m
# CONFIG_MEN_Z188_ADC is not set
# CONFIG_MP2629_ADC is not set
CONFIG_NAU7802=y
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
CONFIG_QCOM_SPMI_ADC5=m
CONFIG_SD_ADC_MODULATOR=m
CONFIG_STX104=y
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=m
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7950=y
CONFIG_TI_ADS8344=m
CONFIG_TI_ADS8688=y
CONFIG_TI_ADS124S08=y
# CONFIG_TI_TLC4541 is not set
CONFIG_VF610_ADC=m
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=m
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
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
CONFIG_SCD30_CORE=m
CONFIG_SCD30_I2C=m
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SPS30=m
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORS_COMMONS is not set
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5360=m
CONFIG_AD5380=m
CONFIG_AD5421=y
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=y
CONFIG_AD5686=y
# CONFIG_AD5686_SPI is not set
CONFIG_AD5696_I2C=y
CONFIG_AD5755=y
CONFIG_AD5758=y
CONFIG_AD5761=y
CONFIG_AD5764=m
CONFIG_AD5770R=y
CONFIG_AD5791=y
CONFIG_AD7303=m
CONFIG_AD8801=y
CONFIG_CIO_DAC=m
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
CONFIG_LTC2632=y
# CONFIG_M62332 is not set
CONFIG_MAX517=m
CONFIG_MAX5821=m
# CONFIG_MCP4725 is not set
CONFIG_MCP4922=y
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=m
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
CONFIG_VF610_DAC=y
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
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m
CONFIG_ADF4371=m
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=m
CONFIG_ADIS16136=y
CONFIG_ADIS16260=m
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
# CONFIG_FXAS21002C is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
# CONFIG_HDC100X is not set
CONFIG_HID_SENSOR_HUMIDITY=m
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
CONFIG_ADIS16480=m
CONFIG_BMI160=m
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=m
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
CONFIG_KMX61=m
CONFIG_INV_ICM42600=m
CONFIG_INV_ICM42600_I2C=m
CONFIG_INV_ICM42600_SPI=m
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=m
CONFIG_INV_MPU6050_SPI=y
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=y
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=y
# CONFIG_AL3010 is not set
CONFIG_AL3320A=m
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
CONFIG_BH1750=m
# CONFIG_BH1780 is not set
CONFIG_CM32181=m
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=y
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=y
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
CONFIG_VEML6030=y
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_BMC150_MAGN_SPI is not set
CONFIG_MAG3110=m
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=y
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
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
CONFIG_DS1803=y
# CONFIG_MAX5432 is not set
CONFIG_MAX5481=y
CONFIG_MAX5487=y
CONFIG_MCP4018=m
CONFIG_MCP4131=m
# CONFIG_MCP4531 is not set
CONFIG_MCP41010=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_DLHL60D=y
CONFIG_DPS310=m
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
CONFIG_ICP10100=y
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=m
CONFIG_MPL3115=m
CONFIG_MS5611=y
CONFIG_MS5611_I2C=m
CONFIG_MS5611_SPI=m
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=m
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=y
CONFIG_PING=m
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX9310=y
CONFIG_SX9500=m
CONFIG_SRF08=y
# CONFIG_VCNL3020 is not set
CONFIG_VL53L0X_I2C=y
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
CONFIG_LTC2983=m
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_HID_SENSOR_TEMP=m
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
CONFIG_TSYS01=y
CONFIG_TSYS02D=m
CONFIG_MAX31856=y
# end of Temperature sensors

CONFIG_NTB=m
CONFIG_NTB_MSI=y
CONFIG_NTB_IDT=m
CONFIG_NTB_SWITCHTEC=m
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_MSI_TEST=m
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=m
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=m
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_CADENCE_TORRENT=m
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_SIERRA=m
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_MIXEL_MIPI_DPHY=y
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=m
# CONFIG_PHY_INTEL_COMBO is not set
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=m
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
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# end of Android

CONFIG_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=m

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=m
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=m
CONFIG_FPGA_MGR_ICE40_SPI=m
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
CONFIG_FPGA_DFL_FME_MGR=m
# CONFIG_FPGA_DFL_FME_BRIDGE is not set
CONFIG_FPGA_DFL_FME_REGION=m
# CONFIG_FPGA_DFL_AFU is not set
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_MASTER_ASPEED=y
CONFIG_FSI_SCOM=y
# CONFIG_FSI_SBEFIFO is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_ADGS1408 is not set
# CONFIG_MUX_GPIO is not set
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=m
# CONFIG_104_QUAD_8 is not set
CONFIG_FTM_QUADDEC=m
CONFIG_MICROCHIP_TCB_CAPTURE=m
CONFIG_MOST=m
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
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
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_CRAMFS=m
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=m
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
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
# CONFIG_PSTORE_CONSOLE is not set
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=y
CONFIG_VBOXSF_FS=m
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
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
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=m
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
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
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_INTEGRITY is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECC=m
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_ECRDSA=m
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
# CONFIG_CRYPTO_CRC32C is not set
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_BLAKE2S=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=m
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=m
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

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
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=m
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
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
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
CONFIG_CRC4=y
CONFIG_CRC7=y
# CONFIG_LIBCRC32C is not set
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
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
CONFIG_DEBUG_INFO_COMPRESSED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B=y
CONFIG_FRAME_POINTER=y
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
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
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
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_TEST_LOCKUP=m
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
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
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
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_RCU_STRICT_GRACE_PERIOD=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
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
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_TRACE_ARRAY=m
CONFIG_SAMPLE_KOBJECT=y
CONFIG_SAMPLE_HW_BREAKPOINT=m
CONFIG_SAMPLE_KFIFO=m
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
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
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=m
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=m
CONFIG_KUNIT_DEBUGFS=y
# CONFIG_KUNIT_TEST is not set
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
CONFIG_HYPERV_TESTING=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='trinity.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-i386-16'
	export tbox_group='vm-snb-i386'
	export branch='linus/master'
	export commit='933ada2c3310aa88807e65c8d498b74a2159a9a2'
	export kconfig='i386-randconfig-r005-20210110'
	export nr_vm=160
	export submit_id='6069ac16ab713c125ed5119e'
	export job_file='/lkp/jobs/scheduled/vm-snb-i386-16/trinity-300s-debian-i386-20191205.cgz-933ada2c3310aa88807e65c8d498b74a2159a9a2-20210404-70238-1lxswmq-151.yaml'
	export id='e547abe72ed70f25f064ca37a56d050753542f06'
	export queuer_version='/lkp-src'
	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='8G'
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export ssh_base_port=23400
	export kernel_cmdline='vmalloc=512M'
	export rootfs='debian-i386-20191205.cgz'
	export compiler='gcc-9'
	export enqueue_time='2021-04-04 20:07:50 +0800'
	export _id='6069b542ab713c125ed511dd'
	export _rt='/result/trinity/300s/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-r005-20210110/gcc-9/933ada2c3310aa88807e65c8d498b74a2159a9a2'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/300s/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-r005-20210110/gcc-9/933ada2c3310aa88807e65c8d498b74a2159a9a2/136'
	export scheduler_version='/lkp/lkp/src'
	export arch='i386'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-i386-20191205.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-i386-16/trinity-300s-debian-i386-20191205.cgz-933ada2c3310aa88807e65c8d498b74a2159a9a2-20210404-70238-1lxswmq-151.yaml
ARCH=i386
kconfig=i386-randconfig-r005-20210110
branch=linus/master
commit=933ada2c3310aa88807e65c8d498b74a2159a9a2
BOOT_IMAGE=/pkg/linux/i386-randconfig-r005-20210110/gcc-9/933ada2c3310aa88807e65c8d498b74a2159a9a2/vmlinuz-5.9.0-rc1-00008-g933ada2c3310a
vmalloc=512M
max_uptime=2100
RESULT_ROOT=/result/trinity/300s/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-r005-20210110/gcc-9/933ada2c3310aa88807e65c8d498b74a2159a9a2/136
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
	export modules_initrd='/pkg/linux/i386-randconfig-r005-20210110/gcc-9/933ada2c3310aa88807e65c8d498b74a2159a9a2/modules.cgz'
	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz,/osimage/pkg/debian-i386-20191205.cgz/trinity-i386-4d2343bd-1_20200320.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='6afbf2f7c767'
	export repeat_to=176
	export queue_at_least_once=1
	export kernel='/pkg/linux/i386-randconfig-r005-20210110/gcc-9/933ada2c3310aa88807e65c8d498b74a2159a9a2/vmlinuz-5.9.0-rc1-00008-g933ada2c3310a'
	export dequeue_time='2021-04-04 21:02:42 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-16/trinity-300s-debian-i386-20191205.cgz-933ada2c3310aa88807e65c8d498b74a2159a9a2-20210404-70238-1lxswmq-151.cgz'

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

	run_test $LKP_SRC/tests/wrapper trinity
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

--5mCyUwZo2JvN/JJP
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--5mCyUwZo2JvN/JJP--
