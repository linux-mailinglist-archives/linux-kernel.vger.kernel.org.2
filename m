Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D45B338DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhCLMvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:51:42 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:2592 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231883AbhCLMur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:50:47 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DxlzT2bTlz9ttBT;
        Fri, 12 Mar 2021 13:50:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IuzSmeOd1X87; Fri, 12 Mar 2021 13:50:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DxlzT1d9Zz9ttBL;
        Fri, 12 Mar 2021 13:50:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 321E48B812;
        Fri, 12 Mar 2021 13:50:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PVYKcUSiKGXk; Fri, 12 Mar 2021 13:50:46 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC00F8B764;
        Fri, 12 Mar 2021 13:50:45 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A6EF7675C9; Fri, 12 Mar 2021 12:50:45 +0000 (UTC)
Message-Id: <e337506e08a4df95b11d2290104b92f0dcdb5548.1615552867.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615552866.git.christophe.leroy@csgroup.eu>
References: <cover.1615552866.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 35/41] powerpc/32: Return directly from
 power_save_ppc32_restore()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 12 Mar 2021 12:50:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

transfer_to_handler_cont: is now just a blr.

Directly perform blr in power_save_ppc32_restore().

Also remove useless setting of r11 in e500 version of
power_save_ppc32_restore().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S  |  3 ---
 arch/powerpc/kernel/idle_6xx.S  |  2 +-
 arch/powerpc/kernel/idle_e500.S | 10 +---------
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 46b3854e7318..b9a2935efec1 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -67,8 +67,6 @@ prepare_transfer_to_handler:
 	bt-	31-TLF_NAPPING,4f
 	bt-	31-TLF_SLEEPING,7f
 #endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
-	.globl transfer_to_handler_cont
-transfer_to_handler_cont:
 	blr
 
 #if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
@@ -86,7 +84,6 @@ transfer_to_handler_cont:
 	b	fast_exception_return
 #endif
 _ASM_NOKPROBE_SYMBOL(prepare_transfer_to_handler)
-_ASM_NOKPROBE_SYMBOL(transfer_to_handler_cont)
 
 	.globl	transfer_to_syscall
 transfer_to_syscall:
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 153366e178c4..13cad9297d82 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -176,7 +176,7 @@ BEGIN_FTR_SECTION
 	lwz	r9,nap_save_hid1@l(r9)
 	mtspr	SPRN_HID1, r9
 END_FTR_SECTION_IFSET(CPU_FTR_DUAL_PLL_750FX)
-	b	transfer_to_handler_cont
+	blr
 _ASM_NOKPROBE_SYMBOL(power_save_ppc32_restore)
 
 	.data
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 7795727e7f08..9e1bc4502c50 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -81,13 +81,5 @@ END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 _GLOBAL(power_save_ppc32_restore)
 	lwz	r9,_LINK(r11)		/* interrupted in e500_idle */
 	stw	r9,_NIP(r11)		/* make it do a blr */
-
-#ifdef CONFIG_SMP
-	lwz	r11,TASK_CPU(r2)		/* get cpu number * 4 */
-	slwi	r11,r11,2
-#else
-	li	r11,0
-#endif
-
-	b	transfer_to_handler_cont
+	blr
 _ASM_NOKPROBE_SYMBOL(power_save_ppc32_restore)
-- 
2.25.0

