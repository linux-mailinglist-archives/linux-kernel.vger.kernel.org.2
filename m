Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1263430FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 07:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhJRFnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 01:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJRFnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:43:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B35C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 22:40:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so39007997wrv.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 22:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkjm+Bi8J7T8XPP53sKHr+5Z6akusLIMIB2gr5LylK8=;
        b=XH8txyXBcD2m81F0JjLcNOoKSCUbM9l5xjIgx01Vh8nfKxZM4rZ2D+hAQt9weVfmBD
         VJ1JRJGfebBDKquONUxbWQ58lIw3sPcGQfcIvnlYvU1LspP9xOZoJPfFIZK27G8y+fB0
         cUh2kL4oJcHHImQEvxMHFqzLjo19TAJgRq968GKslv9xLHILB6G0iX/v6lyDvq5M0+2m
         iO+MO3olY0TCeK7aZYtNPY+ZBpL4p/T7ptp26HMmgId2rQaT5M+JYRRlHpezCdcg4vMS
         jXD52xd2it0aJnoYEKTbFX/GWhpRyDGedacsTqk2f+D3R8rEoJ6CxYnqPPrPkA+8QMc6
         aqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkjm+Bi8J7T8XPP53sKHr+5Z6akusLIMIB2gr5LylK8=;
        b=PbeBClWLoVd/3VKph2R0CB5YvTomyBABZ7REG3ZC/wIn+/d8Pa86qQbLB2ZFnHNaFq
         SKpfD6z7aMXBr+XhvHMXuVg5R8p/Stu/dXMdyd54Nd/4s/VYE0EzM2aCkIlAjuL2K3EF
         yF9bvNxUovEfrQ+AO48uszyNb9dFKSmOsF/+/a7X7ArsYMnJdSramm4otVIDp4n2WokU
         3tzu67uSFQQ3gSoFWQwNY4xV0xKPBFo8b9lgAvZXndRWV27NrrlYFmTHapV/SbS94IBy
         YqbLhoR7cb+47mZG7zgA2Yuzd/n0qM7x6JEnQOJBr7iss9L+Ns3qjZgdB57rtU/+zKhu
         ei0A==
X-Gm-Message-State: AOAM531BPvr8qUyQrF0T28FUIy3qQe48D6j8J3YT/gEeQ/YwI/v4P0Do
        MZ8K8sMFsZ/71z45SEwMJVDVLe609/xJFt26o7mJJQ==
X-Google-Smtp-Source: ABdhPJxndAGotG5djD0ro2r0O/Id4HcAMckY50cuqrq17tP9BylAH8brMIYKrQaO0whGNHibs3rBxzYUKmDkpJGmPg0=
X-Received: by 2002:a05:6000:1acc:: with SMTP id i12mr32479015wry.249.1634535655663;
 Sun, 17 Oct 2021 22:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org>
In-Reply-To: <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 18 Oct 2021 11:10:44 +0530
Message-ID: <CAAhSdy3J4Q2cQ-xe4oxOXbJVEVnXzhkP8YHRS41QA3L1sY-6bA@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
To:     Samuel Holland <samuel@sholland.org>
Cc:     Guo Ren <guoren@kernel.org>, Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:47 AM Samuel Holland <samuel@sholland.org> wrote:
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
>
> With IRQCHIP_EOI_THREADED, .irq_eoi is delayed until after the irqthread
> runs. This is good. Except that the call to unmask_threaded_irq() is
> inside a check for IRQD_IRQ_MASKED. And IRQD_IRQ_MASKED will never be
> set because .irq_mask is NULL. So the end result is that the IRQ is
> never EOI'd and is masked permanently.
>
> If you set .flags = IRQCHIP_EOI_THREADED, and additionally set .irq_mask
> and .irq_unmask to a dummy function that does nothing, the IRQ core will
> properly set/unset IRQD_IRQ_MASKED, and the IRQs will flow as expected.
> But adding dummy functions seems not so ideal, so I am not sure if this
> is the best solution.

This series only tries to optimize a particular case in handle_fasteoi_irq()
for T-HEAD PLIC. I am not sure about this series either.

Although, we do need separate compatible strings for T-HEAD PLIC
because T-HEAD PLIC is not compliant with RISC-V PLIC specification.

Regards,
Anup

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
