Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89693F5B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhHXJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbhHXJkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:40:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD80C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x0l6D8Amq+Z+YcfDlP2KUYELTI4Jv2mYpCv9nMVBlWg=; b=dGLKm+fUypuoGIorJ+QPzaZaWm
        4r+LzigBwT/MbxANA703U/RBWwAgp8pi70vFQD4siJPckMIzvYra6v6HprLPvnihwKBP21pta5ZLN
        VuurJXRa4m7TyAvGjULEXhJzEr2SRvkPj4PRoVyETCYhgDmYudZhTpJc7ixDapgfpqHII+loLvTDm
        TBtj0JChxPSbJu13CxmPhIWlDaKesrQQvT4SwUNKh5+sECVJ5n/cabqQq74z0KBz5q1Qin91gMkBO
        O1DVB6cfZwiFCEueN7S+TbhD0k2NQdS0WLF0AYw4u7vxm9nTuSWtl+MwYbks0viuAVFElQ7/BIbSQ
        le6Y3hGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mISse-00ArNC-Hd; Tue, 24 Aug 2021 09:38:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3B67300399;
        Tue, 24 Aug 2021 11:38:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CE2E20803E99; Tue, 24 Aug 2021 11:38:02 +0200 (CEST)
Date:   Tue, 24 Aug 2021 11:38:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineeth Pillai <vineethrp@gmail.com>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Subject: [PATCH] sched/core: Simplify core-wide task selection
Message-ID: <YSS9+k1teA9oPEKl@hirez.programming.kicks-ass.net>
References: <20210818005615.138527-1-joshdon@google.com>
 <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
 <CAOBnfPjH=y3Lk7AukLeG4mNcJnf5cgV260=PZCbF9u69-T+Q6Q@mail.gmail.com>
 <YSS1/rqqsGaBX/yQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSS1/rqqsGaBX/yQ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:03:58AM +0200, Peter Zijlstra wrote:
> Let me go do that and also attempt a Changelog to go with it ;-)

How's this then?

---
Subject: sched/core: Simplify core-wide task selection
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Aug 24 11:05:47 CEST 2021

Tao suggested a two-pass task selection to avoid the retry loop.

Not only does it avoid the retry loop, it results in *much* simpler
code.

This also fixes an issue spotted by Josh Don where, for SMT3+, we can
forget to update max on the first pass and get to do an extra round.

Suggested-by: Tao Zhou <tao.zhou@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 156 +++++++++++++++-------------------------------------
 1 file changed, 45 insertions(+), 111 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ceae25ea8a0e..8a9a32df5f38 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5381,8 +5381,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			return p;
 	}
 
-	/* The idle class should always have a runnable task: */
-	BUG();
+	BUG(); /* The idle class should always have a runnable task. */
 }
 
 #ifdef CONFIG_SCHED_CORE
@@ -5404,54 +5403,18 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
-// XXX fairness/fwd progress conditions
-/*
- * Returns
- * - NULL if there is no runnable task for this class.
- * - the highest priority task for this runqueue if it matches
- *   rq->core->core_cookie or its priority is greater than max.
- * - Else returns idle_task.
- */
-static struct task_struct *
-pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max, bool in_fi)
+static inline struct task_struct *pick_task(struct rq *rq)
 {
-	struct task_struct *class_pick, *cookie_pick;
-	unsigned long cookie = rq->core->core_cookie;
-
-	class_pick = class->pick_task(rq);
-	if (!class_pick)
-		return NULL;
-
-	if (!cookie) {
-		/*
-		 * If class_pick is tagged, return it only if it has
-		 * higher priority than max.
-		 */
-		if (max && class_pick->core_cookie &&
-		    prio_less(class_pick, max, in_fi))
-			return idle_sched_class.pick_task(rq);
+	const struct sched_class *class;
+	struct task_struct *p;
 
-		return class_pick;
+	for_each_class(class) {
+		p = class->pick_task(rq);
+		if (p)
+			return p;
 	}
 
-	/*
-	 * If class_pick is idle or matches cookie, return early.
-	 */
-	if (cookie_equals(class_pick, cookie))
-		return class_pick;
-
-	cookie_pick = sched_core_find(rq, cookie);
-
-	/*
-	 * If class > max && class > cookie, it is the highest priority task on
-	 * the core (so far) and it must be selected, otherwise we must go with
-	 * the cookie pick in order to satisfy the constraint.
-	 */
-	if (prio_less(cookie_pick, class_pick, in_fi) &&
-	    (!max || prio_less(max, class_pick, in_fi)))
-		return class_pick;
-
-	return cookie_pick;
+	BUG(); /* The idle class should always have a runnable task. */
 }
 
 extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
@@ -5459,11 +5422,12 @@ extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_f
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *next, *max = NULL;
-	const struct sched_class *class;
+	struct task_struct *next, *p, *max = NULL;
 	const struct cpumask *smt_mask;
 	bool fi_before = false;
-	int i, j, cpu, occ = 0;
+	unsigned long cookie;
+	int i, cpu, occ = 0;
+	struct rq *rq_i;
 	bool need_sync;
 
 	if (!sched_core_enabled(rq))
@@ -5536,12 +5500,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-		for_each_class(class) {
-			next = class->pick_task(rq);
-			if (next)
-				break;
-		}
-
+		next = pick_task(rq);
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
 			/*
@@ -5554,76 +5513,51 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 	}
 
-	for_each_cpu(i, smt_mask) {
-		struct rq *rq_i = cpu_rq(i);
-
-		rq_i->core_pick = NULL;
+	/*
+	 * For each thread: do the regular task pick and find the max prio task
+	 * amongst them.
+	 *
+	 * Tie-break prio towards the current CPU
+	 */
+	for_each_cpu_wrap(i, smt_mask, cpu) {
+		rq_i = cpu_rq(i);
 
 		if (i != cpu)
 			update_rq_clock(rq_i);
+
+		p = rq_i->core_pick = pick_task(rq_i);
+		if (!max || prio_less(max, p, fi_before))
+			max = p;
 	}
 
+	cookie = rq->core->core_cookie = max->core_cookie;
+
 	/*
-	 * Try and select tasks for each sibling in descending sched_class
-	 * order.
+	 * For each thread: try and find a runnable task that matches @max or
+	 * force idle.
 	 */
-	for_each_class(class) {
-again:
-		for_each_cpu_wrap(i, smt_mask, cpu) {
-			struct rq *rq_i = cpu_rq(i);
-			struct task_struct *p;
-
-			if (rq_i->core_pick)
-				continue;
+	for_each_cpu(i, smt_mask) {
+		rq_i = cpu_rq(i);
+		p = rq_i->core_pick;
 
-			/*
-			 * If this sibling doesn't yet have a suitable task to
-			 * run; ask for the most eligible task, given the
-			 * highest priority task already selected for this
-			 * core.
-			 */
-			p = pick_task(rq_i, class, max, fi_before);
+		if (!cookie_equals(p, cookie)) {
+			p = NULL;
+			if (cookie)
+				p = sched_core_find(rq_i, cookie);
 			if (!p)
-				continue;
+				p = idle_sched_class.pick_task(rq_i);
+		}
 
-			if (!is_task_rq_idle(p))
-				occ++;
+		rq_i->core_pick = p;
 
-			rq_i->core_pick = p;
-			if (rq_i->idle == p && rq_i->nr_running) {
+		if (p == rq_i->idle) {
+			if (rq_i->nr_running) {
 				rq->core->core_forceidle = true;
 				if (!fi_before)
 					rq->core->core_forceidle_seq++;
 			}
-
-			/*
-			 * If this new candidate is of higher priority than the
-			 * previous; and they're incompatible; we need to wipe
-			 * the slate and start over. pick_task makes sure that
-			 * p's priority is more than max if it doesn't match
-			 * max's cookie.
-			 *
-			 * NOTE: this is a linear max-filter and is thus bounded
-			 * in execution time.
-			 */
-			if (!max || !cookie_match(max, p)) {
-				struct task_struct *old_max = max;
-
-				rq->core->core_cookie = p->core_cookie;
-				max = p;
-
-				if (old_max) {
-					rq->core->core_forceidle = false;
-					for_each_cpu(j, smt_mask) {
-						if (j == i)
-							continue;
-
-						cpu_rq(j)->core_pick = NULL;
-					}
-					occ = 1;
-					goto again;
-				}
-			}
+		} else {
+			occ++;
 		}
 	}
 
@@ -5643,7 +5577,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * non-matching user state.
 	 */
 	for_each_cpu(i, smt_mask) {
-		struct rq *rq_i = cpu_rq(i);
+		rq_i = cpu_rq(i);
 
 		/*
 		 * An online sibling might have gone offline before a task
