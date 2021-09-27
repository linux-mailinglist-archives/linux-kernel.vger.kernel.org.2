Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6D841A146
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhI0VVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:21:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59362 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbhI0VVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:21:10 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632777570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5OOt4nawqznCcmSgkXi0KGSzUjvzHg4XHadv2Xs5IuE=;
        b=u3xF8xxZ0iytynNMP+RphVN3/DJyx3txQKBXp35rqKyEhhAwrU5Zhxjv1slkSNbmxqtzQu
        Bnrxk7cdE53jQMMnn8C05Zt2hqp5P+5ulLIuf974jy1EcsUyzpqTmHJJAfrJQcMpaHRNQ1
        x1sYyXlKBfRsU+w9RHNTu9Rq4/qJa3CGPBknmFY8WGIhb4a0HtaO8imYSIMeLyKefObguK
        M5ssiGy4IfqRPXyJlsV1YN+mUX3WgST+wu41TqfOwN6T6xMlHEGxoARGfQcYJsUT/y7430
        j/ig1zfW9CvWbYLzq3cAb6r966i6ATdJQkQwppeCWiNdnZBp8Inf8VvPEf+ZHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632777570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5OOt4nawqznCcmSgkXi0KGSzUjvzHg4XHadv2Xs5IuE=;
        b=bBYsRW+Ty5p+SZVcSXgZA0MiMIGg7rRa+odqT6EU5CRAiCTym+BqSip3SvZKAchpxTGlNE
        p6o2blWV9Z5wf+CQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] irq_work: Handle some irq_work in SOFTIRQ on PREEMPT_RT
Date:   Mon, 27 Sep 2021 23:19:18 +0200
Message-Id: <20210927211919.310855-5-bigeasy@linutronix.de>
In-Reply-To: <20210927211919.310855-1-bigeasy@linutronix.de>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
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
  to this list. Callbacks on this list will be invoked from timer
  softirq handler. The handler here may acquire sleeping locks such as
  spinlock_t and invoke kfree().

- raised_list
  Work items which are marked with IRQ_WORK_HARD_IRQ will be added to
  this list. They will be invoked in hardirq context and must not
  acquire any sleeping locks.

[bigeasy: melt tglx's irq_work_tick_soft() which splits irq_work_tick() int=
o a
          hard and soft variant. Collected fixes over time from Steven
	  Rostedt and Mike Galbraith. ]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irq_work.h |  6 +++++
 kernel/irq_work.c        | 58 ++++++++++++++++++++++++++++++++--------
 kernel/time/timer.c      |  2 ++
 3 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index b48955e9c920e..d65e34c8d0fd9 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -67,4 +67,10 @@ static inline void irq_work_run(void) { }
 static inline void irq_work_single(void *arg) { }
 #endif
=20
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT)
+void irq_work_tick_soft(void);
+#else
+static inline void irq_work_tick_soft(void) { }
+#endif
+
 #endif /* _LINUX_IRQ_WORK_H */
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 853af2cee3612..55c4206b3ad6f 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -18,6 +18,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/interrupt.h>
 #include <asm/processor.h>
 #include <linux/kasan.h>
=20
@@ -52,13 +53,27 @@ void __weak arch_irq_work_raise(void)
 /* Enqueue on current CPU, work must already be claimed and preempt disabl=
ed */
 static void __irq_work_queue_local(struct irq_work *work)
 {
-	/* If the work is "lazy", handle it from next tick if any */
-	if (atomic_read(&work->node.a_flags) & IRQ_WORK_LAZY) {
-		if (llist_add(&work->node.llist, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->node.llist, this_cpu_ptr(&raised_list)))
+	struct llist_head *list;
+	bool lazy_work;
+	int work_flags;
+
+	work_flags =3D atomic_read(&work->node.a_flags);
+	if (work_flags & IRQ_WORK_LAZY)
+		lazy_work =3D true;
+	else if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		 !(work_flags & IRQ_WORK_HARD_IRQ))
+		lazy_work =3D true;
+	else
+		lazy_work =3D false;
+
+	if (lazy_work)
+		list =3D this_cpu_ptr(&lazy_list);
+	else
+		list =3D this_cpu_ptr(&raised_list);
+
+	if (llist_add(&work->node.llist, list)) {
+		/* If the work is "lazy", handle it from next tick if any */
+		if (!lazy_work || tick_nohz_tick_stopped())
 			arch_irq_work_raise();
 	}
 }
@@ -104,7 +119,13 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (cpu !=3D smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
-		__smp_call_single_queue(cpu, &work->node.llist);
+
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(atomic_read(&work->node.a_flags) =
& IRQ_WORK_HARD_IRQ)) {
+			if (llist_add(&work->node.llist, &per_cpu(lazy_list, cpu)))
+				arch_send_call_function_single_ipi(cpu);
+		} else {
+			__smp_call_single_queue(cpu, &work->node.llist);
+		}
 	} else {
 		__irq_work_queue_local(work);
 	}
@@ -121,7 +142,6 @@ bool irq_work_needs_cpu(void)
=20
 	raised =3D this_cpu_ptr(&raised_list);
 	lazy =3D this_cpu_ptr(&lazy_list);
-
 	if (llist_empty(raised) || arch_irq_work_has_interrupt())
 		if (llist_empty(lazy))
 			return false;
@@ -170,7 +190,11 @@ static void irq_work_run_list(struct llist_head *list)
 	struct irq_work *work, *tmp;
 	struct llist_node *llnode;
=20
-	BUG_ON(!in_hardirq());
+	/*
+	 * On PREEMPT_RT IRQ-work may run in SOFTIRQ context if it is not marked
+	 * explicitly that it needs to run in hardirq context.
+	 */
+	BUG_ON(!in_hardirq() && !IS_ENABLED(CONFIG_PREEMPT_RT));
=20
 	if (llist_empty(list))
 		return;
@@ -187,7 +211,10 @@ static void irq_work_run_list(struct llist_head *list)
 void irq_work_run(void)
 {
 	irq_work_run_list(this_cpu_ptr(&raised_list));
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else if (!llist_empty(this_cpu_ptr(&lazy_list)))
+		raise_softirq(TIMER_SOFTIRQ);
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
=20
@@ -197,8 +224,17 @@ void irq_work_tick(void)
=20
 	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
+}
+
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT)
+void irq_work_tick_soft(void)
+{
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
+#endif
=20
 /*
  * Synchronize against the irq_work @entry, ensures the entry is not
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e3d2c23c413d4..fb235b3e91b3e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1744,6 +1744,8 @@ static __latent_entropy void run_timer_softirq(struct=
 softirq_action *h)
 {
 	struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_STD]);
=20
+	irq_work_tick_soft();
+
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
--=20
2.33.0

