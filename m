Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF53ECB2E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhHOVaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhHOV2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C1AC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:10 -0700 (PDT)
Message-ID: <20210815211303.139337655@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jSpY2/0k40vuDP6cQhKEu+/zYRsaaKqMHEu7iiXO1UA=;
        b=2ajV53NE60n6FgquiKewo/wjciphagkBxrOY40u6+etxa1tANtzbu8ZZpf/rNUu59M7vHi
        QYFUAZqVs2RpgZo47x7J2HfHOf116xGwe6p9wec1p9H65Ijfji8w7Lr4uzAXKvbgU7JPqN
        W2/TVN1R9Er/TDkGyXdcZwKpFqRpGHvJn8QlTO5ViMZ+0XEBZocU44ixGdNvF6p9e3Meh0
        tbbIry/1smw0HPwrHIj1EO7Br/Er4W4Pu4fYf1PUZxX3yhrc0atvX3PPJczfAnvBdlSHMn
        XqFeogoqYW0R+ap7L5icz11ZGqTFJi/pOxBHsgIUNukObMQpCxEI8ANJ88V5eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jSpY2/0k40vuDP6cQhKEu+/zYRsaaKqMHEu7iiXO1UA=;
        b=gfZGnuMZOXr1VSqw2mWZ8l1kmO2mh4APybmI0whpQ4+mPeWd4JFF8BeN32ICJXjhLv+Rl9
        lXTVGJCpbv3OfWDw==
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
Subject: [patch V5 21/72] locking/rtmutex: Provide rt_wake_q and helpers
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:08 +0200 (CEST)
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

