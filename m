Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72AA38B074
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbhETNw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:52:28 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46505 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241325AbhETNwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:52:17 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FmB2x1FX6z9sV0;
        Thu, 20 May 2021 15:50:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9BEWmOeTRV8w; Thu, 20 May 2021 15:50:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FmB2q032xz9sTd;
        Thu, 20 May 2021 15:50:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C84ED8B819;
        Thu, 20 May 2021 15:50:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MnFqMZZHvmmN; Thu, 20 May 2021 15:50:42 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5AF6D8B808;
        Thu, 20 May 2021 15:50:42 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 39F5064C40; Thu, 20 May 2021 13:50:42 +0000 (UTC)
Message-Id: <c9a1201dd0a66b4a0f91f0fb46d9385cbf030feb.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 05/12] powerpc: Do not dereference code as 'struct
 ppc_inst' (uprobe, code-patching, feature-fixups)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 13:50:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct ppc_inst' is an internal structure to represent an instruction,
it is not directly the representation of that instruction in text code.
It is not meant to map and dereference code.

Dereferencing code directly through 'struct ppc_inst' has two main issues:
- On powerpc, structs are expected to be 8 bytes aligned while code is
spread every 4 byte.
- Should a non prefixed instruction lie at the end of the page and the
following page not be mapped, it would generate a page fault.

In-memory code must be accessed with ppc_inst_read().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/uprobes.c     | 2 +-
 arch/powerpc/lib/code-patching.c  | 8 ++++----
 arch/powerpc/lib/feature-fixups.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
index 186f69b11e94..46971bb41d05 100644
--- a/arch/powerpc/kernel/uprobes.c
+++ b/arch/powerpc/kernel/uprobes.c
@@ -42,7 +42,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
 		return -EINVAL;
 
 	if (cpu_has_feature(CPU_FTR_ARCH_31) &&
-	    ppc_inst_prefixed(auprobe->insn) &&
+	    ppc_inst_prefixed(ppc_inst_read(&auprobe->insn)) &&
 	    (addr & 0x3f) == 60) {
 		pr_info_ratelimited("Cannot register a uprobe on 64 byte unaligned prefixed instruction\n");
 		return -EINVAL;
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 870b30d9be2f..0308429b0d1a 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -329,13 +329,13 @@ static unsigned long branch_iform_target(const struct ppc_inst *instr)
 {
 	signed long imm;
 
-	imm = ppc_inst_val(*instr) & 0x3FFFFFC;
+	imm = ppc_inst_val(ppc_inst_read(instr)) & 0x3FFFFFC;
 
 	/* If the top bit of the immediate value is set this is negative */
 	if (imm & 0x2000000)
 		imm -= 0x4000000;
 
-	if ((ppc_inst_val(*instr) & BRANCH_ABSOLUTE) == 0)
+	if ((ppc_inst_val(ppc_inst_read(instr)) & BRANCH_ABSOLUTE) == 0)
 		imm += (unsigned long)instr;
 
 	return (unsigned long)imm;
@@ -345,13 +345,13 @@ static unsigned long branch_bform_target(const struct ppc_inst *instr)
 {
 	signed long imm;
 
-	imm = ppc_inst_val(*instr) & 0xFFFC;
+	imm = ppc_inst_val(ppc_inst_read(instr)) & 0xFFFC;
 
 	/* If the top bit of the immediate value is set this is negative */
 	if (imm & 0x8000)
 		imm -= 0x10000;
 
-	if ((ppc_inst_val(*instr) & BRANCH_ABSOLUTE) == 0)
+	if ((ppc_inst_val(ppc_inst_read(instr)) & BRANCH_ABSOLUTE) == 0)
 		imm += (unsigned long)instr;
 
 	return (unsigned long)imm;
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index fe26f2fa0f3f..8905b53109bc 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -51,7 +51,7 @@ static int patch_alt_instruction(struct ppc_inst *src, struct ppc_inst *dest,
 
 	instr = ppc_inst_read(src);
 
-	if (instr_is_relative_branch(*src)) {
+	if (instr_is_relative_branch(ppc_inst_read(src))) {
 		struct ppc_inst *target = (struct ppc_inst *)branch_target(src);
 
 		/* Branch within the section doesn't need translating */
-- 
2.25.0

