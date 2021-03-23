Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C81E346346
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhCWPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:48:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52849 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233029AbhCWPsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:48:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F4bNv0QZJz9v1CM;
        Tue, 23 Mar 2021 16:47:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yKZo8PO8EepR; Tue, 23 Mar 2021 16:47:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F4bNt676Xz9v1CL;
        Tue, 23 Mar 2021 16:47:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 55FF58B7FA;
        Tue, 23 Mar 2021 16:48:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1ohfYHHR3z24; Tue, 23 Mar 2021 16:48:00 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F0268B7F4;
        Tue, 23 Mar 2021 16:48:00 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E927D675EC; Tue, 23 Mar 2021 15:47:59 +0000 (UTC)
Message-Id: <828348da7868eda953ce023994404dfc49603b64.1616514473.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Switch to relative jump labels
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 23 Mar 2021 15:47:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert powerpc to relative jump labels.

Before the patch, pseries_defconfig vmlinux.o has:
9074 __jump_table  0003f2a0  0000000000000000  0000000000000000  01321fa8  2**0

With the patch, the same config gets:
9074 __jump_table  0002a0e0  0000000000000000  0000000000000000  01321fb4  2**0

Size is 258720 without the patch, 172256 with the patch.
That's a 33% size reduction.

Largely copied from commit c296146c058c ("arm64/kernel: jump_label:
Switch to relative references")

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                  |  1 +
 arch/powerpc/include/asm/jump_label.h | 21 ++++++---------------
 arch/powerpc/kernel/jump_label.c      |  4 ++--
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d46db0bfb998..a52938c0f85b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -182,6 +182,7 @@ config PPC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KGDB
diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index 09297ec9fa52..2d5c6bec2b4f 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -20,7 +20,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	asm_volatile_goto("1:\n\t"
 		 "nop # arch_static_branch\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
+		 ".long 1b - ., %l[l_yes] - .\n\t"
+		 JUMP_ENTRY_TYPE "%c0 - .\n\t"
 		 ".popsection \n\t"
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
 
@@ -34,7 +35,8 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	asm_volatile_goto("1:\n\t"
 		 "b %l[l_yes] # arch_static_branch_jump\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
+		 ".long 1b - ., %l[l_yes] - .\n\t"
+		 JUMP_ENTRY_TYPE "%c0 - .\n\t"
 		 ".popsection \n\t"
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
 
@@ -43,23 +45,12 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
-#ifdef CONFIG_PPC64
-typedef u64 jump_label_t;
-#else
-typedef u32 jump_label_t;
-#endif
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #else
 #define ARCH_STATIC_BRANCH(LABEL, KEY)		\
 1098:	nop;					\
 	.pushsection __jump_table, "aw";	\
-	FTR_ENTRY_LONG 1098b, LABEL, KEY;	\
+	.long 1098b - ., LABEL - .;		\
+	FTR_ENTRY_LONG KEY;			\
 	.popsection
 #endif
 
diff --git a/arch/powerpc/kernel/jump_label.c b/arch/powerpc/kernel/jump_label.c
index 144858027fa3..ce87dc5ea23c 100644
--- a/arch/powerpc/kernel/jump_label.c
+++ b/arch/powerpc/kernel/jump_label.c
@@ -11,10 +11,10 @@
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
-	struct ppc_inst *addr = (struct ppc_inst *)(unsigned long)entry->code;
+	struct ppc_inst *addr = (struct ppc_inst *)jump_entry_code(entry);
 
 	if (type == JUMP_LABEL_JMP)
-		patch_branch(addr, entry->target, 0);
+		patch_branch(addr, jump_entry_target(entry), 0);
 	else
 		patch_instruction(addr, ppc_inst(PPC_INST_NOP));
 }
-- 
2.25.0

