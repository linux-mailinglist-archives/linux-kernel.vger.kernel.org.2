Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAD0340BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhCRRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhCRRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:23:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABB0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7rvFF3BAZnSbryUzcKBSQ1HpAj+AxsMwCFNQdxeJg/Y=; b=TDwanHh92NDjT24h83anfjo5uk
        FLlToEJvqTGS3zJjMsPn/iDk0sxYY9GVdoFabIPabbzRtlR7iuuxFK5gkewk0ID0HaDfZT4Y6u13b
        0/Z5GyZFTiThVyP/036QhPgdeDUnZ0K0vL8tnh7Rue+MriLPAz/emXJ2toyKmuZXUx1x7IlGl6CVj
        jmzuLQkqMVM4at6+83FBioGd2EWrXRiGB3GWsQugYH4X6lgU9dYtccqV/jjG/AX8y6cJfR4W22kJj
        H+5pHPuBhRpQ6DPZ64+BVipFYLYv1IEwhg1GuX4TT9zfaowx4QCfDt4zqsMZUffi8XreOdZsXL3Tg
        AyliePRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMp-005kES-JC; Thu, 18 Mar 2021 17:23:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C57B3060F3;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 15BA2238A4644; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171919.520075106@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 02/14] x86/alternatives: Optimize optimize_nops()
References: <20210318171103.577093939@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently optimize_nops() scans to see if the alternative starts with
NOPs. However, the emit pattern is:

  141:	\oldinstr
  142:	.skip (len-(142b-141b)), 0x90

That is, when oldinstr is short, we pad the tail with NOPs. This case
never gets optimized.

Rewrite optimize_nops() to replace any string of NOPs inside the
alternative to larger NOPs. Also run it irrespective of patching,
replacing NOPs in both the original and replaced code.

A direct consequence is that padlen becomes superfluous, so remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h            |   14 ++---
 arch/x86/kernel/alternative.c                 |   61 ++++++++++++++++----------
 tools/objtool/arch/x86/include/arch/special.h |    2 
 3 files changed, 45 insertions(+), 32 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -65,7 +65,6 @@ struct alt_instr {
 	u16 cpuid;		/* cpuid bit set for replacement */
 	u8  instrlen;		/* length of original instruction */
 	u8  replacementlen;	/* length of new instruction */
-	u8  padlen;		/* length of build-time padding */
 } __packed;
 
 /*
@@ -104,7 +103,6 @@ static inline int alternatives_text_rese
 
 #define alt_end_marker		"663"
 #define alt_slen		"662b-661b"
-#define alt_pad_len		alt_end_marker"b-662b"
 #define alt_total_slen		alt_end_marker"b-661b"
 #define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
 
@@ -151,8 +149,7 @@ static inline int alternatives_text_rese
 	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
 	" .word " __stringify(feature) "\n"		/* feature bit     */ \
 	" .byte " alt_total_slen "\n"			/* source len      */ \
-	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
-	" .byte " alt_pad_len "\n"			/* pad len */
+	" .byte " alt_rlen(num) "\n"			/* replacement len */
 
 #define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
 	"# ALT: replacement " #num "\n"						\
@@ -315,13 +312,12 @@ static inline int alternatives_text_rese
  * enough information for the alternatives patching code to patch an
  * instruction. See apply_alternatives().
  */
-.macro altinstruction_entry orig alt feature orig_len alt_len pad_len
+.macro altinstruction_entry orig alt feature orig_len alt_len
 	.long \orig - .
 	.long \alt - .
 	.word \feature
 	.byte \orig_len
 	.byte \alt_len
-	.byte \pad_len
 .endm
 
 /*
@@ -338,7 +334,7 @@ static inline int alternatives_text_rese
 142:
 
 	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f,142b-141b
+	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f
 	.popsection
 
 	.pushsection .altinstr_replacement,"ax"
@@ -375,8 +371,8 @@ static inline int alternatives_text_rese
 142:
 
 	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f,142b-141b
-	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f,142b-141b
+	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f
+	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
 	.popsection
 
 	.pushsection .altinstr_replacement,"ax"
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -345,19 +345,39 @@ recompute_jump(struct alt_instr *a, u8 *
 static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
 {
 	unsigned long flags;
-	int i;
+	int nops = 0, i = 0;
+	struct insn insn;
+	u8 *nop = NULL;
 
-	for (i = 0; i < a->padlen; i++) {
-		if (instr[i] != 0x90)
+	do {
+		if (insn_decode_kernel(&insn, &instr[i]))
 			return;
-	}
 
-	local_irq_save(flags);
-	add_nops(instr + (a->instrlen - a->padlen), a->padlen);
-	local_irq_restore(flags);
+		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90) {
+			if (!nop) {
+				nop = &instr[i];
+				nops = 1;
+			} else {
+				nops++;
+			}
+		}
+		i += insn.length;
+
+		if ((insn.length != 1 || i == a->instrlen) && nop) {
+
+			local_irq_save(flags);
+			add_nops(nop, nops);
+			local_irq_restore(flags);
+
+			DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
+				   instr, (int)(unsigned long)(nop-instr), nops);
+
+			nop = NULL;
+		}
 
-	DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
-		   instr, a->instrlen - a->padlen, a->padlen);
+	} while (i < a->instrlen);
+
+	WARN_ON_ONCE(nop);
 }
 
 /*
@@ -403,19 +423,15 @@ void __init_or_module noinline apply_alt
 		 * - feature not present but ALTINSTR_FLAG_INV is set to mean,
 		 *   patch if feature is *NOT* present.
 		 */
-		if (!boot_cpu_has(feature) == !(a->cpuid & ALTINSTR_FLAG_INV)) {
-			if (a->padlen > 1)
-				optimize_nops(a, instr);
-
-			continue;
-		}
+		if (!boot_cpu_has(feature) == !(a->cpuid & ALTINSTR_FLAG_INV))
+			goto next;
 
-		DPRINTK("feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d",
+		DPRINTK("feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
 			(a->cpuid & ALTINSTR_FLAG_INV) ? "!" : "",
 			feature >> 5,
 			feature & 0x1f,
 			instr, instr, a->instrlen,
-			replacement, a->replacementlen, a->padlen);
+			replacement, a->replacementlen);
 
 		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
 		DUMP_BYTES(replacement, a->replacementlen, "%px: rpl_insn: ", replacement);
@@ -439,14 +455,15 @@ void __init_or_module noinline apply_alt
 		if (a->replacementlen && is_jmp(replacement[0]))
 			recompute_jump(a, instr, replacement, insn_buff);
 
-		if (a->instrlen > a->replacementlen) {
-			add_nops(insn_buff + a->replacementlen,
-				 a->instrlen - a->replacementlen);
-			insn_buff_sz += a->instrlen - a->replacementlen;
-		}
+		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
+			insn_buff[insn_buff_sz] = 0x90;
+
 		DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
+
+next:
+		optimize_nops(a, instr);
 	}
 }
 
--- a/tools/objtool/arch/x86/include/arch/special.h
+++ b/tools/objtool/arch/x86/include/arch/special.h
@@ -10,7 +10,7 @@
 #define JUMP_ORIG_OFFSET	0
 #define JUMP_NEW_OFFSET		4
 
-#define ALT_ENTRY_SIZE		13
+#define ALT_ENTRY_SIZE		12
 #define ALT_ORIG_OFFSET		0
 #define ALT_NEW_OFFSET		4
 #define ALT_FEATURE_OFFSET	8


