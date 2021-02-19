Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A179D320026
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBSVNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhBSVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:13:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E77EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 13:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4a1krdIM4V6PLQK9rDGTraGcNPH/WOjuMPOCWlWLEm0=; b=Qh3GnfiVztaBtPSLbGF8FU4qeA
        i+JUm4k0ahNx+sylDQSTbtLOHJn+zwpe1NBNs7c8FE87mqgZWHdoNbFouFeJIp2SPiqyAbFMP/yyn
        dDkK2k9X3tS5Ma3uLQrikHU/y/AtP+LuAlVcFh7fPt7HFj7bN/9Hxacn/rDpl+mrdu3mbrxgY/9Ki
        s8oOR595esnR/EJkQT/92nHkMOYpqyxtkrpaRxLma+fITjkprhAKvupK7mJdLmVsTRC0HatC6AzD+
        NQUElGK8N8xKDWHPw/RPEcCSUVkZcgaNsrE1tREa1IeFaIHQETZRIJvSJ6Y5hDBqMMCeiGWDNsJPx
        gr439JrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lDD2O-003Hk3-JJ; Fri, 19 Feb 2021 21:10:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A32BF30753E;
        Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 583AD20215563; Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Message-ID: <20210219210535.492733466@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Feb 2021 21:43:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, x86@kernel.org, pjt@google.com,
        mbenes@suze.cz, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
References: <20210219204300.749932493@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the compiler emits: "CALL __x86_indirect_thunk_\reg" for an
indirect call, have objtool rewrite it to:

	ALTERNATIVE "call *%reg",
		    "call __x86_indirect_thunk_\reg", X86_FEATURE_RETPOLINE

That is, rewrite the thunk calls into actual indirect calls and emit
alternatives to patch it back into the thunk calls when RETPOLINE.

Arguably it would be simpler to do the other way around, but
unfortunately alternatives don't work that way, we cannot say:

	ALTERNATIVE "call __x86_indirect_thunk_\reg",
		    "call *%reg", ~X86_FEATURE_RETPOLINE

That is, there is no negative form of alternatives.

Additionally, in order to not emit endless identical
.altinst_replacement chunks, use a global symbol for them, see
__x86_alt_*. This however does mean objtool itself cannot correctly
parse the alternatives it emits (should be fixable).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/retpoline.S        |   28 +++++
 tools/objtool/arch/x86/decode.c |  203 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 230 insertions(+), 1 deletion(-)

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
 
 	.align 16
 SYM_FUNC_START(__x86_indirect_thunk_\reg)
@@ -38,6 +39,19 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 
 .endm
 
+.macro CALL_THUNK reg
+
+	.align 1
+SYM_FUNC_START(__x86_alt_call_\reg)
+	call __x86_indirect_thunk_\reg
+SYM_FUNC_END(__x86_alt_call_\reg)
+
+SYM_FUNC_START(__x86_alt_jmp_\reg)
+	jmp __x86_indirect_thunk_\reg
+SYM_FUNC_END(__x86_alt_jmp_\reg)
+
+.endm
+
 /*
  * Despite being an assembler file we can't just use .irp here
  * because __KSYM_DEPS__ only uses the C preprocessor and would
@@ -61,3 +75,15 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 
+#undef GEN
+#define GEN(reg) CALL_THUNK reg
+#include <asm/GEN-for-each-reg.h>
+
+#undef GEN
+#define GEN(reg) __EXPORT_THUNK(__x86_alt_call_ ## reg)
+#include <asm/GEN-for-each-reg.h>
+
+#undef GEN
+#define GEN(reg) __EXPORT_THUNK(__x86_alt_jmp_ ## reg)
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
@@ -655,6 +656,208 @@ const char *arch_nop_insn(int len)
 	return nops[len-1];
 }
 
+static const char *cfi_reg_str[16] = {
+	"rax",
+	"rcx",
+	"rdx",
+	"rbx",
+	"rsp",
+	"rbp",
+	"rsi",
+	"rdi",
+	"r8",
+	"r9",
+	"r10",
+	"r11",
+	"r12",
+	"r13",
+	"r14",
+	"r15",
+};
+
+static int str_to_cfi(const char *str)
+{
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(cfi_reg_str); i++) {
+		if (!strcmp(cfi_reg_str[i], str))
+			return i;
+	}
+
+	return CFI_NUM_REGS;
+}
+
+static const char *retpoline_insn(struct instruction *insn, struct reloc *reloc)
+{
+	static char text[5];
+	int cfi = str_to_cfi(reloc->sym->name + 21);
+	int i = 0, modrm = 0;
+
+	if (insn->len != 5 || cfi == CFI_NUM_REGS)
+		return NULL;
+
+	if (cfi >= CFI_R8) {
+		text[i++] = 0x41; /* REX.B prefix */
+		cfi -= CFI_R8;
+	}
+
+	text[i++] = 0xff; /* opcode */
+
+	if (insn->type == INSN_JUMP_DYNAMIC)
+		modrm = 0x20; /* Reg = 4 ; JMP r/m */
+	else
+		modrm = 0x10; /* Reg = 2 ; CALL r/m */
+
+	modrm |= 0xc0; /* Mod = 3; */
+	modrm += cfi;  /* r/m */
+
+	text[i++] = modrm;
+
+	if (i < 5)
+		memcpy(&text[i], arch_nop_insn(5-i), 5-i);
+
+	return text;
+}
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
+			u16 cpuid, u8 orig_len, u8 repl_len, u8 pad_len)
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
+	reloc->type = R_NONE;
+	elf_write_reloc(file->elf, reloc);
+
+	elf_write_insn(file->elf, insn->sec, insn->offset, insn->len,
+		       retpoline_insn(insn, reloc));
+
+	sprintf(name, "__x86_alt_%s_%s",
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
+			    X86_FEATURE_RETPOLINE, 5, 5, 0);
+
+	return 0;
+}
+
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 {
 	struct cfi_reg *cfa = &insn->cfi.cfa;


