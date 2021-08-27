Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7735E3F95CD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbhH0INZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhH0INX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:13:23 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DDDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:12:34 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id k124so1645738vke.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIx8TFemvedEtqGbRbQf0q22wr272bZtmeZhQYgAETY=;
        b=THn6pO4g0QMpgE0IP7GllH5buf9ko1SSmIKaWcJ62NiL+ZfZKQSeorgeq6BoMt6Urn
         XgeogDrf+VJY9jptK2lz6U6b3Qs9ohylKQ2X/YH0BYQjdHUXo5UjhPqT7FwK9w9ykl3X
         DuNvuq0QcH2Y3gTUNSjf5UNnL30SOQ5qxfYIujrL9dl6fwLsxvhz1uPMnzdxN1IJ3y78
         0oavdDJ4lbMgEp6YMOZjyTz67mpQmJm8FktAdN4o+7zpGDAjoDx5ZHmBnYyekIkzaRtZ
         8o2cmokZqzDINFiCAL51TA/wfQBkW4QWQWRNPzySVLQHQ1nbQ0QLWYEGmL/rmG+I76qn
         Mf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIx8TFemvedEtqGbRbQf0q22wr272bZtmeZhQYgAETY=;
        b=RI20Nf9KsslVNV44E2o5fzZCAWKdhNf+bdyomb4QrAjRVG7w91TraIKXRDzQPSAn0r
         93olT1+bLeS5pF0SNJbaFi4oXdGlgXaM8RWu4NmmU0tEOgMYr9WJHPQA7q3khJ9rJAn/
         TOCMVhNgOxkVaxRzFnvYH2o5m2VsTWnduXszYgRUCGSKrwY9+ohV2CeGhmY0SS6Kqy2l
         h7Iv2D8IOfyy8OsFFbRoHvcjs1fIiocINxxmCxEi0xA+DPZp/3Olhu1r/c+CIg9B9QWU
         dVkMnupkwsZLPR2yb7Y0azh+tffnBAAvBzDU85A3exC8nk61yuDf56rmcDKOEwlHYM4v
         31tg==
X-Gm-Message-State: AOAM5312M/qdYsnbuCn54pfQAHZhqC6oJ4haxVLJtd3efIzCBX7YKJdf
        eXSX4RptykX0cSj7vbEzYvlP8s7bSgEbwTTh4f4=
X-Google-Smtp-Source: ABdhPJxZOtkn3hVNHxMK03a1UDn93hXS4QmYMOSJwGa0w2vjV2lG8PxqWJpnm6cskhcVUiBlIJ14oYG3SC8uvDYNXpU=
X-Received: by 2002:a1f:bd0a:: with SMTP id n10mr5378787vkf.5.1630051953917;
 Fri, 27 Aug 2021 01:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210825061152.3396398-1-chenhuacai@loongson.cn>
 <20210825061152.3396398-9-chenhuacai@loongson.cn> <87pmu1q5ms.wl-maz@kernel.org>
In-Reply-To: <87pmu1q5ms.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 27 Aug 2021 16:12:22 +0800
Message-ID: <CAAhV-H6Dto8fmZ0P9i6J6DL_w18G+0PUJ6TPOFKr9w3_CUY-EQ@mail.gmail.com>
Subject: Re: [PATCH V3 08/10] irqchip: Add LoongArch CPU interrupt controller support
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

On Wed, Aug 25, 2021 at 4:40 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 25 Aug 2021 07:11:50 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > We are preparing to add new Loongson (based on LoongArch, not MIPS)
>
> You keep saying "not MIPS", and yet all I see is a blind copy of the
> MIPS code.
I say "not MIPS" means it isn't compatible with MIPS, but it is
similar to MIPS, so I copy something from MIPS. Of course MIPS is not
a good example (though it works), so I will rework this patch again.

>
> > support. This patch add LoongArch CPU interrupt controller support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/Kconfig             | 10 ++++
> >  drivers/irqchip/Makefile            |  1 +
> >  drivers/irqchip/irq-loongarch-cpu.c | 76 +++++++++++++++++++++++++++++
> >  3 files changed, 87 insertions(+)
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
> > index 000000000000..8e9e8d39cb22
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-loongarch-cpu.c
> > @@ -0,0 +1,76 @@
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
> > +static inline void enable_loongarch_irq(struct irq_data *d)
>
> Why 'inline' given that it is used as a function pointer?
>
> > +{
> > +     set_csr_ecfg(ECFGF(d->hwirq));
> > +}
> > +
> > +#define eoi_loongarch_irq enable_loongarch_irq
>
> NAK. EOI and enable cannot be the same operation.
>
> > +
> > +static inline void disable_loongarch_irq(struct irq_data *d)
> > +{
> > +     clear_csr_ecfg(ECFGF(d->hwirq));
> > +}
> > +
> > +#define ack_loongarch_irq disable_loongarch_irq
>
> Same thing. Either you have different operations, or this only
> supports mask/unmask.
>
> > +
> > +static struct irq_chip loongarch_cpu_irq_controller = {
> > +     .name           = "LoongArch",
> > +     .irq_ack        = ack_loongarch_irq,
> > +     .irq_eoi        = eoi_loongarch_irq,
> > +     .irq_enable     = enable_loongarch_irq,
> > +     .irq_disable    = disable_loongarch_irq,
> > +};
> > +
> > +asmlinkage void default_handle_irq(int irq)
> > +{
> > +     do_IRQ(irq_linear_revmap(irq_domain, irq));
>
> This looks both wrong and short sighted:
>
> - irq_linear_revmap() is now another name for irq_find_mapping().
>   Which means it uses a RCU read critical section. If, as I expect,
>   this is just a blind copy of the MIPS code, do_IRQ() will not do
>   anything with respect to irq_enter()/irq_exit(), which will result
>   in something pretty bad on the exit from idle path. Lockdep will
>   probably shout at you pretty loudly.
>
> - A single root interrupt controller is, in my modest experience,
>   something that rarely happen. You will eventually have a variety of
>   them, and you will have to join the other arches such as arm, arm64,
>   riscv and csky that use CONFIG_GENERIC_IRQ_MULTI_HANDLER instead of
>   following the existing MIPS model.
>
> You can solve this by:
>
> - Move over to CONFIG_GENERIC_IRQ_MULTI_HANDLER so that the interrupt
>   controller can register itself with the core, rather than being
>   defined at compile time.
>
> - Drop the do_IRQ() madness. Perform whenever stuff you need to do in
>   the arch code *before* calling into the interrupt controller code.
>
> - Use generic_handle_irq() to call into the irq stack. It will handle
>   all the irq_enter()/irq_exit() correctly. It will also avoid the
>   silly double lookup of the irq_desc on interrupt handling.
Thank you for your suggestions, this is very helpful.

Huacai
>
> > +}
> > +
> > +static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
> > +                          irq_hw_number_t hwirq)
> > +{
> > +     struct irq_chip *chip;
> > +
> > +     irq_set_noprobe(irq);
> > +     chip = &loongarch_cpu_irq_controller;
> > +     set_vi_handler(EXCCODE_INT_START + hwirq, default_handle_irq);
>
> What is that? Yet another MIPS legacy? Why does it have to be per
> interrupt if it obviously apply to each and every root interrupt?
>
> Given that 'vi' probably stands for "vectored interrupt", why isn't
> that the irq_enable() code?
>
> > +     irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
> > +     .map = loongarch_cpu_intc_map,
> > +     .xlate = irq_domain_xlate_onecell,
> > +};
> > +
> > +int __init loongarch_cpu_irq_init(void)
> > +{
> > +     /* Mask interrupts. */
> > +     clear_csr_ecfg(ECFG0_IM);
> > +     clear_csr_estat(ESTATF_IP);
> > +
> > +     irq_domain = irq_domain_add_simple(NULL, EXCCODE_INT_NUM,
> > +                  LOONGSON_CPU_IRQ_BASE, &loongarch_cpu_intc_irq_domain_ops, NULL);
>
> NAK. You still obviously have some static partitioning of the
> interrupt space, which is not acceptable for a new architecture.
>
> > +
> > +     if (!irq_domain)
> > +             panic("Failed to add irqdomain for LoongArch CPU");
> > +
> > +     return 0;
> > +}
>
> I haven't seen much progress from the first version I reviewed. This
> is still the same antiquated, broken MIPS code, only with a different
> name.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
