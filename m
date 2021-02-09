Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37F2314BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBIJlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhBIJhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:37:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0C5C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mGTrZV14uJ2iyRlqc6jkMJ83Khjfg39JBNFy7JzVQek=; b=GxERX3wXbxeH+pBBK3750y+M5O
        wl98bBzcLQP6Th03yiCDuIaiWOG4kafns9UWYgTQxKHCJV6Abwz6Z3ybu2hD6SO4wcojYctgyiHEn
        hHD/urm5RNAh8LvzbSNz4ks8RqszXmUv5uMJuA5GRei9bPN10Eo9fD76EDUdEPOS05nvrC9h1Rp+A
        W79TH47Yp2adQ1d/53AylJfvfxakOoPd7MPf90yvYYn7GxVorGn/0QaqIxCWSQUyN1kyVaxoQZrxG
        bem7rGYHWMKH5KBKgXES10Dz4GQaIJRmSU2eXgeoLxFRSWEt5BYiV/kcSWlyzoyvWqL/H3evUy9jI
        /KkExQgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9PRc-007F7N-45; Tue, 09 Feb 2021 09:36:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 852ED306099;
        Tue,  9 Feb 2021 10:36:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6B2312BB568DD; Tue,  9 Feb 2021 10:36:25 +0100 (CET)
Message-ID: <20210209093521.924097404@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 09 Feb 2021 10:16:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 2/3] objtool,x86: Additionally decode: mov %rsp, (%reg)
References: <20210209091600.075402197@infradead.org>
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


