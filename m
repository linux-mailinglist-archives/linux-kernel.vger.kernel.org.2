Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5621D3E5120
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhHJCoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhHJCoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:44:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD6C261058
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628563422;
        bh=+u2V2+K0bj2ltsUVUXzuEDQxgXWWe8UW8DnbggYPlPE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vF5uPtgSmpsYEI3O9OJ2rNH9LIdrj+/sd/4qcFw7fJPalwrGQf06UBT53RHhl5HWV
         wAod5Tlo7oTM6dZLXlXsqUEG51I44HrSunmUeGeJTjZdc/VY5ZPrGPfVJgeGQcwvbz
         Rd3oJViiQYtLj6OJqkOAuoUGVm0bzMERfXZwqrIi2SG8JCPWufts2LtOVB2WCIr/Xs
         SXCWIjgXTymDOiRzwkac5SwVMAtAWX5htlgiDzuEb5ZDZwow6ZHsnFhMUqkH9AIQto
         azNoaqKEWJg3Rq/RrXYdj2b3cNaAwRsHu4vQL8P2i3cMf44IOcCS5iFSBAFjW5oAj2
         iXLhmbIj2MAqg==
Received: by mail-lf1-f50.google.com with SMTP id g30so6076696lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 19:43:42 -0700 (PDT)
X-Gm-Message-State: AOAM532mIfKuRTRaLOFEwgsO5/t5fA4VkjiV0JTmjaL2Wjt4hfynyVFB
        PkxlQmyWQ1KN4smSD2llCduc1IYPkL2moHTfiiI=
X-Google-Smtp-Source: ABdhPJxWNX4izk44i96wfeOUmqKIwvnCOhHcFfuVsvlvzwGSKgTdi7tE3j/qd91bNPQQpXh+dl1J2EyCxPDUvzAkqU0=
X-Received: by 2002:a05:6512:ba9:: with SMTP id b41mr20914908lfv.231.1628563421204;
 Mon, 09 Aug 2021 19:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <1627953123-24248-1-git-send-email-guoren@kernel.org> <CAAhSdy3ExFE_bTjxiGPh157ev89GEFypMcJ0OU63TQA5CRUONw@mail.gmail.com>
In-Reply-To: <CAAhSdy3ExFE_bTjxiGPh157ev89GEFypMcJ0OU63TQA5CRUONw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 10 Aug 2021 10:43:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQSha1vg4ta4fdbwdWhU8OJkKx+Qf__8vcmjGLQXSpx4g@mail.gmail.com>
Message-ID: <CAJF2gTQSha1vg4ta4fdbwdWhU8OJkKx+Qf__8vcmjGLQXSpx4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/sifive-plic: Fix PLIC crash on touching
 offline CPU context
To:     Anup Patel <anup@brainfault.org>
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

 Hi Anup,

Sorry for the late reply.

On Tue, Aug 3, 2021 at 1:13 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Aug 3, 2021 at 6:42 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The current plic driver would touch offline CPU context and cause
> > bus error in some chip when in CPU hotplug scenario.
> >
> > This patch fixes up the problem and prevents plic access offline
> > CPU context in plic_init() & plic_set_affinity().
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > Cc: Greentime Hu <greentime.hu@sifive.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index cf74cfa..9c9bb20 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -64,6 +64,7 @@ struct plic_priv {
> >         struct cpumask lmask;
> >         struct irq_domain *irqdomain;
> >         void __iomem *regs;
> > +       unsigned int nr_irqs;
> >  };
> >
> >  struct plic_handler {
> > @@ -150,7 +151,7 @@ static int plic_set_affinity(struct irq_data *d,
> >         if (cpu >= nr_cpu_ids)
> >                 return -EINVAL;
> >
> > -       plic_irq_toggle(&priv->lmask, d, 0);
> > +       plic_irq_toggle(cpu_online_mask, d, 0);
>
> This breaks RISC-V multi-socket platforms with multiple PLIC instances.
Yes, I haven't considered the multi-sockets scenario.

>
> When we have multiple PLIC instances in a RISC-V platform, each PLIC
> instance will target a different set of HARTs. The "priv->lmask" represents
> the CPUs/HARTs targeted by a given PLIC instance.
Okay, I would correct it with:
 -       plic_irq_toggle(&priv->lmask, d, 0);
+       cpumask_and(&amask, &priv->lmask, cpu_online_mask);
+       plic_irq_toggle(&amask, d, 0);

>
> I am not sure how you are testing your patches but you certainly need to
> test more on QEMU. The QEMU virt machine support multi-socket so make
> sure any patch which can potentially affect multi-socket support is at least
> tested on QEMU virt machine multi-socket configuration.
The patch has been tested with our hardware platforms and qemu 4.1.
But in that version of qemu, riscv didn't support multi-socket.

I would update my qemu environment to follow your steps :)

>
> >         plic_irq_toggle(cpumask_of(cpu), d, !irqd_irq_masked(d));
> >
> >         irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > @@ -251,15 +252,25 @@ static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
> >
> >  static int plic_dying_cpu(unsigned int cpu)
> >  {
> > +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > +
> >         if (plic_parent_irq)
> >                 disable_percpu_irq(plic_parent_irq);
> >
> > +       handler->present = false;
> > +
>
> Drop these changes in plic_dying_cpu(), see comments below.
>
> >         return 0;
> >  }
> >
> >  static int plic_starting_cpu(unsigned int cpu)
> >  {
> >         struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > +       irq_hw_number_t hwirq;
> > +
> > +       handler->present = true;
>
> The "handler->present" flag indicates that we have PLIC context
> associated with the given handler. It has nothing to do with CPU
> hot-plug.
>
> > +
> > +       for (hwirq = 1; hwirq <= handler->priv->nr_irqs; hwirq++)
> > +               plic_toggle(handler, hwirq, 0);
> >
> >         if (plic_parent_irq)
> >                 enable_percpu_irq(plic_parent_irq,
> > @@ -275,7 +286,6 @@ static int __init plic_init(struct device_node *node,
> >                 struct device_node *parent)
> >  {
> >         int error = 0, nr_contexts, nr_handlers = 0, i;
> > -       u32 nr_irqs;
> >         struct plic_priv *priv;
> >         struct plic_handler *handler;
> >
> > @@ -290,8 +300,8 @@ static int __init plic_init(struct device_node *node,
> >         }
> >
> >         error = -EINVAL;
> > -       of_property_read_u32(node, "riscv,ndev", &nr_irqs);
> > -       if (WARN_ON(!nr_irqs))
> > +       of_property_read_u32(node, "riscv,ndev", &priv->nr_irqs);
> > +       if (WARN_ON(!priv->nr_irqs))
> >                 goto out_iounmap;
> >
> >         nr_contexts = of_irq_count(node);
> > @@ -299,14 +309,13 @@ static int __init plic_init(struct device_node *node,
> >                 goto out_iounmap;
> >
> >         error = -ENOMEM;
> > -       priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
> > +       priv->irqdomain = irq_domain_add_linear(node, priv->nr_irqs + 1,
> >                         &plic_irqdomain_ops, priv);
> >         if (WARN_ON(!priv->irqdomain))
> >                 goto out_iounmap;
> >
> >         for (i = 0; i < nr_contexts; i++) {
> >                 struct of_phandle_args parent;
> > -               irq_hw_number_t hwirq;
> >                 int cpu, hartid;
> >
> >                 if (of_irq_parse_one(node, i, &parent)) {
> > @@ -354,7 +363,8 @@ static int __init plic_init(struct device_node *node,
> >                 }
> >
> >                 cpumask_set_cpu(cpu, &priv->lmask);
> > -               handler->present = true;
> > +               if (cpu == smp_processor_id())
> > +                       handler->present = true;
>
> Drop this change.
>
> >                 handler->hart_base =
> >                         priv->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
> >                 raw_spin_lock_init(&handler->enable_lock);
> > @@ -362,8 +372,6 @@ static int __init plic_init(struct device_node *node,
> >                         priv->regs + ENABLE_BASE + i * ENABLE_PER_HART;
> >                 handler->priv = priv;
> >  done:
> > -               for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> > -                       plic_toggle(handler, hwirq, 0);
>
> In plic_init(), we are bringing all interrupts of PLIC context to a known
> state which is being disabled by default. We don't need to do this every
> time a HART/CPU is brought-up but I am okay to move this to
> plic_starting_cpu() if it helps fix issues on any RISC-V platform.
>
> >                 nr_handlers++;
> >         }
> >
> > --
> > 2.7.4
> >
>
> Regards,
> Anup



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
