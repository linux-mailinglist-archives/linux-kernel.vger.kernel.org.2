Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3C30FEBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBDUrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBDUlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:41:50 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00066C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:41:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2266A42856;
        Thu,  4 Feb 2021 20:40:38 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 10/18] arm64: Introduce FIQ support
Date:   Fri,  5 Feb 2021 05:39:43 +0900
Message-Id: <20210204203951.52105-11-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204203951.52105-1-marcan@marcan.st>
References: <20210204203951.52105-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs (A11 and newer) have some interrupt sources hardwired to the
FIQ line. Implement support for this by simply treating IRQs and FIQs
the same way in the interrupt vectors. This is conditional on the
ARM64_NEEDS_FIQ CPU feature flag, and thus will not affect other
systems.

Root irqchip drivers can discriminate between IRQs and FIQs by checking
the ISR_EL1 system register.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/include/asm/assembler.h |  4 ++++
 arch/arm64/include/asm/daifflags.h |  7 +++++++
 arch/arm64/include/asm/irqflags.h  | 17 +++++++++++++----
 arch/arm64/kernel/entry.S          | 27 +++++++++++++++++++++++----
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index bf125c591116..6acfc372dc76 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -42,7 +42,11 @@
 
 	/* IRQ is the lowest priority flag, unconditionally unmask the rest. */
 	.macro enable_da_f
+alternative_if ARM64_NEEDS_FIQ
+	msr	daifclr, #(8 | 4)
+alternative_else
 	msr	daifclr, #(8 | 4 | 1)
+alternative_endif
 	.endm
 
 /*
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 1c26d7baa67f..228a6039c701 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -112,6 +112,13 @@ static inline void local_daif_restore(unsigned long flags)
 		 * So we don't need additional synchronization here.
 		 */
 		gic_write_pmr(pmr);
+	} else if (system_uses_fiqs()) {
+		/*
+		 * On systems that use FIQs, disable FIQs if IRQs are disabled.
+		 * This can happen if the DAIF_* flags at the top of this file
+		 * are used to set DAIF directly.
+		 */
+		flags |= PSR_F_BIT;
 	}
 
 	write_sysreg(flags, daif);
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index ff328e5bbb75..689c573c4b47 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -19,8 +19,9 @@
  * side effects for other flags. Keeping to this order makes it easier for
  * entry.S to know which exceptions should be unmasked.
  *
- * FIQ is never expected, but we mask it when we disable debug exceptions, and
- * unmask it at all other times.
+ * FIQ is never expected on most platforms, but we mask it when we disable
+ * debug exceptions, and unmask it at all other times. On platforms that
+ * require FIQs, it tracks IRQ masking.
  */
 
 /*
@@ -34,8 +35,14 @@ static inline void arch_local_irq_enable(void)
 		WARN_ON_ONCE(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
 	}
 
-	asm volatile(ALTERNATIVE(
+	/*
+	 * Yes, ALTERNATIVE() nests properly... only one of these should be
+	 * active on any given platform.
+	 */
+	asm volatile(ALTERNATIVE(ALTERNATIVE(
 		"msr	daifclr, #2		// arch_local_irq_enable",
+		"msr	daifclr, #3		// arch_local_irq_enable",
+		ARM64_NEEDS_FIQ),
 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
@@ -53,8 +60,10 @@ static inline void arch_local_irq_disable(void)
 		WARN_ON_ONCE(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
 	}
 
-	asm volatile(ALTERNATIVE(
+	asm volatile(ALTERNATIVE(ALTERNATIVE(
 		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr	daifset, #3		// arch_local_irq_disable",
+		ARM64_NEEDS_FIQ),
 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c9bae73f2621..81ca04ebe37b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -60,7 +60,7 @@
 #define BAD_FIQ		2
 #define BAD_ERROR	3
 
-	.macro kernel_ventry, el, label, regsize = 64
+	.macro kernel_ventry, el, label, regsize = 64, altlabel = 0, alt = 0
 	.align 7
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	.if	\el == 0
@@ -87,7 +87,15 @@ alternative_else_nop_endif
 	tbnz	x0, #THREAD_SHIFT, 0f
 	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
 	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
+	.if	\altlabel != 0
+	alternative_if \alt
+	b	el\()\el\()_\altlabel
+	alternative_else
 	b	el\()\el\()_\label
+	alternative_endif
+	.else
+	b	el\()\el\()_\label
+	.endif
 
 0:
 	/*
@@ -119,7 +127,15 @@ alternative_else_nop_endif
 	sub	sp, sp, x0
 	mrs	x0, tpidrro_el0
 #endif
+	.if	\altlabel != 0
+	alternative_if \alt
+	b	el\()\el\()_\altlabel
+	alternative_else
 	b	el\()\el\()_\label
+	alternative_endif
+	.else
+	b	el\()\el\()_\label
+	.endif
 	.endm
 
 	.macro tramp_alias, dst, sym
@@ -547,18 +563,21 @@ SYM_CODE_START(vectors)
 
 	kernel_ventry	1, sync				// Synchronous EL1h
 	kernel_ventry	1, irq				// IRQ EL1h
-	kernel_ventry	1, fiq_invalid			// FIQ EL1h
+							// FIQ EL1h
+	kernel_ventry	1, fiq_invalid, 64, irq, ARM64_NEEDS_FIQ
 	kernel_ventry	1, error			// Error EL1h
 
 	kernel_ventry	0, sync				// Synchronous 64-bit EL0
 	kernel_ventry	0, irq				// IRQ 64-bit EL0
-	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
+							// FIQ 64-bit EL0
+	kernel_ventry	0, fiq_invalid, 64, irq, ARM64_NEEDS_FIQ
 	kernel_ventry	0, error			// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
 	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
 	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
-	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
+							// FIQ 32-bit EL0
+	kernel_ventry	0, fiq_invalid_compat, 32, irq_compat, ARM64_NEEDS_FIQ
 	kernel_ventry	0, error_compat, 32		// Error 32-bit EL0
 #else
 	kernel_ventry	0, sync_invalid, 32		// Synchronous 32-bit EL0
-- 
2.30.0

