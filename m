Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76144C406
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhKJPHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232339AbhKJPHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:07:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E76561051;
        Wed, 10 Nov 2021 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636556692;
        bh=qtocZ3hkzt64qXgyIeHo10k+iZQM7znfrDaOz+wsqGg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vMwqSGPyb2cDGIhmWJQraSt5kCP4cX1rxlLy7Qf1W8w2NcArCGt4gv+f+jNx98oUz
         BlZdS1nxF9dGOMiYuQzDdLaFO0Xkh58XchNct0I1tOtomLgNYGA/sxYM5AOOgAcfd/
         UhY2z4sul/NUYLj6aBFXyfj5c2YHzrT+LO5CUFy2LMurKbwEb4z3gzfwuuvTSLnHZN
         vk1xSckiI1i2EIZU10a5ZXOmGU6au9amQy+Fe1XU2Yi+5+asgQoWxzHdQNhzaVDXAo
         EGdjOFyLgsvkNiq/PWj8AY7+CMZdaDgu1cJsPW2/6ki/WSR0ZhV7jBOgVm0V3vjtjB
         FzWKHnqMOAaOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 711F95C0848; Wed, 10 Nov 2021 07:04:52 -0800 (PST)
Date:   Wed, 10 Nov 2021 07:04:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource: Improve cs_watchdog_read()
Message-ID: <20211110150452.GB641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <8f13ba8d-03b5-76de-4d59-4ca8786afb83@gmail.com>
 <20211110124821.GZ641268@paulmck-ThinkPad-P17-Gen-1>
 <a1e75119-bf60-8dff-71c5-29d1a137587d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e75119-bf60-8dff-71c5-29d1a137587d@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 02:53:27PM +0100, Heiner Kallweit wrote:
> On 10.11.2021 13:48, Paul E. McKenney wrote:
> > On Tue, Nov 09, 2021 at 09:55:08PM +0100, Heiner Kallweit wrote:
> >> If max_cswd_read_retries is set to 0 or 1 then the current warning
> >> behavior doesn't seem to make too much sense to me.
> >> If set to 0, then we'd warn with each watchdog run.
> >> If set to 1, then we'd warn at the first retry, even though the commit
> >> description of db3a34e17433 states that one retry is expected behavior.
> >> If printing a message at all in this case, then it should be debug
> >> level.
> > 
> > The behavior for max_cswd_read_retries==1 is exactly what you want when
> > you are checking to see whether or not your system would retry at all
> > for the duration of a given run.
> > 
> > The behavior for max_cswd_read_retries==0 is exactly what you want when
> > you are testing the ability to print that message on a system that will
> > not do a retry in a reasonable period of time.
> > 
> > Or am I missing something here?
> > 
> For me this mixes production warning and debug features.

I know of no law saying that a given module parameter cannot be used for
both debugging and production features.  In fact, there are any number
of parameters that take ranges of values, some of which should not be
used in production.  In addition, Linux supports such a wide range of
environments and workloads that people supporting different production
environments will have very different ideas about the advisability of
setting a given value for a given module parameter.

So if your production environments don't like setting the value of
clocksource.max_cswd_read_retries to less than two, why not just prohibit
such settings in your production environments?

> To support your debug use cases, maybe use something like this?
> 
> if (nretries > 1)
> 	pr_warn()
> else if (nretries >= max_cswd_read_retries)
> 	pr_debug()

I am sorry, but I am not seeing the benefit of this change.  How does
this help you?

							Thanx, Paul

> >> Whilst being at it, move declaration of wd_end and wd_delta into the
> >> loop and remove not needed braces.
> > 
> > I am OK with moving those two variables into the "for" loop.
> > 
> > I am personally OK removing the braces, but if I remember correctly,
> > my upstream maintainer asked that I add them due to the statement being
> > split across two lines.
> > 
> > 							Thanx, Paul
> > 
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  kernel/time/clocksource.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> >> index f29d1a524..8c0be9c02 100644
> >> --- a/kernel/time/clocksource.c
> >> +++ b/kernel/time/clocksource.c
> >> @@ -208,10 +208,11 @@ module_param(verify_n_cpus, int, 0644);
> >>  static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> >>  {
> >>  	unsigned int nretries;
> >> -	u64 wd_end, wd_delta;
> >>  	int64_t wd_delay;
> >>  
> >>  	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
> >> +		u64 wd_end, wd_delta;
> >> +
> >>  		local_irq_disable();
> >>  		*wdnow = watchdog->read(watchdog);
> >>  		*csnow = cs->read(cs);
> >> @@ -222,10 +223,9 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> >>  		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
> >>  					      watchdog->shift);
> >>  		if (wd_delay <= WATCHDOG_MAX_SKEW) {
> >> -			if (nretries > 1 || nretries >= max_cswd_read_retries) {
> >> +			if (nretries > 1)
> >>  				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
> >>  					smp_processor_id(), watchdog->name, nretries);
> >> -			}
> >>  			return true;
> >>  		}
> >>  	}
> >> -- 
> >> 2.33.1
> >>
> 
