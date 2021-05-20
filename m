Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7538A77A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 12:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhETKjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 06:39:15 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49195 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236622AbhETKYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:24:23 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fm5R86kxbz9sVZ;
        Thu, 20 May 2021 12:23:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ngyOS56h54P6; Thu, 20 May 2021 12:23:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fm5R85VQBz9sVM;
        Thu, 20 May 2021 12:23:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 991348B811;
        Thu, 20 May 2021 12:23:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JEWw6BsujQTs; Thu, 20 May 2021 12:23:00 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C7DC8B80D;
        Thu, 20 May 2021 12:23:00 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3D58964C44; Thu, 20 May 2021 10:23:00 +0000 (UTC)
Message-Id: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 01/12] powerpc: Rework PPC_RAW_xxx() macros for prefixed
 instructions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 10:23:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time being, we have PPC_RAW_PLXVP() and PPC_RAW_PSTXVP() which
provide a 64 bits value, and then it gets split by open coding to
format it into a 'struct ppc_inst' instruction.

Instead, define a PPC_RAW_xxx_P() and a PPC_RAW_xxx_S() to be used
as is.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 8 ++++----
 arch/powerpc/lib/test_emulate_step.c  | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index ac41776661e9..403067ba170e 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -404,10 +404,10 @@
 #define PPC_RAW_STXVP(xsp, a, i)	(0x18000001 | __PPC_XSP(xsp) | ___PPC_RA(a) | IMM_DQ(i))
 #define PPC_RAW_LXVPX(xtp, a, b)	(0x7c00029a | __PPC_XTP(xtp) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_STXVPX(xsp, a, b)	(0x7c00039a | __PPC_XSP(xsp) | ___PPC_RA(a) | ___PPC_RB(b))
-#define PPC_RAW_PLXVP(xtp, i, a, pr) \
-	((PPC_PREFIX_8LS | __PPC_PRFX_R(pr) | IMM_D0(i)) << 32 | (0xe8000000 | __PPC_XTP(xtp) | ___PPC_RA(a) | IMM_D1(i)))
-#define PPC_RAW_PSTXVP(xsp, i, a, pr) \
-	((PPC_PREFIX_8LS | __PPC_PRFX_R(pr) | IMM_D0(i)) << 32 | (0xf8000000 | __PPC_XSP(xsp) | ___PPC_RA(a) | IMM_D1(i)))
+#define PPC_RAW_PLXVP_P(xtp, i, a, pr)	(PPC_PREFIX_8LS | __PPC_PRFX_R(pr) | IMM_D0(i))
+#define PPC_RAW_PLXVP_S(xtp, i, a, pr)	(0xe8000000 | __PPC_XTP(xtp) | ___PPC_RA(a) | IMM_D1(i))
+#define PPC_RAW_PSTXVP_P(xsp, i, a, pr)	(PPC_PREFIX_8LS | __PPC_PRFX_R(pr) | IMM_D0(i))
+#define PPC_RAW_PSTXVP_S(xsp, i, a, pr)	(0xf8000000 | __PPC_XSP(xsp) | ___PPC_RA(a) | IMM_D1(i))
 #define PPC_RAW_NAP			(0x4c000364)
 #define PPC_RAW_SLEEP			(0x4c0003a4)
 #define PPC_RAW_WINKLE			(0x4c0003e4)
diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index 783d1b85ecfe..f7c74f4f684b 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -824,8 +824,7 @@ static void __init test_plxvp_pstxvp(void)
 	 * XTp = 32xTX + 2xTp
 	 * let RA=3 R=0 D=d0||d1=0 R=0 Tp=1 TX=1
 	 */
-	instr = ppc_inst_prefix(PPC_RAW_PLXVP(34, 0, 3, 0) >> 32,
-			PPC_RAW_PLXVP(34, 0, 3, 0) & 0xffffffff);
+	instr = ppc_inst_prefix(PPC_RAW_PLXVP_P(34, 0, 3, 0), PPC_RAW_PLXVP_S(34, 0, 3, 0));
 
 	stepped = emulate_step(&regs, instr);
 	if (stepped == 1 && cpu_has_feature(CPU_FTR_VSX)) {
@@ -853,8 +852,7 @@ static void __init test_plxvp_pstxvp(void)
 	 * XSp = 32xSX + 2xSp
 	 * let RA=3 D=d0||d1=0 R=0 Sp=1 SX=1
 	 */
-	instr = ppc_inst_prefix(PPC_RAW_PSTXVP(34, 0, 3, 0) >> 32,
-			PPC_RAW_PSTXVP(34, 0, 3, 0) & 0xffffffff);
+	instr = ppc_inst_prefix(PPC_RAW_PSTXVP_P(34, 0, 3, 0), PPC_RAW_PSTXVP_S(34, 0, 3, 0));
 
 	stepped = emulate_step(&regs, instr);
 
-- 
2.25.0

