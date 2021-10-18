Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420F343176A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhJRLf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhJRLfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:35:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57A1F60E76;
        Mon, 18 Oct 2021 11:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634556794;
        bh=o3zG9J75vFfnzz6Szx1i6SLMtSAq2QBbR5nkK1Kth1c=;
        h=From:To:Cc:Subject:Date:From;
        b=FE817d/tOpvcsHqTCLzVZnpL5/GOw89yqgqoruM50O8//fkFG3wovIrZi2L8yO4Vx
         aoQ+UPqKqv1Z1M4zRqv1Bq7QFuo0geIaQRqf6VrdZwDbl/+c8ezv9OgaLyRq/pOk77
         +eKD8//9bpTgNpburBK7qdd5GMWn8C7Fpn5jrhbTk+DsbmMWxN5OJNYelzlubwr/m1
         A/sILBm1f9VjeeLvIOHI2O24I8d0aV2wzVPsOepTIIgEfDQIwwG/gm+uGcO27SrJVN
         H5U6shImmkZQrbzgB079ZsqYZ4Xz4yGMtTil4VURI7dQOtALMAsnAe64kY1EMzQZIl
         iiLQ0iYY31Atw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH] rcu/nocb: Fix misordered rcu_barrier() while (de-)offloading
Date:   Mon, 18 Oct 2021 13:32:59 +0200
Message-Id: <20211018113259.450292-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an rdp is in the process of (de-)offloading, rcu_core() and the
nocb kthreads can process callbacks at the same time. This leaves many
possible scenarios leading to an rcu barrier to execute before
the preceding callbacks. Here is one such example:

            CPU 0                                  CPU 1
       --------------                         ---------------
     call_rcu(callbacks1)
     call_rcu(callbacks2)
     // move callbacks1 and callbacks2 on the done list
     rcu_advance_callbacks()
     call_rcu(callbacks3)
     rcu_barrier_func()
         rcu_segcblist_entrain(...)
                                            nocb_cb_wait()
                                                rcu_do_batch()
                                                    callbacks1()
                                                    cond_resched_tasks_rcu_qs()
     // move callbacks3 and rcu_barrier_callback()
     // on the done list
     rcu_advance_callbacks()
     rcu_core()
         rcu_do_batch()
             callbacks3()
             rcu_barrier_callback()
                                                    //MISORDERING
                                                    callbacks2()

Fix this with preventing two concurrent rcu_do_batch() on a  same rdp
as long as an rcu barrier callback is pending somewhere.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
---
 kernel/rcu/tree.c      | 27 +++++++++++++++++++++++++--
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h | 10 +++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7a655d93a28a..e5b28e05c9f2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2465,11 +2465,12 @@ int rcutree_dead_cpu(unsigned int cpu)
  * Invoke any RCU callbacks that have made it to the end of their grace
  * period.  Throttle as specified by rdp->blimit.
  */
-static void rcu_do_batch(struct rcu_data *rdp)
+static bool rcu_do_batch(struct rcu_data *rdp)
 {
 	int div;
 	bool __maybe_unused empty;
 	unsigned long flags;
+	int doing_batch;
 	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
@@ -2484,7 +2485,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 				    !rcu_segcblist_empty(&rdp->cblist),
 				    need_resched(), is_idle_task(current),
 				    rcu_is_callbacks_kthread());
-		return;
+		return true;
 	}
 
 	/*
@@ -2494,6 +2495,23 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
+
+	doing_batch = READ_ONCE(rdp->doing_batch);
+
+	/*
+	 * If this rdp is already running callbacks somewhere and an RCU
+	 * barrier is pending, we might run it before its preceding callbacks.
+	 * Prevent that from happening. In the worst case we can have false
+	 * positive on barrier_cpu_count (pending on another rdp or recently
+	 * decremented by a concurrent batch processing) but not false negative.
+	 */
+	if (doing_batch && atomic_read(&rcu_state.barrier_cpu_count)) {
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		return false;
+	}
+
+	WRITE_ONCE(rdp->doing_batch, doing_batch + 1);
+
 	pending = rcu_segcblist_n_cbs(&rdp->cblist);
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
@@ -2591,12 +2609,17 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	WARN_ON_ONCE(count == 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) != 0);
 	WARN_ON_ONCE(!empty && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
 
+	doing_batch = READ_ONCE(rdp->doing_batch);
+	WRITE_ONCE(rdp->doing_batch, doing_batch - 1);
+
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Re-invoke RCU core processing if there are callbacks remaining. */
 	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
 		invoke_rcu_core();
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
+
+	return true;
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index deeaf2fee714..4cea596103a5 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -191,6 +191,7 @@ struct rcu_data {
 
 	/* 4) rcu_barrier(), OOM callbacks, and expediting. */
 	struct rcu_head barrier_head;
+	int doing_batch;
 	int exp_dynticks_snap;		/* Double-check need for IPI. */
 
 	/* 5) Callback offloading. */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 3b470113ae38..bf052251c7ab 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -787,6 +787,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	bool needwake_state = false;
 	bool needwake_gp = false;
 	bool can_sleep = true;
+	bool did_batch;
 	struct rcu_node *rnp = rdp->mynode;
 
 	local_irq_save(flags);
@@ -799,7 +800,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	 * instances of this callback would execute concurrently.
 	 */
 	local_bh_disable();
-	rcu_do_batch(rdp);
+	did_batch = rcu_do_batch(rdp);
 	local_bh_enable();
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
@@ -842,6 +843,13 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	if (needwake_state)
 		swake_up_one(&rdp->nocb_state_wq);
 
+	/*
+	 * If rcu_core() is running concurrently and an rcu barrier
+	 * callback is pending, leave it some time to process because
+	 * we can't run concurrently and guarantee callbacks ordering.
+	 */
+	if (!did_batch && !can_sleep && nocb_cb_can_run(rdp))
+		schedule_timeout_idle(1);
 	do {
 		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
 						    nocb_cb_wait_cond(rdp));
-- 
2.25.1

