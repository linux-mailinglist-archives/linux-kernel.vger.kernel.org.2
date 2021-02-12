Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32BA319B88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBLIyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:54:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96D2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 00:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XA61lGSebO6j5KZpbdjl8p3Bghqc3IFOB3gC+eQJU/0=; b=VOIRJ06ASuJc/tj5Mjw+U+LyVX
        RoGhYdu4L0wJfMlq2MNpjb9TzPE28cn52euSQnGRBWujUzCO33HE9KzDUQB3+62i2GD0KDVwpXl5z
        6JseIt/K94J9qZuUTFRmajKMHkiyj+jTXG9DMKJ8Xtg0RL+kHbUruQWlHf0+YA/AuaruAPLQ45BwZ
        pWJNaldoaMdPwa7nX4cWWq/0pUBB5H0MxRmVvPH06y4P0vkZekwQ+D+OrDT2jL6Li2tz8i2+0NMcC
        EvlF4JDGH0Kh4SiC9UPm9Xq9oTWSwUh4VQU9jI7w5kyli6lpzbFcbNjgTffdTzdjF3WZTkVoT8eGq
        jJTFyvNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAUCW-0006CG-S4; Fri, 12 Feb 2021 08:53:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 537E330066E;
        Fri, 12 Feb 2021 09:53:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E12B29DD66B7; Fri, 12 Feb 2021 09:53:18 +0100 (CET)
Date:   Fri, 12 Feb 2021 09:53:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 8/7] objtool,x86: More ModRM sugar
Message-ID: <YCZB/ljatFXqQbm8@hirez.programming.kicks-ass.net>
References: <20210211173044.141215027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211173044.141215027@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I promise, I'll stop poking at it more :-)

---

Subject: objtool,x86: More ModRM sugar
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Feb 12 09:13:00 CET 2021

Better helpers to decode ModRM.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -82,15 +82,21 @@ unsigned long arch_jump_destination(stru
  * 01 |  [r/m + d8]    |[S+d]|   [r/m + d8]  |
  * 10 |  [r/m + d32]   |[S+D]|   [r/m + d32] |
  * 11 |                   r/ m               |
- *
  */
+
+#define mod_is_mem()	(modrm_mod != 3)
+#define mod_is_reg()	(modrm_mod == 3)
+
 #define is_RIP()   ((modrm_rm & 7) == CFI_BP && modrm_mod == 0)
-#define have_SIB() ((modrm_rm & 7) == CFI_SP && modrm_mod != 3)
+#define have_SIB() ((modrm_rm & 7) == CFI_SP && mod_is_mem())
 
 #define rm_is(reg) (have_SIB() ? \
 		    sib_base == (reg) && sib_index == CFI_SP : \
 		    modrm_rm == (reg))
 
+#define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))
+#define rm_is_reg(reg)	(mod_is_reg() && modrm_rm == (reg))
+
 int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -154,7 +160,7 @@ int arch_decode_instruction(const struct
 
 	case 0x1:
 	case 0x29:
-		if (rex_w && modrm_mod == 3 && modrm_rm == CFI_SP) {
+		if (rex_w && rm_is_reg(CFI_SP)) {
 
 			/* add/sub reg, %rsp */
 			ADD_OP(op) {
@@ -219,7 +225,7 @@ int arch_decode_instruction(const struct
 			break;
 
 		/* %rsp target only */
-		if (!(modrm_mod == 3 && modrm_rm == CFI_SP))
+		if (!rm_is_reg(CFI_SP))
 			break;
 
 		imm = insn.immediate.value;
@@ -272,7 +278,7 @@ int arch_decode_instruction(const struct
 
 		if (modrm_reg == CFI_SP) {
 
-			if (modrm_mod == 3) {
+			if (mod_is_reg()) {
 				/* mov %rsp, reg */
 				ADD_OP(op) {
 					op->src.type = OP_SRC_REG;
@@ -308,7 +314,7 @@ int arch_decode_instruction(const struct
 			break;
 		}
 
-		if (modrm_mod == 3 && modrm_rm == CFI_SP) {
+		if (rm_is_reg(CFI_SP)) {
 
 			/* mov reg, %rsp */
 			ADD_OP(op) {
@@ -325,7 +331,7 @@ int arch_decode_instruction(const struct
 		if (!rex_w)
 			break;
 
-		if ((modrm_mod == 1 || modrm_mod == 2) && modrm_rm == CFI_BP) {
+		if (rm_is_mem(CFI_BP)) {
 
 			/* mov reg, disp(%rbp) */
 			ADD_OP(op) {
@@ -338,7 +344,7 @@ int arch_decode_instruction(const struct
 			break;
 		}
 
-		if (modrm_mod != 3 && rm_is(CFI_SP)) {
+		if (rm_is_mem(CFI_SP)) {
 
 			/* mov reg, disp(%rsp) */
 			ADD_OP(op) {
@@ -357,7 +363,7 @@ int arch_decode_instruction(const struct
 		if (!rex_w)
 			break;
 
-		if ((modrm_mod == 1 || modrm_mod == 2) && modrm_rm == CFI_BP) {
+		if (rm_is_mem(CFI_BP)) {
 
 			/* mov disp(%rbp), reg */
 			ADD_OP(op) {
@@ -370,7 +376,7 @@ int arch_decode_instruction(const struct
 			break;
 		}
 
-		if (modrm_mod != 3 && rm_is(CFI_SP)) {
+		if (rm_is_mem(CFI_SP)) {
 
 			/* mov disp(%rsp), reg */
 			ADD_OP(op) {
@@ -386,7 +392,7 @@ int arch_decode_instruction(const struct
 		break;
 
 	case 0x8d:
-		if (modrm_mod == 3) {
+		if (mod_is_reg()) {
 			WARN("invalid LEA encoding at %s:0x%lx", sec->name, offset);
 			break;
 		}
