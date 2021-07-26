Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546C43D59E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhGZMPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234310AbhGZMPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:15:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AACE60F5B;
        Mon, 26 Jul 2021 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627304136;
        bh=Y6Q1zU1EE3FHweXtO3FdGSQmfD6kw20XjAb9W1B4cCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spFo+fr6iPT7oUnJDGd0OJH+Qh9iFEeYzEFTutY9CN1sJToxu7rJuZUUlHJTYxBs9
         hwJf80Amq+wsr5OBoLzC3VTTxGJL/sTGHJMx5vBNTYByc6XQzR+BN3GPub8lauf1uw
         uCWwHl8wD8DyGSPzl7mGsl5ekm11ORcTHxHmHK3TLMJr8ZlHwEZFwLZQc76Zv/ZsFt
         wEd2MHWPnzf0WTZ5g/PNCZFtKlT4RbvAXo0IZjmv1LqrT3uZDGQuDpTW0lh2EbIDsa
         S8dyp5FXMMcWdf6q9TgWjvA4RCIbqne53wkttoExw4nt0WIMBw5vwEwEoWgn7iguik
         8fD3gZ/4Ewznw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 6/6] posix-cpu-timers: Recalc next expiration when timer_settime() ends up not queueing
Date:   Mon, 26 Jul 2021 14:55:13 +0200
Message-Id: <20210726125513.271824-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726125513.271824-1-frederic@kernel.org>
References: <20210726125513.271824-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several scenarios that can result in posix_cpu_timer_set()
not queueing the timer but still leave the threadroup cputime counter
running or keep the tick dependency around for a random amount of time.

1) If timer_settime() is called with a 0 expiration on a timer that is
   already disabled, the process wide cputime counter will be started
   and won't ever get a chance to be stopped by stop_process_timer()
   since no timer is actually armed to be processed.

   The following snippet is enough to trigger the issue.

	void trigger_process_counter(void)
	{
		timer_t id;
		struct itimerspec val = { };

		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
		timer_settime(id, TIMER_ABSTIME, &val, NULL);
		timer_delete(id);
	}

2) If timer_settime() is called with a 0 expiration on a timer that is
   already armed, the timer is dequeued but not really disarmed. So the
   process wide cputime counter and the tick dependency may still remain
   a while around.

   The following code snippet keeps this overhead around for one week after
   the timer deletion:

	void trigger_process_counter(void)
	{
		timer_t id;
		struct itimerspec val = { };

		val.it_value.tv_sec = 604800;
		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
		timer_settime(id, 0, &val, NULL);
		timer_delete(id);
	}

3) If the timer was initially deactivated, this call to timer_settime()
   with an early expiration may have started the process wide cputime
   counter even though the timer hasn't been queued and armed because it
   has fired early and inline within posix_cpu_timer_set() itself. As a
   result the process wide cputime counter may never stop until a new
   timer is ever armed in the future.

   The following code snippet can reproduce this:

	void trigger_process_counter(void)
	{
		timer_t id;
		struct itimerspec val = { };

		signal(SIGALRM, SIG_IGN);
		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
		val.it_value.tv_nsec = 1;
		timer_settime(id, TIMER_ABSTIME, &val, NULL);
	}

4) If the timer was initially armed with a former expiration value
   before this call to timer_settime() and the current call sets an
   early deadline that has already expired, the timer fires inline
   within posix_cpu_timer_set(). In this case it must have been dequeued
   before firing inline with its new expiration value, yet it hasn't
   been disarmed in this case. So the process wide cputime counter and
   the tick dependency may still be around for a while even after the
   timer fired.

   The following code snippet can reproduce this:

	void trigger_process_counter(void)
	{
		timer_t id;
		struct itimerspec val = { };

		signal(SIGALRM, SIG_IGN);
		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
		val.it_value.tv_sec = 100;
		timer_settime(id, TIMER_ABSTIME, &val, NULL);
		val.it_value.tv_sec = 0;
		val.it_value.tv_nsec = 1;
		timer_settime(id, TIMER_ABSTIME, &val, NULL);
	}

Fix all these issues with triggering the related base next expiration
recalculation on the next tick. This also implies to re-evaluate the
need to keep around the process wide cputime counter and the tick
dependency, in a similar fashion to disarm_timer().

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/posix-timers.h   |  7 +++++-
 kernel/time/posix-cpu-timers.c | 41 +++++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 4cf1fbe8d1bc..00fef0064355 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -82,9 +82,14 @@ static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
 	return timerqueue_add(head, &ctmr->node);
 }
 
+static inline bool cpu_timer_queued(struct cpu_timer *ctmr)
+{
+	return !!ctmr->head;
+}
+
 static inline bool cpu_timer_dequeue(struct cpu_timer *ctmr)
 {
-	if (ctmr->head) {
+	if (cpu_timer_queued(ctmr)) {
 		timerqueue_del(ctmr->head, &ctmr->node);
 		ctmr->head = NULL;
 		return true;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0d918117a3e0..ee736861b18f 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -418,6 +418,20 @@ static struct posix_cputimer_base *timer_base(struct k_itimer *timer,
 		return tsk->signal->posix_cputimers.bases + clkidx;
 }
 
+/*
+ * Force recalculating the base earliest expiration on the next tick.
+ * This will also re-evaluate the need to keep around the process wide
+ * cputime counter and tick dependency and eventually shut these down
+ * if necessary.
+ */
+static void trigger_base_recalc_expires(struct k_itimer *timer,
+					struct task_struct *tsk)
+{
+	struct posix_cputimer_base *base = timer_base(timer, tsk);
+
+	base->nextevt = 0;
+}
+
 /*
  * Dequeue the timer and reset the base if it was its earliest expiration.
  * It makes sure the next tick recalculates the base next expiration so we
@@ -438,7 +452,7 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 
 	base = timer_base(timer, p);
 	if (cpu_timer_getexpires(ctmr) == base->nextevt)
-		base->nextevt = 0;
+		trigger_base_recalc_expires(timer, p);
 }
 
 
@@ -734,13 +748,28 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (new_expires != 0 && !(val < new_expires)) {
+	if (val >= new_expires) {
+		if (new_expires != 0) {
+			/*
+			 * The designated time already passed, so we notify
+			 * immediately, even if the thread never runs to
+			 * accumulate more time on this clock.
+			 */
+			cpu_timer_fire(timer);
+		}
+
 		/*
-		 * The designated time already passed, so we notify
-		 * immediately, even if the thread never runs to
-		 * accumulate more time on this clock.
+		 * Make sure we don't keep around the process wide cputime
+		 * counter or the tick dependency if they are not necessary.
 		 */
-		cpu_timer_fire(timer);
+		sighand = lock_task_sighand(p, &flags);
+		if (!sighand)
+			goto out;
+
+		if (!cpu_timer_queued(ctmr))
+			trigger_base_recalc_expires(timer, p);
+
+		unlock_task_sighand(p, &flags);
 	}
  out:
 	rcu_read_unlock();
-- 
2.25.1

