Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE337F007
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbhELXmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243788AbhELXbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38F3461421;
        Wed, 12 May 2021 23:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620862196;
        bh=XdjPdWYdmNBmkvweGZiniBX1BjkxZLsAAZgzewELI8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AA1J2Ni5dmVwJ6/MuL8p0yfFla3VtZcK7939p74VqU9GuSXjymh3TMT0LwAyiKZ2u
         GbjpeSS9LYKlyjPu6Y1UV/Ew+fFSKfl2UQ/zIpz9B/khfFyFA4H/8FzJ0SyQ8v0PoA
         knj3/EoqKud/c/Oq+N+HLwy7DHwF5fGUR+4aUb2p8Kz528dlKrnkiGcrmrJNxqTdGf
         Livy08pKbl+m7B5vIqezq/d+NYhdaiY4DGitQ9t9T5VZ18X3eWpVB7kYykvMeSifGL
         oRT6Vf7fn2/tcYbzqUAS8KuIo97xvtf11YPB967G4pFVBW2ZiAV6BYY4fovH11z/Re
         Ke1PJGHeiGtwA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 08/10] tick/nohz: Kick only _queued_ task whose tick dependency is updated
Date:   Thu, 13 May 2021 01:29:22 +0200
Message-Id: <20210512232924.150322-9-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512232924.150322-1-frederic@kernel.org>
References: <20210512232924.150322-1-frederic@kernel.org>
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
Acked-by: Peter Zijlstra <peterz@infradead.org>
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
index d2c881384517..3341ae2e8231 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2011,6 +2011,8 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 
 #endif /* CONFIG_SMP */
 
+extern bool sched_task_on_rq(struct task_struct *p);
+
 /*
  * In order to reduce various lock holder preemption latencies provide an
  * interface to see if a vCPU is currently running or not.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..78e480f7881a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1590,6 +1590,11 @@ static inline void uclamp_post_fork(struct task_struct *p) { }
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
index 800719ea4045..d370a04deaa8 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -324,14 +324,28 @@ void tick_nohz_full_kick_cpu(int cpu)
 
 static void tick_nohz_kick_task(struct task_struct *tsk)
 {
-	int cpu = task_cpu(tsk);
+	int cpu;
+
+	/*
+	 * If the task is not running, run_posix_cpu_timers
+	 * has nothing to elapse, IPI can then be spared.
+	 *
+	 * activate_task()                      STORE p->tick_dep_mask
+	 *   STORE p->on_rq
+	 * __schedule() (switch to task 'p')    smp_mb() (atomic_fetch_or())
+	 *   LOCK rq->lock                      LOAD p->on_rq
+	 *   smp_mb__after_spin_lock()
+	 *   tick_nohz_task_switch()
+	 *     LOAD p->tick_dep_mask
+	 */
+	if (!sched_task_on_rq(tsk))
+		return;
 
 	/*
 	 * If the task concurrently migrates to another cpu,
 	 * we guarantee it sees the new tick dependency upon
 	 * schedule.
 	 *
-	 *
 	 * set_task_cpu(p, cpu);
 	 *   STORE p->cpu = @cpu
 	 * __schedule() (switch to task 'p')
@@ -340,6 +354,7 @@ static void tick_nohz_kick_task(struct task_struct *tsk)
 	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
 	 *      LOAD p->tick_dep_mask           LOAD p->cpu
 	 */
+	cpu = task_cpu(tsk);
 
 	preempt_disable();
 	if (cpu_online(cpu))
-- 
2.25.1

