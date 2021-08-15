Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9799D3ECB20
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhHOV3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:29:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47766 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhHOV2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:16 -0400
Message-ID: <20210815211302.200898048@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3IhxnMI2OIRewYxeWiR9+ECOACRr6AXapsWArm6PkW8=;
        b=RMzgVdlG0xhk/4E+a83b2S9aPMFR5hSw1HdY7n6AacCglJbC1wABWStlnqGmDhcG3drAQY
        aCigHn6+XUsTdmYGSQvd6Ty+qhQ4OIvQp4S13y0imSsu4XR9/gx36FSmyAivSzI7zvmbaM
        /02k6rjYe4YjB2GTEKnE65GUxpn5qm0UHA+2YK+xMPZl/kZVez5i+9U7UBixlmS7Hyu+2q
        F5tKyIDt2C8ywzIALoNEr+P0fJ93pE5VFiF+bWJjfPdIhOiZSIX9TmjJCxZu0mo0MxCQEb
        GnQ+ttE8fA0bPmNIFvj0WkxmBfsWji6FQNxa8lfQuHhSNaBSYgkvtl6BFHYAGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3IhxnMI2OIRewYxeWiR9+ECOACRr6AXapsWArm6PkW8=;
        b=53zH+ydvYKx4jkhNchcQwYlgtt11957lixAlWieRvPwID91VpRD4WUV+nVHF4Kw5yKVxCk
        MzcwhRrAcfSlOjAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V5 05/72] sched: Reorganize current::__state helpers
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:27:43 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid more duplicate implementations for the debug and
non-debug variants of the state change macros, split the debug portion out
and make that conditional on CONFIG_DEBUG_ATOMIC_SLEEP.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch.
---
 include/linux/sched.h |   48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -123,8 +123,6 @@ struct task_group;
 
 #define task_is_stopped_or_traced(task)	((READ_ONCE(task->__state) & (__TASK_STOPPED | __TASK_TRACED)) != 0)
 
-#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-
 /*
  * Special states are those that do not use the normal wait-loop pattern. See
  * the comment with set_special_state().
@@ -132,30 +130,24 @@ struct task_group;
 #define is_special_task_state(state)				\
 	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
 
-#define __set_current_state(state_value)			\
-	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
-		current->task_state_change = _THIS_IP_;		\
-		WRITE_ONCE(current->__state, (state_value));	\
-	} while (0)
-
-#define set_current_state(state_value)				\
-	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
-		current->task_state_change = _THIS_IP_;		\
-		smp_store_mb(current->__state, (state_value));	\
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+# define debug_normal_state_change(state_value)				\
+	do {								\
+		WARN_ON_ONCE(is_special_task_state(state_value));	\
+		current->task_state_change = _THIS_IP_;			\
 	} while (0)
 
-#define set_special_state(state_value)					\
+# define debug_special_state_change(state_value)			\
 	do {								\
-		unsigned long flags; /* may shadow */			\
 		WARN_ON_ONCE(!is_special_task_state(state_value));	\
-		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		current->task_state_change = _THIS_IP_;			\
-		WRITE_ONCE(current->__state, (state_value));		\
-		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
+
 #else
+# define debug_normal_state_change(cond)	do { } while (0)
+# define debug_special_state_change(cond)	do { } while (0)
+#endif
+
 /*
  * set_current_state() includes a barrier so that the write of current->state
  * is correctly serialised wrt the caller's subsequent test of whether to
@@ -194,27 +186,33 @@ struct task_group;
  * Also see the comments of try_to_wake_up().
  */
 #define __set_current_state(state_value)				\
-	WRITE_ONCE(current->__state, (state_value))
+	do {								\
+		debug_normal_state_change((state_value));		\
+		WRITE_ONCE(current->__state, (state_value));		\
+	} while (0)
 
 #define set_current_state(state_value)					\
-	smp_store_mb(current->__state, (state_value))
+	do {								\
+		debug_normal_state_change((state_value));		\
+		smp_store_mb(current->__state, (state_value));		\
+	} while (0)
 
 /*
  * set_special_state() should be used for those states when the blocking task
  * can not use the regular condition based wait-loop. In that case we must
- * serialize against wakeups such that any possible in-flight TASK_RUNNING stores
- * will not collide with our state change.
+ * serialize against wakeups such that any possible in-flight TASK_RUNNING
+ * stores will not collide with our state change.
  */
 #define set_special_state(state_value)					\
 	do {								\
 		unsigned long flags; /* may shadow */			\
+									\
 		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
+		debug_special_state_change((state_value));		\
 		WRITE_ONCE(current->__state, (state_value));		\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
 
-#endif
-
 #define get_current_state()	READ_ONCE(current->__state)
 
 /* Task command name length: */

