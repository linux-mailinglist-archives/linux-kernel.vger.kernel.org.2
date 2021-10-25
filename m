Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0795A43974F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhJYNQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:16:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231960AbhJYNQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:16:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51E0F6103B;
        Mon, 25 Oct 2021 13:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635167671;
        bh=GavwiAlakBac6bzghfPLRz5VcvYh7Vc9Z0asSU+b89s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EtKYCYDDNGtbiXq6EnTrDqPg/TA65jXyZo/P6q37ayo7S9EH7QDVpKe1Qdv0LV/ql
         cZBYI++b/QEq88ggDtRuC6r4qib0LlkRI3ooNzq50iF2X6dVUc9wKo/A0JNbTL7+ll
         0naECz41hi6SUUPLmUl86T2wZANFCYnn13sOTfycrNd6odnDNSn0rexYU1Z6J4xuGz
         rCEBCUzy0rViCtXu7L3RWokUFc5rTeMWW/KVtwxH11oi2xIJ21mlDN7QB8Y/blqVMQ
         VOleFpkIUhiTZOVMT8Klni7RK2tgvqrCNl5/ykLbCG8mpRPYR5Py+mHujzRh82GEZ5
         r+BSS7Re+PTHg==
Received: by mail-ua1-f50.google.com with SMTP id f24so2842253uav.12;
        Mon, 25 Oct 2021 06:14:31 -0700 (PDT)
X-Gm-Message-State: AOAM530mK7q35WjrAUSc+qn/6Z2yRNCcaO/DTccVrXoQsvD88mncF+jD
        FC+HhWOGHnQwbkHxoB4nlZePi8Tk3WX4y+5icuU=
X-Google-Smtp-Source: ABdhPJyWzs4e0eyzid4oKwu8tHCn+QBDVzHmrAVyqE/4xHGSYCccdYV2M3eNoH0rTILxKQI0JdUrCpKqi3UWGb5lF8Q=
X-Received: by 2002:a05:6102:6c1:: with SMTP id m1mr15014547vsg.28.1635167670442;
 Mon, 25 Oct 2021 06:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211025091219.3665576-1-guoren@kernel.org> <87czntbdgk.wl-maz@kernel.org>
In-Reply-To: <87czntbdgk.wl-maz@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 25 Oct 2021 21:14:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRvFGoyy44i3oRiAYkGnfts4hc-aB74RLHgsz8+AJxb=w@mail.gmail.com>
Message-ID: <CAJF2gTRvFGoyy44i3oRiAYkGnfts4hc-aB74RLHgsz8+AJxb=w@mail.gmail.com>
Subject: Re: [PATCH] irqchip/irq-csky-mpintc: Fixup mask/unmask un-implementation
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 6:34 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 25 Oct 2021 10:12:19 +0100,
> guoren@kernel.org wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The mask/unmask must be implemented, and enable/disable supplement
> > them if the HW requires something different at startup time. When
> > irq source is disabled by mask, mpintc could complete irq normally.
> >
> > So just replace the with mask/unmask function.
> >
> > Tested-by: Guo Ren <guoren@linux.alibaba.com>
>
> This only makes sense if tested by a third party. It is assumed that
> the author of a patch has tested it.
Thx for pointing it out.

>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
>
> This hasn't been my email address for over two years now. I'm sure my
> ex manager is happy to hear from you, but I doubt he'll bother replying.
I'll fix up your email in the next patch, thx for still reviewing.

>
> > ---
> >  drivers/irqchip/irq-csky-mpintc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
> > index a1534edef7fa..f169600dbde6 100644
> > --- a/drivers/irqchip/irq-csky-mpintc.c
> > +++ b/drivers/irqchip/irq-csky-mpintc.c
> > @@ -164,8 +164,8 @@ static int csky_irq_set_affinity(struct irq_data *d,
> >  static struct irq_chip csky_irq_chip = {
> >       .name           = "C-SKY SMP Intc",
> >       .irq_eoi        = csky_mpintc_eoi,
> > -     .irq_enable     = csky_mpintc_enable,
> > -     .irq_disable    = csky_mpintc_disable,
> > +     .irq_unmask     = csky_mpintc_enable,
> > +     .irq_mask       = csky_mpintc_disable,
> >       .irq_set_type   = csky_mpintc_set_type,
> >  #ifdef CONFIG_SMP
> >       .irq_set_affinity = csky_irq_set_affinity,
>
> Please rename the functions to match the fields they are assigned to.
okay

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
