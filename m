Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C215C3E1850
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbhHEPmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbhHEPl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A26C06179A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:41:09 -0700 (PDT)
Message-ID: <20210805153952.975036149@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3IhxnMI2OIRewYxeWiR9+ECOACRr6AXapsWArm6PkW8=;
        b=1IBg0IA32RcObnl/T8iu3pMCDzR9J6E3pKdBi1EMYU+i9kkCLPMKQcY2jPw3fwKndxydRZ
        v+WieoS9wHVU+YR5fNz6WCcM3GKohcCTmFscwICGblfiF4F1VeJ4xqxa6vhiJ7hNJ708MA
        W9KM9OWSVV4topYfd+QglUxngOse5+kXj+dojt5hyagv7RCPdbNBSM4gq0QcgNbYMi8ouR
        5U++69zZPzOXGHAO0GL8XNNDfBoF+xajqgxGHASdEqo+dXNyfQ86FS6Tz1Ub/vsNe2otl8
        159vUsZAefaa3BUa/IksMyBeCh4mmRe9sfB7QqFuzNkqAIgTft1C1zkpoxl6Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3IhxnMI2OIRewYxeWiR9+ECOACRr6AXapsWArm6PkW8=;
        b=nfmg70F2jnRx4OkuXGBKfJWPU+9L9sHyTMzS49Pbi544yghxX7dbn47zBAKjl9EpQXIi3f
        RJKCVAN69TJmcfDA==
Date:   Thu, 05 Aug 2021 17:13:03 +0200
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
Subject: [patch V3 03/64] sched: Reorganize current::__state helpers
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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

