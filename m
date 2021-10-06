Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70565423C83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbhJFLVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbhJFLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:20:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC8AC061760
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 04:19:00 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633519137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWlP05vTdXrgx690tmJEWR6jiTgZ7aKq/O1XxxTStbo=;
        b=s8dAjqcm4gidLrd47qWCTXXbx7wY5HMCpo1GBLU6Gq9HDViUoSfsQCPnouHtxBir3oXI0M
        lC0KTHbRP8ZVvzblG6B7RRmwCaj8MQ54CKNIpcTM7l12FrHesDQux0KodtjnNVvuHBdVlc
        tMaci4hV0UDhphZPtTj+tkVUFGMAjjkvxnHCh2g6e1AFPVme9IAJD/JDhVENjtAxO3jMWe
        oht4JeNFR8BbgtXuQbfgNR8q0GE8VwY+2HNQN5dBFF24WuLyYDnvibfdNTTBUTzDCpyP/h
        RXsqMZFStoxpt52Qpdd/4BKwcgRVm3REKH5dY2IIJq8n6+ZdRJN81CTtS7na/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633519137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWlP05vTdXrgx690tmJEWR6jiTgZ7aKq/O1XxxTStbo=;
        b=DNVqPT9bOLyl/9w+CzUnYBLAb6sY2EJQIi9ZRwu7Vu8E7Haj3zMoqCKfJ2BvKrEFsLiH+l
        wb5IS7HZ1OBXJvCA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/4] irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.
Date:   Wed,  6 Oct 2021 13:18:50 +0200
Message-Id: <20211006111852.1514359-3-bigeasy@linutronix.de>
In-Reply-To: <20211006111852.1514359-1-bigeasy@linutronix.de>
References: <20211006111852.1514359-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_work() triggers instantly an interrupt if supported by the
architecture. Otherwise the work will be processed on the next timer
tick. In worst case irq_work_sync() could spin up to a jiffy.

irq_work_sync() is usually used in tear down context which is fully
preemptible. Based on review irq_work_sync() is invoked from preemptible
context and there is one waiter at a time. This qualifies it to use
rcuwait for synchronisation.

Let irq_work_sync() synchronize with rcuwait if the architecture
processes irqwork via the timer tick.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irq_work.h |  3 +++
 kernel/irq_work.c        | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index ec2a47a81e423..b48955e9c920e 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -3,6 +3,7 @@
 #define _LINUX_IRQ_WORK_H
=20
 #include <linux/smp_types.h>
+#include <linux/rcuwait.h>
=20
 /*
  * An entry can be in one of four states:
@@ -16,11 +17,13 @@
 struct irq_work {
 	struct __call_single_node node;
 	void (*func)(struct irq_work *);
+	struct rcuwait irqwait;
 };
=20
 #define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
 	.node =3D { .u_flags =3D (_flags), },			\
 	.func =3D (_func),					\
+	.irqwait =3D __RCUWAIT_INITIALIZER(irqwait),		\
 }
=20
 #define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index db8c248ebc8c8..e789beda8297d 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -160,6 +160,9 @@ void irq_work_single(void *arg)
 	 * else claimed it meanwhile.
 	 */
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
+
+	if (!arch_irq_work_has_interrupt())
+		rcuwait_wake_up(&work->irqwait);
 }
=20
 static void irq_work_run_list(struct llist_head *list)
@@ -204,6 +207,13 @@ void irq_work_tick(void)
 void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
+	might_sleep();
+
+	if (!arch_irq_work_has_interrupt()) {
+		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
+				   TASK_UNINTERRUPTIBLE);
+		return;
+	}
=20
 	while (irq_work_is_busy(work))
 		cpu_relax();
--=20
2.33.0

