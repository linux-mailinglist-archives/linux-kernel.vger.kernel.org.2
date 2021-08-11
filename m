Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932C53E90F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbhHKM1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbhHKMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:25:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E60C0619C7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:23:30 -0700 (PDT)
Message-ID: <20210811121416.948066221@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lzQ6SJUWO+cQIKpc/IWE3nb8cj8Ps+LzIGeiMNlvMc8=;
        b=fVR98hPsYEGt2QmXWCrBovrPeycl2v8yNFd/bXpFCeBq3BrFzCWrEim01A7o2KA8BJ/XV5
        QBuYRUy7XUXVGeQO/MmZ1Pe1ntdFVwaX7B163v2/ZLS7HH+mqdiZVb1fsdBP6Z+DEwXJ4X
        Fa+yVC8zN9moCfO3qckCSZvrPkpe1rBMux7B5nAUY+hk1P3r2A074HGKhHuXyEHD//Sb5Q
        iRER8kICD5jss3uduYP/uL8xa73Kbwg2Tzjf8REbm9fNF/7HGoWJEG21gpJ8qKHmSOiyOu
        Q011uMIoPliwyUXLcDkQZIQmM+spYqoYhZZjSyDJARyYuklf8W2kcmHNixNqFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lzQ6SJUWO+cQIKpc/IWE3nb8cj8Ps+LzIGeiMNlvMc8=;
        b=GHUyR0hmp9aWm0lBqpjuMl+/4pQSKz/iZuhaPfDwY40pw0xW0raZ9yOGTeWO6FDV+rRvfv
        xSzPBlutqb6kwFAw==
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
Subject: [patch V4 47/68] locking/ww_mutex: Abstract internal lock access
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:28 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing the internal wait_lock of mutex and rtmutex is slightly
different. Provide helper functions for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/ww_mutex.h  |   13 +++++++++----
 kernel/locking/ww_mutex.h |   23 +++++++++++++++++++----
 2 files changed, 28 insertions(+), 8 deletions(-)

--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -19,6 +19,11 @@
 
 #include <linux/mutex.h>
 
+#define WW_MUTEX_BASE			mutex
+#define ww_mutex_base_init(l,n,k)	__mutex_init(l,n,k)
+#define ww_mutex_base_trylock(l)	mutex_trylock(l)
+#define ww_mutex_base_is_locked(b)	mutex_is_locked((b))
+
 struct ww_class {
 	atomic_long_t stamp;
 	struct lock_class_key acquire_key;
@@ -29,7 +34,7 @@ struct ww_class {
 };
 
 struct ww_mutex {
-	struct mutex base;
+	struct WW_MUTEX_BASE base;
 	struct ww_acquire_ctx *ctx;
 #ifdef CONFIG_DEBUG_MUTEXES
 	struct ww_class *ww_class;
@@ -82,7 +87,7 @@ struct ww_acquire_ctx {
 static inline void ww_mutex_init(struct ww_mutex *lock,
 				 struct ww_class *ww_class)
 {
-	__mutex_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
+	ww_mutex_base_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx = NULL;
 #ifdef CONFIG_DEBUG_MUTEXES
 	lock->ww_class = ww_class;
@@ -330,7 +335,7 @@ extern void ww_mutex_unlock(struct ww_mu
  */
 static inline int __must_check ww_mutex_trylock(struct ww_mutex *lock)
 {
-	return mutex_trylock(&lock->base);
+	return ww_mutex_base_trylock(&lock->base);
 }
 
 /***
@@ -354,7 +359,7 @@ static inline void ww_mutex_destroy(stru
  */
 static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
 {
-	return mutex_is_locked(&lock->base);
+	return ww_mutex_base_is_locked(&lock->base);
 }
 
 #endif
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -68,6 +68,21 @@ static inline bool
 	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
 }
 
+static inline void lock_wait_lock(struct mutex *lock)
+{
+	raw_spin_lock(&lock->wait_lock);
+}
+
+static inline void unlock_wait_lock(struct mutex *lock)
+{
+	raw_spin_unlock(&lock->wait_lock);
+}
+
+static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
+{
+	lockdep_assert_held(&lock->wait_lock);
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -174,7 +189,7 @@ static bool __ww_mutex_wound(struct MUTE
 {
 	struct task_struct *owner = __ww_mutex_owner(lock);
 
-	lockdep_assert_held(&lock->wait_lock);
+	lockdep_assert_wait_lock_held(lock);
 
 	/*
 	 * Possible through __ww_mutex_add_waiter() when we race with
@@ -227,7 +242,7 @@ static void
 {
 	struct MUTEX_WAITER *cur;
 
-	lockdep_assert_held(&lock->wait_lock);
+	lockdep_assert_wait_lock_held(lock);
 
 	for (cur = __ww_waiter_first(lock); cur;
 	     cur = __ww_waiter_next(lock, cur)) {
@@ -275,9 +290,9 @@ ww_mutex_set_context_fastpath(struct ww_
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	raw_spin_lock(&lock->base.wait_lock);
+	lock_wait_lock(&lock->base);
 	__ww_mutex_check_waiters(&lock->base, ctx);
-	raw_spin_unlock(&lock->base.wait_lock);
+	unlock_wait_lock(&lock->base);
 }
 
 static __always_inline int

