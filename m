Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8683E185E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbhHEPmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:42:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbhHEPlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:49 -0400
Message-ID: <20210805153953.917392120@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jSpY2/0k40vuDP6cQhKEu+/zYRsaaKqMHEu7iiXO1UA=;
        b=ALhqNOAjRyppCltRc36XpXqpH8ZhkeBIM6SmFEW+Mg8horhABP2VmDDwbJDv8aT907czfB
        GrPMLr2DwnWV/4ZS4CUSFP85qNcJy78zQ5ryIZ40LYXB7Rvw+EARJn1JiFPDlq5mL/cR1S
        vnxohqPQkH/bCgTfaCh9FsG8l6wR7JwJrlnEV+jGFsf6aceiqZQYhw6I31xnMz+To2MZcu
        Tm2LGpOlLIiQh34MCXm6qPyf585mty5B82Y4Da/S4v2lxTcbuyu5PDn3qr9J1tLckLxEhY
        ++G+WgeO3Grz0CHP9dBjGUn7OoQM7x29JooEtda25IIixL/zawGEzK1la36dXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jSpY2/0k40vuDP6cQhKEu+/zYRsaaKqMHEu7iiXO1UA=;
        b=hVR78O3fHNB2HJDrNFba43CyD/RhHJL87Boh0HKD2KznDvVOzbg5+6nAGpTogclnri+g0O
        WCANPoWnwI92aBDg==
Date:   Thu, 05 Aug 2021 17:13:19 +0200
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
Subject: [patch V3 19/64] locking/rtmutex: Provide rt_wake_q and helpers
References: <20210805151300.330412127@linutronix.de>
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

