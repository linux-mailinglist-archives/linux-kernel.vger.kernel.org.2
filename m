Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0935B0CC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 01:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbhDJXuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 19:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234975AbhDJXus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 19:50:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78CC8610A3;
        Sat, 10 Apr 2021 23:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618098633;
        bh=iVD3CjNy6yYEszr8NDiMzPyofOKr+RvlDojk8cOxdLY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nBWF/rIsiGyAFj40XbNmmNgU3TWmE2ROdEAlahJ9HeBG4By//4y811FNJ2Wj+ZVrW
         qHpfRNGrA7rPIzjpynktL+zKYADluxRr8qxcj9PwdFKF85ZZuBbIalt52R9fdYI9Sn
         m3s32J4So43HsLbgX6K+mFoxnHLIAqvLPadOJyKFd8n/T4NPFQAjwvwyjHY1POFgDH
         ojUyOwPRvR99GZOne9/jEhWbwEf528J0ZF6zya+Lx6liR/BqjEayPa56wW7pknotZI
         J1SUDsMP//AzgElBRQo1qMZHPTE8sNWOnx16XqB2p6nVVMqfy3RZLZfPWuesyZR4HC
         MFxMdyQY01Ghw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3EFBA5C0C5F; Sat, 10 Apr 2021 16:50:33 -0700 (PDT)
Date:   Sat, 10 Apr 2021 16:50:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 2/5] clocksource: Retry clock read if long
 delays detected
Message-ID: <20210410235033.GU4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210402224828.GA3683@paulmck-ThinkPad-P72>
 <20210402224906.3912-2-paulmck@kernel.org>
 <87eefi4jm6.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eefi4jm6.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 10:41:21AM +0200, Thomas Gleixner wrote:
> On Fri, Apr 02 2021 at 15:49, paulmck wrote:
> > This commit therefore re-reads the watchdog clock on either side of
> 
> 'This commit' is not any better than 'This patch' and this sentence
> makes no sense. I might be missing something, but how exactly does "the
> commit" re-read the watchdog clock?
> 
>  git grep 'This patch' Documentation/process/

I will rework this.

> > the read from the clock under test.  If the watchdog clock shows an
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
> > +		wdagain_nsec = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> 
> That variable naming is confusing as hell. This is about the delta and
> not about the second readout of the watchdog.

How about wdagain_delta?

> > +		if (wdagain_nsec < 0 || wdagain_nsec > WATCHDOG_MAX_SKEW) {
> 
> How exactly is this going negative especially with clocksources which
> have a limited bitwidth? See clocksource_delta().

I thought that I had actually seen this happen, though it is of course
quite possible that it was due to a bug in an early version of my changes.

What I will do is to remove the less-than comparison and test with
a WARN_ON().  If that doesn't trigger, I will drop the WARN_ON().
If it does trigger, I will figure out why.

> > +			wderr_nsec = wdagain_nsec;
> > +			if (nretries++ < max_read_retries)
> > +				goto retry;
> > +		}
> > +		if (nretries)
> > +			pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d\n",
> > +				smp_processor_id(), watchdog->name, wderr_nsec, nretries);
> 
> Lacks curly braces around the pr_warn() simply because it's not a single
> line. Breaks my parser :)

OK, will fix.  ;-)

> But if this ever happens to exceed max_read_retries, then what's the
> point of continuing at all? The data is known to be crap already.

If there are four delays in four consecutive attempts to read out the
clocks -- with interrupts disabled -- then it is quite possible that the
delay is actually caused by the attempt to read the clock.  In which case,
marking the clock bad due to skew is a reasonable choice.

On the other hand, if the four consecutive delays are caused by something
like an NMI storm, then as you say, you have worse problems.

								Thanx, Paul

> >  		/* Clocksource initialized ? */
> >  		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
> 
> Thanks,
> 
>         tglx
