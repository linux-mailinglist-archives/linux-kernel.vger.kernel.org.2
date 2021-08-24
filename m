Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EB63F62AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhHXQan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:30:43 -0400
Received: from foss.arm.com ([217.140.110.172]:38020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhHXQan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:30:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 965D731B;
        Tue, 24 Aug 2021 09:29:58 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.90.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5710F3F766;
        Tue, 24 Aug 2021 09:29:56 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:29:53 +0100
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
Subject: Re: [PATCH 04/13] clocksource/arm_arch_timer: Move drop _tval from
 erratum function names
Message-ID: <20210824162953.GI96738@C02TD0UTHF1T.local>
References: <20210809152651.2297337-1-maz@kernel.org>
 <20210809152651.2297337-5-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809152651.2297337-5-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 04:26:42PM +0100, Marc Zyngier wrote:
> The '_tval' name in the erratum handling function names doesn't
> make much sense anymore (and they were using CVAL the first place).
> 
> Drop the _tval tag.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Looks good, builds cleanly, and boots fine on both arm/arm64:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 898a07dc01cd..160464f75017 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -371,7 +371,7 @@ EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
>  
>  static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
>  
> -static void erratum_set_next_event_tval_generic(const int access, unsigned long evt,
> +static void erratum_set_next_event_generic(const int access, unsigned long evt,
>  						struct clock_event_device *clk)
>  {
>  	unsigned long ctrl;
> @@ -392,17 +392,17 @@ static void erratum_set_next_event_tval_generic(const int access, unsigned long
>  	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
>  }
>  
> -static __maybe_unused int erratum_set_next_event_tval_virt(unsigned long evt,
> +static __maybe_unused int erratum_set_next_event_virt(unsigned long evt,
>  					    struct clock_event_device *clk)
>  {
> -	erratum_set_next_event_tval_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
> +	erratum_set_next_event_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
>  	return 0;
>  }
>  
> -static __maybe_unused int erratum_set_next_event_tval_phys(unsigned long evt,
> +static __maybe_unused int erratum_set_next_event_phys(unsigned long evt,
>  					    struct clock_event_device *clk)
>  {
> -	erratum_set_next_event_tval_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
> +	erratum_set_next_event_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
>  	return 0;
>  }
>  
> @@ -414,8 +414,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  		.desc = "Freescale erratum a005858",
>  		.read_cntpct_el0 = fsl_a008585_read_cntpct_el0,
>  		.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
> -		.set_next_event_phys = erratum_set_next_event_tval_phys,
> -		.set_next_event_virt = erratum_set_next_event_tval_virt,
> +		.set_next_event_phys = erratum_set_next_event_phys,
> +		.set_next_event_virt = erratum_set_next_event_virt,
>  	},
>  #endif
>  #ifdef CONFIG_HISILICON_ERRATUM_161010101
> @@ -425,8 +425,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  		.desc = "HiSilicon erratum 161010101",
>  		.read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
>  		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
> -		.set_next_event_phys = erratum_set_next_event_tval_phys,
> -		.set_next_event_virt = erratum_set_next_event_tval_virt,
> +		.set_next_event_phys = erratum_set_next_event_phys,
> +		.set_next_event_virt = erratum_set_next_event_virt,
>  	},
>  	{
>  		.match_type = ate_match_acpi_oem_info,
> @@ -434,8 +434,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  		.desc = "HiSilicon erratum 161010101",
>  		.read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
>  		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
> -		.set_next_event_phys = erratum_set_next_event_tval_phys,
> -		.set_next_event_virt = erratum_set_next_event_tval_virt,
> +		.set_next_event_phys = erratum_set_next_event_phys,
> +		.set_next_event_virt = erratum_set_next_event_virt,
>  	},
>  #endif
>  #ifdef CONFIG_ARM64_ERRATUM_858921
> @@ -454,8 +454,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  		.desc = "Allwinner erratum UNKNOWN1",
>  		.read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
>  		.read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
> -		.set_next_event_phys = erratum_set_next_event_tval_phys,
> -		.set_next_event_virt = erratum_set_next_event_tval_virt,
> +		.set_next_event_phys = erratum_set_next_event_phys,
> +		.set_next_event_virt = erratum_set_next_event_virt,
>  	},
>  #endif
>  #ifdef CONFIG_ARM64_ERRATUM_1418040
> -- 
> 2.30.2
> 
