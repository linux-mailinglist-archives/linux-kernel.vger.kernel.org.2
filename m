Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFD231F88A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhBSLmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:42:49 -0500
Received: from foss.arm.com ([217.140.110.172]:34270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230439AbhBSLku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:40:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 832A41435;
        Fri, 19 Feb 2021 03:39:52 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D48B3F694;
        Fri, 19 Feb 2021 03:39:51 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        mark.rutland@arm.com, maz@kernel.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH 8/8] arm64: irq: allow FIQs to be handled
Date:   Fri, 19 Feb 2021 11:39:04 +0000
Message-Id: <20210219113904.41736-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210219113904.41736-1-mark.rutland@arm.com>
References: <20210219113904.41736-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On contemporary platforms we don't use FIQ, and treat any stray FIQ as a
fatal event. However, some platforms have an interrupt controller wired
to FIQ, and need to handle FIQ as part of regular operation.

So that we can support both cases dynamically, this patch updates the
FIQ exception handling code to operate the same way as the IRQ handling
code, with its own handle_arch_fiq handler. Where an FIQ handler is not
registered, an unexpected FIQ exception will trigger the default FIQ
handler, which will panic() as today. Where a FIQ handler is registered,
handling of the FIQ is deferred to that handler.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/irq.h |  1 +
 arch/arm64/kernel/entry.S    | 26 ++++++++++++++++++++++----
 arch/arm64/kernel/irq.c      | 15 +++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 8391c6f6f746..fac08e18bcd5 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -10,6 +10,7 @@ struct pt_regs;
 
 int set_handle_irq(void (*handle_irq)(struct pt_regs *));
 #define set_handle_irq	set_handle_irq
+int set_handle_fiq(void (*handle_fiq)(struct pt_regs *));
 
 static inline int nr_legacy_irqs(void)
 {
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 0474cca9f1a9..a8290bd87a49 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -586,23 +586,23 @@ SYM_CODE_START(vectors)
 
 	kernel_ventry	1, sync				// Synchronous EL1h
 	kernel_ventry	1, irq				// IRQ EL1h
-	kernel_ventry	1, fiq_invalid			// FIQ EL1h
+	kernel_ventry	1, fiq				// FIQ EL1h
 	kernel_ventry	1, error			// Error EL1h
 
 	kernel_ventry	0, sync				// Synchronous 64-bit EL0
 	kernel_ventry	0, irq				// IRQ 64-bit EL0
-	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
+	kernel_ventry	0, fiq				// FIQ 64-bit EL0
 	kernel_ventry	0, error			// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
 	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
 	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
-	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
+	kernel_ventry	0, fiq_compat, 32		// FIQ 32-bit EL0
 	kernel_ventry	0, error_compat, 32		// Error 32-bit EL0
 #else
 	kernel_ventry	0, sync_invalid, 32		// Synchronous 32-bit EL0
 	kernel_ventry	0, irq_invalid, 32		// IRQ 32-bit EL0
-	kernel_ventry	0, fiq_invalid, 32		// FIQ 32-bit EL0
+	kernel_ventry	0, fiq, 32			// FIQ 32-bit EL0
 	kernel_ventry	0, error_invalid, 32		// Error 32-bit EL0
 #endif
 SYM_CODE_END(vectors)
@@ -703,6 +703,12 @@ SYM_CODE_START_LOCAL_NOALIGN(el1_irq)
 	kernel_exit 1
 SYM_CODE_END(el1_irq)
 
+SYM_CODE_START_LOCAL_NOALIGN(el1_fiq)
+	kernel_entry 1
+	el1_interrupt_handler handle_arch_fiq
+	kernel_exit 1
+SYM_CODE_END(el1_fiq)
+
 /*
  * EL0 mode handlers.
  */
@@ -729,6 +735,11 @@ SYM_CODE_START_LOCAL_NOALIGN(el0_irq_compat)
 	b	el0_irq_naked
 SYM_CODE_END(el0_irq_compat)
 
+SYM_CODE_START_LOCAL_NOALIGN(el0_fiq_compat)
+	kernel_entry 0, 32
+	b	el0_fiq_naked
+SYM_CODE_END(el0_fiq_compat)
+
 SYM_CODE_START_LOCAL_NOALIGN(el0_error_compat)
 	kernel_entry 0, 32
 	b	el0_error_naked
@@ -743,6 +754,13 @@ el0_irq_naked:
 	b	ret_to_user
 SYM_CODE_END(el0_irq)
 
+SYM_CODE_START_LOCAL_NOALIGN(el0_fiq)
+	kernel_entry 0
+el0_fiq_naked:
+	el0_interrupt_handler handle_arch_fiq
+	b	ret_to_user
+SYM_CODE_END(el0_fiq)
+
 SYM_CODE_START_LOCAL(el1_error)
 	kernel_entry 1
 	mrs	x1, esr_el1
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 00bcf37aa0ea..bc3215dedf47 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -76,7 +76,13 @@ void default_handle_irq(struct pt_regs *regs)
 	panic("IRQ taken without a registered IRQ controller\n");
 }
 
+void default_handle_fiq(struct pt_regs *regs)
+{
+	panic("FIQ taken without a registered FIQ controller\n");
+}
+
 void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
+void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init = default_handle_fiq;
 
 int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
@@ -87,6 +93,15 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 	return 0;
 }
 
+int __init set_handle_fiq(void (*handle_fiq)(struct pt_regs *))
+{
+	if (handle_arch_fiq != default_handle_fiq)
+		return -EBUSY;
+
+	handle_arch_fiq = handle_fiq;
+	return 0;
+}
+
 void __init init_IRQ(void)
 {
 	init_irq_stacks();
-- 
2.11.0

