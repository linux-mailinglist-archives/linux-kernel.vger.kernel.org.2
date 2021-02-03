Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020A730D97C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhBCMFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhBCMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:05:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CA6C061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mGTrZV14uJ2iyRlqc6jkMJ83Khjfg39JBNFy7JzVQek=; b=GYmPMubE1GU6Ej41b0n2MyDWkU
        UWERapmv7IH0a5R7t+AA5yKFT36IOMbcJnQSswkDi5OCB60U1vnEJ3XsmpfjcPn5RPsDJ74bBKZOP
        1eueQf4NQp+a3yD4fovz03qX0R2ey0MyUGBIAskn6sfiHF17qtd7rbLIHws7X4P/TL1lKXp9VXZVI
        /cyucNeVIkhQoF77RdH2ySnfQq+N6NBhqgPw9D+qTYkctvIImkzgDF1/ILpqk56GGJw2Xg5H5tcZy
        0+F5j52I5avRu4j9IhcD7Ldjl++EVD4O5bmPj/ciesPdeWAdjn7ReH0vpQO8/A74lDToENscJ/pCF
        YcztdPTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7Gtl-0007gx-Jz; Wed, 03 Feb 2021 12:04:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F7CE3069B1;
        Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5F72B2BD45B6F; Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Message-ID: <20210203120401.261333068@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 13:02:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 4/5] objtool,x86: Additionally decode: mov %rsp, (%reg)
References: <20210203120222.451068583@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where we already decode: mov %rsp, %reg, also decode mov %rsp, (%reg).

Nothing should match for this new stack-op.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -222,14 +222,24 @@ int arch_decode_instruction(const struct
 		break;
 
 	case 0x89:
-		if (rex_w && !rex_r && modrm_mod == 3 && modrm_reg == 4) {
+		if (rex_w && !rex_r && modrm_reg == 4) {
 
-			/* mov %rsp, reg */
+			/* mov %rsp, */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
 				op->src.reg = CFI_SP;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+				if (modrm_mod == 3) {
+
+					/* mov %rsp, reg */
+					op->dest.type = OP_DEST_REG;
+					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+
+				} else if (modrm_mod == 0) {
+
+					/* mov %rsp, (%reg) */
+					op->dest.type = OP_DEST_REG_INDIRECT;
+					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+				}
 			}
 			break;
 		}
@@ -259,8 +269,10 @@ int arch_decode_instruction(const struct
 				op->dest.reg = CFI_BP;
 				op->dest.offset = insn.displacement.value;
 			}
+			break;
+		}
 
-		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
+		if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
 
 			/* mov reg, disp(%rsp) */
 			ADD_OP(op) {
@@ -270,6 +282,7 @@ int arch_decode_instruction(const struct
 				op->dest.reg = CFI_SP;
 				op->dest.offset = insn.displacement.value;
 			}
+			break;
 		}
 
 		break;


