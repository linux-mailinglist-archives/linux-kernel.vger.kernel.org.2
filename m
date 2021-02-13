Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12E031ADBF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 20:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhBMTUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 14:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhBMTU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 14:20:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72DB864E51;
        Sat, 13 Feb 2021 19:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613243988;
        bh=0NZfAn33OzbNo1CiIh5EPbmvmV4T8Va4cABUBaf/uOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/TwtpemCRaT9vmbfawjfkPzjkLYu2PYmy+k1fm8CXRJJSCutcXzN/t0ltPTmfeUx
         o4C5R3D7mRtKZ6V1YPRRjpr43N99O8r1qzR11OWGzEFvdwNRiIGcbGpzVnTmKSeZIF
         dbKUfK8NM6Bh/Qkj0LbtMPQpKrHQq/D7wwFCT6PYbOoD6z75d+xP645WUcfLPo1NlF
         cA3nHNraJr9PPfUXfLrenCT2/jhxeMGea4UN+8TOF5xvKwA7m9knLh2jMBPox4lLMu
         n/ShpigswqTUBBxhnldLAgsrNAJUF5F1cCH9Hj9efYaQH6HRNWRzQ8bFtKEOtNa5mw
         GuISfgz4xV+Ew==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brian Gerst <brgerst@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 2/2] x86/entry/32: Remove leftover macros after stackprotector cleanups
Date:   Sat, 13 Feb 2021 11:19:45 -0800
Message-Id: <b1543116f0f0e68f1763d90d5f7fcec27885dff5.1613243844.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613243844.git.luto@kernel.org>
References: <cover.1613243844.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that nonlazy-GS mode is gone, remove the macros from entry_32.S
that obfuscated^Wabstracted GS handling.  The assembled output is
identical before and after this patch.

Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_32.S | 43 ++-------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index eb0cb662bca5..bee9101e211e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -53,35 +53,6 @@
 
 #define PTI_SWITCH_MASK         (1 << PAGE_SHIFT)
 
-/*
- * User gs save/restore
- *
- * This is leftover junk from CONFIG_X86_32_LAZY_GS.  A subsequent patch
- * will remove it entirely.
- */
- /* unfortunately push/pop can't be no-op */
-.macro PUSH_GS
-	pushl	$0
-.endm
-.macro POP_GS pop=0
-	addl	$(4 + \pop), %esp
-.endm
-.macro POP_GS_EX
-.endm
-
- /* all the rest are no-op */
-.macro PTGS_TO_GS
-.endm
-.macro PTGS_TO_GS_EX
-.endm
-.macro GS_TO_REG reg
-.endm
-.macro REG_TO_PTGS reg
-.endm
-.macro SET_KERNEL_GS reg
-.endm
-
-
 /* Unconditionally switch to user cr3 */
 .macro SWITCH_TO_USER_CR3 scratch_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
@@ -234,7 +205,7 @@
 .macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0 unwind_espfix=0
 	cld
 .if \skip_gs == 0
-	PUSH_GS
+	pushl	$0
 .endif
 	pushl	%fs
 
@@ -259,9 +230,6 @@
 	movl	$(__USER_DS), %edx
 	movl	%edx, %ds
 	movl	%edx, %es
-.if \skip_gs == 0
-	SET_KERNEL_GS %edx
-.endif
 	/* Switch to kernel stack if necessary */
 .if \switch_stacks > 0
 	SWITCH_TO_KERNEL_STACK
@@ -300,7 +268,7 @@
 1:	popl	%ds
 2:	popl	%es
 3:	popl	%fs
-	POP_GS \pop
+	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
 	IRET_FRAME
 .pushsection .fixup, "ax"
 4:	movl	$0, (%esp)
@@ -313,7 +281,6 @@
 	_ASM_EXTABLE(1b, 4b)
 	_ASM_EXTABLE(2b, 5b)
 	_ASM_EXTABLE(3b, 6b)
-	POP_GS_EX
 .endm
 
 .macro RESTORE_ALL_NMI cr3_reg:req pop=0
@@ -928,7 +895,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	movl	PT_EIP(%esp), %edx	/* pt_regs->ip */
 	movl	PT_OLDESP(%esp), %ecx	/* pt_regs->sp */
 1:	mov	PT_FS(%esp), %fs
-	PTGS_TO_GS
 
 	popl	%ebx			/* pt_regs->bx */
 	addl	$2*4, %esp		/* skip pt_regs->cx and pt_regs->dx */
@@ -964,7 +930,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	jmp	1b
 .popsection
 	_ASM_EXTABLE(1b, 2b)
-	PTGS_TO_GS_EX
 
 .Lsysenter_fix_flags:
 	pushl	$X86_EFLAGS_FIXED
@@ -1106,11 +1071,7 @@ SYM_CODE_START_LOCAL_NOALIGN(handle_exception)
 	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
 	ENCODE_FRAME_POINTER
 
-	/* fixup %gs */
-	GS_TO_REG %ecx
 	movl	PT_GS(%esp), %edi		# get the function address
-	REG_TO_PTGS %ecx
-	SET_KERNEL_GS %ecx
 
 	/* fixup orig %eax */
 	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
-- 
2.29.2

