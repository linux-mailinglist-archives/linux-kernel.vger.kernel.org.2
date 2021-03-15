Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557C833C04D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhCOPqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhCOPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:45:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD9FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZOzASczcp3MbFcop4KsiZ8bI3zq+avkz+THR3aLEoBM=; b=HfmqVqLEqJ+qvIYYCmFHcDzung
        q/Znc8cIOeh+Gmqcdl7ZS80zJ31FH1Eh0gQLfRPqtbT5VyvVBSt6LS+D1FIpzw3LF2miSQK3h+S2S
        DBG8YnGVG5yc3/6055mIuis5x4ja8X/lN1Dipvo4MxVHpgqQZ5tGMNM46eR/5SYzx2cUFqbwvGQMi
        2Gm+C2leBt0oF7xRijdBqpdz3dVAUKI9uRAt4bivnHeNwEmJFcwgmNJpeP1v0qmXE95oRv286pHMk
        jfvE4DZD/AAVt74ECALqFjWQI3PujWv7p2pm8QNjgYGagrT+P6oUY15oMFEmLbUlYj9AWmNdBZx1m
        qxRDJNdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLpPJ-000NzY-Sl; Mon, 15 Mar 2021 15:45:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D230A305C10;
        Mon, 15 Mar 2021 16:45:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFBF12D8B2253; Mon, 15 Mar 2021 16:45:24 +0100 (CET)
Date:   Mon, 15 Mar 2021 16:45:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] x86/alternatives: Optimize optimize_nops()
Message-ID: <YE+BFIil8wj+q8Qi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 arch/x86/kernel/alternative.c                 |   63 ++++++++++++++++----------
 tools/objtool/arch/x86/include/arch/special.h |    2 
 3 files changed, 46 insertions(+), 33 deletions(-)

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
+
+	do {
+		kernel_insn_init(&insn, &instr[i], MAX_INSN_SIZE);
+		insn_get_length(&insn);
+
+		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90) {
+			if (!nop) {
+				nop = &instr[i];
+				nops = 1;
+			} else {
+				nops++;
+			}
+		}
+		i += insn.length;
 
-	for (i = 0; i < a->padlen; i++) {
-		if (instr[i] != 0x90)
-			return;
-	}
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
 
-	local_irq_save(flags);
-	add_nops(instr + (a->instrlen - a->padlen), a->padlen);
-	local_irq_restore(flags);
+	} while (i < a->instrlen);
 
-	DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
-		   instr, a->instrlen - a->padlen, a->padlen);
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
+		if (!boot_cpu_has(feature) == !(a->cpuid & ALTINSTR_FLAG_INV))
+			goto next;
 
-			continue;
-		}
-
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
