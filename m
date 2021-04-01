Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DA835242C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhDAXrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236222AbhDAXrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:47:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C341461108;
        Thu,  1 Apr 2021 23:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617320839;
        bh=qdwdvwdseQFmYkf5aeev93y8VzxZQGCDKdaxSPGVIvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=os31SLTAyW7KfdqZe6UR5qjgIpiEk4d0YYBhE/tk2t2GIP+nKVYFd06LXuyBdyHG1
         is6Dio9q+xeATOH88tCrJrvscGOLIy9PF2WekotOw2qd91LuDbMQgEYzXJAwXJMcr7
         rjstEwL3VJ6p+Iv7Tr+w9mWbMWsSySqVg+LYhYuBDyONfUwfVFSjVsOTGFxSbr6ynS
         C1yNCBo6Jmjsn1bRP5za+KZ66FeaOce+iERT5O9h+8ukamKn7qoPW4GLyu6XoVnUWT
         Ts8BRiR4gPQ0LcvW1HpDTkhupIFVpEUGPt+35L71I/wHMFRoYkLLbmy4xq0B1YN7ww
         VXXwmX0n37Wig==
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
Subject: [PATCH 3/3] srcu: Fix broken node geometry after early ssp init
Date:   Fri,  2 Apr 2021 01:47:04 +0200
Message-Id: <20210401234704.125498-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401234704.125498-1-frederic@kernel.org>
References: <20210401234704.125498-1-frederic@kernel.org>
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

Solve this with fixing the node tree layout of early initialized ssp
once rcu_init_geometry() is done. Unfortunately this involves a new
field into struct srcu_struct to postpone the ssp hierarchy rebuild.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
---
 include/linux/srcutree.h |  1 +
 kernel/rcu/srcutree.c    | 68 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a756ae..4339e5794a72 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -85,6 +85,7 @@ struct srcu_struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
+	struct list_head early_init;
 };
 
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 10e681ea7051..285f0c053754 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -39,7 +39,7 @@ static ulong counter_wrap_check = (ULONG_MAX >> 2);
 module_param(counter_wrap_check, ulong, 0444);
 
 /* Early-boot callback-management, so early that no lock is required! */
-static LIST_HEAD(srcu_boot_list);
+static LIST_HEAD(srcu_boot_queue_list);
 static bool __read_mostly srcu_init_done;
 
 static void srcu_invoke_callbacks(struct work_struct *work);
@@ -133,7 +133,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 	for_each_possible_cpu(cpu) {
 		sdp = per_cpu_ptr(ssp->sda, cpu);
 		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
-		rcu_segcblist_init(&sdp->srcu_cblist);
+		/* Preserve the queue in case of hierarchy rebuild */
+		if (!rcu_segcblist_is_enabled(&sdp->srcu_cblist))
+			rcu_segcblist_init(&sdp->srcu_cblist);
 		sdp->srcu_cblist_invoking = false;
 		sdp->srcu_gp_seq_needed = ssp->srcu_gp_seq;
 		sdp->srcu_gp_seq_needed_exp = ssp->srcu_gp_seq;
@@ -151,6 +153,8 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 	}
 }
 
+static LIST_HEAD(srcu_early_init_list);
+
 /*
  * Initialize non-compile-time initialized fields, including the
  * associated srcu_node and srcu_data structures.  The is_static
@@ -174,6 +178,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	init_srcu_struct_nodes(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	if (!srcu_init_done)
+		list_add_tail(&ssp->early_init, &srcu_early_init_list);
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
 	return 0;
 }
@@ -679,7 +685,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 			queue_delayed_work(rcu_gp_wq, &ssp->work,
 					   srcu_get_delay(ssp));
 		else if (list_empty(&ssp->work.work.entry))
-			list_add(&ssp->work.work.entry, &srcu_boot_list);
+			list_add(&ssp->work.work.entry, &srcu_boot_queue_list);
 	}
 	spin_unlock_irqrestore_rcu_node(ssp, flags);
 }
@@ -1380,14 +1386,62 @@ static int __init srcu_bootup_announce(void)
 }
 early_initcall(srcu_bootup_announce);
 
+static void __init restore_srcu_sdp(struct srcu_data *sdp,
+				    struct srcu_data *old_sdp,
+				    struct srcu_node *old_mynode)
+{
+	int i;
+	struct srcu_node *mynode = sdp->mynode;
+	struct srcu_node *snp = mynode;
+
+	/* No need to lock the nodes at this stage. We are on early boot */
+	for (snp = mynode; snp != NULL; snp = snp->srcu_parent) {
+		for (i = 0; i < ARRAY_SIZE(old_mynode->srcu_have_cbs); i++) {
+			snp->srcu_have_cbs[i] = old_mynode->srcu_have_cbs[i];
+
+			if (snp != mynode)
+				continue;
+
+			if (old_mynode->srcu_data_have_cbs[i] == old_sdp->grpmask) {
+				snp->srcu_data_have_cbs[i] = sdp->grpmask;
+			} else if (!old_mynode->srcu_data_have_cbs[i]) {
+				snp->srcu_data_have_cbs[i] = 0;
+			} else {
+				/* Don't expect other CPUs to have callbacks that early */
+				WARN_ON_ONCE(1);
+			}
+		}
+		snp->srcu_gp_seq_needed_exp = old_mynode->srcu_gp_seq_needed_exp;
+	}
+
+	sdp->srcu_gp_seq_needed = old_sdp->srcu_gp_seq_needed;
+	sdp->srcu_gp_seq_needed_exp = old_sdp->srcu_gp_seq_needed_exp;
+}
+
 void __init srcu_init(void)
 {
-	struct srcu_struct *ssp;
+	static struct srcu_data __initdata old_sdp;
+	static struct srcu_node __initdata old_mynode;
+	struct srcu_struct *ssp, *tmp;
 
 	srcu_init_done = true;
-	while (!list_empty(&srcu_boot_list)) {
-		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
-				      work.work.entry);
+	/*
+	 * ssp's that got initialized before rcu_init_geometry() have a stale
+	 * node hierarchy. Rebuild their node trees and propagate states from
+	 * pruned leaf nodes.
+	 */
+	list_for_each_entry_safe(ssp, tmp, &srcu_early_init_list, early_init) {
+		struct srcu_data *sdp = this_cpu_ptr(ssp->sda);
+
+		list_del(&ssp->early_init);
+		old_sdp = *sdp;
+		old_mynode = *sdp->mynode;
+		init_srcu_struct_nodes(ssp);
+		restore_srcu_sdp(sdp, &old_sdp, &old_mynode);
+	}
+
+	/* Handle works that had to wait before workqueues get created */
+	list_for_each_entry_safe(ssp, tmp, &srcu_boot_queue_list, work.work.entry) {
 		list_del_init(&ssp->work.work.entry);
 		queue_work(rcu_gp_wq, &ssp->work.work);
 	}
-- 
2.25.1

