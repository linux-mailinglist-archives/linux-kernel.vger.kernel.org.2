Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25B935C572
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhDLLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:42:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26535 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231138AbhDLLm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:42:29 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FJmzx3N7pz9tyR2;
        Mon, 12 Apr 2021 13:42:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gwNBqBJ8OgoL; Mon, 12 Apr 2021 13:42:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FJmzx1sDRz9tyQT;
        Mon, 12 Apr 2021 13:42:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F2028B78E;
        Mon, 12 Apr 2021 13:42:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id i_JtluxN8LDA; Mon, 12 Apr 2021 13:42:10 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BD758B78D;
        Mon, 12 Apr 2021 13:42:10 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D59F967A06; Mon, 12 Apr 2021 11:42:09 +0000 (UTC)
Message-Id: <857ceb23b6a614aea2522e770b067593d5f9e906.1618227677.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 1/4] powerpc: Remove probe_user_read_inst()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 12 Apr 2021 11:42:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its name comes from former probe_user_read() function.
That function is now called copy_from_user_nofault().

probe_user_read_inst() uses copy_from_user_nofault() to read only
a few bytes. It is suboptimal.

It does the same as get_user_inst() but in addition disables
page faults.

But on the other hand, it is not used for the time being. So remove it
for now. If one day it is really needed, we can give it a new name
more in line with today's naming, and implement it using get_user_inst()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/inst.h |  3 ---
 arch/powerpc/lib/inst.c         | 31 -------------------------------
 2 files changed, 34 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 19e18af2fac9..2902d4e6a363 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -175,9 +175,6 @@ static inline char *__ppc_inst_as_str(char str[PPC_INST_STR_LEN], struct ppc_ins
 	__str;				\
 })
 
-int probe_user_read_inst(struct ppc_inst *inst,
-			 struct ppc_inst __user *nip);
-
 int probe_kernel_read_inst(struct ppc_inst *inst,
 			   struct ppc_inst *src);
 
diff --git a/arch/powerpc/lib/inst.c b/arch/powerpc/lib/inst.c
index 9cc17eb62462..c57b3548de37 100644
--- a/arch/powerpc/lib/inst.c
+++ b/arch/powerpc/lib/inst.c
@@ -9,24 +9,6 @@
 #include <asm/ppc-opcode.h>
 
 #ifdef CONFIG_PPC64
-int probe_user_read_inst(struct ppc_inst *inst,
-			 struct ppc_inst __user *nip)
-{
-	unsigned int val, suffix;
-	int err;
-
-	err = copy_from_user_nofault(&val, nip, sizeof(val));
-	if (err)
-		return err;
-	if (get_op(val) == OP_PREFIX) {
-		err = copy_from_user_nofault(&suffix, (void __user *)nip + 4, 4);
-		*inst = ppc_inst_prefix(val, suffix);
-	} else {
-		*inst = ppc_inst(val);
-	}
-	return err;
-}
-
 int probe_kernel_read_inst(struct ppc_inst *inst,
 			   struct ppc_inst *src)
 {
@@ -45,19 +27,6 @@ int probe_kernel_read_inst(struct ppc_inst *inst,
 	return err;
 }
 #else /* !CONFIG_PPC64 */
-int probe_user_read_inst(struct ppc_inst *inst,
-			 struct ppc_inst __user *nip)
-{
-	unsigned int val;
-	int err;
-
-	err = copy_from_user_nofault(&val, nip, sizeof(val));
-	if (!err)
-		*inst = ppc_inst(val);
-
-	return err;
-}
-
 int probe_kernel_read_inst(struct ppc_inst *inst,
 			   struct ppc_inst *src)
 {
-- 
2.25.0

