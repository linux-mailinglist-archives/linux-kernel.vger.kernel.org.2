Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33010423C85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhJFLVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:21:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57684 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbhJFLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:20:52 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633519138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1c+mt9Nk63OaX4OMSEWkc1KvDz8pF4SDlnSH3o4hh0Y=;
        b=RaDQSYUtH+/evYc5lEqyrGO2iIU53jnDrNaCeDs6Uwn2yejK/oXOiliOijqaru2pcmgaTQ
        MpLP9kdqlOXR3N6zYLET/+fdtDp5sbE++LRbFrSvQec0MWKLMBEc7hHrri71AvpDPy4Lg6
        I91eKQyiQmrkdljT0HUcAZw4Fw+zNdH6KxHwpqTyKtNO/qTlr01t/2xzFNh7cyJsqT6BIK
        oqexzNKFupRxdPmXcOxmXBuoBw0ucrs2t0HUbgb69AtLko6QButM/Q9TJx044eRnU+e72t
        uibPfPE4ARircADikvO+yrvM1lWDS39/7WiLyrIZol41G6hnODt7q137Y0y3IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633519138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1c+mt9Nk63OaX4OMSEWkc1KvDz8pF4SDlnSH3o4hh0Y=;
        b=Andb3sBOMuXbdUCfvsm48yQEUGfsBpP4dkPOtDlnVavFEueAOUUk+OdbHgG8RdLvfzdVI8
        jbxuWpNgc0MsLkBQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 4/4] irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT
Date:   Wed,  6 Oct 2021 13:18:52 +0200
Message-Id: <20211006111852.1514359-5-bigeasy@linutronix.de>
In-Reply-To: <20211006111852.1514359-1-bigeasy@linutronix.de>
References: <20211006111852.1514359-1-bigeasy@linutronix.de>
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
index b48955e9c920e..8cd11a2232605 100644
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
index daa5d12522faa..1833f9e23f224 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -214,7 +214,8 @@ void irq_work_single(void *arg)
 	 */
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
=20
-	if (!arch_irq_work_has_interrupt())
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt())
 		rcuwait_wake_up(&work->irqwait);
 }
=20
@@ -274,7 +275,8 @@ void irq_work_sync(struct irq_work *work)
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

