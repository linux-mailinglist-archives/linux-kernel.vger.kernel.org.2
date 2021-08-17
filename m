Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2D13EF059
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhHQQpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:45:11 -0400
Received: from out0.migadu.com ([94.23.1.103]:30074 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhHQQpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:45:11 -0400
Date:   Wed, 18 Aug 2021 00:45:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629218673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9IpxX15DqOD8LIrfGJRCbPsyH+vcshClmcSkLJL6WHM=;
        b=j9RL1ME3CgACWqYIwVG3Qd0rTa0/S4c65xtSI6PQlLkceCJXK7LOjGG4gNTaxkiMIYhkKh
        2wdrZDlq6y5oZcN0fKZVQb9EFNOjT5C0jBQc3dvnS93RNhDgqhp5XG/hJ6GVAjWIh7CR3i
        fFmEAxuPBQ5SX9HfWKqASGbZZ4iq6Tw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de, taozhou@linux.dev
Subject: Re: [PATCH] sched/core: An optimization of pick_next_task() not sure
Message-ID: <YRvnnanIb4WEI5aJ@geo.homenetwork>
References: <20210816154401.23919-1-tao.zhou@linux.dev>
 <YRqz93crZIS1Mvmy@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRqz93crZIS1Mvmy@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Aug 16, 2021 at 08:52:39PM +0200, Peter Zijlstra wrote:

> On Mon, Aug 16, 2021 at 11:44:01PM +0800, Tao Zhou wrote:
> > When find a new candidate max, wipe the stale and start over.
> > Goto again: and use the new max to loop to pick the the task.
> > 
> > Here first want to get the max of the core and use this new
> > max to loop once to pick the task on each thread.
> > 
> > Not sure this is an optimization and just stop here a little
> > and move on..
> > 
> 
> Did you find this retry was an issue on your workload? Or was this from
> reading the source?

Thank you for your reply. Sorry for my late reply.
This was from reading the source..

> 
> > ---
> >  kernel/sched/core.c | 52 +++++++++++++++++----------------------------
> >  1 file changed, 20 insertions(+), 32 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 20ffcc044134..bddcd328df96 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5403,7 +5403,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  	const struct sched_class *class;
> >  	const struct cpumask *smt_mask;
> >  	bool fi_before = false;
> > -	int i, j, cpu, occ = 0;
> > +	int i, cpu, occ = 0;
> >  	bool need_sync;
> >  
> >  	if (!sched_core_enabled(rq))
> > @@ -5508,11 +5508,27 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  	 * order.
> >  	 */
> >  	for_each_class(class) {
> > -again:
> > +		struct rq *rq_i;
> > +		struct task_struct *p;
> > +
> >  		for_each_cpu_wrap(i, smt_mask, cpu) {
> > -			struct rq *rq_i = cpu_rq(i);
> > -			struct task_struct *p;
> > +			rq_i = cpu_rq(i);
> > +			p = pick_task(rq_i, class, max, fi_before);
> > +			/*
> > +			 * If this new candidate is of higher priority than the
> > +			 * previous; and they're incompatible; pick_task makes
> > +			 * sure that p's priority is more than max if it doesn't
> > +			 * match max's cookie. Update max.
> > +			 *
> > +			 * NOTE: this is a linear max-filter and is thus bounded
> > +			 * in execution time.
> > +			 */
> > +			if (!max || !cookie_match(max, p))
> > +				max = p;
> > +		}
> >  
> > +		for_each_cpu_wrap(i, smt_mask, cpu) {
> > +			rq_i = cpu_rq(i);
> >  			if (rq_i->core_pick)
> >  				continue;
> >  
> 
> This now calls pick_task() twice for each CPU, which seems unfortunate;
> perhaps add q->core_temp storage to cache that result. Also, since the
> first iteration is now explicitly about the max filter, perhaps we
> shouuld move that part of pick_task() into the loop and simplify things
> further?

Here is my ugly patch below..
Not compiled..


From b3de16fb6f3e6cd2a8a9f7a579e80df74fb2d865 Mon Sep 17 00:00:00 2001
From: Tao Zhou <tao.zhou@linux.dev>
Date: Wed, 18 Aug 2021 00:07:38 +0800
Subject: [PATCH] optimize pick_next_task()

---
 kernel/sched/core.c  | 71 +++++++++++++++++++++++++++++++++-----------
 kernel/sched/sched.h |  1 +
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20ffcc044134..c2a403bacf99 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5380,18 +5380,32 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	if (cookie_equals(class_pick, cookie))
 		return class_pick;
 
-	cookie_pick = sched_core_find(rq, cookie);
+	return class_pick;
+}
 
-	/*
-	 * If class > max && class > cookie, it is the highest priority task on
-	 * the core (so far) and it must be selected, otherwise we must go with
-	 * the cookie pick in order to satisfy the constraint.
-	 */
-	if (prio_less(cookie_pick, class_pick, in_fi) &&
-	    (!max || prio_less(max, class_pick, in_fi)))
-		return class_pick;
+static task_struct *
+filter_max_prio(struct rq *rq, struct task_struct *class_pick,
+				struct task_struct **cookie_pick, struct task_struct *max,
+				bool in_fi)
+{
+	unsigned long cookie = rq->core->core_cookie;
 
-	return cookie_pick;
+	*cookie_pick = NULL;
+	if (cookie && !cookie_equals(class_pick, cookie)) {
+		*cookie_pick = sched_core_find(rq, cookie);
+		/*
+		 * If class > max && class > cookie, it is the
+		 * highest priority task on the core (so far)
+		 * and it must be selected, otherwise we must
+		 * go with the cookie pick in order to satisfy
+		 * the constraint.
+		 */
+		if (prio_less(cookie_pick, class_pick, in_fi) &&
+		    (!max || prio_less(max, class_pick, in_fi)))
+			return class_pick;
+	}
+
+	return NULL;
 }
 
 extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
@@ -5508,24 +5522,44 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * order.
 	 */
 	for_each_class(class) {
-again:
+		struct task_struct *class_pick, *cookie_pick;
+		struct rq *rq_i;
+
+		for_each_cpu_wrap(i, smt_mask, cpu) {
+			rq_i = cpu_rq(i);
+			class_pick = pick_task(rq_i, class, max, fi_before);
+			rq_i->core_temp = class_pick;
+			/*
+			 * This sibling doesn't yet have a suitable task to
+			 * run.
+			 */
+			if (!class_pick)
+				continue;
+
+			if (filter_max_prio(rq_i, class_pick, &cookie_pick, max, fi_before))
+				max = class_pick;
+		}
+
 		for_each_cpu_wrap(i, smt_mask, cpu) {
-			struct rq *rq_i = cpu_rq(i);
 			struct task_struct *p;
+			rq_i = cpu_rq(i);
 
 			if (rq_i->core_pick)
 				continue;
 
 			/*
-			 * If this sibling doesn't yet have a suitable task to
-			 * run; ask for the most eligible task, given the
-			 * highest priority task already selected for this
-			 * core.
+			 * This sibling doesn't yet have a suitable task to
+			 * run.
 			 */
-			p = pick_task(rq_i, class, max, fi_before);
-			if (!p)
+			if (!rq_i->core_temp)
 				continue;
 
+			p = class_pick = rq_i->core_temp;
+			if (!filter_max_prio(rq_i, class_pick, &cookie_pick, max, fi_before)) {
+				if (cookie_pick)
+					p = cookie_pick;
+			}
+
 			if (!is_task_rq_idle(p))
 				occ++;
 
@@ -9024,6 +9058,7 @@ void __init sched_init(void)
 #ifdef CONFIG_SCHED_CORE
 		rq->core = NULL;
 		rq->core_pick = NULL;
+		rq->core_temp = NULL;
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle = false;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a243f7b..2b21a3846b8e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1089,6 +1089,7 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	struct task_struct	*core_pick;
+	struct task_struct	*core_temp;
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
-- 
2.31.1


Thanks,
Tao
