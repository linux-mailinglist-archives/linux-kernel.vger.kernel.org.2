Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3313372D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhCKMhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233216AbhCKMhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:37:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D886464FE2;
        Thu, 11 Mar 2021 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466240;
        bh=ihrDgHPsOXbJ0Kv6xMjDIKxHBrnQYBX7f9H3CeZ7+Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+xwuhAJouSIwNkq4pLlOxiqqBvcHt+bcl0oGaK3UaiAIWpZ1tBo5TtzrHopuLjU3
         RQDE8fXmi0Xfd6pgs+rozhhCebHvWatzK1DVLo/sktls48RQd22lSmbi36o5GF021C
         56bwFW+wMsi4hdYduuVQl/3MLYlSuafgWeYfrJwvUPRnLrvGb3XQnwNqj+65fipZF0
         Jr+z8JA2QswLofn1q21MxQSnScxt1k6EpZCcrTHcPZtj+JZh8EI3OIcpz+i40gZO9R
         BLK8CQM2EKSHdlQqR8yQeNQO5HcvwypKVNK0MVBY+HCao/+VwCfNXsswK+lxzfJMIZ
         k4hHYTXPBCI3A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 02/10] tick/nohz: Add tick_nohz_full_this_cpu()
Date:   Thu, 11 Mar 2021 13:37:00 +0100
Message-Id: <20210311123708.23501-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311123708.23501-1-frederic@kernel.org>
References: <20210311123708.23501-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize further the check for local full dynticks CPU. Testing directly
tick_nohz_full_cpu(smp_processor_id()) is suboptimal because the
compiler first fetches the CPU number and only then processes the
static key.

It's best to evaluate the static branch before anything. Provide with a
function that handles that correctly and convert some users along.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/tick.h     | 11 ++++++++++-
 kernel/time/tick-sched.c | 12 +++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7340613c7eff..bfc96cbe955c 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -193,6 +193,14 @@ static inline bool tick_nohz_full_cpu(int cpu)
 	return cpumask_test_cpu(cpu, tick_nohz_full_mask);
 }
 
+static inline bool tick_nohz_full_this_cpu(void)
+{
+	if (!tick_nohz_full_enabled())
+		return false;
+
+	return cpumask_test_cpu(smp_processor_id(), tick_nohz_full_mask);
+}
+
 static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask)
 {
 	if (tick_nohz_full_enabled())
@@ -271,6 +279,7 @@ extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
 #else
 static inline bool tick_nohz_full_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
+static inline bool tick_nohz_full_this_cpu(void) { return false; }
 static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
 static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
@@ -296,7 +305,7 @@ static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
 
 static inline void tick_nohz_task_switch(void)
 {
-	if (tick_nohz_full_enabled())
+	if (tick_nohz_full_this_cpu())
 		__tick_nohz_task_switch();
 }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 22b6a46818cf..af76cfa51b57 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -304,7 +304,7 @@ static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =
  */
 static void tick_nohz_full_kick(void)
 {
-	if (!tick_nohz_full_cpu(smp_processor_id()))
+	if (!tick_nohz_full_this_cpu())
 		return;
 
 	irq_work_queue(this_cpu_ptr(&nohz_full_kick_work));
@@ -452,9 +452,6 @@ void __tick_nohz_task_switch(void)
 
 	local_irq_save(flags);
 
-	if (!tick_nohz_full_cpu(smp_processor_id()))
-		goto out;
-
 	ts = this_cpu_ptr(&tick_cpu_sched);
 
 	if (ts->tick_stopped) {
@@ -462,7 +459,6 @@ void __tick_nohz_task_switch(void)
 		    atomic_read(&current->signal->tick_dep_mask))
 			tick_nohz_full_kick();
 	}
-out:
 	local_irq_restore(flags);
 }
 
@@ -929,14 +925,16 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 static void tick_nohz_full_update_tick(struct tick_sched *ts)
 {
 #ifdef CONFIG_NO_HZ_FULL
-	int cpu = smp_processor_id();
+	int cpu;
 
-	if (!tick_nohz_full_cpu(cpu))
+	if (!tick_nohz_full_this_cpu())
 		return;
 
 	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
 		return;
 
+	cpu = smp_processor_id();
+
 	if (can_stop_full_tick(cpu, ts))
 		tick_nohz_stop_sched_tick(ts, cpu);
 	else if (ts->tick_stopped)
-- 
2.25.1

