Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81683E90A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbhHKMXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:23:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50256 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbhHKMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:02 -0400
Message-ID: <20210811121414.485002712@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SZqMfIhfNpT8/bCIRlDGg8ulBul554WecW173Sc7lKg=;
        b=AHmbeR2F2jkOu9K7Fv3I2GyYnUzzmG1jIGSJH33b8Y3gyhOrw/6IMaRlaeDUZF00kjFjLp
        W64xwIkMZMFJ+iopb9QO1yR/ej0OdCdnb5bf2xgde+FQxkLxgievwvXdUfpQq4J9tvvj+b
        GJh+FpIZ7EGHxhg7BNyQXKS2GlAnScB7CJsIkjDf3ScuuNRg30BK0ukvp2eQG+MET73qLL
        yQqtZ6UHJTtzzpaXJZXD9mNvz0CycAiOVnhmEG77FjOsyw+ILZ48No1nDTFrBLgd2N5qTE
        85oN50jb2VOraGeI7oH+ZVj34w3PjN7ZyAkF6Eosi14olYYnCgKJxTC8EMijTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SZqMfIhfNpT8/bCIRlDGg8ulBul554WecW173Sc7lKg=;
        b=zF/yi7U/ISGq1bvo8a5BA3v7qGHo4/xgkg8Yw54rUbk/kDS7CX0ww9+04PVFYrgjsGJwnw
        mjYPm2EiojFfDGBA==
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
Subject: [patch V4 06/68] sched: Provide schedule point for RT locks
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:37 +0200 (CEST)
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

Add a separate scheduling point for this and hand a new scheduling mode
argument to __schedule() which allows along with separate mode masks to
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
@@ -288,6 +288,9 @@ extern long schedule_timeout_idle(long t
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
@@ -5829,7 +5829,13 @@ pick_next_task(struct rq *rq, struct tas
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
@@ -6134,6 +6140,18 @@ void __sched schedule_preempt_disabled(v
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

