Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1D935B0DA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 02:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbhDKAUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 20:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234680AbhDKAUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 20:20:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69550610D1;
        Sun, 11 Apr 2021 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618100420;
        bh=zyE85PV2BpinziaUpqPvnFTXnXCTGDELAlPbvWUlLtE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g2KnAxGGxACb5G+rYFZPPxgJLEp5Sp8q2k3TwYwjyMNz5T633PvZSWXwQvhJ8fXZh
         y5NcxPpg0FzxxC+243kwCBt8X/Epq+fcNiCtjABGbOJamidIbcQ4W/NrRyqRql/J/u
         4xqCyrBNKkD6JCPNWOgCeoUKRhcqPaqGQNHacWndw/UEG8hbJ2ZOU6fnVIFixDdjoU
         FjSqFKa9oKPl8mMLEWL6ytczfOSR+kLPAZtGBA8TQ/BnPEaI1f7U2u3+YXQBKtXYzs
         tB8ZYPS38jRE9w+ZotRo1giE4wSEKWUme17i6luXPoV+A6x1u7cDrKkfnAlRajhhkE
         iFqMTK1nIWb9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 10C825C0C5F; Sat, 10 Apr 2021 17:20:20 -0700 (PDT)
Date:   Sat, 10 Apr 2021 17:20:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210402224828.GA3683@paulmck-ThinkPad-P72>
 <20210402224906.3912-3-paulmck@kernel.org>
 <87blam4iqe.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blam4iqe.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:00:25AM +0200, Thomas Gleixner wrote:
> On Fri, Apr 02 2021 at 15:49, paulmck wrote:
> >
> > +static void clocksource_verify_percpu_wq(struct work_struct *unused)
> > +{
> > +	int cpu;
> > +	struct clocksource *cs;
> > +	int64_t cs_nsec;
> > +	u64 csnow_begin;
> > +	u64 csnow_end;
> > +	u64 delta;
> 
> Please use reverse fir tree ordering and stick variables of the same
> type together:
> 
> 	u64 csnow_begin, csnow_end, delta;
> 	struct clocksource *cs;
> 	s64 cs_nsec;
>         int cpu;

Will do.

> > +
> > +	cs = smp_load_acquire(&clocksource_verify_work_cs); // pairs with release
> 
> Please don't use tail comments. They are a horrible distraction.

I will remove it.

> > +	if (WARN_ON_ONCE(!cs))
> > +		return;
> > +	pr_warn("Checking clocksource %s synchronization from CPU %d.\n",
> > +		cs->name, smp_processor_id());
> > +	cpumask_clear(&cpus_ahead);
> > +	cpumask_clear(&cpus_behind);
> > +	csnow_begin = cs->read(cs);
> 
> So this is invoked via work and the actual clocksource change is done
> via work too. Once the clocksource is not longer actively used for
> timekeeping it can go away. What's guaranteeing that this runs prior to
> the clocksource change and 'cs' is valid throughout this function?

From what I can see, cs->read() doesn't care whether or not the
clocksource has been marked unstable.  So it should be OK to call
cs->read() before, during, or after the call to __clocksource_unstable().

Also, this is only done on clocksources marked CLOCK_SOURCE_VERIFY_PERCPU,
so any clocksource that did not like cs->read() being invoked during
or after the call to __clocksource_unstable() should leave off the
CLOCK_SOURCE_VERIFY_PERCPU bit.

Or did I take a wrong turn somewhere in the pointers to functions?

> > +	queue_work(system_highpri_wq, &clocksource_verify_work);
> 
> This does not guarantee anything. So why does this need an extra work
> function which is scheduled seperately?

Because I was concerned about doing smp_call_function() while holding
watchdog_lock, which is also acquired elsewhere using spin_lock_irqsave().
And it still looks like on x86 that spin_lock_irqsave() spins with irqs
disabled, which could result in deadlock.  The smp_call_function_single()
would wait for the target CPU to enable interrupts, which would not
happen until after the smp_call_function_single() returned due to its
caller holding watchdog_lock.

Or is there something that I am missing that prevents this deadlock
from occurring?

							Thanx, Paul
