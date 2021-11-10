Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B344BE60
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhKJKTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhKJKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9012BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mLUW4RZcNrV2m9t1P+Mij0L/rdbNXsWgjqP4h/hgXek=; b=AAuJSxN1ePx0xdYCSUrGX5hOMv
        GGD9u/tjbJ0uQeehHn7b08rSCogVMcgZJFcWbfMytMyXuwzUuWbgHIG3pGpVD0H+9G36PuvohBRKw
        Kw7NYxtU6JzZe/NDAD418jdz+VANtC8F+4VH05vuQiUb+rB9lDIHjBG2rHo4scYhfySkVtgiVZknP
        omCkRJDBqtTnwe37+XSl+N1bUclzpOdTx004cz3XzEjrqRyPdi2tgVHkpL3MRn+0Jut+L5cynv5EE
        tm863qcxIR354E6JFOe+sxB+NOhdY1vJED0IZFl+jGPeK//46ZNhKrnKtyY3+524SGaY2n9FqAI4X
        zQi/fTWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeG-001lkU-De; Wed, 10 Nov 2021 10:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB20F3006C2;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6F1CF203D5090; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.245184699@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 06/23] x86,entry_32: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where possible, push the .fixup into code, at the tail of functions.

This is hard for macros since they're used in multiple functions,
therefore introduce a new extable handler to pop zeros.

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


