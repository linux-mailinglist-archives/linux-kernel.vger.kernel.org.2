Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A20341A149
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhI0VVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:21:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59366 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbhI0VVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:21:10 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632777571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOphbVXyeyHT1cXLKNnJcfPWN/xniqA3xlB+knbq3Ek=;
        b=CrEpiclvQr6zrklTskeqfOdSixxQfRt7xaPr1CMnFD1OC4TRU3IHFQmzJCsQ8lxQRFRLQb
        HR7EU4DsEVKEOoEVmR3v1F46zOqSEwf0auRyc7ZDok8g5FtxvXnMM3FwknWfXqsT4z+tvt
        bx9SlnHl+luEjFmOBbyVh3w+5jW4KhFQh1I1eDI/ygIVXZ9cf4H/bpTO9dAljsm/i+yLuW
        NN/39g6I0Wtn8r7zRVhzyxBrYpWMMxoHwEF9lXzqlrU3W8AtRwBsLy/jlsFZHi2SuP0wvA
        RomsRnvltd+Pq1MGWJD/IW4k3l4J3LBg64hKqaTjPivce/ytv9M0aKHXPupJOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632777571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOphbVXyeyHT1cXLKNnJcfPWN/xniqA3xlB+knbq3Ek=;
        b=guwHTHNbkxAsdbOochZ4d9ZupJM6dHp5+8aXBDIgQ3Vce6/IYQRax8JyPeCA2ZmzRU4dj5
        1EwvUT2lerVC+HBw==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/5] irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT
Date:   Mon, 27 Sep 2021 23:19:19 +0200
Message-Id: <20210927211919.310855-6-bigeasy@linutronix.de>
In-Reply-To: <20210927211919.310855-1-bigeasy@linutronix.de>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PREEMPT_RT most items are processed as LAZY via softirq context.
Avoid to spin-wait for them because irq_work_sync() could have higher
priority and not allow the irq-work to be completed.

Wait additionally for !IRQ_WORK_HARD_IRQ irq_work items on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irq_work.h | 5 +++++
 kernel/irq_work.c        | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index d65e34c8d0fd9..3ae8ba3fad3af 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -49,6 +49,11 @@ static inline bool irq_work_is_busy(struct irq_work *wor=
k)
 	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
 }
=20
+static inline bool irq_work_is_hard(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ;
+}
+
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
=20
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 55c4206b3ad6f..ee27f56381ee2 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -181,7 +181,8 @@ void irq_work_single(void *arg)
 	 */
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
=20
-	if (!arch_irq_work_has_interrupt())
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt())
 		rcuwait_wake_up(&work->irqwait);
 }
=20
@@ -245,7 +246,8 @@ void irq_work_sync(struct irq_work *work)
 	lockdep_assert_irqs_enabled();
 	might_sleep();
=20
-	if (!arch_irq_work_has_interrupt()) {
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt()) {
 		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
 				   TASK_UNINTERRUPTIBLE);
 		return;
--=20
2.33.0

