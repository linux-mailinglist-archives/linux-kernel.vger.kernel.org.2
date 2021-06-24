Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A055F3B2BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhFXJ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhFXJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0491FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BDcNDv5r/MIGeQyXYNVz094AGo56DYA/ZP7pug4zl3w=; b=fxdckZ7UtYp1unIqBPq5RWNiur
        ls9wQTMZnIHnmuO1fxScx9PCdX9tlzL05u8/vpdFJa5PMVfUWWkewBl/I8ydOIF3bs9kPY77zroU4
        y5u2X6GiBfcXe1olA5lWtQomEOvTF7T4u1P4DqVCaixD/5ZjSnc+fdcgZ3stlS2uq+g82caxyqYp6
        O2Tz0pMr+f760Dd85vbwR6f/MEGmkkqjiCteiPF6mBEAAbEHbwHN0iW6poSXGXu1MgjVJiTjngzMu
        vsKtbchAYDv5Q5ciD2lBYDJxeZcT70I22wlB25xktYR9dTJUjfaNhJ1zTJGg95PfhKht5bwIUNUi/
        zE6Kc7GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM40-00GQOV-Rt; Thu, 24 Jun 2021 09:54:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DCA2430031C;
        Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9D8412BC05F2B; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624095147.756759107@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v2 02/24] objtool: Introduce CFI hash
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi reported that objtool on vmlinux.o consumes more memory than his
system has, leading to horrific performance.

This is in part because we keep a struct instruction for every
instruction in the file in-memory. Shrink struct instruction by
removing the CFI state (which includes full register state) from it
and demand allocating it.

Given most instructions don't actually change CFI state, there's lots
of repetition there, so add a hash table to find previous CFI
instances.

Reduces memory consumption (and runtime) for processing an
x86_64-allyesconfig:

  pre:  4:40.84 real,   143.99 user,    44.18 sys,      30624988 mem
  post: 2:14.61 real,   108.58 user,    25.04 sys,      16396184 mem

Suggested-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c       |    2 
 tools/objtool/check.c                 |  155 ++++++++++++++++++++++++++++++----
 tools/objtool/include/objtool/cfi.h   |    2 
 tools/objtool/include/objtool/check.h |    4 
 tools/objtool/orc_gen.c               |   15 ++-
 5 files changed, 154 insertions(+), 24 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -781,7 +781,7 @@ int arch_rewrite_retpolines(struct objto
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 {
-	struct cfi_reg *cfa = &insn->cfi.cfa;
+	struct cfi_reg *cfa = &insn->cfip->cfa;
 
 	switch (sp_reg) {
 	case ORC_REG_UNDEFINED:
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -5,6 +5,7 @@
 
 #include <string.h>
 #include <stdlib.h>
+#include <sys/mman.h>
 
 #include <arch/elf.h>
 #include <objtool/builtin.h>
@@ -26,7 +27,10 @@ struct alternative {
 	bool skip_orig;
 };
 
-struct cfi_init_state initial_func_cfi;
+static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
+
+static struct cfi_init_state initial_func_cfi;
+static struct cfi_state func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
@@ -265,6 +269,87 @@ static void init_insn_state(struct insn_
 		state->noinstr = sec->noinstr;
 }
 
+static struct cfi_state *cfi_alloc(void)
+{
+	struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
+	if (!cfi) {
+		WARN("calloc failed");
+		exit(1);
+	}
+	nr_cfi++;
+	init_cfi_state(cfi);
+	return cfi;
+}
+
+struct cfi_state *insn_get_cfi(struct instruction *insn)
+{
+	if (!insn->cfip)
+		insn->cfip = cfi_alloc();
+
+	return insn->cfip;
+}
+
+static int cfi_bits;
+static struct hlist_head *cfi_hash;
+
+static inline bool cficmp(struct cfi_state *cfi1, struct cfi_state *cfi2)
+{
+	return memcmp((void *)cfi1 + sizeof(cfi1->hash),
+		      (void *)cfi2 + sizeof(cfi2->hash),
+		      sizeof(struct cfi_state) - sizeof(struct hlist_node));
+}
+
+static inline u32 cfi_key(struct cfi_state *cfi)
+{
+	return jhash((void *)cfi + sizeof(cfi->hash),
+		     sizeof(*cfi) - sizeof(cfi->hash), 0);
+}
+
+static struct cfi_state *cfi_hash_find(struct cfi_state *cfi)
+{
+	struct hlist_head *head = &cfi_hash[hash_min(cfi_key(cfi), cfi_bits)];
+	struct cfi_state *obj;
+
+	hlist_for_each_entry(obj, head, hash) {
+		if (!cficmp(cfi, obj)) {
+			nr_cfi_cache++;
+			return obj;
+		}
+	}
+
+	obj = cfi_alloc();
+	*obj = *cfi;
+	hlist_add_head(&obj->hash, head);
+
+	return obj;
+}
+
+static void cfi_hash_add(struct cfi_state *cfi)
+{
+	struct hlist_head *head = &cfi_hash[hash_min(cfi_key(cfi), cfi_bits)];
+
+	hlist_add_head(&cfi->hash, head);
+}
+
+static void *cfi_hash_alloc(unsigned long size)
+{
+	cfi_bits = max(10, ilog2(size));
+	cfi_hash = mmap(NULL, sizeof(struct hlist_head) << cfi_bits,
+			PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (cfi_hash == (void *)-1L) {
+		WARN("mmap fail cfi_hash");
+		cfi_hash = NULL;
+	}  else if (stats) {
+		printf("cfi_bits: %d\n", cfi_bits);
+	}
+
+	return cfi_hash;
+}
+
+static unsigned long nr_insns;
+static unsigned long nr_visited;
+
 /*
  * Call the arch-specific instruction decoder for all the instructions and add
  * them to the global instruction list.
@@ -275,7 +360,6 @@ static int decode_instructions(struct ob
 	struct symbol *func;
 	unsigned long offset;
 	struct instruction *insn;
-	unsigned long nr_insns = 0;
 	int ret;
 
 	for_each_sec(file, sec) {
@@ -301,7 +385,6 @@ static int decode_instructions(struct ob
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
-			init_cfi_state(&insn->cfi);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -1136,7 +1219,6 @@ static int handle_group_alt(struct objto
 		memset(nop, 0, sizeof(*nop));
 		INIT_LIST_HEAD(&nop->alts);
 		INIT_LIST_HEAD(&nop->stack_ops);
-		init_cfi_state(&nop->cfi);
 
 		nop->sec = special_alt->new_sec;
 		nop->offset = special_alt->new_off + special_alt->new_len;
@@ -1546,9 +1628,10 @@ static void set_func_state(struct cfi_st
 static int read_unwind_hints(struct objtool_file *file)
 {
 	struct section *sec, *relocsec;
-	struct reloc *reloc;
 	struct unwind_hint *hint;
 	struct instruction *insn;
+	struct cfi_state *cfi;
+	struct reloc *reloc;
 	int i;
 
 	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
@@ -1586,19 +1669,21 @@ static int read_unwind_hints(struct objt
 		insn->hint = true;
 
 		if (hint->type == UNWIND_HINT_TYPE_FUNC) {
-			set_func_state(&insn->cfi);
+			insn->cfip = &func_cfi;
 			continue;
 		}
 
+		cfi = insn_get_cfi(insn);
+
 		if (arch_decode_hint_reg(insn, hint->sp_reg)) {
 			WARN_FUNC("unsupported unwind_hint sp base reg %d",
 				  insn->sec, insn->offset, hint->sp_reg);
 			return -1;
 		}
 
-		insn->cfi.cfa.offset = bswap_if_needed(hint->sp_offset);
-		insn->cfi.type = hint->type;
-		insn->cfi.end = hint->end;
+		cfi->cfa.offset = bswap_if_needed(hint->sp_offset);
+		cfi->type = hint->type;
+		cfi->end = hint->end;
 	}
 
 	return 0;
@@ -2452,13 +2537,18 @@ static int propagate_alt_cfi(struct objt
 	if (!insn->alt_group)
 		return 0;
 
+	if (!insn->cfip) {
+		WARN("CFI missing");
+		return -1;
+	}
+
 	alt_cfi = insn->alt_group->cfi;
 	group_off = insn->offset - insn->alt_group->first_insn->offset;
 
 	if (!alt_cfi[group_off]) {
-		alt_cfi[group_off] = &insn->cfi;
+		alt_cfi[group_off] = insn->cfip;
 	} else {
-		if (memcmp(alt_cfi[group_off], &insn->cfi, sizeof(struct cfi_state))) {
+		if (cficmp(alt_cfi[group_off], insn->cfip)) {
 			WARN_FUNC("stack layout conflict in alternatives",
 				  insn->sec, insn->offset);
 			return -1;
@@ -2509,9 +2599,14 @@ static int handle_insn_ops(struct instru
 
 static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 {
-	struct cfi_state *cfi1 = &insn->cfi;
+	struct cfi_state *cfi1 = insn->cfip;
 	int i;
 
+	if (!cfi1) {
+		WARN("CFI missing");
+		return false;
+	}
+
 	if (memcmp(&cfi1->cfa, &cfi2->cfa, sizeof(cfi1->cfa))) {
 
 		WARN_FUNC("stack state mismatch: cfa1=%d%+d cfa2=%d%+d",
@@ -2696,7 +2791,7 @@ static int validate_branch(struct objtoo
 			   struct instruction *insn, struct insn_state state)
 {
 	struct alternative *alt;
-	struct instruction *next_insn;
+	struct instruction *next_insn, *prev_insn = NULL;
 	struct section *sec;
 	u8 visited;
 	int ret;
@@ -2725,15 +2820,24 @@ static int validate_branch(struct objtoo
 
 			if (insn->visited & visited)
 				return 0;
-		}
+		} else
+			nr_visited++;
 
 		if (state.noinstr)
 			state.instr += insn->instr;
 
-		if (insn->hint)
-			state.cfi = insn->cfi;
-		else
-			insn->cfi = state.cfi;
+		if (insn->hint) {
+			state.cfi = *insn->cfip;
+		} else {
+			/* XXX track if we actually changed state.cfi */
+
+			if (prev_insn && !cficmp(prev_insn->cfip, &state.cfi)) {
+				insn->cfip = prev_insn->cfip;
+				nr_cfi_reused++;
+			} else {
+				insn->cfip = cfi_hash_find(&state.cfi);
+			}
+		}
 
 		insn->visited |= visited;
 
@@ -2883,6 +2987,7 @@ static int validate_branch(struct objtoo
 			return 1;
 		}
 
+		prev_insn = insn;
 		insn = next_insn;
 	}
 
@@ -3138,12 +3243,19 @@ int check(struct objtool_file *file)
 	int ret, warnings = 0;
 
 	arch_initial_func_cfi_state(&initial_func_cfi);
+	init_cfi_state(&func_cfi);
+	set_func_state(&func_cfi);
 
 	ret = decode_sections(file);
 	if (ret < 0)
 		goto out;
 	warnings += ret;
 
+	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
+		goto out;
+
+	cfi_hash_add(&func_cfi);
+
 	if (list_empty(&file->insn_list))
 		goto out;
 
@@ -3192,6 +3304,13 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (stats) {
+		printf("nr_visited: %ld\n", nr_visited);
+		printf("nr_cfi: %ld\n", nr_cfi);
+		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
+		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
+	}
+
 out:
 	/*
 	 *  For now, don't fail the kernel build on fatal warnings.  These
--- a/tools/objtool/include/objtool/cfi.h
+++ b/tools/objtool/include/objtool/cfi.h
@@ -7,6 +7,7 @@
 #define _OBJTOOL_CFI_H
 
 #include <arch/cfi_regs.h>
+#include <linux/list.h>
 
 #define CFI_UNDEFINED		-1
 #define CFI_CFA			-2
@@ -24,6 +25,7 @@ struct cfi_init_state {
 };
 
 struct cfi_state {
+	struct hlist_node hash; /* must be first, cficmp() */
 	struct cfi_reg regs[CFI_NUM_REGS];
 	struct cfi_reg vals[CFI_NUM_REGS];
 	struct cfi_reg cfa;
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -60,9 +60,11 @@ struct instruction {
 	struct list_head alts;
 	struct symbol *func;
 	struct list_head stack_ops;
-	struct cfi_state cfi;
+	struct cfi_state *cfip;
 };
 
+extern struct cfi_state *insn_get_cfi(struct instruction *);
+
 static inline bool is_static_jump(struct instruction *insn)
 {
 	return insn->type == INSN_JUMP_CONDITIONAL ||
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -13,13 +13,19 @@
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
 
-static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
+static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
+			  struct instruction *insn)
 {
-	struct instruction *insn = container_of(cfi, struct instruction, cfi);
 	struct cfi_reg *bp = &cfi->regs[CFI_BP];
 
 	memset(orc, 0, sizeof(*orc));
 
+	if (!cfi) {
+		orc->end = 0;
+		orc->sp_reg = ORC_REG_UNDEFINED;
+		return 0;
+	}
+
 	orc->end = cfi->end;
 
 	if (cfi->cfa.base == CFI_UNDEFINED) {
@@ -162,7 +168,7 @@ int orc_create(struct objtool_file *file
 			int i;
 
 			if (!alt_group) {
-				if (init_orc_entry(&orc, &insn->cfi))
+				if (init_orc_entry(&orc, insn->cfip, insn))
 					return -1;
 				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
 					continue;
@@ -186,7 +192,8 @@ int orc_create(struct objtool_file *file
 				struct cfi_state *cfi = alt_group->cfi[i];
 				if (!cfi)
 					continue;
-				if (init_orc_entry(&orc, cfi))
+				/* errors are reported on the original insn */
+				if (init_orc_entry(&orc, cfi, insn))
 					return -1;
 				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
 					continue;


