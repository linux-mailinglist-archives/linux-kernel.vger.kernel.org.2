Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984E03E59FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbhHJMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 08:34:39 -0400
Received: from foss.arm.com ([217.140.110.172]:54394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238617AbhHJMef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:34:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D2D76D;
        Tue, 10 Aug 2021 05:34:13 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 881713F70D;
        Tue, 10 Aug 2021 05:34:10 -0700 (PDT)
Date:   Tue, 10 Aug 2021 13:34:07 +0100
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
Subject: Re: [PATCH 08/13] clocksource/arm_arch_timer: Work around broken
 CVAL implementations
Message-ID: <20210810123407.GB52842@C02TD0UTHF1T.local>
References: <20210809152651.2297337-1-maz@kernel.org>
 <20210809152651.2297337-9-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809152651.2297337-9-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 04:26:46PM +0100, Marc Zyngier wrote:
> The Applied Micro XGene-1 SoC has a busted implementation of the
> CVAL register: it looks like it is based on TVAL instead of the
> other way around. The net effect of this implementation blunder
> is that the maximum deadline you can program in the timer is
> 32bit wide.
> 
> Detect the problematic case and limit the timer to 32bit deltas.
> Note that we don't tie this bug to XGene specifically, as it may
> also catch similar defects on other high-quality implementations.

Do we know of any other implementations that have a similar bug?

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 38 +++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 895844c33351..1c596cd3cc5c 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -778,9 +778,42 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
>  	return 0;
>  }
>  
> +static u64 __arch_timer_check_delta(void)
> +{
> +#ifdef CONFIG_ARM64
> +	u64 tmp;
> +
> +	/*
> +	 * XGene-1 implements CVAL in terms of TVAL, meaning that the
> +	 * maximum timer range is 32bit. Shame on them. Detect the
> +	 * issue by setting a timer to now+(1<<32), which will
> +	 * immediately fire on the duff CPU.
> +	 */
> +	write_sysreg(0, cntv_ctl_el0);
> +	isb();
> +	tmp = read_sysreg(cntvct_el0) | BIT(32);
> +	write_sysreg(tmp, cntv_cval_el0);

This will fire on legitimate implementations fairly often. Consider if
we enter this function at a time where CNTCVT_EL0[32] == 1, where:

* At 100MHz, bit 32 flips every ~42.95
* At 200MHz, bit 32 flips every ~21.47
* At 1GHz, bit 32 flips every ~4.29s

... and ThunderX2 has a 200MHz frequency today, with SBSA recommending
100MHz.

What does XGene-1 return upon a read of CVAL? If it always returns 0 for
the high bits, we could do a timing-insensitive check for truncation of
CVAL, e.g.

| 	/* CVAL must be at least 56 bits wide, as with CNT */
| 	u64 mask = GENMASK(55, 0);
| 	u64 val;
| 
| 	write_sysreg(mask, cntv_cval_el0);
| 	val = read_sysread(cnt_cval_el0);
| 
| 	if (val != mask) {
| 		/* What a great CPU */
| 	}

Thanks,
Mark.

> +	write_sysreg(ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_MASK,
> +		     cntv_ctl_el0);
> +	isb();
> +
> +	tmp = read_sysreg(cntv_ctl_el0);
> +	write_sysreg(0, cntv_ctl_el0);
> +	isb();
> +
> +	if (tmp & ARCH_TIMER_CTRL_IT_STAT) {
> +		pr_warn_once("Detected broken implementation, limiting width to 32bits");
> +		return CLOCKSOURCE_MASK(32);
> +	}
> +#endif
> +	return CLOCKSOURCE_MASK(56);
> +}
> +
>  static void __arch_timer_setup(unsigned type,
>  			       struct clock_event_device *clk)
>  {
> +	u64 max_delta;
> +
>  	clk->features = CLOCK_EVT_FEAT_ONESHOT;
>  
>  	if (type == ARCH_TIMER_TYPE_CP15) {
> @@ -812,6 +845,7 @@ static void __arch_timer_setup(unsigned type,
>  		}
>  
>  		clk->set_next_event = sne;
> +		max_delta = __arch_timer_check_delta();
>  	} else {
>  		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
>  		clk->name = "arch_mem_timer";
> @@ -828,11 +862,13 @@ static void __arch_timer_setup(unsigned type,
>  			clk->set_next_event =
>  				arch_timer_set_next_event_phys_mem;
>  		}
> +
> +		max_delta = CLOCKSOURCE_MASK(56);
>  	}
>  
>  	clk->set_state_shutdown(clk);
>  
> -	clockevents_config_and_register(clk, arch_timer_rate, 0xf, CLOCKSOURCE_MASK(56));
> +	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
>  }
>  
>  static void arch_timer_evtstrm_enable(int divider)
> -- 
> 2.30.2
> 
