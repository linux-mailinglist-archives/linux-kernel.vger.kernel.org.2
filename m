Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E329B41FBC6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhJBMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhJBMfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 08:35:18 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36015C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 05:33:33 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id o124so14410524vsc.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iShBzKiWfQOQKP34myo5NdD/XuDbiC+hqBU2rP9/7qg=;
        b=KOXFsdGZhpKPRVz7VbR3Q8/y4buZXxRDHdOY/A7cf2z4a7BrlhcQpCjKRbkl+8WNKV
         qjG61a+jpeWaF8oEsQZEm/tEHznBUKoKGZtub5Y0jHg/rIUfF736gFY15qkaH1VJms6t
         VnSOsdlnoPnHxtukTG1ba6m5R9Bd0zEbSGqlmnWKNgkQgWNlmUte95DtV8Zi5enqeUyd
         rx4+ttadduEDEQ5qekTD/7EvtY8GHLKvYzdIofoTnJ3Wh4gaYSYSsLdft++LFfsFR90o
         wreEZvuOLKS6ASFlUzz0VTSx2vVYMxxh4Ql4eiHEUvz9UUK/8yCxo7F2xAYIBp8njqL5
         BahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iShBzKiWfQOQKP34myo5NdD/XuDbiC+hqBU2rP9/7qg=;
        b=0R/ZQclRbcGzKhol32M0+6KkIHZSBGOgcW5GhUjRei+6rpSfS1eMhg8vxZDD1S60W3
         Cm3WAqI5jbv/ccpecIp8T2jARIFICJa7ZL0ybon2FOOu5ysFhREIsTJLPfbv3yp6CvPc
         NnuXPDoPGWb473JnWQPnk5s0soQQ7MIaEc6yDN9I0cAhGKq5dYGRMFwlD3+YSe3CijHR
         UT2gDgc/My/6A6iX05DNFftv064hWC0PBsHzN5AETEIkqSCe+wnldAkpsiOzEhi4hXf9
         0K4j47zEPlqyamN/w3vftso2z5fHpevh7enwX3aEmNTtvQiw5YW988WxCyE40Up2imn/
         8c3g==
X-Gm-Message-State: AOAM531l+ykQ5nFmyCuig8aqrc8ERltOZtRliZGaE+lHTP6ilq3955CQ
        MsxwIOuPFyLIiZtScSejsb6vItsnBvPTTLPi0Pbo2wfYH7CycA==
X-Google-Smtp-Source: ABdhPJxwLnETTy2MvoglmwK+iY8iif/Tl+2qbm2mgN9DtawO8z5K0cJD8/Y2fRbpymtTzEHVuNaIwpcmmD5GCCauh9c=
X-Received: by 2002:a05:6102:2757:: with SMTP id p23mr8357965vsu.61.1633178012218;
 Sat, 02 Oct 2021 05:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210916123138.3490474-1-chenhuacai@loongson.cn>
 <20210916123138.3490474-9-chenhuacai@loongson.cn> <87wnmyrvjf.wl-maz@kernel.org>
In-Reply-To: <87wnmyrvjf.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 2 Oct 2021 20:33:20 +0800
Message-ID: <CAAhV-H5xU6TxzUPkXTijvZ85hFBvh-cry=Lxto=YPTvS9T9R0A@mail.gmail.com>
Subject: Re: [PATCH V5 08/10] irqchip: Add LoongArch CPU interrupt controller support
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

On Thu, Sep 30, 2021 at 10:24 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 16 Sep 2021 13:31:36 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > We are preparing to add new Loongson (based on LoongArch, not compatible
> > with old MIPS-based Loongson) support. This patch add the LoongArch CPU
> > interrupt controller support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/Kconfig             | 10 ++++
> >  drivers/irqchip/Makefile            |  1 +
> >  drivers/irqchip/irq-loongarch-cpu.c | 89 +++++++++++++++++++++++++++++
> >  3 files changed, 100 insertions(+)
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
> > index 000000000000..bc15e3cefbd8
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-loongarch-cpu.c
> > @@ -0,0 +1,89 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +
> > +#include <asm/loongarch.h>
> > +#include <asm/setup.h>
> > +
> > +static struct irq_domain *irq_domain;
> > +
> > +static void mask_loongarch_irq(struct irq_data *d)
> > +{
> > +     clear_csr_ecfg(ECFGF(d->hwirq));
>
> Where is this function defined?
It is defined in the arch code.

>
> > +}
> > +
> > +static void unmask_loongarch_irq(struct irq_data *d)
> > +{
> > +     set_csr_ecfg(ECFGF(d->hwirq));
> > +}
> > +
> > +static struct irq_chip cpu_irq_controller = {
> > +     .name           = "LoongArch",
> > +     .irq_mask       = mask_loongarch_irq,
> > +     .irq_unmask     = unmask_loongarch_irq,
> > +};
> > +
> > +static void handle_cpu_irq(struct pt_regs *regs)
> > +{
> > +     int hwirq;
> > +     unsigned int estat = read_csr_estat() & CSR_ESTAT_IS;
> > +
> > +     while ((hwirq = ffs(estat))) {
> > +             estat &= ~BIT(hwirq - 1);
> > +             handle_domain_irq(irq_domain, hwirq - 1, regs);
> > +     }
> > +}
> > +
> > +int get_ipi_irq(void)
> > +{
> > +     return irq_create_mapping(irq_domain, EXCCODE_IPI - EXCCODE_INT_START);
> > +}
> > +
> > +int get_pmc_irq(void)
> > +{
> > +     return irq_create_mapping(irq_domain, EXCCODE_PMC - EXCCODE_INT_START);
> > +}
> > +
> > +int get_timer_irq(void)
> > +{
> > +     return irq_create_mapping(irq_domain, EXCCODE_TIMER - EXCCODE_INT_START);
> > +}
>
> How are these functions used? Why aren't the mappings created using
> the normal DT or ACPI flows? Where are these macros?
Please see the ESTAT register:
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#exception-status
HWI0~HWI7 are configuable (can be created by DT/ACPI), but IPI, TI
(Timer), PCOV (PMC) are hardcoded bits, so we define get_xxx_irq() for
them.

>
> > +
> > +static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
> > +                          irq_hw_number_t hwirq)
> > +{
> > +     irq_set_noprobe(irq);
> > +     irq_set_chip_and_handler(irq, &cpu_irq_controller, handle_percpu_irq);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
> > +     .map = loongarch_cpu_intc_map,
> > +     .xlate = irq_domain_xlate_onecell,
> > +};
> > +
> > +struct irq_domain * __init loongarch_cpu_irq_init(void)
> > +{
> > +     /* Mask interrupts. */
> > +     clear_csr_ecfg(ECFG0_IM);
> > +     clear_csr_estat(ESTATF_IP);
> > +
> > +     irq_domain = irq_domain_add_simple(NULL, EXCCODE_INT_NUM,
>
> This needs to be attached to a firmware node of some sort.
OK, this will be improved.

>
> > +                  0, &loongarch_cpu_intc_irq_domain_ops, NULL);
> > +
> > +     if (!irq_domain)
> > +             panic("Failed to add irqdomain for LoongArch CPU");
> > +
> > +     set_handle_irq(&handle_cpu_irq);
> > +
> > +     return irq_domain;
>
> Who needs to know anything about this irq domain?
LoongArch use ACPI, but ACPI table cannot describe the hierarchy of
irqchips, so we initilize the irqchip subsystem in this way (from arch
code):

+ cpu_domain = loongarch_cpu_irq_init();
+ liointc_domain = liointc_acpi_init(cpu_domain, acpi_liointc);
+ parent_domain = eiointc_acpi_init(cpu_domain, acpi_eiointc[i]);
+ pch_pic_domain[i] = pch_pic_acpi_init(parent_domain, acpi_pchpic[i]);
+ pch_msi_domain[i] = pch_msi_acpi_init(parent_domain, acpi_pchmsi[i]);

Upstream irqchip init function return an irqdomain, and this domain
will be used by downstream irqchips as its parent.

>
> > +}
>
> Given that this refers to all sort of symbols that are not included
> here and that there is no reference to another patch series containing
> the missing code, I'm not sure where you want to take this.

I will add references in the next version. For this version,
arch-specific irq code comes from here:
https://lore.kernel.org/linux-arch/20210927064300.624279-11-chenhuacai@loongson.cn/T/#u

Huacai

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
