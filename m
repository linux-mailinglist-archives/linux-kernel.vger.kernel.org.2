Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F723191C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhBKSDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhBKRlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:41:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E2C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0+z8+nBnNPCXRhsOLnujfLu2MSD7c9TPBKubtGo/PKA=; b=n5XBURrW50cDPTOdB60vOCVmoC
        9jUw8K5iy/d99Rc4DJPZoDG74kiRXCy2aT4REDlPQMMS/AFr4UtI+HAHPCSXMtQsat09/vZxad+oR
        wWiIAmK2V75/jiWG6MeD8Sg/SceU9cUAuCwCtO1MwEk9XVBLrUAsgRP1S+asmSrZoZMJpUN3XCeeS
        XQGu/W1yWUXZnNV8ZPn7sgpALyrcVmvSGYQYO5QFyog5zQlYspTyHzvXxoJTVRCMXRkKmssqhnWIm
        1/WTGlhb7Ylp5gfrz4ICqWIIaHq809UKIko4pspcF1duWM57g9Tz+LA8R4Yefz/JmuhbVA/arG+2F
        BGj3r6/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lAFxN-00AY0G-Vg; Thu, 11 Feb 2021 17:40:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15BF23060F3;
        Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 014992BCDFC78; Thu, 11 Feb 2021 18:40:44 +0100 (CET)
Message-ID: <20210211173627.143250641@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 11 Feb 2021 18:30:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH v2 3/7] objtool,x86: Rewrite LEA decode
References: <20210211173044.141215027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current LEA decoding is a bunch of special cases, properly decode the
instruction, with exception of full SIB and RIP-relative modes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |   83 +++++++++++-----------------------------
 1 file changed, 24 insertions(+), 59 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -91,9 +91,10 @@ int arch_decode_instruction(const struct
 {
 	struct insn insn;
 	int x86_64, sign;
-	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
-		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
-		      modrm_reg = 0, sib = 0;
+	unsigned char op1, op2,
+		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
+		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
+		      sib = 0;
 	struct stack_op *op = NULL;
 	struct symbol *sym;
 
@@ -328,68 +329,32 @@ int arch_decode_instruction(const struct
 		break;
 
 	case 0x8d:
-		if (sib == 0x24 && rex_w && !rex_b && !rex_x) {
-
-			ADD_OP(op) {
-				if (!insn.displacement.value) {
-					/* lea (%rsp), reg */
-					op->src.type = OP_SRC_REG;
-				} else {
-					/* lea disp(%rsp), reg */
-					op->src.type = OP_SRC_ADD;
-					op->src.offset = insn.displacement.value;
-				}
-				op->src.reg = CFI_SP;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
-			}
-
-		} else if (rex == 0x48 && modrm == 0x65) {
-
-			/* lea disp(%rbp), %rsp */
-			ADD_OP(op) {
-				op->src.type = OP_SRC_ADD;
-				op->src.reg = CFI_BP;
-				op->src.offset = insn.displacement.value;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = CFI_SP;
-			}
-
-		} else if (rex == 0x49 && modrm == 0x62 &&
-			   insn.displacement.value == -8) {
+		/* skip non 64bit ops */
+		if (!rex_w)
+			break;
 
-			/*
-			 * lea -0x8(%r10), %rsp
-			 *
-			 * Restoring rsp back to its original value after a
-			 * stack realignment.
-			 */
-			ADD_OP(op) {
-				op->src.type = OP_SRC_ADD;
-				op->src.reg = CFI_R10;
-				op->src.offset = -8;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = CFI_SP;
-			}
+		/* skip nontrivial SIB */
+		if (modrm_rm == 4 && !(sib == 0x24 && rex_b == rex_x))
+			break;
 
-		} else if (rex == 0x49 && modrm == 0x65 &&
-			   insn.displacement.value == -16) {
+		/* skip RIP relative displacement */
+		if (modrm_rm == 5 && modrm_mod == 0)
+			break;
 
-			/*
-			 * lea -0x10(%r13), %rsp
-			 *
-			 * Restoring rsp back to its original value after a
-			 * stack realignment.
-			 */
-			ADD_OP(op) {
+		/* lea disp(%src), %dst */
+		ADD_OP(op) {
+			op->src.offset = insn.displacement.value;
+			if (!op->src.offset) {
+				/* lea (%src), %dst */
+				op->src.type = OP_SRC_REG;
+			} else {
+				/* lea disp(%src), %dst */
 				op->src.type = OP_SRC_ADD;
-				op->src.reg = CFI_R13;
-				op->src.offset = -16;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = CFI_SP;
 			}
+			op->src.reg = op_to_cfi_reg[modrm_rm][rex_b];
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
 		}
-
 		break;
 
 	case 0x8f:


