Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E04541CF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbhI2WMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347155AbhI2WMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:12:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AB4B615E2;
        Wed, 29 Sep 2021 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632953423;
        bh=UvBjxPzS07Qrf4c5Pcqrz0bUHMnyIHlWfTp4fbm48mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8Sqad0kjewSkb48blxY+AaaJgdsWNPFOZmj2km2iMiTh3esLjpF1NCRq5yu5LaUo
         pYdvsmzNe5w6GMOfK6Gih25ALWNUyeUTWX/bQWR5wBvnDDqzGr1WjiapXkzEQbKJNp
         nWL+Sc6xBOHxmnNdjFMQcU94XqqgNK4o6wLmItq+XtVh2gm6VuH3aZKaVOpu7XL2kh
         I8wddhD9pJ29C+34jkW1Gg/pTjJ78YwjMAmJntSAs+i/0k/8LzybRTVhyd8OfrM/zY
         mgJSuFsa+ZJ1nLx9TFMqoczjtTRE9AiWjrmG3U0dg1Jp4eAmE/wUZVcmfUO8e/LgyK
         6zhwXZCjIFIkw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 02/11] rcu/nocb: Prepare state machine for a new step
Date:   Thu, 30 Sep 2021 00:10:03 +0200
Message-Id: <20210929221012.228270-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929221012.228270-1-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently SEGCBLIST_SOFTIRQ_ONLY is a bit of an exception among the
segcblist flags because it is an exclusive state that doesn't mix up
with the other flags. Remove it in favour of:

_ A flag specifying that rcu_core() needs to perform callbacks execution
  and acceleration

and

_ A flag specifying we want the nocb lock to be held in any needed
  circumstances

This clarifies the code and is more flexible: It allows to have a state
where rcu_core() runs with locking while offloading hasn't started yet.
This is a necessary step to prepare for triggering rcu_core() at the
very beginning of the de-offloading process so that rcu_core() won't
dismiss work while being preempted by the de-offloading process, at
least not without a pending subsequent rcu_core() that will quickly
catch up.

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
---
 include/linux/rcu_segcblist.h | 37 ++++++++++++++++++++++-------------
 kernel/rcu/rcu_segcblist.c    |  6 +++---
 kernel/rcu/rcu_segcblist.h    |  7 +++----
 kernel/rcu/tree.c             |  2 +-
 kernel/rcu/tree_nocb.h        | 20 +++++++++++++------
 5 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 3db96c4f45fd..812961b1d064 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -69,7 +69,7 @@ struct rcu_cblist {
  *
  *
  *  ----------------------------------------------------------------------------
- *  |                         SEGCBLIST_SOFTIRQ_ONLY                           |
+ *  |                              SEGCBLIST_RCU_CORE                          |
  *  |                                                                          |
  *  |  Callbacks processed by rcu_core() from softirqs or local                |
  *  |  rcuc kthread, without holding nocb_lock.                                |
@@ -77,7 +77,7 @@ struct rcu_cblist {
  *                                         |
  *                                         v
  *  ----------------------------------------------------------------------------
- *  |                        SEGCBLIST_OFFLOADED                               |
+ *  |       SEGCBLIST_RCU_CORE | SEGCBLIST_LOCKING | SEGCBLIST_OFFLOADED       |
  *  |                                                                          |
  *  | Callbacks processed by rcu_core() from softirqs or local                 |
  *  | rcuc kthread, while holding nocb_lock. Waking up CB and GP kthreads,     |
@@ -89,7 +89,9 @@ struct rcu_cblist {
  *                        |                                 |
  *                        v                                 v
  *  ---------------------------------------  ----------------------------------|
- *  |        SEGCBLIST_OFFLOADED |        |  |     SEGCBLIST_OFFLOADED |       |
+ *  |        SEGCBLIST_RCU_CORE   |       |  |     SEGCBLIST_RCU_CORE   |      |
+ *  |        SEGCBLIST_LOCKING    |       |  |     SEGCBLIST_LOCKING    |      |
+ *  |        SEGCBLIST_OFFLOADED  |       |  |     SEGCBLIST_OFFLOADED  |      |
  *  |        SEGCBLIST_KTHREAD_CB         |  |     SEGCBLIST_KTHREAD_GP        |
  *  |                                     |  |                                 |
  *  |                                     |  |                                 |
@@ -104,9 +106,10 @@ struct rcu_cblist {
  *                                         |
  *                                         v
  *  |--------------------------------------------------------------------------|
- *  |                           SEGCBLIST_OFFLOADED |                          |
- *  |                           SEGCBLIST_KTHREAD_CB |                         |
- *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                           SEGCBLIST_LOCKING    |                         |
+ *  |                           SEGCBLIST_OFFLOADED  |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP |                         |
+ *  |                           SEGCBLIST_KTHREAD_CB                           |
  *  |                                                                          |
  *  |   Kthreads handle callbacks holding nocb_lock, local rcu_core() stops    |
  *  |   handling callbacks. Enable bypass queueing.                            |
@@ -120,7 +123,8 @@ struct rcu_cblist {
  *
  *
  *  |--------------------------------------------------------------------------|
- *  |                           SEGCBLIST_OFFLOADED |                          |
+ *  |                           SEGCBLIST_LOCKING    |                         |
+ *  |                           SEGCBLIST_OFFLOADED  |                         |
  *  |                           SEGCBLIST_KTHREAD_CB |                         |
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
@@ -130,6 +134,8 @@ struct rcu_cblist {
  *                                      |
  *                                      v
  *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_RCU_CORE   |                         |
+ *  |                           SEGCBLIST_LOCKING    |                         |
  *  |                           SEGCBLIST_KTHREAD_CB |                         |
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
@@ -143,7 +149,9 @@ struct rcu_cblist {
  *                     |                                 |
  *                     v                                 v
  *  ---------------------------------------------------------------------------|
- *  |                                                                          |
+ *  |                                     |                                    |
+ *  |        SEGCBLIST_RCU_CORE |         |       SEGCBLIST_RCU_CORE |         |
+ *  |        SEGCBLIST_LOCKING  |         |       SEGCBLIST_LOCKING  |         |
  *  |        SEGCBLIST_KTHREAD_CB         |       SEGCBLIST_KTHREAD_GP         |
  *  |                                     |                                    |
  *  | GP kthread woke up and              |   CB kthread woke up and           |
@@ -159,7 +167,7 @@ struct rcu_cblist {
  *                                      |
  *                                      v
  *  ----------------------------------------------------------------------------
- *  |                                   0                                      |
+ *  |                SEGCBLIST_RCU_CORE | SEGCBLIST_LOCKING                    |
  *  |                                                                          |
  *  | Callbacks processed by rcu_core() from softirqs or local                 |
  *  | rcuc kthread, while holding nocb_lock. Forbid nocb_timer to be armed.    |
@@ -168,17 +176,18 @@ struct rcu_cblist {
  *                                      |
  *                                      v
  *  ----------------------------------------------------------------------------
- *  |                         SEGCBLIST_SOFTIRQ_ONLY                           |
+ *  |                         SEGCBLIST_RCU_CORE                               |
  *  |                                                                          |
  *  |  Callbacks processed by rcu_core() from softirqs or local                |
  *  |  rcuc kthread, without holding nocb_lock.                                |
  *  ----------------------------------------------------------------------------
  */
 #define SEGCBLIST_ENABLED	BIT(0)
-#define SEGCBLIST_SOFTIRQ_ONLY	BIT(1)
-#define SEGCBLIST_KTHREAD_CB	BIT(2)
-#define SEGCBLIST_KTHREAD_GP	BIT(3)
-#define SEGCBLIST_OFFLOADED	BIT(4)
+#define SEGCBLIST_RCU_CORE	BIT(1)
+#define SEGCBLIST_LOCKING	BIT(2)
+#define SEGCBLIST_KTHREAD_CB	BIT(3)
+#define SEGCBLIST_KTHREAD_GP	BIT(4)
+#define SEGCBLIST_OFFLOADED	BIT(5)
 
 struct rcu_segcblist {
 	struct rcu_head *head;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index aaa111237b60..c07aab6e39ef 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -261,14 +261,14 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 }
 
 /*
- * Mark the specified rcu_segcblist structure as offloaded.
+ * Mark the specified rcu_segcblist structure as offloaded (or not)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
 {
 	if (offload) {
-		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
-		rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
+		rcu_segcblist_set_flags(rsclp, SEGCBLIST_LOCKING | SEGCBLIST_OFFLOADED);
 	} else {
+		rcu_segcblist_set_flags(rsclp, SEGCBLIST_RCU_CORE);
 		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_OFFLOADED);
 	}
 }
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 9a19328ff251..0fc9048c4936 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -84,7 +84,7 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
 	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-	    !rcu_segcblist_test_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY))
+	    rcu_segcblist_test_flags(rsclp, SEGCBLIST_LOCKING))
 		return true;
 
 	return false;
@@ -92,9 +92,8 @@ static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 
 static inline bool rcu_segcblist_completely_offloaded(struct rcu_segcblist *rsclp)
 {
-	int flags = SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP | SEGCBLIST_OFFLOADED;
-
-	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) && (rsclp->flags & flags) == flags)
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+	    !rcu_segcblist_test_flags(rsclp, SEGCBLIST_RCU_CORE))
 		return true;
 
 	return false;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 572f644f3240..ef417769bab2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -79,7 +79,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(1),
 #ifdef CONFIG_RCU_NOCB_CPU
-	.cblist.flags = SEGCBLIST_SOFTIRQ_ONLY,
+	.cblist.flags = SEGCBLIST_RCU_CORE,
 #endif
 };
 static struct rcu_state rcu_state = {
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 368ef7b9af4f..71a28f50b40f 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1000,12 +1000,12 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
 	/*
-	 * Theoretically we could set SEGCBLIST_SOFTIRQ_ONLY after the nocb
+	 * Theoretically we could clear SEGCBLIST_LOCKING after the nocb
 	 * lock is released but how about being paranoid for once?
 	 */
-	rcu_segcblist_set_flags(cblist, SEGCBLIST_SOFTIRQ_ONLY);
+	rcu_segcblist_clear_flags(cblist, SEGCBLIST_LOCKING);
 	/*
-	 * With SEGCBLIST_SOFTIRQ_ONLY, we can't use
+	 * Without SEGCBLIST_LOCKING, we can't use
 	 * rcu_nocb_unlock_irqrestore() anymore.
 	 */
 	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
@@ -1058,14 +1058,14 @@ static long rcu_nocb_rdp_offload(void *arg)
 
 	pr_info("Offloading %d\n", rdp->cpu);
 	/*
-	 * Can't use rcu_nocb_lock_irqsave() while we are in
-	 * SEGCBLIST_SOFTIRQ_ONLY mode.
+	 * Can't use rcu_nocb_lock_irqsave() before SEGCBLIST_LOCKING
+	 * is set.
 	 */
 	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 
 	/*
 	 * We didn't take the nocb lock while working on the
-	 * rdp->cblist in SEGCBLIST_SOFTIRQ_ONLY mode.
+	 * rdp->cblist with SEGCBLIST_LOCKING cleared (pure softirq/rcuc mode).
 	 * Every modifications that have been done previously on
 	 * rdp->cblist must be visible remotely by the nocb kthreads
 	 * upon wake up after reading the cblist flags.
@@ -1084,6 +1084,14 @@ static long rcu_nocb_rdp_offload(void *arg)
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
 
+	/*
+	 * All kthreads are ready to work, we can finally relieve rcu_core() and
+	 * enable nocb bypass.
+	 */
+	rcu_nocb_lock_irqsave(rdp, flags);
+	rcu_segcblist_clear_flags(cblist, SEGCBLIST_RCU_CORE);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+
 	return ret;
 }
 
-- 
2.25.1

