Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDEB3F1C84
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbhHSPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:21:49 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:37403 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239492AbhHSPVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:21:48 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Gr7lB5Jntz9sTf;
        Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8-HapuuuVvve; Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Gr7lB4PCtz9sTb;
        Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6330B8B842;
        Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id i2TXcgzTbkic; Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 460738B837;
        Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 03B7166958; Thu, 19 Aug 2021 15:21:09 +0000 (UTC)
Message-Id: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629386461.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/3] powerpc: Remove MSR_PR check in
 interrupt_exit_{user/kernel}_prepare()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 19 Aug 2021 15:21:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In those hot functions that are called at every interrupt, any saved
cycle is worth it.

interrupt_exit_user_prepare() and interrupt_exit_kernel_prepare() are
called from three places:
- From entry_32.S
- From interrupt_64.S
- From interrupt_exit_user_restart() and interrupt_exit_kernel_restart()

In entry_32.S, there are inambiguously called based on MSR_PR:

	interrupt_return:
		lwz	r4,_MSR(r1)
		addi	r3,r1,STACK_FRAME_OVERHEAD
		andi.	r0,r4,MSR_PR
		beq	.Lkernel_interrupt_return
		bl	interrupt_exit_user_prepare
	...
	.Lkernel_interrupt_return:
		bl	interrupt_exit_kernel_prepare

In interrupt_64.S, that's similar:

	interrupt_return_\srr\():
		ld	r4,_MSR(r1)
		andi.	r0,r4,MSR_PR
		beq	interrupt_return_\srr\()_kernel
	interrupt_return_\srr\()_user: /* make backtraces match the _kernel variant */
		addi	r3,r1,STACK_FRAME_OVERHEAD
		bl	interrupt_exit_user_prepare
	...
	interrupt_return_\srr\()_kernel:
		addi	r3,r1,STACK_FRAME_OVERHEAD
		bl	interrupt_exit_kernel_prepare

In interrupt_exit_user_restart() and interrupt_exit_kernel_restart(),
MSR_PR is verified respectively by BUG_ON(!user_mode(regs)) and
BUG_ON(user_mode(regs)) prior to calling interrupt_exit_user_prepare()
and interrupt_exit_kernel_prepare().

The verification in interrupt_exit_user_prepare() and
interrupt_exit_kernel_prepare() are therefore useless and can be removed.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/interrupt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 21bbd615ca41..f26caf911ab5 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -465,7 +465,6 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 
 	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
 		BUG_ON(!(regs->msr & MSR_RI));
-	BUG_ON(!(regs->msr & MSR_PR));
 	BUG_ON(arch_irq_disabled_regs(regs));
 	CT_WARN_ON(ct_state() == CONTEXT_USER);
 
@@ -499,7 +498,6 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x) &&
 	    unlikely(!(regs->msr & MSR_RI)))
 		unrecoverable_exception(regs);
-	BUG_ON(regs->msr & MSR_PR);
 	/*
 	 * CT_WARN_ON comes here via program_check_exception,
 	 * so avoid recursion.
-- 
2.25.0

