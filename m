Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBC33B2BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhFXJ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhFXJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A556C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pc1xEXQTcTB5wVgUPF5AqTuG35xVXy/ucIeK7GUluZs=; b=snSmF9Se1jkqPSk1vltaIb1wVk
        3aGPoUt4q94GjpUKHLHQGkWOQ+pbqIBXcEGJgC4Yuv1jjCXGnP235j4wl+H+u59f249JqqEd7FgAm
        ZXTWxOUTmc8OqzQJcI9GtyGr/WHvIi/4l7lwCxjCYs7znjarot9bukFDKqsWYR4+J8IYAaU9Jn7to
        tqWCpwdDGZTuBs2Lgf3Sj1BJ4rCrat9B/QO0nY8dx5RKtp5WS5NdtFGAqJrdPDOb26jqJe/KB62ln
        8oTzGzkV+2am1GGRKhYutXoH9cUanz6kQC0XOuI0EASFZ0bLSQEaYbQSLnY+GLZLkpCZyavyRqzkL
        kwsWO2OQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM40-00GQOX-Se; Thu, 24 Jun 2021 09:54:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA9883002D7;
        Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A378B2BC05F2D; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095147.818783799@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 03/24] objtool: Handle __sanitize_cov*() tail calls
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out the compilers also generate tail calls to __sanitize_cov*(),
make sure to also patch those out in noinstr code.

Fixes: 0f1441b44e82 ("objtool: Fix noinstr vs KCOV")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c      |   20 ++++
 tools/objtool/check.c                |  153 ++++++++++++++++++-----------------
 tools/objtool/include/objtool/arch.h |    1 
 3 files changed, 100 insertions(+), 74 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -659,6 +659,26 @@ const char *arch_nop_insn(int len)
 	return nops[len-1];
 }
 
+#define BYTE_RET	0xC3
+
+const char *arch_ret_insn(int len)
+{
+	static const char ret[5][5] = {
+		{ BYTE_RET },
+		{ BYTE_RET, BYTES_NOP1 },
+		{ BYTE_RET, BYTES_NOP2 },
+		{ BYTE_RET, BYTES_NOP3 },
+		{ BYTE_RET, BYTES_NOP4 },
+	};
+
+	if (len < 1 || len > 5) {
+		WARN("invalid RET size: %d\n", len);
+		return NULL;
+	}
+
+	return ret[len-1];
+}
+
 /* asm/alternative.h ? */
 
 #define ALTINSTR_FLAG_INV	(1 << 15)
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -828,6 +828,74 @@ static struct reloc *insn_reloc(struct o
 	return insn->reloc;
 }
 
+static void remove_insn_ops(struct instruction *insn)
+{
+	struct stack_op *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
+		list_del(&op->list);
+		free(op);
+	}
+}
+
+static void add_call_dest(struct objtool_file *file, struct instruction *insn,
+			  struct symbol *dest, bool sibling)
+{
+	struct reloc *reloc = insn_reloc(file, insn);
+
+	insn->call_dest = dest;
+	if (!dest)
+		return;
+
+	if (insn->call_dest->static_call_tramp) {
+		list_add_tail(&insn->call_node,
+			      &file->static_call_list);
+	}
+
+	if (insn->sec->noinstr &&
+	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+		if (reloc) {
+			reloc->type = R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+
+		elf_write_insn(file->elf, insn->sec,
+			       insn->offset, insn->len,
+			       sibling ? arch_ret_insn(insn->len)
+			               : arch_nop_insn(insn->len));
+
+		insn->type = sibling ? INSN_RETURN : INSN_NOP;
+	}
+
+	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
+		if (sibling)
+			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
+
+		if (reloc) {
+			reloc->type = R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+
+		elf_write_insn(file->elf, insn->sec,
+			       insn->offset, insn->len,
+			       arch_nop_insn(insn->len));
+
+		insn->type = INSN_NOP;
+
+		list_add_tail(&insn->mcount_loc_node,
+			      &file->mcount_loc_list);
+	}
+
+	/*
+	 * Whatever stack impact regular CALLs have, should be undone
+	 * by the RETURN of the called function.
+	 *
+	 * Annotated intra-function calls retain the stack_ops but
+	 * are converted to JUMP, see read_intra_function_calls().
+	 */
+	remove_insn_ops(insn);
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -866,11 +934,7 @@ static int add_jump_destinations(struct
 			continue;
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
-			insn->call_dest = reloc->sym;
-			if (insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->call_node,
-					      &file->static_call_list);
-			}
+			add_call_dest(file, insn, reloc->sym, true);
 			continue;
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
@@ -926,13 +990,8 @@ static int add_jump_destinations(struct
 
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
 				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
-
 				/* internal sibling call (without reloc) */
-				insn->call_dest = insn->jump_dest->func;
-				if (insn->call_dest->static_call_tramp) {
-					list_add_tail(&insn->call_node,
-						      &file->static_call_list);
-				}
+				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}
 		}
 	}
@@ -940,16 +999,6 @@ static int add_jump_destinations(struct
 	return 0;
 }
 
-static void remove_insn_ops(struct instruction *insn)
-{
-	struct stack_op *op, *tmp;
-
-	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
-		list_del(&op->list);
-		free(op);
-	}
-}
-
 static struct symbol *find_call_destination(struct section *sec, unsigned long offset)
 {
 	struct symbol *call_dest;
@@ -968,6 +1017,7 @@ static int add_call_destinations(struct
 {
 	struct instruction *insn;
 	unsigned long dest_off;
+	struct symbol *dest;
 	struct reloc *reloc;
 
 	for_each_insn(file, insn) {
@@ -977,7 +1027,9 @@ static int add_call_destinations(struct
 		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
-			insn->call_dest = find_call_destination(insn->sec, dest_off);
+			dest = find_call_destination(insn->sec, dest_off);
+
+			add_call_dest(file, insn, dest, false);
 
 			if (insn->ignore)
 				continue;
@@ -995,9 +1047,8 @@ static int add_call_destinations(struct
 
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-			insn->call_dest = find_call_destination(reloc->sym->sec,
-								dest_off);
-			if (!insn->call_dest) {
+			dest = find_call_destination(reloc->sym->sec, dest_off);
+			if (!dest) {
 				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  reloc->sym->sec->name,
@@ -1005,6 +1056,8 @@ static int add_call_destinations(struct
 				return -1;
 			}
 
+			add_call_dest(file, insn, dest, false);
+
 		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline calls are really dynamic calls in
@@ -1020,55 +1073,7 @@ static int add_call_destinations(struct
 			continue;
 
 		} else
-			insn->call_dest = reloc->sym;
-
-		if (insn->call_dest && insn->call_dest->static_call_tramp) {
-			list_add_tail(&insn->call_node,
-				      &file->static_call_list);
-		}
-
-		/*
-		 * Many compilers cannot disable KCOV with a function attribute
-		 * so they need a little help, NOP out any KCOV calls from noinstr
-		 * text.
-		 */
-		if (insn->sec->noinstr &&
-		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
-			if (reloc) {
-				reloc->type = R_NONE;
-				elf_write_reloc(file->elf, reloc);
-			}
-
-			elf_write_insn(file->elf, insn->sec,
-				       insn->offset, insn->len,
-				       arch_nop_insn(insn->len));
-			insn->type = INSN_NOP;
-		}
-
-		if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
-			if (reloc) {
-				reloc->type = R_NONE;
-				elf_write_reloc(file->elf, reloc);
-			}
-
-			elf_write_insn(file->elf, insn->sec,
-				       insn->offset, insn->len,
-				       arch_nop_insn(insn->len));
-
-			insn->type = INSN_NOP;
-
-			list_add_tail(&insn->mcount_loc_node,
-				      &file->mcount_loc_list);
-		}
-
-		/*
-		 * Whatever stack impact regular CALLs have, should be undone
-		 * by the RETURN of the called function.
-		 *
-		 * Annotated intra-function calls retain the stack_ops but
-		 * are converted to JUMP, see read_intra_function_calls().
-		 */
-		remove_insn_ops(insn);
+			add_call_dest(file, insn, reloc->sym, false);
 	}
 
 	return 0;
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -82,6 +82,7 @@ unsigned long arch_jump_destination(stru
 unsigned long arch_dest_reloc_offset(int addend);
 
 const char *arch_nop_insn(int len);
+const char *arch_ret_insn(int len);
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
 


