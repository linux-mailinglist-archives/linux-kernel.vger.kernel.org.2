Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9619314CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhBIKVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:21:50 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:48294 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhBIKFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:05:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdbH69ssz9txgd;
        Tue,  9 Feb 2021 10:56:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id et_8_79l2TV0; Tue,  9 Feb 2021 10:56:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdbH5NBJz9txg8;
        Tue,  9 Feb 2021 10:56:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B14468B7D7;
        Tue,  9 Feb 2021 10:57:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R4cYx1hjxI-0; Tue,  9 Feb 2021 10:57:00 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6FABA8B7D4;
        Tue,  9 Feb 2021 10:57:00 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 47EF067342; Tue,  9 Feb 2021 09:57:00 +0000 (UTC)
Message-Id: <422577ca9a02b718c9f20462940078690a9f2737.1612864004.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 35/41] powerpc/32: Return directly from
 power_save_ppc32_restore()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:57:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

transfer_to_handler_cont: is now just a blr.

Directly perform blr in power_save_ppc32_restore().

Also remove useless setting of r11 in e500 version of
power_save_ppc32_restore().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S  |  2 --
 arch/powerpc/kernel/idle_6xx.S  |  2 +-
 arch/powerpc/kernel/idle_e500.S | 10 +---------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 71ef5ab84b03..70bc18f18f1a 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -75,8 +75,6 @@ prepare_transfer_to_handler:
 	bt-	31-TLF_NAPPING,4f
 	bt-	31-TLF_SLEEPING,7f
 #endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
-	.globl transfer_to_handler_cont
-transfer_to_handler_cont:
 	blr
 
 #if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
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

