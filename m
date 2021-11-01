Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2344121C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 03:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhKACXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 22:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhKACXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 22:23:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67A7161077
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 02:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635733233;
        bh=IafejwO8g0dsJcdD0EGcB6iICuhfeqWu6PXS1URW8eA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fMd3ZfXtabZUeHFQplrpeiqOicoOh9ZVCi/8eenk5EEx/VpokftF2WvYZ90Lhi8sp
         BZvlG+Rd2dYSBpY8DmyPOqSE1BAOHRj8FFwNoZQVewKIgu8e4OfscNn9u/EoX16ouj
         c5YogGHGBhVwi92Y5dWx5TqfK1MqwOtBezKDCVViW4xcYql31uKVteyHaUYRKLDRx0
         ttGxCAKNT4f/IWbQdMqyTsWzj+/pxOyyg9HtxhFs4Gx64utst1bnKgk0g1U8KkGWY1
         ZbVepXHBTd5nUjHAzEKCBtoU3CzjRpkPrWWxQxX6yz1mEWxirhxKNsaxN1qPWh9CSh
         6BGDTEDIeDIEw==
Received: by mail-ua1-f49.google.com with SMTP id v3so29209037uam.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 19:20:33 -0700 (PDT)
X-Gm-Message-State: AOAM533NWI3PTD5EXxMRxvHfgXeqmtPwT6/pJu4iLgnvRPW6IcWs2wLK
        BYbK35397oXscat1n713ZUMp+2eBOgnZ13Bqol4=
X-Google-Smtp-Source: ABdhPJw8d5Byej8xH1/8N2aLyuBdS2vuVUMUDwb2mMOTbLN4DdP83kv1veF/0Zgp+KutXfqR/v946qlKf6b/H1kJ3ng=
X-Received: by 2002:a05:6102:510d:: with SMTP id bm13mr6180428vsb.28.1635733232495;
 Sun, 31 Oct 2021 19:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-4-guoren@kernel.org>
 <87a6ixbcse.wl-maz@kernel.org> <20211028135523.5cf4b66b@redslave.neermore.group>
 <87sfwl9oxg.wl-maz@kernel.org>
In-Reply-To: <87sfwl9oxg.wl-maz@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Nov 2021 10:20:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR3CqtmKZKS3fOQ9mzSLn7_oh7YoSSmWP1YM=ujB_srMw@mail.gmail.com>
Message-ID: <CAJF2gTR3CqtmKZKS3fOQ9mzSLn7_oh7YoSSmWP1YM=ujB_srMw@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] irqchip/sifive-plic: Fixup thead, c900-plic
 request_threaded_irq with ONESHOT
To:     Marc Zyngier <maz@kernel.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:58 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 28 Oct 2021 11:55:23 +0100,
> Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> >
> > Hello Marc and Guo Ren!
> >
> > On Mon, 25 Oct 2021 11:48:33 +0100
> > Marc Zyngier <maz@kernel.org> wrote:
> >
> > > On Sun, 24 Oct 2021 02:33:03 +0100,
> > > guoren@kernel.org wrote:
> > > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the
> > > > driver, only the first interrupt could be handled, and continue irq
> > > > is blocked by hw. Because the thead,c900-plic couldn't complete
> > > > masked irq source which has been disabled in enable register. Add
> > > > thead_plic_chip which fix up c906-plic irq source completion
> > > > problem by unmask/mask wrapper.
> > > >
> > > > Here is the description of Interrupt Completion in PLIC spec [1]:
> > > >
> > > > The PLIC signals it has completed executing an interrupt handler by
> > > > writing the interrupt ID it received from the claim to the
> > > > claim/complete register. The PLIC does not check whether the
> > > > completion ID is the same as the last claim ID for that target. If
> > > > the completion ID does not match an interrupt source that is
> > > > currently enabled for the target, the ^^ ^^^^^^^^^ ^^^^^^^
> > > > completion is silently ignored.
> > >
> > > Given this bit of the spec...
> > >
> > > > +static void plic_thead_irq_eoi(struct irq_data *d)
> > > > +{
> > > > + struct plic_handler *handler =
> > > > this_cpu_ptr(&plic_handlers); +
> > > > + if (irqd_irq_masked(d)) {
> > > > +         plic_irq_unmask(d);
> > > > +         writel(d->hwirq, handler->hart_base +
> > > > CONTEXT_CLAIM);
> > > > +         plic_irq_mask(d);
> > > > + } else {
> > > > +         writel(d->hwirq, handler->hart_base +
> > > > CONTEXT_CLAIM);
> > > > + }
> > > > +}
> > > > +
> > >
> > > ... it isn't obvious to me why this cannot happen on an SiFive PLIC.
> >
> > This indeed happens with SiFive PLIC. I am currently tinkering with
> > da9063 RTC on SiFive Unmatched, and ALARM irq fires only once. However
> > with changes proposed by Guo Ren in plic_thead_irq_eoi, everything
> > begins to work fine.
> >
> > May be these change should be propagated to plic_irq_eoi instead of
> > making a new function ?
>
> That's my impression too. I think the T-Head defect is pretty much
> immaterial when you consider how 'interesting' the PLIC architecture
> is.
Which is the "T-Head defect" you mentioned here?
 1. Auto masking with claim + complete (I don't think it's a defect,
right? May I add a new patch to utilize the feature to decrease a
little duplicate mask/unmask operations in the future?)
 2. EOI failed when masked

> Conflating EOI and masking really is a misfeature...
I think the problem is riscv PLIC reuse enable bit as mask bit. I
recommend separating them. That means:
 - EOI still depends on enable bit.
 - Add mask/unmask bit regs to do the right thing.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
