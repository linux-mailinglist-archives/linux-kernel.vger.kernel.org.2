Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796CB3E90BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbhHKMY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:24:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbhHKMXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:35 -0400
Message-ID: <20210811121416.118105642@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lqolXdw1SKc4oNuWw3sFxwNczR7NC0sp2gE+CrKGG7I=;
        b=hAQfQbncTlGpeaHl1GSGHgF6/V5Ycv2Vc6/Rz5gO0wdh1mw+R1dDkKdSQr9yJGDdYOb5cp
        7lmlOprR6QvjyqeVpnqhj7w9vm0rGqq93PfldB/kY6fce4Ib8BA4gJPzMBoIpqCFWWluJn
        6qMZa9A1bP/Q4U3SW4LM3jIrHlcVRAeVRjQe44buDqHzDBCSv9BkhNHIi51Mr4ul9/pl7u
        MOuVtv1x8zrLx60UPtuDm4q8NzafXK+UM/EmzlKwhq0Att7T4sdRa1xqEQ7ZKP4tX5+2Mp
        NiJSaryHl81Wm4xMrrPVz8hkTLl07MxhR75JwdKvngz7iLyEZLErjkG5Yz30Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lqolXdw1SKc4oNuWw3sFxwNczR7NC0sp2gE+CrKGG7I=;
        b=H37FcQ5EBgOyERjZYhHsUjm7shHEM6v3o0MRf57BCagYPsNdzD8NzEpOL8ldRg3dxxL2BP
        tAuPT1DoQubSvXCQ==
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
Subject: [patch V4 33/68] locking/rtmutex: Squash !RT tasks to DEFAULT_PRIO
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:11 +0200 (CEST)
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

