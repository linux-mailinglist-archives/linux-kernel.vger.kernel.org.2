Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADE236CA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbhD0RvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236740AbhD0RvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:51:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C4D7613B2;
        Tue, 27 Apr 2021 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619545827;
        bh=wqrMecx8hqEvuOOD0EVpbGnVP8yXh1obFZqVd4ZeluE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kOFe5+kdb4ovqAOfcGbkE5KBSU+1ftLEv/ZJ4uuzNE+xG+3yBEULaIxq5xXJ0D51g
         WD6A8OdJT4s5uVAwHcZZwsYpdqW2iZPIP13Q5+zm/JsHusHpApNt95h4xIKEXnGIFL
         2Y4EaM91Jrzq7SYpK4CWPrWx6gWtTKW/yXvHMMEWcBnTqTYOMkQ5bTDrJV0j2eE8rU
         EwHDPsQ7iU3d1GKhD7MNXwApLL5LarJPHw2t5NXTj3BBUs9zOgmn1R2mHHDm5ANMVh
         Zo83YaJeD56JCfOaOYM9axemJ4K4c8y0Gp610HUrCk078XSN01SqYZLJqbBBNeGog3
         2MbIoMM3dJXBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0E0C85C019D; Tue, 27 Apr 2021 10:50:27 -0700 (PDT)
Date:   Tue, 27 Apr 2021 10:50:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org, zhengjun.xing@intel.com
Subject: Re: [clocksource]  8c30ace35d:
 WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
Message-ID: <20210427175027.GA945820@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210425224709.1312655-6-paulmck@kernel.org>
 <20210427072702.GC32408@xsang-OptiPlex-9020>
 <20210427084522.GB65970@shbuild999.sh.intel.com>
 <20210427133746.GG975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427133746.GG975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 06:37:46AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 27, 2021 at 04:45:22PM +0800, Feng Tang wrote:
> > On Tue, Apr 27, 2021 at 03:27:02PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with gcc-9):
> > > 
> > > commit: 8c30ace35da3b362089f5c903144d762a065b58a ("[PATCH v10 clocksource 6/7] clocksource: Forgive tsc_early pre-calibration drift")
> > > url: https://github.com/0day-ci/linux/commits/Paul-E-McKenney/Do-not-mark-clocks-unstable-due-to-delays-for-v5-13/20210426-064834
> > > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2d036dfa5f10df9782f5278fc591d79d283c1fad
> > > 
> > > in testcase: boot
> > > 
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > 
> > > 
> > > [   70.350923] WARNING: CPU: 0 PID: 1 at kernel/time/clocksource.c:435 clocksource_watchdog (kbuild/src/x86_64/kernel/time/clocksource.c:435) 
> > > [   70.353152] Modules linked in:
> > > [   70.354074] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc3-00031-g8c30ace35da3 #2
> > > [   70.356180] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > > [   70.358471] RIP: 0010:clocksource_watchdog (kbuild/src/x86_64/kernel/time/clocksource.c:435) 
> > 
> > Some log extraced from the attached dmesg.xz:
> > 
> > [    8.376387] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x26d347b2dd9, max_idle_ns: 440795223616 ns
> > [    8.890982] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > [    9.132146] clocksource: Switched to clocksource kvm-clock
> > [   10.324011] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > 
> > [   10.397945] Trying to unpack rootfs image as initramfs...
> > [   70.350923] WARNING: CPU: 0 PID: 1 at kernel/time/clocksource.c:435 clocksource_watchdog+0x3b8/0x4c0
> > [  199.544368] Freeing initrd memory: 592780K
> > 
> > [  199.551256] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x26d347b2dd9, max_idle_ns: 440795223616 ns
> > 
> > Seems the initramfs took too long time, and exceeds the 60
> > seconds of WATCHDOG_SYNC_FORGIVENESS time, which triggers
> > the warning.
> > 
> > Also I asked Oliver about the reproduce rate, and he said the
> > warning was seen only once for all around 100 boot tests. From
> > other good boot logs, the initramfs unpacking usually only takes
> > about 20 seconds. 
> 
> Hmmm...  70 seconds.  Is this a legitimate diagnostic of initramfs?
> If not, is there some way to detect that initramfs took longer than
> expected?
> 
> I suppose that I give it (say) 120 seconds instead of the current 60,
> which might be the right thing to do, but it does feel like papering
> over a very real initramfs problem.  Alternatively, I could provide a
> boot parameter allowing those with slow systems to adjust as needed.

OK, it turns out that there are systems for which boot times in excess
of one minute are expected behavior.  They are a bit rare, though.
So what I will do is keep the 60-second default, add a boot parameter,
and also add a comment by the warning pointing out the boot parameter.

							Thanx, Paul

> > Thanks,
> > Feng
> > 
> > > [   70.382655]  <IRQ>
> > > [   70.386145] call_timer_fn (kbuild/src/x86_64/arch/x86/include/asm/jump_label.h:25 kbuild/src/x86_64/include/linux/jump_label.h:200 kbuild/src/x86_64/include/trace/events/timer.h:125 kbuild/src/x86_64/kernel/time/timer.c:1432) 
> > > [   70.387393] run_timer_softirq (kbuild/src/x86_64/kernel/time/timer.c:1477 kbuild/src/x86_64/kernel/time/timer.c:1745 kbuild/src/x86_64/kernel/time/timer.c:1721 kbuild/src/x86_64/kernel/time/timer.c:1758) 
> > > [   70.389855] __do_softirq (kbuild/src/x86_64/arch/x86/include/asm/jump_label.h:25 kbuild/src/x86_64/include/linux/jump_label.h:200 kbuild/src/x86_64/include/trace/events/irq.h:142 kbuild/src/x86_64/kernel/softirq.c:346) 
> > > [   70.390965] irq_exit_rcu (kbuild/src/x86_64/kernel/softirq.c:221 kbuild/src/x86_64/kernel/softirq.c:422 kbuild/src/x86_64/kernel/softirq.c:434) 
> > > [   70.392198] sysvec_apic_timer_interrupt (kbuild/src/x86_64/arch/x86/kernel/apic/apic.c:1100 (discriminator 14)) 
> > > [   70.393575]  </IRQ>
> > > [   70.394355] asm_sysvec_apic_timer_interrupt (kbuild/src/x86_64/arch/x86/include/asm/idtentry.h:632) 
> > > [   70.395968] RIP: 0010:__memcpy (kbuild/src/x86_64/arch/x86/lib/memcpy_64.S:39) 
> > > [ 70.397140] Code: 84 00 00 00 00 00 66 90 48 89 fe 48 c7 c7 7e 0a a2 a7 e9 f1 fe ff ff cc 66 66 90 66 90 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3 a4
> > > [   70.404945] RSP: 0000:ffffb8e500013ae8 EFLAGS: 00010246
> > > [   70.406424] RAX: ffff9fc255c00000 RBX: 0000000000001000 RCX: 0000000000000200
> > > [   70.408416] RDX: 0000000000000000 RSI: ffff9fc2423e4bb0 RDI: ffff9fc255c00000
> > > [   70.410277] RBP: ffff9fc255c00000 R08: ffff9fc140000000 R09: 0000000000004bb0
> > > [   70.412300] R10: ffff9fc2402a3180 R11: 0000000000000000 R12: 0000000000001000
> > > [   70.414194] R13: ffffb8e500013c08 R14: 0000000000001000 R15: ffffe73dc0000000
> > > [   70.416239] iov_iter_copy_from_user_atomic (kbuild/src/x86_64/lib/iov_iter.c:991 (discriminator 10)) 
> > > [   70.417718] generic_perform_write (kbuild/src/x86_64/mm/filemap.c:3586) 
> > > [   70.419241] __generic_file_write_iter (kbuild/src/x86_64/mm/filemap.c:3705) 
> > > [   70.420517] generic_file_write_iter (kbuild/src/x86_64/include/linux/fs.h:780 kbuild/src/x86_64/mm/filemap.c:3737) 
> > > [   70.421643] __kernel_write (kbuild/src/x86_64/fs/read_write.c:550 (discriminator 1)) 
> > > [   70.422769] kernel_write (kbuild/src/x86_64/include/linux/fs.h:2903 kbuild/src/x86_64/fs/read_write.c:580 kbuild/src/x86_64/fs/read_write.c:569) 
> > > [   70.423999] ? write_buffer (kbuild/src/x86_64/init/initramfs.c:436) 
> > > [   70.425104] xwrite+0x31/0x62 
> > > [   70.426262] do_copy (kbuild/src/x86_64/init/initramfs.c:394) 
> > > [   70.427333] ? write_buffer (kbuild/src/x86_64/init/initramfs.c:436) 
> > > [   70.428395] write_buffer (kbuild/src/x86_64/init/initramfs.c:430 (discriminator 1)) 
> > > [   70.429461] flush_buffer (kbuild/src/x86_64/init/initramfs.c:442) 
> > > [   70.430523] ? initrd_load (kbuild/src/x86_64/init/initramfs.c:44) 
> > > [   70.431700] __gunzip (kbuild/src/x86_64/lib/decompress_inflate.c:161) 
> > > [   70.432696] ? bunzip2 (kbuild/src/x86_64/lib/decompress_inflate.c:39) 
> > > [   70.433760] ? __gunzip (kbuild/src/x86_64/lib/decompress_inflate.c:207) 
> > > [   70.434841] gunzip (kbuild/src/x86_64/lib/decompress_inflate.c:207) 
> > > [   70.435927] ? initrd_load (kbuild/src/x86_64/init/initramfs.c:44) 
> > > [   70.437032] unpack_to_rootfs (kbuild/src/x86_64/init/initramfs.c:500) 
> > > [   70.438284] ? initrd_load (kbuild/src/x86_64/init/initramfs.c:44) 
> > > [   70.439507] ? reserve_initrd_mem (kbuild/src/x86_64/init/initramfs.c:662) 
> > > [   70.440794] populate_rootfs (kbuild/src/x86_64/init/initramfs.c:676) 
> > > [   70.441946] ? reserve_initrd_mem (kbuild/src/x86_64/init/initramfs.c:662) 
> > > [   70.443386] do_one_initcall (kbuild/src/x86_64/init/main.c:1226) 
> > > [   70.444562] ? rcu_read_lock_sched_held (kbuild/src/x86_64/include/linux/lockdep.h:278 kbuild/src/x86_64/kernel/rcu/update.c:125) 
> > > [   70.445893] kernel_init_freeable (kbuild/src/x86_64/init/main.c:1298 kbuild/src/x86_64/init/main.c:1315 kbuild/src/x86_64/init/main.c:1335 kbuild/src/x86_64/init/main.c:1537) 
> > > [   70.447344] ? rest_init (kbuild/src/x86_64/init/main.c:1421) 
> > > [   70.448383] kernel_init (kbuild/src/x86_64/init/main.c:1426) 
> > > [   70.449219] ret_from_fork (kbuild/src/x86_64/arch/x86/entry/entry_64.S:300) 
> > > [   70.450175] irq event stamp: 2300500
> > > [   70.451358] hardirqs last enabled at (2300510): console_unlock (kbuild/src/x86_64/arch/x86/include/asm/irqflags.h:45 (discriminator 1) kbuild/src/x86_64/arch/x86/include/asm/irqflags.h:80 (discriminator 1) kbuild/src/x86_64/arch/x86/include/asm/irqflags.h:145 (discriminator 1) kbuild/src/x86_64/kernel/printk/printk.c:2605 (discriminator 1)) 
> > > [   70.453717] hardirqs last disabled at (2300519): console_unlock (kbuild/src/x86_64/kernel/printk/printk.c:2520 (discriminator 1)) 
> > > [   70.456262] softirqs last enabled at (2299674): __do_softirq (kbuild/src/x86_64/arch/x86/include/asm/preempt.h:27 kbuild/src/x86_64/kernel/softirq.c:373) 
> > > [   70.458585] softirqs last disabled at (2299819): irq_exit_rcu (kbuild/src/x86_64/kernel/softirq.c:221 kbuild/src/x86_64/kernel/softirq.c:422 kbuild/src/x86_64/kernel/softirq.c:434) 
> > > [   70.461343] ---[ end trace 5049069f8395a579 ]---
> > > [  199.544368] Freeing initrd memory: 592780K
> > > [  199.545765] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> > > [  199.547432] software IO TLB: mapped [mem 0x00000000bbfe0000-0x00000000bffe0000] (64MB)
> > > [  199.550168] kvm: no hardware support
> > > [  199.551256] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x26d347b2dd9, max_idle_ns: 440795223616 ns
> > > [  199.563791] Initialise system trusted keyrings
> > > [  199.565211] Key type blacklist registered
