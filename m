Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782C832A46D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578099AbhCBKfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:35:38 -0500
Received: from foss.arm.com ([217.140.110.172]:48360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382774AbhCBKPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:15:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41F4F1424;
        Tue,  2 Mar 2021 02:12:35 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B60C3F70D;
        Tue,  2 Mar 2021 02:12:33 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        mark.rutland@arm.com, maz@kernel.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCHv2 6/8] arm64: entry: factor irq triage logic into macros
Date:   Tue,  2 Mar 2021 10:12:09 +0000
Message-Id: <20210302101211.2328-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210302101211.2328-1-mark.rutland@arm.com>
References: <20210302101211.2328-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

In subsequent patches we'll allow an FIQ handler to be registered, and
FIQ exceptions will need to be triaged very similarly to IRQ exceptions.
So that we can reuse the existing logic, this patch factors the IRQ
triage logic out into macros that can be reused for FIQ.

The macros are named to follow the elX_foo_handler scheme used by the C
exception handlers. For consistency with other top-level exception
handlers, the kernel_entry/kernel_exit logic is not moved into the
macros. As FIQ will use a different C handler, this handler name is
provided as an argument to the macros.

There should be no functional change as a result of this patch.

Signed-off-by: Marc Zyngier <maz@kernel.org>
[Mark: rework macros, commit message, rebase before DAIF rework]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/entry.S | 80 +++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a31a0a713c85..e235b0e4e468 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -491,8 +491,8 @@ tsk	.req	x28		// current thread_info
 /*
  * Interrupt handling.
  */
-	.macro	irq_handler
-	ldr_l	x1, handle_arch_irq
+	.macro	irq_handler, handler:req
+	ldr_l	x1, \handler
 	mov	x0, sp
 	irq_stack_entry
 	blr	x1
@@ -531,6 +531,45 @@ alternative_endif
 #endif
 	.endm
 
+	.macro el1_interrupt_handler, handler:req
+	gic_prio_irq_setup pmr=x20, tmp=x1
+	enable_da_f
+
+	mov	x0, sp
+	bl	enter_el1_irq_or_nmi
+
+	irq_handler	\handler
+
+#ifdef CONFIG_PREEMPTION
+	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	/*
+	 * DA_F were cleared at start of handling. If anything is set in DAIF,
+	 * we come back from an NMI, so skip preemption
+	 */
+	mrs	x0, daif
+	orr	x24, x24, x0
+alternative_else_nop_endif
+	cbnz	x24, 1f				// preempt count != 0 || NMI return path
+	bl	arm64_preempt_schedule_irq	// irq en/disable is done inside
+1:
+#endif
+
+	mov	x0, sp
+	bl	exit_el1_irq_or_nmi
+	.endm
+
+	.macro el0_interrupt_handler, handler:req
+	gic_prio_irq_setup pmr=x20, tmp=x0
+	user_exit_irqoff
+	enable_da_f
+
+	tbz	x22, #55, 1f
+	bl	do_el0_irq_bp_hardening
+1:
+	irq_handler	\handler
+	.endm
+
 	.text
 
 /*
@@ -660,32 +699,7 @@ SYM_CODE_END(el1_sync)
 	.align	6
 SYM_CODE_START_LOCAL_NOALIGN(el1_irq)
 	kernel_entry 1
-	gic_prio_irq_setup pmr=x20, tmp=x1
-	enable_da_f
-
-	mov	x0, sp
-	bl	enter_el1_irq_or_nmi
-
-	irq_handler
-
-#ifdef CONFIG_PREEMPTION
-	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
-alternative_if ARM64_HAS_IRQ_PRIO_MASKING
-	/*
-	 * DA_F were cleared at start of handling. If anything is set in DAIF,
-	 * we come back from an NMI, so skip preemption
-	 */
-	mrs	x0, daif
-	orr	x24, x24, x0
-alternative_else_nop_endif
-	cbnz	x24, 1f				// preempt count != 0 || NMI return path
-	bl	arm64_preempt_schedule_irq	// irq en/disable is done inside
-1:
-#endif
-
-	mov	x0, sp
-	bl	exit_el1_irq_or_nmi
-
+	el1_interrupt_handler handle_arch_irq
 	kernel_exit 1
 SYM_CODE_END(el1_irq)
 
@@ -725,15 +739,7 @@ SYM_CODE_END(el0_error_compat)
 SYM_CODE_START_LOCAL_NOALIGN(el0_irq)
 	kernel_entry 0
 el0_irq_naked:
-	gic_prio_irq_setup pmr=x20, tmp=x0
-	user_exit_irqoff
-	enable_da_f
-
-	tbz	x22, #55, 1f
-	bl	do_el0_irq_bp_hardening
-1:
-	irq_handler
-
+	el0_interrupt_handler handle_arch_irq
 	b	ret_to_user
 SYM_CODE_END(el0_irq)
 
-- 
2.11.0

