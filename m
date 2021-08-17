Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D033EEF02
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhHQPRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhHQPRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:17:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA2CC60FC3;
        Tue, 17 Aug 2021 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629213424;
        bh=jdfQynrxi1WCYfDGA9Kc0r4i3sDA4a3bcitAeciJd04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q6iQOsjG6U03LH0Egg7KyLUWwjxpuXN+HAtNzhf03hufk+1/XkGwt5gKmgfUpLXNn
         +UEFTWW0YVt3lRpKaTi0lwijyygOZC5Y3TrJdlszDShNrmW5gbl8umudhNAVfZtcH6
         cxiXDSsByJ0Uk6w2Vow1rblLoZWXcltbd89P1/Gyn6lP1DNg4Bw5fVLGRSqQ7jX5IA
         lZNB2jOktW4J1lO54sTpnO5fgaW8Djq7bsm8gE/FzocMsSR2m4Mt8bYm+x9+GOvmgW
         1qdHWR1gPps2meE+mSh4/v/af2MCAA9PgeEFk3sF8K05S+sQFhZAkCXWw1udcI3G8Q
         2DddKtSRUtWVQ==
Received: by mail-oi1-f172.google.com with SMTP id t35so32369662oiw.9;
        Tue, 17 Aug 2021 08:17:04 -0700 (PDT)
X-Gm-Message-State: AOAM5330AI+YwqY9j29eODkJ/ueS/RVI3yMUa9T6rB0srkqwrYo5ZCNo
        DkCb1LmCgcuPsYwajZvW0tTS8ndUDZZow4/zN5w=
X-Google-Smtp-Source: ABdhPJzOgeV4HsR1ZXLpL94lV6IB9SCXpV41WI6ICwlsMcf3iidx7UFawkqkNj9pUA5Cy+fF+cUE5T6JdTPwYvjIj/w=
X-Received: by 2002:aca:ea54:: with SMTP id i81mr2855390oih.174.1629213424190;
 Tue, 17 Aug 2021 08:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210810134127.1394269-1-valentin.schneider@arm.com>
 <20210810134127.1394269-3-valentin.schneider@arm.com> <87y2989xhh.wl-maz@kernel.org>
In-Reply-To: <87y2989xhh.wl-maz@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Aug 2021 17:16:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH0iO2+GMN+hsX2dMo4FDpXjv0SvNeTCYWPer70Yx8Qug@mail.gmail.com>
Message-ID: <CAMj1kXH0iO2+GMN+hsX2dMo4FDpXjv0SvNeTCYWPer70Yx8Qug@mail.gmail.com>
Subject: Re: [SPLAT 2/3] irqchip/gic-v3-its: Sleeping spinlocks down gic_reserve_range()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 10:50, Marc Zyngier <maz@kernel.org> wrote:
>
> [+ Ard]
>
> On Tue, 10 Aug 2021 14:41:26 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
> >
> > [    0.134518] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
> > [    0.134520] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
> > [    0.134522] 1 lock held by swapper/1/0:
> > [    0.134523] #0: ffff008f3624f728 ((lock).lock){+.+.}-{2:2}, at: get_page_from_freelist (mm/page_alloc.c:3673 mm/page_alloc.c:3704 mm/page_alloc.c:4166)
> > [    0.134533] irq event stamp: 0
> > [    0.134534] hardirqs last enabled at (0): 0x0
> > [    0.134538] hardirqs last disabled at (0): copy_process (./include/linux/lockdep.h:195 ./include/linux/lockdep.h:202 ./include/linux/lockdep.h:208 ./include/linux/seqlock.h:78 kernel/fork.c:2084)
> > [    0.134542] softirqs last enabled at (0): copy_process (./include/linux/lockdep.h:195 ./include/linux/lockdep.h:202 ./include/linux/lockdep.h:208 ./include/linux/seqlock.h:78 kernel/fork.c:2084)
> > [    0.134545] softirqs last disabled at (0): 0x0
> > [    0.134547] Preemption disabled at:
> > [    0.134547] rt_mutex_slowunlock (kernel/locking/rtmutex.c:1223)
> > [    0.134552] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.14.0-rc4-rt6-torture+ #56
> > [    0.134555] Call trace:
> > [    0.134556] dump_backtrace (arch/arm64/kernel/stacktrace.c:151)
> > [    0.134558] show_stack (arch/arm64/kernel/stacktrace.c:217)
> > [    0.134559] dump_stack_lvl (lib/dump_stack.c:106)
> > [    0.134563] dump_stack (lib/dump_stack.c:113)
> > [    0.134565] ___might_sleep (kernel/sched/core.c:9306)
> > [    0.134567] rt_spin_lock (kernel/locking/rtmutex.c:1641 (discriminator 4) kernel/locking/spinlock_rt.c:30 (discriminator 4) kernel/locking/spinlock_rt.c:36 (discriminator 4) kernel/locking/spinlock_rt.c:44 (discriminator 4))
> > [    0.134569] get_page_from_freelist (mm/page_alloc.c:3673 mm/page_alloc.c:3704 mm/page_alloc.c:4166)
> > [    0.134571] __alloc_pages (mm/page_alloc.c:5391)
> > [    0.134573] alloc_page_interleave (mm/mempolicy.c:2119)
> > [    0.134576] alloc_pages (mm/mempolicy.c:2249)
> > [    0.134577] new_slab (mm/slub.c:1740 mm/slub.c:1877 mm/slub.c:1940)
> > [    0.134580] ___slab_alloc (mm/slub.c:2951)
> > [    0.134582] __slab_alloc.isra.0 (mm/slub.c:3038)
> > [    0.134584] kmem_cache_alloc_trace (mm/slub.c:3129 mm/slub.c:3171 mm/slub.c:3188)
> > [    0.134587] efi_mem_reserve_iomem (drivers/firmware/efi/efi.c:905)
> > [    0.134590] efi_mem_reserve_persistent (drivers/firmware/efi/efi.c:952)
> > [    0.134593] its_cpu_init (drivers/irqchip/irq-gic-v3-its.c:3074 drivers/irqchip/irq-gic-v3-its.c:5196)
> > [    0.134596] gic_starting_cpu (drivers/irqchip/irq-gic.c:798)
> > [    0.134599] cpuhp_invoke_callback (kernel/cpu.c:180)
> > [    0.134601] cpuhp_invoke_callback_range (kernel/cpu.c:656)
> > [    0.134603] notify_cpu_starting (kernel/cpu.c:1270)
> > [    0.134605] secondary_start_kernel (arch/arm64/kernel/smp.c:243)
> > [    0.134608] __secondary_switched (arch/arm64/kernel/head.S:661)
>
> The issue is that although the redistributor tables have been
> allocated ahead of time (outside of any cpuhp callback), they cannot
> be programmed into the RDs until the corresponding CPUs have been
> brought up (the registers may not be accessible).
>
> For the same reason, we don't know whether we can free them (because
> there is already a table programmed there) or have to reserve them
> with an efi_mem_reserve_persistent() call. efi_mem_reserve_iomem()
> uses GFP_ATOMIC for its allocation, but this is not sufficient for RT
> anymore.
>
> We could postpone the reservation of the memory to a later point (it
> is only useful for kexec), but it isn't clear where that point is. The
> CPU is not quite up yet, and we can't easily IPI the boot CPU to do
> the reserve call.
>

The kzalloc() call in question is used to allocate the struct resource
which is inserted in to the iomem resource tree. This could definitely
be postponed, given that the kernel itself does not care about these
entries, only user space (IIUC)
