Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECB03A46D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhFKQrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:47:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhFKQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:22 -0400
Message-Id: <20210611163113.307062186@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=23PzgQC/LnXv29LxnK7BMGGdzTtaPuy8HC7iXaqOLLU=;
        b=AnfdfdWKFWlYc/OiWZCtRB4uJOZFwtHKouxvEocyMLF2EG++P7UH7t6sYsBoUkqG8bkmT4
        DYUAdbrkheO0DWeSNdpU9M9MV2fA9pLX/9CJIRMON3fYV2joLvouix6KH6D4pcPIMgsk8y
        8/jVePbKuR22m5b9E3imrZq+pLcf6gzd3mc0t67fnRUTnQEztfdzbdRCE7tiGwwQ9Eh8Do
        GkCCnxcId1rGUvLv9Zoj10nK2tabXHbFtYGWGQvCgJtYsbF+GAwtjocxaIU2CthK9pi2/+
        hmQD8QBfbhviMnf5T/NkL0lt0KQGH3YzFyPWSpm2CyBYKSLkr1y+CGqm0DSmGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=23PzgQC/LnXv29LxnK7BMGGdzTtaPuy8HC7iXaqOLLU=;
        b=YRIViELxG4xXlp+GwidadHoWm5XSZpvJtFrdJ9nuWs7/dxbfK7Dv+k4u3jS4wxXsw1wLye
        hDbezcbZ4sFFDiDA==
Date:   Fri, 11 Jun 2021 18:15:45 +0200
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
Subject: [patch 22/41] x86/fpu/xstate: Sanitize handling of independent features
References: <20210611161523.508908024@linutronix.de>
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
@@ -107,7 +107,8 @@ struct membuf;
 void copy_uabi_xstate_to_membuf(struct membuf to, struct xregs_state *xsave);
 int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
-void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
-void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask);
+
+void xsaves_to_kernel(struct xregs_state *xsave, u64 mask);
+void xrstors_from_kernel(struct xregs_state *xsave, u64 mask);
 
 #endif
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1107,75 +1107,76 @@ int copy_sigframe_from_user_to_xstate(st
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

