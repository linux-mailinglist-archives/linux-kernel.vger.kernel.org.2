Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA2438B078
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbhETNwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:52:37 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46505 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241613AbhETNwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:52:23 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FmB2z0sFzz9sV2;
        Thu, 20 May 2021 15:50:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sDVBm8-iu04O; Thu, 20 May 2021 15:50:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FmB2q4d8cz9sTM;
        Thu, 20 May 2021 15:50:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 71AA88B817;
        Thu, 20 May 2021 15:50:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id k3dLpxm9xnWy; Thu, 20 May 2021 15:50:43 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E9648B813;
        Thu, 20 May 2021 15:50:43 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 43D7564C40; Thu, 20 May 2021 13:50:43 +0000 (UTC)
Message-Id: <5f6b9c8c83170ed310953eac2f5b14539bfc964a.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 06/12] powerpc/lib/code-patching: Make
 instr_is_branch_to_addr() static
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 13:50:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

instr_is_branch_to_addr() is only used in code-patching.c

Make it static.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/code-patching.h |  1 -
 arch/powerpc/lib/code-patching.c         | 18 +++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index f1d029bf906e..f9bd1397b696 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -59,7 +59,6 @@ static inline int modify_instruction_site(s32 *site, unsigned int clr, unsigned
 
 int instr_is_relative_branch(struct ppc_inst instr);
 int instr_is_relative_link_branch(struct ppc_inst instr);
-int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr);
 unsigned long branch_target(const struct ppc_inst *instr);
 int translate_branch(struct ppc_inst *instr, const struct ppc_inst *dest,
 		     const struct ppc_inst *src);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 0308429b0d1a..82f2c1edb498 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -367,15 +367,6 @@ unsigned long branch_target(const struct ppc_inst *instr)
 	return 0;
 }
 
-int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr)
-{
-	if (instr_is_branch_iform(ppc_inst_read(instr)) ||
-	    instr_is_branch_bform(ppc_inst_read(instr)))
-		return branch_target(instr) == addr;
-
-	return 0;
-}
-
 int translate_branch(struct ppc_inst *instr, const struct ppc_inst *dest,
 		     const struct ppc_inst *src)
 {
@@ -410,6 +401,15 @@ void __patch_exception(int exc, unsigned long addr)
 
 #ifdef CONFIG_CODE_PATCHING_SELFTEST
 
+static int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr)
+{
+	if (instr_is_branch_iform(ppc_inst_read(instr)) ||
+	    instr_is_branch_bform(ppc_inst_read(instr)))
+		return branch_target(instr) == addr;
+
+	return 0;
+}
+
 static void __init test_trampoline(void)
 {
 	asm ("nop;\n");
-- 
2.25.0

