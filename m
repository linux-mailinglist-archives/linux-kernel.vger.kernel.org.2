Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE833E187D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbhHEPpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:45:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbhHEPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:29 -0400
Message-ID: <20210805153955.424580143@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xfTiisNqO4bWYKLqxuiAj07QbMu4XhbicsFqzaYisDc=;
        b=E4Yu5EOYeTLCcNORr9AuF/jErt3aQmvBoSb00Hq0pHSM6LXHpgMlmcIfRlnKP6C6TVhLaL
        vCsuGwmBMGTMoW/OV8nmZsIdK92LPWEdoiUVjbGvjriyba9GqXiVPyGxvPVcJ8N4UhgSsv
        gmLZKjW+3E+S3IKoCaaFEQ9Ig/mKNuFT+seYyHMW6/YZkrF8+TQ0U0bSLzOUwpNvlpJmI8
        MCgp5lkZlHC6gaGGduDQ8ylAhHHjrJFvWoLLaRxLL0Hk4weDqorxI7WE/E8zLcxzUoCTN6
        vIVQoacgQn1W4Tm491nvFTDzZ5YL2CAmtedLxvfi+MM1Ma/VA6kSba0VXQrZdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xfTiisNqO4bWYKLqxuiAj07QbMu4XhbicsFqzaYisDc=;
        b=GGPA74+94XQT215Y1b6gFIROf+pNrfyKpOe91TKDMmAe0Iy8pcoY2H/8/NOuEJHPIM0MWe
        5QGJwdEGR3A43tCQ==
Date:   Thu, 05 Aug 2021 17:13:45 +0200
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
Subject: [patch V3 45/64] locking/ww_mutex: Abstract mutex types
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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

