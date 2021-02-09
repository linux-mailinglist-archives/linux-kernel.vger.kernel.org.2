Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0743D314C99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhBIKLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:11:11 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:31782 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhBIKCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:02:23 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdb84l6Hz9txgV;
        Tue,  9 Feb 2021 10:56:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id qERT01IiwSuo; Tue,  9 Feb 2021 10:56:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdb83x51z9txg8;
        Tue,  9 Feb 2021 10:56:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 647AB8B7D8;
        Tue,  9 Feb 2021 10:56:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 30b1Q0D0FdOv; Tue,  9 Feb 2021 10:56:53 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 21D468B7D6;
        Tue,  9 Feb 2021 10:56:53 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F0D4367342; Tue,  9 Feb 2021 09:56:52 +0000 (UTC)
Message-Id: <0c4b5f1107b7af48007ce3a7fa4f826dd4cdface.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 28/41] powerpc/32: Add a prepare_transfer_to_handler
 macro for exception prologs
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:56:52 +0000 (UTC)
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
index 890a4508c1f1..03f4d07f4176 100644
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
 	stw	r9,_MSR(r11)
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
index 12add20edbb1..9bc86aab65ef 100644
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

