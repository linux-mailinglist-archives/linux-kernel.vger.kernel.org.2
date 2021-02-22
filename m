Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5C321552
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBVLoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:44:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhBVLn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:43:59 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F3764ED6;
        Mon, 22 Feb 2021 11:43:16 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lE9cP-00FJBa-Ih; Mon, 22 Feb 2021 11:43:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Feb 2021 11:43:13 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 5/8] arm64: irq: add a default handle_irq panic function
In-Reply-To: <20210222112544.GB70951@C02TD0UTHF1T.local>
References: <20210219113904.41736-1-mark.rutland@arm.com>
 <20210219113904.41736-6-mark.rutland@arm.com>
 <20210222095913.GA70951@C02TD0UTHF1T.local>
 <1d2c27d72b9b2cbdb83d25165a20559a@kernel.org>
 <20210222112544.GB70951@C02TD0UTHF1T.local>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <2e6a9659eabcccb355318ff7214c8d1f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st, tglx@linutronix.de, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-22 11:25, Mark Rutland wrote:
> On Mon, Feb 22, 2021 at 10:48:11AM +0000, Marc Zyngier wrote:
>> On 2021-02-22 09:59, Mark Rutland wrote:
>> > On Fri, Feb 19, 2021 at 11:39:01AM +0000, Mark Rutland wrote:
>> > > +void (*handle_arch_irq)(struct pt_regs *) __ro_after_init =
>> > > default_handle_irq;
>> > >
>> > >  int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>> > >  {
>> > > -	if (handle_arch_irq)
>> > > +	if (handle_arch_irq != default_handle_irq)
>> > >  		return -EBUSY;
>> > >
>> > >  	handle_arch_irq = handle_irq;
>> > > @@ -87,7 +92,7 @@ void __init init_IRQ(void)
>> > >  	init_irq_stacks();
>> > >  	init_irq_scs();
>> > >  	irqchip_init();
>> > > -	if (!handle_arch_irq)
>> > > +	if (handle_arch_irq == default_handle_irq)
>> > >  		panic("No interrupt controller found.");
>> 
>> It also seems odd to have both default_handle_irq() that panics,
>> and init_IRQ that panics as well. Not a big deal, but maybe
>> we should just drop this altogether and get the firework on the
>> first interrupt.
> 
> My gut feeling was that both were useful, and served slightly different
> cases:
> 
> * The panic in default_handle_irq() helps if we unexpectedly unmask IRQ
>   too early. This is mostly a nicety over the current behaviour of
>   branching to NULL in this case.
> 
> * The panic in init_IRQ() gives us a consistent point at which we can
>   note the absence of a root IRQ controller even if all IRQs are
>   quiescent. This is a bit nicer to debug than seeing a load of driver
>   probes fail their request_irq() or whatever.
> 
> ... so I'd err on the side of keeping both, but if you think otherwise
> I'm happy to change this.

As I said, it's not a big deal. I doubt that we'll see 
default_handle_irq()
exploding in practice. But the real nit here is the difference of 
treatment
between IRQ and FIQ. *IF* we ever get a system that only signals its
interrupt as FIQ (and I don't see why we'd forbid that), then we would

To be clear, I don't think we should care too much either way, and I'm
fine with the code as is.

         M.
-- 
Jazz is not dead. It just smells funny...
