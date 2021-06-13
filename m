Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76D73A584B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhFMM2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 08:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhFMM2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 08:28:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9BAC061766
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 05:25:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y7so11233191wrh.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CedaLyXT/oQOMS44WMwA1Yn1YT5L2Y5mE3WMzvk4Nec=;
        b=Vla22lhlDhwzH0V0tZfAp6lf9GbPOibtjyCE86avoTiKJUDhv/iKq5uS7+Z2R6oS/E
         ojxAKjwtnV3zFi9oF3Rkv36ttg1PvAphuDMbO9aYsd/BjccHkMMln8KmnyUbz8D3chUh
         FVolr8aFA/tKcYo+wivA7yjtcBygiExKTVWTODSmTJzNatkNT3kzWXdpm+4PeSG4aI/2
         cS5Gvv5IJsNtL0t45wig6ohiOF88Cd4TFGjYySzEI6YxtyOZ2/kn0Kvs5X1h6ZRqQ4nQ
         XuXjpilMOt0myPrcJWtDXKWyUaYU6Y671FW5BPBO+AswWsP2ThMs7POZ2Le+0plCLEvZ
         5DPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CedaLyXT/oQOMS44WMwA1Yn1YT5L2Y5mE3WMzvk4Nec=;
        b=aS3K+EkYvF2p1BQNzXIb3tbBvIH4RcgIzL9BA1YpTrxUSiK9y0IbFzJ/UYJ9j+KMi0
         /Fe6ZgyEsNpdTs3jvZpQ7+cANcWnPaN8KXieOKIfmIY/FicHiVL8gBo0+x09bQZESFRg
         CJf4osaQpA6+6BOvhgZA4EXI68NlpeWh9lumZM0co8m+8U6lS26fuoLSDJ1IPUhJUklz
         ZLN8rgOCc3/QnQbtSCf2eXxhnTWz8MZGV4nmr9XA+kfAic4ozbIygD8xhl81epOprNFY
         cje8AcTbJgrL4FigE0tWRqwizuNRuos07lfLeupuHINeKGfjYn0q0goCOEC15Y005ny6
         QAwA==
X-Gm-Message-State: AOAM5319Z4cg0teIu91V81eGVOmhWkw+TyZtdzqqDDmwLp0FEhk4sMD6
        gpYlIi3ZbpBHMiiQnYHN5Xvla2GZ09zWdiYr6u7M5g==
X-Google-Smtp-Source: ABdhPJzDZJ0ImBevx9QNHKxBYPkLNodHrbdxR276scCz9w6bcuuS75xFTF3U4ErHLjP4dBXV5OZxpmFB8NV4SwHmj2c=
X-Received: by 2002:a5d:540b:: with SMTP id g11mr14155201wrv.390.1623587151487;
 Sun, 13 Jun 2021 05:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210612160422.330705-1-anup.patel@wdc.com> <20210612160422.330705-6-anup.patel@wdc.com>
 <878s3et831.wl-maz@kernel.org>
In-Reply-To: <878s3et831.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 13 Jun 2021 17:55:40 +0530
Message-ID: <CAAhSdy2e9BsgtTL3ETRC-dvHW9hgKmgRi87Gsk+vUT-kMsJ4NQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 05/10] irqchip: Add ACLINT software interrupt driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 3:11 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 12 Jun 2021 17:04:17 +0100,
> Anup Patel <anup.patel@wdc.com> wrote:
> >
> > The RISC-V ACLINT provides MSWI and SSWI devices for M-mode and
> > S-mode software interrupts respectively. We add irqchip driver
> > which provide IPI operations based on ACLINT [M|S]SWI devices
> > to the Linux RISC-V kernel.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  drivers/irqchip/Kconfig          |  11 +++
> >  drivers/irqchip/Makefile         |   1 +
> >  drivers/irqchip/irq-aclint-swi.c | 122 +++++++++++++++++++++++++++++++
> >  3 files changed, 134 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-aclint-swi.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 62543a4eccc0..2010d493b03b 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -508,6 +508,17 @@ config RISCV_INTC
> >
> >          If you don't know what to do here, say Y.
> >
> > +config RISCV_ACLINT_SWI
> > +     bool "RISC-V Advanced Core Local Interruptor Software Interrupts"
> > +     depends on RISCV
> > +     help
> > +        This enables support for software interrupts using the Advanced
> > +        Core Local Interruptor (ACLINT) found in RISC-V systems.  The
> > +        RISC-V ACLINT provides devices for inter-process interrupt and
> > +        timer functionality.
> > +
> > +        If you don't know what to do here, say Y.
> > +
> >  config SIFIVE_PLIC
> >       bool "SiFive Platform-Level Interrupt Controller"
> >       depends on RISCV
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index f88cbf36a9d2..a6edf6733c1d 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -97,6 +97,7 @@ obj-$(CONFIG_QCOM_PDC)                      += qcom-pdc.o
> >  obj-$(CONFIG_CSKY_MPINTC)            += irq-csky-mpintc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)          += irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)             += irq-riscv-intc.o
> > +obj-$(CONFIG_RISCV_ACLINT_SWI)               += irq-aclint-swi.o
> >  obj-$(CONFIG_SIFIVE_PLIC)            += irq-sifive-plic.o
> >  obj-$(CONFIG_IMX_IRQSTEER)           += irq-imx-irqsteer.o
> >  obj-$(CONFIG_IMX_INTMUX)             += irq-imx-intmux.o
> > diff --git a/drivers/irqchip/irq-aclint-swi.c b/drivers/irqchip/irq-aclint-swi.c
> > new file mode 100644
> > index 000000000000..f9607072cc7b
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-aclint-swi.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#define pr_fmt(fmt) "aclint-swi: " fmt
> > +#include <linux/cpu.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/smp.h>
> > +
> > +struct aclint_swi {
> > +     void __iomem *sip_reg;
> > +};
> > +static DEFINE_PER_CPU(struct aclint_swi, aclint_swis);
> > +
> > +static void aclint_swi_send_ipi(const struct cpumask *target)
> > +{
> > +     unsigned int cpu;
> > +     struct aclint_swi *swi;
> > +
> > +     for_each_cpu(cpu, target) {
> > +             swi = per_cpu_ptr(&aclint_swis, cpu);
> > +             if (!swi->sip_reg) {
> > +                     pr_warn("%s: CPU%d SIP register not available\n",
> > +                             __func__, cpu);
> > +                     continue;
> > +             }
> > +
> > +             writel(1, swi->sip_reg);
> > +     }
> > +}
> > +
> > +static void aclint_swi_clear_ipi(void)
> > +{
> > +     struct aclint_swi *swi = this_cpu_ptr(&aclint_swis);
> > +
> > +     if (!swi->sip_reg) {
> > +             pr_warn("%s: CPU%d SIP register not available\n",
> > +                     __func__, smp_processor_id());
> > +             return;
> > +     }
> > +
> > +     writel(0, swi->sip_reg);
> > +}
> > +
> > +static struct riscv_ipi_ops aclint_swi_ipi_ops = {
> > +     .name = "ACLINT-SWI",
> > +     .use_for_rfence = true,
> > +     .ipi_inject = aclint_swi_send_ipi,
> > +     .ipi_clear = aclint_swi_clear_ipi,
> > +};
> > +
> > +static int __init aclint_swi_init(struct device_node *node,
> > +                               struct device_node *parent)
> > +{
> > +     void __iomem *base;
> > +     struct aclint_swi *swi;
> > +     u32 i, nr_irqs, nr_cpus = 0;
> > +
> > +     /* Map the registers */
> > +     base = of_iomap(node, 0);
> > +     if (!base) {
> > +             pr_err("%pOFP: could not map registers\n", node);
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Iterarte over each target CPU connected with this ACLINT */
> > +     nr_irqs = of_irq_count(node);
> > +     for (i = 0; i < nr_irqs; i++) {
> > +             struct of_phandle_args parent;
> > +             int cpu, hartid;
> > +
> > +             if (of_irq_parse_one(node, i, &parent)) {
> > +                     pr_err("%pOFP: failed to parse irq %d.\n",
> > +                            node, i);
> > +                     continue;
> > +             }
> > +
> > +             if (parent.args[0] != RV_IRQ_SOFT) {
> > +                     pr_err("%pOFP: invalid irq %d (hwirq %d)\n",
> > +                            node, i, parent.args[0]);
> > +                     continue;
> > +             }
> > +
> > +             hartid = riscv_of_parent_hartid(parent.np);
> > +             if (hartid < 0) {
> > +                     pr_warn("failed to parse hart ID for irq %d.\n", i);
> > +                     continue;
> > +             }
> > +
> > +             cpu = riscv_hartid_to_cpuid(hartid);
> > +             if (cpu < 0) {
> > +                     pr_warn("Invalid cpuid for irq %d\n", i);
> > +                     continue;
> > +             }
> > +
> > +             swi = per_cpu_ptr(&aclint_swis, cpu);
> > +             swi->sip_reg = base + i * sizeof(u32);
> > +             nr_cpus++;
> > +     }
> > +
> > +     /* Announce the ACLINT SWI device */
> > +     pr_info("%pOFP: providing IPIs for %d CPUs\n", node, nr_cpus);
> > +
> > +     /* Register the IPI operations */
> > +     riscv_set_ipi_ops(&aclint_swi_ipi_ops);
> > +
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_RISCV_M_MODE
> > +IRQCHIP_DECLARE(riscv_aclint_swi, "riscv,aclint-mswi", aclint_swi_init);
> > +#else
> > +IRQCHIP_DECLARE(riscv_aclint_swi, "riscv,aclint-sswi", aclint_swi_init);
> > +#endif
>
> I'm sorry, but this really isn't an irqchip driver. This is a piece of
> arch-specific code that uses *none* of the irq subsystem abstractions
> apart from the IRQCHIP_DECLARE() macro.

Yes, I was not sure we can call it IRQCHIP hence the RFC PATCH.

Both ACLINT MSWI and SSWI are special devices providing only IPI
support so I will re-think how to fit this.

>
> If you implemented it on top of the IPI irq_domain abstraction, making
> your IPIs actual IRQs, use the proper interrupt flows and accounting,
> then it would make sense to call it an irqchip driver. But as it
> stands, it has no place in drivers/irqchip.

Okay, let me explore IPI irq_domain if it is suitable for this.

Regards,
Anup

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
