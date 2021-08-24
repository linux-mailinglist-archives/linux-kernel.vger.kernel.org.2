Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF9E3F630E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhHXQpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:45:41 -0400
Received: from foss.arm.com ([217.140.110.172]:38128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhHXQpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:45:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF72431B;
        Tue, 24 Aug 2021 09:44:55 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.90.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64623F766;
        Tue, 24 Aug 2021 09:44:53 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:44:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH 05/13] clocksource/arm_arch_timer: Fix MMIO base address
 vs callback ordering issue
Message-ID: <20210824164451.GJ96738@C02TD0UTHF1T.local>
References: <20210809152651.2297337-1-maz@kernel.org>
 <20210809152651.2297337-6-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809152651.2297337-6-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 04:26:43PM +0100, Marc Zyngier wrote:
> The MMIO timer base address gets published after we have registered
> the callbacks and the interrupt handler, which is... a bit dangerous.
> 
> Fix this by moving the base address publication to the point where
> we register the timer, and expose a pointer to the timer structure
> itself rather than a naked value.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

I don't have agood setup to test this with, but this looks good to me,
and builds cleanly for arm/arm64, so:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/clocksource/arm_arch_timer.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 160464f75017..ca7761d8459a 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -54,13 +54,13 @@
>  
>  static unsigned arch_timers_present __initdata;
>  
> -static void __iomem *arch_counter_base __ro_after_init;
> -
>  struct arch_timer {
>  	void __iomem *base;
>  	struct clock_event_device evt;
>  };
>  
> +static struct arch_timer *arch_timer_mem __ro_after_init;
> +
>  #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
>  
>  static u32 arch_timer_rate __ro_after_init;
> @@ -975,9 +975,9 @@ static u64 arch_counter_get_cntvct_mem(void)
>  	u32 vct_lo, vct_hi, tmp_hi;
>  
>  	do {
> -		vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> -		vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
> -		tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> +		vct_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
> +		vct_lo = readl_relaxed(arch_timer_mem->base + CNTVCT_LO);
> +		tmp_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
>  	} while (vct_hi != tmp_hi);
>  
>  	return ((u64) vct_hi << 32) | vct_lo;
> @@ -1168,25 +1168,25 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
>  {
>  	int ret;
>  	irq_handler_t func;
> -	struct arch_timer *t;
>  
> -	t = kzalloc(sizeof(*t), GFP_KERNEL);
> -	if (!t)
> +	arch_timer_mem = kzalloc(sizeof(*arch_timer_mem), GFP_KERNEL);
> +	if (!arch_timer_mem)
>  		return -ENOMEM;
>  
> -	t->base = base;
> -	t->evt.irq = irq;
> -	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &t->evt);
> +	arch_timer_mem->base = base;
> +	arch_timer_mem->evt.irq = irq;
> +	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &arch_timer_mem->evt);
>  
>  	if (arch_timer_mem_use_virtual)
>  		func = arch_timer_handler_virt_mem;
>  	else
>  		func = arch_timer_handler_phys_mem;
>  
> -	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &t->evt);
> +	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &arch_timer_mem->evt);
>  	if (ret) {
>  		pr_err("Failed to request mem timer irq\n");
> -		kfree(t);
> +		kfree(arch_timer_mem);
> +		arch_timer_mem = NULL;
>  	}
>  
>  	return ret;
> @@ -1444,7 +1444,6 @@ arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
>  		return ret;
>  	}
>  
> -	arch_counter_base = base;
>  	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
>  
>  	return 0;
> -- 
> 2.30.2
> 
