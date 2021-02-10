Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F4C31615B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBJIq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhBJIk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:40:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9D1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/GPvZaRgojtdY3kcT7rvSlB+DudLJBNJNksGm8HkQGc=; b=GPo8T8OLOFxlLHLZI3WxjeaZjJ
        ByKdNiuSZo9cxw9Ct8+3WOpwW4h9DpHJ/aKXvCTpTQ4xXNQpkHN/1WJZq7ogvnCsdTMv5z/tnM7e6
        Pl/01JlNNgbfQDx3bpGUQVtbaXmMnWSLa3t24/nI0e8jQyBwztF6HZIlhd53H72urliUqlLZB+X08
        i/3khjmA3qQjT1WtLjjsp7uqleogXkgJcseBgPIzfy7I3JGg+QWxFhVttG0Q6RyQd7z8oPosLz8DT
        UfHqEzLmQpzCeTa2r6mncO0Im/R4EWyWAQY0jr+LhPJ8qfhIoPyPMP+Yv9td6Qx2MIHuKvqjk/bCQ
        Ie2fRI3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9l2Q-008atL-RL; Wed, 10 Feb 2021 08:39:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C42353010D2;
        Wed, 10 Feb 2021 09:39:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BE99201D19B1; Wed, 10 Feb 2021 09:39:53 +0100 (CET)
Date:   Wed, 10 Feb 2021 09:39:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>, yu-cheng.yu@intel.com
Subject: [RFC][PATCH] objtool: WARN about ENDBR instructions
Message-ID: <YCOb2byLJhLOjhrL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Given all the ENDBR fun we recently had, do we want the below? Until
someone comes and fixes up kprobes/ftrace/livepatch etc.. having them is
a giant pain and we'd better warn about it.

---
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 931cef78b857..e708731b10cd 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -91,7 +91,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 {
 	struct insn insn;
 	int x86_64, sign;
-	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
+	unsigned char op1, op2, pfx = 0, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
 	struct stack_op *op = NULL;
@@ -118,6 +118,9 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
 
+	if (insn.prefixes.nbytes)
+		pfx = insn.prefixes.bytes[0];
+
 	if (insn.rex_prefix.nbytes) {
 		rex = insn.rex_prefix.bytes[0];
 		rex_w = X86_REX_W(rex) >> 3;
@@ -444,6 +447,11 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			/* nopl/nopw */
 			*type = INSN_NOP;
 
+		} else if (op2 == 0x1e && pfx == 0xf3 && (modrm == 0xfa || modrm == 0xfb)) {
+
+			/* endbr32/endbr64 */
+			WARN("endbr32/64 instruction at %s:0x%lx", sec->name, offset);
+
 		} else if (op2 == 0xa0 || op2 == 0xa8) {
 
 			/* push fs/gs */
