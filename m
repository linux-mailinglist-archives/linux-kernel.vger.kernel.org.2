Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49D3ECB4A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhHOVcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhHOV3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66DEC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:50 -0700 (PDT)
Message-ID: <20210815211304.622477030@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nrX5zHyTQKua8S1wHg9eh/FmYPW4+RDYg8qTFJk/Xu8=;
        b=uAWhgia4tf5C7myt6TT6AftPLQCJQxVbh1VZ00+1kUlCCjsMuN8/EC+WYNnBTWC6MyTR1X
        JG8xV7o7GUTazQIN4bfDywu4ZtcM/fQ39aF+nO35RzUl9fk31VJ5dzkHRcJ82R40LrUn16
        EVU3a74TNpsHCucL4Ll6gGyQGPt0NQ823I+ZG8jGyr3r9mWZXv5L6+TJ+yKOHgpJzPHLJ/
        2a4y3iv0Vf+q1QOK2+aP//4OzQsVp6dhClDZq9WBy7EFVFq/Mx6yZ/jp/WsBofO9pJ9nHH
        fs/HEc4ykjGujtlHOxdczDfKCBapIFeixDXXKOIYHmOhqE995Gt5Xzj4HqjXjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nrX5zHyTQKua8S1wHg9eh/FmYPW4+RDYg8qTFJk/Xu8=;
        b=mkapmaZqqTLGHAT0ILUAeS78TEdGPThU4QXa/IMT19VvEPIbxW09AypKLobfu4sE14NpbF
        ELCX7MQG2A6Dg7Cw==
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
Subject: [patch V5 47/72] locking/ww_mutex: Abstract mutex accessors
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:49 +0200 (CEST)
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

