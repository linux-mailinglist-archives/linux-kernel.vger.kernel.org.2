Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14352381F41
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhEPO0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 10:26:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:26988 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhEPO0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 10:26:20 -0400
IronPort-SDR: eSvMTYLIVtYmDbU85Ad0Ag6CC1j0oJeDhqLdhr9yDvNzHzWoVcUJYHYijbGAmzl/pkk9wVg8Tq
 C6MYpppe5Iug==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="198381273"
X-IronPort-AV: E=Sophos;i="5.82,304,1613462400"; 
   d="xz'?scan'208";a="198381273"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 07:25:05 -0700
IronPort-SDR: ceLyVObtxyrNpWCc9tINQOqR4nrmXFvux6bILS6w82joM3F6tM9VbTtjJXXXW7CaJAOA+WbbnL
 DA7d60+XklCA==
X-IronPort-AV: E=Sophos;i="5.82,304,1613462400"; 
   d="xz'?scan'208";a="629536213"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 07:25:01 -0700
Date:   Sun, 16 May 2021 22:41:52 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Oliver Glitta <glittao@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: [mm/slub]  ad36bafb3b:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
Message-ID: <20210516144152.GA25903@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597 ("mm/slub: use stackdepot to save stack trace in objects")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


in testcase: rcuscale
version: 
with following parameters:

	runtime: 300s
	scale_type: tasks



on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | 912f180c1b | ad36bafb3b |
+----------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                   | 52         | 0          |
| boot_failures                                                                    | 0          | 65         |
| BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c             | 0          | 65         |
| WARNING:inconsistent_lock_state                                                  | 0          | 18         |
| inconsistent{SOFTIRQ-ON-W}->{IN-SOFTIRQ-W}usage                                  | 0          | 18         |
| RIP:check_preemption_disabled                                                    | 0          | 2          |
| RIP:rcu_torture_one_read[rcutorture]                                             | 0          | 6          |
| WARNING:possible_circular_locking_dependency_detected                            | 0          | 20         |
| RIP:debug_lockdep_rcu_enabled                                                    | 0          | 1          |
| RIP:___might_sleep                                                               | 0          | 5          |
| RIP:pvclock_clocksource_read                                                     | 0          | 4          |
| WARNING:suspicious_RCU_usage                                                     | 0          | 9          |
| kernel/sched/core.c:#Illegal_context_switch_in_RCU-bh_read-side_critical_section | 0          | 9          |
| WARNING:possible_irq_lock_inversion_dependency_detected                          | 0          | 11         |
| RIP:rcu_torture_reader[rcutorture]                                               | 0          | 1          |
| RIP:lock_release                                                                 | 0          | 2          |
| calltrace:do_softirq                                                             | 0          | 4          |
| RIP:preempt_count_add                                                            | 0          | 9          |
| RIP:kasan_check_range                                                            | 0          | 3          |
| RIP:rcutorture_extend_mask[rcutorture]                                           | 0          | 6          |
| WARNING:HARDIRQ-safe->HARDIRQ-unsafe_lock_order_detected                         | 0          | 4          |
| calltrace:srcu_invoke_callbacks                                                  | 0          | 1          |
| RIP:_raw_spin_unlock_irq                                                         | 0          | 1          |
| RIP:finish_task_switch                                                           | 0          | 1          |
| RIP:torture_random[torture]                                                      | 0          | 5          |
| RIP:rcu_is_watching                                                              | 0          | 3          |
| RIP:delay_tsc                                                                    | 0          | 4          |
| RIP:lock_acquire                                                                 | 0          | 2          |
| RIP:rcu_read_delay[rcutorture]                                                   | 0          | 1          |
| RIP:rcutorture_one_extend[rcutorture]                                            | 0          | 12         |
| RIP:default_idle                                                                 | 0          | 6          |
| RIP:_raw_spin_unlock_irqrestore                                                  | 0          | 2          |
| RIP:__kasan_check_read                                                           | 0          | 1          |
| RIP:rcu_read_lock_sched_held                                                     | 0          | 4          |
| RIP:__srcu_read_unlock                                                           | 0          | 1          |
| RIP:get_state_synchronize_rcu                                                    | 0          | 1          |
| RIP:__this_cpu_preempt_check                                                     | 0          | 1          |
| RIP:_raw_write_unlock_irq                                                        | 0          | 1          |
| RIP:rcu_scale_wait_shutdown[rcuscale]                                            | 0          | 1          |
| RIP:__rcu_read_lock                                                              | 0          | 1          |
| RIP:preempt_schedule_irq                                                         | 0          | 1          |
| RIP:debug_smp_processor_id                                                       | 0          | 1          |
| RIP:get_state_synchronize_srcu                                                   | 0          | 1          |
| RIP:rcu_read_lock_held_common                                                    | 0          | 1          |
| RIP:__handle_mm_fault                                                            | 0          | 1          |
| RIP:finish_fault                                                                 | 0          | 1          |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[    6.384600] BUG: sleeping function called from invalid context at mm/page_alloc.c:5036
[    6.385429] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
[    6.386242] no locks held by swapper/0/1.
[    6.386669] irq event stamp: 2982
[    6.387029] hardirqs last enabled at (2981): _raw_spin_unlock_irqrestore (kbuild/src/consumer/include/linux/spinlock_api_smp.h:160 kbuild/src/consumer/kernel/locking/spinlock.c:191) 
[    6.387476] hardirqs last disabled at (2982): __slab_alloc+0x77/0xb0 
[    6.387476] softirqs last enabled at (2840): __do_softirq (kbuild/src/consumer/arch/x86/include/asm/preempt.h:27 kbuild/src/consumer/kernel/softirq.c:403 kbuild/src/consumer/kernel/softirq.c:588) 
[    6.387476] softirqs last disabled at (2831): irq_exit_rcu (kbuild/src/consumer/kernel/softirq.c:433 kbuild/src/consumer/kernel/softirq.c:637 kbuild/src/consumer/kernel/softirq.c:649) 
[    6.387476] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc1-03128-gad36bafb3bcd #1
[    6.387476] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[    6.387476] Call Trace:
[    6.387476] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:122) 
[    6.387476] ? get_partial_node+0x45/0x530 
[    6.387476] dump_stack (kbuild/src/consumer/lib/dump_stack.c:138) 
[    6.387476] ___might_sleep.cold (kbuild/src/consumer/kernel/sched/core.c:9148) 
[    6.387476] __might_sleep (kbuild/src/consumer/kernel/sched/core.c:9102 (discriminator 14)) 
[    6.387476] __alloc_pages (kbuild/src/consumer/include/linux/kernel.h:91 kbuild/src/consumer/mm/page_alloc.c:5036 kbuild/src/consumer/mm/page_alloc.c:5228) 
[    6.387476] ? __alloc_pages_slowpath+0x22e0/0x22e0 
[    6.387476] ? __kernel_text_address (kbuild/src/consumer/kernel/extable.c:105) 
[    6.387476] ? arch_stack_walk (kbuild/src/consumer/arch/x86/kernel/stacktrace.c:27 (discriminator 1)) 
[    6.387476] alloc_page_interleave (kbuild/src/consumer/include/linux/instrumented.h:71 kbuild/src/consumer/include/asm-generic/atomic-instrumented.h:27 kbuild/src/consumer/include/linux/jump_label.h:266 kbuild/src/consumer/mm/mempolicy.c:2149) 
[    6.387476] alloc_pages (kbuild/src/consumer/mm/mempolicy.c:2277) 
[    6.387476] ? __kernfs_new_node+0xd5/0x790 
[    6.387476] stack_depot_save (kbuild/src/consumer/lib/stackdepot.c:304) 
[    6.387476] ? __kernfs_new_node+0xd5/0x790 
[    6.387476] save_stack_trace+0x2b/0x30 
[    6.387476] ? __slab_alloc+0x9f/0xb0 
[    6.387476] ? kmem_cache_alloc (kbuild/src/consumer/mm/slub.c:2920 kbuild/src/consumer/mm/slub.c:2962 kbuild/src/consumer/mm/slub.c:2967) 
[    6.387476] ? __kernfs_new_node+0xd5/0x790 
[    6.387476] ? kernfs_new_node (kbuild/src/consumer/fs/kernfs/dir.c:688) 
[    6.387476] ? __kernfs_create_file (kbuild/src/consumer/fs/kernfs/file.c:987) 
[    6.387476] ? sysfs_add_file_mode_ns (kbuild/src/consumer/fs/sysfs/file.c:324) 
[    6.387476] ? sysfs_create_file_ns (kbuild/src/consumer/fs/sysfs/file.c:343) 
[    6.387476] ? bus_create_file (kbuild/src/consumer/drivers/base/bus.c:54 kbuild/src/consumer/drivers/base/bus.c:136) 
[    6.387476] ? bus_register (kbuild/src/consumer/drivers/base/bus.c:567 kbuild/src/consumer/drivers/base/bus.c:835) 
[    6.387476] ? subsys_register (kbuild/src/consumer/drivers/base/bus.c:1087) 
[    6.387476] ? subsys_system_register (kbuild/src/consumer/drivers/base/bus.c:1144) 
[    6.387476] ? cpu_dev_init (kbuild/src/consumer/drivers/base/cpu.c:608) 
[    6.387476] ? driver_init (kbuild/src/consumer/drivers/base/init.c:37) 
[    6.387476] ? kernel_init_freeable (kbuild/src/consumer/init/main.c:1395 kbuild/src/consumer/init/main.c:1600) 
[    6.387476] ? kernel_init (kbuild/src/consumer/init/main.c:1489) 
[    6.387476] ? ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:300) 
[    6.387476] set_track (kbuild/src/consumer/mm/slub.c:628) 
[    6.387476] alloc_debug_processing (kbuild/src/consumer/mm/slub.c:1208) 
[    6.387476] ___slab_alloc (kbuild/src/consumer/mm/slub.c:2810) 
[    6.387476] ? __kernfs_new_node+0xd5/0x790 
[    6.387476] ? __slab_alloc+0x77/0xb0 
[    6.387476] ? kmem_cache_alloc (kbuild/src/consumer/mm/slub.c:2920 kbuild/src/consumer/mm/slub.c:2962 kbuild/src/consumer/mm/slub.c:2967) 
[    6.387476] __slab_alloc+0x9f/0xb0 
[    6.387476] ? __kernfs_new_node+0xd5/0x790 
[    6.387476] kmem_cache_alloc (kbuild/src/consumer/mm/slub.c:2920 kbuild/src/consumer/mm/slub.c:2962 kbuild/src/consumer/mm/slub.c:2967) 
[    6.387476] __kernfs_new_node+0xd5/0x790 
[    6.387476] ? kernfs_fop_readdir (kbuild/src/consumer/fs/kernfs/dir.c:612) 
[    6.387476] ? wait_for_completion (kbuild/src/consumer/kernel/locking/mutex.c:1216) 
[    6.387476] ? mutex_unlock (kbuild/src/consumer/kernel/locking/mutex.c:731) 
[    6.387476] ? kernfs_activate (kbuild/src/consumer/fs/kernfs/dir.c:1281) 
[    6.387476] kernfs_new_node (kbuild/src/consumer/fs/kernfs/dir.c:688) 
[    6.387476] __kernfs_create_file (kbuild/src/consumer/fs/kernfs/file.c:987) 
[    6.387476] sysfs_add_file_mode_ns (kbuild/src/consumer/fs/sysfs/file.c:324) 
[    6.387476] ? kfree_const (kbuild/src/consumer/mm/util.c:41) 
[    6.387476] ? kobject_set_name_vargs (kbuild/src/consumer/lib/kobject.c:310) 
[    6.387476] sysfs_create_file_ns (kbuild/src/consumer/fs/sysfs/file.c:343) 
[    6.387476] ? kernfs_get (kbuild/src/consumer/arch/x86/include/asm/atomic.h:95 (discriminator 3) kbuild/src/consumer/include/asm-generic/atomic-instrumented.h:241 (discriminator 3) kbuild/src/consumer/fs/kernfs/dir.c:495 (discriminator 3)) 
[    6.387476] ? sysfs_add_file_mode_ns (kbuild/src/consumer/fs/sysfs/file.c:335) 
[    6.387476] bus_create_file (kbuild/src/consumer/drivers/base/bus.c:54 kbuild/src/consumer/drivers/base/bus.c:136) 
[    6.387476] bus_register (kbuild/src/consumer/drivers/base/bus.c:567 kbuild/src/consumer/drivers/base/bus.c:835) 
[    6.387476] subsys_register (kbuild/src/consumer/drivers/base/bus.c:1087) 
[    6.387476] subsys_system_register (kbuild/src/consumer/drivers/base/bus.c:1144) 
[    6.387476] cpu_dev_init (kbuild/src/consumer/drivers/base/cpu.c:608) 
[    6.387476] driver_init (kbuild/src/consumer/drivers/base/init.c:37) 
[    6.387476] kernel_init_freeable (kbuild/src/consumer/init/main.c:1395 kbuild/src/consumer/init/main.c:1600) 
[    6.387476] ? rest_init (kbuild/src/consumer/init/main.c:1484) 
[    6.387476] kernel_init (kbuild/src/consumer/init/main.c:1489) 
[    6.387476] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:300) 
[    6.387900] x86/mm: Memory block size: 128MB
[    6.449462] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    6.450545] futex hash table entries: 512 (order: 4, 65536 bytes, linear)
[    6.451199] pinctrl core: initialized pinctrl subsystem
[    6.451763] pinctrl core: failed to create debugfs directory
[    6.455334] NET: Registered protocol family 16
[    6.459424] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    6.460320] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    6.460942] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    6.465270] thermal_sys: Registered thermal governor 'user_space'
[    6.465524] EISA bus registered
[    6.466657] cpuidle: using governor ladder
[    6.468049] Callback from call_rcu_tasks_trace() invoked.
[    6.468804] Callback from call_rcu_tasks_rude() invoked.
[    6.468800] ACPI: bus type PCI registered
[    6.469928] PCI: Using configuration type 1 for base access
[    6.728660] cryptomgr_test (33) used greatest stack depth: 29432 bytes left
[    6.743101] cryptd: max_cpu_qlen set to 1000
[    6.817477] raid6: sse2x4   gen() 10916 MB/s
[    6.817567] Callback from call_rcu_tasks() invoked.
[    6.873723] raid6: sse2x4   xor()  6327 MB/s
[    6.930478] raid6: sse2x2   gen() 10395 MB/s
[    6.987162] raid6: sse2x2   xor()  6272 MB/s
[    7.043852] raid6: sse2x1   gen()  7328 MB/s
[    7.100533] raid6: sse2x1   xor()  4848 MB/s
[    7.100823] raid6: using algorithm sse2x4 gen() 10916 MB/s
[    7.101406] raid6: .... xor() 6327 MB/s, rmw enabled
[    7.101929] raid6: using ssse3x2 recovery algorithm
[    7.104598] ACPI: Added _OSI(Module Device)
[    7.105060] ACPI: Added _OSI(Processor Device)
[    7.105551] ACPI: Added _OSI(3.0 _SCP Extensions)
[    7.106055] ACPI: Added _OSI(Processor Aggregator Device)
[    7.106650] ACPI: Added _OSI(Linux-Dell-Video)
[    7.107158] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    7.107510] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    7.150345] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    7.191306] ACPI: Interpreter enabled
[    7.191815] ACPI: (supports S0 S5)
[    7.192217] ACPI: Using IOAPIC for interrupt routing
[    7.193064] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    7.197400] ACPI: Enabled 2 GPEs in block 00 to 0F
[    7.297146] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    7.297538] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    7.298754] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    7.309773] PCI host bridge to bus 0000:00
[    7.310281] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    7.310836] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    7.311583] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    7.312415] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    7.313250] pci_bus 0000:00: root bus resource [mem 0x440000000-0x4bfffffff window]
[    7.314089] pci_bus 0000:00: root bus resource [bus 00-ff]
[    7.314441] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    7.319375] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    7.324013] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    7.327090] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    7.328680] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    7.329434] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    7.330128] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    7.330825] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    7.334549] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    7.335727] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    7.336504] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    7.340963] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    7.344104] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    7.346033] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    7.350840] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    7.355365] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    7.356835] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    7.358250] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    7.362520] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    7.367215] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
[    7.367928] pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]


To reproduce:

        # build kernel
	cd linux
	cp config-5.13.0-rc1-03128-gad36bafb3bcd .config
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.13.0-rc1-03128-gad36bafb3bcd"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.13.0-rc1 Kernel Configuration
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
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
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
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_FORCE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

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
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
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

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
# CONFIG_NUMA_BALANCING_DEFAULT_ENABLED is not set
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_UCLAMP_TASK_GROUP=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_TIME_NS is not set
# CONFIG_IPC_NS is not set
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
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
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
# CONFIG_EMBEDDED is not set
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
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
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
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
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
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
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
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_SCHED_MC_PRIO is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_I8K=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_FPDT=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
# CONFIG_DPTF_PCH_FIVR is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_PMIC_OPREGION=y
# CONFIG_BYTCRC_PMIC_OPREGION is not set
# CONFIG_CHTCRC_PMIC_OPREGION is not set
CONFIG_XPOWER_PMIC_OPREGION=y
CONFIG_CHT_DC_TI_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_P4_CLOCKMOD=y

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
# CONFIG_CPU_IDLE_GOV_MENU is not set
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
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
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
# CONFIG_EFI_CAPSULE_LOADER is not set
CONFIG_EFI_TEST=y
CONFIG_APPLE_PROPERTIES=y
CONFIG_RESET_ATTACK_MITIGATION=y
# CONFIG_EFI_RCI2_TABLE is not set
CONFIG_EFI_DISABLE_PCI_DMA=y
# end of EFI (Extensible Firmware Interface) Support

CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set

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
CONFIG_CRASH_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_STATIC_CALL_SELFTEST=y
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
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
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
CONFIG_ISA_BUS_API=y
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
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
CONFIG_CMDLINE_PARTITION=y
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

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
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
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
# CONFIG_ZONE_DEVICE is not set
CONFIG_HMM_MIRROR=y
CONFIG_VMAP_PFN=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_IO_MAPPING=y
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
# CONFIG_MPTCP is not set
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
# CONFIG_PCIEASPM_DEFAULT is not set
CONFIG_PCIEASPM_POWERSAVE=y
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
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
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCIE_DW_PLAT_EP is not set
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
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=y
# CONFIG_PCI_EPF_NTB is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
# CONFIG_CXL_MEM is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
# CONFIG_MHI_BUS_DEBUG is not set
CONFIG_MHI_BUS_PCI_GENERIC=y
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_FTL=y
CONFIG_NFTL=y
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
CONFIG_MTD_SCB2_FLASH=y
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
CONFIG_MTD_DATAFLASH_OTP=y
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
# CONFIG_MTD_ONENAND_GENERIC is not set
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
CONFIG_MTD_NAND_DENALI_PCI=y
CONFIG_MTD_NAND_CAFE=y
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y
CONFIG_MTD_NAND_ARASAN=y

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
CONFIG_MTD_SPI_NAND=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_NAND_ECC_SW_BCH=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
# CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
CONFIG_SPI_INTEL_SPI=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=y
# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=y
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_BLK_DEV_FD=y
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SX8=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=y

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_HWMON=y
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_INTEL_MEI_HDCP=y
# CONFIG_VMWARE_VMCI is not set
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=y
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.rst for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
# CONFIG_IDE_GD_ATA is not set
# CONFIG_IDE_GD_ATAPI is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_BLK_DEV_OPTI621=y
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_PIIX is not set
CONFIG_BLK_DEV_IT8172=y
CONFIG_BLK_DEV_IT8213=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_TC86C001=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_HPSA=y
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AHA1740=y
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_AIC94XX=y
CONFIG_AIC94XX_DEBUG=y
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_DPT_I2O=y
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
CONFIG_SCSI_ESAS2R=y
CONFIG_MEGARAID_NEWGEN=y
# CONFIG_MEGARAID_MM is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_SCSI_HPTIOP=y
CONFIG_SCSI_BUSLOGIC=y
CONFIG_SCSI_FLASHPOINT=y
CONFIG_SCSI_MYRB=y
CONFIG_SCSI_MYRS=y
CONFIG_VMWARE_PVSCSI=y
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
CONFIG_SCSI_ISCI=y
CONFIG_SCSI_IPS=y
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_AM53C974=y
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=y
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

# CONFIG_ATA is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
CONFIG_BCACHE_CLOSURES_DEBUG=y
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
# CONFIG_BLK_DEV_DM is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=y
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
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
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
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
CONFIG_NET_VENDOR_MICROSOFT=y
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

# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
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
# CONFIG_WWAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
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
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
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
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
CONFIG_TOUCHSCREEN_AD7877=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
CONFIG_TOUCHSCREEN_CY8CTMA140=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
# CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=y
CONFIG_TOUCHSCREEN_DA9034=y
CONFIG_TOUCHSCREEN_DA9052=y
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MSG2638=y
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_INEXIO=y
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=y
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
CONFIG_TOUCHSCREEN_WM831X=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set
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
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_BCM63XX=y
CONFIG_SERIAL_BCM63XX_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_FSL_LINFLEXUART=y
# CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE is not set
CONFIG_SERIAL_SPRD=y
# CONFIG_SERIAL_SPRD_CONSOLE is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=y
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_IPMB_DEVICE_INTERFACE=y
# CONFIG_HW_RANDOM is not set
CONFIG_APPLICOM=y
CONFIG_MWAVE=y
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_DEVPORT is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=y
# CONFIG_TCG_TIS_SPI_CR50 is not set
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TCG_TIS_ST33ZP24_SPI=y
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=y
CONFIG_I2C_AMD8111=y
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_ALTERA_DFL=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
# CONFIG_SPI_ZYNQMP_GQSPI is not set
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_DA9062=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_TIGERLAKE=y

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_CRYSTAL_COVE=y
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_JANZ_TTL is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM831X=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set
CONFIG_GPIO_XRA1403=y
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
CONFIG_MAX8925_POWER=y
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_CW2015=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=y
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_CORSAIR_PSU=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2947_SPI=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
CONFIG_SENSORS_BPA_RS600=y
CONFIG_SENSORS_FSP_3Y=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_INSPUR_IPSPS=y
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_IRPS5401=y
# CONFIG_SENSORS_ISL68137 is not set
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_MP2888 is not set
CONFIG_SENSORS_MP2975=y
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
CONFIG_SENSORS_STPDDC60=y
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_XDPE122=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=y
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_PCI is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_MADERA_SPI=y
# CONFIG_MFD_CS47L15 is not set
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_PMT=y
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
# CONFIG_PCF50633_GPIO is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ATC260X=y
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6315 is not set
CONFIG_REGULATOR_MT6323=y
# CONFIG_REGULATOR_MT6358 is not set
CONFIG_REGULATOR_MT6360=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=y
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6524X=y
# CONFIG_REGULATOR_TPS6586X is not set
# CONFIG_REGULATOR_TPS65912 is not set
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
# CONFIG_RC_MAP is not set
CONFIG_LIRC=y
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
# CONFIG_MEDIA_CEC_RC is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=y
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
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FWNODE=y
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
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_DVB_TEST_DRIVERS=y
CONFIG_DVB_VIDTV=y

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=y

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
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_CCS_PLL=y
CONFIG_VIDEO_HI556=y
CONFIG_VIDEO_IMX214=y
CONFIG_VIDEO_IMX219=y
# CONFIG_VIDEO_IMX258 is not set
CONFIG_VIDEO_IMX274=y
# CONFIG_VIDEO_IMX290 is not set
CONFIG_VIDEO_IMX319=y
CONFIG_VIDEO_IMX355=y
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
CONFIG_VIDEO_OV2659=y
# CONFIG_VIDEO_OV2680 is not set
CONFIG_VIDEO_OV2685=y
CONFIG_VIDEO_OV2740=y
# CONFIG_VIDEO_OV5647 is not set
CONFIG_VIDEO_OV5648=y
# CONFIG_VIDEO_OV6650 is not set
CONFIG_VIDEO_OV5670=y
CONFIG_VIDEO_OV5675=y
CONFIG_VIDEO_OV5695=y
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7640=y
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV8856=y
# CONFIG_VIDEO_OV8865 is not set
CONFIG_VIDEO_OV9640=y
CONFIG_VIDEO_OV9650=y
CONFIG_VIDEO_OV9734=y
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
CONFIG_VIDEO_MT9M032=y
# CONFIG_VIDEO_MT9M111 is not set
CONFIG_VIDEO_MT9P031=y
CONFIG_VIDEO_MT9T001=y
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
# CONFIG_VIDEO_MT9V032 is not set
CONFIG_VIDEO_MT9V111=y
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
CONFIG_VIDEO_M5MOLS=y
CONFIG_VIDEO_MAX9271_LIB=y
CONFIG_VIDEO_RDACM20=y
CONFIG_VIDEO_RDACM21=y
CONFIG_VIDEO_RJ54N1=y
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
CONFIG_VIDEO_S5K4ECGX=y
CONFIG_VIDEO_S5K5BAF=y
CONFIG_VIDEO_CCS=y
CONFIG_VIDEO_ET8EK8=y
CONFIG_VIDEO_S5C73M3=y
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_AK7375=y
CONFIG_VIDEO_DW9714=y
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
CONFIG_VIDEO_LM3646=y
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
# CONFIG_MEDIA_TUNER_MT2063 is not set
# CONFIG_MEDIA_TUNER_MT2266 is not set
# CONFIG_MEDIA_TUNER_MT2131 is not set
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
# CONFIG_MEDIA_TUNER_MXL5005S is not set
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_MC44S803=y
# CONFIG_MEDIA_TUNER_MAX2165 is not set
# CONFIG_MEDIA_TUNER_TDA18218 is not set
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
# CONFIG_MEDIA_TUNER_FC0013 is not set
# CONFIG_MEDIA_TUNER_TDA18212 is not set
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC2580 is not set
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
# CONFIG_MEDIA_TUNER_TUA9001 is not set
# CONFIG_MEDIA_TUNER_SI2157 is not set
# CONFIG_MEDIA_TUNER_IT913X is not set
# CONFIG_MEDIA_TUNER_R820T is not set
# CONFIG_MEDIA_TUNER_MXL301RF is not set
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_STB0899 is not set
# CONFIG_DVB_STB6100 is not set
# CONFIG_DVB_STV090x is not set
# CONFIG_DVB_STV0910 is not set
# CONFIG_DVB_STV6110x is not set
# CONFIG_DVB_STV6111 is not set
# CONFIG_DVB_MXL5XX is not set
# CONFIG_DVB_M88DS3103 is not set

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
# CONFIG_DVB_TDA18271C2DD is not set
# CONFIG_DVB_SI2165 is not set
# CONFIG_DVB_MN88472 is not set
# CONFIG_DVB_MN88473 is not set

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
# CONFIG_DVB_CX24123 is not set
# CONFIG_DVB_MT312 is not set
# CONFIG_DVB_ZL10036 is not set
# CONFIG_DVB_ZL10039 is not set
# CONFIG_DVB_S5H1420 is not set
# CONFIG_DVB_STV0288 is not set
# CONFIG_DVB_STB6000 is not set
# CONFIG_DVB_STV0299 is not set
# CONFIG_DVB_STV6110 is not set
# CONFIG_DVB_STV0900 is not set
# CONFIG_DVB_TDA8083 is not set
# CONFIG_DVB_TDA10086 is not set
# CONFIG_DVB_TDA8261 is not set
# CONFIG_DVB_VES1X93 is not set
# CONFIG_DVB_TUNER_ITD1000 is not set
# CONFIG_DVB_TUNER_CX24113 is not set
# CONFIG_DVB_TDA826X is not set
# CONFIG_DVB_TUA6100 is not set
# CONFIG_DVB_CX24116 is not set
# CONFIG_DVB_CX24117 is not set
# CONFIG_DVB_CX24120 is not set
# CONFIG_DVB_SI21XX is not set
# CONFIG_DVB_TS2020 is not set
# CONFIG_DVB_DS3000 is not set
# CONFIG_DVB_MB86A16 is not set
# CONFIG_DVB_TDA10071 is not set

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_CX22700 is not set
# CONFIG_DVB_CX22702 is not set
# CONFIG_DVB_S5H1432 is not set
# CONFIG_DVB_DRXD is not set
# CONFIG_DVB_L64781 is not set
# CONFIG_DVB_TDA1004X is not set
# CONFIG_DVB_NXT6000 is not set
# CONFIG_DVB_MT352 is not set
# CONFIG_DVB_ZL10353 is not set
# CONFIG_DVB_DIB3000MB is not set
# CONFIG_DVB_DIB3000MC is not set
# CONFIG_DVB_DIB7000M is not set
# CONFIG_DVB_DIB7000P is not set
# CONFIG_DVB_DIB9000 is not set
# CONFIG_DVB_TDA10048 is not set
# CONFIG_DVB_AF9013 is not set
# CONFIG_DVB_EC100 is not set
# CONFIG_DVB_STV0367 is not set
# CONFIG_DVB_CXD2820R is not set
# CONFIG_DVB_CXD2841ER is not set
# CONFIG_DVB_RTL2830 is not set
# CONFIG_DVB_RTL2832 is not set
# CONFIG_DVB_SI2168 is not set
# CONFIG_DVB_ZD1301_DEMOD is not set
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
# CONFIG_DVB_TDA10021 is not set
# CONFIG_DVB_TDA10023 is not set
# CONFIG_DVB_STV0297 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
# CONFIG_DVB_OR51211 is not set
# CONFIG_DVB_OR51132 is not set
# CONFIG_DVB_BCM3510 is not set
# CONFIG_DVB_LGDT330X is not set
# CONFIG_DVB_LGDT3305 is not set
# CONFIG_DVB_LGDT3306A is not set
# CONFIG_DVB_LG2160 is not set
# CONFIG_DVB_S5H1409 is not set
# CONFIG_DVB_AU8522_DTV is not set
# CONFIG_DVB_AU8522_V4L is not set
# CONFIG_DVB_S5H1411 is not set
# CONFIG_DVB_MXL692 is not set

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_S921 is not set
# CONFIG_DVB_DIB8000 is not set
# CONFIG_DVB_MB86A20S is not set

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_TC90522 is not set
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
# CONFIG_DVB_TUNER_DIB0070 is not set
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_DRX39XYJ is not set
# CONFIG_DVB_LNBH25 is not set
# CONFIG_DVB_LNBH29 is not set
# CONFIG_DVB_LNBP21 is not set
# CONFIG_DVB_LNBP22 is not set
# CONFIG_DVB_ISL6405 is not set
# CONFIG_DVB_ISL6421 is not set
# CONFIG_DVB_ISL6423 is not set
# CONFIG_DVB_A8293 is not set
# CONFIG_DVB_LGS8GL5 is not set
# CONFIG_DVB_LGS8GXX is not set
# CONFIG_DVB_ATBM8830 is not set
# CONFIG_DVB_TDA665x is not set
# CONFIG_DVB_IX2505V is not set
# CONFIG_DVB_M88RS2000 is not set
# CONFIG_DVB_AF9033 is not set
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
# CONFIG_DVB_CXD2099 is not set
# CONFIG_DVB_SP2 is not set
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_RADEON=y
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=y
# CONFIG_DRM_AMDGPU_SI is not set
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
# CONFIG_DRM_AMD_DC is not set
# CONFIG_DRM_AMD_DC_SI is not set
# end of Display Engine Configuration

CONFIG_HSA_AMD=y
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
# CONFIG_DRM_I915_COMPRESS_ERROR is not set
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y

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
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
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
# CONFIG_DRM_AST is not set
CONFIG_DRM_MGAG200=y
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_CIRRUS_QEMU=y
# CONFIG_DRM_SIMPLEDRM is not set
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9225=y
CONFIG_TINYDRM_ILI9341=y
CONFIG_TINYDRM_ILI9486=y
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
CONFIG_TINYDRM_ST7586=y
CONFIG_TINYDRM_ST7735R=y
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=y
CONFIG_DRM_R128=y
CONFIG_DRM_MGA=y
CONFIG_DRM_VIA=y
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
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
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
# CONFIG_FB_ATY_GX is not set
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=y
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=y
# CONFIG_LCD_PLATFORM is not set
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
CONFIG_LCD_HX8357=y
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_CARILLO_RANCH=y
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_MAX8925 is not set
CONFIG_BACKLIGHT_APPLE=y
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_VIVALDI=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PLAYSTATION is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=y
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
CONFIG_AMD_SFH_HID=y
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
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
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y
CONFIG_LEDS_TPS6105X=y

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=y
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
CONFIG_VFIO_MDEV=y
# CONFIG_VFIO_MDEV_DEVICE is not set
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_NITRO_ENCLAVES=y
CONFIG_VIRTIO=y
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
CONFIG_COMEDI_PCL726=y
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
CONFIG_COMEDI_PCL816=y
# CONFIG_COMEDI_PCL818 is not set
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=y
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
# CONFIG_COMEDI_DAS800 is not set
# CONFIG_COMEDI_DAS1800 is not set
# CONFIG_COMEDI_DAS6402 is not set
CONFIG_COMEDI_DT2801=y
CONFIG_COMEDI_DT2811=y
# CONFIG_COMEDI_DT2814 is not set
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=y
CONFIG_COMEDI_DMM32AT=y
CONFIG_COMEDI_FL512=y
CONFIG_COMEDI_AIO_AIO12_8=y
CONFIG_COMEDI_AIO_IIRO_16=y
# CONFIG_COMEDI_II_PCI20KC is not set
CONFIG_COMEDI_C6XDIGIO=y
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
# CONFIG_COMEDI_NI_AT_AO is not set
# CONFIG_COMEDI_NI_ATMIO is not set
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
# CONFIG_COMEDI_PCMUIO is not set
# CONFIG_COMEDI_MULTIQ3 is not set
CONFIG_COMEDI_S526=y
CONFIG_COMEDI_PCI_DRIVERS=y
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=y
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
CONFIG_COMEDI_ADDI_APCI_1500=y
# CONFIG_COMEDI_ADDI_APCI_1516 is not set
CONFIG_COMEDI_ADDI_APCI_1564=y
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
# CONFIG_COMEDI_ADDI_APCI_2032 is not set
CONFIG_COMEDI_ADDI_APCI_2200=y
CONFIG_COMEDI_ADDI_APCI_3120=y
CONFIG_COMEDI_ADDI_APCI_3501=y
CONFIG_COMEDI_ADDI_APCI_3XXX=y
CONFIG_COMEDI_ADL_PCI6208=y
# CONFIG_COMEDI_ADL_PCI7X3X is not set
# CONFIG_COMEDI_ADL_PCI8164 is not set
# CONFIG_COMEDI_ADL_PCI9111 is not set
# CONFIG_COMEDI_ADL_PCI9118 is not set
CONFIG_COMEDI_ADV_PCI1710=y
# CONFIG_COMEDI_ADV_PCI1720 is not set
# CONFIG_COMEDI_ADV_PCI1723 is not set
CONFIG_COMEDI_ADV_PCI1724=y
CONFIG_COMEDI_ADV_PCI1760=y
CONFIG_COMEDI_ADV_PCI_DIO=y
CONFIG_COMEDI_AMPLC_DIO200_PCI=y
CONFIG_COMEDI_AMPLC_PC236_PCI=y
CONFIG_COMEDI_AMPLC_PC263_PCI=y
# CONFIG_COMEDI_AMPLC_PCI224 is not set
CONFIG_COMEDI_AMPLC_PCI230=y
CONFIG_COMEDI_CONTEC_PCI_DIO=y
CONFIG_COMEDI_DAS08_PCI=y
CONFIG_COMEDI_DT3000=y
CONFIG_COMEDI_DYNA_PCI10XX=y
# CONFIG_COMEDI_GSC_HPDI is not set
CONFIG_COMEDI_MF6X4=y
CONFIG_COMEDI_ICP_MULTI=y
# CONFIG_COMEDI_DAQBOARD2000 is not set
CONFIG_COMEDI_JR3_PCI=y
# CONFIG_COMEDI_KE_COUNTER is not set
# CONFIG_COMEDI_CB_PCIDAS64 is not set
CONFIG_COMEDI_CB_PCIDAS=y
CONFIG_COMEDI_CB_PCIDDA=y
CONFIG_COMEDI_CB_PCIMDAS=y
CONFIG_COMEDI_CB_PCIMDDA=y
CONFIG_COMEDI_ME4000=y
CONFIG_COMEDI_ME_DAQ=y
# CONFIG_COMEDI_NI_6527 is not set
CONFIG_COMEDI_NI_65XX=y
# CONFIG_COMEDI_NI_660X is not set
CONFIG_COMEDI_NI_670X=y
CONFIG_COMEDI_NI_LABPC_PCI=y
CONFIG_COMEDI_NI_PCIDIO=y
# CONFIG_COMEDI_NI_PCIMIO is not set
CONFIG_COMEDI_RTD520=y
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
# CONFIG_COMEDI_KCOMEDILIB is not set
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
# CONFIG_RTLLIB is not set
CONFIG_RTS5208=y
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_GS_FPGABOOT=y
CONFIG_UNISYSSPAR=y
# CONFIG_UNISYS_VISORNIC is not set
CONFIG_UNISYS_VISORINPUT=y
# CONFIG_UNISYS_VISORHBA is not set
CONFIG_FB_TFT=y
CONFIG_FB_TFT_AGM1264K_FL=y
CONFIG_FB_TFT_BD663474=y
CONFIG_FB_TFT_HX8340BN=y
CONFIG_FB_TFT_HX8347D=y
# CONFIG_FB_TFT_HX8353D is not set
# CONFIG_FB_TFT_HX8357D is not set
# CONFIG_FB_TFT_ILI9163 is not set
# CONFIG_FB_TFT_ILI9320 is not set
CONFIG_FB_TFT_ILI9325=y
CONFIG_FB_TFT_ILI9340=y
CONFIG_FB_TFT_ILI9341=y
CONFIG_FB_TFT_ILI9481=y
CONFIG_FB_TFT_ILI9486=y
CONFIG_FB_TFT_PCD8544=y
CONFIG_FB_TFT_RA8875=y
# CONFIG_FB_TFT_S6D02A1 is not set
# CONFIG_FB_TFT_S6D1121 is not set
CONFIG_FB_TFT_SEPS525=y
CONFIG_FB_TFT_SH1106=y
CONFIG_FB_TFT_SSD1289=y
CONFIG_FB_TFT_SSD1305=y
CONFIG_FB_TFT_SSD1306=y
# CONFIG_FB_TFT_SSD1331 is not set
CONFIG_FB_TFT_SSD1351=y
# CONFIG_FB_TFT_ST7735R is not set
CONFIG_FB_TFT_ST7789V=y
CONFIG_FB_TFT_TINYLCD=y
CONFIG_FB_TFT_TLS8204=y
# CONFIG_FB_TFT_UC1611 is not set
CONFIG_FB_TFT_UC1701=y
# CONFIG_FB_TFT_UPD161704 is not set
CONFIG_FB_TFT_WATTEROTT=y
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CHROMEOS_TBMC=y
# CONFIG_CROS_EC is not set
CONFIG_CROS_KBD_LED_BACKLIGHT=y
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE_3_POWER_OPREGION=y
CONFIG_SURFACE_GPE=y
CONFIG_SURFACE_HOTPLUG=y
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_COMMON_CLK_PALMAS=y
CONFIG_XILINX_VCU=y
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
# CONFIG_AMD_IOMMU is not set
# CONFIG_AMD_IOMMU_V2 is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_NS=y
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
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
CONFIG_FPGA_DFL_EMIF=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
CONFIG_IDLE_INJECT=y
CONFIG_DTPM=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
CONFIG_USB4=y
CONFIG_USB4_DEBUGFS_WRITE=y
CONFIG_USB4_KUNIT_TEST=y
CONFIG_USB4_DMA_TEST=y

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
CONFIG_ND_BLK=y
# CONFIG_BTT is not set
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_DEV_DAX_HMEM=y
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_ACPI=y
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_FPGA_DFL=y
# CONFIG_FPGA_DFL_FME is not set
# CONFIG_FPGA_DFL_AFU is not set
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=y
# CONFIG_FPGA_DFL_PCI is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
# end of Multiplexer drivers

CONFIG_UNISYS_VISORBUS=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_FUSE_DAX=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
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
CONFIG_TMPFS_INODE64=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
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
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_STRICT_FOLLOW_PFN is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
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

CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_ADIANTUM=y
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
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
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
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
CONFIG_DECOMPRESS_XZ=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
CONFIG_DMA_PERNUMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
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
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_FRAME_POINTER=y
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
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
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
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_KUNIT_TEST is not set
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
CONFIG_KFENCE_KUNIT_TEST=m
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
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
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
CONFIG_WW_MUTEX_SELFTEST=y
# CONFIG_SCF_TORTURE_TEST is not set
CONFIG_CSD_LOCK_WAIT_DEBUG=y
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
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
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
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
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
CONFIG_SAMPLE_AUXDISPLAY=y
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_CONFIGFS is not set
CONFIG_SAMPLE_HIDRAW=y
CONFIG_SAMPLE_LANDLOCK=y
# CONFIG_SAMPLE_PIDFD is not set
CONFIG_SAMPLE_TIMER=y
CONFIG_SAMPLE_UHID=y
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_ANDROID_BINDERFS is not set
# CONFIG_SAMPLE_VFS is not set
CONFIG_SAMPLE_INTEL_MEI=y
# CONFIG_SAMPLE_WATCHDOG is not set
# CONFIG_SAMPLE_WATCH_QUEUE is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

#
# x86 Debugging
#
# CONFIG_DEBUG_AID_FOR_SYZBOT is not set
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
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
# CONFIG_KCOV_ENABLE_COMPARISONS is not set
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
CONFIG_TEST_DIV64=y
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=y
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=y
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
# CONFIG_TEST_SYSCTL is not set
CONFIG_BITFIELD_KUNIT=y
CONFIG_RESOURCE_KUNIT_TEST=y
CONFIG_SYSCTL_KUNIT_TEST=y
CONFIG_LIST_KUNIT_TEST=y
CONFIG_LINEAR_RANGES_TEST=y
# CONFIG_CMDLINE_KUNIT_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_SLUB_KUNIT_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='rcuscale'
	export testcase='rcuscale'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='rcuscale.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-229'
	export tbox_group='vm-snb'
	export branch='linux-next/master'
	export commit='ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597'
	export kconfig='x86_64-randconfig-a005-20210514'
	export repeat_to=12
	export nr_vm=160
	export submit_id='609fc2391907fe04240aa373'
	export job_file='/lkp/jobs/scheduled/vm-snb-229/rcuscale-300s-tasks-debian-10.4-x86_64-20200603.cgz-ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597-20210515-1060-126pwmi-11.yaml'
	export id='de59dd563915c354346f3a1fd0c76313eaa2d924'
	export queuer_version='/lkp-src'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig='CONFIG_RCU_PERF_TEST=m ~ "<= v5.9"
CONFIG_RCU_SCALE_TEST=m ~ ">= v5.10-rc1"
CONFIG_SECURITY_LOADPIN_ENABLED=n ~ "<= v4.19"
CONFIG_SECURITY_LOADPIN_ENFORCE=n ~ ">= v4.20"
CONFIG_KVM_GUEST=y'
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=512M'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export compiler='gcc-9'
	export enqueue_time='2021-05-15 20:44:41 +0800'
	export _id='609fc23b1907fe04240aa378'
	export _rt='/result/rcuscale/300s-tasks/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a005-20210514/gcc-9/ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/rcuscale/300s-tasks/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a005-20210514/gcc-9/ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597/8'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-229/rcuscale-300s-tasks-debian-10.4-x86_64-20200603.cgz-ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597-20210515-1060-126pwmi-11.yaml
ARCH=x86_64
kconfig=x86_64-randconfig-a005-20210514
branch=linux-next/master
commit=ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a005-20210514/gcc-9/ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597/vmlinuz-5.13.0-rc1-03128-gad36bafb3bcd
vmalloc=512M
max_uptime=2100
RESULT_ROOT=/result/rcuscale/300s-tasks/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a005-20210514/gcc-9/ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597/8
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-a005-20210514/gcc-9/ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='46a1f7098976'
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-randconfig-a005-20210514/gcc-9/ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597/vmlinuz-5.13.0-rc1-03128-gad36bafb3bcd'
	export dequeue_time='2021-05-15 20:46:35 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-229/rcuscale-300s-tasks-debian-10.4-x86_64-20200603.cgz-ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597-20210515-1060-126pwmi-11.cgz'

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

	run_test scale_type='tasks' $LKP_SRC/tests/wrapper rcuscale
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env scale_type='tasks' $LKP_SRC/stats/wrapper rcuscale
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time rcuscale.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--cWoXeonUoKmBZSoM
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
8IqxxGf7AgAAAAAEWVo=

--cWoXeonUoKmBZSoM--
