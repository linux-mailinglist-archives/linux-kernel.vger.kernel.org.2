Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1EF365AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhDTOCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:02:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2862 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhDTOCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:02:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FPljn6cbjz9v0Dy;
        Tue, 20 Apr 2021 16:02:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id w5X7gkbZO2QL; Tue, 20 Apr 2021 16:02:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FPljn5sLLz9v0Dw;
        Tue, 20 Apr 2021 16:02:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 334188B807;
        Tue, 20 Apr 2021 16:02:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VkjBHKdmV6jb; Tue, 20 Apr 2021 16:02:07 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D40178B7ED;
        Tue, 20 Apr 2021 16:02:06 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 42F8F67A48; Tue, 20 Apr 2021 14:02:06 +0000 (UTC)
Message-Id: <22cadf29620664b600b82026d2a72b8b23351777.1618927318.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/2] powerpc/inst: ppc_inst_as_u64() becomes
 ppc_inst_as_ulong()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 20 Apr 2021 14:02:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simplify use on PPC32, change ppc_inst_as_u64()
into ppc_inst_as_ulong() that returns the 32 bits instruction
on PPC32.

Will be used when porting OPTPROBES to PPC32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/inst.h  | 13 +++++++------
 arch/powerpc/kernel/optprobes.c  |  2 +-
 arch/powerpc/lib/code-patching.c |  2 +-
 arch/powerpc/xmon/xmon.c         |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 19e18af2fac9..9646c63f7420 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -147,13 +147,14 @@ static inline struct ppc_inst *ppc_inst_next(void *location, struct ppc_inst *va
 	return location + ppc_inst_len(tmp);
 }
 
-static inline u64 ppc_inst_as_u64(struct ppc_inst x)
+static inline unsigned long ppc_inst_as_ulong(struct ppc_inst x)
 {
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-	return (u64)ppc_inst_suffix(x) << 32 | ppc_inst_val(x);
-#else
-	return (u64)ppc_inst_val(x) << 32 | ppc_inst_suffix(x);
-#endif
+	if (IS_ENABLED(CONFIG_PPC32))
+		return ppc_inst_val(x);
+	else if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
+		return (u64)ppc_inst_suffix(x) << 32 | ppc_inst_val(x);
+	else
+		return (u64)ppc_inst_val(x) << 32 | ppc_inst_suffix(x);
 }
 
 #define PPC_INST_STR_LEN sizeof("00000000 00000000")
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 7f7cdbeacd1a..58fdb9f66e0f 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -264,7 +264,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	 * 3. load instruction to be emulated into relevant register, and
 	 */
 	temp = ppc_inst_read((struct ppc_inst *)p->ainsn.insn);
-	patch_imm64_load_insns(ppc_inst_as_u64(temp), 4, buff + TMPL_INSN_IDX);
+	patch_imm64_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
 
 	/*
 	 * 4. branch back from trampoline
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 65aec4d6d9ba..870b30d9be2f 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -26,7 +26,7 @@ static int __patch_instruction(struct ppc_inst *exec_addr, struct ppc_inst instr
 
 		__put_kernel_nofault(patch_addr, &val, u32, failed);
 	} else {
-		u64 val = ppc_inst_as_u64(instr);
+		u64 val = ppc_inst_as_ulong(instr);
 
 		__put_kernel_nofault(patch_addr, &val, u64, failed);
 	}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a619b9ed8458..ff2b92bfeedc 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2953,7 +2953,7 @@ generic_inst_dump(unsigned long adr, long count, int praddr,
 		if (!ppc_inst_prefixed(inst))
 			dump_func(ppc_inst_val(inst), adr);
 		else
-			dump_func(ppc_inst_as_u64(inst), adr);
+			dump_func(ppc_inst_as_ulong(inst), adr);
 		printf("\n");
 	}
 	return adr - first_adr;
-- 
2.25.0

