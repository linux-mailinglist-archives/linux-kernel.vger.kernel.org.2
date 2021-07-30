Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73953DBA3E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbhG3OUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:20:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbhG3ORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:12 -0400
Message-ID: <20210730135205.434944891@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yFddNLcBiutB/8vMLREBAPQ8WzNzATHga0WkaGc9nqk=;
        b=Rmooj/i5QN/LtyCq0Q/sj8b7JbEEnrfBXXJ+G1bCAlf8O2dPB90Yv2hLt6Sjbufj2JvYDE
        nT/RmwMSduadWwTLwrWXOqKsOf9/uR+q2Q5/79KaBUB5hijfhZ3efwhL2i0IjDeCgLX/a7
        c7UpDVPwGBd2/frZrvn9whK51B0+g0cnM64FvdV/63c6ABESf357G4TvTdWeHrw/lUjXQv
        RlikQffgUVxe1fIPoiGlDEpr4oy3GOy7CRle16lAeAUgqgyrXlgtgqdHtbn+iGsqtL3A/V
        qADcFhGcgysB4fDc4vbGEq3XMdrvNv0gGQPO4hxVQw/nCjLtYrZtIAHnGaP0Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yFddNLcBiutB/8vMLREBAPQ8WzNzATHga0WkaGc9nqk=;
        b=rGptN9ky84KqLNLX9ICYmkfnBm6WZFm7YFYcI0QT66K3zi2BT5upjJzNDhliElAj95p+BY
        keXszrqGGhmXzPDw==
Date:   Fri, 30 Jul 2021 15:50:12 +0200
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
Subject: [patch 05/63] sched: Provide schedule point for RT locks
References: <20210730135007.155909613@linutronix.de>
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
V2: Adopt to the simplified mask logic
---
 include/linux/sched.h |    3 +++
 kernel/sched/core.c   |   20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)
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
@@ -5831,7 +5831,13 @@ pick_next_task(struct rq *rq, struct tas
  */
 #define SM_NONE			0x0
 #define SM_PREEMPT		0x1
-#define SM_MASK_PREEMPT		(~0U)
+#define SM_RTLOCK_WAIT		0x2
+
+#ifndef CONFIG_PREEMPT_RT
+# define SM_MASK_PREEMPT	(~0U)
+#else
+# define SM_MASK_PREEMPT	SM_PREEMPT
+#endif
 
 /*
  * __schedule() is the main scheduler function.
@@ -6136,6 +6142,18 @@ void __sched schedule_preempt_disabled(v
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

