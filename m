Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF11B32146A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBVKtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhBVKs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:48:57 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29BC64D99;
        Mon, 22 Feb 2021 10:48:14 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lE8l9-00FIdq-QM; Mon, 22 Feb 2021 10:48:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Feb 2021 10:48:11 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 5/8] arm64: irq: add a default handle_irq panic function
In-Reply-To: <20210222095913.GA70951@C02TD0UTHF1T.local>
References: <20210219113904.41736-1-mark.rutland@arm.com>
 <20210219113904.41736-6-mark.rutland@arm.com>
 <20210222095913.GA70951@C02TD0UTHF1T.local>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <1d2c27d72b9b2cbdb83d25165a20559a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st, tglx@linutronix.de, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-22 09:59, Mark Rutland wrote:
> On Fri, Feb 19, 2021 at 11:39:01AM +0000, Mark Rutland wrote:
>> If we accidentally unmask IRQs before we've registered an IRQ
>> controller, handle_arch_irq will be NULL, and the IRQ exception 
>> handler
>> will branch to a bogus address.
>> 
>> To make this easier to debug, this patch initialises handle_arch_irq 
>> to
>> a default handler which will panic(), making such problems easier to
>> debug. When we add support for FIQ handlers, we can follow the same
>> approach.
> 
>> -void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
>> +void default_handle_irq(struct pt_regs *regs)
>> +{
>> +	panic("IRQ taken without a registered IRQ controller\n");
>> +}
> 
> The kbuild test robot pointed out that this should be static (likewise
> with default_handle_fiq in patch 8), since it's only used within this
> file, so I've updated that in my branch.
> 
> Mark.
> 
>> +
>> +void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = 
>> default_handle_irq;
>> 
>>  int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>>  {
>> -	if (handle_arch_irq)
>> +	if (handle_arch_irq != default_handle_irq)
>>  		return -EBUSY;
>> 
>>  	handle_arch_irq = handle_irq;
>> @@ -87,7 +92,7 @@ void __init init_IRQ(void)
>>  	init_irq_stacks();
>>  	init_irq_scs();
>>  	irqchip_init();
>> -	if (!handle_arch_irq)
>> +	if (handle_arch_irq == default_handle_irq)
>>  		panic("No interrupt controller found.");

It also seems odd to have both default_handle_irq() that panics,
and init_IRQ that panics as well. Not a big deal, but maybe
we should just drop this altogether and get the firework on the
first interrupt.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
