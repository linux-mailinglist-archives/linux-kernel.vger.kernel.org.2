Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B6435F9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349715AbhDNRUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:20:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54090 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhDNRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:20:06 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618420784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJtu21/9foT+QNiwv3C3gjPou7M8V3FS1zdC8cROlQo=;
        b=K+tRj/Nx3upTDelOmH/DdHFlb2DXXGnU/l4qDG3EMuq4NNgZFN0LL/1OhrotxXHg8MjCcE
        T2ILNN3buva3TEos4phTCQlSAGANbK/Xv8EbRGwHSdn5C4FN48FWjMRNuMoO+Pnwq2gSRZ
        aPu+yISC1ofcwkH23MrCalB4ooHhvIkiF0up6ptFhK9WJovMSKfUX+NqSC9S03Sc19IfdD
        JFxYFJUlhe3W8d3iykBuzW+tfU38swZDT/j8IVTAyOvmjx95Vr3C6YSsWR63tfNh8WM3N0
        Ai2wbLwqAN/aT5tjaQYKt5Hp5yxMlIli9ujr70abv6LxiXF7nNn1GaK9VjC5Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618420784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJtu21/9foT+QNiwv3C3gjPou7M8V3FS1zdC8cROlQo=;
        b=Ab/uSholFzHpg20UZMZoIq3f53CtBdvcYSuzlj0MEt3GWp5TkAeci0sdmkvOZWa71nkIFD
        k1lS52SXXectlEBQ==
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH v2] hrtimer: avoid retrigger_next_event IPI
In-Reply-To: <20210413170431.GA16190@fuller.cnet>
References: <20210407135301.GA16985@fuller.cnet> <87o8en4k9a.ffs@nanos.tec.linutronix.de> <20210409165146.GA40118@fuller.cnet> <87lf9q4lue.ffs@nanos.tec.linutronix.de> <20210413170431.GA16190@fuller.cnet>
Date:   Wed, 14 Apr 2021 19:19:43 +0200
Message-ID: <874kg8wzps.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

On Tue, Apr 13 2021 at 14:04, Marcelo Tosatti wrote:
> Setting the realtime clock triggers an IPI to all CPUs to reprogram
> hrtimers.

s/hrtimers/clock event device/

> However, only realtime and TAI clocks have their offsets updated
> (and therefore potentially require a reprogram).
>
> Check if it only has monotonic active timers, and in that case

boottime != monotonic 

> update the realtime and TAI base offsets remotely, skipping the IPI.

Something like this perhaps:

Instead of sending an IPI unconditionally, check each per CPU hrtimer base
whether it has active timers in the CLOCK_REALTIME and CLOCK_TAI bases. If
that's not the case, update the realtime and TAI base offsets remotely and
skip the IPI. This ensures that any subsequently armed timers on
CLOCK_REALTIME and CLOCK_TAI are evaluated with the correct offsets.

Hmm?

> +#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME)|		\

Missing space between ) and |

> +			 (1U << HRTIMER_BASE_REALTIME_SOFT)|	\
> +			 (1U << HRTIMER_BASE_TAI)|		\
> +			 (1U << HRTIMER_BASE_TAI_SOFT))
> +
> +static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
> +{
> +	unsigned int active = 0;
> +
> +	if (cpu_base->softirq_activated)
> +		return true;
> +
> +	active = cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
> +
> +	active = active | (cpu_base->active_bases & HRTIMER_ACTIVE_HARD);
> +
> +	if ((active & CLOCK_SET_BASES) == 0)
> +		return false;
> +
> +	return true;

That's a pretty elaborate way of writing:

       return (cpu_base->active_bases & CLOCK_SET_BASES) != 0;

> +}
> +
>  /*
>   * Clock realtime was set
>   *
> @@ -885,9 +907,31 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
>  void clock_was_set(void)
>  {
>  #ifdef CONFIG_HIGH_RES_TIMERS
> -	/* Retrigger the CPU local events everywhere */
> -	on_each_cpu(retrigger_next_event, NULL, 1);
> +	cpumask_var_t mask;
> +	int cpu;
> +
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
> +		on_each_cpu(retrigger_next_event, NULL, 1);
> +		goto set_timerfd;
> +	}
> +
> +	/* Avoid interrupting CPUs if possible */
> +	preempt_disable();

That preempt disable is only required around the function call, for the
loop cpus_read_lock() is sufficient.

> +	for_each_online_cpu(cpu) {
> +		unsigned long flags;
> +		struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
> +
> +		raw_spin_lock_irqsave(&cpu_base->lock, flags);
> +		if (need_reprogram_timer(cpu_base))
> +			cpumask_set_cpu(cpu, mask);
> +		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
> +	}
> +
> +	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
> +	preempt_enable();
> +	free_cpumask_var(mask);
>  #endif
> +set_timerfd:

My brain compiler tells me that with CONFIG_HIGH_RES_TIMERS=n a real
compiler will emit a warning about a defined, but unused label....

>  	timerfd_clock_was_set();
>  }

Thanks,

        tglx
