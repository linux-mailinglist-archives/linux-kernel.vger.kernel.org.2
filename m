Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952A736B2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhDZMVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:21:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbhDZMVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:21:41 -0400
Date:   Mon, 26 Apr 2021 12:17:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619439658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=708Z13jq4pu5QVOje9qO4urlU/2ALtRb19OY1U/m3lU=;
        b=onSTVmgorRx2+e7su3EGJIdUutYJKLs/FUAUa1NBIIwqPs8GcZRC1nrRDqlrFuTMgIvyAV
        aaJ4LxxXqUbRsB8Ui2+Ya5tASOT/0f+IvWzNz+Fas8DBOMDp42otFQvGQ/pYsGVVpEp+JJ
        wYCSJ33q4hZmUzelk+WZLTrOjU1Y0XgRTLLPZCkjzVrnzTecx9gszsnLqNuGASnX9AXRgo
        nNBLdpEYEpRgiRQye8WGrjXHTnRP8mOWVnd1pt98aaoqWGx72wUQmGN4f/PHclzUJCRHTk
        /oCNHqnQDx60Zx0P50PgEJt+D38lDLm89CqI1a6F9hNWABASFttLEpkK9wJ9kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619439658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=708Z13jq4pu5QVOje9qO4urlU/2ALtRb19OY1U/m3lU=;
        b=2IX8CPuKbwrwOmmSOHag+bO450UNKS20MrqudanCjiX5pVRMGHjuxJN/sR0Qvz64GleZ9O
        Czcu7wJq7BC/9+AA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/entry for v5.13-rc1
References: <161943945302.1498.9201552430413038175.tglx@nanos>
Message-ID: <161943945423.1498.14173718925126273942.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2021-04-26

up to:  70918779aec9: arm64: entry: Enable random_kstack_offset support


Entry code update:

 Provide support for randomized stack offsets per syscall to make
 stack-based attacks harder which rely on the deterministic stack layout.

 The feature is based on the original idea of PaX's RANDSTACK feature, but
 uses a significantly different implementation.

 The offset does not affect the pt_regs location on the task stack as this
 was agreed on to be of dubious value. The offset is applied before the
 actual syscall is invoked.

 The offset is stored per cpu and the randomization happens at the end of
 the syscall which is less predictable than on syscall entry.

 The mechanism to apply the offset is via alloca(), i.e. abusing the
 dispised VLAs. This comes with the drawback that stack-clash-protection
 has to be disabled for the affected compilation units and there is also
 a negative interaction with stack-protector.

 Those downsides are traded with the advantage that this approach does not
 require any intrusive changes to the low level assembly entry code, does
 not affect the unwinder and the correct stack alignment is handled
 automatically by the compiler.

 The feature is guarded with a static branch which avoids the overhead when
 disabled.

 Currently this is supported for X86 and ARM64.


 

Thanks,

	tglx

------------------>
Kees Cook (6):
      jump_label: Provide CONFIG-driven build state defaults
      init_on_alloc: Optimize static branches
      stack: Optionally randomize kernel stack offset each syscall
      x86/entry: Enable random_kstack_offset support
      lkdtm: Add REPORT_STACK for checking stack offsets
      arm64: entry: Enable random_kstack_offset support


 Documentation/admin-guide/kernel-parameters.txt | 11 +++++
 Makefile                                        |  4 ++
 arch/Kconfig                                    | 23 +++++++++++
 arch/arm64/Kconfig                              |  1 +
 arch/arm64/kernel/Makefile                      |  5 +++
 arch/arm64/kernel/syscall.c                     | 16 ++++++++
 arch/x86/Kconfig                                |  1 +
 arch/x86/entry/common.c                         |  3 ++
 arch/x86/include/asm/entry-common.h             | 16 ++++++++
 drivers/misc/lkdtm/bugs.c                       | 17 ++++++++
 drivers/misc/lkdtm/core.c                       |  1 +
 drivers/misc/lkdtm/lkdtm.h                      |  1 +
 include/linux/jump_label.h                      | 19 +++++++++
 include/linux/mm.h                              | 10 +++--
 include/linux/randomize_kstack.h                | 54 +++++++++++++++++++++++++
 init/main.c                                     | 23 +++++++++++
 mm/page_alloc.c                                 |  4 +-
 mm/slab.h                                       |  6 ++-
 tools/testing/selftests/lkdtm/.gitignore        |  1 +
 tools/testing/selftests/lkdtm/Makefile          |  1 +
 tools/testing/selftests/lkdtm/stack-entropy.sh  | 36 +++++++++++++++++
 21 files changed, 245 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/randomize_kstack.h
 create mode 100755 tools/testing/selftests/lkdtm/stack-entropy.sh

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..bee8644a192e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4061,6 +4061,17 @@
 			fully seed the kernel's CRNG. Default is controlled
 			by CONFIG_RANDOM_TRUST_CPU.
 
+	randomize_kstack_offset=
+			[KNL] Enable or disable kernel stack offset
+			randomization, which provides roughly 5 bits of
+			entropy, frustrating memory corruption attacks
+			that depend on stack address determinism or
+			cross-syscall address exposures. This is only
+			available on architectures that have defined
+			CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET.
+			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
+			Default is CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT.
+
 	ras=option[,option,...]	[KNL] RAS-specific options
 
 		cec_disable	[X86]
diff --git a/Makefile b/Makefile
index cc77fd45ca64..d3bf50326d69 100644
--- a/Makefile
+++ b/Makefile
@@ -813,6 +813,10 @@ KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero
 KBUILD_CFLAGS	+= -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
 endif
 
+# While VLAs have been removed, GCC produces unreachable stack probes
+# for the randomize_kstack_offset feature. Disable it for all compilers.
+KBUILD_CFLAGS	+= $(call cc-option, -fno-stack-clash-protection)
+
 DEBUG_CFLAGS	:=
 
 # Workaround for GCC versions < 5.0
diff --git a/arch/Kconfig b/arch/Kconfig
index ecfd3520b676..6b11c825fc36 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1054,6 +1054,29 @@ config VMAP_STACK
 	  backing virtual mappings with real shadow memory, and KASAN_VMALLOC
 	  must be enabled.
 
+config HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+	def_bool n
+	help
+	  An arch should select this symbol if it can support kernel stack
+	  offset randomization with calls to add_random_kstack_offset()
+	  during syscall entry and choose_random_kstack_offset() during
+	  syscall exit. Careful removal of -fstack-protector-strong and
+	  -fstack-protector should also be applied to the entry code and
+	  closely examined, as the artificial stack bump looks like an array
+	  to the compiler, so it will attempt to add canary checks regardless
+	  of the static branch state.
+
+config RANDOMIZE_KSTACK_OFFSET_DEFAULT
+	bool "Randomize kernel stack offset on syscall entry"
+	depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+	help
+	  The kernel stack offset can be randomized (after pt_regs) by
+	  roughly 5 bits of entropy, frustrating memory corruption
+	  attacks that depend on stack address determinism or
+	  cross-syscall address exposures. This feature is controlled
+	  by kernel boot param "randomize_kstack_offset=on/off", and this
+	  config chooses the default boot state.
+
 config ARCH_OPTIONAL_KERNEL_RWX
 	def_bool n
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e4e1b6550115..4640d2553b47 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -146,6 +146,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_PREL32_RELOCATIONS
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ed65576ce710..6cc97730790e 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -9,6 +9,11 @@ CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 
+# Remove stack protector to avoid triggering unneeded stack canary
+# checks due to randomize_kstack_offset.
+CFLAGS_REMOVE_syscall.o	 = -fstack-protector -fstack-protector-strong
+CFLAGS_syscall.o	+= -fno-stack-protector
+
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-common.o entry-fpsimd.o process.o ptrace.o	\
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index b9cf12b271d7..263d6c1a525f 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
+#include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
 
 #include <asm/daifflags.h>
@@ -43,6 +44,8 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 {
 	long ret;
 
+	add_random_kstack_offset();
+
 	if (scno < sc_nr) {
 		syscall_fn_t syscall_fn;
 		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
@@ -55,6 +58,19 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 		ret = lower_32_bits(ret);
 
 	regs->regs[0] = ret;
+
+	/*
+	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
+	 * but not enough for arm64 stack utilization comfort. To keep
+	 * reasonable stack head room, reduce the maximum offset to 9 bits.
+	 *
+	 * The actual entropy will be further reduced by the compiler when
+	 * applying stack alignment constraints: the AAPCS mandates a
+	 * 16-byte (i.e. 4-bit) aligned SP at function boundaries.
+	 *
+	 * The resulting 5 bits of entropy is seen in SP[8:4].
+	 */
+	choose_random_kstack_offset(get_random_int() & 0x1FF);
 }
 
 static inline bool has_syscall_work(unsigned long flags)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..4b4ad8ec10d2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -165,6 +165,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK		if X86_64
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 4efd39aacb9f..7b2542b13ebd 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -38,6 +38,7 @@
 #ifdef CONFIG_X86_64
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
+	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	instrumentation_begin();
@@ -83,6 +84,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
 	unsigned int nr = syscall_32_enter(regs);
 
+	add_random_kstack_offset();
 	/*
 	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
 	 * orig_ax, the unsigned int return value truncates it.  This may
@@ -102,6 +104,7 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	unsigned int nr = syscall_32_enter(regs);
 	int res;
 
+	add_random_kstack_offset();
 	/*
 	 * This cannot use syscall_enter_from_user_mode() as it has to
 	 * fetch EBP before invoking any of the syscall entry work
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 2b87b191b3b8..14ebd2196569 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_ENTRY_COMMON_H
 #define _ASM_X86_ENTRY_COMMON_H
 
+#include <linux/randomize_kstack.h>
 #include <linux/user-return-notifier.h>
 
 #include <asm/nospec-branch.h>
@@ -70,6 +71,21 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	 */
 	current_thread_info()->status &= ~(TS_COMPAT | TS_I386_REGS_POKED);
 #endif
+
+	/*
+	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
+	 * but not enough for x86 stack utilization comfort. To keep
+	 * reasonable stack head room, reduce the maximum offset to 8 bits.
+	 *
+	 * The actual entropy will be further reduced by the compiler when
+	 * applying stack alignment constraints (see cc_stack_align4/8 in
+	 * arch/x86/Makefile), which will remove the 3 (x86_64) or 2 (ia32)
+	 * low bits from any entropy chosen here.
+	 *
+	 * Therefore, final stack offset entropy will be 5 (x86_64) or
+	 * 6 (ia32) bits.
+	 */
+	choose_random_kstack_offset(rdtsc() & 0xFF);
 }
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 110f5a8538e9..0e8254d0cf0b 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -134,6 +134,23 @@ noinline void lkdtm_CORRUPT_STACK_STRONG(void)
 	__lkdtm_CORRUPT_STACK((void *)&data);
 }
 
+static pid_t stack_pid;
+static unsigned long stack_addr;
+
+void lkdtm_REPORT_STACK(void)
+{
+	volatile uintptr_t magic;
+	pid_t pid = task_pid_nr(current);
+
+	if (pid != stack_pid) {
+		pr_info("Starting stack offset tracking for pid %d\n", pid);
+		stack_pid = pid;
+		stack_addr = (uintptr_t)&magic;
+	}
+
+	pr_info("Stack offset: %d\n", (int)(stack_addr - (uintptr_t)&magic));
+}
+
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
 {
 	static u8 data[5] __attribute__((aligned(4))) = {1, 2, 3, 4, 5};
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index b2aff4d87c01..8024b6a5cc7f 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -110,6 +110,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(EXHAUST_STACK),
 	CRASHTYPE(CORRUPT_STACK),
 	CRASHTYPE(CORRUPT_STACK_STRONG),
+	CRASHTYPE(REPORT_STACK),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 5ae48c64df24..99f90d3e5e9c 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -17,6 +17,7 @@ void lkdtm_LOOP(void);
 void lkdtm_EXHAUST_STACK(void);
 void lkdtm_CORRUPT_STACK(void);
 void lkdtm_CORRUPT_STACK_STRONG(void);
+void lkdtm_REPORT_STACK(void);
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void);
 void lkdtm_SOFTLOCKUP(void);
 void lkdtm_HARDLOCKUP(void);
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index d92691262f51..05f5554d860f 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -382,6 +382,21 @@ struct static_key_false {
 		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
 	}
 
+#define _DEFINE_STATIC_KEY_1(name)	DEFINE_STATIC_KEY_TRUE(name)
+#define _DEFINE_STATIC_KEY_0(name)	DEFINE_STATIC_KEY_FALSE(name)
+#define DEFINE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
+#define _DEFINE_STATIC_KEY_RO_1(name)	DEFINE_STATIC_KEY_TRUE_RO(name)
+#define _DEFINE_STATIC_KEY_RO_0(name)	DEFINE_STATIC_KEY_FALSE_RO(name)
+#define DEFINE_STATIC_KEY_MAYBE_RO(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_RO_, IS_ENABLED(cfg))(name)
+
+#define _DECLARE_STATIC_KEY_1(name)	DECLARE_STATIC_KEY_TRUE(name)
+#define _DECLARE_STATIC_KEY_0(name)	DECLARE_STATIC_KEY_FALSE(name)
+#define DECLARE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DECLARE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
 extern bool ____wrong_branch_error(void);
 
 #define static_key_enabled(x)							\
@@ -482,6 +497,10 @@ extern bool ____wrong_branch_error(void);
 
 #endif /* CONFIG_JUMP_LABEL */
 
+#define static_branch_maybe(config, x)					\
+	(IS_ENABLED(config) ? static_branch_likely(x)			\
+			    : static_branch_unlikely(x))
+
 /*
  * Advanced usage; refcount, branch is enabled when: count != 0
  */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ba434287387..616dcaf08d99 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2904,18 +2904,20 @@ static inline void kernel_poison_pages(struct page *page, int numpages) { }
 static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
 #endif
 
-DECLARE_STATIC_KEY_FALSE(init_on_alloc);
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
-	if (static_branch_unlikely(&init_on_alloc))
+	if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				&init_on_alloc))
 		return true;
 	return flags & __GFP_ZERO;
 }
 
-DECLARE_STATIC_KEY_FALSE(init_on_free);
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
-	return static_branch_unlikely(&init_on_free);
+	return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
+				   &init_on_free);
 }
 
 extern bool _debug_pagealloc_enabled_early;
diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
new file mode 100644
index 000000000000..fd80fab663a9
--- /dev/null
+++ b/include/linux/randomize_kstack.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_RANDOMIZE_KSTACK_H
+#define _LINUX_RANDOMIZE_KSTACK_H
+
+#include <linux/kernel.h>
+#include <linux/jump_label.h>
+#include <linux/percpu-defs.h>
+
+DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
+			 randomize_kstack_offset);
+DECLARE_PER_CPU(u32, kstack_offset);
+
+/*
+ * Do not use this anywhere else in the kernel. This is used here because
+ * it provides an arch-agnostic way to grow the stack with correct
+ * alignment. Also, since this use is being explicitly masked to a max of
+ * 10 bits, stack-clash style attacks are unlikely. For more details see
+ * "VLAs" in Documentation/process/deprecated.rst
+ */
+void *__builtin_alloca(size_t size);
+/*
+ * Use, at most, 10 bits of entropy. We explicitly cap this to keep the
+ * "VLA" from being unbounded (see above). 10 bits leaves enough room for
+ * per-arch offset masks to reduce entropy (by removing higher bits, since
+ * high entropy may overly constrain usable stack space), and for
+ * compiler/arch-specific stack alignment to remove the lower bits.
+ */
+#define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
+
+/*
+ * These macros must be used during syscall entry when interrupts and
+ * preempt are disabled, and after user registers have been stored to
+ * the stack.
+ */
+#define add_random_kstack_offset() do {					\
+	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
+				&randomize_kstack_offset)) {		\
+		u32 offset = raw_cpu_read(kstack_offset);		\
+		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
+		/* Keep allocation even after "ptr" loses scope. */	\
+		asm volatile("" : "=o"(*ptr) :: "memory");		\
+	}								\
+} while (0)
+
+#define choose_random_kstack_offset(rand) do {				\
+	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
+				&randomize_kstack_offset)) {		\
+		u32 offset = raw_cpu_read(kstack_offset);		\
+		offset ^= (rand);					\
+		raw_cpu_write(kstack_offset, offset);			\
+	}								\
+} while (0)
+
+#endif
diff --git a/init/main.c b/init/main.c
index 53b278845b88..f498aac26e8c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -844,6 +844,29 @@ static void __init mm_init(void)
 	pti_init();
 }
 
+#ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
+			   randomize_kstack_offset);
+DEFINE_PER_CPU(u32, kstack_offset);
+
+static int __init early_randomize_kstack_offset(char *buf)
+{
+	int ret;
+	bool bool_result;
+
+	ret = kstrtobool(buf, &bool_result);
+	if (ret)
+		return ret;
+
+	if (bool_result)
+		static_branch_enable(&randomize_kstack_offset);
+	else
+		static_branch_disable(&randomize_kstack_offset);
+	return 0;
+}
+early_param("randomize_kstack_offset", early_randomize_kstack_offset);
+#endif
+
 void __init __weak arch_call_rest_init(void)
 {
 	rest_init();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfc72873961d..e2f19bf948db 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -167,10 +167,10 @@ unsigned long totalcma_pages __read_mostly;
 
 int percpu_pagelist_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
-DEFINE_STATIC_KEY_FALSE(init_on_alloc);
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 EXPORT_SYMBOL(init_on_alloc);
 
-DEFINE_STATIC_KEY_FALSE(init_on_free);
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
 static bool _init_on_alloc_enabled_early __read_mostly
diff --git a/mm/slab.h b/mm/slab.h
index 076582f58f68..774c7221efdc 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -601,7 +601,8 @@ static inline void cache_random_seq_destroy(struct kmem_cache *cachep) { }
 
 static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
 {
-	if (static_branch_unlikely(&init_on_alloc)) {
+	if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				&init_on_alloc)) {
 		if (c->ctor)
 			return false;
 		if (c->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON))
@@ -613,7 +614,8 @@ static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
 
 static inline bool slab_want_init_on_free(struct kmem_cache *c)
 {
-	if (static_branch_unlikely(&init_on_free))
+	if (static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
+				&init_on_free))
 		return !(c->ctor ||
 			 (c->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)));
 	return false;
diff --git a/tools/testing/selftests/lkdtm/.gitignore b/tools/testing/selftests/lkdtm/.gitignore
index f26212605b6b..d4b0be857deb 100644
--- a/tools/testing/selftests/lkdtm/.gitignore
+++ b/tools/testing/selftests/lkdtm/.gitignore
@@ -1,2 +1,3 @@
 *.sh
 !run.sh
+!stack-entropy.sh
diff --git a/tools/testing/selftests/lkdtm/Makefile b/tools/testing/selftests/lkdtm/Makefile
index 1bcc9ee990eb..c71109ceeb2d 100644
--- a/tools/testing/selftests/lkdtm/Makefile
+++ b/tools/testing/selftests/lkdtm/Makefile
@@ -5,6 +5,7 @@ include ../lib.mk
 
 # NOTE: $(OUTPUT) won't get default value if used before lib.mk
 TEST_FILES := tests.txt
+TEST_PROGS := stack-entropy.sh
 TEST_GEN_PROGS = $(patsubst %,$(OUTPUT)/%.sh,$(shell awk '{print $$1}' tests.txt | sed -e 's/\#//'))
 all: $(TEST_GEN_PROGS)
 
diff --git a/tools/testing/selftests/lkdtm/stack-entropy.sh b/tools/testing/selftests/lkdtm/stack-entropy.sh
new file mode 100755
index 000000000000..b1b8a5097cbb
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/stack-entropy.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Measure kernel stack entropy by sampling via LKDTM's REPORT_STACK test.
+set -e
+samples="${1:-1000}"
+
+# Capture dmesg continuously since it may fill up depending on sample size.
+log=$(mktemp -t stack-entropy-XXXXXX)
+dmesg --follow >"$log" & pid=$!
+report=-1
+for i in $(seq 1 $samples); do
+        echo "REPORT_STACK" >/sys/kernel/debug/provoke-crash/DIRECT
+	if [ -t 1 ]; then
+		percent=$(( 100 * $i / $samples ))
+		if [ "$percent" -ne "$report" ]; then
+			/bin/echo -en "$percent%\r"
+			report="$percent"
+		fi
+	fi
+done
+kill "$pid"
+
+# Count unique offsets since last run.
+seen=$(tac "$log" | grep -m1 -B"$samples"0 'Starting stack offset' | \
+	grep 'Stack offset' | awk '{print $NF}' | sort | uniq -c | wc -l)
+bits=$(echo "obase=2; $seen" | bc | wc -L)
+echo "Bits of stack entropy: $bits"
+rm -f "$log"
+
+# We would expect any functional stack randomization to be at least 5 bits.
+if [ "$bits" -lt 5 ]; then
+	exit 1
+else
+	exit 0
+fi

