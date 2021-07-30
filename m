Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853D13DBA69
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbhG3OWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbhG3OSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:07 -0400
Message-ID: <20210730135207.814889581@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LE3Evel80K719bVxB7deCT2IymecX2iC05nYxw52rp4=;
        b=fEsOIMdZNSWgcNnHoDj3xA8FFkIaxeBO8UZhSL3l4Vy6p6aJ9JeFQQcnIpwrjmj8nlwbd/
        IFDHl92ueA5EuAO2vDlVPsWZs89McFP/aSqMTQ5xPcKyPmd8KL+ot8Zi+TOrG2FdS7pgKy
        Yq2irrkDIzAKWqSVJhlU+qV/IUge+uC1+8RKIxmnjh/41xg9el5vXkWA8Um3SMPqAKKj/M
        YUCAGLmHhNKfuMT1hjzy6+3YwojBToRVgZbt3lOvQ8VqgUAD3hU9CsvcpuCqpYsQehJpO/
        znu3PM5zEKzxpgz25rIEemfODQT1/+fMS2KVmBa9Hoxl/FSciP64ShZiyCAb2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LE3Evel80K719bVxB7deCT2IymecX2iC05nYxw52rp4=;
        b=e5idC8/9/7uXxiRvJUAAzK3NVqeHwa8wVu6Oy8DZO1SjSUZYjBJ4EW+0Q9ZmMSYx9rjVz5
        V/bisszvQuH6vnCw==
Date:   Fri, 30 Jul 2021 15:50:54 +0200
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
Subject: [patch 47/63] locking/ww_mutex: Add RT priority to W/W order
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

RTmutex based ww_mutexes cannot order based on timestamp. They have to
order based on priority. Add the necessary decision logic.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/locking/ww_mutex.h |   64 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 15 deletions(-)
---
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -219,19 +219,54 @@ ww_mutex_lock_acquired(struct ww_mutex *
 }
 
 /*
- * Determine if context @a is 'after' context @b. IOW, @a is a younger
- * transaction than @b and depending on algorithm either needs to wait for
- * @b or die.
+ * Determine if @a is 'less' than @b. IOW, either @a is a lower priority task
+ * or, when of equal priority, a younger transaction than @b.
+ *
+ * Depending on the algorithm, @a will either need to wait for @b, or die.
  */
 static inline bool
-__ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
+__ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 {
+/*
+ * Can only do the RT prio for WW_RT because task->prio isn't stable due to PI,
+ * so the wait_list ordering will go wobbly. rt_mutex re-queues the waiter and
+ * isn't affected by this.
+ */
+#ifdef WW_RT
+	/* kernel prio; less is more */
+	int a_prio = a->task->prio;
+	int b_prio = b->task->prio;
+
+	if (dl_prio(a_prio) || dl_prio(b_prio)) {
+
+		if (a_prio > b_prio)
+			return true;
+
+		if (a_prio < b_prio)
+			return false;
+
+		/* equal static prio */
+
+		if (dl_prio(a_prio)) {
+			if (dl_time_before(b->task->dl.deadline,
+					   a->task->dl.deadline))
+				return true;
+
+			if (dl_time_before(a->task->dl.deadline,
+					   b->task->dl.deadline))
+				return false;
+		}
+
+		/* equal prio */
+	}
+#endif
 
+	/* FIFO order tie break -- bigger is younger */
 	return (signed long)(a->stamp - b->stamp) > 0;
 }
 
 /*
- * Wait-Die; wake a younger waiter context (when locks held) such that it can
+ * Wait-Die; wake a lesser waiter context (when locks held) such that it can
  * die.
  *
  * Among waiters with context, only the first one can have other locks acquired
@@ -245,8 +280,7 @@ static bool
 	if (!ww_ctx->is_wait_die)
 		return false;
 
-	if (waiter->ww_ctx->acquired > 0 &&
-			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
+	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
@@ -257,10 +291,10 @@ static bool
 }
 
 /*
- * Wound-Wait; wound a younger @hold_ctx if it holds the lock.
+ * Wound-Wait; wound a lesser @hold_ctx if it holds the lock.
  *
- * Wound the lock holder if there are waiters with older transactions than
- * the lock holders. Even if multiple waiters may wound the lock holder,
+ * Wound the lock holder if there are waiters with more important transactions
+ * than the lock holders. Even if multiple waiters may wound the lock holder,
  * it's sufficient that only one does.
  */
 static bool __ww_mutex_wound(struct MUTEX *lock,
@@ -287,7 +321,7 @@ static bool __ww_mutex_wound(struct MUTE
 	if (!owner)
 		return false;
 
-	if (ww_ctx->acquired > 0 && __ww_ctx_stamp_after(hold_ctx, ww_ctx)) {
+	if (ww_ctx->acquired > 0 && __ww_ctx_less(hold_ctx, ww_ctx)) {
 		hold_ctx->wounded = 1;
 
 		/*
@@ -306,8 +340,8 @@ static bool __ww_mutex_wound(struct MUTE
 }
 
 /*
- * We just acquired @lock under @ww_ctx, if there are later contexts waiting
- * behind us on the wait-list, check if they need to die, or wound us.
+ * We just acquired @lock under @ww_ctx, if there are more important contexts
+ * waiting behind us on the wait-list, check if they need to die, or wound us.
  *
  * See __ww_mutex_add_waiter() for the list-order construction; basically the
  * list is ordered by stamp, smallest (oldest) first.
@@ -421,7 +455,7 @@ static inline int
 		return 0;
 	}
 
-	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
+	if (hold_ctx && __ww_ctx_less(ctx, hold_ctx))
 		return __ww_mutex_kill(lock, ctx);
 
 	/*
@@ -479,7 +513,7 @@ static inline int
 		if (!cur->ww_ctx)
 			continue;
 
-		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
+		if (__ww_ctx_less(ww_ctx, cur->ww_ctx)) {
 			/*
 			 * Wait-Die: if we find an older context waiting, there
 			 * is no point in queueing behind it, as we'd have to

