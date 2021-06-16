Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC343A9675
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhFPJpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhFPJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:45:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3311C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mKRc1y/P+X61Ogjm9y7IPEFP1KueDHKwUkfB9qoQQik=; b=NOhC3iyyqCEFexx3wjGkWXt/dk
        uYeJqL4qcPird6JzLMxkQFlXgfziz+Y/7f0crEcJ3pHzF86JUR6OS6R5g7B172+5hk63XDkGi1+ka
        fZenUV9qgs+OAaUFS0qeSWbObzk9p/eko3w3UnPu2HrHxe9Lc+TgOT+OddjtZlJfnox87WVneJaR7
        bola7YJeN4HKEjwkKSijFS7ukmweNFC7y8G0ki2L80j/zc3KjKgWucpFFL0cB3ABS3YLq4JHGEROk
        xd8ruCqmf0aEyGXL1KyreYE6whSWfqfMlRZZHHxRJ3A+hsh325otAm3reOJg1Pgo+V8UemDN7VaOk
        BK2H+UKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltS4U-007s0r-Ui; Wed, 16 Jun 2021 09:43:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C57AC300269;
        Wed, 16 Jun 2021 11:42:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A853220C169EB; Wed, 16 Jun 2021 11:42:53 +0200 (CEST)
Date:   Wed, 16 Jun 2021 11:42:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 5/6] posix-cpu-timers: Force next expiration recalc after
 early timer firing
Message-ID: <YMnHnUcufPhtnDZP@hirez.programming.kicks-ass.net>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-6-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604113159.26177-6-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:31:58PM +0200, Frederic Weisbecker wrote:
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index 0b5715c8db04..d8325a906314 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -405,6 +405,21 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
>  	return 0;
>  }
>  
> +static void __disarm_timer(struct k_itimer *timer, struct task_struct *p,
> +			   u64 old_expires)
> +{
> +	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
> +	struct posix_cputimer_base *base;
> +
> +	if (CPUCLOCK_PERTHREAD(timer->it_clock))
> +		base = p->posix_cputimers.bases + clkidx;
> +	else
> +		base = p->signal->posix_cputimers.bases + clkidx;
> +
> +	if (old_expires == base->nextevt)
> +		base->nextevt = 0;
> +}
> +
>  /*
>   * Dequeue the timer and reset the base if it was its earliest expiration.
>   * It makes sure the next tick recalculates the base next expiration so we
> @@ -415,24 +430,14 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
>  {
>  	struct cpu_timer *ctmr = &timer->it.cpu;
>  	u64 old_expires = cpu_timer_getexpires(ctmr);
> -	struct posix_cputimer_base *base;
>  	bool queued;
> -	int clkidx;
>  
>  	queued = cpu_timer_dequeue(ctmr);
>  	cpu_timer_setexpires(ctmr, 0);
>  	if (!queued)
>  		return;
>  
> -	clkidx = CPUCLOCK_WHICH(timer->it_clock);
> -
> -	if (CPUCLOCK_PERTHREAD(timer->it_clock))
> -		base = p->posix_cputimers.bases + clkidx;
> -	else
> -		base = p->signal->posix_cputimers.bases + clkidx;
> -
> -	if (old_expires == base->nextevt)
> -		base->nextevt = 0;
> +	__disarm_timer(timer, p, old_expires);
>  }
>  
>  
> @@ -686,8 +691,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
>  			u64 exp = bump_cpu_timer(timer, val);
>  
>  			if (val < exp) {
> -				old_expires = exp - val;
> -				old->it_value = ns_to_timespec64(old_expires);
> +				old->it_value = ns_to_timespec64(exp - val);
>  			} else {
>  				old->it_value.tv_nsec = 1;
>  				old->it_value.tv_sec = 0;
> @@ -748,9 +752,28 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
>  		 * accumulate more time on this clock.
>  		 */
>  		cpu_timer_fire(timer);
> +
> +		sighand = lock_task_sighand(p, &flags);
> +		if (sighand == NULL)
> +			goto out;
> +		if (!cpu_timer_queued(&timer->it.cpu)) {
> +			/*
> +			 * Disarm the previous timer to deactivate the tick
> +			 * dependency and process wide cputime counter if
> +			 * necessary.
> +			 */
> +			__disarm_timer(timer, p, old_expires);
> +			/*
> +			 * If the previous timer was deactivated, we might have
> +			 * just started the process wide cputime counter. Make
> +			 * sure we poke the tick to deactivate it then.
> +			 */
> +			if (!old_expires && !CPUCLOCK_PERTHREAD(timer->it_clock))
> +				p->signal->posix_cputimers.bases[clkid].nextevt = 0;
> +		}
> +		unlock_task_sighand(p, &flags);
>  	}

I'm thinking this is a better fix than patch #2. AFAICT you can now go
back to unconditionally doing start, and then if we fire it early, we'll
disarm the thing.

That would avoid the disconnect between the start condition and the fire
condition.

Hmm?


