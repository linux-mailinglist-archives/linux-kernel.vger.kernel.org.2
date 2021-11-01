Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D216144129D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhKAEBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 00:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhKAD7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:59:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FA9F60ED3
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 03:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635739036;
        bh=vD2UwyFwto5xDJ9vPKkwhKHRlIVNNpiJGv601mTK2HE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VzY99RTkpK+PizdpfPHAaJVY0pb1jsCUngE9ibwZkJTJjnudjjoNI30yGpHXt248Z
         VYSmOVgC4T5TNbGCi5kezcwGHHMuD2gPvNjb2w/owqTYalzSPr3D0Iu4mYyJ2A/CK0
         nXGW8L79YGK3sv/kABOyRPMHfxMjRupRMaW9jNI+6XOs8QP4MwweTrGRfQuf26y/Hx
         ACGkxrDZjlXTmu3E/E25NWWcveivmIRCJbrTbHmLEtD9e50i067s566FqwXau0DqSn
         qAKfn2/ejHd67TuIb5TbEefoJ2Oo2lApMyzoWgEbgJ201wBEhH3CaH4wvBlBvUw0vb
         iuujIHIW1DdaA==
Received: by mail-ua1-f51.google.com with SMTP id e5so29471271uam.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:57:16 -0700 (PDT)
X-Gm-Message-State: AOAM5328IkGji8PXYkbeixj2t6sJH7j0QCjB3Z/ea1hIznqq+eFQoL5G
        DywpbH7UjfJD6eNhylpbV5O8mhv33mmjb8OrT/g=
X-Google-Smtp-Source: ABdhPJx8E7EdmetQcQl5APDfBsF8mc6npSChcKidJD53qVVguiTWfZJuI8UMnitBPa9GO1psM2bV7CPNlt9LUuZtf9E=
X-Received: by 2002:a67:fa93:: with SMTP id f19mr26879699vsq.43.1635739035567;
 Sun, 31 Oct 2021 20:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-4-guoren@kernel.org>
 <87a6ixbcse.wl-maz@kernel.org> <20211028135523.5cf4b66b@redslave.neermore.group>
 <87sfwl9oxg.wl-maz@kernel.org> <CAJF2gTR3CqtmKZKS3fOQ9mzSLn7_oh7YoSSmWP1YM=ujB_srMw@mail.gmail.com>
 <CAAhSdy1WrxbMsiWkwOXd_76A6wNAh05C1QQ-oFXoE9U-F0akiA@mail.gmail.com>
In-Reply-To: <CAAhSdy1WrxbMsiWkwOXd_76A6wNAh05C1QQ-oFXoE9U-F0akiA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Nov 2021 11:57:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRwi+yH-hQ0SHKDOuUf=OOMfJxQb6Q5m6xRCPjvbYjqaQ@mail.gmail.com>
Message-ID: <CAJF2gTRwi+yH-hQ0SHKDOuUf=OOMfJxQb6Q5m6xRCPjvbYjqaQ@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] irqchip/sifive-plic: Fixup thead, c900-plic
 request_threaded_irq with ONESHOT
To:     Anup Patel <anup@brainfault.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 10:53 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Nov 1, 2021 at 7:50 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Thu, Oct 28, 2021 at 10:58 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Thu, 28 Oct 2021 11:55:23 +0100,
> > > Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> > > >
> > > > Hello Marc and Guo Ren!
> > > >
> > > > On Mon, 25 Oct 2021 11:48:33 +0100
> > > > Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > > On Sun, 24 Oct 2021 02:33:03 +0100,
> > > > > guoren@kernel.org wrote:
> > > > > >
> > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > >
> > > > > > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the
> > > > > > driver, only the first interrupt could be handled, and continue irq
> > > > > > is blocked by hw. Because the thead,c900-plic couldn't complete
> > > > > > masked irq source which has been disabled in enable register. Add
> > > > > > thead_plic_chip which fix up c906-plic irq source completion
> > > > > > problem by unmask/mask wrapper.
> > > > > >
> > > > > > Here is the description of Interrupt Completion in PLIC spec [1]:
> > > > > >
> > > > > > The PLIC signals it has completed executing an interrupt handler by
> > > > > > writing the interrupt ID it received from the claim to the
> > > > > > claim/complete register. The PLIC does not check whether the
> > > > > > completion ID is the same as the last claim ID for that target. If
> > > > > > the completion ID does not match an interrupt source that is
> > > > > > currently enabled for the target, the ^^ ^^^^^^^^^ ^^^^^^^
> > > > > > completion is silently ignored.
> > > > >
> > > > > Given this bit of the spec...
> > > > >
> > > > > > +static void plic_thead_irq_eoi(struct irq_data *d)
> > > > > > +{
> > > > > > + struct plic_handler *handler =
> > > > > > this_cpu_ptr(&plic_handlers); +
> > > > > > + if (irqd_irq_masked(d)) {
> > > > > > +         plic_irq_unmask(d);
> > > > > > +         writel(d->hwirq, handler->hart_base +
> > > > > > CONTEXT_CLAIM);
> > > > > > +         plic_irq_mask(d);
> > > > > > + } else {
> > > > > > +         writel(d->hwirq, handler->hart_base +
> > > > > > CONTEXT_CLAIM);
> > > > > > + }
> > > > > > +}
> > > > > > +
> > > > >
> > > > > ... it isn't obvious to me why this cannot happen on an SiFive PLIC.
> > > >
> > > > This indeed happens with SiFive PLIC. I am currently tinkering with
> > > > da9063 RTC on SiFive Unmatched, and ALARM irq fires only once. However
> > > > with changes proposed by Guo Ren in plic_thead_irq_eoi, everything
> > > > begins to work fine.
> > > >
> > > > May be these change should be propagated to plic_irq_eoi instead of
> > > > making a new function ?
> > >
> > > That's my impression too. I think the T-Head defect is pretty much
> > > immaterial when you consider how 'interesting' the PLIC architecture
> > > is.
> > Which is the "T-Head defect" you mentioned here?
> >  1. Auto masking with claim + complete (I don't think it's a defect,
> > right? May I add a new patch to utilize the feature to decrease a
> > little duplicate mask/unmask operations in the future?)
>
> This is definitely a defect and non-compliance for T-HEAD because
I just agree with non-compliance, but what's the defect of
auto-masking? If somebody could explain, I'm very grateful.

> no sane interrupt controller would mask interrupt upon claim and this
> is not what RISC-V PLIC defines.
>
> >  2. EOI failed when masked
>
> This defect exists for both RISC-V PLIC and T-HEAD PLIC
> because of the way interrupt completion is defined.
>
> >
> > > Conflating EOI and masking really is a misfeature...
> > I think the problem is riscv PLIC reuse enable bit as mask bit. I
> > recommend separating them. That means:
>
> There are no per-interrupt mask bits. We only have per-context
> and per-interrupt enable bits which is used to provide mask/unmask
> functionality expected by the irqchip framework.
>
> I don't see how this is a problem for RISC-V PLIC. The only real
> issue with RISC-V PLIC is the fact the interrupt completion will be
> ignored for a masked interrupt which is what Marc is pointing at.
So you are not considering add per-interrupt mask bits to solve the
above problem, right?

I don't think you would keep below codes in AIA eoi.
 +             plic_irq_unmask(d);
 +             writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
 +             plic_irq_mask(d);

>
> Regards,
> Anup
>
> >  - EOI still depends on enable bit.
> >  - Add mask/unmask bit regs to do the right thing.
>
>
>
> >
> > >
> > >         M.
> > >
> > > --
> > > Without deviation from the norm, progress is not possible.
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
