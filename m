Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB42A358FE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhDHWj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhDHWj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:39:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD85261159;
        Thu,  8 Apr 2021 22:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617921554;
        bh=8mWHhPjPigdfaRn4nF/YPGY42tK4rYcbxg+b6Qq4fbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmwykM6P5Myr4k0o+cqEu/4lxbRI2LmRHzBZz4NUuRF0sERpIc+Euk+JfGTPIfKnh
         cMqKfHqdS6kHifQN+NBkXg2Pk10Nhm4GfAWyh6xgLwJ8b4/gN27OqaIXitzueTRSiz
         qmXllY8E6V/vJ0RkRnZnJIwqiBeXSSE6G9asjV8UTJvkV4VGuOWLeCwG/8X6zfr8xi
         5T6lGkBj6lZh4s5e37iPG71A/UsMedMJzHNbweqgiBY9DLS6N+BqivoYPnW5lq1+m4
         NNY8azMvRCbiwXd7RfhlgVJ7mb/eWSC0+udlon/zvCC4duwzKi1TA1mHJbSEz9iM6i
         uHpmiG7beXO3w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/5] srcu: Fix broken node geometry after early ssp init
Date:   Fri,  9 Apr 2021 00:39:00 +0200
Message-Id: <20210408223902.6405-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408223902.6405-1-frederic@kernel.org>
References: <20210408223902.6405-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An ssp initialized before rcu_init_geometry() will have its snp hierarchy
based on CONFIG_NR_CPUS.

Once rcu_init_geometry() is called, the nodes distribution is shrinked
and optimized toward meeting the actual possible number of CPUs detected
on boot.

Later on, the ssp that was initialized before rcu_init_geometry() is
confused and sometimes refers to its initial CONFIG_NR_CPUS based node
hierarchy, sometimes to the new num_possible_cpus() based one instead.
For example each of its sdp->mynode remain backward and refer to the
early node leaves that may not exist anymore. On the other hand the
srcu_for_each_node_breadth_first() refers to the new node hierarchy.

There are at least two bad possible outcomes to this:

1) a) A callback enqueued early on an sdp is recorded pending on
      sdp->mynode->srcu_data_have_cbs in srcu_funnel_gp_start() with
      sdp->mynode pointing to a deep leaf (say 3 levels).

   b) The grace period ends after rcu_init_geometry() which shrinks the
      nodes level to a single one. srcu_gp_end() walks through the new
      snp hierarchy without ever reaching the old leaves so the callback
      is never executed.

   This is easily reproduced on an 8 CPUs machine with
   CONFIG_NR_CPUS >= 32 and "rcupdate.rcu_self_test=1". The
   srcu_barrier() after early tests verification never completes and
   the boot hangs:

	[ 5413.141029] INFO: task swapper/0:1 blocked for more than 4915 seconds.
	[ 5413.147564]       Not tainted 5.12.0-rc4+ #28
	[ 5413.151927] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	[ 5413.159753] task:swapper/0       state:D stack:    0 pid:    1 ppid:     0 flags:0x00004000
	[ 5413.168099] Call Trace:
	[ 5413.170555]  __schedule+0x36c/0x930
	[ 5413.174057]  ? wait_for_completion+0x88/0x110
	[ 5413.178423]  schedule+0x46/0xf0
	[ 5413.181575]  schedule_timeout+0x284/0x380
	[ 5413.185591]  ? wait_for_completion+0x88/0x110
	[ 5413.189957]  ? mark_held_locks+0x61/0x80
	[ 5413.193882]  ? mark_held_locks+0x61/0x80
	[ 5413.197809]  ? _raw_spin_unlock_irq+0x24/0x50
	[ 5413.202173]  ? wait_for_completion+0x88/0x110
	[ 5413.206535]  wait_for_completion+0xb4/0x110
	[ 5413.210724]  ? srcu_torture_stats_print+0x110/0x110
	[ 5413.215610]  srcu_barrier+0x187/0x200
	[ 5413.219277]  ? rcu_tasks_verify_self_tests+0x50/0x50
	[ 5413.224244]  ? rdinit_setup+0x2b/0x2b
	[ 5413.227907]  rcu_verify_early_boot_tests+0x2d/0x40
	[ 5413.232700]  do_one_initcall+0x63/0x310
	[ 5413.236541]  ? rdinit_setup+0x2b/0x2b
	[ 5413.240207]  ? rcu_read_lock_sched_held+0x52/0x80
	[ 5413.244912]  kernel_init_freeable+0x253/0x28f
	[ 5413.249273]  ? rest_init+0x250/0x250
	[ 5413.252846]  kernel_init+0xa/0x110
	[ 5413.256257]  ret_from_fork+0x22/0x30

2) An ssp that gets initialized before rcu_init_geometry() and used
   afterward will always have stale rdp->mynode references, resulting in
   callbacks to be missed in srcu_gp_end(), just like in the previous
   scenario.

Solve this once rcu_init_geometry() is done with resetting the whole
state and node tree layout for each early initialized ssp's. Queued
callbacks are saved then requeued once the ssp reset is done.

Suggested-by: Paul E . McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
---
 include/linux/srcutree.h |  1 +
 kernel/rcu/srcutree.c    | 77 ++++++++++++++++++++++++++++++++++------
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index cb1f4351e8ba..a2422c442470 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -83,6 +83,7 @@ struct srcu_struct {
 						/*  operation. */
 	struct delayed_work work;
 	struct lockdep_map dep_map;
+	struct list_head early_init;
 };
 
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 108f9ca06047..7ca1bd0067c4 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -39,7 +39,7 @@ static ulong counter_wrap_check = (ULONG_MAX >> 2);
 module_param(counter_wrap_check, ulong, 0444);
 
 /* Early-boot callback-management, so early that no lock is required! */
-static LIST_HEAD(srcu_boot_list);
+static LIST_HEAD(srcu_early_init_list);
 static bool __read_mostly srcu_init_done;
 
 static void srcu_invoke_callbacks(struct work_struct *work);
@@ -174,10 +174,61 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	init_srcu_struct_nodes(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	if (!srcu_init_done)
+		list_add_tail(&ssp->early_init, &srcu_early_init_list);
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
 	return 0;
 }
 
+/*
+ * After rcu_init_geometry(), early initialized SRCU nodes can be
+ * in a confused state, with sdp->mynode pointing to pruned nodes.
+ * Reset the ssp struct along with its node hierarchy and requeue its
+ * callbacks.
+ */
+static void reset_srcu_struct(struct srcu_struct *ssp)
+{
+	int cpu;
+	struct lockdep_map dep_map;
+	struct rcu_cblist pendcbs;
+	struct rcu_head *rhp;
+	struct srcu_data __percpu *sda;
+
+	rcu_cblist_init(&pendcbs);
+
+	for_each_possible_cpu(cpu) {
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
+
+		if (cpu == smp_processor_id())
+			rcu_segcblist_extract_pend_cbs(&sdp->srcu_cblist, &pendcbs);
+
+		/*
+		 * We don't expect to have ready callbacks at this stage, nor any
+		 * callback at all on non-boot CPUs.
+		 */
+		WARN_ON_ONCE(!rcu_segcblist_empty(&sdp->srcu_cblist));
+
+		memset(sdp, 0, sizeof(*sdp));
+	}
+
+	/*
+	 * Save the per-CPU states. We don't need to re-allocate them.
+	 * Besides they may even be static.
+	 */
+	sda = ssp->sda;
+	/* Save the lockdep map, it may not suffer double-initialization */
+	dep_map = ssp->dep_map;
+
+	memset(ssp, 0, sizeof(*ssp));
+	ssp->sda = sda;
+	ssp->dep_map = dep_map;
+	spin_lock_init(&ACCESS_PRIVATE(ssp, lock));
+	init_srcu_struct_fields(ssp, true);
+
+	while ((rhp = rcu_cblist_dequeue(&pendcbs)))
+		call_srcu(ssp, rhp, rhp->func);
+}
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
@@ -675,11 +726,14 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
+		/*
+		 * If SRCU isn't initialized yet, the grace period will be
+		 * started again on srcu_init() at which point the work will
+		 * be safely queued to rcu_gp_wq.
+		 */
 		if (likely(srcu_init_done))
 			queue_delayed_work(rcu_gp_wq, &ssp->work,
 					   srcu_get_delay(ssp));
-		else if (list_empty(&ssp->work.work.entry))
-			list_add(&ssp->work.work.entry, &srcu_boot_list);
 	}
 	spin_unlock_irqrestore_rcu_node(ssp, flags);
 }
@@ -1382,7 +1436,9 @@ early_initcall(srcu_bootup_announce);
 
 void __init srcu_init(void)
 {
-	struct srcu_struct *ssp;
+	struct srcu_struct *ssp, *tmp;
+
+	lockdep_assert_irqs_disabled();
 
 	/*
 	 * Once that is set, call_srcu() can follow the normal path and
@@ -1390,12 +1446,13 @@ void __init srcu_init(void)
 	 * and timers initialization.
 	 */
 	srcu_init_done = true;
-	while (!list_empty(&srcu_boot_list)) {
-		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
-				      work.work.entry);
-		list_del_init(&ssp->work.work.entry);
-		queue_work(rcu_gp_wq, &ssp->work.work);
-	}
+	/*
+	 * ssp's that got initialized before rcu_init_geometry() have a stale
+	 * node hierarchy. Rebuild their node trees and requeue their pending
+	 * callbacks.
+	 */
+	list_for_each_entry_safe(ssp, tmp, &srcu_early_init_list, early_init)
+		reset_srcu_struct(ssp);
 }
 
 #ifdef CONFIG_MODULES
-- 
2.25.1

