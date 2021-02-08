Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE631394B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 17:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhBHQZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 11:25:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:3583 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233366AbhBHPMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:12:54 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZ8bR1nTyzB09ZD;
        Mon,  8 Feb 2021 16:10:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4cwNbu17HKuW; Mon,  8 Feb 2021 16:10:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZ8bR128pzB09ZC;
        Mon,  8 Feb 2021 16:10:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 73EE28B7C0;
        Mon,  8 Feb 2021 16:10:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jWipu8pVH-qT; Mon,  8 Feb 2021 16:10:32 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DCDE08B7BA;
        Mon,  8 Feb 2021 16:10:31 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BDF626733E; Mon,  8 Feb 2021 15:10:31 +0000 (UTC)
Message-Id: <67820fada8dd6a8fe9d7b666f175d4cc9d8de87e.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612796617.git.christophe.leroy@csgroup.eu>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 12/22] powerpc/syscall: Change condition to check MSR_RI
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  8 Feb 2021 15:10:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In system_call_exception(), MSR_RI also needs to be checked on 8xx.
Only booke and 40x doesn't have MSR_RI.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5: Also in interrupt exit prepare
---
 arch/powerpc/kernel/interrupt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 1a2dec49f811..107ec39f05cb 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -39,7 +39,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 
 	trace_hardirqs_off(); /* finish reconciling */
 
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
+	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
 		BUG_ON(!(regs->msr & MSR_RI));
 	BUG_ON(!(regs->msr & MSR_PR));
 	BUG_ON(!FULL_REGS(regs));
@@ -338,7 +338,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
 	unsigned long flags;
 	unsigned long ret = 0;
 
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
+	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
 		BUG_ON(!(regs->msr & MSR_RI));
 	BUG_ON(!(regs->msr & MSR_PR));
 	BUG_ON(!FULL_REGS(regs));
@@ -436,7 +436,8 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	unsigned long amr;
 #endif
 
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && unlikely(!(regs->msr & MSR_RI)))
+	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x) &&
+	    unlikely(!(regs->msr & MSR_RI)))
 		unrecoverable_exception(regs);
 	BUG_ON(regs->msr & MSR_PR);
 	BUG_ON(!FULL_REGS(regs));
-- 
2.25.0

