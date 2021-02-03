Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7471C30D97D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhBCMGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbhBCMGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:06:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A015EC06178A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YS795qkO0nXSd/7ytG8vCGCdMgGXy3vgfITieZEiAoY=; b=nz5fNqNrO4bSqrUFkCZ2g8ddXp
        o8WDh4n69OX3/xaQehgSq4KOcbdpZporK/GU8nmcw+MBIGAoFXpJH5gpJYHAtBahJzT1ivYdC+jRw
        8HANidDZxOszVVAFhxBRtfqd63r9F4hIIC7tx75hxEei72Yxu+rf5HkFxUQwtQ2GUTgQGxtwWJGZP
        l+pU/hOHE110/PI5Ye4KRNc0vjoQUtUHk4pXA9GvKo4KW16T6N40Z2Y6ypi8msu4jhO9XouqhLIGB
        9gfsRbOTLzl39XReU7kHAbxsz2JWdls0wiKrCBbLeWnNmVQcS99TI2zbYzyL2784TQ0dNyp6FNniB
        6+z+pgTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7Gtm-00GnWo-5x; Wed, 03 Feb 2021 12:04:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72722306FFE;
        Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 63B062BD45B68; Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Message-ID: <20210203120401.321109449@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 13:02:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 5/5] objtool: Support stack-swizzle
References: <20210203120222.451068583@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Natively support the stack swizzle pattern:

	mov %rsp, (%[tos])
	mov %[tos], %rsp
	...
	pop %rsp

with the constraint that %[tos] must be !arch_callee_saved_reg().

It uses the (newly minted) scratch regs to link the first two
stack-ops, and detect the SP to SP_INDIRECT swizzle.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1937,6 +1937,34 @@ static int update_cfi_state(struct instr
 					cfa->offset = -cfi->vals[op->src.reg].offset;
 					cfi->stack_size = cfa->offset;
 
+				} else if (cfa->base == CFI_SP &&
+					   cfi->regs[op->src.reg].base == CFI_SP_INDIRECT &&
+					   cfi->regs[op->src.reg].offset == cfa->offset) {
+
+					/*
+					 * Stack swizzle:
+					 *
+					 * 1: mov %rsp, (%[tos])
+					 * 2: mov %[tos], %rsp
+					 *    ...
+					 * 3: pop %rsp
+					 *
+					 * Where:
+					 *
+					 * 1 - places a pointer to the previous
+					 *     stack at the Top-of-Stack of the
+					 *     new stack.
+					 *
+					 * 2 - switches to the new stack.
+					 *
+					 * 3 - pops the Top-of-Stack to restore
+					 *     the original stack.
+					 *
+					 * Note:
+					 * %[tos] must not be a callee saved reg
+					 */
+					cfa->base = CFI_SP_INDIRECT;
+
 				} else {
 					cfa->base = CFI_UNDEFINED;
 					cfa->offset = 0;
@@ -2028,6 +2056,13 @@ static int update_cfi_state(struct instr
 
 		case OP_SRC_POP:
 		case OP_SRC_POPF:
+			if (op->dest.reg == CFI_SP && cfa->base == CFI_SP_INDIRECT) {
+
+				/* pop %rsp; # restore from a stack swizzle */
+				cfa->base = CFI_SP;
+				break;
+			}
+
 			if (!cfi->drap && op->dest.reg == cfa->base) {
 
 				/* pop %rbp */
@@ -2154,6 +2189,14 @@ static int update_cfi_state(struct instr
 			/* mov reg, disp(%rsp) */
 			save_reg(cfi, op->src.reg, CFI_CFA,
 				 op->dest.offset - cfi->cfa.offset);
+
+		} else if (op->src.reg == CFI_SP && op->dest.offset == 0) {
+
+			/* mov %rsp, (%reg); # setup a stack swizzle. */
+			if (!arch_callee_saved_reg(op->dest.reg)) {
+				__save_reg(cfi, op->dest.reg, CFI_SP_INDIRECT, cfi->cfa.offset);
+				skip_wipe = true;
+			}
 		}
 
 		break;


