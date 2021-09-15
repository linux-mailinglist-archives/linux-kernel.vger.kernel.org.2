Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13F940CBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhIORqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:46:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhIORqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:46:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3A8161164;
        Wed, 15 Sep 2021 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631727881;
        bh=153DCivB/K0pLBmVlnf+6nYHCZLGx19k2qUULWDghU0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=s8vPx9JnOZrbHBeL3w63s0Ev2E126p9xK/KVLi7bOgNORiU/Gu8+E5jmE9xfs8Kg3
         5QKHcUv2qoXPq0eaZSiXOq3iIprItmQ+2OzZRUWQyCKaksVYUdhpxbtEMPmdvg3qux
         p4hUTjboV/CSw9fo4BwH1iAnrMGLSkFy2CH5m1n7XkpsMZ0K8KTSYBFdASgBZd9oxc
         4swmymXlMzgX/NsN57iu94juy2gfDjXGN/B3Cbl2Of+FkpypxDmOhtyOVScZKU2TvR
         AOkmtxgZL1/1G0p0D6Aw+GG5mrKgusVUfz1UUt5PiLEchPU6jm8Gc7HCQGauNdZDui
         ZwwuU9qTXZEPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BD25A5C054E; Wed, 15 Sep 2021 10:44:40 -0700 (PDT)
Date:   Wed, 15 Sep 2021 10:44:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/1] timers/nohz: Last resort update jiffies on nohz_full
 IRQ entry
Message-ID: <20210915174440.GU4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210915142303.24297-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915142303.24297-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 04:23:03PM +0200, Frederic Weisbecker wrote:
> When at least one CPU runs in nohz_full mode, a dedicated timekeeper CPU
> is guaranteed to stay online and to never stop its tick.
> 
> Meanwhile on some rare case, the dedicated timekeeper may be running
> with interrupts disabled for a while, such as in stop_machine.
> 
> If jiffies stop being updated, a nohz_full CPU may end up endlessly
> programming the next tick in the past, taking the last jiffies update
> monotonic timestamp as a stale base, resulting in an tick storm.
> 
> Here is a scenario where it matters:
> 
> 0) CPU 0 is the timekeeper and CPU 1 a nohz_full CPU.
> 
> 1) A stop machine callback is queued to execute somewhere.
> 
> 2) CPU 0 reaches MULTI_STOP_DISABLE_IRQ while CPU 1 is still in
>    MULTI_STOP_PREPARE. Hence CPU 0 can't do its timekeeping duty. CPU 1
>    can still take IRQs.
> 
> 3) CPU 1 receives an IRQ which queues a timer callback one jiffy forward.
> 
> 4) On IRQ exit, CPU 1 schedules the tick one jiffy forward, taking
>    last_jiffies_update as a base. But last_jiffies_update hasn't been
>    updated for 2 jiffies since the timekeeper has interrupts disabled.
> 
> 5) clockevents_program_event(), which relies on ktime_get(), observes
>    that the expiration is in the past and therefore programs the min
>    delta event on the clock.
> 
> 6) The tick fires immediately, goto 3)
> 
> 7) Tick storm, the nohz_full CPU is drown and takes ages to reach
>    MULTI_STOP_DISABLE_IRQ, which is the only way out of this situation.
> 
> Solve this with unconditionally updating jiffies if the value is stale
> on nohz_full IRQ entry. IRQs and other disturbances are expected to be
> rare enough on nohz_full for the unconditional call to ktime_get() to
> actually matter.
> 
> Reported-and-tested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Nice, thank you!!!

I am assuming that this goes up through some other channel, but in
the meantime I have pulled it into -rcu for continued testing and
to get it into -next sooner rather than later.

I also could not resist wordsmithing as shown below.

							Thanx, Paul

------------------------------------------------------------------------

commit e603ba78a96dc69f31579908fcee4ae4eedb68ae
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Wed Sep 15 16:23:03 2021 +0200

    timers/nohz: Last resort update jiffies on nohz_full IRQ entry
    
    When at least one CPU runs in nohz_full mode, a dedicated timekeeper
    CPU is guaranteed to stay online and to never stop its tick.  Except
    that this timekeeper could be spinning with interrupts disabled for an
    extended period of time, for example, when in the midst of a stop-machine
    operation.
    
    This means that jiffies are no longer being updated, which in turn means
    that a nohz_full CPU can endlessly program its next tick in the past,
    which results in an tick storm.
    
    This situation can arise as follows:
    
    0) CPU 0 is the timekeeper and CPU 1 a nohz_full CPU.
    
    1) A stop-machine callback is queued.
    
    2) CPU 0 reaches MULTI_STOP_DISABLE_IRQ while CPU 1 is still in
       MULTI_STOP_PREPARE. Hence CPU 0 can't do its timekeeping duty. CPU 1
       can still take IRQs.
    
    3) CPU 1 receives an IRQ which queues a timer callback one jiffy forward.
    
    4) On IRQ exit, CPU 1 schedules the tick one jiffy forward, taking
       last_jiffies_update as a base. But last_jiffies_update hasn't been
       updated for 2 jiffies since the timekeeper has interrupts disabled.
    
    5) clockevents_program_event(), which relies on ktime_get(), observes
       that the expiration is in the past and therefore programs the min
       delta event on the clock.
    
    6) The tick fires immediately, goto 3), tick storm!
    
    7) The nohz_full CPU 1 makes no forward progress until such time as
       integer overflow causes the tick's expiration to actually be in
       the future, which after the better part of an hour finally allows
       CPU 1 to reach MULTI_STOP_DISABLE_IRQ.
    
    Solve this by unconditionally updating jiffies if the value is stale
    on nohz_full IRQ entry. IRQs and other disturbances are expected to be
    rare enough on nohz_full for the unconditional call to ktime_get() to
    incur negligible overhead.
    
    Reported-and-tested-by: Paul E. McKenney <paulmck@kernel.org>
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 322b65d45676..41f470929e99 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -595,7 +595,8 @@ void irq_enter_rcu(void)
 {
 	__irq_enter_raw();
 
-	if (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET))
+	if (tick_nohz_full_cpu(smp_processor_id()) ||
+	    (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET)))
 		tick_irq_enter();
 
 	account_hardirq_enter(current);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6bffe5af8cb1..17a283ce2b20 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1375,6 +1375,13 @@ static inline void tick_nohz_irq_enter(void)
 	now = ktime_get();
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
+	/*
+	 * If all CPUs are idle. We may need to update a stale jiffies value.
+	 * Note nohz_full is a special case: a timekeeper is guaranteed to stay
+	 * alive but it might be busy looping with interrupts disabled in some
+	 * rare case (typically stop machine). So we must make sure we have a
+	 * last resort.
+	 */
 	if (ts->tick_stopped)
 		tick_nohz_update_jiffies(now);
 }
