Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A414314CDA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhBIKWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:22:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:4343 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhBIKFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:05:04 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdbJ6x8hz9txgf;
        Tue,  9 Feb 2021 10:57:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DXMgeJjQFPAy; Tue,  9 Feb 2021 10:57:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdbJ64tQz9txg8;
        Tue,  9 Feb 2021 10:57:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B78B18B7D6;
        Tue,  9 Feb 2021 10:57:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WtDjsBW9HvIB; Tue,  9 Feb 2021 10:57:01 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7658C8B7D4;
        Tue,  9 Feb 2021 10:57:01 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4F15167342; Tue,  9 Feb 2021 09:57:01 +0000 (UTC)
Message-Id: <78f268d2bfc752ca188480e7e5716be01bdf079d.1612864004.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 36/41] powerpc/32: Only use prepare_transfer_to_handler
 function on book3s/32 and e500
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:57:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only book3s/32 and e500 have significative work to do in
prepare_transfer_to_handler.

Other 32 bit have nothing to do at all.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S   | 6 ++----
 arch/powerpc/kernel/head_32.h    | 2 ++
 arch/powerpc/kernel/head_booke.h | 2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 70bc18f18f1a..544a9a2270ff 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -55,6 +55,7 @@
  * Note that we rely on the caller having set cr0.eq iff the exception
  * occurred in kernel mode (i.e. MSR:PR = 0).
  */
+#if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 	.globl	prepare_transfer_to_handler
 prepare_transfer_to_handler:
 	andi.	r0,r9,MSR_PR
@@ -69,15 +70,12 @@ prepare_transfer_to_handler:
          * check for stack overflow
          */
 	kuap_save_and_lock r11, r12, r9, r5, r6
-#if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 	lwz	r12,TI_LOCAL_FLAGS(r2)
 	mtcrf	0x01,r12
 	bt-	31-TLF_NAPPING,4f
 	bt-	31-TLF_SLEEPING,7f
-#endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
 	blr
 
-#if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
 	stw	r12,TI_LOCAL_FLAGS(r2)
 	b	power_save_ppc32_restore
@@ -88,9 +86,9 @@ prepare_transfer_to_handler:
 	rlwinm	r9,r9,0,~MSR_EE
 	stw	r9,_MSR(r11)
 	b	fast_exception_return
-#endif
 _ASM_NOKPROBE_SYMBOL(prepare_transfer_to_handler)
 _ASM_NOKPROBE_SYMBOL(transfer_to_handler_cont)
+#endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
 
 	.globl	transfer_to_syscall
 transfer_to_syscall:
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index b29c13221baa..e994ee3575d2 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -132,7 +132,9 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 .endm
 
 .macro prepare_transfer_to_handler
+#ifdef CONFIG_PPC_BOOK3S_32
 	bl	prepare_transfer_to_handler
+#endif
 .endm
 
 .macro SYSCALL_ENTRY trapno
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 7e47b5dfdd9c..750ffc0915df 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -92,7 +92,9 @@ END_BTB_FLUSH_SECTION
 .end
 
 .macro prepare_transfer_to_handler
+#ifdef CONFIG_E500
 	bl	prepare_transfer_to_handler
+#endif
 .endm
 
 .macro SYSCALL_ENTRY trapno intno srr1
-- 
2.25.0

