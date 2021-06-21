Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF963AE8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhFUMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhFUMGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E04C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RnMXf4wN3pAPS/c+om2cdvtDY/gkdx5mVmwXT1Q1Mi8=; b=hVRhzOk1Omchs9Bk5nY2153XDp
        I+9+JyLXRr8B7DxgDNYkcHeyMO+2Tc0abcXs66U6R/qbh4yexYu4CyLxCiqguIzLfsEWeiVGPD37x
        nWbGAqDDV/vV4teOYMplZZLE5y67YYTc3+AGXkPTpDrmbl6zv/ZHsSO/1P9svxcovaD5qwRZp1V3C
        e0Y9aSUT43JHVtuWBEfETk62UmC31AoovB/aWF8deih3xvJDiDnbTBs9eQcoF0HvRkqRS6eRsOmTQ
        ugi5YVAOTNIv/ex63fkOAJvAbH9qzIKZCKAXksdfwjmanygx/2SpelQtIBb6uu7nRpQ0SjPumjWIf
        vrHnXJDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdm-00D3if-44; Mon, 21 Jun 2021 12:03:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD3DA3005E3;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5C974235EE390; Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Message-ID: <20210621120121.812129206@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [RFC][PATCH 18/18] objtool: Support pv_opsindirect calls for noinstr
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally objtool will now follow indirect calls; there is no need.

However, this becomes a problem with noinstr validation; if there's an
indirect call from noinstr code, we very much need to know it is to
another noinstr function. Luckily there aren't many indirect calls in
entry code with the obvious exception of paravirt. As such, noinstr
validation didn't work with paravirt kernels.

In order to track pv_ops[] call targets, objtool reads the static
pv_ops[] tables as well as direct assignments to the pv_ops[] array,
provided the compiler makes them a single instruction like:

  bf87:       48 c7 05 00 00 00 00 00 00 00 00        movq   $0x0,0x0(%rip)
    bf92 <xen_init_spinlocks+0x5f>
    bf8a: R_X86_64_PC32     pv_ops+0x268

There are, as of yet, no warnings for when this goes wrong :/

Using the functions found with the above means, all pv_ops[] calls are
now subject to noinstr validation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/Kconfig.debug                       |    2 
 tools/objtool/arch/x86/decode.c         |   34 ++++++-
 tools/objtool/check.c                   |  151 +++++++++++++++++++++++++++++---
 tools/objtool/include/objtool/arch.h    |    2 
 tools/objtool/include/objtool/elf.h     |    1 
 tools/objtool/include/objtool/objtool.h |    9 +
 tools/objtool/objtool.c                 |   22 ++++
 7 files changed, 208 insertions(+), 13 deletions(-)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -445,7 +445,7 @@ config STACK_VALIDATION
 
 config VMLINUX_VALIDATION
 	bool
-	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
+	depends on STACK_VALIDATION && DEBUG_ENTRY
 	default y
 
 config VMLINUX_MAP
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -20,6 +20,7 @@
 #include <objtool/arch.h>
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
+#include <objtool/builtin.h>
 #include <arch/elf.h>
 
 static int is_x86_64(const struct elf *elf)
@@ -102,12 +103,13 @@ unsigned long arch_jump_destination(stru
 #define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))
 #define rm_is_reg(reg)	(mod_is_reg() && modrm_rm == (reg))
 
-int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
 			    struct list_head *ops_list)
 {
+	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, ret;
 	unsigned char op1, op2,
@@ -544,6 +546,36 @@ int arch_decode_instruction(const struct
 		*type = INSN_RETURN;
 		break;
 
+	case 0xc7: /* mov imm, r/m */
+		if (!noinstr)
+			break;
+
+		if (insn.length == 3+4+4 && !strncmp(sec->name, ".init.text", 10)) {
+			struct reloc *immr, *disp;
+			struct symbol *func;
+			int idx;
+
+			immr = find_reloc_by_dest(elf, (void *)sec, offset+3);
+			disp = find_reloc_by_dest(elf, (void *)sec, offset+7);
+
+			if (!immr || strcmp(immr->sym->name, "pv_ops"))
+				break;
+
+			idx = (immr->addend + 8) / sizeof(void *);
+
+			func = disp->sym;
+			if (disp->sym->type == STT_SECTION)
+				func = find_symbol_by_offset(disp->sym->sec, disp->addend);
+			if (!func) {
+				WARN("no func for pv_ops[]");
+				return -1;
+			}
+
+			objtool_pv_add(file, idx, func);
+		}
+
+		break;
+
 	case 0xcf: /* iret */
 		/*
 		 * Handle sync_core(), which has an IRET to self.
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -306,7 +306,7 @@ static int decode_instructions(struct ob
 			insn->sec = sec;
 			insn->offset = offset;
 
-			ret = arch_decode_instruction(file->elf, sec, offset,
+			ret = arch_decode_instruction(file, sec, offset,
 						      sec->len - offset,
 						      &insn->len, &insn->type,
 						      &insn->immediate,
@@ -344,6 +344,82 @@ static int decode_instructions(struct ob
 	return ret;
 }
 
+/*
+ * Read the pv_ops[] .data table to find the static initialized values.
+ */
+static int add_pv_ops(struct objtool_file *file, const char *symname)
+{
+	struct symbol *sym, *func;
+	unsigned long off, end;
+	struct reloc *rel;
+	int idx;
+
+	sym = find_symbol_by_name(file->elf, symname);
+	if (!sym)
+		return 0;
+
+	off = sym->offset;
+	end = off + sym->len;
+	for (;;) {
+		rel = find_reloc_by_dest_range(file->elf, sym->sec, off, end - off);
+		if (!rel)
+			break;
+
+		func = rel->sym;
+		if (func->type == STT_SECTION)
+			func = find_symbol_by_offset(rel->sym->sec, rel->addend);
+
+		idx = (rel->offset - sym->offset) / sizeof(unsigned long);
+
+		objtool_pv_add(file, idx, func);
+
+		off = rel->offset + 1;
+		if (off > end)
+			break;
+	}
+
+	return 0;
+}
+
+/*
+ * Allocate and initialize file->pv_ops[].
+ */
+static int init_pv_ops(struct objtool_file *file)
+{
+	static const char *pv_ops_tables[] = {
+		"pv_ops",
+		"xen_cpu_ops",
+		"xen_irq_ops",
+		"xen_mmu_ops",
+		NULL,
+	};
+	const char *pv_ops;
+	struct symbol *sym;
+	int idx, nr;
+
+	if (!noinstr)
+		return 0;
+
+	file->pv_ops = NULL;
+
+	sym = find_symbol_by_name(file->elf, "pv_ops");
+	if (!sym)
+		return 0;
+
+	nr = sym->len / sizeof(unsigned long);
+	file->pv_ops = calloc(sizeof(struct pv_state), nr);
+	if (!file->pv_ops)
+		return -1;
+
+	for (idx = 0; idx < nr; idx++)
+		INIT_LIST_HEAD(&file->pv_ops[idx].targets);
+
+	for (idx = 0; (pv_ops = pv_ops_tables[idx]); idx++)
+		add_pv_ops(file, pv_ops);
+
+	return 0;
+}
+
 static struct instruction *find_last_insn(struct objtool_file *file,
 					  struct section *sec)
 {
@@ -817,6 +893,9 @@ static struct reloc *insn_reloc(struct o
 		return NULL;
 
 	if (!insn->reloc) {
+		if (!file)
+			return NULL;
+
 		insn->reloc = find_reloc_by_dest_range(file->elf, insn->sec,
 						       insn->offset, insn->len);
 		if (!insn->reloc) {
@@ -1791,6 +1870,10 @@ static int decode_sections(struct objtoo
 
 	mark_rodata(file);
 
+	ret = init_pv_ops(file);
+	if (ret)
+		return ret;
+
 	ret = decode_instructions(file);
 	if (ret)
 		return ret;
@@ -2562,20 +2645,64 @@ static inline bool func_uaccess_safe(str
 
 static inline const char *call_dest_name(struct instruction *insn)
 {
+	static char pvname[16];
+	struct reloc *rel;
+	int idx;
+
 	if (insn->call_dest)
 		return insn->call_dest->name;
 
+	rel = insn_reloc(NULL, insn);
+	if (rel && !strcmp(rel->sym->name, "pv_ops")) {
+		idx = (rel->addend / sizeof(void *));
+		snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
+		return pvname;
+	}
+
 	return "{dynamic}";
 }
 
-static inline bool noinstr_call_dest(struct symbol *func)
+static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
+{
+	struct symbol *target;
+	struct reloc *rel;
+	int idx;
+
+	rel = insn_reloc(file, insn);
+	if (!rel || strcmp(rel->sym->name, "pv_ops"))
+		return false;
+
+	idx = (arch_dest_reloc_offset(rel->addend) / sizeof(void *));
+
+	if (file->pv_ops[idx].clean)
+		return true;
+
+	file->pv_ops[idx].clean = true;
+
+	list_for_each_entry(target, &file->pv_ops[idx].targets, pv_target) {
+		if (!target->sec->noinstr) {
+			WARN("pv_ops[%d]: %s", idx, target->name);
+			file->pv_ops[idx].clean = false;
+		}
+	}
+
+	return file->pv_ops[idx].clean;
+}
+
+static inline bool noinstr_call_dest(struct objtool_file *file,
+				     struct instruction *insn,
+				     struct symbol *func)
 {
 	/*
 	 * We can't deal with indirect function calls at present;
 	 * assume they're instrumented.
 	 */
-	if (!func)
+	if (!func) {
+		if (file->pv_ops)
+			return pv_call_dest(file, insn);
+
 		return false;
+	}
 
 	/*
 	 * If the symbol is from a noinstr section; we good.
@@ -2594,10 +2721,12 @@ static inline bool noinstr_call_dest(str
 	return false;
 }
 
-static int validate_call(struct instruction *insn, struct insn_state *state)
+static int validate_call(struct objtool_file *file,
+			 struct instruction *insn,
+			 struct insn_state *state)
 {
 	if (state->noinstr && state->instr <= 0 &&
-	    !noinstr_call_dest(insn->call_dest)) {
+	    !noinstr_call_dest(file, insn, insn->call_dest)) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
@@ -2618,7 +2747,9 @@ static int validate_call(struct instruct
 	return 0;
 }
 
-static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
+static int validate_sibling_call(struct objtool_file *file,
+				 struct instruction *insn,
+				 struct insn_state *state)
 {
 	if (has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
@@ -2626,7 +2757,7 @@ static int validate_sibling_call(struct
 		return 1;
 	}
 
-	return validate_call(insn, state);
+	return validate_call(file, insn, state);
 }
 
 static int validate_return(struct symbol *func, struct instruction *insn, struct insn_state *state)
@@ -2769,7 +2900,7 @@ static int validate_branch(struct objtoo
 
 		case INSN_CALL:
 		case INSN_CALL_DYNAMIC:
-			ret = validate_call(insn, &state);
+			ret = validate_call(file, insn, &state);
 			if (ret)
 				return ret;
 
@@ -2788,7 +2919,7 @@ static int validate_branch(struct objtoo
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
 			if (is_sibling_call(insn)) {
-				ret = validate_sibling_call(insn, &state);
+				ret = validate_sibling_call(file, insn, &state);
 				if (ret)
 					return ret;
 
@@ -2810,7 +2941,7 @@ static int validate_branch(struct objtoo
 		case INSN_JUMP_DYNAMIC:
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
 			if (is_sibling_call(insn)) {
-				ret = validate_sibling_call(insn, &state);
+				ret = validate_sibling_call(file, insn, &state);
 				if (ret)
 					return ret;
 			}
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -69,7 +69,7 @@ struct instruction;
 
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
-int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -57,6 +57,7 @@ struct symbol {
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
 	bool static_call_tramp;
+	struct list_head pv_target;
 };
 
 struct reloc {
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -14,6 +14,11 @@
 
 #define __weak __attribute__((weak))
 
+struct pv_state {
+	bool clean;
+	struct list_head targets;
+};
+
 struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
@@ -25,10 +30,14 @@ struct objtool_file {
 
 	unsigned long jl_short, jl_long;
 	unsigned long jl_nop_short, jl_nop_long;
+
+	struct pv_state *pv_ops;
 };
 
 struct objtool_file *objtool_open_read(const char *_objname);
 
+void objtool_pv_add(struct objtool_file *file, int idx, struct symbol *func);
+
 int check(struct objtool_file *file);
 int orc_dump(const char *objname);
 int orc_create(struct objtool_file *file);
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -135,6 +135,28 @@ struct objtool_file *objtool_open_read(c
 	return &file;
 }
 
+void objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func)
+{
+	if (!noinstr)
+		return;
+
+	if (!f->pv_ops) {
+		WARN("paravirt confusion");
+		return;
+	}
+
+	/*
+	 * These functions will be patched into native code,
+	 * see paravirt_patch().
+	 */
+	if (!strcmp(func->name, "_paravirt_nop") ||
+	    !strcmp(func->name, "_paravirt_ident_64"))
+		return;
+
+	list_add(&func->pv_target, &f->pv_ops[idx].targets);
+	f->pv_ops[idx].clean = false;
+}
+
 static void cmd_usage(void)
 {
 	unsigned int i, longest = 0;


