Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F6443AFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhJZKSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60688 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbhJZKSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:23 -0400
Date:   Tue, 26 Oct 2021 10:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Y/U8ANWUcxwSRZRyOjgfZMOKPBnl8MCXz3uFDj4HzBg=;
        b=yyVGa19vL4wyAvUqoEQEhwlIpfoqjO75DxYfNbWK3R5zIAUFSz9B8+H7y3eDnL+Fts64Zu
        XKmfxeo5OUMUF5WA2zzmltRNMaxbMU74I4+erAsX7TT1OBdeawvsy27X08IAmUdITp32Uk
        A828dHxFhYm01alu4HQ9vR577rqP2ONz3FCh014rEneCzsXGIB5GQJDGkEKJmaQkkzVZNz
        lTck5FN9AuCCAN0jCnwyFwhCToMbJpnRSvCWsqP5XbDx3WnuGm9ej4gFftJsZI3glnTxLI
        QbxNaI3czGdCpPbfn+R1SzAgV3L4z5F0s+omo0z8u3PtjgHUT6rsqIuHCpC+Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Y/U8ANWUcxwSRZRyOjgfZMOKPBnl8MCXz3uFDj4HzBg=;
        b=o6ClpCfDJVnQzIKUW8sRpcqrv4/QPhZ0YgG38SYkRBcSBOdNa1uzfjXF13AEYDJ03LJ5Um
        dVQJF2WKDgf2sUDw==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: riscv: perform irqentry in entry code
Cc:     Mark Rutland <mark.rutland@arm.com>, Guo Ren <guoren@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524335823.626.3244517543787862921.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     7ecbc648102f2fa80d2aefb75b7f8b482f1a4483
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/7ecbc648102f2fa80d2aefb75b7f8b482f1a4483
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 20 Oct 2021 11:33:49 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Tue, 26 Oct 2021 10:13:29 +01:00

irq: riscv: perform irqentry in entry code

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
 arch/riscv/Kconfig        |  1 -
 arch/riscv/kernel/entry.S |  3 +--
 arch/riscv/kernel/smp.c   |  9 +--------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7406530..301a542 100644
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
index 98f5026..64236f7 100644
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
index 921d9d7..2f6da84 100644
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
