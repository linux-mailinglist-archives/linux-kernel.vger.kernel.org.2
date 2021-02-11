Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110493191E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhBKSIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbhBKRlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:41:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFED7C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8KqJmI5pwXWmxsu6Bhe1JOaP3dAS38iL8+9rAolUI3M=; b=nSJ3Xfq7MytztqBJi7HvLseY3+
        6oXvlpew1zqPoz0rpnt1u2IUKPdbo1XJIpP1wdi/2nN45ldg6zpBw5PVSbOR1xnjVMlxRcHnxm8Tw
        G4OpY+x/w20L0+/ol7XUaEoEmBhN6QLj4IhpuNvHekOhP+LEo/453fGnaNJCgEbRL5Nw8O5vY4X0c
        +vAE+mduJ4fJTyylOaxh/ZkZD4T3ZGHiOfQm70S5fKdAgOvPTUJr8PD63/4mslkiqv8ytIEC2U+9S
        bBV5/EirVgxF+qDWZrYHfEFkJN6WQCC4TEW1Hy5KWAL/DzvLg7yf8wuHZLYiDXeig9FUicTCB1g+A
        ce9lwuew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lAFxO-00AY0L-TW; Thu, 11 Feb 2021 17:40:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CBA93062BA;
        Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0BB8D2BCDFC7A; Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Message-ID: <20210211173627.362004522@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 11 Feb 2021 18:30:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH v2 5/7] objtool,x86: Simplify register decode
References: <20210211173044.141215027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the CFI_reg number now matches the instruction encoding order do
away with the op_to_cfi_reg[] and use direct assignment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |   79 +++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -17,17 +17,6 @@
 #include <objtool/arch.h>
 #include <objtool/warn.h>
 
-static unsigned char op_to_cfi_reg[][2] = {
-	{CFI_AX, CFI_R8},
-	{CFI_CX, CFI_R9},
-	{CFI_DX, CFI_R10},
-	{CFI_BX, CFI_R11},
-	{CFI_SP, CFI_R12},
-	{CFI_BP, CFI_R13},
-	{CFI_SI, CFI_R14},
-	{CFI_DI, CFI_R15},
-};
-
 static int is_x86_64(const struct elf *elf)
 {
 	switch (elf->ehdr.e_machine) {
@@ -94,7 +83,7 @@ int arch_decode_instruction(const struct
 	unsigned char op1, op2,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
-		      sib = 0;
+		      sib = 0 /* , sib_scale = 0, sib_index = 0, sib_base = 0 */;
 	struct stack_op *op = NULL;
 	struct symbol *sym;
 
@@ -130,23 +119,29 @@ int arch_decode_instruction(const struct
 	if (insn.modrm.nbytes) {
 		modrm = insn.modrm.bytes[0];
 		modrm_mod = X86_MODRM_MOD(modrm);
-		modrm_reg = X86_MODRM_REG(modrm);
-		modrm_rm = X86_MODRM_RM(modrm);
+		modrm_reg = X86_MODRM_REG(modrm) + 8*rex_r;
+		modrm_rm  = X86_MODRM_RM(modrm)  + 8*rex_b;
 	}
 
-	if (insn.sib.nbytes)
+	if (insn.sib.nbytes) {
 		sib = insn.sib.bytes[0];
+		/*
+		sib_scale = X86_SIB_SCALE(sib);
+		sib_index = X86_SIB_INDEX(sib) + 8*rex_x;
+		sib_base  = X86_SIB_BASE(sib)  + 8*rex_b;
+		 */
+	}
 
 	switch (op1) {
 
 	case 0x1:
 	case 0x29:
-		if (rex_w && !rex_b && modrm_mod == 3 && modrm_rm == 4) {
+		if (rex_w && modrm_mod == 3 && modrm_rm == CFI_SP) {
 
 			/* add/sub reg, %rsp */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
-				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->src.reg = modrm_reg;
 				op->dest.type = OP_DEST_REG;
 				op->dest.reg = CFI_SP;
 			}
@@ -158,7 +153,7 @@ int arch_decode_instruction(const struct
 		/* push reg */
 		ADD_OP(op) {
 			op->src.type = OP_SRC_REG;
-			op->src.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
+			op->src.reg = (op1 & 0x7) + 8*rex_b;
 			op->dest.type = OP_DEST_PUSH;
 		}
 
@@ -170,7 +165,7 @@ int arch_decode_instruction(const struct
 		ADD_OP(op) {
 			op->src.type = OP_SRC_POP;
 			op->dest.type = OP_DEST_REG;
-			op->dest.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
+			op->dest.reg = (op1 & 0x7) + 8*rex_b;
 		}
 
 		break;
@@ -223,7 +218,7 @@ int arch_decode_instruction(const struct
 		break;
 
 	case 0x89:
-		if (rex_w && !rex_r && modrm_reg == 4) {
+		if (rex_w && modrm_reg == CFI_SP) {
 
 			if (modrm_mod == 3) {
 				/* mov %rsp, reg */
@@ -231,17 +226,17 @@ int arch_decode_instruction(const struct
 					op->src.type = OP_SRC_REG;
 					op->src.reg = CFI_SP;
 					op->dest.type = OP_DEST_REG;
-					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+					op->dest.reg = modrm_rm;
 				}
 				break;
 
 			} else {
 				/* skip nontrivial SIB */
-				if (modrm_rm == 4 && !(sib == 0x24 && rex_b == rex_x))
+				if ((modrm_rm & 7) == 4 && !(sib == 0x24 && rex_b == rex_x))
 					break;
 
 				/* skip RIP relative displacement */
-				if (modrm_rm == 5 && modrm_mod == 0)
+				if ((modrm_rm & 7) == 5 && modrm_mod == 0)
 					break;
 
 				/* mov %rsp, disp(%reg) */
@@ -249,7 +244,7 @@ int arch_decode_instruction(const struct
 					op->src.type = OP_SRC_REG;
 					op->src.reg = CFI_SP;
 					op->dest.type = OP_DEST_REG_INDIRECT;
-					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+					op->dest.reg = modrm_rm;
 					op->dest.offset = insn.displacement.value;
 				}
 				break;
@@ -258,12 +253,12 @@ int arch_decode_instruction(const struct
 			break;
 		}
 
-		if (rex_w && !rex_b && modrm_mod == 3 && modrm_rm == 4) {
+		if (rex_w && modrm_mod == 3 && modrm_rm == CFI_SP) {
 
 			/* mov reg, %rsp */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
-				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->src.reg = modrm_reg;
 				op->dest.type = OP_DEST_REG;
 				op->dest.reg = CFI_SP;
 			}
@@ -272,13 +267,12 @@ int arch_decode_instruction(const struct
 
 		/* fallthrough */
 	case 0x88:
-		if (!rex_b &&
-		    (modrm_mod == 1 || modrm_mod == 2) && modrm_rm == 5) {
+		if ((modrm_mod == 1 || modrm_mod == 2) && modrm_rm == CFI_BP) {
 
 			/* mov reg, disp(%rbp) */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
-				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->src.reg = modrm_reg;
 				op->dest.type = OP_DEST_REG_INDIRECT;
 				op->dest.reg = CFI_BP;
 				op->dest.offset = insn.displacement.value;
@@ -286,12 +280,12 @@ int arch_decode_instruction(const struct
 			break;
 		}
 
-		if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
+		if (rex_w && modrm_rm == CFI_SP && sib == 0x24) {
 
 			/* mov reg, disp(%rsp) */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
-				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->src.reg = modrm_reg;
 				op->dest.type = OP_DEST_REG_INDIRECT;
 				op->dest.reg = CFI_SP;
 				op->dest.offset = insn.displacement.value;
@@ -302,7 +296,10 @@ int arch_decode_instruction(const struct
 		break;
 
 	case 0x8b:
-		if (rex_w && !rex_b && modrm_mod == 1 && modrm_rm == 5) {
+		if (!rex_w)
+			break;
+
+		if (modrm_mod == 1 && modrm_rm == CFI_BP) {
 
 			/* mov disp(%rbp), reg */
 			ADD_OP(op) {
@@ -310,11 +307,12 @@ int arch_decode_instruction(const struct
 				op->src.reg = CFI_BP;
 				op->src.offset = insn.displacement.value;
 				op->dest.type = OP_DEST_REG;
-				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->dest.reg = modrm_reg;
 			}
+			break;
+		}
 
-		} else if (rex_w && !rex_b && sib == 0x24 &&
-			   modrm_mod != 3 && modrm_rm == 4) {
+		if (modrm_mod != 3 && modrm_rm == CFI_SP && sib == 0x24) {
 
 			/* mov disp(%rsp), reg */
 			ADD_OP(op) {
@@ -322,8 +320,9 @@ int arch_decode_instruction(const struct
 				op->src.reg = CFI_SP;
 				op->src.offset = insn.displacement.value;
 				op->dest.type = OP_DEST_REG;
-				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->dest.reg = modrm_reg;
 			}
+			break;
 		}
 
 		break;
@@ -334,11 +333,11 @@ int arch_decode_instruction(const struct
 			break;
 
 		/* skip nontrivial SIB */
-		if (modrm_rm == 4 && !(sib == 0x24 && rex_b == rex_x))
+		if ((modrm_rm & 7) == 4 && !(sib == 0x24 && rex_b == rex_x))
 			break;
 
 		/* skip RIP relative displacement */
-		if (modrm_rm == 5 && modrm_mod == 0)
+		if ((modrm_rm & 7) == 5 && modrm_mod == 0)
 			break;
 
 		/* lea disp(%src), %dst */
@@ -351,9 +350,9 @@ int arch_decode_instruction(const struct
 				/* lea disp(%src), %dst */
 				op->src.type = OP_SRC_ADD;
 			}
-			op->src.reg = op_to_cfi_reg[modrm_rm][rex_b];
+			op->src.reg = modrm_rm;
 			op->dest.type = OP_DEST_REG;
-			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+			op->dest.reg = modrm_reg;
 		}
 		break;
 


