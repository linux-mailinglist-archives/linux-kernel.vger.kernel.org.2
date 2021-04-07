Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB55B357774
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhDGWPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhDGWPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:15:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 680B361164;
        Wed,  7 Apr 2021 22:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617833700;
        bh=6yHO0EcEJrkJ9yf4S7m3SxFrbETpMHH35QKbv6IS1MQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2PK7tFYa/iF2/oZxUOFrpPKJ42P6j4PaET0uc1rMJ4MScMHGDwixiD6DUHAZrpoJ
         5gukJDGrHNebjUba1MCWMTFxCf6NRt0BxogOKXdq7DJBv/CoyPrHgsT6m5r0mY/1XF
         obPBh55nHK8nDBwj3+MgrDY+6n2O6cURhCkTL9TAVKRr0NVyPBZ0GDpEQde1A05wYs
         rQOWUYvEYq5RdNXTSwSkd87u9LmXa7ELmsGIB9yUSo0/9sg3XV0V6uAdI+SYzIggQw
         e9RkGbdrFmIcWaRTSfcnjhiqYoVDKMEZ64TtgVA9Djf6qyD6LP3kHSys6tXK82Vlpk
         /HvN3SqhxAafQ==
Date:   Thu, 8 Apr 2021 00:14:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH] hrtimer: avoid retrigger_next_event IPI
Message-ID: <20210407221457.GA56249@lothringen>
References: <20210407135301.GA16985@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407135301.GA16985@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:53:01AM -0300, Marcelo Tosatti wrote:
> 
> Setting the realtime clock triggers an IPI to all CPUs to reprogram
> hrtimers.
> 
> However, only base, boottime and tai clocks have their offsets updated
> (and therefore potentially require a reprogram).
> 
> If the CPU is a nohz_full one, check if it only has 
> monotonic active timers, and in that case update the 
> realtime base offsets, skipping the IPI.
> 
> This reduces interruptions to nohz_full CPUs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 743c852e10f2..b42b1a434b22 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -853,6 +853,28 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
>  	tick_program_event(expires, 1);
>  }
>  
> +#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME)|		\
> +			 (1U << HRTIMER_BASE_REALTIME_SOFT)|	\
> +			 (1U << HRTIMER_BASE_BOOTTIME)|		\
> +			 (1U << HRTIMER_BASE_BOOTTIME_SOFT)|	\
> +			 (1U << HRTIMER_BASE_TAI)|		\
> +			 (1U << HRTIMER_BASE_TAI_SOFT))
> +
> +static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
> +{
> +	unsigned int active = 0;
> +
> +	if (!cpu_base->softirq_activated)
> +		active = cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
> +
> +	active = active | (cpu_base->active_bases & HRTIMER_ACTIVE_HARD);
> +
> +	if ((active & CLOCK_SET_BASES) == 0)
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * Clock realtime was set
>   *
> @@ -867,9 +889,41 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
>  void clock_was_set(void)
>  {
>  #ifdef CONFIG_HIGH_RES_TIMERS
> -	/* Retrigger the CPU local events everywhere */
> -	on_each_cpu(retrigger_next_event, NULL, 1);
> +	cpumask_var_t mask;
> +	int cpu;
> +
> +	if (!tick_nohz_full_enabled()) {
> +		/* Retrigger the CPU local events everywhere */
> +		on_each_cpu(retrigger_next_event, NULL, 1);
> +		goto set_timerfd;
> +	}
> +
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
> +		on_each_cpu(retrigger_next_event, NULL, 1);
> +		goto set_timerfd;
> +	}
> +
> +	/* Avoid interrupting nohz_full CPUs if possible */
> +	preempt_disable();
> +	for_each_online_cpu(cpu) {
> +		if (tick_nohz_full_cpu(cpu)) {
> +			unsigned long flags;
> +			struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
> +
> +			raw_spin_lock_irqsave(&cpu_base->lock, flags);
> +			if (need_reprogram_timer(cpu_base))
> +				cpumask_set_cpu(cpu, mask);
> +			else
> +				hrtimer_update_base(cpu_base);
> +			raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
> +		}

You forgot to add the housekeeping CPUs to the mask.
As for the need_reprogram_timer() trick, I'll rather defer to Thomas review...

Thanks.

> +	}
> +
> +	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
> +	preempt_enable();
> +	free_cpumask_var(mask);
>  #endif
> +set_timerfd:
>  	timerfd_clock_was_set();
>  }
>  
> 
