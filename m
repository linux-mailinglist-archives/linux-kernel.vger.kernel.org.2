Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA7C3BE234
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 06:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhGGEyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 00:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhGGEyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 00:54:03 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC67C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 21:51:24 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id g3so1064517ilq.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 21:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGC4jbGQXy2pIkoJ6o2a8RwCC/cOqvmMyK9vB+dPbdE=;
        b=KmHOunTmO42hfO1cEQctEt5SPVReK64wWWoMkhEfM3DX4P5CChYk1cxwayfNdcaXlZ
         p41MBPwVYbAGJnTh0PWaxvfgVtJYar5oMha8Wbjmw5z/G9dL8ikHDCcaaYTTx76wuz7q
         tuLJOuk7bl1FA/cC7iba3pHzjJ4O7dlnPqkszWidM7vEXU/2rhgkVB4jRWreplGBw/Lr
         tSNqF994fagll6wMHcnev911PULItARYrgecpB1q2gvjfwHwkL5dqT6Lz/fkk7Xo6uF0
         aaZJFQipBWfQTwuNGankq42GL4XYIEyAW67eHHVQ39zT3EiDWuhFyBVfIAj5cXaeiOrI
         xowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGC4jbGQXy2pIkoJ6o2a8RwCC/cOqvmMyK9vB+dPbdE=;
        b=DCMBnGAIBXHQdQP/899M0LER80FdJeFuJTvluojymTIh/6eJzI4l60I4q39X8RhwXR
         KYzFjl45Yc5SSi1sf1mz08x1CDuRvP8HHBv2I4y3exUGGnq9naU3hRFzYzUH6hiTJbgI
         23OUeuAKz2XPOrZjKRBNgb8w2JIxvgMEu/w1hE7P4QhXDdgGKCKrne73T7KpTfKc3Pqr
         OWb34lBlA6rdGVaXoSc8I5Bq2SkXsFaNc/i6JuS3Tje1yZOfa/RVtCjibkawnZ3aYFIX
         vdf5nTOI5bAaR/PSYDhq1BgF1sI4q2q5YSEPOR96Y/3WTM7vsW3om7/kqScNGdgizIxz
         TGrw==
X-Gm-Message-State: AOAM533ZXEhWxomowdRxEs0tzxwpv4aRlMTSSa2oTPyDb9OZ5L512+lR
        cN8cxE59z+1t3EuwjuXS6jIeOmCGD0MU+VcgxxU=
X-Google-Smtp-Source: ABdhPJyD3nAL9ZEmSPEJB3wGwc0+cmHG+rbfnw8KFePE6elgh/yzsrKVLMqwiPVoUDV4E7dSYDdlWT1SZPau63s2n/A=
X-Received: by 2002:a92:6509:: with SMTP id z9mr17132353ilb.184.1625633483662;
 Tue, 06 Jul 2021 21:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210706030904.1411775-1-chenhuacai@loongson.cn>
 <20210706030904.1411775-5-chenhuacai@loongson.cn> <875yxn8u2o.wl-maz@kernel.org>
In-Reply-To: <875yxn8u2o.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 7 Jul 2021 12:51:12 +0800
Message-ID: <CAAhV-H6smHJQ5Q_txRp1XDvfBhwkxqRDUK0PTJ7nqMM+wcU=2Q@mail.gmail.com>
Subject: Re: [PATCH 4/9] irqchip/loongson-pch-msi: Add ACPI init support
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

On Tue, Jul 6, 2021 at 9:12 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 06 Jul 2021 04:08:59 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > We are preparing to add new Loongson (based on LoongArch, not MIPS)
> > support. LoongArch use ACPI other than DT as its boot protocol, so
> > add ACPI init support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/irq-loongson-pch-msi.c | 69 ++++++++++++++++++++++++--
> >  1 file changed, 64 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
> > index 32562b7e681b..adfa30046f0a 100644
> > --- a/drivers/irqchip/irq-loongson-pch-msi.c
> > +++ b/drivers/irqchip/irq-loongson-pch-msi.c
> > @@ -1,6 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
> > + *                   Jianmin Lv <lvjianmin@loongson.cn>
> > + *                   Huacai Chen <chenhuacai@loongson.cn>
>
> Same thing as the previous patch: drop it.
>
> >   *  Loongson PCH MSI support
> >   */
> >
> > @@ -21,6 +23,7 @@ struct pch_msi_data {
> >       u32             irq_first;      /* The vector number that MSIs starts */
> >       u32             num_irqs;       /* The number of vectors for MSIs */
> >       unsigned long   *msi_map;
> > +     struct fwnode_handle *domain_handle;
> >  };
> >
> >  static void pch_msi_mask_msi_irq(struct irq_data *d)
> > @@ -159,7 +162,12 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
> >  {
> >       struct irq_domain *middle_domain, *msi_domain;
> >
> > -     middle_domain = irq_domain_create_linear(of_node_to_fwnode(node),
> > +     if (node)
> > +             priv->domain_handle = of_node_to_fwnode(node);
> > +     else
> > +             priv->domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)priv);
> > +
> > +     middle_domain = irq_domain_create_linear(priv->domain_handle,
> >                                               priv->num_irqs,
> >                                               &pch_msi_middle_domain_ops,
> >                                               priv);
> > @@ -171,7 +179,7 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
> >       middle_domain->parent = parent;
> >       irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
> >
> > -     msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
> > +     msi_domain = pci_msi_create_irq_domain(priv->domain_handle,
> >                                              &pch_msi_domain_info,
> >                                              middle_domain);
> >       if (!msi_domain) {
> > @@ -183,8 +191,9 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
> >       return 0;
> >  }
> >
> > -static int pch_msi_init(struct device_node *node,
> > -                         struct device_node *parent)
> > +#ifdef CONFIG_OF
> > +
> > +int pch_msi_of_init(struct device_node *node, struct device_node *parent)
> >  {
> >       struct pch_msi_data *priv;
> >       struct irq_domain *parent_domain;
> > @@ -247,4 +256,54 @@ static int pch_msi_init(struct device_node *node,
> >       return ret;
> >  }
> >
> > -IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
> > +IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
> > +
> > +#endif
> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +struct fwnode_handle *pch_msi_acpi_init(struct fwnode_handle *parent,
> > +                                     struct acpi_madt_msi_pic *acpi_pchmsi)
> > +{
> > +     int ret;
> > +     struct pch_msi_data *priv;
> > +     struct irq_domain *parent_domain;
> > +
> > +     priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return NULL;
> > +
> > +     mutex_init(&priv->msi_map_lock);
> > +
> > +     priv->doorbell = acpi_pchmsi->msg_address;
> > +     priv->irq_first = acpi_pchmsi->start;
> > +     priv->num_irqs = acpi_pchmsi->count;
> > +
> > +     parent_domain = irq_find_matching_fwnode(parent, DOMAIN_BUS_ANY);
> > +     if (!parent_domain) {
> > +             pr_err("Failed to find the parent domain\n");
> > +             return NULL;
> > +     }
> > +
> > +     priv->msi_map = bitmap_zalloc(priv->num_irqs, GFP_KERNEL);
> > +     if (!priv->msi_map)
> > +             goto err_priv;
> > +
> > +     pr_debug("Registering %d MSIs, starting at %d\n",
> > +              priv->num_irqs, priv->irq_first);
> > +
> > +     ret = pch_msi_init_domains(priv, NULL, parent_domain);
> > +     if (ret)
> > +             goto err_map;
> > +
> > +     return priv->domain_handle;
> > +
> > +err_map:
> > +     kfree(priv->msi_map);
> > +err_priv:
> > +     kfree(priv);
> > +
> > +     return NULL;
> > +}
> > +
> > +#endif
>
> Same thing. You are pointlessly duplicating the logic.
OK, I'll rework this.

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
