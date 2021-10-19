Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725D9433573
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhJSMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235466AbhJSMKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:10:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C78A60FD8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 12:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634645317;
        bh=5nPRHKIP9eYkiOuntM3zn2Qn2ZVQwDrthsEbHkwU/rE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IZwzW4oH+VPNGXmvEC2e4dPYKDhFOBGXeG2HpPADbdiAuYpRN1T4PLcnGIc54RHhA
         Ju664zJ0PkZ4bngm+a7xKbY4xdSOOX10H5/Ze6B1JOoL+3CHZVPWr7BgsxFwf6ITv7
         ECbe8OQ+efCv042ASOX6YGZPiGTpaqjWOiPphXE+BJhxEPumsSifS1ADqd9dKIr1Qi
         nTMC3LdddsF2oFNqoP349EiH7zx2ipxdG4YyOQAfNYkQMUQSctLDh3vZbkSlRb/viK
         eOkZllcBHS90XbYL3iaR0jX2A9xdE9kcSES6dAukHx7xIdPjT6fbDpgtS2tVMWE3WA
         r8hZmqJmD+pRg==
Received: by mail-vk1-f176.google.com with SMTP id 34so10187023vkl.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:08:37 -0700 (PDT)
X-Gm-Message-State: AOAM533VCX6Ontf+L4IFGkU838EDMFPp67j+jzdqe/MtibXqMgcz/6sr
        /YAfLWe5BLPE2UFHsjL0B73q1DwVy9oQYo/OSuQ=
X-Google-Smtp-Source: ABdhPJzj3XALoe/oBtGzqznvV3w2Y5Ar/58hu+edopFQM1cWJAAhWYhEpoEz7HzTMsPrn2IW23goifaseSIjzaaLd40=
X-Received: by 2002:a05:6122:788:: with SMTP id k8mr26869086vkr.8.1634645316437;
 Tue, 19 Oct 2021 05:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211011132431.2792797-1-guoren@kernel.org> <CAAhSdy1xjRE0TJ_Nd9fdz4RAK2J5FskQYbWDVXO7jhfcZsFm_g@mail.gmail.com>
 <CAJF2gTRUSyyaniW6mcLSuO5td8ih8O0YOFbbY2EwVqgmzX+0nQ@mail.gmail.com> <CAAhSdy1Gb8nTNxCYsSnp820wCVQGS=m7+11jnCgvfPx9dZ6=vQ@mail.gmail.com>
In-Reply-To: <CAAhSdy1Gb8nTNxCYsSnp820wCVQGS=m7+11jnCgvfPx9dZ6=vQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 19 Oct 2021 20:08:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRUUq7Xi6JaMb-hKEmMgU3DFPETtPj4ea8zXx0LofJWyg@mail.gmail.com>
Message-ID: <CAJF2gTRUUq7Xi6JaMb-hKEmMgU3DFPETtPj4ea8zXx0LofJWyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/sifive-plic: Fix duplicate mask/unmask for claim/complete
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 11:37 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Oct 12, 2021 at 6:52 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Mon, Oct 11, 2021 at 11:02 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 6:54 PM <guoren@kernel.org> wrote:
> > > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > PLIC only has enable-registers not mask/unmask registers. Mixing
> > > > mask/unmask with irq_eoi is wrong, because readl(claim) could mask
> > >
> > > This is an incorrect assumption about readl(claim). When SW does
> > > read(claim) the HW updates internal state that IRQ has been claimed.
> > > The HW can still get same (already claimed) IRQ again before
> > > writel(claim) which will be delivered after writel(claim).
> > Our hw would mask IRQ with readl(claim), so it's unnecessary for our
> > board. I agree some hardware won't mask IRQ after readl(claim), so I
> > put DT-bool to control it.
>
> Clearly, the PLIC on C9xx does not comply with RISC-V PLIC because
> it is violating the "Interrupt Claim Process" and "Interrupt Completion
> Process" defined by the RISC-V PLIC specification.
> (Refer, https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc)
10. Interrupt Completion
The PLIC signals it has completed executing an interrupt handler by
writing the interrupt ID it received from the claim to the
claim/complete register. The PLIC does not check whether the
completion ID is the same as the last claim ID for that target. If the
completion ID does not match an interrupt source that is *currently
enabled* for the target, the completion is silently *ignored*.

How do you think about *currently enabled* & *silently ignored*?


>
> I would suggest you to have a separate compatible string
> "thead,c9xx-plic" for C9xx PLIC implementation.
>
> >
> > >
> > > > irq by hardware. We only need mask/unmask to fixup the hardware
> > > > which couldn't claim + mask correctly.
> > >
> > > The handle_fasteoi_irq() only calls unmask_irq() mostly when the
> > > underlying IRQ is threaded. Is there any other case ?
> > When in handle_fasteoi_irq ONESHOT path, it will call:
> >         if (desc->istate & IRQS_ONESHOT)
> >                 mask_irq(desc);
> >
> > mask_irq->plic_irq_mask->"write 0 to PRIORITY & ENABLE_BASE-bit"
> >
> > In this IRQ context, it wouldn't call unmask_irq with
> > cond_unmask_eoi_irq when in IRQCHIP_EOI_THREADED. Then the path would
> > writel(hwirq, claim) with irq disabled.
> > static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
> > {
> > ...
> >         } else if (!(chip->flags & IRQCHIP_EOI_THREADED)) {
> >                 chip->irq_eoi(&desc->irq_data);
> >         }
> >
> > When IRQ is disabled in c9xx, writel(hwirq, claim) would be invalid
> > and cause a blocking irq bug.
>
> Like mentioned above, this is not inline with RISC-V PLIC. You
> should call it C9xx PLIC.
>
> >
> > >
> > > Another fact is that all irqchip drivers using handle_fasteoi_irq()
> > > implement irq_mask/unmask().
> > C9xx needn't call mask&unmask after readl(claim), because:
> > 1. If hw supports readl(claim) with acquiring irq then the mask/unmask
> > is unnecessary and causes performance problems.
> > 2. When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED path, unnecessary mask
> > operation would cause a blocking irq bug.
>
> I would suggest the following:
>
> 1) Add a separate compatible string "thead,c9xx-plic" for your PLIC
> implementation.
>
> 2) In plic_init() when DT node is compatible to "thead,c9xx-plic",
> you should set irq_mask/unmask of "plic_chip" to NULL and point
> irq_enable/disable of "plic_chip" to plic_irq_mask/unmask.
>
> 3) Add a detailed comment block in plic_init() about the differences
> in Claim/Completion process of RISC-V PLIC and C9xx PLIC.
>
> Regards,
> Anup
>
> >
> > >
> > > Regards,
> > > Anup
> > >
> > > >
> > > > If hardware supports claim + mask, it would cause unnecessary
> > > > mask/umak operations.
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > > Cc: Anup Patel <anup@brainfault.org>
> > > > Cc: Atish Patra <atish.patra@wdc.com>
> > > > ---
> > > >  drivers/irqchip/irq-sifive-plic.c | 16 ++++++++++++----
> > > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > > > index cf74cfa82045..0fa46912f452 100644
> > > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > > +++ b/drivers/irqchip/irq-sifive-plic.c
> > > > @@ -64,6 +64,7 @@ struct plic_priv {
> > > >         struct cpumask lmask;
> > > >         struct irq_domain *irqdomain;
> > > >         void __iomem *regs;
> > > > +       bool claim_mask_support;
> > > >  };
> > > >
> > > >  struct plic_handler {
> > > > @@ -111,7 +112,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
> > > >         }
> > > >  }
> > > >
> > > > -static void plic_irq_unmask(struct irq_data *d)
> > > > +static void plic_irq_enable(struct irq_data *d)
> > > >  {
> > > >         struct cpumask amask;
> > > >         unsigned int cpu;
> > > > @@ -125,7 +126,7 @@ static void plic_irq_unmask(struct irq_data *d)
> > > >         plic_irq_toggle(cpumask_of(cpu), d, 1);
> > > >  }
> > > >
> > > > -static void plic_irq_mask(struct irq_data *d)
> > > > +static void plic_irq_disable(struct irq_data *d)
> > > >  {
> > > >         struct plic_priv *priv = irq_data_get_irq_chip_data(d);
> > > >
> > > > @@ -168,8 +169,8 @@ static void plic_irq_eoi(struct irq_data *d)
> > > >
> > > >  static struct irq_chip plic_chip = {
> > > >         .name           = "SiFive PLIC",
> > > > -       .irq_mask       = plic_irq_mask,
> > > > -       .irq_unmask     = plic_irq_unmask,
> > > > +       .irq_enable     = plic_irq_enable,
> > > > +       .irq_disable    = plic_irq_disable,
> > > >         .irq_eoi        = plic_irq_eoi,
> > > >  #ifdef CONFIG_SMP
> > > >         .irq_set_affinity = plic_set_affinity,
> > > > @@ -181,6 +182,11 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> > > >  {
> > > >         struct plic_priv *priv = d->host_data;
> > > >
> > > > +       if (!priv->claim_mask_support) {
> > > > +               plic_chip.irq_mask      = plic_irq_disable;
> > > > +               plic_chip.irq_unmask    = plic_irq_enable;
> > > > +       }
> > > > +
> > > >         irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> > > >                             handle_fasteoi_irq, NULL, NULL);
> > > >         irq_set_noprobe(irq);
> > > > @@ -298,6 +304,8 @@ static int __init plic_init(struct device_node *node,
> > > >         if (WARN_ON(!nr_contexts))
> > > >                 goto out_iounmap;
> > > >
> > > > +       priv->claim_mask_support = of_property_read_bool(node, "claim-mask-support");
> > > > +
> > > >         error = -ENOMEM;
> > > >         priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
> > > >                         &plic_irqdomain_ops, priv);
> > > > --
> > > > 2.25.1
> > > >
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
