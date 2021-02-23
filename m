Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8B322D14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhBWPEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:04:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52362 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhBWPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:03:40 -0500
Date:   Tue, 23 Feb 2021 15:02:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614092563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UDqP0SZ2Ns3x7efzHYEhU3p/zfNLohIlKH4KLRBwqQc=;
        b=L1R22dRnvAWe+nK21ZXG4WX6GZZdcrzCo7Q/ND3VFWapWN6OKvtjB4VHKRlLbbRsClwSMV
        dsg/HCy5PJXAJnBuLsxjMMLRwPlOJj9wGNQTDMwZMvMH8Bxvhp0CXa64Ls1GZzLiT5xVGP
        m9+wLIipbvgs2yCaLVKIhayGVnmtGAUwkqDmzA6MZCm8BDSmkTLnvFwKU6KdNLeygdVWFA
        U7AdV2FaPWZmhePYboYvBbYpTnd9UCMYXsS6TLckOHQhtaanNSVvmUs9PFEM8lA1D8EXnD
        nTLs6XrJYCR08PdkgI6D0FBcbAw2yhgciF/D5Nkjg2ym9Y3v1s++oTbxv8390Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614092563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UDqP0SZ2Ns3x7efzHYEhU3p/zfNLohIlKH4KLRBwqQc=;
        b=/lUlwILyF0CUbFyhcxIItjjxhvtVl4GSJ/U5wcryeocnj4lbjY9uMjknshN0mE/BsLnsqR
        7f8/1TkMDjyxR6AQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] objtool/core for 5.12
Message-ID: <161409254266.2358.17202318838981714361.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest objtool/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-02-23

up to:  aafeb14e9da2: objtool: Support stack-swizzle

objtool updates:

 - Make objtool work for big-endian cross compiles

 - Make stack tracking via stack pointer memory operations match push/pop
   semantics to prepare for architectures w/o PUSH/POP instructions.

 - Add support for analyzing alternatives

 - Improve retpoline detection and handling

 - Improve assembly code coverage on x86

 - Provide support for inlined stack switching


Thanks,

	tglx

------------------>
Josh Poimboeuf (21):
      objtool: Refactor ORC section generation
      objtool: Add 'alt_group' struct
      objtool: Support stack layout changes in alternatives
      objtool: Fix error handling for STD/CLD warnings
      objtool: Fix retpoline detection in asm code
      objtool: Fix ".cold" section suffix check for newer versions of GCC
      objtool: Support retpoline jump detection for vmlinux.o
      x86/ftrace: Add UNWIND_HINT_FUNC annotation for ftrace_stub
      objtool: Assume only ELF functions do sibling calls
      objtool: Add asm version of STACK_FRAME_NON_STANDARD
      objtool: Combine UNWIND_HINT_RET_OFFSET and UNWIND_HINT_FUNC
      objtool: Add xen_start_kernel() to noreturn list
      x86/xen: Support objtool validation in xen-asm.S
      x86/xen: Support objtool vmlinux.o validation in xen-head.S
      x86/xen/pvh: Annotate indirect branch as safe
      x86/ftrace: Support objtool vmlinux.o validation in ftrace_64.S
      x86/acpi: Annotate indirect branch as safe
      x86/acpi: Support objtool validation in wakeup_64.S
      x86/power: Annotate indirect branches as safe
      x86/power: Move restore_registers() to top of the file
      x86/power: Support objtool validation in hibernate_asm_64.S

Julien Thierry (3):
      objtool: Fully validate the stack frame
      objtool: Support addition to set CFA base
      objtool: Make SP memory operation match PUSH/POP semantics

Martin Schwidefsky (2):
      x86/insn: Support big endian cross-compiles
      objtool: Fix reloc generation on big endian cross-compiles

Peter Zijlstra (3):
      x86/unwind/orc: Change REG_SP_INDIRECT
      objtool,x86: Additionally decode: mov %rsp, (%reg)
      objtool: Support stack-swizzle

Vasily Gorbik (4):
      x86/tools: Use tools headers for instruction decoder selftests
      objtool: Fix x86 orc generation on big endian cross-compiles
      objtool: Rework header include paths
      x86/insn: Fix vector instruction decoding on big endian cross-compiles


 arch/x86/include/asm/insn.h                        |  45 +++
 arch/x86/include/asm/orc_types.h                   |  10 +
 arch/x86/include/asm/unwind_hints.h                |  13 +-
 arch/x86/kernel/acpi/Makefile                      |   1 -
 arch/x86/kernel/acpi/wakeup_64.S                   |   4 +
 arch/x86/kernel/ftrace_64.S                        |   8 +-
 arch/x86/kernel/unwind_orc.c                       |   5 +-
 arch/x86/lib/insn.c                                | 119 +++---
 arch/x86/lib/retpoline.S                           |   2 +-
 arch/x86/platform/pvh/head.S                       |   2 +
 arch/x86/power/Makefile                            |   1 -
 arch/x86/power/hibernate_asm_64.S                  | 103 +++---
 arch/x86/tools/Makefile                            |   8 +-
 arch/x86/tools/insn_sanity.c                       |   4 -
 arch/x86/xen/Makefile                              |   1 -
 arch/x86/xen/xen-asm.S                             |  29 +-
 arch/x86/xen/xen-head.S                            |   5 +-
 include/linux/objtool.h                            |  13 +-
 tools/arch/x86/include/asm/insn.h                  |  45 +++
 tools/arch/x86/include/asm/orc_types.h             |  10 +
 tools/arch/x86/lib/insn.c                          | 119 +++---
 tools/include/linux/objtool.h                      |  13 +-
 tools/objtool/.gitignore                           |   2 +-
 tools/objtool/Documentation/stack-validation.txt   |  16 +-
 tools/objtool/Makefile                             |   5 +-
 tools/objtool/arch/x86/decode.c                    |  54 ++-
 .../objtool/arch/x86/include/{ => arch}/cfi_regs.h |   0
 .../arch/x86/include/{arch_elf.h => arch/elf.h}    |   0
 tools/objtool/arch/x86/include/arch/endianness.h   |   9 +
 .../x86/include/{arch_special.h => arch/special.h} |   0
 tools/objtool/arch/x86/special.c                   |   6 +-
 tools/objtool/builtin-check.c                      |   4 +-
 tools/objtool/builtin-orc.c                        |  10 +-
 tools/objtool/check.c                              | 402 +++++++++++++--------
 tools/objtool/elf.c                                |  40 +-
 tools/objtool/{ => include/objtool}/arch.h         |   8 +-
 tools/objtool/{ => include/objtool}/builtin.h      |   0
 tools/objtool/{ => include/objtool}/cfi.h          |   2 +-
 tools/objtool/{ => include/objtool}/check.h        |  38 +-
 tools/objtool/{ => include/objtool}/elf.h          |   0
 tools/objtool/include/objtool/endianness.h         |  38 ++
 tools/objtool/{ => include/objtool}/objtool.h      |   5 +-
 tools/objtool/{ => include/objtool}/special.h      |   4 +-
 tools/objtool/{ => include/objtool}/warn.h         |   2 +-
 tools/objtool/objtool.c                            |   6 +-
 tools/objtool/orc_dump.c                           |  11 +-
 tools/objtool/orc_gen.c                            | 315 +++++++++-------
 tools/objtool/special.c                            |  14 +-
 tools/objtool/weak.c                               |   9 +-
 49 files changed, 963 insertions(+), 597 deletions(-)
 rename tools/objtool/arch/x86/include/{ => arch}/cfi_regs.h (100%)
 rename tools/objtool/arch/x86/include/{arch_elf.h => arch/elf.h} (100%)
 create mode 100644 tools/objtool/arch/x86/include/arch/endianness.h
 rename tools/objtool/arch/x86/include/{arch_special.h => arch/special.h} (100%)
 rename tools/objtool/{ => include/objtool}/arch.h (94%)
 rename tools/objtool/{ => include/objtool}/builtin.h (100%)
 rename tools/objtool/{ => include/objtool}/cfi.h (96%)
 rename tools/objtool/{ => include/objtool}/check.h (64%)
 rename tools/objtool/{ => include/objtool}/elf.h (100%)
 create mode 100644 tools/objtool/include/objtool/endianness.h
 rename tools/objtool/{ => include/objtool}/objtool.h (84%)
 rename tools/objtool/{ => include/objtool}/special.h (94%)
 rename tools/objtool/{ => include/objtool}/warn.h (98%)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index a8c3d284fa46..95a448fbb44c 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -7,9 +7,12 @@
  * Copyright (C) IBM Corporation, 2009
  */
 
+#include <asm/byteorder.h>
 /* insn_attr_t is defined in inat.h */
 #include <asm/inat.h>
 
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+
 struct insn_field {
 	union {
 		insn_value_t value;
@@ -20,6 +23,48 @@ struct insn_field {
 	unsigned char nbytes;
 };
 
+static inline void insn_field_set(struct insn_field *p, insn_value_t v,
+				  unsigned char n)
+{
+	p->value = v;
+	p->nbytes = n;
+}
+
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+}
+
+#else
+
+struct insn_field {
+	insn_value_t value;
+	union {
+		insn_value_t little;
+		insn_byte_t bytes[4];
+	};
+	/* !0 if we've run insn_get_xxx() for this field */
+	unsigned char got;
+	unsigned char nbytes;
+};
+
+static inline void insn_field_set(struct insn_field *p, insn_value_t v,
+				  unsigned char n)
+{
+	p->value = v;
+	p->little = __cpu_to_le32(v);
+	p->nbytes = n;
+}
+
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+	p->value = __le32_to_cpu(p->little);
+}
+#endif
+
 struct insn {
 	struct insn_field prefixes;	/*
 					 * Prefixes
diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index fdbffec4cfde..5a2baf28a1dc 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -40,6 +40,8 @@
 #define ORC_REG_MAX			15
 
 #ifndef __ASSEMBLY__
+#include <asm/byteorder.h>
+
 /*
  * This struct is more or less a vastly simplified version of the DWARF Call
  * Frame Information standard.  It contains only the necessary parts of DWARF
@@ -51,10 +53,18 @@
 struct orc_entry {
 	s16		sp_offset;
 	s16		bp_offset;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
 	unsigned	end:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	unsigned	bp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:5;
+	unsigned	end:1;
+	unsigned	type:2;
+#endif
 } __packed;
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 664d4610d700..8e574c0afef8 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -48,17 +48,8 @@
 	UNWIND_HINT_REGS base=\base offset=\offset partial=1
 .endm
 
-.macro UNWIND_HINT_FUNC sp_offset=8
-	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=\sp_offset type=UNWIND_HINT_TYPE_CALL
-.endm
-
-/*
- * RET_OFFSET: Used on instructions that terminate a function; mostly RETURN
- * and sibling calls. On these, sp_offset denotes the expected offset from
- * initial_func_cfi.
- */
-.macro UNWIND_HINT_RET_OFFSET sp_offset=8
-	UNWIND_HINT sp_reg=ORC_REG_SP type=UNWIND_HINT_TYPE_RET_OFFSET sp_offset=\sp_offset
+.macro UNWIND_HINT_FUNC
+	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=8 type=UNWIND_HINT_TYPE_FUNC
 .endm
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
index f1bb57b0e41e..cf340d85946a 100644
--- a/arch/x86/kernel/acpi/Makefile
+++ b/arch/x86/kernel/acpi/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD_wakeup_$(BITS).o := y
 
 obj-$(CONFIG_ACPI)		+= boot.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 5d3a0b8fd379..56b6865afb2a 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -1,12 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 .text
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/segment.h>
 #include <asm/pgtable_types.h>
 #include <asm/page_types.h>
 #include <asm/msr.h>
 #include <asm/asm-offsets.h>
 #include <asm/frame.h>
+#include <asm/nospec-branch.h>
 
 # Copyright 2003 Pavel Machek <pavel@suse.cz
 
@@ -39,6 +41,7 @@ SYM_FUNC_START(wakeup_long64)
 	movq	saved_rbp, %rbp
 
 	movq	saved_rip, %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 SYM_FUNC_END(wakeup_long64)
 
@@ -126,6 +129,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	FRAME_END
 	jmp	restore_processor_state
 SYM_FUNC_END(do_suspend_lowlevel)
+STACK_FRAME_NON_STANDARD do_suspend_lowlevel
 
 .data
 saved_rbp:		.quad	0
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 0d54099c2a3a..7c273846c687 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -184,6 +184,7 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
  * It is also used to copy the retq for trampolines.
  */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
+	UNWIND_HINT_FUNC
 	retq
 SYM_FUNC_END(ftrace_epilogue)
 
@@ -276,7 +277,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	restore_mcount_regs 8
 	/* Restore flags */
 	popfq
-	UNWIND_HINT_RET_OFFSET
+	UNWIND_HINT_FUNC
 	jmp	ftrace_epilogue
 
 SYM_FUNC_END(ftrace_regs_caller)
@@ -333,8 +334,7 @@ SYM_FUNC_START(ftrace_graph_caller)
 	retq
 SYM_FUNC_END(ftrace_graph_caller)
 
-SYM_CODE_START(return_to_handler)
-	UNWIND_HINT_EMPTY
+SYM_FUNC_START(return_to_handler)
 	subq  $24, %rsp
 
 	/* Save the return values */
@@ -349,5 +349,5 @@ SYM_CODE_START(return_to_handler)
 	movq (%rsp), %rax
 	addq $24, %rsp
 	JMP_NOSPEC rdi
-SYM_CODE_END(return_to_handler)
+SYM_FUNC_END(return_to_handler)
 #endif
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 73f800100066..2a1d47f47eee 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -471,7 +471,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		break;
 
 	case ORC_REG_SP_INDIRECT:
-		sp = state->sp + orc->sp_offset;
+		sp = state->sp;
 		indirect = true;
 		break;
 
@@ -521,6 +521,9 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (indirect) {
 		if (!deref_stack_reg(state, sp, &sp))
 			goto err;
+
+		if (orc->sp_reg == ORC_REG_SP_INDIRECT)
+			sp += orc->sp_offset;
 	}
 
 	/* Find IP, SP and possibly regs: */
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 404279563891..435630a6ec97 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -5,6 +5,7 @@
  * Copyright (C) IBM Corporation, 2002, 2004, 2009
  */
 
+#include <linux/kernel.h>
 #ifdef __KERNEL__
 #include <linux/string.h>
 #else
@@ -15,15 +16,28 @@
 
 #include <asm/emulate_prefix.h>
 
+#define leXX_to_cpu(t, r)						\
+({									\
+	__typeof__(t) v;						\
+	switch (sizeof(t)) {						\
+	case 4: v = le32_to_cpu(r); break;				\
+	case 2: v = le16_to_cpu(r); break;				\
+	case 1:	v = r; break;						\
+	default:							\
+		BUILD_BUG(); break;					\
+	}								\
+	v;								\
+})
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
+	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); r; })
+	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
@@ -147,9 +161,9 @@ void insn_get_prefixes(struct insn *insn)
 			b = insn->prefixes.bytes[3];
 			for (i = 0; i < nb; i++)
 				if (prefixes->bytes[i] == lb)
-					prefixes->bytes[i] = b;
+					insn_set_byte(prefixes, i, b);
 		}
-		insn->prefixes.bytes[3] = lb;
+		insn_set_byte(&insn->prefixes, 3, lb);
 	}
 
 	/* Decode REX prefix */
@@ -157,8 +171,7 @@ void insn_get_prefixes(struct insn *insn)
 		b = peek_next(insn_byte_t, insn);
 		attr = inat_get_opcode_attribute(b);
 		if (inat_is_rex_prefix(attr)) {
-			insn->rex_prefix.value = b;
-			insn->rex_prefix.nbytes = 1;
+			insn_field_set(&insn->rex_prefix, b, 1);
 			insn->next_byte++;
 			if (X86_REX_W(b))
 				/* REX.W overrides opnd_size */
@@ -181,13 +194,13 @@ void insn_get_prefixes(struct insn *insn)
 			if (X86_MODRM_MOD(b2) != 3)
 				goto vex_end;
 		}
-		insn->vex_prefix.bytes[0] = b;
-		insn->vex_prefix.bytes[1] = b2;
+		insn_set_byte(&insn->vex_prefix, 0, b);
+		insn_set_byte(&insn->vex_prefix, 1, b2);
 		if (inat_is_evex_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			b2 = peek_nbyte_next(insn_byte_t, insn, 3);
-			insn->vex_prefix.bytes[3] = b2;
+			insn_set_byte(&insn->vex_prefix, 3, b2);
 			insn->vex_prefix.nbytes = 4;
 			insn->next_byte += 4;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -195,7 +208,7 @@ void insn_get_prefixes(struct insn *insn)
 				insn->opnd_bytes = 8;
 		} else if (inat_is_vex3_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			insn->vex_prefix.nbytes = 3;
 			insn->next_byte += 3;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -207,7 +220,7 @@ void insn_get_prefixes(struct insn *insn)
 			 * Makes it easier to decode vex.W, vex.vvvv,
 			 * vex.L and vex.pp. Masking with 0x7f sets vex.W == 0.
 			 */
-			insn->vex_prefix.bytes[2] = b2 & 0x7f;
+			insn_set_byte(&insn->vex_prefix, 2, b2 & 0x7f);
 			insn->vex_prefix.nbytes = 2;
 			insn->next_byte += 2;
 		}
@@ -243,7 +256,7 @@ void insn_get_opcode(struct insn *insn)
 
 	/* Get first opcode */
 	op = get_next(insn_byte_t, insn);
-	opcode->bytes[0] = op;
+	insn_set_byte(opcode, 0, op);
 	opcode->nbytes = 1;
 
 	/* Check if there is VEX prefix or not */
@@ -295,8 +308,7 @@ void insn_get_modrm(struct insn *insn)
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
-		modrm->value = mod;
-		modrm->nbytes = 1;
+		insn_field_set(modrm, mod, 1);
 		if (inat_is_group(insn->attr)) {
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
@@ -334,7 +346,7 @@ int insn_rip_relative(struct insn *insn)
 	 * For rip-relative instructions, the mod field (top 2 bits)
 	 * is zero and the r/m field (bottom 3 bits) is 0x5.
 	 */
-	return (modrm->nbytes && (modrm->value & 0xc7) == 0x5);
+	return (modrm->nbytes && (modrm->bytes[0] & 0xc7) == 0x5);
 }
 
 /**
@@ -353,11 +365,11 @@ void insn_get_sib(struct insn *insn)
 	if (!insn->modrm.got)
 		insn_get_modrm(insn);
 	if (insn->modrm.nbytes) {
-		modrm = (insn_byte_t)insn->modrm.value;
+		modrm = insn->modrm.bytes[0];
 		if (insn->addr_bytes != 2 &&
 		    X86_MODRM_MOD(modrm) != 3 && X86_MODRM_RM(modrm) == 4) {
-			insn->sib.value = get_next(insn_byte_t, insn);
-			insn->sib.nbytes = 1;
+			insn_field_set(&insn->sib,
+				       get_next(insn_byte_t, insn), 1);
 		}
 	}
 	insn->sib.got = 1;
@@ -407,19 +419,18 @@ void insn_get_displacement(struct insn *insn)
 		if (mod == 3)
 			goto out;
 		if (mod == 1) {
-			insn->displacement.value = get_next(signed char, insn);
-			insn->displacement.nbytes = 1;
+			insn_field_set(&insn->displacement,
+				       get_next(signed char, insn), 1);
 		} else if (insn->addr_bytes == 2) {
 			if ((mod == 0 && rm == 6) || mod == 2) {
-				insn->displacement.value =
-					 get_next(short, insn);
-				insn->displacement.nbytes = 2;
+				insn_field_set(&insn->displacement,
+					       get_next(short, insn), 2);
 			}
 		} else {
 			if ((mod == 0 && rm == 5) || mod == 2 ||
 			    (mod == 0 && base == 5)) {
-				insn->displacement.value = get_next(int, insn);
-				insn->displacement.nbytes = 4;
+				insn_field_set(&insn->displacement,
+					       get_next(int, insn), 4);
 			}
 		}
 	}
@@ -435,18 +446,14 @@ static int __get_moffset(struct insn *insn)
 {
 	switch (insn->addr_bytes) {
 	case 2:
-		insn->moffset1.value = get_next(short, insn);
-		insn->moffset1.nbytes = 2;
+		insn_field_set(&insn->moffset1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->moffset1.value = get_next(int, insn);
-		insn->moffset1.nbytes = 4;
+		insn_field_set(&insn->moffset1, get_next(int, insn), 4);
 		break;
 	case 8:
-		insn->moffset1.value = get_next(int, insn);
-		insn->moffset1.nbytes = 4;
-		insn->moffset2.value = get_next(int, insn);
-		insn->moffset2.nbytes = 4;
+		insn_field_set(&insn->moffset1, get_next(int, insn), 4);
+		insn_field_set(&insn->moffset2, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -464,13 +471,11 @@ static int __get_immv32(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate.value = get_next(short, insn);
-		insn->immediate.nbytes = 2;
+		insn_field_set(&insn->immediate, get_next(short, insn), 2);
 		break;
 	case 4:
 	case 8:
-		insn->immediate.value = get_next(int, insn);
-		insn->immediate.nbytes = 4;
+		insn_field_set(&insn->immediate, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -487,18 +492,15 @@ static int __get_immv(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate1.value = get_next(short, insn);
-		insn->immediate1.nbytes = 2;
+		insn_field_set(&insn->immediate1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->immediate1.value = get_next(int, insn);
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
 		insn->immediate1.nbytes = 4;
 		break;
 	case 8:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		insn->immediate2.value = get_next(int, insn);
-		insn->immediate2.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
+		insn_field_set(&insn->immediate2, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -515,12 +517,10 @@ static int __get_immptr(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate1.value = get_next(short, insn);
-		insn->immediate1.nbytes = 2;
+		insn_field_set(&insn->immediate1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
 		break;
 	case 8:
 		/* ptr16:64 is not exist (no segment) */
@@ -528,8 +528,7 @@ static int __get_immptr(struct insn *insn)
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
 	}
-	insn->immediate2.value = get_next(unsigned short, insn);
-	insn->immediate2.nbytes = 2;
+	insn_field_set(&insn->immediate2, get_next(unsigned short, insn), 2);
 	insn->immediate1.got = insn->immediate2.got = 1;
 
 	return 1;
@@ -565,22 +564,17 @@ void insn_get_immediate(struct insn *insn)
 
 	switch (inat_immediate_size(insn->attr)) {
 	case INAT_IMM_BYTE:
-		insn->immediate.value = get_next(signed char, insn);
-		insn->immediate.nbytes = 1;
+		insn_field_set(&insn->immediate, get_next(signed char, insn), 1);
 		break;
 	case INAT_IMM_WORD:
-		insn->immediate.value = get_next(short, insn);
-		insn->immediate.nbytes = 2;
+		insn_field_set(&insn->immediate, get_next(short, insn), 2);
 		break;
 	case INAT_IMM_DWORD:
-		insn->immediate.value = get_next(int, insn);
-		insn->immediate.nbytes = 4;
+		insn_field_set(&insn->immediate, get_next(int, insn), 4);
 		break;
 	case INAT_IMM_QWORD:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		insn->immediate2.value = get_next(int, insn);
-		insn->immediate2.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
+		insn_field_set(&insn->immediate2, get_next(int, insn), 4);
 		break;
 	case INAT_IMM_PTR:
 		if (!__get_immptr(insn))
@@ -599,8 +593,7 @@ void insn_get_immediate(struct insn *insn)
 		goto err_out;
 	}
 	if (inat_has_second_immediate(insn->attr)) {
-		insn->immediate2.value = get_next(signed char, insn);
-		insn->immediate2.nbytes = 1;
+		insn_field_set(&insn->immediate2, get_next(signed char, insn), 1);
 	}
 done:
 	insn->immediate.got = 1;
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index b4c43a9b1483..f6fb1d218dcc 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -28,7 +28,7 @@ SYM_FUNC_START_NOALIGN(__x86_retpoline_\reg)
 	jmp	.Lspec_trap_\@
 .Ldo_rop_\@:
 	mov	%\reg, (%_ASM_SP)
-	UNWIND_HINT_RET_OFFSET
+	UNWIND_HINT_FUNC
 	ret
 SYM_FUNC_END(__x86_retpoline_\reg)
 
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 43b4d864817e..d2ccadc247e6 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -16,6 +16,7 @@
 #include <asm/boot.h>
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
+#include <asm/nospec-branch.h>
 #include <xen/interface/elfnote.h>
 
 	__HEAD
@@ -105,6 +106,7 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi
 	mov $_pa(startup_64), %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp *%rax
 
 #else /* CONFIG_X86_64 */
diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index 6907b523e856..3ff80156f21a 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD_hibernate_asm_$(BITS).o := y
 
 # __restore_processor_state() restores %gs after S3 resume and so should not
 # itself be stack-protected
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 7918b8415f13..d9bed596d849 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -21,6 +21,53 @@
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
 #include <asm/frame.h>
+#include <asm/nospec-branch.h>
+
+	 /* code below belongs to the image kernel */
+	.align PAGE_SIZE
+SYM_FUNC_START(restore_registers)
+	/* go back to the original page tables */
+	movq    %r9, %cr3
+
+	/* Flush TLB, including "global" things (vmalloc) */
+	movq	mmu_cr4_features(%rip), %rax
+	movq	%rax, %rdx
+	andq	$~(X86_CR4_PGE), %rdx
+	movq	%rdx, %cr4;  # turn off PGE
+	movq	%cr3, %rcx;  # flush TLB
+	movq	%rcx, %cr3
+	movq	%rax, %cr4;  # turn PGE back on
+
+	/* We don't restore %rax, it must be 0 anyway */
+	movq	$saved_context, %rax
+	movq	pt_regs_sp(%rax), %rsp
+	movq	pt_regs_bp(%rax), %rbp
+	movq	pt_regs_si(%rax), %rsi
+	movq	pt_regs_di(%rax), %rdi
+	movq	pt_regs_bx(%rax), %rbx
+	movq	pt_regs_cx(%rax), %rcx
+	movq	pt_regs_dx(%rax), %rdx
+	movq	pt_regs_r8(%rax), %r8
+	movq	pt_regs_r9(%rax), %r9
+	movq	pt_regs_r10(%rax), %r10
+	movq	pt_regs_r11(%rax), %r11
+	movq	pt_regs_r12(%rax), %r12
+	movq	pt_regs_r13(%rax), %r13
+	movq	pt_regs_r14(%rax), %r14
+	movq	pt_regs_r15(%rax), %r15
+	pushq	pt_regs_flags(%rax)
+	popfq
+
+	/* Saved in save_processor_state. */
+	lgdt	saved_context_gdt_desc(%rax)
+
+	xorl	%eax, %eax
+
+	/* tell the hibernation core that we've just restored the memory */
+	movq	%rax, in_suspend(%rip)
+
+	ret
+SYM_FUNC_END(restore_registers)
 
 SYM_FUNC_START(swsusp_arch_suspend)
 	movq	$saved_context, %rax
@@ -52,7 +99,7 @@ SYM_FUNC_START(swsusp_arch_suspend)
 	ret
 SYM_FUNC_END(swsusp_arch_suspend)
 
-SYM_CODE_START(restore_image)
+SYM_FUNC_START(restore_image)
 	/* prepare to jump to the image kernel */
 	movq	restore_jump_address(%rip), %r8
 	movq	restore_cr3(%rip), %r9
@@ -66,11 +113,12 @@ SYM_CODE_START(restore_image)
 
 	/* jump to relocated restore code */
 	movq	relocated_restore_code(%rip), %rcx
+	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%rcx
-SYM_CODE_END(restore_image)
+SYM_FUNC_END(restore_image)
 
 	/* code below has been relocated to a safe page */
-SYM_CODE_START(core_restore_code)
+SYM_FUNC_START(core_restore_code)
 	/* switch to temporary page tables */
 	movq	%rax, %cr3
 	/* flush TLB */
@@ -97,51 +145,6 @@ SYM_CODE_START(core_restore_code)
 
 .Ldone:
 	/* jump to the restore_registers address from the image header */
+	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%r8
-SYM_CODE_END(core_restore_code)
-
-	 /* code below belongs to the image kernel */
-	.align PAGE_SIZE
-SYM_FUNC_START(restore_registers)
-	/* go back to the original page tables */
-	movq    %r9, %cr3
-
-	/* Flush TLB, including "global" things (vmalloc) */
-	movq	mmu_cr4_features(%rip), %rax
-	movq	%rax, %rdx
-	andq	$~(X86_CR4_PGE), %rdx
-	movq	%rdx, %cr4;  # turn off PGE
-	movq	%cr3, %rcx;  # flush TLB
-	movq	%rcx, %cr3
-	movq	%rax, %cr4;  # turn PGE back on
-
-	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
-	movq	pt_regs_sp(%rax), %rsp
-	movq	pt_regs_bp(%rax), %rbp
-	movq	pt_regs_si(%rax), %rsi
-	movq	pt_regs_di(%rax), %rdi
-	movq	pt_regs_bx(%rax), %rbx
-	movq	pt_regs_cx(%rax), %rcx
-	movq	pt_regs_dx(%rax), %rdx
-	movq	pt_regs_r8(%rax), %r8
-	movq	pt_regs_r9(%rax), %r9
-	movq	pt_regs_r10(%rax), %r10
-	movq	pt_regs_r11(%rax), %r11
-	movq	pt_regs_r12(%rax), %r12
-	movq	pt_regs_r13(%rax), %r13
-	movq	pt_regs_r14(%rax), %r14
-	movq	pt_regs_r15(%rax), %r15
-	pushq	pt_regs_flags(%rax)
-	popfq
-
-	/* Saved in save_processor_state. */
-	lgdt	saved_context_gdt_desc(%rax)
-
-	xorl	%eax, %eax
-
-	/* tell the hibernation core that we've just restored the memory */
-	movq	%rax, in_suspend(%rip)
-
-	ret
-SYM_FUNC_END(restore_registers)
+SYM_FUNC_END(core_restore_code)
diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 55b1ab378974..bddfc9a46645 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -29,14 +29,14 @@ posttest: $(obj)/insn_decoder_test vmlinux $(obj)/insn_sanity
 hostprogs += insn_decoder_test insn_sanity
 
 # -I needed for generated C source and C source which in the kernel tree.
-HOSTCFLAGS_insn_decoder_test.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/uapi/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/uapi/
+HOSTCFLAGS_insn_decoder_test.o := -Wall -I$(srctree)/tools/arch/x86/lib/ -I$(srctree)/tools/arch/x86/include/ -I$(objtree)/arch/x86/lib/
 
-HOSTCFLAGS_insn_sanity.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/
+HOSTCFLAGS_insn_sanity.o := -Wall -I$(srctree)/tools/arch/x86/lib/ -I$(srctree)/tools/arch/x86/include/ -I$(objtree)/arch/x86/lib/
 
 # Dependencies are also needed.
-$(obj)/insn_decoder_test.o: $(srctree)/arch/x86/lib/insn.c $(srctree)/arch/x86/lib/inat.c $(srctree)/arch/x86/include/asm/inat_types.h $(srctree)/arch/x86/include/asm/inat.h $(srctree)/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
+$(obj)/insn_decoder_test.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tools/arch/x86/lib/inat.c $(srctree)/tools/arch/x86/include/asm/inat_types.h $(srctree)/tools/arch/x86/include/asm/inat.h $(srctree)/tools/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
 
-$(obj)/insn_sanity.o: $(srctree)/arch/x86/lib/insn.c $(srctree)/arch/x86/lib/inat.c $(srctree)/arch/x86/include/asm/inat_types.h $(srctree)/arch/x86/include/asm/inat.h $(srctree)/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
+$(obj)/insn_sanity.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tools/arch/x86/lib/inat.c $(srctree)/tools/arch/x86/include/asm/inat_types.h $(srctree)/tools/arch/x86/include/asm/inat.h $(srctree)/tools/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 hostprogs	+= relocs
diff --git a/arch/x86/tools/insn_sanity.c b/arch/x86/tools/insn_sanity.c
index 185ceba9d289..c6a0000ae635 100644
--- a/arch/x86/tools/insn_sanity.c
+++ b/arch/x86/tools/insn_sanity.c
@@ -14,10 +14,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-
-#define unlikely(cond) (cond)
-#define ARRAY_SIZE(a)	(sizeof(a)/sizeof(a[0]))
-
 #include <asm/insn.h>
 #include <inat.c>
 #include <insn.c>
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index fc5c5ba4aacb..40b5779fce21 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD_xen-asm.o := y
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 1cb0e84b9161..a05e80b552c0 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -14,6 +14,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm.h>
 #include <asm/frame.h>
+#include <asm/unwind_hints.h>
 
 #include <xen/interface/xen.h>
 
@@ -146,6 +147,7 @@ SYM_FUNC_END(xen_read_cr2_direct);
 
 .macro xen_pv_trap name
 SYM_CODE_START(xen_\name)
+	UNWIND_HINT_EMPTY
 	pop %rcx
 	pop %r11
 	jmp  \name
@@ -184,6 +186,7 @@ xen_pv_trap asm_exc_xen_hypervisor_callback
 SYM_CODE_START(xen_early_idt_handler_array)
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
+	UNWIND_HINT_EMPTY
 	pop %rcx
 	pop %r11
 	jmp early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE
@@ -210,11 +213,13 @@ hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
  * rsp->rax		}
  */
 SYM_CODE_START(xen_iret)
+	UNWIND_HINT_EMPTY
 	pushq $0
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
 
 SYM_CODE_START(xen_sysret64)
+	UNWIND_HINT_EMPTY
 	/*
 	 * We're already on the usermode stack at this point, but
 	 * still with the kernel gs, so we can easily switch back.
@@ -250,7 +255,8 @@ SYM_CODE_END(xen_sysret64)
  */
 
 /* Normal 64-bit system call target */
-SYM_FUNC_START(xen_syscall_target)
+SYM_CODE_START(xen_syscall_target)
+	UNWIND_HINT_EMPTY
 	popq %rcx
 	popq %r11
 
@@ -263,12 +269,13 @@ SYM_FUNC_START(xen_syscall_target)
 	movq $__USER_CS, 1*8(%rsp)
 
 	jmp entry_SYSCALL_64_after_hwframe
-SYM_FUNC_END(xen_syscall_target)
+SYM_CODE_END(xen_syscall_target)
 
 #ifdef CONFIG_IA32_EMULATION
 
 /* 32-bit compat syscall target */
-SYM_FUNC_START(xen_syscall32_target)
+SYM_CODE_START(xen_syscall32_target)
+	UNWIND_HINT_EMPTY
 	popq %rcx
 	popq %r11
 
@@ -281,10 +288,11 @@ SYM_FUNC_START(xen_syscall32_target)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSCALL_compat_after_hwframe
-SYM_FUNC_END(xen_syscall32_target)
+SYM_CODE_END(xen_syscall32_target)
 
 /* 32-bit compat sysenter target */
-SYM_FUNC_START(xen_sysenter_target)
+SYM_CODE_START(xen_sysenter_target)
+	UNWIND_HINT_EMPTY
 	/*
 	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
 	 * that we don't need to guard against single step exceptions here.
@@ -301,17 +309,18 @@ SYM_FUNC_START(xen_sysenter_target)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSENTER_compat_after_hwframe
-SYM_FUNC_END(xen_sysenter_target)
+SYM_CODE_END(xen_sysenter_target)
 
 #else /* !CONFIG_IA32_EMULATION */
 
-SYM_FUNC_START_ALIAS(xen_syscall32_target)
-SYM_FUNC_START(xen_sysenter_target)
+SYM_CODE_START(xen_syscall32_target)
+SYM_CODE_START(xen_sysenter_target)
+	UNWIND_HINT_EMPTY
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
 	pushq $0
 	jmp hypercall_iret
-SYM_FUNC_END(xen_sysenter_target)
-SYM_FUNC_END_ALIAS(xen_syscall32_target)
+SYM_CODE_END(xen_sysenter_target)
+SYM_CODE_END(xen_syscall32_target)
 
 #endif	/* CONFIG_IA32_EMULATION */
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 2d7c8f34f56c..cb6538ae2fe0 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -68,8 +68,9 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
 	.balign PAGE_SIZE
 SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)
-		UNWIND_HINT_EMPTY
-		.skip 32
+		UNWIND_HINT_FUNC
+		.skip 31, 0x90
+		ret
 	.endr
 
 #define HYPERCALL(n) \
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 577f51436cf9..7e72d975cb76 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -29,11 +29,14 @@ struct unwind_hint {
  *
  * UNWIND_HINT_TYPE_REGS_PARTIAL: Used in entry code to indicate that
  * sp_reg+sp_offset points to the iret return frame.
+ *
+ * UNWIND_HINT_FUNC: Generate the unwind metadata of a callable function.
+ * Useful for code which doesn't have an ELF function annotation.
  */
 #define UNWIND_HINT_TYPE_CALL		0
 #define UNWIND_HINT_TYPE_REGS		1
 #define UNWIND_HINT_TYPE_REGS_PARTIAL	2
-#define UNWIND_HINT_TYPE_RET_OFFSET	3
+#define UNWIND_HINT_TYPE_FUNC		3
 
 #ifdef CONFIG_STACK_VALIDATION
 
@@ -109,6 +112,12 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro STACK_FRAME_NON_STANDARD func:req
+	.pushsection .discard.func_stack_frame_non_standard, "aw"
+		.long \func - .
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -122,6 +131,8 @@ struct unwind_hint {
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
 .endm
+.macro STACK_FRAME_NON_STANDARD func:req
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 52c6262e6bfd..cc777c185212 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -7,9 +7,12 @@
  * Copyright (C) IBM Corporation, 2009
  */
 
+#include <asm/byteorder.h>
 /* insn_attr_t is defined in inat.h */
 #include "inat.h"
 
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+
 struct insn_field {
 	union {
 		insn_value_t value;
@@ -20,6 +23,48 @@ struct insn_field {
 	unsigned char nbytes;
 };
 
+static inline void insn_field_set(struct insn_field *p, insn_value_t v,
+				  unsigned char n)
+{
+	p->value = v;
+	p->nbytes = n;
+}
+
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+}
+
+#else
+
+struct insn_field {
+	insn_value_t value;
+	union {
+		insn_value_t little;
+		insn_byte_t bytes[4];
+	};
+	/* !0 if we've run insn_get_xxx() for this field */
+	unsigned char got;
+	unsigned char nbytes;
+};
+
+static inline void insn_field_set(struct insn_field *p, insn_value_t v,
+				  unsigned char n)
+{
+	p->value = v;
+	p->little = __cpu_to_le32(v);
+	p->nbytes = n;
+}
+
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+	p->value = __le32_to_cpu(p->little);
+}
+#endif
+
 struct insn {
 	struct insn_field prefixes;	/*
 					 * Prefixes
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index fdbffec4cfde..5a2baf28a1dc 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -40,6 +40,8 @@
 #define ORC_REG_MAX			15
 
 #ifndef __ASSEMBLY__
+#include <asm/byteorder.h>
+
 /*
  * This struct is more or less a vastly simplified version of the DWARF Call
  * Frame Information standard.  It contains only the necessary parts of DWARF
@@ -51,10 +53,18 @@
 struct orc_entry {
 	s16		sp_offset;
 	s16		bp_offset;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
 	unsigned	end:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	unsigned	bp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:5;
+	unsigned	end:1;
+	unsigned	type:2;
+#endif
 } __packed;
 
 #endif /* __ASSEMBLY__ */
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 0151dfc6da61..3d9355ed1246 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -5,6 +5,7 @@
  * Copyright (C) IBM Corporation, 2002, 2004, 2009
  */
 
+#include <linux/kernel.h>
 #ifdef __KERNEL__
 #include <linux/string.h>
 #else
@@ -15,15 +16,28 @@
 
 #include "../include/asm/emulate_prefix.h"
 
+#define leXX_to_cpu(t, r)						\
+({									\
+	__typeof__(t) v;						\
+	switch (sizeof(t)) {						\
+	case 4: v = le32_to_cpu(r); break;				\
+	case 2: v = le16_to_cpu(r); break;				\
+	case 1:	v = r; break;						\
+	default:							\
+		BUILD_BUG(); break;					\
+	}								\
+	v;								\
+})
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
+	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); r; })
+	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
@@ -147,9 +161,9 @@ void insn_get_prefixes(struct insn *insn)
 			b = insn->prefixes.bytes[3];
 			for (i = 0; i < nb; i++)
 				if (prefixes->bytes[i] == lb)
-					prefixes->bytes[i] = b;
+					insn_set_byte(prefixes, i, b);
 		}
-		insn->prefixes.bytes[3] = lb;
+		insn_set_byte(&insn->prefixes, 3, lb);
 	}
 
 	/* Decode REX prefix */
@@ -157,8 +171,7 @@ void insn_get_prefixes(struct insn *insn)
 		b = peek_next(insn_byte_t, insn);
 		attr = inat_get_opcode_attribute(b);
 		if (inat_is_rex_prefix(attr)) {
-			insn->rex_prefix.value = b;
-			insn->rex_prefix.nbytes = 1;
+			insn_field_set(&insn->rex_prefix, b, 1);
 			insn->next_byte++;
 			if (X86_REX_W(b))
 				/* REX.W overrides opnd_size */
@@ -181,13 +194,13 @@ void insn_get_prefixes(struct insn *insn)
 			if (X86_MODRM_MOD(b2) != 3)
 				goto vex_end;
 		}
-		insn->vex_prefix.bytes[0] = b;
-		insn->vex_prefix.bytes[1] = b2;
+		insn_set_byte(&insn->vex_prefix, 0, b);
+		insn_set_byte(&insn->vex_prefix, 1, b2);
 		if (inat_is_evex_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			b2 = peek_nbyte_next(insn_byte_t, insn, 3);
-			insn->vex_prefix.bytes[3] = b2;
+			insn_set_byte(&insn->vex_prefix, 3, b2);
 			insn->vex_prefix.nbytes = 4;
 			insn->next_byte += 4;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -195,7 +208,7 @@ void insn_get_prefixes(struct insn *insn)
 				insn->opnd_bytes = 8;
 		} else if (inat_is_vex3_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			insn->vex_prefix.nbytes = 3;
 			insn->next_byte += 3;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -207,7 +220,7 @@ void insn_get_prefixes(struct insn *insn)
 			 * Makes it easier to decode vex.W, vex.vvvv,
 			 * vex.L and vex.pp. Masking with 0x7f sets vex.W == 0.
 			 */
-			insn->vex_prefix.bytes[2] = b2 & 0x7f;
+			insn_set_byte(&insn->vex_prefix, 2, b2 & 0x7f);
 			insn->vex_prefix.nbytes = 2;
 			insn->next_byte += 2;
 		}
@@ -243,7 +256,7 @@ void insn_get_opcode(struct insn *insn)
 
 	/* Get first opcode */
 	op = get_next(insn_byte_t, insn);
-	opcode->bytes[0] = op;
+	insn_set_byte(opcode, 0, op);
 	opcode->nbytes = 1;
 
 	/* Check if there is VEX prefix or not */
@@ -295,8 +308,7 @@ void insn_get_modrm(struct insn *insn)
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
-		modrm->value = mod;
-		modrm->nbytes = 1;
+		insn_field_set(modrm, mod, 1);
 		if (inat_is_group(insn->attr)) {
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
@@ -334,7 +346,7 @@ int insn_rip_relative(struct insn *insn)
 	 * For rip-relative instructions, the mod field (top 2 bits)
 	 * is zero and the r/m field (bottom 3 bits) is 0x5.
 	 */
-	return (modrm->nbytes && (modrm->value & 0xc7) == 0x5);
+	return (modrm->nbytes && (modrm->bytes[0] & 0xc7) == 0x5);
 }
 
 /**
@@ -353,11 +365,11 @@ void insn_get_sib(struct insn *insn)
 	if (!insn->modrm.got)
 		insn_get_modrm(insn);
 	if (insn->modrm.nbytes) {
-		modrm = (insn_byte_t)insn->modrm.value;
+		modrm = insn->modrm.bytes[0];
 		if (insn->addr_bytes != 2 &&
 		    X86_MODRM_MOD(modrm) != 3 && X86_MODRM_RM(modrm) == 4) {
-			insn->sib.value = get_next(insn_byte_t, insn);
-			insn->sib.nbytes = 1;
+			insn_field_set(&insn->sib,
+				       get_next(insn_byte_t, insn), 1);
 		}
 	}
 	insn->sib.got = 1;
@@ -407,19 +419,18 @@ void insn_get_displacement(struct insn *insn)
 		if (mod == 3)
 			goto out;
 		if (mod == 1) {
-			insn->displacement.value = get_next(signed char, insn);
-			insn->displacement.nbytes = 1;
+			insn_field_set(&insn->displacement,
+				       get_next(signed char, insn), 1);
 		} else if (insn->addr_bytes == 2) {
 			if ((mod == 0 && rm == 6) || mod == 2) {
-				insn->displacement.value =
-					 get_next(short, insn);
-				insn->displacement.nbytes = 2;
+				insn_field_set(&insn->displacement,
+					       get_next(short, insn), 2);
 			}
 		} else {
 			if ((mod == 0 && rm == 5) || mod == 2 ||
 			    (mod == 0 && base == 5)) {
-				insn->displacement.value = get_next(int, insn);
-				insn->displacement.nbytes = 4;
+				insn_field_set(&insn->displacement,
+					       get_next(int, insn), 4);
 			}
 		}
 	}
@@ -435,18 +446,14 @@ static int __get_moffset(struct insn *insn)
 {
 	switch (insn->addr_bytes) {
 	case 2:
-		insn->moffset1.value = get_next(short, insn);
-		insn->moffset1.nbytes = 2;
+		insn_field_set(&insn->moffset1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->moffset1.value = get_next(int, insn);
-		insn->moffset1.nbytes = 4;
+		insn_field_set(&insn->moffset1, get_next(int, insn), 4);
 		break;
 	case 8:
-		insn->moffset1.value = get_next(int, insn);
-		insn->moffset1.nbytes = 4;
-		insn->moffset2.value = get_next(int, insn);
-		insn->moffset2.nbytes = 4;
+		insn_field_set(&insn->moffset1, get_next(int, insn), 4);
+		insn_field_set(&insn->moffset2, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -464,13 +471,11 @@ static int __get_immv32(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate.value = get_next(short, insn);
-		insn->immediate.nbytes = 2;
+		insn_field_set(&insn->immediate, get_next(short, insn), 2);
 		break;
 	case 4:
 	case 8:
-		insn->immediate.value = get_next(int, insn);
-		insn->immediate.nbytes = 4;
+		insn_field_set(&insn->immediate, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -487,18 +492,15 @@ static int __get_immv(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate1.value = get_next(short, insn);
-		insn->immediate1.nbytes = 2;
+		insn_field_set(&insn->immediate1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->immediate1.value = get_next(int, insn);
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
 		insn->immediate1.nbytes = 4;
 		break;
 	case 8:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		insn->immediate2.value = get_next(int, insn);
-		insn->immediate2.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
+		insn_field_set(&insn->immediate2, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -515,12 +517,10 @@ static int __get_immptr(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate1.value = get_next(short, insn);
-		insn->immediate1.nbytes = 2;
+		insn_field_set(&insn->immediate1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
 		break;
 	case 8:
 		/* ptr16:64 is not exist (no segment) */
@@ -528,8 +528,7 @@ static int __get_immptr(struct insn *insn)
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
 	}
-	insn->immediate2.value = get_next(unsigned short, insn);
-	insn->immediate2.nbytes = 2;
+	insn_field_set(&insn->immediate2, get_next(unsigned short, insn), 2);
 	insn->immediate1.got = insn->immediate2.got = 1;
 
 	return 1;
@@ -565,22 +564,17 @@ void insn_get_immediate(struct insn *insn)
 
 	switch (inat_immediate_size(insn->attr)) {
 	case INAT_IMM_BYTE:
-		insn->immediate.value = get_next(signed char, insn);
-		insn->immediate.nbytes = 1;
+		insn_field_set(&insn->immediate, get_next(signed char, insn), 1);
 		break;
 	case INAT_IMM_WORD:
-		insn->immediate.value = get_next(short, insn);
-		insn->immediate.nbytes = 2;
+		insn_field_set(&insn->immediate, get_next(short, insn), 2);
 		break;
 	case INAT_IMM_DWORD:
-		insn->immediate.value = get_next(int, insn);
-		insn->immediate.nbytes = 4;
+		insn_field_set(&insn->immediate, get_next(int, insn), 4);
 		break;
 	case INAT_IMM_QWORD:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		insn->immediate2.value = get_next(int, insn);
-		insn->immediate2.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
+		insn_field_set(&insn->immediate2, get_next(int, insn), 4);
 		break;
 	case INAT_IMM_PTR:
 		if (!__get_immptr(insn))
@@ -599,8 +593,7 @@ void insn_get_immediate(struct insn *insn)
 		goto err_out;
 	}
 	if (inat_has_second_immediate(insn->attr)) {
-		insn->immediate2.value = get_next(signed char, insn);
-		insn->immediate2.nbytes = 1;
+		insn_field_set(&insn->immediate2, get_next(signed char, insn), 1);
 	}
 done:
 	insn->immediate.got = 1;
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 577f51436cf9..7e72d975cb76 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -29,11 +29,14 @@ struct unwind_hint {
  *
  * UNWIND_HINT_TYPE_REGS_PARTIAL: Used in entry code to indicate that
  * sp_reg+sp_offset points to the iret return frame.
+ *
+ * UNWIND_HINT_FUNC: Generate the unwind metadata of a callable function.
+ * Useful for code which doesn't have an ELF function annotation.
  */
 #define UNWIND_HINT_TYPE_CALL		0
 #define UNWIND_HINT_TYPE_REGS		1
 #define UNWIND_HINT_TYPE_REGS_PARTIAL	2
-#define UNWIND_HINT_TYPE_RET_OFFSET	3
+#define UNWIND_HINT_TYPE_FUNC		3
 
 #ifdef CONFIG_STACK_VALIDATION
 
@@ -109,6 +112,12 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro STACK_FRAME_NON_STANDARD func:req
+	.pushsection .discard.func_stack_frame_non_standard, "aw"
+		.long \func - .
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -122,6 +131,8 @@ struct unwind_hint {
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
 .endm
+.macro STACK_FRAME_NON_STANDARD func:req
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/tools/objtool/.gitignore b/tools/objtool/.gitignore
index 45cefda24c7b..14236db3677f 100644
--- a/tools/objtool/.gitignore
+++ b/tools/objtool/.gitignore
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 arch/x86/lib/inat-tables.c
-objtool
+/objtool
 fixdep
diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index 0542e46c7552..30f38fdc0d56 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -315,13 +315,15 @@ they mean, and suggestions for how to fix them.
       function tracing inserts additional calls, which is not obvious from the
       sources).
 
-10. file.o: warning: func()+0x5c: alternative modifies stack
-
-    This means that an alternative includes instructions that modify the
-    stack. The problem is that there is only one ORC unwind table, this means
-    that the ORC unwind entries must be valid for each of the alternatives.
-    The easiest way to enforce this is to ensure alternatives do not contain
-    any ORC entries, which in turn implies the above constraint.
+10. file.o: warning: func()+0x5c: stack layout conflict in alternatives
+
+    This means that in the use of the alternative() or ALTERNATIVE()
+    macro, the code paths have conflicting modifications to the stack.
+    The problem is that there is only one ORC unwind table, which means
+    that the ORC unwind entries must be consistent for all possible
+    instruction boundaries regardless of which code has been patched.
+    This limitation can be overcome by massaging the alternatives with
+    NOPs to shift the stack changes around so they no longer conflict.
 
 11. file.o: warning: unannotated intra-function call
 
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 5cdb19036d7f..92ce4fce7bc7 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -27,6 +27,7 @@ all: $(OBJTOOL)
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
+	    -I$(srctree)/tools/objtool/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
@@ -46,10 +47,6 @@ ifeq ($(SRCARCH),x86)
 	SUBCMD_ORC := y
 endif
 
-ifeq ($(SUBCMD_ORC),y)
-	CFLAGS += -DINSN_USE_ORC
-endif
-
 export SUBCMD_CHECK SUBCMD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cde9c36e40ae..549813cff8ab 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -11,11 +11,11 @@
 #include "../../../arch/x86/lib/inat.c"
 #include "../../../arch/x86/lib/insn.c"
 
-#include "../../check.h"
-#include "../../elf.h"
-#include "../../arch.h"
-#include "../../warn.h"
 #include <asm/orc_types.h>
+#include <objtool/check.h>
+#include <objtool/elf.h>
+#include <objtool/arch.h>
+#include <objtool/warn.h>
 
 static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_AX, CFI_R8},
@@ -222,15 +222,38 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		break;
 
 	case 0x89:
-		if (rex_w && !rex_r && modrm_mod == 3 && modrm_reg == 4) {
+		if (rex_w && !rex_r && modrm_reg == 4) {
 
-			/* mov %rsp, reg */
-			ADD_OP(op) {
-				op->src.type = OP_SRC_REG;
-				op->src.reg = CFI_SP;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+			if (modrm_mod == 3) {
+				/* mov %rsp, reg */
+				ADD_OP(op) {
+					op->src.type = OP_SRC_REG;
+					op->src.reg = CFI_SP;
+					op->dest.type = OP_DEST_REG;
+					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+				}
+				break;
+
+			} else {
+				/* skip nontrivial SIB */
+				if (modrm_rm == 4 && !(sib == 0x24 && rex_b == rex_x))
+					break;
+
+				/* skip RIP relative displacement */
+				if (modrm_rm == 5 && modrm_mod == 0)
+					break;
+
+				/* mov %rsp, disp(%reg) */
+				ADD_OP(op) {
+					op->src.type = OP_SRC_REG;
+					op->src.reg = CFI_SP;
+					op->dest.type = OP_DEST_REG_INDIRECT;
+					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+					op->dest.offset = insn.displacement.value;
+				}
+				break;
 			}
+
 			break;
 		}
 
@@ -259,8 +282,10 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 				op->dest.reg = CFI_BP;
 				op->dest.offset = insn.displacement.value;
 			}
+			break;
+		}
 
-		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
+		if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
 
 			/* mov reg, disp(%rsp) */
 			ADD_OP(op) {
@@ -270,6 +295,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 				op->dest.reg = CFI_SP;
 				op->dest.offset = insn.displacement.value;
 			}
+			break;
 		}
 
 		break;
@@ -563,8 +589,8 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->cfa.offset = 8;
 
 	/* initial RA (return address) */
-	state->regs[16].base = CFI_CFA;
-	state->regs[16].offset = -8;
+	state->regs[CFI_RA].base = CFI_CFA;
+	state->regs[CFI_RA].offset = -8;
 }
 
 const char *arch_nop_insn(int len)
diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/arch/cfi_regs.h
similarity index 100%
rename from tools/objtool/arch/x86/include/cfi_regs.h
rename to tools/objtool/arch/x86/include/arch/cfi_regs.h
diff --git a/tools/objtool/arch/x86/include/arch_elf.h b/tools/objtool/arch/x86/include/arch/elf.h
similarity index 100%
rename from tools/objtool/arch/x86/include/arch_elf.h
rename to tools/objtool/arch/x86/include/arch/elf.h
diff --git a/tools/objtool/arch/x86/include/arch/endianness.h b/tools/objtool/arch/x86/include/arch/endianness.h
new file mode 100644
index 000000000000..7c362527da20
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch/endianness.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ARCH_ENDIANNESS_H
+#define _ARCH_ENDIANNESS_H
+
+#include <endian.h>
+
+#define __TARGET_BYTE_ORDER __LITTLE_ENDIAN
+
+#endif /* _ARCH_ENDIANNESS_H */
diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch/special.h
similarity index 100%
rename from tools/objtool/arch/x86/include/arch_special.h
rename to tools/objtool/arch/x86/include/arch/special.h
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index fd4af88c0ea5..e707d9bcd161 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <string.h>
 
-#include "../../special.h"
-#include "../../builtin.h"
+#include <objtool/special.h>
+#include <objtool/builtin.h>
 
 #define X86_FEATURE_POPCNT (4 * 32 + 23)
 #define X86_FEATURE_SMAP   (9 * 32 + 20)
@@ -48,7 +48,7 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 	 * replacement group.
 	 */
 	return insn->offset == special_alt->new_off &&
-	       (insn->type == INSN_CALL || is_static_jump(insn));
+	       (insn->type == INSN_CALL || is_jump(insn));
 }
 
 /*
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c6d199bfd0ae..f47951e19c9d 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -15,8 +15,8 @@
 
 #include <subcmd/parse-options.h>
 #include <string.h>
-#include "builtin.h"
-#include "objtool.h"
+#include <objtool/builtin.h>
+#include <objtool/objtool.h>
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
 
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 7b31121fa60b..8273bbf7cebb 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -13,8 +13,8 @@
  */
 
 #include <string.h>
-#include "builtin.h"
-#include "objtool.h"
+#include <objtool/builtin.h>
+#include <objtool/objtool.h>
 
 static const char *orc_usage[] = {
 	"objtool orc generate [<options>] file.o",
@@ -51,11 +51,7 @@ int cmd_orc(int argc, const char **argv)
 		if (list_empty(&file->insn_list))
 			return 0;
 
-		ret = create_orc(file);
-		if (ret)
-			return ret;
-
-		ret = create_orc_sections(file);
+		ret = orc_create(file);
 		if (ret)
 			return ret;
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5f8d3eed78a1..62cd211ec45c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -6,21 +6,20 @@
 #include <string.h>
 #include <stdlib.h>
 
-#include "builtin.h"
-#include "cfi.h"
-#include "arch.h"
-#include "check.h"
-#include "special.h"
-#include "warn.h"
-#include "arch_elf.h"
+#include <arch/elf.h>
+#include <objtool/builtin.h>
+#include <objtool/cfi.h>
+#include <objtool/arch.h>
+#include <objtool/check.h>
+#include <objtool/special.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 #include <linux/objtool.h>
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
 #include <linux/static_call_types.h>
 
-#define FAKE_JUMP_OFFSET -1
-
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -111,15 +110,20 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
 
 static bool is_sibling_call(struct instruction *insn)
 {
+	/*
+	 * Assume only ELF functions can make sibling calls.  This ensures
+	 * sibling call detection consistency between vmlinux.o and individual
+	 * objects.
+	 */
+	if (!insn->func)
+		return false;
+
 	/* An indirect jump is either a sibling call or a jump to a table. */
 	if (insn->type == INSN_JUMP_DYNAMIC)
 		return list_empty(&insn->alts);
 
-	if (!is_static_jump(insn))
-		return false;
-
 	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
-	return !!insn->call_dest;
+	return (is_static_jump(insn) && insn->call_dest);
 }
 
 /*
@@ -156,6 +160,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"machine_real_restart",
 		"rewind_stack_do_exit",
 		"kunit_try_catch_throw",
+		"xen_start_kernel",
 	};
 
 	if (!func)
@@ -774,22 +779,16 @@ static int add_jump_destinations(struct objtool_file *file)
 		if (!is_static_jump(insn))
 			continue;
 
-		if (insn->offset == FAKE_JUMP_OFFSET)
-			continue;
-
 		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					       insn->offset, insn->len);
+						 insn->offset, insn->len);
 		if (!reloc) {
 			dest_sec = insn->sec;
 			dest_off = arch_jump_destination(insn);
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (reloc->sym->sec->idx) {
-			dest_sec = reloc->sym->sec;
-			dest_off = reloc->sym->sym.st_value +
-				   arch_dest_reloc_offset(reloc->addend);
-		} else if (strstr(reloc->sym->name, "_indirect_thunk_")) {
+		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21) ||
+			   !strncmp(reloc->sym->name, "__x86_retpoline_", 16)) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -801,14 +800,21 @@ static int add_jump_destinations(struct objtool_file *file)
 
 			insn->retpoline_safe = true;
 			continue;
-		} else {
-			/* external sibling call */
+		} else if (insn->func) {
+			/* internal or external sibling call (with reloc) */
 			insn->call_dest = reloc->sym;
 			if (insn->call_dest->static_call_tramp) {
 				list_add_tail(&insn->static_call_node,
 					      &file->static_call_list);
 			}
 			continue;
+		} else if (reloc->sym->sec->idx) {
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->sym.st_value +
+				   arch_dest_reloc_offset(reloc->addend);
+		} else {
+			/* non-func asm code jumping to another file */
+			continue;
 		}
 
 		insn->jump_dest = find_insn(file, dest_sec, dest_off);
@@ -849,15 +855,15 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * case where the parent function's only reference to a
 			 * subfunction is through a jump table.
 			 */
-			if (!strstr(insn->func->name, ".cold.") &&
-			    strstr(insn->jump_dest->func->name, ".cold.")) {
+			if (!strstr(insn->func->name, ".cold") &&
+			    strstr(insn->jump_dest->func->name, ".cold")) {
 				insn->func->cfunc = insn->jump_dest->func;
 				insn->jump_dest->func->pfunc = insn->func;
 
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
 				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
 
-				/* internal sibling call */
+				/* internal sibling call (without reloc) */
 				insn->call_dest = insn->jump_dest->func;
 				if (insn->call_dest->static_call_tramp) {
 					list_add_tail(&insn->static_call_node,
@@ -970,73 +976,83 @@ static int add_call_destinations(struct objtool_file *file)
 }
 
 /*
- * The .alternatives section requires some extra special care, over and above
- * what other special sections require:
- *
- * 1. Because alternatives are patched in-place, we need to insert a fake jump
- *    instruction at the end so that validate_branch() skips all the original
- *    replaced instructions when validating the new instruction path.
- *
- * 2. An added wrinkle is that the new instruction length might be zero.  In
- *    that case the old instructions are replaced with noops.  We simulate that
- *    by creating a fake jump as the only new instruction.
- *
- * 3. In some cases, the alternative section includes an instruction which
- *    conditionally jumps to the _end_ of the entry.  We have to modify these
- *    jumps' destinations to point back to .text rather than the end of the
- *    entry in .altinstr_replacement.
+ * The .alternatives section requires some extra special care over and above
+ * other special sections because alternatives are patched in place.
  */
 static int handle_group_alt(struct objtool_file *file,
 			    struct special_alt *special_alt,
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
-	static unsigned int alt_group_next_index = 1;
-	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
-	unsigned int alt_group = alt_group_next_index++;
+	struct instruction *last_orig_insn, *last_new_insn = NULL, *insn, *nop = NULL;
+	struct alt_group *orig_alt_group, *new_alt_group;
 	unsigned long dest_off;
 
+
+	orig_alt_group = malloc(sizeof(*orig_alt_group));
+	if (!orig_alt_group) {
+		WARN("malloc failed");
+		return -1;
+	}
+	orig_alt_group->cfi = calloc(special_alt->orig_len,
+				     sizeof(struct cfi_state *));
+	if (!orig_alt_group->cfi) {
+		WARN("calloc failed");
+		return -1;
+	}
+
 	last_orig_insn = NULL;
 	insn = orig_insn;
 	sec_for_each_insn_from(file, insn) {
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
-		insn->alt_group = alt_group;
+		insn->alt_group = orig_alt_group;
 		last_orig_insn = insn;
 	}
+	orig_alt_group->orig_group = NULL;
+	orig_alt_group->first_insn = orig_insn;
+	orig_alt_group->last_insn = last_orig_insn;
+
+
+	new_alt_group = malloc(sizeof(*new_alt_group));
+	if (!new_alt_group) {
+		WARN("malloc failed");
+		return -1;
+	}
 
-	if (next_insn_same_sec(file, last_orig_insn)) {
-		fake_jump = malloc(sizeof(*fake_jump));
-		if (!fake_jump) {
+	if (special_alt->new_len < special_alt->orig_len) {
+		/*
+		 * Insert a fake nop at the end to make the replacement
+		 * alt_group the same size as the original.  This is needed to
+		 * allow propagate_alt_cfi() to do its magic.  When the last
+		 * instruction affects the stack, the instruction after it (the
+		 * nop) will propagate the new state to the shared CFI array.
+		 */
+		nop = malloc(sizeof(*nop));
+		if (!nop) {
 			WARN("malloc failed");
 			return -1;
 		}
-		memset(fake_jump, 0, sizeof(*fake_jump));
-		INIT_LIST_HEAD(&fake_jump->alts);
-		INIT_LIST_HEAD(&fake_jump->stack_ops);
-		init_cfi_state(&fake_jump->cfi);
+		memset(nop, 0, sizeof(*nop));
+		INIT_LIST_HEAD(&nop->alts);
+		INIT_LIST_HEAD(&nop->stack_ops);
+		init_cfi_state(&nop->cfi);
 
-		fake_jump->sec = special_alt->new_sec;
-		fake_jump->offset = FAKE_JUMP_OFFSET;
-		fake_jump->type = INSN_JUMP_UNCONDITIONAL;
-		fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
-		fake_jump->func = orig_insn->func;
+		nop->sec = special_alt->new_sec;
+		nop->offset = special_alt->new_off + special_alt->new_len;
+		nop->len = special_alt->orig_len - special_alt->new_len;
+		nop->type = INSN_NOP;
+		nop->func = orig_insn->func;
+		nop->alt_group = new_alt_group;
+		nop->ignore = orig_insn->ignore_alts;
 	}
 
 	if (!special_alt->new_len) {
-		if (!fake_jump) {
-			WARN("%s: empty alternative at end of section",
-			     special_alt->orig_sec->name);
-			return -1;
-		}
-
-		*new_insn = fake_jump;
-		return 0;
+		*new_insn = nop;
+		goto end;
 	}
 
-	last_new_insn = NULL;
-	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
 		struct reloc *alt_reloc;
@@ -1048,7 +1064,7 @@ static int handle_group_alt(struct objtool_file *file,
 
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
-		insn->alt_group = alt_group;
+		insn->alt_group = new_alt_group;
 
 		/*
 		 * Since alternative replacement code is copy/pasted by the
@@ -1075,14 +1091,8 @@ static int handle_group_alt(struct objtool_file *file,
 			continue;
 
 		dest_off = arch_jump_destination(insn);
-		if (dest_off == special_alt->new_off + special_alt->new_len) {
-			if (!fake_jump) {
-				WARN("%s: alternative jump to end of section",
-				     special_alt->orig_sec->name);
-				return -1;
-			}
-			insn->jump_dest = fake_jump;
-		}
+		if (dest_off == special_alt->new_off + special_alt->new_len)
+			insn->jump_dest = next_insn_same_sec(file, last_orig_insn);
 
 		if (!insn->jump_dest) {
 			WARN_FUNC("can't find alternative jump destination",
@@ -1097,9 +1107,13 @@ static int handle_group_alt(struct objtool_file *file,
 		return -1;
 	}
 
-	if (fake_jump)
-		list_add(&fake_jump->list, &last_new_insn->list);
-
+	if (nop)
+		list_add(&nop->list, &last_new_insn->list);
+end:
+	new_alt_group->orig_group = orig_alt_group;
+	new_alt_group->first_insn = *new_insn;
+	new_alt_group->last_insn = nop ? : last_new_insn;
+	new_alt_group->cfi = orig_alt_group->cfi;
 	return 0;
 }
 
@@ -1391,13 +1405,20 @@ static int add_jump_table_alts(struct objtool_file *file)
 	return 0;
 }
 
+static void set_func_state(struct cfi_state *state)
+{
+	state->cfa = initial_func_cfi.cfa;
+	memcpy(&state->regs, &initial_func_cfi.regs,
+	       CFI_NUM_REGS * sizeof(struct cfi_reg));
+	state->stack_size = initial_func_cfi.cfa.offset;
+}
+
 static int read_unwind_hints(struct objtool_file *file)
 {
 	struct section *sec, *relocsec;
 	struct reloc *reloc;
 	struct unwind_hint *hint;
 	struct instruction *insn;
-	struct cfi_reg *cfa;
 	int i;
 
 	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
@@ -1432,22 +1453,20 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		cfa = &insn->cfi.cfa;
+		insn->hint = true;
 
-		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
-			insn->ret_offset = hint->sp_offset;
+		if (hint->type == UNWIND_HINT_TYPE_FUNC) {
+			set_func_state(&insn->cfi);
 			continue;
 		}
 
-		insn->hint = true;
-
 		if (arch_decode_hint_reg(insn, hint->sp_reg)) {
 			WARN_FUNC("unsupported unwind_hint sp base reg %d",
 				  insn->sec, insn->offset, hint->sp_reg);
 			return -1;
 		}
 
-		cfa->offset = hint->sp_offset;
+		insn->cfi.cfa.offset = bswap_if_needed(hint->sp_offset);
 		insn->cfi.type = hint->type;
 		insn->cfi.end = hint->end;
 	}
@@ -1703,27 +1722,18 @@ static bool is_fentry_call(struct instruction *insn)
 
 static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
 {
-	u8 ret_offset = insn->ret_offset;
 	struct cfi_state *cfi = &state->cfi;
 	int i;
 
 	if (cfi->cfa.base != initial_func_cfi.cfa.base || cfi->drap)
 		return true;
 
-	if (cfi->cfa.offset != initial_func_cfi.cfa.offset + ret_offset)
+	if (cfi->cfa.offset != initial_func_cfi.cfa.offset)
 		return true;
 
-	if (cfi->stack_size != initial_func_cfi.cfa.offset + ret_offset)
+	if (cfi->stack_size != initial_func_cfi.cfa.offset)
 		return true;
 
-	/*
-	 * If there is a ret offset hint then don't check registers
-	 * because a callee-saved register might have been pushed on
-	 * the stack.
-	 */
-	if (ret_offset)
-		return false;
-
 	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (cfi->regs[i].base != initial_func_cfi.regs[i].base ||
 		    cfi->regs[i].offset != initial_func_cfi.regs[i].offset)
@@ -1733,12 +1743,20 @@ static bool has_modified_stack_frame(struct instruction *insn, struct insn_state
 	return false;
 }
 
+static bool check_reg_frame_pos(const struct cfi_reg *reg,
+				int expected_offset)
+{
+	return reg->base == CFI_CFA &&
+	       reg->offset == expected_offset;
+}
+
 static bool has_valid_stack_frame(struct insn_state *state)
 {
 	struct cfi_state *cfi = &state->cfi;
 
-	if (cfi->cfa.base == CFI_BP && cfi->regs[CFI_BP].base == CFI_CFA &&
-	    cfi->regs[CFI_BP].offset == -16)
+	if (cfi->cfa.base == CFI_BP &&
+	    check_reg_frame_pos(&cfi->regs[CFI_BP], -cfi->cfa.offset) &&
+	    check_reg_frame_pos(&cfi->regs[CFI_RA], -cfi->cfa.offset + 8))
 		return true;
 
 	if (cfi->drap && cfi->regs[CFI_BP].base == CFI_BP)
@@ -1867,8 +1885,7 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 		case OP_SRC_REG:
 			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
 			    cfa->base == CFI_SP &&
-			    regs[CFI_BP].base == CFI_CFA &&
-			    regs[CFI_BP].offset == -cfa->offset) {
+			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset)) {
 
 				/* mov %rsp, %rbp */
 				cfa->base = op->dest.reg;
@@ -1928,6 +1945,38 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 					cfa->offset = -cfi->vals[op->src.reg].offset;
 					cfi->stack_size = cfa->offset;
 
+				} else if (cfa->base == CFI_SP &&
+					   cfi->vals[op->src.reg].base == CFI_SP_INDIRECT &&
+					   cfi->vals[op->src.reg].offset == cfa->offset) {
+
+					/*
+					 * Stack swizzle:
+					 *
+					 * 1: mov %rsp, (%[tos])
+					 * 2: mov %[tos], %rsp
+					 *    ...
+					 * 3: pop %rsp
+					 *
+					 * Where:
+					 *
+					 * 1 - places a pointer to the previous
+					 *     stack at the Top-of-Stack of the
+					 *     new stack.
+					 *
+					 * 2 - switches to the new stack.
+					 *
+					 * 3 - pops the Top-of-Stack to restore
+					 *     the original stack.
+					 *
+					 * Note: we set base to SP_INDIRECT
+					 * here and preserve offset. Therefore
+					 * when the unwinder reaches ToS it
+					 * will dereference SP and then add the
+					 * offset to find the next frame, IOW:
+					 * (%rsp) + offset.
+					 */
+					cfa->base = CFI_SP_INDIRECT;
+
 				} else {
 					cfa->base = CFI_UNDEFINED;
 					cfa->offset = 0;
@@ -1953,6 +2002,17 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				break;
 			}
 
+			if (!cfi->drap && op->src.reg == CFI_SP &&
+			    op->dest.reg == CFI_BP && cfa->base == CFI_SP &&
+			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset + op->src.offset)) {
+
+				/* lea disp(%rsp), %rbp */
+				cfa->base = CFI_BP;
+				cfa->offset -= op->src.offset;
+				cfi->bp_scratch = false;
+				break;
+			}
+
 			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
 
 				/* drap: lea disp(%rsp), %drap */
@@ -2019,6 +2079,13 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 
 		case OP_SRC_POP:
 		case OP_SRC_POPF:
+			if (op->dest.reg == CFI_SP && cfa->base == CFI_SP_INDIRECT) {
+
+				/* pop %rsp; # restore from a stack swizzle */
+				cfa->base = CFI_SP;
+				break;
+			}
+
 			if (!cfi->drap && op->dest.reg == cfa->base) {
 
 				/* pop %rbp */
@@ -2047,6 +2114,14 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 			break;
 
 		case OP_SRC_REG_INDIRECT:
+			if (!cfi->drap && op->dest.reg == cfa->base &&
+			    op->dest.reg == CFI_BP) {
+
+				/* mov disp(%rsp), %rbp */
+				cfa->base = CFI_SP;
+				cfa->offset = cfi->stack_size;
+			}
+
 			if (cfi->drap && op->src.reg == CFI_BP &&
 			    op->src.offset == cfi->drap_offset) {
 
@@ -2068,6 +2143,12 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				/* mov disp(%rbp), %reg */
 				/* mov disp(%rsp), %reg */
 				restore_reg(cfi, op->dest.reg);
+
+			} else if (op->src.reg == CFI_SP &&
+				   op->src.offset == regs[op->dest.reg].offset + cfi->stack_size) {
+
+				/* mov disp(%rsp), %reg */
+				restore_reg(cfi, op->dest.reg);
 			}
 
 			break;
@@ -2145,6 +2226,18 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 			/* mov reg, disp(%rsp) */
 			save_reg(cfi, op->src.reg, CFI_CFA,
 				 op->dest.offset - cfi->cfa.offset);
+
+		} else if (op->dest.reg == CFI_SP) {
+
+			/* mov reg, disp(%rsp) */
+			save_reg(cfi, op->src.reg, CFI_CFA,
+				 op->dest.offset - cfi->stack_size);
+
+		} else if (op->src.reg == CFI_SP && op->dest.offset == 0) {
+
+			/* mov %rsp, (%reg); # setup a stack swizzle. */
+			cfi->vals[op->dest.reg].base = CFI_SP_INDIRECT;
+			cfi->vals[op->dest.reg].offset = cfa->offset;
 		}
 
 		break;
@@ -2192,22 +2285,47 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 	return 0;
 }
 
-static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
+/*
+ * The stack layouts of alternatives instructions can sometimes diverge when
+ * they have stack modifications.  That's fine as long as the potential stack
+ * layouts don't conflict at any given potential instruction boundary.
+ *
+ * Flatten the CFIs of the different alternative code streams (both original
+ * and replacement) into a single shared CFI array which can be used to detect
+ * conflicts and nicely feed a linear array of ORC entries to the unwinder.
+ */
+static int propagate_alt_cfi(struct objtool_file *file, struct instruction *insn)
 {
-	struct stack_op *op;
+	struct cfi_state **alt_cfi;
+	int group_off;
 
-	list_for_each_entry(op, &insn->stack_ops, list) {
-		struct cfi_state old_cfi = state->cfi;
-		int res;
+	if (!insn->alt_group)
+		return 0;
 
-		res = update_cfi_state(insn, &state->cfi, op);
-		if (res)
-			return res;
+	alt_cfi = insn->alt_group->cfi;
+	group_off = insn->offset - insn->alt_group->first_insn->offset;
 
-		if (insn->alt_group && memcmp(&state->cfi, &old_cfi, sizeof(struct cfi_state))) {
-			WARN_FUNC("alternative modifies stack", insn->sec, insn->offset);
+	if (!alt_cfi[group_off]) {
+		alt_cfi[group_off] = &insn->cfi;
+	} else {
+		if (memcmp(alt_cfi[group_off], &insn->cfi, sizeof(struct cfi_state))) {
+			WARN_FUNC("stack layout conflict in alternatives",
+				  insn->sec, insn->offset);
 			return -1;
 		}
+	}
+
+	return 0;
+}
+
+static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
+{
+	struct stack_op *op;
+
+	list_for_each_entry(op, &insn->stack_ops, list) {
+
+		if (update_cfi_state(insn, &state->cfi, op))
+			return 1;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
 			if (!state->uaccess_stack) {
@@ -2397,28 +2515,20 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 	return 0;
 }
 
-/*
- * Alternatives should not contain any ORC entries, this in turn means they
- * should not contain any CFI ops, which implies all instructions should have
- * the same same CFI state.
- *
- * It is possible to constuct alternatives that have unreachable holes that go
- * unreported (because they're NOPs), such holes would result in CFI_UNDEFINED
- * states which then results in ORC entries, which we just said we didn't want.
- *
- * Avoid them by copying the CFI entry of the first instruction into the whole
- * alternative.
- */
-static void fill_alternative_cfi(struct objtool_file *file, struct instruction *insn)
+static struct instruction *next_insn_to_validate(struct objtool_file *file,
+						 struct instruction *insn)
 {
-	struct instruction *first_insn = insn;
-	int alt_group = insn->alt_group;
+	struct alt_group *alt_group = insn->alt_group;
 
-	sec_for_each_insn_continue(file, insn) {
-		if (insn->alt_group != alt_group)
-			break;
-		insn->cfi = first_insn->cfi;
-	}
+	/*
+	 * Simulate the fact that alternatives are patched in-place.  When the
+	 * end of a replacement alt_group is reached, redirect objtool flow to
+	 * the end of the original alt_group.
+	 */
+	if (alt_group && insn == alt_group->last_insn && alt_group->orig_group)
+		return next_insn_same_sec(file, alt_group->orig_group->last_insn);
+
+	return next_insn_same_sec(file, insn);
 }
 
 /*
@@ -2439,7 +2549,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	sec = insn->sec;
 
 	while (1) {
-		next_insn = next_insn_same_sec(file, insn);
+		next_insn = next_insn_to_validate(file, insn);
 
 		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
 			WARN("%s() falls through to next function %s()",
@@ -2472,6 +2582,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		insn->visited |= visited;
 
+		if (propagate_alt_cfi(file, insn))
+			return 1;
+
 		if (!insn->ignore_alts && !list_empty(&insn->alts)) {
 			bool skip_orig = false;
 
@@ -2487,9 +2600,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				}
 			}
 
-			if (insn->alt_group)
-				fill_alternative_cfi(file, insn);
-
 			if (skip_orig)
 				return 0;
 		}
@@ -2527,7 +2637,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
-			if (func && is_sibling_call(insn)) {
+			if (is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
@@ -2549,7 +2659,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_JUMP_DYNAMIC:
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
-			if (func && is_sibling_call(insn)) {
+			if (is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
@@ -2592,15 +2702,19 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_STD:
-			if (state.df)
+			if (state.df) {
 				WARN_FUNC("recursive STD", sec, insn->offset);
+				return 1;
+			}
 
 			state.df = true;
 			break;
 
 		case INSN_CLD:
-			if (!state.df && func)
+			if (!state.df && func) {
 				WARN_FUNC("redundant CLD", sec, insn->offset);
+				return 1;
+			}
 
 			state.df = false;
 			break;
@@ -2723,9 +2837,6 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
 
-	if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->offset == FAKE_JUMP_OFFSET)
-		return true;
-
 	if (!insn->func)
 		return false;
 
@@ -2811,10 +2922,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 			continue;
 
 		init_insn_state(&state, sec);
-		state.cfi.cfa = initial_func_cfi.cfa;
-		memcpy(&state.cfi.regs, &initial_func_cfi.regs,
-		       CFI_NUM_REGS * sizeof(struct cfi_reg));
-		state.cfi.stack_size = initial_func_cfi.cfa.offset;
+		set_func_state(&state.cfi);
 
 		warnings += validate_symbol(file, sec, func, &state);
 	}
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index be89c741ba9a..43714ecd09f7 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -15,10 +15,10 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
-#include "builtin.h"
+#include <objtool/builtin.h>
 
-#include "elf.h"
-#include "warn.h"
+#include <objtool/elf.h>
+#include <objtool/warn.h>
 
 #define MAX_NAME_LEN 128
 
@@ -855,25 +855,27 @@ static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
 	int idx = 0, size;
-	GElf_Rel *relocs;
+	void *buf;
 
 	/* Allocate a buffer for relocations */
-	size = nr * sizeof(*relocs);
-	relocs = malloc(size);
-	if (!relocs) {
+	size = nr * sizeof(GElf_Rel);
+	buf = malloc(size);
+	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = relocs;
+	sec->data->d_buf = buf;
 	sec->data->d_size = size;
+	sec->data->d_type = ELF_T_REL;
 
 	sec->sh.sh_size = size;
 
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
-		relocs[idx].r_offset = reloc->offset;
-		relocs[idx].r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		reloc->rel.r_offset = reloc->offset;
+		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		gelf_update_rel(sec->data, idx, &reloc->rel);
 		idx++;
 	}
 
@@ -884,26 +886,28 @@ static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
 	int idx = 0, size;
-	GElf_Rela *relocs;
+	void *buf;
 
 	/* Allocate a buffer for relocations with addends */
-	size = nr * sizeof(*relocs);
-	relocs = malloc(size);
-	if (!relocs) {
+	size = nr * sizeof(GElf_Rela);
+	buf = malloc(size);
+	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = relocs;
+	sec->data->d_buf = buf;
 	sec->data->d_size = size;
+	sec->data->d_type = ELF_T_RELA;
 
 	sec->sh.sh_size = size;
 
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
-		relocs[idx].r_offset = reloc->offset;
-		relocs[idx].r_addend = reloc->addend;
-		relocs[idx].r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		reloc->rela.r_offset = reloc->offset;
+		reloc->rela.r_addend = reloc->addend;
+		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		gelf_update_rela(sec->data, idx, &reloc->rela);
 		idx++;
 	}
 
diff --git a/tools/objtool/arch.h b/tools/objtool/include/objtool/arch.h
similarity index 94%
rename from tools/objtool/arch.h
rename to tools/objtool/include/objtool/arch.h
index 4a84c3081b8e..6ff0685f5cc5 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -8,12 +8,8 @@
 
 #include <stdbool.h>
 #include <linux/list.h>
-#include "objtool.h"
-#include "cfi.h"
-
-#ifdef INSN_USE_ORC
-#include <asm/orc_types.h>
-#endif
+#include <objtool/objtool.h>
+#include <objtool/cfi.h>
 
 enum insn_type {
 	INSN_JUMP_CONDITIONAL,
diff --git a/tools/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
similarity index 100%
rename from tools/objtool/builtin.h
rename to tools/objtool/include/objtool/builtin.h
diff --git a/tools/objtool/cfi.h b/tools/objtool/include/objtool/cfi.h
similarity index 96%
rename from tools/objtool/cfi.h
rename to tools/objtool/include/objtool/cfi.h
index c7c59c6a44ee..fd5cb0bed9bf 100644
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/include/objtool/cfi.h
@@ -6,7 +6,7 @@
 #ifndef _OBJTOOL_CFI_H
 #define _OBJTOOL_CFI_H
 
-#include "cfi_regs.h"
+#include <arch/cfi_regs.h>
 
 #define CFI_UNDEFINED		-1
 #define CFI_CFA			-2
diff --git a/tools/objtool/check.h b/tools/objtool/include/objtool/check.h
similarity index 64%
rename from tools/objtool/check.h
rename to tools/objtool/include/objtool/check.h
index 5ec00a4b891b..4891ead0e85f 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -7,8 +7,8 @@
 #define _CHECK_H
 
 #include <stdbool.h>
-#include "cfi.h"
-#include "arch.h"
+#include <objtool/cfi.h>
+#include <objtool/arch.h>
 
 struct insn_state {
 	struct cfi_state cfi;
@@ -19,6 +19,23 @@ struct insn_state {
 	s8 instr;
 };
 
+struct alt_group {
+	/*
+	 * Pointer from a replacement group to the original group.  NULL if it
+	 * *is* the original group.
+	 */
+	struct alt_group *orig_group;
+
+	/* First and last instructions in the group */
+	struct instruction *first_insn, *last_insn;
+
+	/*
+	 * Byte-offset-addressed len-sized array of pointers to CFI structs.
+	 * This is shared with the other alt_groups in the same alternative.
+	 */
+	struct cfi_state **cfi;
+};
+
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
@@ -33,8 +50,7 @@ struct instruction {
 	bool retpoline_safe;
 	s8 instr;
 	u8 visited;
-	u8 ret_offset;
-	int alt_group;
+	struct alt_group *alt_group;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
@@ -43,9 +59,6 @@ struct instruction {
 	struct symbol *func;
 	struct list_head stack_ops;
 	struct cfi_state cfi;
-#ifdef INSN_USE_ORC
-	struct orc_entry orc;
-#endif
 };
 
 static inline bool is_static_jump(struct instruction *insn)
@@ -54,6 +67,17 @@ static inline bool is_static_jump(struct instruction *insn)
 	       insn->type == INSN_JUMP_UNCONDITIONAL;
 }
 
+static inline bool is_dynamic_jump(struct instruction *insn)
+{
+	return insn->type == INSN_JUMP_DYNAMIC ||
+	       insn->type == INSN_JUMP_DYNAMIC_CONDITIONAL;
+}
+
+static inline bool is_jump(struct instruction *insn)
+{
+	return is_static_jump(insn) || is_dynamic_jump(insn);
+}
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
diff --git a/tools/objtool/elf.h b/tools/objtool/include/objtool/elf.h
similarity index 100%
rename from tools/objtool/elf.h
rename to tools/objtool/include/objtool/elf.h
diff --git a/tools/objtool/include/objtool/endianness.h b/tools/objtool/include/objtool/endianness.h
new file mode 100644
index 000000000000..10241341eff3
--- /dev/null
+++ b/tools/objtool/include/objtool/endianness.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ENDIANNESS_H
+#define _OBJTOOL_ENDIANNESS_H
+
+#include <arch/endianness.h>
+#include <linux/kernel.h>
+#include <endian.h>
+
+#ifndef __TARGET_BYTE_ORDER
+#error undefined arch __TARGET_BYTE_ORDER
+#endif
+
+#if __BYTE_ORDER != __TARGET_BYTE_ORDER
+#define __NEED_BSWAP 1
+#else
+#define __NEED_BSWAP 0
+#endif
+
+/*
+ * Does a byte swap if target endianness doesn't match the host, i.e. cross
+ * compilation for little endian on big endian and vice versa.
+ * To be used for multi-byte values conversion, which are read from / about
+ * to be written to a target native endianness ELF file.
+ */
+#define bswap_if_needed(val)						\
+({									\
+	__typeof__(val) __ret;						\
+	switch (sizeof(val)) {						\
+	case 8: __ret = __NEED_BSWAP ? bswap_64(val) : (val); break;	\
+	case 4: __ret = __NEED_BSWAP ? bswap_32(val) : (val); break;	\
+	case 2: __ret = __NEED_BSWAP ? bswap_16(val) : (val); break;	\
+	default:							\
+		BUILD_BUG(); break;					\
+	}								\
+	__ret;								\
+})
+
+#endif /* _OBJTOOL_ENDIANNESS_H */
diff --git a/tools/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
similarity index 84%
rename from tools/objtool/objtool.h
rename to tools/objtool/include/objtool/objtool.h
index 4125d4578b23..e114642efb65 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -10,7 +10,7 @@
 #include <linux/list.h>
 #include <linux/hashtable.h>
 
-#include "elf.h"
+#include <objtool/elf.h>
 
 #define __weak __attribute__((weak))
 
@@ -26,7 +26,6 @@ struct objtool_file *objtool_open_read(const char *_objname);
 
 int check(struct objtool_file *file);
 int orc_dump(const char *objname);
-int create_orc(struct objtool_file *file);
-int create_orc_sections(struct objtool_file *file);
+int orc_create(struct objtool_file *file);
 
 #endif /* _OBJTOOL_H */
diff --git a/tools/objtool/special.h b/tools/objtool/include/objtool/special.h
similarity index 94%
rename from tools/objtool/special.h
rename to tools/objtool/include/objtool/special.h
index abddf38ef334..8a09f4e9d480 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -7,8 +7,8 @@
 #define _SPECIAL_H
 
 #include <stdbool.h>
-#include "check.h"
-#include "elf.h"
+#include <objtool/check.h>
+#include <objtool/elf.h>
 
 #define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
 
diff --git a/tools/objtool/warn.h b/tools/objtool/include/objtool/warn.h
similarity index 98%
rename from tools/objtool/warn.h
rename to tools/objtool/include/objtool/warn.h
index 7799f60de80a..d99c4675e4a5 100644
--- a/tools/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -11,7 +11,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include "elf.h"
+#include <objtool/elf.h>
 
 extern const char *objname;
 
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 9df0cd86d310..e848feb0a5fc 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -21,9 +21,9 @@
 #include <subcmd/pager.h>
 #include <linux/kernel.h>
 
-#include "builtin.h"
-#include "objtool.h"
-#include "warn.h"
+#include <objtool/builtin.h>
+#include <objtool/objtool.h>
+#include <objtool/warn.h>
 
 struct cmd_struct {
 	const char *name;
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 5e6a95368d35..f5a8508c42d6 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -6,8 +6,9 @@
 #include <unistd.h>
 #include <linux/objtool.h>
 #include <asm/orc_types.h>
-#include "objtool.h"
-#include "warn.h"
+#include <objtool/objtool.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 static const char *reg_name(unsigned int reg)
 {
@@ -54,7 +55,7 @@ static void print_reg(unsigned int reg, int offset)
 	if (reg == ORC_REG_BP_INDIRECT)
 		printf("(bp%+d)", offset);
 	else if (reg == ORC_REG_SP_INDIRECT)
-		printf("(sp%+d)", offset);
+		printf("(sp)%+d", offset);
 	else if (reg == ORC_REG_UNDEFINED)
 		printf("(und)");
 	else
@@ -197,11 +198,11 @@ int orc_dump(const char *_objname)
 
 		printf(" sp:");
 
-		print_reg(orc[i].sp_reg, orc[i].sp_offset);
+		print_reg(orc[i].sp_reg, bswap_if_needed(orc[i].sp_offset));
 
 		printf(" bp:");
 
-		print_reg(orc[i].bp_reg, orc[i].bp_offset);
+		print_reg(orc[i].bp_reg, bswap_if_needed(orc[i].bp_offset));
 
 		printf(" type:%s end:%d\n",
 		       orc_type_name(orc[i].type), orc[i].end);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 9ce68b385a1b..738aa5021bc4 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -9,93 +9,91 @@
 #include <linux/objtool.h>
 #include <asm/orc_types.h>
 
-#include "check.h"
-#include "warn.h"
+#include <objtool/check.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
-int create_orc(struct objtool_file *file)
+static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
 {
-	struct instruction *insn;
+	struct instruction *insn = container_of(cfi, struct instruction, cfi);
+	struct cfi_reg *bp = &cfi->regs[CFI_BP];
 
-	for_each_insn(file, insn) {
-		struct orc_entry *orc = &insn->orc;
-		struct cfi_reg *cfa = &insn->cfi.cfa;
-		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
+	memset(orc, 0, sizeof(*orc));
 
-		if (!insn->sec->text)
-			continue;
-
-		orc->end = insn->cfi.end;
-
-		if (cfa->base == CFI_UNDEFINED) {
-			orc->sp_reg = ORC_REG_UNDEFINED;
-			continue;
-		}
+	orc->end = cfi->end;
 
-		switch (cfa->base) {
-		case CFI_SP:
-			orc->sp_reg = ORC_REG_SP;
-			break;
-		case CFI_SP_INDIRECT:
-			orc->sp_reg = ORC_REG_SP_INDIRECT;
-			break;
-		case CFI_BP:
-			orc->sp_reg = ORC_REG_BP;
-			break;
-		case CFI_BP_INDIRECT:
-			orc->sp_reg = ORC_REG_BP_INDIRECT;
-			break;
-		case CFI_R10:
-			orc->sp_reg = ORC_REG_R10;
-			break;
-		case CFI_R13:
-			orc->sp_reg = ORC_REG_R13;
-			break;
-		case CFI_DI:
-			orc->sp_reg = ORC_REG_DI;
-			break;
-		case CFI_DX:
-			orc->sp_reg = ORC_REG_DX;
-			break;
-		default:
-			WARN_FUNC("unknown CFA base reg %d",
-				  insn->sec, insn->offset, cfa->base);
-			return -1;
-		}
+	if (cfi->cfa.base == CFI_UNDEFINED) {
+		orc->sp_reg = ORC_REG_UNDEFINED;
+		return 0;
+	}
 
-		switch(bp->base) {
-		case CFI_UNDEFINED:
-			orc->bp_reg = ORC_REG_UNDEFINED;
-			break;
-		case CFI_CFA:
-			orc->bp_reg = ORC_REG_PREV_SP;
-			break;
-		case CFI_BP:
-			orc->bp_reg = ORC_REG_BP;
-			break;
-		default:
-			WARN_FUNC("unknown BP base reg %d",
-				  insn->sec, insn->offset, bp->base);
-			return -1;
-		}
+	switch (cfi->cfa.base) {
+	case CFI_SP:
+		orc->sp_reg = ORC_REG_SP;
+		break;
+	case CFI_SP_INDIRECT:
+		orc->sp_reg = ORC_REG_SP_INDIRECT;
+		break;
+	case CFI_BP:
+		orc->sp_reg = ORC_REG_BP;
+		break;
+	case CFI_BP_INDIRECT:
+		orc->sp_reg = ORC_REG_BP_INDIRECT;
+		break;
+	case CFI_R10:
+		orc->sp_reg = ORC_REG_R10;
+		break;
+	case CFI_R13:
+		orc->sp_reg = ORC_REG_R13;
+		break;
+	case CFI_DI:
+		orc->sp_reg = ORC_REG_DI;
+		break;
+	case CFI_DX:
+		orc->sp_reg = ORC_REG_DX;
+		break;
+	default:
+		WARN_FUNC("unknown CFA base reg %d",
+			  insn->sec, insn->offset, cfi->cfa.base);
+		return -1;
+	}
 
-		orc->sp_offset = cfa->offset;
-		orc->bp_offset = bp->offset;
-		orc->type = insn->cfi.type;
+	switch (bp->base) {
+	case CFI_UNDEFINED:
+		orc->bp_reg = ORC_REG_UNDEFINED;
+		break;
+	case CFI_CFA:
+		orc->bp_reg = ORC_REG_PREV_SP;
+		break;
+	case CFI_BP:
+		orc->bp_reg = ORC_REG_BP;
+		break;
+	default:
+		WARN_FUNC("unknown BP base reg %d",
+			  insn->sec, insn->offset, bp->base);
+		return -1;
 	}
 
+	orc->sp_offset = cfi->cfa.offset;
+	orc->bp_offset = bp->offset;
+	orc->type = cfi->type;
+
 	return 0;
 }
 
-static int create_orc_entry(struct elf *elf, struct section *u_sec, struct section *ip_relocsec,
-				unsigned int idx, struct section *insn_sec,
-				unsigned long insn_off, struct orc_entry *o)
+static int write_orc_entry(struct elf *elf, struct section *orc_sec,
+			   struct section *ip_rsec, unsigned int idx,
+			   struct section *insn_sec, unsigned long insn_off,
+			   struct orc_entry *o)
 {
 	struct orc_entry *orc;
 	struct reloc *reloc;
 
 	/* populate ORC data */
-	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
+	orc = (struct orc_entry *)orc_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
+	orc->sp_offset = bswap_if_needed(orc->sp_offset);
+	orc->bp_offset = bswap_if_needed(orc->bp_offset);
 
 	/* populate reloc for ip */
 	reloc = malloc(sizeof(*reloc));
@@ -114,102 +112,149 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 
 	reloc->type = R_X86_64_PC32;
 	reloc->offset = idx * sizeof(int);
-	reloc->sec = ip_relocsec;
+	reloc->sec = ip_rsec;
 
 	elf_add_reloc(elf, reloc);
 
 	return 0;
 }
 
-int create_orc_sections(struct objtool_file *file)
-{
-	struct instruction *insn, *prev_insn;
-	struct section *sec, *u_sec, *ip_relocsec;
-	unsigned int idx;
+struct orc_list_entry {
+	struct list_head list;
+	struct orc_entry orc;
+	struct section *insn_sec;
+	unsigned long insn_off;
+};
 
-	struct orc_entry empty = {
-		.sp_reg = ORC_REG_UNDEFINED,
-		.bp_reg  = ORC_REG_UNDEFINED,
-		.type    = UNWIND_HINT_TYPE_CALL,
-	};
+static int orc_list_add(struct list_head *orc_list, struct orc_entry *orc,
+			struct section *sec, unsigned long offset)
+{
+	struct orc_list_entry *entry = malloc(sizeof(*entry));
 
-	sec = find_section_by_name(file->elf, ".orc_unwind");
-	if (sec) {
-		WARN("file already has .orc_unwind section, skipping");
+	if (!entry) {
+		WARN("malloc failed");
 		return -1;
 	}
 
-	/* count the number of needed orcs */
-	idx = 0;
-	for_each_sec(file, sec) {
-		if (!sec->text)
-			continue;
-
-		prev_insn = NULL;
-		sec_for_each_insn(file, sec, insn) {
-			if (!prev_insn ||
-			    memcmp(&insn->orc, &prev_insn->orc,
-				   sizeof(struct orc_entry))) {
-				idx++;
-			}
-			prev_insn = insn;
-		}
-
-		/* section terminator */
-		if (prev_insn)
-			idx++;
-	}
-	if (!idx)
-		return -1;
+	entry->orc	= *orc;
+	entry->insn_sec = sec;
+	entry->insn_off = offset;
 
+	list_add_tail(&entry->list, orc_list);
+	return 0;
+}
 
-	/* create .orc_unwind_ip and .rela.orc_unwind_ip sections */
-	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), idx);
-	if (!sec)
-		return -1;
+static unsigned long alt_group_len(struct alt_group *alt_group)
+{
+	return alt_group->last_insn->offset +
+	       alt_group->last_insn->len -
+	       alt_group->first_insn->offset;
+}
 
-	ip_relocsec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
-	if (!ip_relocsec)
-		return -1;
+int orc_create(struct objtool_file *file)
+{
+	struct section *sec, *ip_rsec, *orc_sec;
+	unsigned int nr = 0, idx = 0;
+	struct orc_list_entry *entry;
+	struct list_head orc_list;
 
-	/* create .orc_unwind section */
-	u_sec = elf_create_section(file->elf, ".orc_unwind", 0,
-				   sizeof(struct orc_entry), idx);
+	struct orc_entry null = {
+		.sp_reg  = ORC_REG_UNDEFINED,
+		.bp_reg  = ORC_REG_UNDEFINED,
+		.type    = UNWIND_HINT_TYPE_CALL,
+	};
 
-	/* populate sections */
-	idx = 0;
+	/* Build a deduplicated list of ORC entries: */
+	INIT_LIST_HEAD(&orc_list);
 	for_each_sec(file, sec) {
+		struct orc_entry orc, prev_orc = {0};
+		struct instruction *insn;
+		bool empty = true;
+
 		if (!sec->text)
 			continue;
 
-		prev_insn = NULL;
 		sec_for_each_insn(file, sec, insn) {
-			if (!prev_insn || memcmp(&insn->orc, &prev_insn->orc,
-						 sizeof(struct orc_entry))) {
+			struct alt_group *alt_group = insn->alt_group;
+			int i;
 
-				if (create_orc_entry(file->elf, u_sec, ip_relocsec, idx,
-						     insn->sec, insn->offset,
-						     &insn->orc))
+			if (!alt_group) {
+				if (init_orc_entry(&orc, &insn->cfi))
 					return -1;
+				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
+					continue;
+				if (orc_list_add(&orc_list, &orc, sec,
+						 insn->offset))
+					return -1;
+				nr++;
+				prev_orc = orc;
+				empty = false;
+				continue;
+			}
 
-				idx++;
+			/*
+			 * Alternatives can have different stack layout
+			 * possibilities (but they shouldn't conflict).
+			 * Instead of traversing the instructions, use the
+			 * alt_group's flattened byte-offset-addressed CFI
+			 * array.
+			 */
+			for (i = 0; i < alt_group_len(alt_group); i++) {
+				struct cfi_state *cfi = alt_group->cfi[i];
+				if (!cfi)
+					continue;
+				if (init_orc_entry(&orc, cfi))
+					return -1;
+				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
+					continue;
+				if (orc_list_add(&orc_list, &orc, insn->sec,
+						 insn->offset + i))
+					return -1;
+				nr++;
+				prev_orc = orc;
+				empty = false;
 			}
-			prev_insn = insn;
-		}
 
-		/* section terminator */
-		if (prev_insn) {
-			if (create_orc_entry(file->elf, u_sec, ip_relocsec, idx,
-					     prev_insn->sec,
-					     prev_insn->offset + prev_insn->len,
-					     &empty))
-				return -1;
+			/* Skip to the end of the alt_group */
+			insn = alt_group->last_insn;
+		}
 
-			idx++;
+		/* Add a section terminator */
+		if (!empty) {
+			orc_list_add(&orc_list, &null, sec, sec->len);
+			nr++;
 		}
 	}
+	if (!nr)
+		return 0;
+
+	/* Create .orc_unwind, .orc_unwind_ip and .rela.orc_unwind_ip sections: */
+	sec = find_section_by_name(file->elf, ".orc_unwind");
+	if (sec) {
+		WARN("file already has .orc_unwind section, skipping");
+		return -1;
+	}
+	orc_sec = elf_create_section(file->elf, ".orc_unwind", 0,
+				     sizeof(struct orc_entry), nr);
+	if (!orc_sec)
+		return -1;
+
+	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), nr);
+	if (!sec)
+		return -1;
+	ip_rsec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
+	if (!ip_rsec)
+		return -1;
+
+	/* Write ORC entries to sections: */
+	list_for_each_entry(entry, &orc_list, list) {
+		if (write_orc_entry(file->elf, orc_sec, ip_rsec, idx++,
+				    entry->insn_sec, entry->insn_off,
+				    &entry->orc))
+			return -1;
+	}
 
-	if (elf_rebuild_reloc_section(file->elf, ip_relocsec))
+	if (elf_rebuild_reloc_section(file->elf, ip_rsec))
 		return -1;
 
 	return 0;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 1a2420febd08..2c7fbda7b055 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -11,10 +11,11 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "builtin.h"
-#include "special.h"
-#include "warn.h"
-#include "arch_special.h"
+#include <arch/special.h>
+#include <objtool/builtin.h>
+#include <objtool/special.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 struct special_entry {
 	const char *sec;
@@ -77,8 +78,9 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 	if (entry->feature) {
 		unsigned short feature;
 
-		feature = *(unsigned short *)(sec->data->d_buf + offset +
-					      entry->feature);
+		feature = bswap_if_needed(*(unsigned short *)(sec->data->d_buf +
+							      offset +
+							      entry->feature));
 		arch_handle_alternative(feature, alt);
 	}
 
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 7843e9a7a72f..8314e824db4a 100644
--- a/tools/objtool/weak.c
+++ b/tools/objtool/weak.c
@@ -7,7 +7,7 @@
 
 #include <stdbool.h>
 #include <errno.h>
-#include "objtool.h"
+#include <objtool/objtool.h>
 
 #define UNSUPPORTED(name)						\
 ({									\
@@ -25,12 +25,7 @@ int __weak orc_dump(const char *_objname)
 	UNSUPPORTED("orc");
 }
 
-int __weak create_orc(struct objtool_file *file)
-{
-	UNSUPPORTED("orc");
-}
-
-int __weak create_orc_sections(struct objtool_file *file)
+int __weak orc_create(struct objtool_file *file)
 {
 	UNSUPPORTED("orc");
 }

