Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC03215C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 13:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhBVMHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 07:07:36 -0500
Received: from foss.arm.com ([217.140.110.172]:43906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhBVMHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:07:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B89751FB;
        Mon, 22 Feb 2021 04:06:18 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBB993F70D;
        Mon, 22 Feb 2021 04:06:16 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:06:14 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 5/8] arm64: irq: add a default handle_irq panic function
Message-ID: <20210222120614.GC70951@C02TD0UTHF1T.local>
References: <20210219113904.41736-1-mark.rutland@arm.com>
 <20210219113904.41736-6-mark.rutland@arm.com>
 <20210222095913.GA70951@C02TD0UTHF1T.local>
 <1d2c27d72b9b2cbdb83d25165a20559a@kernel.org>
 <20210222112544.GB70951@C02TD0UTHF1T.local>
 <2e6a9659eabcccb355318ff7214c8d1f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e6a9659eabcccb355318ff7214c8d1f@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 11:43:13AM +0000, Marc Zyngier wrote:
> On 2021-02-22 11:25, Mark Rutland wrote:
> > On Mon, Feb 22, 2021 at 10:48:11AM +0000, Marc Zyngier wrote:
> > > On 2021-02-22 09:59, Mark Rutland wrote:
> > > > On Fri, Feb 19, 2021 at 11:39:01AM +0000, Mark Rutland wrote:
> > > > > +void (*handle_arch_irq)(struct pt_regs *) __ro_after_init =
> > > > > default_handle_irq;
> > > > >
> > > > >  int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
> > > > >  {
> > > > > -	if (handle_arch_irq)
> > > > > +	if (handle_arch_irq != default_handle_irq)
> > > > >  		return -EBUSY;
> > > > >
> > > > >  	handle_arch_irq = handle_irq;
> > > > > @@ -87,7 +92,7 @@ void __init init_IRQ(void)
> > > > >  	init_irq_stacks();
> > > > >  	init_irq_scs();
> > > > >  	irqchip_init();
> > > > > -	if (!handle_arch_irq)
> > > > > +	if (handle_arch_irq == default_handle_irq)
> > > > >  		panic("No interrupt controller found.");
> > > 
> > > It also seems odd to have both default_handle_irq() that panics,
> > > and init_IRQ that panics as well. Not a big deal, but maybe
> > > we should just drop this altogether and get the firework on the
> > > first interrupt.
> > 
> > My gut feeling was that both were useful, and served slightly different
> > cases:
> > 
> > * The panic in default_handle_irq() helps if we unexpectedly unmask IRQ
> >   too early. This is mostly a nicety over the current behaviour of
> >   branching to NULL in this case.
> > 
> > * The panic in init_IRQ() gives us a consistent point at which we can
> >   note the absence of a root IRQ controller even if all IRQs are
> >   quiescent. This is a bit nicer to debug than seeing a load of driver
> >   probes fail their request_irq() or whatever.
> > 
> > ... so I'd err on the side of keeping both, but if you think otherwise
> > I'm happy to change this.
> 
> As I said, it's not a big deal. I doubt that we'll see default_handle_irq()
> exploding in practice. But the real nit here is the difference of treatment
> between IRQ and FIQ. *IF* we ever get a system that only signals its
> interrupt as FIQ (and I don't see why we'd forbid that), then we would

That's a fair point.

For consistency, we could remove the init_IRQ() panic() and instead log
the registered handlers, e.g.

| pr_info("Root IRQ handler is %ps\n", handle_arch_irq);
| pr_info("Root FIQ handler is %ps\n", handle_arch_fiq);

... or do that inside the set_handle_{irq,fiq}() functions. That way the
messages (or absence thereof) would be sufficient to diagnose the lack
of a root IRQ/FIQ handler when IRQ/FIQ happens to be quiescent.

Does that sound any better?

> To be clear, I don't think we should care too much either way, and I'm
> fine with the code as is.

Sure, and FWIW I agree with the nit!

Thanks,
Mark.
