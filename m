Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D9376907
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbhEGQuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbhEGQus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:50:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0D2C061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3tY7c5T46UuOkry+vPsIbMU2YrXGGOfrHw8UQ6nq/i8=; b=cxg0yOnII4vstNUUzcUZeQLpYn
        f+StQP5PF5BmMfcszoyX0SlgjVB/3A1UtG5l64qik7DkeSeN5XeS/OopKn4RmVQQPTi5y65TL2n81
        5qWhCZkkLyTDewDVQVSuC6QdkbMi0cgFfsxtJmCSl2krIqjMAYykoRZPBYYMGT+6QVW8ZNXuHhZGJ
        aMhJT0dbUuuU6wV12Tox5kP9EL01aan4wUJouWm33QWk9pP4GNEvsEZm13y/7z6bSt0q33H/OcYWC
        k3HMbR3N9+rg9zjz8w5ajd5wgPxX/Ru1ChSGRpdx26zgKldZQvsN1i3bwoOJSQAgrO5DW8cm0EvPA
        Zi/Y+iiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lf3fK-003M7E-OH; Fri, 07 May 2021 16:49:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C50F986472; Fri,  7 May 2021 18:49:25 +0200 (CEST)
Date:   Fri, 7 May 2021 18:49:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>, mbenes@suse.de
Subject: Re: [PATCH] objtool: Allocate CFI state lazily
Message-ID: <20210507164925.GC54801@worktop.programming.kicks-ass.net>
References: <20210505033835.1282751-1-ak@linux.intel.com>
 <YJUvmt1vXN9FeTrV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJUvmt1vXN9FeTrV@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 02:16:26PM +0200, Peter Zijlstra wrote:
> On Tue, May 04, 2021 at 08:38:35PM -0700, Andi Kleen wrote:
> > @@ -2694,9 +2706,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> >  			state.instr += insn->instr;
> >  
> >  		if (insn->hint)
> > -			state.cfi = insn->cfi;
> > +			state.cfi = *insn_get_cfi(insn);
> >  		else
> > -			insn->cfi = state.cfi;
> > +			*insn_get_cfi(insn) = state.cfi;
> >  
> >  		insn->visited |= visited;
> 
> This; that still allocates a CFI for every instruction we see. Given you
> see a reduction in memory use, the only explanation I have for that is
> that we have a lot of instruction that are not executed (crap between
> functions?)
> 
> I've modified the thing to re-use the allocation of the previous
> instruction when the CFI didn't change and added a default func_cfi.
> 
> This drops x86_64-defconfig processing from 1.8G to 1.0G and 6.0s to 4.3s.
> 
> There might be room for further improvements...

allyesconfig/vmlinux.o

orig:	6:17.83 real,   150.43 user,    88.55 sys,      29189972 mem
prev:	2:38.22 real,   105.06 user,    51.97 sys,      17869952 mem
this:	2:29.80 real,   105.18 user,    44.61 sys,      16170064 mem

---
 tools/objtool/Makefile                |   2 +-
 tools/objtool/arch/x86/decode.c       |   2 +-
 tools/objtool/check.c                 | 155 ++++++++++++++++++++++++++++++----
 tools/objtool/include/objtool/cfi.h   |   2 +
 tools/objtool/include/objtool/check.h |   4 +-
 tools/objtool/orc_gen.c               |  15 +++-
 6 files changed, 155 insertions(+), 25 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 92ce4fce7bc7..32f830bfe94b 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -30,7 +30,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/objtool/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
-CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g3 $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cedf3ede7545..3f4d4444df8b 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -776,7 +776,7 @@ int arch_rewrite_retpolines(struct objtool_file *file)
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 {
-	struct cfi_reg *cfa = &insn->cfi.cfa;
+	struct cfi_reg *cfa = &insn->cfip->cfa;
 
 	switch (sp_reg) {
 	case ORC_REG_UNDEFINED:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2c6a93edf27e..ac5ad27ca374 100644
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
@@ -265,6 +269,87 @@ static void init_insn_state(struct insn_state *state, struct section *sec)
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
@@ -275,7 +360,6 @@ static int decode_instructions(struct objtool_file *file)
 	struct symbol *func;
 	unsigned long offset;
 	struct instruction *insn;
-	unsigned long nr_insns = 0;
 	int ret;
 
 	for_each_sec(file, sec) {
@@ -301,7 +385,6 @@ static int decode_instructions(struct objtool_file *file)
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
-			init_cfi_state(&insn->cfi);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -1136,7 +1219,6 @@ static int handle_group_alt(struct objtool_file *file,
 		memset(nop, 0, sizeof(*nop));
 		INIT_LIST_HEAD(&nop->alts);
 		INIT_LIST_HEAD(&nop->stack_ops);
-		init_cfi_state(&nop->cfi);
 
 		nop->sec = special_alt->new_sec;
 		nop->offset = special_alt->new_off + special_alt->new_len;
@@ -1546,9 +1628,10 @@ static void set_func_state(struct cfi_state *state)
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
@@ -1586,19 +1669,21 @@ static int read_unwind_hints(struct objtool_file *file)
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
@@ -2452,13 +2537,18 @@ static int propagate_alt_cfi(struct objtool_file *file, struct instruction *insn
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
@@ -2509,9 +2599,14 @@ static int handle_insn_ops(struct instruction *insn,
 
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
@@ -2696,7 +2791,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			   struct instruction *insn, struct insn_state state)
 {
 	struct alternative *alt;
-	struct instruction *next_insn;
+	struct instruction *next_insn, *prev_insn = NULL;
 	struct section *sec;
 	u8 visited;
 	int ret;
@@ -2725,15 +2820,24 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
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
 
@@ -2883,6 +2987,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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
diff --git a/tools/objtool/include/objtool/cfi.h b/tools/objtool/include/objtool/cfi.h
index fd5cb0bed9bf..f11d1ac1dadf 100644
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
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 56d50bc50c10..c5959a84aacf 100644
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
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index dc9b7dd314b0..f52bde0f536b 100644
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
@@ -162,7 +168,7 @@ int orc_create(struct objtool_file *file)
 			int i;
 
 			if (!alt_group) {
-				if (init_orc_entry(&orc, &insn->cfi))
+				if (init_orc_entry(&orc, insn->cfip, insn))
 					return -1;
 				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
 					continue;
@@ -186,7 +192,8 @@ int orc_create(struct objtool_file *file)
 				struct cfi_state *cfi = alt_group->cfi[i];
 				if (!cfi)
 					continue;
-				if (init_orc_entry(&orc, cfi))
+				/* errors are reported on the original insn */
+				if (init_orc_entry(&orc, cfi, insn))
 					return -1;
 				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
 					continue;
