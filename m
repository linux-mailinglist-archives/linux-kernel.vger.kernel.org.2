Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4138B085
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbhETNxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:53:46 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46505 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234831AbhETNxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:53:25 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FmB382YT6z9sTp;
        Thu, 20 May 2021 15:51:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zdD4Mets5ZeE; Thu, 20 May 2021 15:51:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FmB2x6YHLz9sTd;
        Thu, 20 May 2021 15:50:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C339D8B808;
        Thu, 20 May 2021 15:50:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id y3gveetMcaH2; Thu, 20 May 2021 15:50:49 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F4BE8B767;
        Thu, 20 May 2021 15:50:49 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 838BC64C40; Thu, 20 May 2021 13:50:49 +0000 (UTC)
Message-Id: <5a167b8ba4d33a5c09cd504f0c862e25ffe85459.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 12/12] powerpc/optprobes: use PPC_RAW_ macros
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 13:50:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PPC_RAW_ macros to simplify the code.

And use PPC_LO/PPC_HI instead of IMM_L/IMM_H which are for
internal use inside ppc-opcode.h

Those macros are self explanatory, comments can go as well.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 11 ++++----
 arch/powerpc/kernel/optprobes.c       | 39 +++++----------------------
 2 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index ac41776661e9..87802e8073e6 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -261,9 +261,6 @@
 #define PPC_INST_BCTR			0x4e800420
 #define PPC_INST_BCTRL			0x4e800421
 #define PPC_INST_DIVD			0x7c0003d2
-#define PPC_INST_RLDICR			0x78000004
-#define PPC_INST_ORI			0x60000000
-#define PPC_INST_ORIS			0x64000000
 #define PPC_INST_BRANCH			0x48000000
 #define PPC_INST_BL			0x48000001
 #define PPC_INST_BRANCH_COND		0x40800000
@@ -323,6 +320,8 @@
 #define PPC_LO(v)	((v) & 0xffff)
 #define PPC_HI(v)	(((v) >> 16) & 0xffff)
 #define PPC_HA(v)	PPC_HI((v) + 0x8000)
+#define PPC_HIGHER(v)	(((v) >> 32) & 0xffff)
+#define PPC_HIGHEST(v)	(((v) >> 48) & 0xffff)
 
 /*
  * Only use the larx hint bit on 64bit CPUs. e500v1/v2 based CPUs will treat a
@@ -499,8 +498,8 @@
 #define PPC_RAW_AND_DOT(d, a, b)	(0x7c000039 | ___PPC_RA(d) | ___PPC_RS(a) | ___PPC_RB(b))
 #define PPC_RAW_OR(d, a, b)		(0x7c000378 | ___PPC_RA(d) | ___PPC_RS(a) | ___PPC_RB(b))
 #define PPC_RAW_MR(d, a)		PPC_RAW_OR(d, a, a)
-#define PPC_RAW_ORI(d, a, i)		(PPC_INST_ORI | ___PPC_RA(d) | ___PPC_RS(a) | IMM_L(i))
-#define PPC_RAW_ORIS(d, a, i)		(PPC_INST_ORIS | ___PPC_RA(d) | ___PPC_RS(a) | IMM_L(i))
+#define PPC_RAW_ORI(d, a, i)		(0x60000000 | ___PPC_RA(d) | ___PPC_RS(a) | IMM_L(i))
+#define PPC_RAW_ORIS(d, a, i)		(0x64000000 | ___PPC_RA(d) | ___PPC_RS(a) | IMM_L(i))
 #define PPC_RAW_NOR(d, a, b)		(0x7c0000f8 | ___PPC_RA(d) | ___PPC_RS(a) | ___PPC_RB(b))
 #define PPC_RAW_XOR(d, a, b)		(0x7c000278 | ___PPC_RA(d) | ___PPC_RS(a) | ___PPC_RB(b))
 #define PPC_RAW_XORI(d, a, i)		(0x68000000 | ___PPC_RA(d) | ___PPC_RS(a) | IMM_L(i))
@@ -519,7 +518,7 @@
 					(0x54000001 | ___PPC_RA(d) | ___PPC_RS(a) | __PPC_SH(i) | __PPC_MB(mb) | __PPC_ME(me))
 #define PPC_RAW_RLWIMI(d, a, i, mb, me) (0x50000000 | ___PPC_RA(d) | ___PPC_RS(a) | __PPC_SH(i) | __PPC_MB(mb) | __PPC_ME(me))
 #define PPC_RAW_RLDICL(d, a, i, mb)     (0x78000000 | ___PPC_RA(d) | ___PPC_RS(a) | __PPC_SH64(i) | __PPC_MB64(mb))
-#define PPC_RAW_RLDICR(d, a, i, me)     (PPC_INST_RLDICR | ___PPC_RA(d) | ___PPC_RS(a) | __PPC_SH64(i) | __PPC_ME64(me))
+#define PPC_RAW_RLDICR(d, a, i, me)     (0x78000004 | ___PPC_RA(d) | ___PPC_RS(a) | __PPC_SH64(i) | __PPC_ME64(me))
 
 /* slwi = rlwinm Rx, Ry, n, 0, 31-n */
 #define PPC_RAW_SLWI(d, a, i)		PPC_RAW_RLWINM(d, a, i, 0, 31-(i))
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 9c1c8de8c06d..1488d4e9b34d 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -137,10 +137,8 @@ void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
 
 static void patch_imm32_load_insns(unsigned long val, int reg, kprobe_opcode_t *addr)
 {
-	patch_instruction(addr, ppc_inst(PPC_RAW_LIS(reg, IMM_H(val))));
-	addr++;
-
-	patch_instruction(addr, ppc_inst(PPC_RAW_ORI(reg, reg, IMM_L(val))));
+	patch_instruction(addr++, ppc_inst(PPC_RAW_LIS(reg, PPC_HI(val))));
+	patch_instruction(addr, ppc_inst(PPC_RAW_ORI(reg, reg, PPC_LO(val))));
 }
 
 /*
@@ -149,34 +147,11 @@ static void patch_imm32_load_insns(unsigned long val, int reg, kprobe_opcode_t *
  */
 static void patch_imm64_load_insns(unsigned long long val, int reg, kprobe_opcode_t *addr)
 {
-	/* lis reg,(op)@highest */
-	patch_instruction(addr,
-			  ppc_inst(PPC_INST_ADDIS | ___PPC_RT(reg) |
-				   ((val >> 48) & 0xffff)));
-	addr++;
-
-	/* ori reg,reg,(op)@higher */
-	patch_instruction(addr,
-			  ppc_inst(PPC_INST_ORI | ___PPC_RA(reg) |
-				   ___PPC_RS(reg) | ((val >> 32) & 0xffff)));
-	addr++;
-
-	/* rldicr reg,reg,32,31 */
-	patch_instruction(addr,
-			  ppc_inst(PPC_INST_RLDICR | ___PPC_RA(reg) |
-				   ___PPC_RS(reg) | __PPC_SH64(32) | __PPC_ME64(31)));
-	addr++;
-
-	/* oris reg,reg,(op)@h */
-	patch_instruction(addr,
-			  ppc_inst(PPC_INST_ORIS | ___PPC_RA(reg) |
-				   ___PPC_RS(reg) | ((val >> 16) & 0xffff)));
-	addr++;
-
-	/* ori reg,reg,(op)@l */
-	patch_instruction(addr,
-			  ppc_inst(PPC_INST_ORI | ___PPC_RA(reg) |
-				   ___PPC_RS(reg) | (val & 0xffff)));
+	patch_instruction(addr++, ppc_inst(PPC_RAW_LIS(reg, PPC_HIGHEST(val))));
+	patch_instruction(addr++, ppc_inst(PPC_RAW_ORI(reg, reg, PPC_HIGHER(val))));
+	patch_instruction(addr++, ppc_inst(PPC_RAW_SLDI(reg, reg, 32)));
+	patch_instruction(addr++, ppc_inst(PPC_RAW_ORIS(reg, reg, PPC_HI(val))));
+	patch_instruction(addr, ppc_inst(PPC_RAW_ORI(reg, reg, PPC_LO(val))));
 }
 
 static void patch_imm_load_insns(unsigned long val, int reg, kprobe_opcode_t *addr)
-- 
2.25.0

