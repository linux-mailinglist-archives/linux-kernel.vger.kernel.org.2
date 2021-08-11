Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB43E90E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbhHKM0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:26:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhHKMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:24:18 -0400
Message-ID: <20210811121418.124274733@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=a0QmhjYmOpsjV7DFN30aDRNpJiPQTVCOzfwzPDjxAKk=;
        b=o7mHt+153gLhuVhN+EH5TL4GKu1hp2+tfI0kU8LPfYoJEAyiy4K4CsE5oHAlhYq70t8ald
        CFAbZN+SbQi4aVk04V2T98kbbQfkrOkxeNkldeC+Ulf6uIpgBIGrDsbrC2SnA0CzEyKN34
        YdoDhG8mmeCmrjXWgeZO3aobfsvPd6lXbno8vZwTIxALdOTb3UkpKjbET2Gh3+UkaP7jpz
        5VZSyd1iQnpMOeDwC0NOfsAXdjXLFQ5etlhYhWMw1eb7voPKcDvxaxzpRF6e1Y5I+6LUxp
        CFUrk9aG7WGIE93G5Za2CKqvek1/7paFDpn/Er4Z5kMTBbrR7X8Ni4tLXAT1mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=a0QmhjYmOpsjV7DFN30aDRNpJiPQTVCOzfwzPDjxAKk=;
        b=3gb7LDBB9sAxyPQahFpHRbGpts9TE9O4loTomLFsdLPjcsFKBZvnVwCLbMeiSkLRMYBYIp
        z8fzb+JZ9PZVHPAQ==
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
        Mike Galbraith <efault@gmx.de>,
        Gregory Haskins <ghaskins@novell.com>
Subject: [patch V4 67/68] locking/rtmutex: Implement equal priority lock stealing
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:53 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory Haskins <ghaskins@novell.com>

The current logic only allows lock stealing to occur if the current task is
of higher priority than the pending owner.

Significant throughput improvements can be gained by allowing the lock
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
@@ -338,6 +338,26 @@ static __always_inline int rt_mutex_wait
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
 
@@ -932,19 +952,21 @@ try_to_take_rt_mutex(struct rt_mutex_bas
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
@@ -955,13 +977,9 @@ try_to_take_rt_mutex(struct rt_mutex_bas
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

