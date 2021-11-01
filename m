Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3AE441200
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 03:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhKACDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 22:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhKACDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 22:03:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72809610A8
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 02:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635732044;
        bh=shDWMdR5V2gSq0ntHDz1VoZ/I3FO9yU751bkzZSy4uU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r/KJGLPJ/bEKLNfFgjopwlGfCSOs1ce1OalxGSb3AD/wINtuVf/u73DIHpJgoIlAs
         VIpku2Ri8Z81ZDsz9LFS0mxrON1qiVXH5H6eLf2w4OVSx/WVgdDurGlLE/rz+4GpM2
         LCAbNowRHhDCBxDgrRweDqoF9zEJKlD6LT9liIzyW87HbcUOEHB8EUbkD7U8V69SML
         rTA1L594a7qguNKO0Wx4H9JFjOrfhvedsPywO0kMXomRUxvN6ZoyWYhB4u9t0EI2Em
         aDCE9yTJ+uObRgxUvX777AYl3Mt4i2zZ+TOr/3nTiNkexoscnH+lHdBzDCw5GAw4I9
         j5qncXHFNt/zw==
Received: by mail-ua1-f41.google.com with SMTP id i6so15002235uae.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 19:00:44 -0700 (PDT)
X-Gm-Message-State: AOAM530K1dYXn3SiPXyAMOzobi4gjYRneQ7M0ivZRgdBQ2ZzIL26Weh2
        d0L+nGaMro+dEvsnsPeyJWe+hGNGbcp+dRICInU=
X-Google-Smtp-Source: ABdhPJzFRI/HrKf9T9tRooHhLIs67Rp+m6dvFEoAhFZMESmvoDaPLjdwFFWHOWJhZAPLQ8OQKNSWFvLZZ9pCmvBE+yw=
X-Received: by 2002:a67:ca1c:: with SMTP id z28mr26599957vsk.11.1635732043483;
 Sun, 31 Oct 2021 19:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-4-guoren@kernel.org>
 <87a6ixbcse.wl-maz@kernel.org> <20211028135523.5cf4b66b@redslave.neermore.group>
In-Reply-To: <20211028135523.5cf4b66b@redslave.neermore.group>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Nov 2021 10:00:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRcVNLxns42u6GK3qhGKoqLb-10H=b2BDGWwuDRi_MPQw@mail.gmail.com>
Message-ID: <CAJF2gTRcVNLxns42u6GK3qhGKoqLb-10H=b2BDGWwuDRi_MPQw@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] irqchip/sifive-plic: Fixup thead, c900-plic
 request_threaded_irq with ONESHOT
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
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

Thx Nikita,

I would fixup that globally in the plic in next version of patch.

On Thu, Oct 28, 2021 at 7:01 PM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
>
> Hello Marc and Guo Ren!
>
> On Mon, 25 Oct 2021 11:48:33 +0100
> Marc Zyngier <maz@kernel.org> wrote:
>
> > On Sun, 24 Oct 2021 02:33:03 +0100,
> > guoren@kernel.org wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the
> > > driver, only the first interrupt could be handled, and continue irq
> > > is blocked by hw. Because the thead,c900-plic couldn't complete
> > > masked irq source which has been disabled in enable register. Add
> > > thead_plic_chip which fix up c906-plic irq source completion
> > > problem by unmask/mask wrapper.
> > >
> > > Here is the description of Interrupt Completion in PLIC spec [1]:
> > >
> > > The PLIC signals it has completed executing an interrupt handler by
> > > writing the interrupt ID it received from the claim to the
> > > claim/complete register. The PLIC does not check whether the
> > > completion ID is the same as the last claim ID for that target. If
> > > the completion ID does not match an interrupt source that is
> > > currently enabled for the target, the ^^ ^^^^^^^^^ ^^^^^^^
> > > completion is silently ignored.
> >
> > Given this bit of the spec...
> >
> > > +static void plic_thead_irq_eoi(struct irq_data *d)
> > > +{
> > > +   struct plic_handler *handler =
> > > this_cpu_ptr(&plic_handlers); +
> > > +   if (irqd_irq_masked(d)) {
> > > +           plic_irq_unmask(d);
> > > +           writel(d->hwirq, handler->hart_base +
> > > CONTEXT_CLAIM);
> > > +           plic_irq_mask(d);
> > > +   } else {
> > > +           writel(d->hwirq, handler->hart_base +
> > > CONTEXT_CLAIM);
> > > +   }
> > > +}
> > > +
> >
> > ... it isn't obvious to me why this cannot happen on an SiFive PLIC.
>
> This indeed happens with SiFive PLIC. I am currently tinkering with
> da9063 RTC on SiFive Unmatched, and ALARM irq fires only once. However
> with changes proposed by Guo Ren in plic_thead_irq_eoi, everything
> begins to work fine.
>
> May be these change should be propagated to plic_irq_eoi instead of
> making a new function ?
>
> >
> > And it isn't only for threaded interrupts in oneshot mode. Any driver
> > can mask an interrupt from its handler after having set the
> > IRQ_DISABLE_UNLAZY flag, and the interrupt would need the exact same
> > treatment.
> >
> >       M.
> >
>
> ---
> diff --git a/drivers/irqchip/irq-sifive-plic.c
> b/drivers/irqchip/irq-sifive-plic.c index cf74cfa82045..259065d271ef
> 100644 --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -163,7 +163,13 @@ static void plic_irq_eoi(struct irq_data *d)
>  {
>         struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>
> -       writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +       if (irqd_irq_masked(d)) {
> +               plic_irq_unmask(d);
> +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +               plic_irq_mask(d);
> +       } else {
> +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +       }
>  }
>
>  static struct irq_chip plic_chip = {



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
