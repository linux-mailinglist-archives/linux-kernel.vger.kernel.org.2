Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356873191DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhBKSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhBKRlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:41:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9BEC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TULeRrnX2rH0sszHbgWd1JMl6ddl8su6cbV3YgJqs+I=; b=02BRFrzkVoMNjIxBkOJLs16wgz
        6OpSG4HjnBMIWLswrXObXHLetxP6+DffBZcW24SINMJzoAYTX3RwX3X0tG8RQtRiyGiyU5U6tuQQn
        nzAmbKeLkDxbNhs7Y5pNfZJbi/hHUIzOouNM+4rlYTXIf3kdFgvRgcUMOoIiv5JZlCckDart5vzMm
        8RZQ4velajmNIFZyrlBLX3iii+0epWOpl8GIchc9mfTAluqovm/bjBlzqb0SZaq3qp/uKwFhnEySO
        oy2jlCv3jI4kUApBFfYV5KxD7QqlBoL9XYF1msQUmAtjkvIi9RFigMs23p52pyGMzGUcDQc339FWc
        11HKDWRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAFxO-0005bx-Bu; Thu, 11 Feb 2021 17:40:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 187DE306102;
        Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 064D82BCDFC79; Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Message-ID: <20210211173627.253273977@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 11 Feb 2021 18:30:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH v2 4/7] objtool,x86: Rewrite LEAVE
References: <20210211173044.141215027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we can now have multiple stack-ops per instruction, we don't
need to special case LEAVE and can simply emit the composite
operations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c      |   14 +++++++++++---
 tools/objtool/check.c                |   24 ++----------------------
 tools/objtool/include/objtool/arch.h |    1 -
 3 files changed, 13 insertions(+), 26 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -441,9 +441,17 @@ int arch_decode_instruction(const struct
 		 * mov bp, sp
 		 * pop bp
 		 */
-		ADD_OP(op)
-			op->dest.type = OP_DEST_LEAVE;
-
+		ADD_OP(op) {
+			op->src.type = OP_SRC_REG;
+			op->src.reg = CFI_BP;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_SP;
+		}
+		ADD_OP(op) {
+			op->src.type = OP_SRC_POP;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_BP;
+		}
 		break;
 
 	case 0xe3:
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1931,7 +1931,7 @@ static int update_cfi_state(struct instr
 			}
 
 			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
-				 cfa->base == CFI_BP) {
+				 (cfa->base == CFI_BP || cfa->base == cfi->drap_reg)) {
 
 				/*
 				 * mov %rbp, %rsp
@@ -2114,7 +2114,7 @@ static int update_cfi_state(struct instr
 				cfa->offset = 0;
 				cfi->drap_offset = -1;
 
-			} else if (regs[op->dest.reg].offset == -cfi->stack_size) {
+			} else if (cfi->stack_size == -regs[op->dest.reg].offset) {
 
 				/* pop %reg */
 				restore_reg(cfi, op->dest.reg);
@@ -2254,26 +2254,6 @@ static int update_cfi_state(struct instr
 		}
 
 		break;
-
-	case OP_DEST_LEAVE:
-		if ((!cfi->drap && cfa->base != CFI_BP) ||
-		    (cfi->drap && cfa->base != cfi->drap_reg)) {
-			WARN_FUNC("leave instruction with modified stack frame",
-				  insn->sec, insn->offset);
-			return -1;
-		}
-
-		/* leave (mov %rbp, %rsp; pop %rbp) */
-
-		cfi->stack_size = -cfi->regs[CFI_BP].offset - 8;
-		restore_reg(cfi, CFI_BP);
-
-		if (!cfi->drap) {
-			cfa->base = CFI_SP;
-			cfa->offset -= 8;
-		}
-
-		break;
 
 	case OP_DEST_MEM:
 		if (op->src.type != OP_SRC_POP && op->src.type != OP_SRC_POPF) {
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -35,7 +35,6 @@ enum op_dest_type {
 	OP_DEST_MEM,
 	OP_DEST_PUSH,
 	OP_DEST_PUSHF,
-	OP_DEST_LEAVE,
 };
 
 struct op_dest {


