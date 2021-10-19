Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619EF433709
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhJSN32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235557AbhJSN30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:29:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F51761038
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634650034;
        bh=XwT+O/puqIO9BVfJ+yLseMkazHGtskDQhP43nI3oppI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CEfX81BfCRk2mEwUgwZbVCdkLh9u7Ef0w0Pc8fcOmUzsWgiaUWT16G26XXz2JoFeS
         GY0my/BtI2nl/OeTlf/yC82pAfK5m/OvihOcjxc44jhYsyY/OoUQldMSg0ygo/1DGu
         AUViooEqtFueY88yOpVH4r/dBhQatnV45M7TagJsmzIM3H1z7Gr1XvWc+OtyTpo81O
         wRu9D4YN6yfsC6jgSkP9zu9MIVjN44UooFwYSpia0nJIr6L0ND/V85P7R/0oMmW3hk
         2DseVbsVxLL3fEq+HMoh2tiEY8L0R01aw6Xobmo8tVEU1yAY8ozP9pbNtwVpEo9O2p
         BxkSCmXVVI76w==
Received: by mail-ua1-f50.google.com with SMTP id h4so11174919uaw.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:27:14 -0700 (PDT)
X-Gm-Message-State: AOAM533C1iMlrQruLVAyOPmKAR6cdPstpxhWHhd0RpTmzP7WWeVK9Yix
        TmuVnpT2MZRelufJCkFTeQzDYkx7NH2/y2zrM78=
X-Google-Smtp-Source: ABdhPJxZ8MT65UmaNvlpDO/eGxDHT6mlb1Hzhjau2Hlwa4n/GLInYBXxt7YnLmtajfjpmoL7vYq4xsEJzzSBRPB8hKY=
X-Received: by 2002:a05:6102:537:: with SMTP id m23mr34557525vsa.43.1634650033178;
 Tue, 19 Oct 2021 06:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org> <f850af365f2ac77af79ec59f92e6434a@kernel.org>
 <CAJF2gTShT8Tvk0z6B52zKEi0vq_toc-7mAKWFKj3j-zg=OhpYQ@mail.gmail.com> <8735oxuxlq.wl-maz@kernel.org>
In-Reply-To: <8735oxuxlq.wl-maz@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 19 Oct 2021 21:27:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSmyu9nA5M3QLeR1LdGMkeGb7jE93Z9zjixcpb_freLMw@mail.gmail.com>
Message-ID: <CAJF2gTSmyu9nA5M3QLeR1LdGMkeGb7jE93Z9zjixcpb_freLMw@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
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

On Tue, Oct 19, 2021 at 6:18 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 19 Oct 2021 10:33:49 +0100,
> Guo Ren <guoren@kernel.org> wrote:
>
> > > If you have an 'automask' behavior and yet the HW doesn't record this
> > > in a separate bit, then you need to track this by yourself in the
> > > irq_eoi() callback instead. I guess that you would skip the write to
> > > the CLAIM register in this case, though I have no idea whether this
> > > breaks
> > > the HW interrupt state or not.
> > The problem is when enable bit is 0 for that irq_number,
> > "writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM)" wouldn't affect
> > the hw state machine. Then this irq would enter in ack state and no
> > continues irqs could come in.
>
> Really? This means that you cannot mask an interrupt while it is being
> handled? How great...
If the completion ID does not match an interrupt source that is
currently enabled for the target, the completion is silently ignored.
So, C9xx completion depends on enable-bit.

>
> > >
> > > There is an example of this in the Apple AIC driver.
> > Thx for the tip, I think your suggestion is:
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -163,7 +163,12 @@ static void plic_irq_eoi(struct irq_data *d)
> >  {
> >         struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> >
> > -       writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > +       if (irqd_irq_masked(d)) {
> > +               plic_irq_unmask(d);
> > +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > +               plic_irq_mask(d);
>
> This looks pretty dodgy. You are relying on interrupts being globally
> masked on the CPU, I guess. It probably works today, but man, what a
> terrible HW implementation.



>
> You'll definitely have to move this into a c900-specific callback.
Yes, it's an errata.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
