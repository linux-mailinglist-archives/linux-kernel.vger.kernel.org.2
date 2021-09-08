Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F3D403F35
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350215AbhIHSsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbhIHSr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:47:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3B0C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 11:46:51 -0700 (PDT)
Date:   Wed, 8 Sep 2021 20:46:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631126808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Vf0Lc8mnIKLwR/Lr8BCHiWHVstsT7vDJr5snnT+dWgY=;
        b=zN6WZNthk4NkJRCJ6LE81Y2keUOJgkxB3Flm6MjVHgSbA18ynUq/tzNmQaK0x0ngdy2ACR
        VQ7cqgjrNLLmUX2jJQI1oUbt64eQ/Vm3JMYweHgKyPPkDwC1q60itXdu4jGkYdOy9KC4pJ
        LrfSWgSwIcQXn5nn/vP1FhlmxYbZvwJccHSI/XMGD76kpHY2PUMAPwcq1O0oqxq6qoJUxB
        GrtlZMf34H9XC+c5NGG264Ngbp+rJ1NG3L/Pkmm0osQDH45PoZDM7Rt9Ql9LTIu5Pk5Hef
        rlbyLcvISYmvfgsJ22GNLh/MbQfwilvO7RCdsiT01Mlgx+Nh4CMSAO0D9oNX9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631126808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Vf0Lc8mnIKLwR/Lr8BCHiWHVstsT7vDJr5snnT+dWgY=;
        b=35Gh5+w61BI/OrZGXhvs9QR/86GsUluAsf+7Eycb9RJr5xrsDPxsmfTtTjd/LXZ2OZABCb
        nL3R6RDtyPfnfMDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH] irq_work: Allow irq_work_sync() to sleep if irq_work() no
 IRQ support.
Message-ID: <20210908184646.o2mj4izebqwm6igq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Let irq_work_sync() synchornize with rcuwait if the architecture
processes irqwork via the timer tick.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irq_work.h |  3 +++
 kernel/irq_work.c        | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index dbbef90897895..d65e34c8d0fd9 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -3,6 +3,7 @@
 #define _LINUX_IRQ_WORK_H
 
 #include <linux/smp_types.h>
+#include <linux/rcuwait.h>
 
 /*
  * An entry can be in one of four states:
@@ -16,11 +17,13 @@
 struct irq_work {
 	struct __call_single_node node;
 	void (*func)(struct irq_work *);
+	struct rcuwait irqwait;
 };
 
 #define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
 	.node = { .u_flags = (_flags), },			\
 	.func = (_func),					\
+	.irqwait = __RCUWAIT_INITIALIZER(irqwait),		\
 }
 
 #define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 0ec825dbe9f05..dbd2b3b423365 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -181,6 +181,9 @@ void irq_work_single(void *arg)
 	 * else claimed it meanwhile.
 	 */
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
+
+	if (!arch_irq_work_has_interrupt())
+		rcuwait_wake_up(&work->irqwait);
 }
 
 static void irq_work_run_list(struct llist_head *list)
@@ -247,6 +250,13 @@ void irq_work_tick_soft(void)
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
 
 	while (irq_work_is_busy(work))
 		cpu_relax();
-- 
2.33.0

