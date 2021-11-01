Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B244411C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 02:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhKABSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 21:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhKABSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 21:18:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1193AC061764
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 18:16:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635729362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=w8s2LmshPc2EcPjzjsPrsSrlOIffi1meLfss/3E20f4=;
        b=C5Ixy0z/iC1JhS4zMMCYR83C9MKu3g7MlMQe+S8JUDCexV51bH7RQYK+MsuVACNupEKnTH
        wFvOPPdGKYxeylqF3WHsRR7HmUQAIx7ZX+FDGvWyHv7XjIoOY5FALwssaQRvRu2/kXMyWm
        gkwGoSSOJdQURbWHfdKoZGkYtxKONHqQFWtgaWXEFCbvZiqi+rgSTRMhhXep76406QR2Ky
        ffDGpbJQlJ0IS6ZFeBQg5kf5wr8z6WcI4VUrVILju4Bq3REpjh4sKNzgVzh23I2ZeXepCH
        hLKiUbEuK7VUuoCoBBKh5ffI30cPXnQX22MlxDNfz6PD7J/B9QqbUu5fE+I4kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635729362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=w8s2LmshPc2EcPjzjsPrsSrlOIffi1meLfss/3E20f4=;
        b=N8TyrjwLwovE/atitdrrqRWSx5wt+eZqR4TxOEgVrK5MIk9gPe+95v2rdHdYJfVUjx9mDy
        2o1twXNI7hNEzdBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] objtool/core for v5.16-rc1
References: <163572864256.3357115.931779940195622047.tglx@xen13>
Message-ID: <163572864563.3357115.8793939214537874196.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon,  1 Nov 2021 02:16:01 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest objtool/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-202=
1-10-31

up to:  87c87ecd00c5: bpf,x86: Respect X86_FEATURE_RETPOLINE*

objtool updates:

 - Improve retpoline code patching by separating it from alternatives which
   reduces memory footprint and allows to do better optimizations in the
   actual runtime patching.

 - Add proper retpoline support for x86/BPF

 - Address noinstr warnings in x86/kvm, lockdep and paravirtualization code

 - Add support to handle pv_opsindirect calls in the noinstr analysis

 - Classify symbols upfront and cache the result to avoid redundant
   str*cmp() invocations.

 - Add a CFI hash to reduce memory consumption which also reduces runtime
   on a allyesconfig by ~50%

 - Adjust XEN code to make objtool handling more robust and as a side
   effect to prevent text fragmentation due to placement of the hypercall
   page.

Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      x86/xen: Move hypercall_page to top of the file

Peter Zijlstra (40):
      x86/xen: Mark cpu_bringup_and_idle() as dead_end_function
      objtool: Introduce CFI hash
      objtool: Handle __sanitize_cov*() tail calls
      x86/kvm: Always inline sev_*guest()
      x86/kvm: Always inline vmload() / vmsave()
      x86: Always inline context_tracking_guest_enter()
      x86/kvm: Always inline to_svm()
      x86/kvm: Always inline evmcs_write64()
      x86: Always inline ip_within_syscall_gap()
      x86/sev: Fix noinstr for vc_ghcb_invalidate()
      locking/lockdep: Avoid RCU-induced noinstr fail
      x86/paravirt: Mark arch_local_irq_*() __always_inline
      x86/paravirt: Use PVOP_* for paravirt calls
      x86/xen: Make read_cr2() noinstr
      x86/xen: Make write_cr2() noinstr
      x86/xen: Make get_debugreg() noinstr
      x86/xen: Make set_debugreg() noinstr
      x86/xen: Make save_fl() noinstr
      x86/xen: Make hypercall_page noinstr
      x86/xen: Make irq_enable() noinstr
      x86/xen: Make irq_disable() noinstr
      x86/xen: Mark xen_force_evtchn_callback() noinstr
      x86/xen: Rework the xen_{cpu,irq,mmu}_opsarrays
      objtool: Support pv_opsindirect calls for noinstr
      objtool: Classify symbols
      objtool: Explicitly avoid self modifying code in .altinstr_replacement
      objtool: Shrink struct instruction
      objtool,x86: Replace alternatives with .retpoline_sites
      x86/retpoline: Remove unused replacement symbols
      x86/asm: Fix register order
      x86/asm: Fixup odd GEN-for-each-reg.h usage
      x86/retpoline: Move the retpoline thunk declarations to nospec-branch.h
      x86/retpoline: Create a retpoline thunk array
      x86/alternative: Implement .retpoline_sites support
      x86/alternative: Handle Jcc __x86_indirect_thunk_\reg
      x86/alternative: Try inline spectre_v2=3Dretpoline,amd
      x86/alternative: Add debug prints to apply_retpolines()
      x86,bugs: Unconditionally allow spectre_v2=3Dretpoline,amd
      bpf,x86: Simplify computing label offsets
      bpf,x86: Respect X86_FEATURE_RETPOLINE*


 arch/um/kernel/um_arch.c                |   4 +
 arch/x86/include/asm/GEN-for-each-reg.h |  14 +-
 arch/x86/include/asm/alternative.h      |   1 +
 arch/x86/include/asm/asm-prototypes.h   |  18 -
 arch/x86/include/asm/nospec-branch.h    |  72 +---
 arch/x86/include/asm/paravirt.h         |  31 +-
 arch/x86/include/asm/ptrace.h           |   2 +-
 arch/x86/include/asm/xen/hypercall.h    |   6 +-
 arch/x86/kernel/alternative.c           | 191 +++++++++-
 arch/x86/kernel/cpu/bugs.c              |   7 -
 arch/x86/kernel/irqflags.S              |   2 +
 arch/x86/kernel/module.c                |   9 +-
 arch/x86/kernel/paravirt.c              |  45 ++-
 arch/x86/kernel/sev-shared.c            |   2 +-
 arch/x86/kernel/vmlinux.lds.S           |  14 +
 arch/x86/kvm/svm/svm.h                  |   8 +-
 arch/x86/kvm/svm/svm_ops.h              |   4 +-
 arch/x86/kvm/vmx/evmcs.h                |   4 +-
 arch/x86/lib/retpoline.S                |  56 +--
 arch/x86/net/bpf_jit_comp.c             | 160 +++-----
 arch/x86/net/bpf_jit_comp32.c           |  22 +-
 arch/x86/xen/enlighten_pv.c             |  70 ++--
 arch/x86/xen/irq.c                      |  31 +-
 arch/x86/xen/mmu_pv.c                   |  93 ++---
 arch/x86/xen/xen-asm.S                  |  79 ++--
 arch/x86/xen/xen-head.S                 |  34 +-
 include/linux/context_tracking.h        |   2 +-
 kernel/locking/lockdep.c                |   2 +-
 lib/Kconfig.debug                       |   2 +-
 tools/objtool/arch/x86/decode.c         | 180 +++------
 tools/objtool/check.c                   | 646 ++++++++++++++++++++++++------=
--
 tools/objtool/elf.c                     |  84 -----
 tools/objtool/include/objtool/arch.h    |   5 +-
 tools/objtool/include/objtool/cfi.h     |   2 +
 tools/objtool/include/objtool/check.h   |   3 +-
 tools/objtool/include/objtool/elf.h     |   9 +-
 tools/objtool/include/objtool/objtool.h |   9 +
 tools/objtool/objtool.c                 |  22 ++
 tools/objtool/orc_gen.c                 |  15 +-
 tools/objtool/special.c                 |   8 -
 40 files changed, 1157 insertions(+), 811 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a149a5e9a16a..54447690de11 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -421,6 +421,10 @@ void __init check_bugs(void)
 	os_check_bugs();
 }
=20
+void apply_retpolines(s32 *start, s32 *end)
+{
+}
+
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
diff --git a/arch/x86/include/asm/GEN-for-each-reg.h b/arch/x86/include/asm/G=
EN-for-each-reg.h
index 1b07fb102c4e..07949102a08d 100644
--- a/arch/x86/include/asm/GEN-for-each-reg.h
+++ b/arch/x86/include/asm/GEN-for-each-reg.h
@@ -1,11 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * These are in machine order; things rely on that.
+ */
 #ifdef CONFIG_64BIT
 GEN(rax)
-GEN(rbx)
 GEN(rcx)
 GEN(rdx)
+GEN(rbx)
+GEN(rsp)
+GEN(rbp)
 GEN(rsi)
 GEN(rdi)
-GEN(rbp)
 GEN(r8)
 GEN(r9)
 GEN(r10)
@@ -16,10 +21,11 @@ GEN(r14)
 GEN(r15)
 #else
 GEN(eax)
-GEN(ebx)
 GEN(ecx)
 GEN(edx)
+GEN(ebx)
+GEN(esp)
+GEN(ebp)
 GEN(esi)
 GEN(edi)
-GEN(ebp)
 #endif
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/altern=
ative.h
index a3c2315aca12..58eee6402832 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -75,6 +75,7 @@ extern int alternatives_patched;
=20
 extern void alternative_instructions(void);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *en=
d);
+extern void apply_retpolines(s32 *start, s32 *end);
=20
 struct module;
=20
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm=
-prototypes.h
index 4cb726c71ed8..8f80de627c60 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -17,21 +17,3 @@
 extern void cmpxchg8b_emu(void);
 #endif
=20
-#ifdef CONFIG_RETPOLINE
-
-#undef GEN
-#define GEN(reg) \
-	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
-#include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) \
-	extern asmlinkage void __x86_indirect_alt_call_ ## reg (void);
-#include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) \
-	extern asmlinkage void __x86_indirect_alt_jmp_ ## reg (void);
-#include <asm/GEN-for-each-reg.h>
-
-#endif /* CONFIG_RETPOLINE */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nosp=
ec-branch.h
index ec2d5c8c6694..cc74dc584836 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -5,12 +5,15 @@
=20
 #include <linux/static_key.h>
 #include <linux/objtool.h>
+#include <linux/linkage.h>
=20
 #include <asm/alternative.h>
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
=20
+#define RETPOLINE_THUNK_SIZE	32
+
 /*
  * Fill the CPU return stack buffer.
  *
@@ -118,6 +121,16 @@
 	".popsection\n\t"
=20
 #ifdef CONFIG_RETPOLINE
+
+typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
+
+#define GEN(reg) \
+	extern retpoline_thunk_t __x86_indirect_thunk_ ## reg;
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+extern retpoline_thunk_t __x86_indirect_thunk_array[];
+
 #ifdef CONFIG_X86_64
=20
 /*
@@ -303,63 +316,4 @@ static inline void mds_idle_clear_cpu_buffers(void)
=20
 #endif /* __ASSEMBLY__ */
=20
-/*
- * Below is used in the eBPF JIT compiler and emits the byte sequence
- * for the following assembly:
- *
- * With retpolines configured:
- *
- *    callq do_rop
- *  spec_trap:
- *    pause
- *    lfence
- *    jmp spec_trap
- *  do_rop:
- *    mov %rcx,(%rsp) for x86_64
- *    mov %edx,(%esp) for x86_32
- *    retq
- *
- * Without retpolines configured:
- *
- *    jmp *%rcx for x86_64
- *    jmp *%edx for x86_32
- */
-#ifdef CONFIG_RETPOLINE
-# ifdef CONFIG_X86_64
-#  define RETPOLINE_RCX_BPF_JIT_SIZE	17
-#  define RETPOLINE_RCX_BPF_JIT()				\
-do {								\
-	EMIT1_off32(0xE8, 7);	 /* callq do_rop */		\
-	/* spec_trap: */					\
-	EMIT2(0xF3, 0x90);       /* pause */			\
-	EMIT3(0x0F, 0xAE, 0xE8); /* lfence */			\
-	EMIT2(0xEB, 0xF9);       /* jmp spec_trap */		\
-	/* do_rop: */						\
-	EMIT4(0x48, 0x89, 0x0C, 0x24); /* mov %rcx,(%rsp) */	\
-	EMIT1(0xC3);             /* retq */			\
-} while (0)
-# else /* !CONFIG_X86_64 */
-#  define RETPOLINE_EDX_BPF_JIT()				\
-do {								\
-	EMIT1_off32(0xE8, 7);	 /* call do_rop */		\
-	/* spec_trap: */					\
-	EMIT2(0xF3, 0x90);       /* pause */			\
-	EMIT3(0x0F, 0xAE, 0xE8); /* lfence */			\
-	EMIT2(0xEB, 0xF9);       /* jmp spec_trap */		\
-	/* do_rop: */						\
-	EMIT3(0x89, 0x14, 0x24); /* mov %edx,(%esp) */		\
-	EMIT1(0xC3);             /* ret */			\
-} while (0)
-# endif
-#else /* !CONFIG_RETPOLINE */
-# ifdef CONFIG_X86_64
-#  define RETPOLINE_RCX_BPF_JIT_SIZE	2
-#  define RETPOLINE_RCX_BPF_JIT()				\
-	EMIT2(0xFF, 0xE1);       /* jmp *%rcx */
-# else /* !CONFIG_X86_64 */
-#  define RETPOLINE_EDX_BPF_JIT()				\
-	EMIT2(0xFF, 0xE2)        /* jmp *%edx */
-# endif
-#endif
-
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index da3a1ac82be5..cebec95a7124 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -52,11 +52,11 @@ void __init paravirt_set_cap(void);
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
-	pv_ops.cpu.io_delay();
+	PVOP_VCALL0(cpu.io_delay);
 #ifdef REALLY_SLOW_IO
-	pv_ops.cpu.io_delay();
-	pv_ops.cpu.io_delay();
-	pv_ops.cpu.io_delay();
+	PVOP_VCALL0(cpu.io_delay);
+	PVOP_VCALL0(cpu.io_delay);
+	PVOP_VCALL0(cpu.io_delay);
 #endif
 }
=20
@@ -113,12 +113,12 @@ static inline void __cpuid(unsigned int *eax, unsigned =
int *ebx,
 /*
  * These special macros can be used to get or set a debugging register
  */
-static inline unsigned long paravirt_get_debugreg(int reg)
+static __always_inline unsigned long paravirt_get_debugreg(int reg)
 {
 	return PVOP_CALL1(unsigned long, cpu.get_debugreg, reg);
 }
 #define get_debugreg(var, reg) var =3D paravirt_get_debugreg(reg)
-static inline void set_debugreg(unsigned long val, int reg)
+static __always_inline void set_debugreg(unsigned long val, int reg)
 {
 	PVOP_VCALL2(cpu.set_debugreg, reg, val);
 }
@@ -133,14 +133,14 @@ static inline void write_cr0(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr0, x);
 }
=20
-static inline unsigned long read_cr2(void)
+static __always_inline unsigned long read_cr2(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
 				"mov %%cr2, %%rax;",
 				ALT_NOT(X86_FEATURE_XENPV));
 }
=20
-static inline void write_cr2(unsigned long x)
+static __always_inline void write_cr2(unsigned long x)
 {
 	PVOP_VCALL1(mmu.write_cr2, x);
 }
@@ -653,10 +653,10 @@ bool __raw_callee_save___native_vcpu_is_preempted(long =
cpu);
  * functions.
  */
 #define PV_THUNK_NAME(func) "__raw_callee_save_" #func
-#define PV_CALLEE_SAVE_REGS_THUNK(func)					\
+#define __PV_CALLEE_SAVE_REGS_THUNK(func, section)			\
 	extern typeof(func) __raw_callee_save_##func;			\
 									\
-	asm(".pushsection .text;"					\
+	asm(".pushsection " section ", \"ax\";"				\
 	    ".globl " PV_THUNK_NAME(func) ";"				\
 	    ".type " PV_THUNK_NAME(func) ", @function;"			\
 	    PV_THUNK_NAME(func) ":"					\
@@ -669,6 +669,9 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cp=
u);
 	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
 	    ".popsection")
=20
+#define PV_CALLEE_SAVE_REGS_THUNK(func)			\
+	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text")
+
 /* Get a reference to a callee-save function */
 #define PV_CALLEE_SAVE(func)						\
 	((struct paravirt_callee_save) { __raw_callee_save_##func })
@@ -678,23 +681,23 @@ bool __raw_callee_save___native_vcpu_is_preempted(long =
cpu);
 	((struct paravirt_callee_save) { func })
=20
 #ifdef CONFIG_PARAVIRT_XXL
-static inline notrace unsigned long arch_local_save_flags(void)
+static __always_inline unsigned long arch_local_save_flags(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax;",
 				ALT_NOT(X86_FEATURE_XENPV));
 }
=20
-static inline notrace void arch_local_irq_disable(void)
+static __always_inline void arch_local_irq_disable(void)
 {
 	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT(X86_FEATURE_XENPV));
 }
=20
-static inline notrace void arch_local_irq_enable(void)
+static __always_inline void arch_local_irq_enable(void)
 {
 	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT(X86_FEATURE_XENPV));
 }
=20
-static inline notrace unsigned long arch_local_irq_save(void)
+static __always_inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long f;
=20
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index b94f615600d5..703663175a5a 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -181,7 +181,7 @@ static inline bool any_64bit_mode(struct pt_regs *regs)
 #define current_user_stack_pointer()	current_pt_regs()->sp
 #define compat_user_stack_pointer()	current_pt_regs()->sp
=20
-static inline bool ip_within_syscall_gap(struct pt_regs *regs)
+static __always_inline bool ip_within_syscall_gap(struct pt_regs *regs)
 {
 	bool ret =3D (regs->ip >=3D (unsigned long)entry_SYSCALL_64 &&
 		    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack);
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/=
hypercall.h
index 454b20815f35..4a7ff8b0db20 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -308,13 +308,13 @@ HYPERVISOR_platform_op(struct xen_platform_op *op)
 	return _hypercall1(int, platform_op, op);
 }
=20
-static inline int
+static __always_inline int
 HYPERVISOR_set_debugreg(int reg, unsigned long value)
 {
 	return _hypercall2(int, set_debugreg, reg, value);
 }
=20
-static inline unsigned long
+static __always_inline unsigned long
 HYPERVISOR_get_debugreg(int reg)
 {
 	return _hypercall1(unsigned long, get_debugreg, reg);
@@ -358,7 +358,7 @@ HYPERVISOR_event_channel_op(int cmd, void *arg)
 	return _hypercall2(int, event_channel_op, cmd, arg);
 }
=20
-static inline int
+static __always_inline int
 HYPERVISOR_xen_version(int cmd, void *arg)
 {
 	return _hypercall2(int, xen_version, cmd, arg);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e9da3dc71254..23fb4d51a5da 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -29,6 +29,7 @@
 #include <asm/io.h>
 #include <asm/fixmap.h>
 #include <asm/paravirt.h>
+#include <asm/asm-prototypes.h>
=20
 int __read_mostly alternatives_patched;
=20
@@ -113,6 +114,7 @@ static void __init_or_module add_nops(void *insns, unsign=
ed int len)
 	}
 }
=20
+extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
@@ -221,7 +223,7 @@ static __always_inline int optimize_nops_range(u8 *instr,=
 u8 instrlen, int off)
  * "noinline" to cause control flow change and thus invalidate I$ and
  * cause refetch after modification.
  */
-static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 =
*instr)
+static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 {
 	struct insn insn;
 	int i =3D 0;
@@ -239,11 +241,11 @@ static void __init_or_module noinline optimize_nops(str=
uct alt_instr *a, u8 *ins
 		 * optimized.
 		 */
 		if (insn.length =3D=3D 1 && insn.opcode.bytes[0] =3D=3D 0x90)
-			i +=3D optimize_nops_range(instr, a->instrlen, i);
+			i +=3D optimize_nops_range(instr, len, i);
 		else
 			i +=3D insn.length;
=20
-		if (i >=3D a->instrlen)
+		if (i >=3D len)
 			return;
 	}
 }
@@ -331,10 +333,185 @@ void __init_or_module noinline apply_alternatives(stru=
ct alt_instr *start,
 		text_poke_early(instr, insn_buff, insn_buff_sz);
=20
 next:
-		optimize_nops(a, instr);
+		optimize_nops(instr, a->instrlen);
 	}
 }
=20
+#if defined(CONFIG_RETPOLINE) && defined(CONFIG_STACK_VALIDATION)
+
+/*
+ * CALL/JMP *%\reg
+ */
+static int emit_indirect(int op, int reg, u8 *bytes)
+{
+	int i =3D 0;
+	u8 modrm;
+
+	switch (op) {
+	case CALL_INSN_OPCODE:
+		modrm =3D 0x10; /* Reg =3D 2; CALL r/m */
+		break;
+
+	case JMP32_INSN_OPCODE:
+		modrm =3D 0x20; /* Reg =3D 4; JMP r/m */
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		return -1;
+	}
+
+	if (reg >=3D 8) {
+		bytes[i++] =3D 0x41; /* REX.B prefix */
+		reg -=3D 8;
+	}
+
+	modrm |=3D 0xc0; /* Mod =3D 3 */
+	modrm +=3D reg;
+
+	bytes[i++] =3D 0xff; /* opcode */
+	bytes[i++] =3D modrm;
+
+	return i;
+}
+
+/*
+ * Rewrite the compiler generated retpoline thunk calls.
+ *
+ * For spectre_v2=3Doff (!X86_FEATURE_RETPOLINE), rewrite them into immediate
+ * indirect instructions, avoiding the extra indirection.
+ *
+ * For example, convert:
+ *
+ *   CALL __x86_indirect_thunk_\reg
+ *
+ * into:
+ *
+ *   CALL *%\reg
+ *
+ * It also tries to inline spectre_v2=3Dretpoline,amd when size permits.
+ */
+static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
+{
+	retpoline_thunk_t *target;
+	int reg, ret, i =3D 0;
+	u8 op, cc;
+
+	target =3D addr + insn->length + insn->immediate.value;
+	reg =3D target - __x86_indirect_thunk_array;
+
+	if (WARN_ON_ONCE(reg & ~0xf))
+		return -1;
+
+	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
+	BUG_ON(reg =3D=3D 4);
+
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
+	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD))
+		return -1;
+
+	op =3D insn->opcode.bytes[0];
+
+	/*
+	 * Convert:
+	 *
+	 *   Jcc.d32 __x86_indirect_thunk_\reg
+	 *
+	 * into:
+	 *
+	 *   Jncc.d8 1f
+	 *   [ LFENCE ]
+	 *   JMP *%\reg
+	 *   [ NOP ]
+	 * 1:
+	 */
+	/* Jcc.d32 second opcode byte is in the range: 0x80-0x8f */
+	if (op =3D=3D 0x0f && (insn->opcode.bytes[1] & 0xf0) =3D=3D 0x80) {
+		cc =3D insn->opcode.bytes[1] & 0xf;
+		cc ^=3D 1; /* invert condition */
+
+		bytes[i++] =3D 0x70 + cc;        /* Jcc.d8 */
+		bytes[i++] =3D insn->length - 2; /* sizeof(Jcc.d8) =3D=3D 2 */
+
+		/* Continue as if: JMP.d32 __x86_indirect_thunk_\reg */
+		op =3D JMP32_INSN_OPCODE;
+	}
+
+	/*
+	 * For RETPOLINE_AMD: prepend the indirect CALL/JMP with an LFENCE.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
+		bytes[i++] =3D 0x0f;
+		bytes[i++] =3D 0xae;
+		bytes[i++] =3D 0xe8; /* LFENCE */
+	}
+
+	ret =3D emit_indirect(op, reg, bytes + i);
+	if (ret < 0)
+		return ret;
+	i +=3D ret;
+
+	for (; i < insn->length;)
+		bytes[i++] =3D BYTES_NOP1;
+
+	return i;
+}
+
+/*
+ * Generated by 'objtool --retpoline'.
+ */
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s =3D start; s < end; s++) {
+		void *addr =3D (void *)s + *s;
+		struct insn insn;
+		int len, ret;
+		u8 bytes[16];
+		u8 op1, op2;
+
+		ret =3D insn_decode_kernel(&insn, addr);
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+
+		op1 =3D insn.opcode.bytes[0];
+		op2 =3D insn.opcode.bytes[1];
+
+		switch (op1) {
+		case CALL_INSN_OPCODE:
+		case JMP32_INSN_OPCODE:
+			break;
+
+		case 0x0f: /* escape */
+			if (op2 >=3D 0x80 && op2 <=3D 0x8f)
+				break;
+			fallthrough;
+		default:
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		DPRINTK("retpoline at: %pS (%px) len: %d to: %pS",
+			addr, addr, insn.length,
+			addr + insn.length + insn.immediate.value);
+
+		len =3D patch_retpoline(addr, &insn, bytes);
+		if (len =3D=3D insn.length) {
+			optimize_nops(bytes, len);
+			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
+			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
+			text_poke_early(addr, bytes, len);
+		}
+	}
+}
+
+#else /* !RETPOLINES || !CONFIG_STACK_VALIDATION */
+
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end) { }
+
+#endif /* CONFIG_RETPOLINE && CONFIG_STACK_VALIDATION */
+
 #ifdef CONFIG_SMP
 static void alternatives_smp_lock(const s32 *start, const s32 *end,
 				  u8 *text, u8 *text_end)
@@ -642,6 +819,12 @@ void __init alternative_instructions(void)
 	 */
 	apply_paravirt(__parainstructions, __parainstructions_end);
=20
+	/*
+	 * Rewrite the retpolines, must be done before alternatives since
+	 * those can rewrite the retpoline thunks.
+	 */
+	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
+
 	/*
 	 * Then patch alternatives, such that those paravirt calls that are in
 	 * alternatives can be overwritten by their immediate fragments.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ecfca3bbcd96..ba43597f1027 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -882,13 +882,6 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_=
parse_cmdline(void)
 		return SPECTRE_V2_CMD_AUTO;
 	}
=20
-	if (cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_AMD &&
-	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_HYGON &&
-	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD) {
-		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO selec=
t\n");
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
 	spec_v2_print_cond(mitigation_options[i].option,
 			   mitigation_options[i].secure);
 	return cmd;
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
index 8ef35063964b..760e1f293093 100644
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -7,9 +7,11 @@
 /*
  * unsigned long native_save_fl(void)
  */
+.pushsection .noinstr.text, "ax"
 SYM_FUNC_START(native_save_fl)
 	pushf
 	pop %_ASM_AX
 	ret
 SYM_FUNC_END(native_save_fl)
+.popsection
 EXPORT_SYMBOL(native_save_fl)
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 5e9a34b5bd74..169fb6f4cd2e 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -251,7 +251,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    struct module *me)
 {
 	const Elf_Shdr *s, *text =3D NULL, *alt =3D NULL, *locks =3D NULL,
-		*para =3D NULL, *orc =3D NULL, *orc_ip =3D NULL;
+		*para =3D NULL, *orc =3D NULL, *orc_ip =3D NULL,
+		*retpolines =3D NULL;
 	char *secstrings =3D (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
=20
 	for (s =3D sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -267,8 +268,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 			orc =3D s;
 		if (!strcmp(".orc_unwind_ip", secstrings + s->sh_name))
 			orc_ip =3D s;
+		if (!strcmp(".retpoline_sites", secstrings + s->sh_name))
+			retpolines =3D s;
 	}
=20
+	if (retpolines) {
+		void *rseg =3D (void *)retpolines->sh_addr;
+		apply_retpolines(rseg, rseg + retpolines->sh_size);
+	}
 	if (alt) {
 		/* patch .altinstructions */
 		void *aseg =3D (void *)alt->sh_addr;
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 04cafc057bed..ebc45360ffd4 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -218,6 +218,36 @@ void paravirt_end_context_switch(struct task_struct *nex=
t)
 	if (test_and_clear_ti_thread_flag(task_thread_info(next), TIF_LAZY_MMU_UPDA=
TES))
 		arch_enter_lazy_mmu_mode();
 }
+
+static noinstr unsigned long pv_native_read_cr2(void)
+{
+	return native_read_cr2();
+}
+
+static noinstr void pv_native_write_cr2(unsigned long val)
+{
+	native_write_cr2(val);
+}
+
+static noinstr unsigned long pv_native_get_debugreg(int regno)
+{
+	return native_get_debugreg(regno);
+}
+
+static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
+{
+	native_set_debugreg(regno, val);
+}
+
+static noinstr void pv_native_irq_enable(void)
+{
+	native_irq_enable();
+}
+
+static noinstr void pv_native_irq_disable(void)
+{
+	native_irq_disable();
+}
 #endif
=20
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
@@ -244,8 +274,8 @@ struct paravirt_patch_template pv_ops =3D {
=20
 #ifdef CONFIG_PARAVIRT_XXL
 	.cpu.cpuid		=3D native_cpuid,
-	.cpu.get_debugreg	=3D native_get_debugreg,
-	.cpu.set_debugreg	=3D native_set_debugreg,
+	.cpu.get_debugreg	=3D pv_native_get_debugreg,
+	.cpu.set_debugreg	=3D pv_native_set_debugreg,
 	.cpu.read_cr0		=3D native_read_cr0,
 	.cpu.write_cr0		=3D native_write_cr0,
 	.cpu.write_cr4		=3D native_write_cr4,
@@ -281,8 +311,8 @@ struct paravirt_patch_template pv_ops =3D {
=20
 	/* Irq ops. */
 	.irq.save_fl		=3D __PV_IS_CALLEE_SAVE(native_save_fl),
-	.irq.irq_disable	=3D __PV_IS_CALLEE_SAVE(native_irq_disable),
-	.irq.irq_enable		=3D __PV_IS_CALLEE_SAVE(native_irq_enable),
+	.irq.irq_disable	=3D __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
+	.irq.irq_enable		=3D __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
 	.irq.safe_halt		=3D native_safe_halt,
 	.irq.halt		=3D native_halt,
 #endif /* CONFIG_PARAVIRT_XXL */
@@ -298,8 +328,8 @@ struct paravirt_patch_template pv_ops =3D {
 	.mmu.exit_mmap		=3D paravirt_nop,
=20
 #ifdef CONFIG_PARAVIRT_XXL
-	.mmu.read_cr2		=3D __PV_IS_CALLEE_SAVE(native_read_cr2),
-	.mmu.write_cr2		=3D native_write_cr2,
+	.mmu.read_cr2		=3D __PV_IS_CALLEE_SAVE(pv_native_read_cr2),
+	.mmu.write_cr2		=3D pv_native_write_cr2,
 	.mmu.read_cr3		=3D __native_read_cr3,
 	.mmu.write_cr3		=3D native_write_cr3,
=20
@@ -371,9 +401,6 @@ struct paravirt_patch_template pv_ops =3D {
 };
=20
 #ifdef CONFIG_PARAVIRT_XXL
-/* At this point, native_get/set_debugreg has real function entries */
-NOKPROBE_SYMBOL(native_get_debugreg);
-NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
=20
 void (*paravirt_iret)(void) =3D native_iret;
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 9f90f460a28c..34f20e08dc46 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -64,7 +64,7 @@ static bool sev_es_negotiate_protocol(void)
 static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
 {
 	ghcb->save.sw_exit_code =3D 0;
-	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
+	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap=
));
 }
=20
 static bool vc_decoding_needed(unsigned long exit_code)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index efd9e9ea17f2..3d6dc12d198f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -272,6 +272,20 @@ SECTIONS
 		__parainstructions_end =3D .;
 	}
=20
+#ifdef CONFIG_RETPOLINE
+	/*
+	 * List of instructions that call/jmp/jcc to retpoline thunks
+	 * __x86_indirect_thunk_*(). These instructions can be patched along
+	 * with alternatives, after which the section can be freed.
+	 */
+	. =3D ALIGN(8);
+	.retpoline_sites : AT(ADDR(.retpoline_sites) - LOAD_OFFSET) {
+		__retpoline_sites =3D .;
+		*(.retpoline_sites)
+		__retpoline_sites_end =3D .;
+	}
+#endif
+
 	/*
 	 * struct alt_inst entries. From the header (alternative.h):
 	 * "Alternative instructions for different CPU types or capabilities"
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 128a54b1fbf1..58350deb428b 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -218,12 +218,12 @@ DECLARE_PER_CPU(struct svm_cpu_data *, svm_data);
=20
 void recalc_intercepts(struct vcpu_svm *svm);
=20
-static inline struct kvm_svm *to_kvm_svm(struct kvm *kvm)
+static __always_inline struct kvm_svm *to_kvm_svm(struct kvm *kvm)
 {
 	return container_of(kvm, struct kvm_svm, kvm);
 }
=20
-static inline bool sev_guest(struct kvm *kvm)
+static __always_inline bool sev_guest(struct kvm *kvm)
 {
 #ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_info;
@@ -234,7 +234,7 @@ static inline bool sev_guest(struct kvm *kvm)
 #endif
 }
=20
-static inline bool sev_es_guest(struct kvm *kvm)
+static __always_inline bool sev_es_guest(struct kvm *kvm)
 {
 #ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_info;
@@ -271,7 +271,7 @@ static inline bool vmcb_is_dirty(struct vmcb *vmcb, int b=
it)
         return !test_bit(bit, (unsigned long *)&vmcb->control.clean);
 }
=20
-static inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
+static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
 {
 	return container_of(vcpu, struct vcpu_svm, vcpu);
 }
diff --git a/arch/x86/kvm/svm/svm_ops.h b/arch/x86/kvm/svm/svm_ops.h
index 22e2b019de37..9430d6437c9f 100644
--- a/arch/x86/kvm/svm/svm_ops.h
+++ b/arch/x86/kvm/svm/svm_ops.h
@@ -56,12 +56,12 @@ static inline void invlpga(unsigned long addr, u32 asid)
  * VMSAVE, VMLOAD, etc... is still controlled by the effective address size,
  * hence 'unsigned long' instead of 'hpa_t'.
  */
-static inline void vmsave(unsigned long pa)
+static __always_inline void vmsave(unsigned long pa)
 {
 	svm_asm1(vmsave, "a" (pa), "memory");
 }
=20
-static inline void vmload(unsigned long pa)
+static __always_inline void vmload(unsigned long pa)
 {
 	svm_asm1(vmload, "a" (pa), "memory");
 }
diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
index 152ab0aa82cf..16731d2cf231 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -93,7 +93,7 @@ static __always_inline int get_evmcs_offset(unsigned long f=
ield,
 	return evmcs_field->offset;
 }
=20
-static inline void evmcs_write64(unsigned long field, u64 value)
+static __always_inline void evmcs_write64(unsigned long field, u64 value)
 {
 	u16 clean_field;
 	int offset =3D get_evmcs_offset(field, &clean_field);
@@ -183,7 +183,7 @@ static inline void evmcs_load(u64 phys_addr)
=20
 __init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf);
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
-static inline void evmcs_write64(unsigned long field, u64 value) {}
+static __always_inline void evmcs_write64(unsigned long field, u64 value) {}
 static inline void evmcs_write32(unsigned long field, u32 value) {}
 static inline void evmcs_write16(unsigned long field, u16 value) {}
 static inline u64 evmcs_read64(unsigned long field) { return 0; }
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index ec9922cba30a..cf0b39f97adc 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -28,46 +28,14 @@
=20
 .macro THUNK reg
=20
-	.align 32
-
-SYM_FUNC_START(__x86_indirect_thunk_\reg)
+	.align RETPOLINE_THUNK_SIZE
+SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
+	UNWIND_HINT_EMPTY
=20
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATUR=
E_RETPOLINE_AMD
=20
-SYM_FUNC_END(__x86_indirect_thunk_\reg)
-
-.endm
-
-/*
- * This generates .altinstr_replacement symbols for use by objtool. They,
- * however, must not actually live in .altinstr_replacement since that will =
be
- * discarded after init, but module alternatives will also reference these
- * symbols.
- *
- * Their names matches the "__x86_indirect_" prefix to mark them as retpolin=
es.
- */
-.macro ALT_THUNK reg
-
-	.align 1
-
-SYM_FUNC_START_NOALIGN(__x86_indirect_alt_call_\reg)
-	ANNOTATE_RETPOLINE_SAFE
-1:	call	*%\reg
-2:	.skip	5-(2b-1b), 0x90
-SYM_FUNC_END(__x86_indirect_alt_call_\reg)
-
-STACK_FRAME_NON_STANDARD(__x86_indirect_alt_call_\reg)
-
-SYM_FUNC_START_NOALIGN(__x86_indirect_alt_jmp_\reg)
-	ANNOTATE_RETPOLINE_SAFE
-1:	jmp	*%\reg
-2:	.skip	5-(2b-1b), 0x90
-SYM_FUNC_END(__x86_indirect_alt_jmp_\reg)
-
-STACK_FRAME_NON_STANDARD(__x86_indirect_alt_jmp_\reg)
-
 .endm
=20
 /*
@@ -85,22 +53,16 @@ STACK_FRAME_NON_STANDARD(__x86_indirect_alt_jmp_\reg)
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
 #define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
=20
-#undef GEN
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_START(__x86_indirect_thunk_array)
+
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>
-
 #undef GEN
-#define GEN(reg) EXPORT_THUNK(reg)
-#include <asm/GEN-for-each-reg.h>
=20
-#undef GEN
-#define GEN(reg) ALT_THUNK reg
-#include <asm/GEN-for-each-reg.h>
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_END(__x86_indirect_thunk_array)
=20
-#undef GEN
-#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_call_ ## reg)
+#define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
-
 #undef GEN
-#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_jmp_ ## reg)
-#include <asm/GEN-for-each-reg.h>
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9ea57389c554..39c802525fce 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -15,7 +15,6 @@
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
-#include <asm/asm-prototypes.h>
=20
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
@@ -225,6 +224,14 @@ static void jit_fill_hole(void *area, unsigned int size)
=20
 struct jit_context {
 	int cleanup_addr; /* Epilogue code offset */
+
+	/*
+	 * Program specific offsets of labels in the code; these rely on the
+	 * JIT doing at least 2 passes, recording the position on the first
+	 * pass, only to generate the correct offset on the second pass.
+	 */
+	int tail_call_direct_label;
+	int tail_call_indirect_label;
 };
=20
 /* Maximum number of bytes emitted while JITing one eBPF insn */
@@ -380,20 +387,23 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_typ=
e t,
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr, true);
 }
=20
-static int get_pop_bytes(bool *callee_regs_used)
+#define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
+
+static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 {
-	int bytes =3D 0;
+	u8 *prog =3D *pprog;
=20
-	if (callee_regs_used[3])
-		bytes +=3D 2;
-	if (callee_regs_used[2])
-		bytes +=3D 2;
-	if (callee_regs_used[1])
-		bytes +=3D 2;
-	if (callee_regs_used[0])
-		bytes +=3D 1;
+#ifdef CONFIG_RETPOLINE
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
+		EMIT_LFENCE();
+		EMIT2(0xFF, 0xE0 + reg);
+	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
+	} else
+#endif
+	EMIT2(0xFF, 0xE0 + reg);
=20
-	return bytes;
+	*pprog =3D prog;
 }
=20
 /*
@@ -411,29 +421,12 @@ static int get_pop_bytes(bool *callee_regs_used)
  * out:
  */
 static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
-					u32 stack_depth)
+					u32 stack_depth, u8 *ip,
+					struct jit_context *ctx)
 {
 	int tcc_off =3D -4 - round_up(stack_depth, 8);
-	u8 *prog =3D *pprog;
-	int pop_bytes =3D 0;
-	int off1 =3D 42;
-	int off2 =3D 31;
-	int off3 =3D 9;
-
-	/* count the additional bytes used for popping callee regs from stack
-	 * that need to be taken into account for each of the offsets that
-	 * are used for bailing out of the tail call
-	 */
-	pop_bytes =3D get_pop_bytes(callee_regs_used);
-	off1 +=3D pop_bytes;
-	off2 +=3D pop_bytes;
-	off3 +=3D pop_bytes;
-
-	if (stack_depth) {
-		off1 +=3D 7;
-		off2 +=3D 7;
-		off3 +=3D 7;
-	}
+	u8 *prog =3D *pprog, *start =3D *pprog;
+	int offset;
=20
 	/*
 	 * rdi - pointer to ctx
@@ -448,8 +441,9 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool =
*callee_regs_used,
 	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx =
*/
 	      offsetof(struct bpf_array, map.max_entries));
-#define OFFSET1 (off1 + RETPOLINE_RCX_BPF_JIT_SIZE) /* Number of bytes to ju=
mp */
-	EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
+
+	offset =3D ctx->tail_call_indirect_label - (prog + 2 - start);
+	EMIT2(X86_JBE, offset);                   /* jbe out */
=20
 	/*
 	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
@@ -457,8 +451,9 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool =
*callee_regs_used,
 	 */
 	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_=
off] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
-#define OFFSET2 (off2 + RETPOLINE_RCX_BPF_JIT_SIZE)
-	EMIT2(X86_JA, OFFSET2);                   /* ja out */
+
+	offset =3D ctx->tail_call_indirect_label - (prog + 2 - start);
+	EMIT2(X86_JA, offset);                    /* ja out */
 	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
 	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off],=
 eax */
=20
@@ -471,12 +466,11 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, boo=
l *callee_regs_used,
 	 *	goto out;
 	 */
 	EMIT3(0x48, 0x85, 0xC9);                  /* test rcx,rcx */
-#define OFFSET3 (off3 + RETPOLINE_RCX_BPF_JIT_SIZE)
-	EMIT2(X86_JE, OFFSET3);                   /* je out */
=20
-	*pprog =3D prog;
-	pop_callee_regs(pprog, callee_regs_used);
-	prog =3D *pprog;
+	offset =3D ctx->tail_call_indirect_label - (prog + 2 - start);
+	EMIT2(X86_JE, offset);                    /* je out */
+
+	pop_callee_regs(&prog, callee_regs_used);
=20
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
@@ -493,41 +487,21 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, boo=
l *callee_regs_used,
 	 * rdi =3D=3D ctx (1st arg)
 	 * rcx =3D=3D prog->bpf_func + X86_TAIL_CALL_OFFSET
 	 */
-	RETPOLINE_RCX_BPF_JIT();
+	emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
=20
 	/* out: */
+	ctx->tail_call_indirect_label =3D prog - start;
 	*pprog =3D prog;
 }
=20
 static void emit_bpf_tail_call_direct(struct bpf_jit_poke_descriptor *poke,
-				      u8 **pprog, int addr, u8 *image,
-				      bool *callee_regs_used, u32 stack_depth)
+				      u8 **pprog, u8 *ip,
+				      bool *callee_regs_used, u32 stack_depth,
+				      struct jit_context *ctx)
 {
 	int tcc_off =3D -4 - round_up(stack_depth, 8);
-	u8 *prog =3D *pprog;
-	int pop_bytes =3D 0;
-	int off1 =3D 20;
-	int poke_off;
-
-	/* count the additional bytes used for popping callee regs to stack
-	 * that need to be taken into account for jump offset that is used for
-	 * bailing out from of the tail call when limit is reached
-	 */
-	pop_bytes =3D get_pop_bytes(callee_regs_used);
-	off1 +=3D pop_bytes;
-
-	/*
-	 * total bytes for:
-	 * - nop5/ jmpq $off
-	 * - pop callee regs
-	 * - sub rsp, $val if depth > 0
-	 * - pop rax
-	 */
-	poke_off =3D X86_PATCH_SIZE + pop_bytes + 1;
-	if (stack_depth) {
-		poke_off +=3D 7;
-		off1 +=3D 7;
-	}
+	u8 *prog =3D *pprog, *start =3D *pprog;
+	int offset;
=20
 	/*
 	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
@@ -535,28 +509,30 @@ static void emit_bpf_tail_call_direct(struct bpf_jit_po=
ke_descriptor *poke,
 	 */
 	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - =
tcc_off] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT=
 */
-	EMIT2(X86_JA, off1);                          /* ja out */
+
+	offset =3D ctx->tail_call_direct_label - (prog + 2 - start);
+	EMIT2(X86_JA, offset);                        /* ja out */
 	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
 	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_o=
ff], eax */
=20
-	poke->tailcall_bypass =3D image + (addr - poke_off - X86_PATCH_SIZE);
+	poke->tailcall_bypass =3D ip + (prog - start);
 	poke->adj_off =3D X86_TAIL_CALL_OFFSET;
-	poke->tailcall_target =3D image + (addr - X86_PATCH_SIZE);
+	poke->tailcall_target =3D ip + ctx->tail_call_direct_label - X86_PATCH_SIZE;
 	poke->bypass_addr =3D (u8 *)poke->tailcall_target + X86_PATCH_SIZE;
=20
 	emit_jump(&prog, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
 		  poke->tailcall_bypass);
=20
-	*pprog =3D prog;
-	pop_callee_regs(pprog, callee_regs_used);
-	prog =3D *pprog;
+	pop_callee_regs(&prog, callee_regs_used);
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
=20
 	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 	prog +=3D X86_PATCH_SIZE;
+
 	/* out: */
+	ctx->tail_call_direct_label =3D prog - start;
=20
 	*pprog =3D prog;
 }
@@ -1222,8 +1198,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs=
, u8 *image,
 			/* speculation barrier */
 		case BPF_ST | BPF_NOSPEC:
 			if (boot_cpu_has(X86_FEATURE_XMM2))
-				/* Emit 'lfence' */
-				EMIT3(0x0F, 0xAE, 0xE8);
+				EMIT_LFENCE();
 			break;
=20
 			/* ST: *(u8*)(dst_reg + off) =3D imm */
@@ -1412,13 +1387,16 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_TAIL_CALL:
 			if (imm32)
 				emit_bpf_tail_call_direct(&bpf_prog->aux->poke_tab[imm32 - 1],
-							  &prog, addrs[i], image,
+							  &prog, image + addrs[i - 1],
 							  callee_regs_used,
-							  bpf_prog->aux->stack_depth);
+							  bpf_prog->aux->stack_depth,
+							  ctx);
 			else
 				emit_bpf_tail_call_indirect(&prog,
 							    callee_regs_used,
-							    bpf_prog->aux->stack_depth);
+							    bpf_prog->aux->stack_depth,
+							    image + addrs[i - 1],
+							    ctx);
 			break;
=20
 			/* cond jump */
@@ -2124,24 +2102,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image=
 *im, void *image, void *i
 	return ret;
 }
=20
-static int emit_fallback_jump(u8 **pprog)
-{
-	u8 *prog =3D *pprog;
-	int err =3D 0;
-
-#ifdef CONFIG_RETPOLINE
-	/* Note that this assumes the the compiler uses external
-	 * thunks for indirect calls. Both clang and GCC use the same
-	 * naming convention for external thunks.
-	 */
-	err =3D emit_jump(&prog, __x86_indirect_thunk_rdx, prog);
-#else
-	EMIT2(0xFF, 0xE2);	/* jmp rdx */
-#endif
-	*pprog =3D prog;
-	return err;
-}
-
 static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
 {
 	u8 *jg_reloc, *prog =3D *pprog;
@@ -2163,9 +2123,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b=
, s64 *progs)
 		if (err)
 			return err;
=20
-		err =3D emit_fallback_jump(&prog);	/* jmp thunk/indirect */
-		if (err)
-			return err;
+		emit_indirect_jump(&prog, 2 /* rdx */, prog);
=20
 		*pprog =3D prog;
 		return 0;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 3bfda5f502cb..da9b7cfa4632 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -15,6 +15,7 @@
 #include <asm/cacheflush.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
+#include <asm/asm-prototypes.h>
 #include <linux/bpf.h>
=20
 /*
@@ -1267,6 +1268,21 @@ static void emit_epilogue(u8 **pprog, u32 stack_depth)
 	*pprog =3D prog;
 }
=20
+static int emit_jmp_edx(u8 **pprog, u8 *ip)
+{
+	u8 *prog =3D *pprog;
+	int cnt =3D 0;
+
+#ifdef CONFIG_RETPOLINE
+	EMIT1_off32(0xE9, (u8 *)__x86_indirect_thunk_edx - (ip + 5));
+#else
+	EMIT2(0xFF, 0xE2);
+#endif
+	*pprog =3D prog;
+
+	return cnt;
+}
+
 /*
  * Generate the following code:
  * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
@@ -1280,7 +1296,7 @@ static void emit_epilogue(u8 **pprog, u32 stack_depth)
  *   goto *(prog->bpf_func + prologue_size);
  * out:
  */
-static void emit_bpf_tail_call(u8 **pprog)
+static void emit_bpf_tail_call(u8 **pprog, u8 *ip)
 {
 	u8 *prog =3D *pprog;
 	int cnt =3D 0;
@@ -1362,7 +1378,7 @@ static void emit_bpf_tail_call(u8 **pprog)
 	 * eax =3D=3D ctx (1st arg)
 	 * edx =3D=3D prog->bpf_func + prologue_size
 	 */
-	RETPOLINE_EDX_BPF_JIT();
+	cnt +=3D emit_jmp_edx(&prog, ip + cnt);
=20
 	if (jmp_label1 =3D=3D -1)
 		jmp_label1 =3D cnt;
@@ -2122,7 +2138,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs=
, u8 *image,
 			break;
 		}
 		case BPF_JMP | BPF_TAIL_CALL:
-			emit_bpf_tail_call(&prog);
+			emit_bpf_tail_call(&prog, image + addrs[i - 1]);
 			break;
=20
 		/* cond jump */
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 6e0d0754f94f..6cf3c379bbaa 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -311,12 +311,12 @@ static void __init xen_init_capabilities(void)
 	}
 }
=20
-static void xen_set_debugreg(int reg, unsigned long val)
+static noinstr void xen_set_debugreg(int reg, unsigned long val)
 {
 	HYPERVISOR_set_debugreg(reg, val);
 }
=20
-static unsigned long xen_get_debugreg(int reg)
+static noinstr unsigned long xen_get_debugreg(int reg)
 {
 	return HYPERVISOR_get_debugreg(reg);
 }
@@ -1053,52 +1053,54 @@ static const struct pv_info xen_info __initconst =3D {
 	.name =3D "Xen",
 };
=20
-static const struct pv_cpu_ops xen_cpu_ops __initconst =3D {
-	.cpuid =3D xen_cpuid,
+static const typeof(pv_ops) xen_cpu_ops __initconst =3D {
+	.cpu =3D {
+		.cpuid =3D xen_cpuid,
=20
-	.set_debugreg =3D xen_set_debugreg,
-	.get_debugreg =3D xen_get_debugreg,
+		.set_debugreg =3D xen_set_debugreg,
+		.get_debugreg =3D xen_get_debugreg,
=20
-	.read_cr0 =3D xen_read_cr0,
-	.write_cr0 =3D xen_write_cr0,
+		.read_cr0 =3D xen_read_cr0,
+		.write_cr0 =3D xen_write_cr0,
=20
-	.write_cr4 =3D xen_write_cr4,
+		.write_cr4 =3D xen_write_cr4,
=20
-	.wbinvd =3D native_wbinvd,
+		.wbinvd =3D native_wbinvd,
=20
-	.read_msr =3D xen_read_msr,
-	.write_msr =3D xen_write_msr,
+		.read_msr =3D xen_read_msr,
+		.write_msr =3D xen_write_msr,
=20
-	.read_msr_safe =3D xen_read_msr_safe,
-	.write_msr_safe =3D xen_write_msr_safe,
+		.read_msr_safe =3D xen_read_msr_safe,
+		.write_msr_safe =3D xen_write_msr_safe,
=20
-	.read_pmc =3D xen_read_pmc,
+		.read_pmc =3D xen_read_pmc,
=20
-	.load_tr_desc =3D paravirt_nop,
-	.set_ldt =3D xen_set_ldt,
-	.load_gdt =3D xen_load_gdt,
-	.load_idt =3D xen_load_idt,
-	.load_tls =3D xen_load_tls,
-	.load_gs_index =3D xen_load_gs_index,
+		.load_tr_desc =3D paravirt_nop,
+		.set_ldt =3D xen_set_ldt,
+		.load_gdt =3D xen_load_gdt,
+		.load_idt =3D xen_load_idt,
+		.load_tls =3D xen_load_tls,
+		.load_gs_index =3D xen_load_gs_index,
=20
-	.alloc_ldt =3D xen_alloc_ldt,
-	.free_ldt =3D xen_free_ldt,
+		.alloc_ldt =3D xen_alloc_ldt,
+		.free_ldt =3D xen_free_ldt,
=20
-	.store_tr =3D xen_store_tr,
+		.store_tr =3D xen_store_tr,
=20
-	.write_ldt_entry =3D xen_write_ldt_entry,
-	.write_gdt_entry =3D xen_write_gdt_entry,
-	.write_idt_entry =3D xen_write_idt_entry,
-	.load_sp0 =3D xen_load_sp0,
+		.write_ldt_entry =3D xen_write_ldt_entry,
+		.write_gdt_entry =3D xen_write_gdt_entry,
+		.write_idt_entry =3D xen_write_idt_entry,
+		.load_sp0 =3D xen_load_sp0,
=20
 #ifdef CONFIG_X86_IOPL_IOPERM
-	.invalidate_io_bitmap =3D xen_invalidate_io_bitmap,
-	.update_io_bitmap =3D xen_update_io_bitmap,
+		.invalidate_io_bitmap =3D xen_invalidate_io_bitmap,
+		.update_io_bitmap =3D xen_update_io_bitmap,
 #endif
-	.io_delay =3D xen_io_delay,
+		.io_delay =3D xen_io_delay,
=20
-	.start_context_switch =3D paravirt_start_context_switch,
-	.end_context_switch =3D xen_end_context_switch,
+		.start_context_switch =3D paravirt_start_context_switch,
+		.end_context_switch =3D xen_end_context_switch,
+	},
 };
=20
 static void xen_restart(char *msg)
@@ -1239,7 +1241,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
=20
 	/* Install Xen paravirt ops */
 	pv_info =3D xen_info;
-	pv_ops.cpu =3D xen_cpu_ops;
+	pv_ops.cpu =3D xen_cpu_ops.cpu;
 	paravirt_iret =3D xen_iret;
 	xen_init_irq_ops();
=20
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index dfa091d79c2e..4fe387e520af 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -19,12 +19,12 @@
  * callback mask. We do this in a very simple manner, by making a call
  * down into Xen. The pending flag will be checked by Xen on return.
  */
-void xen_force_evtchn_callback(void)
+noinstr void xen_force_evtchn_callback(void)
 {
 	(void)HYPERVISOR_xen_version(0, NULL);
 }
=20
-asmlinkage __visible unsigned long xen_save_fl(void)
+asmlinkage __visible noinstr unsigned long xen_save_fl(void)
 {
 	struct vcpu_info *vcpu;
 	unsigned long flags;
@@ -40,9 +40,9 @@ asmlinkage __visible unsigned long xen_save_fl(void)
 	*/
 	return (-flags) & X86_EFLAGS_IF;
 }
-PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl);
+__PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl, ".noinstr.text");
=20
-asmlinkage __visible void xen_irq_disable(void)
+asmlinkage __visible noinstr void xen_irq_disable(void)
 {
 	/* There's a one instruction preempt window here.  We need to
 	   make sure we're don't switch CPUs between getting the vcpu
@@ -51,9 +51,9 @@ asmlinkage __visible void xen_irq_disable(void)
 	this_cpu_read(xen_vcpu)->evtchn_upcall_mask =3D 1;
 	preempt_enable_no_resched();
 }
-PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable);
+__PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable, ".noinstr.text");
=20
-asmlinkage __visible void xen_irq_enable(void)
+asmlinkage __visible noinstr void xen_irq_enable(void)
 {
 	struct vcpu_info *vcpu;
=20
@@ -76,7 +76,7 @@ asmlinkage __visible void xen_irq_enable(void)
=20
 	preempt_enable();
 }
-PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable);
+__PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable, ".noinstr.text");
=20
 static void xen_safe_halt(void)
 {
@@ -94,17 +94,20 @@ static void xen_halt(void)
 		xen_safe_halt();
 }
=20
-static const struct pv_irq_ops xen_irq_ops __initconst =3D {
-	.save_fl =3D PV_CALLEE_SAVE(xen_save_fl),
-	.irq_disable =3D PV_CALLEE_SAVE(xen_irq_disable),
-	.irq_enable =3D PV_CALLEE_SAVE(xen_irq_enable),
+static const typeof(pv_ops) xen_irq_ops __initconst =3D {
+	.irq =3D {
=20
-	.safe_halt =3D xen_safe_halt,
-	.halt =3D xen_halt,
+		.save_fl =3D PV_CALLEE_SAVE(xen_save_fl),
+		.irq_disable =3D PV_CALLEE_SAVE(xen_irq_disable),
+		.irq_enable =3D PV_CALLEE_SAVE(xen_irq_enable),
+
+		.safe_halt =3D xen_safe_halt,
+		.halt =3D xen_halt,
+	},
 };
=20
 void __init xen_init_irq_ops(void)
 {
-	pv_ops.irq =3D xen_irq_ops;
+	pv_ops.irq =3D xen_irq_ops.irq;
 	x86_init.irqs.intr_init =3D xen_init_IRQ;
 }
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 8d751939c6f3..823660738bad 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1204,7 +1204,8 @@ static void __init xen_pagetable_init(void)
 	xen_remap_memory();
 	xen_setup_mfn_list_list();
 }
-static void xen_write_cr2(unsigned long cr2)
+
+static noinstr void xen_write_cr2(unsigned long cr2)
 {
 	this_cpu_read(xen_vcpu)->arch.cr2 =3D cr2;
 }
@@ -2078,67 +2079,69 @@ static void xen_leave_lazy_mmu(void)
 	preempt_enable();
 }
=20
-static const struct pv_mmu_ops xen_mmu_ops __initconst =3D {
-	.read_cr2 =3D __PV_IS_CALLEE_SAVE(xen_read_cr2),
-	.write_cr2 =3D xen_write_cr2,
+static const typeof(pv_ops) xen_mmu_ops __initconst =3D {
+	.mmu =3D {
+		.read_cr2 =3D __PV_IS_CALLEE_SAVE(xen_read_cr2),
+		.write_cr2 =3D xen_write_cr2,
=20
-	.read_cr3 =3D xen_read_cr3,
-	.write_cr3 =3D xen_write_cr3_init,
+		.read_cr3 =3D xen_read_cr3,
+		.write_cr3 =3D xen_write_cr3_init,
=20
-	.flush_tlb_user =3D xen_flush_tlb,
-	.flush_tlb_kernel =3D xen_flush_tlb,
-	.flush_tlb_one_user =3D xen_flush_tlb_one_user,
-	.flush_tlb_multi =3D xen_flush_tlb_multi,
-	.tlb_remove_table =3D tlb_remove_table,
+		.flush_tlb_user =3D xen_flush_tlb,
+		.flush_tlb_kernel =3D xen_flush_tlb,
+		.flush_tlb_one_user =3D xen_flush_tlb_one_user,
+		.flush_tlb_multi =3D xen_flush_tlb_multi,
+		.tlb_remove_table =3D tlb_remove_table,
=20
-	.pgd_alloc =3D xen_pgd_alloc,
-	.pgd_free =3D xen_pgd_free,
+		.pgd_alloc =3D xen_pgd_alloc,
+		.pgd_free =3D xen_pgd_free,
=20
-	.alloc_pte =3D xen_alloc_pte_init,
-	.release_pte =3D xen_release_pte_init,
-	.alloc_pmd =3D xen_alloc_pmd_init,
-	.release_pmd =3D xen_release_pmd_init,
+		.alloc_pte =3D xen_alloc_pte_init,
+		.release_pte =3D xen_release_pte_init,
+		.alloc_pmd =3D xen_alloc_pmd_init,
+		.release_pmd =3D xen_release_pmd_init,
=20
-	.set_pte =3D xen_set_pte_init,
-	.set_pmd =3D xen_set_pmd_hyper,
+		.set_pte =3D xen_set_pte_init,
+		.set_pmd =3D xen_set_pmd_hyper,
=20
-	.ptep_modify_prot_start =3D xen_ptep_modify_prot_start,
-	.ptep_modify_prot_commit =3D xen_ptep_modify_prot_commit,
+		.ptep_modify_prot_start =3D xen_ptep_modify_prot_start,
+		.ptep_modify_prot_commit =3D xen_ptep_modify_prot_commit,
=20
-	.pte_val =3D PV_CALLEE_SAVE(xen_pte_val),
-	.pgd_val =3D PV_CALLEE_SAVE(xen_pgd_val),
+		.pte_val =3D PV_CALLEE_SAVE(xen_pte_val),
+		.pgd_val =3D PV_CALLEE_SAVE(xen_pgd_val),
=20
-	.make_pte =3D PV_CALLEE_SAVE(xen_make_pte_init),
-	.make_pgd =3D PV_CALLEE_SAVE(xen_make_pgd),
+		.make_pte =3D PV_CALLEE_SAVE(xen_make_pte_init),
+		.make_pgd =3D PV_CALLEE_SAVE(xen_make_pgd),
=20
-	.set_pud =3D xen_set_pud_hyper,
+		.set_pud =3D xen_set_pud_hyper,
=20
-	.make_pmd =3D PV_CALLEE_SAVE(xen_make_pmd),
-	.pmd_val =3D PV_CALLEE_SAVE(xen_pmd_val),
+		.make_pmd =3D PV_CALLEE_SAVE(xen_make_pmd),
+		.pmd_val =3D PV_CALLEE_SAVE(xen_pmd_val),
=20
-	.pud_val =3D PV_CALLEE_SAVE(xen_pud_val),
-	.make_pud =3D PV_CALLEE_SAVE(xen_make_pud),
-	.set_p4d =3D xen_set_p4d_hyper,
+		.pud_val =3D PV_CALLEE_SAVE(xen_pud_val),
+		.make_pud =3D PV_CALLEE_SAVE(xen_make_pud),
+		.set_p4d =3D xen_set_p4d_hyper,
=20
-	.alloc_pud =3D xen_alloc_pmd_init,
-	.release_pud =3D xen_release_pmd_init,
+		.alloc_pud =3D xen_alloc_pmd_init,
+		.release_pud =3D xen_release_pmd_init,
=20
 #if CONFIG_PGTABLE_LEVELS >=3D 5
-	.p4d_val =3D PV_CALLEE_SAVE(xen_p4d_val),
-	.make_p4d =3D PV_CALLEE_SAVE(xen_make_p4d),
+		.p4d_val =3D PV_CALLEE_SAVE(xen_p4d_val),
+		.make_p4d =3D PV_CALLEE_SAVE(xen_make_p4d),
 #endif
=20
-	.activate_mm =3D xen_activate_mm,
-	.dup_mmap =3D xen_dup_mmap,
-	.exit_mmap =3D xen_exit_mmap,
+		.activate_mm =3D xen_activate_mm,
+		.dup_mmap =3D xen_dup_mmap,
+		.exit_mmap =3D xen_exit_mmap,
=20
-	.lazy_mode =3D {
-		.enter =3D paravirt_enter_lazy_mmu,
-		.leave =3D xen_leave_lazy_mmu,
-		.flush =3D paravirt_flush_lazy_mmu,
-	},
+		.lazy_mode =3D {
+			.enter =3D paravirt_enter_lazy_mmu,
+			.leave =3D xen_leave_lazy_mmu,
+			.flush =3D paravirt_flush_lazy_mmu,
+		},
=20
-	.set_fixmap =3D xen_set_fixmap,
+		.set_fixmap =3D xen_set_fixmap,
+	},
 };
=20
 void __init xen_init_mmu_ops(void)
@@ -2146,7 +2149,7 @@ void __init xen_init_mmu_ops(void)
 	x86_init.paging.pagetable_init =3D xen_pagetable_init;
 	x86_init.hyper.init_after_bootmem =3D xen_after_bootmem;
=20
-	pv_ops.mmu =3D xen_mmu_ops;
+	pv_ops.mmu =3D xen_mmu_ops.mmu;
=20
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 1e626444712b..220dd9678494 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -21,6 +21,45 @@
 #include <linux/init.h>
 #include <linux/linkage.h>
=20
+.pushsection .noinstr.text, "ax"
+/*
+ * Disabling events is simply a matter of making the event mask
+ * non-zero.
+ */
+SYM_FUNC_START(xen_irq_disable_direct)
+	movb $1, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+	ret
+SYM_FUNC_END(xen_irq_disable_direct)
+
+/*
+ * Force an event check by making a hypercall, but preserve regs
+ * before making the call.
+ */
+SYM_FUNC_START(check_events)
+	FRAME_BEGIN
+	push %rax
+	push %rcx
+	push %rdx
+	push %rsi
+	push %rdi
+	push %r8
+	push %r9
+	push %r10
+	push %r11
+	call xen_force_evtchn_callback
+	pop %r11
+	pop %r10
+	pop %r9
+	pop %r8
+	pop %rdi
+	pop %rsi
+	pop %rdx
+	pop %rcx
+	pop %rax
+	FRAME_END
+	ret
+SYM_FUNC_END(check_events)
+
 /*
  * Enable events.  This clears the event mask and tests the pending
  * event status with one and operation.  If there are pending events,
@@ -47,16 +86,6 @@ SYM_FUNC_START(xen_irq_enable_direct)
 	ret
 SYM_FUNC_END(xen_irq_enable_direct)
=20
-
-/*
- * Disabling events is simply a matter of making the event mask
- * non-zero.
- */
-SYM_FUNC_START(xen_irq_disable_direct)
-	movb $1, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
-	ret
-SYM_FUNC_END(xen_irq_disable_direct)
-
 /*
  * (xen_)save_fl is used to get the current interrupt enable status.
  * Callers expect the status to be in X86_EFLAGS_IF, and other bits
@@ -73,35 +102,6 @@ SYM_FUNC_START(xen_save_fl_direct)
 	ret
 SYM_FUNC_END(xen_save_fl_direct)
=20
-/*
- * Force an event check by making a hypercall, but preserve regs
- * before making the call.
- */
-SYM_FUNC_START(check_events)
-	FRAME_BEGIN
-	push %rax
-	push %rcx
-	push %rdx
-	push %rsi
-	push %rdi
-	push %r8
-	push %r9
-	push %r10
-	push %r11
-	call xen_force_evtchn_callback
-	pop %r11
-	pop %r10
-	pop %r9
-	pop %r8
-	pop %rdi
-	pop %rsi
-	pop %rdx
-	pop %rcx
-	pop %rax
-	FRAME_END
-	ret
-SYM_FUNC_END(check_events)
-
 SYM_FUNC_START(xen_read_cr2)
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
@@ -116,6 +116,7 @@ SYM_FUNC_START(xen_read_cr2_direct)
 	FRAME_END
 	ret
 SYM_FUNC_END(xen_read_cr2_direct);
+.popsection
=20
 .macro xen_pv_trap name
 SYM_CODE_START(xen_\name)
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index cb6538ae2fe0..9e27b86a0c31 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -20,6 +20,23 @@
 #include <xen/interface/xen-mca.h>
 #include <asm/xen/interface.h>
=20
+.pushsection .noinstr.text, "ax"
+	.balign PAGE_SIZE
+SYM_CODE_START(hypercall_page)
+	.rept (PAGE_SIZE / 32)
+		UNWIND_HINT_FUNC
+		.skip 31, 0x90
+		ret
+	.endr
+
+#define HYPERCALL(n) \
+	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
+	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
+#include <asm/xen-hypercalls.h>
+#undef HYPERCALL
+SYM_CODE_END(hypercall_page)
+.popsection
+
 #ifdef CONFIG_XEN_PV
 	__INIT
 SYM_CODE_START(startup_xen)
@@ -64,23 +81,6 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
 #endif
 #endif
=20
-.pushsection .text
-	.balign PAGE_SIZE
-SYM_CODE_START(hypercall_page)
-	.rept (PAGE_SIZE / 32)
-		UNWIND_HINT_FUNC
-		.skip 31, 0x90
-		ret
-	.endr
-
-#define HYPERCALL(n) \
-	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
-	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
-#include <asm/xen-hypercalls.h>
-#undef HYPERCALL
-SYM_CODE_END(hypercall_page)
-.popsection
-
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
 	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
diff --git a/include/linux/context_tracking.h b/include/linux/context_trackin=
g.h
index 4d7fced3a39f..7a14807c9d1a 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -105,7 +105,7 @@ static inline void user_exit_irqoff(void) { }
 static inline enum ctx_state exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
-static inline bool context_tracking_guest_enter(void) { return false; }
+static __always_inline bool context_tracking_guest_enter(void) { return fals=
e; }
 static inline void context_tracking_guest_exit(void) { }
=20
 #endif /* !CONFIG_CONTEXT_TRACKING */
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bf1c00c881e4..8a509672a4cc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -888,7 +888,7 @@ look_up_lock_class(const struct lockdep_map *lock, unsign=
ed int subclass)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return NULL;
=20
-	hlist_for_each_entry_rcu(class, hash_head, hash_entry) {
+	hlist_for_each_entry_rcu_notrace(class, hash_head, hash_entry) {
 		if (class->key =3D=3D key) {
 			/*
 			 * Huh! same key, different name? Did someone trample
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2a9b6dcdac4f..40e4766bc541 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -458,7 +458,7 @@ config STACK_VALIDATION
=20
 config VMLINUX_VALIDATION
 	bool
-	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
+	depends on STACK_VALIDATION && DEBUG_ENTRY
 	default y
=20
 config VMLINUX_MAP
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 0893436cc09f..4d6d7fc13255 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -20,6 +20,7 @@
 #include <objtool/arch.h>
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
+#include <objtool/builtin.h>
 #include <arch/elf.h>
=20
 static int is_x86_64(const struct elf *elf)
@@ -102,12 +103,13 @@ unsigned long arch_jump_destination(struct instruction =
*insn)
 #define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))
 #define rm_is_reg(reg)	(mod_is_reg() && modrm_rm =3D=3D (reg))
=20
-int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+int arch_decode_instruction(struct objtool_file *file, const struct section =
*sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
 			    struct list_head *ops_list)
 {
+	const struct elf *elf =3D file->elf;
 	struct insn insn;
 	int x86_64, ret;
 	unsigned char op1, op2,
@@ -544,6 +546,36 @@ int arch_decode_instruction(const struct elf *elf, const=
 struct section *sec,
 		*type =3D INSN_RETURN;
 		break;
=20
+	case 0xc7: /* mov imm, r/m */
+		if (!noinstr)
+			break;
+
+		if (insn.length =3D=3D 3+4+4 && !strncmp(sec->name, ".init.text", 10)) {
+			struct reloc *immr, *disp;
+			struct symbol *func;
+			int idx;
+
+			immr =3D find_reloc_by_dest(elf, (void *)sec, offset+3);
+			disp =3D find_reloc_by_dest(elf, (void *)sec, offset+7);
+
+			if (!immr || strcmp(immr->sym->name, "pv_ops"))
+				break;
+
+			idx =3D (immr->addend + 8) / sizeof(void *);
+
+			func =3D disp->sym;
+			if (disp->sym->type =3D=3D STT_SECTION)
+				func =3D find_symbol_by_offset(disp->sym->sec, disp->addend);
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
@@ -659,154 +691,52 @@ const char *arch_nop_insn(int len)
 	return nops[len-1];
 }
=20
-/* asm/alternative.h ? */
-
-#define ALTINSTR_FLAG_INV	(1 << 15)
-#define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
-
-struct alt_instr {
-	s32 instr_offset;	/* original instruction */
-	s32 repl_offset;	/* offset to replacement instruction */
-	u16 cpuid;		/* cpuid bit set for replacement */
-	u8  instrlen;		/* length of original instruction */
-	u8  replacementlen;	/* length of new instruction */
-} __packed;
-
-static int elf_add_alternative(struct elf *elf,
-			       struct instruction *orig, struct symbol *sym,
-			       int cpuid, u8 orig_len, u8 repl_len)
-{
-	const int size =3D sizeof(struct alt_instr);
-	struct alt_instr *alt;
-	struct section *sec;
-	Elf_Scn *s;
-
-	sec =3D find_section_by_name(elf, ".altinstructions");
-	if (!sec) {
-		sec =3D elf_create_section(elf, ".altinstructions",
-					 SHF_ALLOC, 0, 0);
-
-		if (!sec) {
-			WARN_ELF("elf_create_section");
-			return -1;
-		}
-	}
-
-	s =3D elf_getscn(elf->elf, sec->idx);
-	if (!s) {
-		WARN_ELF("elf_getscn");
-		return -1;
-	}
-
-	sec->data =3D elf_newdata(s);
-	if (!sec->data) {
-		WARN_ELF("elf_newdata");
-		return -1;
-	}
-
-	sec->data->d_size =3D size;
-	sec->data->d_align =3D 1;
-
-	alt =3D sec->data->d_buf =3D malloc(size);
-	if (!sec->data->d_buf) {
-		perror("malloc");
-		return -1;
-	}
-	memset(sec->data->d_buf, 0, size);
-
-	if (elf_add_reloc_to_insn(elf, sec, sec->sh.sh_size,
-				  R_X86_64_PC32, orig->sec, orig->offset)) {
-		WARN("elf_create_reloc: alt_instr::instr_offset");
-		return -1;
-	}
-
-	if (elf_add_reloc(elf, sec, sec->sh.sh_size + 4,
-			  R_X86_64_PC32, sym, 0)) {
-		WARN("elf_create_reloc: alt_instr::repl_offset");
-		return -1;
-	}
-
-	alt->cpuid =3D bswap_if_needed(cpuid);
-	alt->instrlen =3D orig_len;
-	alt->replacementlen =3D repl_len;
-
-	sec->sh.sh_size +=3D size;
-	sec->changed =3D true;
-
-	return 0;
-}
-
-#define X86_FEATURE_RETPOLINE                ( 7*32+12)
+#define BYTE_RET	0xC3
=20
-int arch_rewrite_retpolines(struct objtool_file *file)
+const char *arch_ret_insn(int len)
 {
-	struct instruction *insn;
-	struct reloc *reloc;
-	struct symbol *sym;
-	char name[32] =3D "";
-
-	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
-
-		if (insn->type !=3D INSN_JUMP_DYNAMIC &&
-		    insn->type !=3D INSN_CALL_DYNAMIC)
-			continue;
-
-		if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
-			continue;
-
-		reloc =3D insn->reloc;
-
-		sprintf(name, "__x86_indirect_alt_%s_%s",
-			insn->type =3D=3D INSN_JUMP_DYNAMIC ? "jmp" : "call",
-			reloc->sym->name + 21);
-
-		sym =3D find_symbol_by_name(file->elf, name);
-		if (!sym) {
-			sym =3D elf_create_undef_symbol(file->elf, name);
-			if (!sym) {
-				WARN("elf_create_undef_symbol");
-				return -1;
-			}
-		}
+	static const char ret[5][5] =3D {
+		{ BYTE_RET },
+		{ BYTE_RET, BYTES_NOP1 },
+		{ BYTE_RET, BYTES_NOP2 },
+		{ BYTE_RET, BYTES_NOP3 },
+		{ BYTE_RET, BYTES_NOP4 },
+	};
=20
-		if (elf_add_alternative(file->elf, insn, sym,
-					ALT_NOT(X86_FEATURE_RETPOLINE), 5, 5)) {
-			WARN("elf_add_alternative");
-			return -1;
-		}
+	if (len < 1 || len > 5) {
+		WARN("invalid RET size: %d\n", len);
+		return NULL;
 	}
=20
-	return 0;
+	return ret[len-1];
 }
=20
-int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
+int arch_decode_hint_reg(u8 sp_reg, int *base)
 {
-	struct cfi_reg *cfa =3D &insn->cfi.cfa;
-
 	switch (sp_reg) {
 	case ORC_REG_UNDEFINED:
-		cfa->base =3D CFI_UNDEFINED;
+		*base =3D CFI_UNDEFINED;
 		break;
 	case ORC_REG_SP:
-		cfa->base =3D CFI_SP;
+		*base =3D CFI_SP;
 		break;
 	case ORC_REG_BP:
-		cfa->base =3D CFI_BP;
+		*base =3D CFI_BP;
 		break;
 	case ORC_REG_SP_INDIRECT:
-		cfa->base =3D CFI_SP_INDIRECT;
+		*base =3D CFI_SP_INDIRECT;
 		break;
 	case ORC_REG_R10:
-		cfa->base =3D CFI_R10;
+		*base =3D CFI_R10;
 		break;
 	case ORC_REG_R13:
-		cfa->base =3D CFI_R13;
+		*base =3D CFI_R13;
 		break;
 	case ORC_REG_DI:
-		cfa->base =3D CFI_DI;
+		*base =3D CFI_DI;
 		break;
 	case ORC_REG_DX:
-		cfa->base =3D CFI_DX;
+		*base =3D CFI_DX;
 		break;
 	default:
 		return -1;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 06b5c164ae93..fb3f251ea021 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -5,6 +5,7 @@
=20
 #include <string.h>
 #include <stdlib.h>
+#include <sys/mman.h>
=20
 #include <arch/elf.h>
 #include <objtool/builtin.h>
@@ -26,7 +27,11 @@ struct alternative {
 	bool skip_orig;
 };
=20
-struct cfi_init_state initial_func_cfi;
+static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
+
+static struct cfi_init_state initial_func_cfi;
+static struct cfi_state init_cfi;
+static struct cfi_state func_cfi;
=20
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
@@ -173,6 +178,7 @@ static bool __dead_end_function(struct objtool_file *file=
, struct symbol *func,
 		"rewind_stack_do_exit",
 		"kunit_try_catch_throw",
 		"xen_start_kernel",
+		"cpu_bringup_and_idle",
 	};
=20
 	if (!func)
@@ -265,6 +271,78 @@ static void init_insn_state(struct insn_state *state, st=
ruct section *sec)
 		state->noinstr =3D sec->noinstr;
 }
=20
+static struct cfi_state *cfi_alloc(void)
+{
+	struct cfi_state *cfi =3D calloc(sizeof(struct cfi_state), 1);
+	if (!cfi) {
+		WARN("calloc failed");
+		exit(1);
+	}
+	nr_cfi++;
+	return cfi;
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
+static struct cfi_state *cfi_hash_find_or_add(struct cfi_state *cfi)
+{
+	struct hlist_head *head =3D &cfi_hash[hash_min(cfi_key(cfi), cfi_bits)];
+	struct cfi_state *obj;
+
+	hlist_for_each_entry(obj, head, hash) {
+		if (!cficmp(cfi, obj)) {
+			nr_cfi_cache++;
+			return obj;
+		}
+	}
+
+	obj =3D cfi_alloc();
+	*obj =3D *cfi;
+	hlist_add_head(&obj->hash, head);
+
+	return obj;
+}
+
+static void cfi_hash_add(struct cfi_state *cfi)
+{
+	struct hlist_head *head =3D &cfi_hash[hash_min(cfi_key(cfi), cfi_bits)];
+
+	hlist_add_head(&cfi->hash, head);
+}
+
+static void *cfi_hash_alloc(unsigned long size)
+{
+	cfi_bits =3D max(10, ilog2(size));
+	cfi_hash =3D mmap(NULL, sizeof(struct hlist_head) << cfi_bits,
+			PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (cfi_hash =3D=3D (void *)-1L) {
+		WARN("mmap fail cfi_hash");
+		cfi_hash =3D NULL;
+	}  else if (stats) {
+		printf("cfi_bits: %d\n", cfi_bits);
+	}
+
+	return cfi_hash;
+}
+
+static unsigned long nr_insns;
+static unsigned long nr_insns_visited;
+
 /*
  * Call the arch-specific instruction decoder for all the instructions and a=
dd
  * them to the global instruction list.
@@ -275,7 +353,6 @@ static int decode_instructions(struct objtool_file *file)
 	struct symbol *func;
 	unsigned long offset;
 	struct instruction *insn;
-	unsigned long nr_insns =3D 0;
 	int ret;
=20
 	for_each_sec(file, sec) {
@@ -301,12 +378,11 @@ static int decode_instructions(struct objtool_file *fil=
e)
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
-			init_cfi_state(&insn->cfi);
=20
 			insn->sec =3D sec;
 			insn->offset =3D offset;
=20
-			ret =3D arch_decode_instruction(file->elf, sec, offset,
+			ret =3D arch_decode_instruction(file, sec, offset,
 						      sec->sh.sh_size - offset,
 						      &insn->len, &insn->type,
 						      &insn->immediate,
@@ -344,6 +420,82 @@ static int decode_instructions(struct objtool_file *file)
 	return ret;
 }
=20
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
+	sym =3D find_symbol_by_name(file->elf, symname);
+	if (!sym)
+		return 0;
+
+	off =3D sym->offset;
+	end =3D off + sym->len;
+	for (;;) {
+		rel =3D find_reloc_by_dest_range(file->elf, sym->sec, off, end - off);
+		if (!rel)
+			break;
+
+		func =3D rel->sym;
+		if (func->type =3D=3D STT_SECTION)
+			func =3D find_symbol_by_offset(rel->sym->sec, rel->addend);
+
+		idx =3D (rel->offset - sym->offset) / sizeof(unsigned long);
+
+		objtool_pv_add(file, idx, func);
+
+		off =3D rel->offset + 1;
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
+	static const char *pv_ops_tables[] =3D {
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
+	file->pv_ops =3D NULL;
+
+	sym =3D find_symbol_by_name(file->elf, "pv_ops");
+	if (!sym)
+		return 0;
+
+	nr =3D sym->len / sizeof(unsigned long);
+	file->pv_ops =3D calloc(sizeof(struct pv_state), nr);
+	if (!file->pv_ops)
+		return -1;
+
+	for (idx =3D 0; idx < nr; idx++)
+		INIT_LIST_HEAD(&file->pv_ops[idx].targets);
+
+	for (idx =3D 0; (pv_ops =3D pv_ops_tables[idx]); idx++)
+		add_pv_ops(file, pv_ops);
+
+	return 0;
+}
+
 static struct instruction *find_last_insn(struct objtool_file *file,
 					  struct section *sec)
 {
@@ -531,6 +683,52 @@ static int create_static_call_sections(struct objtool_fi=
le *file)
 	return 0;
 }
=20
+static int create_retpoline_sites_sections(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	int idx;
+
+	sec =3D find_section_by_name(file->elf, ".retpoline_sites");
+	if (sec) {
+		WARN("file already has .retpoline_sites, skipping");
+		return 0;
+	}
+
+	idx =3D 0;
+	list_for_each_entry(insn, &file->retpoline_call_list, call_node)
+		idx++;
+
+	if (!idx)
+		return 0;
+
+	sec =3D elf_create_section(file->elf, ".retpoline_sites", 0,
+				 sizeof(int), idx);
+	if (!sec) {
+		WARN("elf_create_section: .retpoline_sites");
+		return -1;
+	}
+
+	idx =3D 0;
+	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
+
+		int *site =3D (int *)sec->data->d_buf + idx;
+		*site =3D 0;
+
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(int),
+					  R_X86_64_PC32,
+					  insn->sec, insn->offset)) {
+			WARN("elf_add_reloc_to_insn: .retpoline_sites");
+			return -1;
+		}
+
+		idx++;
+	}
+
+	return 0;
+}
+
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
 	struct section *sec;
@@ -549,7 +747,7 @@ static int create_mcount_loc_sections(struct objtool_file=
 *file)
 		return 0;
=20
 	idx =3D 0;
-	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node)
+	list_for_each_entry(insn, &file->mcount_loc_list, call_node)
 		idx++;
=20
 	sec =3D elf_create_section(file->elf, "__mcount_loc", 0, sizeof(unsigned lo=
ng), idx);
@@ -557,7 +755,7 @@ static int create_mcount_loc_sections(struct objtool_file=
 *file)
 		return -1;
=20
 	idx =3D 0;
-	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node) {
+	list_for_each_entry(insn, &file->mcount_loc_list, call_node) {
=20
 		loc =3D (unsigned long *)sec->data->d_buf + idx;
 		memset(loc, 0, sizeof(unsigned long));
@@ -817,6 +1015,9 @@ static struct reloc *insn_reloc(struct objtool_file *fil=
e, struct instruction *i
 		return NULL;
=20
 	if (!insn->reloc) {
+		if (!file)
+			return NULL;
+
 		insn->reloc =3D find_reloc_by_dest_range(file->elf, insn->sec,
 						       insn->offset, insn->len);
 		if (!insn->reloc) {
@@ -828,6 +1029,136 @@ static struct reloc *insn_reloc(struct objtool_file *f=
ile, struct instruction *i
 	return insn->reloc;
 }
=20
+static void remove_insn_ops(struct instruction *insn)
+{
+	struct stack_op *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
+		list_del(&op->list);
+		free(op);
+	}
+}
+
+static void annotate_call_site(struct objtool_file *file,
+			       struct instruction *insn, bool sibling)
+{
+	struct reloc *reloc =3D insn_reloc(file, insn);
+	struct symbol *sym =3D insn->call_dest;
+
+	if (!sym)
+		sym =3D reloc->sym;
+
+	/*
+	 * Alternative replacement code is just template code which is
+	 * sometimes copied to the original instruction. For now, don't
+	 * annotate it. (In the future we might consider annotating the
+	 * original instruction if/when it ever makes sense to do so.)
+	 */
+	if (!strcmp(insn->sec->name, ".altinstr_replacement"))
+		return;
+
+	if (sym->static_call_tramp) {
+		list_add_tail(&insn->call_node, &file->static_call_list);
+		return;
+	}
+
+	if (sym->retpoline_thunk) {
+		list_add_tail(&insn->call_node, &file->retpoline_call_list);
+		return;
+	}
+
+	/*
+	 * Many compilers cannot disable KCOV with a function attribute
+	 * so they need a little help, NOP out any KCOV calls from noinstr
+	 * text.
+	 */
+	if (insn->sec->noinstr && sym->kcov) {
+		if (reloc) {
+			reloc->type =3D R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+
+		elf_write_insn(file->elf, insn->sec,
+			       insn->offset, insn->len,
+			       sibling ? arch_ret_insn(insn->len)
+			               : arch_nop_insn(insn->len));
+
+		insn->type =3D sibling ? INSN_RETURN : INSN_NOP;
+		return;
+	}
+
+	if (mcount && sym->fentry) {
+		if (sibling)
+			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
+
+		if (reloc) {
+			reloc->type =3D R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+
+		elf_write_insn(file->elf, insn->sec,
+			       insn->offset, insn->len,
+			       arch_nop_insn(insn->len));
+
+		insn->type =3D INSN_NOP;
+
+		list_add_tail(&insn->call_node, &file->mcount_loc_list);
+		return;
+	}
+}
+
+static void add_call_dest(struct objtool_file *file, struct instruction *ins=
n,
+			  struct symbol *dest, bool sibling)
+{
+	insn->call_dest =3D dest;
+	if (!dest)
+		return;
+
+	/*
+	 * Whatever stack impact regular CALLs have, should be undone
+	 * by the RETURN of the called function.
+	 *
+	 * Annotated intra-function calls retain the stack_ops but
+	 * are converted to JUMP, see read_intra_function_calls().
+	 */
+	remove_insn_ops(insn);
+
+	annotate_call_site(file, insn, sibling);
+}
+
+static void add_retpoline_call(struct objtool_file *file, struct instruction=
 *insn)
+{
+	/*
+	 * Retpoline calls/jumps are really dynamic calls/jumps in disguise,
+	 * so convert them accordingly.
+	 */
+	switch (insn->type) {
+	case INSN_CALL:
+		insn->type =3D INSN_CALL_DYNAMIC;
+		break;
+	case INSN_JUMP_UNCONDITIONAL:
+		insn->type =3D INSN_JUMP_DYNAMIC;
+		break;
+	case INSN_JUMP_CONDITIONAL:
+		insn->type =3D INSN_JUMP_DYNAMIC_CONDITIONAL;
+		break;
+	default:
+		return;
+	}
+
+	insn->retpoline_safe =3D true;
+
+	/*
+	 * Whatever stack impact regular CALLs have, should be undone
+	 * by the RETURN of the called function.
+	 *
+	 * Annotated intra-function calls retain the stack_ops but
+	 * are converted to JUMP, see read_intra_function_calls().
+	 */
+	remove_insn_ops(insn);
+
+	annotate_call_site(file, insn, false);
+}
 /*
  * Find the destination instructions for all jumps.
  */
@@ -849,28 +1180,12 @@ static int add_jump_destinations(struct objtool_file *=
file)
 		} else if (reloc->sym->type =3D=3D STT_SECTION) {
 			dest_sec =3D reloc->sym->sec;
 			dest_off =3D arch_dest_reloc_offset(reloc->addend);
-		} else if (arch_is_retpoline(reloc->sym)) {
-			/*
-			 * Retpoline jumps are really dynamic jumps in
-			 * disguise, so convert them accordingly.
-			 */
-			if (insn->type =3D=3D INSN_JUMP_UNCONDITIONAL)
-				insn->type =3D INSN_JUMP_DYNAMIC;
-			else
-				insn->type =3D INSN_JUMP_DYNAMIC_CONDITIONAL;
-
-			list_add_tail(&insn->call_node,
-				      &file->retpoline_call_list);
-
-			insn->retpoline_safe =3D true;
+		} else if (reloc->sym->retpoline_thunk) {
+			add_retpoline_call(file, insn);
 			continue;
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
-			insn->call_dest =3D reloc->sym;
-			if (insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->call_node,
-					      &file->static_call_list);
-			}
+			add_call_dest(file, insn, reloc->sym, true);
 			continue;
 		} else if (reloc->sym->sec->idx) {
 			dest_sec =3D reloc->sym->sec;
@@ -926,13 +1241,8 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
=20
 			} else if (insn->jump_dest->func->pfunc !=3D insn->func->pfunc &&
 				   insn->jump_dest->offset =3D=3D insn->jump_dest->func->offset) {
-
 				/* internal sibling call (without reloc) */
-				insn->call_dest =3D insn->jump_dest->func;
-				if (insn->call_dest->static_call_tramp) {
-					list_add_tail(&insn->call_node,
-						      &file->static_call_list);
-				}
+				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}
 		}
 	}
@@ -940,16 +1250,6 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
 	return 0;
 }
=20
-static void remove_insn_ops(struct instruction *insn)
-{
-	struct stack_op *op, *tmp;
-
-	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
-		list_del(&op->list);
-		free(op);
-	}
-}
-
 static struct symbol *find_call_destination(struct section *sec, unsigned lo=
ng offset)
 {
 	struct symbol *call_dest;
@@ -968,6 +1268,7 @@ static int add_call_destinations(struct objtool_file *fi=
le)
 {
 	struct instruction *insn;
 	unsigned long dest_off;
+	struct symbol *dest;
 	struct reloc *reloc;
=20
 	for_each_insn(file, insn) {
@@ -977,7 +1278,9 @@ static int add_call_destinations(struct objtool_file *fi=
le)
 		reloc =3D insn_reloc(file, insn);
 		if (!reloc) {
 			dest_off =3D arch_jump_destination(insn);
-			insn->call_dest =3D find_call_destination(insn->sec, dest_off);
+			dest =3D find_call_destination(insn->sec, dest_off);
+
+			add_call_dest(file, insn, dest, false);
=20
 			if (insn->ignore)
 				continue;
@@ -995,9 +1298,8 @@ static int add_call_destinations(struct objtool_file *fi=
le)
=20
 		} else if (reloc->sym->type =3D=3D STT_SECTION) {
 			dest_off =3D arch_dest_reloc_offset(reloc->addend);
-			insn->call_dest =3D find_call_destination(reloc->sym->sec,
-								dest_off);
-			if (!insn->call_dest) {
+			dest =3D find_call_destination(reloc->sym->sec, dest_off);
+			if (!dest) {
 				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  reloc->sym->sec->name,
@@ -1005,70 +1307,13 @@ static int add_call_destinations(struct objtool_file =
*file)
 				return -1;
 			}
=20
-		} else if (arch_is_retpoline(reloc->sym)) {
-			/*
-			 * Retpoline calls are really dynamic calls in
-			 * disguise, so convert them accordingly.
-			 */
-			insn->type =3D INSN_CALL_DYNAMIC;
-			insn->retpoline_safe =3D true;
+			add_call_dest(file, insn, dest, false);
=20
-			list_add_tail(&insn->call_node,
-				      &file->retpoline_call_list);
-
-			remove_insn_ops(insn);
-			continue;
+		} else if (reloc->sym->retpoline_thunk) {
+			add_retpoline_call(file, insn);
=20
 		} else
-			insn->call_dest =3D reloc->sym;
-
-		if (insn->call_dest && insn->call_dest->static_call_tramp) {
-			list_add_tail(&insn->call_node,
-				      &file->static_call_list);
-		}
-
-		/*
-		 * Many compilers cannot disable KCOV with a function attribute
-		 * so they need a little help, NOP out any KCOV calls from noinstr
-		 * text.
-		 */
-		if (insn->sec->noinstr &&
-		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
-			if (reloc) {
-				reloc->type =3D R_NONE;
-				elf_write_reloc(file->elf, reloc);
-			}
-
-			elf_write_insn(file->elf, insn->sec,
-				       insn->offset, insn->len,
-				       arch_nop_insn(insn->len));
-			insn->type =3D INSN_NOP;
-		}
-
-		if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
-			if (reloc) {
-				reloc->type =3D R_NONE;
-				elf_write_reloc(file->elf, reloc);
-			}
-
-			elf_write_insn(file->elf, insn->sec,
-				       insn->offset, insn->len,
-				       arch_nop_insn(insn->len));
-
-			insn->type =3D INSN_NOP;
-
-			list_add_tail(&insn->mcount_loc_node,
-				      &file->mcount_loc_list);
-		}
-
-		/*
-		 * Whatever stack impact regular CALLs have, should be undone
-		 * by the RETURN of the called function.
-		 *
-		 * Annotated intra-function calls retain the stack_ops but
-		 * are converted to JUMP, see read_intra_function_calls().
-		 */
-		remove_insn_ops(insn);
+			add_call_dest(file, insn, reloc->sym, false);
 	}
=20
 	return 0;
@@ -1136,7 +1381,6 @@ static int handle_group_alt(struct objtool_file *file,
 		memset(nop, 0, sizeof(*nop));
 		INIT_LIST_HEAD(&nop->alts);
 		INIT_LIST_HEAD(&nop->stack_ops);
-		init_cfi_state(&nop->cfi);
=20
 		nop->sec =3D special_alt->new_sec;
 		nop->offset =3D special_alt->new_off + special_alt->new_len;
@@ -1545,10 +1789,11 @@ static void set_func_state(struct cfi_state *state)
=20
 static int read_unwind_hints(struct objtool_file *file)
 {
+	struct cfi_state cfi =3D init_cfi;
 	struct section *sec, *relocsec;
-	struct reloc *reloc;
 	struct unwind_hint *hint;
 	struct instruction *insn;
+	struct reloc *reloc;
 	int i;
=20
 	sec =3D find_section_by_name(file->elf, ".discard.unwind_hints");
@@ -1586,19 +1831,24 @@ static int read_unwind_hints(struct objtool_file *fil=
e)
 		insn->hint =3D true;
=20
 		if (hint->type =3D=3D UNWIND_HINT_TYPE_FUNC) {
-			set_func_state(&insn->cfi);
+			insn->cfi =3D &func_cfi;
 			continue;
 		}
=20
-		if (arch_decode_hint_reg(insn, hint->sp_reg)) {
+		if (insn->cfi)
+			cfi =3D *(insn->cfi);
+
+		if (arch_decode_hint_reg(hint->sp_reg, &cfi.cfa.base)) {
 			WARN_FUNC("unsupported unwind_hint sp base reg %d",
 				  insn->sec, insn->offset, hint->sp_reg);
 			return -1;
 		}
=20
-		insn->cfi.cfa.offset =3D bswap_if_needed(hint->sp_offset);
-		insn->cfi.type =3D hint->type;
-		insn->cfi.end =3D hint->end;
+		cfi.cfa.offset =3D bswap_if_needed(hint->sp_offset);
+		cfi.type =3D hint->type;
+		cfi.end =3D hint->end;
+
+		insn->cfi =3D cfi_hash_find_or_add(&cfi);
 	}
=20
 	return 0;
@@ -1737,17 +1987,28 @@ static int read_intra_function_calls(struct objtool_f=
ile *file)
 	return 0;
 }
=20
-static int read_static_call_tramps(struct objtool_file *file)
+static int classify_symbols(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
=20
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->bind =3D=3D STB_GLOBAL &&
-			    !strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
+			if (func->bind !=3D STB_GLOBAL)
+				continue;
+
+			if (!strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
 				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
 				func->static_call_tramp =3D true;
+
+			if (arch_is_retpoline(func))
+				func->retpoline_thunk =3D true;
+
+			if (!strcmp(func->name, "__fentry__"))
+				func->fentry =3D true;
+
+			if (!strncmp(func->name, "__sanitizer_cov_", 16))
+				func->kcov =3D true;
 		}
 	}
=20
@@ -1780,17 +2041,16 @@ static void mark_rodata(struct objtool_file *file)
 	file->rodata =3D found;
 }
=20
-__weak int arch_rewrite_retpolines(struct objtool_file *file)
-{
-	return 0;
-}
-
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
=20
 	mark_rodata(file);
=20
+	ret =3D init_pv_ops(file);
+	if (ret)
+		return ret;
+
 	ret =3D decode_instructions(file);
 	if (ret)
 		return ret;
@@ -1809,7 +2069,7 @@ static int decode_sections(struct objtool_file *file)
 	/*
 	 * Must be before add_{jump_call}_destination.
 	 */
-	ret =3D read_static_call_tramps(file);
+	ret =3D classify_symbols(file);
 	if (ret)
 		return ret;
=20
@@ -1853,23 +2113,14 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
=20
-	/*
-	 * Must be after add_special_section_alts(), since this will emit
-	 * alternatives. Must be after add_{jump,call}_destination(), since
-	 * those create the call insn lists.
-	 */
-	ret =3D arch_rewrite_retpolines(file);
-	if (ret)
-		return ret;
-
 	return 0;
 }
=20
 static bool is_fentry_call(struct instruction *insn)
 {
-	if (insn->type =3D=3D INSN_CALL && insn->call_dest &&
-	    insn->call_dest->type =3D=3D STT_NOTYPE &&
-	    !strcmp(insn->call_dest->name, "__fentry__"))
+	if (insn->type =3D=3D INSN_CALL &&
+	    insn->call_dest &&
+	    insn->call_dest->fentry)
 		return true;
=20
 	return false;
@@ -2452,13 +2703,18 @@ static int propagate_alt_cfi(struct objtool_file *fil=
e, struct instruction *insn
 	if (!insn->alt_group)
 		return 0;
=20
+	if (!insn->cfi) {
+		WARN("CFI missing");
+		return -1;
+	}
+
 	alt_cfi =3D insn->alt_group->cfi;
 	group_off =3D insn->offset - insn->alt_group->first_insn->offset;
=20
 	if (!alt_cfi[group_off]) {
-		alt_cfi[group_off] =3D &insn->cfi;
+		alt_cfi[group_off] =3D insn->cfi;
 	} else {
-		if (memcmp(alt_cfi[group_off], &insn->cfi, sizeof(struct cfi_state))) {
+		if (cficmp(alt_cfi[group_off], insn->cfi)) {
 			WARN_FUNC("stack layout conflict in alternatives",
 				  insn->sec, insn->offset);
 			return -1;
@@ -2509,9 +2765,14 @@ static int handle_insn_ops(struct instruction *insn,
=20
 static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 {
-	struct cfi_state *cfi1 =3D &insn->cfi;
+	struct cfi_state *cfi1 =3D insn->cfi;
 	int i;
=20
+	if (!cfi1) {
+		WARN("CFI missing");
+		return false;
+	}
+
 	if (memcmp(&cfi1->cfa, &cfi2->cfa, sizeof(cfi1->cfa))) {
=20
 		WARN_FUNC("stack state mismatch: cfa1=3D%d%+d cfa2=3D%d%+d",
@@ -2562,20 +2823,64 @@ static inline bool func_uaccess_safe(struct symbol *f=
unc)
=20
 static inline const char *call_dest_name(struct instruction *insn)
 {
+	static char pvname[16];
+	struct reloc *rel;
+	int idx;
+
 	if (insn->call_dest)
 		return insn->call_dest->name;
=20
+	rel =3D insn_reloc(NULL, insn);
+	if (rel && !strcmp(rel->sym->name, "pv_ops")) {
+		idx =3D (rel->addend / sizeof(void *));
+		snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
+		return pvname;
+	}
+
 	return "{dynamic}";
 }
=20
-static inline bool noinstr_call_dest(struct symbol *func)
+static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
+{
+	struct symbol *target;
+	struct reloc *rel;
+	int idx;
+
+	rel =3D insn_reloc(file, insn);
+	if (!rel || strcmp(rel->sym->name, "pv_ops"))
+		return false;
+
+	idx =3D (arch_dest_reloc_offset(rel->addend) / sizeof(void *));
+
+	if (file->pv_ops[idx].clean)
+		return true;
+
+	file->pv_ops[idx].clean =3D true;
+
+	list_for_each_entry(target, &file->pv_ops[idx].targets, pv_target) {
+		if (!target->sec->noinstr) {
+			WARN("pv_ops[%d]: %s", idx, target->name);
+			file->pv_ops[idx].clean =3D false;
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
=20
 	/*
 	 * If the symbol is from a noinstr section; we good.
@@ -2594,10 +2899,12 @@ static inline bool noinstr_call_dest(struct symbol *f=
unc)
 	return false;
 }
=20
-static int validate_call(struct instruction *insn, struct insn_state *state)
+static int validate_call(struct objtool_file *file,
+			 struct instruction *insn,
+			 struct insn_state *state)
 {
 	if (state->noinstr && state->instr <=3D 0 &&
-	    !noinstr_call_dest(insn->call_dest)) {
+	    !noinstr_call_dest(file, insn, insn->call_dest)) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
@@ -2618,7 +2925,9 @@ static int validate_call(struct instruction *insn, stru=
ct insn_state *state)
 	return 0;
 }
=20
-static int validate_sibling_call(struct instruction *insn, struct insn_state=
 *state)
+static int validate_sibling_call(struct objtool_file *file,
+				 struct instruction *insn,
+				 struct insn_state *state)
 {
 	if (has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack fram=
e",
@@ -2626,7 +2935,7 @@ static int validate_sibling_call(struct instruction *in=
sn, struct insn_state *st
 		return 1;
 	}
=20
-	return validate_call(insn, state);
+	return validate_call(file, insn, state);
 }
=20
 static int validate_return(struct symbol *func, struct instruction *insn, st=
ruct insn_state *state)
@@ -2696,7 +3005,7 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
 			   struct instruction *insn, struct insn_state state)
 {
 	struct alternative *alt;
-	struct instruction *next_insn;
+	struct instruction *next_insn, *prev_insn =3D NULL;
 	struct section *sec;
 	u8 visited;
 	int ret;
@@ -2725,15 +3034,25 @@ static int validate_branch(struct objtool_file *file,=
 struct symbol *func,
=20
 			if (insn->visited & visited)
 				return 0;
+		} else {
+			nr_insns_visited++;
 		}
=20
 		if (state.noinstr)
 			state.instr +=3D insn->instr;
=20
-		if (insn->hint)
-			state.cfi =3D insn->cfi;
-		else
-			insn->cfi =3D state.cfi;
+		if (insn->hint) {
+			state.cfi =3D *insn->cfi;
+		} else {
+			/* XXX track if we actually changed state.cfi */
+
+			if (prev_insn && !cficmp(prev_insn->cfi, &state.cfi)) {
+				insn->cfi =3D prev_insn->cfi;
+				nr_cfi_reused++;
+			} else {
+				insn->cfi =3D cfi_hash_find_or_add(&state.cfi);
+			}
+		}
=20
 		insn->visited |=3D visited;
=20
@@ -2769,7 +3088,7 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
=20
 		case INSN_CALL:
 		case INSN_CALL_DYNAMIC:
-			ret =3D validate_call(insn, &state);
+			ret =3D validate_call(file, insn, &state);
 			if (ret)
 				return ret;
=20
@@ -2788,7 +3107,7 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
 			if (is_sibling_call(insn)) {
-				ret =3D validate_sibling_call(insn, &state);
+				ret =3D validate_sibling_call(file, insn, &state);
 				if (ret)
 					return ret;
=20
@@ -2810,7 +3129,7 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
 		case INSN_JUMP_DYNAMIC:
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
 			if (is_sibling_call(insn)) {
-				ret =3D validate_sibling_call(insn, &state);
+				ret =3D validate_sibling_call(file, insn, &state);
 				if (ret)
 					return ret;
 			}
@@ -2883,6 +3202,7 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
 			return 1;
 		}
=20
+		prev_insn =3D insn;
 		insn =3D next_insn;
 	}
=20
@@ -3138,10 +3458,20 @@ int check(struct objtool_file *file)
 	int ret, warnings =3D 0;
=20
 	arch_initial_func_cfi_state(&initial_func_cfi);
+	init_cfi_state(&init_cfi);
+	init_cfi_state(&func_cfi);
+	set_func_state(&func_cfi);
+
+	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
+		goto out;
+
+	cfi_hash_add(&init_cfi);
+	cfi_hash_add(&func_cfi);
=20
 	ret =3D decode_sections(file);
 	if (ret < 0)
 		goto out;
+
 	warnings +=3D ret;
=20
 	if (list_empty(&file->insn_list))
@@ -3185,6 +3515,13 @@ int check(struct objtool_file *file)
 		goto out;
 	warnings +=3D ret;
=20
+	if (retpoline) {
+		ret =3D create_retpoline_sites_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings +=3D ret;
+	}
+
 	if (mcount) {
 		ret =3D create_mcount_loc_sections(file);
 		if (ret < 0)
@@ -3192,6 +3529,13 @@ int check(struct objtool_file *file)
 		warnings +=3D ret;
 	}
=20
+	if (stats) {
+		printf("nr_insns_visited: %ld\n", nr_insns_visited);
+		printf("nr_cfi: %ld\n", nr_cfi);
+		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
+		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
+	}
+
 out:
 	/*
 	 *  For now, don't fail the kernel build on fatal warnings.  These
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index b18f0055b50b..5c029355c38c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -740,90 +740,6 @@ static int elf_add_string(struct elf *elf, struct sectio=
n *strtab, char *str)
 	return len;
 }
=20
-struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
-{
-	struct section *symtab, *symtab_shndx;
-	struct symbol *sym;
-	Elf_Data *data;
-	Elf_Scn *s;
-
-	sym =3D malloc(sizeof(*sym));
-	if (!sym) {
-		perror("malloc");
-		return NULL;
-	}
-	memset(sym, 0, sizeof(*sym));
-
-	sym->name =3D strdup(name);
-
-	sym->sym.st_name =3D elf_add_string(elf, NULL, sym->name);
-	if (sym->sym.st_name =3D=3D -1)
-		return NULL;
-
-	sym->sym.st_info =3D GELF_ST_INFO(STB_GLOBAL, STT_NOTYPE);
-	// st_other 0
-	// st_shndx 0
-	// st_value 0
-	// st_size 0
-
-	symtab =3D find_section_by_name(elf, ".symtab");
-	if (!symtab) {
-		WARN("can't find .symtab");
-		return NULL;
-	}
-
-	s =3D elf_getscn(elf->elf, symtab->idx);
-	if (!s) {
-		WARN_ELF("elf_getscn");
-		return NULL;
-	}
-
-	data =3D elf_newdata(s);
-	if (!data) {
-		WARN_ELF("elf_newdata");
-		return NULL;
-	}
-
-	data->d_buf =3D &sym->sym;
-	data->d_size =3D sizeof(sym->sym);
-	data->d_align =3D 1;
-	data->d_type =3D ELF_T_SYM;
-
-	sym->idx =3D symtab->sh.sh_size / sizeof(sym->sym);
-
-	symtab->sh.sh_size +=3D data->d_size;
-	symtab->changed =3D true;
-
-	symtab_shndx =3D find_section_by_name(elf, ".symtab_shndx");
-	if (symtab_shndx) {
-		s =3D elf_getscn(elf->elf, symtab_shndx->idx);
-		if (!s) {
-			WARN_ELF("elf_getscn");
-			return NULL;
-		}
-
-		data =3D elf_newdata(s);
-		if (!data) {
-			WARN_ELF("elf_newdata");
-			return NULL;
-		}
-
-		data->d_buf =3D &sym->sym.st_size; /* conveniently 0 */
-		data->d_size =3D sizeof(Elf32_Word);
-		data->d_align =3D 4;
-		data->d_type =3D ELF_T_WORD;
-
-		symtab_shndx->sh.sh_size +=3D 4;
-		symtab_shndx->changed =3D true;
-	}
-
-	sym->sec =3D find_section_by_index(elf, 0);
-
-	elf_add_symbol(elf, sym);
-
-	return sym;
-}
-
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   unsigned int sh_flags, size_t entsize, int nr)
 {
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/obj=
tool/arch.h
index 062bb6e9b865..589ff58426ab 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -69,7 +69,7 @@ struct instruction;
=20
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
=20
-int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+int arch_decode_instruction(struct objtool_file *file, const struct section =
*sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
@@ -82,8 +82,9 @@ unsigned long arch_jump_destination(struct instruction *ins=
n);
 unsigned long arch_dest_reloc_offset(int addend);
=20
 const char *arch_nop_insn(int len);
+const char *arch_ret_insn(int len);
=20
-int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
+int arch_decode_hint_reg(u8 sp_reg, int *base);
=20
 bool arch_is_retpoline(struct symbol *sym);
=20
diff --git a/tools/objtool/include/objtool/cfi.h b/tools/objtool/include/objt=
ool/cfi.h
index fd5cb0bed9bf..f11d1ac1dadf 100644
--- a/tools/objtool/include/objtool/cfi.h
+++ b/tools/objtool/include/objtool/cfi.h
@@ -7,6 +7,7 @@
 #define _OBJTOOL_CFI_H
=20
 #include <arch/cfi_regs.h>
+#include <linux/list.h>
=20
 #define CFI_UNDEFINED		-1
 #define CFI_CFA			-2
@@ -24,6 +25,7 @@ struct cfi_init_state {
 };
=20
 struct cfi_state {
+	struct hlist_node hash; /* must be first, cficmp() */
 	struct cfi_reg regs[CFI_NUM_REGS];
 	struct cfi_reg vals[CFI_NUM_REGS];
 	struct cfi_reg cfa;
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index 56d50bc50c10..6cfff078897f 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -40,7 +40,6 @@ struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
 	struct list_head call_node;
-	struct list_head mcount_loc_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
@@ -60,7 +59,7 @@ struct instruction {
 	struct list_head alts;
 	struct symbol *func;
 	struct list_head stack_ops;
-	struct cfi_state cfi;
+	struct cfi_state *cfi;
 };
=20
 static inline bool is_static_jump(struct instruction *insn)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 075d8291b854..cdc739fa9a6f 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -54,8 +54,12 @@ struct symbol {
 	unsigned long offset;
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
-	bool uaccess_safe;
-	bool static_call_tramp;
+	u8 uaccess_safe      : 1;
+	u8 static_call_tramp : 1;
+	u8 retpoline_thunk   : 1;
+	u8 fentry            : 1;
+	u8 kcov              : 1;
+	struct list_head pv_target;
 };
=20
 struct reloc {
@@ -140,7 +144,6 @@ int elf_write_insn(struct elf *elf, struct section *sec,
 		   unsigned long offset, unsigned int len,
 		   const char *insn);
 int elf_write_reloc(struct elf *elf, struct reloc *reloc);
-struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
=20
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/=
objtool/objtool.h
index 24fa83634de4..f99fbc6078d5 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -14,6 +14,11 @@
=20
 #define __weak __attribute__((weak))
=20
+struct pv_state {
+	bool clean;
+	struct list_head targets;
+};
+
 struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
@@ -25,10 +30,14 @@ struct objtool_file {
=20
 	unsigned long jl_short, jl_long;
 	unsigned long jl_nop_short, jl_nop_long;
+
+	struct pv_state *pv_ops;
 };
=20
 struct objtool_file *objtool_open_read(const char *_objname);
=20
+void objtool_pv_add(struct objtool_file *file, int idx, struct symbol *func);
+
 int check(struct objtool_file *file);
 int orc_dump(const char *objname);
 int orc_create(struct objtool_file *file);
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index e21db8bce493..c90c7084e45a 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -135,6 +135,28 @@ struct objtool_file *objtool_open_read(const char *_objn=
ame)
 	return &file;
 }
=20
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
+	f->pv_ops[idx].clean =3D false;
+}
+
 static void cmd_usage(void)
 {
 	unsigned int i, longest =3D 0;
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index b5865e2450cb..dd3c64af9db2 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -13,13 +13,19 @@
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
=20
-static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
+static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
+			  struct instruction *insn)
 {
-	struct instruction *insn =3D container_of(cfi, struct instruction, cfi);
 	struct cfi_reg *bp =3D &cfi->regs[CFI_BP];
=20
 	memset(orc, 0, sizeof(*orc));
=20
+	if (!cfi) {
+		orc->end =3D 0;
+		orc->sp_reg =3D ORC_REG_UNDEFINED;
+		return 0;
+	}
+
 	orc->end =3D cfi->end;
=20
 	if (cfi->cfa.base =3D=3D CFI_UNDEFINED) {
@@ -162,7 +168,7 @@ int orc_create(struct objtool_file *file)
 			int i;
=20
 			if (!alt_group) {
-				if (init_orc_entry(&orc, &insn->cfi))
+				if (init_orc_entry(&orc, insn->cfi, insn))
 					return -1;
 				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
 					continue;
@@ -186,7 +192,8 @@ int orc_create(struct objtool_file *file)
 				struct cfi_state *cfi =3D alt_group->cfi[i];
 				if (!cfi)
 					continue;
-				if (init_orc_entry(&orc, cfi))
+				/* errors are reported on the original insn */
+				if (init_orc_entry(&orc, cfi, insn))
 					return -1;
 				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
 					continue;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 06c3eacab3d5..e2223dd91c37 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -109,14 +109,6 @@ static int get_alt_entry(struct elf *elf, struct special=
_entry *entry,
 			return -1;
 		}
=20
-		/*
-		 * Skip retpoline .altinstr_replacement... we already rewrite the
-		 * instructions for retpolines anyway, see arch_is_retpoline()
-		 * usage in add_{call,jump}_destinations().
-		 */
-		if (arch_is_retpoline(new_reloc->sym))
-			return 1;
-
 		reloc_to_sec_off(new_reloc, &alt->new_sec, &alt->new_off);
=20
 		/* _ASM_EXTABLE_EX hack */

