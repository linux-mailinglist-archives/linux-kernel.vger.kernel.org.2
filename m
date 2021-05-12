Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EBE37F00A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbhELXnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243801AbhELXbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E007D61419;
        Wed, 12 May 2021 23:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620862191;
        bh=zoEBwoFlfzxHdcfT/CJv36f7y4sja7OTvx5PCo9WrcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oo93JNqh5kVUwjkpV5MEsUKXDtuEttCtHMgpZHUQeBAUvDT0FpAWn6d0TRCipN8vF
         CRS9uZl3iw/TkXahmeyKbYF82n/wYcQVdmpxqsZncJaQdo+RMsJetcUwtW0KvNpSZ0
         XfVdvOzdAmlccJugT8+R0U3B6wcTh/P+gdn1J8P0IVmmzowJGvJIcYCKsjh3CQ0lb4
         LVDtyXGqNfiIxP9a6A7K0iVqNaIS3VZ2ZJf/zGNshnBPZeYgIcV9B0JTc85gB+Ekne
         UcEWLAYu8QTycMP58Nk5RDC1UnQAt+/LaqffC6Q8D8YeH/FZzAqygtffViTypXxKV5
         L0JlEY4EIzdcQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 06/10] tick/nohz: Only wakeup a single target cpu when kicking a task
Date:   Thu, 13 May 2021 01:29:20 +0200
Message-Id: <20210512232924.150322-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512232924.150322-1-frederic@kernel.org>
References: <20210512232924.150322-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a tick dependency to a task, its necessary to
wakeup the CPU where the task resides to reevaluate tick
dependencies on that CPU.

However the current code wakes up all nohz_full CPUs, which
is unnecessary.

Switch to waking up a single CPU, by using ordering of writes
to task->cpu and task->tick_dep_mask.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
---
 kernel/time/tick-sched.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 89ec0abcd62b..1991adf5a922 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -322,6 +322,31 @@ void tick_nohz_full_kick_cpu(int cpu)
 	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
 }
 
+static void tick_nohz_kick_task(struct task_struct *tsk)
+{
+	int cpu = task_cpu(tsk);
+
+	/*
+	 * If the task concurrently migrates to another cpu,
+	 * we guarantee it sees the new tick dependency upon
+	 * schedule.
+	 *
+	 *
+	 * set_task_cpu(p, cpu);
+	 *   STORE p->cpu = @cpu
+	 * __schedule() (switch to task 'p')
+	 *   LOCK rq->lock
+	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
+	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
+	 *      LOAD p->tick_dep_mask           LOAD p->cpu
+	 */
+
+	preempt_disable();
+	if (cpu_online(cpu))
+		tick_nohz_full_kick_cpu(cpu);
+	preempt_enable();
+}
+
 /*
  * Kick all full dynticks CPUs in order to force these to re-evaluate
  * their dependency on the tick and restart it if necessary.
@@ -404,19 +429,8 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
  */
 void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
 {
-	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
-		if (tsk == current) {
-			preempt_disable();
-			tick_nohz_full_kick();
-			preempt_enable();
-		} else {
-			/*
-			 * Some future tick_nohz_full_kick_task()
-			 * should optimize this.
-			 */
-			tick_nohz_full_kick_all();
-		}
-	}
+	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask))
+		tick_nohz_kick_task(tsk);
 }
 EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
 
-- 
2.25.1

