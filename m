Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97943161E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhBJJPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBJJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:10:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255F6C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 01:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dO0NJfmNcSuP+xVtY92vSbmQs6DWgIFj1BGa13sdq/o=; b=rZolrWGo1JD/UAL5vOlr5w68xz
        ZptF0Qbem3xuQ/xZW3Up1xaVzf2HkJk7WB0pbL3lj7KN1mO3cXB3yywMOKFmmOh6BoEcw6s3rtu9w
        +uAyv2C1lcjn5CSdU8Tl3c3Ksi+K0lXfi3GcJ0ZeHfbbIQxDW2xzdCL/sBCt+91VluKkiZiJ1Njqw
        lomwLzhiC3MFwrDlw2C9f9tKa/ZPGUn/JzKULySf2pbd4LytuTWT8YbAVYFKdAnD0P4xaxGrz6FQG
        fEf4EkreJ4WpPTaVXZ2lTUAQucGsJ42haB7RWhsUm1vytvWyQLJFVWz+AGLFqm+nhbxjYSDVUQCjF
        VbLKtjxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9lUW-008cwT-1X; Wed, 10 Feb 2021 09:08:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CECC13006D0;
        Wed, 10 Feb 2021 10:08:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF543201D19B1; Wed, 10 Feb 2021 10:08:51 +0100 (CET)
Date:   Wed, 10 Feb 2021 10:08:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2.1 2/3] objtool,x86: Additionally decode: mov %rsp, (%reg)
Message-ID: <YCOiowWtr8XTT+mN@hirez.programming.kicks-ass.net>
References: <20210209091600.075402197@infradead.org>
 <20210209093521.924097404@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209093521.924097404@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Subject: objtool,x86: Additionally decode: mov %rsp, (%reg)
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Feb 3 12:02:18 CET 2021

Where we already decode: mov %rsp, %reg, also decode mov %rsp, (%reg).

Nothing should match for this new stack-op.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |   42 ++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -222,15 +222,38 @@ int arch_decode_instruction(const struct
 		break;
 
 	case 0x89:
-		if (rex_w && !rex_r && modrm_mod == 3 && modrm_reg == 4) {
+		if (rex_w && !rex_r && modrm_reg == 4) {
 
-			/* mov %rsp, reg */
-			ADD_OP(op) {
-				op->src.type = OP_SRC_REG;
-				op->src.reg = CFI_SP;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+			if (modrm_mod == 3) {
+				/* mov %rsp, reg */
+				ADD_OP(op) {
+					op->src.type = OP_SRC_REG;
+					op->src.reg = CFI_SP;
+					op->dest.type = OP_DEST_REG;
+					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+				}
+				break;
+
+			} else {
+				/* skip nontrivial SIB */
+				if (modrm_rm == 4 && sib != 0x24)
+					break;
+
+				/* skip RIP relative displacement */
+				if (modrm_rm == 5 && modrm_mod == 0)
+					break;
+
+				/* mov %rsp, disp(%reg) */
+				ADD_OP(op) {
+					op->src.type = OP_SRC_REG;
+					op->src.reg = CFI_SP;
+					op->dest.type = OP_DEST_REG_INDIRECT;
+					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+					op->dest.offset = insn.displacement.value;
+				}
+				break;
 			}
+
 			break;
 		}
 
@@ -259,8 +282,10 @@ int arch_decode_instruction(const struct
 				op->dest.reg = CFI_BP;
 				op->dest.offset = insn.displacement.value;
 			}
+			break;
+		}
 
-		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
+		if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
 
 			/* mov reg, disp(%rsp) */
 			ADD_OP(op) {
@@ -270,6 +295,7 @@ int arch_decode_instruction(const struct
 				op->dest.reg = CFI_SP;
 				op->dest.offset = insn.displacement.value;
 			}
+			break;
 		}
 
 		break;
