Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3B34AC2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCZQCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:02:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55866 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhCZQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:40 -0400
Message-Id: <20210326153943.863379182@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=15cB/+ue2fn4WzCW6t9oUrB2XaSIP6rxgX5lGvaAGcg=;
        b=jody/Cr/6FlOeApb3hFrRrfRMgVoEMYSbarwfYi49DndHX8tPVXQLHO20vZ7IQvRc478V1
        3YZrJBZ41ROc6+2X4M+iJ+Ae7uL6nnBsEAFiZao1uf28TbJD3MfxjND5F3i/w+gkdHwkO+
        lmOZEGIfRV3Qx7exz2E+ECn+Zdbq6OMKGGtvVhCuuMrSz/HSDrJtKEcDalelKwxUoiPjum
        nVSarWEBzMmjI+YfX0MXJTo+gq0CMzQgzFDaH/pj5/9SXwtoCqf1C7YAE1wWY6gJKgDpIq
        BCIWrCvwQKCGSaYL08deZSYQKLTokXG37ZkAz4g7r5xFuai7pbFO/bM04lo2RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=15cB/+ue2fn4WzCW6t9oUrB2XaSIP6rxgX5lGvaAGcg=;
        b=Fjafy1pAWqtDxUcb8YpQTq48tXQYMYM0hOoONcmVyN8DRuRw8vzfJS1EhkULDFzKmu4DIO
        H71BjPwOYC9k4tBA==
Date:   Fri, 26 Mar 2021 16:29:37 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 08/15] locking/rtmutex: Remove pointless CONFIG_RT_MUTEXES=n stubs
References: <20210326152929.709289883@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of these functions is used when CONFIG_RT_MUTEXES=n.

Remove the gunk. Remove pointless comments and clean up the coding style
mess while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Bring back the #ifdef and provide a proper stub for rt_mutex_owner()
    which is used unconditionally in RCU
---
 kernel/locking/rtmutex_common.h |   62 ++++++++++++----------------------------
 1 file changed, 20 insertions(+), 42 deletions(-)

--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -23,29 +23,30 @@
  * @tree_entry:		pi node to enqueue into the mutex waiters tree
  * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
+ * @lock:		Pointer to the rt_mutex on which the waiter blocks
+ * @prio:		Priority of the waiter
+ * @deadline:		Deadline of the waiter if applicable
  */
 struct rt_mutex_waiter {
-	struct rb_node          tree_entry;
-	struct rb_node          pi_tree_entry;
+	struct rb_node		tree_entry;
+	struct rb_node		pi_tree_entry;
 	struct task_struct	*task;
 	struct rt_mutex		*lock;
-	int prio;
-	u64 deadline;
+	int			prio;
+	u64			deadline;
 };
 
 /*
- * Various helpers to access the waiters-tree:
+ * Must be guarded because this header is included from rcu/tree_plugin.h
+ * unconditionally.
  */
-
 #ifdef CONFIG_RT_MUTEXES
-
 static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
 {
 	return !RB_EMPTY_ROOT(&lock->waiters.rb_root);
 }
 
-static inline struct rt_mutex_waiter *
-rt_mutex_top_waiter(struct rt_mutex *lock)
+static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex *lock)
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 	struct rt_mutex_waiter *w = NULL;
@@ -62,42 +63,12 @@ static inline int task_has_pi_waiters(st
 	return !RB_EMPTY_ROOT(&p->pi_waiters.rb_root);
 }
 
-static inline struct rt_mutex_waiter *
-task_top_pi_waiter(struct task_struct *p)
-{
-	return rb_entry(p->pi_waiters.rb_leftmost,
-			struct rt_mutex_waiter, pi_tree_entry);
-}
-
-#else
-
-static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
-{
-	return false;
-}
-
-static inline struct rt_mutex_waiter *
-rt_mutex_top_waiter(struct rt_mutex *lock)
-{
-	return NULL;
-}
-
-static inline int task_has_pi_waiters(struct task_struct *p)
+static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 {
-	return false;
+	return rb_entry(p->pi_waiters.rb_leftmost, struct rt_mutex_waiter,
+			pi_tree_entry);
 }
 
-static inline struct rt_mutex_waiter *
-task_top_pi_waiter(struct task_struct *p)
-{
-	return NULL;
-}
-
-#endif
-
-/*
- * lock->owner state tracking:
- */
 #define RT_MUTEX_HAS_WAITERS	1UL
 
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
@@ -106,6 +77,13 @@ static inline struct task_struct *rt_mut
 
 	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
 }
+#else /* CONFIG_RT_MUTEXES */
+/* Used in rcu/tree_plugin.h */
+static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
+{
+	return NULL;
+}
+#endif  /* !CONFIG_RT_MUTEXES */
 
 /*
  * Constants for rt mutex functions which have a selectable deadlock

