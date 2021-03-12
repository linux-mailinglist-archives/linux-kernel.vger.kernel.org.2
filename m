Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA20338DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhCLMv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:51:29 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:16243 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231788AbhCLMul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:50:41 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DxlzM2zjVz9ttDF;
        Fri, 12 Mar 2021 13:50:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id LQ2xpAKQfvSM; Fri, 12 Mar 2021 13:50:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DxlzM11Qfz9ttBY;
        Fri, 12 Mar 2021 13:50:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 039F48B813;
        Fri, 12 Mar 2021 13:50:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Kt5YIlEkTr61; Fri, 12 Mar 2021 13:50:39 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A604C8B812;
        Fri, 12 Mar 2021 13:50:39 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7D2B2675C9; Fri, 12 Mar 2021 12:50:39 +0000 (UTC)
Message-Id: <7f757c52518ab1d7b27ad5113b10f860e803f467.1615552867.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615552866.git.christophe.leroy@csgroup.eu>
References: <cover.1615552866.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 29/41] powerpc/32: Add a prepare_transfer_to_handler macro
 for exception prologs
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 12 Mar 2021 12:50:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to increase flexibility, add a macro that will for now
call transfer_to_handler.

As transfer_to_handler doesn't do the actual transfer anymore,
also name it prepare_transfer_to_handler. The following patches
will progressively remove the use of transfer_to_handler label.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S   | 3 +++
 arch/powerpc/kernel/head_32.h    | 4 ++++
 arch/powerpc/kernel/head_booke.h | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 76e1502b3e6f..237b753720db 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -86,6 +86,8 @@ _ASM_NOKPROBE_SYMBOL(transfer_to_handler_full)
 
 	.globl	transfer_to_handler
 transfer_to_handler:
+	.globl	prepare_transfer_to_handler
+prepare_transfer_to_handler:
 	SAVE_NVGPRS(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	stw	r2,GPR2(r11)
@@ -133,6 +135,7 @@ transfer_to_handler_cont:
 	lwz	r2, GPR2(r11)
 	b	fast_exception_return
 #endif
+_ASM_NOKPROBE_SYMBOL(prepare_transfer_to_handler)
 _ASM_NOKPROBE_SYMBOL(transfer_to_handler)
 _ASM_NOKPROBE_SYMBOL(transfer_to_handler_cont)
 
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index bf4c288173ad..3ab0f3ad9a6a 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -115,6 +115,10 @@
 _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 .endm
 
+.macro prepare_transfer_to_handler
+	bl	prepare_transfer_to_handler
+.endm
+
 .macro SYSCALL_ENTRY trapno
 	mfspr	r9, SPRN_SRR1
 	mfspr	r10, SPRN_SRR0
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 27a7358c04bb..0f02b970e797 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -87,6 +87,10 @@ END_BTB_FLUSH_SECTION
 	SAVE_4GPRS(3, r11);						     \
 	SAVE_2GPRS(7, r11)
 
+.macro prepare_transfer_to_handler
+	bl	prepare_transfer_to_handler
+.endm
+
 .macro SYSCALL_ENTRY trapno intno srr1
 	mfspr	r10, SPRN_SPRG_THREAD
 #ifdef CONFIG_KVM_BOOKE_HV
-- 
2.25.0

