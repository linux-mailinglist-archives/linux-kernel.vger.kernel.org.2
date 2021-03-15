Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA733B1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCOL5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:57:23 -0400
Received: from foss.arm.com ([217.140.110.172]:35108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhCOL4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:56:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBF02143D;
        Mon, 15 Mar 2021 04:56:50 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84F403F792;
        Mon, 15 Mar 2021 04:56:49 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com
Cc:     james.morse@arm.com, marcan@marcan.st, mark.rutland@arm.com,
        maz@kernel.org, tglx@linutronix.de
Subject: [PATCHv3 6/6] arm64: irq: allow FIQs to be handled
Date:   Mon, 15 Mar 2021 11:56:29 +0000
Message-Id: <20210315115629.57191-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210315115629.57191-1-mark.rutland@arm.com>
References: <20210315115629.57191-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On contemporary platforms we don't use FIQ, and treat any stray FIQ as a
fatal event. However, some platforms have an interrupt controller wired
to FIQ, and need to handle FIQ as part of regular operation.

So that we can support both cases dynamically, this patch updates the
FIQ exception handling code to operate the same way as the IRQ handling
code, with its own handle_arch_fiq handler. Where a root FIQ handler is
not registered, an unexpected FIQ exception will trigger the default FIQ
handler, which will panic() as today. Where a root FIQ handler is
registered, handling of the FIQ is deferred to that handler.

As el0_fiq_invalid_compat is supplanted by el0_fiq, the former is
removed. For !CONFIG_COMPAT builds we never expect to take an exception
from AArch32 EL0, so we keep the common el0_fiq_invalid handler.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Hector Martin <marcan@marcan.st>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/irq.h |  1 +
 arch/arm64/kernel/entry.S    | 30 +++++++++++++++++++++---------
 arch/arm64/kernel/irq.c      | 16 ++++++++++++++++
 3 files changed, 38 insertions(+), 9 deletions(-)

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
index ce8d4dc416fb..a86f50de2c7b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -588,18 +588,18 @@ SYM_CODE_START(vectors)
 
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
@@ -665,12 +665,6 @@ SYM_CODE_START_LOCAL(el0_error_invalid)
 	inv_entry 0, BAD_ERROR
 SYM_CODE_END(el0_error_invalid)
 
-#ifdef CONFIG_COMPAT
-SYM_CODE_START_LOCAL(el0_fiq_invalid_compat)
-	inv_entry 0, BAD_FIQ, 32
-SYM_CODE_END(el0_fiq_invalid_compat)
-#endif
-
 SYM_CODE_START_LOCAL(el1_sync_invalid)
 	inv_entry 1, BAD_SYNC
 SYM_CODE_END(el1_sync_invalid)
@@ -705,6 +699,12 @@ SYM_CODE_START_LOCAL_NOALIGN(el1_irq)
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
@@ -731,6 +731,11 @@ SYM_CODE_START_LOCAL_NOALIGN(el0_irq_compat)
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
@@ -745,6 +750,13 @@ el0_irq_naked:
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
index 2fe0b535de30..bda49430c9ea 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -76,7 +76,13 @@ static void default_handle_irq(struct pt_regs *regs)
 	panic("IRQ taken without a root IRQ handler\n");
 }
 
+static void default_handle_fiq(struct pt_regs *regs)
+{
+	panic("FIQ taken without a root FIQ handler\n");
+}
+
 void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
+void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init = default_handle_fiq;
 
 int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
@@ -88,6 +94,16 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 	return 0;
 }
 
+int __init set_handle_fiq(void (*handle_fiq)(struct pt_regs *))
+{
+	if (handle_arch_fiq != default_handle_fiq)
+		return -EBUSY;
+
+	handle_arch_fiq = handle_fiq;
+	pr_info("Root FIQ handler: %ps\n", handle_fiq);
+	return 0;
+}
+
 void __init init_IRQ(void)
 {
 	init_irq_stacks();
-- 
2.11.0

