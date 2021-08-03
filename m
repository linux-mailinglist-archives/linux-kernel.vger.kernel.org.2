Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C983DE60F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhHCFOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhHCFOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:14:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF87FC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 22:13:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p5so23854580wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 22:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgtLvuf0owNQRuqUwX+vRIu3EEpd7ijmGPvQTuH4f1U=;
        b=tYyI7iW0EczWyd8YKTmgkuDRNXjLNAlD6m4BaF6j/EylspqbgI+AGDzam5UjFol4vr
         44J6YLfJsAalzoCN61h8w2Cg4YLQ8V/kycvo+YqOT6Gs3oNNjguNUS7JMmA8/Fk9lwK1
         dKofTPHFoJFb+7L1Oh1NzAjdVFPCqnzElpNMUSqAW4lvufx/70gKe4HjW6AT/pPqSJwB
         kgiKd0QVwmGBO8wO9AVhv1P/4gUGi+prhZ9iHqVeJI9vI2RbKzDReaNDXHW4b9SZqsP2
         pGzjhAayIVpPxN6pXGvtsG7l0YahlJrwQVSg2pZVZjxNTQZ24XNS95XOJqEMRbMsqdct
         cm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgtLvuf0owNQRuqUwX+vRIu3EEpd7ijmGPvQTuH4f1U=;
        b=L1xvxkoAQlclT+TI3IJ33Rhgt+vWDBMxF7wELL6cViNKYBIQnteX5vZSkyFSMiyLgf
         yPv9BajMgomwtG9Chv2Kxhi8torxf3gjHvhpCL9oWR0q1m9qEemUFhvkgQ4cYJV0q9IX
         RmvFB2KnON8mt3H5jPGwolXHH9eMsvtpt5qVuvJ29bi4nIw6mxpMBAy2TCvYSGBKN7oh
         Kln/EWQ1n4IU1ql14ZhbQ7ou9tUZ9lIGfsp8NeEu0qrKeRg5xJ9YnBKQIYGlNYnbJqC1
         ruRcUYsxzRdD/s7vtoxKvLcpzCYY66lDTbfpoSJSZG3n/FAW7jx66J6AuRR53R+s3CMU
         VzmA==
X-Gm-Message-State: AOAM5333qSqsHRVjI3pwzdS2H4G3sAJyq+GmSyonu2FaMfxNWSSXHlhx
        hsfP++i6YPUyF6t4x3AFnNcPhkNt4Jb8JTsn7u3JPA==
X-Google-Smtp-Source: ABdhPJw91PoH825qQ811F77iCveefx3m5Hx5ungo+XqTTn+aFrtABkDDMkjMsjUo5kVRCjf1wKzOXgqmVdNG9ODY9MA=
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr21519185wro.390.1627967628528;
 Mon, 02 Aug 2021 22:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <1627953123-24248-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1627953123-24248-1-git-send-email-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 3 Aug 2021 10:43:10 +0530
Message-ID: <CAAhSdy3ExFE_bTjxiGPh157ev89GEFypMcJ0OU63TQA5CRUONw@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/sifive-plic: Fix PLIC crash on touching
 offline CPU context
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 6:42 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The current plic driver would touch offline CPU context and cause
> bus error in some chip when in CPU hotplug scenario.
>
> This patch fixes up the problem and prevents plic access offline
> CPU context in plic_init() & plic_set_affinity().
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Greentime Hu <greentime.hu@sifive.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index cf74cfa..9c9bb20 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -64,6 +64,7 @@ struct plic_priv {
>         struct cpumask lmask;
>         struct irq_domain *irqdomain;
>         void __iomem *regs;
> +       unsigned int nr_irqs;
>  };
>
>  struct plic_handler {
> @@ -150,7 +151,7 @@ static int plic_set_affinity(struct irq_data *d,
>         if (cpu >= nr_cpu_ids)
>                 return -EINVAL;
>
> -       plic_irq_toggle(&priv->lmask, d, 0);
> +       plic_irq_toggle(cpu_online_mask, d, 0);

This breaks RISC-V multi-socket platforms with multiple PLIC instances.

When we have multiple PLIC instances in a RISC-V platform, each PLIC
instance will target a different set of HARTs. The "priv->lmask" represents
the CPUs/HARTs targeted by a given PLIC instance.

I am not sure how you are testing your patches but you certainly need to
test more on QEMU. The QEMU virt machine support multi-socket so make
sure any patch which can potentially affect multi-socket support is at least
tested on QEMU virt machine multi-socket configuration.

>         plic_irq_toggle(cpumask_of(cpu), d, !irqd_irq_masked(d));
>
>         irq_data_update_effective_affinity(d, cpumask_of(cpu));
> @@ -251,15 +252,25 @@ static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
>
>  static int plic_dying_cpu(unsigned int cpu)
>  {
> +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +
>         if (plic_parent_irq)
>                 disable_percpu_irq(plic_parent_irq);
>
> +       handler->present = false;
> +

Drop these changes in plic_dying_cpu(), see comments below.

>         return 0;
>  }
>
>  static int plic_starting_cpu(unsigned int cpu)
>  {
>         struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +       irq_hw_number_t hwirq;
> +
> +       handler->present = true;

The "handler->present" flag indicates that we have PLIC context
associated with the given handler. It has nothing to do with CPU
hot-plug.

> +
> +       for (hwirq = 1; hwirq <= handler->priv->nr_irqs; hwirq++)
> +               plic_toggle(handler, hwirq, 0);
>
>         if (plic_parent_irq)
>                 enable_percpu_irq(plic_parent_irq,
> @@ -275,7 +286,6 @@ static int __init plic_init(struct device_node *node,
>                 struct device_node *parent)
>  {
>         int error = 0, nr_contexts, nr_handlers = 0, i;
> -       u32 nr_irqs;
>         struct plic_priv *priv;
>         struct plic_handler *handler;
>
> @@ -290,8 +300,8 @@ static int __init plic_init(struct device_node *node,
>         }
>
>         error = -EINVAL;
> -       of_property_read_u32(node, "riscv,ndev", &nr_irqs);
> -       if (WARN_ON(!nr_irqs))
> +       of_property_read_u32(node, "riscv,ndev", &priv->nr_irqs);
> +       if (WARN_ON(!priv->nr_irqs))
>                 goto out_iounmap;
>
>         nr_contexts = of_irq_count(node);
> @@ -299,14 +309,13 @@ static int __init plic_init(struct device_node *node,
>                 goto out_iounmap;
>
>         error = -ENOMEM;
> -       priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
> +       priv->irqdomain = irq_domain_add_linear(node, priv->nr_irqs + 1,
>                         &plic_irqdomain_ops, priv);
>         if (WARN_ON(!priv->irqdomain))
>                 goto out_iounmap;
>
>         for (i = 0; i < nr_contexts; i++) {
>                 struct of_phandle_args parent;
> -               irq_hw_number_t hwirq;
>                 int cpu, hartid;
>
>                 if (of_irq_parse_one(node, i, &parent)) {
> @@ -354,7 +363,8 @@ static int __init plic_init(struct device_node *node,
>                 }
>
>                 cpumask_set_cpu(cpu, &priv->lmask);
> -               handler->present = true;
> +               if (cpu == smp_processor_id())
> +                       handler->present = true;

Drop this change.

>                 handler->hart_base =
>                         priv->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
>                 raw_spin_lock_init(&handler->enable_lock);
> @@ -362,8 +372,6 @@ static int __init plic_init(struct device_node *node,
>                         priv->regs + ENABLE_BASE + i * ENABLE_PER_HART;
>                 handler->priv = priv;
>  done:
> -               for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> -                       plic_toggle(handler, hwirq, 0);

In plic_init(), we are bringing all interrupts of PLIC context to a known
state which is being disabled by default. We don't need to do this every
time a HART/CPU is brought-up but I am okay to move this to
plic_starting_cpu() if it helps fix issues on any RISC-V platform.

>                 nr_handlers++;
>         }
>
> --
> 2.7.4
>

Regards,
Anup
