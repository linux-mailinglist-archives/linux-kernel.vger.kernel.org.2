Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8233A3CC428
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhGQPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:38:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:24190 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235020AbhGQPiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:38:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="210853845"
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="210853845"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2021 08:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="631387013"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2021 08:35:07 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v8 12/26] x86/fpu/xstate: Use feature disable (XFD) to protect dynamic user state
Date:   Sat, 17 Jul 2021 08:28:49 -0700
Message-Id: <20210717152903.7651-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210717152903.7651-1-chang.seok.bae@intel.com>
References: <20210717152903.7651-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's Extended Feature Disable (XFD) feature is an extension of the XSAVE
architecture. XFD allows the kernel to enable a feature state in XCR0 and
to receive a #NM trap when a task uses instructions accessing that state.
In this way, Linux can defer allocating the large XSAVE buffer until tasks
need it.

XFD introduces two MSRs: IA32_XFD to enable/disable the feature and
IA32_XFD_ERR to assist the #NM trap handler. Both use the same
xstate-component bitmap format, used by XCR0.

Use this hardware capability to find the right time to expand the XSTATE
buffer. The #NM handler induces the buffer expansion.

Introduce helper functions:
    xfd_write()   - write IA32_XFD MSR
    xfd_read()    - read IA32_XFD MSR
    xfd_switch()  - switch IA32_XFD MSR
    xfd_capable() - indicate XFD-capable xfeatures

In the event of vzalloc() failure, send SIGILL with si_code ILL_ILL_OPC.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v7:
* Update #NM handler to raise SIGILL rather than SIGSEGV. (Thiago
  Macieira)

Changes from v6:
* Update the #NM handler a little bit.
* Clean up the code comment.

Changes from v5:
* Excluded the access request check here and included the buffer allocation
  again in #NM handler. The access request will be dealt in next patch.
* Updated the title. (Dave Hansen)
* Updated the code comment.

Changes from v4:
* Changed to use XFD to support the access request policy. Updated #NM
  handler to raise a signal instead of buffer allocation.
* Decoupled XFD from the use of XSAVE compacted format.
* Updated helper functions.
* Updated function descriptions in a proper format.
* Updated some code comments.

Changes from v3:
* Removed 'no functional change' in the changelog. (Borislav Petkov)

Changes from v2:
* Changed to enable XFD only when the compacted format is used.
* Updated the changelog with task->fpu removed. (Borislav Petkov)

Changes from v1:
* Inlined the XFD-induced #NM handling code (Andy Lutomirski)
---
 arch/x86/include/asm/cpufeatures.h  |  1 +
 arch/x86/include/asm/fpu/internal.h | 45 +++++++++++++++++++++++++++--
 arch/x86/include/asm/msr-index.h    |  2 ++
 arch/x86/kernel/cpu/cpuid-deps.c    |  1 +
 arch/x86/kernel/fpu/xstate.c        | 44 ++++++++++++++++++++++++++--
 arch/x86/kernel/process.c           |  6 ++++
 arch/x86/kernel/process_32.c        |  2 +-
 arch/x86/kernel/process_64.c        |  2 +-
 arch/x86/kernel/traps.c             | 39 +++++++++++++++++++++++++
 9 files changed, 136 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d0ce5cfd3ac1..37150b7a8e44 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -277,6 +277,7 @@
 #define X86_FEATURE_XSAVEC		(10*32+ 1) /* XSAVEC instruction */
 #define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX = 1 instruction */
 #define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
+#define X86_FEATURE_XFD			(10*32+ 4) /* eXtended Feature Disabling */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 263e349ff85a..e3590cf55325 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -535,14 +535,55 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  * Misc helper functions:
  */
 
+/* The Extended Feature Disable (XFD) helpers: */
+
+static inline void xfd_write(u64 value)
+{
+	wrmsrl_safe(MSR_IA32_XFD, value);
+}
+
+static inline u64 xfd_read(void)
+{
+	u64 value;
+
+	rdmsrl_safe(MSR_IA32_XFD, &value);
+	return value;
+}
+
+static inline u64 xfd_capable(void)
+{
+	return xfeatures_mask_user_dynamic;
+}
+
+/**
+ * xfd_switch - Switches the MSR IA32_XFD context if needed.
+ * @prev:	The previous task's struct fpu pointer
+ * @next:	The next task's struct fpu pointer
+ */
+static inline void xfd_switch(struct fpu *prev, struct fpu *next)
+{
+	u64 prev_xfd_mask, next_xfd_mask;
+
+	if (!static_cpu_has(X86_FEATURE_XFD) || !xfd_capable())
+		return;
+
+	prev_xfd_mask = prev->state_mask & xfd_capable();
+	next_xfd_mask = next->state_mask & xfd_capable();
+
+	if (unlikely(prev_xfd_mask != next_xfd_mask))
+		xfd_write(xfd_capable() ^ next_xfd_mask);
+}
+
 /*
  * Delay loading of the complete FPU state until the return to userland.
  * PKRU is handled separately.
  */
-static inline void switch_fpu_finish(struct fpu *new_fpu)
+static inline void switch_fpu_finish(struct fpu *old_fpu, struct fpu *new_fpu)
 {
-	if (cpu_feature_enabled(X86_FEATURE_FPU))
+	if (cpu_feature_enabled(X86_FEATURE_FPU)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
+		xfd_switch(old_fpu, new_fpu);
+	}
 }
 
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a7c413432b33..eac0cfd9210b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -626,6 +626,8 @@
 #define MSR_IA32_BNDCFGS_RSVD		0x00000ffc
 
 #define MSR_IA32_XSS			0x00000da0
+#define MSR_IA32_XFD			0x000001c4
+#define MSR_IA32_XFD_ERR		0x000001c5
 
 #define MSR_IA32_APICBASE		0x0000001b
 #define MSR_IA32_APICBASE_BSP		(1<<8)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index defda61f372d..7f891d2eb52e 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -75,6 +75,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
+	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVE     },
 	{}
 };
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3b56e7612c45..c6ff0575d87d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -182,6 +182,26 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
+/**
+ * xfd_supported - Check if the feature supports Extended Feature Disable (XFD).
+ * @feature_nr:	The feature number.
+ *
+ * Returns:	True if supported; otherwise, false.
+ */
+static bool xfd_supported(int feature_nr)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (!boot_cpu_has(X86_FEATURE_XFD))
+		return false;
+
+	/*
+	 * If state component 'i' supports it, ECX[2] return 1; otherwise, 0.
+	 */
+	cpuid_count(XSTATE_CPUID, feature_nr, &eax, &ebx, &ecx, &edx);
+	return ecx & 4;
+}
+
 /**
  * get_xstate_comp_offset - Find the feature's offset in the compacted
  *			    format.
@@ -274,6 +294,9 @@ void fpu__init_cpu_xstate(void)
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
 				     xfeatures_mask_independent());
 	}
+
+	if (boot_cpu_has(X86_FEATURE_XFD))
+		xfd_write(xfd_capable());
 }
 
 static bool xfeature_enabled(enum xfeature xfeature)
@@ -473,8 +496,9 @@ static void __init print_xstate_offset_size(void)
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		if (!xfeature_enabled(i))
 			continue;
-		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
-			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
+		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d (%s)\n",
+			i, xstate_comp_offsets[i], i, xstate_sizes[i],
+			(xfeatures_mask_user_dynamic & BIT_ULL(i)) ? "dynamic" : "default");
 	}
 }
 
@@ -920,6 +944,16 @@ void __init fpu__init_system_xstate(void)
 	/* Do not support the dynamically allocated buffer yet. */
 	xfeatures_mask_user_dynamic = 0;
 
+	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		u64 feature_mask = BIT_ULL(i);
+
+		if (!(xfeatures_mask_uabi() & feature_mask))
+			continue;
+
+		if (xfd_supported(i))
+			xfeatures_mask_user_dynamic |= feature_mask;
+	}
+
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
 	err = init_xstate_size();
@@ -981,6 +1015,12 @@ void fpu__resume_cpu(void)
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
 				     xfeatures_mask_independent());
 	}
+
+	if (boot_cpu_has(X86_FEATURE_XFD)) {
+		u64 fpu_xfd_mask = current->thread.fpu.state_mask & xfd_capable();
+
+		xfd_write(xfd_capable() ^ fpu_xfd_mask);
+	}
 }
 
 /**
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 534b9fb7e7ee..b85fa499f195 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -97,6 +97,12 @@ void arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
 	*size = get_xstate_config(XSTATE_MIN_SIZE);
 }
 
+void arch_release_task_struct(struct task_struct *task)
+{
+	if (cpu_feature_enabled(X86_FEATURE_FPU))
+		free_xstate_buffer(&task->thread.fpu);
+}
+
 /*
  * Free thread data structures etc..
  */
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4f2f54e1281c..7bd5d08eeb41 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -213,7 +213,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	this_cpu_write(current_task, next_p);
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish(prev_fpu, next_fpu);
 
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ec0d836a13b1..41c9855158d6 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -620,7 +620,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish(prev_fpu, next_fpu);
 
 	/* Reload sp0. */
 	update_task_stack(next_p);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a58800973aed..dd66d528afd8 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1112,6 +1112,45 @@ DEFINE_IDTENTRY(exc_device_not_available)
 {
 	unsigned long cr0 = read_cr0();
 
+	if (boot_cpu_has(X86_FEATURE_XFD)) {
+		u64 xfd_err;
+
+		rdmsrl_safe(MSR_IA32_XFD_ERR, &xfd_err);
+		wrmsrl_safe(MSR_IA32_XFD_ERR, 0);
+
+		if (xfd_err) {
+			u64 xfd_event = xfd_err & xfd_capable();
+
+			if (WARN_ON(!xfd_event)) {
+				/*
+				 * Unexpected event is raised. But update XFD state to
+				 * unblock the task.
+				 */
+				xfd_write(xfd_read() & ~xfd_err);
+			} else {
+				struct fpu *fpu = &current->thread.fpu;
+				int err = -1;
+
+				/*
+				 * Make sure not in interrupt context as handling a
+				 * trap from userspace.
+				 */
+				if (!WARN_ON(in_interrupt())) {
+					err = alloc_xstate_buffer(fpu, xfd_event);
+					if (!err)
+						xfd_write((fpu->state_mask & xfd_capable()) ^
+							  xfd_capable());
+				}
+
+				/* Raise a signal when it failed to handle. */
+				if (err)
+					force_sig_fault(SIGILL, ILL_ILLOPC,
+							error_get_trap_addr(regs));
+			}
+			return;
+		}
+	}
+
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
-- 
2.17.1

