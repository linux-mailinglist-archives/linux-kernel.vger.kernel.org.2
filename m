Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539A0437434
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhJVJEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:04:52 -0400
Received: from foss.arm.com ([217.140.110.172]:51704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhJVJEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:04:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DC56ED1;
        Fri, 22 Oct 2021 02:02:34 -0700 (PDT)
Received: from FVFF77S0Q05N (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D26BC3F70D;
        Fri, 22 Oct 2021 02:02:30 -0700 (PDT)
Date:   Fri, 22 Oct 2021 10:02:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 05/15] irq: add generic_handle_arch_irq()
Message-ID: <YXJ+JObUxKUXxr+1@FVFF77S0Q05N>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-6-mark.rutland@arm.com>
 <YXIdkj2x0+yw+TIf@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXIdkj2x0+yw+TIf@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:10:26AM +0800, Pingfan Liu wrote:
> On Thu, Oct 21, 2021 at 07:02:26PM +0100, Mark Rutland wrote:
> > Several architectures select GENERIC_IRQ_MULTI_HANDLER and branch to
> > handle_arch_irq() without performing any entry accounting.
> > 
> > Add a generic wrapper to handle the commoon irqentry work when invoking
> > handle_arch_irq(). Where an architecture needs to perform some entry
> > accounting itself, it will need to invoke handle_arch_irq() itself.
> > 
> > In subsequent patches it will become the responsibilty of the entry code
> > to set the irq regs when entering an IRQ (rather than deferring this to
> > an irqchip handler), so generic_handle_arch_irq() is made to set the irq
> > regs now. This can be redundant in some cases, but is never harmful as
> > saving/restoring the old regs nests safely.
> > 
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
> >  	handle_arch_irq = handle_irq;
> >  	return 0;
> >  }
> > +
> > +/**
> > + * generic_handle_arch_irq - root irq handler for architectures which do no
> > + *                           entry accounting themselves
> > + * @regs:	Register file coming from the low-level handling code
> > + */
> > +asmlinkage void noinstr generic_handle_arch_irq(struct pt_regs *regs)
> > +{
> > +	struct pt_regs *old_regs;
> > +
> > +	irq_enter();
> > +	old_regs = set_irq_regs(regs);
> > +	handle_arch_irq(regs);
> 
> After all involved arches call generic_handle_arch_irq(), can
> handle_arch_irq be encapsulated by declaring as static?
> 
> Two places need to be fixed for this purpose:
> -1. absorb the logic about handle_arch_irq in arm64/kernel/irq.c
> -2. In arm, setup_arch(), 
>     #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
>             handle_arch_irq = mdesc->handle_irq;
>     #endif

That arm bit would need to be set_handle_irq(mdesc->handle_irq); anywhere it
uses handle_arch_irq it's depending on the CONFIG_GENERIC_IRQ_MULTI_HANDLER
definition.

While I agree it would seem nice to encapsulate this, in future we want
architectures to move to the more correct entry sequencing described in the
cover letter, and when that happens they should invoke handle_arch_irq()
directly, so I think this is best to leave as-is.

We have custom logic on arm64 because we want to handle IRQ and FIQ
consistently, and there wasn't a neat way to bodge that into the generic code,
but that issue doesn't apply to the other users of
CONFIG_GENERIC_IRQ_MULTI_HANDLER.

Thanks,
Mark.
