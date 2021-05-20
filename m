Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8ED38A7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhETKnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 06:43:09 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59737 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235929AbhETK1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:27:49 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fm5RC5TXYz9sVv;
        Thu, 20 May 2021 12:23:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1MWlCUDGc9fC; Thu, 20 May 2021 12:23:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fm5RB5Y0pz9sVM;
        Thu, 20 May 2021 12:23:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A2FEA8B811;
        Thu, 20 May 2021 12:23:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id x1AVz3B6ZgJe; Thu, 20 May 2021 12:23:02 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FC648B80D;
        Thu, 20 May 2021 12:23:02 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4908C64C44; Thu, 20 May 2021 10:23:02 +0000 (UTC)
Message-Id: <8c92f1d9e825ee47c6f88fe43ad42d2a8cc2ab4a.1621506159.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
References: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 03/12] powerpc/lib/code-patching: Use PPC_RAW_() macros
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 10:23:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding with PPC_INST_ defines, use
PPC_RAW_() macros. It improves readability.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/code-patching.h | 12 +++++-------
 arch/powerpc/kernel/trace/ftrace.c       |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index f1d029bf906e..22957c6068c8 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -73,9 +73,9 @@ void __patch_exception(int exc, unsigned long addr);
 #endif
 
 #define OP_RT_RA_MASK	0xffff0000UL
-#define LIS_R2		(PPC_INST_ADDIS | __PPC_RT(R2))
-#define ADDIS_R2_R12	(PPC_INST_ADDIS | __PPC_RT(R2) | __PPC_RA(R12))
-#define ADDI_R2_R2	(PPC_INST_ADDI  | __PPC_RT(R2) | __PPC_RA(R2))
+#define LIS_R2		(PPC_RAW_LIS(_R2, 0))
+#define ADDIS_R2_R12	(PPC_RAW_ADDIS(_R2, _R12, 0))
+#define ADDI_R2_R2	(PPC_RAW_ADDI(_R2, _R2, 0))
 
 
 static inline unsigned long ppc_function_entry(void *func)
@@ -180,12 +180,10 @@ static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
 #define R2_STACK_OFFSET         40
 #endif
 
-#define PPC_INST_LD_TOC		(PPC_INST_LD  | ___PPC_RT(__REG_R2) | \
-				 ___PPC_RA(__REG_R1) | R2_STACK_OFFSET)
+#define PPC_INST_LD_TOC		PPC_RAW_LD(_R2, _R1, R2_STACK_OFFSET)
 
 /* usually preceded by a mflr r0 */
-#define PPC_INST_STD_LR		(PPC_INST_STD | ___PPC_RS(__REG_R0) | \
-				 ___PPC_RA(__REG_R1) | PPC_LR_STKOFF)
+#define PPC_INST_STD_LR		PPC_RAW_STD(_R0, _R1, PPC_LR_STKOFF)
 #endif /* CONFIG_PPC64 */
 
 #endif /* _ASM_POWERPC_CODE_PATCHING_H */
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index ffe9537195aa..937220310f99 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -203,7 +203,7 @@ __ftrace_make_nop(struct module *mod,
 	}
 
 	if (!ppc_inst_equal(op,  ppc_inst(PPC_INST_LD_TOC))) {
-		pr_err("Expected %08x found %s\n", PPC_INST_LD_TOC, ppc_inst_as_str(op));
+		pr_err("Expected %08lx found %s\n", PPC_INST_LD_TOC, ppc_inst_as_str(op));
 		return -EINVAL;
 	}
 #endif /* CONFIG_MPROFILE_KERNEL */
-- 
2.25.0

