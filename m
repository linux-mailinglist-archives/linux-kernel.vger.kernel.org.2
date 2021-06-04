Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F52239B7F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFDLd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhFDLd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:33:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0177261414;
        Fri,  4 Jun 2021 11:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622806330;
        bh=KlLBEMEdqi0epe6fPxGlME4m214IZeWzy7tdD9dk7R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvhflCfgsRWz1vXdD0HuXT2NCiquWBUX85eW4PwMCkFoTpV/jajgNBQqNA/CfYRm4
         b+672Gqsc+Dg6AUGN77DvzdyY6Qn7B90mW1x+smeCslZe3/9Ut4pNqgkZcgWxgLry1
         MaRVOEWaa8d7Q+jfYqAmy4ZFr7Y0RVHwu7opzheG2l5IDUdDAE7mvyxDah48VHo9Ew
         MYiacGbpeBaInVbloJar55XA0Pxn0AtwpQ0MdYGZUC9wc38NKNmLB6ah5V0RqyORYU
         H9GRkkI0WJBpQ6RqtUcOZ4oT04eDXIAH6q4EszW1WZ20T4Zc2Q+qNQsYIh+rLkMfqK
         Nf/J/BePb9rYw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3/6] posix-cpu-timers: Force next_expiration recalc after timer deletion
Date:   Fri,  4 Jun 2021 13:31:56 +0200
Message-Id: <20210604113159.26177-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604113159.26177-1-frederic@kernel.org>
References: <20210604113159.26177-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A timer deletion only dequeues the timer but it doesn't shutdown
the related costly process wide cputimer counter and the tick dependency.

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

Make sure the next target's tick recalculates the nearest expiration and
clears the process wide counter and tick dependency if necessary.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/posix-timers.h   |  4 +++-
 kernel/time/posix-cpu-timers.c | 29 ++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 896c16d2c5fb..4cf1fbe8d1bc 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -82,12 +82,14 @@ static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
 	return timerqueue_add(head, &ctmr->node);
 }
 
-static inline void cpu_timer_dequeue(struct cpu_timer *ctmr)
+static inline bool cpu_timer_dequeue(struct cpu_timer *ctmr)
 {
 	if (ctmr->head) {
 		timerqueue_del(ctmr->head, &ctmr->node);
 		ctmr->head = NULL;
+		return true;
 	}
+	return false;
 }
 
 static inline u64 cpu_timer_getexpires(struct cpu_timer *ctmr)
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 132fd56fb1cd..bb1f862c785e 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -405,6 +405,33 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 	return 0;
 }
 
+/*
+ * Dequeue the timer and reset the base if it was its earliest expiration.
+ * It makes sure the next tick recalculates the base next expiration so we
+ * don't keep the costly process wide cputime counter around for a random
+ * amount of time, along with the tick dependency.
+ */
+static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
+{
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	struct posix_cputimer_base *base;
+	int clkidx;
+
+	if (!cpu_timer_dequeue(ctmr))
+		return;
+
+	clkidx = CPUCLOCK_WHICH(timer->it_clock);
+
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		base = p->posix_cputimers.bases + clkidx;
+	else
+		base = p->signal->posix_cputimers.bases + clkidx;
+
+	if (cpu_timer_getexpires(ctmr) == base->nextevt)
+		base->nextevt = 0;
+}
+
+
 /*
  * Clean up a CPU-clock timer that is about to be destroyed.
  * This is called from timer deletion with the timer already locked.
@@ -439,7 +466,7 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		if (timer->it.cpu.firing)
 			ret = TIMER_RETRY;
 		else
-			cpu_timer_dequeue(ctmr);
+			disarm_timer(timer, p);
 
 		unlock_task_sighand(p, &flags);
 	}
-- 
2.25.1

