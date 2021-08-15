Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A213ECB4D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhHOVcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:32:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48436 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhHOV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:25 -0400
Message-ID: <20210815211304.790760545@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=MJbhoSWNuYj+bWle6aksdkFrxsJ6cTJTB/qdnCZsORI=;
        b=TttJjF2H6fUIn8MK6zkiM7Rd95SvbJzubvvhBzOedadin50NUl8LEq4/oNAQobXVllX36M
        0EZ1A/M8HkZ0k6S67hYKVrdOA+pIHHVN//XT1c+hvEZyXvb2xyS0xBFJam2LDole8xQmHU
        GrDqxskT2JA5XVwArYIITksWavEqEwhiYXgT1BQi0Om7ZMNbSvw76NgeK+Y7l4WMKc81ZK
        hhVRzWQ9GEen+QEuKj0YNfkAEJa1MzvmpVu/IDhoTVUzti4e8OqEapoIXr1WoLIlEYhnCi
        cI8tpgNuuPJWCWBuGT9DpzNqNV5khhi6zzbfcEyz4Yxp0rkz2URqvLoonJg+cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=MJbhoSWNuYj+bWle6aksdkFrxsJ6cTJTB/qdnCZsORI=;
        b=e9r+UwQI+BvRdAGrysH1aiaLq7YndsxCbXqKxIDNeAlRvUSgrs1HzXBQQrmf+9oc9evy6r
        YBmCiJMX0rZLHUBw==
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
Subject: [patch V5 50/72] locking/ww_mutex: Implement rt_mutex accessors
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:53 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Provide the type defines and the helper inlines for rtmutex based ww_mutexes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/locking/ww_mutex.h |   80 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
---
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+#ifndef WW_RT
+
 #define MUTEX		mutex
 #define MUTEX_WAITER	mutex_waiter
 
@@ -83,6 +85,82 @@ static inline void lockdep_assert_wait_l
 	lockdep_assert_held(&lock->wait_lock);
 }
 
+#else /* WW_RT */
+
+#define MUTEX		rt_mutex
+#define MUTEX_WAITER	rt_mutex_waiter
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_first(struct rt_mutex *lock)
+{
+	struct rb_node *n = rb_first(&lock->rtmutex.waiters.rb_root);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_next(struct rt_mutex *lock, struct rt_mutex_waiter *w)
+{
+	struct rb_node *n = rb_next(&w->tree_entry);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_prev(struct rt_mutex *lock, struct rt_mutex_waiter *w)
+{
+	struct rb_node *n = rb_prev(&w->tree_entry);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_last(struct rt_mutex *lock)
+{
+	struct rb_node *n = rb_last(&lock->rtmutex.waiters.rb_root);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline void
+__ww_waiter_add(struct rt_mutex *lock, struct rt_mutex_waiter *waiter, struct rt_mutex_waiter *pos)
+{
+	/* RT unconditionally adds the waiter first and then removes it on error */
+}
+
+static inline struct task_struct *
+__ww_mutex_owner(struct rt_mutex *lock)
+{
+	return rt_mutex_owner(&lock->rtmutex);
+}
+
+static inline bool
+__ww_mutex_has_waiters(struct rt_mutex *lock)
+{
+	return rt_mutex_has_waiters(&lock->rtmutex);
+}
+
+static inline void lock_wait_lock(struct rt_mutex *lock)
+{
+	raw_spin_lock(&lock->rtmutex.wait_lock);
+}
+
+static inline void unlock_wait_lock(struct rt_mutex *lock)
+{
+	raw_spin_unlock(&lock->rtmutex.wait_lock);
+}
+
+static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
+{
+	lockdep_assert_held(&lock->rtmutex.wait_lock);
+}
+
+#endif /* WW_RT */
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -169,7 +247,9 @@ static bool
 
 	if (waiter->ww_ctx->acquired > 0 &&
 			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
+#ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
+#endif
 		wake_up_process(waiter->task);
 	}
 

