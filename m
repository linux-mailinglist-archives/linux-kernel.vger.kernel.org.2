Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486FE314C50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhBIJ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:59:48 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:17434 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhBIJ5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:57:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdZc3Jy2z9tx3j;
        Tue,  9 Feb 2021 10:56:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vVAFlkfvfudk; Tue,  9 Feb 2021 10:56:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdZc2Y3bz9tx3b;
        Tue,  9 Feb 2021 10:56:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 567B78B7D6;
        Tue,  9 Feb 2021 10:56:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XRzbqbrA8whx; Tue,  9 Feb 2021 10:56:25 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A9698B7D4;
        Tue,  9 Feb 2021 10:56:25 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EB88067342; Tue,  9 Feb 2021 09:56:24 +0000 (UTC)
Message-Id: <9fd49051430eda14df70d673cd23dadd7daff9e2.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 01/41] powerpc/32: Preserve cr1 in exception prolog
 stack check to fix build error
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:56:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THREAD_ALIGN_SHIFT = THREAD_SHIFT + 1 = PAGE_SHIFT + 1
Maximum PAGE_SHIFT is 18 for 256k pages so
THREAD_ALIGN_SHIFT is 19 at the maximum.

No need to clobber cr1, it can be preserved when moving r1
into CR when we check stack overflow.

This reduces the number of instructions in Machine Check Exception
prolog and fixes a build failure reported by the kernel test robot
on v5.10 stable when building with RTAS + VMAP_STACK + KVM. That
build failure is due to too many instructions in the prolog hence
not fitting between 0x200 and 0x300. Allthough the problem doesn't
show up in mainline, it is still worth the change.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 98bf2d3f4970 ("powerpc/32s: Fix RTAS machine check with VMAP stack")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.h        | 2 +-
 arch/powerpc/kernel/head_book3s_32.S | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 961b1ce3b6bf..5d4706c14572 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -47,7 +47,7 @@
 	lwz	r1,TASK_STACK-THREAD(r1)
 	addi	r1, r1, THREAD_SIZE - INT_FRAME_SIZE
 1:
-	mtcrf	0x7f, r1
+	mtcrf	0x3f, r1
 	bt	32 - THREAD_ALIGN_SHIFT, stack_overflow
 #else
 	subi	r11, r1, INT_FRAME_SIZE		/* use r1 if kernel */
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 086970bec32c..727fdab557c9 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -278,12 +278,6 @@ MachineCheck:
 7:	EXCEPTION_PROLOG_2
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 #ifdef CONFIG_PPC_CHRP
-#ifdef CONFIG_VMAP_STACK
-	mfspr	r4, SPRN_SPRG_THREAD
-	tovirt(r4, r4)
-	lwz	r4, RTAS_SP(r4)
-	cmpwi	cr1, r4, 0
-#endif
 	beq	cr1, machine_check_tramp
 	twi	31, 0, 0
 #else
-- 
2.25.0

