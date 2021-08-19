Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ECB3F138E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhHSGbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:31:33 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:39205 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231435AbhHSGbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:31:32 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GqvzF6qHmz9sWT;
        Thu, 19 Aug 2021 08:30:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nPy7X1Q-Z3gN; Thu, 19 Aug 2021 08:30:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GqvzF5tvKz9sWP;
        Thu, 19 Aug 2021 08:30:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D63D8B822;
        Thu, 19 Aug 2021 08:30:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id t8nVhXpLBMk2; Thu, 19 Aug 2021 08:30:49 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7770B8B764;
        Thu, 19 Aug 2021 08:30:49 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6F0F266973; Thu, 19 Aug 2021 06:30:49 +0000 (UTC)
Message-Id: <d8983e24df420eae50a38f46e2459ddd638b0157.1629354625.git.christophe.leroy@csgroup.eu>
In-Reply-To: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629354625.git.christophe.leroy@csgroup.eu>
References: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629354625.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/3] powerpc: Define and use MSR_RI only on non booke/40x
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 19 Aug 2021 06:30:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

40x and BOOKE don't have MSR_RI.

Define MSR_RI only for platforms where it exists. For the other ones,
defines it as BUILD_BUG for C and do not define it for ASM.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/reg.h       | 4 ++++
 arch/powerpc/include/asm/reg_booke.h | 6 +++---
 arch/powerpc/kernel/head_32.h        | 4 ++++
 arch/powerpc/kernel/process.c        | 2 +-
 arch/powerpc/lib/sstep.c             | 2 +-
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index be85cf156a1f..656a9aaa1e8e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -109,7 +109,11 @@
 #ifndef MSR_PMM
 #define MSR_PMM		__MASK(MSR_PMM_LG)	/* Performance monitor */
 #endif
+#if !defined(CONFIG_BOOKE) && !defined(CONFIG_40x)
 #define MSR_RI		__MASK(MSR_RI_LG)	/* Recoverable Exception */
+#elif !defined(__ASSEMBLY__)
+#define MSR_RI		({BUILD_BUG(); 0; })
+#endif
 #define MSR_LE		__MASK(MSR_LE_LG)	/* Little Endian */
 
 #define MSR_TM		__MASK(MSR_TM_LG)	/* Transactional Mem Available */
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 17b8dcd9a40d..6f40a8420ad0 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -38,15 +38,15 @@
 #if defined(CONFIG_PPC_BOOK3E_64)
 #define MSR_64BIT	MSR_CM
 
-#define MSR_		(MSR_ME | MSR_RI | MSR_CE)
+#define MSR_		(MSR_ME | MSR_CE)
 #define MSR_KERNEL	(MSR_ | MSR_64BIT)
 #define MSR_USER32	(MSR_ | MSR_PR | MSR_EE)
 #define MSR_USER64	(MSR_USER32 | MSR_64BIT)
 #elif defined (CONFIG_40x)
-#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
+#define MSR_KERNEL	(MSR_ME|MSR_IR|MSR_DR|MSR_CE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #else
-#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
+#define MSR_KERNEL	(MSR_ME|MSR_CE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #endif
 
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 6b1ec9e3541b..6c5f4183dc8e 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -63,7 +63,11 @@
 	mtspr	SPRN_DAR, r11	/* Tag DAR, to be used in DTLB Error */
 	.endif
 #endif
+#ifdef CONFIG_40x
+	LOAD_REG_IMMEDIATE(r11, MSR_KERNEL) /* re-enable MMU */
+#else
 	LOAD_REG_IMMEDIATE(r11, MSR_KERNEL & ~MSR_RI) /* re-enable MMU */
+#endif
 	mtspr	SPRN_SRR1, r11
 	lis	r11, 1f@h
 	ori	r11, r11, 1f@l
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 185beb290580..5ba72e31de28 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1420,7 +1420,7 @@ static struct regbit msr_bits[] = {
 	{MSR_IR,	"IR"},
 	{MSR_DR,	"DR"},
 	{MSR_PMM,	"PMM"},
-#ifndef CONFIG_BOOKE
+#if !defined(CONFIG_BOOKE) && !defined(CONFIG_40x)
 	{MSR_RI,	"RI"},
 	{MSR_LE,	"LE"},
 #endif
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index d8d5f901cee1..357cc1fb4f67 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -3559,7 +3559,7 @@ int emulate_step(struct pt_regs *regs, struct ppc_inst instr)
 
 	case MTMSR:
 		val = regs->gpr[op.reg];
-		if ((val & MSR_RI) == 0)
+		if (cpu_has_msr_ri() && (val & MSR_RI) == 0)
 			/* can't step mtmsr[d] that would clear MSR_RI */
 			return -1;
 		/* here op.val is the mask of bits to change */
-- 
2.25.0

