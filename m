Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150A93372DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhCKMiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233231AbhCKMhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:37:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18EBE64FE7;
        Thu, 11 Mar 2021 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466262;
        bh=38O6IdUVlG5EbO7ReCj+0QIhJzLPIefrvh064DDAteY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNWKZLOCLTadlUkZVfZf1xdB8v1+pMXDChUaDgzJHs+WnbOWNGfXozIQBMZpWREPf
         MRAvXBef4MZSXyewBcdoXxDXV+iSrMUsOU7NxfrH5Q4zR4t852IEHaCi2CrpY32uAW
         afZQbElqOhOVRX6+y6wgCDQjgwNPssHs+QyNk2Vo27BC+6LD/xJzFJKf7KB/qY8bPY
         qJFHDQmCxJgZioEKv/79Uvj4Dx+s0Q9YKpOV3PAWZM8lPPM2FvzTHDCAtfJRbJ6BAN
         her6KE2fCu7I7opKuRe+aL2aEv42uk5Xv2M/smmoArsq4kW5jOdQRWVyaZsqpukFsw
         eBiUgSQC4dPPw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 10/10] tick/nohz: Kick only _queued_ task whose tick dependency is updated
Date:   Thu, 11 Mar 2021 13:37:08 +0100
Message-Id: <20210311123708.23501-11-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311123708.23501-1-frederic@kernel.org>
References: <20210311123708.23501-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Tosatti <mtosatti@redhat.com>

When the tick dependency of a task is updated, we want it to aknowledge
the new state and restart the tick if needed. If the task is not
running, we don't need to kick it because it will observe the new
dependency upon scheduling in. But if the task is running, we may need
to send an IPI to it so that it gets notified.

Unfortunately we don't have the means to check if a task is running
in a race free way. Checking p->on_cpu in a synchronized way against
p->tick_dep_mask would imply adding a full barrier between
prepare_task_switch() and tick_nohz_task_switch(), which we want to
avoid in this fast-path.

Therefore we blindly fire an IPI to the task's CPU.

Meanwhile we can check if the task is queued on the CPU rq because
p->on_rq is always set to TASK_ON_RQ_QUEUED _before_ schedule() and its
full barrier that precedes tick_nohz_task_switch(). And if the task is
queued on a nohz_full CPU, it also has fair chances to be running as the
isolation constraints prescribe running single tasks on full dynticks
CPUs.

So use this as a trick to check if we can spare an IPI toward a
non-running task.

NOTE: For the ordering to be correct, it is assumed that we never
deactivate a task while it is running, the only exception being the task
deactivating itself while scheduling out.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched.h    |  2 ++
 kernel/sched/core.c      |  5 +++++
 kernel/time/tick-sched.c | 19 +++++++++++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef00bb22164c..64dd6f698f3a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1999,6 +1999,8 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 
 #endif /* CONFIG_SMP */
 
+extern bool sched_task_on_rq(struct task_struct *p);
+
 /*
  * In order to reduce various lock holder preemption latencies provide an
  * interface to see if a vCPU is currently running or not.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 24552911f92b..7ec46f3e8110 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1598,6 +1598,11 @@ static inline void uclamp_post_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
 
+bool sched_task_on_rq(struct task_struct *p)
+{
+	return task_on_rq_queued(p);
+}
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a866fd8e7bb5..015281c3dd8d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -324,8 +324,6 @@ void tick_nohz_full_kick_cpu(int cpu)
 
 static void tick_nohz_kick_task(struct task_struct *tsk)
 {
-	int cpu = task_cpu(tsk);
-
 	/*
 	 * If the task concurrently migrates to another cpu,
 	 * we guarantee it sees the new tick dependency upon
@@ -340,6 +338,23 @@ static void tick_nohz_kick_task(struct task_struct *tsk)
 	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
 	 *      LOAD p->tick_dep_mask           LOAD p->cpu
 	 */
+	int cpu = task_cpu(tsk);
+
+	/*
+	 * If the task is not running, run_posix_cpu_timers
+	 * has nothing to elapsed, can spare IPI in that
+	 * case.
+	 *
+	 * activate_task()                      STORE p->tick_dep_mask
+	 * STORE p->on_rq
+	 * __schedule() (switch to task 'p')    smp_mb() (atomic_fetch_or())
+	 * LOCK rq->lock                        LOAD p->on_rq
+	 * smp_mb__after_spin_lock()
+	 * tick_nohz_task_switch()
+	 *	LOAD p->tick_dep_mask
+	 */
+	if (!sched_task_on_rq(tsk))
+		return;
 
 	preempt_disable();
 	if (cpu_online(cpu))
-- 
2.25.1

