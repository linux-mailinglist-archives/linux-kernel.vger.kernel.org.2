Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D03DBA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbhG3OWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbhG3OSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CADC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:17:56 -0700 (PDT)
Message-ID: <20210730135207.594075340@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nrX5zHyTQKua8S1wHg9eh/FmYPW4+RDYg8qTFJk/Xu8=;
        b=W71nwMsJsDTs8i/tws7q9a7zk8VcQKnrWS82G6MzCZwf7ZNmYNRMwbb1q/1rq/tJp86m7v
        fuTxqV8K/vavfKOhHVKIcN46sVQKrUPQzTw2NxaVBZxUC9qG3QzMTUFPSphibn7+sP4v00
        t6o5VS7NuPed4sCqgGrV0naefnaijehH+vC9sMGtvAaFtnkZgtUSATnt8CjKTyAb7k+DEC
        ZO6vZrXTUsLBd9h0jwni3JWhlzk//I1YpkZQ64vY3hs4YzRuM5NKkW3xi45SUe7jK0XI4q
        HPpATDMyEYUEfHNEj9A/Zy9cenXRH6+AdnPcbsOCUGAyaj7DVSMVwVnuYgxqAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nrX5zHyTQKua8S1wHg9eh/FmYPW4+RDYg8qTFJk/Xu8=;
        b=yWbI9B8UVGlPwGcWaUoOdpvnc7etje4Eq6+UdZ9FdXH5Pj1QL/nFNOCwlasga4TJ0pzr2a
        p1AV1l9WxpLP06Ag==
Date:   Fri, 30 Jul 2021 15:50:50 +0200
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
Subject: [patch 43/63] locking/ww_mutex: Abstract mutex accessors
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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

