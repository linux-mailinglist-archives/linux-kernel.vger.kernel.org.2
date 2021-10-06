Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585F4423C87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhJFLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:21:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57678 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbhJFLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:20:52 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633519138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWU/CJzOfqO5RX4U88SMqj8kQgNPE1iR1ydpvZrvtyI=;
        b=DfFAFgMgVTSsxd1NMOBwkgiYZfxDH0m/ttULYeST3V5n7SN1yf8s1yYtHk847KbPoMY0i+
        NtHF6x3tTd1coysOHdd2Z5InLcvRWA+TX5y3FX9n4Ml8fRyP0yVyl/1r8b4yZlcfLXmOpG
        44nam6aPu5SUvleHlLhDQepT+67MvHiCvVgiQgOhu1OewAaPCKbGorgk/SToYGaHun6x8w
        7o8BKaTL/xy0wemiWhORBqiE3JsiBFfBYUuAkNpHWCRw9yt9EDhm94xmaq+3ugoCLkY1zu
        UZbDwEfDLeyn8NIzt8zmbHFt1aNMFdHw/m/UndV/XIWyZx/3clQ7BCpzsF7hxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633519138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWU/CJzOfqO5RX4U88SMqj8kQgNPE1iR1ydpvZrvtyI=;
        b=0Wbbc5BwUvCaoq/6AkbG2WsfYiVuLSro5xSyGNa5hLbGfGebThxy6mDNaQoV5MN/zejhdG
        alRS7ZJhh3vgv2CQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/4] irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT
Date:   Wed,  6 Oct 2021 13:18:51 +0200
Message-Id: <20211006111852.1514359-4-bigeasy@linutronix.de>
In-Reply-To: <20211006111852.1514359-1-bigeasy@linutronix.de>
References: <20211006111852.1514359-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_work callback is invoked in hard IRQ context. By default all
callbacks are scheduled for invocation right away (given supported by
the architecture) except for the ones marked IRQ_WORK_LAZY which are
delayed until the next timer-tick.

While looking over the callbacks, some of them may acquire locks
(spinlock_t, rwlock_t) which are transformed into sleeping locks on
PREEMPT_RT and must not be acquired in hard IRQ context.
Changing the locks into locks which could be acquired in this context
will lead to other problems such as increased latencies if everything
in the chain has IRQ-off locks. This will not solve all the issues as
one callback has been noticed which invoked kref_put() and its callback
invokes kfree() and this can not be invoked in hardirq context.

Some callbacks are required to be invoked in hardirq context even on
PREEMPT_RT to work properly. This includes for instance the NO_HZ
callback which needs to be able to observe the idle context.

The callbacks which require to be run in hardirq have already been
marked. Use this information to split the callbacks onto the two lists
on PREEMPT_RT:
- lazy_list
  Work items which are not marked with IRQ_WORK_HARD_IRQ will be added
  to this list. Callbacks on this list will be invoked from a per-CPU
  thread.
  The handler here may acquire sleeping locks such as spinlock_t and
  invoke kfree().

- raised_list
  Work items which are marked with IRQ_WORK_HARD_IRQ will be added to
  this list. They will be invoked in hardirq context and must not
  acquire any sleeping locks.

The wake up of the per-CPU thread occurs from irq_work handler/
hardirq context. The thread runs with lowest RT priority to ensure it
runs before any SCHED_OTHER tasks do.

[bigeasy: melt tglx's irq_work_tick_soft() which splits irq_work_tick() int=
o a
	  hard and soft variant. Collected fixes over time from Steven
	  Rostedt and Mike Galbraith. Move to per-CPU threads instead of
	  softirq as suggested by PeterZ.]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/irq_work.c | 117 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 104 insertions(+), 13 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index e789beda8297d..daa5d12522faa 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -18,11 +18,34 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/smpboot.h>
 #include <asm/processor.h>
 #include <linux/kasan.h>
=20
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
+static DEFINE_PER_CPU(struct task_struct *, irq_workd);
+
+static void wake_irq_workd(void)
+{
+	struct task_struct *tsk =3D __this_cpu_read(irq_workd);
+
+	if (!llist_empty(this_cpu_ptr(&lazy_list)) && tsk)
+		wake_up_process(tsk);
+}
+
+static void irq_work_wake(struct irq_work *entry)
+{
+	wake_irq_workd();
+}
+
+static DEFINE_PER_CPU(struct irq_work, irq_work_pending) =3D
+	IRQ_WORK_INIT_HARD(irq_work_wake);
+
+static int irq_workd_should_run(unsigned int cpu)
+{
+	return !llist_empty(this_cpu_ptr(&lazy_list));
+}
=20
 /*
  * Claim the entry so that no one else will poke at it.
@@ -52,15 +75,29 @@ void __weak arch_irq_work_raise(void)
 /* Enqueue on current CPU, work must already be claimed and preempt disabl=
ed */
 static void __irq_work_queue_local(struct irq_work *work)
 {
+	struct llist_head *list;
+	bool rt_lazy_work =3D false;
+	bool lazy_work =3D false;
+	int work_flags;
+
+	work_flags =3D atomic_read(&work->node.a_flags);
+	if (work_flags & IRQ_WORK_LAZY)
+		lazy_work =3D true;
+	else if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		 !(work_flags & IRQ_WORK_HARD_IRQ))
+		rt_lazy_work =3D true;
+
+	if (lazy_work || rt_lazy_work)
+		list =3D this_cpu_ptr(&lazy_list);
+	else
+		list =3D this_cpu_ptr(&raised_list);
+
+	if (!llist_add(&work->node.llist, list))
+		return;
+
 	/* If the work is "lazy", handle it from next tick if any */
-	if (atomic_read(&work->node.a_flags) & IRQ_WORK_LAZY) {
-		if (llist_add(&work->node.llist, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->node.llist, this_cpu_ptr(&raised_list)))
-			arch_irq_work_raise();
-	}
+	if (!lazy_work || tick_nohz_tick_stopped())
+		arch_irq_work_raise();
 }
=20
 /* Enqueue the irq work @work on the current CPU */
@@ -104,7 +141,24 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (cpu !=3D smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
-		__smp_call_single_queue(cpu, &work->node.llist);
+
+		/*
+		 * On PREEMPT_RT the items which are not marked as
+		 * IRQ_WORK_HARD_IRQ are added to the lazy list and a HARD work
+		 * item is used on the remote CPU to wake the thread.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		    !(atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ) &&
+		    llist_add(&work->node.llist, &per_cpu(lazy_list, cpu))) {
+			struct irq_work *wake_work;
+
+			wake_work =3D &per_cpu(irq_work_pending, cpu);
+			if (irq_work_claim(wake_work))
+				__smp_call_single_queue(cpu,
+							&wake_work->node.llist);
+		} else {
+			__smp_call_single_queue(cpu, &work->node.llist);
+		}
 	} else {
 		__irq_work_queue_local(work);
 	}
@@ -114,7 +168,6 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 #endif /* CONFIG_SMP */
 }
=20
-
 bool irq_work_needs_cpu(void)
 {
 	struct llist_head *raised, *lazy;
@@ -170,7 +223,12 @@ static void irq_work_run_list(struct llist_head *list)
 	struct irq_work *work, *tmp;
 	struct llist_node *llnode;
=20
-	BUG_ON(!irqs_disabled());
+	/*
+	 * On PREEMPT_RT IRQ-work which is not marked as HARD will be processed
+	 * in a per-CPU thread in preemptible context. Only the items which are
+	 * marked as IRQ_WORK_HARD_IRQ will be processed in hardirq context.
+	 */
+	BUG_ON(!irqs_disabled() && !IS_ENABLED(CONFIG_PREEMPT_RT));
=20
 	if (llist_empty(list))
 		return;
@@ -187,7 +245,10 @@ static void irq_work_run_list(struct llist_head *list)
 void irq_work_run(void)
 {
 	irq_work_run_list(this_cpu_ptr(&raised_list));
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
=20
@@ -197,7 +258,11 @@ void irq_work_tick(void)
=20
 	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
=20
 /*
@@ -219,3 +284,29 @@ void irq_work_sync(struct irq_work *work)
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
+
+static void run_irq_workd(unsigned int cpu)
+{
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
+}
+
+static void irq_workd_setup(unsigned int cpu)
+{
+	sched_set_fifo_low(current);
+}
+
+static struct smp_hotplug_thread irqwork_threads =3D {
+	.store                  =3D &irq_workd,
+	.setup			=3D irq_workd_setup,
+	.thread_should_run      =3D irq_workd_should_run,
+	.thread_fn              =3D run_irq_workd,
+	.thread_comm            =3D "irq_work/%u",
+};
+
+static __init int irq_work_init_threads(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		BUG_ON(smpboot_register_percpu_thread(&irqwork_threads));
+	return 0;
+}
+early_initcall(irq_work_init_threads);
--=20
2.33.0

