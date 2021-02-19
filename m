Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1432001E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBSVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBSVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:10:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C964C061786
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 13:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BFzdNc4Al+4SwJijnkTefSWEjv9BX66AFUmawVT+FnY=; b=eoHDOS6o6dmNloHFdV7o9nMtgi
        afZow+ME621FXQHQd6qSyjU4Ph6pgKZMrkZW5ZmRltzBoTPu2ybVpARQs4FfMW8B01TCSAmuyhKaa
        4Wazjr3TWWS6Qgs+TkTyQrM4VnOMhNXzA162CRlNDezs2WffSsXKwq0AYiIRzEjonXw9d9S+psZCh
        zysloMGQ6Y4DXHmJ7Wx3ZtuLNMJkeO0IrCWKN7lE9aWc5fjq49WeppfXvMmtQS5FcYP3rq7f00F6j
        aTYGBOa1QEfQFoEWJ0s0sYo1ka9bBs9rCX5de+xgiVZeP3IWzNq+ndyoa+5mEpZU2oaksyrCztvK5
        O1Ha+i0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDD2N-0006Ga-U3; Fri, 19 Feb 2021 21:10:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E7DC3070D5;
        Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 526972021555F; Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Message-ID: <20210219210535.431965352@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Feb 2021 21:43:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, x86@kernel.org, pjt@google.com,
        mbenes@suze.cz, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 5/6] objtool: Allow archs to rewrite retpolines
References: <20210219204300.749932493@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When retpolines are employed, compilers typically emit calls to
retpoline thunks. Objtool recognises these calls and marks them as
dynamic calls.

Provide infrastructure for architectures to rewrite/augment what the
compiler wrote for us.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                |   23 +++++++++++++++++++++--
 tools/objtool/include/objtool/arch.h |    3 +++
 2 files changed, 24 insertions(+), 2 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -775,6 +775,14 @@ static int add_ignore_alternatives(struc
 	return 0;
 }
 
+
+__weak int arch_rewrite_retpoline(struct objtool_file *file,
+				  struct instruction *insn,
+				  struct reloc *reloc)
+{
+	return 0;
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -808,6 +816,9 @@ static int add_jump_destinations(struct
 				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
 
 			insn->retpoline_safe = true;
+
+			arch_rewrite_retpoline(file, insn, reloc);
+
 			continue;
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
@@ -959,6 +970,8 @@ static int add_call_destinations(struct
 			insn->type = INSN_CALL_DYNAMIC;
 			insn->retpoline_safe = true;
 
+			arch_rewrite_retpoline(file, insn, reloc);
+
 			remove_insn_ops(insn);
 			continue;
 
@@ -1119,6 +1132,8 @@ static int handle_group_alt(struct objto
 		dest_off = arch_jump_destination(insn);
 		if (dest_off == special_alt->new_off + special_alt->new_len)
 			insn->jump_dest = next_insn_same_sec(file, last_orig_insn);
+		else
+			insn->jump_dest = find_insn(file, insn->sec, dest_off);
 
 		if (!insn->jump_dest) {
 			WARN_FUNC("can't find alternative jump destination",
@@ -1704,11 +1719,15 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = add_jump_destinations(file);
+	/*
+	 * Must be before add_{jump,call}_destination; for they can add
+	 * magic alternatives we can't actually parse.
+	 */
+	ret = add_special_section_alts(file);
 	if (ret)
 		return ret;
 
-	ret = add_special_section_alts(file);
+	ret = add_jump_destinations(file);
 	if (ret)
 		return ret;
 
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -82,6 +82,9 @@ unsigned long arch_jump_destination(stru
 unsigned long arch_dest_reloc_offset(int addend);
 
 const char *arch_nop_insn(int len);
+int arch_rewrite_retpoline(struct objtool_file *file,
+			   struct instruction *insn,
+			   struct reloc *reloc);
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
 


