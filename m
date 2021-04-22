Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899393680AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbhDVMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbhDVMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:38:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0805BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=a6njO43jSaonKc+5YUYXd6HmtS5fmuoE9MQ8zUzxLwQ=; b=lwr63Ghjd5dLB71he7ilrCe+a5
        4R1M59hKYWKKgczx4CsPRkDNYcep42PfA0HUqIl/0avAFho/k2MbGyD8VBWhtQRrL26pkwTjlTHRx
        VKXdVt8BCD1h7krcGquU9LTTewF87/C57nixrhN22InKQciPENL0iEIyyyOsCDvfUSrTiqegqngUm
        LIP/aUuA7K4tUAkr6hYk7OetrzbugONDgmlQeMe1FonkcVLXflb1Ynpl8g1CdkeJWz1AZ/5qCTmR4
        AjZfV1pYHUpKGzRuuw4Deb/ihbV4DkTSTimR9Bzrp7w2FGDc6I7Mp8MdRpejgpcrXsltmx9r12fBY
        Paz8DdaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZ2-00GiYy-Mq; Thu, 22 Apr 2021 12:38:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 777D930031D;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 536C62C67A900; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.617407840@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, Vineeth Pillai <viremana@linux.microsoft.com>
Subject: [PATCH 11/19] sched/fair: Fix forced idle sibling starvation corner case
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

If there is only one long running local task and the sibling is
forced idle, it  might not get a chance to run until a schedule
event happens on any cpu in the core.

So we check for this condition during a tick to see if a sibling
is starved and then give it a chance to schedule.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  | 15 ++++++++-------
 kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 +-
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bd0b0bbb040..52d0e83072a4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5206,16 +5206,15 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* reset state */
 	rq->core->core_cookie = 0UL;
+	if (rq->core->core_forceidle) {
+		need_sync = true;
+		rq->core->core_forceidle = false;
+	}
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
 		rq_i->core_pick = NULL;
 
-		if (rq_i->core_forceidle) {
-			need_sync = true;
-			rq_i->core_forceidle = false;
-		}
-
 		if (i != cpu)
 			update_rq_clock(rq_i);
 	}
@@ -5335,8 +5334,10 @@ next_class:;
 		if (!rq_i->core_pick)
 			continue;
 
-		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running)
-			rq_i->core_forceidle = true;
+		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
+		    !rq_i->core->core_forceidle) {
+			rq_i->core->core_forceidle = true;
+		}
 
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f53681cd263e..42965c4fd71f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10692,6 +10692,44 @@ static void rq_offline_fair(struct rq *rq)
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_SCHED_CORE
+static inline bool
+__entity_slice_used(struct sched_entity *se, int min_nr_tasks)
+{
+	u64 slice = sched_slice(cfs_rq_of(se), se);
+	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+
+	return (rtime * min_nr_tasks > slice);
+}
+
+#define MIN_NR_TASKS_DURING_FORCEIDLE	2
+static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	/*
+	 * If runqueue has only one task which used up its slice and
+	 * if the sibling is forced idle, then trigger schedule to
+	 * give forced idle task a chance.
+	 *
+	 * sched_slice() considers only this active rq and it gets the
+	 * whole slice. But during force idle, we have siblings acting
+	 * like a single runqueue and hence we need to consider runnable
+	 * tasks on this cpu and the forced idle cpu. Ideally, we should
+	 * go through the forced idle rq, but that would be a perf hit.
+	 * We can assume that the forced idle cpu has atleast
+	 * MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks and use that to check
+	 * if we need to give up the cpu.
+	 */
+	if (rq->core->core_forceidle && rq->cfs.nr_running == 1 &&
+	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
+		resched_curr(rq);
+}
+#else
+static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
+#endif
+
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -10715,6 +10753,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+
+	task_tick_core(rq, curr);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 63b28e1843ee..be656ca8693d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1069,12 +1069,12 @@ struct rq {
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
-	unsigned char		core_forceidle;
 
 	/* shared state */
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
+	unsigned char		core_forceidle;
 #endif
 };
 
-- 
2.29.2.299.gdc1121823c-goog



