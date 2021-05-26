Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3953E3921B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhEZU7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:59:37 -0400
Received: from foss.arm.com ([217.140.110.172]:49878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233697AbhEZU7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:59:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B88D13A1;
        Wed, 26 May 2021 13:58:01 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7007F3F73B;
        Wed, 26 May 2021 13:57:59 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: [PATCH 1/2] sched: Don't defer CPU pick to migration_cpu_stop()
Date:   Wed, 26 May 2021 21:57:50 +0100
Message-Id: <20210526205751.842360-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210526205751.842360-1-valentin.schneider@arm.com>
References: <20210526205751.842360-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3d2527239c3e..d40511c55e80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2273,7 +2273,6 @@ static int migration_cpu_stop(void *data)
 	struct migration_arg *arg = data;
 	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
-	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
 	bool complete = false;
 	struct rq_flags rf;
@@ -2311,19 +2310,15 @@ static int migration_cpu_stop(void *data)
 		if (pending) {
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
@@ -2606,7 +2601,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			init_completion(&my_pending.done);
 			my_pending.arg = (struct migration_arg) {
 				.task = p,
-				.dest_cpu = -1,		/* any */
+				.dest_cpu = dest_cpu,
 				.pending = &my_pending,
 			};
 
@@ -2614,6 +2609,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
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
2.25.1

