Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFE1432B09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhJSAKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233880AbhJSAKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:10:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F342861350;
        Tue, 19 Oct 2021 00:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602108;
        bh=f2LmMIqQcz67Sks7M7Cnnc/R1j2F6JCXPEsP9uZVo+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO3N5v4t3MC85qwho9malkhl9fFeqUkiLMPOA+Hc+b1GgKNjMo5NCTo3d8rHfsdvI
         Fm7hMFB2khkndjje5mKhFupa8YwcmECqaGWu172iAv+REG1NLruBnUEoE+Rz2Hfwgm
         zLnz9r/im1t1hU1Z/gq7zLfH+RG5TUHxBAwuJHuRO72ZT0XQsn60iMqXYkJnl2SlKE
         5AWbXVYX/YqonpqxStZ7aEW9en/YicEVAxfrnIlGI5F3vWtSJ3vmrVI55Fz/6Sjh0B
         S6R1WEQBPir8+n4rEGdSx7MuD77y8YNRuzCMZI1RiqWb9z2IiS3+aKwUbHtlKWDmnj
         GlBj1J+Tv8F0A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 02/10] rcu/nocb: Invoke rcu_core() at the start of deoffloading
Date:   Tue, 19 Oct 2021 02:08:08 +0200
Message-Id: <20211019000816.455375-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019000816.455375-1-frederic@kernel.org>
References: <20211019000816.455375-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PREEMPT_RT, if rcu_core() is preempted by the de-offloading process,
some work, such as callbacks acceleration and invocation, may be left
unattended due to the volatile checks on the offloaded state.

In the worst case this work is postponed until the next rcu_pending()
check that can take a jiffy to reach, which can be a problem in case
of callbacks flooding.

Solve that with invoking rcu_core() early in the de-offloading process.
This way any work dismissed by an ongoing rcu_core() call fooled by
a preempting deoffloading process will be caught up by a nearby future
recall to rcu_core(), this time fully aware of the de-offloading state.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h | 14 ++++++++++++++
 kernel/rcu/rcu_segcblist.c    |  6 ++----
 kernel/rcu/tree.c             | 17 +++++++++++++++++
 kernel/rcu/tree_nocb.h        |  9 +++++++++
 4 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 812961b1d064..659d13a7ddaa 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -136,6 +136,20 @@ struct rcu_cblist {
  *  |--------------------------------------------------------------------------|
  *  |                           SEGCBLIST_RCU_CORE   |                         |
  *  |                           SEGCBLIST_LOCKING    |                         |
+ *  |                           SEGCBLIST_OFFLOADED  |                         |
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
+ *  |   handles callbacks concurrently. Bypass enqueue is enabled.             |
+ *  |   Invoke RCU core so we make sure not to preempt it in the middle with   |
+ *  |   leaving some urgent work unattended within a jiffy.                    |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_RCU_CORE   |                         |
+ *  |                           SEGCBLIST_LOCKING    |                         |
  *  |                           SEGCBLIST_KTHREAD_CB |                         |
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index c07aab6e39ef..81145c3ece25 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -265,12 +265,10 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
 {
-	if (offload) {
+	if (offload)
 		rcu_segcblist_set_flags(rsclp, SEGCBLIST_LOCKING | SEGCBLIST_OFFLOADED);
-	} else {
-		rcu_segcblist_set_flags(rsclp, SEGCBLIST_RCU_CORE);
+	else
 		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_OFFLOADED);
-	}
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e38028d48648..b236271b9022 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2717,6 +2717,23 @@ static __latent_entropy void rcu_core(void)
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
+	/*
+	 * On RT rcu_core() can be preempted when IRQs aren't disabled.
+	 * Therefore this function can race with concurrent NOCB (de-)offloading
+	 * on this CPU and the below condition must be considered volatile.
+	 * However if we race with:
+	 *
+	 * _ Offloading:   In the worst case we accelerate or process callbacks
+	 *                 concurrently with NOCB kthreads. We are guaranteed to
+	 *                 call rcu_nocb_lock() if that happens.
+	 *
+	 * _ Deoffloading: In the worst case we miss callbacks acceleration or
+	 *                 processing. This is fine because the early stage
+	 *                 of deoffloading invokes rcu_core() after setting
+	 *                 SEGCBLIST_RCU_CORE. So we guarantee that we'll process
+	 *                 what could have been dismissed without the need to wait
+	 *                 for the next rcu_pending() check in the next jiffy.
+	 */
 	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b3e07d0bfbbf..2461fe8d0c23 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -990,6 +990,15 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 * will refuse to put anything into the bypass.
 	 */
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	/*
+	 * Start with invoking rcu_core() early. This way if the current thread
+	 * happens to preempt an ongoing call to rcu_core() in the middle,
+	 * leaving some work dismissed because rcu_core() still thinks the rdp is
+	 * completely offloaded, we are guaranteed a nearby future instance of
+	 * rcu_core() to catch up.
+	 */
+	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
+	invoke_rcu_core();
 	ret = rdp_offload_toggle(rdp, false, flags);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
-- 
2.25.1

