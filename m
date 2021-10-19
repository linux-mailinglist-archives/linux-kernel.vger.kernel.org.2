Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F0543324E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhJSJgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234914AbhJSJgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:36:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9BBA6137E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634636041;
        bh=3UNbOyr82bSSOSjxWwdVdgEz10NAQFkIbzyWwjJ+ZNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YF29Jl/oZPhaXtGBXbLN51d768SoHd7O+cUTu0b1182vASo8A3ARMvxWH5o9tvMwY
         Lv1EC4Oykasz1GEFHNBXRTHOazzH4YZ/vQBQbrWyf+uAtN9AuxBhZgQOAUQR1EsVvg
         /uBCeoEz2Oxm9sq00OKpK22xGhJ3DGXaa6tGlKgqmJ80+TrKR+JErxJpR9Lvemp+Ws
         EQI/A7hmLSDNQykoKy41dda2KmRkrBK2pkvlBd9sx60GqmQtyGpJSwqGzPqTbfvvR1
         PJ393rpYrIJZNkdrgW6LxFDRtQYGeN770gPMQLGITqr8qpMkkj1qNEb0aORaK7ygnv
         ROIQ3V6AMQJbA==
Received: by mail-vk1-f181.google.com with SMTP id bc10so3044284vkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:34:01 -0700 (PDT)
X-Gm-Message-State: AOAM533OK29Nfn/GoVso5gMnzOu2jzvYpFcV2d1whqcqUz4CD52TPn3V
        rNKJLXMPz4K/dIZ2vBSyAsL7VoSpfCojlFk8B+M=
X-Google-Smtp-Source: ABdhPJxJIEctK2xe5aGxfFxMurhpHqGuhiAs2vy2gnKDcHNh3DSmK9px66KXu2nNWAp4/Ns/xrWpfIhBY33Z72BvAwo=
X-Received: by 2002:a05:6122:788:: with SMTP id k8mr26064612vkr.8.1634636040949;
 Tue, 19 Oct 2021 02:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org> <f850af365f2ac77af79ec59f92e6434a@kernel.org>
In-Reply-To: <f850af365f2ac77af79ec59f92e6434a@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 19 Oct 2021 17:33:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTShT8Tvk0z6B52zKEi0vq_toc-7mAKWFKj3j-zg=OhpYQ@mail.gmail.com>
Message-ID: <CAJF2gTShT8Tvk0z6B52zKEi0vq_toc-7mAKWFKj3j-zg=OhpYQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
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

Thx Marc,

On Mon, Oct 18, 2021 at 3:21 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-10-18 06:17, Samuel Holland wrote:
> > On 10/15/21 10:21 PM, guoren@kernel.org wrote:
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> 1) The irq_mask/unmask() is used by handle_fasteoi_irq() is mostly
>
> Drop this useless numbering.
Okay

>
> >> for ONESHOT irqs and there is no limitation in the RISC-V PLIC driver
> >> due to use of irq_mask/unmask() callbacks. In fact, a lot of irqchip
> >> drivers using handle_fasteoi_irq() also implement irq_mask/unmask().
>
> This paragraph doesn't provide any useful information in the context
> of this patch. That's at best cover-letter material.
Okay. I would reconstruct the sentence.

>
> >> 2) The C9xx PLIC does not comply with the interrupt claim/completion
> >> process defined by the RISC-V PLIC specification because C9xx PLIC
> >> will mask an IRQ when it is claimed by PLIC driver (i.e. readl(claim)
> >> and the IRQ will be unmasked upon completion by PLIC driver (i.e.
> >> writel(claim). This behaviour breaks the handling of IRQS_ONESHOT by
> >> the generic handle_fasteoi_irq() used in the PLIC driver.
> >>
> >> 3) This patch adds an errata fix for IRQS_ONESHOT handling on
>
> s/fix/workaround/
Okay

>
> >> C9xx PLIC by using irq_enable/disable() callbacks instead of
> >> irq_mask/unmask().
>
>  From Documentation/process/submitting-patches.rst:
>
> <quote>
> Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.
> </quote>
I would try the style in the next version of the patch.

>
> >>
> >> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >> Cc: Anup Patel <anup@brainfault.org>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >> Cc: Atish Patra <atish.patra@wdc.com>
> >>
> >> ---
> >>
> >> Changes since V4:
> >>  - Update comment by Anup
> >>
> >> Changes since V3:
> >>  - Rename "c9xx" to "c900"
> >>  - Add sifive_plic_chip and thead_plic_chip for difference
> >>
> >> Changes since V2:
> >>  - Add a separate compatible string "thead,c9xx-plic"
> >>  - set irq_mask/unmask of "plic_chip" to NULL and point
> >>    irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
> >>  - Add a detailed comment block in plic_init() about the
> >>    differences in Claim/Completion process of RISC-V PLIC and C9xx
> >>    PLIC.
> >> ---
> >>  drivers/irqchip/irq-sifive-plic.c | 34
> >> +++++++++++++++++++++++++++++--
> >>  1 file changed, 32 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/irqchip/irq-sifive-plic.c
> >> b/drivers/irqchip/irq-sifive-plic.c
> >> index cf74cfa82045..960b29d02070 100644
> >> --- a/drivers/irqchip/irq-sifive-plic.c
> >> +++ b/drivers/irqchip/irq-sifive-plic.c
> >> @@ -166,7 +166,7 @@ static void plic_irq_eoi(struct irq_data *d)
> >>      writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >>  }
> >>
> >> -static struct irq_chip plic_chip = {
> >> +static struct irq_chip sifive_plic_chip = {
> >>      .name           = "SiFive PLIC",
> >>      .irq_mask       = plic_irq_mask,
> >>      .irq_unmask     = plic_irq_unmask,
> >> @@ -176,12 +176,32 @@ static struct irq_chip plic_chip = {
> >>  #endif
> >>  };
> >>
> >> +/*
> >> + * The C9xx PLIC does not comply with the interrupt claim/completion
> >> + * process defined by the RISC-V PLIC specification because C9xx PLIC
> >> + * will mask an IRQ when it is claimed by PLIC driver (i.e.
> >> readl(claim)
> >> + * and the IRQ will be unmasked upon completion by PLIC driver (i.e.
> >> + * writel(claim). This behaviour breaks the handling of IRQS_ONESHOT
> >> by
> >> + * the generic handle_fasteoi_irq() used in the PLIC driver.
> >> + */
> >> +static struct irq_chip thead_plic_chip = {
> >> +    .name           = "T-Head PLIC",
> >> +    .irq_disable    = plic_irq_mask,
> >> +    .irq_enable     = plic_irq_unmask,
> >> +    .irq_eoi        = plic_irq_eoi,
> >> +#ifdef CONFIG_SMP
> >> +    .irq_set_affinity = plic_set_affinity,
> >> +#endif
> > I tested this, and it doesn't work. Without IRQCHIP_EOI_THREADED,
> > .irq_eoi is called at the end of the hard IRQ handler. This unmasks the
> > IRQ before the irqthread has a chance to run, so it causes an interrupt
> > storm for any threaded level IRQ (I saw this happen for sun8i_thermal).
> >
> > With IRQCHIP_EOI_THREADED, .irq_eoi is delayed until after the
> > irqthread
> > runs. This is good. Except that the call to unmask_threaded_irq() is
> > inside a check for IRQD_IRQ_MASKED. And IRQD_IRQ_MASKED will never be
> > set because .irq_mask is NULL. So the end result is that the IRQ is
> > never EOI'd and is masked permanently.
> >
> > If you set .flags = IRQCHIP_EOI_THREADED, and additionally set
> > .irq_mask
> > and .irq_unmask to a dummy function that does nothing, the IRQ core
> > will
> > properly set/unset IRQD_IRQ_MASKED, and the IRQs will flow as expected.
> > But adding dummy functions seems not so ideal, so I am not sure if this
> > is the best solution.
>
> This series is totally broken indeed, because it assumes that
> enable/disable are a substitute to mask/unmask. Nothing could be further
> from the truth. mask/unmask must be implemented, and enable/disable
> supplement them if the HW requires something different at startup time.
After re-studying irqchip, I agree that you are right. The csky-mpintc
driver needs to be corrected, I will send patches asap. I hope you can
continue to help review.

handle_fasteoi_irq itself has avoided mask/unmask, so my understanding
is wrong. The mask/unmask design can prevent "rogue interrupts" from
damaging the system. C-SKY guys encountered the thread_irq interrupt
storm problem. The solution at that time was to pull the interrupt
signal in the handler and put the rest in thread_fn. If we implemented
the mask/unmask correctly in csky-mpintc, it was unnecessary.




>
> If you have an 'automask' behavior and yet the HW doesn't record this
> in a separate bit, then you need to track this by yourself in the
> irq_eoi() callback instead. I guess that you would skip the write to
> the CLAIM register in this case, though I have no idea whether this
> breaks
> the HW interrupt state or not.
The problem is when enable bit is 0 for that irq_number,
"writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM)" wouldn't affect
the hw state machine. Then this irq would enter in ack state and no
continues irqs could come in.

>
> There is an example of this in the Apple AIC driver.
Thx for the tip, I think your suggestion is:
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -163,7 +163,12 @@ static void plic_irq_eoi(struct irq_data *d)
 {
        struct plic_handler *handler = this_cpu_ptr(&plic_handlers);

-       writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+       if (irqd_irq_masked(d)) {
+               plic_irq_unmask(d);
+               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+               plic_irq_mask(d);
+       } else {
+               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+       }
 }

The above could solve the problem, I've tested it on qemu & our hw platform.

>
>          M.
> --
> Jazz is not dead. It just smells funny...

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
