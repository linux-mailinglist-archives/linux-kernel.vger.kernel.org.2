Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B728439610
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhJYMXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233134AbhJYMXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:23:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C877F61073;
        Mon, 25 Oct 2021 12:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635164475;
        bh=9F6yfN673eZlS130Eq+XEqL3Qzcqky6qGtY+tRCN/J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nEkVei+vNR4SzIB2PA/furFYxZELh4t1tMuC4bBLxEEMi3AIDP0iJsIQyQVh88o+h
         ji8OVPeYDTEFEhoXQe4hKjhXVjrIHsKD2AkI86+HNo90V0xIxOoOiENQDi/k/tYlNF
         79Q/B2Zd7LgqI6nB3iQ59+Fu8LfpBPYAhoBe12eNdrkHJxWaIvUGGVJtiU8xbxAFaF
         a9GKo1FLa22COdWadOBkUecnJAuPbSnPBhMuulNMljv7e7WBwUDg7Bccp8XyhTKLoA
         OIoUWnaqUA8zMK8QXjmRM/GsuXHGbfMg5749kzQY+vuLyuPqwQB3puoFU3nYa4Bqtv
         Uo3PWygGkmw/g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/4] arm64: Implement IRQ exit preemption static call for dynamic preemption
Date:   Mon, 25 Oct 2021 14:21:01 +0200
Message-Id: <20211025122102.46089-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025122102.46089-1-frederic@kernel.org>
References: <20211025122102.46089-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 doesn't support generic entry yet, so the architecture's own IRQ
exit preemption path needs to be exposed through the relevant static
call.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
---
 arch/arm64/include/asm/preempt.h |  7 +++++++
 arch/arm64/kernel/entry-common.c | 15 ++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index e83f0982b99c..4fbbe644532f 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -3,6 +3,7 @@
 #define __ASM_PREEMPT_H
 
 #include <linux/thread_info.h>
+#include <linux/static_call_types.h>
 
 #define PREEMPT_NEED_RESCHED	BIT(32)
 #define PREEMPT_ENABLED	(PREEMPT_NEED_RESCHED)
@@ -86,4 +87,10 @@ void preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
 #endif /* CONFIG_PREEMPTION */
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+void arm64_preempt_schedule_irq(void);
+#define __irqentry_exit_cond_resched_func arm64_preempt_schedule_irq
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, __irqentry_exit_cond_resched_func);
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 32f9796c4ffe..f1c739dd874d 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/thread_info.h>
+#include <linux/static_call.h>
 
 #include <asm/cpufeature.h>
 #include <asm/daifflags.h>
@@ -235,7 +236,7 @@ static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
 		exit_to_kernel_mode(regs);
 }
 
-static void __sched arm64_preempt_schedule_irq(void)
+void __sched arm64_preempt_schedule_irq(void)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -259,6 +260,9 @@ static void __sched arm64_preempt_schedule_irq(void)
 	if (system_capabilities_finalized())
 		preempt_schedule_irq();
 }
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched, arm64_preempt_schedule_irq);
+#endif
 
 static void do_interrupt_handler(struct pt_regs *regs,
 				 void (*handler)(struct pt_regs *))
@@ -446,8 +450,13 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
 	 * preempt_count().
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPTION) &&
-	    READ_ONCE(current_thread_info()->preempt_count) == 0)
-		arm64_preempt_schedule_irq();
+	    READ_ONCE(current_thread_info()->preempt_count) == 0) {
+#ifdef CONFIG_PREEMPT_DYNAMIC
+			static_call(irqentry_exit_cond_resched)();
+#else
+			arm64_preempt_schedule_irq();
+#endif
+	}
 
 	exit_el1_irq_or_nmi(regs);
 }
-- 
2.25.1

