Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5023ECB2F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhHOVa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhHOV2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577E0C061796
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:13 -0700 (PDT)
Message-ID: <20210815211303.253614678@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+YnMRjsnxk84Or/H+2smifp2SyRHTm7IycMX/nyQ9U0=;
        b=p1bJZceizZAuQOIDEAf1H37lFi7qN4+oePUltuHgUAULOZB3eMqV2FIvwVtY3Ind5O+8Kb
        5/EBA6gwRSaHOcLYaJM+lMfT2KAw28V1X98BG/OgnvbI5MWQYwg/L8chlD9vpqfkr0jzqN
        GtfRzCXx6YhkWzECBmD2hBvaQmoo2TIUUacXiRg1KQGEQbF+pecSIpN++lnY2Z/IYXQ3Qy
        GOJHeOWhx4dDcFwrQzJTBhWfxg88g7Ki9tFU1gGLbVyVKXkN51O1sE0JoyiP4xmClf6Dl7
        zRSt92DV0Q3hGIzH4mckhb0qrchsdZNyODKVlroc84tmIyaajMjTljXWvgkSnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+YnMRjsnxk84Or/H+2smifp2SyRHTm7IycMX/nyQ9U0=;
        b=lwHIGxp/I9FwYFMHGrcpKL+HuI7iz+nGEINPNsTOI8uzo4NKugAR38eHDq1DW2dCsC4rW5
        xs9JaVSG7WpcyEDQ==
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
Subject: [patch V5 23/72] locking/rtmutex: Prepare RT rt_mutex_wake_q for RT locks
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:11 +0200 (CEST)
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

