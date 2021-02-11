Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934393191DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhBKSIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhBKRlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:41:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2055FC061793
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RsO1fzcMw6LSXdtwYBhdcS04778DCpQDYDEUwBTg9/w=; b=eOvnACDIlu03ZXMTbvSEdbgRmy
        fX2mBLWxERSVQLuMpTL6BDdAsjk5GxrmwehRlVJBiwXijVaof1dD+/0T+MtJoSE/mmyv+jsN/Qwmv
        BBt3U87+4ezkCsQGlBs4qrcEc7gHcLnomP21EhxBJMH4iachyNIk8oZEWI1vUTzJVcTNAZtU9jfSs
        oNmPQAjsn40d5s/2Hcfb0zo9TRtopEE+r+SN3pAkSgkUZr9GghTNSKHi6mcX7H1k9EbsVV7PlAomL
        LcUFi5n90QQJFAWPkYXqw2TfhNo+QvqiuNZJat2ZeomTBRUV2aZwJ8Nm96+mcdwP8gAouk39liqR3
        1B09ZPpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lAFxO-00AY0M-UT; Thu, 11 Feb 2021 17:40:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2553F3075F1;
        Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 17A6A2BCDFC7B; Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Message-ID: <20210211173627.588366777@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 11 Feb 2021 18:30:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH v2 7/7] objtool,x86: Rewrite ADD/SUB/AND
References: <20210211173044.141215027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support sign extending and imm8 forms.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |   70 +++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 19 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -98,13 +98,14 @@ int arch_decode_instruction(const struct
 			    struct list_head *ops_list)
 {
 	struct insn insn;
-	int x86_64, sign;
+	int x86_64;
 	unsigned char op1, op2,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
 	struct stack_op *op = NULL;
 	struct symbol *sym;
+	u64 imm;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
@@ -200,12 +201,54 @@ int arch_decode_instruction(const struct
 		*type = INSN_JUMP_CONDITIONAL;
 		break;
 
-	case 0x81:
-	case 0x83:
-		if (rex != 0x48)
+	case 0x80 ... 0x83:
+		/*
+		 * 1000 00sw : mod OP r/m : immediate
+		 *
+		 * s - sign extend immediate
+		 * w - imm8 / imm32
+		 *
+		 * OP: 000 ADD    100 AND
+		 *     001 OR     101 SUB
+		 *     010 ADC    110 XOR
+		 *     011 SBB    111 CMP
+		 */
+
+		/* 64bit only */
+		if (!rex_w)
+			break;
+
+		/* %rsp target only */
+		if (!(modrm_mod == 3 && modrm_rm == CFI_SP))
 			break;
 
-		if (modrm == 0xe4) {
+		imm = insn.immediate.value;
+		if (op1 & 2) { /* sign extend */
+			if (op1 & 1) { /* imm32 */
+				imm <<= 32;
+				imm = (s64)imm >> 32;
+			} else { /* imm8 */
+				imm <<= 56;
+				imm = (s64)imm >> 56;
+			}
+		}
+
+		switch (modrm_reg & 7) {
+		case 5:
+			imm = -imm;
+			/* fallthrough */
+		case 0:
+			/* add/sub imm, %rsp */
+			ADD_OP(op) {
+				op->src.type = OP_SRC_ADD;
+				op->src.reg = CFI_SP;
+				op->src.offset = imm;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = CFI_SP;
+			}
+			break;
+
+		case 4:
 			/* and imm, %rsp */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_AND;
@@ -215,23 +258,12 @@ int arch_decode_instruction(const struct
 				op->dest.reg = CFI_SP;
 			}
 			break;
-		}
 
-		if (modrm == 0xc4)
-			sign = 1;
-		else if (modrm == 0xec)
-			sign = -1;
-		else
+		default:
+			/* WARN ? */
 			break;
-
-		/* add/sub imm, %rsp */
-		ADD_OP(op) {
-			op->src.type = OP_SRC_ADD;
-			op->src.reg = CFI_SP;
-			op->src.offset = insn.immediate.value * sign;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = CFI_SP;
 		}
+
 		break;
 
 	case 0x89:


