Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB1344B1F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbhKIR1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:27:18 -0500
Received: from foss.arm.com ([217.140.110.172]:36518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241002AbhKIR1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:27:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61958139F;
        Tue,  9 Nov 2021 09:24:26 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 121A83F800;
        Tue,  9 Nov 2021 09:24:24 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, catalin.marinas@arm.com, frederic@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org
Subject: [PATCH 3/6] sched/preempt: simplify irqentry_exit_cond_resched() callers
Date:   Tue,  9 Nov 2021 17:24:05 +0000
Message-Id: <20211109172408.49641-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211109172408.49641-1-mark.rutland@arm.com>
References: <20211109172408.49641-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently callers of irqentry_exit_cond_resched() need to be aware of
whether the function should be indirected via a static call, leading to
ugly ifdeffery in callers.

Save them the hassle with a static inline wrapper that does the right
thing. The raw_irqentry_exit_cond_resched() will also be useful in
subsequent patches which will add conditional wrappers for preemption
functions.

Note: in arch/x86/entry/common.c, xen_pv_evtchn_do_upcall() always calls
irqentry_exit_cond_resched() directly, even when PREEMPT_DYNAMIC is in
use. I believe this is a latent bug (which this patch corrects), but I'm
not entirely certain this wasn't deliberate.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/entry-common.h |  9 ++++++---
 kernel/entry/common.c        | 12 ++++--------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index a01ac1a0a292..dfd84c59b144 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -454,11 +454,14 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  *
  * Conditional reschedule with additional sanity checks.
  */
-void irqentry_exit_cond_resched(void);
+void raw_irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#define irqentry_exit_cond_resched_dynamic_enabled	irqentry_exit_cond_resched
+#define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
 #define irqentry_exit_cond_resched_dynamic_disabled	NULL
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
+#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
+#else
+#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
 #endif
 
 /**
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d5a61d565ad5..3be0526e003d 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -380,7 +380,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return ret;
 }
 
-void irqentry_exit_cond_resched(void)
+void raw_irqentry_exit_cond_resched(void)
 {
 	if (!preempt_count()) {
 		/* Sanity check RCU and thread stack */
@@ -392,7 +392,7 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 #endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
@@ -420,13 +420,9 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION)) {
-#ifdef CONFIG_PREEMPT_DYNAMIC
-			static_call(irqentry_exit_cond_resched)();
-#else
+		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
-#endif
-		}
+
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
-- 
2.11.0

