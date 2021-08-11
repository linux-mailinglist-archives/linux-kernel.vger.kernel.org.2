Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F133E90DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhHKM0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhHKMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:24:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11335C0617A3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:23:24 -0700 (PDT)
Message-ID: <20210811121416.655931494@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YVuvJ1XLBnOmfbJAV083RKXMf2sXOwW2CPGoKsQ79eo=;
        b=gQf/zcPCAeIuNu3jtADEgbloGfV3nFlJHfnIzdYf0CMY6L63TunOih4BA4zBibnEgAxVut
        7CIulIyChGAEwvHjilPuQilKKeh/NQ/zQ5QUV2i92Jn1D/HXP2U4ULm3jtNTGw5HTaYQwY
        K+2H4xAPRekDTCf//JmzUJk9xQpRyj2byoTr8FWBClojpEZaftxmy9FXxwb8Y18VqPxOcg
        dPjLU0ju3mXyGZvNQxOLSiPajsGAUBnGuKJIEwTxPPm73/jHqz5BIxHbpZiXcT+9S/epW0
        LS3TiM4rtQx9kOW3T5Gk2GC1WaS+rekBspTx/mox/gCvKaJZuEyAT5KrYPbQgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YVuvJ1XLBnOmfbJAV083RKXMf2sXOwW2CPGoKsQ79eo=;
        b=UeiGYiDaUuYp3dAjJnl/59/P8wsAuOvgs9liflDnSCYlUa0OwqtONThGXv1rj9cGODbtjK
        OOqY9nJWaEpXElDA==
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
Subject: [patch V4 42/68] locking/ww_mutex: Remove __sched annotation
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:22 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

None of these functions will be on the stack when blocking in
schedule(), hence __sched is not needed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/ww_mutex.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
---
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -62,7 +62,7 @@ ww_mutex_lock_acquired(struct ww_mutex *
  * transaction than @b and depending on algorithm either needs to wait for
  * @b or die.
  */
-static inline bool __sched
+static inline bool
 __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 {
 
@@ -77,7 +77,7 @@ static inline bool __sched
  * already (ctx->acquired > 0), because __ww_mutex_add_waiter() and
  * __ww_mutex_check_kill() wake any but the earliest context.
  */
-static bool __sched
+static bool
 __ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
 	       struct ww_acquire_ctx *ww_ctx)
 {
@@ -154,7 +154,7 @@ static bool __ww_mutex_wound(struct mute
  *
  * The current task must not be on the wait list.
  */
-static void __sched
+static void
 __ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	struct mutex_waiter *cur;
@@ -210,7 +210,7 @@ ww_mutex_set_context_fastpath(struct ww_
 	raw_spin_unlock(&lock->base.wait_lock);
 }
 
-static __always_inline int __sched
+static __always_inline int
 __ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	if (ww_ctx->acquired > 0) {
@@ -238,7 +238,7 @@ static __always_inline int __sched
  * Since __ww_mutex_add_waiter() orders the wait-list on stamp, we only have to
  * look at waiters before us in the wait-list.
  */
-static inline int __sched
+static inline int
 __ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
 		      struct ww_acquire_ctx *ctx)
 {
@@ -285,7 +285,7 @@ static inline int __sched
  * older contexts already waiting) to avoid unnecessary waiting and for
  * Wound-Wait ensure we wound the owning context when it is younger.
  */
-static inline int __sched
+static inline int
 __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 		      struct mutex *lock,
 		      struct ww_acquire_ctx *ww_ctx)

