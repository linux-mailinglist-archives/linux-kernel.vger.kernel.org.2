Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8733A57F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhCNPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhCNPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:40:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC72C061762
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 08:40:26 -0700 (PDT)
Date:   Sun, 14 Mar 2021 15:39:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615736424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fBWtJ3/zh17WXSqRXsAN0QX0t8Vh86b7wicEAgC33UE=;
        b=2/hPkSxLdPbkuxd+62o3YdKdKXM+DwIz6lJGgVLDZCodRzoWk4S9tASslOIsHXwbtg6M/X
        ebmYrJCHbZzqiEx96/OmoOF9gk5KRJjTMszmUi9ZJKfD8/Vw9VbWSiZjVx5xwuJXnFeSgO
        utH9vNW8HKwMhQB26/jAVdwtT5PR8gsMIMdUrTUJSRQzaK+1Qbou8ivSYl8Mb+g8ephYsE
        F4g2byP79zuiIKV8HSqoCP5knDtqQlX+/ZBc5QWjNfWmGtIHH1QnyHo/mnGMHbxsHaLpwv
        Lh0zklEkm0vL9N05RBlOYcUXN1OOdtNf/CHSa7K+at/aZCo0BIxgFy5uSkgBgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615736424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fBWtJ3/zh17WXSqRXsAN0QX0t8Vh86b7wicEAgC33UE=;
        b=RgrOKYdUTIXmF+Oiyh69O4fgorPouV5m1saJicqPKL9jhkUzrgffRmuYX6uogz+efkv+iU
        hR1j7G2r7lK9IyBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.12-rc3
References: <161573639668.27979.17827928369874291298.tglx@nanos>
Message-ID: <161573639909.27979.13628967413376263524.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-03-14

up to:  ce29ddc47b91: sched/membarrier: fix missing local execution of ipi_sync_rq_state()


A set of scheduler updates:

  - Prevent a NULL pointer dereference in the migration_stop_cpu()
    mechanims

  - Prevent self concurrency of affine_move_task()

  - Small fixes and cleanups related to task migration/affinity setting

  - Ensure that sync_runqueues_membarrier_state() is invoked on the current
    CPU when it is in the cpu mask


Thanks,

	tglx

------------------>
Mathieu Desnoyers (1):
      sched/membarrier: fix missing local execution of ipi_sync_rq_state()

Peter Zijlstra (6):
      sched: Fix migration_cpu_stop() requeueing
      sched: Simplify migration_cpu_stop()
      sched: Collate affine_move_task() stoppers
      sched: Optimize migration_cpu_stop()
      sched: Fix affine_move_task() self-concurrency
      sched: Simplify set_affinity_pending refcounts


 kernel/sched/core.c       | 126 +++++++++++++++++++++++-----------------------
 kernel/sched/membarrier.c |   4 +-
 2 files changed, 63 insertions(+), 67 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca2bb629595f..98191218d891 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1862,8 +1862,13 @@ struct migration_arg {
 	struct set_affinity_pending	*pending;
 };
 
+/*
+ * @refs: number of wait_for_completion()
+ * @stop_pending: is @stop_work in use
+ */
 struct set_affinity_pending {
 	refcount_t		refs;
+	unsigned int		stop_pending;
 	struct completion	done;
 	struct cpu_stop_work	stop_work;
 	struct migration_arg	arg;
@@ -1898,8 +1903,8 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  */
 static int migration_cpu_stop(void *data)
 {
-	struct set_affinity_pending *pending;
 	struct migration_arg *arg = data;
+	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
 	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
@@ -1921,7 +1926,6 @@ static int migration_cpu_stop(void *data)
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
 
-	pending = p->migration_pending;
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -1932,21 +1936,14 @@ static int migration_cpu_stop(void *data)
 			goto out;
 
 		if (pending) {
-			p->migration_pending = NULL;
+			if (p->migration_pending == pending)
+				p->migration_pending = NULL;
 			complete = true;
 		}
 
-		/* migrate_enable() --  we must not race against SCA */
 		if (dest_cpu < 0) {
-			/*
-			 * When this was migrate_enable() but we no longer
-			 * have a @pending, a concurrent SCA 'fixed' things
-			 * and we should be valid again. Nothing to do.
-			 */
-			if (!pending) {
-				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
+			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
 				goto out;
-			}
 
 			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
 		}
@@ -1956,7 +1953,14 @@ static int migration_cpu_stop(void *data)
 		else
 			p->wake_cpu = dest_cpu;
 
-	} else if (dest_cpu < 0 || pending) {
+		/*
+		 * XXX __migrate_task() can fail, at which point we might end
+		 * up running on a dodgy CPU, AFAICT this can only happen
+		 * during CPU hotplug, at which point we'll get pushed out
+		 * anyway, so it's probably not a big deal.
+		 */
+
+	} else if (pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
 		 * preempt_enable() and scheduling the stopper task. At that
@@ -1971,43 +1975,32 @@ static int migration_cpu_stop(void *data)
 		 * ->pi_lock, so the allowed mask is stable - if it got
 		 * somewhere allowed, we're done.
 		 */
-		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
-			p->migration_pending = NULL;
+		if (cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
+			if (p->migration_pending == pending)
+				p->migration_pending = NULL;
 			complete = true;
 			goto out;
 		}
 
-		/*
-		 * When this was migrate_enable() but we no longer have an
-		 * @pending, a concurrent SCA 'fixed' things and we should be
-		 * valid again. Nothing to do.
-		 */
-		if (!pending) {
-			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
-			goto out;
-		}
-
 		/*
 		 * When migrate_enable() hits a rq mis-match we can't reliably
 		 * determine is_migration_disabled() and so have to chase after
 		 * it.
 		 */
+		WARN_ON_ONCE(!pending->stop_pending);
 		task_rq_unlock(rq, p, &rf);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 		return 0;
 	}
 out:
+	if (pending)
+		pending->stop_pending = false;
 	task_rq_unlock(rq, p, &rf);
 
 	if (complete)
 		complete_all(&pending->done);
 
-	/* For pending->{arg,stop_work} */
-	pending = arg->pending;
-	if (pending && refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs);
-
 	return 0;
 }
 
@@ -2194,11 +2187,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
-	struct migration_arg arg = {
-		.task = p,
-		.dest_cpu = dest_cpu,
-	};
-	bool complete = false;
+	bool stop_pending, complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
@@ -2210,12 +2199,16 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			push_task = get_task_struct(p);
 		}
 
+		/*
+		 * If there are pending waiters, but no pending stop_work,
+		 * then complete now.
+		 */
 		pending = p->migration_pending;
-		if (pending) {
-			refcount_inc(&pending->refs);
+		if (pending && !pending->stop_pending) {
 			p->migration_pending = NULL;
 			complete = true;
 		}
+
 		task_rq_unlock(rq, p, rf);
 
 		if (push_task) {
@@ -2224,7 +2217,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		}
 
 		if (complete)
-			goto do_complete;
+			complete_all(&pending->done);
 
 		return 0;
 	}
@@ -2235,6 +2228,12 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			/* Install the request */
 			refcount_set(&my_pending.refs, 1);
 			init_completion(&my_pending.done);
+			my_pending.arg = (struct migration_arg) {
+				.task = p,
+				.dest_cpu = -1,		/* any */
+				.pending = &my_pending,
+			};
+
 			p->migration_pending = &my_pending;
 		} else {
 			pending = p->migration_pending;
@@ -2259,45 +2258,41 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		return -EINVAL;
 	}
 
-	if (flags & SCA_MIGRATE_ENABLE) {
-
-		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
-		p->migration_flags &= ~MDF_PUSH;
-		task_rq_unlock(rq, p, rf);
-
-		pending->arg = (struct migration_arg) {
-			.task = p,
-			.dest_cpu = -1,
-			.pending = pending,
-		};
-
-		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-				    &pending->arg, &pending->stop_work);
-
-		return 0;
-	}
-
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		/*
-		 * Lessen races (and headaches) by delegating
-		 * is_migration_disabled(p) checks to the stopper, which will
-		 * run on the same CPU as said p.
+		 * MIGRATE_ENABLE gets here because 'p == current', but for
+		 * anything else we cannot do is_migration_disabled(), punt
+		 * and have the stopper function handle it all race-free.
 		 */
+		stop_pending = pending->stop_pending;
+		if (!stop_pending)
+			pending->stop_pending = true;
+
+		if (flags & SCA_MIGRATE_ENABLE)
+			p->migration_flags &= ~MDF_PUSH;
+
 		task_rq_unlock(rq, p, rf);
-		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
 
+		if (!stop_pending) {
+			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+					    &pending->arg, &pending->stop_work);
+		}
+
+		if (flags & SCA_MIGRATE_ENABLE)
+			return 0;
 	} else {
 
 		if (!is_migration_disabled(p)) {
 			if (task_on_rq_queued(p))
 				rq = move_queued_task(rq, rf, p, dest_cpu);
 
-			p->migration_pending = NULL;
-			complete = true;
+			if (!pending->stop_pending) {
+				p->migration_pending = NULL;
+				complete = true;
+			}
 		}
 		task_rq_unlock(rq, p, rf);
 
-do_complete:
 		if (complete)
 			complete_all(&pending->done);
 	}
@@ -2305,7 +2300,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	wait_for_completion(&pending->done);
 
 	if (refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs);
+		wake_up_var(&pending->refs); /* No UaF, just an address */
 
 	/*
 	 * Block the original owner of &pending until all subsequent callers
@@ -2313,6 +2308,9 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	 */
 	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
 
+	/* ARGH */
+	WARN_ON_ONCE(my_pending.stop_pending);
+
 	return 0;
 }
 
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index acdae625c636..b5add64d9698 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -471,9 +471,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 	}
 	rcu_read_unlock();
 
-	preempt_disable();
-	smp_call_function_many(tmpmask, ipi_sync_rq_state, mm, 1);
-	preempt_enable();
+	on_each_cpu_mask(tmpmask, ipi_sync_rq_state, mm, true);
 
 	free_cpumask_var(tmpmask);
 	cpus_read_unlock();

