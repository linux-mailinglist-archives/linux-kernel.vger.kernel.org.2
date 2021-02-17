Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF4931D8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhBQL4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:56:24 -0500
Received: from foss.arm.com ([217.140.110.172]:57052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbhBQLuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:50:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A999531B;
        Wed, 17 Feb 2021 03:49:29 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.46.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 623163F694;
        Wed, 17 Feb 2021 03:49:26 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:49:23 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/25] arm64: entry: Map the FIQ vector to IRQ on
 NEEDS_FIQ platforms
Message-ID: <20210217114923.GB5556@C02TD0UTHF1T.local>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-10-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-10-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

On Mon, Feb 15, 2021 at 09:16:57PM +0900, Hector Martin wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> By default, FIQ exceptions trigger a panic. On platforms that need to
> deliver interrupts via FIQ, this gets redirected via an alternative to
> instead handle FIQ the same way as IRQ. It is up to the irqchip handler
> to discriminate between the two.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Since the use of FIQ is a platform integration detail rather than a CPU
implementation detail (and e.g. can differ across bare-metal and VM),
I'd prefer to always have separate registered handlers for IRQ/FIQ (also
avoiding the need for patching). That way we can explicitly opt-in to
FIQ when required, and avoid edge-cases where an unexpected FIQ could
livelock an unaware IRQ handler.

Marc and I had a quick play with that, and I have a series of patches
I've pushed to:

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/fiq
git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/fiq

... which I'll post out shortly.

Thanks,
Mark.

> ---
>  arch/arm64/kernel/entry.S | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ba5f9aa379ce..bcfd1ac72636 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -547,18 +547,18 @@ SYM_CODE_START(vectors)
>  
>  	kernel_ventry	1, sync				// Synchronous EL1h
>  	kernel_ventry	1, irq				// IRQ EL1h
> -	kernel_ventry	1, fiq_invalid			// FIQ EL1h
> +	kernel_ventry	1, fiq				// FIQ EL1h
>  	kernel_ventry	1, error			// Error EL1h
>  
>  	kernel_ventry	0, sync				// Synchronous 64-bit EL0
>  	kernel_ventry	0, irq				// IRQ 64-bit EL0
> -	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
> +	kernel_ventry	0, fiq				// FIQ 64-bit EL0
>  	kernel_ventry	0, error			// Error 64-bit EL0
>  
>  #ifdef CONFIG_COMPAT
>  	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
>  	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
> -	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
> +	kernel_ventry	0, fiq_compat, 32		// FIQ 32-bit EL0
>  	kernel_ventry	0, error_compat, 32		// Error 32-bit EL0
>  #else
>  	kernel_ventry	0, sync_invalid, 32		// Synchronous 32-bit EL0
> @@ -658,6 +658,10 @@ SYM_CODE_START_LOCAL_NOALIGN(el1_sync)
>  SYM_CODE_END(el1_sync)
>  
>  	.align	6
> +SYM_CODE_START_LOCAL_NOALIGN(el1_fiq)
> +alternative_if_not ARM64_NEEDS_FIQ
> +	b	el1_fiq_invalid
> +alternative_else_nop_endif
>  SYM_CODE_START_LOCAL_NOALIGN(el1_irq)
>  	kernel_entry 1
>  	gic_prio_irq_setup pmr=x20, tmp=x1
> @@ -688,6 +692,7 @@ alternative_else_nop_endif
>  
>  	kernel_exit 1
>  SYM_CODE_END(el1_irq)
> +SYM_CODE_END(el1_fiq)
>  
>  /*
>   * EL0 mode handlers.
> @@ -710,10 +715,15 @@ SYM_CODE_START_LOCAL_NOALIGN(el0_sync_compat)
>  SYM_CODE_END(el0_sync_compat)
>  
>  	.align	6
> +SYM_CODE_START_LOCAL_NOALIGN(el0_fiq_compat)
> +alternative_if_not ARM64_NEEDS_FIQ
> +	b	el0_fiq_invalid_compat
> +alternative_else_nop_endif
>  SYM_CODE_START_LOCAL_NOALIGN(el0_irq_compat)
>  	kernel_entry 0, 32
>  	b	el0_irq_naked
>  SYM_CODE_END(el0_irq_compat)
> +SYM_CODE_END(el0_fiq_compat)
>  
>  SYM_CODE_START_LOCAL_NOALIGN(el0_error_compat)
>  	kernel_entry 0, 32
> @@ -722,6 +732,10 @@ SYM_CODE_END(el0_error_compat)
>  #endif
>  
>  	.align	6
> +SYM_CODE_START_LOCAL_NOALIGN(el0_fiq)
> +alternative_if_not ARM64_NEEDS_FIQ
> +	b	el0_fiq_invalid
> +alternative_else_nop_endif
>  SYM_CODE_START_LOCAL_NOALIGN(el0_irq)
>  	kernel_entry 0
>  el0_irq_naked:
> @@ -736,6 +750,7 @@ el0_irq_naked:
>  
>  	b	ret_to_user
>  SYM_CODE_END(el0_irq)
> +SYM_CODE_END(el0_fiq)
>  
>  SYM_CODE_START_LOCAL(el1_error)
>  	kernel_entry 1
> -- 
> 2.30.0
> 
