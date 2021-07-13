Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4533C73F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhGMQQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54182 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhGMQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:05 -0400
Message-Id: <20210713160746.410991567@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JrxeDOuHXcbgPtOWsXMvGO1cM0e5y/2ueKg3gpR1SvA=;
        b=0QclRgU5jCA/BnIisJMllm0GFSRfsTKFCgXG9xX7ixPygZgXsMkUP2+Q9XXKUG9z7GwcZv
        1X9oOaSyanyWFFEoFqHjzfxgCR3VJcHAbUCeiNPfmHlaNLBvIw4CBCJ75/kz5rxjNv9zpy
        wU52mDYELRdR0hNAubFjhrgo9ie6Sg5UO7MRuIfYQOD1mQan7qdTmxLE4O5ecf+QxtmoKe
        KSjRFnlx9TvIJif8ixurIh7yIlHmkGg0Kw1j7f05XAI3QvGZjCGOAARPDak0FcuC6ckXWW
        ugboFjhzy0lrArnrvszHRePWOeTBc09wxA9zsjFwHx0QdxwHWjfnyvFzyabADg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JrxeDOuHXcbgPtOWsXMvGO1cM0e5y/2ueKg3gpR1SvA=;
        b=S8TIUxC5kJfi/dQUSNDy5IxQKa4XmG8bN8oCoKX0x7qXHJWylNip1kgTYxItTc4PVCgRx2
        Lmb04hU1NbAbR5Ag==
Date:   Tue, 13 Jul 2021 17:10:59 +0200
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
Subject: [patch 05/50] sched: Provide schedule point for RT locks
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

RT enabled kernels substitute spin/rwlocks with 'sleeping' variants based
on rtmutex. Blocking on such a lock is similar to preemption versus:

 - I/O scheduling and worker handling because these functions might block
   on another substituted lock or come from a lock contention within these
   functions.

 - RCU considers this like a preemption because the task might be in a read
   side critical section.

Add a seperate scheduling point for this and hand a new scheduling mode
argument to __schedule() which allows along with seperate mode masks to
handle this gracefully from within the scheduler without proliferating that
to other subsystems like RCU.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched.h |    3 +++
 kernel/sched/core.c   |   22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)
---
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -294,6 +294,9 @@ extern long schedule_timeout_idle(long t
 asmlinkage void schedule(void);
 extern void schedule_preempt_disabled(void);
 asmlinkage void preempt_schedule_irq(void);
+#ifdef CONFIG_PREEMPT_RT
+ extern void schedule_rtlock(void);
+#endif
 
 extern int __must_check io_schedule_prepare(void);
 extern void io_schedule_finish(int token);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5832,8 +5832,14 @@ pick_next_task(struct rq *rq, struct tas
  */
 #define	SM_NONE			0x0
 #define	SM_PREEMPT		0x1
-#define SM_MASK_PREEMPT		UINT_MAX
-#define SM_MASK_STATE		SM_MASK_PREEMPT
+#ifndef CONFIG_PREEMPT_RT
+# define SM_MASK_PREEMPT	UINT_MAX
+# define SM_MASK_STATE		SM_MASK_PREEMPT
+#else
+# define SM_RTLOCK_WAIT		0x2
+# define SM_MASK_PREEMPT	SM_PREEMPT
+# define SM_MASK_STATE		(SM_PREEMPT | SM_RTLOCK_WAIT)
+#endif
 
 /*
  * __schedule() is the main scheduler function.
@@ -6138,6 +6144,18 @@ void __sched schedule_preempt_disabled(v
 	preempt_disable();
 }
 
+#ifdef CONFIG_PREEMPT_RT
+void __sched notrace schedule_rtlock(void)
+{
+	do {
+		preempt_disable();
+		__schedule(SM_RTLOCK_WAIT);
+		sched_preempt_enable_no_resched();
+	} while (need_resched());
+}
+NOKPROBE_SYMBOL(schedule_rtlock);
+#endif
+
 static void __sched notrace preempt_schedule_common(void)
 {
 	do {

