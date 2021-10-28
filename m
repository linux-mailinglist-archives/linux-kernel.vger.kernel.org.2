Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581B043D88B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 03:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhJ1BbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 21:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhJ1BbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:31:20 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62DCC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 18:28:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y80so11018493ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfzKd2vgkQfDrWQZtVDjJh7Mhi+T2vul4wAXZwlcYCo=;
        b=hgWwmgVV6g5xybQgwSLBtjXyugKqAY1Irq7ojaDOA4ea2QyEXEFeTUE14eZ/v/oGIn
         BFYGADNpK7FuoI20MC6kvuVqZPZ2de1wUXs4N7vSEYjyHqCYy2PzO+Sy9SU0P4TfRJVA
         0NiZby1Hqb/98HVjVyuLLRgBuuM243Kf9vFjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfzKd2vgkQfDrWQZtVDjJh7Mhi+T2vul4wAXZwlcYCo=;
        b=05uxomkJxj4OVtgUTWRnzwWuD8LZu9nvwd8IQv0DihqX1lrjpw+7Sh6SxakUJIlYHL
         cpXja8NSQg03WaY4n/D1EvHyfbnDznuzTaKQv7Xagnssi0Jkp6fEGDvDZ3CLEUTKCudD
         5d/SOlyCvz6GTfhlPzNb0eiB40WZvyk39WdZUFHsyVURLxmXPnLZm69kI1eLc23zENMk
         W0gg+E72KeVd347B8R8kwNAa6b97b6ReJTw9Z9sDMEL49xADoOBejeRAx+PtqIreSzJX
         2yFTkwLskRZ9YEZorRRGQ5VScXiaOoz0VxxyOIEJPAn6bJGr5YrEcObqq/be7TRdvS/j
         sIXQ==
X-Gm-Message-State: AOAM530l9UXaiLLPyjsv9uXzIuZ7XtPEpbShNIYGWQt6i7Y4p+YWBarl
        D4v+YhSZJT/TDkofDdObC74uJX3uZRCTFb1Haofv
X-Google-Smtp-Source: ABdhPJwg3HxikGp82SuVl8GjPiHpQ0jVVz+E+HzYhzxNsyemMVi28uqNPMGwGaBfjOOdFQXeQ7ddO+rw35fGWQoMrbw=
X-Received: by 2002:a25:4010:: with SMTP id n16mr1354592yba.204.1635384533140;
 Wed, 27 Oct 2021 18:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com>
 <CAOnJCULgjUsnb__QrUFdop3Nr9t6G5WtSsG+EE2d4_e+b7Dy5Q@mail.gmail.com> <CAMuHMdUBFE+dzg0Lqechmj8D4ssJS5O_UCrDBtToWn-EP+0T_g@mail.gmail.com>
In-Reply-To: <CAMuHMdUBFE+dzg0Lqechmj8D4ssJS5O_UCrDBtToWn-EP+0T_g@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 27 Oct 2021 18:28:42 -0700
Message-ID: <CAOnJCUJHXcaLve3Nei+PnnA1-kKUXjShDneK5qNh5ebVnnWMXw@mail.gmail.com>
Subject: Re: Out-of-bounds access when hartid >= NR_CPUS
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 2:03 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Atish,
>
> On Tue, Oct 26, 2021 at 10:55 AM Atish Patra <atishp@atishpatra.org> wrote:
> > On Mon, Oct 25, 2021 at 8:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > When booting a kernel with CONFIG_NR_CPUS=4 on Microchip PolarFire,
> > > the 4th CPU either fails to come online, or the system crashes.
> > >
> > > This happens because PolarFire has 5 CPU cores: hart 0 is an e51,
> > > and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in Linux:
> > >   - unused core has hartid 0 (sifive,e51),
> > >   - processor 0 has hartid 1 (sifive,u74-mc),
> > >   - processor 1 has hartid 2 (sifive,u74-mc),
> > >   - processor 2 has hartid 3 (sifive,u74-mc),
> > >   - processor 3 has hartid 4 (sifive,u74-mc).
> > >
> > > I assume the same issue is present on the SiFive fu540 and fu740
> > > SoCs, but I don't have access to these.  The issue is not present
> > > on StarFive JH7100, as processor 0 has hartid 1, and processor 1 has
> > > hartid 0.
> > >
> > > arch/riscv/kernel/cpu_ops.c has:
> > >
> > >     void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
> > >     void *__cpu_up_task_pointer[NR_CPUS] __section(".data");
> > >
> > >     void cpu_update_secondary_bootdata(unsigned int cpuid,
> > >                                        struct task_struct *tidle)
> > >     {
> > >             int hartid = cpuid_to_hartid_map(cpuid);
> > >
> > >             /* Make sure tidle is updated */
> > >             smp_mb();
> > >             WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> > >                        task_stack_page(tidle) + THREAD_SIZE);
> > >             WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> > >
> > > The above two writes cause out-of-bound accesses beyond
> > > __cpu_up_{stack,pointer}_pointer[] if hartid >= CONFIG_NR_CPUS.
> > >
> > >     }
> > >
> >
> > Thanks for reporting this. We need to fix this and definitely shouldn't hide it
> > using configs. I guess I never tested with lower values (2 or 4) for
> > CONFIG_NR_CPUS which explains how this bug was not noticed until now.
>
> > > How to fix this?
> > >
> > > We could skip hartids >= NR_CPUS, but that feels strange to me, as
> > > you need NR_CPUS to be larger (much larger if the first usable hartid
> > > is a large number) than the number of CPUs used.
> > >
> > > We could store the minimum hartid, and always subtract that when
> > > accessing __cpu_up_{stack,pointer}_pointer[] (also in
> > > arch/riscv/kernel/head.S), but that means unused cores cannot be in the
> > > middle of the hartid range.
> >
> > Yeah. Both of the above proposed solutions are not ideal.
> >
> > >
> > > Are hartids guaranteed to be continuous? If not, we have no choice but
> > > to index __cpu_up_{stack,pointer}_pointer[] by cpuid instead, which
> > > needs a more expensive conversion in arch/riscv/kernel/head.S.
> >
> > This will work for ordered booting with SBI HSM extension. However, it may
> > fail for spinwait booting because cpuid_to_hartid_map might not have setup
> > depending on when secondary harts are jumping to linux.
> >
> > Ideally, the size of the __cpu_up_{stack,task}_pointer[] should be the maximum
> > hartid possible. How about adding a config for that ?
>
> (reading more RISC-V specs)
> Hart IDs can use up to XLEN (32, 64, or 128) bits. So creative sparse
> multi-level encodings like used in MPIDR on ARM[1] makes using a
> simple array infeasible.
>

Hmm. Should we worry about similar creative sparse encodings when it appears ?
Maybe we can dodge it all together.

The other approach would be to go with your proposed solution to
convert the hartid it to the cpuid in head.S
However, this can only be fixed for ordered booting. Most of today's
users have probably moved on to ordered booting.
The only user who would be using spinwait would be

1. whoever still uses BBL
2. whoever still uses OpenSBI v0.6 or older

Maybe we can document this bug in the Linux kernel for the spinwait
method and move on.
Hopefully, we can remove the spinwait method in a couple of years.

Is that acceptable ?

> [1] arch/arm{,64}/include/asm/cputype.h
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Regards,
Atish
