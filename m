Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0023935F4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351332AbhDNNYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351466AbhDNNYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:24:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 254C9611AD;
        Wed, 14 Apr 2021 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618406661;
        bh=hPfiwarYM7YNO7SIjk41LUb17gc4VW3U0j0edfurSpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ps68EAFswVKzvJQ7kUtCj+E/qqxwM831gz3O6gDEd9SvzAiXdhX3VQbnibwpGWuoz
         y0rXj85A8JGqY+ql3iIK4tUn4zddBtFzkmHoM6+TvfTMZgNUTXOqPHTNibRAwroCQy
         0qQDMNmNS89utRQohfdJmuBVg2mytcZ0KllVRBTRdKRD/tGpL+KDLddJrPg6aaQrAX
         LoMJHK4oJzKUktG0eE08QaJbWdiMsrtU54rRS9Bc06p5eoEsuF9L1ujjKOQwdocrtz
         DoIoESliDSO1ATzKY0FjdviHbaV+orV82ez6vQgrMcM8yONOKOrduzrrzgGVN+38gA
         YcIDSUjmvmV8A==
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
Subject: [PATCH 1/2] srcu: Fix broken node geometry after early ssp init
Date:   Wed, 14 Apr 2021 15:24:12 +0200
Message-Id: <20210414132413.98062-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414132413.98062-1-frederic@kernel.org>
References: <20210414132413.98062-1-frederic@kernel.org>
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

Solve this with calling rcu_init_geometry() whenever an struct srcu_state
happens to be initialized before rcu_init(). This way we make sure the
RCU nodes hierarchy is properly built and distributed before the nodes
of a struct srcu_state are allocated.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
---
 kernel/rcu/rcu.h      |  3 +++
 kernel/rcu/srcutree.c |  2 ++
 kernel/rcu/tree.c     | 18 +++++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 75ed367d5b60..24db97cbf76b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -278,6 +278,7 @@ extern void resched_cpu(int cpu);
 extern int rcu_num_lvls;
 extern int num_rcu_lvl[];
 extern int rcu_num_nodes;
+extern bool rcu_geometry_initialized;
 static bool rcu_fanout_exact;
 static int rcu_fanout_leaf;
 
@@ -308,6 +309,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 	}
 }
 
+extern void rcu_init_geometry(void);
+
 /* Returns a pointer to the first leaf rcu_node structure. */
 #define rcu_first_leaf_node() (rcu_state.level[rcu_num_lvls - 1])
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 108f9ca06047..05ca3c275af1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -171,6 +171,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	if (!ssp->sda)
 		return -ENOMEM;
+	if (!rcu_geometry_initialized)
+		rcu_init_geometry();
 	init_srcu_struct_nodes(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 740f5cd34459..b1d6e60e08d1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4556,17 +4556,33 @@ static void __init rcu_init_one(void)
 	}
 }
 
+bool rcu_geometry_initialized __read_mostly;
+
 /*
  * Compute the rcu_node tree geometry from kernel parameters.  This cannot
  * replace the definitions in tree.h because those are needed to size
  * the ->node array in the rcu_state structure.
  */
-static void __init rcu_init_geometry(void)
+void rcu_init_geometry(void)
 {
 	ulong d;
 	int i;
+	static unsigned long old_nr_cpu_ids;
 	int rcu_capacity[RCU_NUM_LVLS];
 
+	if (rcu_geometry_initialized) {
+		/*
+		 * Arrange for warning if rcu_init_geometry() was called before
+		 * setup_nr_cpu_ids(). We may miss cases when
+		 * nr_cpus_ids == NR_CPUS but that shouldn't matter too much.
+		 */
+		WARN_ON_ONCE(old_nr_cpu_ids != nr_cpu_ids);
+		return;
+	}
+
+	old_nr_cpu_ids = nr_cpu_ids;
+	rcu_geometry_initialized = true;
+
 	/*
 	 * Initialize any unspecified boot parameters.
 	 * The default values of jiffies_till_first_fqs and
-- 
2.25.1

