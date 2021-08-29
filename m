Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC383FAA79
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhH2Jiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhH2Jix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:38:53 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF80C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:38:01 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id x137so465334vsx.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RbVkSv+VOm23+fR9cD+C7ExtLf1mHTCxQubzmdp2peU=;
        b=QTjHsCOucILQF2jqKwQIFSdkMfXHRUaKZhyWZ0YLQbsCfbHyo+1W201WoCo/2TXm6R
         2P6SmTDEc+sEziBTXP9splrGBuhzvz/F1WEWkz7yu6wsZqtZN03l5r71tY0h27uW1Bp4
         eHMJ/nQ6Rm7aRJQlgVhnHDN4iWzjT+XlkwTRc6JkJIADr697Z+70fdQ8XTb/0F3vcKST
         4lpmLMiowOlSx+vdICc4oQCK4mwLXiUScub4JUydsmyESc7D/Y5ui9JMw6ByPeAp9gZ1
         xsE7gDzcCwGp2mnZ0h9YavYM30muKzYDNVOoXxsZL6uL7c5YsUjdKcUAUigq8nyWQe1j
         sWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RbVkSv+VOm23+fR9cD+C7ExtLf1mHTCxQubzmdp2peU=;
        b=b9LwBpHuodihg9jCUjtDICOQBoLLHBT2sTGE01rWlhTQdFEgHhdy9zz5U1WJLaDRaV
         Y3GgvTFbU+EwSVPXWKgzgUXWwBzppTRA9tzg3J9gkkeXYUsGF37ZhpCVGxLteJiiB3Pb
         pXuEdmrnA/H8W53k4pWGiwrRZdS/oF/gf7OMd7kbr1cDnyMHc1ByjI32uLE2KeFLlNZ/
         sFzEAcZdxra8QXGV0ewH00mf47xpCuy/JMHsJ21CJhg0zt+NeTQuBivvr5gd9TZz/MNx
         ng/Fxh9W5vt+PepEDdAmSaeaGFz7zDEVE88zCrM1mBhXylN76C5kbGLoKJAux/8LbLiP
         VX9g==
X-Gm-Message-State: AOAM533/WX8Dsw1dcK38kdnwsvve3y+dhV1W2IXWuLICKHKHF6SaFcm4
        4W+l9v+zAop26ncc5NI3sAN9uAGj7Oxraia7ln0=
X-Google-Smtp-Source: ABdhPJy/KzKL4+iaDMtPiMR1/lTSHNNXWaLvXVSEAAuEvx0p8LEO7gTYC60u6l0l/9fIO3Y0UQY9rhuftUPkIBUWZCY=
X-Received: by 2002:a67:e3a7:: with SMTP id j7mr12528346vsm.4.1630229880048;
 Sun, 29 Aug 2021 02:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210825061152.3396398-1-chenhuacai@loongson.cn>
 <20210825061152.3396398-9-chenhuacai@loongson.cn> <87pmu1q5ms.wl-maz@kernel.org>
 <CAAhV-H5yadRbTt9a-i-65Mvd6mBxm58R_+mWLfJrauuAe3+qyg@mail.gmail.com> <87v93pddzu.wl-maz@kernel.org>
In-Reply-To: <87v93pddzu.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 29 Aug 2021 17:37:48 +0800
Message-ID: <CAAhV-H41rridOo_3Eq5t9LPz-mefketAKNdhgbguFtZ0Cqz5Ng@mail.gmail.com>
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

On Sat, Aug 28, 2021 at 7:07 PM Marc Zyngier <maz@kernel.org> wrote:
>
> Huacai,
>
> On Sat, 28 Aug 2021 11:07:16 +0100,
> Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > Hi, Marc,
> >
> > On Wed, Aug 25, 2021 at 4:40 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Wed, 25 Aug 2021 07:11:50 +0100,
> > > Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > We are preparing to add new Loongson (based on LoongArch, not MIPS)
> > >
> > > You keep saying "not MIPS", and yet all I see is a blind copy of the
> > > MIPS code.
> > >
> > > > support. This patch add LoongArch CPU interrupt controller support.
> > > >
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  drivers/irqchip/Kconfig             | 10 ++++
> > > >  drivers/irqchip/Makefile            |  1 +
> > > >  drivers/irqchip/irq-loongarch-cpu.c | 76 +++++++++++++++++++++++++++++
> > > >  3 files changed, 87 insertions(+)
> > > >  create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
> > > >
> > > > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > > > index 084bc4c2eebd..443c3a7a0cc1 100644
> > > > --- a/drivers/irqchip/Kconfig
> > > > +++ b/drivers/irqchip/Kconfig
> > > > @@ -528,6 +528,16 @@ config EXYNOS_IRQ_COMBINER
> > > >         Say yes here to add support for the IRQ combiner devices embedded
> > > >         in Samsung Exynos chips.
> > > >
> > > > +config IRQ_LOONGARCH_CPU
> > > > +     bool
> > > > +     select GENERIC_IRQ_CHIP
> > > > +     select IRQ_DOMAIN
> > > > +     select GENERIC_IRQ_EFFECTIVE_AFF_MASK
> > > > +     help
> > > > +       Support for the LoongArch CPU Interrupt Controller. For details of
> > > > +       irq chip hierarchy on LoongArch platforms please read the document
> > > > +       Documentation/loongarch/irq-chip-model.rst.
> > > > +
> > > >  config LOONGSON_LIOINTC
> > > >       bool "Loongson Local I/O Interrupt Controller"
> > > >       depends on MACH_LOONGSON64
> > > > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > > > index f88cbf36a9d2..4e34eebe180b 100644
> > > > --- a/drivers/irqchip/Makefile
> > > > +++ b/drivers/irqchip/Makefile
> > > > @@ -105,6 +105,7 @@ obj-$(CONFIG_LS1X_IRQ)                    += irq-ls1x.o
> > > >  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)    += irq-ti-sci-intr.o
> > > >  obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)    += irq-ti-sci-inta.o
> > > >  obj-$(CONFIG_TI_PRUSS_INTC)          += irq-pruss-intc.o
> > > > +obj-$(CONFIG_IRQ_LOONGARCH_CPU)              += irq-loongarch-cpu.o
> > > >  obj-$(CONFIG_LOONGSON_LIOINTC)               += irq-loongson-liointc.o
> > > >  obj-$(CONFIG_LOONGSON_HTPIC)         += irq-loongson-htpic.o
> > > >  obj-$(CONFIG_LOONGSON_HTVEC)         += irq-loongson-htvec.o
> > > > diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
> > > > new file mode 100644
> > > > index 000000000000..8e9e8d39cb22
> > > > --- /dev/null
> > > > +++ b/drivers/irqchip/irq-loongarch-cpu.c
> > > > @@ -0,0 +1,76 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > > > + */
> > > > +
> > > > +#include <linux/init.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/irq.h>
> > > > +#include <linux/irqchip.h>
> > > > +#include <linux/irqdomain.h>
> > > > +
> > > > +#include <asm/loongarch.h>
> > > > +#include <asm/setup.h>
> > > > +
> > > > +static struct irq_domain *irq_domain;
> > > > +
> > > > +static inline void enable_loongarch_irq(struct irq_data *d)
> > >
> > > Why 'inline' given that it is used as a function pointer?
> > >
> > > > +{
> > > > +     set_csr_ecfg(ECFGF(d->hwirq));
> > > > +}
> > > > +
> > > > +#define eoi_loongarch_irq enable_loongarch_irq
> > >
> > > NAK. EOI and enable cannot be the same operation.
> > >
> > > > +
> > > > +static inline void disable_loongarch_irq(struct irq_data *d)
> > > > +{
> > > > +     clear_csr_ecfg(ECFGF(d->hwirq));
> > > > +}
> > > > +
> > > > +#define ack_loongarch_irq disable_loongarch_irq
> > >
> > > Same thing. Either you have different operations, or this only
> > > supports mask/unmask.
> > >
> > > > +
> > > > +static struct irq_chip loongarch_cpu_irq_controller = {
> > > > +     .name           = "LoongArch",
> > > > +     .irq_ack        = ack_loongarch_irq,
> > > > +     .irq_eoi        = eoi_loongarch_irq,
> > > > +     .irq_enable     = enable_loongarch_irq,
> > > > +     .irq_disable    = disable_loongarch_irq,
> > > > +};
> > > > +
> > > > +asmlinkage void default_handle_irq(int irq)
> > > > +{
> > > > +     do_IRQ(irq_linear_revmap(irq_domain, irq));
> > >
> > > This looks both wrong and short sighted:
> > >
> > > - irq_linear_revmap() is now another name for irq_find_mapping().
> > >   Which means it uses a RCU read critical section. If, as I expect,
> > >   this is just a blind copy of the MIPS code, do_IRQ() will not do
> > >   anything with respect to irq_enter()/irq_exit(), which will result
> > >   in something pretty bad on the exit from idle path. Lockdep will
> > >   probably shout at you pretty loudly.
> > >
> > > - A single root interrupt controller is, in my modest experience,
> > >   something that rarely happen. You will eventually have a variety of
> > >   them, and you will have to join the other arches such as arm, arm64,
> > >   riscv and csky that use CONFIG_GENERIC_IRQ_MULTI_HANDLER instead of
> > >   following the existing MIPS model.
> > I try to use CONFIG_GENERIC_IRQ_MULTI_HANDLER and
> > set_handle_irq()/handle_arch_irq() as arm64, riscv and csky do. But I
> > found a problem:
> > The main handler (e.g., handle_arch_irq()) take only one argument
> > (i.e., struct pt_regs *regs) and polling all interrupts, but we want
> > to use vectored interrupts which take a "irq" argument (as
> > default_handle_irq() does) which can directly handle it.
>
> Are you saying that there is no way for the interrupt controller
> driver to figure out the hwirq number on its own?  That would seem
> pretty odd (even the MIPS GIC has that). Worse case, you can provide
> an arch-specific helper that exposes the current hwirq based on the
> vector that triggered.
We can get the hwirq number by reading CSR.ESTAT register, but in this
way "vectored interrupts" is meaningless.

Huacai
>
> do_IRQ() is a terrible abstraction, and only outlines that your arch
> code is badly structured. What does the arch code have to do with a
> Linux irq number? It shouldn't care at all, because as a value it has
> no significance to the arch code at all. You just go back there
> because the management of your interrupt context is upside down, and
> it really shouldn't matter *what interrupt fired*.
>
> > This seems that if I want to use vectored interrupts, then I will fall
> > to the MIPS model.
>
> Not happening, I'm afraid.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
