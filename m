Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B131F889
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhBSLmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:42:22 -0500
Received: from foss.arm.com ([217.140.110.172]:34268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbhBSLku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:40:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BEB9142F;
        Fri, 19 Feb 2021 03:39:50 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 45E3B3F694;
        Fri, 19 Feb 2021 03:39:49 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        mark.rutland@arm.com, maz@kernel.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH 7/8] arm64: Always keep DAIF.[IF] in sync
Date:   Fri, 19 Feb 2021 11:39:03 +0000
Message-Id: <20210219113904.41736-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210219113904.41736-1-mark.rutland@arm.com>
References: <20210219113904.41736-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

Apple SoCs (A11 and newer) have some interrupt sources hardwired to the
FIQ line. We implement support for this by simply treating IRQs and FIQs
the same way in the interrupt vectors.

To support these systems, the FIQ mask bit needs to be kept in sync with
the IRQ mask bit, so both kinds of exceptions are masked together. No
other platforms should be delivering FIQ exceptions right now, and we
already unmask FIQ in normal process context, so this should not have an
effect on other systems - if spurious FIQs were arriving, they would
already panic the kernel.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/assembler.h |  6 +++---
 arch/arm64/include/asm/daifflags.h |  4 ++--
 arch/arm64/include/asm/irqflags.h  | 19 +++++++++++--------
 arch/arm64/kernel/entry.S          |  8 ++++----
 4 files changed, 20 insertions(+), 17 deletions(-)

Note: as per discussion on v2 [1], there are a few additional fixups necessary;
and so we should not queue this version of the patch. I've included it for now
as it is a prerequisite for the last patch.

[1] https://lore.kernel.org/r/20210215121713.57687-9-marcan@marcan.st

Mark.

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index bf125c591116..ac4c823bf2b6 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -40,9 +40,9 @@
 	msr	daif, \flags
 	.endm
 
-	/* IRQ is the lowest priority flag, unconditionally unmask the rest. */
-	.macro enable_da_f
-	msr	daifclr, #(8 | 4 | 1)
+	/* IRQ/FIQ are the lowest priority flags, unconditionally unmask the rest. */
+	.macro enable_da
+	msr	daifclr, #(8 | 4)
 	.endm
 
 /*
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 1c26d7baa67f..9d1d4ab98585 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -13,8 +13,8 @@
 #include <asm/ptrace.h>
 
 #define DAIF_PROCCTX		0
-#define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
-#define DAIF_ERRCTX		(PSR_I_BIT | PSR_A_BIT)
+#define DAIF_PROCCTX_NOIRQ	(PSR_I_BIT | PSR_F_BIT)
+#define DAIF_ERRCTX		(PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
 #define DAIF_MASK		(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
 
 
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index ff328e5bbb75..125201dced5f 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -12,15 +12,18 @@
 
 /*
  * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
- * FIQ exceptions, in the 'daif' register. We mask and unmask them in 'dai'
+ * FIQ exceptions, in the 'daif' register. We mask and unmask them in 'daif'
  * order:
  * Masking debug exceptions causes all other exceptions to be masked too/
- * Masking SError masks irq, but not debug exceptions. Masking irqs has no
- * side effects for other flags. Keeping to this order makes it easier for
- * entry.S to know which exceptions should be unmasked.
+ * Masking SError masks IRQ/FIQ, but not debug exceptions. IRQ and FIQ are
+ * always masked and unmasked together, and have no side effects for other
+ * flags. Keeping to this order makes it easier for entry.S to know which
+ * exceptions should be unmasked.
  *
- * FIQ is never expected, but we mask it when we disable debug exceptions, and
- * unmask it at all other times.
+ * FIQ is never expected on most platforms, but we keep it synchronized
+ * with the IRQ mask status. On platforms that do not expect FIQ, that vector
+ * triggers a kernel panic. On platforms that do, the FIQ vector is unified
+ * with the IRQ vector.
  */
 
 /*
@@ -35,7 +38,7 @@ static inline void arch_local_irq_enable(void)
 	}
 
 	asm volatile(ALTERNATIVE(
-		"msr	daifclr, #2		// arch_local_irq_enable",
+		"msr	daifclr, #3		// arch_local_irq_enable",
 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
@@ -54,7 +57,7 @@ static inline void arch_local_irq_disable(void)
 	}
 
 	asm volatile(ALTERNATIVE(
-		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr	daifset, #3		// arch_local_irq_disable",
 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index acc677672277..0474cca9f1a9 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -533,7 +533,7 @@ alternative_endif
 
 	.macro el1_interrupt_handler, handler:req
 	gic_prio_irq_setup pmr=x20, tmp=x1
-	enable_da_f
+	enable_da
 
 	mov	x0, sp
 	bl	enter_el1_irq_or_nmi
@@ -544,7 +544,7 @@ alternative_endif
 	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
 alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	/*
-	 * DA_F were cleared at start of handling. If anything is set in DAIF,
+	 * DA were cleared at start of handling. If anything is set in DAIF,
 	 * we come back from an NMI, so skip preemption
 	 */
 	mrs	x0, daif
@@ -562,7 +562,7 @@ alternative_else_nop_endif
 	.macro el0_interrupt_handler, handler:req
 	gic_prio_irq_setup pmr=x20, tmp=x0
 	user_exit_irqoff
-	enable_da_f
+	enable_da
 
 	tbz	x22, #55, 1f
 	bl	do_el0_irq_bp_hardening
@@ -763,7 +763,7 @@ el0_error_naked:
 	mov	x0, sp
 	mov	x1, x25
 	bl	do_serror
-	enable_da_f
+	enable_da
 	b	ret_to_user
 SYM_CODE_END(el0_error)
 
-- 
2.11.0

