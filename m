Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738BF3B10BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhFVXog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 19:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhFVXoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 19:44:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDEC0611CA;
        Tue, 22 Jun 2021 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624405336;
        bh=XPa3V7robUtgpIHuj3twDwCKwhVMaB3VZQaNb/U7R10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdHj14c6UAO1eiWkFxxWih14g+TNGZjepwq5109d86WsvmKJLz0ItRrD6nUyrdiJs
         WK48ebesI4GpsHAlycdXlTzZ6/Wsy9lkn3lG/vJ/NSrOuOUuFeWUKHsURsQp8z6S3N
         pLQVWk3WiGWVaUlcpCx2d/In6Za/hn3ebFxBeISwl4VNhB8lyJbNxj/QRfF6Pe5Suk
         2RtPu5Y3l4+tcVC2S7MQVcbWGgUfOSKrSoTmNVB5tuXrXyUitOHjRizJ9J9aFkMWXe
         gz2OFqvqXmb82uu5VgFFbgg3ygrIWxNALKzqpFttgQ+Ey7DOB9AfOLB4GzbKPT23SL
         Jo5VZKLZJeLcQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 7/7] posix-cpu-timers: Recalc next expiration when timer_settime() ends up not queueing
Date:   Wed, 23 Jun 2021 01:41:55 +0200
Message-Id: <20210622234155.119685-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210622234155.119685-1-frederic@kernel.org>
References: <20210622234155.119685-1-frederic@kernel.org>
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
index acc6843d4b31..8527bd5b4030 100644
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

