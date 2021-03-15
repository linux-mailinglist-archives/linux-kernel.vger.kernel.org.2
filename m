Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269A333BF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbhCOOy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:54:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36923 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241584AbhCOOw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:52:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DzfXt3wJYz9tyTK;
        Mon, 15 Mar 2021 15:52:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vniJaSbpwf9e; Mon, 15 Mar 2021 15:52:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DzfXt2SyJz9tyTJ;
        Mon, 15 Mar 2021 15:52:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8CD08B776;
        Mon, 15 Mar 2021 15:52:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ABtNn8k4BisG; Mon, 15 Mar 2021 15:52:51 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 861B48B75B;
        Mon, 15 Mar 2021 15:52:51 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5E62F675E2; Mon, 15 Mar 2021 14:52:51 +0000 (UTC)
Message-Id: <8038392f38d81f2ad169347efac29146f553b238.1615819955.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/mm: Remove unneeded #ifdef CONFIG_PPC_MEM_KEYS
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 15 Mar 2021 14:52:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fault.c, #ifdef CONFIG_PPC_MEM_KEYS is not needed because all
functions are always defined, and arch_vma_access_permitted()
always returns true when CONFIG_PPC_MEM_KEYS is not defined so
access_pkey_error() will return false so bad_access_pkey()
will never be called.

Include linux/pkeys.h to get a definition of vma_pkeys() for
bad_access_pkey().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/fault.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index bb368257b55c..f1b3f5922f90 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -32,6 +32,7 @@
 #include <linux/context_tracking.h>
 #include <linux/hugetlb.h>
 #include <linux/uaccess.h>
+#include <linux/pkeys.h>
 
 #include <asm/firmware.h>
 #include <asm/interrupt.h>
@@ -87,7 +88,6 @@ static noinline int bad_area(struct pt_regs *regs, unsigned long address)
 	return __bad_area(regs, address, SEGV_MAPERR);
 }
 
-#ifdef CONFIG_PPC_MEM_KEYS
 static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long address,
 				    struct vm_area_struct *vma)
 {
@@ -127,7 +127,6 @@ static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long address,
 
 	return 0;
 }
-#endif
 
 static noinline int bad_access(struct pt_regs *regs, unsigned long address)
 {
@@ -234,7 +233,6 @@ static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
 	return false;
 }
 
-#ifdef CONFIG_PPC_MEM_KEYS
 static bool access_pkey_error(bool is_write, bool is_exec, bool is_pkey,
 			      struct vm_area_struct *vma)
 {
@@ -248,7 +246,6 @@ static bool access_pkey_error(bool is_write, bool is_exec, bool is_pkey,
 
 	return false;
 }
-#endif
 
 static bool access_error(bool is_write, bool is_exec, struct vm_area_struct *vma)
 {
@@ -492,11 +489,9 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 			return bad_area(regs, address);
 	}
 
-#ifdef CONFIG_PPC_MEM_KEYS
 	if (unlikely(access_pkey_error(is_write, is_exec,
 				       (error_code & DSISR_KEYFAULT), vma)))
 		return bad_access_pkey(regs, address, vma);
-#endif /* CONFIG_PPC_MEM_KEYS */
 
 	if (unlikely(access_error(is_write, is_exec, vma)))
 		return bad_access(regs, address);
-- 
2.25.0

