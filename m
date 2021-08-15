Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5263ECB4B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhHOVcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhHOV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D3C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:52 -0700 (PDT)
Message-ID: <20210815211304.678720245@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xfTiisNqO4bWYKLqxuiAj07QbMu4XhbicsFqzaYisDc=;
        b=YAkFVa6qI8InQp48xLE9jaQ0DUBkLSoywjc8FIYgBShERI29zg2Ro3C5KesAZ1aOcONnWI
        zDbXpAIrxyRatNzmW2QSINe1uWP9GiBSO7eSPfoF2RU1B+V5/gc1tGaifsOFMXSgN7BY2k
        9piWeV5J1fN9Yi/Lk0xbOWq0BIvw2Rjtf8jXfGwa7Z6CcSPYsnP2sOeeG8S873GB0j0+Pv
        orofhM0axmvQWsie48yK6Qc5YQ+w7W9vDj1lHrWmIPnL6oQmMGFG81xYQRaDTweSIFKwDo
        +O1F3M9JqU14EqJPC5ykFDkgr9DrD6J9ICHTZLDGPrdOYBpbC/puWEJGxycihw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xfTiisNqO4bWYKLqxuiAj07QbMu4XhbicsFqzaYisDc=;
        b=EluH7NguXeHBvbFIIrZJ69HFfd24uE1e4tW2GTd2lSPRzL3qUT/k0JiansAGHIwHm98NxU
        AY2RfDpJQ9NWHrCw==
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
Subject: [patch V5 48/72] locking/ww_mutex: Abstract mutex types
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:50 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Some ww_mutex helper functions use pointers for the underlying mutex and
mutex_waiter. The upcoming rtmutex based implementation needs to share
these functions. Add and use defines for the types and replace the direct
types in the affected functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/locking/ww_mutex.h |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)
---
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+#define MUTEX		mutex
+#define MUTEX_WAITER	mutex_waiter
+
 static inline struct mutex_waiter *
 __ww_waiter_first(struct mutex *lock)
 {
@@ -143,7 +146,7 @@ static inline bool
  * __ww_mutex_check_kill() wake any but the earliest context.
  */
 static bool
-__ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
+__ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 	       struct ww_acquire_ctx *ww_ctx)
 {
 	if (!ww_ctx->is_wait_die)
@@ -165,7 +168,7 @@ static bool
  * the lock holders. Even if multiple waiters may wound the lock holder,
  * it's sufficient that only one does.
  */
-static bool __ww_mutex_wound(struct mutex *lock,
+static bool __ww_mutex_wound(struct MUTEX *lock,
 			     struct ww_acquire_ctx *ww_ctx,
 			     struct ww_acquire_ctx *hold_ctx)
 {
@@ -220,9 +223,9 @@ static bool __ww_mutex_wound(struct mute
  * The current task must not be on the wait list.
  */
 static void
-__ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+__ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
 {
-	struct mutex_waiter *cur;
+	struct MUTEX_WAITER *cur;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -278,7 +281,7 @@ ww_mutex_set_context_fastpath(struct ww_
 }
 
 static __always_inline int
-__ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+__ww_mutex_kill(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	if (ww_ctx->acquired > 0) {
 #ifdef CONFIG_DEBUG_MUTEXES
@@ -306,12 +309,12 @@ static __always_inline int
  * look at waiters before us in the wait-list.
  */
 static inline int
-__ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
+__ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		      struct ww_acquire_ctx *ctx)
 {
 	struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
 	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
-	struct mutex_waiter *cur;
+	struct MUTEX_WAITER *cur;
 
 	if (ctx->acquired == 0)
 		return 0;
@@ -354,11 +357,11 @@ static inline int
  * Wound-Wait ensure we wound the owning context when it is younger.
  */
 static inline int
-__ww_mutex_add_waiter(struct mutex_waiter *waiter,
-		      struct mutex *lock,
+__ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
+		      struct MUTEX *lock,
 		      struct ww_acquire_ctx *ww_ctx)
 {
-	struct mutex_waiter *cur, *pos = NULL;
+	struct MUTEX_WAITER *cur, *pos = NULL;
 	bool is_wait_die;
 
 	if (!ww_ctx) {

