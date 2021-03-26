Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B51534AD54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCZR2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhCZR1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:27:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5FEC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:27:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b16so7191325eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csRzJ/ofwIZr0NehLJnkYKcYDLD8BnbI62VMSZcr30I=;
        b=jWx3ya5RJpSvmXUN/SyrM0KdbghFwAI1izWNWH7POTgLCNTs7kxfxzdwrxmD7dz+Pv
         GLNfy/xk5OJzdVzQVQEFNBIptvmt78+mbK3O/p83OfuSCQkEDH0YdO9+8Oh51Di2c1dN
         MjGah09PXZZ25GBt80rMRb2FAUvo32LWmtnso+gGuBRu32XOQyPXYObsGWQZQYSuZ5ud
         UQdPs3n47d1puyzKSs+KtK0Xj+DVxs4K54ZGhMs1i+iniOmZgCtsyWWbwOmhVjgHA9B0
         J4OC2+vtakFmKC0qq4FyikCqDfkiLT0TvViD7zOOfAQPmhP+qzq0BjdqfViPB17uOKYt
         vItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csRzJ/ofwIZr0NehLJnkYKcYDLD8BnbI62VMSZcr30I=;
        b=tNFvKFRLDSFPAtQKrzsdOKKOdmvusv8XUfL+biJiY5Quf4wyTYZruNpJkDxi8Cgoi9
         yWryGaHYd0/ZGM+xAU3ok+PUlZj8wPgBJk3m23VszYRlMKqyLYnNS9uQsgWcrWDGjeKV
         +EIRPc2s9QKgBczhi5llGWiNjkBluK4njCfncuVDq6Yxe41TfSRBOSpM59/3lhY1dc4X
         bQnEoUUgc5tSEre6dc0aUaFLyWbmKQbkaw05KR5TWbQaaVCVSwotduMlH4peMIBq4hjy
         Rruz7iGJK2Mq5lTt2H/1T53R0Yp9o43URXw+wm0OFCK9OdzRNCvcAu0AiMteazLwHG77
         Ns/Q==
X-Gm-Message-State: AOAM532seKT9LPupZWrtV0vFURuZx/Mk5cHWsFKBdf0u940GUEtjrVz7
        eGUYfgc5joUpBRFty7bN+63nQ0h+GQZYkV6Tt1fRSoqybiZHGA==
X-Google-Smtp-Source: ABdhPJzuDPXUbItWM4IE/5nCwO/dBYQWDPH+m15vVxqojEzWUg1G34AqV73KsXkQ2fphyqR+IuJiuRruspUtQCdo4FY=
X-Received: by 2002:aa7:ca04:: with SMTP id y4mr16383323eds.339.1616779671029;
 Fri, 26 Mar 2021 10:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210324230759.2213957-1-minchan@kernel.org> <CADYN=9+0it8b8sWB+sixY02UEPyc+hn=nk99WgVp1sm0YRAgTA@mail.gmail.com>
 <YF4C7AwqxYytU1Sv@google.com>
In-Reply-To: <YF4C7AwqxYytU1Sv@google.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 26 Mar 2021 18:27:39 +0100
Message-ID: <CADYN=9L=mG4qqNj0GyzigqhnAV6Lcfi0AvuQ-+Ladp680e1=Zg@mail.gmail.com>
Subject: Re: [PATCH v8] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, jhubbard@nvidia.com,
        Matthew Wilcox <willy@infradead.org>, digetx@gmail.com,
        Colin Ian King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 at 16:51, Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Mar 26, 2021 at 02:59:30PM +0100, Anders Roxell wrote:
> > On Thu, 25 Mar 2021 at 00:09, Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > Since CMA is getting used more widely, it's more important to
> > > keep monitoring CMA statistics for system health since it's
> > > directly related to user experience.
> > >
> > > This patch introduces sysfs statistics for CMA, in order to provide
> > > some basic monitoring of the CMA allocator.
> > >
> > >  * the number of CMA page successful allocations
> > >  * the number of CMA page allocation failures
> > >
> > > These two values allow the user to calcuate the allocation
> > > failure rate for each CMA area.
> > >
> > > e.g.)
> > >   /sys/kernel/mm/cma/WIFI/alloc_pages_[success|fail]
> > >   /sys/kernel/mm/cma/SENSOR/alloc_pages_[success|fail]
> > >   /sys/kernel/mm/cma/BLUETOOTH/alloc_pages_[success|fail]
> > >
> > > The cma_stat was intentionally allocated by dynamic allocation
> > > to harmonize with kobject lifetime management.
> > > https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/
> > >
> > > Tested-by: Dmitry Osipenko <digetx@gmail.com>
> > > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > > Link: https://lore.kernel.org/linux-mm/20210316100433.17665-1-colin.king@canonical.com/
> > > Addresses-Coverity: ("Dereference after null check")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> >
> > When I build an arm64 kernel (allmodconfig - boot selftest) on today's
> > next tag: next-20210326, I see this issue when I'm booting in qemu.
> >
> > [    0.985891][    T9] Callback from call_rcu_tasks() invoked.
> > [    1.008860][    T1] smp: Bringing up secondary CPUs ...
> > [    1.012655][    T1] smp: Brought up 1 node, 1 CPU
> > [    1.015194][    T1] SMP: Total of 1 processors activated.
> > [    1.018987][    T1] CPU features: detected: 32-bit EL0 Support
> > [    1.021995][    T1] CPU features: detected: CRC32 instructions
> > [    1.026047][    T1] CPU features: detected: 32-bit EL1 Support
> > [    1.033728][    T1] CPU features: emulated: Privileged Access Never
> > (PAN) using TTBR0_EL1 switching
> > [    2.140828][    T1] CPU: All CPU(s) started at EL1
> > [    2.144773][   T17] alternatives: patching kernel code
> > [  132.866390][    C0] watchdog: BUG: soft lockup - CPU#0 stuck for
> > 25s! [pgdatinit0:20]
> > [  132.870865][    C0] Modules linked in:
> > [  132.873037][    C0] irq event stamp: 739758
> > [  132.875308][    C0] hardirqs last  enabled at (739757):
> > [<ffff8000126fb3d0>] _raw_spin_unlock_irqrestore+0x90/0x100
> > [  132.880740][    C0] hardirqs last disabled at (739758):
> > [<ffff8000126e30a4>] enter_el1_irq_or_nmi+0xa4/0xc0
> > [  132.885801][    C0] softirqs last  enabled at (739056):
> > [<ffff800010010f98>] __do_softirq+0x8b8/0x9ac
> > [  132.890571][    C0] softirqs last disabled at (739051):
> > [<ffff80001013742c>] __irq_exit_rcu+0x1ac/0x240
> > [  132.895560][    C0] CPU: 0 PID: 20 Comm: pgdatinit0 Not tainted
> > 5.12.0-rc4-next-20210326-00008-g23921ff47279 #1
> > [  132.900759][    C0] Hardware name: linux,dummy-virt (DT)
> > [  132.903637][    C0] pstate: 40400005 (nZcv daif +PAN -UAO -TCO BTYPE=--)
> > [  132.907212][    C0] pc : _raw_spin_unlock_irqrestore+0xa4/0x100
> > [  132.910432][    C0] lr : _raw_spin_unlock_irqrestore+0x90/0x100
> > [  132.913647][    C0] sp : ffff000007b9f640
> > [  132.915832][    C0] x29: ffff000007b9f640 x28: ffff800016954518
> > [  132.919237][    C0] x27: 000000000000000e x26: dead000000000100
> > [  132.922689][    C0] x25: dead000000000122 x24: 00000000000559b0
> > [  132.926098][    C0] x23: ffff80001550e000 x22: ffff800016954530
> > [  132.929479][    C0] x21: ffff800016954518 x20: 0000000000000000
> > [  132.932901][    C0] x19: ffff800010f662f4 x18: 0000000000001530
> > [  132.936312][    C0] x17: 0000000000001470 x16: 0000000000005518
> > [  132.939723][    C0] x15: 0000000000001578 x14: ffff800010189520
> > [  132.943107][    C0] x13: ffff8000107592e0 x12: ffff600000f73eb1
> > [  132.946520][    C0] x11: 1fffe00000f73eb0 x10: ffff600000f73eb0
> > [  132.949914][    C0] x9 : dfff800000000000 x8 : ffff000007b9f587
> > [  132.953312][    C0] x7 : 0000000000000001 x6 : 00009fffff08c150
> > [  132.956713][    C0] x5 : 0000000000000000 x4 : 0000000000000000
> > [  132.960117][    C0] x3 : ffff000007b90040 x2 : 000000000005e6fd
> > [  132.963521][    C0] x1 : 00000000000000c0 x0 : 0000000000000080
> > [  132.966889][    C0] Call trace:
> > [  132.968667][    C0]  _raw_spin_unlock_irqrestore+0xa4/0x100
> > [  132.971754][    C0]  __debug_check_no_obj_freed+0x1d4/0x2a0
> > [  132.974890][    C0]  debug_check_no_obj_freed+0x20/0x80
> > [  132.977813][    C0]  __free_pages_ok+0x5a0/0x740
> > [  132.980384][    C0]  __free_pages_core+0x24c/0x280
> > [  132.983091][    C0]  deferred_free_range+0x6c/0xbc
> > [  132.985826][    C0]  deferred_init_maxorder+0x2d0/0x350
> > [  132.988735][    C0]  deferred_init_memmap_chunk+0xc8/0x124
> > [  132.991784][    C0]  padata_do_multithreaded+0x15c/0x578
> > [  132.994723][    C0]  deferred_init_memmap+0x26c/0x364
> > [  132.997560][    C0]  kthread+0x23c/0x260
> > [  132.999851][    C0]  ret_from_fork+0x10/0x18
> > [  133.002324][    C0] Kernel panic - not syncing: softlockup: hung tasks
> > [  133.005767][    C0] CPU: 0 PID: 20 Comm: pgdatinit0 Tainted: G
> >        L    5.12.0-rc4-next-20210326-00008-g23921ff47279 #1
> > [  133.011613][    C0] Hardware name: linux,dummy-virt (DT)
> > [  133.014435][    C0] Call trace:
> > [  133.016143][    C0]  dump_backtrace+0x0/0x420
> > [  133.018617][    C0]  show_stack+0x38/0x60
> > [  133.020882][    C0]  dump_stack+0x1fc/0x2c8
> > [  133.023343][    C0]  panic+0x304/0x5d8
> > [  133.025567][    C0]  watchdog_timer_fn+0x4ac/0x500
> > [  133.028209][    C0]  __run_hrtimer+0x770/0xba0
> > [  133.030734][    C0]  __hrtimer_run_queues+0x1a0/0x220
> > [  133.033537][    C0]  hrtimer_run_queues+0x20c/0x240
> > [  133.036202][    C0]  update_process_times+0xbc/0x1a0
> > [  133.038997][    C0]  tick_periodic+0x27c/0x2c0
> > [  133.041510][    C0]  tick_handle_periodic+0x44/0x120
> > [  133.044267][    C0]  arch_timer_handler_virt+0x68/0xa0
> > [  133.047226][    C0]  handle_percpu_devid_irq+0x118/0x2a0
> > [  133.050229][    C0]  __handle_domain_irq+0x150/0x1c0
> > [  133.052959][    C0]  gic_handle_irq+0x130/0x180
> > [  133.055505][    C0]  el1_irq+0xc0/0x15c
> > [  133.057723][    C0]  _raw_spin_unlock_irqrestore+0xa4/0x100
> > [  133.060792][    C0]  __debug_check_no_obj_freed+0x1d4/0x2a0
> > [  133.063869][    C0]  debug_check_no_obj_freed+0x20/0x80
> > [  133.066813][    C0]  __free_pages_ok+0x5a0/0x740
> > [  133.069409][    C0]  __free_pages_core+0x24c/0x280
> > [  133.072127][    C0]  deferred_free_range+0x6c/0xbc
> > [  133.074847][    C0]  deferred_init_maxorder+0x2d0/0x350
> > [  133.077803][    C0]  deferred_init_memmap_chunk+0xc8/0x124
> > [  133.080834][    C0]  padata_do_multithreaded+0x15c/0x578
> > [  133.083791][    C0]  deferred_init_memmap+0x26c/0x364
> > [  133.086614][    C0]  kthread+0x23c/0x260
> > [  133.088879][    C0]  ret_from_fork+0x10/0x18
> > [  133.092092][    C0] ---[ end Kernel panic - not syncing:
> > softlockup: hung tasks ]---
> >
> > Full log [1], and my .config [2].
> >
> > I bisected down to patch 799815f497e2 ("mm: cma: support sysfs").
> >
> > When I revert
> > 799815f497e2 ("mm: cma: support sysfs")
> > 7af97692f30d ("mm: cma: fix potential null dereference on pointer cma")
> >
> > The kernel boots fine.
> >
> > Any idea whats happening?
>
> Hi Anders,
>
> Dmitry reported the crash(However, your callstack is not the same
> and didn't show any CMA stuffs so I am not sure it's same crash)
> and posted the fix.
>
> https://lore.kernel.org/linux-mm/20210324192044.1505747-1-minchan@kernel.org/
>
> However, in the end, it was folded into original patchset to replace it.

Oh, thank you for letting me know, sorry that I reported on the wrong one.

> That is an this v8 patch. So, could you try it?

I was able to boot the kernel.

Cheers,
Anders
