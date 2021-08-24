Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB603F629C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhHXQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:21:44 -0400
Received: from foss.arm.com ([217.140.110.172]:37894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhHXQVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:21:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B745431B;
        Tue, 24 Aug 2021 09:20:58 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.90.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8BDB3F766;
        Tue, 24 Aug 2021 09:20:56 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:20:54 +0100
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
Subject: Re: [PATCH 02/13] clocksource/arm_arch_timer: Extend write side of
 timer register accessors to u64
Message-ID: <20210824162054.GG96738@C02TD0UTHF1T.local>
References: <20210809152651.2297337-1-maz@kernel.org>
 <20210809152651.2297337-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809152651.2297337-3-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 04:26:40PM +0100, Marc Zyngier wrote:
> The various accessors for the timer sysreg and MMIO registers are
> currently hardwired to 32bit. However, we are about to introduce
> the use of the CVAL registers, which require a 64bit access.
> 
> Upgrade the write side of the accessors to take a 64bit value
> (the read side is left untouched as we don't plan to ever read
> back any of these registers).
> 
> No functional change expected.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Looks good, builds cleanly, and boots fine on both arm/arm64:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm/include/asm/arch_timer.h    | 10 +++++-----
>  arch/arm64/include/asm/arch_timer.h  |  2 +-
>  drivers/clocksource/arm_arch_timer.c | 10 +++++-----
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 0c09afaa590d..88075c7f4bfd 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -24,24 +24,24 @@ int arch_timer_arch_init(void);
>   * the code. At least it does so with a recent GCC (4.6.3).
>   */
>  static __always_inline
> -void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
> +void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
>  {
>  	if (access == ARCH_TIMER_PHYS_ACCESS) {
>  		switch (reg) {
>  		case ARCH_TIMER_REG_CTRL:
> -			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" (val));
> +			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
>  			break;
>  		case ARCH_TIMER_REG_TVAL:
> -			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" (val));
> +			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" ((u32)val));
>  			break;
>  		}
>  	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
>  		switch (reg) {
>  		case ARCH_TIMER_REG_CTRL:
> -			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" (val));
> +			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
>  			break;
>  		case ARCH_TIMER_REG_TVAL:
> -			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" (val));
> +			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" ((u32)val));
>  			break;
>  		}
>  	}
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 8e3b2ac60c30..107afb721749 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -89,7 +89,7 @@ static inline notrace u64 arch_timer_read_cntvct_el0(void)
>   * the code.
>   */
>  static __always_inline
> -void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
> +void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
>  {
>  	if (access == ARCH_TIMER_PHYS_ACCESS) {
>  		switch (reg) {
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9db5c16e31e7..0b2bac3ef7ce 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -100,27 +100,27 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
>   */
>  
>  static __always_inline
> -void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
> +void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
>  			  struct clock_event_device *clk)
>  {
>  	if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
>  		struct arch_timer *timer = to_arch_timer(clk);
>  		switch (reg) {
>  		case ARCH_TIMER_REG_CTRL:
> -			writel_relaxed(val, timer->base + CNTP_CTL);
> +			writel_relaxed((u32)val, timer->base + CNTP_CTL);
>  			break;
>  		case ARCH_TIMER_REG_TVAL:
> -			writel_relaxed(val, timer->base + CNTP_TVAL);
> +			writel_relaxed((u32)val, timer->base + CNTP_TVAL);
>  			break;
>  		}
>  	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
>  		struct arch_timer *timer = to_arch_timer(clk);
>  		switch (reg) {
>  		case ARCH_TIMER_REG_CTRL:
> -			writel_relaxed(val, timer->base + CNTV_CTL);
> +			writel_relaxed((u32)val, timer->base + CNTV_CTL);
>  			break;
>  		case ARCH_TIMER_REG_TVAL:
> -			writel_relaxed(val, timer->base + CNTV_TVAL);
> +			writel_relaxed((u32)val, timer->base + CNTV_TVAL);
>  			break;
>  		}
>  	} else {
> -- 
> 2.30.2
> 
