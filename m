Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8423FA4ED
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhH1KIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhH1KIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:08:19 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57922C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:07:29 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id i23so6579428vsj.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtj/gpMFpx8qvMVsIwiFw6Cv7Eqh7JdFS2jbIunoY1o=;
        b=JDTB6EJG+wAx0rVhc61S/b/K6PgsPx6WnR0IIo23QyeNs3KERttn+6rdSkUO0s4fr6
         onKXlg3dL97gm/L6PC03gYhaclQGN7RoRlrMF7FqtI5Cj4sFSrgRcyJQqa9fOOpnCEQF
         yGVVrnjmkd7p1vPUoRm+2SeqedQxiyVQWZg5D73MRbHfmsf8UoDVbA1dCTcudJ9Vf+7d
         Q5McJzDHxmG8jJTznkrOFSy1/IyjAUSSj7LFTqst+WedAHqdMtlOJNzDMMukip7qVNRT
         244o/Ksrvjc7ouN6G1pB612STbXpPZXW7hv6KTOzjTJGWREUzSUCuM8HKMDBSs90xS+6
         /Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtj/gpMFpx8qvMVsIwiFw6Cv7Eqh7JdFS2jbIunoY1o=;
        b=NV1UTwVLTMiHFhdbXihztOtCE6QMV7YC/7qNZbBYIkCyCeJVJsuy3VVvfQkwdyhw1t
         mq0D1J76HP/vqHGWoM5xH7ZT4UcwscXE3adSBndNynZFgOB0TZETMFevYieBHSYTAtCI
         l2HUeXvX1JBJjbKxootAXbLyGvpH1sn3aOAEliGJcUkncZsZrkGuJ/ANHwH45uR2lXmN
         eMLs9r+A90HiLoK9jScLACwmjToeGNXgoMMXxou+mdtEm1U1Hr6Vtfk76A4NgoMzwoer
         kZIVADwph4/5mdjmta8FBr04OItYwK5OVdGaI+SiJWw9GEf21t4uZi8oxF6PoUJAWoLi
         bd4g==
X-Gm-Message-State: AOAM53014gJE9rqNUON+K+QkAsnxy44ownocftSUykEDb10Pzr+96n6o
        YaLgMFkCLtdptGHNGeCoMEw+NmhSBVmCsiVCX6E=
X-Google-Smtp-Source: ABdhPJxLukpDKf3Gss51AM/1OQjZ92FPFWSRE4FZj2gLH5I0p6umQd1vqNPUpKG7Ycd69aWr5gm/768dz9zs5xZQ6lo=
X-Received: by 2002:a67:f510:: with SMTP id u16mr10408176vsn.60.1630145248330;
 Sat, 28 Aug 2021 03:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210825061152.3396398-1-chenhuacai@loongson.cn>
 <20210825061152.3396398-9-chenhuacai@loongson.cn> <87pmu1q5ms.wl-maz@kernel.org>
In-Reply-To: <87pmu1q5ms.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 28 Aug 2021 18:07:16 +0800
Message-ID: <CAAhV-H5yadRbTt9a-i-65Mvd6mBxm58R_+mWLfJrauuAe3+qyg@mail.gmail.com>
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
I try to use CONFIG_GENERIC_IRQ_MULTI_HANDLER and
set_handle_irq()/handle_arch_irq() as arm64, riscv and csky do. But I
found a problem:
The main handler (e.g., handle_arch_irq()) take only one argument
(i.e., struct pt_regs *regs) and polling all interrupts, but we want
to use vectored interrupts which take a "irq" argument (as
default_handle_irq() does) which can directly handle it.

This seems that if I want to use vectored interrupts, then I will fall
to the MIPS model.

Huacai
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
