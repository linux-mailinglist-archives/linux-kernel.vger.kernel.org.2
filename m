Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28483C7409
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhGMQQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbhGMQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80846C0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:30 -0700 (PDT)
Message-Id: <20210713160747.601687056@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2Fhr7RO2Ug2naPvaP9QlX+DXHXcOnSHQlJKqhIoO03o=;
        b=mhbT37uJYIrb2J63iKg1F4lzVrdUZ2C+NaRPTNHZZapeqwS8YFwL6trfQKbZFxNgH4qj8b
        ldarreCLcr0ja1SRwW6nc08amTETRFMtMV+XCv9px/dJQqcc+mHvX53XQHIAGXVh/PiISX
        1w+ZO6EAXIUa/A/GNy58xKeVwjBAIHw+MS1MVMNjFMoDDU2ANdW1Zix2/FwhVW8jNvyH0t
        VF7lukI7hx+VdOnpoZrWYmt5FiuwRS3c5edBck36TgA19QGRLvzVoRgdouI0RWs5pQaRHJ
        MzDyRYXswMYnwSNRZiuBr+DpOkuvlvMG89LpGZZaOUEbdgDxOy+dltbk4W6TJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2Fhr7RO2Ug2naPvaP9QlX+DXHXcOnSHQlJKqhIoO03o=;
        b=0UFvV3SkfJqeKaOY78CgiseSWZAP6wor6Z+u75wUKHvToZzi4TQMkisQ8lHvfO/YKtldDY
        iZUmipR58H6DBjBw==
Date:   Tue, 13 Jul 2021 17:11:11 +0200
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
Subject: [patch 17/50] locking/rtmutex: Prepare RT rt_mutex_wake_q for RT locks
References: <20210713151054.700719949@linutronix.de>
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
 kernel/locking/rtmutex.c        |   16 ++++++++++++++--
 kernel/locking/rtmutex_common.h |    3 +++
 2 files changed, 17 insertions(+), 2 deletions(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -351,12 +351,24 @@ static __always_inline void rt_mutex_adj
 static __always_inline void rt_mutex_wake_q_add(struct rt_mutex_wake_q_head *wqh,
 						struct rt_mutex_waiter *w)
 {
-	wake_q_add(&wqh->head, w->task);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state != TASK_NORMAL) {
+		get_task_struct(w->task);
+		wqh->rtlock_task = w->task;
+	} else {
+		wake_q_add(&wqh->head, w->task);
+	}
 }
 
 static __always_inline void rt_mutex_wake_up_q(struct rt_mutex_wake_q_head *wqh)
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
@@ -43,14 +43,17 @@ struct rt_mutex_waiter {
  * rt_mutex_wake_q_head - Wrapper around regular wake_q_head to support
  *			  "sleeping" spinlocks on RT
  * @head:		The regular wake_q_head for sleeping lock variants
+ * @rtlock_task:	Task pointer for RT lock (spin/rwlock) wakeups
  */
 struct rt_mutex_wake_q_head {
 	struct wake_q_head	head;
+	struct task_struct	*rtlock_task;
 };
 
 #define DEFINE_RT_MUTEX_WAKE_Q_HEAD(name)				\
 	struct rt_mutex_wake_q_head name = {				\
 		.head		= WAKE_Q_HEAD_INITIALIZER(name.head),	\
+		.rtlock_task	= NULL,					\
 	}
 
 /*

