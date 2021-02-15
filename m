Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677FD31B90E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhBOMVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:21:16 -0500
Received: from marcansoft.com ([212.63.210.85]:42626 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhBOMTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:19:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 913F8424A1;
        Mon, 15 Feb 2021 12:18:13 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/25] arm64: Always keep DAIF.[IF] in sync
Date:   Mon, 15 Feb 2021 21:16:56 +0900
Message-Id: <20210215121713.57687-9-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
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

Root irqchip drivers can discriminate between IRQs and FIQs by checking
the ISR_EL1 system register.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/include/asm/assembler.h |  6 +++---
 arch/arm64/include/asm/daifflags.h |  4 ++--
 arch/arm64/include/asm/irqflags.h  | 19 +++++++++++--------
 arch/arm64/kernel/entry.S          |  6 +++---
 4 files changed, 19 insertions(+), 16 deletions(-)

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
index c9bae73f2621..ba5f9aa379ce 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -661,7 +661,7 @@ SYM_CODE_END(el1_sync)
 SYM_CODE_START_LOCAL_NOALIGN(el1_irq)
 	kernel_entry 1
 	gic_prio_irq_setup pmr=x20, tmp=x1
-	enable_da_f
+	enable_da
 
 	mov	x0, sp
 	bl	enter_el1_irq_or_nmi
@@ -727,7 +727,7 @@ SYM_CODE_START_LOCAL_NOALIGN(el0_irq)
 el0_irq_naked:
 	gic_prio_irq_setup pmr=x20, tmp=x0
 	user_exit_irqoff
-	enable_da_f
+	enable_da
 
 	tbz	x22, #55, 1f
 	bl	do_el0_irq_bp_hardening
@@ -757,7 +757,7 @@ el0_error_naked:
 	mov	x0, sp
 	mov	x1, x25
 	bl	do_serror
-	enable_da_f
+	enable_da
 	b	ret_to_user
 SYM_CODE_END(el0_error)
 
-- 
2.30.0

