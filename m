Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB65139B7F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhFDLeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhFDLeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:34:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C724561422;
        Fri,  4 Jun 2021 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622806334;
        bh=BO6zwXdpdvSkGFwPk+Al+5ccyF9S9WmwtFjhWTF+8dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TW1iwU7KLiEdBPKjrUButznSKWzcUtYnG+KKT2mT7uFPSSpWKdq6K6STPUc93q5OK
         FppaNupKMGSGgXE1EybWksBz+GjeEu01FfXHsyGvkqvZj8dg6oWbC/5ZGiXqCq2TT8
         99moLzgd3OTYO6dJ5AdDiZ9LZwgr4csyZfy351QFFcwmIEBXaj10qJ41ryjBBn2BUb
         CqZaeJtlaMWnm4IKaPITM5VaKXuvYIbgkgoKrRiHmOHh32hRGwk6Oct8aMKBt2TDfu
         LTWJ0p8uv4Gci/AO9f1OVwhuZBT9Wmo4sJ92PA9YzciFXFvLNdeqI0fgdz+0blf0ic
         3jJt2Zu0ClNBw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5/6] posix-cpu-timers: Force next expiration recalc after early timer firing
Date:   Fri,  4 Jun 2021 13:31:58 +0200
Message-Id: <20210604113159.26177-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604113159.26177-1-frederic@kernel.org>
References: <20210604113159.26177-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fire a per-process oneshot timer early and inline from the actual
call to timer_settime(), two issues can happen:

1) If the timer was initially deactivated, this call to timer_settime()
   may have started the process wide cputime counter even though the
   timer hasn't been queued and armed. As a result the process wide
   cputime counter may never stop until a new timer is ever armed in
   the future.

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

2) If the timer was initially armed with a former expiration value
   before this call to timer_settime(), it must have been dequeued
   before firing inline with its new expiration value. Yet it hasn't
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

To solve the first case, the base next event value needs to be explicilty
reset so that the target's next tick deactivates the process cputime
counter if necessary.

To solve the second case, the timer with its former value is explicitly
disarmed and not just dequeued so that the target's next tick deactivates
the process cputime counter and the tick dependency if necessary.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/posix-timers.h   |  7 ++++-
 kernel/time/posix-cpu-timers.c | 51 ++++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 15 deletions(-)

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
index 0b5715c8db04..d8325a906314 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -405,6 +405,21 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 	return 0;
 }
 
+static void __disarm_timer(struct k_itimer *timer, struct task_struct *p,
+			   u64 old_expires)
+{
+	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
+	struct posix_cputimer_base *base;
+
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		base = p->posix_cputimers.bases + clkidx;
+	else
+		base = p->signal->posix_cputimers.bases + clkidx;
+
+	if (old_expires == base->nextevt)
+		base->nextevt = 0;
+}
+
 /*
  * Dequeue the timer and reset the base if it was its earliest expiration.
  * It makes sure the next tick recalculates the base next expiration so we
@@ -415,24 +430,14 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 old_expires = cpu_timer_getexpires(ctmr);
-	struct posix_cputimer_base *base;
 	bool queued;
-	int clkidx;
 
 	queued = cpu_timer_dequeue(ctmr);
 	cpu_timer_setexpires(ctmr, 0);
 	if (!queued)
 		return;
 
-	clkidx = CPUCLOCK_WHICH(timer->it_clock);
-
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		base = p->posix_cputimers.bases + clkidx;
-	else
-		base = p->signal->posix_cputimers.bases + clkidx;
-
-	if (old_expires == base->nextevt)
-		base->nextevt = 0;
+	__disarm_timer(timer, p, old_expires);
 }
 
 
@@ -686,8 +691,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			u64 exp = bump_cpu_timer(timer, val);
 
 			if (val < exp) {
-				old_expires = exp - val;
-				old->it_value = ns_to_timespec64(old_expires);
+				old->it_value = ns_to_timespec64(exp - val);
 			} else {
 				old->it_value.tv_nsec = 1;
 				old->it_value.tv_sec = 0;
@@ -748,9 +752,28 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 		 * accumulate more time on this clock.
 		 */
 		cpu_timer_fire(timer);
+
+		sighand = lock_task_sighand(p, &flags);
+		if (sighand == NULL)
+			goto out;
+		if (!cpu_timer_queued(&timer->it.cpu)) {
+			/*
+			 * Disarm the previous timer to deactivate the tick
+			 * dependency and process wide cputime counter if
+			 * necessary.
+			 */
+			__disarm_timer(timer, p, old_expires);
+			/*
+			 * If the previous timer was deactivated, we might have
+			 * just started the process wide cputime counter. Make
+			 * sure we poke the tick to deactivate it then.
+			 */
+			if (!old_expires && !CPUCLOCK_PERTHREAD(timer->it_clock))
+				p->signal->posix_cputimers.bases[clkid].nextevt = 0;
+		}
+		unlock_task_sighand(p, &flags);
 	}
 
-	ret = 0;
  out:
 	rcu_read_unlock();
 	if (old)
-- 
2.25.1

