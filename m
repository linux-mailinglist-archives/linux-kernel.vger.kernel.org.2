Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA03DBA44
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbhG3OUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:20:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbhG3ORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:31 -0400
Message-ID: <20210730135206.188262987@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kPHQSdoRDDQ+gtY5Ph5Qk1JzSjWNCTU5piibPZKDGHI=;
        b=xGNU71IP7NIZf+EnrHmdo3o8REY3Z60k07Ueu1b9HdLeeW6NE2wAZYsI6/tQTpPStjqV12
        O28DTP2nTduh372kvruhqCwPY/be1tXRffe4kvxvoSdEzx6gPZ/O+UgKUi2HWhAqDIxaDF
        scFuws6ler7jY4tan9LO+ShwMrM12xbRIz8OEqNVwyZd9GA+cdZMik1hNSd1Y2YbMfLHFx
        CJ9g5NrzstIe1mBYxGZTkOu39uCQlo8RreiS8OFxYdcNvX0Oc+tl4fJfYrfGqjd4HK+crW
        5w7NlQCO1eTKcNxTFcmmd/jgrc/NV9GHo9hPExmE/bWrIya7VZTY0Kvehcxsng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kPHQSdoRDDQ+gtY5Ph5Qk1JzSjWNCTU5piibPZKDGHI=;
        b=iwWfc4BPcPngQnBNalJBqeKpPA/i9RoSNUnTiOOxJApzQajHOfTj3nM/4dGvHuiDI4LadE
        AeVwtvwERx1npiBA==
Date:   Fri, 30 Jul 2021 15:50:25 +0200
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
Subject: [patch 18/63] locking/rtmutex: Provide rt_wake_q and helpers
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

To handle the difference of wakeups for regular sleeping locks (mutex,
rtmutex, rw_semaphore) and the wakeups for 'sleeping' spin/rwlocks on
PREEMPT_RT enabled kernels correctly, it is required to provide a
wake_q construct which allows to keep them seperate.

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

