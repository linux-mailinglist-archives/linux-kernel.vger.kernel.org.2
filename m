Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D121E3DBA45
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbhG3OU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:20:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55584 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbhG3ORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:32 -0400
Message-ID: <20210730135206.301477338@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8IVT82AeJWY0RxlKDGWc7VOoP+02IvCgg5Oih1Rk2hc=;
        b=unK2lJDtadGjWrih7vbr4WvG6Q8aBxTFsvuSqmmprHLbKBQi0lPK0x0JiGl3Uk8sPHFXI1
        Lfua5Fn8XucWWGabC/69HDRP8W8w8NMEO3eVh7YXGscgRLfN5S5N3isyB2Ra9dgKkWn7ft
        sidyF04kMcpCJB7wuqcWuId+oCFMxyqkRxRG2IbWzxa+vxstoFPNKxgMQGajilrQlL41xj
        ZfhvKTOHch4dHOnDoQbIdxmOdu+0qhlGltTVj7MKW0DstydO1shbGvDWElTyEFU2eWgtKD
        gCeCPRem7TRh0x70wSKY/Ce1ViIPJf0O2upslCC0EtHXpp3/ND3WwizcKBCOBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8IVT82AeJWY0RxlKDGWc7VOoP+02IvCgg5Oih1Rk2hc=;
        b=42BsIyOPFvCs5cN46S6Ph+dDTJBCwcHI7Mel80hlLuZvwwuUEDJ7Qlbwg155mZEtCvZWPy
        e26vH2/HmPyG27Cw==
Date:   Fri, 30 Jul 2021 15:50:27 +0200
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
Subject: [patch 20/63] locking/rtmutex: Prepare RT rt_mutex_wake_q for RT locks
References: <20210730135007.155909613@linutronix.de>
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

No functional change for non-RT enabled kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Make it symmetric (PeterZ)
---
 include/linux/sched/wake_q.h    |    7 ++++++-
 kernel/locking/rtmutex.c        |   12 ++++++++++--
 kernel/locking/rtmutex_common.h |    3 +++
 kernel/sched/core.c             |    4 ++--
 4 files changed, 21 insertions(+), 5 deletions(-)
---
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -61,6 +61,11 @@ static inline bool wake_q_empty(struct w
 
 extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
-extern void wake_up_q(struct wake_q_head *head);
+extern void __wake_up_q(struct wake_q_head *head, unsigned int state);
+
+static inline void wake_up_q(struct wake_q_head *head)
+{
+	__wake_up_q(head, TASK_NORMAL);
+}
 
 #endif /* _LINUX_SCHED_WAKE_Q_H */
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -351,12 +351,20 @@ static __always_inline void rt_mutex_adj
 static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
 						struct rt_mutex_waiter *w)
 {
-	wake_q_add(&wqh->head, w->task);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state != TASK_NORMAL) {
+		wake_q_add(&wqh->rt_head, w->task);
+	} else {
+		wake_q_add(&wqh->head, w->task);
+	}
 }
 
 static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
 {
-	wake_up_q(&wqh->head);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !wake_q_empty(&wqh->rt_head))
+		__wake_up_q(&wqh->rt_head, TASK_RTLOCK_WAIT);
+
+	if (!wake_q_empty(&wqh->head))
+		wake_up_q(&wqh->head);
 
 	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
 	preempt_enable();
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -43,14 +43,17 @@ struct rt_mutex_waiter {
  * rt_wake_q_head - Wrapper around regular wake_q_head to support
  *		    "sleeping" spinlocks on RT
  * @head:	The regular wake_q_head for sleeping lock variants
+ * @rt_head:	The wake_q_head for RT lock (spin/rwlock) variants
  */
 struct rt_wake_q_head {
 	struct wake_q_head	head;
+	struct wake_q_head	rt_head;
 };
 
 #define DEFINE_RT_WAKE_Q(name)						\
 	struct rt_wake_q_head name = {					\
 		.head		= WAKE_Q_HEAD_INITIALIZER(name.head),	\
+		.rt_head	= WAKE_Q_HEAD_INITIALIZER(name.rt_head),\
 	}
 
 /*
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -916,7 +916,7 @@ void wake_q_add_safe(struct wake_q_head
 		put_task_struct(task);
 }
 
-void wake_up_q(struct wake_q_head *head)
+void __wake_up_q(struct wake_q_head *head, unsigned int state)
 {
 	struct wake_q_node *node = head->first;
 
@@ -932,7 +932,7 @@ void wake_up_q(struct wake_q_head *head)
 		 * wake_up_process() executes a full barrier, which pairs with
 		 * the queueing in wake_q_add() so as not to miss wakeups.
 		 */
-		wake_up_process(task);
+		wake_up_state(task, state);
 		put_task_struct(task);
 	}
 }

