Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90D5314BE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBIJkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhBIJhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:37:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D01C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=y/Ssx/Ju41Di8qxJhrq3z+b9Pqqpv/OliGBbOSuk6vo=; b=aKYY4B19Uf24pgmJ+4Dj67fifw
        WdbhVm7VVAAbZfS3f+jwR3QYE7CBQHhaUQg+p/9BxB3L+bpQxz8mebvMlt2hyk4jh9YmO5RsKpq1T
        2QGs93XfccWSZyVWlY5//F9zr1JhwiZiABv1oHn7nMBOYo7xqmAa3TjQY2guhDTPxDnI8DE19a/0i
        XxUTLjWwF2wR7+a6WqKSHjf/AlWSslZrrZJZrasN2YzZCTkGzonHzl3YZlOpZmnny0jXGsFzQxCCo
        2v/4N2UrHhOsQP4mURHYXu58uosgGQNNeXW0MRTwxd2+agxTaV0EgU6UOLWUPlcRqCLbF7XSZ4KR7
        AyZBq1Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9PRb-0005wi-IN; Tue, 09 Feb 2021 09:36:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 892133060AE;
        Tue,  9 Feb 2021 10:36:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 719B02BB568DF; Tue,  9 Feb 2021 10:36:25 +0100 (CET)
Message-ID: <20210209093521.994069508@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 09 Feb 2021 10:16:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 3/3] objtool: Support stack-swizzle
References: <20210209091600.075402197@infradead.org>
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

It uses the vals[] array to link the first two stack-ops, and detect
the SP to SP_INDIRECT swizzle.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1945,6 +1945,38 @@ static int update_cfi_state(struct instr
 					cfa->offset = -cfi->vals[op->src.reg].offset;
 					cfi->stack_size = cfa->offset;
 
+				} else if (cfa->base == CFI_SP &&
+					   cfi->vals[op->src.reg].base == CFI_SP_INDIRECT &&
+					   cfi->vals[op->src.reg].offset == cfa->offset) {
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
+					 * Note: we set base to SP_INDIRECT
+					 * here and preserve offset. Therefore
+					 * when the unwinder reaches ToS it
+					 * will dereference SP and then add the
+					 * offset to find the next frame, IOW:
+					 * (%rsp) + offset.
+					 */
+					cfa->base = CFI_SP_INDIRECT;
+
 				} else {
 					cfa->base = CFI_UNDEFINED;
 					cfa->offset = 0;
@@ -2047,6 +2079,13 @@ static int update_cfi_state(struct instr
 
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
@@ -2193,6 +2232,12 @@ static int update_cfi_state(struct instr
 			/* mov reg, disp(%rsp) */
 			save_reg(cfi, op->src.reg, CFI_CFA,
 				 op->dest.offset - cfi->stack_size);
+
+		} else if (op->src.reg == CFI_SP && op->dest.offset == 0) {
+
+			/* mov %rsp, (%reg); # setup a stack swizzle. */
+			cfi->vals[op->dest.reg].base = CFI_SP_INDIRECT;
+			cfi->vals[op->dest.reg].offset = cfi->cfa.offset;
 		}
 
 		break;


