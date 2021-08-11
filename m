Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE0E3E90B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhHKMY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbhHKMXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5F7C061385
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:22:55 -0700 (PDT)
Message-ID: <20210811121415.281128316@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jSpY2/0k40vuDP6cQhKEu+/zYRsaaKqMHEu7iiXO1UA=;
        b=qSofjjp/VVTcnh415yZLQvY/s69+C6JHI7m78uMYLipocpraBalOqXJ0CSwq9LOiOtfn2O
        wnXXvufeOKJosIw5Clky/VOWqL97/Im2gR0WD8q+ldvaS2zKDdhZgkYnULis5+R/F5aU8e
        Hh7Y4Cl41mNo3igElPV8yqk90Bct11gJbX+T2mvy0CTf5yVogvjif8fwIZJj8k8+bfU3AJ
        SqoYndOIH1K5sK6g0jJEQEeElJW6iMWmhwN864Ml/YF1inusGjDLyNE6CumQgwJRI9jSOu
        rx9Z66WRkXQXQsmZH+tVpKATnzAiU2iQkH9+CeuEqUko6Tn9WhXItXfLzQbPDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jSpY2/0k40vuDP6cQhKEu+/zYRsaaKqMHEu7iiXO1UA=;
        b=GZiM0qyHV2G8l1KnRyCtp/1WdGiosmqlP7YoK3DHTGUVPQe8/OifByvf/oyOo0akbtAL36
        F1p18baazK9L0ABA==
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
Subject: [patch V4 19/68] locking/rtmutex: Provide rt_wake_q and helpers
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:54 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

To handle the difference of wakeups for regular sleeping locks (mutex,
rtmutex, rw_semaphore) and the wakeups for 'sleeping' spin/rwlocks on
PREEMPT_RT enabled kernels correctly, it is required to provide a
wake_q construct which allows to keep them separate.

Provide a wrapper around wake_q and the required helpers, which will be
extended with the state handling later.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Rename according to PeterZ
---
 kernel/locking/rtmutex.c        |   15 +++++++++++++++
 kernel/locking/rtmutex_common.h |   14 ++++++++++++++
 2 files changed, 29 insertions(+)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -347,6 +347,21 @@ static __always_inline void rt_mutex_adj
 	rt_mutex_setprio(p, pi_task);
 }
 
+/* RT mutex specific wake_q wrappers */
+static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
+						struct rt_mutex_waiter *w)
+{
+	wake_q_add(&wqh->head, w->task);
+}
+
+static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
+{
+	wake_up_q(&wqh->head);
+
+	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
+	preempt_enable();
+}
+
 /*
  * Deadlock detection is conditional:
  *
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -39,6 +39,20 @@ struct rt_mutex_waiter {
 	u64			deadline;
 };
 
+/**
+ * rt_wake_q_head - Wrapper around regular wake_q_head to support
+ *		    "sleeping" spinlocks on RT
+ * @head:	The regular wake_q_head for sleeping lock variants
+ */
+struct rt_wake_q_head {
+	struct wake_q_head	head;
+};
+
+#define DEFINE_RT_WAKE_Q(name)						\
+	struct rt_wake_q_head name = {					\
+		.head		= WAKE_Q_HEAD_INITIALIZER(name.head),	\
+	}
+
 /*
  * PI-futex support (proxy locking functions, etc.):
  */

