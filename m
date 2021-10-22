Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A164D4373FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhJVIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:54:30 -0400
Received: from foss.arm.com ([217.140.110.172]:51532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhJVIy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:54:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 722E0ED1;
        Fri, 22 Oct 2021 01:52:11 -0700 (PDT)
Received: from FVFF77S0Q05N (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FADC3F70D;
        Fri, 22 Oct 2021 01:52:08 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:52:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <guoren@kernel.org>
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
Subject: Re: [PATCH 05/15] irq: add generic_handle_arch_irq()
Message-ID: <YXJ7YzZoJ1ZkLl4X@FVFF77S0Q05N>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-6-mark.rutland@arm.com>
 <CAJF2gTShTh5be3SxaVwAzbXTb=LZi-qfweXBvyLeg9TyKgfLNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTShTh5be3SxaVwAzbXTb=LZi-qfweXBvyLeg9TyKgfLNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:33:53AM +0800, Guo Ren wrote:
> On Fri, Oct 22, 2021 at 2:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Several architectures select GENERIC_IRQ_MULTI_HANDLER and branch to
> > handle_arch_irq() without performing any entry accounting.
> >
> > Add a generic wrapper to handle the commoon irqentry work when invoking

Ah, I'd typo'd 'common' there; I'll go fix that...

> > handle_arch_irq(). Where an architecture needs to perform some entry
> > accounting itself, it will need to invoke handle_arch_irq() itself.
> >
> > In subsequent patches it will become the responsibilty of the entry code
> > to set the irq regs when entering an IRQ (rather than deferring this to
> > an irqchip handler), so generic_handle_arch_irq() is made to set the irq
> > regs now. This can be redundant in some cases, but is never harmful as
> > saving/restoring the old regs nests safely.
> Shall we remove old_regs save/restore in handle_domain_irq? It's duplicated.

We do, in patch 15 when handle_domain_irq() is removed entirely. :)

Removing it immediately in this patch would require more ifdeffery and/or
another copy of handle_domain_irq(), and since the duplication doesn't cause a
functional problem, I think it's better to live with the temporary duplication
for the next few patches than to try to optimize the intermediate steps at the
cost of legibility.

Thanks,
Mark.

> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/irq/handle.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> > index 221d80c31e94..27182003b879 100644
> > --- a/kernel/irq/handle.c
> > +++ b/kernel/irq/handle.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel_stat.h>
> >
> > +#include <asm/irq_regs.h>
> > +
> >  #include <trace/events/irq.h>
> >
> >  #include "internals.h"
> > @@ -226,4 +228,20 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
> >         handle_arch_irq = handle_irq;
> >         return 0;
> >  }
> > +
> > +/**
> > + * generic_handle_arch_irq - root irq handler for architectures which do no
> > + *                           entry accounting themselves
> > + * @regs:      Register file coming from the low-level handling code
> > + */
> > +asmlinkage void noinstr generic_handle_arch_irq(struct pt_regs *regs)
> > +{
> > +       struct pt_regs *old_regs;
> > +
> > +       irq_enter();
> > +       old_regs = set_irq_regs(regs);
> > +       handle_arch_irq(regs);
> > +       set_irq_regs(old_regs);
> > +       irq_exit();
> > +}
> >  #endif
> > --
> > 2.11.0
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
