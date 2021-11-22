Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AFC459485
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbhKVSNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239938AbhKVSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:13:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC4EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nLJQCSLMEKOdB1HX5XlkIMpIxd4c7zFZGDjX6eke1B0=; b=GiR5EuuQOCac6X0B/XiRdYT0lv
        xpSQHsu2u4JpUg50cFt0GAsk5U2vDlGT4F8u4JxCA7nZi4qPrLW3ha2T42Yp9+Qxjb1UYPMXlyNgT
        slFiDARonHcJarCEE7i1erfR62pI5N2irekJikYVEFO+/du0FVIXE0wQyPY4HuKMXzM2apApBUj/7
        0gOxYOF4RfG6cG+F7p1Zh945/ZDlcXve5ws7BgiZK51qkYUfoiUpL1upY770sJ03B8Jcosw6lXNCm
        v699QF1iWLxjH56qyLjbuEJkPeN8o/KlMJDQlqrgIv3HeKVQAwPjJ8DRwyFX9hCXmK1ZqUo6Zv14I
        GsnmWG7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpDlD-00D41G-3g; Mon, 22 Nov 2021 18:09:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F8E798664C; Mon, 22 Nov 2021 19:09:47 +0100 (CET)
Date:   Mon, 22 Nov 2021 19:09:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com
Subject: Re: [RFC][PATCH 3/6] x86: Add ENDBR to IRET-to-Self
Message-ID: <20211122180947.GA721624@worktop.programming.kicks-ass.net>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.149482391@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122170805.149482391@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 06:03:04PM +0100, Peter Zijlstra wrote:
> The IRET-to-Self chunks trigger forward code references without ENDBR,
> fix that.

Andy corrected me, IRET doesn't take ENBR, the alternative is the below.

---
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1316,7 +1316,6 @@ SYM_CODE_START(asm_exc_nmi)
 	iretq			/* continues at repeat_nmi below */
 	UNWIND_HINT_IRET_REGS entry=0
 1:
-	ENDBR
 #endif
 
 repeat_nmi:
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -6,7 +6,6 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/special_insns.h>
-#include <asm/ibt.h>
 
 #ifdef CONFIG_X86_32
 static inline void iret_to_self(void)
@@ -35,7 +34,6 @@ static inline void iret_to_self(void)
 		"pushq $1f\n\t"
 		"iretq\n\t"
 		"1:"
-		ASM_ENDBR
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
 }
 #endif /* CONFIG_X86_32 */
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -598,6 +598,7 @@ int arch_decode_instruction(struct objto
 				op->dest.type = OP_DEST_REG;
 				op->dest.reg = CFI_SP;
 			}
+			*type = INSN_IRET;
 			break;
 		}
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3587,7 +3587,7 @@ static int validate_ibt_reloc(struct obj
 static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
 {
 	struct reloc *reloc = insn_reloc(file, insn);
-	struct instruction *target;
+	struct instruction *target, *n;
 	unsigned long offset;
 
 	if (!reloc)
@@ -3599,8 +3599,16 @@ static void validate_ibt_insn(struct obj
 	offset = reloc->sym->offset + reloc->addend;
 
 	target = find_insn(file, reloc->sym->sec, offset);
-	if (target && insn->func == target->func && target->this_ip)
-		return;
+	if (target && insn->func == target->func) {
+		if (target->this_ip)
+			return;
+
+		for (n = insn; n->offset <= target->offset;
+		     n = next_insn_same_func(file, n)) {
+			if (n->type == INSN_IRET)
+				return;
+		}
+	}
 
 	WARN_FUNC("relocation to !ENDBR: %s+0x%lx",
 		  insn->sec, insn->offset,
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -27,6 +27,7 @@ enum insn_type {
 	INSN_STD,
 	INSN_CLD,
 	INSN_ENDBR,
+	INSN_IRET,
 	INSN_OTHER,
 };
 
