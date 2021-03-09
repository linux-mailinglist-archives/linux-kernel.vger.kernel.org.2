Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADA63324E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhCIMKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:10:42 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40249 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhCIMJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:09:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DvvCj6RSxz9tyjH;
        Tue,  9 Mar 2021 13:09:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tUGXqfuo8RMi; Tue,  9 Mar 2021 13:09:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DvvCj5fBvz9tyjG;
        Tue,  9 Mar 2021 13:09:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F7E68B802;
        Tue,  9 Mar 2021 13:09:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rsZM9YlbXIn1; Tue,  9 Mar 2021 13:09:54 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B91EB8B7FC;
        Tue,  9 Mar 2021 13:09:54 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9A72367555; Tue,  9 Mar 2021 12:09:54 +0000 (UTC)
Message-Id: <b2878184d4c21faa8af55b60e52c83f391272112.1615291473.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615291471.git.christophe.leroy@csgroup.eu>
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 28/43] powerpc/64e: Call bad_page_fault() from
 do_page_fault()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Mar 2021 12:09:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

book3e/64 is the last one calling __bad_page_fault()
from assembly.

Save non volatile registers before calling do_page_fault()
and modify do_page_fault() to call __bad_page_fault()
for all platforms.

Then it can be refactored by the call of bad_page_fault()
which avoids the duplication of the exception table search.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/exceptions-64e.S |  8 +-------
 arch/powerpc/mm/fault.c              | 17 ++++-------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index e8eb9992a270..b60f89078a3f 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -1010,15 +1010,9 @@ storage_fault_common:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	ld	r15,PACA_EXGEN+EX_R15(r13)
+	bl	save_nvgprs
 	bl	do_page_fault
-	cmpdi	r3,0
-	bne-	1f
 	b	ret_from_except_lite
-1:	bl	save_nvgprs
-	mr	r4,r3
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	__bad_page_fault
-	b	ret_from_except
 
 /*
  * Alignment exception doesn't fit entirely in the 0x100 bytes so it
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 2e54bac99a22..7bcff3fca110 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -541,24 +541,15 @@ NOKPROBE_SYMBOL(___do_page_fault);
 
 static long __do_page_fault(struct pt_regs *regs)
 {
-	const struct exception_table_entry *entry;
 	long err;
 
 	err = ___do_page_fault(regs, regs->dar, regs->dsisr);
 	if (likely(!err))
-		return err;
-
-	entry = search_exception_tables(regs->nip);
-	if (likely(entry)) {
-		instruction_pointer_set(regs, extable_fixup(entry));
 		return 0;
-	} else if (!IS_ENABLED(CONFIG_PPC_BOOK3E_64)) {
-		__bad_page_fault(regs, err);
-		return 0;
-	} else {
-		/* 32 and 64e handle the bad page fault in asm */
-		return err;
-	}
+
+	bad_page_fault(regs, err);
+
+	return 0;
 }
 NOKPROBE_SYMBOL(__do_page_fault);
 
-- 
2.25.0

