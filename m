Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3270035B62D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbhDKQqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 12:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235779AbhDKQq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 12:46:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CCB3610A2;
        Sun, 11 Apr 2021 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618159572;
        bh=rbVb19c1/SJxSlrFOUOznSlTQjAxKlDBVgXXuCUlmdM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=izM6T6VR3pNv2yxHYdhcp7tn9Yt+Hqq634NW1JgX3nYJ4zs8CiS3BDhkDKtCoQAGA
         aSCOcyzvNnvrCpEvBCneD+OFa13dnUaORAHFFPKS0nax7PwJa8Nx3AutGkuSdcnJBH
         +YYo3tPtQAz3iXzDJ7ZgsX471FVoQlQDH9B/O11wv2SeWglAcJfRLu33imK+dU5X5X
         IA1uo6qQXfXiDV9IZjXWTHYr32koLAT+w2lXtRGFjm2cHexAtOn2NrnTL9zTcbTJzK
         TsrWWog+IbTlAOnUYuON0IUjMcxASB3ZQIKXrTzatacl9cNPnBBJ5dOHqXKZFrOIJ2
         dILuDctPuFgRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 654FA5C0A23; Sun, 11 Apr 2021 09:46:12 -0700 (PDT)
Date:   Sun, 11 Apr 2021 09:46:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210411164612.GZ4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210402224828.GA3683@paulmck-ThinkPad-P72>
 <20210402224906.3912-3-paulmck@kernel.org>
 <87blam4iqe.ffs@nanos.tec.linutronix.de>
 <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1>
 <878s5p2jqv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s5p2jqv.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 12:33:44PM +0200, Thomas Gleixner wrote:
> On Sat, Apr 10 2021 at 17:20, Paul E. McKenney wrote:
> > On Sat, Apr 10, 2021 at 11:00:25AM +0200, Thomas Gleixner wrote:
> >> > +	if (WARN_ON_ONCE(!cs))
> >> > +		return;
> >> > +	pr_warn("Checking clocksource %s synchronization from CPU %d.\n",
> >> > +		cs->name, smp_processor_id());
> >> > +	cpumask_clear(&cpus_ahead);
> >> > +	cpumask_clear(&cpus_behind);
> >> > +	csnow_begin = cs->read(cs);
> >> 
> >> So this is invoked via work and the actual clocksource change is done
> >> via work too. Once the clocksource is not longer actively used for
> >> timekeeping it can go away. What's guaranteeing that this runs prior to
> >> the clocksource change and 'cs' is valid throughout this function?
> >
> > From what I can see, cs->read() doesn't care whether or not the
> > clocksource has been marked unstable.  So it should be OK to call
> > cs->read() before, during, or after the call to __clocksource_unstable().
> >
> > Also, this is only done on clocksources marked CLOCK_SOURCE_VERIFY_PERCPU,
> > so any clocksource that did not like cs->read() being invoked during
> > or after the call to __clocksource_unstable() should leave off the
> > CLOCK_SOURCE_VERIFY_PERCPU bit.
> >
> > Or did I take a wrong turn somewhere in the pointers to functions?
> 
> Right. cs->read() does not care, but what guarantees that cs is valid
> and not freed yet? It's not an issue with TSC and KVMCLOCK, but
> conceptually the following is possible:
> 
> watchdog()   
>   queue_work(synccheck);
>   queue_work(clocksource_change);
> 
> work:                                   
>   synccheck()                             clocksource_change()
>     preemption                            ...
>                                           ...
>                                           some_other_code():
>                                              unregister_clocksource(cs)
>                                              free(cs)
>   cs->read()   <- UAF

Got it, with the ingenic_tcu_init() function being case in point.
It invokes clcoksource_unregister() shortly followed by clk_put(), which,
if I found the correct clk_put(), can kfree() it.

Thank you!

> >> > +	queue_work(system_highpri_wq, &clocksource_verify_work);
> >> 
> >> This does not guarantee anything. So why does this need an extra work
> >> function which is scheduled seperately?
> >
> > Because I was concerned about doing smp_call_function() while holding
> > watchdog_lock, which is also acquired elsewhere using spin_lock_irqsave().
> > And it still looks like on x86 that spin_lock_irqsave() spins with irqs
> > disabled, which could result in deadlock.  The smp_call_function_single()
> > would wait for the target CPU to enable interrupts, which would not
> > happen until after the smp_call_function_single() returned due to its
> > caller holding watchdog_lock.
> >
> > Or is there something that I am missing that prevents this deadlock
> > from occurring?
> 
> The unstable mechanism is:
> 
> watchdog()
>   __clocksource_unstable()
>     schedule_work(&watchdog_work);
> 
> watchdog_work()
>   kthread_run(clocksource_watchdog_thread);
> 
> cs_watchdog_thread()
>   mutex_lock(&clocksource_mutex);
>   if (__clocksource_watchdog_kthread())
> 	clocksource_select();
>   mutex_unlock(&clocksource_mutex);
> 
> So what prevents you from doing that right in watchdog_work() or even in
> cs_watchdog_thread() properly ordered against the actual clocksource
> switch?
> 
> Hmm?

My own confusion, apparently.  :-/

So I need to is inline clocksource_verify_percpu_wq()
into clocksource_verify_percpu() and then move the call to
clocksource_verify_percpu() to __clocksource_watchdog_kthread(), right
before the existing call to list_del_init().  Will do!

							Thanx, Paul
