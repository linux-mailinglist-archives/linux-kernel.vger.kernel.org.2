Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FA63E1880
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242633AbhHEPpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:45:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44312 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbhHEPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:38 -0400
Message-ID: <20210805153955.652772788@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=cuh2XqHKJ/UcXAmLgSNKkpMsXwRJ/8chvM5yWBeR1wQ=;
        b=vGhBnOx35hQGHVohlLxO5URBLKlZ37doY1gk+1ZYdwMnQnSH3LPz/De2n3Ie775rGGzkbP
        2QtrSYaj775mZEWewcBHAFjp2kwOqrlGXySaALfO0SbE1bEO390Z3u3f695PgRMrOo/5nP
        O9hOd7aV/AurPpN/ff2qU3yKYSj17Dn95w2wvJEhdt6yr3UvNnBk8tvn2YmFHvbMBNNfEE
        YeIjUZjTND14F6EoKY6bk0PCyuhhmm/wLP1IWmSmegtJPr5QGwNdWgzt6yzX4QK9yOESnT
        ANX8UNI1cR3IbHX09QvQanvtnipLNpfXD4l20dc6b+25E0ulWbiwQ/ZjoA3Tgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=cuh2XqHKJ/UcXAmLgSNKkpMsXwRJ/8chvM5yWBeR1wQ=;
        b=Hw0aKftWL6BcSRppjI5xtvrXBnCsmbcliaSr48F1sGyMxn7sSKlt/4U/5WIa9t1on+xez/
        dQ10yIUPX7c104Bg==
Date:   Thu, 05 Aug 2021 17:13:49 +0200
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
Subject: [patch V3 49/64] locking/ww_mutex: Add rt_mutex based lock type and accessors
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Provide the defines for RT mutex based ww_mutexes and fixup the debug logic
so it's either enabled by DEBUG_MUTEXES or DEBUG_RT_MUTEXES on RT kernels.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/ww_mutex.h  |   33 ++++++++++++++++++++++++---------
 kernel/locking/ww_mutex.h |    6 +++---
 2 files changed, 27 insertions(+), 12 deletions(-)
---
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -18,11 +18,24 @@
 #define __LINUX_WW_MUTEX_H
 
 #include <linux/mutex.h>
+#include <linux/rtmutex.h>
 
+#if defined(CONFIG_DEBUG_MUTEXES) || \
+   (defined(CONFIG_PREEMPT_RT) && defined(CONFIG_DEBUG_RT_MUTEXES))
+#define DEBUG_WW_MUTEXES
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
 #define WW_MUTEX_BASE			mutex
 #define ww_mutex_base_init(l,n,k)	__mutex_init(l,n,k)
 #define ww_mutex_base_trylock(l)	mutex_trylock(l)
 #define ww_mutex_base_is_locked(b)	mutex_is_locked((b))
+#else
+#define WW_MUTEX_BASE			rt_mutex
+#define ww_mutex_base_init(l,n,k)	__rt_mutex_init(l,n,k)
+#define ww_mutex_base_trylock(l)	rt_mutex_trylock(l)
+#define ww_mutex_base_is_locked(b)	rt_mutex_base_is_locked(&(b)->rtmutex)
+#endif
 
 struct ww_class {
 	atomic_long_t stamp;
@@ -36,7 +49,7 @@ struct ww_class {
 struct ww_mutex {
 	struct WW_MUTEX_BASE base;
 	struct ww_acquire_ctx *ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	struct ww_class *ww_class;
 #endif
 };
@@ -47,10 +60,10 @@ struct ww_acquire_ctx {
 	unsigned int acquired;
 	unsigned short wounded;
 	unsigned short is_wait_die;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	unsigned int done_acquire;
 	struct ww_class *ww_class;
-	struct ww_mutex *contending_lock;
+	void *contending_lock;
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
@@ -89,7 +102,7 @@ static inline void ww_mutex_init(struct
 {
 	ww_mutex_base_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx = NULL;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	lock->ww_class = ww_class;
 #endif
 }
@@ -126,7 +139,7 @@ static inline void ww_acquire_init(struc
 	ctx->acquired = 0;
 	ctx->wounded = false;
 	ctx->is_wait_die = ww_class->is_wait_die;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	ctx->ww_class = ww_class;
 	ctx->done_acquire = 0;
 	ctx->contending_lock = NULL;
@@ -156,7 +169,7 @@ static inline void ww_acquire_init(struc
  */
 static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	lockdep_assert_held(ctx);
 
 	DEBUG_LOCKS_WARN_ON(ctx->done_acquire);
@@ -176,7 +189,7 @@ static inline void ww_acquire_fini(struc
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	mutex_release(&ctx->dep_map, _THIS_IP_);
 #endif
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(ctx->acquired);
 	if (!IS_ENABLED(CONFIG_PROVE_LOCKING))
 		/*
@@ -282,7 +295,7 @@ static inline void
 ww_mutex_lock_slow(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 	int ret;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
 #endif
 	ret = ww_mutex_lock(lock, ctx);
@@ -318,7 +331,7 @@ static inline int __must_check
 ww_mutex_lock_slow_interruptible(struct ww_mutex *lock,
 				 struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
 #endif
 	return ww_mutex_lock_interruptible(lock, ctx);
@@ -348,7 +361,9 @@ static inline int __must_check ww_mutex_
  */
 static inline void ww_mutex_destroy(struct ww_mutex *lock)
 {
+#ifndef CONFIG_PREEMPT_RT
 	mutex_destroy(&lock->base);
+#endif
 }
 
 /**
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -180,7 +180,7 @@ static inline void lockdep_assert_wait_l
 static __always_inline void
 ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	/*
 	 * If this WARN_ON triggers, you used ww_mutex_lock to acquire,
 	 * but released with a normal mutex_unlock in this call.
@@ -413,7 +413,7 @@ static __always_inline int
 __ww_mutex_kill(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	if (ww_ctx->acquired > 0) {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 		struct ww_mutex *ww;
 
 		ww = container_of(lock, struct ww_mutex, base);
@@ -559,7 +559,7 @@ static inline int
 static inline void __ww_mutex_unlock(struct ww_mutex *lock)
 {
 	if (lock->ctx) {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
 #endif
 		if (lock->ctx->acquired > 0)

