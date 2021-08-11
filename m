Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9233E90ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhHKM07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:26:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50906 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbhHKMXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:50 -0400
Message-ID: <20210811121416.831948901@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nrX5zHyTQKua8S1wHg9eh/FmYPW4+RDYg8qTFJk/Xu8=;
        b=YEP6UVkFwdOUm7sg1wKJmM3TfQ/7YacUBsqpddmH/Uh2ydLNVOFnsXhcGWV96zkIRmXLYc
        FdPyGefPhjYdnWYP01BOsWhCCljJgbO3oJ550RPf0EjR/o/dyJwkzHMqWSEj2GvesH57A0
        ckt2YVRM4z0YLHmPm6hyyk42BZxeMBKGMWKdMevTw6yfsJ+TfAP0IxAf89TgLj7WbX+++1
        rw37OeFXO4qEHXdZ/ICL0GljYSqD6EYa+83LLB/I1Kfw3sSOwdn5pSZrhjiq+brgndK//b
        bfYBguLrwyBKi5TjMfnxSzLZlfeTY1wTk1f8pm90VgH5g0StLXlYOdniH/MMOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nrX5zHyTQKua8S1wHg9eh/FmYPW4+RDYg8qTFJk/Xu8=;
        b=6QUlGnP478LFEHlxTJ3s55YcV8ZEZSI3Pt4Xnnx/7Kz4s5eJ1LymV9bljcXzVAleOWrbEF
        bQDbMZjCs3tRdbAg==
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
Subject: [patch V4 45/68] locking/ww_mutex: Abstract mutex accessors
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:26 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Move the mutex related access from various ww_mutex functions into helper
functions so they can be substituted for rtmutex based ww_mutex later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/locking/ww_mutex.h |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)
---
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -53,6 +53,18 @@ static inline void
 	__mutex_add_waiter(lock, waiter, p);
 }
 
+static inline struct task_struct *
+__ww_mutex_owner(struct mutex *lock)
+{
+	return __mutex_owner(lock);
+}
+
+static inline bool
+__ww_mutex_has_waiters(struct mutex *lock)
+{
+	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -157,7 +169,7 @@ static bool __ww_mutex_wound(struct mute
 			     struct ww_acquire_ctx *ww_ctx,
 			     struct ww_acquire_ctx *hold_ctx)
 {
-	struct task_struct *owner = __mutex_owner(lock);
+	struct task_struct *owner = __ww_mutex_owner(lock);
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -253,7 +265,7 @@ ww_mutex_set_context_fastpath(struct ww_
 	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
 	 * and/or !empty list.
 	 */
-	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
+	if (likely(!__ww_mutex_has_waiters(&lock->base)))
 		return;
 
 	/*

