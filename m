Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD8442529
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 02:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKBBgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 21:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhKBBgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 21:36:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1944D610A3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635816859;
        bh=KBfwQn1lo+MMUlOPKsEz1KcXY8/Wb65K4WsUqTq24E4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cE9XgtnUFOFO2LdcnfN4bMNZSI5vIe8XcJU8ODf/p0RqwhC7veDbcQ4tY7uQWyD5z
         rXRK+QLrTmqTudy+dHtvK345uih4d+fZeTCCLYynZXoFizJyjiPqBwpQSsuuG2jXac
         aoTMaA6d5aKfYtAMqN7/pcHu0n04wGRutN23ll5Ke7Frvq7quPllNrWIaGzXbGB8qL
         jWfXVcZjhOww0mc2F0S6bPYULLe+UmDr8sYsj8jrkZRi7LIcy7wLEu3HbNS5eAXfi1
         Dg3uG1Ew3tyPiLI8jVkeFWGaX6yqCMDZev2La5dfh12bpz/u/16Dvush0C8eJ8zVjZ
         BFfp+vVosRDGQ==
Received: by mail-vk1-f171.google.com with SMTP id e64so8856747vke.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 18:34:19 -0700 (PDT)
X-Gm-Message-State: AOAM530S+DmfXWlwz4lon5hHHsBG0HnxDh0Ef2AQBdcWkr8zY9bFemKT
        KQyWi2Y7Lcj41EPjr8mKpMPmAYHUgpuZOh2m1kU=
X-Google-Smtp-Source: ABdhPJwiZHnZGzmFzbMokFi2SeReyaH4brsIPT0MbKW0LQSZeF6q6/y7zuc2Tm86DLoMTf0LZH7b7X548r8CFmmo24E=
X-Received: by 2002:a05:6122:2192:: with SMTP id j18mr4154959vkd.8.1635816858131;
 Mon, 01 Nov 2021 18:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211101131736.3800114-1-guoren@kernel.org> <20211101164705.4e07fdb9@redslave.neermore.group>
In-Reply-To: <20211101164705.4e07fdb9@redslave.neermore.group>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 2 Nov 2021 09:34:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRM4xFv+EFCBGwLfp3sLoP=fb-aqX572kYvT+nRJFboTw@mail.gmail.com>
Message-ID: <CAJF2gTRM4xFv+EFCBGwLfp3sLoP=fb-aqX572kYvT+nRJFboTw@mail.gmail.com>
Subject: Re: [PATCH V6] irqchip/sifive-plic: Fixup EOI failed when masked
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Pelletier <plr.vincent@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 9:47 PM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
>
> On Mon,  1 Nov 2021 21:17:36 +0800
> guoren@kernel.org wrote:
>
> Hi Guo Ren,
>
> Thank you for your patch.
>
> May be it should be applied to stable ?
Yes, I would Cc stable next.

>
> Tested-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the
> > driver, only the first interrupt could be handled, and continue irq
> > is blocked by hw. Because the riscv plic couldn't complete masked irq
> > source which has been disabled in enable register. The bug was
> > firstly reported in [1].
> >
> > Here is the description of Interrupt Completion in PLIC spec [2]:
> >
> > The PLIC signals it has completed executing an interrupt handler by
> > writing the interrupt ID it received from the claim to the
> > claim/complete register. The PLIC does not check whether the
> > completion ID is the same as the last claim ID for that target. If
> > the completion ID does not match an interrupt source that is
> > currently enabled for the target, the ^^ ^^^^^^^^^ ^^^^^^^
> > completion is silently ignored.
> >
> > [1]
> > http://lists.infradead.org/pipermail/linux-riscv/2021-July/007441.html
> > [2]
> > https://github.com/riscv/riscv-plic-spec/blob/8bc15a35d07c9edf7b5d23fec9728302595ffc4d/riscv-plic.adoc
> >
> > Reported-by: Vincent Pelletier <plr.vincent@gmail.com>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > Cc: Nikita Shubin <nikita.shubin@maquefel.me>
> > Cc: incent Pelletier <plr.vincent@gmail.com>
> >
> > ---
> >
> > Changes since V6:
> >  - Propagate to plic_irq_eoi for all riscv,plic by Nikita Shubin
> >  - Remove thead related codes
> >
> > Changes since V5:
> >  - Move back to mask/unmask
> >  - Fixup the problem in eoi callback
> >  - Remove allwinner,sun20i-d1 IRQCHIP_DECLARE
> >  - Rewrite comment log
> >
> > Changes since V4:
> >  - Update comment by Anup
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
> >  drivers/irqchip/irq-sifive-plic.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c
> > b/drivers/irqchip/irq-sifive-plic.c index cf74cfa82045..259065d271ef
> > 100644 --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -163,7 +163,13 @@ static void plic_irq_eoi(struct irq_data *d)
> >  {
> >       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> >
> > -     writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > +     if (irqd_irq_masked(d)) {
> > +             plic_irq_unmask(d);
> > +             writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > +             plic_irq_mask(d);
> > +     } else {
> > +             writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > +     }
> >  }
> >
> >  static struct irq_chip plic_chip = {
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
