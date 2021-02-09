Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C7314CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhBIKNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:13:45 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:9886 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbhBIKCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:02:17 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdZx1717z9txgH;
        Tue,  9 Feb 2021 10:56:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7-1DYM9m--CQ; Tue,  9 Feb 2021 10:56:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdZx0Nxfz9txg8;
        Tue,  9 Feb 2021 10:56:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EF90A8B7D8;
        Tue,  9 Feb 2021 10:56:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4t0HPQfUR_Ih; Tue,  9 Feb 2021 10:56:41 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9CFD98B7D6;
        Tue,  9 Feb 2021 10:56:41 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7600A67342; Tue,  9 Feb 2021 09:56:41 +0000 (UTC)
Message-Id: <070dc48559435f528b5682d685af300ae974cb35.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 17/41] powerpc/32: Add vmap_stack_overflow label inside
 the macro
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:56:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistancy, add in the macro the label used by exception prolog
to branch to stack overflow processing.

While at it, enclose the macro in #ifdef CONFIG_VMAP_STACK on the 8xx
as already done on book3s/32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.h        | 3 ++-
 arch/powerpc/kernel/head_8xx.S       | 3 ++-
 arch/powerpc/kernel/head_book3s_32.S | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 15c6fc7cbbf5..d97ec94b34da 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -52,7 +52,7 @@
 1:
 #ifdef CONFIG_VMAP_STACK
 	mtcrf	0x3f, r1
-	bt	32 - THREAD_ALIGN_SHIFT, stack_overflow
+	bt	32 - THREAD_ALIGN_SHIFT, vmap_stack_overflow
 #endif
 .endm
 
@@ -196,6 +196,7 @@
 			  ret_from_except)
 
 .macro vmap_stack_overflow_exception
+vmap_stack_overflow:
 #ifdef CONFIG_SMP
 	mfspr	r1, SPRN_SPRG_THREAD
 	lwz	r1, TASK_CPU - THREAD(r1)
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index cdbfa9d41353..b63445c55f4d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -338,8 +338,9 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 	/* 0x300 is DataAccess exception, needed by bad_page_fault() */
 	EXC_XFER_LITE(0x300, handle_page_fault)
 
-stack_overflow:
+#ifdef CONFIG_VMAP_STACK
 	vmap_stack_overflow_exception
+#endif
 
 /* On the MPC8xx, these next four traps are used for development
  * support of breakpoints and such.  Someday I will get around to
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 59efbee7c080..9dc05890477d 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -729,7 +729,6 @@ fast_hash_page_return:
 #endif /* CONFIG_PPC_BOOK3S_604 */
 
 #ifdef CONFIG_VMAP_STACK
-stack_overflow:
 	vmap_stack_overflow_exception
 #endif
 
-- 
2.25.0

