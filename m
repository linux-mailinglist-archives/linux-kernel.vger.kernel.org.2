Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1764C38A813
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhETKqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 06:46:16 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59737 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237066AbhETK3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:29:36 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fm5RD3bTDz9sVt;
        Thu, 20 May 2021 12:23:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M2PemQLadhfP; Thu, 20 May 2021 12:23:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fm5RC4zFGz9sVn;
        Thu, 20 May 2021 12:23:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 909408B811;
        Thu, 20 May 2021 12:23:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id funtmd-tDeQa; Thu, 20 May 2021 12:23:03 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 63F928B80D;
        Thu, 20 May 2021 12:23:03 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4D83364C44; Thu, 20 May 2021 10:23:03 +0000 (UTC)
Message-Id: <4ca2bfdca2f47a293d05f61eb3c4e487ee170f1f.1621506159.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
References: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 04/12] powerpc/signal: Use PPC_RAW_xx() macros
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 10:23:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve readability, use PPC_RAW_xx() macros instead of
open coding. Those macros are self-explanatory so the comments
can go as well.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h |  5 +++--
 arch/powerpc/kernel/signal_32.c       | 11 ++++-------
 arch/powerpc/kernel/signal_64.c       | 15 ++++++---------
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index efabbeb48f4e..003e74827e19 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -275,7 +275,6 @@
 #define PPC_INST_MFSPR_DSCR_USER_MASK	0xfc1ffffe
 #define PPC_INST_MTSPR_DSCR_USER	0x7c0303a6
 #define PPC_INST_MTSPR_DSCR_USER_MASK	0xfc1ffffe
-#define PPC_INST_SC			0x44000002
 #define PPC_INST_STRING			0x7c00042a
 #define PPC_INST_STRING_MASK		0xfc0007fe
 #define PPC_INST_STRING_GEN_MASK	0xfc00067e
@@ -293,7 +292,6 @@
 #define PPC_INST_ADD			0x7c000214
 #define PPC_INST_BLR			0x4e800020
 #define PPC_INST_BCTR			0x4e800420
-#define PPC_INST_BCTRL			0x4e800421
 #define PPC_INST_DIVD			0x7c0003d2
 #define PPC_INST_RLDICR			0x78000004
 #define PPC_INST_ORI			0x60000000
@@ -417,6 +415,8 @@
 #define PPC_RAW_STBCIX(s, a, b)		(0x7c0007aa | __PPC_RS(s) | __PPC_RA(a) | __PPC_RB(b))
 #define PPC_RAW_DCBFPS(a, b)		(0x7c0000ac | ___PPC_RA(a) | ___PPC_RB(b) | (4 << 21))
 #define PPC_RAW_DCBSTPS(a, b)		(0x7c0000ac | ___PPC_RA(a) | ___PPC_RB(b) | (6 << 21))
+#define PPC_RAW_SC()			(0x44000002)
+
 /*
  * Define what the VSX XX1 form instructions will look like, then add
  * the 128 bit load store instructions based on that.
@@ -485,6 +485,7 @@
 #define PPC_RAW_MTLR(r)			(0x7c0803a6 | ___PPC_RT(r))
 #define PPC_RAW_MFLR(t)			(PPC_INST_MFLR | ___PPC_RT(t))
 #define PPC_RAW_BCTR()			(PPC_INST_BCTR)
+#define PPC_RAW_BCTRL()			(0x4e800421)
 #define PPC_RAW_MTCTR(r)		(PPC_INST_MTCTR | ___PPC_RT(r))
 #define PPC_RAW_ADDI(d, a, i)		(PPC_INST_ADDI | ___PPC_RT(d) | ___PPC_RA(a) | IMM_L(i))
 #define PPC_RAW_LI(r, i)		PPC_RAW_ADDI(r, 0, i)
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 8f05ed0da292..a50d091334ea 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -828,10 +828,8 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 		tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp_rt32);
 	} else {
 		tramp = (unsigned long)mctx->mc_pad;
-		/* Set up the sigreturn trampoline: li r0,sigret; sc */
-		unsafe_put_user(PPC_INST_ADDI + __NR_rt_sigreturn, &mctx->mc_pad[0],
-				failed);
-		unsafe_put_user(PPC_INST_SC, &mctx->mc_pad[1], failed);
+		unsafe_put_user(PPC_RAW_LI(_R0, __NR_rt_sigreturn), &mctx->mc_pad[0], failed);
+		unsafe_put_user(PPC_RAW_SC(), &mctx->mc_pad[1], failed);
 		asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
 	}
 	unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
@@ -926,9 +924,8 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 		tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp32);
 	} else {
 		tramp = (unsigned long)mctx->mc_pad;
-		/* Set up the sigreturn trampoline: li r0,sigret; sc */
-		unsafe_put_user(PPC_INST_ADDI + __NR_sigreturn, &mctx->mc_pad[0], failed);
-		unsafe_put_user(PPC_INST_SC, &mctx->mc_pad[1], failed);
+		unsafe_put_user(PPC_RAW_LI(_R0, __NR_sigreturn), &mctx->mc_pad[0], failed);
+		unsafe_put_user(PPC_RAW_SC(), &mctx->mc_pad[1], failed);
 		asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
 	}
 	user_access_end();
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index dca66481d0c2..8425abb8b899 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -618,15 +618,12 @@ static long setup_trampoline(unsigned int syscall, unsigned int __user *tramp)
 	int i;
 	long err = 0;
 
-	/* bctrl # call the handler */
-	err |= __put_user(PPC_INST_BCTRL, &tramp[0]);
-	/* addi r1, r1, __SIGNAL_FRAMESIZE  # Pop the dummy stackframe */
-	err |= __put_user(PPC_INST_ADDI | __PPC_RT(R1) | __PPC_RA(R1) |
-			  (__SIGNAL_FRAMESIZE & 0xffff), &tramp[1]);
-	/* li r0, __NR_[rt_]sigreturn| */
-	err |= __put_user(PPC_INST_ADDI | (syscall & 0xffff), &tramp[2]);
-	/* sc */
-	err |= __put_user(PPC_INST_SC, &tramp[3]);
+	/* Call the handler and pop the dummy stackframe*/
+	err |= __put_user(PPC_RAW_BCTRL(), &tramp[0]);
+	err |= __put_user(PPC_RAW_ADDI(_R1, _R1, __SIGNAL_FRAMESIZE), &tramp[1]);
+
+	err |= __put_user(PPC_RAW_LI(_R0, syscall), &tramp[2]);
+	err |= __put_user(PPC_RAW_SC(), &tramp[3]);
 
 	/* Minimal traceback info */
 	for (i=TRAMP_TRACEBACK; i < TRAMP_SIZE ;i++)
-- 
2.25.0

