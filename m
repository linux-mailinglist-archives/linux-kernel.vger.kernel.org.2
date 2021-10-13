Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F94942B119
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhJMAur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234265AbhJMAuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:50:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD99560F23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634086123;
        bh=Kbv/rHFna/0Axvw8OiuTxul21mQUIZgn9kqs0WcnFpw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=REIdUY56wkstG2cUg5plCACNHr7fl9slIshXF+9EU2VrzK5ptrsUr9jfrR3BMtspu
         lG1KKTllRC5jKeO4w0o19sJ214mbrdoZg9mPgSEk+Vyh7sxZHt+Z7oEt/aHqso9Jxz
         KIaLcAvAvSSdvM97epDJOyHM4miERaTY4sDAV37QokyYjf1O1Jj8H7alpOTqjpdP1i
         LwRdJ/BeeHXzqFRNB2btmd3AG6ERftjK/D3b1dfEfnjvbB+xgRfbXj7NS4+Zf6uV45
         ObbcUkWCYJ00YYiTU70mJefnwYjrBb1onmr/XTU1aMe6pqaHE6AJcRH1oh0lTJeJzo
         qlH/qr/7ud+1Q==
Received: by mail-vk1-f177.google.com with SMTP id z202so818541vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:48:43 -0700 (PDT)
X-Gm-Message-State: AOAM53358jNCUejp4V+juPyw9xsYuBirril1ZF7hqyyqpR/n+WHh5Trd
        1A4IJuuJLcbHx5ba7R2O3b6oB3eUc9CZUVIgdcI=
X-Google-Smtp-Source: ABdhPJyU0BzpFlToBC3ztDGY3guFLaVJQqyQsSaArHBjwR3YgO1KL43j8F8oD47xmnJyXo8Z7rP10Fe8sj3kOMTl27Y=
X-Received: by 2002:ab0:5a93:: with SMTP id w19mr12761590uae.58.1634086122886;
 Tue, 12 Oct 2021 17:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211012153432.2817285-1-guoren@kernel.org> <20211012153432.2817285-2-guoren@kernel.org>
 <CAAhSdy32wkwH5k3iwdUNDsXjUNX8icQwcz_h2E6UixH7ZmD5KQ@mail.gmail.com>
In-Reply-To: <CAAhSdy32wkwH5k3iwdUNDsXjUNX8icQwcz_h2E6UixH7ZmD5KQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Oct 2021 08:48:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQBnd7GhQeK1jJb_UNNUHMqN1ZNAG2bekZHPu3Lkfg+ew@mail.gmail.com>
Message-ID: <CAJF2gTQBnd7GhQeK1jJb_UNNUHMqN1ZNAG2bekZHPu3Lkfg+ew@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] irqchip/sifive-plic: Add thead,c9xx-plic support
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 12:40 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Oct 12, 2021 at 9:04 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > thead,c9xx-plic would mask IRQ with readl(claim), so it needn't
> > mask/unmask which needed in RISC-V PLIC.
> >
> > When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED path, unnecessary mask
> > operation would cause a blocking irq bug in thead,c9xx-plic. Because
> > when IRQ is disabled in c9xx, writel(hwirq, claim) would be invalid.
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
> > Changes since V2:
> >  - Add a separate compatible string "thead,c9xx-plic"
> >  - set irq_mask/unmask of "plic_chip" to NULL and point
> >    irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
> >  - Add a detailed comment block in plic_init() about the
> >    differences in Claim/Completion process of RISC-V PLIC and C9xx
> >    PLIC.
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index cf74cfa82045..3756b1c147c3 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -79,6 +79,7 @@ struct plic_handler {
> >  };
> >  static int plic_parent_irq __ro_after_init;
> >  static bool plic_cpuhp_setup_done __ro_after_init;
> > +static bool disable_mask_unmask __ro_after_init;
> >  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
> >
> >  static inline void plic_toggle(struct plic_handler *handler,
> > @@ -181,6 +182,13 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >  {
> >         struct plic_priv *priv = d->host_data;
> >
> > +       if (disable_mask_unmask) {
> > +               plic_chip.irq_mask      = NULL;
> > +               plic_chip.irq_unmask    = NULL;
> > +               plic_chip.irq_enable    = plic_irq_unmask;
> > +               plic_chip.irq_disable   = plic_irq_mask;
> > +       }
> > +
> >         irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> >                             handle_fasteoi_irq, NULL, NULL);
> >         irq_set_noprobe(irq);
> > @@ -390,5 +398,14 @@ static int __init plic_init(struct device_node *node,
> >         return error;
> >  }
> >
> > +static int __init thead_c9xx_plic_init(struct device_node *node,
> > +               struct device_node *parent)
> > +{
> > +       disable_mask_unmask = true;
>
> The plic_irqdomain_map() is called for each irq so "plic_chip"
> will be updated multiple times.
>
> You can drop the disable_mask_unmask variable and instead
> directly update "plic_chip" here.
Good advice, better than mine.

>
> > +
> > +       return plic_init(node, parent);
> > +}
> > +
> >  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> >  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
> > +IRQCHIP_DECLARE(thead_c9xx_plic, "thead,c9xx-plic", thead_c9xx_plic_init);
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
