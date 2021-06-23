Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D953B19FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFWM1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36846 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhFWM0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:37 -0400
Message-Id: <20210623121454.911450390@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=iv0Z2t2WhybDI7Z1L+7PttHDSRi5E0AYoLXSxCrzg9Q=;
        b=3mNMyL0K3RRfBnl8gs7lfIvPNdOD9ujyFnD+MDjNs09lovS6SmgNihyehsyuNRneeIoBeb
        WmO0AITfMLLnbJFISKelI5xzMYJzvODmTmkgrrzkgSIpCna3qAVExYFpfKYbrrHa1BpWRS
        +WyL/Ba2FLkC6vjilR6v+DJNzavOIoOilXHbm7hK+IuhJsIbfwhtgEa4igJKdsqDtJgttq
        /K5G50NZgP3UzAH5psQj6yDIeEd3LMKRttQVuTicNvTSA4gjTVfutwO1NDu4UAZaiksGeI
        IeL+uyfTYI/+U15zG+0e3VtysYdoT3yf/tniaGYB4uQ8G7bK2XjqmPV5yWASUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=iv0Z2t2WhybDI7Z1L+7PttHDSRi5E0AYoLXSxCrzg9Q=;
        b=XjlGsg0IU/N7u4UasWCjxeCg1IsTNbYK52hm3bUdZvM0HOluH/wXDPOf9pNZYxVjvH+DWv
        r2ZfFJuv8pt7wzDA==
Date:   Wed, 23 Jun 2021 14:02:03 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 36/65] x86/fpu: Rename "dynamic" XSTATEs to "independent"
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

The salient feature of "dynamic" XSTATEs is that they are not part of the
main task XSTATE buffer.  The fact that they are dynamically allocated is
irrelevant and will become quite confusing when user math XSTATEs start
being dynamically allocated.  Rename them to "independent" because they
are independent of the main XSTATE code.

This is just a search-and-replace with some whitespace updates to keep
things aligned.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1eecb0e4f3e07828ebe5d737ec77dc3b708fad2d.1623388344.git.luto@kernel.org
---
V4: Fix the comments
---
 arch/x86/events/intel/lbr.c       |    6 +--
 arch/x86/include/asm/fpu/xstate.h |   22 ++++++-------
 arch/x86/kernel/fpu/xstate.c      |   62 +++++++++++++++++++-------------------
 3 files changed, 45 insertions(+), 45 deletions(-)

--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -491,7 +491,7 @@ static void intel_pmu_arch_lbr_xrstors(v
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_kernel_to_dynamic_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	copy_kernel_to_independent_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
@@ -576,7 +576,7 @@ static void intel_pmu_arch_lbr_xsaves(vo
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_dynamic_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	copy_independent_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static void __intel_pmu_lbr_save(void *ctx)
@@ -992,7 +992,7 @@ static void intel_pmu_arch_lbr_read_xsav
 		intel_pmu_store_lbr(cpuc, NULL);
 		return;
 	}
-	copy_dynamic_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
+	copy_independent_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
 }
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -42,21 +42,21 @@
  * and its size may be huge. Saving/restoring such supervisor state components
  * at each context switch can cause high CPU and space overhead, which should
  * be avoided. Such supervisor state components should only be saved/restored
- * on demand. The on-demand dynamic supervisor features are set in this mask.
+ * on demand. The on-demand supervisor features are set in this mask.
  *
- * Unlike the existing supported supervisor features, a dynamic supervisor
+ * Unlike the existing supported supervisor features, a independent supervisor
  * feature does not allocate a buffer in task->fpu, and the corresponding
  * supervisor state component cannot be saved/restored at each context switch.
  *
- * To support a dynamic supervisor feature, a developer should follow the
+ * To support a independent supervisor feature, a developer should follow the
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
@@ -66,7 +66,7 @@
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
-				      XFEATURE_MASK_DYNAMIC | \
+				      XFEATURE_MASK_INDEPENDENT | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
 #ifdef CONFIG_X86_64
@@ -87,12 +87,12 @@ static inline u64 xfeatures_mask_user(vo
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
-static inline u64 xfeatures_mask_dynamic(void)
+static inline u64 xfeatures_mask_independent(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_DYNAMIC & ~XFEATURE_MASK_LBR;
+		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_DYNAMIC;
+	return XFEATURE_MASK_INDEPENDENT;
 }
 
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
@@ -104,8 +104,8 @@ void *get_xsave_addr(struct xregs_state
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
-void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
-void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
+void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
+void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask);
 
 enum xstate_copy_mode {
 	XSTATE_COPY_FP,
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -151,7 +151,7 @@ void fpu__init_cpu_xstate(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_independent());
 	}
 }
 
@@ -551,7 +551,7 @@ static void check_xstate_against_struct(
  * how large the XSAVE buffer needs to be.  We are recalculating
  * it to be safe.
  *
- * Dynamic XSAVE features allocate their own buffers and are not
+ * Independent XSAVE features allocate their own buffers and are not
  * covered by these checks. Only the size of the buffer for task->fpu
  * is checked here.
  */
@@ -617,18 +617,18 @@ static unsigned int __init get_xsaves_si
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
@@ -637,7 +637,7 @@ static unsigned int __init get_xsaves_si
 	 */
 	size = get_xsaves_size();
 
-	/* Re-enable dynamic features so XSAVES will work on them again. */
+	/* Re-enable independent features so XSAVES will work on them again. */
 	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
 
 	return size;
@@ -680,7 +680,7 @@ static int __init init_xstate_size(void)
 	xsave_size = get_xsave_size();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		possible_xstate_size = get_xsaves_size_no_dynamic();
+		possible_xstate_size = get_xsaves_size_no_independent();
 	else
 		possible_xstate_size = xsave_size;
 
@@ -837,7 +837,7 @@ void fpu__resume_cpu(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_independent());
 	}
 }
 
@@ -1163,34 +1163,34 @@ int copy_sigframe_from_user_to_xstate(st
 }
 
 /**
- * copy_dynamic_supervisor_to_kernel() - Save dynamic supervisor states to
- *                                       an xsave area
+ * copy_independent_supervisor_to_kernel() - Save independent supervisor states to
+ *                                           an xsave area
  * @xstate: A pointer to an xsave area
- * @mask: Represent the dynamic supervisor features saved into the xsave area
+ * @mask: Represent the independent supervisor features saved into the xsave area
  *
- * Only the dynamic supervisor states sets in the mask are saved into the xsave
- * area (See the comment in XFEATURE_MASK_DYNAMIC for the details of dynamic
- * supervisor feature). Besides the dynamic supervisor states, the legacy
+ * Only the independent supervisor states sets in the mask are saved into the xsave
+ * area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of independent
+ * supervisor feature). Besides the independent supervisor states, the legacy
  * region and XSAVE header are also saved into the xsave area. The supervisor
  * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
  *
  * The xsave area must be 64-bytes aligned.
  */
-void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
+void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u64 independent_mask = xfeatures_mask_independent() & mask;
 	u32 lmask, hmask;
 	int err;
 
 	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
 		return;
 
-	if (WARN_ON_FPU(!dynamic_mask))
+	if (WARN_ON_FPU(!independent_mask))
 		return;
 
-	lmask = dynamic_mask;
-	hmask = dynamic_mask >> 32;
+	lmask = independent_mask;
+	hmask = independent_mask >> 32;
 
 	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
 
@@ -1199,34 +1199,34 @@ void copy_dynamic_supervisor_to_kernel(s
 }
 
 /**
- * copy_kernel_to_dynamic_supervisor() - Restore dynamic supervisor states from
- *                                       an xsave area
+ * copy_kernel_to_independent_supervisor() - Restore independent supervisor states from
+ *                                           an xsave area
  * @xstate: A pointer to an xsave area
- * @mask: Represent the dynamic supervisor features restored from the xsave area
+ * @mask: Represent the independent supervisor features restored from the xsave area
  *
- * Only the dynamic supervisor states sets in the mask are restored from the
- * xsave area (See the comment in XFEATURE_MASK_DYNAMIC for the details of
- * dynamic supervisor feature). Besides the dynamic supervisor states, the
+ * Only the independent supervisor states sets in the mask are restored from the
+ * xsave area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of
+ * independent supervisor feature). Besides the independent supervisor states, the
  * legacy region and XSAVE header are also restored from the xsave area. The
  * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
  *
  * The xsave area must be 64-bytes aligned.
  */
-void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask)
+void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u64 independent_mask = xfeatures_mask_independent() & mask;
 	u32 lmask, hmask;
 	int err;
 
 	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
 		return;
 
-	if (WARN_ON_FPU(!dynamic_mask))
+	if (WARN_ON_FPU(!independent_mask))
 		return;
 
-	lmask = dynamic_mask;
-	hmask = dynamic_mask >> 32;
+	lmask = independent_mask;
+	hmask = independent_mask >> 32;
 
 	XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 

