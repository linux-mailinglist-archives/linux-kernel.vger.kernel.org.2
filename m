Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC33680AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbhDVMkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbhDVMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:38:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ABAC061342
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=y+OjswArZXc+ybv0At+ukN79xcpqwy7Qor1liHcadws=; b=mY141mMTOhwkF6y0g1O91kP3EA
        Mq8K2MfJsJCbBfQ6Rs2HDK/jMwnpUycK25m1XCksR64bB7X3Oi6gUS9d49gqybKE5YG9fuVQ1q3nA
        zqPYkUMs4jjtqMcdxxl9aiOdLk/4gh+xdeeTydMCs4tpNRiPzF68Q64LbmtztScH0f4R59pzCIDpH
        rEe0tfO6nPYWcY9V0yLWk+4ZAUC6+mHkYZN6OuDj22+ijBP/JKwXeqppkJRHM/n2A/YI/hQQK5OoX
        35xUsovVmBRNxGtPjT9hIlM7K4BaNhFrDlWNkXwifp2OEA052QBmWO/d8cKSo5NQQ+11MiUp4ZGTM
        CgmihExQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZ2-00GiYz-Mx; Thu, 22 Apr 2021 12:38:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D053300322;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5DDC62C67A902; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.738542617@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 13/19] sched/fair: Snapshot the min_vruntime of CPUs on force idle
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

During force-idle, we end up doing cross-cpu comparison of vruntimes
during pick_next_task. If we simply compare (vruntime-min_vruntime)
across CPUs, and if the CPUs only have 1 task each, we will always
end up comparing 0 with 0 and pick just one of the tasks all the time.
This starves the task that was not picked. To fix this, take a snapshot
of the min_vruntime when entering force idle and use it for comparison.
This min_vruntime snapshot will only be used for cross-CPU vruntime
comparison, and nothing else.

A note about the min_vruntime snapshot and force idling:

During selection:

  When we're not fi, we need to update snapshot.
  when we're fi and we were not fi, we must update snapshot.
  When we're fi and we were already fi, we must not update snapshot.

Which gives:

  fib     fi      update
  0       0       1
  0       1       1
  1       0       1
  1       1       0

Where:

  fi:  force-idled now
  fib: force-idled before

So the min_vruntime snapshot needs to be updated when: !(fib && fi).

Also, the cfs_prio_less() function needs to be aware of whether the
core is in force idle or not, since it will be use this information to
know whether to advance a cfs_rq's min_vruntime_fi in the hierarchy.
So pass this information along via pick_task() -> prio_less().

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   59 +++++++++++++++++++++++-----------------
 kernel/sched/fair.c  |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |    8 +++++
 3 files changed, 117 insertions(+), 25 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -101,7 +101,7 @@ static inline int __task_prio(struct tas
  */
 
 /* real prio, less is less */
-static inline bool prio_less(struct task_struct *a, struct task_struct *b)
+static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 {
 
 	int pa = __task_prio(a), pb = __task_prio(b);
@@ -115,19 +115,8 @@ static inline bool prio_less(struct task
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 vruntime = b->se.vruntime;
-
-		/*
-		 * Normalize the vruntime if tasks are in different cpus.
-		 */
-		if (task_cpu(a) != task_cpu(b)) {
-			vruntime -= task_cfs_rq(b)->min_vruntime;
-			vruntime += task_cfs_rq(a)->min_vruntime;
-		}
-
-		return !((s64)(a->se.vruntime - vruntime) <= 0);
-	}
+	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
+		return cfs_prio_less(a, b, in_fi);
 
 	return false;
 }
@@ -141,7 +130,7 @@ static inline bool __sched_core_less(str
 		return false;
 
 	/* flip prio, so high prio is leftmost */
-	if (prio_less(b, a))
+	if (prio_less(b, a, task_rq(a)->core->core_forceidle))
 		return true;
 
 	return false;
@@ -5145,7 +5134,7 @@ static inline bool cookie_match(struct t
  * - Else returns idle_task.
  */
 static struct task_struct *
-pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
+pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max, bool in_fi)
 {
 	struct task_struct *class_pick, *cookie_pick;
 	unsigned long cookie = rq->core->core_cookie;
@@ -5160,7 +5149,7 @@ pick_task(struct rq *rq, const struct sc
 		 * higher priority than max.
 		 */
 		if (max && class_pick->core_cookie &&
-		    prio_less(class_pick, max))
+		    prio_less(class_pick, max, in_fi))
 			return idle_sched_class.pick_task(rq);
 
 		return class_pick;
@@ -5179,19 +5168,22 @@ pick_task(struct rq *rq, const struct sc
 	 * the core (so far) and it must be selected, otherwise we must go with
 	 * the cookie pick in order to satisfy the constraint.
 	 */
-	if (prio_less(cookie_pick, class_pick) &&
-	    (!max || prio_less(max, class_pick)))
+	if (prio_less(cookie_pick, class_pick, in_fi) &&
+	    (!max || prio_less(max, class_pick, in_fi)))
 		return class_pick;
 
 	return cookie_pick;
 }
 
+extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
+
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
+	bool fi_before = false;
 	bool need_sync;
 	int i, j, cpu;
 
@@ -5273,9 +5265,14 @@ pick_next_task(struct rq *rq, struct tas
 
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
+			/*
+			 * For robustness, update the min_vruntime_fi for
+			 * unconstrained picks as well.
+			 */
+			WARN_ON_ONCE(fi_before);
+			task_vruntime_update(rq, next, false);
 			goto done;
 		}
-		need_sync = true;
 	}
 
 	for_each_cpu(i, smt_mask) {
@@ -5306,11 +5303,16 @@ pick_next_task(struct rq *rq, struct tas
 			 * highest priority task already selected for this
 			 * core.
 			 */
-			p = pick_task(rq_i, class, max);
+			p = pick_task(rq_i, class, max, fi_before);
 			if (!p)
 				continue;
 
 			rq_i->core_pick = p;
+			if (rq_i->idle == p && rq_i->nr_running) {
+				rq->core->core_forceidle = true;
+				if (!fi_before)
+					rq->core->core_forceidle_seq++;
+			}
 
 			/*
 			 * If this new candidate is of higher priority than the
@@ -5329,6 +5331,7 @@ pick_next_task(struct rq *rq, struct tas
 				max = p;
 
 				if (old_max) {
+					rq->core->core_forceidle = false;
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
 							continue;
@@ -5369,10 +5372,16 @@ pick_next_task(struct rq *rq, struct tas
 		if (!rq_i->core_pick)
 			continue;
 
-		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
-		    !rq_i->core->core_forceidle) {
-			rq_i->core->core_forceidle = true;
-		}
+		/*
+		 * Update for new !FI->FI transitions, or if continuing to be in !FI:
+		 * fi_before     fi      update?
+		 *  0            0       1
+		 *  0            1       1
+		 *  1            0       1
+		 *  1            1       0
+		 */
+		if (!(fi_before && rq->core->core_forceidle))
+			task_vruntime_update(rq_i, rq_i->core_pick, rq->core->core_forceidle);
 
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10727,6 +10727,81 @@ static inline void task_tick_core(struct
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
+
+/*
+ * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
+ */
+static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forceidle)
+{
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		if (forceidle) {
+			if (cfs_rq->forceidle_seq == fi_seq)
+				break;
+			cfs_rq->forceidle_seq = fi_seq;
+		}
+
+		cfs_rq->min_vruntime_fi = cfs_rq->min_vruntime;
+	}
+}
+
+void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
+{
+	struct sched_entity *se = &p->se;
+
+	if (p->sched_class != &fair_sched_class)
+		return;
+
+	se_fi_update(se, rq->core->core_forceidle_seq, in_fi);
+}
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
+{
+	struct rq *rq = task_rq(a);
+	struct sched_entity *sea = &a->se;
+	struct sched_entity *seb = &b->se;
+	struct cfs_rq *cfs_rqa;
+	struct cfs_rq *cfs_rqb;
+	s64 delta;
+
+	SCHED_WARN_ON(task_rq(b)->core != rq->core);
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	/*
+	 * Find an se in the hierarchy for tasks a and b, such that the se's
+	 * are immediate siblings.
+	 */
+	while (sea->cfs_rq->tg != seb->cfs_rq->tg) {
+		int sea_depth = sea->depth;
+		int seb_depth = seb->depth;
+
+		if (sea_depth >= seb_depth)
+			sea = parent_entity(sea);
+		if (sea_depth <= seb_depth)
+			seb = parent_entity(seb);
+	}
+
+	se_fi_update(sea, rq->core->core_forceidle_seq, in_fi);
+	se_fi_update(seb, rq->core->core_forceidle_seq, in_fi);
+
+	cfs_rqa = sea->cfs_rq;
+	cfs_rqb = seb->cfs_rq;
+#else
+	cfs_rqa = &task_rq(a)->cfs;
+	cfs_rqb = &task_rq(b)->cfs;
+#endif
+
+	/*
+	 * Find delta after normalizing se's vruntime with its cfs_rq's
+	 * min_vruntime_fi, which would have been updated in prior calls
+	 * to se_fi_update().
+	 */
+	delta = (s64)(sea->vruntime - seb->vruntime) +
+		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
+
+	return delta > 0;
+}
 #else
 static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
 #endif
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -517,6 +517,11 @@ struct cfs_rq {
 
 	u64			exec_clock;
 	u64			min_vruntime;
+#ifdef CONFIG_SCHED_CORE
+	unsigned int		forceidle_seq;
+	u64			min_vruntime_fi;
+#endif
+
 #ifndef CONFIG_64BIT
 	u64			min_vruntime_copy;
 #endif
@@ -1075,6 +1080,7 @@ struct rq {
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
 	unsigned char		core_forceidle;
+	unsigned int		core_forceidle_seq;
 #endif
 };
 
@@ -1130,6 +1136,8 @@ static inline raw_spinlock_t *rq_lockp(s
 	return &rq->__lock;
 }
 
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)


