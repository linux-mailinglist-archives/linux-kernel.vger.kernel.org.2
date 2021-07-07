Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F873BE22F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 06:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhGGExL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 00:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhGGExK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 00:53:10 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54751C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 21:50:30 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id o8so1053163ilf.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 21:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9FcRE/KuvCie0HZGq6YdR8mT5ZuuTJXP2+C+/GmUQU=;
        b=TGuqj4dYY/ZeeodMCINiTCMp/q6ElDypnwDIcWBPnDQ/zhgWts3zdxMRVLDsSoP/B1
         s5tP2GI1jwZ6FffCNEEyjn5jhDaBwihPhiaQChzyshO8cxnHWwVD04nPRnbrhLxK0+qA
         PalwsNMOwikUzeaBp7o6fIPDRCxOTozCABG+VidenILuyd2r7qv1H6Bt3E7XznrpA8bD
         9HdiGxgRPQKKJc60VYSkGo+lVKyRQ9Xm5y29RDwXoIigDJhmDISBZbpLWnLj3rPQ+xOf
         yh2QZz4gbKiwI0aihKMhFF/rniNTIB6wlVRaqePP4raeB1hpdRQvg6/O1g5TErgCa5QE
         qeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9FcRE/KuvCie0HZGq6YdR8mT5ZuuTJXP2+C+/GmUQU=;
        b=muevugWG/AStItAlkt5T8kOQrW5x3cIIUrq6PxVxQk7uR0Y0fXe3oRnXtUxhW6DG1b
         xP93Uns1Ejh1K3OeuYQ90GYG2bc+prUWtInP1N/NoeQAlDAYR0lY8tLRx0mxvY12zXdh
         Y80APWAmb0wt5i9CDqy8j0TXzYTrBUkaqi1Rv1tvJaNfPxRFo9jsuxtXkOcmB9zsIsP8
         qCpytceC3dWLgT7fhIaR0e/pMEa12JmB9xUKV2IjPsisaA28pMfJWBhcxlDCuS5o42gg
         XgZFJTiaHxvnYu8yfqUlVikTdTegGNY3kILeA/86Iv1f3LhUm5AJTPQJJH/7Y37EPjjJ
         Tc8Q==
X-Gm-Message-State: AOAM530zknbseEzjUBXe3aJ/KsCJ2pQ+Wq8ugRLeUdlIJv+XCWOUpf03
        WByrbqpZn/UcNFT165I4JDwfBC2hEc0o7kyUBRU=
X-Google-Smtp-Source: ABdhPJwVuu0jt8EClJ+zpkipBC3XYXuvAL6K5EIFjswB52qwXC7OG5SR1IfVBaN4GfWcVyL6K2lZbfK1wTXaQ0pb6PA=
X-Received: by 2002:a05:6e02:1d12:: with SMTP id i18mr17150970ila.97.1625633429770;
 Tue, 06 Jul 2021 21:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210706030904.1411775-1-chenhuacai@loongson.cn>
 <20210706030904.1411775-4-chenhuacai@loongson.cn> <877di38u5c.wl-maz@kernel.org>
In-Reply-To: <877di38u5c.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 7 Jul 2021 12:50:17 +0800
Message-ID: <CAAhV-H6Fr3hp9kp778SbY7gqRGRntYG=QfT-XJ8zD1c0KJUFgA@mail.gmail.com>
Subject: Re: [PATCH 3/9] irqchip/loongson-pch-pic: Add ACPI init support
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

On Tue, Jul 6, 2021 at 9:10 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 06 Jul 2021 04:08:58 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > We are preparing to add new Loongson (based on LoongArch, not MIPS)
> > support. LoongArch use ACPI other than DT as its boot protocol, so
> > add ACPI init support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/irq-loongson-pch-pic.c | 120 ++++++++++++++++++++++++-
> >  1 file changed, 119 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
> > index a4eb8a2181c7..62382611995b 100644
> > --- a/drivers/irqchip/irq-loongson-pch-pic.c
> > +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> > @@ -1,6 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
> > + *                   Jianmin Lv <lvjianmin@loongson.cn>
> > + *                   Huacai Chen <chenhuacai@loongson.cn>
>
> Please drop this change. I'm in a position where I can verify who owns
> the copyright to this code, and I seriously doubt that 100 lines of
> boilerplate probing code give you any right over it.
OK, thanks.

>
> >   *  Loongson PCH PIC support
> >   */
> >
> > @@ -15,6 +17,7 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/syscore_ops.h>
> >
> >  /* Registers */
> >  #define PCH_PIC_MASK         0x20
> > @@ -32,14 +35,23 @@
> >  #define PIC_COUNT            (PIC_COUNT_PER_REG * PIC_REG_COUNT)
> >  #define PIC_REG_IDX(irq_id)  ((irq_id) / PIC_COUNT_PER_REG)
> >  #define PIC_REG_BIT(irq_id)  ((irq_id) % PIC_COUNT_PER_REG)
> > +#define PCH_PIC_SIZE         0x400
> > +
> > +static int nr_pch_pics;
> >
> >  struct pch_pic {
> >       void __iomem            *base;
> >       struct irq_domain       *pic_domain;
> > +     struct fwnode_handle    *domain_handle;
> >       u32                     ht_vec_base;
> >       raw_spinlock_t          pic_lock;
> > +     u32                     saved_vec_en[PIC_REG_COUNT];
> > +     u32                     saved_vec_pol[PIC_REG_COUNT];
> > +     u32                     saved_vec_edge[PIC_REG_COUNT];
> >  };
> >
> > +struct pch_pic *pch_pic_priv[4];
> > +
> >  static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
> >  {
> >       u32 reg;
> > @@ -137,6 +149,7 @@ static struct irq_chip pch_pic_irq_chip = {
> >       .irq_ack                = pch_pic_ack_irq,
> >       .irq_set_affinity       = irq_chip_set_affinity_parent,
> >       .irq_set_type           = pch_pic_set_type,
> > +     .flags                  = IRQCHIP_SKIP_SET_WAKE,
> >  };
> >
> >  static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
> > @@ -180,7 +193,7 @@ static void pch_pic_reset(struct pch_pic *priv)
> >       int i;
> >
> >       for (i = 0; i < PIC_COUNT; i++) {
> > -             /* Write vectored ID */
> > +             /* Write vector ID */
> >               writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
> >               /* Hardcode route to HT0 Lo */
> >               writeb(1, priv->base + PCH_INT_ROUTE(i));
> > @@ -198,6 +211,48 @@ static void pch_pic_reset(struct pch_pic *priv)
> >       }
> >  }
> >
> > +static int pch_pic_suspend(void)
> > +{
> > +     int i, j;
> > +
> > +     for (i = 0; i < nr_pch_pics; i++) {
> > +             for (j = 0; j < PIC_REG_COUNT; j++) {
> > +                     pch_pic_priv[i]->saved_vec_pol[j] =
> > +                             readl(pch_pic_priv[i]->base + PCH_PIC_POL + 4 * j);
> > +                     pch_pic_priv[i]->saved_vec_edge[j] =
> > +                             readl(pch_pic_priv[i]->base + PCH_PIC_EDGE + 4 * j);
> > +                     pch_pic_priv[i]->saved_vec_en[j] =
> > +                             readl(pch_pic_priv[i]->base + PCH_PIC_MASK + 4 * j);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void pch_pic_resume(void)
> > +{
> > +     int i, j;
> > +
> > +     for (i = 0; i < nr_pch_pics; i++) {
> > +             pch_pic_reset(pch_pic_priv[i]);
> > +             for (j = 0; j < PIC_REG_COUNT; j++) {
> > +                     writel(pch_pic_priv[i]->saved_vec_pol[j],
> > +                                     pch_pic_priv[i]->base + PCH_PIC_POL + 4 * j);
> > +                     writel(pch_pic_priv[i]->saved_vec_edge[j],
> > +                                     pch_pic_priv[i]->base + PCH_PIC_EDGE + 4 * j);
> > +                     writel(pch_pic_priv[i]->saved_vec_en[j],
> > +                                     pch_pic_priv[i]->base + PCH_PIC_MASK + 4 * j);
> > +             }
> > +     }
> > +}
> > +
> > +static struct syscore_ops pch_pic_syscore_ops = {
> > +     .suspend =  pch_pic_suspend,
> > +     .resume =  pch_pic_resume,
> > +};
>
> None of this has anything to do with what is described in the commit
> message. Please move this into its own patch.
OK, this will be split out.

>
> > +
> > +#ifdef CONFIG_OF
> > +
> >  static int pch_pic_of_init(struct device_node *node,
> >                               struct device_node *parent)
> >  {
> > @@ -242,6 +297,9 @@ static int pch_pic_of_init(struct device_node *node,
> >       }
> >
> >       pch_pic_reset(priv);
> > +     pch_pic_priv[0] = priv;
> > +
> > +     register_syscore_ops(&pch_pic_syscore_ops);
> >
> >       return 0;
> >
> > @@ -254,3 +312,63 @@ static int pch_pic_of_init(struct device_node *node,
> >  }
> >
> >  IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
> > +
> > +#endif
> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +struct fwnode_handle *pch_pic_acpi_init(struct fwnode_handle *parent,
> > +                                     struct acpi_madt_bio_pic *acpi_pchpic)
> > +{
> > +     int count;
> > +     struct pch_pic *priv;
> > +     struct irq_domain *parent_domain;
> > +
> > +     priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return NULL;
> > +
> > +     raw_spin_lock_init(&priv->pic_lock);
> > +     priv->base = ioremap(acpi_pchpic->address, acpi_pchpic->size);
> > +     if (!priv->base)
> > +             goto free_priv;
> > +
> > +     priv->domain_handle = irq_domain_alloc_fwnode(priv->base);
> > +     if (!priv->domain_handle) {
> > +             pr_err("Unable to allocate domain handle\n");
> > +             goto iounmap_base;
> > +     }
> > +
> > +     priv->ht_vec_base = acpi_pchpic->gsi_base;
> > +     count = ((readq(priv->base) >> 48) & 0xff) + 1;
> > +     parent_domain = irq_find_matching_fwnode(parent, DOMAIN_BUS_ANY);
> > +     if (!parent_domain) {
> > +             pr_err("Failed to find the parent domain\n");
> > +             goto iounmap_base;
> > +     }
> > +
> > +     priv->pic_domain = irq_domain_create_hierarchy(parent_domain, 0,
> > +                                             count, priv->domain_handle,
> > +                                             &pch_pic_domain_ops, priv);
> > +
> > +     if (!priv->pic_domain) {
> > +             pr_err("Failed to create IRQ domain\n");
> > +             goto iounmap_base;
> > +     }
> > +
> > +     pch_pic_reset(priv);
> > +     pch_pic_priv[nr_pch_pics++] = priv;
> > +
> > +     register_syscore_ops(&pch_pic_syscore_ops);
> > +
> > +     return priv->domain_handle;
> > +
> > +iounmap_base:
> > +     iounmap(priv->base);
> > +free_priv:
> > +     kfree(priv);
> > +
> > +     return NULL;
> > +}
> > +
> > +#endif
>
> A lot of this code is common with its OF counterpart. How about making
> this logic common?
OK, let me think about.

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
