Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC22636B5BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhDZP0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233919AbhDZP0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:26:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05D1C61396;
        Mon, 26 Apr 2021 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619450730;
        bh=z8sBKtTH9XsU/Y+TciCRxZQUbTCh1nmv68f/Vjlbxbg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uw2qP6wdKqvS003T8T2yFJ9sW7aZ8CXGH+vp3q322ciDYlCUeJE/S1f0MPrxF6xOj
         HDEvjy0HCdCMFq2CSLLL/bmdYtDBq+Rv10qiVHKfVhtsGwwJFTDQYCoSbtHbwZ3/9k
         pDVxI57Iy3ILfLzv6Bt9o1fnt5D/mYATdOF3RJxZxspvtzT86GVx3gORQAS0jFdux8
         iaskystrBQwIbxXbjjYX6tM+1NSSnB/wEoYzBDzflJv84TYi2hLgHsUFqP7e+9ddq/
         5FdLTXikUtZLoiY7nRfYY9/mpvciI82wy/5QH/KvkK6CFjE5LG3EMcL5sxgss4oL9I
         fkLgA/Xg8AXxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E4EC5C0121; Mon, 26 Apr 2021 08:25:29 -0700 (PDT)
Date:   Mon, 26 Apr 2021 08:25:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        zhengjun.xing@intel.com,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v10 clocksource 6/7] clocksource: Forgive tsc_early
 pre-calibration drift
Message-ID: <20210426152529.GX975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-6-paulmck@kernel.org>
 <20210426150127.GB23119@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426150127.GB23119@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:01:27PM +0800, Feng Tang wrote:
> Hi Paul,
> 
> On Sun, Apr 25, 2021 at 03:47:07PM -0700, Paul E. McKenney wrote:
> > Because the x86 tsc_early clocksource is given a quick and semi-accurate
> > calibration (by design!), it might have drift rates well in excess of
> > the 0.1% limit that is in the process of being adopted.
> > 
> > Therefore, add a max_drift field to the clocksource structure that, when
> > non-zero, specifies the maximum allowable drift rate in nanoseconds over
> > a half-second period.  The tsc_early clocksource initializes this to five
> > miliseconds, which corresponds to the 1% drift rate limit suggested by
> > Xing Zhengjun.  This max_drift field is intended only for early boot,
> > so clocksource_watchdog() splats if it encounters a non-zero value in
> > this field more than 60 seconds after boot, inspired by a suggestion by
> > Thomas Gleixner.
> > 
> > This was tested by setting the clocksource_tsc ->max_drift field to 1,
> > which, as expected, resulted in a clock-skew event.
> 
> We've run the same last for this v10, and those 'unstable' thing [1] can
> not be reproduced!

Good to hear!  ;-)

> We've reported one case that tsc can be wrongly judged as 'unstable'
> by 'refined-jiffies' watchdog [1], while reducing the threshold could
> make it easier to be triggered.
> 
> It could be reproduced on the a plaform with a 115200 serial console,
> and hpet been disabled (several x86 platforms has this), add 
> 'initcall_debug' cmdline parameter to get more debug message, we can
> see:
> 
> [    1.134197] clocksource: timekeeping watchdog on CPU1: Marking clocksource 'tsc-early' as unstable because the skew is too large:
> [    1.134214] clocksource:                       'refined-jiffies' wd_nesc: 500000000 wd_now: ffff8b35 wd_last: ffff8b03 mask: ffffffff
> [    1.134217] clocksource:                       'tsc-early' cs_nsec: 507537855 cs_now: 4e63c9d09 cs_last: 4bebd81f5 mask: ffffffffffffffff
> [    1.134220] clocksource:                       No current clocksource.
> [    1.134222] tsc: Marking TSC unstable due to clocksource watchdog

Just to make sure I understand: "could be reproduced" as in this is the
result from v9, and v10 avoids this, correct?

							Thanx, Paul

> [1]. https://lore.kernel.org/lkml/20210420064934.GE31773@xsang-OptiPlex-9020/ 
> [2]. https://lore.kernel.org/lkml/20201126012421.GA92582@shbuild999.sh.intel.com/
> 
> Thanks,
> Feng
> 
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Mark Rutland <Mark.Rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
> > Cc: Feng Tang <feng.tang@intel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  arch/x86/kernel/tsc.c       |  1 +
> >  include/linux/clocksource.h |  5 +++++
> >  kernel/time/clocksource.c   | 19 ++++++++++++++++++-
> >  3 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 56289170753c..7192b8950322 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1127,6 +1127,7 @@ static int tsc_cs_enable(struct clocksource *cs)
> >  static struct clocksource clocksource_tsc_early = {
> >  	.name			= "tsc-early",
> >  	.rating			= 299,
> > +	.max_drift		= 5 * NSEC_PER_MSEC,
> >  	.read			= read_tsc,
> >  	.mask			= CLOCKSOURCE_MASK(64),
> >  	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
> > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> > index 83a3ebff7456..07d25a158d7a 100644
> > --- a/include/linux/clocksource.h
> > +++ b/include/linux/clocksource.h
> > @@ -42,6 +42,10 @@ struct module;
> >   * @shift:		Cycle to nanosecond divisor (power of two)
> >   * @max_idle_ns:	Maximum idle time permitted by the clocksource (nsecs)
> >   * @maxadj:		Maximum adjustment value to mult (~11%)
> > + * @max_drift:		Maximum drift rate in nanoseconds per half second.
> > + *			Zero says to use default WATCHDOG_THRESHOLD.
> > + *			A non-zero value for ->max_drift more than 60 seconds after boot
> > + *			will result in a splat.
> >   * @archdata:		Optional arch-specific data
> >   * @max_cycles:		Maximum safe cycle value which won't overflow on
> >   *			multiplication
> > @@ -93,6 +97,7 @@ struct clocksource {
> >  	u32			shift;
> >  	u64			max_idle_ns;
> >  	u32			maxadj;
> > +	u32			max_drift;
> >  #ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
> >  	struct arch_clocksource_data archdata;
> >  #endif
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index f71f375df544..070b09dab815 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -126,6 +126,7 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
> >   */
> >  #define WATCHDOG_INTERVAL (HZ >> 1)
> >  #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
> > +#define WATCHDOG_SYNC_FORGIVENESS (HZ * 60UL)
> >  
> >  /*
> >   * Maximum permissible delay between two readouts of the watchdog
> > @@ -377,6 +378,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  	int next_cpu, reset_pending;
> >  	int64_t wd_nsec, cs_nsec;
> >  	struct clocksource *cs;
> > +	u32 md;
> >  
> >  	spin_lock(&watchdog_lock);
> >  	if (!watchdog_running)
> > @@ -423,7 +425,22 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  			continue;
> >  
> >  		/* Check the deviation from the watchdog clocksource. */
> > -		if (abs(cs_nsec - wd_nsec) > WATCHDOG_THRESHOLD) {
> > +		if (!cs->max_drift) {
> > +			md = WATCHDOG_THRESHOLD;
> > +		} else {
> > +			static unsigned long first_jiffies;
> > +			static bool beenhere;
> > +
> > +			if (beenhere) {
> > +				WARN_ON_ONCE(time_after(jiffies,
> > +							first_jiffies + WATCHDOG_SYNC_FORGIVENESS));
> > +			} else {
> > +				beenhere = true;
> > +				first_jiffies = jiffies;
> > +			}
> > +			md = cs->max_drift;
> > +		}
> > +		if (abs(cs_nsec - wd_nsec) > md) {
> >  			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
> >  				smp_processor_id(), cs->name);
> >  			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
> > -- 
> > 2.31.1.189.g2e36527f23
