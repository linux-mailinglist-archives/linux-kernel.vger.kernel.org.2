Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40431363298
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 01:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhDQWyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 18:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237088AbhDQWyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 18:54:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A85A6120A;
        Sat, 17 Apr 2021 22:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618700049;
        bh=uhpJRyAuxZotjTFThMVL1OEB1IVrkujn2YS0pSsG2mA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TmKROW3Nr3limwhrBPETF0zXjv+p4yG8D55EFZYvrSBChn654qm9103qGvOB6jiIt
         tukgykWzOmAwtmQGWzZxAo6JOnvsul8Bgwfl7ucCxYS5zdYNqpuOlNpkccfannhZ5n
         IntV8ivjyTcQ4sPp1KYOAUIo+M7yB6+HxLV4Qe4RozYb+MSQIuPFAXs50+nfSY4Hh1
         zf80C2IfIdbIqPQIBPBQvy9CvO+okVRHzQ7mGMBbksMLPwcSPe+xsHRQystzy1KdmN
         OmCZvhXjeAg/OQ27yVziwEZrWQ8b9sKsGxQchS/5fHBpWTYqcmC4/mahxVOxuuPBPQ
         x7fSeGNuD4xhw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 26FF05C051E; Sat, 17 Apr 2021 15:54:09 -0700 (PDT)
Date:   Sat, 17 Apr 2021 15:54:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 2/5] clocksource: Retry clock read if long
 delays detected
Message-ID: <20210417225409.GA5006@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
 <20210414043602.2812981-2-paulmck@kernel.org>
 <87y2dhrte0.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2dhrte0.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 02:24:23PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 13 2021 at 21:35, Paul E. McKenney wrote:
> >  #define WATCHDOG_INTERVAL (HZ >> 1)
> >  #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
> > +#define WATCHDOG_MAX_SKEW (NSEC_PER_SEC >> 6)
> 
> That's ~15ms which is a tad large I'd say...

And I have a separate patch queued to crank this down to 125us.

I ran 2,664 hours of rcutorture on this patch, and saw only 18 instances
of delay detected.  So 125us works well, but I am not inclined to decrease
it much.

I will try 50us this evening though, just for grins.  After all, only
those who have gone too far can possibly tell you how far you can go.

> >  static void clocksource_watchdog_work(struct work_struct *work)
> >  {
> > @@ -213,9 +214,10 @@ static void clocksource_watchdog_inject_delay(void)
> >  static void clocksource_watchdog(struct timer_list *unused)
> >  {
> >  	struct clocksource *cs;
> > -	u64 csnow, wdnow, cslast, wdlast, delta;
> > -	int64_t wd_nsec, cs_nsec;
> > +	u64 csnow, wdnow, wdagain, cslast, wdlast, delta;
> > +	int64_t wd_nsec, wdagain_delta, wderr_nsec = 0, cs_nsec;
> >  	int next_cpu, reset_pending;
> > +	int nretries;
> >  
> >  	spin_lock(&watchdog_lock);
> >  	if (!watchdog_running)
> > @@ -224,6 +226,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  	reset_pending = atomic_read(&watchdog_reset_pending);
> >  
> >  	list_for_each_entry(cs, &watchdog_list, wd_list) {
> > +		nretries = 0;
> >  
> >  		/* Clocksource already marked unstable? */
> >  		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
> > @@ -232,11 +235,24 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  			continue;
> >  		}
> >  
> > +retry:
> >  		local_irq_disable();
> > -		csnow = cs->read(cs);
> > -		clocksource_watchdog_inject_delay();
> >  		wdnow = watchdog->read(watchdog);
> > +		clocksource_watchdog_inject_delay();
> > +		csnow = cs->read(cs);
> > +		wdagain = watchdog->read(watchdog);
> >  		local_irq_enable();
> > +		delta = clocksource_delta(wdagain, wdnow, watchdog->mask);
> > +		wdagain_delta = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> > +		if (wdagain_delta > WATCHDOG_MAX_SKEW) {
> > +			wderr_nsec = wdagain_delta;
> > +			if (nretries++ < max_read_retries)
> > +				goto retry;
> > +		}
> > +		if (nretries) {
> > +			pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d\n",
> > +				smp_processor_id(), watchdog->name, wderr_nsec, nretries);
> > +		}
> >  
> >  		/* Clocksource initialized ? */
> >  		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
> 
> This can nicely be split out into a read function which avoids brain
> overload when reading. Something like the uncompiled below.

Good point, done, with minor adjustments.

> I so wish we could just delete all of this horror instead of making it
> more horrible.

Revisit deleting it in five years if there are no issues, whatever
"issue" might mean in this context?  Five years should give time for
this to propagate to the enterprise distros.

							Thanx, Paul

> Thanks,
> 
>         tglx
> ---
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -124,6 +124,12 @@ static void __clocksource_change_rating(
>  #define WATCHDOG_INTERVAL (HZ >> 1)
>  #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
>  
> +/*
> + * The maximum delay between two consecutive readouts of the watchdog
> + * clocksource to detect SMI,NMI,vCPU preemption.
> + */
> +#define WATCHDOG_MAX_DELAY (100 * NSEC_PER_USEC)
> +
>  static void clocksource_watchdog_work(struct work_struct *work)
>  {
>  	/*
> @@ -184,12 +190,37 @@ void clocksource_mark_unstable(struct cl
>  	spin_unlock_irqrestore(&watchdog_lock, flags);
>  }
>  
> +static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> +{
> +	unsigned int nretries;
> +	u64 wd_end, wd_delta;
> +	int64_t wd_delay;
> +
> +	for (nretries = 0; nretries < max_read_retries; nretries++) {
> +		local_irq_disable();
> +		*wdnow = watchdog->read(watchdog);
> +		clocksource_watchdog_inject_delay();
> +		*csnow = cs->read(cs);
> +		wd_end = watchdog->read(watchdog);
> +		local_irq_enable();
> +
> +		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
> +		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
> +		if (wd_delay < WATCHDOG_MAX_DELAY)
> +			return true;
> +	}
> +
> +	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, %d attempts\n",
> +		smp_processor_id(), watchdog->name, wd_delay, nretries);
> +	return false;
> +}
> +
>  static void clocksource_watchdog(struct timer_list *unused)
>  {
> -	struct clocksource *cs;
>  	u64 csnow, wdnow, cslast, wdlast, delta;
> -	int64_t wd_nsec, cs_nsec;
>  	int next_cpu, reset_pending;
> +	int64_t wd_nsec, cs_nsec;
> +	struct clocksource *cs;
>  
>  	spin_lock(&watchdog_lock);
>  	if (!watchdog_running)
> @@ -206,10 +237,14 @@ static void clocksource_watchdog(struct
>  			continue;
>  		}
>  
> -		local_irq_disable();
> -		csnow = cs->read(cs);
> -		wdnow = watchdog->read(watchdog);
> -		local_irq_enable();
> +		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
> +			/*
> +			 * No point to continue if the watchdog readout is
> +			 * unreliable.
> +			 */
> +			__clocksource_unstable(cs);
> +			continue;
> +		}
>  
>  		/* Clocksource initialized ? */
>  		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
