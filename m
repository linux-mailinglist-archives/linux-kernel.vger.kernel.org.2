Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8F3E1861
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhHEPm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:42:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242168AbhHEPlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:51 -0400
Message-ID: <20210805153954.036560834@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+YnMRjsnxk84Or/H+2smifp2SyRHTm7IycMX/nyQ9U0=;
        b=TVsQt2lamKZDkiwrJm0NotW4AEVi6cN0hhf0459DIcvwqAxJN1we9XZIyMFPxp6BoZkQfR
        98UmnHLQpi3hOU1jYVb1TcCEs/sokmVIMf7xIAYfPjrQlFnWWC/iZ/TP/xMh0M4CPxVWuR
        9/eEe7ysia7IAW4v+OAz/zwhWNxVBrMr1IEvOfZqCMNEzGuqmsi2ymxyoO/LxPbHwziC8I
        X7NUXWxonGExAepR29U6tXhI11p2LTMXNWozcJg4+vGNdeFSSDR8onfmeKX+nOygv4fhF8
        USDd4qFiOzgubxgxk1cXCtV3F0id2D1Hat8ESJsINL7AcPkGdLQ62JdL0p7XEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+YnMRjsnxk84Or/H+2smifp2SyRHTm7IycMX/nyQ9U0=;
        b=3T2pCOUXhY0qfBMjsQSwwdtKcsolME1klprfiDVMVI9dayD0DBRAZs/CHGQOWsCKTkQxDl
        Ex2T0eqghchaVODA==
Date:   Thu, 05 Aug 2021 17:13:21 +0200
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
Subject: [patch V3 21/64] locking/rtmutex: Prepare RT rt_mutex_wake_q for RT locks
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add a rtlock_task pointer to rt_mutex_wake_q which allows to handle the RT
specific wakeup for spin/rwlock waiters. The pointer is just consuming 4/8
bytes on stack so it is provided unconditionaly to avoid #ifdeffery all
over the place.

This cannot use a wake_q because a task can have concurrent wakeups which
would make it miss either lock or the regular wakeup depending on what gets
queued first unless task struct gains a separate wake_q_node for this which
would be overkill because there can only be a single task which gets woken
up in the spin/rw_lock unlock path.

No functional change for non-RT enabled kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Switch back to the working version (Mike)
V2: Make it symmetric (PeterZ)
---
 include/linux/sched/wake_q.h    |    1 -
 kernel/locking/rtmutex.c        |   18 ++++++++++++++++--
 kernel/locking/rtmutex_common.h |    5 ++++-
 3 files changed, 20 insertions(+), 4 deletions(-)
---
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -62,5 +62,4 @@ static inline bool wake_q_empty(struct w
 extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
-
 #endif /* _LINUX_SCHED_WAKE_Q_H */
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -351,12 +351,26 @@ static __always_inline void rt_mutex_adj
 static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
 						struct rt_mutex_waiter *w)
 {
-	wake_q_add(&wqh->head, w->task);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state != TASK_NORMAL) {
+		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
+			WARN_ON_ONCE(wqh->rtlock_task);
+		get_task_struct(w->task);
+		wqh->rtlock_task = w->task;
+	} else {
+		wake_q_add(&wqh->head, w->task);
+	}
 }
 
 static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
 {
-	wake_up_q(&wqh->head);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
+		wake_up_state(wqh->rtlock_task, TASK_RTLOCK_WAIT);
+		put_task_struct(wqh->rtlock_task);
+		wqh->rtlock_task = NULL;
+	}
+
+	if (!wake_q_empty(&wqh->head))
+		wake_up_q(&wqh->head);
 
 	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
 	preempt_enable();
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -42,15 +42,18 @@ struct rt_mutex_waiter {
 /**
  * rt_wake_q_head - Wrapper around regular wake_q_head to support
  *		    "sleeping" spinlocks on RT
- * @head:	The regular wake_q_head for sleeping lock variants
+ * @head:		The regular wake_q_head for sleeping lock variants
+ * @rtlock_task:	Task pointer for RT lock (spin/rwlock) wakeups
  */
 struct rt_wake_q_head {
 	struct wake_q_head	head;
+	struct task_struct	*rtlock_task;
 };
 
 #define DEFINE_RT_WAKE_Q(name)						\
 	struct rt_wake_q_head name = {					\
 		.head		= WAKE_Q_HEAD_INITIALIZER(name.head),	\
+		.rtlock_task	= NULL,					\
 	}
 
 /*

