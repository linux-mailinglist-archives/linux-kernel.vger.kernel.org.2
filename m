Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF640C763
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbhIOOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233935AbhIOOY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:24:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ED56610E9;
        Wed, 15 Sep 2021 14:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631715787;
        bh=eTPRL0lrN3Tly2YHaW+S68RBnHDX61hqsVRtb7XXK5s=;
        h=From:To:Cc:Subject:Date:From;
        b=tHZtNqqCIC9WwaOTLc4voERArPKNqs7J25Os0rCKOqAOMk3c1Ts452YtRgmvXoXC8
         xaELy/nMrfAQIqNzcTdHR9NESdKWSFtNlUH/07axwuoO45X/kCoeLswk4yQoOiusIl
         Hm49nl+N2lI0nVL8YF0Fdboq9AJJHEl0BPdXiF5AKtho47NoYITEGZUrxd2BbzS3ma
         J7VmkcwauHMhAIybsluc2MpM/B3EDDnayBg4PW2E1iDRKMpoOvrjYaxm2DFKR8Uxeg
         l7OqEIIj1lOtFc0mCqyBjkfK5if9u/LnrReLddXsqRZVoE+tyr8qVUe35Q0hUNNvex
         a2Sqc0fRoTi7Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/1] timers/nohz: Last resort update jiffies on nohz_full IRQ entry
Date:   Wed, 15 Sep 2021 16:23:03 +0200
Message-Id: <20210915142303.24297-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When at least one CPU runs in nohz_full mode, a dedicated timekeeper CPU
is guaranteed to stay online and to never stop its tick.

Meanwhile on some rare case, the dedicated timekeeper may be running
with interrupts disabled for a while, such as in stop_machine.

If jiffies stop being updated, a nohz_full CPU may end up endlessly
programming the next tick in the past, taking the last jiffies update
monotonic timestamp as a stale base, resulting in an tick storm.

Here is a scenario where it matters:

0) CPU 0 is the timekeeper and CPU 1 a nohz_full CPU.

1) A stop machine callback is queued to execute somewhere.

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

6) The tick fires immediately, goto 3)

7) Tick storm, the nohz_full CPU is drown and takes ages to reach
   MULTI_STOP_DISABLE_IRQ, which is the only way out of this situation.

Solve this with unconditionally updating jiffies if the value is stale
on nohz_full IRQ entry. IRQs and other disturbances are expected to be
rare enough on nohz_full for the unconditional call to ktime_get() to
actually matter.

Reported-and-tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/softirq.c         | 3 ++-
 kernel/time/tick-sched.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

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
-- 
2.25.1

