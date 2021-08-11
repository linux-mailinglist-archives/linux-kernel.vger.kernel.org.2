Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D3B3E90C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbhHKMZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:25:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbhHKMXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:21 -0400
Message-ID: <20210811121415.403149201@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+YnMRjsnxk84Or/H+2smifp2SyRHTm7IycMX/nyQ9U0=;
        b=TsO4JhqrNlsL4MUYiCt3CA5XnD8n74sOfKmp5/ECXE9oy6BmWlDTjli+ogccXlxGAwilT8
        pxQeK227/q473wp/bF3yHUFqplTk3rOtsJI+FuLPtNGB053ZCWYMONfEoWNa8Ox+q7QLa7
        Hqi5tgxS0JPgclIEcAEg17Ut9DGaXvErsvUZ7eCjxv8CoOUVBY4V6gBQlwEYUbYRgRlPWa
        /0ujDo0mhVuCAjw4s5abEiRS2M+y5mvCzMwuOfNypNvYcny7wgEAd5deJ81PY2PSM6GPbT
        K50V9s8dt5qZaTZj5rA7Q7qtNRlS2c8FuKMdd+CEfiGKSHlp/SpZzaqfFI/eIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+YnMRjsnxk84Or/H+2smifp2SyRHTm7IycMX/nyQ9U0=;
        b=eO4Yterc9XzVBiobmi+pJtXtV/xMsDJE4Pe87Ef7p48WoeDrHiciUADnO/L+u9x/+41kse
        dyC2IOAn22qLpEAQ==
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
Subject: [patch V4 21/68] locking/rtmutex: Prepare RT rt_mutex_wake_q for RT locks
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:56 +0200 (CEST)
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

