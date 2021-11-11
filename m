Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D82844D87D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 15:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhKKOqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 09:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhKKOqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:46:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D489F61207;
        Thu, 11 Nov 2021 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636641791;
        bh=+QfbjmwlSImP2CtzsMwsd73wLPgprw33rB7JGCA9H+w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J+6dGjLhu4enVAcNzV4CIRC3gXzjx1ET/ih73xxG1g350/MP0ZZMOFTZvBSgUM18G
         wslNyNlL1mOS8tQT9a833udR/u54th7coU6KyFnD3ZcYuvUMWTsM8/sYNW9k5VqiRE
         SV3j4XrXGm9O0Rx/xG2VbI54tQFVaqLrrNlGmLGo4Bpm59pJA2ivxOsXSEBeMEl+Qo
         +GIbwozLUYZB/iEYzROaveQ0cS0WbNZgGxrSUlCfwIe//lcACkpbECf1BVicqHSH1W
         4eHYSqbAuy2RR+MNDwxwyT/jvSVR89FUtznCuW3jK6TF/fs07zurFiR3dZ1yrK+R/c
         4jAAcffFqJYZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9CA505C06AF; Thu, 11 Nov 2021 06:43:11 -0800 (PST)
Date:   Thu, 11 Nov 2021 06:43:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/2] clocksource: Avoid accidental unstable marking of
 clocksources
Message-ID: <20211111144311.GK641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211110221732.272986-1-longman@redhat.com>
 <20211110221732.272986-2-longman@redhat.com>
 <20211111045703.GA15896@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111045703.GA15896@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 12:57:03PM +0800, Feng Tang wrote:
> On Wed, Nov 10, 2021 at 05:17:31PM -0500, Waiman Long wrote:
> > Since commit db3a34e17433 ("clocksource: Retry clock read if long delays
> > detected") and commit 2e27e793e280 ("clocksource: Reduce clocksource-skew
> > threshold"), it is found that tsc clocksource fallback to hpet can
> > sometimes happen on both Intel and AMD systems especially when they are
> > running stressful benchmarking workloads. Of the 23 systems tested with
> > a v5.14 kernel, 10 of them have switched to hpet clock source during
> > the test run.
> > 
> > The result of falling back to hpet is a drastic reduction of performance
> > when running benchmarks. For example, the fio performance tests can
> > drop up to 70% whereas the iperf3 performance can drop up to 80%.
> > 
> > 4 hpet fallbacks happened during bootup. They were:
> > 
> >   [    8.749399] clocksource: timekeeping watchdog on CPU13: hpet read-back delay of 263750ns, attempt 4, marking unstable
> >   [   12.044610] clocksource: timekeeping watchdog on CPU19: hpet read-back delay of 186166ns, attempt 4, marking unstable
> >   [   17.336941] clocksource: timekeeping watchdog on CPU28: hpet read-back delay of 182291ns, attempt 4, marking unstable
> >   [   17.518565] clocksource: timekeeping watchdog on CPU34: hpet read-back delay of 252196ns, attempt 4, marking unstable
> > 
> > Other fallbacks happen when the systems were running stressful
> > benchmarks. For example:
> > 
> >   [ 2685.867873] clocksource: timekeeping watchdog on CPU117: hpet read-back delay of 57269ns, attempt 4, marking unstable
> >   [46215.471228] clocksource: timekeeping watchdog on CPU8: hpet read-back delay of 61460ns, attempt 4, marking unstable
> > 
> > Commit 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold"),
> > changed the skew margin from 100us to 50us. I think this is too small
> > and can easily be exceeded when running some stressful workloads on
> > a thermally stressed system.  So it is switched back to 100us. On
> > the other hand, it doesn't look like we need to increase the minimum
> > uncertainty margin. So it is kept the same at 100us too.
> > 
> > Even a maximum skew margin of 100us may be too small in for some systems
> > when booting up especially if those systems are under thermal stress. To
> > eliminate the case that the large skew is due to the system being too
> > busy slowing down the reading of both the watchdog and the clocksource,
> > a final check is done by reading watchdog time again and comparing the
> > consecutive watchdog timing read delay against WATCHDOG_MAX_SKEW/2. If
> > that delay exceeds the limit, we assume that the system is just too
> > busy. A warning will be printed to the console and the watchdog check
> > is then skipped for this round. For example:
> > 
> >   [    8.789316] clocksource: timekeeping watchdog on CPU13: hpet consecutive read-back delay of 174541ns, system too busy
>  
> 
> I think it may be better to add more details about the root cause, other
> than that it looks good to me, as we tested similar patch on our test
> platforms.
> 
> Reviewed-by: Feng Tang <feng.tang@intel.com>

Thank you both!

I agree on the bit about root cause.  Would it make sense to compare the
difference between HPET reads 1 and 2 (containing the read of the TSC)
and the difference between HPET reads 2 and 3?  If the 2-1 difference was
no more than (say) 8/7ths of the 3-2 difference, or the 2-1 difference
was no more than (say) 20 microseconds more than the 3-2 difference,
this could be considered a good-as-it-gets read, ending the retry loop.
Then if the 3-1 difference was greater than the default (100 microseconds
in current -rcu), that difference could be substituted for that particular
clocksource watchdog check.  With a console message noting the unusually
high overhead (but not a splat).

So if it took 75 microseconds for each HPET read and 1 microsecond for
the TSC read, then 226 microseconds would be substituted for the default
of 100 microseconds for that cycle's skew cutoff.  Unless the previous
skew cutoff was larger, in which case the previous cutoff should be
used instead.  Either way, the current cutoff is recorded for comparison
for the next clocksource watchdog check.

If the 3-1 difference was greater than 62.5 milliseconds, a warning should
probably be emitted anyway.

Or did you have something else in mind?

							Thanx, Paul

> Thanks,
> Feng
> 
> > Fixes: db3a34e17433 ("clocksource: Retry clock read if long delays detected")
> > Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >  kernel/time/clocksource.c | 53 +++++++++++++++++++++++++++++----------
> >  1 file changed, 40 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index b8a14d2fb5ba..c503f5ab4101 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -107,7 +107,7 @@ static u64 suspend_start;
> >   * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
> >   * a lower bound for cs->uncertainty_margin values when registering clocks.
> >   */
> > -#define WATCHDOG_MAX_SKEW (50 * NSEC_PER_USEC)
> > +#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
> >  
> >  #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
> >  static void clocksource_watchdog_work(struct work_struct *work);
> > @@ -205,11 +205,17 @@ EXPORT_SYMBOL_GPL(max_cswd_read_retries);
> >  static int verify_n_cpus = 8;
> >  module_param(verify_n_cpus, int, 0644);
> >  
> > -static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> > +enum wd_read_status {
> > +	WD_READ_SUCCESS,
> > +	WD_READ_UNSTABLE,
> > +	WD_READ_SKIP
> > +};
> > +
> > +static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> >  {
> >  	unsigned int nretries;
> > -	u64 wd_end, wd_delta;
> > -	int64_t wd_delay;
> > +	u64 wd_end, wd_end2, wd_delta;
> > +	int64_t wd_delay, wd_delay2;
> >  
> >  	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
> >  		local_irq_disable();
> > @@ -226,13 +232,30 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> >  				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
> >  					smp_processor_id(), watchdog->name, nretries);
> >  			}
> > -			return true;
> > +			return WD_READ_SUCCESS;
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Now compute delay in consecutive watchdog read to see if there is
> > +	 * too much external interferences that cause significant delay in
> > +	 * reading both clocksource and watchdog.
> > +	 *
> > +	 * If the consecutive watchdog read-back delay > WATCHDOG_MAX_SKEW/2,
> > +	 * report system busy and skip the current watchdog test.
> > +	 */
> > +	wd_end2 = watchdog->read(watchdog);
> > +	wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
> > +	wd_delay2 = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
> > +	if (wd_delay2 > WATCHDOG_MAX_SKEW/2) {
> > +		pr_warn("timekeeping watchdog on CPU%d: %s consecutive read-back delay of %lldns, system too busy\n",
> > +			smp_processor_id(), watchdog->name, wd_delay2);
> > +		return WD_READ_SKIP;
> > +	}
> > +
> >  	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
> >  		smp_processor_id(), watchdog->name, wd_delay, nretries);
> > -	return false;
> > +	return WD_READ_UNSTABLE;
> >  }
> >  
> >  static u64 csnow_mid;
> > @@ -356,6 +379,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  	int next_cpu, reset_pending;
> >  	int64_t wd_nsec, cs_nsec;
> >  	struct clocksource *cs;
> > +	enum wd_read_status read_ret;
> >  	u32 md;
> >  
> >  	spin_lock(&watchdog_lock);
> > @@ -373,9 +397,12 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  			continue;
> >  		}
> >  
> > -		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
> > -			/* Clock readout unreliable, so give it up. */
> > -			__clocksource_unstable(cs);
> > +		read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
> > +
> > +		if (read_ret != WD_READ_SUCCESS) {
> > +			if (read_ret == WD_READ_UNSTABLE)
> > +				/* Clock readout unreliable, so give it up. */
> > +				__clocksource_unstable(cs);
> >  			continue;
> >  		}
> >  
> > @@ -1061,7 +1088,7 @@ void __clocksource_update_freq_scale(struct clocksource *cs, u32 scale, u32 freq
> >  	/*
> >  	 * If the uncertainty margin is not specified, calculate it.
> >  	 * If both scale and freq are non-zero, calculate the clock
> > -	 * period, but bound below at 2*WATCHDOG_MAX_SKEW.  However,
> > +	 * period, but bound below at WATCHDOG_MAX_SKEW.  However,
> >  	 * if either of scale or freq is zero, be very conservative and
> >  	 * take the tens-of-milliseconds WATCHDOG_THRESHOLD value for the
> >  	 * uncertainty margin.  Allow stupidly small uncertainty margins
> > @@ -1070,12 +1097,12 @@ void __clocksource_update_freq_scale(struct clocksource *cs, u32 scale, u32 freq
> >  	 */
> >  	if (scale && freq && !cs->uncertainty_margin) {
> >  		cs->uncertainty_margin = NSEC_PER_SEC / (scale * freq);
> > -		if (cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW)
> > -			cs->uncertainty_margin = 2 * WATCHDOG_MAX_SKEW;
> > +		if (cs->uncertainty_margin < WATCHDOG_MAX_SKEW)
> > +			cs->uncertainty_margin = WATCHDOG_MAX_SKEW;
> >  	} else if (!cs->uncertainty_margin) {
> >  		cs->uncertainty_margin = WATCHDOG_THRESHOLD;
> >  	}
> > -	WARN_ON_ONCE(cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW);
> > +	WARN_ON_ONCE(cs->uncertainty_margin < WATCHDOG_MAX_SKEW);
> >  
> >  	/*
> >  	 * Ensure clocksources that have large 'mult' values don't overflow
> > -- 
> > 2.27.0
