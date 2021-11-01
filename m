Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40D044123B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 03:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhKAC4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 22:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhKAC4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 22:56:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F70C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 19:53:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d5so10827871wrc.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 19:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvbOQpgpKa/5ij2ev10oZE8n6rmgG4chJJBzT/WxPJ0=;
        b=diIfg/CNueN8pMnCSN/txdouYqdEB7R13PondC3mzFuIywkxT/4fharfu2kkesKGY1
         UnWYWe70KFjZ3mfGRzkUJtSx8xTgz+L0uNBTh1xa1Lk7Wief1CgV+7s7XrsyPTCj+azq
         HgPttcFRHP5ejF/nQcxl+Z7SgbFcY9+SOSNumAdDpodezNBWCJzXUZDox3xccZ/FDOAT
         gZXXKBdDn/G6/AWmEdS7FyXe/FdoOB4Lx9/sEes55248auuHwZzACuDMQrf8q6T8foK2
         n38IL/wWQOLV3kN/dc5bv5I6Kw8y+FDDhGU3r+2NYog+2xCQfbDyY/2WURJ/07XMlCJc
         +6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvbOQpgpKa/5ij2ev10oZE8n6rmgG4chJJBzT/WxPJ0=;
        b=6pc/JquMW3pasckXr+Y3DYQfoPUVN6kZHhy2xUhEewHl5RNcywSTU3vKxNVrovGs/2
         rL/21+uvRBs2Sot45kGXZ1f9RqoN9x7QEgYHblopDn+VOpb9uGRSFoTQOwyU8j4R/aMY
         3NPizph6qB9/0+kN6z2muQEPuGN69AzZnN6K3MhSvWg6mU5FHcqt3mRO1V8x14wybkGc
         tq2ljNxRM+jXy+8lpJSqKK+5AEj2NRy/z55dyn8wHhJUFcUqpFB07k6ETDUDwYdTHBLU
         jFz8n2AX1xoDD9pPYAHfNUDOvKdeCyPPJwqVo7H94+wYFUxiWqOQb5CpRkf5eBMhC++k
         /pMA==
X-Gm-Message-State: AOAM530I/PNx52XY9aS1RcsjUaAiOdggxwrkWlHENSa+e8MQFQAbnTFX
        Tx6JM5mDx6KJMmq2gjmWJORikLU7DNi0em3rERDq5OFk6uU=
X-Google-Smtp-Source: ABdhPJwouoUj164/5xoi25/rch+6KuRfZi1QqakhntCC4/6ov2KkbfvMaMe6RBq8MifprVJ2w0UyWfVUNidosFu1r1k=
X-Received: by 2002:a05:6000:1a45:: with SMTP id t5mr22392605wry.306.1635735206224;
 Sun, 31 Oct 2021 19:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-4-guoren@kernel.org>
 <87a6ixbcse.wl-maz@kernel.org> <20211028135523.5cf4b66b@redslave.neermore.group>
 <87sfwl9oxg.wl-maz@kernel.org> <CAJF2gTR3CqtmKZKS3fOQ9mzSLn7_oh7YoSSmWP1YM=ujB_srMw@mail.gmail.com>
In-Reply-To: <CAJF2gTR3CqtmKZKS3fOQ9mzSLn7_oh7YoSSmWP1YM=ujB_srMw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 1 Nov 2021 08:23:14 +0530
Message-ID: <CAAhSdy1WrxbMsiWkwOXd_76A6wNAh05C1QQ-oFXoE9U-F0akiA@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] irqchip/sifive-plic: Fixup thead, c900-plic
 request_threaded_irq with ONESHOT
To:     Guo Ren <guoren@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
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

On Mon, Nov 1, 2021 at 7:50 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Oct 28, 2021 at 10:58 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Thu, 28 Oct 2021 11:55:23 +0100,
> > Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> > >
> > > Hello Marc and Guo Ren!
> > >
> > > On Mon, 25 Oct 2021 11:48:33 +0100
> > > Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > > On Sun, 24 Oct 2021 02:33:03 +0100,
> > > > guoren@kernel.org wrote:
> > > > >
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the
> > > > > driver, only the first interrupt could be handled, and continue irq
> > > > > is blocked by hw. Because the thead,c900-plic couldn't complete
> > > > > masked irq source which has been disabled in enable register. Add
> > > > > thead_plic_chip which fix up c906-plic irq source completion
> > > > > problem by unmask/mask wrapper.
> > > > >
> > > > > Here is the description of Interrupt Completion in PLIC spec [1]:
> > > > >
> > > > > The PLIC signals it has completed executing an interrupt handler by
> > > > > writing the interrupt ID it received from the claim to the
> > > > > claim/complete register. The PLIC does not check whether the
> > > > > completion ID is the same as the last claim ID for that target. If
> > > > > the completion ID does not match an interrupt source that is
> > > > > currently enabled for the target, the ^^ ^^^^^^^^^ ^^^^^^^
> > > > > completion is silently ignored.
> > > >
> > > > Given this bit of the spec...
> > > >
> > > > > +static void plic_thead_irq_eoi(struct irq_data *d)
> > > > > +{
> > > > > + struct plic_handler *handler =
> > > > > this_cpu_ptr(&plic_handlers); +
> > > > > + if (irqd_irq_masked(d)) {
> > > > > +         plic_irq_unmask(d);
> > > > > +         writel(d->hwirq, handler->hart_base +
> > > > > CONTEXT_CLAIM);
> > > > > +         plic_irq_mask(d);
> > > > > + } else {
> > > > > +         writel(d->hwirq, handler->hart_base +
> > > > > CONTEXT_CLAIM);
> > > > > + }
> > > > > +}
> > > > > +
> > > >
> > > > ... it isn't obvious to me why this cannot happen on an SiFive PLIC.
> > >
> > > This indeed happens with SiFive PLIC. I am currently tinkering with
> > > da9063 RTC on SiFive Unmatched, and ALARM irq fires only once. However
> > > with changes proposed by Guo Ren in plic_thead_irq_eoi, everything
> > > begins to work fine.
> > >
> > > May be these change should be propagated to plic_irq_eoi instead of
> > > making a new function ?
> >
> > That's my impression too. I think the T-Head defect is pretty much
> > immaterial when you consider how 'interesting' the PLIC architecture
> > is.
> Which is the "T-Head defect" you mentioned here?
>  1. Auto masking with claim + complete (I don't think it's a defect,
> right? May I add a new patch to utilize the feature to decrease a
> little duplicate mask/unmask operations in the future?)

This is definitely a defect and non-compliance for T-HEAD because
no sane interrupt controller would mask interrupt upon claim and this
is not what RISC-V PLIC defines.

>  2. EOI failed when masked

This defect exists for both RISC-V PLIC and T-HEAD PLIC
because of the way interrupt completion is defined.

>
> > Conflating EOI and masking really is a misfeature...
> I think the problem is riscv PLIC reuse enable bit as mask bit. I
> recommend separating them. That means:

There are no per-interrupt mask bits. We only have per-context
and per-interrupt enable bits which is used to provide mask/unmask
functionality expected by the irqchip framework.

I don't see how this is a problem for RISC-V PLIC. The only real
issue with RISC-V PLIC is the fact the interrupt completion will be
ignored for a masked interrupt which is what Marc is pointing at.

Regards,
Anup

>  - EOI still depends on enable bit.
>  - Add mask/unmask bit regs to do the right thing.



>
> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
