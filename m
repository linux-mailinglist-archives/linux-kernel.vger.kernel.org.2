Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEB33F4992
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbhHWLUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbhHWLUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:20:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82251C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z0NBJdM9mtTfxBSPC+2W2ykM3ginT7Xw/FdE8D04H40=; b=KMS9cGT/YXxnTukACIP5LDXfJi
        3ZtJvuITO++DtMiBaMIfnBlV83+b3yM98hC9lQVEyzRIlAqW46/Fz4rCavpoFUdWIS+LeKjV9GRtx
        3MHaCHNag3fI2egdJ2dERXF1ugXQfY6mJ1ZvWJDHoKIh9Lxx0oz227olXSyPoVonQfRbsqn8hltAL
        KyptD9LZuJNN/VLgPhwU4StBwE1R/NwjOWhvQtl3Bev82oRjvH1S6H55DTyYzNgVZg+yBs+XOi9YB
        6zEu/2H2Cp8duOFvHJxjC7LDdcqjBZcbXNisFn81iJKgqLWdaSPWniEQqSOm9vYwIWPfaIC7z0zqG
        /O6w2HiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI7wo-009czI-Bx; Mon, 23 Aug 2021 11:17:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F84230018A;
        Mon, 23 Aug 2021 13:16:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 463572098533C; Mon, 23 Aug 2021 13:16:56 +0200 (CEST)
Date:   Mon, 23 Aug 2021 13:16:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Subject: Re: [PATCH] sched/core: fix pick_next_task 'max' tracking
Message-ID: <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
References: <20210818005615.138527-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818005615.138527-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 05:56:15PM -0700, Josh Don wrote:
> For core-sched, pick_next_task will update the 'max' task if there is a
> cookie mismatch (since in this case the new task must be of higher
> priority than the current max). However, we fail to update 'max' if
> we've found a task with a matching cookie and higher priority than
> 'max'.
> 
> This can result in extra iterations on SMT-X machines, where X > 2.
> 
> As an example, on a machine with SMT=3, on core 0, SMT-0 might pick
> the following, in order:
> 
> - SMT-0: p1, with cookie A, and priority 10 (max = p1)
> - SMT-1: p2, with cookie A, and priority 30 (max not updated here)
> - SMT-2: p3, with cookie B, and priority 20 (max = p2)
> 	> invalidate the other picks and retry
> 
> Here, we should have instead updated 'max' when picking for SMT-1. Note
> that this code would eventually have righted itself, since the retry
> loop would re-pick p2, and update 'max' accordingly. However, this patch
> avoids the extra round-trip.

Going with the observation Tao made; how about we rewrite the whole lot
to not be mind-bending complicated :-)

How's this? It seems to build and pass the core-sched selftest thingy
(so it must be perfect, right? :-)

---
 kernel/sched/core.c  | 147 ++++++++++++++-------------------------------------
 kernel/sched/sched.h |   1 +
 2 files changed, 41 insertions(+), 107 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ceae25ea8a0e..e896250c2fb8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5404,66 +5404,18 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
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
-{
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
-
-		return class_pick;
-	}
-
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
-}
-
 extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
 
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *next, *max = NULL;
+	struct task_struct *next, *p, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
 	bool fi_before = false;
-	int i, j, cpu, occ = 0;
+	unsigned long cookie;
+	int i, cpu, occ = 0;
+	struct rq *rq_i;
 	bool need_sync;
 
 	if (!sched_core_enabled(rq))
@@ -5554,76 +5506,57 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 	}
 
-	for_each_cpu(i, smt_mask) {
-		struct rq *rq_i = cpu_rq(i);
-
+	/*
+	 * For each thread: do the regular task pick and find the max prio task
+	 * amongst them.
+	 *
+	 * Tie-break prio towards the current CPU
+	 */
+	for_each_cpu_wrap(i, smt_mask, cpu) {
+		rq_i = cpu_rq(i);
 		rq_i->core_pick = NULL;
 
 		if (i != cpu)
 			update_rq_clock(rq_i);
+
+		for_each_class(class) {
+			p = rq_i->core_temp = class->pick_task(rq_i);
+			if (p)
+				break;
+		}
+
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
+		p = rq_i->core_temp;
 
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
 
@@ -5643,7 +5576,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * non-matching user state.
 	 */
 	for_each_cpu(i, smt_mask) {
-		struct rq *rq_i = cpu_rq(i);
+		rq_i = cpu_rq(i);
 
 		/*
 		 * An online sibling might have gone offline before a task
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d9f8d73a1d84..0760b460903a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1091,6 +1091,7 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	struct task_struct	*core_pick;
+	struct task_struct	*core_temp;
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
