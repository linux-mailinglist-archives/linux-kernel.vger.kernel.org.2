Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612C4431100
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhJRHHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhJRHHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:07:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC59F6124F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634540725;
        bh=Zm8Ho9eB1/3/Ub8lBLbn/YGxOibWZkDMEC+h7+q0RnQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kRpG0lBpmI2MUi1jbdnLd/ffxja2zx8lMB0Dif7wy0vlFBaLv64Unf6FZ+csNfABU
         cox3paU1DKIylQ28hZLROjuYDQdYbAkTWYTsTM5TnHNXxXpqWgk1OrUNpZho6YhvdI
         hwoPvxvRj1+NdWMUcIoWGl5D6fQ1JZr414i3tQVLR/0vjQxMuGW+IUkFtOeh7e5bDl
         vipKxSRPVP9AGQNzw8S9I7KpgeE3v40qeHryangC5D5VXRRBe21rPlb+TfKRLJAZHm
         K5UhiGW7oD20hTlGO7DrcFWJaKabaDJ453vd62cdeIA2eaB6MfQeY3YfRu7hNtkvyh
         kSi+ts30E86Cg==
Received: by mail-ua1-f54.google.com with SMTP id e10so3930144uab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:05:24 -0700 (PDT)
X-Gm-Message-State: AOAM532u+jfDiKErsFlOZ4MQA6I1iKgwY68pf6iQxhcEXpO8EItJfXDX
        DlxbD0Mxo9DMgLysPbKPZZvAsuyYbrxiMW9HMFw=
X-Google-Smtp-Source: ABdhPJyLENNfKQTvM76ddqJx5TPSGUaAAVd35qI9UQ0ZhKH9bb0iZHVMhlF3L32wUY3JMKctzXGyVIPJF9+5lvh4Izk=
X-Received: by 2002:ab0:3c4d:: with SMTP id u13mr24939921uaw.66.1634540724073;
 Mon, 18 Oct 2021 00:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org>
In-Reply-To: <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 18 Oct 2021 15:05:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR1Oo=ERti69_SpcAyGe83PcfbjD5_3D1VrjNLBoftecw@mail.gmail.com>
Message-ID: <CAJF2gTR1Oo=ERti69_SpcAyGe83PcfbjD5_3D1VrjNLBoftecw@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
To:     Samuel Holland <samuel@sholland.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
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

Hi Samuel,

On Mon, Oct 18, 2021 at 1:17 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 10/15/21 10:21 PM, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > 1) The irq_mask/unmask() is used by handle_fasteoi_irq() is mostly
> > for ONESHOT irqs and there is no limitation in the RISC-V PLIC driver
> > due to use of irq_mask/unmask() callbacks. In fact, a lot of irqchip
> > drivers using handle_fasteoi_irq() also implement irq_mask/unmask().
> >
> > 2) The C9xx PLIC does not comply with the interrupt claim/completion
> > process defined by the RISC-V PLIC specification because C9xx PLIC
> > will mask an IRQ when it is claimed by PLIC driver (i.e. readl(claim)
> > and the IRQ will be unmasked upon completion by PLIC driver (i.e.
> > writel(claim). This behaviour breaks the handling of IRQS_ONESHOT by
> > the generic handle_fasteoi_irq() used in the PLIC driver.
> >
> > 3) This patch adds an errata fix for IRQS_ONESHOT handling on
> > C9xx PLIC by using irq_enable/disable() callbacks instead of
> > irq_mask/unmask().
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Atish Patra <atish.patra@wdc.com>
> >
> > ---
> >
> > Changes since V4:
> >  - Update comment by Anup
> >
> > Changes since V3:
> >  - Rename "c9xx" to "c900"
> >  - Add sifive_plic_chip and thead_plic_chip for difference
> >
> > Changes since V2:
> >  - Add a separate compatible string "thead,c9xx-plic"
> >  - set irq_mask/unmask of "plic_chip" to NULL and point
> >    irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
> >  - Add a detailed comment block in plic_init() about the
> >    differences in Claim/Completion process of RISC-V PLIC and C9xx
> >    PLIC.
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 34 +++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index cf74cfa82045..960b29d02070 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -166,7 +166,7 @@ static void plic_irq_eoi(struct irq_data *d)
> >       writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >  }
> >
> > -static struct irq_chip plic_chip = {
> > +static struct irq_chip sifive_plic_chip = {
> >       .name           = "SiFive PLIC",
> >       .irq_mask       = plic_irq_mask,
> >       .irq_unmask     = plic_irq_unmask,
> > @@ -176,12 +176,32 @@ static struct irq_chip plic_chip = {
> >  #endif
> >  };
> >
> > +/*
> > + * The C9xx PLIC does not comply with the interrupt claim/completion
> > + * process defined by the RISC-V PLIC specification because C9xx PLIC
> > + * will mask an IRQ when it is claimed by PLIC driver (i.e. readl(claim)
> > + * and the IRQ will be unmasked upon completion by PLIC driver (i.e.
> > + * writel(claim). This behaviour breaks the handling of IRQS_ONESHOT by
> > + * the generic handle_fasteoi_irq() used in the PLIC driver.
> > + */
> > +static struct irq_chip thead_plic_chip = {
> > +     .name           = "T-Head PLIC",
> > +     .irq_disable    = plic_irq_mask,
> > +     .irq_enable     = plic_irq_unmask,
> > +     .irq_eoi        = plic_irq_eoi,
> > +#ifdef CONFIG_SMP
> > +     .irq_set_affinity = plic_set_affinity,
> > +#endif
> I tested this, and it doesn't work. Without IRQCHIP_EOI_THREADED,
> .irq_eoi is called at the end of the hard IRQ handler. This unmasks the
> IRQ before the irqthread has a chance to run, so it causes an interrupt
> storm for any threaded level IRQ (I saw this happen for sun8i_thermal).
devm_request_threaded_irq(struct device *dev, unsigned int irq,
irq_handler_t handler, irq_handler_t thread_fn

I think you should pull down the IRQ level signal in "handler" and put
the backend progress into "thread_fn".

Could you give out your driver code?

>
> With IRQCHIP_EOI_THREADED, .irq_eoi is delayed until after the irqthread
> runs. This is good. Except that the call to unmask_threaded_irq() is
> inside a check for IRQD_IRQ_MASKED. And IRQD_IRQ_MASKED will never be
> set because .irq_mask is NULL. So the end result is that the IRQ is
> never EOI'd and is masked permanently.
I don't think we should use IRQCHIP_EOI_THREADED because it makes the
IRQ path complex, we need to let the driver separate their "handler" &
"thread_fn" properly.

How do you think?

>
> If you set .flags = IRQCHIP_EOI_THREADED, and additionally set .irq_mask
> and .irq_unmask to a dummy function that does nothing, the IRQ core will
> properly set/unset IRQD_IRQ_MASKED, and the IRQs will flow as expected.
> But adding dummy functions seems not so ideal, so I am not sure if this
> is the best solution.
It's ununderstandable, we need to find a way.

Thx for the test & the question.

>
> Regards,
> Samuel
>
> > +};
> > +
> > +static struct irq_chip *def_plic_chip = &sifive_plic_chip;
> > +
> >  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >                             irq_hw_number_t hwirq)
> >  {
> >       struct plic_priv *priv = d->host_data;
> >
> > -     irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> > +     irq_domain_set_info(d, irq, hwirq, def_plic_chip, d->host_data,
> >                           handle_fasteoi_irq, NULL, NULL);
> >       irq_set_noprobe(irq);
> >       irq_set_affinity(irq, &priv->lmask);
> > @@ -390,5 +410,15 @@ static int __init plic_init(struct device_node *node,
> >       return error;
> >  }
> >
> > +static int __init thead_c900_plic_init(struct device_node *node,
> > +             struct device_node *parent)
> > +{
> > +     def_plic_chip = &thead_plic_chip;
> > +
> > +     return plic_init(node, parent);
> > +}
> > +
> >  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> >  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
> > +IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", thead_c900_plic_init);
> > +IRQCHIP_DECLARE(allwinner_sun20i_d1_plic, "allwinner,sun20i-d1-plic", thead_c900_plic_init);
> >
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
