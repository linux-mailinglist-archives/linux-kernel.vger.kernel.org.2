Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306103C7427
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhGMQRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbhGMQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:17:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B347AC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:14:09 -0700 (PDT)
Message-Id: <20210713160750.755786198@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7rAbPb2kTXkzxyQpKLCUDPudmpCDKhwEfSFhuJboTgs=;
        b=xabXjfm12S1g7BBLgNOPoKU03oAnZVl27klGxVHIlvt4uMaMSTIPsPE6cv/RU6f+RzTyHr
        RqhpeAs1Ws0YBumz7AhoyVIlEGzegZZ7YpFaAD2WzIGjpNMAGi6WRZrCztwNKDzDH9+gOe
        fx6FD4+/oXD5XuccCuV9Crko4ZixcQCmPr8QaQ187/DleDv0UQgN4vBuHbwk1fuxCIZUXC
        xjdf/zrosoxGW1w1FsIUwcLQh6pdImOSx0VPS2cBN/P+QNILSxWG2DM+lwzMYTQ4n6RiQD
        8jgGwtUO+pQ91MsDXzQmJu0t6/62bTd2ojPekydWDhD0LmyyzLAQ2XcjbQ4JFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7rAbPb2kTXkzxyQpKLCUDPudmpCDKhwEfSFhuJboTgs=;
        b=+G7byVr4awHiivLZbEddour4ANxzhlpeDKdVZWhUKTjn927RPfVRcR60yto8AJetPHx6QN
        QgOAO4eSiHVGmBBQ==
Date:   Tue, 13 Jul 2021 17:11:43 +0200
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
        Gregory Haskins <ghaskins@novell.com>
Subject: [patch 49/50] locking/rtmutex: Implement equal priority lock stealing
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory Haskins <ghaskins@novell.com>

The current logic only allows lock stealing to occur if the current task is
of higher priority than the pending owner.

Signficant throughput improvements can be gained by allowing the lock
stealing to include tasks of equal priority when the contended lock is a
spin_lock or a rw_lock and the tasks are not in a RT scheduling task.

The assumption was that the system will make faster progress by allowing
the task already on the CPU to take the lock rather than waiting for the
system to wake up a different task.

This does add a degree of unfairness, but in reality no negative side
effects have been observed in the many years that this has been used in the
RT kernel.

[ tglx: Refactored and rewritten several times by Steve Rostedt, Sebastian
  	Siewior and myself ]

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |   52 +++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 17 deletions(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -286,6 +286,26 @@ static __always_inline int rt_mutex_wait
 	return 1;
 }
 
+static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
+				  struct rt_mutex_waiter *top_waiter)
+{
+	if (rt_mutex_waiter_less(waiter, top_waiter))
+		return true;
+
+#ifdef RT_MUTEX_BUILD_SPINLOCKS
+	/*
+	 * Note that RT tasks are excluded from same priority (lateral)
+	 * steals to prevent the introduction of an unbounded latency.
+	 */
+	if (rt_prio(waiter->prio) || dl_prio(waiter->prio))
+		return false;
+
+	return rt_mutex_waiter_equal(waiter, top_waiter);
+#else
+	return false;
+#endif
+}
+
 #define __node_2_waiter(node) \
 	rb_entry((node), struct rt_mutex_waiter, tree_entry)
 
@@ -858,19 +878,21 @@ try_to_take_rt_mutex(struct rt_mutex *lo
 	 * trylock attempt.
 	 */
 	if (waiter) {
-		/*
-		 * If waiter is not the highest priority waiter of
-		 * @lock, give up.
-		 */
-		if (waiter != rt_mutex_top_waiter(lock))
-			return 0;
+		struct rt_mutex_waiter *top_waiter = rt_mutex_top_waiter(lock);
 
 		/*
-		 * We can acquire the lock. Remove the waiter from the
-		 * lock waiters tree.
+		 * If waiter is the highest priority waiter of @lock,
+		 * or allowed to steal it, take it over.
 		 */
-		rt_mutex_dequeue(lock, waiter);
-
+		if (waiter == top_waiter || rt_mutex_steal(waiter, top_waiter)) {
+			/*
+			 * We can acquire the lock. Remove the waiter from the
+			 * lock waiters tree.
+			 */
+			rt_mutex_dequeue(lock, waiter);
+		} else {
+			return 0;
+		}
 	} else {
 		/*
 		 * If the lock has waiters already we check whether @task is
@@ -881,13 +903,9 @@ try_to_take_rt_mutex(struct rt_mutex *lo
 		 * not need to be dequeued.
 		 */
 		if (rt_mutex_has_waiters(lock)) {
-			/*
-			 * If @task->prio is greater than or equal to
-			 * the top waiter priority (kernel view),
-			 * @task lost.
-			 */
-			if (!rt_mutex_waiter_less(task_to_waiter(task),
-						  rt_mutex_top_waiter(lock)))
+			/* Check whether the trylock can steal it. */
+			if (!rt_mutex_steal(task_to_waiter(task),
+					    rt_mutex_top_waiter(lock)))
 				return 0;
 
 			/*

