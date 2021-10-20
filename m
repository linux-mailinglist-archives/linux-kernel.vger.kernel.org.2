Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19794349A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhJTLGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhJTLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:06:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722DCC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2KeoqRLePXN8Oq8amW25Bs77+PlAxHNXR8If6BImhJ8=; b=iKAmFKYYSFuDpVzS0V7ekrLaLr
        W+0JgFlsG3qX+KIVEVbu/snLckkqORqAuuBvD/D1K7mjukBkEfQ+H8fKjQ9YcVysDZCZgz8COYKq9
        7nTKq1DpM6QMvM7we6A6F81hUpcmDcmoEF3vAjlibuPjOOV93InaLK2IGx4V+vDYB56hcaioPId3x
        iTLEFnC24gdBpHLvh/lJpyfsQ2yy97/darKk454If0pZaz27P2WIl9Mwh3uUE02+JP5oke0GK6wa3
        0FU8KN4KrKluRgb8PYJ1k/4OjcGwacXAKWGcf6UB/8mAwMFfnNCImm8tnHxBLb2qbBDqO+c/R/lFP
        80wnPJgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9Kz-00CR0z-Qx; Wed, 20 Oct 2021 11:01:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 057BB3003A9;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DFC70201BB3C8; Wed, 20 Oct 2021 13:00:49 +0200 (CEST)
Message-ID: <20211020105842.617682654@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 02/14] objtool: Explicitly avoid self modifying code in .altinstr_replacement
References: <20211020104442.021802560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assume ALTERNATIVE()s know what they're doing and do not change, or
cause to change, instructions in .altinstr_replacement sections.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -993,18 +993,27 @@ static void remove_insn_ops(struct instr
 	}
 }
 
-static void add_call_dest(struct objtool_file *file, struct instruction *insn,
-			  struct symbol *dest, bool sibling)
+static void annotate_call_site(struct objtool_file *file,
+			       struct instruction *insn, bool sibling)
 {
 	struct reloc *reloc = insn_reloc(file, insn);
+	struct symbol *sym = insn->call_dest;
 
-	insn->call_dest = dest;
-	if (!dest)
+	if (!sym)
+		sym = reloc->sym;
+
+	/*
+	 * Alternative replacement code is just template code which is
+	 * sometimes copied to the original instruction, For now, don't
+	 * annotate it. (In the future we might consider annotating the
+	 * original instruction if/when it ever makes sense to do so.).
+	 */
+	if (!strcmp(insn->sec->name, ".altinstr_replacement"))
 		return;
 
-	if (insn->call_dest->static_call_tramp) {
-		list_add_tail(&insn->call_node,
-			      &file->static_call_list);
+	if (sym->static_call_tramp) {
+		list_add_tail(&insn->call_node, &file->static_call_list);
+		return;
 	}
 
 	/*
@@ -1013,7 +1022,7 @@ static void add_call_dest(struct objtool
 	 * text.
 	 */
 	if (insn->sec->noinstr &&
-	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+	    !strncmp(sym->name, "__sanitizer_cov_", 16)) {
 		if (reloc) {
 			reloc->type = R_NONE;
 			elf_write_reloc(file->elf, reloc);
@@ -1025,9 +1034,10 @@ static void add_call_dest(struct objtool
 			               : arch_nop_insn(insn->len));
 
 		insn->type = sibling ? INSN_RETURN : INSN_NOP;
+		return;
 	}
 
-	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
+	if (mcount && !strcmp(sym->name, "__fentry__")) {
 		if (sibling)
 			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
 
@@ -1042,9 +1052,17 @@ static void add_call_dest(struct objtool
 
 		insn->type = INSN_NOP;
 
-		list_add_tail(&insn->mcount_loc_node,
-			      &file->mcount_loc_list);
+		list_add_tail(&insn->mcount_loc_node, &file->mcount_loc_list);
+		return;
 	}
+}
+
+static void add_call_dest(struct objtool_file *file, struct instruction *insn,
+			  struct symbol *dest, bool sibling)
+{
+	insn->call_dest = dest;
+	if (!dest)
+		return;
 
 	/*
 	 * Whatever stack impact regular CALLs have, should be undone
@@ -1054,6 +1072,8 @@ static void add_call_dest(struct objtool
 	 * are converted to JUMP, see read_intra_function_calls().
 	 */
 	remove_insn_ops(insn);
+
+	annotate_call_site(file, insn, sibling);
 }
 
 /*


