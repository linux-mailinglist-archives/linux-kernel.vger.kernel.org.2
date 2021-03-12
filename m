Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855D633948C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhCLRSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhCLRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:17:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4FBC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fff8wSjsFEVSScoLrEbNTADtep5HrGXAsNkRLBAqrKs=; b=bToz45S8NrJbPqIS5ZTpUPUFAn
        KWQytk/MYmsKWZEmhc6hXCTNVO6/3L/Mdi5XtZyue6DPE05K3YPfY1q9LKzbU20lSa7YV5sy1SUTz
        509yIm5PkbmhWDxnykxi8ezFB9UlOb7k9nJM8ISm5QSfLTEd0lpFGEe7h5BTP94CYJGasn5U+yVFZ
        bJOAvvYh6KcOKGU++naW4nqt73sxdmuM5YbhFwuVTBldzsxGYHILOEnG1TDnaFDXByGEs+7BaPKln
        pi+VFYN2v6toUwm2SkGh3StreoWdxtI7Lx3DuIUqoyKDI7Cvr2fne4RecOsf0UvEXgSAH2TfjynW0
        fFeD3sPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKlQA-00C53F-L5; Fri, 12 Mar 2021 17:17:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46C113060F3;
        Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1851E23CC2297; Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Message-ID: <20210312171653.771790856@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 18:16:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 7/9] objtool: Allow archs to rewrite retpolines
References: <20210312171613.533405394@infradead.org>
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
@@ -852,6 +852,14 @@ __weak bool arch_is_retpoline(struct sym
 	return false;
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
@@ -885,6 +893,9 @@ static int add_jump_destinations(struct
 				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
 
 			insn->retpoline_safe = true;
+
+			arch_rewrite_retpoline(file, insn, reloc);
+
 			continue;
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
@@ -1036,6 +1047,8 @@ static int add_call_destinations(struct
 			insn->type = INSN_CALL_DYNAMIC;
 			insn->retpoline_safe = true;
 
+			arch_rewrite_retpoline(file, insn, reloc);
+
 			remove_insn_ops(insn);
 			continue;
 
@@ -1212,6 +1225,8 @@ static int handle_group_alt(struct objto
 		dest_off = arch_jump_destination(insn);
 		if (dest_off == special_alt->new_off + special_alt->new_len)
 			insn->jump_dest = next_insn_same_sec(file, last_orig_insn);
+		else
+			insn->jump_dest = find_insn(file, insn->sec, dest_off);
 
 		if (!insn->jump_dest) {
 			WARN_FUNC("can't find alternative jump destination",
@@ -1797,11 +1812,15 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = add_jump_destinations(file);
+	/*
+	 * Must be before add_{jump,call}_destination; for they can add
+	 * magic alternatives.
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
 


