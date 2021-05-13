Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F237FA26
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhEMPBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhEMPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:01:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17440C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LCAxmDDo6ECYenb0y1m9OqhwJCS/EudtX9JMHrl7HEA=; b=KgN6JzSN01wVfT8TzKCcYujMMC
        9A5ZnihIS0/dZwdh7mhJSMVbBDVYNOe11Q8zYqIFmT3b00faCS4OKvGsUI4ajUw5E1BWAtr8Lt4NY
        OBbgzaKpTV9TAPXniNBzjIpZvGvHDoykaXva6q9IQns9eSYLtq8jKVVBHfRpASY/IWO03cm60tvpO
        KDVDa2sQXYevN5PxludyLg39qZyQ4kc2vD496Hns56aeTHWGafjLID26wObRAPY2F6esN2hY+cRKY
        T0l2jHXqQHBdnoYhrpflEeVks21HTjlaY3UWBu5oZfU2c9DNPeSdJJcjVW99bJjaJDi4dgvWUnU5h
        sxOUCl0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhCod-005os1-NL; Thu, 13 May 2021 14:59:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 854173001E1;
        Thu, 13 May 2021 16:59:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 717C42D8C548F; Thu, 13 May 2021 16:59:54 +0200 (CEST)
Date:   Thu, 13 May 2021 16:59:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch 7/8] hrtimer: Avoid unnecessary SMP function calls in
 clock_was_set()
Message-ID: <YJ0+6vfkC+LTPkkw@hirez.programming.kicks-ass.net>
References: <20210427082537.611978720@linutronix.de>
 <20210427083724.732437214@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427083724.732437214@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 10:25:44AM +0200, Thomas Gleixner wrote:
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -896,11 +896,42 @@ static void hrtimer_reprogram(struct hrt
>   */
>  void clock_was_set(unsigned int bases)
>  {
> +	cpumask_var_t mask;
> +	int cpu;
> +
>  	if (!hrtimer_hres_active() && !tick_nohz_active)
>  		goto out_timerfd;
>  
> -	/* Retrigger the CPU local events everywhere */
> -	on_each_cpu(retrigger_next_event, NULL, 1);
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
> +		on_each_cpu(retrigger_next_event, NULL, 1);

This will violate NOHZ_FULL;

> +		goto out_timerfd;
> +	}
> +
> +	/* Avoid interrupting CPUs if possible */
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
> +		unsigned long flags;
> +
> +		raw_spin_lock_irqsave(&cpu_base->lock, flags);
> +		/*
> +		 * Only send the IPI when there are timers queued in one of
> +		 * the affected clock bases. Otherwise update the base
> +		 * remote to ensure that the next enqueue of a timer on
> +		 * such a clock base will see the correct offsets.
> +		 */
> +		if (cpu_base->active_bases & bases)
> +			cpumask_set_cpu(cpu, mask);
> +		else
> +			hrtimer_update_base(cpu_base);
> +		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
> +	}
> +
> +	preempt_disable();
> +	smp_call_function_many(mask, retrigger_next_event, NULL, 1);

The sane option is:

	smp_call_function_many_cond(cpu_online_mask, retrigger_next_event,
				    NULL, SCF_WAIT, update_needs_ipi);

Which does all of the above, but better.


> +	preempt_enable();
> +	cpus_read_unlock();
> +	free_cpumask_var(mask);
>  
>  out_timerfd:
>  	timerfd_clock_was_set();
> 
