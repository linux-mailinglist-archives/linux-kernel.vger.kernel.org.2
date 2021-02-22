Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD3132151D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhBVL2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:28:38 -0500
Received: from foss.arm.com ([217.140.110.172]:42194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhBVL0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:26:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 614EB1FB;
        Mon, 22 Feb 2021 03:25:49 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01183F73B;
        Mon, 22 Feb 2021 03:25:47 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:25:44 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 5/8] arm64: irq: add a default handle_irq panic function
Message-ID: <20210222112544.GB70951@C02TD0UTHF1T.local>
References: <20210219113904.41736-1-mark.rutland@arm.com>
 <20210219113904.41736-6-mark.rutland@arm.com>
 <20210222095913.GA70951@C02TD0UTHF1T.local>
 <1d2c27d72b9b2cbdb83d25165a20559a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2c27d72b9b2cbdb83d25165a20559a@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 10:48:11AM +0000, Marc Zyngier wrote:
> On 2021-02-22 09:59, Mark Rutland wrote:
> > On Fri, Feb 19, 2021 at 11:39:01AM +0000, Mark Rutland wrote:
> > > +void (*handle_arch_irq)(struct pt_regs *) __ro_after_init =
> > > default_handle_irq;
> > > 
> > >  int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
> > >  {
> > > -	if (handle_arch_irq)
> > > +	if (handle_arch_irq != default_handle_irq)
> > >  		return -EBUSY;
> > > 
> > >  	handle_arch_irq = handle_irq;
> > > @@ -87,7 +92,7 @@ void __init init_IRQ(void)
> > >  	init_irq_stacks();
> > >  	init_irq_scs();
> > >  	irqchip_init();
> > > -	if (!handle_arch_irq)
> > > +	if (handle_arch_irq == default_handle_irq)
> > >  		panic("No interrupt controller found.");
> 
> It also seems odd to have both default_handle_irq() that panics,
> and init_IRQ that panics as well. Not a big deal, but maybe
> we should just drop this altogether and get the firework on the
> first interrupt.

My gut feeling was that both were useful, and served slightly different
cases:

* The panic in default_handle_irq() helps if we unexpectedly unmask IRQ
  too early. This is mostly a nicety over the current behaviour of
  branching to NULL in this case.

* The panic in init_IRQ() gives us a consistent point at which we can
  note the absence of a root IRQ controller even if all IRQs are
  quiescent. This is a bit nicer to debug than seeing a load of driver
  probes fail their request_irq() or whatever.

... so I'd err on the side of keeping both, but if you think otherwise
I'm happy to change this.

Thanks,
Mark.
