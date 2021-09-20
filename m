Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F394C41297C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbhITXjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 19:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239851AbhITXhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:37:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E82261352;
        Mon, 20 Sep 2021 23:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632180770;
        bh=9EhR/MtkK9d88Jt4FcAUzuwH4W4ncUWfwRBg/jCbcHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7hDMJ13wPPjR9Tcwo+4kl1qkrjji8oxZ+SKDaU+9lh81xm25VzTws88UV97mpdKO
         Sl732HjkxA9mBV8OQRpaygizqUoJpZaGpdAN5EgZZKBGdNyyuSAcprGNunCQIG12xd
         SgLkt1VwUegdFeF6+AuPw8i7vtXWJg/aydlOtYC501cQXB4wt0Zt9KQ7o//Hnz6PI+
         iRqJkMksC5QAZtxAOQ40vNlgcJcXa4NiCQ+9DL8/PDF6TgcARJ1CkCtoQbX5S/hDxA
         Dtukr2utUMbo/87mKbHJwlfGXQP+X/17LfZiRynKdG5hPE2cb0sRcgdOlVaF51apzj
         rI/QZ3eafxy+Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/4] arm64: Implement IRQ exit preemption static call for dynamic preemption
Date:   Tue, 21 Sep 2021 01:32:36 +0200
Message-Id: <20210920233237.90463-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920233237.90463-1-frederic@kernel.org>
References: <20210920233237.90463-1-frederic@kernel.org>
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

