Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1062B3C7407
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhGMQQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54312 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhGMQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:17 -0400
Message-Id: <20210713160747.414120167@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Et7qRP3zCJtmBwbP66EDpqfwa9jwm97vtvatyq28C08=;
        b=UJNZR9l0ZIA+Ov5dQc85QN0K619+9VNRcFSh2VYenSMPhQOAjpLvBV7SC4YMtnML7L3ONG
        fhSeIPTUJzFD4SV5grOqBZLq9EoACn4ZA5bHp8ZCs3V3F+hmVpymC79mkoOKronaos0v3d
        MbfnxHadvYmpql21M+O4CAZEY3gFx8zxr+Abo5RUFbr5k9U45hdwZhzrC5+bgdoTn/Qsfl
        Lfkl8EPBIjbRU/06TtDCgJwjNPVEcu3klLQg9KtQslTSMXdJvXVWR7zp+c14qanSh7hTjF
        D2MP4UKe0X345FqhGk5usdrx7ZY9Ifq/U5Hf91GgIhlOfc51B4fz5euGkMlziQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Et7qRP3zCJtmBwbP66EDpqfwa9jwm97vtvatyq28C08=;
        b=pWmU5j2KdbejKzAiEd9hTGLO6P7tC+usmabz/2jly/jmAO+3ApwaiM4EiKkOPoDliR/NWo
        FmrHPVortyKVt+Dg==
Date:   Tue, 13 Jul 2021 17:11:09 +0200
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
Subject: [patch 15/50] locking/rtmutex: Provide rt_mutex_wake_q and helpers
References: <20210713151054.700719949@linutronix.de>
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
 kernel/locking/rtmutex.c        | 15 +++++++++++++++
 kernel/locking/rtmutex_common.h | 14 ++++++++++++++
 2 files changed, 29 insertions(+)
---
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2aaf3bfc1052..db3103e2733b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -347,6 +347,21 @@ static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
 	rt_mutex_setprio(p, pi_task);
 }
 
+/* RT mutex specific wake_q wrappers */
+static __always_inline void rt_mutex_wake_q_add(struct rt_mutex_wake_q_head *wqh,
+						struct rt_mutex_waiter *w)
+{
+	wake_q_add(&wqh->head, w->task);
+}
+
+static __always_inline void rt_mutex_wake_up_q(struct rt_mutex_wake_q_head *wqh)
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
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index dbd261911fdc..b1ea7fe88546 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -39,6 +39,20 @@ struct rt_mutex_waiter {
 	u64			deadline;
 };
 
+/**
+ * rt_mutex_wake_q_head - Wrapper around regular wake_q_head to support
+ *			  "sleeping" spinlocks on RT
+ * @head:		The regular wake_q_head for sleeping lock variants
+ */
+struct rt_mutex_wake_q_head {
+	struct wake_q_head	head;
+};
+
+#define DEFINE_RT_MUTEX_WAKE_Q_HEAD(name)				\
+	struct rt_mutex_wake_q_head name = {				\
+		.head		= WAKE_Q_HEAD_INITIALIZER(name.head),	\
+	}
+
 /*
  * PI-futex support (proxy locking functions, etc.):
  */

