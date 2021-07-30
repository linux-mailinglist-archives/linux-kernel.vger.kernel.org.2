Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9947F3DBA76
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbhG3OXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:23:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbhG3OR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:56 -0400
Message-ID: <20210730135207.423626327@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=asyCb3EnTX0AwPRcbwl9IwcpguTWU0as684+zNGmICU=;
        b=WcR7sikQRHvZn6zHl9NoG94sJNYUufgDcT98U9gyuzofHHoLedwttVQ+OX1NHZgRVL4+fj
        LabRIhkFAZabiHRPh/GJzmQQr2QGAeO5XMsgYpJO5BBoKCZqTm/4c6SzCOm+XAlUYdSHml
        j2AqYgKJWKI5JD7WowqPgFdzIX2gMoEEwmfZHwCUq94XvpmSxOQw3Zmb+TD6uzgUa+cRXU
        EUyky8YSIQxy1ioO1g0Dspt2DYfRp1tOEDfq+e1cY7l62sFRrsOssqdfbYDn0PiKr+bq1p
        LPekfH9aZB1czSL5jlmUX5qpaHDDJpsmzDO1hiqKI1v9x/jAVIyBgcsOOjCUQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=asyCb3EnTX0AwPRcbwl9IwcpguTWU0as684+zNGmICU=;
        b=X9pe/dgFDsMDrpH6WtpB8UUKw1kxxLplf+zJx/zOTv85mbKxaLcf2IXe3yO66QJtyNs+x8
        QkfvUDKcYmi0P6AQ==
Date:   Fri, 30 Jul 2021 15:50:47 +0200
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
Subject: [patch 40/63] locking/ww_mutex: Remove __sched annotation
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

None of these functions will be on the stack when we block in
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

