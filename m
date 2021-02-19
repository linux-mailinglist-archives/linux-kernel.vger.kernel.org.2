Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DEA31FDC7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhBSRWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:22:39 -0500
Received: from marcansoft.com ([212.63.210.85]:42284 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBSRWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:22:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 432C141EF0;
        Fri, 19 Feb 2021 17:21:49 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hector Martin <marcan@marcan.st>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 7/8 v1.5] arm64: Always keep DAIF.[IF] in sync
Date:   Sat, 20 Feb 2021 02:21:45 +0900
Message-Id: <20210219172145.45264-1-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>

---
 arch/arm64/include/asm/arch_gicv3.h |  2 +-
 arch/arm64/include/asm/assembler.h  |  8 ++++----
 arch/arm64/include/asm/daifflags.h  | 10 +++++-----
 arch/arm64/include/asm/irqflags.h   | 16 +++++++---------
 arch/arm64/kernel/entry.S           | 12 +++++++-----
 arch/arm64/kernel/process.c         |  2 +-
 arch/arm64/kernel/smp.c             |  1 +
 7 files changed, 26 insertions(+), 25 deletions(-)

This is the updated patch after addressing the comments in the original
v2 review; we're moving it to this series now, so please review it in
this context.

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 880b9054d75c..934b9be582d2 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -173,7 +173,7 @@ static inline void gic_pmr_mask_irqs(void)

 static inline void gic_arch_enable_irqs(void)
 {
-	asm volatile ("msr daifclr, #2" : : : "memory");
+	asm volatile ("msr daifclr, #3" : : : "memory");
 }

 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index bf125c591116..53ff8c71eed7 100644
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
@@ -50,7 +50,7 @@
  */
 	.macro	save_and_disable_irq, flags
 	mrs	\flags, daif
-	msr	daifset, #2
+	msr	daifset, #3
 	.endm

 	.macro	restore_irq, flags
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 1c26d7baa67f..5eb7af9c4557 100644
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


@@ -47,7 +47,7 @@ static inline unsigned long local_daif_save_flags(void)
 	if (system_uses_irq_prio_masking()) {
 		/* If IRQs are masked with PMR, reflect it in the flags */
 		if (read_sysreg_s(SYS_ICC_PMR_EL1) != GIC_PRIO_IRQON)
-			flags |= PSR_I_BIT;
+			flags |= PSR_I_BIT | PSR_F_BIT;
 	}

 	return flags;
@@ -69,7 +69,7 @@ static inline void local_daif_restore(unsigned long flags)
 	bool irq_disabled = flags & PSR_I_BIT;

 	WARN_ON(system_has_prio_mask_debugging() &&
-		!(read_sysreg(daif) & PSR_I_BIT));
+		(read_sysreg(daif) & (PSR_I_BIT | PSR_F_BIT)) != (PSR_I_BIT | PSR_F_BIT));

 	if (!irq_disabled) {
 		trace_hardirqs_on();
@@ -86,7 +86,7 @@ static inline void local_daif_restore(unsigned long flags)
 			 * If interrupts are disabled but we can take
 			 * asynchronous errors, we can take NMIs
 			 */
-			flags &= ~PSR_I_BIT;
+			flags &= ~(PSR_I_BIT | PSR_F_BIT);
 			pmr = GIC_PRIO_IRQOFF;
 		} else {
 			pmr = GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET;
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index ff328e5bbb75..b57b9b1e4344 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -12,15 +12,13 @@

 /*
  * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
- * FIQ exceptions, in the 'daif' register. We mask and unmask them in 'dai'
+ * FIQ exceptions, in the 'daif' register. We mask and unmask them in 'daif'
  * order:
  * Masking debug exceptions causes all other exceptions to be masked too/
- * Masking SError masks irq, but not debug exceptions. Masking irqs has no
- * side effects for other flags. Keeping to this order makes it easier for
- * entry.S to know which exceptions should be unmasked.
- *
- * FIQ is never expected, but we mask it when we disable debug exceptions, and
- * unmask it at all other times.
+ * Masking SError masks IRQ/FIQ, but not debug exceptions. IRQ and FIQ are
+ * always masked and unmasked together, and have no side effects for other
+ * flags. Keeping to this order makes it easier for entry.S to know which
+ * exceptions should be unmasked.
  */

 /*
@@ -35,7 +33,7 @@ static inline void arch_local_irq_enable(void)
 	}

 	asm volatile(ALTERNATIVE(
-		"msr	daifclr, #2		// arch_local_irq_enable",
+		"msr	daifclr, #3		// arch_local_irq_enable",
 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
@@ -54,7 +52,7 @@ static inline void arch_local_irq_disable(void)
 	}

 	asm volatile(ALTERNATIVE(
-		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr	daifset, #3		// arch_local_irq_disable",
 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index acc677672277..af04ce5088ca 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -533,7 +533,7 @@ alternative_endif

 	.macro el1_interrupt_handler, handler:req
 	gic_prio_irq_setup pmr=x20, tmp=x1
-	enable_da_f
+	enable_da

 	mov	x0, sp
 	bl	enter_el1_irq_or_nmi
@@ -544,8 +544,10 @@ alternative_endif
 	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
 alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	/*
-	 * DA_F were cleared at start of handling. If anything is set in DAIF,
-	 * we come back from an NMI, so skip preemption
+	 * DA were cleared at start of handling, and IF are cleared by
+	 * the GIC irqchip driver using gic_arch_enable_irqs() for
+	 * normal IRQs. If anything is set, it means we come back from
+	 * an NMI instead of a normal IRQ, so skip preemption
 	 */
 	mrs	x0, daif
 	orr	x24, x24, x0
@@ -562,7 +564,7 @@ alternative_else_nop_endif
 	.macro el0_interrupt_handler, handler:req
 	gic_prio_irq_setup pmr=x20, tmp=x0
 	user_exit_irqoff
-	enable_da_f
+	enable_da

 	tbz	x22, #55, 1f
 	bl	do_el0_irq_bp_hardening
@@ -763,7 +765,7 @@ el0_error_naked:
 	mov	x0, sp
 	mov	x1, x25
 	bl	do_serror
-	enable_da_f
+	enable_da
 	b	ret_to_user
 SYM_CODE_END(el0_error)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6616486a58fe..34ec400288d0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -84,7 +84,7 @@ static void noinstr __cpu_do_idle_irqprio(void)
 	unsigned long daif_bits;

 	daif_bits = read_sysreg(daif);
-	write_sysreg(daif_bits | PSR_I_BIT, daif);
+	write_sysreg(daif_bits | PSR_I_BIT | PSR_F_BIT, daif);

 	/*
 	 * Unmask PMR before going idle to make sure interrupts can
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ad00f99ee9b0..9dee8a17b1ac 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -188,6 +188,7 @@ static void init_gic_priority_masking(void)
 	cpuflags = read_sysreg(daif);

 	WARN_ON(!(cpuflags & PSR_I_BIT));
+	WARN_ON(!(cpuflags & PSR_F_BIT));

 	gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET);
 }
--
2.30.0

