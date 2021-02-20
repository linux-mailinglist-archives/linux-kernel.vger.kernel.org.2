Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9AD320782
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 23:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBTW3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 17:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhBTW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 17:29:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B6FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 14:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S5fj/O0GLfRafiagPJ/f5yvDr7YDDPFSp4WbvGYtrME=; b=SWe0Ih2fpSgvzkWVQjTu5IdPil
        jAkTaT/mb5EFqMFLmFIK2LVd/EHUqbeo/zsFI0HFosnl7SFdr2+H4lNLSqkNe6pmfs+dlvvhHdRy9
        DL4dwMpTBcXAriA7RraaBFqWJzOo+cetV9s+ujB5lyjEnlYm6CNUQDu4dqxr8fvBvkA8YNq2yLOUr
        W3Gjs/wrJ3zOpCWe571QBI4IyvKluy94m4Ioj1VV5tJGX7eyGFDIT3AWc5ePAq2d8BdHM4/0RLf5w
        gAZhAhKKtFGlTsckifiPpR4b7s2X+x+mcuY0ixSu4I5r0Au1nDqhCZLaL6upLSzunjLCinQr8B0Nn
        Fgsg25sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDajO-00026k-Lo; Sat, 20 Feb 2021 22:28:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 340F89864D6; Sat, 20 Feb 2021 23:28:02 +0100 (CET)
Date:   Sat, 20 Feb 2021 23:28:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        pjt@google.com, mbenes@suze.cz, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210220222802.GA4746@worktop.programming.kicks-ass.net>
References: <20210219204300.749932493@infradead.org>
 <20210219210535.492733466@infradead.org>
 <20210219215530.ivzzv3oavhuip6un@treble>
 <20210219220158.GD59023@worktop.programming.kicks-ass.net>
 <20210220003920.GG26778@zn.tnic>
 <YDE9bmaO4tOZ/HWn@hirez.programming.kicks-ass.net>
 <20210220174101.GA29905@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220174101.GA29905@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 06:41:01PM +0100, Borislav Petkov wrote:
> >  - I have more cases for objtool to rewrite code (I'll see if I can
> >    rebase and post that this weekend -- no promises).
> 
> Oh noes.

11 patches and one beer later, it even boots :-)

Saves more than 6k on a defconfig build.

I'll push it out to git in a bit.

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -4,12 +4,12 @@
 
 #define HAVE_JUMP_LABEL_BATCH
 
-#define JUMP_LABEL_NOP_SIZE 5
-
 #ifdef CONFIG_X86_64
-# define STATIC_KEY_INIT_NOP P6_NOP5_ATOMIC
+# define STATIC_KEY_NOP2 P6_NOP2
+# define STATIC_KEY_NOP5 P6_NOP5_ATOMIC
 #else
-# define STATIC_KEY_INIT_NOP GENERIC_NOP5_ATOMIC
+# define STATIC_KEY_NOP2 GENERIC_NOP2
+# define STATIC_KEY_NOP5 GENERIC_NOP5_ATOMIC
 #endif
 
 #include <asm/asm.h>
@@ -20,15 +20,35 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
 
+#define JUMP_TABLE_ENTRY				\
+	".pushsection __jump_table,  \"aw\" \n\t"	\
+	_ASM_ALIGN "\n\t"				\
+	".long 1b - . \n\t"				\
+	".long %l[l_yes] - . \n\t"			\
+	_ASM_PTR "%c0 + %c1 - .\n\t"			\
+	".popsection \n\t"
+
+#ifdef CONFIG_STACK_VALIDATION
+
+static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+{
+	asm_volatile_goto("1:"
+		"jmp %l[l_yes] # objtool NOPs this \n\t"
+		JUMP_TABLE_ENTRY
+		: :  "i" (key), "i" (2 | branch) : : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+#else
+
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
+		".byte " __stringify(STATIC_KEY_NOP5) "\n\t"
+		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
@@ -36,16 +56,13 @@ static __always_inline bool arch_static_
 	return true;
 }
 
+#endif /* STACK_VALIDATION */
+
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
-		"2:\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
+		"jmp %l[l_yes]\n\t"
+		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
@@ -53,41 +70,7 @@ static __always_inline bool arch_static_
 	return true;
 }
 
-#else	/* __ASSEMBLY__ */
-
-.macro STATIC_JUMP_IF_TRUE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.else
-	.byte		STATIC_KEY_INIT_NOP
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key - .
-	.popsection
-.endm
-
-.macro STATIC_JUMP_IF_FALSE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	.byte		STATIC_KEY_INIT_NOP
-	.else
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key + 1 - .
-	.popsection
-.endm
+extern int arch_jump_entry_size(struct jump_entry *entry);
 
 #endif	/* __ASSEMBLY__ */
 
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -5,6 +5,7 @@
 /*
  * Define nops for use with alternative() and for tracing.
  *
+ * *_NOP2 must be a single instruction
  * *_NOP5_ATOMIC must be a single instruction.
  */
 
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,53 +16,81 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
-static void bug_at(const void *ip, int line)
+int arch_jump_entry_size(struct jump_entry *entry)
 {
-	/*
-	 * The location is not an op that we were expecting.
-	 * Something went wrong. Crash the box, as something could be
-	 * corrupting the kernel.
-	 */
-	pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph) %d\n", ip, ip, ip, line);
-	BUG();
+	struct insn insn;
+
+	kernel_insn_init(&insn, (void *)jump_entry_code(entry), MAX_INSN_SIZE);
+	insn_get_length(&insn);
+	BUG_ON(insn.length != 2 && insn.length != 5);
+
+	return insn.length;
 }
 
-static const void *
-__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
+struct jump_label_patch {
+	const void *code;
+	int size;
+};
+
+static struct jump_label_patch
+__jump_label_patch(struct jump_entry *entry, enum jump_label_type type, int init)
 {
-	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	const void *expect, *code;
+	const unsigned char default_nop2[] = { STATIC_KEY_NOP2 };
+	const unsigned char default_nop5[] = { STATIC_KEY_NOP5 };
+	const void *expect, *code, *nop, *default_nop;
 	const void *addr, *dest;
-	int line;
+	int line, size;
 
 	addr = (void *)jump_entry_code(entry);
 	dest = (void *)jump_entry_target(entry);
 
-	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
+	size = arch_jump_entry_size(entry);
+	switch (size) {
+	case JMP8_INSN_SIZE:
+		code = text_gen_insn(JMP8_INSN_OPCODE, addr, dest);
+		default_nop = default_nop2;
+		nop = ideal_nops[2];
+		break;
+
+	case JMP32_INSN_SIZE:
+		code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
+		default_nop = default_nop5;
+		nop = ideal_nops[NOP_ATOMIC5];
+		break;
+
+	default: BUG();
+	}
 
 	if (init) {
 		expect = default_nop; line = __LINE__;
 	} else if (type == JUMP_LABEL_JMP) {
-		expect = ideal_nop; line = __LINE__;
+		expect = nop; line = __LINE__;
 	} else {
 		expect = code; line = __LINE__;
 	}
 
-	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE))
-		bug_at(addr, line);
+	if (memcmp(addr, expect, size)) {
+		/*
+		 * The location is not an op that we were expecting.
+		 * Something went wrong. Crash the box, as something could be
+		 * corrupting the kernel.
+		 */
+		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) line:%d init:%d size:%d type:%d\n",
+				addr, addr, addr, expect, line, init, size, type);
+		BUG();
+	}
 
 	if (type == JUMP_LABEL_NOP)
-		code = ideal_nop;
+		code = nop;
 
-	return code;
+	return (struct jump_label_patch){.code = code, .size = size};
 }
 
 static inline void __jump_label_transform(struct jump_entry *entry,
 					  enum jump_label_type type,
 					  int init)
 {
-	const void *opcode = __jump_label_set_jump_code(entry, type, init);
+	const struct jump_label_patch jlp = __jump_label_patch(entry, type, init);
 
 	/*
 	 * As long as only a single processor is running and the code is still
@@ -76,12 +104,11 @@ static inline void __jump_label_transfor
 	 * always nop being the 'currently valid' instruction
 	 */
 	if (init || system_state == SYSTEM_BOOTING) {
-		text_poke_early((void *)jump_entry_code(entry), opcode,
-				JUMP_LABEL_NOP_SIZE);
+		text_poke_early((void *)jump_entry_code(entry), jlp.code, jlp.size);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), opcode, JUMP_LABEL_NOP_SIZE, NULL);
+	text_poke_bp((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
 }
 
 static void __ref jump_label_transform(struct jump_entry *entry,
@@ -102,7 +129,7 @@ void arch_jump_label_transform(struct ju
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
 {
-	const void *opcode;
+	struct jump_label_patch jlp;
 
 	if (system_state == SYSTEM_BOOTING) {
 		/*
@@ -113,9 +140,8 @@ bool arch_jump_label_transform_queue(str
 	}
 
 	mutex_lock(&text_mutex);
-	opcode = __jump_label_set_jump_code(entry, type, 0);
-	text_poke_queue((void *)jump_entry_code(entry),
-			opcode, JUMP_LABEL_NOP_SIZE, NULL);
+	jlp = __jump_label_patch(entry, type, 0);
+	text_poke_queue((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
 	mutex_unlock(&text_mutex);
 	return true;
 }
@@ -137,21 +163,10 @@ __init_or_module void arch_jump_label_tr
 				      enum jump_label_type type)
 {
 	/*
-	 * This function is called at boot up and when modules are
-	 * first loaded. Check if the default nop, the one that is
-	 * inserted at compile time, is the ideal nop. If it is, then
-	 * we do not need to update the nop, and we can leave it as is.
-	 * If it is not, then we need to update the nop to the ideal nop.
+	 * Rewrite the NOP on init / module-load to ensure we got the ideal
+	 * nop.  Don't bother with trying to figure out what size and what nop
+	 * it should be for now, simply do an unconditional rewrite.
 	 */
-	if (jlstate == JL_STATE_START) {
-		const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-		const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-
-		if (memcmp(ideal_nop, default_nop, 5) != 0)
-			jlstate = JL_STATE_UPDATE;
-		else
-			jlstate = JL_STATE_NO_UPDATE;
-	}
-	if (jlstate == JL_STATE_UPDATE)
+	if (jlstate == JL_STATE_UPDATE || jlstate == JL_STATE_START)
 		jump_label_transform(entry, type, 1);
 }
--- a/arch/x86/realmode/Makefile
+++ b/arch/x86/realmode/Makefile
@@ -10,7 +10,6 @@
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
-OBJECT_FILES_NON_STANDARD	:= y
 
 subdir- := rm
 
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -171,9 +171,21 @@ static inline bool jump_entry_is_init(co
 	return (unsigned long)entry->key & 2UL;
 }
 
-static inline void jump_entry_set_init(struct jump_entry *entry)
+static inline void jump_entry_set_init(struct jump_entry *entry, bool set)
 {
-	entry->key |= 2;
+	if (set)
+		entry->key |= 2;
+	else
+		entry->key &= ~2;
+}
+
+static inline int jump_entry_size(struct jump_entry *entry)
+{
+#ifdef JUMP_LABEL_NOP_SIZE
+	return JUMP_LABEL_NOP_SIZE;
+#else
+	return arch_jump_entry_size(entry);
+#endif
 }
 
 #endif
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit)
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
 	if (jump_entry_code(entry) <= (unsigned long)end &&
-	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	    jump_entry_code(entry) + jump_entry_size(entry) > (unsigned long)start)
 		return 1;
 
 	return 0;
@@ -480,8 +480,8 @@ void __init jump_label_init(void)
 		if (jump_label_type(iter) == JUMP_LABEL_NOP)
 			arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
 
-		if (init_section_contains((void *)jump_entry_code(iter), 1))
-			jump_entry_set_init(iter);
+		jump_entry_set_init(iter,
+				    init_section_contains((void *)jump_entry_code(iter), 1));
 
 		iterk = jump_entry_key(iter);
 		if (iterk == key)
@@ -627,8 +627,8 @@ static int jump_label_add_module(struct
 	for (iter = iter_start; iter < iter_stop; iter++) {
 		struct static_key *iterk;
 
-		if (within_module_init(jump_entry_code(iter), mod))
-			jump_entry_set_init(iter);
+		jump_entry_set_init(iter,
+				    within_module_init(jump_entry_code(iter), mod));
 
 		iterk = jump_entry_key(iter);
 		if (iterk == key)
--- a/tools/objtool/arch/x86/include/arch/special.h
+++ b/tools/objtool/arch/x86/include/arch/special.h
@@ -9,6 +9,7 @@
 #define JUMP_ENTRY_SIZE		16
 #define JUMP_ORIG_OFFSET	0
 #define JUMP_NEW_OFFSET		4
+#define JUMP_KEY_OFFSET		8
 
 #define ALT_ENTRY_SIZE		13
 #define ALT_ORIG_OFFSET		0
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1164,6 +1164,22 @@ static int handle_jump_alt(struct objtoo
 		return -1;
 	}
 
+	if (special_alt->key_addend & 2) {
+		struct reloc *reloc;
+
+		reloc = find_reloc_by_dest_range(file->elf, orig_insn->sec,
+						 orig_insn->offset, orig_insn->len);
+		if (reloc) {
+			reloc->type = R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+		elf_write_insn(file->elf, orig_insn->sec,
+			       orig_insn->offset, orig_insn->len,
+			       arch_nop_insn(orig_insn->len));
+		orig_insn->type = INSN_NOP;
+		return 0;
+	}
+
 	*new_insn = list_next_entry(orig_insn, list);
 	return 0;
 }
@@ -1709,6 +1725,9 @@ static int decode_sections(struct objtoo
 	/*
 	 * Must be before add_{jump,call}_destination; for they can add
 	 * magic alternatives we can't actually parse.
+	 *
+	 * Also; must be before add_jump_destinations() because it will
+	 * rewrite JMPs into NOPs -- see handle_jump_alt().
 	 */
 	ret = add_special_section_alts(file);
 	if (ret)
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -27,6 +27,7 @@ struct special_alt {
 	unsigned long new_off;
 
 	unsigned int orig_len, new_len; /* group only */
+	u8 key_addend;
 };
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -23,6 +23,7 @@ struct special_entry {
 	unsigned char size, orig, new;
 	unsigned char orig_len, new_len; /* group only */
 	unsigned char feature; /* ALTERNATIVE macro CPU feature */
+	unsigned char key; /* jump_label key */
 };
 
 struct special_entry entries[] = {
@@ -42,6 +43,7 @@ struct special_entry entries[] = {
 		.size = JUMP_ENTRY_SIZE,
 		.orig = JUMP_ORIG_OFFSET,
 		.new = JUMP_NEW_OFFSET,
+		.key = JUMP_KEY_OFFSET,
 	},
 	{
 		.sec = "__ex_table",
@@ -114,6 +116,18 @@ static int get_alt_entry(struct elf *elf
 			alt->new_off -= 0x7ffffff0;
 	}
 
+	if (entry->key) {
+		struct reloc *key_reloc;
+
+		key_reloc = find_reloc_by_dest(elf, sec, offset + entry->key);
+		if (!key_reloc) {
+			WARN_FUNC("can't find key reloc",
+				  sec, offset + entry->key);
+			return -1;
+		}
+		alt->key_addend = key_reloc->addend;
+	}
+
 	return 0;
 }
 
