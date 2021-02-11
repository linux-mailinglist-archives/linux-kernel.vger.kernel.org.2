Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217CB3191DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhBKSH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhBKRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:41:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9218DC06178B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=XZjX3/qbtdYNtSlEKn95X0KZlxcQpu6IJ1bRw7/tVO0=; b=NlXa1tVBYPurBPHgIQfS7E3aoo
        DeztOz54UJIdsY8xBBJdd7CTs2vEpGJwqjskh0YDnUUsPEOQzpreqTRe4tmsu412SJ1e3sUP2sXwj
        N42UAJEnc8Tt0juzLXBz8R1z9VjNgO+11lA7dW+8OXEMcs/W0+8gwHJbITZva8g33EZ4CEfojPxNF
        47Bt45UCFfjejLI8jqjB7obtK2DjbipXlfiRmM+zhQwCpJs76HJnKbF+QBMISSZDD5NYyuaWyj3xX
        uzerjpl9/nNSadrjnIwFQMWNIVroRcFjIDxJqdRvPx83PLOfzJoD10Z9P5E5YkaHT71A9BUGzaad0
        uFCQ0t+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAFxP-0005c5-PX; Thu, 11 Feb 2021 17:40:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2278D3062EA;
        Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 114912BC34265; Thu, 11 Feb 2021 18:40:45 +0100 (CET)
Message-ID: <20210211173627.472967498@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 11 Feb 2021 18:30:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH v2 6/7] objtool,x86: Support %riz encodings
References: <20210211173044.141215027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there's a SIB byte, the register otherwise denoted by r/m will
then be denoted by SIB.base REX.b will now extend this. SIB.index == SP
is magic and notes an index value zero.

This means that there's a bunch of alternative (longer) encodings for
the same thing. Eg. 'ModRM.mod != 3, ModRM.r/m = AX' can be encoded as
'ModRM.mod != 3, ModRM.r/m = SP, SIB.base = AX, SIB.index = SP' which is actually 4
different encodings because the value of SIB.scale is irrelevant,
giving rise to 5 different but equal encodings.

Support these encodings and clean up the SIB handling in general.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |   67 ++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 19 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -72,6 +72,25 @@ unsigned long arch_jump_destination(stru
 		return -1; \
 	else for (list_add_tail(&op->list, ops_list); op; op = NULL)
 
+/*
+ * Helpers to decode ModRM/SIB:
+ *
+ * r/m| AX  CX  DX  BX |  SP |  BP |  SI  DI |
+ *    | R8  R9 R10 R11 | R12 | R13 | R14 R15 |
+ * Mod+----------------+-----+-----+---------+
+ * 00 |    [r/m]       |[SIB]|[IP+]|  [r/m]  |
+ * 01 |  [r/m + d8]    |[S+d]|   [r/m + d8]  |
+ * 10 |  [r/m + d32]   |[S+D]|   [r/m + d32] |
+ * 11 |                   r/ m               |
+ *
+ */
+#define is_RIP()   ((modrm_rm & 7) == CFI_BP && modrm_mod == 0)
+#define have_SIB() ((modrm_rm & 7) == CFI_SP && modrm_mod != 3)
+
+#define rm_is(reg) (have_SIB() ? \
+		    sib_base == (reg) && sib_index == CFI_SP : \
+		    modrm_rm == (reg))
+
 int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -83,7 +102,7 @@ int arch_decode_instruction(const struct
 	unsigned char op1, op2,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
-		      sib = 0 /* , sib_scale = 0, sib_index = 0, sib_base = 0 */;
+		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
 	struct stack_op *op = NULL;
 	struct symbol *sym;
 
@@ -125,11 +144,9 @@ int arch_decode_instruction(const struct
 
 	if (insn.sib.nbytes) {
 		sib = insn.sib.bytes[0];
-		/*
-		sib_scale = X86_SIB_SCALE(sib);
+		/* sib_scale = X86_SIB_SCALE(sib); */
 		sib_index = X86_SIB_INDEX(sib) + 8*rex_x;
 		sib_base  = X86_SIB_BASE(sib)  + 8*rex_b;
-		 */
 	}
 
 	switch (op1) {
@@ -218,7 +235,10 @@ int arch_decode_instruction(const struct
 		break;
 
 	case 0x89:
-		if (rex_w && modrm_reg == CFI_SP) {
+		if (!rex_w)
+			break;
+
+		if (modrm_reg == CFI_SP) {
 
 			if (modrm_mod == 3) {
 				/* mov %rsp, reg */
@@ -231,14 +251,17 @@ int arch_decode_instruction(const struct
 				break;
 
 			} else {
-				/* skip nontrivial SIB */
-				if ((modrm_rm & 7) == 4 && !(sib == 0x24 && rex_b == rex_x))
-					break;
-
 				/* skip RIP relative displacement */
-				if ((modrm_rm & 7) == 5 && modrm_mod == 0)
+				if (is_RIP())
 					break;
 
+				/* skip nontrivial SIB */
+				if (have_SIB()) {
+					modrm_rm = sib_base;
+					if (sib_index != CFI_SP)
+						break;
+				}
+
 				/* mov %rsp, disp(%reg) */
 				ADD_OP(op) {
 					op->src.type = OP_SRC_REG;
@@ -253,7 +276,7 @@ int arch_decode_instruction(const struct
 			break;
 		}
 
-		if (rex_w && modrm_mod == 3 && modrm_rm == CFI_SP) {
+		if (modrm_mod == 3 && modrm_rm == CFI_SP) {
 
 			/* mov reg, %rsp */
 			ADD_OP(op) {
@@ -267,6 +290,9 @@ int arch_decode_instruction(const struct
 
 		/* fallthrough */
 	case 0x88:
+		if (!rex_w)
+			break;
+
 		if ((modrm_mod == 1 || modrm_mod == 2) && modrm_rm == CFI_BP) {
 
 			/* mov reg, disp(%rbp) */
@@ -280,7 +306,7 @@ int arch_decode_instruction(const struct
 			break;
 		}
 
-		if (rex_w && modrm_rm == CFI_SP && sib == 0x24) {
+		if (modrm_mod != 3 && rm_is(CFI_SP)) {
 
 			/* mov reg, disp(%rsp) */
 			ADD_OP(op) {
@@ -299,7 +325,7 @@ int arch_decode_instruction(const struct
 		if (!rex_w)
 			break;
 
-		if (modrm_mod == 1 && modrm_rm == CFI_BP) {
+		if ((modrm_mod == 1 || modrm_mod == 2) && modrm_rm == CFI_BP) {
 
 			/* mov disp(%rbp), reg */
 			ADD_OP(op) {
@@ -312,7 +338,7 @@ int arch_decode_instruction(const struct
 			break;
 		}
 
-		if (modrm_mod != 3 && modrm_rm == CFI_SP && sib == 0x24) {
+		if (modrm_mod != 3 && rm_is(CFI_SP)) {
 
 			/* mov disp(%rsp), reg */
 			ADD_OP(op) {
@@ -332,14 +358,17 @@ int arch_decode_instruction(const struct
 		if (!rex_w)
 			break;
 
-		/* skip nontrivial SIB */
-		if ((modrm_rm & 7) == 4 && !(sib == 0x24 && rex_b == rex_x))
-			break;
-
 		/* skip RIP relative displacement */
-		if ((modrm_rm & 7) == 5 && modrm_mod == 0)
+		if (is_RIP())
 			break;
 
+		/* skip nontrivial SIB */
+		if (have_SIB()) {
+			modrm_rm = sib_base;
+			if (sib_index != CFI_SP)
+				break;
+		}
+
 		/* lea disp(%src), %dst */
 		ADD_OP(op) {
 			op->src.offset = insn.displacement.value;


