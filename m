Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7274C3BE242
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 06:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhGGFAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhGGFAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:00:10 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 21:57:30 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k11so1457393ioa.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 21:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VV8M2xSF2eL09Edi4kMHHw/0zSgOdP4Zm8xnHSDZykM=;
        b=KTfgZ+IURIgEeVkK5YhvnAlDhUzHISuzAxCI1X2a1+8ZwjJBefRZd+uHYc/4PXboak
         bV6k6y3Xw2b3zEu7MwfeYGEoUUnbXFUY3wEgTuZ6WDBHlVVhVPA7aLzalwWwOYk8KV1U
         tbA704qVw+qsybrplmdPol2cFcPvT0cvVD+J+NyImjKxhtpjveq9cO2IPFcvl7UXFfRm
         aYYaODCBThKaFPDU+VQMNBVug1AteUmk715cX3Jpc7N1f5+ADMgLb711Q86GvP2kKKGG
         6kNyIA4zbd8YB40h6dZBh1brQkEGmTaVqxwcjD/R3zueWpZ38iVuGl6sMhIcDLgzP9sf
         Up0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VV8M2xSF2eL09Edi4kMHHw/0zSgOdP4Zm8xnHSDZykM=;
        b=Rz1B7zIWyWDxEPNlNYj73/VzhTjHSzYHt7hw/dPhnkiubZcQMOqiixK+v7Sf4HAXNb
         7Gp60MCnOV5vHCEcNyIW8QSlHbstuOE990s1ZTAaEuff4YN4//f4L9Yy2ingjs6HhGFj
         bar1/qyPxzn51mraaWw2ZP+T89tWW1fYflN1TnMtUISo81tiY8VppPfZDogXmLKZt/aR
         Cn88mlqEeEp0Pagdph5eXvo4MKghX2r8T9AihwP0M78qGy1ajso7mVvCRifBraHQYZmS
         lVokAipaaAeuVJ0J6oE9NISGa65daMYI9uskNKPFaeghki7iQnPo234O4S0If65C5j0W
         PkWQ==
X-Gm-Message-State: AOAM531T9aDYF1OTLrh89R5GvRX+vxchkjVkiDXl45No2aIx/Z27AF9j
        +mr9HR4DAMPP4HORCWjJ3IWPgrtqWY7cp0xZXWs=
X-Google-Smtp-Source: ABdhPJx063XEXgSCJ1uTIq81PRWxa04oCtHHpmQ26Z+ZuTEjoBy+DBKv7JP7SZh2iTAil5Kpug84WeObGyL15UJRX70=
X-Received: by 2002:a5d:889a:: with SMTP id d26mr15359311ioo.14.1625633849551;
 Tue, 06 Jul 2021 21:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210706030904.1411775-1-chenhuacai@loongson.cn>
 <20210706030904.1411775-8-chenhuacai@loongson.cn> <8735sr8tob.wl-maz@kernel.org>
In-Reply-To: <8735sr8tob.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 7 Jul 2021 12:57:17 +0800
Message-ID: <CAAhV-H4ToQ=r8f7pkf3JGoDj2MkrZA+MkMoDEVnQHYZA8exWiA@mail.gmail.com>
Subject: Re: [PATCH 7/9] irqchip: Add LoongArch CPU interrupt controller support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Tue, Jul 6, 2021 at 9:21 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 06 Jul 2021 04:09:02 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > We are preparing to add new Loongson (based on LoongArch, not MIPS)
> > support. This patch add LoongArch CPU interrupt controller support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/Kconfig             | 10 ++++
> >  drivers/irqchip/Makefile            |  1 +
> >  drivers/irqchip/irq-loongarch-cpu.c | 87 +++++++++++++++++++++++++++++
> >  3 files changed, 98 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 084bc4c2eebd..443c3a7a0cc1 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -528,6 +528,16 @@ config EXYNOS_IRQ_COMBINER
> >         Say yes here to add support for the IRQ combiner devices embedded
> >         in Samsung Exynos chips.
> >
> > +config IRQ_LOONGARCH_CPU
> > +     bool
> > +     select GENERIC_IRQ_CHIP
> > +     select IRQ_DOMAIN
> > +     select GENERIC_IRQ_EFFECTIVE_AFF_MASK
> > +     help
> > +       Support for the LoongArch CPU Interrupt Controller. For details of
> > +       irq chip hierarchy on LoongArch platforms please read the document
> > +       Documentation/loongarch/irq-chip-model.rst.
> > +
> >  config LOONGSON_LIOINTC
> >       bool "Loongson Local I/O Interrupt Controller"
> >       depends on MACH_LOONGSON64
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index f88cbf36a9d2..4e34eebe180b 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -105,6 +105,7 @@ obj-$(CONFIG_LS1X_IRQ)                    += irq-ls1x.o
> >  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)    += irq-ti-sci-intr.o
> >  obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)    += irq-ti-sci-inta.o
> >  obj-$(CONFIG_TI_PRUSS_INTC)          += irq-pruss-intc.o
> > +obj-$(CONFIG_IRQ_LOONGARCH_CPU)              += irq-loongarch-cpu.o
> >  obj-$(CONFIG_LOONGSON_LIOINTC)               += irq-loongson-liointc.o
> >  obj-$(CONFIG_LOONGSON_HTPIC)         += irq-loongson-htpic.o
> >  obj-$(CONFIG_LOONGSON_HTVEC)         += irq-loongson-htvec.o
> > diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
> > new file mode 100644
> > index 000000000000..918d61a5a980
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-loongarch-cpu.c
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Loongson Technologies, Inc.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +
> > +#include <asm/setup.h>
> > +#include <asm/loongarchregs.h>
> > +
> > +static struct irq_domain *irq_domain;
> > +
> > +static inline void unmask_loongarch_irq(struct irq_data *d)
> > +{
> > +     set_csr_ecfg(ECFGF(d->hwirq));
> > +}
> > +
> > +static inline void mask_loongarch_irq(struct irq_data *d)
> > +{
> > +     clear_csr_ecfg(ECFGF(d->hwirq));
> > +}
> > +
> > +#define enable_loongarch_irq  unmask_loongarch_irq
> > +#define disable_loongarch_irq mask_loongarch_irq
> > +
> > +static struct irq_chip loongarch_cpu_irq_controller = {
> > +     .name           = "LoongArch",
> > +     .irq_ack        = mask_loongarch_irq,
> > +     .irq_mask       = mask_loongarch_irq,
> > +     .irq_mask_ack   = mask_loongarch_irq,
> > +     .irq_unmask     = unmask_loongarch_irq,
> > +     .irq_eoi        = unmask_loongarch_irq,
> > +     .irq_enable     = enable_loongarch_irq,
> > +     .irq_disable    = disable_loongarch_irq,
>
> NAK. Clearly, you don't understand what these callbacks do.
>
> > +};
> > +
> > +asmlinkage void __weak plat_irq_dispatch(int irq)
> > +{
> > +     do_IRQ(irq_linear_revmap(irq_domain, irq));
> > +}
>
> NAK. If you are going to add a new architecture to Linux, do not mimic
> the MIPS brain-damage. Have your new architecture to support multiple
> interrupt controllers from day one without the need to add these silly
> weak symbols.
>
> Move the low-level code such as this into the architecture code, and
> use the existing domain abstractions.
Thanks, I will consider to rework the whole thing.

Huacai
>
> > +
> > +static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
> > +                          irq_hw_number_t hwirq)
> > +{
> > +     struct irq_chip *chip;
> > +
> > +     chip = &loongarch_cpu_irq_controller;
> > +     set_vi_handler(EXCCODE_INT_START + hwirq, plat_irq_dispatch);
> > +     irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
> > +     .map = loongarch_cpu_intc_map,
> > +     .xlate = irq_domain_xlate_onecell,
>
> Are all interrupts with the same trigger?
>
> > +};
> > +
> > +
> > +int __init loongarch_cpu_irq_init(struct device_node *of_node, struct device_node *parent)
> > +{
> > +     int i;
> > +
> > +     /* Mask interrupts. */
> > +     clear_csr_ecfg(ECFG0_IM);
> > +     clear_csr_estat(ESTATF_IP);
> > +
> > +     irq_alloc_descs(-1, LOONGSON_CPU_IRQ_BASE, EXCCODE_INT_NUM, 0);
> > +
> > +     for (i = LOONGSON_CPU_IRQ_BASE; i <= LOONGSON_CPU_LAST_IRQ; i++)
> > +             irq_set_noprobe(i);
> > +
> > +     irq_domain = irq_domain_add_legacy(of_node, EXCCODE_INT_NUM,
> > +                  LOONGSON_CPU_IRQ_BASE, 0, &loongarch_cpu_intc_irq_domain_ops, NULL);
>
> Oh, the irony of using irq_domain_add_legacy() for a brand new
> architecture...
>
> > +
> > +     if (!irq_domain)
> > +             panic("Failed to add irqdomain for loongarch CPU");
> > +
> > +     return 0;
> > +}
> > +
> > +IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller", loongarch_cpu_irq_init);
>
> As it stands, this driver has zero chance of being merged. You
> seriously need to move your low-level interrupt handling code into the
> 21st century.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
