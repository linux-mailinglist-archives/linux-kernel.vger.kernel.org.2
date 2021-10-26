Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C3D43AF08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhJZJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:28:47 -0400
Received: from foss.arm.com ([217.140.110.172]:55726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235121AbhJZJ2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:28:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17D341396;
        Tue, 26 Oct 2021 02:26:07 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B1553F70D;
        Tue, 26 Oct 2021 02:26:04 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, maz@kernel.org, nickhu@andestech.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org
Subject: [PATCH v2 15/17] irq: riscv: perform irqentry in entry code
Date:   Tue, 26 Oct 2021 10:25:02 +0100
Message-Id: <20211026092504.27071-16-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211026092504.27071-1-mark.rutland@arm.com>
References: <20211026092504.27071-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/riscv
perform all the irqentry accounting in its entry code. As arch/riscv
uses GENERIC_IRQ_MULTI_HANDLER, we can use generic_handle_arch_irq() to
do so.

Since generic_handle_arch_irq() handles the irq entry and setting the
irq regs, and happens before the irqchip code calls handle_IPI(), we can
remove the redundant irq entry and irq regs manipulation from
handle_IPI().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/riscv/Kconfig        | 1 -
 arch/riscv/kernel/entry.S | 3 +--
 arch/riscv/kernel/smp.c   | 9 +--------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 740653063a56..301a54233c7e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -63,7 +63,6 @@ config RISCV
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select HANDLE_DOMAIN_IRQ
-	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 98f502654edd..64236f7efde5 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -130,8 +130,7 @@ skip_context_tracking:
 
 	/* Handle interrupts */
 	move a0, sp /* pt_regs */
-	la a1, handle_arch_irq
-	REG_L a1, (a1)
+	la a1, generic_handle_arch_irq
 	jr a1
 1:
 	/*
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 921d9d7df400..2f6da845c9ae 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -140,12 +140,9 @@ void arch_irq_work_raise(void)
 
 void handle_IPI(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
 	unsigned long *stats = ipi_data[smp_processor_id()].stats;
 
-	irq_enter();
-
 	riscv_clear_ipi();
 
 	while (true) {
@@ -156,7 +153,7 @@ void handle_IPI(struct pt_regs *regs)
 
 		ops = xchg(pending_ipis, 0);
 		if (ops == 0)
-			goto done;
+			return;
 
 		if (ops & (1 << IPI_RESCHEDULE)) {
 			stats[IPI_RESCHEDULE]++;
@@ -189,10 +186,6 @@ void handle_IPI(struct pt_regs *regs)
 		/* Order data access and bit testing. */
 		mb();
 	}
-
-done:
-	irq_exit();
-	set_irq_regs(old_regs);
 }
 
 static const char * const ipi_names[] = {
-- 
2.11.0

