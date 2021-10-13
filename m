Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E9142BAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbhJMIlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhJMIlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:41:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A06ED61074
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634114345;
        bh=ZNUTxDIwgSu+vOtmo4g3584XPbhlqaPhtiT514GpsXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hb2LFyxQJ3A9SSPuAtj8fUizWNkliuyk03zKrk/xcarnbI8zZFW8j57GJcen3452U
         xdJCHfmmjaggYNNqmnLBZ98QkDhTwpzO5x3jaLFhphVNbkavUVfxUy/9GvFPqrpx7W
         ux9JLWEQACcSuVMjeLcIxNZqTqZpcLRhDue0Cy/+6uLfdjQib2gIICmRs1FYbiwUSC
         e9OXBaJv1rQDiczcK1xhgVMUNQPB6RyG/Hr+DlOzi6EXv4SFSRbxQf36lOaUS3K5OA
         yl9PRt4qOqb8O7uxSjHCEp7YgPEfLNrUw9v9gg6MHu40pH/Pi68MKY1SY6LE8h+kNY
         txuDox5x6HyRg==
Received: by mail-ua1-f46.google.com with SMTP id h4so3009452uaw.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 01:39:05 -0700 (PDT)
X-Gm-Message-State: AOAM532I61XXAMXp9u/LShyAoewOESWx/hW9l2Cx1jHGqc+vLB5OCr6z
        OrKOyybCBKyUGa1K3QR7c+EfwwODo+QduqB9Mlc=
X-Google-Smtp-Source: ABdhPJzMzPjRx0tJntq697GnLyNdIiu+c7GL9onC6nRg14TohlFxhP/gu7b1LNwQtL/7EqE/SUsB+UpbjNLRSdbdWP0=
X-Received: by 2002:a05:6102:537:: with SMTP id m23mr55870vsa.43.1634114344625;
 Wed, 13 Oct 2021 01:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org> <20211013012149.2834212-2-guoren@kernel.org>
 <CAAhSdy3B9AtbeBrNoQJOBkmAcOR56s1WExGNPMXsSsF+38y8DA@mail.gmail.com>
In-Reply-To: <CAAhSdy3B9AtbeBrNoQJOBkmAcOR56s1WExGNPMXsSsF+38y8DA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Oct 2021 16:38:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSzz_41cLHH48C98FqstEK+AVMAi2xrdfMQbQn2=xEKcQ@mail.gmail.com>
Message-ID: <CAJF2gTSzz_41cLHH48C98FqstEK+AVMAi2xrdfMQbQn2=xEKcQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] irqchip/sifive-plic: Add thead,c900-plic support
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 1:04 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Oct 13, 2021 at 6:52 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > thead,c900-plic would mask IRQ with readl(claim), so it needn't
> > mask/unmask which needed in RISC-V PLIC.
> >
> > When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED path, unnecessary mask
> > operation would cause a blocking irq bug in thead,c900-plic. Because
> > when IRQ is disabled in c900, writel(hwirq, claim) would be invalid.
>
> This is a totally incorrect description.
>
> Instead of this, the commit description should say the following:
>
> 1) The irq_mask/unmask() is used by handle_fasteoi_irq() is mostly
> for ONESHOT irqs and there is no limitation in the RISC-V PLIC driver
> due to use of irq_mask/unmask() callbacks. In fact, a lot of irqchip
> drivers using handle_fasteoi_irq() also implement irq_mask/unmask().
Add irq_mask/unmask in handle_fasteoi_irq() would decrease the
performance, we also need to add this fact in the description.
>
> 2) The C9xx PLIC does not comply with the interrupt claim/completion
> process defined by the RISC-V PLIC specification because C9xx PLIC
> will mask an IRQ when it is claimed by PLIC driver (i.e. readl(claim) and
> the IRQ will be unmasked upon completion by PLIC driver (i.e. writel(claim).
> This behaviour breaks the handling of IRQS_ONESHOT by the generic
> handle_fasteoi_irq() used in the PLIC driver.
>
> 3) This patch adds an errata fix for IRQS_ONESHOT handling on
> C9xx PLIC by using irq_enable/disable() callbacks instead of
> irq_mask/unmask().
>
> In general, non-compliance of the C9xx PLIC should be treated as
> an errata so please don't project it as a feature.
>
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
> >  drivers/irqchip/irq-sifive-plic.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index cf74cfa82045..5b806d823df7 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -166,7 +166,7 @@ static void plic_irq_eoi(struct irq_data *d)
> >         writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >  }
> >
> > -static struct irq_chip plic_chip = {
> > +static struct irq_chip sifive_plic_chip = {
> >         .name           = "SiFive PLIC",
> >         .irq_mask       = plic_irq_mask,
> >         .irq_unmask     = plic_irq_unmask,
> > @@ -176,12 +176,24 @@ static struct irq_chip plic_chip = {
> >  #endif
> >  };
> >
>
> Please add a detailed comment block as described by point#2
> above.
>
> > +static struct irq_chip thead_plic_chip = {
> > +       .name           = "T-Head PLIC",
> > +       .irq_disable    = plic_irq_mask,
> > +       .irq_enable     = plic_irq_unmask,
> > +       .irq_eoi        = plic_irq_eoi,
> > +#ifdef CONFIG_SMP
> > +       .irq_set_affinity = plic_set_affinity,
> > +#endif
> > +};
> > +
> > +static struct irq_chip *def_plic_chip = &sifive_plic_chip;
> > +
> >  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >                               irq_hw_number_t hwirq)
> >  {
> >         struct plic_priv *priv = d->host_data;
> >
> > -       irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> > +       irq_domain_set_info(d, irq, hwirq, def_plic_chip, d->host_data,
> >                             handle_fasteoi_irq, NULL, NULL);
> >         irq_set_noprobe(irq);
> >         irq_set_affinity(irq, &priv->lmask);
> > @@ -390,5 +402,14 @@ static int __init plic_init(struct device_node *node,
> >         return error;
> >  }
> >
> > +static int __init thead_c900_plic_init(struct device_node *node,
> > +               struct device_node *parent)
> > +{
> > +       def_plic_chip = &thead_plic_chip;
> > +
> > +       return plic_init(node, parent);
> > +}
> > +
> >  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> >  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
> > +IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", thead_c900_plic_init);
> > --
> > 2.25.1
> >
>
> Regards,
> Anup



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
