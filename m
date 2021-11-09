Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4037844B1FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbhKIR1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:27:25 -0500
Received: from foss.arm.com ([217.140.110.172]:36552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241025AbhKIR1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:27:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92299ED1;
        Tue,  9 Nov 2021 09:24:32 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 424913F800;
        Tue,  9 Nov 2021 09:24:31 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, catalin.marinas@arm.com, frederic@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org
Subject: [PATCH 6/6] arm64: support PREEMPT_DYNAMIC
Date:   Tue,  9 Nov 2021 17:24:08 +0000
Message-Id: <20211109172408.49641-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211109172408.49641-1-mark.rutland@arm.com>
References: <20211109172408.49641-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables support for PREEMPT_DYNAMIC on arm64, using static
keys to disable the out-of-line forms of the preemption functions. This
side-steps a number of pain points highlighted with static calls, and I
expect the overhead to be similar (and hopefully lower in some cases)
than would be the case for non-inlined static calls, by virtue of
effectively inlining the trampolines into the callees.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/preempt.h | 16 ++++++++++++++--
 arch/arm64/kernel/entry-common.c |  9 +++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..928b710465ce 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -191,6 +191,7 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index e83f0982b99c..73623f719d7e 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -80,10 +80,22 @@ static inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_preempt_schedule(void);
+#define __preempt_schedule()		dynamic_preempt_schedule()
+void dynamic_preempt_schedule_notrace(void);
+#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
+
+#else
+
 void preempt_schedule(void);
-#define __preempt_schedule() preempt_schedule()
+#define __preempt_schedule()		preempt_schedule()
 void preempt_schedule_notrace(void);
-#define __preempt_schedule_notrace() preempt_schedule_notrace()
+#define __preempt_schedule_notrace()	preempt_schedule_notrace()
+
+#endif
 #endif /* CONFIG_PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index f7408edf8571..f096678dd580 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -220,10 +220,19 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+#endif
+
 static void __sched arm64_preempt_schedule_irq(void)
 {
 	lockdep_assert_irqs_disabled();
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+		return;
+#endif
+
 	/*
 	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
 	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
-- 
2.11.0

