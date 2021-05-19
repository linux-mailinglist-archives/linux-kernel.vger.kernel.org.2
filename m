Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45713891B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354727AbhESOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:46:11 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:35235 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354516AbhESOpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:45:20 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FlbGJ1Fntz9sWd;
        Wed, 19 May 2021 16:43:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n3RrMlL0Ju17; Wed, 19 May 2021 16:43:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FlbGH623Lz9sWc;
        Wed, 19 May 2021 16:43:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A56D58B7F5;
        Wed, 19 May 2021 16:43:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rFW_DNv440R9; Wed, 19 May 2021 16:43:35 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 47DD88B7E0;
        Wed, 19 May 2021 16:43:35 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id ADBA564C3A; Wed, 19 May 2021 14:43:34 +0000 (UTC)
Message-Id: <b9696fca8b47e64a44e4a68e3b0e8f789ff390ae.1621435024.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621435024.git.christophe.leroy@csgroup.eu>
References: <cover.1621435024.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 07/12] powerpc/lib/code-patching: Don't use struct
 'ppc_inst' for runnable code in tests.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 19 May 2021 14:43:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct ppc_inst' is meant to represent an instruction internally, it
is not meant to dereference code in memory.

For testing code patching, use patch_instruction() to properly
write into memory the code to be tested.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/code-patching.c | 95 ++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 82f2c1edb498..508e9511ca96 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -422,9 +422,9 @@ static void __init test_branch_iform(void)
 {
 	int err;
 	struct ppc_inst instr;
-	unsigned long addr;
-
-	addr = (unsigned long)&instr;
+	unsigned int tmp[2];
+	struct ppc_inst *iptr = (struct ppc_inst *)tmp;
+	unsigned long addr = (unsigned long)tmp;
 
 	/* The simplest case, branch to self, no flags */
 	check(instr_is_branch_iform(ppc_inst(0x48000000)));
@@ -445,52 +445,57 @@ static void __init test_branch_iform(void)
 	check(!instr_is_branch_iform(ppc_inst(0x7bfffffd)));
 
 	/* Absolute branch to 0x100 */
-	instr = ppc_inst(0x48000103);
-	check(instr_is_branch_to_addr(&instr, 0x100));
+	patch_instruction(iptr, ppc_inst(0x48000103));
+	check(instr_is_branch_to_addr(iptr, 0x100));
 	/* Absolute branch to 0x420fc */
-	instr = ppc_inst(0x480420ff);
-	check(instr_is_branch_to_addr(&instr, 0x420fc));
+	patch_instruction(iptr, ppc_inst(0x480420ff));
+	check(instr_is_branch_to_addr(iptr, 0x420fc));
 	/* Maximum positive relative branch, + 20MB - 4B */
-	instr = ppc_inst(0x49fffffc);
-	check(instr_is_branch_to_addr(&instr, addr + 0x1FFFFFC));
+	patch_instruction(iptr, ppc_inst(0x49fffffc));
+	check(instr_is_branch_to_addr(iptr, addr + 0x1FFFFFC));
 	/* Smallest negative relative branch, - 4B */
-	instr = ppc_inst(0x4bfffffc);
-	check(instr_is_branch_to_addr(&instr, addr - 4));
+	patch_instruction(iptr, ppc_inst(0x4bfffffc));
+	check(instr_is_branch_to_addr(iptr, addr - 4));
 	/* Largest negative relative branch, - 32 MB */
-	instr = ppc_inst(0x4a000000);
-	check(instr_is_branch_to_addr(&instr, addr - 0x2000000));
+	patch_instruction(iptr, ppc_inst(0x4a000000));
+	check(instr_is_branch_to_addr(iptr, addr - 0x2000000));
 
 	/* Branch to self, with link */
-	err = create_branch(&instr, &instr, addr, BRANCH_SET_LINK);
-	check(instr_is_branch_to_addr(&instr, addr));
+	err = create_branch(&instr, iptr, addr, BRANCH_SET_LINK);
+	patch_instruction(iptr, instr);
+	check(instr_is_branch_to_addr(iptr, addr));
 
 	/* Branch to self - 0x100, with link */
-	err = create_branch(&instr, &instr, addr - 0x100, BRANCH_SET_LINK);
-	check(instr_is_branch_to_addr(&instr, addr - 0x100));
+	err = create_branch(&instr, iptr, addr - 0x100, BRANCH_SET_LINK);
+	patch_instruction(iptr, instr);
+	check(instr_is_branch_to_addr(iptr, addr - 0x100));
 
 	/* Branch to self + 0x100, no link */
-	err = create_branch(&instr, &instr, addr + 0x100, 0);
-	check(instr_is_branch_to_addr(&instr, addr + 0x100));
+	err = create_branch(&instr, iptr, addr + 0x100, 0);
+	patch_instruction(iptr, instr);
+	check(instr_is_branch_to_addr(iptr, addr + 0x100));
 
 	/* Maximum relative negative offset, - 32 MB */
-	err = create_branch(&instr, &instr, addr - 0x2000000, BRANCH_SET_LINK);
-	check(instr_is_branch_to_addr(&instr, addr - 0x2000000));
+	err = create_branch(&instr, iptr, addr - 0x2000000, BRANCH_SET_LINK);
+	patch_instruction(iptr, instr);
+	check(instr_is_branch_to_addr(iptr, addr - 0x2000000));
 
 	/* Out of range relative negative offset, - 32 MB + 4*/
-	err = create_branch(&instr, &instr, addr - 0x2000004, BRANCH_SET_LINK);
+	err = create_branch(&instr, iptr, addr - 0x2000004, BRANCH_SET_LINK);
 	check(err);
 
 	/* Out of range relative positive offset, + 32 MB */
-	err = create_branch(&instr, &instr, addr + 0x2000000, BRANCH_SET_LINK);
+	err = create_branch(&instr, iptr, addr + 0x2000000, BRANCH_SET_LINK);
 	check(err);
 
 	/* Unaligned target */
-	err = create_branch(&instr, &instr, addr + 3, BRANCH_SET_LINK);
+	err = create_branch(&instr, iptr, addr + 3, BRANCH_SET_LINK);
 	check(err);
 
 	/* Check flags are masked correctly */
-	err = create_branch(&instr, &instr, addr, 0xFFFFFFFC);
-	check(instr_is_branch_to_addr(&instr, addr));
+	err = create_branch(&instr, iptr, addr, 0xFFFFFFFC);
+	patch_instruction(iptr, instr);
+	check(instr_is_branch_to_addr(iptr, addr));
 	check(ppc_inst_equal(instr, ppc_inst(0x48000000)));
 }
 
@@ -513,9 +518,10 @@ static void __init test_branch_bform(void)
 	int err;
 	unsigned long addr;
 	struct ppc_inst *iptr, instr;
+	unsigned int tmp[2];
 	unsigned int flags;
 
-	iptr = &instr;
+	iptr = (struct ppc_inst *)tmp;
 	addr = (unsigned long)iptr;
 
 	/* The simplest case, branch to self, no flags */
@@ -528,39 +534,43 @@ static void __init test_branch_bform(void)
 	check(!instr_is_branch_bform(ppc_inst(0x7bffffff)));
 
 	/* Absolute conditional branch to 0x100 */
-	instr = ppc_inst(0x43ff0103);
-	check(instr_is_branch_to_addr(&instr, 0x100));
+	patch_instruction(iptr, ppc_inst(0x43ff0103));
+	check(instr_is_branch_to_addr(iptr, 0x100));
 	/* Absolute conditional branch to 0x20fc */
-	instr = ppc_inst(0x43ff20ff);
-	check(instr_is_branch_to_addr(&instr, 0x20fc));
+	patch_instruction(iptr, ppc_inst(0x43ff20ff));
+	check(instr_is_branch_to_addr(iptr, 0x20fc));
 	/* Maximum positive relative conditional branch, + 32 KB - 4B */
-	instr = ppc_inst(0x43ff7ffc);
-	check(instr_is_branch_to_addr(&instr, addr + 0x7FFC));
+	patch_instruction(iptr, ppc_inst(0x43ff7ffc));
+	check(instr_is_branch_to_addr(iptr, addr + 0x7FFC));
 	/* Smallest negative relative conditional branch, - 4B */
-	instr = ppc_inst(0x43fffffc);
-	check(instr_is_branch_to_addr(&instr, addr - 4));
+	patch_instruction(iptr, ppc_inst(0x43fffffc));
+	check(instr_is_branch_to_addr(iptr, addr - 4));
 	/* Largest negative relative conditional branch, - 32 KB */
-	instr = ppc_inst(0x43ff8000);
-	check(instr_is_branch_to_addr(&instr, addr - 0x8000));
+	patch_instruction(iptr, ppc_inst(0x43ff8000));
+	check(instr_is_branch_to_addr(iptr, addr - 0x8000));
 
 	/* All condition code bits set & link */
 	flags = 0x3ff000 | BRANCH_SET_LINK;
 
 	/* Branch to self */
 	err = create_cond_branch(&instr, iptr, addr, flags);
-	check(instr_is_branch_to_addr(&instr, addr));
+	patch_instruction(iptr, instr);
+	check(instr_is_branch_to_addr(iptr, addr));
 
 	/* Branch to self - 0x100 */
 	err = create_cond_branch(&instr, iptr, addr - 0x100, flags);
-	check(instr_is_branch_to_addr(&instr, addr - 0x100));
+	patch_instruction(iptr, instr);
+	check(instr_is_branch_to_addr(iptr, addr - 0x100));
 
 	/* Branch to self + 0x100 */
 	err = create_cond_branch(&instr, iptr, addr + 0x100, flags);
-	check(instr_is_branch_to_addr(&instr, addr + 0x100));
+	patch_instruction(iptr, instr);
+	check(instr_is_branch_to_addr(iptr, addr + 0x100));
 
 	/* Maximum relative negative offset, - 32 KB */
 	err = create_cond_branch(&instr, iptr, addr - 0x8000, flags);
-	check(instr_is_branch_to_addr(&instr, addr - 0x8000));
+	patch_instruction(iptr, instr);
+	check(instr_is_branch_to_addr(iptr, addr - 0x8000));
 
 	/* Out of range relative negative offset, - 32 KB + 4*/
 	err = create_cond_branch(&instr, iptr, addr - 0x8004, flags);
@@ -576,7 +586,8 @@ static void __init test_branch_bform(void)
 
 	/* Check flags are masked correctly */
 	err = create_cond_branch(&instr, iptr, addr, 0xFFFFFFFC);
-	check(instr_is_branch_to_addr(&instr, addr));
+	patch_instruction(iptr, instr);
+	check(instr_is_branch_to_addr(iptr, addr));
 	check(ppc_inst_equal(instr, ppc_inst(0x43FF0000)));
 }
 
-- 
2.25.0

