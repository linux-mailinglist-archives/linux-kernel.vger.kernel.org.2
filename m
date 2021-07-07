Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238C83BE597
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhGGJbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhGGJbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:31:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCE2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 02:28:50 -0700 (PDT)
Date:   Wed, 07 Jul 2021 09:28:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625650128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QtUXJENGAzAGDgnYUTkTBvVdcq29TZjoVKspHGPeOZw=;
        b=n6ZOIcfCUxOoXxZM5UTB9OICoV4pWnOK9YHOXcDpajwHYqLew1z3CrSYJIyX3efZorC/ea
        q0XKxe7c7wuKTOk2in3aKdpCswJBDeWlVYc8I3vvv32ByC60twidb5mSUJx3xSTkMM8p/x
        0cm6FcpLlEmAPm2jVoEbUzt+77Y9DW3b6DTLf2oKU9Tg10GDU5LFdgHxX/8BeC623ktwBp
        S8X/B+n6bsKH0hMBpob092RIlbWMAPrukly9HJBD0PBUXbfbGmzC93Lz1CjqqQ+XmCvWgW
        bdJbD3ckeGiO9AzzPb5QutmgEeSWIPU+WQ3d/5IZXem7RXL+hmjYFe3mOJqGqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625650128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QtUXJENGAzAGDgnYUTkTBvVdcq29TZjoVKspHGPeOZw=;
        b=JGGJbyPbgn54WZqH1pk7EnNSr8lXXVcT7lnQw+hUTWIb6FPYGLjIDk0fGvUcnN/2Pck0re
        f1MAq5ozEe/yr+BA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/fpu for v5.14-rc1
Message-ID: <162565008209.29791.8510279419712030267.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/fpu branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2021-07-07

up to:  93c2cdc975aa: x86/fpu/xstate: Clear xstate header in copy_xstate_to_uabi_buf() again


Fixes and improvements for FPU handling on x86:

  - Prevent sigaltstack out of bounds writes. The kernel unconditionally
    writes the FPU state to the alternate stack without checking whether
    the stack is large enough to accomodate it.

    Check the alternate stack size before doing so and in case it's too
    small force a SIGSEGV instead of silently corrupting user space data.

  - MINSIGSTKZ and SIGSTKSZ are constants in signal.h and have never been
    updated despite the fact that the FPU state which is stored on the
    signal stack has grown over time which causes trouble in the field
    when AVX512 is available on a CPU. The kernel does not expose the
    minimum requirements for the alternate stack size depending on the
    available and enabled CPU features.

    ARM already added an aux vector AT_MINSIGSTKSZ for the same reason.
    Add it to x86 as well

  - A major cleanup of the x86 FPU code. The recent discoveries of XSTATE
    related issues unearthed quite some inconsistencies, duplicated code
    and other issues like lack of robustness.

    The fine granular overhaul addresses this, makes the code more robust
    and maintainable, which allows to integrate upcoming XSTATE related
    features in sane ways.

This PR comes late so the changes could soak for a while in -next. The
changes have been extensively tested by various teams at Intel and the
marginal fallout has been addressed. Some test cases have been added
already, but there is a larger set of Intel internal tests coming up soon
which will allow to catch similar issues in the future.

Thanks,

	tglx

------------------>
Andy Lutomirski (7):
      x86/fpu: Add address range checks to copy_user_to_xstate()
      selftests/x86: Test signal frame XSTATE header corruption handling
      x86/fpu: Rewrite xfpregs_set()
      x86/fpu: Fail ptrace() requests that try to set invalid MXCSR values
      x86/fpu: Clean up fpregs_set()
      x86/fpu: Rename "dynamic" XSTATEs to "independent"
      x86/fpu: Clean up the fpu__clear() variants

Chang S. Bae (6):
      uapi/auxvec: Define the aux vector AT_MINSIGSTKSZ
      x86/signal: Introduce helpers to get the maximum signal frame size
      x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
      selftest/sigaltstack: Use the AT_MINSIGSTKSZ aux vector if available
      x86/signal: Detect and prevent an alternate signal stack overflow
      selftest/x86/signal: Include test cases for validating sigaltstack

Dave Hansen (5):
      x86/fpu: Simplify PTRACE_GETREGS code
      x86/kvm: Avoid looking up PKRU in XSAVE buffer
      x86/pkeys: Move read_pkru() and write_pkru()
      x86/fpu: Add PKRU storage outside of task XSAVE buffer
      x86/fpu: Hook up PKRU into ptrace()

Thomas Gleixner (56):
      x86/fpu: Fix copy_xstate_to_kernel() gap handling
      x86/pkeys: Revert a5eff7259790 ("x86/pkeys: Add PKRU value to init_fpstate")
      x86/fpu: Mark various FPU state variables __ro_after_init
      x86/fpu: Make xfeatures_mask_all __ro_after_init
      x86/fpu: Get rid of fpu__get_supported_xfeatures_mask()
      x86/fpu: Remove unused get_xsave_field_ptr()
      x86/fpu: Move inlines where they belong
      x86/fpu: Limit xstate copy size in xstateregs_set()
      x86/fpu: Sanitize xstateregs_set()
      x86/fpu: Reject invalid MXCSR values in copy_kernel_to_xstate()
      x86/fpu: Make copy_xstate_to_kernel() usable for [x]fpregs_get()
      x86/fpu: Use copy_xstate_to_uabi_buf() in xfpregs_get()
      x86/fpu: Use copy_xstate_to_uabi_buf() in fpregs_get()
      x86/fpu: Remove fpstate_sanitize_xstate()
      x86/fpu/regset: Move fpu__read_begin() into regset
      x86/fpu: Move fpu__write_begin() to regset
      x86/fpu: Get rid of using_compacted_format()
      x86/fpu: Cleanup arch_set_user_pkey_access()
      x86/fpu: Get rid of copy_supervisor_to_kernel()
      x86/fpu: Rename copy_xregs_to_kernel() and copy_kernel_to_xregs()
      x86/fpu: Rename copy_user_to_xregs() and copy_xregs_to_user()
      x86/fpu: Rename fxregs-related copy functions
      x86/math-emu: Rename frstor()
      x86/fpu: Rename fregs-related copy functions
      x86/fpu: Rename xstate copy functions which are related to UABI
      x86/fpu: Deduplicate copy_uabi_from_user/kernel_to_xstate()
      x86/fpu: Rename copy_fpregs_to_fpstate() to save_fpregs_to_fpstate()
      x86/fpu: Get rid of the FNSAVE optimization
      x86/fpu: Rename copy_kernel_to_fpregs() to restore_fpregs_from_fpstate()
      x86/fpu: Rename initstate copy functions
      x86/fpu/xstate: Sanitize handling of independent features
      x86/fpu: Rename and sanitize fpu__save/copy()
      x86/cpu: Sanitize X86_FEATURE_OSPKE
      x86/pkru: Provide pkru_get_init_value()
      x86/pkru: Provide pkru_write_default()
      x86/cpu: Write the default PKRU value when enabling PKE
      x86/fpu: Use pkru_write_default() in copy_init_fpstate_to_fpregs()
      x86/fpu: Rename fpu__clear_all() to fpu_flush_thread()
      x86/fpu: Rename __fpregs_load_activate() to fpregs_restore_userregs()
      x86/fpu: Move FXSAVE_LEAK quirk info __copy_kernel_to_fpregs()
      x86/fpu: Rename xfeatures_mask_user() to xfeatures_mask_uabi()
      x86/fpu: Dont restore PKRU in fpregs_restore_userspace()
      x86/fpu: Mask PKRU from kernel XRSTOR[S] operations
      x86/fpu: Remove PKRU handling from switch_fpu_finish()
      x86/fpu: Don't store PKRU in xstate in fpu_reset_fpstate()
      x86/pkru: Remove xstate fiddling from write_pkru()
      x86/fpu: Mark init_fpstate __ro_after_init
      x86/fpu/signal: Move initial checks into fpu__restore_sig()
      x86/fpu/signal: Remove the legacy alignment check
      x86/fpu/signal: Sanitize the xstate check on sigframe
      x86/fpu/signal: Sanitize copy_user_to_fpregs_zeroing()
      x86/fpu/signal: Split out the direct restore code
      x86/fpu: Return proper error codes from user access functions
      x86/fpu/signal: Handle #PF in the direct restore path
      x86/fpu/signal: Let xrstor handle the features to init
      x86/fpu/xstate: Clear xstate header in copy_xstate_to_uabi_buf() again


 Documentation/x86/elf_auxvec.rst                   |  53 ++
 Documentation/x86/index.rst                        |   1 +
 arch/x86/events/intel/lbr.c                        |   6 +-
 arch/x86/include/asm/elf.h                         |   4 +
 arch/x86/include/asm/fpu/internal.h                | 202 +++----
 arch/x86/include/asm/fpu/signal.h                  |   2 +
 arch/x86/include/asm/fpu/xstate.h                  |  78 ++-
 arch/x86/include/asm/pgtable.h                     |  57 +-
 arch/x86/include/asm/pkeys.h                       |   9 +-
 arch/x86/include/asm/pkru.h                        |  62 ++
 arch/x86/include/asm/processor.h                   |   9 +
 arch/x86/include/asm/sigframe.h                    |   2 +
 arch/x86/include/asm/special_insns.h               |  14 +-
 arch/x86/include/uapi/asm/auxvec.h                 |   4 +-
 arch/x86/kernel/cpu/common.c                       |  37 +-
 arch/x86/kernel/fpu/core.c                         | 282 ++++-----
 arch/x86/kernel/fpu/init.c                         |  15 +-
 arch/x86/kernel/fpu/regset.c                       | 223 ++++---
 arch/x86/kernel/fpu/signal.c                       | 438 +++++++-------
 arch/x86/kernel/fpu/xstate.c                       | 644 ++++++++-------------
 arch/x86/kernel/process.c                          |  22 +-
 arch/x86/kernel/process_64.c                       |  28 +-
 arch/x86/kernel/signal.c                           |  88 ++-
 arch/x86/kernel/traps.c                            |   5 +-
 arch/x86/kvm/svm/sev.c                             |   1 +
 arch/x86/kvm/x86.c                                 |  56 +-
 arch/x86/math-emu/fpu_proto.h                      |   2 +-
 arch/x86/math-emu/load_store.c                     |   2 +-
 arch/x86/math-emu/reg_ld_str.c                     |   2 +-
 arch/x86/mm/extable.c                              |   2 +-
 arch/x86/mm/fault.c                                |   2 +-
 arch/x86/mm/pkeys.c                                |  22 -
 include/linux/pkeys.h                              |   4 -
 include/linux/sched/signal.h                       |  19 +-
 include/uapi/linux/auxvec.h                        |   3 +
 tools/testing/selftests/sigaltstack/sas.c          |  20 +-
 tools/testing/selftests/x86/Makefile               |   5 +-
 .../testing/selftests/x86/corrupt_xstate_header.c  | 114 ++++
 tools/testing/selftests/x86/sigaltstack.c          | 128 ++++
 39 files changed, 1480 insertions(+), 1187 deletions(-)
 create mode 100644 Documentation/x86/elf_auxvec.rst
 create mode 100644 arch/x86/include/asm/pkru.h
 create mode 100644 tools/testing/selftests/x86/corrupt_xstate_header.c
 create mode 100644 tools/testing/selftests/x86/sigaltstack.c

diff --git a/Documentation/x86/elf_auxvec.rst b/Documentation/x86/elf_auxvec.rst
new file mode 100644
index 000000000000..18e4744717f9
--- /dev/null
+++ b/Documentation/x86/elf_auxvec.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+x86-specific ELF Auxiliary Vectors
+==================================
+
+This document describes the semantics of the x86 auxiliary vectors.
+
+Introduction
+============
+
+ELF Auxiliary vectors enable the kernel to efficiently provide
+configuration-specific parameters to userspace. In this example, a program
+allocates an alternate stack based on the kernel-provided size::
+
+   #include <sys/auxv.h>
+   #include <elf.h>
+   #include <signal.h>
+   #include <stdlib.h>
+   #include <assert.h>
+   #include <err.h>
+
+   #ifndef AT_MINSIGSTKSZ
+   #define AT_MINSIGSTKSZ	51
+   #endif
+
+   ....
+   stack_t ss;
+
+   ss.ss_sp = malloc(ss.ss_size);
+   assert(ss.ss_sp);
+
+   ss.ss_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
+   ss.ss_flags = 0;
+
+   if (sigaltstack(&ss, NULL))
+        err(1, "sigaltstack");
+
+
+The exposed auxiliary vectors
+=============================
+
+AT_SYSINFO is used for locating the vsyscall entry point.  It is not
+exported on 64-bit mode.
+
+AT_SYSINFO_EHDR is the start address of the page containing the vDSO.
+
+AT_MINSIGSTKSZ denotes the minimum stack size required by the kernel to
+deliver a signal to user-space.  AT_MINSIGSTKSZ comprehends the space
+consumed by the kernel to accommodate the user context for the current
+hardware configuration.  It does not comprehend subsequent user-space stack
+consumption, which must be added by the user.  (e.g. Above, user-space adds
+SIGSTKSZ to AT_MINSIGSTKSZ.)
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 4693e192b447..d58614d5cde6 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -35,3 +35,4 @@ x86-specific Documentation
    sva
    sgx
    features
+   elf_auxvec
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4409d2cccfda..f338645071c8 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -491,7 +491,7 @@ static void intel_pmu_arch_lbr_xrstors(void *ctx)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_kernel_to_dynamic_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	xrstors(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
@@ -576,7 +576,7 @@ static void intel_pmu_arch_lbr_xsaves(void *ctx)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_dynamic_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	xsaves(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static void __intel_pmu_lbr_save(void *ctx)
@@ -992,7 +992,7 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
 		intel_pmu_store_lbr(cpuc, NULL);
 		return;
 	}
-	copy_dynamic_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
+	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
 }
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 7d7500806af8..29fea180a665 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -312,6 +312,7 @@ do {									\
 		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY);			\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_CURRENT_BASE);	\
 	}								\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());		\
 } while (0)
 
 /*
@@ -328,6 +329,7 @@ extern unsigned long task_size_32bit(void);
 extern unsigned long task_size_64bit(int full_addr_space);
 extern unsigned long get_mmap_base(int is_legacy);
 extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
+extern unsigned long get_sigframe_size(void);
 
 #ifdef CONFIG_X86_32
 
@@ -349,6 +351,7 @@ do {									\
 	if (vdso64_enabled)						\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 			    (unsigned long __force)current->mm->context.vdso); \
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());		\
 } while (0)
 
 /* As a historical oddity, the x32 and x86_64 vDSOs are controlled together. */
@@ -357,6 +360,7 @@ do {									\
 	if (vdso64_enabled)						\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 			    (unsigned long __force)current->mm->context.vdso); \
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());		\
 } while (0)
 
 #define AT_SYSINFO		32
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 16bf4d4a8159..5a18694a89b2 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -26,16 +26,17 @@
 /*
  * High level FPU state handling functions:
  */
-extern void fpu__prepare_read(struct fpu *fpu);
-extern void fpu__prepare_write(struct fpu *fpu);
-extern void fpu__save(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
-extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
 extern void fpu__clear_user_states(struct fpu *fpu);
-extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 
+extern void fpu_sync_fpstate(struct fpu *fpu);
+
+/* Clone and exit operations */
+extern int  fpu_clone(struct task_struct *dst);
+extern void fpu_flush_thread(void);
+
 /*
  * Boot time FPU initialization functions:
  */
@@ -45,7 +46,6 @@ extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system(struct cpuinfo_x86 *c);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
-extern u64 fpu__get_supported_xfeatures_mask(void);
 
 /*
  * Debugging facility:
@@ -86,23 +86,9 @@ extern void fpstate_init_soft(struct swregs_state *soft);
 #else
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
+extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
-static inline void fpstate_init_xstate(struct xregs_state *xsave)
-{
-	/*
-	 * XRSTORS requires these bits set in xcomp_bv, or it will
-	 * trigger #GP:
-	 */
-	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
-}
-
-static inline void fpstate_init_fxstate(struct fxregs_state *fx)
-{
-	fx->cwd = 0x37f;
-	fx->mxcsr = MXCSR_DEFAULT;
-}
-extern void fpstate_sanitize_xstate(struct fpu *fpu);
-
+/* Returns 0 or the negated trap number, which results in -EFAULT for #PF */
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
@@ -110,14 +96,14 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 	might_fault();							\
 									\
 	asm volatile(ASM_STAC "\n"					\
-		     "1:" #insn "\n\t"					\
+		     "1: " #insn "\n"					\
 		     "2: " ASM_CLAC "\n"				\
 		     ".section .fixup,\"ax\"\n"				\
-		     "3:  movl $-1,%[err]\n"				\
+		     "3:  negl %%eax\n"					\
 		     "    jmp  2b\n"					\
 		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : [err] "=r" (err), output				\
+		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     : [err] "=a" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
 })
@@ -143,12 +129,12 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
 		     : output : input)
 
-static inline int copy_fregs_to_user(struct fregs_state __user *fx)
+static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
 {
 	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
 }
 
-static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
+static inline int fxsave_to_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
@@ -157,7 +143,7 @@ static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
 
 }
 
-static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
+static inline void fxrstor(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		kernel_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -165,7 +151,7 @@ static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 		kernel_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_kernel_to_fxregs_err(struct fxregs_state *fx)
+static inline int fxrstor_safe(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return kernel_insn_err(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -173,7 +159,7 @@ static inline int copy_kernel_to_fxregs_err(struct fxregs_state *fx)
 		return kernel_insn_err(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
+static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -181,29 +167,21 @@ static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
 		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline void copy_kernel_to_fregs(struct fregs_state *fx)
+static inline void frstor(struct fregs_state *fx)
 {
 	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_kernel_to_fregs_err(struct fregs_state *fx)
+static inline int frstor_safe(struct fregs_state *fx)
 {
 	return kernel_insn_err(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fregs(struct fregs_state __user *fx)
+static inline int frstor_from_user_sigframe(struct fregs_state __user *fx)
 {
 	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline void copy_fxregs_to_kernel(struct fpu *fpu)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		asm volatile( "fxsave %[fx]" : [fx] "=m" (fpu->state.fxsave));
-	else
-		asm volatile("fxsaveq %[fx]" : [fx] "=m" (fpu->state.fxsave));
-}
-
 static inline void fxsave(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
@@ -219,16 +197,20 @@ static inline void fxsave(struct fxregs_state *fx)
 #define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
 #define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
 
+/*
+ * After this @err contains 0 on success or the negated trap number when
+ * the operation raises an exception. For faults this results in -EFAULT.
+ */
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\
 		     "xor %[err], %[err]\n"				\
 		     "2:\n\t"						\
 		     ".pushsection .fixup,\"ax\"\n\t"			\
-		     "3: movl $-2,%[err]\n\t"				\
+		     "3: negl %%eax\n\t"				\
 		     "jmp 2b\n\t"					\
 		     ".popsection\n\t"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : [err] "=r" (err)					\
+		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     : [err] "=a" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
@@ -280,9 +262,9 @@ static inline void fxsave(struct fxregs_state *fx)
  * This function is called only during boot time when x86 caps are not set
  * up and alternative can not be used yet.
  */
-static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
+static inline void os_xrstor_booting(struct xregs_state *xstate)
 {
-	u64 mask = -1;
+	u64 mask = xfeatures_mask_fpstate();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
@@ -303,8 +285,11 @@ static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
 
 /*
  * Save processor xstate to xsave area.
+ *
+ * Uses either XSAVE or XSAVEOPT or XSAVES depending on the CPU features
+ * and command line options. The choice is permanent until the next reboot.
  */
-static inline void copy_xregs_to_kernel(struct xregs_state *xstate)
+static inline void os_xsave(struct xregs_state *xstate)
 {
 	u64 mask = xfeatures_mask_all;
 	u32 lmask = mask;
@@ -321,8 +306,10 @@ static inline void copy_xregs_to_kernel(struct xregs_state *xstate)
 
 /*
  * Restore processor xstate from xsave area.
+ *
+ * Uses XRSTORS when XSAVES is used, XRSTOR otherwise.
  */
-static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
+static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
 {
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
@@ -340,9 +327,14 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
  * backward compatibility for old applications which don't understand
  * compacted format of xsave area.
  */
-static inline int copy_xregs_to_user(struct xregs_state __user *buf)
+static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
-	u64 mask = xfeatures_mask_user();
+	/*
+	 * Include the features which are not xsaved/rstored by the kernel
+	 * internally, e.g. PKRU. That's user space ABI and also required
+	 * to allow the signal handler to modify PKRU.
+	 */
+	u64 mask = xfeatures_mask_uabi();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
@@ -365,7 +357,7 @@ static inline int copy_xregs_to_user(struct xregs_state __user *buf)
 /*
  * Restore xstate from user space xsave area.
  */
-static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
+static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64 mask)
 {
 	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
 	u32 lmask = mask;
@@ -383,13 +375,13 @@ static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
  * Restore xstate from kernel space xsave area, return an error code instead of
  * an exception.
  */
-static inline int copy_kernel_to_xregs_err(struct xregs_state *xstate, u64 mask)
+static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
 {
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
 
-	if (static_cpu_has(X86_FEATURE_XSAVES))
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
 		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 	else
 		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
@@ -397,36 +389,11 @@ static inline int copy_kernel_to_xregs_err(struct xregs_state *xstate, u64 mask)
 	return err;
 }
 
-extern int copy_fpregs_to_fpstate(struct fpu *fpu);
+extern void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask);
 
-static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
+static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
 {
-	if (use_xsave()) {
-		copy_kernel_to_xregs(&fpstate->xsave, mask);
-	} else {
-		if (use_fxsr())
-			copy_kernel_to_fxregs(&fpstate->fxsave);
-		else
-			copy_kernel_to_fregs(&fpstate->fsave);
-	}
-}
-
-static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
-{
-	/*
-	 * AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception is
-	 * pending. Clear the x87 state here by setting it to fixed values.
-	 * "m" is a random variable that should be in L1.
-	 */
-	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK))) {
-		asm volatile(
-			"fnclex\n\t"
-			"emms\n\t"
-			"fildl %P[addr]"	/* set F?P to defined value */
-			: : [addr] "m" (fpstate));
-	}
-
-	__copy_kernel_to_fpregs(fpstate, -1);
+	__restore_fpregs_from_fpstate(fpstate, xfeatures_mask_fpstate());
 }
 
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
@@ -485,10 +452,8 @@ static inline void fpregs_activate(struct fpu *fpu)
 	trace_x86_fpu_regs_activated(fpu);
 }
 
-/*
- * Internal helper, do not use directly. Use switch_fpu_return() instead.
- */
-static inline void __fpregs_load_activate(void)
+/* Internal helper for switch_fpu_return() and signal frame setup */
+static inline void fpregs_restore_userregs(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int cpu = smp_processor_id();
@@ -497,7 +462,21 @@ static inline void __fpregs_load_activate(void)
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
-		copy_kernel_to_fpregs(&fpu->state);
+		u64 mask;
+
+		/*
+		 * This restores _all_ xstate which has not been
+		 * established yet.
+		 *
+		 * If PKRU is enabled, then the PKRU value is already
+		 * correct because it was either set in switch_to() or in
+		 * flush_thread(). So it is excluded because it might be
+		 * not up to date in current->thread.fpu.xsave state.
+		 */
+		mask = xfeatures_mask_restore_user() |
+			xfeatures_mask_supervisor();
+		__restore_fpregs_from_fpstate(&fpu->state, mask);
+
 		fpregs_activate(fpu);
 		fpu->last_cpu = cpu;
 	}
@@ -529,12 +508,17 @@ static inline void __fpregs_load_activate(void)
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
-		if (!copy_fpregs_to_fpstate(old_fpu))
-			old_fpu->last_cpu = -1;
-		else
-			old_fpu->last_cpu = cpu;
+		save_fpregs_to_fpstate(old_fpu);
+		/*
+		 * The save operation preserved register state, so the
+		 * fpu_fpregs_owner_ctx is still @old_fpu. Store the
+		 * current CPU number in @old_fpu, so the next return
+		 * to user space can avoid the FPU register restore
+		 * when is returns on the same CPU and still owns the
+		 * context.
+		 */
+		old_fpu->last_cpu = cpu;
 
-		/* But leave fpu_fpregs_owner_ctx! */
 		trace_x86_fpu_regs_deactivated(old_fpu);
 	}
 }
@@ -544,39 +528,13 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 
 /*
- * Load PKRU from the FPU context if available. Delay loading of the
- * complete FPU state until the return to userland.
+ * Delay loading of the complete FPU state until the return to userland.
+ * PKRU is handled separately.
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu)
 {
-	u32 pkru_val = init_pkru_value;
-	struct pkru_state *pk;
-
-	if (!static_cpu_has(X86_FEATURE_FPU))
-		return;
-
-	set_thread_flag(TIF_NEED_FPU_LOAD);
-
-	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
-		return;
-
-	/*
-	 * PKRU state is switched eagerly because it needs to be valid before we
-	 * return to userland e.g. for a copy_to_user() operation.
-	 */
-	if (!(current->flags & PF_KTHREAD)) {
-		/*
-		 * If the PKRU bit in xsave.header.xfeatures is not set,
-		 * then the PKRU component was in init state, which means
-		 * XRSTOR will set PKRU to 0. If the bit is not set then
-		 * get_xsave_addr() will return NULL because the PKRU value
-		 * in memory is not valid. This means pkru_val has to be
-		 * set to 0 and not to init_pkru_value.
-		 */
-		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
-		pkru_val = pk ? pk->pkru : 0;
-	}
-	__write_pkru(pkru_val);
+	if (cpu_feature_enabled(X86_FEATURE_FPU))
+		set_thread_flag(TIF_NEED_FPU_LOAD);
 }
 
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 7fb516b6893a..8b6631dffefd 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -29,6 +29,8 @@ unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size);
 
+unsigned long fpu__get_fpstate_size(void);
+
 extern void fpu__init_prepare_fx_sw_frame(void);
 
 #endif /* _ASM_X86_FPU_SIGNAL_H */
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 47a92232d595..109dfcc75299 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 #include <asm/processor.h>
+#include <asm/fpu/api.h>
 #include <asm/user.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
@@ -34,6 +35,14 @@
 				      XFEATURE_MASK_BNDREGS | \
 				      XFEATURE_MASK_BNDCSR)
 
+/*
+ * Features which are restored when returning to user space.
+ * PKRU is not restored on return to user space because PKRU
+ * is switched eagerly in switch_to() and flush_thread()
+ */
+#define XFEATURE_MASK_USER_RESTORE	\
+	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
+
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
 
@@ -42,21 +51,21 @@
  * and its size may be huge. Saving/restoring such supervisor state components
  * at each context switch can cause high CPU and space overhead, which should
  * be avoided. Such supervisor state components should only be saved/restored
- * on demand. The on-demand dynamic supervisor features are set in this mask.
+ * on demand. The on-demand supervisor features are set in this mask.
  *
- * Unlike the existing supported supervisor features, a dynamic supervisor
+ * Unlike the existing supported supervisor features, an independent supervisor
  * feature does not allocate a buffer in task->fpu, and the corresponding
  * supervisor state component cannot be saved/restored at each context switch.
  *
- * To support a dynamic supervisor feature, a developer should follow the
+ * To support an independent supervisor feature, a developer should follow the
  * dos and don'ts as below:
  * - Do dynamically allocate a buffer for the supervisor state component.
  * - Do manually invoke the XSAVES/XRSTORS instruction to save/restore the
  *   state component to/from the buffer.
- * - Don't set the bit corresponding to the dynamic supervisor feature in
+ * - Don't set the bit corresponding to the independent supervisor feature in
  *   IA32_XSS at run time, since it has been set at boot time.
  */
-#define XFEATURE_MASK_DYNAMIC (XFEATURE_MASK_LBR)
+#define XFEATURE_MASK_INDEPENDENT (XFEATURE_MASK_LBR)
 
 /*
  * Unsupported supervisor features. When a supervisor feature in this mask is
@@ -66,7 +75,7 @@
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
-				      XFEATURE_MASK_DYNAMIC | \
+				      XFEATURE_MASK_INDEPENDENT | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
 #ifdef CONFIG_X86_64
@@ -82,17 +91,42 @@ static inline u64 xfeatures_mask_supervisor(void)
 	return xfeatures_mask_all & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 }
 
-static inline u64 xfeatures_mask_user(void)
+/*
+ * The xfeatures which are enabled in XCR0 and expected to be in ptrace
+ * buffers and signal frames.
+ */
+static inline u64 xfeatures_mask_uabi(void)
 {
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
-static inline u64 xfeatures_mask_dynamic(void)
+/*
+ * The xfeatures which are restored by the kernel when returning to user
+ * mode. This is not necessarily the same as xfeatures_mask_uabi() as the
+ * kernel does not manage all XCR0 enabled features via xsave/xrstor as
+ * some of them have to be switched eagerly on context switch and exec().
+ */
+static inline u64 xfeatures_mask_restore_user(void)
+{
+	return xfeatures_mask_all & XFEATURE_MASK_USER_RESTORE;
+}
+
+/*
+ * Like xfeatures_mask_restore_user() but additionally restors the
+ * supported supervisor states.
+ */
+static inline u64 xfeatures_mask_fpstate(void)
+{
+	return xfeatures_mask_all & \
+		(XFEATURE_MASK_USER_RESTORE | XFEATURE_MASK_SUPERVISOR_SUPPORTED);
+}
+
+static inline u64 xfeatures_mask_independent(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_DYNAMIC & ~XFEATURE_MASK_LBR;
+		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_DYNAMIC;
+	return XFEATURE_MASK_INDEPENDENT;
 }
 
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
@@ -101,19 +135,21 @@ extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
-const void *get_xsave_field_ptr(int xfeature_nr);
-int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
-struct membuf;
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
-void copy_supervisor_to_kernel(struct xregs_state *xsave);
-void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
-void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
+int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 
+void xsaves(struct xregs_state *xsave, u64 mask);
+void xrstors(struct xregs_state *xsave, u64 mask);
 
-/* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_user_xstate_header(const struct xstate_header *hdr);
+enum xstate_copy_mode {
+	XSTATE_COPY_FP,
+	XSTATE_COPY_FX,
+	XSTATE_COPY_XSAVE,
+};
+
+struct membuf;
+void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
+			     enum xstate_copy_mode mode);
 
 #endif
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b1099f2d9800..ec0d8e106646 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -23,7 +23,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/x86_init.h>
-#include <asm/fpu/xstate.h>
+#include <asm/pkru.h>
 #include <asm/fpu/api.h>
 #include <asm-generic/pgtable_uffd.h>
 
@@ -126,35 +126,6 @@ static inline int pte_dirty(pte_t pte)
 	return pte_flags(pte) & _PAGE_DIRTY;
 }
 
-
-static inline u32 read_pkru(void)
-{
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		return rdpkru();
-	return 0;
-}
-
-static inline void write_pkru(u32 pkru)
-{
-	struct pkru_state *pk;
-
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
-		return;
-
-	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
-
-	/*
-	 * The PKRU value in xstate needs to be in sync with the value that is
-	 * written to the CPU. The FPU restore on return to userland would
-	 * otherwise load the previous value again.
-	 */
-	fpregs_lock();
-	if (pk)
-		pk->pkru = pkru;
-	__write_pkru(pkru);
-	fpregs_unlock();
-}
-
 static inline int pte_young(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_ACCESSED;
@@ -1360,32 +1331,6 @@ static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
 }
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
-#define PKRU_AD_BIT 0x1
-#define PKRU_WD_BIT 0x2
-#define PKRU_BITS_PER_PKEY 2
-
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-extern u32 init_pkru_value;
-#else
-#define init_pkru_value	0
-#endif
-
-static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
-{
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	return !(pkru & (PKRU_AD_BIT << pkru_pkey_bits));
-}
-
-static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
-{
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	/*
-	 * Access-disable disables writes too so we need to check
-	 * both bits here.
-	 */
-	return !(pkru & ((PKRU_AD_BIT|PKRU_WD_BIT) << pkru_pkey_bits));
-}
-
 static inline u16 pte_flags_pkey(unsigned long pte_flags)
 {
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 2ff9b98812b7..5c7bcaa79623 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -9,14 +9,14 @@
  * will be necessary to ensure that the types that store key
  * numbers and masks have sufficient capacity.
  */
-#define arch_max_pkey() (boot_cpu_has(X86_FEATURE_OSPKE) ? 16 : 1)
+#define arch_max_pkey() (cpu_feature_enabled(X86_FEATURE_OSPKE) ? 16 : 1)
 
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 
 static inline bool arch_pkeys_enabled(void)
 {
-	return boot_cpu_has(X86_FEATURE_OSPKE);
+	return cpu_feature_enabled(X86_FEATURE_OSPKE);
 }
 
 /*
@@ -26,7 +26,7 @@ static inline bool arch_pkeys_enabled(void)
 extern int __execute_only_pkey(struct mm_struct *mm);
 static inline int execute_only_pkey(struct mm_struct *mm)
 {
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return ARCH_DEFAULT_PKEY;
 
 	return __execute_only_pkey(mm);
@@ -37,7 +37,7 @@ extern int __arch_override_mprotect_pkey(struct vm_area_struct *vma,
 static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 		int prot, int pkey)
 {
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return 0;
 
 	return __arch_override_mprotect_pkey(vma, prot, pkey);
@@ -124,7 +124,6 @@ extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
-extern void copy_init_pkru_to_fpregs(void);
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
new file mode 100644
index 000000000000..ccc539faa5bb
--- /dev/null
+++ b/arch/x86/include/asm/pkru.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PKRU_H
+#define _ASM_X86_PKRU_H
+
+#include <asm/fpu/xstate.h>
+
+#define PKRU_AD_BIT 0x1
+#define PKRU_WD_BIT 0x2
+#define PKRU_BITS_PER_PKEY 2
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+extern u32 init_pkru_value;
+#define pkru_get_init_value()	READ_ONCE(init_pkru_value)
+#else
+#define init_pkru_value	0
+#define pkru_get_init_value()	0
+#endif
+
+static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
+{
+	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
+	return !(pkru & (PKRU_AD_BIT << pkru_pkey_bits));
+}
+
+static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
+{
+	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
+	/*
+	 * Access-disable disables writes too so we need to check
+	 * both bits here.
+	 */
+	return !(pkru & ((PKRU_AD_BIT|PKRU_WD_BIT) << pkru_pkey_bits));
+}
+
+static inline u32 read_pkru(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return rdpkru();
+	return 0;
+}
+
+static inline void write_pkru(u32 pkru)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+	/*
+	 * WRPKRU is relatively expensive compared to RDPKRU.
+	 * Avoid WRPKRU when it would not change the value.
+	 */
+	if (pkru != rdpkru())
+		wrpkru(pkru);
+}
+
+static inline void pkru_write_default(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	wrpkru(pkru_get_init_value());
+}
+
+#endif
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 556b2b17c3e2..91946fc3c006 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -518,6 +518,15 @@ struct thread_struct {
 
 	unsigned int		sig_on_uaccess_err:1;
 
+	/*
+	 * Protection Keys Register for Userspace.  Loaded immediately on
+	 * context switch. Store it in thread_struct to avoid a lookup in
+	 * the tasks's FPU xstate buffer. This value is only valid when a
+	 * task is scheduled out. For 'current' the authoritative source of
+	 * PKRU is the hardware itself.
+	 */
+	u32			pkru;
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index 84eab2724875..5b1ed650b124 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -85,4 +85,6 @@ struct rt_sigframe_x32 {
 
 #endif /* CONFIG_X86_64 */
 
+void __init init_sigframe_size(void);
+
 #endif /* _ASM_X86_SIGFRAME_H */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2acd6cb62328..f3fbb84ff8a7 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -104,25 +104,13 @@ static inline void wrpkru(u32 pkru)
 		     : : "a" (pkru), "c"(ecx), "d"(edx));
 }
 
-static inline void __write_pkru(u32 pkru)
-{
-	/*
-	 * WRPKRU is relatively expensive compared to RDPKRU.
-	 * Avoid WRPKRU when it would not change the value.
-	 */
-	if (pkru == rdpkru())
-		return;
-
-	wrpkru(pkru);
-}
-
 #else
 static inline u32 rdpkru(void)
 {
 	return 0;
 }
 
-static inline void __write_pkru(u32 pkru)
+static inline void wrpkru(u32 pkru)
 {
 }
 #endif
diff --git a/arch/x86/include/uapi/asm/auxvec.h b/arch/x86/include/uapi/asm/auxvec.h
index 580e3c567046..6beb55bbefa4 100644
--- a/arch/x86/include/uapi/asm/auxvec.h
+++ b/arch/x86/include/uapi/asm/auxvec.h
@@ -12,9 +12,9 @@
 
 /* entries in ARCH_DLINFO: */
 #if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
-# define AT_VECTOR_SIZE_ARCH 2
+# define AT_VECTOR_SIZE_ARCH 3
 #else /* else it's non-compat x86-64 */
-# define AT_VECTOR_SIZE_ARCH 1
+# define AT_VECTOR_SIZE_ARCH 2
 #endif
 
 #endif /* _ASM_X86_AUXVEC_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a1b756c49a93..ca668efa4c81 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -58,6 +58,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/sigframe.h>
 
 #include "cpu.h"
 
@@ -465,27 +466,22 @@ static bool pku_disabled;
 
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
-	struct pkru_state *pk;
+	if (c == &boot_cpu_data) {
+		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
+			return;
+		/*
+		 * Setting CR4.PKE will cause the X86_FEATURE_OSPKE cpuid
+		 * bit to be set.  Enforce it.
+		 */
+		setup_force_cpu_cap(X86_FEATURE_OSPKE);
 
-	/* check the boot processor, plus compile options for PKU: */
-	if (!cpu_feature_enabled(X86_FEATURE_PKU))
-		return;
-	/* checks the actual processor's cpuid bits: */
-	if (!cpu_has(c, X86_FEATURE_PKU))
-		return;
-	if (pku_disabled)
+	} else if (!cpu_feature_enabled(X86_FEATURE_OSPKE)) {
 		return;
+	}
 
 	cr4_set_bits(X86_CR4_PKE);
-	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
-	if (pk)
-		pk->pkru = init_pkru_value;
-	/*
-	 * Setting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
-	 * cpuid bit to be set.  We need to ensure that we
-	 * update that bit in this CPU's "cpu_info".
-	 */
-	set_cpu_cap(c, X86_FEATURE_OSPKE);
+	/* Load the default PKRU value */
+	pkru_write_default();
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
@@ -1332,6 +1328,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	fpu__init_system(c);
 
+	init_sigframe_size();
+
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
@@ -1717,9 +1715,8 @@ void print_cpu_info(struct cpuinfo_x86 *c)
 }
 
 /*
- * clearcpuid= was already parsed in fpu__init_parse_early_param.
- * But we need to keep a dummy __setup around otherwise it would
- * show up as an environment variable for init.
+ * clearcpuid= was already parsed in cpu_parse_early_param().  This dummy
+ * function prevents it from becoming an environment variable for init.
  */
 static __init int setup_clearcpuid(char *arg)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 571220ac8bea..7ada7bd03a32 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -23,7 +23,7 @@
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
  * depending on the FPU hardware format:
  */
-union fpregs_state init_fpstate __read_mostly;
+union fpregs_state init_fpstate __ro_after_init;
 
 /*
  * Track whether the kernel is using the FPU state
@@ -83,19 +83,23 @@ bool irq_fpu_usable(void)
 EXPORT_SYMBOL(irq_fpu_usable);
 
 /*
- * These must be called with preempt disabled. Returns
- * 'true' if the FPU state is still intact and we can
- * keep registers active.
+ * Save the FPU register state in fpu->state. The register state is
+ * preserved.
  *
- * The legacy FNSAVE instruction cleared all FPU state
- * unconditionally, so registers are essentially destroyed.
- * Modern FPU state can be kept in registers, if there are
- * no pending FP exceptions.
+ * Must be called with fpregs_lock() held.
+ *
+ * The legacy FNSAVE instruction clears all FPU state unconditionally, so
+ * register state has to be reloaded. That might be a pointless exercise
+ * when the FPU is going to be used by another task right after that. But
+ * this only affects 20+ years old 32bit systems and avoids conditionals all
+ * over the place.
+ *
+ * FXSAVE and all XSAVE variants preserve the FPU register state.
  */
-int copy_fpregs_to_fpstate(struct fpu *fpu)
+void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
-		copy_xregs_to_kernel(&fpu->state.xsave);
+		os_xsave(&fpu->state.xsave);
 
 		/*
 		 * AVX512 state is tracked here because its use is
@@ -103,23 +107,49 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
 		 */
 		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
 			fpu->avx512_timestamp = jiffies;
-		return 1;
+		return;
 	}
 
 	if (likely(use_fxsr())) {
-		copy_fxregs_to_kernel(fpu);
-		return 1;
+		fxsave(&fpu->state.fxsave);
+		return;
 	}
 
 	/*
 	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
-	 * so we have to mark them inactive:
+	 * so we have to reload them from the memory state.
 	 */
 	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
+	frstor(&fpu->state.fsave);
+}
+EXPORT_SYMBOL(save_fpregs_to_fpstate);
 
-	return 0;
+void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
+{
+	/*
+	 * AMD K7/K8 and later CPUs up to Zen don't save/restore
+	 * FDP/FIP/FOP unless an exception is pending. Clear the x87 state
+	 * here by setting it to fixed values.  "m" is a random variable
+	 * that should be in L1.
+	 */
+	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK))) {
+		asm volatile(
+			"fnclex\n\t"
+			"emms\n\t"
+			"fildl %P[addr]"	/* set F?P to defined value */
+			: : [addr] "m" (fpstate));
+	}
+
+	if (use_xsave()) {
+		os_xrstor(&fpstate->xsave, mask);
+	} else {
+		if (use_fxsr())
+			fxrstor(&fpstate->fxsave);
+		else
+			frstor(&fpstate->fsave);
+	}
 }
-EXPORT_SYMBOL(copy_fpregs_to_fpstate);
+EXPORT_SYMBOL_GPL(__restore_fpregs_from_fpstate);
 
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
@@ -133,11 +163,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 	if (!(current->flags & PF_KTHREAD) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
-		/*
-		 * Ignore return value -- we don't care if reg state
-		 * is clobbered.
-		 */
-		copy_fpregs_to_fpstate(&current->thread.fpu);
+		save_fpregs_to_fpstate(&current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
 
@@ -160,27 +186,38 @@ void kernel_fpu_end(void)
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
 /*
- * Save the FPU state (mark it for reload if necessary):
- *
- * This only ever gets called for the current task.
+ * Sync the FPU register state to current's memory register state when the
+ * current task owns the FPU. The hardware register state is preserved.
  */
-void fpu__save(struct fpu *fpu)
+void fpu_sync_fpstate(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
 	fpregs_lock();
 	trace_x86_fpu_before_save(fpu);
 
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		if (!copy_fpregs_to_fpstate(fpu)) {
-			copy_kernel_to_fpregs(&fpu->state);
-		}
-	}
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
+		save_fpregs_to_fpstate(fpu);
 
 	trace_x86_fpu_after_save(fpu);
 	fpregs_unlock();
 }
 
+static inline void fpstate_init_xstate(struct xregs_state *xsave)
+{
+	/*
+	 * XRSTORS requires these bits set in xcomp_bv, or it will
+	 * trigger #GP:
+	 */
+	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
+}
+
+static inline void fpstate_init_fxstate(struct fxregs_state *fx)
+{
+	fx->cwd = 0x37f;
+	fx->mxcsr = MXCSR_DEFAULT;
+}
+
 /*
  * Legacy x87 fpstate state init:
  */
@@ -210,18 +247,18 @@ void fpstate_init(union fpregs_state *state)
 }
 EXPORT_SYMBOL_GPL(fpstate_init);
 
-int fpu__copy(struct task_struct *dst, struct task_struct *src)
+/* Clone current's FPU state on fork */
+int fpu_clone(struct task_struct *dst)
 {
+	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
-	struct fpu *src_fpu = &src->thread.fpu;
 
+	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
 
-	if (!static_cpu_has(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return 0;
 
-	WARN_ON_FPU(src_fpu != &current->thread.fpu);
-
 	/*
 	 * Don't let 'init optimized' areas of the XSAVE area
 	 * leak into the child task:
@@ -229,20 +266,16 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 	memset(&dst_fpu->state.xsave, 0, fpu_kernel_xstate_size);
 
 	/*
-	 * If the FPU registers are not current just memcpy() the state.
-	 * Otherwise save current FPU registers directly into the child's FPU
-	 * context, without any memory-to-memory copying.
-	 *
-	 * ( The function 'fails' in the FNSAVE case, which destroys
-	 *   register contents so we have to load them back. )
+	 * If the FPU registers are not owned by current just memcpy() the
+	 * state.  Otherwise save the FPU registers directly into the
+	 * child's FPU context, without any memory-to-memory copying.
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
 
-	else if (!copy_fpregs_to_fpstate(dst_fpu))
-		copy_kernel_to_fpregs(&dst_fpu->state);
-
+	else
+		save_fpregs_to_fpstate(dst_fpu);
 	fpregs_unlock();
 
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
@@ -253,63 +286,6 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
-/*
- * Activate the current task's in-memory FPU context,
- * if it has not been used before:
- */
-static void fpu__initialize(struct fpu *fpu)
-{
-	WARN_ON_FPU(fpu != &current->thread.fpu);
-
-	set_thread_flag(TIF_NEED_FPU_LOAD);
-	fpstate_init(&fpu->state);
-	trace_x86_fpu_init_state(fpu);
-}
-
-/*
- * This function must be called before we read a task's fpstate.
- *
- * There's two cases where this gets called:
- *
- * - for the current task (when coredumping), in which case we have
- *   to save the latest FPU registers into the fpstate,
- *
- * - or it's called for stopped tasks (ptrace), in which case the
- *   registers were already saved by the context-switch code when
- *   the task scheduled out.
- *
- * If the task has used the FPU before then save it.
- */
-void fpu__prepare_read(struct fpu *fpu)
-{
-	if (fpu == &current->thread.fpu)
-		fpu__save(fpu);
-}
-
-/*
- * This function must be called before we write a task's fpstate.
- *
- * Invalidate any cached FPU registers.
- *
- * After this function call, after registers in the fpstate are
- * modified and the child task has woken up, the child task will
- * restore the modified FPU state from the modified context. If we
- * didn't clear its cached status here then the cached in-registers
- * state pending on its former CPU could be restored, corrupting
- * the modifications.
- */
-void fpu__prepare_write(struct fpu *fpu)
-{
-	/*
-	 * Only stopped child tasks can be used to modify the FPU
-	 * state in the fpstate buffer:
-	 */
-	WARN_ON_FPU(fpu == &current->thread.fpu);
-
-	/* Invalidate any cached state: */
-	__fpu_invalidate_fpregs_state(fpu);
-}
-
 /*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
@@ -340,61 +316,97 @@ void fpu__drop(struct fpu *fpu)
  * Clear FPU registers by setting them up from the init fpstate.
  * Caller must do fpregs_[un]lock() around it.
  */
-static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
+static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 {
 	if (use_xsave())
-		copy_kernel_to_xregs(&init_fpstate.xsave, features_mask);
-	else if (static_cpu_has(X86_FEATURE_FXSR))
-		copy_kernel_to_fxregs(&init_fpstate.fxsave);
+		os_xrstor(&init_fpstate.xsave, features_mask);
+	else if (use_fxsr())
+		fxrstor(&init_fpstate.fxsave);
 	else
-		copy_kernel_to_fregs(&init_fpstate.fsave);
+		frstor(&init_fpstate.fsave);
 
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		copy_init_pkru_to_fpregs();
+	pkru_write_default();
+}
+
+static inline unsigned int init_fpstate_copy_size(void)
+{
+	if (!use_xsave())
+		return fpu_kernel_xstate_size;
+
+	/* XSAVE(S) just needs the legacy and the xstate header part */
+	return sizeof(init_fpstate.xsave);
 }
 
 /*
- * Clear the FPU state back to init state.
- *
- * Called by sys_execve(), by the signal handler code and by various
- * error paths.
+ * Reset current->fpu memory state to the init values.
+ */
+static void fpu_reset_fpstate(void)
+{
+	struct fpu *fpu = &current->thread.fpu;
+
+	fpregs_lock();
+	fpu__drop(fpu);
+	/*
+	 * This does not change the actual hardware registers. It just
+	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a
+	 * subsequent return to usermode will reload the registers from the
+	 * task's memory image.
+	 *
+	 * Do not use fpstate_init() here. Just copy init_fpstate which has
+	 * the correct content already except for PKRU.
+	 *
+	 * PKRU handling does not rely on the xstate when restoring for
+	 * user space as PKRU is eagerly written in switch_to() and
+	 * flush_thread().
+	 */
+	memcpy(&fpu->state, &init_fpstate, init_fpstate_copy_size());
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+	fpregs_unlock();
+}
+
+/*
+ * Reset current's user FPU states to the init states.  current's
+ * supervisor states, if any, are not modified by this function.  The
+ * caller guarantees that the XSTATE header in memory is intact.
  */
-static void fpu__clear(struct fpu *fpu, bool user_only)
+void fpu__clear_user_states(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
-	if (!static_cpu_has(X86_FEATURE_FPU)) {
-		fpu__drop(fpu);
-		fpu__initialize(fpu);
+	fpregs_lock();
+	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
+		fpu_reset_fpstate();
+		fpregs_unlock();
 		return;
 	}
 
-	fpregs_lock();
-
-	if (user_only) {
-		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
-		    xfeatures_mask_supervisor())
-			copy_kernel_to_xregs(&fpu->state.xsave,
-					     xfeatures_mask_supervisor());
-		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
-	} else {
-		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
+	/*
+	 * Ensure that current's supervisor states are loaded into their
+	 * corresponding registers.
+	 */
+	if (xfeatures_mask_supervisor() &&
+	    !fpregs_state_valid(fpu, smp_processor_id())) {
+		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
 	}
 
+	/* Reset user states in registers. */
+	restore_fpregs_from_init_fpstate(xfeatures_mask_restore_user());
+
+	/*
+	 * Now all FPU registers have their desired values.  Inform the FPU
+	 * state machine that current's FPU registers are in the hardware
+	 * registers. The memory image does not need to be updated because
+	 * any operation relying on it has to save the registers first when
+	 * current's FPU is marked active.
+	 */
 	fpregs_mark_activate();
 	fpregs_unlock();
 }
 
-void fpu__clear_user_states(struct fpu *fpu)
+void fpu_flush_thread(void)
 {
-	fpu__clear(fpu, true);
+	fpu_reset_fpstate();
 }
-
-void fpu__clear_all(struct fpu *fpu)
-{
-	fpu__clear(fpu, false);
-}
-
 /*
  * Load FPU context before returning to userspace.
  */
@@ -403,7 +415,7 @@ void switch_fpu_return(void)
 	if (!static_cpu_has(X86_FEATURE_FPU))
 		return;
 
-	__fpregs_load_activate();
+	fpregs_restore_userregs();
 }
 EXPORT_SYMBOL_GPL(switch_fpu_return);
 
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 701f196d7c68..64e29927cc32 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -89,7 +89,7 @@ static void fpu__init_system_early_generic(struct cpuinfo_x86 *c)
 /*
  * Boot time FPU feature detection code:
  */
-unsigned int mxcsr_feature_mask __read_mostly = 0xffffffffu;
+unsigned int mxcsr_feature_mask __ro_after_init = 0xffffffffu;
 EXPORT_SYMBOL_GPL(mxcsr_feature_mask);
 
 static void __init fpu__init_system_mxcsr(void)
@@ -135,7 +135,7 @@ static void __init fpu__init_system_generic(void)
  * This is inherent to the XSAVE architecture which puts all state
  * components into a single, continuous memory block:
  */
-unsigned int fpu_kernel_xstate_size;
+unsigned int fpu_kernel_xstate_size __ro_after_init;
 EXPORT_SYMBOL_GPL(fpu_kernel_xstate_size);
 
 /* Get alignment of the TYPE. */
@@ -216,17 +216,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_user_xstate_size = fpu_kernel_xstate_size;
 }
 
-/*
- * Find supported xfeatures based on cpu features and command-line input.
- * This must be called after fpu__init_parse_early_param() is called and
- * xfeatures_mask is enumerated.
- */
-u64 __init fpu__get_supported_xfeatures_mask(void)
-{
-	return XFEATURE_MASK_USER_SUPPORTED |
-	       XFEATURE_MASK_SUPERVISOR_SUPPORTED;
-}
-
 /* Legacy code to initialize eager fpu mode. */
 static void __init fpu__init_system_ctx_switch(void)
 {
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index c413756ba89f..66ed317ebc0d 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -2,11 +2,13 @@
 /*
  * FPU register's regset abstraction, for ptrace, core dumps, etc.
  */
+#include <linux/sched/task_stack.h>
+#include <linux/vmalloc.h>
+
 #include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
-#include <linux/sched/task_stack.h>
 
 /*
  * The xstateregs_active() routine is the same as the regset_fpregs_active() routine,
@@ -26,18 +28,58 @@ int regset_xregset_fpregs_active(struct task_struct *target, const struct user_r
 		return 0;
 }
 
+/*
+ * The regset get() functions are invoked from:
+ *
+ *   - coredump to dump the current task's fpstate. If the current task
+ *     owns the FPU then the memory state has to be synchronized and the
+ *     FPU register state preserved. Otherwise fpstate is already in sync.
+ *
+ *   - ptrace to dump fpstate of a stopped task, in which case the registers
+ *     have already been saved to fpstate on context switch.
+ */
+static void sync_fpstate(struct fpu *fpu)
+{
+	if (fpu == &current->thread.fpu)
+		fpu_sync_fpstate(fpu);
+}
+
+/*
+ * Invalidate cached FPU registers before modifying the stopped target
+ * task's fpstate.
+ *
+ * This forces the target task on resume to restore the FPU registers from
+ * modified fpstate. Otherwise the task might skip the restore and operate
+ * with the cached FPU registers which discards the modifications.
+ */
+static void fpu_force_restore(struct fpu *fpu)
+{
+	/*
+	 * Only stopped child tasks can be used to modify the FPU
+	 * state in the fpstate buffer:
+	 */
+	WARN_ON_FPU(fpu == &current->thread.fpu);
+
+	__fpu_invalidate_fpregs_state(fpu);
+}
+
 int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
 	struct fpu *fpu = &target->thread.fpu;
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR))
+	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
 
-	fpu__prepare_read(fpu);
-	fpstate_sanitize_xstate(fpu);
+	sync_fpstate(fpu);
+
+	if (!use_xsave()) {
+		return membuf_write(&to, &fpu->state.fxsave,
+				    sizeof(fpu->state.fxsave));
+	}
 
-	return membuf_write(&to, &fpu->state.fxsave, sizeof(struct fxregs_state));
+	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_FX);
+	return 0;
 }
 
 int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
@@ -45,62 +87,52 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 		const void *kbuf, const void __user *ubuf)
 {
 	struct fpu *fpu = &target->thread.fpu;
+	struct user32_fxsr_struct newstate;
 	int ret;
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR))
+	BUILD_BUG_ON(sizeof(newstate) != sizeof(struct fxregs_state));
+
+	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
 
-	fpu__prepare_write(fpu);
-	fpstate_sanitize_xstate(fpu);
+	/* No funny business with partial or oversized writes is permitted. */
+	if (pos != 0 || count != sizeof(newstate))
+		return -EINVAL;
 
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 &fpu->state.fxsave, 0, -1);
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newstate, 0, -1);
+	if (ret)
+		return ret;
 
-	/*
-	 * mxcsr reserved bits must be masked to zero for security reasons.
-	 */
-	fpu->state.fxsave.mxcsr &= mxcsr_feature_mask;
+	/* Do not allow an invalid MXCSR value. */
+	if (newstate.mxcsr & ~mxcsr_feature_mask)
+		return -EINVAL;
 
-	/*
-	 * update the header bits in the xsave header, indicating the
-	 * presence of FP and SSE state.
-	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
+	fpu_force_restore(fpu);
+
+	/* Copy the state  */
+	memcpy(&fpu->state.fxsave, &newstate, sizeof(newstate));
+
+	/* Clear xmm8..15 */
+	BUILD_BUG_ON(sizeof(fpu->state.fxsave.xmm_space) != 16 * 16);
+	memset(&fpu->state.fxsave.xmm_space[8], 0, 8 * 16);
+
+	/* Mark FP and SSE as in use when XSAVE is enabled */
+	if (use_xsave())
 		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
 
-	return ret;
+	return 0;
 }
 
 int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
-	struct xregs_state *xsave;
-
-	if (!boot_cpu_has(X86_FEATURE_XSAVE))
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	xsave = &fpu->state.xsave;
-
-	fpu__prepare_read(fpu);
+	sync_fpstate(&target->thread.fpu);
 
-	if (using_compacted_format()) {
-		copy_xstate_to_kernel(to, xsave);
-		return 0;
-	} else {
-		fpstate_sanitize_xstate(fpu);
-		/*
-		 * Copy the 48 bytes defined by the software into the xsave
-		 * area in the thread struct, so that we can copy the whole
-		 * area to user using one user_regset_copyout().
-		 */
-		memcpy(&xsave->i387.sw_reserved, xstate_fx_sw_bytes, sizeof(xstate_fx_sw_bytes));
-
-		/*
-		 * Copy the xstate memory layout.
-		 */
-		return membuf_write(&to, xsave, fpu_user_xstate_size);
-	}
+	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_XSAVE);
+	return 0;
 }
 
 int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
@@ -108,44 +140,34 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 		  const void *kbuf, const void __user *ubuf)
 {
 	struct fpu *fpu = &target->thread.fpu;
-	struct xregs_state *xsave;
+	struct xregs_state *tmpbuf = NULL;
 	int ret;
 
-	if (!boot_cpu_has(X86_FEATURE_XSAVE))
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
 	/*
 	 * A whole standard-format XSAVE buffer is needed:
 	 */
-	if ((pos != 0) || (count < fpu_user_xstate_size))
+	if (pos != 0 || count != fpu_user_xstate_size)
 		return -EFAULT;
 
-	xsave = &fpu->state.xsave;
-
-	fpu__prepare_write(fpu);
+	if (!kbuf) {
+		tmpbuf = vmalloc(count);
+		if (!tmpbuf)
+			return -ENOMEM;
 
-	if (using_compacted_format()) {
-		if (kbuf)
-			ret = copy_kernel_to_xstate(xsave, kbuf);
-		else
-			ret = copy_user_to_xstate(xsave, ubuf);
-	} else {
-		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
-		if (!ret)
-			ret = validate_user_xstate_header(&xsave->header);
+		if (copy_from_user(tmpbuf, ubuf, count)) {
+			ret = -EFAULT;
+			goto out;
+		}
 	}
 
-	/*
-	 * mxcsr reserved bits must be masked to zero for security reasons.
-	 */
-	xsave->i387.mxcsr &= mxcsr_feature_mask;
-
-	/*
-	 * In case of failure, mark all states as init:
-	 */
-	if (ret)
-		fpstate_init(&fpu->state);
+	fpu_force_restore(fpu);
+	ret = copy_uabi_from_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
 
+out:
+	vfree(tmpbuf);
 	return ret;
 }
 
@@ -221,10 +243,10 @@ static inline u32 twd_fxsr_to_i387(struct fxregs_state *fxsave)
  * FXSR floating point environment conversions.
  */
 
-void
-convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
+static void __convert_from_fxsr(struct user_i387_ia32_struct *env,
+				struct task_struct *tsk,
+				struct fxregs_state *fxsave)
 {
-	struct fxregs_state *fxsave = &tsk->thread.fpu.state.fxsave;
 	struct _fpreg *to = (struct _fpreg *) &env->st_space[0];
 	struct _fpxreg *from = (struct _fpxreg *) &fxsave->st_space[0];
 	int i;
@@ -258,6 +280,12 @@ convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
 		memcpy(&to[i], &from[i], sizeof(to[0]));
 }
 
+void
+convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
+{
+	__convert_from_fxsr(env, tsk, &tsk->thread.fpu.state.fxsave);
+}
+
 void convert_to_fxsr(struct fxregs_state *fxsave,
 		     const struct user_i387_ia32_struct *env)
 
@@ -290,25 +318,29 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 {
 	struct fpu *fpu = &target->thread.fpu;
 	struct user_i387_ia32_struct env;
+	struct fxregs_state fxsave, *fx;
 
-	fpu__prepare_read(fpu);
+	sync_fpstate(fpu);
 
-	if (!boot_cpu_has(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return fpregs_soft_get(target, regset, to);
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR)) {
+	if (!cpu_feature_enabled(X86_FEATURE_FXSR)) {
 		return membuf_write(&to, &fpu->state.fsave,
 				    sizeof(struct fregs_state));
 	}
 
-	fpstate_sanitize_xstate(fpu);
+	if (use_xsave()) {
+		struct membuf mb = { .p = &fxsave, .left = sizeof(fxsave) };
 
-	if (to.left == sizeof(env)) {
-		convert_from_fxsr(to.p, target);
-		return 0;
+		/* Handle init state optimized xstate correctly */
+		copy_xstate_to_uabi_buf(mb, target, XSTATE_COPY_FP);
+		fx = &fxsave;
+	} else {
+		fx = &fpu->state.fxsave;
 	}
 
-	convert_from_fxsr(&env, target);
+	__convert_from_fxsr(&env, target, fx);
 	return membuf_write(&to, &env, sizeof(env));
 }
 
@@ -320,31 +352,32 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	struct user_i387_ia32_struct env;
 	int ret;
 
-	fpu__prepare_write(fpu);
-	fpstate_sanitize_xstate(fpu);
+	/* No funny business with partial or oversized writes is permitted. */
+	if (pos != 0 || count != sizeof(struct user_i387_ia32_struct))
+		return -EINVAL;
 
-	if (!boot_cpu_has(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return fpregs_soft_set(target, regset, pos, count, kbuf, ubuf);
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR))
-		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					  &fpu->state.fsave, 0,
-					  -1);
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
+	if (ret)
+		return ret;
 
-	if (pos > 0 || count < sizeof(env))
-		convert_from_fxsr(&env, target);
+	fpu_force_restore(fpu);
 
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
-	if (!ret)
-		convert_to_fxsr(&target->thread.fpu.state.fxsave, &env);
+	if (cpu_feature_enabled(X86_FEATURE_FXSR))
+		convert_to_fxsr(&fpu->state.fxsave, &env);
+	else
+		memcpy(&fpu->state.fsave, &env, sizeof(env));
 
 	/*
-	 * update the header bit in the xsave header, indicating the
+	 * Update the header bit in the xsave header, indicating the
 	 * presence of FP.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
+	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
 		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FP;
-	return ret;
+
+	return 0;
 }
 
 #endif	/* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index b7b92cdf3add..445c57c9c539 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -15,29 +15,30 @@
 #include <asm/sigframe.h>
 #include <asm/trace/fpu.h>
 
-static struct _fpx_sw_bytes fx_sw_reserved, fx_sw_reserved_ia32;
+static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
+static struct _fpx_sw_bytes fx_sw_reserved_ia32 __ro_after_init;
 
 /*
  * Check for the presence of extended state information in the
  * user fpstate pointer in the sigcontext.
  */
-static inline int check_for_xstate(struct fxregs_state __user *buf,
-				   void __user *fpstate,
-				   struct _fpx_sw_bytes *fx_sw)
+static inline int check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
+					   struct _fpx_sw_bytes *fx_sw)
 {
 	int min_xstate_size = sizeof(struct fxregs_state) +
 			      sizeof(struct xstate_header);
+	void __user *fpstate = fxbuf;
 	unsigned int magic2;
 
-	if (__copy_from_user(fx_sw, &buf->sw_reserved[0], sizeof(*fx_sw)))
-		return -1;
+	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
+		return -EFAULT;
 
 	/* Check for the first magic field and other error scenarios. */
 	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
 	    fx_sw->xstate_size < min_xstate_size ||
 	    fx_sw->xstate_size > fpu_user_xstate_size ||
 	    fx_sw->xstate_size > fx_sw->extended_size)
-		return -1;
+		goto setfx;
 
 	/*
 	 * Check for the presence of second magic word at the end of memory
@@ -45,10 +46,18 @@ static inline int check_for_xstate(struct fxregs_state __user *buf,
 	 * fpstate layout with out copying the extended state information
 	 * in the memory layout.
 	 */
-	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size))
-	    || magic2 != FP_XSTATE_MAGIC2)
-		return -1;
+	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
+		return -EFAULT;
 
+	if (likely(magic2 == FP_XSTATE_MAGIC2))
+		return 0;
+setfx:
+	trace_x86_fpu_xstate_check_failed(&current->thread.fpu);
+
+	/* Set the parameters for fx only state */
+	fx_sw->magic1 = 0;
+	fx_sw->xstate_size = sizeof(struct fxregs_state);
+	fx_sw->xfeatures = XFEATURE_MASK_FPSSE;
 	return 0;
 }
 
@@ -64,7 +73,7 @@ static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
 
 		fpregs_lock();
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-			copy_fxregs_to_kernel(&tsk->thread.fpu);
+			fxsave(&tsk->thread.fpu.state.fxsave);
 		fpregs_unlock();
 
 		convert_from_fxsr(&env, tsk);
@@ -129,11 +138,11 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 	int err;
 
 	if (use_xsave())
-		err = copy_xregs_to_user(buf);
+		err = xsave_to_user_sigframe(buf);
 	else if (use_fxsr())
-		err = copy_fxregs_to_user((struct fxregs_state __user *) buf);
+		err = fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
-		err = copy_fregs_to_user((struct fregs_state __user *) buf);
+		err = fnsave_to_user_sigframe((struct fregs_state __user *) buf);
 
 	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
 		err = -EFAULT;
@@ -188,7 +197,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		__fpregs_load_activate();
+		fpregs_restore_userregs();
 
 	pagefault_disable();
 	ret = copy_fpregs_to_sigframe(buf_fx);
@@ -211,189 +220,132 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	return 0;
 }
 
-static inline void
-sanitize_restored_user_xstate(union fpregs_state *state,
-			      struct user_i387_ia32_struct *ia32_env,
-			      u64 user_xfeatures, int fx_only)
+static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
+				      bool fx_only)
 {
-	struct xregs_state *xsave = &state->xsave;
-	struct xstate_header *header = &xsave->header;
-
 	if (use_xsave()) {
-		/*
-		 * Clear all feature bits which are not set in
-		 * user_xfeatures and clear all extended features
-		 * for fx_only mode.
-		 */
-		u64 mask = fx_only ? XFEATURE_MASK_FPSSE : user_xfeatures;
+		u64 init_bv = xfeatures_mask_uabi() & ~xrestore;
+		int ret;
 
-		/*
-		 * Supervisor state has to be preserved. The sigframe
-		 * restore can only modify user features, i.e. @mask
-		 * cannot contain them.
-		 */
-		header->xfeatures &= mask | xfeatures_mask_supervisor();
-	}
-
-	if (use_fxsr()) {
-		/*
-		 * mscsr reserved bits must be masked to zero for security
-		 * reasons.
-		 */
-		xsave->i387.mxcsr &= mxcsr_feature_mask;
+		if (likely(!fx_only))
+			ret = xrstor_from_user_sigframe(buf, xrestore);
+		else
+			ret = fxrstor_from_user_sigframe(buf);
 
-		if (ia32_env)
-			convert_to_fxsr(&state->fxsave, ia32_env);
+		if (!ret && unlikely(init_bv))
+			os_xrstor(&init_fpstate.xsave, init_bv);
+		return ret;
+	} else if (use_fxsr()) {
+		return fxrstor_from_user_sigframe(buf);
+	} else {
+		return frstor_from_user_sigframe(buf);
 	}
 }
 
 /*
- * Restore the extended state if present. Otherwise, restore the FP/SSE state.
+ * Attempt to restore the FPU registers directly from user memory.
+ * Pagefaults are handled and any errors returned are fatal.
  */
-static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
+				    bool fx_only, unsigned int size)
 {
-	u64 init_bv;
-	int r;
+	struct fpu *fpu = &current->thread.fpu;
+	int ret;
 
-	if (use_xsave()) {
-		if (fx_only) {
-			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
-
-			r = copy_user_to_fxregs(buf);
-			if (!r)
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			return r;
-		} else {
-			init_bv = xfeatures_mask_user() & ~xbv;
-
-			r = copy_user_to_xregs(buf, xbv);
-			if (!r && unlikely(init_bv))
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			return r;
-		}
-	} else if (use_fxsr()) {
-		return copy_user_to_fxregs(buf);
-	} else
-		return copy_user_to_fregs(buf);
+retry:
+	fpregs_lock();
+	pagefault_disable();
+	ret = __restore_fpregs_from_user(buf, xrestore, fx_only);
+	pagefault_enable();
+
+	if (unlikely(ret)) {
+		/*
+		 * The above did an FPU restore operation, restricted to
+		 * the user portion of the registers, and failed, but the
+		 * microcode might have modified the FPU registers
+		 * nevertheless.
+		 *
+		 * If the FPU registers do not belong to current, then
+		 * invalidate the FPU register state otherwise the task
+		 * might preempt current and return to user space with
+		 * corrupted FPU registers.
+		 */
+		if (test_thread_flag(TIF_NEED_FPU_LOAD))
+			__cpu_invalidate_fpregs_state();
+		fpregs_unlock();
+
+		/* Try to handle #PF, but anything else is fatal. */
+		if (ret != -EFAULT)
+			return -EINVAL;
+
+		ret = fault_in_pages_readable(buf, size);
+		if (!ret)
+			goto retry;
+		return ret;
+	}
+
+	/*
+	 * Restore supervisor states: previous context switch etc has done
+	 * XSAVES and saved the supervisor states in the kernel buffer from
+	 * which they can be restored now.
+	 *
+	 * It would be optimal to handle this with a single XRSTORS, but
+	 * this does not work because the rest of the FPU registers have
+	 * been restored from a user buffer directly.
+	 */
+	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
+		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
+
+	fpregs_mark_activate();
+	fpregs_unlock();
+	return 0;
 }
 
-static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
+static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
+			     bool ia32_fxstate)
 {
-	struct user_i387_ia32_struct *envp = NULL;
 	int state_size = fpu_kernel_xstate_size;
-	int ia32_fxstate = (buf != buf_fx);
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
 	u64 user_xfeatures = 0;
-	int fx_only = 0;
-	int ret = 0;
-
-	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
-			 IS_ENABLED(CONFIG_IA32_EMULATION));
-
-	if (!buf) {
-		fpu__clear_user_states(fpu);
-		return 0;
-	}
-
-	if (!access_ok(buf, size)) {
-		ret = -EACCES;
-		goto out;
-	}
-
-	if (!static_cpu_has(X86_FEATURE_FPU)) {
-		ret = fpregs_soft_set(current, NULL, 0,
-				      sizeof(struct user_i387_ia32_struct),
-				      NULL, buf);
-		goto out;
-	}
+	bool fx_only = false;
+	int ret;
 
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
-		if (unlikely(check_for_xstate(buf_fx, buf_fx, &fx_sw_user))) {
-			/*
-			 * Couldn't find the extended state information in the
-			 * memory layout. Restore just the FP/SSE and init all
-			 * the other extended state.
-			 */
-			state_size = sizeof(struct fxregs_state);
-			fx_only = 1;
-			trace_x86_fpu_xstate_check_failed(fpu);
-		} else {
-			state_size = fx_sw_user.xstate_size;
-			user_xfeatures = fx_sw_user.xfeatures;
-		}
-	}
 
-	if ((unsigned long)buf_fx % 64)
-		fx_only = 1;
+		ret = check_xstate_in_sigframe(buf_fx, &fx_sw_user);
+		if (unlikely(ret))
+			return ret;
 
-	if (!ia32_fxstate) {
-		/*
-		 * Attempt to restore the FPU registers directly from user
-		 * memory. For that to succeed, the user access cannot cause
-		 * page faults. If it does, fall back to the slow path below,
-		 * going through the kernel buffer with the enabled pagefault
-		 * handler.
-		 */
-		fpregs_lock();
-		pagefault_disable();
-		ret = copy_user_to_fpregs_zeroing(buf_fx, user_xfeatures, fx_only);
-		pagefault_enable();
-		if (!ret) {
-
-			/*
-			 * Restore supervisor states: previous context switch
-			 * etc has done XSAVES and saved the supervisor states
-			 * in the kernel buffer from which they can be restored
-			 * now.
-			 *
-			 * We cannot do a single XRSTORS here - which would
-			 * be nice - because the rest of the FPU registers are
-			 * being restored from a user buffer directly. The
-			 * single XRSTORS happens below, when the user buffer
-			 * has been copied to the kernel one.
-			 */
-			if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
-			    xfeatures_mask_supervisor())
-				copy_kernel_to_xregs(&fpu->state.xsave,
-						     xfeatures_mask_supervisor());
-			fpregs_mark_activate();
-			fpregs_unlock();
-			return 0;
-		}
-
-		/*
-		 * The above did an FPU restore operation, restricted to
-		 * the user portion of the registers, and failed, but the
-		 * microcode might have modified the FPU registers
-		 * nevertheless.
-		 *
-		 * If the FPU registers do not belong to current, then
-		 * invalidate the FPU register state otherwise the task might
-		 * preempt current and return to user space with corrupted
-		 * FPU registers.
-		 *
-		 * In case current owns the FPU registers then no further
-		 * action is required. The fixup below will handle it
-		 * correctly.
-		 */
-		if (test_thread_flag(TIF_NEED_FPU_LOAD))
-			__cpu_invalidate_fpregs_state();
-
-		fpregs_unlock();
+		fx_only = !fx_sw_user.magic1;
+		state_size = fx_sw_user.xstate_size;
+		user_xfeatures = fx_sw_user.xfeatures;
 	} else {
+		user_xfeatures = XFEATURE_MASK_FPSSE;
+	}
+
+	if (likely(!ia32_fxstate)) {
 		/*
-		 * For 32-bit frames with fxstate, copy the fxstate so it can
-		 * be reconstructed later.
+		 * Attempt to restore the FPU registers directly from user
+		 * memory. For that to succeed, the user access cannot cause page
+		 * faults. If it does, fall back to the slow path below, going
+		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		ret = __copy_from_user(&env, buf, sizeof(env));
-		if (ret)
-			goto out;
-		envp = &env;
+		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
+						state_size);
 	}
 
+	/*
+	 * Copy the legacy state because the FP portion of the FX frame has
+	 * to be ignored for histerical raisins. The legacy state is folded
+	 * in once the larger state has been copied.
+	 */
+	ret = __copy_from_user(&env, buf, sizeof(env));
+	if (ret)
+		return ret;
+
 	/*
 	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
 	 * not modified on context switch and that the xstate is considered
@@ -401,80 +353,69 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	 * the optimisation).
 	 */
 	fpregs_lock();
-
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-
 		/*
-		 * Supervisor states are not modified by user space input.  Save
-		 * current supervisor states first and invalidate the FPU regs.
+		 * If supervisor states are available then save the
+		 * hardware state in current's fpstate so that the
+		 * supervisor state is preserved. Save the full state for
+		 * simplicity. There is no point in optimizing this by only
+		 * saving the supervisor states and then shuffle them to
+		 * the right place in memory. It's ia32 mode. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
-			copy_supervisor_to_kernel(&fpu->state.xsave);
+			os_xsave(&fpu->state.xsave);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
+	__cpu_invalidate_fpregs_state();
 	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
-
-		ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
+		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
-			goto out;
+			return ret;
+	} else {
+		if (__copy_from_user(&fpu->state.fxsave, buf_fx,
+				     sizeof(fpu->state.fxsave)))
+			return -EFAULT;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
-					      fx_only);
+		/* Reject invalid MXCSR values. */
+		if (fpu->state.fxsave.mxcsr & ~mxcsr_feature_mask)
+			return -EINVAL;
 
-		fpregs_lock();
-		if (unlikely(init_bv))
-			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
+		if (use_xsave())
+			fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
+	}
 
+	/* Fold the legacy FP storage */
+	convert_to_fxsr(&fpu->state.fxsave, &env);
+
+	fpregs_lock();
+	if (use_xsave()) {
 		/*
-		 * Restore previously saved supervisor xstates along with
-		 * copied-in user xstates.
+		 * Remove all UABI feature bits not set in user_xfeatures
+		 * from the memory xstate header which makes the full
+		 * restore below bring them into init state. This works for
+		 * fx_only mode as well because that has only FP and SSE
+		 * set in user_xfeatures.
+		 *
+		 * Preserve supervisor states!
 		 */
-		ret = copy_kernel_to_xregs_err(&fpu->state.xsave,
-					       user_xfeatures | xfeatures_mask_supervisor());
+		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
-	} else if (use_fxsr()) {
-		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
-		if (ret) {
-			ret = -EFAULT;
-			goto out;
-		}
-
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
-					      fx_only);
-
-		fpregs_lock();
-		if (use_xsave()) {
-			u64 init_bv;
-
-			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
-			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-		}
-
-		ret = copy_kernel_to_fxregs_err(&fpu->state.fxsave);
+		fpu->state.xsave.header.xfeatures &= mask;
+		ret = os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all);
 	} else {
-		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
-		if (ret)
-			goto out;
-
-		fpregs_lock();
-		ret = copy_kernel_to_fregs_err(&fpu->state.fsave);
+		ret = fxrstor_safe(&fpu->state.fxsave);
 	}
-	if (!ret)
+
+	if (likely(!ret))
 		fpregs_mark_activate();
-	else
-		fpregs_deactivate(fpu);
-	fpregs_unlock();
 
-out:
-	if (ret)
-		fpu__clear_user_states(fpu);
+	fpregs_unlock();
 	return ret;
 }
-
 static inline int xstate_sigframe_size(void)
 {
 	return use_xsave() ? fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE :
@@ -486,15 +427,47 @@ static inline int xstate_sigframe_size(void)
  */
 int fpu__restore_sig(void __user *buf, int ia32_frame)
 {
+	unsigned int size = xstate_sigframe_size();
+	struct fpu *fpu = &current->thread.fpu;
 	void __user *buf_fx = buf;
-	int size = xstate_sigframe_size();
+	bool ia32_fxstate = false;
+	int ret;
 
+	if (unlikely(!buf)) {
+		fpu__clear_user_states(fpu);
+		return 0;
+	}
+
+	ia32_frame &= (IS_ENABLED(CONFIG_X86_32) ||
+		       IS_ENABLED(CONFIG_IA32_EMULATION));
+
+	/*
+	 * Only FXSR enabled systems need the FX state quirk.
+	 * FRSTOR does not need it and can use the fast path.
+	 */
 	if (ia32_frame && use_fxsr()) {
 		buf_fx = buf + sizeof(struct fregs_state);
 		size += sizeof(struct fregs_state);
+		ia32_fxstate = true;
+	}
+
+	if (!access_ok(buf, size)) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	if (!IS_ENABLED(CONFIG_X86_64) && !cpu_feature_enabled(X86_FEATURE_FPU)) {
+		ret = fpregs_soft_set(current, NULL, 0,
+				      sizeof(struct user_i387_ia32_struct),
+				      NULL, buf);
+	} else {
+		ret = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
 	}
 
-	return __fpu__restore_sig(buf, buf_fx, size);
+out:
+	if (unlikely(ret))
+		fpu__clear_user_states(fpu);
+	return ret;
 }
 
 unsigned long
@@ -513,6 +486,25 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 	return sp;
 }
+
+unsigned long fpu__get_fpstate_size(void)
+{
+	unsigned long ret = xstate_sigframe_size();
+
+	/*
+	 * This space is needed on (most) 32-bit kernels, or when a 32-bit
+	 * app is running on a 64-bit kernel. To keep things simple, just
+	 * assume the worst case and always include space for 'freg_state',
+	 * even for 64-bit apps on 64-bit kernels. This wastes a bit of
+	 * space, but keeps the code simple.
+	 */
+	if ((IS_ENABLED(CONFIG_IA32_EMULATION) ||
+	     IS_ENABLED(CONFIG_X86_32)) && use_fxsr())
+		ret += sizeof(struct fregs_state);
+
+	return ret;
+}
+
 /*
  * Prepare the SW reserved portion of the fxsave memory layout, indicating
  * the presence of the extended state information in the memory layout
@@ -526,7 +518,7 @@ void fpu__init_prepare_fx_sw_frame(void)
 
 	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
 	fx_sw_reserved.extended_size = size;
-	fx_sw_reserved.xfeatures = xfeatures_mask_user();
+	fx_sw_reserved.xfeatures = xfeatures_mask_uabi();
 	fx_sw_reserved.xstate_size = fpu_user_xstate_size;
 
 	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1cadb2faf740..c8def1b7f8fb 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -59,19 +59,24 @@ static short xsave_cpuid_features[] __initdata = {
  * This represents the full set of bits that should ever be set in a kernel
  * XSAVE buffer, both supervisor and user xstates.
  */
-u64 xfeatures_mask_all __read_mostly;
-
-static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
+u64 xfeatures_mask_all __ro_after_init;
+EXPORT_SYMBOL_GPL(xfeatures_mask_all);
+
+static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
  * it is always in standard format for user mode. This is the user
  * mode standard format size used for signal and ptrace frames.
  */
-unsigned int fpu_user_xstate_size;
+unsigned int fpu_user_xstate_size __ro_after_init;
 
 /*
  * Return whether the system supports a given xfeature.
@@ -124,104 +129,14 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
-/*
- * When executing XSAVEOPT (or other optimized XSAVE instructions), if
- * a processor implementation detects that an FPU state component is still
- * (or is again) in its initialized state, it may clear the corresponding
- * bit in the header.xfeatures field, and can skip the writeout of registers
- * to the corresponding memory layout.
- *
- * This means that when the bit is zero, the state component might still contain
- * some previous - non-initialized register state.
- *
- * Before writing xstate information to user-space we sanitize those components,
- * to always ensure that the memory layout of a feature will be in the init state
- * if the corresponding header bit is zero. This is to ensure that user-space doesn't
- * see some stale state in the memory layout during signal handling, debugging etc.
- */
-void fpstate_sanitize_xstate(struct fpu *fpu)
-{
-	struct fxregs_state *fx = &fpu->state.fxsave;
-	int feature_bit;
-	u64 xfeatures;
-
-	if (!use_xsaveopt())
-		return;
-
-	xfeatures = fpu->state.xsave.header.xfeatures;
-
-	/*
-	 * None of the feature bits are in init state. So nothing else
-	 * to do for us, as the memory layout is up to date.
-	 */
-	if ((xfeatures & xfeatures_mask_all) == xfeatures_mask_all)
-		return;
-
-	/*
-	 * FP is in init state
-	 */
-	if (!(xfeatures & XFEATURE_MASK_FP)) {
-		fx->cwd = 0x37f;
-		fx->swd = 0;
-		fx->twd = 0;
-		fx->fop = 0;
-		fx->rip = 0;
-		fx->rdp = 0;
-		memset(fx->st_space, 0, sizeof(fx->st_space));
-	}
-
-	/*
-	 * SSE is in init state
-	 */
-	if (!(xfeatures & XFEATURE_MASK_SSE))
-		memset(fx->xmm_space, 0, sizeof(fx->xmm_space));
-
-	/*
-	 * First two features are FPU and SSE, which above we handled
-	 * in a special way already:
-	 */
-	feature_bit = 0x2;
-	xfeatures = (xfeatures_mask_user() & ~xfeatures) >> 2;
-
-	/*
-	 * Update all the remaining memory layouts according to their
-	 * standard xstate layout, if their header bit is in the init
-	 * state:
-	 */
-	while (xfeatures) {
-		if (xfeatures & 0x1) {
-			int offset = xstate_comp_offsets[feature_bit];
-			int size = xstate_sizes[feature_bit];
-
-			memcpy((void *)fx + offset,
-			       (void *)&init_fpstate.xsave + offset,
-			       size);
-		}
-
-		xfeatures >>= 1;
-		feature_bit++;
-	}
-}
-
 /*
  * Enable the extended processor state save/restore feature.
  * Called once per CPU onlining.
  */
 void fpu__init_cpu_xstate(void)
 {
-	u64 unsup_bits;
-
 	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
 		return;
-	/*
-	 * Unsupported supervisor xstates should not be found in
-	 * the xfeatures mask.
-	 */
-	unsup_bits = xfeatures_mask_all & XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
-	WARN_ONCE(unsup_bits, "x86/fpu: Found unsupported supervisor xstates: 0x%llx\n",
-		  unsup_bits);
-
-	xfeatures_mask_all &= ~XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
 
@@ -230,14 +145,14 @@ void fpu__init_cpu_xstate(void)
 	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
 	 * states can be set here.
 	 */
-	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
 
 	/*
 	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_independent());
 	}
 }
 
@@ -486,7 +401,7 @@ static void __init setup_init_fpu_buf(void)
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
 	 */
-	copy_kernel_to_xregs_booting(&init_fpstate.xsave);
+	os_xrstor_booting(&init_fpstate.xsave);
 
 	/*
 	 * All components are now in init state. Read the state back so
@@ -535,25 +450,11 @@ int xfeature_size(int xfeature_nr)
 	return eax;
 }
 
-/*
- * 'XSAVES' implies two different things:
- * 1. saving of supervisor/system state
- * 2. using the compacted format
- *
- * Use this function when dealing with the compacted format so
- * that it is obvious which aspect of 'XSAVES' is being handled
- * by the calling code.
- */
-int using_compacted_format(void)
-{
-	return boot_cpu_has(X86_FEATURE_XSAVES);
-}
-
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_user_xstate_header(const struct xstate_header *hdr)
+static int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & ~xfeatures_mask_user())
+	if (hdr->xfeatures & ~xfeatures_mask_uabi())
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -651,7 +552,7 @@ static void check_xstate_against_struct(int nr)
  * how large the XSAVE buffer needs to be.  We are recalculating
  * it to be safe.
  *
- * Dynamic XSAVE features allocate their own buffers and are not
+ * Independent XSAVE features allocate their own buffers and are not
  * covered by these checks. Only the size of the buffer for task->fpu
  * is checked here.
  */
@@ -667,9 +568,9 @@ static void do_extra_xstate_size_checks(void)
 		check_xstate_against_struct(i);
 		/*
 		 * Supervisor state components can be managed only by
-		 * XSAVES, which is compacted-format only.
+		 * XSAVES.
 		 */
-		if (!using_compacted_format())
+		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
 			XSTATE_WARN_ON(xfeature_is_supervisor(i));
 
 		/* Align from the end of the previous feature */
@@ -679,9 +580,9 @@ static void do_extra_xstate_size_checks(void)
 		 * The offset of a given state in the non-compacted
 		 * format is given to us in a CPUID leaf.  We check
 		 * them for being ordered (increasing offsets) in
-		 * setup_xstate_features().
+		 * setup_xstate_features(). XSAVES uses compacted format.
 		 */
-		if (!using_compacted_format())
+		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
 			paranoid_xstate_size = xfeature_uncompacted_offset(i);
 		/*
 		 * The compacted-format offset always depends on where
@@ -717,18 +618,18 @@ static unsigned int __init get_xsaves_size(void)
 }
 
 /*
- * Get the total size of the enabled xstates without the dynamic supervisor
+ * Get the total size of the enabled xstates without the independent supervisor
  * features.
  */
-static unsigned int __init get_xsaves_size_no_dynamic(void)
+static unsigned int __init get_xsaves_size_no_independent(void)
 {
-	u64 mask = xfeatures_mask_dynamic();
+	u64 mask = xfeatures_mask_independent();
 	unsigned int size;
 
 	if (!mask)
 		return get_xsaves_size();
 
-	/* Disable dynamic features. */
+	/* Disable independent features. */
 	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
 
 	/*
@@ -737,7 +638,7 @@ static unsigned int __init get_xsaves_size_no_dynamic(void)
 	 */
 	size = get_xsaves_size();
 
-	/* Re-enable dynamic features so XSAVES will work on them again. */
+	/* Re-enable independent features so XSAVES will work on them again. */
 	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
 
 	return size;
@@ -780,7 +681,7 @@ static int __init init_xstate_size(void)
 	xsave_size = get_xsave_size();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		possible_xstate_size = get_xsaves_size_no_dynamic();
+		possible_xstate_size = get_xsaves_size_no_independent();
 	else
 		possible_xstate_size = xsave_size;
 
@@ -821,6 +722,7 @@ void __init fpu__init_system_xstate(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 	static int on_boot_cpu __initdata = 1;
+	u64 xfeatures;
 	int err;
 	int i;
 
@@ -855,7 +757,7 @@ void __init fpu__init_system_xstate(void)
 	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
 	xfeatures_mask_all |= ecx + ((u64)edx << 32);
 
-	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
+	if ((xfeatures_mask_uabi() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
 		 * with the enumeration.  Disable XSAVE and try to continue
@@ -874,7 +776,11 @@ void __init fpu__init_system_xstate(void)
 			xfeatures_mask_all &= ~BIT_ULL(i);
 	}
 
-	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
+	xfeatures_mask_all &= XFEATURE_MASK_USER_SUPPORTED |
+			      XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+
+	/* Store it for paranoia check at the end */
+	xfeatures = xfeatures_mask_all;
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -886,14 +792,24 @@ void __init fpu__init_system_xstate(void)
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user());
+	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_uabi());
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
 	setup_supervisor_only_offsets();
-	print_xstate_offset_size();
 
+	/*
+	 * Paranoia check whether something in the setup modified the
+	 * xfeatures mask.
+	 */
+	if (xfeatures != xfeatures_mask_all) {
+		pr_err("x86/fpu: xfeatures modified from 0x%016llx to 0x%016llx during init, disabling XSAVE\n",
+		       xfeatures, xfeatures_mask_all);
+		goto out_disable;
+	}
+
+	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		xfeatures_mask_all,
 		fpu_kernel_xstate_size,
@@ -913,16 +829,16 @@ void fpu__resume_cpu(void)
 	/*
 	 * Restore XCR0 on xsave capable CPUs:
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
 
 	/*
 	 * Restore IA32_XSS. The same CPUID bit enumerates support
 	 * of XSAVES and MSR_IA32_XSS.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_independent());
 	}
 }
 
@@ -990,36 +906,6 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
 
-/*
- * This wraps up the common operations that need to occur when retrieving
- * data from xsave state.  It first ensures that the current task was
- * using the FPU and retrieves the data in to a buffer.  It then calculates
- * the offset of the requested field in the buffer.
- *
- * This function is safe to call whether the FPU is in use or not.
- *
- * Note that this only works on the current task.
- *
- * Inputs:
- *	@xfeature_nr: state which is defined in xsave.h (e.g. XFEATURE_FP,
- *	XFEATURE_SSE, etc...)
- * Output:
- *	address of the state in the xsave area or NULL if the state
- *	is not present or is in its 'init state'.
- */
-const void *get_xsave_field_ptr(int xfeature_nr)
-{
-	struct fpu *fpu = &current->thread.fpu;
-
-	/*
-	 * fpu__save() takes the CPU's xstate registers
-	 * and saves them off to the 'fpu memory buffer.
-	 */
-	fpu__save(fpu);
-
-	return get_xsave_addr(&fpu->state.xsave, xfeature_nr);
-}
-
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
 /*
@@ -1027,17 +913,16 @@ const void *get_xsave_field_ptr(int xfeature_nr)
  * rights for @pkey to @init_val.
  */
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val)
+			      unsigned long init_val)
 {
-	u32 old_pkru;
-	int pkey_shift = (pkey * PKRU_BITS_PER_PKEY);
-	u32 new_pkru_bits = 0;
+	u32 old_pkru, new_pkru_bits = 0;
+	int pkey_shift;
 
 	/*
 	 * This check implies XSAVE support.  OSPKE only gets
 	 * set if we enable XSAVE and we enable PKU in XCR0.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return -EINVAL;
 
 	/*
@@ -1045,7 +930,8 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	 * values originating from in-kernel users.  Complain
 	 * if a bad value is observed.
 	 */
-	WARN_ON_ONCE(pkey >= arch_max_pkey());
+	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
+		return -EINVAL;
 
 	/* Set the bits we need in PKRU:  */
 	if (init_val & PKEY_DISABLE_ACCESS)
@@ -1054,6 +940,7 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		new_pkru_bits |= PKRU_WD_BIT;
 
 	/* Shift the bits in to the correct place in PKRU for pkey: */
+	pkey_shift = pkey * PKRU_BITS_PER_PKEY;
 	new_pkru_bits <<= pkey_shift;
 
 	/* Get old PKRU and mask off any old bits in place: */
@@ -1067,170 +954,178 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 }
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
-/*
- * Weird legacy quirk: SSE and YMM states store information in the
- * MXCSR and MXCSR_FLAGS fields of the FP area. That means if the FP
- * area is marked as unused in the xfeatures header, we need to copy
- * MXCSR and MXCSR_FLAGS if either SSE or YMM are in use.
- */
-static inline bool xfeatures_mxcsr_quirk(u64 xfeatures)
+static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
+			 void *init_xstate, unsigned int size)
 {
-	if (!(xfeatures & (XFEATURE_MASK_SSE|XFEATURE_MASK_YMM)))
-		return false;
-
-	if (xfeatures & XFEATURE_MASK_FP)
-		return false;
-
-	return true;
-}
-
-static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
-{
-	if (*last >= offset)
-		return;
-	membuf_write(to, (void *)&init_fpstate.xsave + *last, offset - *last);
-	*last = offset;
-}
-
-static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
-		      unsigned size, void *from)
-{
-	fill_gap(to, last, offset);
-	membuf_write(to, from, size);
-	*last = offset + size;
+	membuf_write(to, from_xstate ? xstate : init_xstate, size);
 }
 
-/*
- * Convert from kernel XSAVES compacted format to standard format and copy
- * to a kernel-space ptrace buffer.
+/**
+ * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
+ * @to:		membuf descriptor
+ * @tsk:	The task from which to copy the saved xstate
+ * @copy_mode:	The requested copy mode
+ *
+ * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
+ * format, i.e. from the kernel internal hardware dependent storage format
+ * to the requested @mode. UABI XSTATE is always uncompacted!
  *
- * It supports partial copy but pos always starts from zero. This is called
- * from xstateregs_get() and there we check the CPU has XSAVES.
+ * It supports partial copy but @to.pos always starts from zero.
  */
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
+void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
+			     enum xstate_copy_mode copy_mode)
 {
+	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
+	struct xregs_state *xinit = &init_fpstate.xsave;
 	struct xstate_header header;
-	const unsigned off_mxcsr = offsetof(struct fxregs_state, mxcsr);
-	unsigned size = to.left;
-	unsigned last = 0;
+	unsigned int zerofrom;
 	int i;
 
-	/*
-	 * The destination is a ptrace buffer; we put in only user xstates:
-	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= xfeatures_mask_user();
-
-	if (header.xfeatures & XFEATURE_MASK_FP)
-		copy_part(&to, &last, 0, off_mxcsr, &xsave->i387);
-	if (header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM))
-		copy_part(&to, &last, off_mxcsr,
-			  MXCSR_AND_FLAGS_SIZE, &xsave->i387.mxcsr);
-	if (header.xfeatures & XFEATURE_MASK_FP)
-		copy_part(&to, &last, offsetof(struct fxregs_state, st_space),
-			  128, &xsave->i387.st_space);
-	if (header.xfeatures & XFEATURE_MASK_SSE)
-		copy_part(&to, &last, xstate_offsets[XFEATURE_SSE],
-			  256, &xsave->i387.xmm_space);
-	/*
-	 * Fill xsave->i387.sw_reserved value for ptrace frame:
-	 */
-	copy_part(&to, &last, offsetof(struct fxregs_state, sw_reserved),
-		  48, xstate_fx_sw_bytes);
-	/*
-	 * Copy xregs_state->header:
-	 */
-	copy_part(&to, &last, offsetof(struct xregs_state, header),
-		  sizeof(header), &header);
 
-	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		/*
-		 * Copy only in-use xstates:
-		 */
-		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, i);
+	/* Mask out the feature bits depending on copy mode */
+	switch (copy_mode) {
+	case XSTATE_COPY_FP:
+		header.xfeatures &= XFEATURE_MASK_FP;
+		break;
 
-			copy_part(&to, &last, xstate_offsets[i],
-				  xstate_sizes[i], src);
-		}
+	case XSTATE_COPY_FX:
+		header.xfeatures &= XFEATURE_MASK_FP | XFEATURE_MASK_SSE;
+		break;
 
+	case XSTATE_COPY_XSAVE:
+		header.xfeatures &= xfeatures_mask_uabi();
+		break;
 	}
-	fill_gap(&to, &last, size);
-}
 
-/*
- * Convert from a ptrace standard-format kernel buffer to kernel XSAVES format
- * and copy to the target thread. This is called from xstateregs_set().
- */
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
-{
-	unsigned int offset, size;
-	int i;
-	struct xstate_header hdr;
+	/* Copy FP state up to MXCSR */
+	copy_feature(header.xfeatures & XFEATURE_MASK_FP, &to, &xsave->i387,
+		     &xinit->i387, off_mxcsr);
 
-	offset = offsetof(struct xregs_state, header);
-	size = sizeof(hdr);
+	/* Copy MXCSR when SSE or YMM are set in the feature mask */
+	copy_feature(header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM),
+		     &to, &xsave->i387.mxcsr, &xinit->i387.mxcsr,
+		     MXCSR_AND_FLAGS_SIZE);
 
-	memcpy(&hdr, kbuf + offset, size);
+	/* Copy the remaining FP state */
+	copy_feature(header.xfeatures & XFEATURE_MASK_FP,
+		     &to, &xsave->i387.st_space, &xinit->i387.st_space,
+		     sizeof(xsave->i387.st_space));
 
-	if (validate_user_xstate_header(&hdr))
-		return -EINVAL;
+	/* Copy the SSE state - shared with YMM, but independently managed */
+	copy_feature(header.xfeatures & XFEATURE_MASK_SSE,
+		     &to, &xsave->i387.xmm_space, &xinit->i387.xmm_space,
+		     sizeof(xsave->i387.xmm_space));
 
-	for (i = 0; i < XFEATURE_MAX; i++) {
-		u64 mask = ((u64)1 << i);
+	if (copy_mode != XSTATE_COPY_XSAVE)
+		goto out;
 
-		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, i);
+	/* Zero the padding area */
+	membuf_zero(&to, sizeof(xsave->i387.padding));
 
-			offset = xstate_offsets[i];
-			size = xstate_sizes[i];
+	/* Copy xsave->i387.sw_reserved */
+	membuf_write(&to, xstate_fx_sw_bytes, sizeof(xsave->i387.sw_reserved));
 
-			memcpy(dst, kbuf + offset, size);
-		}
-	}
+	/* Copy the user space relevant state of @xsave->header */
+	membuf_write(&to, &header, sizeof(header));
 
-	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
-		offset = offsetof(struct fxregs_state, mxcsr);
-		size = MXCSR_AND_FLAGS_SIZE;
-		memcpy(&xsave->i387.mxcsr, kbuf + offset, size);
-	}
+	zerofrom = offsetof(struct xregs_state, extended_state_area);
 
-	/*
-	 * The state that came in from userspace was user-state only.
-	 * Mask all the user states out of 'xfeatures':
-	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR_ALL;
+	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		/*
+		 * The ptrace buffer is in non-compacted XSAVE format.
+		 * In non-compacted format disabled features still occupy
+		 * state space, but there is no state to copy from in the
+		 * compacted init_fpstate. The gap tracking will zero this
+		 * later.
+		 */
+		if (!(xfeatures_mask_uabi() & BIT_ULL(i)))
+			continue;
 
-	/*
-	 * Add back in the features that came in from userspace:
-	 */
-	xsave->header.xfeatures |= hdr.xfeatures;
+		/*
+		 * If there was a feature or alignment gap, zero the space
+		 * in the destination buffer.
+		 */
+		if (zerofrom < xstate_offsets[i])
+			membuf_zero(&to, xstate_offsets[i] - zerofrom);
+
+		if (i == XFEATURE_PKRU) {
+			struct pkru_state pkru = {0};
+			/*
+			 * PKRU is not necessarily up to date in the
+			 * thread's XSAVE buffer.  Fill this part from the
+			 * per-thread storage.
+			 */
+			pkru.pkru = tsk->thread.pkru;
+			membuf_write(&to, &pkru, sizeof(pkru));
+		} else {
+			copy_feature(header.xfeatures & BIT_ULL(i), &to,
+				     __raw_xsave_addr(xsave, i),
+				     __raw_xsave_addr(xinit, i),
+				     xstate_sizes[i]);
+		}
+		/*
+		 * Keep track of the last copied state in the non-compacted
+		 * target buffer for gap zeroing.
+		 */
+		zerofrom = xstate_offsets[i] + xstate_sizes[i];
+	}
+
+out:
+	if (to.left)
+		membuf_zero(&to, to.left);
+}
 
+static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
+			    const void *kbuf, const void __user *ubuf)
+{
+	if (kbuf) {
+		memcpy(dst, kbuf + offset, size);
+	} else {
+		if (copy_from_user(dst, ubuf + offset, size))
+			return -EFAULT;
+	}
 	return 0;
 }
 
-/*
- * Convert from a ptrace or sigreturn standard-format user-space buffer to
- * kernel XSAVES format and copy to the target thread. This is called from
- * xstateregs_set(), as well as potentially from the sigreturn() and
- * rt_sigreturn() system calls.
- */
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
+
+static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
+			       const void __user *ubuf)
 {
 	unsigned int offset, size;
-	int i;
 	struct xstate_header hdr;
+	u64 mask;
+	int i;
 
 	offset = offsetof(struct xregs_state, header);
-	size = sizeof(hdr);
-
-	if (__copy_from_user(&hdr, ubuf + offset, size))
+	if (copy_from_buffer(&hdr, offset, sizeof(hdr), kbuf, ubuf))
 		return -EFAULT;
 
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
+	/* Validate MXCSR when any of the related features is in use */
+	mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
+	if (hdr.xfeatures & mask) {
+		u32 mxcsr[2];
+
+		offset = offsetof(struct fxregs_state, mxcsr);
+		if (copy_from_buffer(mxcsr, offset, sizeof(mxcsr), kbuf, ubuf))
+			return -EFAULT;
+
+		/* Reserved bits in MXCSR must be zero. */
+		if (mxcsr[0] & ~mxcsr_feature_mask)
+			return -EINVAL;
+
+		/* SSE and YMM require MXCSR even when FP is not in use. */
+		if (!(hdr.xfeatures & XFEATURE_MASK_FP)) {
+			xsave->i387.mxcsr = mxcsr[0];
+			xsave->i387.mxcsr_mask = mxcsr[1];
+		}
+	}
+
 	for (i = 0; i < XFEATURE_MAX; i++) {
 		u64 mask = ((u64)1 << i);
 
@@ -1240,18 +1135,11 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-			if (__copy_from_user(dst, ubuf + offset, size))
+			if (copy_from_buffer(dst, offset, size, kbuf, ubuf))
 				return -EFAULT;
 		}
 	}
 
-	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
-		offset = offsetof(struct fxregs_state, mxcsr);
-		size = MXCSR_AND_FLAGS_SIZE;
-		if (__copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
-			return -EFAULT;
-	}
-
 	/*
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
@@ -1267,130 +1155,94 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 }
 
 /*
- * Save only supervisor states to the kernel buffer.  This blows away all
- * old states, and is intended to be used only in __fpu__restore_sig(), where
- * user states are restored from the user buffer.
+ * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S]
+ * format and copy to the target thread. This is called from
+ * xstateregs_set().
  */
-void copy_supervisor_to_kernel(struct xregs_state *xstate)
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 {
-	struct xstate_header *header;
-	u64 max_bit, min_bit;
-	u32 lmask, hmask;
-	int err, i;
-
-	if (WARN_ON(!boot_cpu_has(X86_FEATURE_XSAVES)))
-		return;
-
-	if (!xfeatures_mask_supervisor())
-		return;
-
-	max_bit = __fls(xfeatures_mask_supervisor());
-	min_bit = __ffs(xfeatures_mask_supervisor());
-
-	lmask = xfeatures_mask_supervisor();
-	hmask = xfeatures_mask_supervisor() >> 32;
-	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
+	return copy_uabi_to_xstate(xsave, kbuf, NULL);
+}
 
-	/* We should never fault when copying to a kernel buffer: */
-	if (WARN_ON_FPU(err))
-		return;
+/*
+ * Convert from a sigreturn standard-format user-space buffer to kernel
+ * XSAVE[S] format and copy to the target thread. This is called from the
+ * sigreturn() and rt_sigreturn() system calls.
+ */
+int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
+				      const void __user *ubuf)
+{
+	return copy_uabi_to_xstate(xsave, NULL, ubuf);
+}
 
-	/*
-	 * At this point, the buffer has only supervisor states and must be
-	 * converted back to normal kernel format.
-	 */
-	header = &xstate->header;
-	header->xcomp_bv |= xfeatures_mask_all;
+static bool validate_xsaves_xrstors(u64 mask)
+{
+	u64 xchk;
 
+	if (WARN_ON_FPU(!cpu_feature_enabled(X86_FEATURE_XSAVES)))
+		return false;
 	/*
-	 * This only moves states up in the buffer.  Start with
-	 * the last state and move backwards so that states are
-	 * not overwritten until after they are moved.  Note:
-	 * memmove() allows overlapping src/dst buffers.
+	 * Validate that this is either a task->fpstate related component
+	 * subset or an independent one.
 	 */
-	for (i = max_bit; i >= min_bit; i--) {
-		u8 *xbuf = (u8 *)xstate;
+	if (mask & xfeatures_mask_independent())
+		xchk = ~xfeatures_mask_independent();
+	else
+		xchk = ~xfeatures_mask_all;
 
-		if (!((header->xfeatures >> i) & 1))
-			continue;
+	if (WARN_ON_ONCE(!mask || mask & xchk))
+		return false;
 
-		/* Move xfeature 'i' into its normal location */
-		memmove(xbuf + xstate_comp_offsets[i],
-			xbuf + xstate_supervisor_only_offsets[i],
-			xstate_sizes[i]);
-	}
+	return true;
 }
 
 /**
- * copy_dynamic_supervisor_to_kernel() - Save dynamic supervisor states to
- *                                       an xsave area
- * @xstate: A pointer to an xsave area
- * @mask: Represent the dynamic supervisor features saved into the xsave area
+ * xsaves - Save selected components to a kernel xstate buffer
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to save
  *
- * Only the dynamic supervisor states sets in the mask are saved into the xsave
- * area (See the comment in XFEATURE_MASK_DYNAMIC for the details of dynamic
- * supervisor feature). Besides the dynamic supervisor states, the legacy
- * region and XSAVE header are also saved into the xsave area. The supervisor
- * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
- * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
+ * The @xstate buffer must be 64 byte aligned and correctly initialized as
+ * XSAVES does not write the full xstate header. Before first use the
+ * buffer should be zeroed otherwise a consecutive XRSTORS from that buffer
+ * can #GP.
  *
- * The xsave area must be 64-bytes aligned.
+ * The feature mask must either be a subset of the independent features or
+ * a subset of the task->fpstate related features.
  */
-void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
+void xsaves(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
-	u32 lmask, hmask;
 	int err;
 
-	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
-		return;
-
-	if (WARN_ON_FPU(!dynamic_mask))
+	if (!validate_xsaves_xrstors(mask))
 		return;
 
-	lmask = dynamic_mask;
-	hmask = dynamic_mask >> 32;
-
-	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
-
-	/* Should never fault when copying to a kernel buffer */
-	WARN_ON_FPU(err);
+	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
+	WARN_ON_ONCE(err);
 }
 
 /**
- * copy_kernel_to_dynamic_supervisor() - Restore dynamic supervisor states from
- *                                       an xsave area
- * @xstate: A pointer to an xsave area
- * @mask: Represent the dynamic supervisor features restored from the xsave area
+ * xrstors - Restore selected components from a kernel xstate buffer
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to restore
  *
- * Only the dynamic supervisor states sets in the mask are restored from the
- * xsave area (See the comment in XFEATURE_MASK_DYNAMIC for the details of
- * dynamic supervisor feature). Besides the dynamic supervisor states, the
- * legacy region and XSAVE header are also restored from the xsave area. The
- * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
- * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
+ * The @xstate buffer must be 64 byte aligned and correctly initialized
+ * otherwise XRSTORS from that buffer can #GP.
  *
- * The xsave area must be 64-bytes aligned.
+ * Proper usage is to restore the state which was saved with
+ * xsaves() into @xstate.
+ *
+ * The feature mask must either be a subset of the independent features or
+ * a subset of the task->fpstate related features.
  */
-void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask)
+void xrstors(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
-	u32 lmask, hmask;
 	int err;
 
-	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
-		return;
-
-	if (WARN_ON_FPU(!dynamic_mask))
+	if (!validate_xsaves_xrstors(mask))
 		return;
 
-	lmask = dynamic_mask;
-	hmask = dynamic_mask >> 32;
-
-	XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
-
-	/* Should never fault when copying from a kernel buffer */
-	WARN_ON_FPU(err);
+	XSTATE_OP(XRSTORS, xstate, (u32)mask, (u32)(mask >> 32), err);
+	WARN_ON_ONCE(err);
 }
 
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5e1f38179f49..fa6c8fa0f778 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -87,8 +87,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
-
-	return fpu__copy(dst, src);
+	return fpu_clone(dst);
 }
 
 /*
@@ -157,11 +156,18 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
+		p->thread.pkru = pkru_get_init_value();
 		memset(childregs, 0, sizeof(struct pt_regs));
 		kthread_frame_init(frame, sp, arg);
 		return 0;
 	}
 
+	/*
+	 * Clone current's PKRU value from hardware. tsk->thread.pkru
+	 * is only valid when scheduled out.
+	 */
+	p->thread.pkru = read_pkru();
+
 	frame->bx = 0;
 	*childregs = *current_pt_regs();
 	childregs->ax = 0;
@@ -199,6 +205,15 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	return ret;
 }
 
+static void pkru_flush_thread(void)
+{
+	/*
+	 * If PKRU is enabled the default PKRU value has to be loaded into
+	 * the hardware right here (similar to context switch).
+	 */
+	pkru_write_default();
+}
+
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
@@ -206,7 +221,8 @@ void flush_thread(void)
 	flush_ptrace_hw_breakpoint(tsk);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
-	fpu__clear_all(&tsk->thread.fpu);
+	fpu_flush_thread();
+	pkru_flush_thread();
 }
 
 void disable_TSC(void)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d08307df69ad..ec0d836a13b1 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -41,6 +41,7 @@
 #include <linux/syscalls.h>
 
 #include <asm/processor.h>
+#include <asm/pkru.h>
 #include <asm/fpu/internal.h>
 #include <asm/mmu_context.h>
 #include <asm/prctl.h>
@@ -136,7 +137,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 		       log_lvl, d3, d6, d7);
 	}
 
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
 		printk("%sPKRU: %08x\n", log_lvl, read_pkru());
 }
 
@@ -339,6 +340,29 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
+/*
+ * Store prev's PKRU value and load next's PKRU value if they differ. PKRU
+ * is not XSTATE managed on context switch because that would require a
+ * lookup in the task's FPU xsave buffer and require to keep that updated
+ * in various places.
+ */
+static __always_inline void x86_pkru_load(struct thread_struct *prev,
+					  struct thread_struct *next)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	/* Stash the prev task's value: */
+	prev->pkru = rdpkru();
+
+	/*
+	 * PKRU writes are slightly expensive.  Avoid them when not
+	 * strictly necessary:
+	 */
+	if (prev->pkru != next->pkru)
+		wrpkru(next->pkru);
+}
+
 static __always_inline void x86_fsgsbase_load(struct thread_struct *prev,
 					      struct thread_struct *next)
 {
@@ -588,6 +612,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	x86_fsgsbase_load(prev, next);
 
+	x86_pkru_load(prev, next);
+
 	/*
 	 * Switch the PDA and FPU contexts.
 	 */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index a06cb107c0e8..2ddcf2165bcb 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -212,6 +212,11 @@ do {									\
  * Set up a signal frame.
  */
 
+/* x86 ABI requires 16-byte alignment */
+#define FRAME_ALIGNMENT	16UL
+
+#define MAX_FRAME_PADDING	(FRAME_ALIGNMENT - 1)
+
 /*
  * Determine which stack to use..
  */
@@ -222,9 +227,9 @@ static unsigned long align_sigframe(unsigned long sp)
 	 * Align the stack pointer according to the i386 ABI,
 	 * i.e. so that on function entry ((sp + 4) & 15) == 0.
 	 */
-	sp = ((sp + 4) & -16ul) - 4;
+	sp = ((sp + 4) & -FRAME_ALIGNMENT) - 4;
 #else /* !CONFIG_X86_32 */
-	sp = round_down(sp, 16) - 8;
+	sp = round_down(sp, FRAME_ALIGNMENT) - 8;
 #endif
 	return sp;
 }
@@ -234,10 +239,11 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	     void __user **fpstate)
 {
 	/* Default to using normal stack */
+	bool nested_altstack = on_sig_stack(regs->sp);
+	bool entering_altstack = false;
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
-	int onsigstack = on_sig_stack(sp);
 	int ret;
 
 	/* redzone */
@@ -246,15 +252,23 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (sas_ss_flags(sp) == 0)
+		/*
+		 * This checks nested_altstack via sas_ss_flags(). Sensible
+		 * programs use SS_AUTODISARM, which disables that check, and
+		 * programs that don't use SS_AUTODISARM get compatible.
+		 */
+		if (sas_ss_flags(sp) == 0) {
 			sp = current->sas_ss_sp + current->sas_ss_size;
+			entering_altstack = true;
+		}
 	} else if (IS_ENABLED(CONFIG_X86_32) &&
-		   !onsigstack &&
+		   !nested_altstack &&
 		   regs->ss != __USER_DS &&
 		   !(ka->sa.sa_flags & SA_RESTORER) &&
 		   ka->sa.sa_restorer) {
 		/* This is the legacy signal stack switching. */
 		sp = (unsigned long) ka->sa.sa_restorer;
+		entering_altstack = true;
 	}
 
 	sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
@@ -267,8 +281,15 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	 * If we are on the alternate signal stack and would overflow it, don't.
 	 * Return an always-bogus address instead so we will die with SIGSEGV.
 	 */
-	if (onsigstack && !likely(on_sig_stack(sp)))
+	if (unlikely((nested_altstack || entering_altstack) &&
+		     !__on_sig_stack(sp))) {
+
+		if (show_unhandled_signals && printk_ratelimit())
+			pr_info("%s[%d] overflowed sigaltstack\n",
+				current->comm, task_pid_nr(current));
+
 		return (void __user *)-1L;
+	}
 
 	/* save i387 and extended state */
 	ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);
@@ -663,6 +684,61 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return 0;
 }
 
+/*
+ * There are four different struct types for signal frame: sigframe_ia32,
+ * rt_sigframe_ia32, rt_sigframe_x32, and rt_sigframe. Use the worst case
+ * -- the largest size. It means the size for 64-bit apps is a bit more
+ * than needed, but this keeps the code simple.
+ */
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+# define MAX_FRAME_SIGINFO_UCTXT_SIZE	sizeof(struct sigframe_ia32)
+#else
+# define MAX_FRAME_SIGINFO_UCTXT_SIZE	sizeof(struct rt_sigframe)
+#endif
+
+/*
+ * The FP state frame contains an XSAVE buffer which must be 64-byte aligned.
+ * If a signal frame starts at an unaligned address, extra space is required.
+ * This is the max alignment padding, conservatively.
+ */
+#define MAX_XSAVE_PADDING	63UL
+
+/*
+ * The frame data is composed of the following areas and laid out as:
+ *
+ * -------------------------
+ * | alignment padding     |
+ * -------------------------
+ * | (f)xsave frame        |
+ * -------------------------
+ * | fsave header          |
+ * -------------------------
+ * | alignment padding     |
+ * -------------------------
+ * | siginfo + ucontext    |
+ * -------------------------
+ */
+
+/* max_frame_size tells userspace the worst case signal stack size. */
+static unsigned long __ro_after_init max_frame_size;
+
+void __init init_sigframe_size(void)
+{
+	max_frame_size = MAX_FRAME_SIGINFO_UCTXT_SIZE + MAX_FRAME_PADDING;
+
+	max_frame_size += fpu__get_fpstate_size() + MAX_XSAVE_PADDING;
+
+	/* Userspace expects an aligned size. */
+	max_frame_size = round_up(max_frame_size, FRAME_ALIGNMENT);
+
+	pr_info("max sigframe size: %lu\n", max_frame_size);
+}
+
+unsigned long get_sigframe_size(void)
+{
+	return max_frame_size;
+}
+
 static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
 	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 853ea7a80806..4c9c4aa83216 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1046,9 +1046,10 @@ static void math_error(struct pt_regs *regs, int trapnr)
 	}
 
 	/*
-	 * Save the info for the exception handler and clear the error.
+	 * Synchronize the FPU register state to the memory register state
+	 * if necessary. This allows the exception handler to inspect it.
 	 */
-	fpu__save(fpu);
+	fpu_sync_fpstate(fpu);
 
 	task->thread.trap_nr	= trapnr;
 	task->thread.error_code = 0;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8d36f0c73071..62926f1a5f7b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -19,6 +19,7 @@
 #include <linux/trace_events.h>
 #include <asm/fpu/internal.h>
 
+#include <asm/pkru.h>
 #include <asm/trapnr.h>
 
 #include "x86.h"
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e0f4a46649d7..8ee7add0e763 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -65,6 +65,7 @@
 #include <asm/msr.h>
 #include <asm/desc.h>
 #include <asm/mce.h>
+#include <asm/pkru.h>
 #include <linux/kernel_stat.h>
 #include <asm/fpu/internal.h> /* Ugh! */
 #include <asm/pvclock.h>
@@ -942,7 +943,7 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
 	    (kvm_read_cr4_bits(vcpu, X86_CR4_PKE) ||
 	     (vcpu->arch.xcr0 & XFEATURE_MASK_PKRU)) &&
 	    vcpu->arch.pkru != vcpu->arch.host_pkru)
-		__write_pkru(vcpu->arch.pkru);
+		write_pkru(vcpu->arch.pkru);
 }
 EXPORT_SYMBOL_GPL(kvm_load_guest_xsave_state);
 
@@ -956,7 +957,7 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 	     (vcpu->arch.xcr0 & XFEATURE_MASK_PKRU))) {
 		vcpu->arch.pkru = rdpkru();
 		if (vcpu->arch.pkru != vcpu->arch.host_pkru)
-			__write_pkru(vcpu->arch.host_pkru);
+			write_pkru(vcpu->arch.host_pkru);
 	}
 
 	if (kvm_read_cr4_bits(vcpu, X86_CR4_OSXSAVE)) {
@@ -4604,20 +4605,21 @@ static void fill_xsave(u8 *dest, struct kvm_vcpu *vcpu)
 	 */
 	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
+		u32 size, offset, ecx, edx;
 		u64 xfeature_mask = valid & -valid;
 		int xfeature_nr = fls64(xfeature_mask) - 1;
-		void *src = get_xsave_addr(xsave, xfeature_nr);
-
-		if (src) {
-			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, xfeature_nr,
-				    &size, &offset, &ecx, &edx);
-			if (xfeature_nr == XFEATURE_PKRU)
-				memcpy(dest + offset, &vcpu->arch.pkru,
-				       sizeof(vcpu->arch.pkru));
-			else
-				memcpy(dest + offset, src, size);
+		void *src;
+
+		cpuid_count(XSTATE_CPUID, xfeature_nr,
+			    &size, &offset, &ecx, &edx);
 
+		if (xfeature_nr == XFEATURE_PKRU) {
+			memcpy(dest + offset, &vcpu->arch.pkru,
+			       sizeof(vcpu->arch.pkru));
+		} else {
+			src = get_xsave_addr(xsave, xfeature_nr);
+			if (src)
+				memcpy(dest + offset, src, size);
 		}
 
 		valid -= xfeature_mask;
@@ -4647,18 +4649,20 @@ static void load_xsave(struct kvm_vcpu *vcpu, u8 *src)
 	 */
 	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
+		u32 size, offset, ecx, edx;
 		u64 xfeature_mask = valid & -valid;
 		int xfeature_nr = fls64(xfeature_mask) - 1;
-		void *dest = get_xsave_addr(xsave, xfeature_nr);
-
-		if (dest) {
-			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, xfeature_nr,
-				    &size, &offset, &ecx, &edx);
-			if (xfeature_nr == XFEATURE_PKRU)
-				memcpy(&vcpu->arch.pkru, src + offset,
-				       sizeof(vcpu->arch.pkru));
-			else
+
+		cpuid_count(XSTATE_CPUID, xfeature_nr,
+			    &size, &offset, &ecx, &edx);
+
+		if (xfeature_nr == XFEATURE_PKRU) {
+			memcpy(&vcpu->arch.pkru, src + offset,
+			       sizeof(vcpu->arch.pkru));
+		} else {
+			void *dest = get_xsave_addr(xsave, xfeature_nr);
+
+			if (dest)
 				memcpy(dest, src + offset, size);
 		}
 
@@ -9634,7 +9638,7 @@ static void kvm_save_current_fpu(struct fpu *fpu)
 		memcpy(&fpu->state, &current->thread.fpu.state,
 		       fpu_kernel_xstate_size);
 	else
-		copy_fpregs_to_fpstate(fpu);
+		save_fpregs_to_fpstate(fpu);
 }
 
 /* Swap (qemu) user FPU context for the guest FPU context. */
@@ -9650,7 +9654,7 @@ static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 	 */
 	if (vcpu->arch.guest_fpu)
 		/* PKRU is separately restored in kvm_x86_ops.run. */
-		__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu->state,
+		__restore_fpregs_from_fpstate(&vcpu->arch.guest_fpu->state,
 					~XFEATURE_MASK_PKRU);
 
 	fpregs_mark_activate();
@@ -9671,7 +9675,7 @@ static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.guest_fpu)
 		kvm_save_current_fpu(vcpu->arch.guest_fpu);
 
-	copy_kernel_to_fpregs(&vcpu->arch.user_fpu->state);
+	restore_fpregs_from_fpstate(&vcpu->arch.user_fpu->state);
 
 	fpregs_mark_activate();
 	fpregs_unlock();
diff --git a/arch/x86/math-emu/fpu_proto.h b/arch/x86/math-emu/fpu_proto.h
index 70d35c200945..94c4023092f3 100644
--- a/arch/x86/math-emu/fpu_proto.h
+++ b/arch/x86/math-emu/fpu_proto.h
@@ -144,7 +144,7 @@ extern int FPU_store_int16(FPU_REG *st0_ptr, u_char st0_tag, short __user *d);
 extern int FPU_store_bcd(FPU_REG *st0_ptr, u_char st0_tag, u_char __user *d);
 extern int FPU_round_to_int(FPU_REG *r, u_char tag);
 extern u_char __user *fldenv(fpu_addr_modes addr_modes, u_char __user *s);
-extern void frstor(fpu_addr_modes addr_modes, u_char __user *data_address);
+extern void FPU_frstor(fpu_addr_modes addr_modes, u_char __user *data_address);
 extern u_char __user *fstenv(fpu_addr_modes addr_modes, u_char __user *d);
 extern void fsave(fpu_addr_modes addr_modes, u_char __user *data_address);
 extern int FPU_tagof(FPU_REG *ptr);
diff --git a/arch/x86/math-emu/load_store.c b/arch/x86/math-emu/load_store.c
index f15263e158e8..4092df79de4f 100644
--- a/arch/x86/math-emu/load_store.c
+++ b/arch/x86/math-emu/load_store.c
@@ -240,7 +240,7 @@ int FPU_load_store(u_char type, fpu_addr_modes addr_modes,
 		   fix-up operations. */
 		return 1;
 	case 022:		/* frstor m94/108byte */
-		frstor(addr_modes, (u_char __user *) data_address);
+		FPU_frstor(addr_modes, (u_char __user *) data_address);
 		/* Ensure that the values just loaded are not changed by
 		   fix-up operations. */
 		return 1;
diff --git a/arch/x86/math-emu/reg_ld_str.c b/arch/x86/math-emu/reg_ld_str.c
index 7ca6417c0c8d..7e4521fbe7da 100644
--- a/arch/x86/math-emu/reg_ld_str.c
+++ b/arch/x86/math-emu/reg_ld_str.c
@@ -1117,7 +1117,7 @@ u_char __user *fldenv(fpu_addr_modes addr_modes, u_char __user *s)
 	return s;
 }
 
-void frstor(fpu_addr_modes addr_modes, u_char __user *data_address)
+void FPU_frstor(fpu_addr_modes addr_modes, u_char __user *data_address)
 {
 	int i, regnr;
 	u_char __user *s = fldenv(addr_modes, data_address);
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 121921b2927c..e1664e9f969c 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -65,7 +65,7 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
-	__copy_kernel_to_fpregs(&init_fpstate, -1);
+	__restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
 	return true;
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6bda7f67d737..f33a61a432ce 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -875,7 +875,7 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 	/* This code is always called on the current mm */
 	bool foreign = false;
 
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return false;
 	if (error_code & X86_PF_PK)
 		return true;
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index a2332eef66e9..fb171a5d7f33 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -10,7 +10,6 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
-#include <asm/fpu/internal.h>		/* init_fpstate			*/
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -125,22 +124,6 @@ u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
 		      PKRU_AD_KEY(10) | PKRU_AD_KEY(11) | PKRU_AD_KEY(12) |
 		      PKRU_AD_KEY(13) | PKRU_AD_KEY(14) | PKRU_AD_KEY(15);
 
-/*
- * Called from the FPU code when creating a fresh set of FPU
- * registers.  This is called from a very specific context where
- * we know the FPU registers are safe for use and we can use PKRU
- * directly.
- */
-void copy_init_pkru_to_fpregs(void)
-{
-	u32 init_pkru_value_snapshot = READ_ONCE(init_pkru_value);
-	/*
-	 * Override the PKRU state that came from 'init_fpstate'
-	 * with the baseline from the process.
-	 */
-	write_pkru(init_pkru_value_snapshot);
-}
-
 static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {
@@ -154,7 +137,6 @@ static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 static ssize_t init_pkru_write_file(struct file *file,
 		 const char __user *user_buf, size_t count, loff_t *ppos)
 {
-	struct pkru_state *pk;
 	char buf[32];
 	ssize_t len;
 	u32 new_init_pkru;
@@ -177,10 +159,6 @@ static ssize_t init_pkru_write_file(struct file *file,
 		return -EINVAL;
 
 	WRITE_ONCE(init_pkru_value, new_init_pkru);
-	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
-	if (!pk)
-		return -EINVAL;
-	pk->pkru = new_init_pkru;
 	return count;
 }
 
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 2955ba976048..6beb26b7151d 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -44,10 +44,6 @@ static inline bool arch_pkeys_enabled(void)
 	return false;
 }
 
-static inline void copy_init_pkru_to_fpregs(void)
-{
-}
-
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
 #endif /* _LINUX_PKEYS_H */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7f4278fa21fe..0d7fec79d28f 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -538,6 +538,17 @@ static inline int kill_cad_pid(int sig, int priv)
 #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
 #define SEND_SIG_PRIV	((struct kernel_siginfo *) 1)
 
+static inline int __on_sig_stack(unsigned long sp)
+{
+#ifdef CONFIG_STACK_GROWSUP
+	return sp >= current->sas_ss_sp &&
+		sp - current->sas_ss_sp < current->sas_ss_size;
+#else
+	return sp > current->sas_ss_sp &&
+		sp - current->sas_ss_sp <= current->sas_ss_size;
+#endif
+}
+
 /*
  * True if we are on the alternate signal stack.
  */
@@ -555,13 +566,7 @@ static inline int on_sig_stack(unsigned long sp)
 	if (current->sas_ss_flags & SS_AUTODISARM)
 		return 0;
 
-#ifdef CONFIG_STACK_GROWSUP
-	return sp >= current->sas_ss_sp &&
-		sp - current->sas_ss_sp < current->sas_ss_size;
-#else
-	return sp > current->sas_ss_sp &&
-		sp - current->sas_ss_sp <= current->sas_ss_size;
-#endif
+	return __on_sig_stack(sp);
 }
 
 static inline int sas_ss_flags(unsigned long sp)
diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
index abe5f2b6581b..c7e502bf5a6f 100644
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -33,5 +33,8 @@
 
 #define AT_EXECFN  31	/* filename of program */
 
+#ifndef AT_MINSIGSTKSZ
+#define AT_MINSIGSTKSZ	51	/* minimal stack size for signal delivery */
+#endif
 
 #endif /* _UAPI_LINUX_AUXVEC_H */
diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 8934a3766d20..c53b070755b6 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -17,6 +17,7 @@
 #include <string.h>
 #include <assert.h>
 #include <errno.h>
+#include <sys/auxv.h>
 
 #include "../kselftest.h"
 
@@ -24,6 +25,11 @@
 #define SS_AUTODISARM  (1U << 31)
 #endif
 
+#ifndef AT_MINSIGSTKSZ
+#define AT_MINSIGSTKSZ	51
+#endif
+
+static unsigned int stack_size;
 static void *sstack, *ustack;
 static ucontext_t uc, sc;
 static const char *msg = "[OK]\tStack preserved";
@@ -47,7 +53,7 @@ void my_usr1(int sig, siginfo_t *si, void *u)
 #endif
 
 	if (sp < (unsigned long)sstack ||
-			sp >= (unsigned long)sstack + SIGSTKSZ) {
+			sp >= (unsigned long)sstack + stack_size) {
 		ksft_exit_fail_msg("SP is not on sigaltstack\n");
 	}
 	/* put some data on stack. other sighandler will try to overwrite it */
@@ -108,6 +114,10 @@ int main(void)
 	stack_t stk;
 	int err;
 
+	/* Make sure more than the required minimum. */
+	stack_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
+	ksft_print_msg("[NOTE]\tthe stack size is %lu\n", stack_size);
+
 	ksft_print_header();
 	ksft_set_plan(3);
 
@@ -117,7 +127,7 @@ int main(void)
 	sigaction(SIGUSR1, &act, NULL);
 	act.sa_sigaction = my_usr2;
 	sigaction(SIGUSR2, &act, NULL);
-	sstack = mmap(NULL, SIGSTKSZ, PROT_READ | PROT_WRITE,
+	sstack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
 	if (sstack == MAP_FAILED) {
 		ksft_exit_fail_msg("mmap() - %s\n", strerror(errno));
@@ -139,7 +149,7 @@ int main(void)
 	}
 
 	stk.ss_sp = sstack;
-	stk.ss_size = SIGSTKSZ;
+	stk.ss_size = stack_size;
 	stk.ss_flags = SS_ONSTACK | SS_AUTODISARM;
 	err = sigaltstack(&stk, NULL);
 	if (err) {
@@ -161,7 +171,7 @@ int main(void)
 		}
 	}
 
-	ustack = mmap(NULL, SIGSTKSZ, PROT_READ | PROT_WRITE,
+	ustack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
 	if (ustack == MAP_FAILED) {
 		ksft_exit_fail_msg("mmap() - %s\n", strerror(errno));
@@ -170,7 +180,7 @@ int main(void)
 	getcontext(&uc);
 	uc.uc_link = NULL;
 	uc.uc_stack.ss_sp = ustack;
-	uc.uc_stack.ss_size = SIGSTKSZ;
+	uc.uc_stack.ss_size = stack_size;
 	makecontext(&uc, switch_fn, 0);
 	raise(SIGUSR1);
 
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 333980375bc7..b4142cd1c5c2 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,11 +13,12 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vsyscall mov_ss_trap \
-			syscall_arg_fault fsgsbase_restore
+			syscall_arg_fault fsgsbase_restore sigaltstack
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
-TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering
+TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
+			corrupt_xstate_header
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
new file mode 100644
index 000000000000..ab8599c10ce5
--- /dev/null
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Corrupt the XSTATE header in a signal frame
+ *
+ * Based on analysis and a test case from Thomas Gleixner.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sched.h>
+#include <signal.h>
+#include <err.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/wait.h>
+
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	asm volatile(
+		"cpuid;"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (*eax), "2" (*ecx));
+}
+
+static inline int xsave_enabled(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	eax = 0x1;
+	ecx = 0x0;
+	__cpuid(&eax, &ebx, &ecx, &edx);
+
+	/* Is CR4.OSXSAVE enabled ? */
+	return ecx & (1U << 27);
+}
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void sigusr1(int sig, siginfo_t *info, void *uc_void)
+{
+	ucontext_t *uc = uc_void;
+	uint8_t *fpstate = (uint8_t *)uc->uc_mcontext.fpregs;
+	uint64_t *xfeatures = (uint64_t *)(fpstate + 512);
+
+	printf("\tWreck XSTATE header\n");
+	/* Wreck the first reserved bytes in the header */
+	*(xfeatures + 2) = 0xfffffff;
+}
+
+static void sigsegv(int sig, siginfo_t *info, void *uc_void)
+{
+	printf("\tGot SIGSEGV\n");
+}
+
+int main(void)
+{
+	cpu_set_t set;
+
+	sethandler(SIGUSR1, sigusr1, 0);
+	sethandler(SIGSEGV, sigsegv, 0);
+
+	if (!xsave_enabled()) {
+		printf("[SKIP] CR4.OSXSAVE disabled.\n");
+		return 0;
+	}
+
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+
+	/*
+	 * Enforce that the child runs on the same CPU
+	 * which in turn forces a schedule.
+	 */
+	sched_setaffinity(getpid(), sizeof(set), &set);
+
+	printf("[RUN]\tSend ourselves a signal\n");
+	raise(SIGUSR1);
+
+	printf("[OK]\tBack from the signal.  Now schedule.\n");
+	pid_t child = fork();
+	if (child < 0)
+		err(1, "fork");
+	if (child == 0)
+		return 0;
+	if (child)
+		waitpid(child, NULL, 0);
+	printf("[OK]\tBack in the main thread.\n");
+
+	/*
+	 * We could try to confirm that extended state is still preserved
+	 * when we schedule.  For now, the only indication of failure is
+	 * a warning in the kernel logs.
+	 */
+
+	return 0;
+}
diff --git a/tools/testing/selftests/x86/sigaltstack.c b/tools/testing/selftests/x86/sigaltstack.c
new file mode 100644
index 000000000000..f689af75e979
--- /dev/null
+++ b/tools/testing/selftests/x86/sigaltstack.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define _GNU_SOURCE
+#include <signal.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <err.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/mman.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <sys/resource.h>
+#include <setjmp.h>
+
+/* sigaltstack()-enforced minimum stack */
+#define ENFORCED_MINSIGSTKSZ	2048
+
+#ifndef AT_MINSIGSTKSZ
+#  define AT_MINSIGSTKSZ	51
+#endif
+
+static int nerrs;
+
+static bool sigalrm_expected;
+
+static unsigned long at_minstack_size;
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void clearhandler(int sig)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static int setup_altstack(void *start, unsigned long size)
+{
+	stack_t ss;
+
+	memset(&ss, 0, sizeof(ss));
+	ss.ss_size = size;
+	ss.ss_sp = start;
+
+	return sigaltstack(&ss, NULL);
+}
+
+static jmp_buf jmpbuf;
+
+static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
+{
+	if (sigalrm_expected) {
+		printf("[FAIL]\tWrong signal delivered: SIGSEGV (expected SIGALRM).");
+		nerrs++;
+	} else {
+		printf("[OK]\tSIGSEGV signal delivered.\n");
+	}
+
+	siglongjmp(jmpbuf, 1);
+}
+
+static void sigalrm(int sig, siginfo_t *info, void *ctx_void)
+{
+	if (!sigalrm_expected) {
+		printf("[FAIL]\tWrong signal delivered: SIGALRM (expected SIGSEGV).");
+		nerrs++;
+	} else {
+		printf("[OK]\tSIGALRM signal delivered.\n");
+	}
+}
+
+static void test_sigaltstack(void *altstack, unsigned long size)
+{
+	if (setup_altstack(altstack, size))
+		err(1, "sigaltstack()");
+
+	sigalrm_expected = (size > at_minstack_size) ? true : false;
+
+	sethandler(SIGSEGV, sigsegv, 0);
+	sethandler(SIGALRM, sigalrm, SA_ONSTACK);
+
+	if (!sigsetjmp(jmpbuf, 1)) {
+		printf("[RUN]\tTest an alternate signal stack of %ssufficient size.\n",
+		       sigalrm_expected ? "" : "in");
+		printf("\tRaise SIGALRM. %s is expected to be delivered.\n",
+		       sigalrm_expected ? "It" : "SIGSEGV");
+		raise(SIGALRM);
+	}
+
+	clearhandler(SIGALRM);
+	clearhandler(SIGSEGV);
+}
+
+int main(void)
+{
+	void *altstack;
+
+	at_minstack_size = getauxval(AT_MINSIGSTKSZ);
+
+	altstack = mmap(NULL, at_minstack_size + SIGSTKSZ, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+	if (altstack == MAP_FAILED)
+		err(1, "mmap()");
+
+	if ((ENFORCED_MINSIGSTKSZ + 1) < at_minstack_size)
+		test_sigaltstack(altstack, ENFORCED_MINSIGSTKSZ + 1);
+
+	test_sigaltstack(altstack, at_minstack_size + SIGSTKSZ);
+
+	return nerrs == 0 ? 0 : 1;
+}

