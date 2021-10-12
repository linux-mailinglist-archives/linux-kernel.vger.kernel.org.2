Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF292429AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhJLBYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232148AbhJLBYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:24:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED35160F22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634001773;
        bh=XM2NRJccgxND7m0Mlqsxadwo2rATHdUUDllqG1KrA20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iB8MZy/9A0LoAM9ynq8J8Hrn1v6AGyqG9D4Lub376hhcU1NzWLltcMAC5COselTCO
         HlNZJzNCk4mJdETBmTjXgCVCq9JTgJ5e+nGAF3diTdYNXRqyKptSo2MeiKdo81YTd6
         DMnMOlJSGw3BE9mYC076qiQwKfEFp3OHaZY93kW+oryKcLj3dr4/h8C8rgEVNG60h9
         lfWbXk9jJhpqPur16JvRSkpKEI6j7W3uQLaxGGbjruoOeLSdSXsMps0oIOyELRRGoD
         18BRpmKOblQT7QMntWaQjbUctgjMXRmiJUNsntCKA1QwoLCLRtPigUXWn0K+MinpeK
         jtVm9Lbr5rBhA==
Received: by mail-vk1-f179.google.com with SMTP id x207so8696877vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:22:52 -0700 (PDT)
X-Gm-Message-State: AOAM532koAMw5ggnggOS17G16NYIQTR0wyuFRsauXLuzYJD3K0gIphKr
        zZUTq3sfZpORweU2LOHO6jcpGI940pDXh9dfScQ=
X-Google-Smtp-Source: ABdhPJxdfoYYG8Z/5jPPiLI202N0xiC0dHhM75NEkRh/kdaAbP0kEJRLXDusuGmqgJRThSX6aN0AG4r7pbrXSnH4aL0=
X-Received: by 2002:a67:ca1c:: with SMTP id z28mr27488752vsk.11.1634001772006;
 Mon, 11 Oct 2021 18:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211011132431.2792797-1-guoren@kernel.org> <CAAhSdy1xjRE0TJ_Nd9fdz4RAK2J5FskQYbWDVXO7jhfcZsFm_g@mail.gmail.com>
In-Reply-To: <CAAhSdy1xjRE0TJ_Nd9fdz4RAK2J5FskQYbWDVXO7jhfcZsFm_g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Oct 2021 09:22:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRUSyyaniW6mcLSuO5td8ih8O0YOFbbY2EwVqgmzX+0nQ@mail.gmail.com>
Message-ID: <CAJF2gTRUSyyaniW6mcLSuO5td8ih8O0YOFbbY2EwVqgmzX+0nQ@mail.gmail.com>
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

On Mon, Oct 11, 2021 at 11:02 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Oct 11, 2021 at 6:54 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > PLIC only has enable-registers not mask/unmask registers. Mixing
> > mask/unmask with irq_eoi is wrong, because readl(claim) could mask
>
> This is an incorrect assumption about readl(claim). When SW does
> read(claim) the HW updates internal state that IRQ has been claimed.
> The HW can still get same (already claimed) IRQ again before
> writel(claim) which will be delivered after writel(claim).
Our hw would mask IRQ with readl(claim), so it's unnecessary for our
board. I agree some hardware won't mask IRQ after readl(claim), so I
put DT-bool to control it.

>
> > irq by hardware. We only need mask/unmask to fixup the hardware
> > which couldn't claim + mask correctly.
>
> The handle_fasteoi_irq() only calls unmask_irq() mostly when the
> underlying IRQ is threaded. Is there any other case ?
When in handle_fasteoi_irq ONESHOT path, it will call:
        if (desc->istate & IRQS_ONESHOT)
                mask_irq(desc);

mask_irq->plic_irq_mask->"write 0 to PRIORITY & ENABLE_BASE-bit"

In this IRQ context, it wouldn't call unmask_irq with
cond_unmask_eoi_irq when in IRQCHIP_EOI_THREADED. Then the path would
writel(hwirq, claim) with irq disabled.
static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
{
...
        } else if (!(chip->flags & IRQCHIP_EOI_THREADED)) {
                chip->irq_eoi(&desc->irq_data);
        }

When IRQ is disabled in c9xx, writel(hwirq, claim) would be invalid
and cause a blocking irq bug.

>
> Another fact is that all irqchip drivers using handle_fasteoi_irq()
> implement irq_mask/unmask().
C9xx needn't call mask&unmask after readl(claim), because:
1. If hw supports readl(claim) with acquiring irq then the mask/unmask
is unnecessary and causes performance problems.
2. When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED path, unnecessary mask
operation would cause a blocking irq bug.

>
> Regards,
> Anup
>
> >
> > If hardware supports claim + mask, it would cause unnecessary
> > mask/umak operations.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index cf74cfa82045..0fa46912f452 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -64,6 +64,7 @@ struct plic_priv {
> >         struct cpumask lmask;
> >         struct irq_domain *irqdomain;
> >         void __iomem *regs;
> > +       bool claim_mask_support;
> >  };
> >
> >  struct plic_handler {
> > @@ -111,7 +112,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
> >         }
> >  }
> >
> > -static void plic_irq_unmask(struct irq_data *d)
> > +static void plic_irq_enable(struct irq_data *d)
> >  {
> >         struct cpumask amask;
> >         unsigned int cpu;
> > @@ -125,7 +126,7 @@ static void plic_irq_unmask(struct irq_data *d)
> >         plic_irq_toggle(cpumask_of(cpu), d, 1);
> >  }
> >
> > -static void plic_irq_mask(struct irq_data *d)
> > +static void plic_irq_disable(struct irq_data *d)
> >  {
> >         struct plic_priv *priv = irq_data_get_irq_chip_data(d);
> >
> > @@ -168,8 +169,8 @@ static void plic_irq_eoi(struct irq_data *d)
> >
> >  static struct irq_chip plic_chip = {
> >         .name           = "SiFive PLIC",
> > -       .irq_mask       = plic_irq_mask,
> > -       .irq_unmask     = plic_irq_unmask,
> > +       .irq_enable     = plic_irq_enable,
> > +       .irq_disable    = plic_irq_disable,
> >         .irq_eoi        = plic_irq_eoi,
> >  #ifdef CONFIG_SMP
> >         .irq_set_affinity = plic_set_affinity,
> > @@ -181,6 +182,11 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >  {
> >         struct plic_priv *priv = d->host_data;
> >
> > +       if (!priv->claim_mask_support) {
> > +               plic_chip.irq_mask      = plic_irq_disable;
> > +               plic_chip.irq_unmask    = plic_irq_enable;
> > +       }
> > +
> >         irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> >                             handle_fasteoi_irq, NULL, NULL);
> >         irq_set_noprobe(irq);
> > @@ -298,6 +304,8 @@ static int __init plic_init(struct device_node *node,
> >         if (WARN_ON(!nr_contexts))
> >                 goto out_iounmap;
> >
> > +       priv->claim_mask_support = of_property_read_bool(node, "claim-mask-support");
> > +
> >         error = -ENOMEM;
> >         priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
> >                         &plic_irqdomain_ops, priv);
> > --
> > 2.25.1
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
