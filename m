Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2813C3C1DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 05:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhGIDDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 23:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhGIDDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 23:03:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09081C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 20:01:11 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id k6so8764115ilo.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JB29uDKXAR3TDkN7CTX1FDUHolpKXNTz5HDQsIY///s=;
        b=didvMpCkFWJoXetV1ihrET4YVS3SiUkyc95HxcXVHoRhNOGlF3KDPKDM2zrK9FlLJc
         dTFH/ugMpblbRXQjDHZWKnedsEQlvUiDgpjY+dPzGt9fdocqkRNbtuZ9RTAslt2aJLlw
         Cz5jir//vUtvBDy8rnp+cVFFsp/YDR2Uti4TFb2x89OFCPKyq11T2kPetf0HT1m+0u4+
         kk7Eb3c1Tz+bb/J8aEUbo8/wwCV8OKugAbP6WrPvFFhtD2MICC9br37UsFaBcP7luhrp
         MRKJT0depoQ3MnqGj6/vSLGU04mXSVgAWFlUPrILn4p5S4HiZW0/6/6D9S7FlpTKBQAB
         tPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JB29uDKXAR3TDkN7CTX1FDUHolpKXNTz5HDQsIY///s=;
        b=ZZA5s81R+gK4a+P+IuZGEQr9dGzfue9t84NSiEJLxppT+Pt7N2vKzyDWv582Xmml9W
         JtB/poQFd7uCGIdd/TWpBnBzdqIsbzESpKB6neCLvifxt0LFLMTkY6GqEkl0exZOAxVK
         EvxwFhb4f1jUp3Ny/5yyLKEloguX7NGMR2iAlwpoh7LtsszNkgddxquHG+l02I+ranAT
         +WwhIdh1SYknoa1ahJqHYMINgEmPImudp+yq+DsbFr8OHWtqYHABWhm+jrY1R+I9UDXv
         RQtt0FmGb/0snnNhLdKeTkZREbn48iBGRlkTZUqlkxailSWfKfJS8gTKeMGn0edy2hHw
         kiyg==
X-Gm-Message-State: AOAM533j42ES3Mi7uUeDH+rFau/tDK6epozQ9lwFFA4F0MQp36lJsdCq
        qH/UWHjahMnI9m9wIOAVU4tTYHvYN6JtPXhya4k=
X-Google-Smtp-Source: ABdhPJw//M6vG5252bHiNdutPuaL2MMmqvbflnFUn/HnG9rCsqnJ1kcTnZ4HNehiXjRYjR0w0+IDZLsLXyqfke/wOqU=
X-Received: by 2002:a92:6509:: with SMTP id z9mr24941780ilb.184.1625799670336;
 Thu, 08 Jul 2021 20:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210706030904.1411775-1-chenhuacai@loongson.cn>
 <20210706030904.1411775-3-chenhuacai@loongson.cn> <878s2j8udi.wl-maz@kernel.org>
In-Reply-To: <878s2j8udi.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 9 Jul 2021 11:00:58 +0800
Message-ID: <CAAhV-H51iX1DC54wczkwwambtfWutqg-hfoZ-A7DSxTonmruHA@mail.gmail.com>
Subject: Re: [PATCH 2/9] irqchip/loongson-pch-pic: Improve edge triggered
 interrupt support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Chen Zhu <zhuchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Tue, Jul 6, 2021 at 9:06 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 06 Jul 2021 04:08:57 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Edge-triggered mode and level-triggered mode need different handlers,
> > and edge-triggered mode need a specific ack operation. So improve it.
> >
>
> Is this a fix? How does it work currently?
Yes, some devices (e.g., RTC) is edge-triggered, they need
handle_edge_irq(). Currently we don't use RTC interrupt in the
upstream kernel on Loongson platform, so it "works".

>
>
> > Signed-off-by: Chen Zhu <zhuchen@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/irq-loongson-pch-pic.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
> > index f790ca6d78aa..a4eb8a2181c7 100644
> > --- a/drivers/irqchip/irq-loongson-pch-pic.c
> > +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> > @@ -92,18 +92,22 @@ static int pch_pic_set_type(struct irq_data *d, unsigned int type)
> >       case IRQ_TYPE_EDGE_RISING:
> >               pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
> >               pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
> > +             irq_set_handler_locked(d, handle_edge_irq);
> >               break;
> >       case IRQ_TYPE_EDGE_FALLING:
> >               pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
> >               pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
> > +             irq_set_handler_locked(d, handle_edge_irq);
> >               break;
> >       case IRQ_TYPE_LEVEL_HIGH:
> >               pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
> >               pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
> > +             irq_set_handler_locked(d, handle_level_irq);
> >               break;
> >       case IRQ_TYPE_LEVEL_LOW:
> >               pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
> >               pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
> > +             irq_set_handler_locked(d, handle_level_irq);
>
> You are changing the flow for the whole hierarchy. Are all the
> irqchips in the stack supporting this?
Yes, both PCH-PIC and its parent (HTVEC) support both edge and level mode.

Huacai
>
> >               break;
> >       default:
> >               ret = -EINVAL;
> > @@ -113,11 +117,24 @@ static int pch_pic_set_type(struct irq_data *d, unsigned int type)
> >       return ret;
> >  }
> >
> > +static void pch_pic_ack_irq(struct irq_data *d)
> > +{
> > +     unsigned int reg;
> > +     struct pch_pic *priv = irq_data_get_irq_chip_data(d);
> > +
> > +     reg = readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(d->hwirq) * 4);
> > +     if (reg & BIT(PIC_REG_BIT(d->hwirq))) {
> > +             writel(BIT(PIC_REG_BIT(d->hwirq)),
> > +                     priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
> > +     }
> > +     irq_chip_ack_parent(d);
> > +}
> > +
> >  static struct irq_chip pch_pic_irq_chip = {
> >       .name                   = "PCH PIC",
> >       .irq_mask               = pch_pic_mask_irq,
> >       .irq_unmask             = pch_pic_unmask_irq,
> > -     .irq_ack                = irq_chip_ack_parent,
> > +     .irq_ack                = pch_pic_ack_irq,
> >       .irq_set_affinity       = irq_chip_set_affinity_parent,
> >       .irq_set_type           = pch_pic_set_type,
> >  };
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
