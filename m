Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808A53213B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBVKEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:04:44 -0500
Received: from foss.arm.com ([217.140.110.172]:38392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhBVKAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:00:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C65E4ED1;
        Mon, 22 Feb 2021 01:59:25 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2C873F73B;
        Mon, 22 Feb 2021 01:59:23 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:59:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        maz@kernel.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 5/8] arm64: irq: add a default handle_irq panic function
Message-ID: <20210222095913.GA70951@C02TD0UTHF1T.local>
References: <20210219113904.41736-1-mark.rutland@arm.com>
 <20210219113904.41736-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219113904.41736-6-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:39:01AM +0000, Mark Rutland wrote:
> If we accidentally unmask IRQs before we've registered an IRQ
> controller, handle_arch_irq will be NULL, and the IRQ exception handler
> will branch to a bogus address.
> 
> To make this easier to debug, this patch initialises handle_arch_irq to
> a default handler which will panic(), making such problems easier to
> debug. When we add support for FIQ handlers, we can follow the same
> approach.

> -void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
> +void default_handle_irq(struct pt_regs *regs)
> +{
> +	panic("IRQ taken without a registered IRQ controller\n");
> +}

The kbuild test robot pointed out that this should be static (likewise
with default_handle_fiq in patch 8), since it's only used within this
file, so I've updated that in my branch.

Mark.

> +
> +void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
>  
>  int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>  {
> -	if (handle_arch_irq)
> +	if (handle_arch_irq != default_handle_irq)
>  		return -EBUSY;
>  
>  	handle_arch_irq = handle_irq;
> @@ -87,7 +92,7 @@ void __init init_IRQ(void)
>  	init_irq_stacks();
>  	init_irq_scs();
>  	irqchip_init();
> -	if (!handle_arch_irq)
> +	if (handle_arch_irq == default_handle_irq)
>  		panic("No interrupt controller found.");
>  
>  	if (system_uses_irq_prio_masking()) {
> -- 
> 2.11.0
> 
