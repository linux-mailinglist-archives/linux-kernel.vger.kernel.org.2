Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB93AEA26
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhFUNkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:40:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D497F61042;
        Mon, 21 Jun 2021 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624282677;
        bh=bSGthvmo7hxviWXuFN82mIhLkx+NZG4Fc4pTGclp5F4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S6LDnmmryAvSiPPEBF/4YXTzALUKbylvyRFuMqekyIVmvWis+N5fPsqQID0td21Kb
         q2p1k8yZYP7lHcux8VzmKTcCTV4gtDn0bP1rvz0Tyhib+G84jWNCwM2Gi1BxymRrfn
         IGoWXGQNnN1eq+/tFBB+XzlqIf96fN1i18vuF3To3flNFkgUEaU3VA1qho/eXSC6iv
         60loBoWXGbRMfim+gslXKSwp0+ojHlU8qP7XpInfZ3KZZWAT5ROUtHFFT7jj/2UqMm
         /bdePajjomdsUh4oE8QA+xZDRK6Y045tlu2cUrKlzSULd2IGBiQawRmZXGd7wU4BSM
         V/TA3tQnU8Okg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A0F805C038E; Mon, 21 Jun 2021 06:37:57 -0700 (PDT)
Date:   Mon, 21 Jun 2021 06:37:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <20210621133757.GS4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com>
 <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
 <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
 <20210620210127.GR4397@paulmck-ThinkPad-P17-Gen-1>
 <YNA/gkHbq46A/21C@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNA/gkHbq46A/21C@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 09:28:02AM +0200, Peter Zijlstra wrote:
> On Sun, Jun 20, 2021 at 02:01:27PM -0700, Paul E. McKenney wrote:
> > On Sun, Jun 20, 2021 at 09:14:28PM +0200, Peter Zijlstra wrote:
> 
> > > I don't buy that argument. pr_err() (or worse) is not supposed to
> > > happen, ever. If it does, *that* is a far worse condition that any data
> > > race possibly found by kcsan.
> > > 
> > > So the only way the pr_err() expression itself can lead to kcsan
> > > determining a data-race, if something far worse triggered the pr_err()
> > > itself.
> > 
> > Earlier, you said pr_warn().  Above, I said pr_*().  Now you say
> > pr_err().  But OK...
> 
> Same, thing.. also Sundays aren't great for details it seems :-)

I know that feeling!  ;-)

> > Let's take for example the pr_err() in __call_rcu(), that is, the
> > double-free diagnostic.  A KCSAN warning on the unmarked load from
> > head->func could give valuable information on the whereabouts of the
> > other code interfering with the callback.  Blanket disabling of KCSAN
> > across all pr_err() calls (let alone all pr_*() calls) would be the
> > opposite of helpful.
> 
> I'm confused. That pr_err() should never happen in a correct program. If
> it happens, fix it and any data race as a consequence of that pr_err()
> no longer exists either.
> 
> I fundementally don't see the relevance of a possible data race from a
> statement that should never happen in a correct program to begin with.
> 
> Why do you think otherwise?

Because detection of that data race can provide valuable debugging help.

> > > You've lost me on the schedule thing, what?
> > 
> > The definition of schedule_timeout_interruptible() is in part of the
> > kernel that uses much looser KCSAN checking.  Thus there are some
> > KCSAN warnings from RCU involving schedule_timeout_interruptible().
> > But at least some of these warnings are for conflicting writes, which
> > many parts of the kernel suppress KCSAN warnings for.
> 
> You've lost me again.. schedule_timeout_interruptible() doesn't do
> writes to rcu state, does it? So how can there be problems?

Because the static inline functions end up in RCU's tranlation units,
and they do write to other state.  See for example the line marked with
the asterisk at the end of this email, which is apparently between
__run_timers() and rcu_torture_reader().  But gdb says that this is
really between this statement in __run_timers():

	base->running_timer = NULL;

And this statement in try_to_del_timer_sync():

	if (base->running_timer != timer)

Because of inline functions, running KCSAN on RCU can detect races in
other subsystems.  In this case, I could argue for a READ_ONCE() on the
"if" condition, but last I knew, the rules for timers are that C-language
writes do not participate in data races.  So maybe I should add that
READ_ONCE(), but running KCSAN on rcutorture would still complain.

Here is the stack leading to try_to_del_timer_sync():

	read to 0xffff95bbdf49c280 of 8 bytes by task 167 on cpu 0:
	 try_to_del_timer_sync+0x96/0x1b0
	 del_timer_sync+0xa8/0xe0
	 schedule_timeout+0xc9/0x140
	 schedule_timeout_interruptible+0x28/0x30
	 stutter_wait+0x18a/0x220
	 rcu_torture_reader+0xfc/0x330
	 kthread+0x1fa/0x210
	 ret_from_fork+0x22/0x30

So one option would be to add the READ_ONCE(), but put an RCU wrapper
around schedule_timeout_interruptible() to allow rcutorture to either
show all data races or only those directly related to RCU.  The reason for
wanting it to show only those directly related to RCU is that this allows
me to much more easily spot a new RCU-related data race.  The reason
for wanting it to (only sometimes!) show all data races is to help track
down any non-RCU bugs that might be afficting my rcutorture runs.

Make sense?

							Thanx, Paul

------------------------------------------------------------------------

    129 BUG: KCSAN: data-race in prandom_bytes / prandom_u32
    123 BUG: KCSAN: data-race in __hrtimer_run_queues / hrtimer_active
     56 BUG: KCSAN: data-race in mutex_spin_on_owner+0x13d/0x260
     51 BUG: KCSAN: data-race in prandom_u32 / prandom_u32
     41 BUG: KCSAN: data-race in __run_timers / try_to_del_timer_sync
     37 BUG: KCSAN: data-race in tick_sched_timer / tick_sched_timer
     34 BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event
     26 BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_idle_stop_tick
*    18 BUG: KCSAN: data-race in __run_timers / rcu_torture_reader
     16 BUG: KCSAN: data-race in __hrtimer_run_queues / hrtimer_try_to_cancel
     16 BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_sched_timer
      6 BUG: KCSAN: data-race in cpumask_next+0x20/0x50
      6 BUG: KCSAN: data-race in __mod_timer / __run_timers
      6 BUG: KCSAN: data-race in run_timer_softirq / try_to_del_timer_sync
      6 BUG: KCSAN: data-race in rwsem_spin_on_owner+0x144/0x230
      6 BUG: KCSAN: data-race in tick_nohz_next_event / tick_sched_timer
      5 BUG: KCSAN: data-race in cpumask_next_and+0x25/0x60
      4 BUG: KCSAN: data-race in _find_next_bit+0x3f/0x120
      4 BUG: KCSAN: data-race in ps2_do_sendbyte / ps2_handle_ack
      4 BUG: KCSAN: data-race in rcu_preempt_deferred_qs_irqrestore / try_to_take_rt_mutex
      4 BUG: KCSAN: data-race in rcu_torture_reader / run_timer_softirq
      3 BUG: KCSAN: data-race in cpumask_next_and+0x27/0x70
      3 BUG: KCSAN: data-race in cpumask_next_and+0x30/0x60
      3 BUG: KCSAN: data-race in cpumask_next_wrap+0x4b/0xa0
      3 BUG: KCSAN: data-race in do_raw_write_lock / do_raw_write_unlock
      3 BUG: KCSAN: data-race in process_one_work / queue_work_on
      3 BUG: KCSAN: data-race in timer_clear_idle / trigger_dyntick_cpu
      2 BUG: KCSAN: data-race in do_raw_write_lock / do_raw_write_lock
      2 BUG: KCSAN: data-race in ktime_get_real_fast_ns+0x7d/0x130
      2 BUG: KCSAN: data-race in ktime_get_real_fast_ns+0xb5/0x130
      2 BUG: KCSAN: data-race in __mod_timer / run_timer_softirq
      2 BUG: KCSAN: data-race in queue_work_on / worker_thread
      1 BUG: KCSAN: data-race in bringup_cpu / cpuhp_should_run
      1 BUG: KCSAN: data-race in can_stop_idle_tick / tick_sched_timer
      1 BUG: KCSAN: data-race in internal_add_timer / update_process_times
      1 BUG: KCSAN: data-race in rcu_nocb_cb_kthread / rcu_nocb_gp_kthread
      1 BUG: KCSAN: data-race in rcu_preempt_deferred_qs_irqrestore / rt_mutex_unlock
      1 BUG: KCSAN: data-race in __ww_mutex_lock+0x1a3/0x1610
