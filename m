Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5CB306410
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhA0Tbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:31:48 -0500
Received: from foss.arm.com ([217.140.110.172]:33780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231341AbhA0Tbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34B0B31B;
        Wed, 27 Jan 2021 11:30:57 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0ED613F68F;
        Wed, 27 Jan 2021 11:30:54 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: [RFC PATCH] sched/core: Fix premature p->migration_pending completion
Date:   Wed, 27 Jan 2021 19:30:35 +0000
Message-Id: <20210127193035.13789-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fiddling some more with a TLA+ model of set_cpus_allowed_ptr() & friends
unearthed one more outstanding issue. This doesn't even involve
migrate_disable(), but rather affinity changes and execution of the stopper
racing with each other.

My own interpretation of the (lengthy) TLA+ splat (note the potential for
errors at each level) is:

  Initial conditions:
    victim.cpus_mask = {CPU0, CPU1}

  CPU0                             CPU1                             CPU<don't care>

  switch_to(victim)
								    set_cpus_allowed(victim, {CPU1})
								      kick CPU0 migration_cpu_stop({.dest_cpu = CPU1})
  switch_to(stopper/0)
								    // e.g. CFS load balance
								    move_queued_task(CPU0, victim, CPU1);
				   switch_to(victim)
								    set_cpus_allowed(victim, {CPU0});
								      task_rq_unlock();
  migration_cpu_stop(dest_cpu=CPU1)
    task_rq(p) != rq && pending
      kick CPU1 migration_cpu_stop({.dest_cpu = CPU1})

				   switch_to(stopper/1)
				   migration_cpu_stop(dest_cpu=CPU1)
				     task_rq(p) == rq && pending
				       __migrate_task(dest_cpu) // no-op
				     complete_all() <-- !!! affinity is {CPU0} !!!

I believe there are two issues there:
- retriggering of migration_cpu_stop() from within migration_cpu_stop()
  itself doesn't change arg.dest_cpu
- we'll issue a complete_all() in the task_rq(p) == rq path of
  migration_cpu_stop() even if the dest_cpu has been superseded by a
  further affinity change.

Something similar could happen with NUMA's migrate_task_to(), and arguably
any other user of migration_cpu_stop() with a .dest_cpu >= 0.
Consider:

  CPU0					CPUX

  switch_to(victim)
					migrate_task_to(victim, CPU1)
					  kick CPU0 migration_cpu_stop({.dest_cpu = CPU1})

					set_cpus_allowed(victim, {CPU42})
					  task_rq_unlock();
  switch_to(stopper/0)
  migration_cpu_stop(dest_cpu=CPU1)
    task_rq(p) == rq && pending
      __migrate_task(dest_cpu)
    complete_all() <-- !!! affinity is {CPU42} !!!

Prevent such premature completions by ensuring the dest_cpu in
migration_cpu_stop() is in the task's allowed cpumask.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 06b449942adf..b57326b0a742 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1923,20 +1923,28 @@ static int migration_cpu_stop(void *data)
 			complete = true;
 		}
 
-		/* migrate_enable() --  we must not race against SCA */
-		if (dest_cpu < 0) {
-			/*
-			 * When this was migrate_enable() but we no longer
-			 * have a @pending, a concurrent SCA 'fixed' things
-			 * and we should be valid again. Nothing to do.
-			 */
-			if (!pending) {
-				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
-				goto out;
-			}
+	       /*
+		* When this was migrate_enable() but we no longer
+		* have a @pending, a concurrent SCA 'fixed' things
+		* and we should be valid again.
+		*
+		* This can also be a stopper invocation that was 'fixed' by an
+		* earlier one.
+		*
+		* Nothing to do.
+		*/
+		if ((dest_cpu < 0 || dest_cpu == cpu_of(rq)) && !pending) {
+			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
+			goto out;
+		}
 
+		/*
+		 * Catch any affinity change between the stop_cpu() call and us
+		 * getting here.
+		 * For migrate_enable(), we just want to pick an allowed one.
+		 */
+		if (dest_cpu < 0 || !cpumask_test_cpu(dest_cpu, &p->cpus_mask))
 			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
-		}
 
 		if (task_on_rq_queued(p))
 			rq = __migrate_task(rq, &rf, p, dest_cpu);
-- 
2.27.0

