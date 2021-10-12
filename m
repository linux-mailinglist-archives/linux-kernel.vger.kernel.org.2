Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28D242AFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhJLXIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:08:47 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40032 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhJLXIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:08:46 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1maQqy-0000bk-RR; Wed, 13 Oct 2021 01:06:36 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH V2 2/2] irqchip/sifive-plic: Add thead,c9xx-plic support
Date:   Wed, 13 Oct 2021 01:06:35 +0200
Message-ID: <4404316.9H8m7z83OK@diego>
In-Reply-To: <CAAhSdy32wkwH5k3iwdUNDsXjUNX8icQwcz_h2E6UixH7ZmD5KQ@mail.gmail.com>
References: <20211012153432.2817285-1-guoren@kernel.org> <20211012153432.2817285-2-guoren@kernel.org> <CAAhSdy32wkwH5k3iwdUNDsXjUNX8icQwcz_h2E6UixH7ZmD5KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 12. Oktober 2021, 18:40:26 CEST schrieb Anup Patel:
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

Actually I'd think something more dynamic might be appropriate?

I.e. don't modify the generic plic_chip structure, but define a second
one for this type of chip and reference that one in plic_irqdomain_map
depending on the block found?

According to [0] a system can have multiple PLICs and nothing
guarantees that they'll always be the same variant on future socs
[hardware engineers are very creative]

So adding more stuff that modifies static content used by all PLICs
doesn't really improve driver quality here ;-)


Heiko


[0] https://lore.kernel.org/linux-riscv/1839bf9ef91de2358a7e8ecade361f7a@www.loen.fr/T/


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
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 




