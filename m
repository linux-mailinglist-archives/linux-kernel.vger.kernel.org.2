Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E829A35D026
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbhDLSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhDLSVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:21:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D00F961289;
        Mon, 12 Apr 2021 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618251649;
        bh=+qNcZZVKpnD42SZYygELSRzFGrquBNCnSaALrYgY+94=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MgZRmT0mOa+cpabctG7YJzQyeQAOnsQKoRPvOTZyh+FefpcWhHyRn+PEh7mhSmtE8
         9+Fo3WFkl3dJMO/8kZkPmn9/hd5URj1uyGfcv4YLbu3TCx8ZwYwgE6hlcfIOUJtEki
         /uTT1tQFD1iUd+G4rCa/lIMuO1zjSzMuvPpxLXv3HdoydIz6ywZoIVufDAf6LWSGD7
         IxniP4TVki25c2sM4wjJMpPSCsqGAHy4B3fEJFoMarTdcfGM1jbkvmg4S5nQawGzqa
         pByP5wN74BETHDGVowXxl1qupAuWtNmJuC/d5VjKXSOs8cPQWhnt/43fpw8zFO5Tmg
         xMeOzkERROTZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 91E4A5C034B; Mon, 12 Apr 2021 11:20:49 -0700 (PDT)
Date:   Mon, 12 Apr 2021 11:20:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210412182049.GE4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210402224828.GA3683@paulmck-ThinkPad-P72>
 <20210402224906.3912-3-paulmck@kernel.org>
 <87blam4iqe.ffs@nanos.tec.linutronix.de>
 <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1>
 <878s5p2jqv.ffs@nanos.tec.linutronix.de>
 <20210411164612.GZ4510@paulmck-ThinkPad-P17-Gen-1>
 <20210412042157.GA1889369@paulmck-ThinkPad-P17-Gen-1>
 <87k0p71whr.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0p71whr.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 03:08:16PM +0200, Thomas Gleixner wrote:
> On Sun, Apr 11 2021 at 21:21, Paul E. McKenney wrote:
> > On Sun, Apr 11, 2021 at 09:46:12AM -0700, Paul E. McKenney wrote:
> >> So I need to is inline clocksource_verify_percpu_wq()
> >> into clocksource_verify_percpu() and then move the call to
> >> clocksource_verify_percpu() to __clocksource_watchdog_kthread(), right
> >> before the existing call to list_del_init().  Will do!
> >
> > Except that this triggers the WARN_ON_ONCE() in smp_call_function_single()
> > due to interrupts being disabled across that list_del_init().
> >
> > Possibilities include:
> >
> > 1.	Figure out why interrupts must be disabled only sometimes while
> > 	holding watchdog_lock, in the hope that they need not be across
> > 	the entire critical section for __clocksource_watchdog_kthread().
> > 	As in:
> >
> > 		local_irq_restore(flags);
> > 		clocksource_verify_percpu(cs);
> > 		local_irq_save(flags);
> >
> > 	Trying this first with lockdep enabled.  Might be spectacular.
> 
> Yes, it's a possible deadlock against the watchdog timer firing ...

And lockdep most emphatically agrees with you.  ;-)

> The reason for irqsave is again historical AFAICT and nobody bothered to
> clean it up. spin_lock_bh() should be sufficient to serialize against
> the watchdog timer, though I haven't looked at all possible scenarios.

Though if BH is disabled, there is not so much advantage to
invoking it from __clocksource_watchdog_kthread().  Might as
well just invoke it directly from clocksource_watchdog().

> > 2.	Invoke clocksource_verify_percpu() from its original
> > 	location in clocksource_watchdog(), just before the call to
> > 	__clocksource_unstable().  This relies on the fact that
> > 	clocksource_watchdog() acquires watchdog_lock without
> > 	disabling interrupts.
> 
> That should be fine, but this might cause the softirq to 'run' for a
> very long time which is not pretty either.
> 
> Aside of that, do we really need to check _all_ online CPUs? What you
> are trying to figure out is whether the wreckage is CPU local or global,
> right?
> 
> Wouldn't a shirt-sleeve approach of just querying _one_ CPU be good
> enough? Either the other CPU has the same wreckage, then it's global or
> it hasn't which points to a per CPU local issue.
> 
> Sure it does not catch the case where a subset (>1) of all CPUs is
> affected, but I'm not seing how that really buys us anything.

Good point!  My thought is to randomly pick eight CPUs to keep the
duration reasonable while having a good chance of hitting "interesting"
CPU choices in multicore and multisocket systems.

However, if a hard-to-reproduce problem occurred, it would be good to take
the hit and scan all the CPUs.  Additionally, there are some workloads
for which the switch from TSC to HPET is fatal anyway due to increased
overhead.  For these workloads, the full CPU scan is no additional pain.

So I am thinking in terms of a default that probes eight randomly selected
CPUs without worrying about duplicates (as in there would be some chance
that fewer CPUs would actually be probed), but with a boot-time flag
that does all CPUs.  I would add the (default) random selection as a
separate patch.

I will send a new series out later today, Pacific Time.

							Thanx, Paul
