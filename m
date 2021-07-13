Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5985A3C7419
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhGMQRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54590 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbhGMQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:41 -0400
Message-Id: <20210713160749.253603468@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mPfSYxBnhDkMrp2qar2MWJi4SONwJJ2SPV3HrpY1Hbg=;
        b=jUbADS1/6TSWg1cZ9q4HuYCEkdPR9O/owG4lENZDgGg3uqZRnQ8PRRB8rSLGClGZTZv4n/
        n0+N86ieer/3njnqxnlRBQ1WZ2MvZf5gqrDpxOUp1M+itwwiXjo2DwjPPUrTEAk3RdBpOV
        nhc6DjrN+ihq3gdSTDljhAwOYDomiAFcGH5FgOoKOGd9O+EpdbzSX19EIfo6SVyAyiHOC3
        0XlJTISPqu6IzktOAAyvVX0J2T2fPwJ08orNOZIYxyvcDR1w89Au0trXo/JqL8+SydVQ/G
        QfHG85G78RdLRPW+K1zdSfWrvGkGxvSV41yf00bGEF8Pxk2kWLcM74crdeNZnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mPfSYxBnhDkMrp2qar2MWJi4SONwJJ2SPV3HrpY1Hbg=;
        b=EuV+BOPNtVOJNN1jjrgWj3ggfWR+rwNr+CWIzr1A632zCXasP6BZ0sJr93fhi1fXhp/IhK
        /Y4RHiLrsxthjUDg==
Date:   Tue, 13 Jul 2021 17:11:28 +0200
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
Subject: [patch 34/50] locking/mutex: Rename the ww_mutex relevant functions
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

In order to build ww_mutex standalone for PREEMPT_RT and to allow replacing
the regular mutex with an RT specific rtmutex based variant, rename a few
ww_mutex relevant functions, so the final RT build does not have namespace
collisions.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mutex.h        | 60 ++++++++++++++++++++++++++++++---------------
 include/linux/ww_mutex.h     |  2 +-
 kernel/locking/mutex-debug.c |  9 +++----
 kernel/locking/mutex.c       | 26 ++++----------------
 4 files changed, 52 insertions(+), 45 deletions(-)
---
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 87dafe179ed2..9183e3f7911d 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -69,19 +69,19 @@ typedef struct mutex {
 #endif
 } _mutex_t;
 
-#ifdef CONFIG_DEBUG_MUTEXES
+extern void __mutex_t_init(_mutex_t *lock, const char *name,
+			   struct lock_class_key *key);
+extern int _mutex_t_trylock(_mutex_t *lock);
+extern bool _mutex_t_is_locked(_mutex_t *lock);
 
-#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
+#ifdef CONFIG_DEBUG_MUTEXES
+# define __DEBUG_MUTEX_INITIALIZER(lockname)	\
 	, .magic = &lockname
 
-extern void mutex_destroy(struct mutex *lock);
-
+extern void _mutex_t_destroy(_mutex_t *lock);
 #else
-
 # define __DEBUG_MUTEX_INITIALIZER(lockname)
-
-static inline void mutex_destroy(struct mutex *lock) {}
-
+static inline void _mutex_t_destroy(_mutex_t *lock) {}
 #endif
 
 /**
@@ -96,7 +96,12 @@ static inline void mutex_destroy(struct mutex *lock) {}
 do {									\
 	static struct lock_class_key __key;				\
 									\
-	__mutex_init((mutex), #mutex, &__key);				\
+	__mutex_t_init((mutex), #mutex, &__key);			\
+} while (0)
+
+#define __mutex_init(mutex, name, key)					\
+do {									\
+	__mutex_t_init((mutex), name, key);				\
 } while (0)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -119,8 +124,10 @@ do {									\
 #define DEFINE_MUTEX(mutexname) \
 	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
 
-extern void __mutex_init(struct mutex *lock, const char *name,
-			 struct lock_class_key *key);
+static __always_inline void mutex_destroy(struct mutex *lock)
+{
+	_mutex_t_destroy(lock);
+}
 
 /**
  * mutex_is_locked - is the mutex locked
@@ -128,7 +135,29 @@ extern void __mutex_init(struct mutex *lock, const char *name,
  *
  * Returns true if the mutex is locked, false if unlocked.
  */
-extern bool mutex_is_locked(struct mutex *lock);
+static __always_inline bool mutex_is_locked(struct mutex *lock)
+{
+	return _mutex_t_is_locked(lock);
+}
+
+/**
+ * mutex_trylock - try to acquire the mutex, without waiting
+ * @lock: the mutex to be acquired
+ *
+ * Try to acquire the mutex atomically. Returns 1 if the mutex
+ * has been acquired successfully, and 0 on contention.
+ *
+ * NOTE: this function follows the spin_trylock() convention, so
+ * it is negated from the down_trylock() return values! Be careful
+ * about this when converting semaphore users to mutexes.
+ *
+ * This function must not be used in interrupt context. The
+ * mutex must be released by the same task that acquired it.
+ */
+static __always_inline int mutex_trylock(struct mutex *lock)
+{
+	return _mutex_t_trylock(lock);
+}
 
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
@@ -168,13 +197,6 @@ extern void mutex_lock_io(struct mutex *lock);
 # define mutex_lock_io_nested(lock, subclass) mutex_lock_io(lock)
 #endif
 
-/*
- * NOTE: mutex_trylock() follows the spin_trylock() convention,
- *       not the down_trylock() convention!
- *
- * Returns 1 if the mutex has been acquired successfully, and 0 on contention.
- */
-extern int mutex_trylock(struct mutex *lock);
 extern void mutex_unlock(struct mutex *lock);
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 590aaa207757..455542a42123 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -82,7 +82,7 @@ struct ww_acquire_ctx {
 static inline void ww_mutex_init(struct ww_mutex *lock,
 				 struct ww_class *ww_class)
 {
-	__mutex_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
+	__mutex_t_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx = NULL;
 #ifdef CONFIG_DEBUG_MUTEXES
 	lock->ww_class = ww_class;
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 7ef5a36857e8..aef7cc76ed62 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -89,17 +89,16 @@ void debug_mutex_init(struct mutex *lock, const char *name,
 }
 
 /***
- * mutex_destroy - mark a mutex unusable
+ * _mutex_t_destroy - mark a mutex unusable
  * @lock: the mutex to be destroyed
  *
  * This function marks the mutex uninitialized, and any subsequent
  * use of the mutex is forbidden. The mutex must not be locked when
  * this function is called.
  */
-void mutex_destroy(struct mutex *lock)
+void _mutex_t_destroy(_mutex_t *lock)
 {
-	DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock));
+	DEBUG_LOCKS_WARN_ON(_mutex_t_is_locked(lock));
 	lock->magic = NULL;
 }
-
-EXPORT_SYMBOL_GPL(mutex_destroy);
+EXPORT_SYMBOL_GPL(_mutex_t_destroy);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 16360787aa47..01f59b544042 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -33,7 +33,7 @@
 #include "mutex.h"
 
 void
-__mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
+__mutex_t_init(_mutex_t *lock, const char *name, struct lock_class_key *key)
 {
 	atomic_long_set(&lock->owner, 0);
 	raw_spin_lock_init(&lock->wait_lock);
@@ -44,7 +44,7 @@ __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 
 	debug_mutex_init(lock, name, key);
 }
-EXPORT_SYMBOL(__mutex_init);
+EXPORT_SYMBOL(__mutex_t_init);
 
 /*
  * @owner: contains: 'struct task_struct *' to the current lock owner,
@@ -76,11 +76,11 @@ static inline struct task_struct *__owner_task(unsigned long owner)
 	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
 }
 
-bool mutex_is_locked(struct mutex *lock)
+bool _mutex_t_is_locked(_mutex_t *lock)
 {
 	return __mutex_owner(lock) != NULL;
 }
-EXPORT_SYMBOL(mutex_is_locked);
+EXPORT_SYMBOL(_mutex_t_is_locked);
 
 static inline unsigned long __owner_flags(unsigned long owner)
 {
@@ -1390,21 +1390,7 @@ __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
 
 #endif
 
-/**
- * mutex_trylock - try to acquire the mutex, without waiting
- * @lock: the mutex to be acquired
- *
- * Try to acquire the mutex atomically. Returns 1 if the mutex
- * has been acquired successfully, and 0 on contention.
- *
- * NOTE: this function follows the spin_trylock() convention, so
- * it is negated from the down_trylock() return values! Be careful
- * about this when converting semaphore users to mutexes.
- *
- * This function must not be used in interrupt context. The
- * mutex must be released by the same task that acquired it.
- */
-int __sched mutex_trylock(struct mutex *lock)
+int __sched _mutex_t_trylock(_mutex_t *lock)
 {
 	bool locked;
 
@@ -1418,7 +1404,7 @@ int __sched mutex_trylock(struct mutex *lock)
 
 	return locked;
 }
-EXPORT_SYMBOL(mutex_trylock);
+EXPORT_SYMBOL(_mutex_t_trylock);
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 int __sched

