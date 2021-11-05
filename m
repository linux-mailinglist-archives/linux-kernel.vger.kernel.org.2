Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6100F4467B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhKERXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhKERWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:22:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05CC06120C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=h+cEveSj9uKTly9M9x2HbKRfUF7B9tZ5s1j9To+RtkQ=; b=WERbtrRSA+TJ8Bu7Bj7FkKwuoo
        7OpDo7086W7VkKWf3HiJVUHJiqiOrtXxZJetaX6BL5iDJBp7ic+TMAiji4MZ/TZ+CWDX8PtxFVFXO
        LmYCvzgtGDXenHF6QoC5m0IQKGaRkI91CU6CLNAlxi6P6ib+jLT/qy4uwXfSU93GEwqQbjWzZai8k
        VRMTamIVzGH2FJW1j64bYEf6vQISwGy1s9NMyaVDiZUUuUQFCQeqbRQ9PGU7LtwNrT04NXipvNdsQ
        sreT9qKjDddfx5gCCzbqTUBbZeTmfiVjwHPpXYsIWoyqO+d1Gk64/JryrlceRkNtZhmhjKommhZdM
        2haiLZyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sY-00ENAV-Ht; Fri, 05 Nov 2021 17:19:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF825300ECB;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5168F201C7B55; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171820.809028458@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 06/22] x86,entry_32: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where possible, push the .fixup into code, at the tail of functions.

This is hard for macros since they're used in multiple functions,
therefore introduce a new extable handler for pop-segment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_32.S                  |   28 ++++++++--------------------
 arch/x86/include/asm/extable_fixup_types.h |    2 ++
 arch/x86/mm/extable.c                      |   14 ++++++++++++++
 3 files changed, 24 insertions(+), 20 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -270,17 +270,9 @@
 3:	popl	%fs
 	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
 	IRET_FRAME
-.pushsection .fixup, "ax"
-4:	movl	$0, (%esp)
-	jmp	1b
-5:	movl	$0, (%esp)
-	jmp	2b
-6:	movl	$0, (%esp)
-	jmp	3b
-.popsection
-	_ASM_EXTABLE(1b, 4b)
-	_ASM_EXTABLE(2b, 5b)
-	_ASM_EXTABLE(3b, 6b)
+	_ASM_EXTABLE_TYPE(1b, 1b, EX_TYPE_POP_ZERO)
+	_ASM_EXTABLE_TYPE(2b, 2b, EX_TYPE_POP_ZERO)
+	_ASM_EXTABLE_TYPE(3b, 3b, EX_TYPE_POP_ZERO)
 .endm
 
 .macro RESTORE_ALL_NMI cr3_reg:req pop=0
@@ -925,10 +917,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	sti
 	sysexit
 
-.pushsection .fixup, "ax"
-2:	movl	$0, PT_FS(%esp)
-	jmp	1b
-.popsection
+2:	movl    $0, PT_FS(%esp)
+	jmp     1b
 	_ASM_EXTABLE(1b, 2b)
 
 .Lsysenter_fix_flags:
@@ -996,8 +986,7 @@ SYM_FUNC_START(entry_INT80_32)
 	 */
 	iret
 
-.section .fixup, "ax"
-SYM_CODE_START(asm_iret_error)
+.Lasm_iret_error:
 	pushl	$0				# no error code
 	pushl	$iret_error
 
@@ -1014,9 +1003,8 @@ SYM_CODE_START(asm_iret_error)
 #endif
 
 	jmp	handle_exception
-SYM_CODE_END(asm_iret_error)
-.previous
-	_ASM_EXTABLE(.Lirq_return, asm_iret_error)
+
+	_ASM_EXTABLE(.Lirq_return, .Lasm_iret_error)
 SYM_FUNC_END(entry_INT80_32)
 
 .macro FIXUP_ESPFIX_STACK
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -19,4 +19,6 @@
 #define	EX_TYPE_DEFAULT_MCE_SAFE	12
 #define	EX_TYPE_FAULT_MCE_SAFE		13
 
+#define	EX_TYPE_POP_ZERO		14
+
 #endif
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -99,6 +99,18 @@ static bool ex_handler_clear_fs(const st
 	return ex_handler_default(fixup, regs);
 }
 
+static bool ex_handler_pop_zero(const struct exception_table_entry *fixup,
+				struct pt_regs *regs)
+{
+	/*
+	 * Typically used for when "pop %seg" traps, in which case we'll clear
+	 * the stack slot and re-try the instruction, which will then succeed
+	 * to pop zero.
+	 */
+	*((unsigned long *)regs->sp) = 0;
+	return ex_handler_default(fixup, regs);
+}
+
 int ex_get_fixup_type(unsigned long ip)
 {
 	const struct exception_table_entry *e = search_exception_tables(ip);
@@ -156,6 +168,8 @@ int fixup_exception(struct pt_regs *regs
 	case EX_TYPE_WRMSR_IN_MCE:
 		ex_handler_msr_mce(regs, true);
 		break;
+	case EX_TYPE_POP_ZERO:
+		return ex_handler_pop_zero(e, regs);
 	}
 	BUG();
 }


