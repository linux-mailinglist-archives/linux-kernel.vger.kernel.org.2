Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA073D59E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhGZMPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234179AbhGZMPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:15:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9168D60F57;
        Mon, 26 Jul 2021 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627304129;
        bh=xtJus25PbSxnqcNCERKn5vxKOyVzPZzDAWtGW0CsVjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGuJFNYWwSMth3CbcjVFECYvhMbCIx7pMJ/BHno9tGzJ/eUoIPjdYRQksduhRgHTx
         lUix23vMCK+foniV/ofv5ch2tkD599tTNFpd1gY06P61iTxpKMC1hBAfHSPlWaxjz6
         wRY15ZK9Hr8hlFoVmg3S90ricnx9gR2NV58+8CTMdVGVAoKoO+yo47C2KzMp/UIfPy
         1OJwrY7OuNjjdU5widKL8XkQwTP495mtw8rLl+eLxKGULq3zYUm9IexrPaeyokaDry
         P6YLC5lRy6FtVdQw8/Sgr1/MWMyP5V4de4o6Nwn5zziPrkECUHby+rO2XMe3DU9cOv
         Qdzdie5j3yI/g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 2/6] posix-cpu-timers: Force next_expiration recalc after timer deletion
Date:   Mon, 26 Jul 2021 14:55:09 +0200
Message-Id: <20210726125513.271824-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726125513.271824-1-frederic@kernel.org>
References: <20210726125513.271824-1-frederic@kernel.org>
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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/posix-timers.h   |  4 +++-
 kernel/time/posix-cpu-timers.c | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

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
index 4693d3c71e7e..61c78b62fe6a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -407,6 +407,37 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 	return 0;
 }
 
+/*
+ * Dequeue the timer and reset the base if it was its earliest expiration.
+ * It makes sure the next tick recalculates the base next expiration so we
+ * don't keep the costly process wide cputime counter around for a random
+ * amount of time, along with the tick dependency.
+ *
+ * If another timer gets queued between this and the next tick, its
+ * expiration will update the base next event if necessary on the next
+ * tick.
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
@@ -441,7 +472,7 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		if (timer->it.cpu.firing)
 			ret = TIMER_RETRY;
 		else
-			cpu_timer_dequeue(ctmr);
+			disarm_timer(timer, p);
 
 		unlock_task_sighand(p, &flags);
 	}
-- 
2.25.1

