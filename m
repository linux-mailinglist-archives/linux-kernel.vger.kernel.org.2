Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A240C33948E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhCLRSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhCLRSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:18:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B751BC061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0hG8N4PI8BSCd3aD5i1zP1zA6m5We8nSA4kF6/rHe3Y=; b=dB3d61c+JojQoXWDjg2X61d3HB
        X3Yyzy8zUEj6RgBb5QwLX2+mBPJlGsK4VuwvZBIgeTHOkB5NMHTXOh0VRX4SZGxcDAEjyZzIG7WH6
        mRBHKXIu0XrTXXQpH5qgRI6H3yrC8ru0GVfy7ZdbeQl8UmDy7XtKpWDEZBqVvLcntgQ2hbQwJrHDe
        6z/0CVOMJD3b3kd44kVXFnbpWorFOvkgU8Tq9c65zyGDtqk3HkNwtAAqtzSYPpsAYHX1Fef8AZAlk
        mY2/c84nlF3n3NbTm+TiT/hysZ7fbfA8uWRhvv5hylkiEGBEEljQlclAW1Dn7eQe+5CnFuNeM14gR
        MWAyHlng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKlQA-00BETu-N7; Fri, 12 Mar 2021 17:18:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BC5D307697;
        Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1FF5D23CC2299; Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Message-ID: <20210312171653.892431925@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 18:16:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 9/9] objtool,x86: Rewrite retpoline thunk calls
References: <20210312171613.533405394@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the compiler emits: "CALL __x86_indirect_thunk_\reg" for an
indirect call, have objtool rewrite it to:

	ALTERNATIVE "call __x86_indirect_thunk_\reg",
		    "call *%reg", ALT_NOT(X86_FEATURE_RETPOLINE)

Additionally, in order to not emit endless identical
.altinst_replacement chunks, use a global symbol for them, see
__x86_indirect_alt_*.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/asm-prototypes.h |   12 ++
 arch/x86/lib/retpoline.S              |   33 +++++++-
 tools/objtool/arch/x86/decode.c       |  139 ++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -19,11 +19,19 @@ extern void cmpxchg8b_emu(void);
 
 #ifdef CONFIG_RETPOLINE
 
-#define DECL_INDIRECT_THUNK(reg) \
+#undef GEN
+#define GEN(reg) \
 	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
+#include <asm/GEN-for-each-reg.h>
+
+#undef GEN
+#define GEN(reg) \
+	extern asmlinkage void __x86_indirect_alt_call_ ## reg (void);
+#include <asm/GEN-for-each-reg.h>
 
 #undef GEN
-#define GEN(reg) DECL_INDIRECT_THUNK(reg)
+#define GEN(reg) \
+	extern asmlinkage void __x86_indirect_alt_jmp_ ## reg (void);
 #include <asm/GEN-for-each-reg.h>
 
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -10,6 +10,8 @@
 #include <asm/unwind_hints.h>
 #include <asm/frame.h>
 
+	.section .text.__x86.indirect_thunk
+
 .macro RETPOLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call    .Ldo_rop_\@
@@ -25,7 +27,6 @@
 .endm
 
 .macro THUNK reg
-	.section .text.__x86.indirect_thunk
 
 	.align 32
 SYM_FUNC_START(__x86_indirect_thunk_\reg)
@@ -38,6 +39,24 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 
 .endm
 
+.macro CALL_THUNK reg
+
+	.align 1
+
+SYM_FUNC_START_NOALIGN(__x86_indirect_alt_call_\reg)
+	ANNOTATE_RETPOLINE_SAFE
+1:	call	*%\reg
+2:	.nops	5-(2b-1b)
+SYM_FUNC_END(__x86_indirect_alt_call_\reg)
+
+SYM_FUNC_START_NOALIGN(__x86_indirect_alt_jmp_\reg)
+	ANNOTATE_RETPOLINE_SAFE
+1:	jmp	*%\reg
+2:	.nops	5-(2b-1b)
+SYM_FUNC_END(__x86_indirect_alt_jmp_\reg)
+
+.endm
+
 /*
  * Despite being an assembler file we can't just use .irp here
  * because __KSYM_DEPS__ only uses the C preprocessor and would
@@ -61,3 +80,15 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 
+#undef GEN
+#define GEN(reg) CALL_THUNK reg
+#include <asm/GEN-for-each-reg.h>
+
+#undef GEN
+#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_call_ ## reg)
+#include <asm/GEN-for-each-reg.h>
+
+#undef GEN
+#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_jmp_ ## reg)
+#include <asm/GEN-for-each-reg.h>
+
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -16,6 +16,7 @@
 #include <objtool/elf.h>
 #include <objtool/arch.h>
 #include <objtool/warn.h>
+#include <arch/elf.h>
 
 static int is_x86_64(const struct elf *elf)
 {
@@ -655,6 +656,144 @@ const char *arch_nop_insn(int len)
 	return nops[len-1];
 }
 
+/* asm/alternative.h ? */
+
+#define ALTINSTR_FLAG_INV	(1 << 15)
+#define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
+
+struct alt_instr {
+	s32 instr_offset;	/* original instruction */
+	s32 repl_offset;	/* offset to replacement instruction */
+	u16 cpuid;		/* cpuid bit set for replacement */
+	u8  instrlen;		/* length of original instruction */
+	u8  replacementlen;	/* length of new instruction */
+	u8  padlen;		/* length of build-time padding */
+} __packed;
+
+static int elf_add_alternative(struct elf *elf,
+			struct instruction *orig, struct symbol *sym,
+			int cpuid, u8 orig_len, u8 repl_len, u8 pad_len)
+{
+	struct section *sec, *reloc_sec;
+	struct reloc *reloc;
+	Elf_Scn *s;
+	const int size = sizeof(struct alt_instr);
+	struct alt_instr *alt;
+
+	sec = find_section_by_name(elf, ".altinstructions");
+	if (!sec) {
+		sec = elf_create_section(elf, ".altinstructions",
+					 SHF_WRITE, size, 0);
+
+		if (!sec) {
+			WARN_ELF("elf_create_section");
+			return -1;
+		}
+
+		reloc_sec = elf_create_reloc_section(elf, sec, SHT_RELA);
+		if (!reloc_sec) {
+			WARN_ELF("elf_create_reloc_section");
+			return -1;
+		}
+	}
+
+	s = elf_getscn(elf->elf, sec->idx);
+	if (!s) {
+		WARN_ELF("elf_getscn");
+		return -1;
+	}
+
+	sec->data = elf_newdata(s);
+	if (!sec->data) {
+		WARN_ELF("elf_newdata");
+		return -1;
+	}
+
+	sec->data->d_size = size;
+	sec->data->d_align = 1;
+
+	alt = sec->data->d_buf = malloc(size);
+	if (!sec->data->d_buf) {
+		perror("malloc");
+		return -1;
+	}
+	memset(sec->data->d_buf, 0, size);
+
+	alt->cpuid = cpuid;
+	alt->instrlen = orig_len;
+	alt->replacementlen = repl_len;
+	alt->padlen = pad_len;
+
+	reloc = malloc(sizeof(*reloc));
+	if (!reloc) {
+		perror("malloc");
+		return -1;
+	}
+	memset(reloc, 0, sizeof(*reloc));
+
+	insn_to_reloc_sym_addend(orig->sec, orig->offset, reloc);
+	if (!reloc->sym) {
+		WARN_FUNC("alt: missing containing symbol",
+			  orig->sec, orig->offset);
+		return -1;
+	}
+
+	reloc->type = R_X86_64_PC32;
+	reloc->offset = sec->sh.sh_size;
+	reloc->sec = sec->reloc;
+	elf_add_reloc(elf, reloc);
+
+	reloc = malloc(sizeof(*reloc));
+	if (!reloc) {
+		perror("malloc");
+		return -1;
+	}
+	memset(reloc, 0, sizeof(*reloc));
+
+	reloc->sym = sym;
+	reloc->addend = 0;
+	reloc->type = R_X86_64_PC32;
+	reloc->offset = sec->sh.sh_size + 4;
+	reloc->sec = sec->reloc;
+	elf_add_reloc(elf, reloc);
+
+	sec->sh.sh_size += size;
+	sec->changed = true;
+
+	return 0;
+}
+
+#define X86_FEATURE_RETPOLINE                ( 7*32+12)
+
+int arch_rewrite_retpoline(struct objtool_file *file,
+			   struct instruction *insn,
+			   struct reloc *reloc)
+{
+	struct symbol *sym;
+	char name[32] = "";
+
+	if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
+		return 0;
+
+	sprintf(name, "__x86_indirect_alt_%s_%s",
+		insn->type == INSN_JUMP_DYNAMIC ? "jmp" : "call",
+		reloc->sym->name + 21);
+
+	sym = find_symbol_by_name(file->elf, name);
+	if (!sym) {
+		sym = elf_create_undef_symbol(file->elf, name);
+		if (!sym) {
+			WARN("elf_create_undef_symbol");
+			return -1;
+		}
+	}
+
+	elf_add_alternative(file->elf, insn, sym,
+			    ALT_NOT(X86_FEATURE_RETPOLINE), 5, 5, 0);
+
+	return 0;
+}
+
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 {
 	struct cfi_reg *cfa = &insn->cfi.cfa;


