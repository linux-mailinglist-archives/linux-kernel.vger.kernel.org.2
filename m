Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4488E3E1851
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbhHEPmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:42:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242156AbhHEPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:27 -0400
Message-ID: <20210805153953.152275344@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=iIZa3zE37Q8YGnDqK53W6KL1tZETOpU/jK4xBGjnKFo=;
        b=eet742g5VIE0vDMs0Q3Vb09aV9XyvPu8oJ0TE3Uv2D3N0Di+r8wQIIMXelmvI4S9h6WmSL
        6WLZlyL6VDkNY86CZIyPoipTg8rLJ6V8fG8TRdA4bjvbIWptvh9iJh3JGYgv6JpVm5uqDJ
        0mvRKbLtWc6ZbOH/2F6Ua1rL0LipmrUidxaG426A0AhIEDDu7NhNVAH/DjEXoHB8i5nkdS
        EcU7+/88iSX6hcG2+1UeFYqTsqyaC7W20qUeYiUPqZeFyi9T2Q6scuYjhq6zAjjMXiY2OT
        ZTf99c6c4DpysSCShUANiuOs9PMG0DSg6HdnmpJfhHf3xuNpssiRPEhLyHo0qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=iIZa3zE37Q8YGnDqK53W6KL1tZETOpU/jK4xBGjnKFo=;
        b=RIJ6JA30WWhHg3s8YvZNQOPpROjODsMm7tR+FWWQxzfnMoOL6so+3A0y1zbwPOlowIyKdp
        Q6nWYO2H4vzv1DDQ==
Date:   Thu, 05 Aug 2021 17:13:06 +0200
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
Subject: [patch V3 06/64] sched: Provide schedule point for RT locks
References: <20210805151300.330412127@linutronix.de>
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

