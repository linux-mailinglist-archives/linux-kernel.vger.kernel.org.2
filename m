Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF93346B46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhCWVld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:41:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhCWVjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:51 -0400
Message-Id: <20210323213708.305191020@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WQ79W0UKQ3FaQqUk75fa8vxbtUiLoQOfE/l0ic+As9Y=;
        b=0dwiNOtvsHICNKbN4FI/g8BuGzIsiMoFI0tjDiIMsE5xjeHZ15I/MzIBwWvD0d1i0fuXEK
        w8u9Cn/rFO7ro+ZlyOHT830q1Qa+gdCHvEcthePOA/Vgoq34EMzUk5XudODwHTIxYmRk4e
        JndbzldEtV+oruFstumU3tjTR8nMvks7uSWVnpa+OMl4JJGhpspO++yNkLiVwkM2srQ4lD
        AWHHvlyzdepLt640jN61aOe4IK2AbyWUhDlQqPYntOBAnewzaw1Id3BFsJE9B3fcQsGCGK
        dk4JDDrDTv3R3El5aq4VpcFaC+MSmZcY4FglWuemmbTJGRdpTo+XMNEN9+2qXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WQ79W0UKQ3FaQqUk75fa8vxbtUiLoQOfE/l0ic+As9Y=;
        b=nwWcJYRQRF+7MxEGrE05poWn6aMKu7zZvnCHFiPWt2Z1UPbbtW4LnPt4hFMfYuMxwhmCy+
        X2jeRLHlo0dPVqCA==
Date:   Tue, 23 Mar 2021 22:30:27 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 08/14] locking/rtmutex: Remove pointless CONFIG_RT_MUTEXES=n stubs
References: <20210323213019.217008708@linutronix.de>
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
 kernel/locking/rtmutex_common.h |   56 +++++++---------------------------------
 1 file changed, 11 insertions(+), 45 deletions(-)

--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -23,29 +23,25 @@
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
 
-/*
- * Various helpers to access the waiters-tree:
- */
-
-#ifdef CONFIG_RT_MUTEXES
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
@@ -62,42 +58,12 @@ static inline int task_has_pi_waiters(st
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
-{
-	return false;
-}
-
-static inline struct rt_mutex_waiter *
-task_top_pi_waiter(struct task_struct *p)
+static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 {
-	return NULL;
+	return rb_entry(p->pi_waiters.rb_leftmost, struct rt_mutex_waiter,
+			pi_tree_entry);
 }
 
-#endif
-
-/*
- * lock->owner state tracking:
- */
 #define RT_MUTEX_HAS_WAITERS	1UL
 
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)

