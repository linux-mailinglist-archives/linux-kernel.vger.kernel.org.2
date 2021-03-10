Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9A33409C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhCJOpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:45:12 -0500
Received: from foss.arm.com ([217.140.110.172]:47732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhCJOo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:44:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D478831B;
        Wed, 10 Mar 2021 06:44:57 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC0933F793;
        Wed, 10 Mar 2021 06:44:55 -0800 (PST)
Date:   Wed, 10 Mar 2021 14:44:53 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: Re: [PATCH v4 15/19] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20210310144453.u756vzktfdd3vxmy@e107158-lin.cambridge.arm.com>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.499155098@infradead.org>
 <20201226135445.gkxfn5lmbxhblnj4@e107158-lin>
 <YEJGq3aKM9lfYked@hirez.programming.kicks-ass.net>
 <jhjblbx7glh.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjblbx7glh.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 15:41, Valentin Schneider wrote:
> On 05/03/21 15:56, Peter Zijlstra wrote:
> > On Sat, Dec 26, 2020 at 01:54:45PM +0000, Qais Yousef wrote:
> >>
> >> > +static inline struct task_struct *get_push_task(struct rq *rq)
> >> > +{
> >> > +	struct task_struct *p = rq->curr;
> >>
> >> Shouldn't we verify the class of the task here? The RT task in migration
> >> disabled could have been preempted by a dl or stopper task. Similarly, the dl
> >> task could have been preempted by a stopper task.
> >>
> >> I don't think an RT task should be allowed to push a dl task under any
> >> circumstances?
> >
> > Hmm, quite. Fancy doing a patch?
> 
> Last time we talked about this, I looked into
> 
>   push_rt_task() + find_lowest_rq()
> 
> IIRC, with how
> 
>   find_lowest_rq() + cpupri_find_fitness()
> 
> currently work, find_lowest_rq() should return -1 in push_rt_task() if
> rq->curr is DL (CPUPRI_INVALID). IOW, Migration-Disabled RT tasks shouldn't
> actually interfere with DL tasks (unless a DL task gets scheduled after we
> drop the rq lock and kick the stopper, but we have that problem everywhere
> including CFS active balance).

This makes it less of a problem true, but AFAICT this can still happen in the
pull path.

Anyways, here's the patch as extra bolts and braces to be considered.

Thanks

--
Qais Yousef

--->8----

From 2df733d381f636cc185944c7eda86c824a9a785e Mon Sep 17 00:00:00 2001
From: Qais Yousef <qais.yousef@arm.com>
Date: Tue, 12 Jan 2021 11:54:16 +0000
Subject: [PATCH] sched: Don't push a higher priority class in get_push_task()

Commit a7c81556ec4d ("sched: Fix migrate_disable() vs rt/dl balancing")
will attempt to push/pull a higher priority task if the candidate task
is in migrate_disable() section. This is an attempt to prevent
starvation of these lower priority task that, in theory at least, could
end up in a situation where they're forever in migrate disable section
with no CPU time to run.

One issue with that is get_push_task() assumes rq->curr is of the same
sched_class, which AFAICT is not guaranteed to be true.

This patch adds extra bolts and braces to ensure that this voluntary
push operation is performed on a task of the same scheduling class only.

Otherwise an RT task could end up causing a DL task to be pushed away.
Which breaks the strict priority between sched classes.

We could also end up trying to push the migration task. Which I think is
harmless and is nothing but a wasted effort.

Fixes: a7c81556ec4d ("sched: Fix migrate_disable() vs rt/dl balancing")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/deadline.c |  2 +-
 kernel/sched/rt.c       |  4 ++--
 kernel/sched/sched.h    | 17 ++++++++++++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index aac3539aa0fe..afadc7e1f968 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2276,7 +2276,7 @@ static void pull_dl_task(struct rq *this_rq)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
-				push_task = get_push_task(src_rq);
+				push_task = get_push_task(src_rq, SCHED_DEADLINE);
 			} else {
 				deactivate_task(src_rq, p, 0);
 				set_task_cpu(p, this_cpu);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8f720b71d13d..c2c5c08e3030 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1892,7 +1892,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * to this other CPU, instead attempt to push the current
 		 * running task on this CPU away.
 		 */
-		push_task = get_push_task(rq);
+		push_task = get_push_task(rq, SCHED_FIFO);
 		if (push_task) {
 			raw_spin_unlock(&rq->lock);
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
@@ -2225,7 +2225,7 @@ static void pull_rt_task(struct rq *this_rq)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
-				push_task = get_push_task(src_rq);
+				push_task = get_push_task(src_rq, SCHED_FIFO);
 			} else {
 				deactivate_task(src_rq, p, 0);
 				set_task_cpu(p, this_cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..4e156f008d22 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1954,12 +1954,27 @@ extern void trigger_load_balance(struct rq *rq);
 
 extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
 
-static inline struct task_struct *get_push_task(struct rq *rq)
+static inline struct task_struct *get_push_task(struct rq *rq, int policy)
 {
 	struct task_struct *p = rq->curr;
 
 	lockdep_assert_held(&rq->lock);
 
+	switch(policy) {
+	case SCHED_FIFO:
+	case SCHED_RR:
+		if (!rt_task(p))
+			return NULL;
+		break;
+	case SCHED_DEADLINE:
+		if (!dl_task(p))
+			return NULL;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
 	if (rq->push_busy)
 		return NULL;
 
-- 
2.25.1

