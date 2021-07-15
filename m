Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44F53C9C27
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbhGOJxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:53:32 -0400
Received: from foss.arm.com ([217.140.110.172]:50212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240295AbhGOJxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:53:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133A71042;
        Thu, 15 Jul 2021 02:50:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D67D3F694;
        Thu, 15 Jul 2021 02:50:38 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     mark.rutland@arm.com, maz@kernel.org, paulmck@kernel.org,
        peterz@infradead.org
Subject: [PATCH v3 1/2] irq: abstract irqaction handler invocation
Date:   Thu, 15 Jul 2021 10:50:30 +0100
Message-Id: <20210715095031.41922-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210715095031.41922-1-mark.rutland@arm.com>
References: <20210715095031.41922-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a few functions which invoke irqaction handlers, all of which
need to call trace_irq_handler_entry() and trace_irq_handler_exit().

In preparation for adding some additional debug logic to each irqaction
handler invocation, let's factor out this work to a helper. Where the
return value isn't consumed, the unused temporary variable is also
removed.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c      | 15 +++------------
 kernel/irq/handle.c    |  4 +---
 kernel/irq/internals.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 7f04c7d8296e..804c2791315d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -741,16 +741,13 @@ void handle_fasteoi_nmi(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
-	irqreturn_t res;
 
 	__kstat_incr_irqs_this_cpu(desc);
 
-	trace_irq_handler_entry(irq, action);
 	/*
 	 * NMIs cannot be shared, there is only one action.
 	 */
-	res = action->handler(irq, action->dev_id);
-	trace_irq_handler_exit(irq, action, res);
+	handle_irqaction(irq, action);
 
 	if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
@@ -914,7 +911,6 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
-	irqreturn_t res;
 
 	/*
 	 * PER CPU interrupts are not serialized. Do not touch
@@ -926,9 +922,7 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		chip->irq_ack(&desc->irq_data);
 
 	if (likely(action)) {
-		trace_irq_handler_entry(irq, action);
-		res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
-		trace_irq_handler_exit(irq, action, res);
+		handle_irqaction_percpu_devid(irq, action);
 	} else {
 		unsigned int cpu = smp_processor_id();
 		bool enabled = cpumask_test_cpu(cpu, desc->percpu_enabled);
@@ -957,13 +951,10 @@ void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
-	irqreturn_t res;
 
 	__kstat_incr_irqs_this_cpu(desc);
 
-	trace_irq_handler_entry(irq, action);
-	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
-	trace_irq_handler_exit(irq, action, res);
+	handle_irqaction_percpu_devid(irq, action);
 
 	if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 221d80c31e94..dbe5c9277dd7 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -152,9 +152,7 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
 		    !(action->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT)))
 			lockdep_hardirq_threaded();
 
-		trace_irq_handler_entry(irq, action);
-		res = action->handler(irq, action->dev_id);
-		trace_irq_handler_exit(irq, action, res);
+		res = handle_irqaction(irq, action);
 
 		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",
 			      irq, action->handler))
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 54363527feea..70a4694cc891 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -11,6 +11,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/sched/clock.h>
 
+#include <trace/events/irq.h>
+
 #ifdef CONFIG_SPARSE_IRQ
 # define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
 #else
@@ -107,6 +109,32 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
 
+static inline irqreturn_t __handle_irqaction(unsigned int irq,
+					     struct irqaction *action,
+					     void *dev_id)
+{
+	irqreturn_t res;
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, dev_id);
+	trace_irq_handler_exit(irq, action, res);
+
+	return res;
+}
+
+static inline irqreturn_t handle_irqaction(unsigned int irq,
+					   struct irqaction *action)
+{
+	return __handle_irqaction(irq, action, action->dev_id);
+}
+
+static inline irqreturn_t handle_irqaction_percpu_devid(unsigned int irq,
+							struct irqaction *action)
+{
+	return __handle_irqaction(irq, action,
+				  raw_cpu_ptr(action->percpu_dev_id));
+}
+
 /* Resending of interrupts :*/
 int check_irq_resend(struct irq_desc *desc, bool inject);
 bool irq_wait_for_poll(struct irq_desc *desc);
-- 
2.11.0

