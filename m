Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EDE3C2B22
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 00:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhGIWDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 18:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231244AbhGIWDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 18:03:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791B2613DC;
        Fri,  9 Jul 2021 22:00:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m1yXi-000CM4-He; Fri, 09 Jul 2021 18:00:18 -0400
Message-ID: <20210709220018.381962162@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 18:00:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH RT 7/8] sched: Dont defer CPU pick to migration_cpu_stop()
References: <20210709215953.122804544@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.10.47-rt46-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Valentin Schneider <valentin.schneider@arm.com>

commit 475ea6c60279e9f2ddf7e4cf2648cd8ae0608361 upstream.

Will reported that the 'XXX __migrate_task() can fail' in migration_cpu_stop()
can happen, and it *is* sort of a big deal. Looking at it some more, one
will note there is a glaring hole in the deferred CPU selection:

  (w/ CONFIG_CPUSET=n, so that the affinity mask passed via taskset doesn't
  get AND'd with cpu_online_mask)

  $ taskset -pc 0-2 $PID
  # offline CPUs 3-4
  $ taskset -pc 3-5 $PID
    `\
      $PID may stay on 0-2 due to the cpumask_any_distribute() picking an
      offline CPU and __migrate_task() refusing to do anything due to
      cpu_is_allowed().

set_cpus_allowed_ptr() goes to some length to pick a dest_cpu that matches
the right constraints vs affinity and the online/active state of the
CPUs. Reuse that instead of discarding it in the affine_move_task() case.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210526205751.842360-2-valentin.schneider@arm.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 35d8b80d7cb8..b1e87f304ade 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1942,7 +1942,6 @@ static int migration_cpu_stop(void *data)
 	struct migration_arg *arg = data;
 	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
-	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
 	bool complete = false;
 	struct rq_flags rf;
@@ -1975,19 +1974,15 @@ static int migration_cpu_stop(void *data)
 			if (p->migration_pending == pending)
 				p->migration_pending = NULL;
 			complete = true;
-		}
 
-		if (dest_cpu < 0) {
 			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
 				goto out;
-
-			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
 		}
 
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, dest_cpu);
+			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
 		else
-			p->wake_cpu = dest_cpu;
+			p->wake_cpu = arg->dest_cpu;
 
 		/*
 		 * XXX __migrate_task() can fail, at which point we might end
@@ -2266,7 +2261,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			init_completion(&my_pending.done);
 			my_pending.arg = (struct migration_arg) {
 				.task = p,
-				.dest_cpu = -1,		/* any */
+				.dest_cpu = dest_cpu,
 				.pending = &my_pending,
 			};
 
@@ -2274,6 +2269,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		} else {
 			pending = p->migration_pending;
 			refcount_inc(&pending->refs);
+			/*
+			 * Affinity has changed, but we've already installed a
+			 * pending. migration_cpu_stop() *must* see this, else
+			 * we risk a completion of the pending despite having a
+			 * task on a disallowed CPU.
+			 *
+			 * Serialized by p->pi_lock, so this is safe.
+			 */
+			pending->arg.dest_cpu = dest_cpu;
 		}
 	}
 	pending = p->migration_pending;
-- 
2.30.2
