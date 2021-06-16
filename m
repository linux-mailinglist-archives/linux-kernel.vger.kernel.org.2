Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468E43A9821
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhFPKx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhFPKxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:53:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7EDD6100A;
        Wed, 16 Jun 2021 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623840679;
        bh=0lqhxwxk1k9uCXk3N7Z5LMDu3OsIrJ/dh/mh/a1Tp6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmSHGhdjW9NHDVy4JLlANDIQbfCgGtFuukpSDwaqjL5lO3Jc1q8a4RX1U3GlOKV0m
         kXVjqARZWLOfPMsKDAlDwe13Lr2VNysnPRYo7iiE+45atrLZMvh5mHxrOXQiha6bR1
         CSoRnNCmTuQN6UFipirhhHQM7n5a1m/PHqUFZ1e0yF3emCFRK+DqtvNLCUha190P7W
         59tm/YpeB1bWEimvnyd1/dLY7CTtVwWGGVmLmyy7UR67CCPXj8yGDizQcPikzLnFmZ
         3dTo0kSvkIxyRvB9qH+6pVhX6kYSuNvkIqbukuAs0tg8wNvve0v+a4G9FdGhsPTNha
         C8bAlTupUJYDA==
Date:   Wed, 16 Jun 2021 12:51:16 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/6] posix-cpu-timers: Don't start process wide cputime
 counter if timer is disabled
Message-ID: <20210616105116.GA801071@lothringen>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-3-frederic@kernel.org>
 <YMm7iafJ1mberGIg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMm7iafJ1mberGIg@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:51:21AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 01:31:55PM +0200, Frederic Weisbecker wrote:
> > If timer_settime() is called with a 0 expiration on a timer that is
> > already disabled, the process wide cputime counter will be started
> > and won't ever get a chance to be stopped by stop_process_timer() since
> > no timer is actually armed to be processed.
> > 
> > This process wide counter might bring some performance hit due to the
> > concurrent atomic additions at the thread group scope.
> > 
> > The following snippet is enough to trigger the issue.
> > 
> > 	void trigger_process_counter(void)
> > 	{
> > 		timer_t id;
> > 		struct itimerspec val = { };
> > 
> > 		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
> > 		timer_settime(id, TIMER_ABSTIME, &val, NULL);
> > 		timer_delete(id);
> > 	}
> > 
> > So make sure we don't needlessly start it.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > ---
> >  kernel/time/posix-cpu-timers.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> > index aa52fc85dbcb..132fd56fb1cd 100644
> > --- a/kernel/time/posix-cpu-timers.c
> > +++ b/kernel/time/posix-cpu-timers.c
> > @@ -632,10 +632,15 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
> >  	 * times (in arm_timer).  With an absolute time, we must
> >  	 * check if it's already passed.  In short, we need a sample.
> >  	 */
> > -	if (CPUCLOCK_PERTHREAD(timer->it_clock))
> > +	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
> >  		val = cpu_clock_sample(clkid, p);
> > -	else
> > -		val = cpu_clock_sample_group(clkid, p, true);
> > +	} else {
> > +		/*
> > +		 * Sample group but only start the process wide cputime counter
> > +		 * if the timer is to be enabled.
> > +		 */
> > +		val = cpu_clock_sample_group(clkid, p, !!new_expires);
> > +	}
> 
> The cpu_timer_enqueue() is in arm_timer() and the condition for calling
> that is:
> 
>   'new_expires != 0 && val < new_expires'
> 
> Which is not the same as the one you add.

There are two different things here:

1) the threadgroup cputime counter, activated by cpu_clock_sample_group(clkid,
p, true)

2) the expiration set (+ the callback enqueued) in arm_timer()

The issue here is that we go through 1) but not through 2)

> 
> I'm thinking the fundamental problem here is the disconnect between
> cpu_timer_enqueue() and pct->timers_active ?

You're right it's the core issue. But what prevents the whole to be
fundamentally connected is a circular dependency: we need to know the
threadgroup cputime before arming the timer, but we would need to know
if we arm the timer before starting the threadgroup cputime counter

To sum up, the current sequence is:

* fetch the threadgroup cputime AND start the whole threadgroup counter

* arm the timer if it isn't zero and it hasn't yet expired

While the ideal sequence should be:

* fetch the threadgroup cputime (without starting the whole threadgroup counter
  yet)

* arm the timer if it isn't zero and it hasn't yet expired

* iff we armed the timer, start the whole theadgroup counter

But that means re-iterating the whole threadgroup and update atomically
the group counter with each task's time.
