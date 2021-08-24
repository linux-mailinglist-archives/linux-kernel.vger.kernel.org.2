Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100BF3F629D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhHXQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:22:15 -0400
Received: from foss.arm.com ([217.140.110.172]:37918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhHXQWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:22:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CDEE31B;
        Tue, 24 Aug 2021 09:21:27 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.90.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DF623F766;
        Tue, 24 Aug 2021 09:21:25 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:21:22 +0100
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
Subject: Re: [PATCH 03/13] clocksource/arm_arch_timer: Move system register
 timer programming over to CVAL
Message-ID: <20210824162122.GH96738@C02TD0UTHF1T.local>
References: <20210809152651.2297337-1-maz@kernel.org>
 <20210809152651.2297337-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809152651.2297337-4-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 04:26:41PM +0100, Marc Zyngier wrote:
> In order to cope better with high frequency counters, move the
> programming of the timers from the countdown timer (TVAL) over
> to the comparator (CVAL).
> 
> The programming model is slightly different, as we now need to
> read the current counter value to have an absolute deadline
> instead of a relative one.
> 
> There is a small overhead to this change, which we will address
> in the following patches.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Looks good, builds cleanly, and boots fine on both arm/arm64:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm/include/asm/arch_timer.h    | 14 ++++++++----
>  arch/arm64/include/asm/arch_timer.h  | 16 +++++++++-----
>  drivers/clocksource/arm_arch_timer.c | 32 +++++++++++++++++++++++++---
>  include/clocksource/arm_arch_timer.h |  1 +
>  4 files changed, 51 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 88075c7f4bfd..b48de9d26f27 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -31,18 +31,22 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
>  		case ARCH_TIMER_REG_CTRL:
>  			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
>  			break;
> -		case ARCH_TIMER_REG_TVAL:
> -			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" ((u32)val));
> +		case ARCH_TIMER_REG_CVAL:
> +			asm volatile("mcrr p15, 2, %Q0, %R0, c14" : : "r" (val));
>  			break;
> +		case ARCH_TIMER_REG_TVAL:
> +			BUG();
>  		}
>  	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
>  		switch (reg) {
>  		case ARCH_TIMER_REG_CTRL:
>  			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
>  			break;
> -		case ARCH_TIMER_REG_TVAL:
> -			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" ((u32)val));
> +		case ARCH_TIMER_REG_CVAL:
> +			asm volatile("mcrr p15, 3, %Q0, %R0, c14" : : "r" (val));
>  			break;
> +		case ARCH_TIMER_REG_TVAL:
> +			BUG();
>  		}
>  	}
>  
> @@ -60,6 +64,7 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>  			asm volatile("mrc p15, 0, %0, c14, c2, 1" : "=r" (val));
>  			break;
>  		case ARCH_TIMER_REG_TVAL:
> +		case ARCH_TIMER_REG_CVAL:
>  			BUG();
>  		}
>  	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
> @@ -68,6 +73,7 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>  			asm volatile("mrc p15, 0, %0, c14, c3, 1" : "=r" (val));
>  			break;
>  		case ARCH_TIMER_REG_TVAL:
> +		case ARCH_TIMER_REG_CVAL:
>  			BUG();
>  		}
>  	}
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 107afb721749..6ceb050ae7b9 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -96,18 +96,22 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
>  		case ARCH_TIMER_REG_CTRL:
>  			write_sysreg(val, cntp_ctl_el0);
>  			break;
> -		case ARCH_TIMER_REG_TVAL:
> -			write_sysreg(val, cntp_tval_el0);
> +		case ARCH_TIMER_REG_CVAL:
> +			write_sysreg(val, cntp_cval_el0);
>  			break;
> +		case ARCH_TIMER_REG_TVAL:
> +			BUG();
>  		}
>  	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
>  		switch (reg) {
>  		case ARCH_TIMER_REG_CTRL:
>  			write_sysreg(val, cntv_ctl_el0);
>  			break;
> -		case ARCH_TIMER_REG_TVAL:
> -			write_sysreg(val, cntv_tval_el0);
> +		case ARCH_TIMER_REG_CVAL:
> +			write_sysreg(val, cntv_cval_el0);
>  			break;
> +		case ARCH_TIMER_REG_TVAL:
> +			BUG();
>  		}
>  	}
>  
> @@ -115,13 +119,14 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
>  }
>  
>  static __always_inline
> -u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
> +u64 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>  {
>  	if (access == ARCH_TIMER_PHYS_ACCESS) {
>  		switch (reg) {
>  		case ARCH_TIMER_REG_CTRL:
>  			return read_sysreg(cntp_ctl_el0);
>  		case ARCH_TIMER_REG_TVAL:
> +		case ARCH_TIMER_REG_CVAL:
>  			break;
>  		}
>  	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
> @@ -129,6 +134,7 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>  		case ARCH_TIMER_REG_CTRL:
>  			return read_sysreg(cntv_ctl_el0);
>  		case ARCH_TIMER_REG_TVAL:
> +		case ARCH_TIMER_REG_CVAL:
>  			break;
>  		}
>  	}
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 0b2bac3ef7ce..898a07dc01cd 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -112,6 +112,8 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
>  		case ARCH_TIMER_REG_TVAL:
>  			writel_relaxed((u32)val, timer->base + CNTP_TVAL);
>  			break;
> +		case ARCH_TIMER_REG_CVAL:
> +			BUG();
>  		}
>  	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
>  		struct arch_timer *timer = to_arch_timer(clk);
> @@ -122,6 +124,8 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
>  		case ARCH_TIMER_REG_TVAL:
>  			writel_relaxed((u32)val, timer->base + CNTV_TVAL);
>  			break;
> +		case ARCH_TIMER_REG_CVAL:
> +			BUG();
>  		}
>  	} else {
>  		arch_timer_reg_write_cp15(access, reg, val);
> @@ -141,6 +145,7 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
>  			val = readl_relaxed(timer->base + CNTP_CTL);
>  			break;
>  		case ARCH_TIMER_REG_TVAL:
> +		case ARCH_TIMER_REG_CVAL:
>  			BUG();
>  		}
>  	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
> @@ -150,6 +155,7 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
>  			val = readl_relaxed(timer->base + CNTV_CTL);
>  			break;
>  		case ARCH_TIMER_REG_TVAL:
> +		case ARCH_TIMER_REG_CVAL:
>  			BUG();
>  		}
>  	} else {
> @@ -687,10 +693,18 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
>  					   struct clock_event_device *clk)
>  {
>  	unsigned long ctrl;
> +	u64 cnt;
> +
>  	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
>  	ctrl |= ARCH_TIMER_CTRL_ENABLE;
>  	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
> -	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
> +
> +	if (access == ARCH_TIMER_PHYS_ACCESS)
> +		cnt = __arch_counter_get_cntpct();
> +	else
> +		cnt = __arch_counter_get_cntvct();
> +
> +	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
>  	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
>  }
>  
> @@ -708,17 +722,29 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
>  	return 0;
>  }
>  
> +static __always_inline void set_next_event_mem(const int access, unsigned long evt,
> +					   struct clock_event_device *clk)
> +{
> +	unsigned long ctrl;
> +	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
> +	ctrl |= ARCH_TIMER_CTRL_ENABLE;
> +	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
> +
> +	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
> +	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
> +}
> +
>  static int arch_timer_set_next_event_virt_mem(unsigned long evt,
>  					      struct clock_event_device *clk)
>  {
> -	set_next_event(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
> +	set_next_event_mem(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
>  	return 0;
>  }
>  
>  static int arch_timer_set_next_event_phys_mem(unsigned long evt,
>  					      struct clock_event_device *clk)
>  {
> -	set_next_event(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
> +	set_next_event_mem(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
>  	return 0;
>  }
>  
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 73c7139c866f..d59537afb29d 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -25,6 +25,7 @@
>  enum arch_timer_reg {
>  	ARCH_TIMER_REG_CTRL,
>  	ARCH_TIMER_REG_TVAL,
> +	ARCH_TIMER_REG_CVAL,
>  };
>  
>  enum arch_timer_ppi_nr {
> -- 
> 2.30.2
> 
