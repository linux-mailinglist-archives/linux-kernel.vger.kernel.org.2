Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2835B93D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 06:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhDLEWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 00:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhDLEWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 00:22:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D39DB6120F;
        Mon, 12 Apr 2021 04:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618201317;
        bh=ALi5hFLVgrvp5MPFRprYwOz3W7pmmDbRjUbtk9vVG34=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eOrlYyneUgVqzksi1x3yXtRHsRtI+rKMA5LlQAzAdNSMBj0DB27kMtfnr3xicQNIE
         g90oEZWbOMS6cMCsnmxEaZdm+KLs8a+nTz8X/JCi0A2ti2df+DSHCEHzBmBV9pf+9Z
         RyE8cUT9PGFHdxQ4h6piGcksSjh7ckYfSHUwcxDkxxzvI+kCu0bZt+XSH6vzTmkVz/
         8/RjjKO8ghy95mLC8A9L7FzipqO+ISf9fvhTsGG53Yoz/yb0tTNz74PDZGbvDduShD
         /FQ6cRAXG64k+b8FWlL+yy3dRGbOdvhFpLF+hzkmerTJKEKUmWR4MWgv76vsB/4nRb
         hJ59aHXNQLUXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9669A5C26D7; Sun, 11 Apr 2021 21:21:57 -0700 (PDT)
Date:   Sun, 11 Apr 2021 21:21:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210412042157.GA1889369@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210402224828.GA3683@paulmck-ThinkPad-P72>
 <20210402224906.3912-3-paulmck@kernel.org>
 <87blam4iqe.ffs@nanos.tec.linutronix.de>
 <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1>
 <878s5p2jqv.ffs@nanos.tec.linutronix.de>
 <20210411164612.GZ4510@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411164612.GZ4510@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 09:46:12AM -0700, Paul E. McKenney wrote:
> On Sun, Apr 11, 2021 at 12:33:44PM +0200, Thomas Gleixner wrote:
> > On Sat, Apr 10 2021 at 17:20, Paul E. McKenney wrote:
> > > On Sat, Apr 10, 2021 at 11:00:25AM +0200, Thomas Gleixner wrote:
> > >> > +	if (WARN_ON_ONCE(!cs))
> > >> > +		return;
> > >> > +	pr_warn("Checking clocksource %s synchronization from CPU %d.\n",
> > >> > +		cs->name, smp_processor_id());
> > >> > +	cpumask_clear(&cpus_ahead);
> > >> > +	cpumask_clear(&cpus_behind);
> > >> > +	csnow_begin = cs->read(cs);
> > >> 
> > >> So this is invoked via work and the actual clocksource change is done
> > >> via work too. Once the clocksource is not longer actively used for
> > >> timekeeping it can go away. What's guaranteeing that this runs prior to
> > >> the clocksource change and 'cs' is valid throughout this function?
> > >
> > > From what I can see, cs->read() doesn't care whether or not the
> > > clocksource has been marked unstable.  So it should be OK to call
> > > cs->read() before, during, or after the call to __clocksource_unstable().
> > >
> > > Also, this is only done on clocksources marked CLOCK_SOURCE_VERIFY_PERCPU,
> > > so any clocksource that did not like cs->read() being invoked during
> > > or after the call to __clocksource_unstable() should leave off the
> > > CLOCK_SOURCE_VERIFY_PERCPU bit.
> > >
> > > Or did I take a wrong turn somewhere in the pointers to functions?
> > 
> > Right. cs->read() does not care, but what guarantees that cs is valid
> > and not freed yet? It's not an issue with TSC and KVMCLOCK, but
> > conceptually the following is possible:
> > 
> > watchdog()   
> >   queue_work(synccheck);
> >   queue_work(clocksource_change);
> > 
> > work:                                   
> >   synccheck()                             clocksource_change()
> >     preemption                            ...
> >                                           ...
> >                                           some_other_code():
> >                                              unregister_clocksource(cs)
> >                                              free(cs)
> >   cs->read()   <- UAF
> 
> Got it, with the ingenic_tcu_init() function being case in point.
> It invokes clcoksource_unregister() shortly followed by clk_put(), which,
> if I found the correct clk_put(), can kfree() it.
> 
> Thank you!
> 
> > >> > +	queue_work(system_highpri_wq, &clocksource_verify_work);
> > >> 
> > >> This does not guarantee anything. So why does this need an extra work
> > >> function which is scheduled seperately?
> > >
> > > Because I was concerned about doing smp_call_function() while holding
> > > watchdog_lock, which is also acquired elsewhere using spin_lock_irqsave().
> > > And it still looks like on x86 that spin_lock_irqsave() spins with irqs
> > > disabled, which could result in deadlock.  The smp_call_function_single()
> > > would wait for the target CPU to enable interrupts, which would not
> > > happen until after the smp_call_function_single() returned due to its
> > > caller holding watchdog_lock.
> > >
> > > Or is there something that I am missing that prevents this deadlock
> > > from occurring?
> > 
> > The unstable mechanism is:
> > 
> > watchdog()
> >   __clocksource_unstable()
> >     schedule_work(&watchdog_work);
> > 
> > watchdog_work()
> >   kthread_run(clocksource_watchdog_thread);
> > 
> > cs_watchdog_thread()
> >   mutex_lock(&clocksource_mutex);
> >   if (__clocksource_watchdog_kthread())
> > 	clocksource_select();
> >   mutex_unlock(&clocksource_mutex);
> > 
> > So what prevents you from doing that right in watchdog_work() or even in
> > cs_watchdog_thread() properly ordered against the actual clocksource
> > switch?
> > 
> > Hmm?
> 
> My own confusion, apparently.  :-/
> 
> So I need to is inline clocksource_verify_percpu_wq()
> into clocksource_verify_percpu() and then move the call to
> clocksource_verify_percpu() to __clocksource_watchdog_kthread(), right
> before the existing call to list_del_init().  Will do!

Except that this triggers the WARN_ON_ONCE() in smp_call_function_single()
due to interrupts being disabled across that list_del_init().

Possibilities include:

1.	Figure out why interrupts must be disabled only sometimes while
	holding watchdog_lock, in the hope that they need not be across
	the entire critical section for __clocksource_watchdog_kthread().
	As in:

		local_irq_restore(flags);
		clocksource_verify_percpu(cs);
		local_irq_save(flags);

	Trying this first with lockdep enabled.  Might be spectacular.

2.	Invoke clocksource_verify_percpu() from its original
	location in clocksource_watchdog(), just before the call to
	__clocksource_unstable().  This relies on the fact that
	clocksource_watchdog() acquires watchdog_lock without
	disabling interrupts.

3.	Restrict CLOCK_SOURCE_VERIFY_PERCPU to clocksource structures
	that are statically allocated, thus avoiding the use-after-free
	problem.  Rely on KASAN to enforce this restriction.

4.	Add reference counting or some such to clock sources.

5.	Your ideas here.

I will give this more thought, but #2 is looking pretty good at this point.

							Thanx, Paul
