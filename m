Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC4435870
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 03:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhJUBtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 21:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhJUBtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 21:49:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7EE26113D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634780815;
        bh=BiQ6Ok9tsztXXaQtA4aELWgHA+y/OBYDN5rjL5WbOqc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o2HZ1vxG0Uaqk08V9aqyUvWlAzTcvixz7NBLPDSDMcNeop9BDQxfkpQH9nOL1/GMp
         stRpr9Nsz1Vhn0og6qn++mp93DO60QXDUbTFPe7jxo2PGjjlj5tkyFdWAKRAZ8eOIb
         VS0aF4qVW3BV/cf6/dqxO4G55dATf0f1M0tM8nvfUeWOtL4lGsd4GX3po6y18qdkvl
         GXBVEWSbfYRVWQh1tDrJIy+lf3bV16xnjTi4YfR0Rg24SQSgpLKGR9kreHnPJ9/oNr
         FBgEJqWjONYgPCaQIEqmAJMdv5yvPVeOrZK/Ra3j4jEptcpTZ+AhsQnIOhX4n8wJzN
         GrWlpR75mFeDw==
Received: by mail-lf1-f41.google.com with SMTP id y26so1192484lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 18:46:55 -0700 (PDT)
X-Gm-Message-State: AOAM532ZhnglZV4vEokNIKksJv05uRwKvklR0dQGWXqcYY2NaHA4GHv+
        Nr0h29tiVYqKwa8Ov7YEgtXA8+/WM4sLbub2Skk=
X-Google-Smtp-Source: ABdhPJxBTxu95pbGNNITW1Hh2ENk1tznIA6FdU1oYEWsED2d5NUFqPI+NtWSGSK/S8R8GtdmyAUAd+iCCQ06RHB3Hyc=
X-Received: by 2002:a05:6512:3f1b:: with SMTP id y27mr2712392lfa.606.1634780814035;
 Wed, 20 Oct 2021 18:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org> <f850af365f2ac77af79ec59f92e6434a@kernel.org>
 <CAJF2gTShT8Tvk0z6B52zKEi0vq_toc-7mAKWFKj3j-zg=OhpYQ@mail.gmail.com>
 <8735oxuxlq.wl-maz@kernel.org> <CAJF2gTSmyu9nA5M3QLeR1LdGMkeGb7jE93Z9zjixcpb_freLMw@mail.gmail.com>
 <875ytrddma.wl-maz@kernel.org> <CAAhSdy0TwOjv_RDMRsKqcqTE8PSO_A_EttMGBiDbb-0PTRizZg@mail.gmail.com>
 <871r4fd996.wl-maz@kernel.org> <CAAhSdy24WRZP70C0HUA1y0nVf0yWdj4SYY8HhGSfxQzDdafYnQ@mail.gmail.com>
In-Reply-To: <CAAhSdy24WRZP70C0HUA1y0nVf0yWdj4SYY8HhGSfxQzDdafYnQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 21 Oct 2021 09:46:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS2sb8cqwwg1RcyMcjQkaiHTo3g+A9LabUgzm19ZENLfQ@mail.gmail.com>
Message-ID: <CAJF2gTS2sb8cqwwg1RcyMcjQkaiHTo3g+A9LabUgzm19ZENLfQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
To:     Anup Patel <anup@brainfault.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
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

On Thu, Oct 21, 2021 at 12:08 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Oct 20, 2021 at 8:38 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Wed, 20 Oct 2021 15:33:49 +0100,
> > Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Wed, Oct 20, 2021 at 7:04 PM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > On Tue, 19 Oct 2021 14:27:02 +0100,
> > > > Guo Ren <guoren@kernel.org> wrote:
> > > > >
> > > > > On Tue, Oct 19, 2021 at 6:18 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, 19 Oct 2021 10:33:49 +0100,
> > > > > > Guo Ren <guoren@kernel.org> wrote:
> > > > > >
> > > > > > > > If you have an 'automask' behavior and yet the HW doesn't record this
> > > > > > > > in a separate bit, then you need to track this by yourself in the
> > > > > > > > irq_eoi() callback instead. I guess that you would skip the write to
> > > > > > > > the CLAIM register in this case, though I have no idea whether this
> > > > > > > > breaks
> > > > > > > > the HW interrupt state or not.
> > > > > > > The problem is when enable bit is 0 for that irq_number,
> > > > > > > "writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM)" wouldn't affect
> > > > > > > the hw state machine. Then this irq would enter in ack state and no
> > > > > > > continues irqs could come in.
> > > > > >
> > > > > > Really? This means that you cannot mask an interrupt while it is being
> > > > > > handled? How great...
> > > > > If the completion ID does not match an interrupt source that is
> > > > > currently enabled for the target, the completion is silently ignored.
> > > > > So, C9xx completion depends on enable-bit.
> > > >
> > > > Is that what the PLIC spec says? Or what your implementation does? I
> > > > can understand that one implementation would be broken, but if the
> > > > PLIC architecture itself is broken, that's far more concerning.
> > >
> > > Yes, we are dealing with a broken/non-compliant PLIC
> > > implementation.
> > >
> > > The RISC-V PLIC spec defines a very different behaviour for the
> > > interrupt claim (i.e. readl(claim)) and interrupt completion (i.e.
> > > writel(claim)). The T-HEAD PLIC implementation does things
> > > different from what the RISC-V PLIC spec says because it will
> > > mask an interrupt upon interrupt claim whereas PLIC spec says
> > > it should only clear the interrupt pending bit (not mask the interrupt).
> > >
> > > Quoting interrupt claim process (chapter 9) from PLIC spec:
> > > "The PLIC can perform an interrupt claim by reading the claim/complete
> > > register, which returns the ID of the highest priority pending interrupt or
> > > zero if there is no pending interrupt. A successful claim will also atomically
> > > clear the corresponding pending bit on the interrupt source."
> > >
> > > Refer, https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc
> >
> > That's not the point I'm making. According to Guo, the PLIC (any
> > implementation of it) will ignore a write to claim on a masked
> > interrupt.
>
> Yes, write to claim on a masked interrupt is certainly ignored but
> read to claim does not automatically mask the interrupt.
>
> >
> > If that's indeed correct, then a sequence such as:
> >
> > (1) irq = read(claim)
>
> This will return highest priority pending interrupt and clear the
> pending bit as-per RISC-V PLIC spec.
>
> > (2) mask from the interrupt handler with the right flags so that it
> > isn't done lazily
> > (3) write(irq, claim)
> >
> > will result in an interrupt blocked in ack state (and probably no more
> > interrupt for this CPU at this priority). That would be an interesting
> > bug in the current code, but also a pretty bad architectural choice.
>
> The interrupt claim/completion is for each interrupt and not at CPU
> level so if an interrupt is masked then only that interrupt is blocked
> for all CPUs but other interrupts can still be raised.
1.
I think PLIC only could receive a new coming IRQ after completion:

claim IRQ-0
complete IRQ-0
claim IRQ-1
complete IRQ-1
claim IRQ-2
complete IRQ-2

Any recursion would break the PLIC, right? That's why we need to mask
the IRQ before entering this IRQ thread_fn.

2.
plic_handle_irq ->  readl(claim)
handle_fasteoi_irq -> if (desc->istate & IRQS_ONESHOT) mask_irq(desc);
handle_fasteoi_irq -> chip->irq_eoi(&desc->irq_data); // failied

Seems all ONESHOT IRQs would be broken, right?

>
> Regards,
> Anup
>
> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
