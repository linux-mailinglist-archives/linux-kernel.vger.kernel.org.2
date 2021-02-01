Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A982E30A7A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhBAM3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:29:24 -0500
Received: from foss.arm.com ([217.140.110.172]:58636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhBAM3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:29:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3FFEED1;
        Mon,  1 Feb 2021 04:28:30 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10C4B3F718;
        Mon,  1 Feb 2021 04:28:28 -0800 (PST)
Date:   Mon, 1 Feb 2021 12:28:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/core 10/10] hppa64-linux-ld:
 init/do_mounts.o(.text.unlikely+0x104): cannot reach warn_bogus_irq_restore
Message-ID: <20210201122826.GC64300@C02TD0UTHF1T.local>
References: <202101292128.VVZdDf29-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101292128.VVZdDf29-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 09:44:31PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> head:   997acaf6b4b59c6a9c259740312a69ea549cc684
> commit: 997acaf6b4b59c6a9c259740312a69ea549cc684 [10/10] lockdep: report broken irq restoration
> config: parisc-randconfig-r024-20210129 (attached as .config)
> compiler: hppa64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=997acaf6b4b59c6a9c259740312a69ea549cc684
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip locking/core
>         git checkout 997acaf6b4b59c6a9c259740312a69ea549cc684
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

Per the existing warnings, this kernel config is generally failing to
link correctly, and I believe all the new warnings are just instances of
the same underlying problem rather than something new introduced by this
patch.

Given the base is so broken, it's probably not worth build testing this
conifiguration. Either that, or this config should be forbidden by
Kconfig somehow.

Thanks,
Mark.

> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    init/main.o: in function `unknown_bootoption':
>    (.init.text+0x5f0): relocation truncated to fit: R_PARISC_PCREL22F against symbol `strnchr' defined in .text section in lib/string.o
>    hppa64-linux-ld: init/main.o(.init.text+0x694): cannot reach strncmp
>    (.init.text+0x694): relocation truncated to fit: R_PARISC_PCREL22F against symbol `strncmp' defined in .text section in lib/string.o
>    hppa64-linux-ld: init/main.o(.init.text+0x830): cannot reach snprintf
>    init/main.o: in function `xbc_snprint_cmdline':
>    (.init.text+0x830): relocation truncated to fit: R_PARISC_PCREL22F against symbol `snprintf' defined in .text section in lib/vsprintf.o
>    hppa64-linux-ld: init/main.o(.init.text+0x85c): cannot reach snprintf
>    (.init.text+0x85c): relocation truncated to fit: R_PARISC_PCREL22F against symbol `snprintf' defined in .text section in lib/vsprintf.o
>    hppa64-linux-ld: init/main.o(.init.text+0xae4): cannot reach get_option
>    init/main.o: in function `loglevel':
>    (.init.text+0xae4): relocation truncated to fit: R_PARISC_PCREL22F against symbol `get_option' defined in .text section in lib/cmdline.o
>    hppa64-linux-ld: init/main.o(.init.text+0xba0): cannot reach strsep
>    init/main.o: in function `initcall_blacklist':
>    (.init.text+0xba0): relocation truncated to fit: R_PARISC_PCREL22F against symbol `strsep' defined in .text section in lib/string.o
>    hppa64-linux-ld: init/main.o(.init.text+0xbf8): cannot reach panic
>    (.init.text+0xbf8): additional relocation overflows omitted from the output
>    hppa64-linux-ld: init/main.o(.init.text+0xc70): cannot reach panic
>    hppa64-linux-ld: init/main.o(.init.text+0xca4): cannot reach __list_add_valid
>    hppa64-linux-ld: init/main.o(.init.text+0xd94): cannot reach strreplace
>    hppa64-linux-ld: init/main.o(.init.text+0xdb4): cannot reach strcmp
>    hppa64-linux-ld: init/main.o(.init.text+0xe24): cannot reach kstrtobool
>    hppa64-linux-ld: init/main.o(.init.text+0xf04): cannot reach strlcpy
>    hppa64-linux-ld: init/main.o(.init.text+0xf8c): cannot reach rest_init
>    hppa64-linux-ld: init/main.o(.init.text+0x118c): cannot reach memcmp
>    hppa64-linux-ld: init/main.o(.init.text+0x1220): cannot reach strlcpy
>    hppa64-linux-ld: init/main.o(.init.text+0x133c): cannot reach memcpy
>    hppa64-linux-ld: init/main.o(.init.text+0x147c): cannot reach panic
>    hppa64-linux-ld: init/main.o(.init.text+0x14d4): cannot reach panic
>    hppa64-linux-ld: init/main.o(.init.text+0x160c): cannot reach build_all_zonelists
>    hppa64-linux-ld: init/main.o(.init.text+0x1ae8): cannot reach add_device_randomness
>    hppa64-linux-ld: init/main.o(.init.text+0x1b18): cannot reach profile_init
>    hppa64-linux-ld: init/main.o(.init.text+0x1c08): cannot reach panic
>    hppa64-linux-ld: init/main.o(.init.text+0x1c10): cannot reach locking_selftest
>    hppa64-linux-ld: init/main.o(.init.text+0x218c): cannot reach strlcat
>    hppa64-linux-ld: init/main.o(.init.text+0x2418): cannot reach wait_for_completion
>    hppa64-linux-ld: init/main.o(.init.text+0x2454): cannot reach _raw_spin_lock
>    hppa64-linux-ld: init/main.o(.init.text+0x25ac): cannot reach unknown
>    hppa64-linux-ld: init/main.o(.init.text+0x26c4): cannot reach panic
>    hppa64-linux-ld: init/main.o(.init.text+0x2788): cannot reach unknown
>    hppa64-linux-ld: init/main.o(.text.unlikely+0x68): cannot reach kernel_execve
>    hppa64-linux-ld: init/main.o(.text.unlikely+0xfc): cannot reach ftrace_likely_update
>    hppa64-linux-ld: init/main.o(.text.unlikely+0x120): cannot reach ftrace_likely_update
>    hppa64-linux-ld: init/main.o(.ref.text+0x30): cannot reach rcu_scheduler_starting
>    hppa64-linux-ld: init/main.o(.ref.text+0x54): cannot reach kernel_thread
>    hppa64-linux-ld: init/main.o(.ref.text+0x84): cannot reach find_task_by_pid_ns
>    hppa64-linux-ld: init/main.o(.ref.text+0xbc): cannot reach set_cpus_allowed_ptr
>    hppa64-linux-ld: init/main.o(.ref.text+0xdc): cannot reach rcu_read_unlock_strict
>    hppa64-linux-ld: init/main.o(.ref.text+0x100): cannot reach kernel_thread
>    hppa64-linux-ld: init/main.o(.ref.text+0x128): cannot reach find_task_by_pid_ns
>    hppa64-linux-ld: init/main.o(.ref.text+0x154): cannot reach rcu_read_unlock_strict
>    hppa64-linux-ld: init/main.o(.ref.text+0x180): cannot reach complete
>    hppa64-linux-ld: init/main.o(.ref.text+0x1a0): cannot reach cpu_startup_entry
>    hppa64-linux-ld: init/main.o(.ref.text+0x1e8): cannot reach unknown
>    hppa64-linux-ld: init/main.o(.ref.text+0x1f8): cannot reach async_synchronize_full
>    hppa64-linux-ld: init/main.o(.ref.text+0x208): cannot reach ftrace_free_init_mem
>    hppa64-linux-ld: init/main.o(.ref.text+0x238): cannot reach rcu_barrier
>    hppa64-linux-ld: init/main.o(.ref.text+0x248): cannot reach mark_rodata_ro
>    hppa64-linux-ld: init/main.o(.ref.text+0x268): cannot reach rcu_end_inkernel_boot
>    hppa64-linux-ld: init/do_mounts.o(.text+0x38): cannot reach strcmp
>    hppa64-linux-ld: init/do_mounts.o(.text+0xb0): cannot reach strncasecmp
>    hppa64-linux-ld: init/do_mounts.o(.text+0x178): cannot reach strcmp
>    hppa64-linux-ld: init/do_mounts.o(.text+0x198): cannot reach strcmp
>    hppa64-linux-ld: init/do_mounts.o(.text+0x1bc): cannot reach strcmp
>    hppa64-linux-ld: init/do_mounts.o(.text+0x1e4): cannot reach strncmp
>    hppa64-linux-ld: init/do_mounts.o(.text+0x208): cannot reach strncmp
>    hppa64-linux-ld: init/do_mounts.o(.text+0x22c): cannot reach strncmp
>    hppa64-linux-ld: init/do_mounts.o(.text+0x264): cannot reach sscanf
>    hppa64-linux-ld: init/do_mounts.o(.text+0x2e4): cannot reach sscanf
>    hppa64-linux-ld: init/do_mounts.o(.text+0x300): cannot reach simple_strtoul
>    hppa64-linux-ld: init/do_mounts.o(.text+0x370): cannot reach memcpy
>    hppa64-linux-ld: init/do_mounts.o(.text+0x3b4): cannot reach blk_lookup_devt
>    hppa64-linux-ld: init/do_mounts.o(.text+0x42c): cannot reach simple_strtoul
>    hppa64-linux-ld: init/do_mounts.o(.text+0x44c): cannot reach blk_lookup_devt
>    hppa64-linux-ld: init/do_mounts.o(.text+0x49c): cannot reach blk_lookup_devt
>    hppa64-linux-ld: init/do_mounts.o(.text+0x4c4): cannot reach strchr
>    hppa64-linux-ld: init/do_mounts.o(.text+0x4f4): cannot reach sscanf
>    hppa64-linux-ld: init/do_mounts.o(.text+0x538): cannot reach class_find_device
>    hppa64-linux-ld: init/do_mounts.o(.text+0x55c): cannot reach put_device
>    hppa64-linux-ld: init/do_mounts.o(.text+0x594): cannot reach class_find_device
>    hppa64-linux-ld: init/do_mounts.o(.text+0x5ac): cannot reach put_device
>    hppa64-linux-ld: init/do_mounts.o(.text+0x5c4): cannot reach blk_lookup_devt
>    hppa64-linux-ld: init/do_mounts.o(.text+0x610): cannot reach bdget_disk
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x1a4): cannot reach simple_strtoul
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x208): cannot reach strlcpy
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x390): cannot reach scnprintf
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x418): cannot reach strchr
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x5e4): cannot reach unknown
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x624): cannot reach unknown
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x6b0): cannot reach panic
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x710): cannot reach panic
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x84c): cannot reach wait_for_device_probe
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x88c): cannot reach strncmp
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x8b0): cannot reach strncmp
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x920): cannot reach strncmp
>    hppa64-linux-ld: init/do_mounts.o(.init.text+0x978): cannot reach driver_probe_done
>    hppa64-linux-ld: init/do_mounts.o(.text.unlikely+0x40): cannot reach ftrace_likely_update
>    hppa64-linux-ld: init/do_mounts.o(.text.unlikely+0x7c): cannot reach trace_hardirqs_off
>    hppa64-linux-ld: init/do_mounts.o(.text.unlikely+0xc4): cannot reach trace_hardirqs_on
>    hppa64-linux-ld: init/do_mounts.o(.text.unlikely+0xf0): cannot reach ftrace_likely_update
> >> hppa64-linux-ld: init/do_mounts.o(.text.unlikely+0x104): cannot reach warn_bogus_irq_restore
>    hppa64-linux-ld: init/do_mounts.o(.text.unlikely+0x120): cannot reach __put_page
>    hppa64-linux-ld: init/do_mounts_rd.o(.init.text+0x1ec): cannot reach simple_strtol
>    hppa64-linux-ld: init/do_mounts_rd.o(.init.text+0x5b8): cannot reach panic
>    hppa64-linux-ld: init/do_mounts_rd.o(.init.text+0x67c): cannot reach strcmp
>    hppa64-linux-ld: init/do_mounts_rd.o(.init.text+0x748): cannot reach __umoddi3
>    hppa64-linux-ld: init/do_mounts_initrd.o(.init.text+0x140): cannot reach memparse
>    hppa64-linux-ld: init/do_mounts_initrd.o(.init.text+0x170): cannot reach memparse
>    hppa64-linux-ld: init/initramfs.o(.init.text+0xbb4): cannot reach panic
>    hppa64-linux-ld: init/initramfs.o(.init.text+0xcc8): cannot reach strcmp
>    hppa64-linux-ld: init/initramfs.o(.init.text+0xf08): cannot reach panic
>    hppa64-linux-ld: init/initramfs.o(.init.text+0xf50): cannot reach __list_add_valid
>    hppa64-linux-ld: init/initramfs.o(.init.text+0x1110): cannot reach memcpy
>    hppa64-linux-ld: init/initramfs.o(.init.text+0x1220): cannot reach simple_strtoul
>    hppa64-linux-ld: init/initramfs.o(.init.text+0x13c0): cannot reach memcmp
>    hppa64-linux-ld: init/initramfs.o(.init.text+0x1400): cannot reach memcmp
>    hppa64-linux-ld: init/initramfs.o(.init.text+0x169c): cannot reach panic
>    hppa64-linux-ld: init/initramfs.o(.init.text+0x1820): cannot reach snprintf
>    hppa64-linux-ld: init/initramfs.o(.init.text+0x18bc): cannot reach __list_del_entry_valid
>    hppa64-linux-ld: init/initramfs.o(.init.text+0x1a84): cannot reach panic
>    hppa64-linux-ld: arch/parisc/mm/init.o(.text+0x88): cannot reach _raw_spin_lock
>    hppa64-linux-ld: arch/parisc/mm/init.o(.text+0x1b4): cannot reach _raw_spin_lock
>    hppa64-linux-ld: arch/parisc/mm/init.o(.text+0x2e0): cannot reach _raw_spin_lock
>    hppa64-linux-ld: arch/parisc/mm/init.o(.text+0x3e4): cannot reach _raw_spin_lock
>    hppa64-linux-ld: arch/parisc/mm/init.o(.text+0x464): cannot reach _raw_spin_lock
>    hppa64-linux-ld: arch/parisc/mm/init.o(.text+0x4d0): cannot reach find_next_zero_bit
>    hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x134): cannot reach panic
>    hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x1e8): cannot reach panic
>    hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x590): cannot reach memcmp
>    hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x5b0): cannot reach memparse
>    hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x968): cannot reach panic
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0x90): cannot reach unknown
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xbc): cannot reach unknown
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xe0): cannot reach unknown
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xfc): cannot reach __flush_tlb_range
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0x114): cannot reach flush_kernel_dcache_range_asm
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0x12c): cannot reach flush_kernel_icache_range_asm
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0x150): cannot reach free_reserved_area
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0x160): cannot reach pdc_chassis_send_status
>    hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x140): cannot reach __sw_hweight64
>    hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x210): cannot reach strlcpy
>    hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x2fc): cannot reach panic
>    hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x4b4): cannot reach panic
>    hppa64-linux-ld: arch/parisc/kernel/hardware.o(.init.text+0x148): cannot reach panic
>    hppa64-linux-ld: arch/parisc/kernel/topology.o(.text.unlikely+0x90): cannot reach trace_hardirqs_off
>    hppa64-linux-ld: arch/parisc/kernel/topology.o(.text.unlikely+0xd4): cannot reach trace_hardirqs_on
> >> hppa64-linux-ld: arch/parisc/kernel/topology.o(.text.unlikely+0x100): cannot reach ftrace_likely_update
> >> hppa64-linux-ld: arch/parisc/kernel/topology.o(.text.unlikely+0x114): cannot reach warn_bogus_irq_restore
>    hppa64-linux-ld: arch/parisc/kernel/topology.o(.init.text+0xd4): cannot reach cpumask_next
>    hppa64-linux-ld: arch/parisc/kernel/topology.o(.init.text+0x1a8): cannot reach cpumask_next
>    hppa64-linux-ld: arch/parisc/kernel/topology.o(.init.text+0x1ec): cannot reach unknown
>    hppa64-linux-ld: arch/parisc/kernel/topology.o(.init.text+0x208): cannot reach unknown
>    hppa64-linux-ld: arch/parisc/kernel/topology.o(.init.text+0x238): cannot reach unknown
>    hppa64-linux-ld: arch/parisc/kernel/topology.o(.init.text+0x254): cannot reach unknown
>    hppa64-linux-ld: arch/parisc/kernel/topology.o(.init.text+0x314): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/softirq.o(.text+0xf6c): cannot reach __do_softirq
>    hppa64-linux-ld: kernel/softirq.o(.text+0x1204): cannot reach __do_softirq
>    hppa64-linux-ld: kernel/softirq.o(.text+0x1248): cannot reach _cond_resched
>    hppa64-linux-ld: kernel/softirq.o(.text+0x1344): cannot reach rcu_irq_enter
>    hppa64-linux-ld: kernel/softirq.o(.text+0x1484): cannot reach __do_softirq
>    hppa64-linux-ld: kernel/softirq.o(.text+0x1548): cannot reach rcu_irq_exit
>    hppa64-linux-ld: kernel/softirq.o(.text+0x15d4): cannot reach __do_softirq
>    hppa64-linux-ld: kernel/softirq.o(.text+0x2708): cannot reach yield
>    hppa64-linux-ld: kernel/softirq.o(.init.text+0x134): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0xd0): cannot reach __local_bh_disable_ip
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x188): cannot reach trace_hardirqs_on
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x2e4): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x3a0): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x3c0): cannot reach unknown
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x494): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x4b8): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x540): cannot reach trace_hardirqs_off
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x550): cannot reach rcu_softirq_qs
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x5c4): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x5e8): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x6ac): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x6d0): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/extable.o(.text+0x44): cannot reach search_extable
>    hppa64-linux-ld: kernel/extable.o(.text+0x9c): cannot reach search_extable
>    hppa64-linux-ld: kernel/extable.o(.text+0x290): cannot reach rcu_nmi_enter
>    hppa64-linux-ld: kernel/extable.o(.text+0x2b8): cannot reach rcu_nmi_exit
>    hppa64-linux-ld: kernel/extable.o(.init.text+0x58): cannot reach sort_extable
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x720): cannot reach timerqueue_add
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x750): cannot reach timerqueue_del
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x8f8): cannot reach platform_device_register_full
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x970): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x9b8): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x9c8): cannot reach platform_device_unregister
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x9e8): cannot reach get_device
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xa0c): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xab8): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xae4): cannot reach timerqueue_del
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xb08): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xb70): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xbb8): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xc38): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xe60): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xe80): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xeec): cannot reach rtc_timer_cancel
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xf5c): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xf84): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xfb8): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0xfd4): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x1020): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x103c): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x10fc): cannot reach rtc_timer_cancel
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x1114): cannot reach rtc_read_time
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x113c): cannot reach rtc_tm_to_ktime
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x1158): cannot reach rtc_timer_start
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x13d8): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x1430): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x1678): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x16d0): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x175c): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x17a4): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x1828): cannot reach timerqueue_del
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x1ac8): cannot reach __divdi3
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.text+0x1ae4): cannot reach __muldi3
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.init.text+0x44): cannot reach rtc_timer_init
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.init.text+0xec): cannot reach class_interface_register
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.init.text+0x110): cannot reach __platform_driver_register
>    hppa64-linux-ld: kernel/time/alarmtimer.o(.init.text+0x128): cannot reach class_interface_unregister
>    hppa64-linux-ld: kernel/crash_core.o(.text+0x90): cannot reach memcpy
>    hppa64-linux-ld: kernel/crash_core.o(.text+0xb0): cannot reach memcpy
>    hppa64-linux-ld: kernel/crash_core.o(.text+0x1fc): cannot reach memcpy
>    hppa64-linux-ld: kernel/crash_core.o(.text+0x2a8): cannot reach vscnprintf
>    hppa64-linux-ld: kernel/crash_core.o(.text+0x2e4): cannot reach memcpy
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0xe0): cannot reach strstr
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x110): cannot reach strchr
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x174): cannot reach strncmp
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x1b8): cannot reach strncmp
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x1d8): cannot reach strstr
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x210): cannot reach memparse
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x24c): cannot reach strncmp
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x288): cannot reach strchr
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x2a4): cannot reach strchr
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x2e4): cannot reach memparse
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x324): cannot reach memparse
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x36c): cannot reach memparse
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x3e4): cannot reach memparse
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x414): cannot reach memparse
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x448): cannot reach memparse
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x6c0): cannot reach strcmp
>    hppa64-linux-ld: kernel/crash_core.o(.init.text+0x6f8): cannot reach bin2hex
>    hppa64-linux-ld: kernel/cgroup/cgroup.o(.text+0x1c4c): cannot reach find_next_bit
>    hppa64-linux-ld: kernel/cgroup/cgroup.o(.text+0x1cc0): cannot reach find_next_bit
>    hppa64-linux-ld: kernel/cgroup/cgroup.o(.text+0x1f70): cannot reach memcpy
>    hppa64-linux-ld: kernel/cgroup/cgroup.o(.text+0x2078): cannot reach snprintf
> --
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7204): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x723c): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x725c): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x72dc): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x73ac): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7484): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7574): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x758c): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x75a0): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x76e4): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7710): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7adc): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7b24): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7b98): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7bb0): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7cf8): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7ec8): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7ee0): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x7fe8): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x8084): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x850c): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x8540): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x8630): cannot reach strlcpy
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x864c): cannot reach strlcpy
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x86d4): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x876c): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x87a4): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x87d0): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x883c): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x885c): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x88b8): cannot reach bsearch
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x8918): cannot reach __list_add_valid
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x8aac): cannot reach memmove
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x8bf8): cannot reach __list_add_valid
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x90f0): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9138): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9150): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9238): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9294): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x92b4): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x93e8): cannot reach __list_add_valid
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x94a4): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x94fc): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9514): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x95c4): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x95dc): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9860): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x98b0): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9998): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9a64): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9abc): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9d94): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9dbc): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9edc): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9f08): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9f8c): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0x9fb8): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0xa034): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text+0xa1b0): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x1c): cannot reach simple_strtoul
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x70): cannot reach strlcpy
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0xb0): cannot reach strlcpy
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0xe0): cannot reach strlcpy
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x110): cannot reach strlcpy
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x198): cannot reach strsep
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x300): cannot reach strsep
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x3a0): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x3cc): cannot reach strcmp
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x3f4): cannot reach __list_add_valid
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x424): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x4bc): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x4e8): cannot reach strcmp
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x530): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ftrace.o(.init.text+0x680): cannot reach unknown
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x88): cannot reach sort
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x9c): cannot reach unknown
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x118): cannot reach __get_free_pages
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x18c): cannot reach unknown
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x1d4): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x1fc): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x248): cannot reach free_pages
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x260): cannot reach kfree
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x2b8): cannot reach unknown
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x2f8): cannot reach unknown
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x364): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x398): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x3d0): cannot reach ftrace_call_adjust
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x418): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x440): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x474): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x4d0): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x4f4): cannot reach trace_hardirqs_off
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x514): cannot reach ftrace_now
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x594): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x5dc): cannot reach ftrace_likely_update
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x600): cannot reach ftrace_make_nop
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x628): cannot reach ftrace_bug
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x64c): cannot reach ftrace_now
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x674): cannot reach trace_hardirqs_on
>    hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x6a0): cannot reach ftrace_likely_update
> >> hppa64-linux-ld: kernel/trace/ftrace.o(.text.unlikely+0x6b4): cannot reach warn_bogus_irq_restore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x248): cannot reach __list_del_entry_valid
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x3ac): cannot reach memcpy
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x744): cannot reach __list_add_valid
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x958): cannot reach __list_del_entry_valid
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xac4): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x1444): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x229c): cannot reach _raw_spin_lock_irq
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x22f8): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x2450): cannot reach __list_del_entry_valid
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x24c8): cannot reach _raw_spin_lock_irq
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x2764): cannot reach _cond_resched
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x3010): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x4138): cannot reach __list_del_entry_valid
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x5994): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x5b80): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x5ba0): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x5c40): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x66a4): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x66f0): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x6714): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x7510): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x7734): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x780c): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x7e90): cannot reach __udivdi3
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8110): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8204): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8308): cannot reach __udivdi3
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8320): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x83e8): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8448): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8488): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x84b4): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8520): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x856c): cannot reach __list_del_entry_valid
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x85e4): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x85fc): cannot reach __udivdi3
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8614): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8638): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8720): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x87f8): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x88a4): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x890c): cannot reach wait_for_completion
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8950): cannot reach wait_for_completion
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8a08): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8a2c): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x8bd0): cannot reach __muldi3
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xa29c): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xa2c8): cannot reach __cmpxchg_u64
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xb34c): cannot reach memcpy
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xb4e4): cannot reach __muldi3
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xc3b4): cannot reach __cmpxchg_u32
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xc41c): cannot reach __cmpxchg_u32
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xc798): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xc7e4): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xca44): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xcad4): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xcb38): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xcb84): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xcd84): cannot reach _raw_spin_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xcee4): cannot reach _raw_spin_trylock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xd0d0): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xd2a8): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xd43c): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xd628): cannot reach _raw_spin_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xd798): cannot reach _raw_spin_trylock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xdb0c): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xdb88): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xdbf8): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xdc2c): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xdd68): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xdd94): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xde94): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xe0e8): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xe22c): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xe26c): cannot reach cpumask_next_and
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xe44c): cannot reach cpumask_next_and
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xe608): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xe6f4): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xe8d0): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xeb8c): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xec04): cannot reach _raw_spin_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xed2c): cannot reach _raw_spin_trylock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xef20): cannot reach _raw_spin_lock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xf018): cannot reach _raw_spin_trylock
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xf2f4): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xf354): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xf38c): cannot reach __muldi3
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xf3a0): cannot reach schedule
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0xff0c): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x10254): cannot reach memcpy
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x1049c): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x10540): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.text+0x108b8): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.init.text+0x5c): cannot reach schedule
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.init.text+0x118): cannot reach __umoddi3
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.init.text+0x244): cannot reach memcpy
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.init.text+0x4b4): cannot reach usleep_range
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.init.text+0x5e4): cannot reach __cmpxchg_u32
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.init.text+0x654): cannot reach cpumask_next
>    hppa64-linux-ld: kernel/trace/ring_buffer.o(.init.text+0x8b8): cannot reach __cmpxchg_u32
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


