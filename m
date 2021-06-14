Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA23A6C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhFNQld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56150 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhFNQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:28 -0400
Message-Id: <20210614155356.961460910@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/cQ9BHrfwKOg6qxSJh9KjCI9pKKwpMrkB4z0n/bF8aI=;
        b=PWsj2VlHHQNcCdlZKui0n6KhVLRTjDyCJ9JLG/T/+CjPz27q6HlVcnJ6sko/JDALK3P6/A
        RlpV+TN0EeAiCu9CIEMtRVWnFG6ZR4WwzlTpr+nVNAVjtCTDn5C0Gmv70Di0WyYCQapiMg
        panzebetNRkQPOdLxrCW5L2ThPcH5s+4MXwAWZnAoJ9p+WW6fVF7Xt34q2CDy4YGflWJPy
        hOVcFmHQjhRXeegjgy8gTgNTdG5esvO81sUeSxT+jES7vpUAFs2nrNdqrcLMxjGXZ58rFz
        LsWsLTnAYjQbvOh0ems0aJR69ENmFPNmrmeB6kTqOHe4GsdkA8Zufc8GkXzU6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/cQ9BHrfwKOg6qxSJh9KjCI9pKKwpMrkB4z0n/bF8aI=;
        b=XCYt26wu8WKc8+WJpt6wk5n4ULq/P75NbFkp/HTt/jL4vhsl9Xe30X+P/2U2kwns2t8Buf
        LYqMzW8UEDHBSGAA==
Date:   Mon, 14 Jun 2021 17:44:40 +0200
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
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 32/52] x86/fpu/xstate: Sanitize handling of independent features
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copy functions for the independent features are horribly named and the
supervisor and independent part is just overengineered.

The point is that the supplied mask has either to be a subset of the
independent feature or a subset of the task->fpu.xstate managed features.

Rewrite it so it checks check for invalid overlaps of these areas in the
caller supplied feature mask. Rename it so it follows the new naming
convention for these operations. Mop up the function documentation.

This allows to use that function for other purposes as well.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c       |    6 +-
 arch/x86/include/asm/fpu/xstate.h |    5 +-
 arch/x86/kernel/fpu/xstate.c      |   93 +++++++++++++++++++-------------------
 3 files changed, 53 insertions(+), 51 deletions(-)

--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -491,7 +491,7 @@ static void intel_pmu_arch_lbr_xrstors(v
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_kernel_to_independent_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	xrstors_from_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
@@ -576,7 +576,7 @@ static void intel_pmu_arch_lbr_xsaves(vo
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_independent_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	xsaves_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static void __intel_pmu_lbr_save(void *ctx)
@@ -992,7 +992,7 @@ static void intel_pmu_arch_lbr_read_xsav
 		intel_pmu_store_lbr(cpuc, NULL);
 		return;
 	}
-	copy_independent_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
+	xsaves_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
 }
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -104,8 +104,9 @@ void *get_xsave_addr(struct xregs_state
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
-void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
-void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask);
+
+void xsaves_to_kernel(struct xregs_state *xsave, u64 mask);
+void xrstors_from_kernel(struct xregs_state *xsave, u64 mask);
 
 enum xstate_copy_mode {
 	XSTATE_COPY_FP,
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1163,75 +1163,76 @@ int copy_sigframe_from_user_to_xstate(st
 }
 
 /**
- * copy_independent_supervisor_to_kernel() - Save independent supervisor states to
- *                                           an xsave area
- * @xstate: A pointer to an xsave area
- * @mask: Represent the independent supervisor features saved into the xsave area
+ * xsaves_to_kernel - Save selected components to a kernel xstate buffer
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to save
  *
- * Only the independent supervisor states sets in the mask are saved into the xsave
- * area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of independent
- * supervisor feature). Besides the independent supervisor states, the legacy
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
+ * a subset of the task->fpstate related features
  */
-void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
+void xsaves_to_kernel(struct xregs_state *xstate, u64 mask)
 {
-	u64 independent_mask = xfeatures_mask_independent() & mask;
-	u32 lmask, hmask;
+	u64 xchk;
 	int err;
 
-	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
+	if (WARN_ON_FPU(!cpu_feature_enabled(X86_FEATURE_XSAVES)))
 		return;
+	/*
+	 * Validate that this is either a task->fpstate related component
+	 * subset or an independent one.
+	 */
+	if (mask & xfeatures_mask_independent())
+		xchk = ~xfeatures_mask_independent();
+	else
+		xchk = ~xfeatures_mask_all;
 
-	if (WARN_ON_FPU(!independent_mask))
+	if (WARN_ON_ONCE(!mask || mask & xchk))
 		return;
 
-	lmask = independent_mask;
-	hmask = independent_mask >> 32;
-
-	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
-
-	/* Should never fault when copying to a kernel buffer */
-	WARN_ON_FPU(err);
+	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
+	WARN_ON_ONCE(err);
 }
 
 /**
- * copy_kernel_to_independent_supervisor() - Restore independent supervisor states from
- *                                           an xsave area
- * @xstate: A pointer to an xsave area
- * @mask: Represent the independent supervisor features restored from the xsave area
+ * xrstors_from_kernel - Restore selected components from a kernel xstate buffer
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to restore
+ *
+ * The @xstate buffer must be 64 byte aligned and correctly initialized
+ * otherwise XRSTORS from that buffer can #GP.
  *
- * Only the independent supervisor states sets in the mask are restored from the
- * xsave area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of
- * independent supervisor feature). Besides the independent supervisor states, the
- * legacy region and XSAVE header are also restored from the xsave area. The
- * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
- * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
+ * Proper usage is to restore the state which was saved with
+ * xsaves_to_kernel() into @xstate.
  *
- * The xsave area must be 64-bytes aligned.
+ * The feature mask must either be a subset of the independent features or
+ * a subset of the task->fpstate related features
  */
-void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask)
+void xrstors_from_kernel(struct xregs_state *xstate, u64 mask)
 {
-	u64 independent_mask = xfeatures_mask_independent() & mask;
-	u32 lmask, hmask;
+	u64 xchk;
 	int err;
 
-	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
+	if (WARN_ON_FPU(!cpu_feature_enabled(X86_FEATURE_XSAVES)))
 		return;
+	/*
+	 * Validate that this is either a task->fpstate related component
+	 * subset or an independent one.
+	 */
+	if (mask & xfeatures_mask_independent())
+		xchk = ~xfeatures_mask_independent();
+	else
+		xchk = ~xfeatures_mask_all;
 
-	if (WARN_ON_FPU(!independent_mask))
+	if (WARN_ON_ONCE(!mask || mask & xchk))
 		return;
 
-	lmask = independent_mask;
-	hmask = independent_mask >> 32;
-
-	XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
-
-	/* Should never fault when copying from a kernel buffer */
-	WARN_ON_FPU(err);
+	XSTATE_OP(XRSTORS, xstate, (u32)mask, (u32)(mask >> 32), err);
+	WARN_ON_ONCE(err);
 }
 
 #ifdef CONFIG_PROC_PID_ARCH_STATUS

