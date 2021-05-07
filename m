Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F213764F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbhEGMRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEGMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:17:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDBBC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BtaHR6kknQLLECzsUtErVmI5G/Fj5eKO0WYLhKMoPWw=; b=DEE4nj8X3qlHpDeCpqKxA0rXUc
        xNzVlTKBDMTob81j0m7sqjLC916LZB8QGKxAQ8weqye88T/C9g917YRVfs3u2sEfeZMlWsxlTbhAx
        sklLCEk7th3Nd/2RN/y0q7rj/CG1r6jUcvWhKJRKXQmNhqYhq+LfXBZQzD3dQVbM3VkJlAc5swA0N
        3YxMt3dGnDwGO/KhfOZ15B19vPcuOMRm3/4mwuZ+jvwGkp3GYssEYwwxNYi/YCERIQhMt7EvIDgZd
        gJLGj4xf1DtotLRd0rDRkqwfWJD0CgFiKPXqg/SoA+9IHXRtebIaiCMBS4BpxIaGV7F9AAC0vT7Kw
        lIbcXJww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lezP9-0072Ek-UY; Fri, 07 May 2021 12:16:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C4F83001D0;
        Fri,  7 May 2021 14:16:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 718512028F00F; Fri,  7 May 2021 14:16:26 +0200 (CEST)
Date:   Fri, 7 May 2021 14:16:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>, mbenes@suse.de
Subject: Re: [PATCH] objtool: Allocate CFI state lazily
Message-ID: <YJUvmt1vXN9FeTrV@hirez.programming.kicks-ass.net>
References: <20210505033835.1282751-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505033835.1282751-1-ak@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 08:38:35PM -0700, Andi Kleen wrote:
> @@ -2694,9 +2706,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  			state.instr += insn->instr;
>  
>  		if (insn->hint)
> -			state.cfi = insn->cfi;
> +			state.cfi = *insn_get_cfi(insn);
>  		else
> -			insn->cfi = state.cfi;
> +			*insn_get_cfi(insn) = state.cfi;
>  
>  		insn->visited |= visited;

This; that still allocates a CFI for every instruction we see. Given you
see a reduction in memory use, the only explanation I have for that is
that we have a lot of instruction that are not executed (crap between
functions?)

I've modified the thing to re-use the allocation of the previous
instruction when the CFI didn't change and added a default func_cfi.

This drops x86_64-defconfig processing from 1.8G to 1.0G and 6.0s to 4.3s.

There might be room for further improvements...

tools/objtool# /usr/bin/time -f "\t%E real,\t%U user,\t%S sys,\t%M mem"  ./objtool check -abdflrsu ../../defconfig-build/vmlinux.o
nr_sections: 23001
section_bits: 14
nr_symbols: 154328
symbol_bits: 17
max_reloc: 449748
tot_reloc: 1026063
reloc_bits: 19
nr_insns: 3176001
jl\     NOP     JMP
short:  2000    60
long:   1327    24
../../defconfig-build/vmlinux.o: warning: objtool: file already has .static_call_sites section, skipping
nr_cfi: 576321
nr_cfi_reused: 2234676
nr_cfi_func: 303671
	0:04.33 real,   2.88 user,      1.44 sys,       1081092 mem

---
 tools/objtool/arch/x86/decode.c       |  7 ++-
 tools/objtool/check.c                 | 86 ++++++++++++++++++++++++++++-------
 tools/objtool/include/objtool/check.h |  4 +-
 tools/objtool/orc_gen.c               | 15 ++++--
 4 files changed, 90 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cedf3ede7545..9eddeb02de60 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -776,7 +776,12 @@ int arch_rewrite_retpolines(struct objtool_file *file)
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 {
-	struct cfi_reg *cfa = &insn->cfi.cfa;
+	struct cfi_reg *cfa;
+
+	if (sp_reg == ORC_REG_UNDEFINED && !insn->cfip)
+		return 0;
+
+	cfa = &insn_get_cfi(insn)->cfa;
 
 	switch (sp_reg) {
 	case ORC_REG_UNDEFINED:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2c6a93edf27e..68136d9bdfa6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -26,7 +26,10 @@ struct alternative {
 	bool skip_orig;
 };
 
-struct cfi_init_state initial_func_cfi;
+static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_func;
+
+static struct cfi_init_state initial_func_cfi;
+static struct cfi_state func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
@@ -265,6 +268,22 @@ static void init_insn_state(struct insn_state *state, struct section *sec)
 		state->noinstr = sec->noinstr;
 }
 
+
+struct cfi_state *insn_get_cfi(struct instruction *insn)
+{
+	if (!insn->cfip) {
+		struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
+		if (!cfi) {
+			WARN("calloc failed");
+			exit(1);
+		}
+		nr_cfi++;
+		init_cfi_state(cfi);
+		insn->cfip = cfi;
+	}
+	return insn->cfip;
+}
+
 /*
  * Call the arch-specific instruction decoder for all the instructions and add
  * them to the global instruction list.
@@ -301,7 +320,6 @@ static int decode_instructions(struct objtool_file *file)
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
-			init_cfi_state(&insn->cfi);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -1136,7 +1154,6 @@ static int handle_group_alt(struct objtool_file *file,
 		memset(nop, 0, sizeof(*nop));
 		INIT_LIST_HEAD(&nop->alts);
 		INIT_LIST_HEAD(&nop->stack_ops);
-		init_cfi_state(&nop->cfi);
 
 		nop->sec = special_alt->new_sec;
 		nop->offset = special_alt->new_off + special_alt->new_len;
@@ -1546,9 +1563,10 @@ static void set_func_state(struct cfi_state *state)
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
@@ -1586,7 +1604,7 @@ static int read_unwind_hints(struct objtool_file *file)
 		insn->hint = true;
 
 		if (hint->type == UNWIND_HINT_TYPE_FUNC) {
-			set_func_state(&insn->cfi);
+			insn->cfip = &func_cfi;
 			continue;
 		}
 
@@ -1596,9 +1614,10 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn->cfi.cfa.offset = bswap_if_needed(hint->sp_offset);
-		insn->cfi.type = hint->type;
-		insn->cfi.end = hint->end;
+		cfi = insn_get_cfi(insn);
+		cfi->cfa.offset = bswap_if_needed(hint->sp_offset);
+		cfi->type = hint->type;
+		cfi->end = hint->end;
 	}
 
 	return 0;
@@ -2435,6 +2454,11 @@ static int update_cfi_state(struct instruction *insn,
 	return 0;
 }
 
+static inline bool cficmp(struct cfi_state *cfi1, struct cfi_state *cfi2)
+{
+	return memcmp(cfi1, cfi2, sizeof(struct cfi_state));
+}
+
 /*
  * The stack layouts of alternatives instructions can sometimes diverge when
  * they have stack modifications.  That's fine as long as the potential stack
@@ -2452,13 +2476,18 @@ static int propagate_alt_cfi(struct objtool_file *file, struct instruction *insn
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
@@ -2509,9 +2538,14 @@ static int handle_insn_ops(struct instruction *insn,
 
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
@@ -2696,7 +2730,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			   struct instruction *insn, struct insn_state state)
 {
 	struct alternative *alt;
-	struct instruction *next_insn;
+	struct instruction *next_insn, *prev_insn = NULL;
 	struct section *sec;
 	u8 visited;
 	int ret;
@@ -2730,10 +2764,21 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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
+			if (!cficmp(&func_cfi, &state.cfi)) {
+				insn->cfip = &func_cfi;
+				nr_cfi_func++;
+			} else if (prev_insn && !cficmp(prev_insn->cfip, &state.cfi)) {
+				insn->cfip = prev_insn->cfip;
+				nr_cfi_reused++;
+			} else {
+				*insn_get_cfi(insn) = state.cfi;
+			}
+		}
 
 		insn->visited |= visited;
 
@@ -2883,6 +2928,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 1;
 		}
 
+		prev_insn = insn;
 		insn = next_insn;
 	}
 
@@ -3138,6 +3184,8 @@ int check(struct objtool_file *file)
 	int ret, warnings = 0;
 
 	arch_initial_func_cfi_state(&initial_func_cfi);
+	init_cfi_state(&func_cfi);
+	set_func_state(&func_cfi);
 
 	ret = decode_sections(file);
 	if (ret < 0)
@@ -3192,6 +3240,12 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (stats) {
+		printf("nr_cfi: %ld\n", nr_cfi);
+		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
+		printf("nr_cfi_func: %ld\n", nr_cfi_func);
+	}
+
 out:
 	/*
 	 *  For now, don't fail the kernel build on fatal warnings.  These
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

