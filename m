Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A4B43864A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 04:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhJXBzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 21:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhJXBzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 21:55:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85A1860FC4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 01:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635040412;
        bh=dgtGbUaKyJhkeN8FVxfsoKQ31HtE58GU7i+rzNa2uwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YV7/MLnQmjz0thsDbFFObufT2E2VpjBqjq7wPMpBcQjA1HrRjfyJdXL2kMPkmzMt2
         YQbzRtjQd3TMZpCZwhyDNQjmK1nNgA3XxZyv8lEIgSeSucEh7i5SbPscoj1x7eemAt
         RFf51MhiFv3ImLRkRGVdyfjRMA76q+DnlInDUdUaHwrZuqOnBh6sqr7F4VkuEW1NFC
         ALKM6byos2V1IBn/zA+A9PGptqJddiuFBWranOWCpFP3xI2oQPeLBX48gNZRYj6HIW
         FUwQfXT+2+puAOnnBLJlczxu3PAqp+eqv6OE3DzV6JSFGXVw7eiY0ZSNYzSift7l5c
         DgOG5Xv+vKvpA==
Received: by mail-ua1-f51.google.com with SMTP id o26so1220866uab.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 18:53:32 -0700 (PDT)
X-Gm-Message-State: AOAM530g7zAnwI20PHZzM1i3RnWe5il9My3YXuP+c0mlhXL5+d7TBLYM
        L4g6Cl7MVJfovwxWWiOsc1d3c99h9KgARUWfJSo=
X-Google-Smtp-Source: ABdhPJw/2IoaPbYltWLtIlaqsveHkS2v+bQld2gBSCJjaSQmhga/a4IadupdkKlOSWhgf4sOZyQw14i59iBzB9aUpFc=
X-Received: by 2002:a67:ca1c:: with SMTP id z28mr9245548vsk.11.1635040411387;
 Sat, 23 Oct 2021 18:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211021180236.37428-1-mark.rutland@arm.com> <20211021180236.37428-6-mark.rutland@arm.com>
 <CAJF2gTShTh5be3SxaVwAzbXTb=LZi-qfweXBvyLeg9TyKgfLNg@mail.gmail.com> <YXJ7YzZoJ1ZkLl4X@FVFF77S0Q05N>
In-Reply-To: <YXJ7YzZoJ1ZkLl4X@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 24 Oct 2021 09:53:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTn+vg-zT2HRMGxBU0iOhr-mVHNZb4e9saD-Tw7Mt3LYQ@mail.gmail.com>
Message-ID: <CAJF2gTTn+vg-zT2HRMGxBU0iOhr-mVHNZb4e9saD-Tw7Mt3LYQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] irq: add generic_handle_arch_irq()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>, kernelfans@gmail.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul McKenney <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        vgupta@kernel.org, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 4:52 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Oct 22, 2021 at 10:33:53AM +0800, Guo Ren wrote:
> > On Fri, Oct 22, 2021 at 2:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > Several architectures select GENERIC_IRQ_MULTI_HANDLER and branch to
> > > handle_arch_irq() without performing any entry accounting.
> > >
> > > Add a generic wrapper to handle the commoon irqentry work when invoking
>
> Ah, I'd typo'd 'common' there; I'll go fix that...
>
> > > handle_arch_irq(). Where an architecture needs to perform some entry
> > > accounting itself, it will need to invoke handle_arch_irq() itself.
> > >
> > > In subsequent patches it will become the responsibilty of the entry code
> > > to set the irq regs when entering an IRQ (rather than deferring this to
> > > an irqchip handler), so generic_handle_arch_irq() is made to set the irq
> > > regs now. This can be redundant in some cases, but is never harmful as
> > > saving/restoring the old regs nests safely.
> > Shall we remove old_regs save/restore in handle_domain_irq? It's duplicated.
>
> We do, in patch 15 when handle_domain_irq() is removed entirely. :)
I miss that patch. Yes, in generic_handle_domain_nmi.

>
> Removing it immediately in this patch would require more ifdeffery and/or
> another copy of handle_domain_irq(), and since the duplication doesn't cause a
> functional problem, I think it's better to live with the temporary duplication
> for the next few patches than to try to optimize the intermediate steps at the
> cost of legibility.
Thx for explaining.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> Thanks,
> Mark.
>
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > ---
> > >  kernel/irq/handle.c | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> > > index 221d80c31e94..27182003b879 100644
> > > --- a/kernel/irq/handle.c
> > > +++ b/kernel/irq/handle.c
> > > @@ -14,6 +14,8 @@
> > >  #include <linux/interrupt.h>
> > >  #include <linux/kernel_stat.h>
> > >
> > > +#include <asm/irq_regs.h>
> > > +
> > >  #include <trace/events/irq.h>
> > >
> > >  #include "internals.h"
> > > @@ -226,4 +228,20 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
> > >         handle_arch_irq = handle_irq;
> > >         return 0;
> > >  }
> > > +
> > > +/**
> > > + * generic_handle_arch_irq - root irq handler for architectures which do no
> > > + *                           entry accounting themselves
> > > + * @regs:      Register file coming from the low-level handling code
> > > + */
> > > +asmlinkage void noinstr generic_handle_arch_irq(struct pt_regs *regs)
> > > +{
> > > +       struct pt_regs *old_regs;
> > > +
> > > +       irq_enter();
> > > +       old_regs = set_irq_regs(regs);
> > > +       handle_arch_irq(regs);
> > > +       set_irq_regs(old_regs);
> > > +       irq_exit();
> > > +}
> > >  #endif
> > > --
> > > 2.11.0
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
