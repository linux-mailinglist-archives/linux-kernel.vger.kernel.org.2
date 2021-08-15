Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B583ECB38
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhHOVay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhHOV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADC7C0612A8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:31 -0700 (PDT)
Message-ID: <20210815211303.938676930@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lqolXdw1SKc4oNuWw3sFxwNczR7NC0sp2gE+CrKGG7I=;
        b=bGemIjuf7echrTwxNzJEXoOdRBmSUU7TWeNOnX1AprKMMOp/r10t6LQAeQn7zWXjefhU6b
        T6lbHO6UjsInbt49ZCEilj1csNjsyHu3R5oW76sNTFa74Pn9EXGdinIZD75uWSOoEBbTnx
        FBWKur9eNUeU2YHrQIKhK9C4UgPqxNOAgDyNXrZYGsloMgqxYWs0Txxra8/IYE9PTBMPV7
        gn+8JYF/Jcspl9gOGmUforumg242BS7amexlP/EnGoMgxQW2uzvud5IuO78PXv3ACHWrAE
        LkTVXshTvkqMLB8A2T49DZ+MPfCTOh38SZh1IHthqvS1I0t9fzpjYbMCOVRfaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lqolXdw1SKc4oNuWw3sFxwNczR7NC0sp2gE+CrKGG7I=;
        b=3/PKdUiyTo6oBhwodHxlJLZ1jGhTOJfVItC+I+JaxhwVee4Sj5wJNAISYY51pjtx551lqa
        KlVrJg6go46iknBw==
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
Subject: [patch V5 35/72] locking/rtmutex: Squash !RT tasks to DEFAULT_PRIO
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:30 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure all !RT tasks have the same prio such that they end up in FIFO
order and aren't split up according to nice level.

The reason why nice levels were taken into account so far is historical. In
the early days of the rtmutex code it was done to give the PI boosting and
deboosting a larger coverage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Picked up as a new patch
---
---
 kernel/locking/rtmutex.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -244,11 +244,28 @@ static __always_inline bool unlock_rt_mu
 }
 #endif
 
+static __always_inline int __waiter_prio(struct task_struct *task)
+{
+	int prio = task->prio;
+
+	if (!rt_prio(prio))
+		return DEFAULT_PRIO;
+
+	return prio;
+}
+
+static __always_inline void
+waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	waiter->prio = __waiter_prio(task);
+	waiter->deadline = task->dl.deadline;
+}
+
 /*
  * Only use with rt_mutex_waiter_{less,equal}()
  */
 #define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = (p)->prio, .deadline = (p)->dl.deadline }
+	&(struct rt_mutex_waiter){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
 
 static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 						struct rt_mutex_waiter *right)
@@ -698,8 +715,7 @@ static int __sched rt_mutex_adjust_prio_
 	 * serializes all pi_waiters access and rb_erase() does not care about
 	 * the values of the node being removed.
 	 */
-	waiter->prio = task->prio;
-	waiter->deadline = task->dl.deadline;
+	waiter_update_prio(waiter, task);
 
 	rt_mutex_enqueue(lock, waiter);
 
@@ -969,8 +985,7 @@ static int __sched task_blocks_on_rt_mut
 	raw_spin_lock(&task->pi_lock);
 	waiter->task = task;
 	waiter->lock = lock;
-	waiter->prio = task->prio;
-	waiter->deadline = task->dl.deadline;
+	waiter_update_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))

