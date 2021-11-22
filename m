Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ACC4593C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbhKVRRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbhKVRRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:17:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37054C061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ALLEqeceox14FGyQ5vG3uOqQzYvlNPiqwIlXiR0dqsw=; b=K3dp/PtbqJ4icobk1yacf5YBeh
        z7+MLVfrBbsof2zMDmcX+cG2FQ5SwDftQSg0Go7AHQNrEhSsf1hZR+v7QeuNNlWBYbYhlB4zObRdM
        8ZTsHqnXVkKFU5D2108hRK8ExdYu1yp6BELwCeVK5shQbnUT4KSl1H1K6UVKYxGNVNV2zWLOc2885
        xRgo9FV93YoRyvcKemAwN+Dt3EZ7FTlAt5covmdsdkFkY2nQlhdV3aVJKLQQmt02Ndrkm/bRoO60e
        nO9Urb7LwhbJbHVr4F2peKcKnvFD+I/i7bjatnqNY+f+xLEPSoNBcJ8GoF6AynpkwxKjMlIHGINJ3
        wJRCi39A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpCtF-00D1sJ-N5; Mon, 22 Nov 2021 17:14:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F51E30074D;
        Mon, 22 Nov 2021 18:13:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 091D62C4B3CD2; Mon, 22 Nov 2021 18:13:59 +0100 (CET)
Message-ID: <20211122170805.338489412@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Nov 2021 18:03:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com
Subject: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
References: <20211122170301.764232470@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool based IBT validation in 3 passes:

 --ibt-fix-direct:

    Detect and rewrite any code/reloc from a JMP/CALL instruction
    to an ENDBR instruction. This is basically a compiler bug since
    neither needs the ENDBR and decoding it is a pure waste of time.

 --ibt:

    Report code relocs that are not JMP/CALL and don't point to ENDBR

    There's a bunch of false positives, for eg. static_call_update()
    and copy_thread() and kprobes. But most of them were due to
    _THIS_IP_ which has been taken care of with the prior annotation.

 --ibt-seal:

    Find and NOP superfluous ENDBR instructions. Any function that
    doesn't have it's address taken should not have an ENDBR
    instruction. This removes about 1-in-4 ENDBR instructions.

All these flags are LTO like and require '--vmlinux --duplicate' to
run. As is, the output on x86_64-defconfig looks like:

  defconfig-build/vmlinux.o: warning: objtool: apply_retpolines()+0x9b: relocation to !ENDBR: __x86_indirect_thunk_array+0x0
  defconfig-build/vmlinux.o: warning: objtool: copy_thread()+0x3c: relocation to !ENDBR: ret_from_fork+0x0
  defconfig-build/vmlinux.o: warning: objtool: machine_kexec_prepare()+0x189: relocation to !ENDBR: relocate_kernel+0x0
  defconfig-build/vmlinux.o: warning: objtool: machine_kexec()+0x44: relocation to !ENDBR: relocate_kernel+0x0
  defconfig-build/vmlinux.o: warning: objtool: __kretprobe_trampoline()+0x0: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: arch_prepare_kretprobe()+0x16: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: trampoline_handler()+0x1b: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: apply_relocate_add()+0x30: relocation to !ENDBR: __memcpy+0x0
  defconfig-build/vmlinux.o: warning: objtool: unwind_next_frame()+0x53d: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: unwind_next_frame()+0x3d0: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: unwind_next_frame()+0x232: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: __unwind_start()+0x11a: relocation to !ENDBR: ret_from_fork+0x0
  defconfig-build/vmlinux.o: warning: objtool: sched_dynamic_update()+0x3b: relocation to !ENDBR: preempt_schedule_thunk+0x0
  defconfig-build/vmlinux.o: warning: objtool: sched_dynamic_update()+0x55: relocation to !ENDBR: preempt_schedule_notrace_thunk+0x0
  defconfig-build/vmlinux.o: warning: objtool: sched_dynamic_update()+0x1e3: relocation to !ENDBR: preempt_schedule_thunk+0x0
  defconfig-build/vmlinux.o: warning: objtool: sched_dynamic_update()+0x1fd: relocation to !ENDBR: preempt_schedule_notrace_thunk+0x0
  defconfig-build/vmlinux.o: warning: objtool: filter_irq_stacks()+0x1f: relocation to !ENDBR: __irqentry_text_end+0x0
  defconfig-build/vmlinux.o: warning: objtool: __kretprobe_find_ret_addr()+0xe: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: kretprobe_find_ret_addr()+0x13: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: __kretprobe_trampoline_handler()+0x43: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: trace_seq_print_sym()+0x8e: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: trace_seq_print_sym()+0x39: relocation to !ENDBR: __kretprobe_trampoline+0x0
  defconfig-build/vmlinux.o: warning: objtool: override_function_with_return()+0x4: relocation to !ENDBR: just_return_func+0x0
  defconfig-build/vmlinux.o: warning: objtool: rpm_suspend()+0x409: relocation to !ENDBR: rpm_suspend+0x56b
  defconfig-build/vmlinux.o: warning: objtool: rpm_idle()+0x192: relocation to !ENDBR: rpm_idle+0x215
  defconfig-build/vmlinux.o: warning: objtool: arch_hibernation_header_save()+0x17: relocation to !ENDBR: restore_registers+0x0
  defconfig-build/vmlinux.o: warning: objtool: relocate_restore_code()+0x1e: relocation to !ENDBR: core_restore_code+0xfffffffffffffffc
  defconfig-build/vmlinux.o: warning: objtool: relocate_restore_code()+0x29: relocation to !ENDBR: core_restore_code+0x0
  defconfig-build/vmlinux.o: warning: objtool: init_real_mode()+0xf1: relocation to !ENDBR: secondary_startup_64+0x0
  defconfig-build/vmlinux.o: warning: objtool: int3_exception_notify()+0x52: relocation to !ENDBR: int3_magic+0x0
  defconfig-build/vmlinux.o: warning: objtool: exc_double_fault()+0x55: relocation to !ENDBR: native_irq_return_iret+0x0
  defconfig-build/vmlinux.o: warning: objtool: exc_debug()+0xa3: relocation to !ENDBR: __end_entry_SYSENTER_compat+0x0
  defconfig-build/vmlinux.o: warning: objtool: .text+0x5211c: relocation to !ENDBR: .text+0x52125
  defconfig-build/vmlinux.o: warning: objtool: .head.text+0x80: relocation to !ENDBR: .head.text+0x89
  defconfig-build/vmlinux.o: warning: objtool: .head.text+0xf4: relocation to !ENDBR: .head.text+0x107
  defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x1836: relocation to !ENDBR: asm_load_gs_index+0x3
  defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x1937: relocation to !ENDBR: .entry.text+0x19b4
  defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x198a: relocation to !ENDBR: .entry.text+0x19b4
  defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x1945: relocation to !ENDBR: .entry.text+0x19d9
  IBT superfluous ENDBR: 11799/43941

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c         |   18 ++
 tools/objtool/builtin-check.c           |   10 +
 tools/objtool/check.c                   |  236 +++++++++++++++++++++++++++++---
 tools/objtool/include/objtool/arch.h    |    2 
 tools/objtool/include/objtool/builtin.h |    2 
 tools/objtool/include/objtool/objtool.h |    3 
 tools/objtool/objtool.c                 |    1 
 7 files changed, 249 insertions(+), 23 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -112,7 +112,7 @@ int arch_decode_instruction(struct objto
 	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, ret;
-	unsigned char op1, op2,
+	unsigned char op1, op2, prefix,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
@@ -137,6 +137,8 @@ int arch_decode_instruction(struct objto
 	if (insn.vex_prefix.nbytes)
 		return 0;
 
+	prefix = insn.prefixes.bytes[0];
+
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
 
@@ -491,6 +493,11 @@ int arch_decode_instruction(struct objto
 			/* nopl/nopw */
 			*type = INSN_NOP;
 
+		} else if (op2 == 0x1e) {
+
+			if (prefix == 0xf3 && (modrm == 0xfa || modrm == 0xfb))
+				*type = INSN_ENDBR;
+
 		} else if (op2 == 0xa0 || op2 == 0xa8) {
 
 			/* push fs/gs */
@@ -691,6 +698,15 @@ const char *arch_nop_insn(int len)
 	return nops[len-1];
 }
 
+const char *arch_call_insn(unsigned long ip, unsigned long target)
+{
+	static char bytes[5] = { 0xe8, 0, 0, 0, 0 };
+
+	*(int *)(&bytes[1]) = (long)(target - (ip + 5));
+
+	return bytes;
+}
+
 #define BYTE_RET	0xC3
 
 const char *arch_ret_insn(int len)
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -20,7 +20,7 @@
 #include <objtool/objtool.h>
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-     validate_dup, vmlinux, mcount, noinstr, backup;
+     validate_dup, vmlinux, mcount, noinstr, backup, ibt, ibt_fix_direct, ibt_seal;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -45,6 +45,9 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
 	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
 	OPT_BOOLEAN('B', "backup", &backup, "create .orig files before modification"),
+	OPT_BOOLEAN(0, "ibt", &ibt, "foobar"),
+	OPT_BOOLEAN(0, "ibt-fix-direct", &ibt_fix_direct, "foobar"),
+	OPT_BOOLEAN(0, "ibt-seal", &ibt_seal, "foobar"),
 	OPT_END(),
 };
 
@@ -84,6 +87,11 @@ int cmd_check(int argc, const char **arg
 	argc = cmd_parse_options(argc, argv, check_usage);
 	objname = argv[0];
 
+	if (ibt && !(vmlinux && validate_dup)) {
+		fprintf(stderr, "--ibt requires: --vmlinux --duplicate\n");
+		exit(129);
+	}
+
 	file = objtool_open_read(objname);
 	if (!file)
 		return 1;
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -378,6 +378,7 @@ static int decode_instructions(struct ob
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
+			INIT_LIST_HEAD(&insn->call_node);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -1170,6 +1171,13 @@ static int add_jump_destinations(struct
 	unsigned long dest_off;
 
 	for_each_insn(file, insn) {
+		if (insn->type == INSN_ENDBR) {
+			if (insn->func && insn->offset == insn->func->offset) {
+				list_add_tail(&insn->call_node, &file->endbr_list);
+				file->nr_endbr++;
+			}
+		}
+
 		if (!is_static_jump(insn))
 			continue;
 
@@ -1186,10 +1194,14 @@ static int add_jump_destinations(struct
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
 			add_call_dest(file, insn, reloc->sym, true);
-			continue;
+
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->offset +
+				   arch_dest_reloc_offset(reloc->addend);
+
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
-			dest_off = reloc->sym->sym.st_value +
+			dest_off = reloc->sym->offset +
 				   arch_dest_reloc_offset(reloc->addend);
 		} else {
 			/* non-func asm code jumping to another file */
@@ -1199,6 +1211,9 @@ static int add_jump_destinations(struct
 		insn->jump_dest = find_insn(file, dest_sec, dest_off);
 		if (!insn->jump_dest) {
 
+			if (insn->func)
+				continue;
+
 			/*
 			 * This is a special case where an alt instruction
 			 * jumps past the end of the section.  These are
@@ -1213,6 +1228,19 @@ static int add_jump_destinations(struct
 			return -1;
 		}
 
+		if (ibt && insn->call_dest && insn->jump_dest->type == INSN_ENDBR) {
+			if (reloc) {
+				if (ibt_fix_direct) {
+					reloc->addend += 4;
+					elf_write_reloc(file->elf, reloc);
+				} else {
+					WARN_FUNC("Direct RELOC jump to ENDBR", insn->sec, insn->offset);
+				}
+			} else {
+				WARN_FUNC("Direct IMM jump to ENDBR", insn->sec, insn->offset);
+			}
+		}
+
 		/*
 		 * Cross-function jump.
 		 */
@@ -1240,7 +1268,8 @@ static int add_jump_destinations(struct
 				insn->jump_dest->func->pfunc = insn->func;
 
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
-				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
+				   ((insn->jump_dest->offset == insn->jump_dest->func->offset) ||
+				    (insn->jump_dest->offset == insn->jump_dest->func->offset + 4))) {
 				/* internal sibling call (without reloc) */
 				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}
@@ -1250,23 +1279,12 @@ static int add_jump_destinations(struct
 	return 0;
 }
 
-static struct symbol *find_call_destination(struct section *sec, unsigned long offset)
-{
-	struct symbol *call_dest;
-
-	call_dest = find_func_by_offset(sec, offset);
-	if (!call_dest)
-		call_dest = find_symbol_by_offset(sec, offset);
-
-	return call_dest;
-}
-
 /*
  * Find the destination instructions for all calls.
  */
 static int add_call_destinations(struct objtool_file *file)
 {
-	struct instruction *insn;
+	struct instruction *insn, *target = NULL;
 	unsigned long dest_off;
 	struct symbol *dest;
 	struct reloc *reloc;
@@ -1278,7 +1296,21 @@ static int add_call_destinations(struct
 		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
-			dest = find_call_destination(insn->sec, dest_off);
+
+			target = find_insn(file, insn->sec, dest_off);
+			if (!target) {
+				WARN_FUNC("direct call to nowhere", insn->sec, insn->offset);
+				return -1;
+			}
+			dest = target->func;
+			if (!dest)
+				dest = find_symbol_containing(insn->sec, dest_off);
+			if (!dest) {
+				WARN_FUNC("IMM can't find call dest symbol at %s+0x%lx",
+					  insn->sec, insn->offset,
+					  insn->sec->name, dest_off);
+				return -1;
+			}
 
 			add_call_dest(file, insn, dest, false);
 
@@ -1297,10 +1329,25 @@ static int add_call_destinations(struct
 			}
 
 		} else if (reloc->sym->type == STT_SECTION) {
-			dest_off = arch_dest_reloc_offset(reloc->addend);
-			dest = find_call_destination(reloc->sym->sec, dest_off);
+			struct section *dest_sec;
+
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->offset +
+				   arch_dest_reloc_offset(reloc->addend);
+
+			target = find_insn(file, dest_sec, dest_off);
+			if (target) {
+				dest = target->func;
+				if (!dest)
+					dest = find_symbol_containing(dest_sec, dest_off);
+			} else {
+				WARN("foo");
+				dest = find_func_by_offset(dest_sec, dest_off);
+				if (!dest)
+					dest = find_symbol_by_offset(dest_sec, dest_off);
+			}
 			if (!dest) {
-				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
+				WARN_FUNC("RELOC can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  reloc->sym->sec->name,
 					  dest_off);
@@ -1311,9 +1358,37 @@ static int add_call_destinations(struct
 
 		} else if (reloc->sym->retpoline_thunk) {
 			add_retpoline_call(file, insn);
+			continue;
+
+		} else {
+			struct section *dest_sec;
+
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->offset +
+				   arch_dest_reloc_offset(reloc->addend);
+
+			target = find_insn(file, dest_sec, dest_off);
 
-		} else
 			add_call_dest(file, insn, reloc->sym, false);
+		}
+
+		if (ibt && target && target->type == INSN_ENDBR) {
+			if (reloc) {
+				if (ibt_fix_direct) {
+					reloc->addend += 4;
+					elf_write_reloc(file->elf, reloc);
+				} else {
+					WARN_FUNC("Direct RELOC call to ENDBR", insn->sec, insn->offset);
+				}
+			} else {
+				if (ibt_fix_direct) {
+					elf_write_insn(file->elf, insn->sec, insn->offset, insn->len,
+						       arch_call_insn(insn->offset, dest_off + 4));
+				} else {
+					WARN_FUNC("Direct IMM call to ENDBR", insn->sec, insn->offset);
+				}
+			}
+		}
 	}
 
 	return 0;
@@ -3023,6 +3098,8 @@ static struct instruction *next_insn_to_
 	return next_insn_same_sec(file, insn);
 }
 
+static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn);
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -3071,6 +3148,12 @@ static int validate_branch(struct objtoo
 
 		if (insn->hint) {
 			state.cfi = *insn->cfi;
+			if (ibt) {
+				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_ENTRY &&
+				    insn->type != INSN_ENDBR) {
+					WARN_FUNC("IRET_ENTRY hint without ENDBR", insn->sec, insn->offset);
+				}
+			}
 		} else {
 			/* XXX track if we actually changed state.cfi */
 
@@ -3216,7 +3299,12 @@ static int validate_branch(struct objtoo
 			state.df = false;
 			break;
 
+		case INSN_NOP:
+			break;
+
 		default:
+			if (ibt)
+				validate_ibt_insn(file, insn);
 			break;
 		}
 
@@ -3466,6 +3554,111 @@ static int validate_functions(struct obj
 	return warnings;
 }
 
+static int validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc, char **name)
+{
+	struct instruction *dest;
+	struct section *sec;
+	unsigned long off;
+
+	sec = reloc->sym->sec;
+	off = reloc->sym->offset + reloc->addend;
+
+	dest = find_insn(file, sec, off);
+	if (!dest)
+		return 0;
+
+	if (name && dest->func)
+		*name = dest->func->name;
+
+	if (dest->type == INSN_ENDBR) {
+		if (!list_empty(&dest->call_node)) {
+			list_del_init(&dest->call_node);
+			return 1;
+		}
+		return 0;
+	}
+
+	if (reloc->sym->static_call_tramp)
+		return 0;
+
+	return -1;
+}
+
+static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
+{
+	struct reloc *reloc = insn_reloc(file, insn);
+	struct instruction *target;
+	unsigned long offset;
+
+	if (!reloc)
+		return;
+
+	if (validate_ibt_reloc(file, reloc, NULL) >= 0)
+		return;
+
+	offset = reloc->sym->offset + reloc->addend;
+
+	target = find_insn(file, reloc->sym->sec, offset);
+	if (target && insn->func == target->func && target->this_ip)
+		return;
+
+	WARN_FUNC("relocation to !ENDBR: %s+0x%lx",
+		  insn->sec, insn->offset,
+		  target && target->func ? target->func->name : reloc->sym->name,
+		  target && target->func ? target->offset - target->func->offset : reloc->addend);
+}
+
+static int validate_ibt(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	struct reloc *reloc;
+	char *name;
+	int nr = 0;
+
+	for_each_sec(file, sec) {
+		/* already done in validate_branch() */
+		if (sec->sh.sh_flags & SHF_EXECINSTR)
+			continue;
+
+		if (!sec->reloc)
+			continue;
+
+		if (!strncmp(sec->name, ".orc", 4))
+			continue;
+
+		if (!strncmp(sec->name, ".discard", 8))
+			continue;
+
+		if (!strcmp(sec->name, "_error_injection_whitelist"))
+			continue;
+
+		if (!strcmp(sec->name, "_kprobe_blacklist"))
+			continue;
+
+		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
+			if (validate_ibt_reloc(file, reloc, &name) > 0) {
+//				WARN("preserved (%s) ENDBR from section: %s", name, sec->name);
+			}
+
+		}
+	}
+
+	list_for_each_entry(insn, &file->endbr_list, call_node) {
+		if (ibt_seal) {
+			elf_write_insn(file->elf, insn->sec,
+				       insn->offset, insn->len,
+				       arch_nop_insn(insn->len));
+		}
+		nr++;
+	}
+
+	if (stats)
+		printf("IBT superfluous ENDBR: %d/%d\n", nr, file->nr_endbr);
+
+	return 0;
+}
+
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn;
@@ -3534,6 +3727,9 @@ int check(struct objtool_file *file)
 		goto out;
 	warnings += ret;
 
+	if (vmlinux && ibt)
+		ret = validate_ibt(file);
+
 	if (!warnings) {
 		ret = validate_reachable_instructions(file);
 		if (ret < 0)
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -26,6 +26,7 @@ enum insn_type {
 	INSN_CLAC,
 	INSN_STD,
 	INSN_CLD,
+	INSN_ENDBR,
 	INSN_OTHER,
 };
 
@@ -83,6 +84,7 @@ unsigned long arch_dest_reloc_offset(int
 
 const char *arch_nop_insn(int len);
 const char *arch_ret_insn(int len);
+const char *arch_call_insn(unsigned long ip, unsigned long target);
 
 int arch_decode_hint_reg(u8 sp_reg, int *base);
 
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,7 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-            validate_dup, vmlinux, mcount, noinstr, backup;
+            validate_dup, vmlinux, mcount, noinstr, backup, ibt, ibt_fix_direct, ibt_seal;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -26,8 +26,11 @@ struct objtool_file {
 	struct list_head retpoline_call_list;
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
+	struct list_head endbr_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 
+	unsigned int nr_endbr;
+
 	unsigned long jl_short, jl_long;
 	unsigned long jl_nop_short, jl_nop_long;
 
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -128,6 +128,7 @@ struct objtool_file *objtool_open_read(c
 	INIT_LIST_HEAD(&file.retpoline_call_list);
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
+	INIT_LIST_HEAD(&file.endbr_list);
 	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;


