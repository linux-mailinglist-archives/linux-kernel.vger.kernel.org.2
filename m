Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808943191E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhBKSJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhBKRli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:41:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2458FC061794
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AfkR7TYJUX66Y3HtIuMsGJrIZgkMMZfHDBYmSFIgeuU=; b=RG45cO1tKY9MLLmuWqHm2D3MFT
        p+DOccEv1SsOR15b7Zm1aPAG+akR/DuddrN6rZJmQ3Nc9qnbZSra1lMmgz8fJXzOYVwWTqh3PQoRo
        sU0eqThyB6vVXHk4d6D3BzCQA9aY+sRkigsjz9jm5/2jHHXEE0EcE9ebEhV2OPvhxHwDCvA6mAlU0
        FmoyT87FDUy9rDR9qcnATY8HoTjEzabk7aVoAArcvQ2MIVNWSJx/AUh/APSpHn9EOxReuB4U1dTU8
        LvClKLU5Uddm3qCqTaHv6lQCX1X244rdnQOQmxqy1udSRxQRCY0QdBAobzUxjCYcPz/D8jO++AHtg
        d/fmhbBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lAFxN-00AY0H-Va; Thu, 11 Feb 2021 17:40:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1318F3060AE;
        Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EB6F62BB91E3A; Thu, 11 Feb 2021 18:40:44 +0100 (CET)
Message-ID: <20210211173626.918498579@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 11 Feb 2021 18:30:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH v2 1/7] objtool: Allow UNWIND_HINT to suppress dodgy stack modifications
References: <20210211173044.141215027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rewind_stack_do_exit()
	UNWIND_HINT_FUNC
	/* Prevent any naive code from trying to unwind to our caller. */

	xorl	%ebp, %ebp
	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
	leaq	-PTREGS_SIZE(%rax), %rsp
	UNWIND_HINT_REGS

	call	do_exit

Does unspeakable things to the stack, which objtool currently fails to
detect due to a limitation in instruction decoding. This will be
rectified after which the above will result in:

arch/x86/entry/entry_64.o: warning: objtool: .text+0xab: unsupported stack register modification

Allow the UNWIND_HINT on the next instruction to suppress this, it
will overwrite the state anyway.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1918,8 +1918,9 @@ static void restore_reg(struct cfi_state
  *   41 5d			pop    %r13
  *   c3				retq
  */
-static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
-			     struct stack_op *op)
+static int update_cfi_state(struct instruction *insn,
+			    struct instruction *next_insn,
+			    struct cfi_state *cfi, struct stack_op *op)
 {
 	struct cfi_reg *cfa = &cfi->cfa;
 	struct cfi_reg *regs = cfi->regs;
@@ -2106,7 +2107,7 @@ static int update_cfi_state(struct instr
 				break;
 			}
 
-			if (op->dest.reg == cfi->cfa.base) {
+			if (op->dest.reg == cfi->cfa.base && !(next_insn && next_insn->hint)) {
 				WARN_FUNC("unsupported stack register modification",
 					  insn->sec, insn->offset);
 				return -1;
@@ -2378,13 +2379,15 @@ static int propagate_alt_cfi(struct objt
 	return 0;
 }
 
-static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
+static int handle_insn_ops(struct instruction *insn,
+			   struct instruction *next_insn,
+			   struct insn_state *state)
 {
 	struct stack_op *op;
 
 	list_for_each_entry(op, &insn->stack_ops, list) {
 
-		if (update_cfi_state(insn, &state->cfi, op))
+		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
@@ -2678,7 +2681,7 @@ static int validate_branch(struct objtoo
 				return 0;
 		}
 
-		if (handle_insn_ops(insn, &state))
+		if (handle_insn_ops(insn, next_insn, &state))
 			return 1;
 
 		switch (insn->type) {


