Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9A3A99B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhFPMBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231256AbhFPMBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:01:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6207861245;
        Wed, 16 Jun 2021 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623844765;
        bh=T1MvNWOqxvY1uHQ504TWxCJo8tg7sX1NHlZeLaQVJig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s019J64J35LoWgpXSIO/jgumoRXqndYyN37HXLAn3L23lxkicAbKsBU4Eve/JZVbF
         84mlgU5e8CNNSR5t8YsKZ46yj2Sy4eygdJp6rVaYzLUUliCwN+xZKi5K4z/OEAANx1
         uEV3erjiBq0bJQeCGCKY9l0izlMtxU27CqZJOY5CSOA6nD3vvW8cD7UfTwHJjXiexz
         eylsSogw7BKWbNnnqPch+6obwg8bLP6Jz3spC0zLzacMwtDNYF7zy7Ybv5SlWqvGRe
         tGWFeOeViFis6nyh7olniet6YJoU2VrO5hEndt8g6NEr0hKkPHCYWlu+qt9QiH8RGA
         heLLgLxk6Pm7A==
Date:   Wed, 16 Jun 2021 13:59:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 5/6] posix-cpu-timers: Force next expiration recalc after
 early timer firing
Message-ID: <20210616115923.GC801071@lothringen>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-6-frederic@kernel.org>
 <YMnHnUcufPhtnDZP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMnHnUcufPhtnDZP@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:42:53AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 01:31:58PM +0200, Frederic Weisbecker wrote:
> > diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> > index 0b5715c8db04..d8325a906314 100644
> > --- a/kernel/time/posix-cpu-timers.c
> > +++ b/kernel/time/posix-cpu-timers.c
> > @@ -405,6 +405,21 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
> >  	return 0;
> >  }
> >  
> > +static void __disarm_timer(struct k_itimer *timer, struct task_struct *p,
> > +			   u64 old_expires)
> > +{
> > +	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
> > +	struct posix_cputimer_base *base;
> > +
> > +	if (CPUCLOCK_PERTHREAD(timer->it_clock))
> > +		base = p->posix_cputimers.bases + clkidx;
> > +	else
> > +		base = p->signal->posix_cputimers.bases + clkidx;
> > +
> > +	if (old_expires == base->nextevt)
> > +		base->nextevt = 0;
> > +}
> > +
> >  /*
> >   * Dequeue the timer and reset the base if it was its earliest expiration.
> >   * It makes sure the next tick recalculates the base next expiration so we
> > @@ -415,24 +430,14 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
> >  {
> >  	struct cpu_timer *ctmr = &timer->it.cpu;
> >  	u64 old_expires = cpu_timer_getexpires(ctmr);
> > -	struct posix_cputimer_base *base;
> >  	bool queued;
> > -	int clkidx;
> >  
> >  	queued = cpu_timer_dequeue(ctmr);
> >  	cpu_timer_setexpires(ctmr, 0);
> >  	if (!queued)
> >  		return;
> >  
> > -	clkidx = CPUCLOCK_WHICH(timer->it_clock);
> > -
> > -	if (CPUCLOCK_PERTHREAD(timer->it_clock))
> > -		base = p->posix_cputimers.bases + clkidx;
> > -	else
> > -		base = p->signal->posix_cputimers.bases + clkidx;
> > -
> > -	if (old_expires == base->nextevt)
> > -		base->nextevt = 0;
> > +	__disarm_timer(timer, p, old_expires);
> >  }
> >  
> >  
> > @@ -686,8 +691,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
> >  			u64 exp = bump_cpu_timer(timer, val);
> >  
> >  			if (val < exp) {
> > -				old_expires = exp - val;
> > -				old->it_value = ns_to_timespec64(old_expires);
> > +				old->it_value = ns_to_timespec64(exp - val);
> >  			} else {
> >  				old->it_value.tv_nsec = 1;
> >  				old->it_value.tv_sec = 0;
> > @@ -748,9 +752,28 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
> >  		 * accumulate more time on this clock.
> >  		 */
> >  		cpu_timer_fire(timer);
> > +
> > +		sighand = lock_task_sighand(p, &flags);
> > +		if (sighand == NULL)
> > +			goto out;
> > +		if (!cpu_timer_queued(&timer->it.cpu)) {
> > +			/*
> > +			 * Disarm the previous timer to deactivate the tick
> > +			 * dependency and process wide cputime counter if
> > +			 * necessary.
> > +			 */
> > +			__disarm_timer(timer, p, old_expires);
> > +			/*
> > +			 * If the previous timer was deactivated, we might have
> > +			 * just started the process wide cputime counter. Make
> > +			 * sure we poke the tick to deactivate it then.
> > +			 */
> > +			if (!old_expires && !CPUCLOCK_PERTHREAD(timer->it_clock))
> > +				p->signal->posix_cputimers.bases[clkid].nextevt = 0;
> > +		}
> > +		unlock_task_sighand(p, &flags);
> >  	}
> 
> I'm thinking this is a better fix than patch #2. AFAICT you can now go
> back to unconditionally doing start, and then if we fire it early, we'll
> disarm the thing.
> 
> That would avoid the disconnect between the start condition and the fire
> condition.

Right but the drawback is that we unconditionally start the threadgroup
counter while initializing the timer to 0 (deactivated).

Then in the next tick at least one thread will need to lock the sighand
and re-evaluate the whole list.
