Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79393921B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhEZU7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:59:41 -0400
Received: from foss.arm.com ([217.140.110.172]:49906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233726AbhEZU7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:59:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA21F1476;
        Wed, 26 May 2021 13:58:02 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 355E33F73B;
        Wed, 26 May 2021 13:58:01 -0700 (PDT)
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
Subject: [PATCH 2/2] sched: Plug race between SCA, hotplug and migration_cpu_stop()
Date:   Wed, 26 May 2021 21:57:51 +0100
Message-Id: <20210526205751.842360-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210526205751.842360-1-valentin.schneider@arm.com>
References: <20210526205751.842360-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

migration_cpu_stop() is handed a CPU that was a valid pick at the time
set_cpus_allowed_ptr() was invoked. However, hotplug may have happened
between then and the stopper work being executed, meaning
__move_queued_task() could fail when passed arg.dest_cpu. This could mean
leaving a task on its current CPU (despite it being outside the task's
affinity) up until its next wakeup, which is a big no-no.

Verify the validity of the pick in the stopper callback, and invoke
select_fallback_rq() there if need be.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d40511c55e80..0679efb6c22d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2263,6 +2263,8 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 	return rq;
 }
 
+static int select_fallback_rq(int cpu, struct task_struct *p);
+
 /*
  * migration_cpu_stop - this will be executed by a highprio stopper thread
  * and performs thread migration by bumping thread off CPU then
@@ -2276,6 +2278,7 @@ static int migration_cpu_stop(void *data)
 	struct rq *rq = this_rq();
 	bool complete = false;
 	struct rq_flags rf;
+	int dest_cpu;
 
 	/*
 	 * The original target CPU might have gone down and we might
@@ -2315,18 +2318,27 @@ static int migration_cpu_stop(void *data)
 				goto out;
 		}
 
-		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
-		else
-			p->wake_cpu = arg->dest_cpu;
-
-		/*
-		 * XXX __migrate_task() can fail, at which point we might end
-		 * up running on a dodgy CPU, AFAICT this can only happen
-		 * during CPU hotplug, at which point we'll get pushed out
-		 * anyway, so it's probably not a big deal.
-		 */
-
+		dest_cpu = arg->dest_cpu;
+		if (task_on_rq_queued(p)) {
+			/*
+			 * A hotplug operation could have happened between
+			 * set_cpus_allowed_ptr() and here, making dest_cpu no
+			 * longer allowed.
+			 */
+			if (!is_cpu_allowed(p, dest_cpu))
+				dest_cpu = select_fallback_rq(cpu_of(rq), p);
+			/*
+			 * dest_cpu can be victim of hotplug between is_cpu_allowed()
+			 * and here. However, per the synchronize_rcu() in
+			 * sched_cpu_deactivate(), it can't have gone lower than
+			 * CPUHP_AP_ACTIVE, so it's safe to punt it over and let
+			 * balance_push() route it elsewhere.
+			 */
+			update_rq_clock(rq);
+			rq = move_queued_task(rq, &rf, p, dest_cpu);
+		} else {
+			p->wake_cpu = dest_cpu;
+		}
 	} else if (pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
-- 
2.25.1

