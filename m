Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5F3B747F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhF2Oli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhF2OlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:41:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA1AC061767
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:38:52 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:35:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624977530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=n8jHRvII4kcbh6j/Y2oo52GVVOJog1HB/XFuSvIe4gk=;
        b=JMXYdyzeVXBNic6qrBiJB5mYlgt52Moeu1TLejK/+Aca9wXLFnfAqE0ULY7SPv0t2e+fZ0
        Wr0keR/cMItHc1g82zJJtah+ch7xbiLhJUsqwxesR5sMbVl5AnZZHqii+zyxQCS1nwm24c
        X+HTG064p7DogtGwAw1qRJKLZjVIBalOM+5UMOHde62EMkly6kAq2kBbG8vmbzyj9XMu58
        kBttg4a26lXUAXmHDqKN2sSQX+cY/FllB2GxO3fWpglMdxl24qwstCxCfOmxuy4SDpegup
        9mahPGAjvjbC20SQC8rPD6U/5K3WFIaWvLjmtULDDEblbY3WgIv3WUVVRSUORQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624977530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=n8jHRvII4kcbh6j/Y2oo52GVVOJog1HB/XFuSvIe4gk=;
        b=UXzFCkq9MuE+ymRKN7yGm5LFdoSKJBhQ4c25WevywbJVp/2cNTUdiQf1eggm59nvyh1bQi
        cDzPzcG524168GCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/entry for v5.14-rc1
References: <162497731214.6531.6083197571290189651.tglx@nanos>
Message-ID: <162497731697.6531.7109985100069695741.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2021-06-29

up to:  48f7eee81cd5: x86/syscalls: Don't adjust CFLAGS for syscall tables


X86 entry code related updates:

 - Consolidate the macros for .byte ... opcode sequences

 - Deduplicate register offset defines in include files

 - Simplify the ia32,x32 compat handling of the related syscall tables to
   get rid of #ifdeffery.

 - Clear all EFLAGS which are not required for syscall handling

 - Consolidate the syscall tables and switch the generation over to the
   generic shell script and remove the CFLAGS tweaks which are not longer
   required.

 - Use 'int' type for system call numbers to match the generic code.

 - Add more selftests for syscalls

Thanks,

	tglx

------------------>
Brian Gerst (3):
      x86/uml/syscalls: Remove array index from syscall initializers
      x86/syscalls: Remove -Wno-override-init for syscall tables
      x86/syscalls: Don't adjust CFLAGS for syscall tables

H. Peter Anvin (1):
      x86/regs: Syscall_get_nr() returns -1 for a non-system call

H. Peter Anvin (Intel) (14):
      x86/asm: Have the __ASM_FORM macros handle commas in arguments
      x86/asm: Add _ASM_BYTES() macro for a .byte ... opcode sequence
      x86/asm: Use _ASM_BYTES() in <asm/nops.h>
      x86/entry: Unify definitions from <asm/calling.h> and <asm/ptrace-abi.h>
      x86/entry: Reverse arguments to do_syscall_64()
      x86/syscall: Unconditionally prototype {ia32,x32}_sys_call_table[]
      x86/syscall: Maximize MSR_SYSCALL_MASK
      x86/entry: Split PUSH_AND_CLEAR_REGS into two submacros
      selftests/x86/syscall: Update and extend syscall_numbering_64
      selftests/x86/syscall: Simplify message reporting in syscall_numbering
      selftests/x86/syscall: Add tests under ptrace to syscall_numbering_64
      x86/entry/64: Sign-extend system calls on entry to int
      x86/entry: Treat out of range and gap system calls the same
      x86/entry: Use int everywhere for system call numbers

Ingo Molnar (1):
      x86/asm: Make <asm/asm.h> valid on cross-builds as well

Masahiro Yamada (7):
      x86/entry/x32: Rename __x32_compat_sys_* to __x64_compat_sys_*
      x86/syscalls: Switch to generic syscalltbl.sh
      x86/syscalls: Stop filling syscall arrays with *_sys_ni_syscall
      x86/unistd: Define X32_NR_syscalls only for 64-bit kernel
      x86/syscalls: Use __NR_syscalls instead of __NR_syscall_max
      x86/syscalls: Switch to generic syscallhdr.sh
      x86/syscalls: Clear 'offset' and 'prefix' in case they are set in env


 arch/um/kernel/skas/syscall.c                   |   2 +-
 arch/x86/entry/Makefile                         |  10 -
 arch/x86/entry/calling.h                        |  45 +--
 arch/x86/entry/common.c                         |  87 +++--
 arch/x86/entry/entry_64.S                       |   5 +-
 arch/x86/entry/syscall_32.c                     |  20 +-
 arch/x86/entry/syscall_64.c                     |  17 +-
 arch/x86/entry/syscall_x32.c                    |  35 +-
 arch/x86/entry/syscalls/Makefile                |  38 +-
 arch/x86/entry/syscalls/syscallhdr.sh           |  35 --
 arch/x86/entry/syscalls/syscalltbl.sh           |  46 ---
 arch/x86/include/asm/Kbuild                     |   1 +
 arch/x86/include/asm/asm.h                      |  27 +-
 arch/x86/include/asm/nops.h                     |  24 +-
 arch/x86/include/asm/syscall.h                  |  13 +-
 arch/x86/include/asm/syscall_wrapper.h          |  10 +-
 arch/x86/include/asm/unistd.h                   |   8 +-
 arch/x86/kernel/cpu/common.c                    |  12 +-
 arch/x86/kernel/head_64.S                       |   6 +-
 arch/x86/kernel/ptrace.c                        |   2 +-
 arch/x86/kernel/signal.c                        |   4 +-
 arch/x86/um/sys_call_table_32.c                 |  14 +-
 arch/x86/um/sys_call_table_64.c                 |  15 +-
 tools/arch/x86/include/asm/asm.h                | 193 ++++++++++
 tools/arch/x86/include/asm/nops.h               |  24 +-
 tools/testing/selftests/x86/syscall_numbering.c | 491 +++++++++++++++++++++---
 26 files changed, 827 insertions(+), 357 deletions(-)
 delete mode 100644 arch/x86/entry/syscalls/syscallhdr.sh
 delete mode 100644 arch/x86/entry/syscalls/syscalltbl.sh
 create mode 100644 tools/arch/x86/include/asm/asm.h

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 3d91f89fd852..9ee19e566da3 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -41,7 +41,7 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
-	if (syscall >= 0 && syscall <= __NR_syscall_max)
+	if (syscall >= 0 && syscall < __NR_syscalls)
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
 
diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 08bf95dbc911..7fec5dcf6438 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -8,18 +8,8 @@ UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_syscall_x32.o	= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
-CFLAGS_syscall_64.o		+= -fno-stack-protector
-CFLAGS_syscall_32.o		+= -fno-stack-protector
-CFLAGS_syscall_x32.o		+= -fno-stack-protector
-
-CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
-CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
-CFLAGS_syscall_x32.o		+= $(call cc-option,-Wno-override-init,)
 
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 07a9331d55e7..a4c061fb7c6e 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,6 +6,7 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/ptrace-abi.h>
 
 /*
 
@@ -62,42 +63,7 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-/* The layout forms the "struct pt_regs" on the stack: */
-/*
- * C ABI says these regs are callee-preserved. They aren't saved on kernel entry
- * unless syscall needs a complete, fully filled "struct pt_regs".
- */
-#define R15		0*8
-#define R14		1*8
-#define R13		2*8
-#define R12		3*8
-#define RBP		4*8
-#define RBX		5*8
-/* These regs are callee-clobbered. Always saved on kernel entry. */
-#define R11		6*8
-#define R10		7*8
-#define R9		8*8
-#define R8		9*8
-#define RAX		10*8
-#define RCX		11*8
-#define RDX		12*8
-#define RSI		13*8
-#define RDI		14*8
-/*
- * On syscall entry, this is syscall#. On CPU exception, this is error code.
- * On hw interrupt, it's IRQ number:
- */
-#define ORIG_RAX	15*8
-/* Return frame for iretq */
-#define RIP		16*8
-#define CS		17*8
-#define EFLAGS		18*8
-#define RSP		19*8
-#define SS		20*8
-
-#define SIZEOF_PTREGS	21*8
-
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
+.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -124,7 +90,9 @@ For 32-bit we have the following conventions - kernel is built with
 	.if \save_ret
 	pushq	%rsi		/* return address on top of stack */
 	.endif
+.endm
 
+.macro CLEAR_REGS
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
@@ -146,6 +114,11 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
+	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
+	CLEAR_REGS
+.endm
+
 .macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7b2542b13ebd..ee95fe3f1518 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -36,61 +36,97 @@
 #include <asm/irq_stack.h>
 
 #ifdef CONFIG_X86_64
-__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+
+static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Convert negative numbers to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int unr = nr;
+
+	if (likely(unr < NR_syscalls)) {
+		unr = array_index_nospec(unr, NR_syscalls);
+		regs->ax = sys_call_table[unr](regs);
+		return true;
+	}
+	return false;
+}
+
+static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Adjust the starting offset of the table, and convert numbers
+	 * < __X32_SYSCALL_BIT to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int xnr = nr - __X32_SYSCALL_BIT;
+
+	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
+		xnr = array_index_nospec(xnr, X32_NR_syscalls);
+		regs->ax = x32_sys_call_table[xnr](regs);
+		return true;
+	}
+	return false;
+}
+
+__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
 {
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	instrumentation_begin();
-	if (likely(nr < NR_syscalls)) {
-		nr = array_index_nospec(nr, NR_syscalls);
-		regs->ax = sys_call_table[nr](regs);
-#ifdef CONFIG_X86_X32_ABI
-	} else if (likely((nr & __X32_SYSCALL_BIT) &&
-			  (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)) {
-		nr = array_index_nospec(nr & ~__X32_SYSCALL_BIT,
-					X32_NR_syscalls);
-		regs->ax = x32_sys_call_table[nr](regs);
-#endif
+
+	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
+		/* Invalid system call, but still a system call. */
+		regs->ax = __x64_sys_ni_syscall(regs);
 	}
+
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
-static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
+static __always_inline int syscall_32_enter(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_IA32_EMULATION))
 		current_thread_info()->status |= TS_COMPAT;
 
-	return (unsigned int)regs->orig_ax;
+	return (int)regs->orig_ax;
 }
 
 /*
  * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
  */
-static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
-						  unsigned int nr)
+static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 {
-	if (likely(nr < IA32_NR_syscalls)) {
-		nr = array_index_nospec(nr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call_table[nr](regs);
+	/*
+	 * Convert negative numbers to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int unr = nr;
+
+	if (likely(unr < IA32_NR_syscalls)) {
+		unr = array_index_nospec(unr, IA32_NR_syscalls);
+		regs->ax = ia32_sys_call_table[unr](regs);
+	} else if (nr != -1) {
+		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
 }
 
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	unsigned int nr = syscall_32_enter(regs);
+	int nr = syscall_32_enter(regs);
 
 	add_random_kstack_offset();
 	/*
-	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
-	 * orig_ax, the unsigned int return value truncates it.  This may
-	 * or may not be necessary, but it matches the old asm behavior.
+	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
+	 * orig_ax, the int return value truncates it. This matches
+	 * the semantics of syscall_get_nr().
 	 */
-	nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
+	nr = syscall_enter_from_user_mode(regs, nr);
 	instrumentation_begin();
 
 	do_syscall_32_irqs_on(regs, nr);
@@ -101,7 +137,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 
 static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
-	unsigned int nr = syscall_32_enter(regs);
+	int nr = syscall_32_enter(regs);
 	int res;
 
 	add_random_kstack_offset();
@@ -136,8 +172,7 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 		return false;
 	}
 
-	/* The case truncates any ptrace induced syscall nr > 2^32 -1 */
-	nr = (unsigned int)syscall_enter_from_user_mode_work(regs, nr);
+	nr = syscall_enter_from_user_mode_work(regs, nr);
 
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index a16a5294d55f..a5f02d03c585 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -107,8 +107,9 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
 	/* IRQs are off. */
-	movq	%rax, %rdi
-	movq	%rsp, %rsi
+	movq	%rsp, %rdi
+	/* Sign extend the lower 32bit as syscall numbers are treated as int */
+	movslq	%eax, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 	/*
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 86eb0d89d46f..8cfc9bc73e7f 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -5,21 +5,21 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_I386(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
+#ifdef CONFIG_IA32_EMULATION
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
+#else
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+#endif
+
+#define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
 
 #include <asm/syscalls_32.h>
-#undef __SYSCALL_I386
+#undef __SYSCALL
 
-#define __SYSCALL_I386(nr, sym) [nr] = __ia32_##sym,
+#define __SYSCALL(nr, sym) __ia32_##sym,
 
-__visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_ia32_syscall_max] = &__ia32_sys_ni_syscall,
+__visible const sys_call_ptr_t ia32_sys_call_table[] = {
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 1594ec72bcbb..be120eec1fc9 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -5,23 +5,14 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_X32(nr, sym)
-#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
-
-#define __SYSCALL_64(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
-#undef __SYSCALL_64
+#undef __SYSCALL
 
-#define __SYSCALL_64(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) __x64_##sym,
 
-asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_max] = &__x64_sys_ni_syscall,
+asmlinkage const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_64.h>
 };
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index f2fe0a33bcfd..bdd0e03a1265 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -5,37 +5,14 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
-/*
- * Reuse the 64-bit entry points for the x32 versions that occupy different
- * slots in the syscall table.
- */
-#define __x32_sys_readv		__x64_sys_readv
-#define __x32_sys_writev	__x64_sys_writev
-#define __x32_sys_getsockopt	__x64_sys_getsockopt
-#define __x32_sys_setsockopt	__x64_sys_setsockopt
-#define __x32_sys_vmsplice	__x64_sys_vmsplice
-#define __x32_sys_process_vm_readv	__x64_sys_process_vm_readv
-#define __x32_sys_process_vm_writev	__x64_sys_process_vm_writev
+#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#include <asm/syscalls_x32.h>
+#undef __SYSCALL
 
-#define __SYSCALL_64(nr, sym)
+#define __SYSCALL(nr, sym) __x64_##sym,
 
-#define __SYSCALL_X32(nr, sym) extern long __x32_##sym(const struct pt_regs *);
-#define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
-#include <asm/syscalls_64.h>
-#undef __SYSCALL_X32
-#undef __SYSCALL_COMMON
-
-#define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
-#define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,
-
-asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_x32_syscall_max] = &__x64_sys_ni_syscall,
-#include <asm/syscalls_64.h>
+asmlinkage const sys_call_ptr_t x32_sys_call_table[] = {
+#include <asm/syscalls_x32.h>
 };
diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index d8c4f6c9eadc..5b3efed0e4e8 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -9,47 +9,54 @@ _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)') \
 syscall32 := $(src)/syscall_32.tbl
 syscall64 := $(src)/syscall_64.tbl
 
-syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+syshdr := $(srctree)/scripts/syscallhdr.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
+offset :=
+prefix :=
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@' \
-		   '$(syshdr_abi_$(basetarget))' \
-		   '$(syshdr_pfx_$(basetarget))' \
-		   '$(syshdr_offset_$(basetarget))'
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --abis $(abis) --emit-nr \
+		$(if $(offset),--offset $(offset)) \
+		$(if $(prefix),--prefix $(prefix)) \
+		$< $@
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
 
 quiet_cmd_hypercalls = HYPERCALLS $@
       cmd_hypercalls = $(CONFIG_SHELL) '$<' $@ $(filter-out $<, $(real-prereqs))
 
-syshdr_abi_unistd_32 := i386
+$(uapi)/unistd_32.h: abis := i386
 $(uapi)/unistd_32.h: $(syscall32) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_32_ia32 := i386
-syshdr_pfx_unistd_32_ia32 := ia32_
+$(out)/unistd_32_ia32.h: abis := i386
+$(out)/unistd_32_ia32.h: prefix := ia32_
 $(out)/unistd_32_ia32.h: $(syscall32) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_x32 := common,x32
-syshdr_offset_unistd_x32 := __X32_SYSCALL_BIT
+$(uapi)/unistd_x32.h: abis := common,x32
+$(uapi)/unistd_x32.h: offset := __X32_SYSCALL_BIT
 $(uapi)/unistd_x32.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_64 := common,64
+$(uapi)/unistd_64.h: abis := common,64
 $(uapi)/unistd_64.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_64_x32 := x32
-syshdr_pfx_unistd_64_x32 := x32_
+$(out)/unistd_64_x32.h: abis := x32
+$(out)/unistd_64_x32.h: prefix := x32_
 $(out)/unistd_64_x32.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
+$(out)/syscalls_32.h: abis := i386
 $(out)/syscalls_32.h: $(syscall32) $(systbl) FORCE
 	$(call if_changed,systbl)
+$(out)/syscalls_64.h: abis := common,64
 $(out)/syscalls_64.h: $(syscall64) $(systbl) FORCE
 	$(call if_changed,systbl)
+$(out)/syscalls_x32.h: abis := common,x32
+$(out)/syscalls_x32.h: $(syscall64) $(systbl) FORCE
+	$(call if_changed,systbl)
 
 $(out)/xen-hypercalls.h: $(srctree)/scripts/xen-hypercalls.sh FORCE
 	$(call if_changed,hypercalls)
@@ -60,6 +67,7 @@ uapisyshdr-y			+= unistd_32.h unistd_64.h unistd_x32.h
 syshdr-y			+= syscalls_32.h
 syshdr-$(CONFIG_X86_64)		+= unistd_32_ia32.h unistd_64_x32.h
 syshdr-$(CONFIG_X86_64)		+= syscalls_64.h
+syshdr-$(CONFIG_X86_X32)	+= syscalls_x32.h
 syshdr-$(CONFIG_XEN)		+= xen-hypercalls.h
 
 uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
diff --git a/arch/x86/entry/syscalls/syscallhdr.sh b/arch/x86/entry/syscalls/syscallhdr.sh
deleted file mode 100644
index cc1e63857427..000000000000
--- a/arch/x86/entry/syscalls/syscallhdr.sh
+++ /dev/null
@@ -1,35 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-offset="$5"
-
-fileguard=_ASM_X86_`basename "$out" | sed \
-    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-    echo "#ifndef ${fileguard}"
-    echo "#define ${fileguard} 1"
-    echo ""
-
-    max=0
-    while read nr abi name entry ; do
-	if [ -z "$offset" ]; then
-	    echo "#define __NR_${prefix}${name} $nr"
-	else
-	    echo "#define __NR_${prefix}${name} ($offset + $nr)"
-        fi
-
-	max=$nr
-    done
-
-    echo ""
-    echo "#ifdef __KERNEL__"
-    echo "#define __NR_${prefix}syscall_max $max"
-    echo "#endif"
-    echo ""
-    echo "#endif /* ${fileguard} */"
-) > "$out"
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
deleted file mode 100644
index 929bde120d6b..000000000000
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-
-syscall_macro() {
-    local abi="$1"
-    local nr="$2"
-    local entry="$3"
-
-    echo "__SYSCALL_${abi}($nr, $entry)"
-}
-
-emit() {
-    local abi="$1"
-    local nr="$2"
-    local entry="$3"
-    local compat="$4"
-
-    if [ "$abi" != "I386" -a -n "$compat" ]; then
-	echo "a compat entry ($abi: $compat) for a 64-bit syscall makes no sense" >&2
-	exit 1
-    fi
-
-    if [ -z "$compat" ]; then
-	if [ -n "$entry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	fi
-    else
-	echo "#ifdef CONFIG_X86_32"
-	if [ -n "$entry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	fi
-	echo "#else"
-	syscall_macro "$abi" "$nr" "$compat"
-	echo "#endif"
-    fi
-}
-
-grep '^[0-9]' "$in" | sort -n | (
-    while read nr abi name entry compat; do
-	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
-	emit "$abi" "$nr" "$entry" "$compat"
-    done
-) > "$out"
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index b19ec8282d50..1e51650b79d7 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -3,6 +3,7 @@
 
 generated-y += syscalls_32.h
 generated-y += syscalls_64.h
+generated-y += syscalls_x32.h
 generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0603c7423aca..3ad3da9a7d97 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -3,25 +3,26 @@
 #define _ASM_X86_ASM_H
 
 #ifdef __ASSEMBLY__
-# define __ASM_FORM(x)	x
-# define __ASM_FORM_RAW(x)     x
-# define __ASM_FORM_COMMA(x) x,
+# define __ASM_FORM(x, ...)		x,## __VA_ARGS__
+# define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
+# define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
 #else
 #include <linux/stringify.h>
-
-# define __ASM_FORM(x)	" " __stringify(x) " "
-# define __ASM_FORM_RAW(x)     __stringify(x)
-# define __ASM_FORM_COMMA(x) " " __stringify(x) ","
+# define __ASM_FORM(x, ...)		" " __stringify(x,##__VA_ARGS__) " "
+# define __ASM_FORM_RAW(x, ...)		    __stringify(x,##__VA_ARGS__)
+# define __ASM_FORM_COMMA(x, ...)	" " __stringify(x,##__VA_ARGS__) ","
 #endif
 
+#define _ASM_BYTES(x, ...)	__ASM_FORM(.byte x,##__VA_ARGS__ ;)
+
 #ifndef __x86_64__
 /* 32 bit */
-# define __ASM_SEL(a,b) __ASM_FORM(a)
-# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(a)
+# define __ASM_SEL(a,b)		__ASM_FORM(a)
+# define __ASM_SEL_RAW(a,b)	__ASM_FORM_RAW(a)
 #else
 /* 64 bit */
-# define __ASM_SEL(a,b) __ASM_FORM(b)
-# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(b)
+# define __ASM_SEL(a,b)		__ASM_FORM(b)
+# define __ASM_SEL_RAW(a,b)	__ASM_FORM_RAW(b)
 #endif
 
 #define __ASM_SIZE(inst, ...)	__ASM_SEL(inst##l##__VA_ARGS__, \
@@ -119,6 +120,8 @@
 # define CC_OUT(c) [_cc_ ## c] "=qm"
 #endif
 
+#ifdef __KERNEL__
+
 /* Exception table entry */
 #ifdef __ASSEMBLY__
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
@@ -185,4 +188,6 @@ register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif /* __ASSEMBLY__ */
 
+#endif /* __KERNEL__ */
+
 #endif /* _ASM_X86_ASM_H */
diff --git a/arch/x86/include/asm/nops.h b/arch/x86/include/asm/nops.h
index c1e5e818ba16..c5573eaa5bb9 100644
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_NOPS_H
 #define _ASM_X86_NOPS_H
 
+#include <asm/asm.h>
+
 /*
  * Define nops for use with alternative() and for tracing.
  */
@@ -57,20 +59,14 @@
 
 #endif /* CONFIG_64BIT */
 
-#ifdef __ASSEMBLY__
-#define _ASM_MK_NOP(x) .byte x
-#else
-#define _ASM_MK_NOP(x) ".byte " __stringify(x) "\n"
-#endif
-
-#define ASM_NOP1 _ASM_MK_NOP(BYTES_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(BYTES_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(BYTES_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(BYTES_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(BYTES_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(BYTES_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(BYTES_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(BYTES_NOP8)
+#define ASM_NOP1 _ASM_BYTES(BYTES_NOP1)
+#define ASM_NOP2 _ASM_BYTES(BYTES_NOP2)
+#define ASM_NOP3 _ASM_BYTES(BYTES_NOP3)
+#define ASM_NOP4 _ASM_BYTES(BYTES_NOP4)
+#define ASM_NOP5 _ASM_BYTES(BYTES_NOP5)
+#define ASM_NOP6 _ASM_BYTES(BYTES_NOP6)
+#define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
+#define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
 #define ASM_NOP_MAX 8
 
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 7cbf733d11af..f7e2d82d24fb 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -21,13 +21,12 @@ extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
 #define ia32_sys_call_table sys_call_table
-#endif
-
-#if defined(CONFIG_IA32_EMULATION)
+#else
+/*
+ * These may not exist, but still put the prototypes in so we
+ * can use IS_ENABLED().
+ */
 extern const sys_call_ptr_t ia32_sys_call_table[];
-#endif
-
-#ifdef CONFIG_X86_X32_ABI
 extern const sys_call_ptr_t x32_sys_call_table[];
 #endif
 
@@ -160,7 +159,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
 
-void do_syscall_64(unsigned long nr, struct pt_regs *regs);
+void do_syscall_64(struct pt_regs *regs, int nr);
 void do_int80_syscall_32(struct pt_regs *regs);
 long do_fast_syscall_32(struct pt_regs *regs);
 
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 80c08c7d5e72..6a2827d0681f 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -17,7 +17,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * __x64_sys_*()         - 64-bit native syscall
  * __ia32_sys_*()        - 32-bit native syscall or common compat syscall
  * __ia32_compat_sys_*() - 32-bit compat syscall
- * __x32_compat_sys_*()  - 64-bit X32 compat syscall
+ * __x64_compat_sys_*()  - 64-bit X32 compat syscall
  *
  * The registers are decoded according to the ABI:
  * 64-bit: RDI, RSI, RDX, R10, R8, R9
@@ -166,17 +166,17 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * with x86_64 obviously do not need such care.
  */
 #define __X32_COMPAT_SYS_STUB0(name)					\
-	__SYS_STUB0(x32, compat_sys_##name)
+	__SYS_STUB0(x64, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
-	__SYS_STUBx(x32, compat_sys##name,				\
+	__SYS_STUBx(x64, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #define __X32_COMPAT_COND_SYSCALL(name)					\
-	__COND_SYSCALL(x32, compat_sys_##name)
+	__COND_SYSCALL(x64, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_NI(name)					\
-	__SYS_NI(x32, compat_sys_##name)
+	__SYS_NI(x64, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index c1c3d31b15c0..80e9d5206a71 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -13,7 +13,7 @@
 #  define __ARCH_WANT_SYS_OLD_MMAP
 #  define __ARCH_WANT_SYS_OLD_SELECT
 
-#  define __NR_ia32_syscall_max __NR_syscall_max
+#  define IA32_NR_syscalls (__NR_syscalls)
 
 # else
 
@@ -26,12 +26,12 @@
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
+#  define X32_NR_syscalls (__NR_x32_syscalls)
+#  define IA32_NR_syscalls (__NR_ia32_syscalls)
 
 # endif
 
-# define NR_syscalls (__NR_syscall_max + 1)
-# define X32_NR_syscalls (__NR_x32_syscall_max + 1)
-# define IA32_NR_syscalls (__NR_ia32_syscall_max + 1)
+# define NR_syscalls (__NR_syscalls)
 
 # define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a1b756c49a93..6cf697574661 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1773,10 +1773,16 @@ void syscall_init(void)
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
 #endif
 
-	/* Flags to clear on syscall */
+	/*
+	 * Flags to clear on syscall; clear as much as possible
+	 * to minimize user space-kernel interference.
+	 */
 	wrmsrl(MSR_SYSCALL_MASK,
-	       X86_EFLAGS_TF|X86_EFLAGS_DF|X86_EFLAGS_IF|
-	       X86_EFLAGS_IOPL|X86_EFLAGS_AC|X86_EFLAGS_NT);
+	       X86_EFLAGS_CF|X86_EFLAGS_PF|X86_EFLAGS_AF|
+	       X86_EFLAGS_ZF|X86_EFLAGS_SF|X86_EFLAGS_TF|
+	       X86_EFLAGS_IF|X86_EFLAGS_DF|X86_EFLAGS_OF|
+	       X86_EFLAGS_IOPL|X86_EFLAGS_NT|X86_EFLAGS_RF|
+	       X86_EFLAGS_AC|X86_EFLAGS_ID);
 }
 
 #else	/* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 04bddaaba8e2..d8b3ebd2bb85 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -62,7 +62,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 */
 
 	/* Set up the stack for verify_cpu(), similar to initial_stack below */
-	leaq	(__end_init_task - SIZEOF_PTREGS)(%rip), %rsp
+	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
 
 	leaq	_text(%rip), %rdi
 	pushq	%rsi
@@ -343,10 +343,10 @@ SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
 
 /*
- * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
+ * The FRAME_SIZE gap is a convention which helps the in-kernel unwinder
  * reliably detect the end of the stack.
  */
-SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - SIZEOF_PTREGS)
+SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
 	__FINITDATA
 
 	__INIT
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 87a4143aa7d7..4c208ea3bd9f 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -911,7 +911,7 @@ static int putreg32(struct task_struct *child, unsigned regno, u32 value)
 		 * syscall with TS_COMPAT still set.
 		 */
 		regs->orig_ax = value;
-		if (syscall_get_nr(child, regs) >= 0)
+		if (syscall_get_nr(child, regs) != -1)
 			child->thread_info.status |= TS_I386_REGS_POKED;
 		break;
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index a06cb107c0e8..e12779a2714d 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -713,7 +713,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
 
 	/* Are we from a system call? */
-	if (syscall_get_nr(current, regs) >= 0) {
+	if (syscall_get_nr(current, regs) != -1) {
 		/* If so, check system call restarting.. */
 		switch (syscall_get_error(current, regs)) {
 		case -ERESTART_RESTARTBLOCK:
@@ -793,7 +793,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
 	}
 
 	/* Did we come from a system call? */
-	if (syscall_get_nr(current, regs) >= 0) {
+	if (syscall_get_nr(current, regs) != -1) {
 		/* Restart the system call - no handlers present */
 		switch (syscall_get_error(current, regs)) {
 		case -ERESTARTNOHAND:
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 2ed81e581755..0575decb5e54 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -7,7 +7,6 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __NO_STUBS
@@ -26,20 +25,17 @@
 
 #define old_mmap sys_old_mmap
 
-#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+
+#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_32.h>
 
-#undef __SYSCALL_I386
-#define __SYSCALL_I386(nr, sym) [ nr ] = sym,
+#undef __SYSCALL
+#define __SYSCALL(nr, sym) sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
 const sys_call_ptr_t sys_call_table[] ____cacheline_aligned = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_max] = &sys_ni_syscall,
 #include <asm/syscalls_32.h>
 };
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 2e8544dafbb0..95725b5a41ac 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -7,7 +7,6 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __NO_STUBS
@@ -36,23 +35,15 @@
 #define stub_execveat sys_execveat
 #define stub_rt_sigreturn sys_rt_sigreturn
 
-#define __SYSCALL_X32(nr, sym)
-#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
-
-#define __SYSCALL_64(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_64.h>
 
-#undef __SYSCALL_64
-#define __SYSCALL_64(nr, sym) [ nr ] = sym,
+#undef __SYSCALL
+#define __SYSCALL(nr, sym) sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
 const sys_call_ptr_t sys_call_table[] ____cacheline_aligned = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_max] = &sys_ni_syscall,
 #include <asm/syscalls_64.h>
 };
 
diff --git a/tools/arch/x86/include/asm/asm.h b/tools/arch/x86/include/asm/asm.h
new file mode 100644
index 000000000000..3ad3da9a7d97
--- /dev/null
+++ b/tools/arch/x86/include/asm/asm.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ASM_H
+#define _ASM_X86_ASM_H
+
+#ifdef __ASSEMBLY__
+# define __ASM_FORM(x, ...)		x,## __VA_ARGS__
+# define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
+# define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
+#else
+#include <linux/stringify.h>
+# define __ASM_FORM(x, ...)		" " __stringify(x,##__VA_ARGS__) " "
+# define __ASM_FORM_RAW(x, ...)		    __stringify(x,##__VA_ARGS__)
+# define __ASM_FORM_COMMA(x, ...)	" " __stringify(x,##__VA_ARGS__) ","
+#endif
+
+#define _ASM_BYTES(x, ...)	__ASM_FORM(.byte x,##__VA_ARGS__ ;)
+
+#ifndef __x86_64__
+/* 32 bit */
+# define __ASM_SEL(a,b)		__ASM_FORM(a)
+# define __ASM_SEL_RAW(a,b)	__ASM_FORM_RAW(a)
+#else
+/* 64 bit */
+# define __ASM_SEL(a,b)		__ASM_FORM(b)
+# define __ASM_SEL_RAW(a,b)	__ASM_FORM_RAW(b)
+#endif
+
+#define __ASM_SIZE(inst, ...)	__ASM_SEL(inst##l##__VA_ARGS__, \
+					  inst##q##__VA_ARGS__)
+#define __ASM_REG(reg)         __ASM_SEL_RAW(e##reg, r##reg)
+
+#define _ASM_PTR	__ASM_SEL(.long, .quad)
+#define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)
+
+#define _ASM_MOV	__ASM_SIZE(mov)
+#define _ASM_INC	__ASM_SIZE(inc)
+#define _ASM_DEC	__ASM_SIZE(dec)
+#define _ASM_ADD	__ASM_SIZE(add)
+#define _ASM_SUB	__ASM_SIZE(sub)
+#define _ASM_XADD	__ASM_SIZE(xadd)
+#define _ASM_MUL	__ASM_SIZE(mul)
+
+#define _ASM_AX		__ASM_REG(ax)
+#define _ASM_BX		__ASM_REG(bx)
+#define _ASM_CX		__ASM_REG(cx)
+#define _ASM_DX		__ASM_REG(dx)
+#define _ASM_SP		__ASM_REG(sp)
+#define _ASM_BP		__ASM_REG(bp)
+#define _ASM_SI		__ASM_REG(si)
+#define _ASM_DI		__ASM_REG(di)
+
+#ifndef __x86_64__
+/* 32 bit */
+
+#define _ASM_ARG1	_ASM_AX
+#define _ASM_ARG2	_ASM_DX
+#define _ASM_ARG3	_ASM_CX
+
+#define _ASM_ARG1L	eax
+#define _ASM_ARG2L	edx
+#define _ASM_ARG3L	ecx
+
+#define _ASM_ARG1W	ax
+#define _ASM_ARG2W	dx
+#define _ASM_ARG3W	cx
+
+#define _ASM_ARG1B	al
+#define _ASM_ARG2B	dl
+#define _ASM_ARG3B	cl
+
+#else
+/* 64 bit */
+
+#define _ASM_ARG1	_ASM_DI
+#define _ASM_ARG2	_ASM_SI
+#define _ASM_ARG3	_ASM_DX
+#define _ASM_ARG4	_ASM_CX
+#define _ASM_ARG5	r8
+#define _ASM_ARG6	r9
+
+#define _ASM_ARG1Q	rdi
+#define _ASM_ARG2Q	rsi
+#define _ASM_ARG3Q	rdx
+#define _ASM_ARG4Q	rcx
+#define _ASM_ARG5Q	r8
+#define _ASM_ARG6Q	r9
+
+#define _ASM_ARG1L	edi
+#define _ASM_ARG2L	esi
+#define _ASM_ARG3L	edx
+#define _ASM_ARG4L	ecx
+#define _ASM_ARG5L	r8d
+#define _ASM_ARG6L	r9d
+
+#define _ASM_ARG1W	di
+#define _ASM_ARG2W	si
+#define _ASM_ARG3W	dx
+#define _ASM_ARG4W	cx
+#define _ASM_ARG5W	r8w
+#define _ASM_ARG6W	r9w
+
+#define _ASM_ARG1B	dil
+#define _ASM_ARG2B	sil
+#define _ASM_ARG3B	dl
+#define _ASM_ARG4B	cl
+#define _ASM_ARG5B	r8b
+#define _ASM_ARG6B	r9b
+
+#endif
+
+/*
+ * Macros to generate condition code outputs from inline assembly,
+ * The output operand must be type "bool".
+ */
+#ifdef __GCC_ASM_FLAG_OUTPUTS__
+# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
+# define CC_OUT(c) "=@cc" #c
+#else
+# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
+# define CC_OUT(c) [_cc_ ## c] "=qm"
+#endif
+
+#ifdef __KERNEL__
+
+/* Exception table entry */
+#ifdef __ASSEMBLY__
+# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+	.pushsection "__ex_table","a" ;				\
+	.balign 4 ;						\
+	.long (from) - . ;					\
+	.long (to) - . ;					\
+	.long (handler) - . ;					\
+	.popsection
+
+# define _ASM_EXTABLE(from, to)					\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
+
+# define _ASM_EXTABLE_UA(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+
+# define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
+# define _ASM_EXTABLE_FAULT(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
+
+# ifdef CONFIG_KPROBES
+#  define _ASM_NOKPROBE(entry)					\
+	.pushsection "_kprobe_blacklist","aw" ;			\
+	_ASM_ALIGN ;						\
+	_ASM_PTR (entry);					\
+	.popsection
+# else
+#  define _ASM_NOKPROBE(entry)
+# endif
+
+#else /* ! __ASSEMBLY__ */
+# define _EXPAND_EXTABLE_HANDLE(x) #x
+# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+	" .pushsection \"__ex_table\",\"a\"\n"			\
+	" .balign 4\n"						\
+	" .long (" #from ") - .\n"				\
+	" .long (" #to ") - .\n"				\
+	" .long (" _EXPAND_EXTABLE_HANDLE(handler) ") - .\n"	\
+	" .popsection\n"
+
+# define _ASM_EXTABLE(from, to)					\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
+
+# define _ASM_EXTABLE_UA(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+
+# define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
+# define _ASM_EXTABLE_FAULT(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
+
+/* For C file, we already have NOKPROBE_SYMBOL macro */
+
+/*
+ * This output constraint should be used for any inline asm which has a "call"
+ * instruction.  Otherwise the asm may be inserted before the frame pointer
+ * gets set up by the containing function.  If you forget to do this, objtool
+ * may print a "call without frame pointer save/setup" warning.
+ */
+register unsigned long current_stack_pointer asm(_ASM_SP);
+#define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_X86_ASM_H */
diff --git a/tools/arch/x86/include/asm/nops.h b/tools/arch/x86/include/asm/nops.h
index c1e5e818ba16..c5573eaa5bb9 100644
--- a/tools/arch/x86/include/asm/nops.h
+++ b/tools/arch/x86/include/asm/nops.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_NOPS_H
 #define _ASM_X86_NOPS_H
 
+#include <asm/asm.h>
+
 /*
  * Define nops for use with alternative() and for tracing.
  */
@@ -57,20 +59,14 @@
 
 #endif /* CONFIG_64BIT */
 
-#ifdef __ASSEMBLY__
-#define _ASM_MK_NOP(x) .byte x
-#else
-#define _ASM_MK_NOP(x) ".byte " __stringify(x) "\n"
-#endif
-
-#define ASM_NOP1 _ASM_MK_NOP(BYTES_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(BYTES_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(BYTES_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(BYTES_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(BYTES_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(BYTES_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(BYTES_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(BYTES_NOP8)
+#define ASM_NOP1 _ASM_BYTES(BYTES_NOP1)
+#define ASM_NOP2 _ASM_BYTES(BYTES_NOP2)
+#define ASM_NOP3 _ASM_BYTES(BYTES_NOP3)
+#define ASM_NOP4 _ASM_BYTES(BYTES_NOP4)
+#define ASM_NOP5 _ASM_BYTES(BYTES_NOP5)
+#define ASM_NOP6 _ASM_BYTES(BYTES_NOP6)
+#define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
+#define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
 #define ASM_NOP_MAX 8
 
diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index d6b09cb1aa2c..991591718bb0 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * syscall_arg_fault.c - tests faults 32-bit fast syscall stack args
+ * syscall_numbering.c - test calling the x86-64 kernel with various
+ * valid and invalid system call numbers.
+ *
  * Copyright (c) 2018 Andrew Lutomirski
  */
 
@@ -11,79 +13,470 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <unistd.h>
-#include <syscall.h>
+#include <string.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <signal.h>
+#include <sysexits.h>
 
-static int nerrs;
+#include <sys/ptrace.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
 
-#define X32_BIT 0x40000000UL
+#include <linux/ptrace.h>
 
-static void check_enosys(unsigned long nr, bool *ok)
+/* Common system call numbers */
+#define SYS_READ	  0
+#define SYS_WRITE	  1
+#define SYS_GETPID	 39
+/* x64-only system call numbers */
+#define X64_IOCTL	 16
+#define X64_READV	 19
+#define X64_WRITEV	 20
+/* x32-only system call numbers (without X32_BIT) */
+#define X32_IOCTL	514
+#define X32_READV	515
+#define X32_WRITEV	516
+
+#define X32_BIT 0x40000000
+
+static int nullfd = -1;		/* File descriptor for /dev/null */
+static bool with_x32;		/* x32 supported on this kernel? */
+
+enum ptrace_pass {
+	PTP_NOTHING,
+	PTP_GETREGS,
+	PTP_WRITEBACK,
+	PTP_FUZZRET,
+	PTP_FUZZHIGH,
+	PTP_INTNUM,
+	PTP_DONE
+};
+
+static const char * const ptrace_pass_name[] =
 {
-	/* If this fails, a segfault is reasonably likely. */
-	fflush(stdout);
+	[PTP_NOTHING]	= "just stop, no data read",
+	[PTP_GETREGS]	= "only getregs",
+	[PTP_WRITEBACK]	= "getregs, unmodified setregs",
+	[PTP_FUZZRET]	= "modifying the default return",
+	[PTP_FUZZHIGH]	= "clobbering the top 32 bits",
+	[PTP_INTNUM]	= "sign-extending the syscall number",
+};
 
-	long ret = syscall(nr, 0, 0, 0, 0, 0, 0);
-	if (ret == 0) {
-		printf("[FAIL]\tsyscall %lu succeeded, but it should have failed\n", nr);
-		*ok = false;
-	} else if (errno != ENOSYS) {
-		printf("[FAIL]\tsyscall %lu had error code %d, but it should have reported ENOSYS\n", nr, errno);
-		*ok = false;
-	}
+/*
+ * Shared memory block between tracer and test
+ */
+struct shared {
+	unsigned int nerr;	/* Total error count */
+	unsigned int indent;	/* Message indentation level */
+	enum ptrace_pass ptrace_pass;
+	bool probing_syscall;	/* In probe_syscall() */
+};
+static volatile struct shared *sh;
+
+static inline unsigned int offset(void)
+{
+	unsigned int level = sh ? sh->indent : 0;
+
+	return 8 + level * 4;
 }
 
-static void test_x32_without_x32_bit(void)
+#define msg(lvl, fmt, ...) printf("%-*s" fmt, offset(), "[" #lvl "]", \
+				  ## __VA_ARGS__)
+
+#define run(fmt, ...)  msg(RUN,  fmt, ## __VA_ARGS__)
+#define info(fmt, ...) msg(INFO, fmt, ## __VA_ARGS__)
+#define ok(fmt, ...)   msg(OK,   fmt, ## __VA_ARGS__)
+
+#define fail(fmt, ...)					\
+	do {						\
+		msg(FAIL, fmt, ## __VA_ARGS__);		\
+		sh->nerr++;				\
+       } while (0)
+
+#define crit(fmt, ...)					\
+	do {						\
+		sh->indent = 0;				\
+		msg(FAIL, fmt, ## __VA_ARGS__);		\
+		msg(SKIP, "Unable to run test\n");	\
+		exit(EX_OSERR);				\
+       } while (0)
+
+/* Sentinel for ptrace-modified return value */
+#define MODIFIED_BY_PTRACE	-9999
+
+/*
+ * Directly invokes the given syscall with nullfd as the first argument
+ * and the rest zero. Avoids involving glibc wrappers in case they ever
+ * end up intercepting some system calls for some reason, or modify
+ * the system call number itself.
+ */
+static long long probe_syscall(int msb, int lsb)
 {
-	bool ok = true;
+	register long long arg1 asm("rdi") = nullfd;
+	register long long arg2 asm("rsi") = 0;
+	register long long arg3 asm("rdx") = 0;
+	register long long arg4 asm("r10") = 0;
+	register long long arg5 asm("r8")  = 0;
+	register long long arg6 asm("r9")  = 0;
+	long long nr = ((long long)msb << 32) | (unsigned int)lsb;
+	long long ret;
 
 	/*
-	 * Syscalls 512-547 are "x32" syscalls.  They are intended to be
-	 * called with the x32 (0x40000000) bit set.  Calling them without
-	 * the x32 bit set is nonsense and should not work.
+	 * We pass in an extra copy of the extended system call number
+	 * in %rbx, so we can examine it from the ptrace handler without
+	 * worrying about it being possibly modified. This is to test
+	 * the validity of struct user regs.orig_rax a.k.a.
+	 * struct pt_regs.orig_ax.
 	 */
-	printf("[RUN]\tChecking syscalls 512-547\n");
-	for (int i = 512; i <= 547; i++)
-		check_enosys(i, &ok);
+	sh->probing_syscall = true;
+	asm volatile("syscall"
+		     : "=a" (ret)
+		     : "a" (nr), "b" (nr),
+		       "r" (arg1), "r" (arg2), "r" (arg3),
+		       "r" (arg4), "r" (arg5), "r" (arg6)
+		     : "rcx", "r11", "memory", "cc");
+	sh->probing_syscall = false;
+
+	return ret;
+}
+
+static const char *syscall_str(int msb, int start, int end)
+{
+	static char buf[64];
+	const char * const type = (start & X32_BIT) ? "x32" : "x64";
+	int lsb = start;
 
 	/*
-	 * Check that a handful of 64-bit-only syscalls are rejected if the x32
-	 * bit is set.
+	 * Improve readability by stripping the x32 bit, but round
+	 * toward zero so we don't display -1 as -1073741825.
 	 */
-	printf("[RUN]\tChecking some 64-bit syscalls in x32 range\n");
-	check_enosys(16 | X32_BIT, &ok);	/* ioctl */
-	check_enosys(19 | X32_BIT, &ok);	/* readv */
-	check_enosys(20 | X32_BIT, &ok);	/* writev */
+	if (lsb < 0)
+		lsb |= X32_BIT;
+	else
+		lsb &= ~X32_BIT;
+
+	if (start == end)
+		snprintf(buf, sizeof buf, "%s syscall %d:%d",
+			 type, msb, lsb);
+	else
+		snprintf(buf, sizeof buf, "%s syscalls %d:%d..%d",
+			 type, msb, lsb, lsb + (end-start));
+
+	return buf;
+}
+
+static unsigned int _check_for(int msb, int start, int end, long long expect,
+			       const char *expect_str)
+{
+	unsigned int err = 0;
+
+	sh->indent++;
+	if (start != end)
+		sh->indent++;
+
+	for (int nr = start; nr <= end; nr++) {
+		long long ret = probe_syscall(msb, nr);
+
+		if (ret != expect) {
+			fail("%s returned %lld, but it should have returned %s\n",
+			       syscall_str(msb, nr, nr),
+			       ret, expect_str);
+			err++;
+		}
+	}
+
+	if (start != end)
+		sh->indent--;
+
+	if (err) {
+		if (start != end)
+			fail("%s had %u failure%s\n",
+			     syscall_str(msb, start, end),
+			     err, err == 1 ? "s" : "");
+	} else {
+		ok("%s returned %s as expected\n",
+		   syscall_str(msb, start, end), expect_str);
+	}
+
+	sh->indent--;
+
+	return err;
+}
+
+#define check_for(msb,start,end,expect) \
+	_check_for(msb,start,end,expect,#expect)
+
+static bool check_zero(int msb, int nr)
+{
+	return check_for(msb, nr, nr, 0);
+}
+
+static bool check_enosys(int msb, int nr)
+{
+	return check_for(msb, nr, nr, -ENOSYS);
+}
+
+/*
+ * Anyone diagnosing a failure will want to know whether the kernel
+ * supports x32. Tell them. This can also be used to conditionalize
+ * tests based on existence or nonexistence of x32.
+ */
+static bool test_x32(void)
+{
+	long long ret;
+	pid_t mypid = getpid();
+
+	run("Checking for x32 by calling x32 getpid()\n");
+	ret = probe_syscall(0, SYS_GETPID | X32_BIT);
+
+	sh->indent++;
+	if (ret == mypid) {
+		info("x32 is supported\n");
+		with_x32 = true;
+	} else if (ret == -ENOSYS) {
+		info("x32 is not supported\n");
+		with_x32 = false;
+	} else {
+		fail("x32 getpid() returned %lld, but it should have returned either %lld or -ENOSYS\n", ret, (long long)mypid);
+		with_x32 = false;
+	}
+	sh->indent--;
+	return with_x32;
+}
+
+static void test_syscalls_common(int msb)
+{
+	enum ptrace_pass pass = sh->ptrace_pass;
+
+	run("Checking some common syscalls as 64 bit\n");
+	check_zero(msb, SYS_READ);
+	check_zero(msb, SYS_WRITE);
+
+	run("Checking some 64-bit only syscalls as 64 bit\n");
+	check_zero(msb, X64_READV);
+	check_zero(msb, X64_WRITEV);
+
+	run("Checking out of range system calls\n");
+	check_for(msb, -64, -2, -ENOSYS);
+	if (pass >= PTP_FUZZRET)
+		check_for(msb, -1, -1, MODIFIED_BY_PTRACE);
+	else
+		check_for(msb, -1, -1, -ENOSYS);
+	check_for(msb, X32_BIT-64, X32_BIT-1, -ENOSYS);
+	check_for(msb, -64-X32_BIT, -1-X32_BIT, -ENOSYS);
+	check_for(msb, INT_MAX-64, INT_MAX-1, -ENOSYS);
+}
 
+static void test_syscalls_with_x32(int msb)
+{
 	/*
-	 * Check some syscalls with high bits set.
+	 * Syscalls 512-547 are "x32" syscalls.  They are
+	 * intended to be called with the x32 (0x40000000) bit
+	 * set.  Calling them without the x32 bit set is
+	 * nonsense and should not work.
 	 */
-	printf("[RUN]\tChecking numbers above 2^32-1\n");
-	check_enosys((1UL << 32), &ok);
-	check_enosys(X32_BIT | (1UL << 32), &ok);
+	run("Checking x32 syscalls as 64 bit\n");
+	check_for(msb, 512, 547, -ENOSYS);
 
-	if (!ok)
-		nerrs++;
-	else
-		printf("[OK]\tThey all returned -ENOSYS\n");
+	run("Checking some common syscalls as x32\n");
+	check_zero(msb, SYS_READ   | X32_BIT);
+	check_zero(msb, SYS_WRITE  | X32_BIT);
+
+	run("Checking some x32 syscalls as x32\n");
+	check_zero(msb, X32_READV  | X32_BIT);
+	check_zero(msb, X32_WRITEV | X32_BIT);
+
+	run("Checking some 64-bit syscalls as x32\n");
+	check_enosys(msb, X64_IOCTL  | X32_BIT);
+	check_enosys(msb, X64_READV  | X32_BIT);
+	check_enosys(msb, X64_WRITEV | X32_BIT);
 }
 
-int main()
+static void test_syscalls_without_x32(int msb)
 {
+	run("Checking for absence of x32 system calls\n");
+	check_for(msb, 0 | X32_BIT, 999 | X32_BIT, -ENOSYS);
+}
+
+static void test_syscall_numbering(void)
+{
+	static const int msbs[] = {
+		0, 1, -1, X32_BIT-1, X32_BIT, X32_BIT-1, -X32_BIT, INT_MAX,
+		INT_MIN, INT_MIN+1
+	};
+
+	sh->indent++;
+
 	/*
-	 * Anyone diagnosing a failure will want to know whether the kernel
-	 * supports x32.  Tell them.
+	 * The MSB is supposed to be ignored, so we loop over a few
+	 * to test that out.
 	 */
-	printf("\tChecking for x32...");
-	fflush(stdout);
-	if (syscall(39 | X32_BIT, 0, 0, 0, 0, 0, 0) >= 0) {
-		printf(" supported\n");
-	} else if (errno == ENOSYS) {
-		printf(" not supported\n");
+	for (size_t i = 0; i < sizeof(msbs)/sizeof(msbs[0]); i++) {
+		int msb = msbs[i];
+		run("Checking system calls with msb = %d (0x%x)\n",
+		    msb, msb);
+
+		sh->indent++;
+
+		test_syscalls_common(msb);
+		if (with_x32)
+			test_syscalls_with_x32(msb);
+		else
+			test_syscalls_without_x32(msb);
+
+		sh->indent--;
+	}
+
+	sh->indent--;
+}
+
+static void syscall_numbering_tracee(void)
+{
+	enum ptrace_pass pass;
+
+	if (ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+		crit("Failed to request tracing\n");
+		return;
+	}
+	raise(SIGSTOP);
+
+	for (sh->ptrace_pass = pass = PTP_NOTHING; pass < PTP_DONE;
+	     sh->ptrace_pass = ++pass) {
+		run("Running tests under ptrace: %s\n", ptrace_pass_name[pass]);
+		test_syscall_numbering();
+	}
+}
+
+static void mess_with_syscall(pid_t testpid, enum ptrace_pass pass)
+{
+	struct user_regs_struct regs;
+
+	sh->probing_syscall = false; /* Do this on entry only */
+
+	/* For these, don't even getregs */
+	if (pass == PTP_NOTHING || pass == PTP_DONE)
+		return;
+
+	ptrace(PTRACE_GETREGS, testpid, NULL, &regs);
+
+	if (regs.orig_rax != regs.rbx) {
+		fail("orig_rax %#llx doesn't match syscall number %#llx\n",
+		     (unsigned long long)regs.orig_rax,
+		     (unsigned long long)regs.rbx);
+	}
+
+	switch (pass) {
+	case PTP_GETREGS:
+		/* Just read, no writeback */
+		return;
+	case PTP_WRITEBACK:
+		/* Write back the same register state verbatim */
+		break;
+	case PTP_FUZZRET:
+		regs.rax = MODIFIED_BY_PTRACE;
+		break;
+	case PTP_FUZZHIGH:
+		regs.rax = MODIFIED_BY_PTRACE;
+		regs.orig_rax = regs.orig_rax | 0xffffffff00000000ULL;
+		break;
+	case PTP_INTNUM:
+		regs.rax = MODIFIED_BY_PTRACE;
+		regs.orig_rax = (int)regs.orig_rax;
+		break;
+	default:
+		crit("invalid ptrace_pass\n");
+		break;
+	}
+
+	ptrace(PTRACE_SETREGS, testpid, NULL, &regs);
+}
+
+static void syscall_numbering_tracer(pid_t testpid)
+{
+	int wstatus;
+
+	do {
+		pid_t wpid = waitpid(testpid, &wstatus, 0);
+		if (wpid < 0 && errno != EINTR)
+			break;
+		if (wpid != testpid)
+			continue;
+		if (!WIFSTOPPED(wstatus))
+			break;	/* Thread exited? */
+
+		if (sh->probing_syscall && WSTOPSIG(wstatus) == SIGTRAP)
+			mess_with_syscall(testpid, sh->ptrace_pass);
+	} while (sh->ptrace_pass != PTP_DONE &&
+		 !ptrace(PTRACE_SYSCALL, testpid, NULL, NULL));
+
+	ptrace(PTRACE_DETACH, testpid, NULL, NULL);
+
+	/* Wait for the child process to terminate */
+	while (waitpid(testpid, &wstatus, 0) != testpid || !WIFEXITED(wstatus))
+		/* wait some more */;
+}
+
+static void test_traced_syscall_numbering(void)
+{
+	pid_t testpid;
+
+	/* Launch the test thread; this thread continues as the tracer thread */
+	testpid = fork();
+
+	if (testpid < 0) {
+		crit("Unable to launch tracer process\n");
+	} else if (testpid == 0) {
+		syscall_numbering_tracee();
+		_exit(0);
 	} else {
-		printf(" confused\n");
+		syscall_numbering_tracer(testpid);
 	}
+}
 
-	test_x32_without_x32_bit();
+int main(void)
+{
+	unsigned int nerr;
 
-	return nerrs ? 1 : 0;
+	/*
+	 * It is quite likely to get a segfault on a failure, so make
+	 * sure the message gets out by setting stdout to nonbuffered.
+	 */
+	setvbuf(stdout, NULL, _IONBF, 0);
+
+	/*
+	 * Harmless file descriptor to work on...
+	 */
+	nullfd = open("/dev/null", O_RDWR);
+	if (nullfd < 0) {
+		crit("Unable to open /dev/null: %s\n", strerror(errno));
+	}
+
+	/*
+	 * Set up a block of shared memory...
+	 */
+	sh = mmap(NULL, sysconf(_SC_PAGE_SIZE), PROT_READ|PROT_WRITE,
+		  MAP_ANONYMOUS|MAP_SHARED, 0, 0);
+	if (sh == MAP_FAILED) {
+		crit("Unable to allocated shared memory block: %s\n",
+		     strerror(errno));
+	}
+
+	with_x32 = test_x32();
+
+	run("Running tests without ptrace...\n");
+	test_syscall_numbering();
+
+	test_traced_syscall_numbering();
+
+	nerr = sh->nerr;
+	if (!nerr) {
+		ok("All system calls succeeded or failed as expected\n");
+		return 0;
+	} else {
+		fail("A total of %u system call%s had incorrect behavior\n",
+		     nerr, nerr != 1 ? "s" : "");
+		return 1;
+	}
 }

