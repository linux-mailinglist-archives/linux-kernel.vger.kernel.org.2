Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB033C741E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhGMQRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhGMQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4944FC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:56 -0700 (PDT)
Message-Id: <20210713160749.648533960@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8kUuP5QxNsLawC3LgEmLTEjvm20HRPkWnqj7deXILF0=;
        b=GBXcIIYfaU56mvR2G3C3YVdhB5unCtMBJ3lMtrH47vLZSfeAM6ZWExW8oB5VBtoxkcpknI
        b0WLneLPcjmUEjvClQtFwvFYiyEF1JMu8yLfe6ik+twvZzzmPfUqSY1WTRV79DQnKm25lF
        1p7BhRlKabuFHt7Ot3DmoU5kZZh3P92ECruQ2M/0H3P51Jj3RflbvHBEHKAnSc89G4G309
        xitv5/N6SjDZR+9FDA2ED8YB3yV7NpiSBO86fjrQPDrSZSBADSxbdKPYOwpA6f1j6Ig6hm
        EWRWhUqBBCQK2o1sxn9o3UN9ltHqRhxhsXD3udZbJjafpG6Uqp9S4iZ2Smu4LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8kUuP5QxNsLawC3LgEmLTEjvm20HRPkWnqj7deXILF0=;
        b=ku0dY38bg2FMR/jBVA/fIg2ePLv4bDbhGrp4Tls1Bo9huujlQBSl737Lm8YF3MOO+c2ZB+
        e5+f7skI1ogvmkDA==
Date:   Tue, 13 Jul 2021 17:11:32 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 38/50] locking/mutex: Exclude non-ww_mutex API for RT
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

In order to build ww_mutex standalone on RT and to replace mutex with a RT
specific rtmutex based variant, guard the non-ww_mutex API so it is only
built when CONFIG_PREEMPT_RT is disabled.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/mutex.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)
---
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -242,7 +242,7 @@ static void __mutex_handoff(_mutex_t *lo
 	}
 }
 
-#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#if !defined(CONFIG_DEBUG_LOCK_ALLOC) && !defined(CONFIG_PREEMPT_RT)
 /*
  * We split the mutex lock/unlock logic into separate fastpath and
  * slowpath functions, to reduce the register pressure on the fastpath.
@@ -280,7 +280,7 @@ void __sched mutex_lock(struct mutex *lo
 		__mutex_lock_slowpath(lock);
 }
 EXPORT_SYMBOL(mutex_lock);
-#endif
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC && !CONFIG_PREEMPT_RT */
 
 /*
  * Wait-Die:
@@ -705,17 +705,27 @@ mutex_optimistic_spin(_mutex_t *lock, st
 
 	return false;
 }
-#else
+#else /* CONFIG_MUTEX_SPIN_ON_OWNER */
 static __always_inline bool
 mutex_optimistic_spin(_mutex_t *lock, struct ww_acquire_ctx *ww_ctx,
 		      struct mutex_waiter *waiter)
 {
 	return false;
 }
-#endif
+#endif /* !CONFIG_MUTEX_SPIN_ON_OWNER */
 
 static noinline void __sched __mutex_unlock_slowpath(_mutex_t *lock, unsigned long ip);
 
+static __always_inline void __mutex_unlock(_mutex_t *lock)
+{
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
+	if (__mutex_unlock_fast(lock))
+		return;
+#endif
+	__mutex_unlock_slowpath(lock, _RET_IP_);
+}
+
+#ifndef CONFIG_PREEMPT_RT
 /**
  * mutex_unlock - release the mutex
  * @lock: the mutex to be released
@@ -729,13 +739,10 @@ static noinline void __sched __mutex_unl
  */
 void __sched mutex_unlock(struct mutex *lock)
 {
-#ifndef CONFIG_DEBUG_LOCK_ALLOC
-	if (__mutex_unlock_fast(lock))
-		return;
-#endif
-	__mutex_unlock_slowpath(lock, _RET_IP_);
+	__mutex_unlock(lock);
 }
 EXPORT_SYMBOL(mutex_unlock);
+#endif /* !CONFIG_PREEMPT_RT */
 
 /**
  * ww_mutex_unlock - release the w/w mutex
@@ -763,7 +770,7 @@ void __sched ww_mutex_unlock(struct ww_m
 		lock->ctx = NULL;
 	}
 
-	mutex_unlock(&lock->base);
+	__mutex_unlock(&lock->base);
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
 
@@ -1093,12 +1100,14 @@ static __always_inline int __sched
 	return ret;
 }
 
+#ifndef CONFIG_PREEMPT_RT
 static int __sched
 __mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 	     struct lockdep_map *nest_lock, unsigned long ip)
 {
 	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
 }
+#endif /* !CONFIG_PREEMPT_RT */
 
 static int __sched
 __ww_mutex_lock(_mutex_t *lock, unsigned int state, unsigned int subclass,
@@ -1109,6 +1118,7 @@ static int __sched
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
+# ifndef CONFIG_PREEMPT_RT
 void __sched
 mutex_lock_nested(struct mutex *lock, unsigned int subclass)
 {
@@ -1151,6 +1161,7 @@ mutex_lock_io_nested(struct mutex *lock,
 	io_schedule_finish(token);
 }
 EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
+# endif /* !CONFIG_PREEMPT_RT */
 
 static inline int
 ww_mutex_deadlock_injection(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
@@ -1278,6 +1289,7 @@ static noinline void __sched __mutex_unl
 }
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
+#ifndef CONFIG_PREEMPT_RT
 /*
  * Here come the less common (and hence less performance-critical) APIs:
  * mutex_lock_interruptible() and mutex_trylock().
@@ -1372,6 +1384,7 @@ static noinline int __sched
 {
 	return __mutex_lock(lock, TASK_INTERRUPTIBLE, 0, NULL, _RET_IP_);
 }
+#endif /* !CONFIG_PREEMPT_RT */
 
 static noinline int __sched
 __ww_mutex_lock_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)

