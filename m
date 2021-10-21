Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62713436DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhJUXHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:4523 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232139AbhJUXHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="292634863"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="292634863"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033414"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:26 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 15/23] x86/fpu: Add sanity checks for XFD
Date:   Thu, 21 Oct 2021 15:55:19 -0700
Message-Id: <20211021225527.10184-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add debug functionality to ensure that the XFD MSR is up to date for XSAVE*
and XRSTOR* operations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Changes from the tglx tree:
* Rename the xstate ops validation helper. (Dave Hansen)
* Update code comments. (Dave Hansen)
---
 arch/x86/kernel/fpu/core.c   |  9 +++---
 arch/x86/kernel/fpu/signal.c |  6 ++--
 arch/x86/kernel/fpu/xstate.c | 55 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/fpu/xstate.h | 34 +++++++++++++++++++---
 4 files changed, 92 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index e92c9d79441c..f4b02ed47034 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -166,7 +166,7 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 		 */
 		mask = fpu_kernel_cfg.max_features & mask;
 
-		os_xrstor(&fpstate->regs.xsave, mask);
+		os_xrstor(fpstate, mask);
 	} else {
 		if (use_fxsr())
 			fxrstor(&fpstate->regs.fxsave);
@@ -537,7 +537,7 @@ void fpu__drop(struct fpu *fpu)
 static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 {
 	if (use_xsave())
-		os_xrstor(&init_fpstate.regs.xsave, features_mask);
+		os_xrstor(&init_fpstate, features_mask);
 	else if (use_fxsr())
 		fxrstor(&init_fpstate.regs.fxsave);
 	else
@@ -594,9 +594,8 @@ void fpu__clear_user_states(struct fpu *fpu)
 	 * corresponding registers.
 	 */
 	if (xfeatures_mask_supervisor() &&
-	    !fpregs_state_valid(fpu, smp_processor_id())) {
-		os_xrstor(&fpu->fpstate->regs.xsave, xfeatures_mask_supervisor());
-	}
+	    !fpregs_state_valid(fpu, smp_processor_id()))
+		os_xrstor_supervisor(fpu->fpstate);
 
 	/* Reset user states in registers. */
 	restore_fpregs_from_init_fpstate(XFEATURE_MASK_USER_RESTORE);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d128eb581ffc..a937980fd02b 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -261,7 +261,7 @@ static int __restore_fpregs_from_user(void __user *buf, u64 ufeatures,
 			ret = fxrstor_from_user_sigframe(buf);
 
 		if (!ret && unlikely(init_bv))
-			os_xrstor(&init_fpstate.regs.xsave, init_bv);
+			os_xrstor(&init_fpstate, init_bv);
 		return ret;
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
@@ -322,7 +322,7 @@ static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
 	 * been restored from a user buffer directly.
 	 */
 	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
-		os_xrstor(&fpu->fpstate->regs.xsave, xfeatures_mask_supervisor());
+		os_xrstor_supervisor(fpu->fpstate);
 
 	fpregs_mark_activate();
 	fpregs_unlock();
@@ -432,7 +432,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
 		fpregs->xsave.header.xfeatures &= mask;
-		success = !os_xrstor_safe(&fpregs->xsave,
+		success = !os_xrstor_safe(fpu->fpstate,
 					  fpu_kernel_cfg.max_features);
 	} else {
 		success = !fxrstor_safe(&fpregs->fxsave);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c178aa91abb3..c2cbe14aaa00 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1301,6 +1301,61 @@ EXPORT_SYMBOL_GPL(fpstate_clear_xstate_component);
 #endif
 
 #ifdef CONFIG_X86_64
+
+#ifdef CONFIG_X86_DEBUG_FPU
+/*
+ * Ensure that a subsequent XSAVE* or XRSTOR* instruction with RFBM=@mask
+ * can safely operate on the @fpstate buffer.
+ */
+static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
+{
+	u64 xfd = __this_cpu_read(xfd_state);
+
+	if (fpstate->xfd == xfd)
+		return true;
+
+	/* For current's fpstate the XFD state must be correct. */
+	if (fpstate->xfd == current->thread.fpu.fpstate->xfd)
+		return false;
+
+	/*
+	 * XRSTOR(S) from init_fpstate are always correct as it will just
+	 * bring all components into init state and not read from the
+	 * buffer. XSAVE(S) raises #PF after init.
+	 */
+	if (fpstate == &init_fpstate)
+		return rstor;
+
+	/*
+	 * XSAVE(S): clone(), fpu_swap_kvm_fpu()
+	 * XRSTORS(S): fpu_swap_kvm_fpu()
+	 */
+
+	/*
+	 * No XSAVE/XRSTOR instructions (except XSAVE itself) touch
+	 * the buffer area for XFD-disabled state components.
+	 */
+	mask &= ~xfd;
+
+	/*
+	 * Remove features which are valid in fpstate. They
+	 * have space allocated in fpstate.
+	 */
+	mask &= ~fpstate->xfeatures;
+
+	/*
+	 * Any remaining state components in 'mask' might be written
+	 * by XSAVE/XRSTOR. Fail validation it found.
+	 */
+	return !mask;
+}
+
+void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor)
+{
+	WARN_ON_ONCE(!xstate_op_valid(fpstate, mask, rstor));
+}
+#endif /* CONFIG_X86_DEBUG_FPU */
+
 static int validate_sigaltstack(unsigned int usize)
 {
 	struct task_struct *thread, *leader = current->group_leader;
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 32a4dee4de3b..29024244965b 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -130,6 +130,12 @@ static inline u64 xfeatures_mask_independent(void)
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+#if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)
+extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor);
+#else
+static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor) { }
+#endif
+
 /*
  * Save processor xstate to xsave area.
  *
@@ -144,6 +150,7 @@ static inline void os_xsave(struct fpstate *fpstate)
 	int err;
 
 	WARN_ON_FPU(!alternatives_patched);
+	xfd_validate_state(fpstate, mask, false);
 
 	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
 
@@ -156,12 +163,23 @@ static inline void os_xsave(struct fpstate *fpstate)
  *
  * Uses XRSTORS when XSAVES is used, XRSTOR otherwise.
  */
-static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
+static inline void os_xrstor(struct fpstate *fpstate, u64 mask)
+{
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
+
+	xfd_validate_state(fpstate, mask, true);
+	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
+}
+
+/* Restore of supervisor state. Does not require XFD */
+static inline void os_xrstor_supervisor(struct fpstate *fpstate)
 {
+	u64 mask = xfeatures_mask_supervisor();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 
-	XSTATE_XRESTORE(xstate, lmask, hmask);
+	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
 }
 
 /*
@@ -184,11 +202,14 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 	 * internally, e.g. PKRU. That's user space ABI and also required
 	 * to allow the signal handler to modify PKRU.
 	 */
-	u64 mask = current->thread.fpu.fpstate->user_xfeatures;
+	struct fpstate *fpstate = current->thread.fpu.fpstate;
+	u64 mask = fpstate->user_xfeatures;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
 
+	xfd_validate_state(fpstate, mask, false);
+
 	stac();
 	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
 	clac();
@@ -206,6 +227,8 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64
 	u32 hmask = mask >> 32;
 	int err;
 
+	xfd_validate_state(current->thread.fpu.fpstate, mask, true);
+
 	stac();
 	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
 	clac();
@@ -217,12 +240,15 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64
  * Restore xstate from kernel space xsave area, return an error code instead of
  * an exception.
  */
-static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
+static inline int os_xrstor_safe(struct fpstate *fpstate, u64 mask)
 {
+	struct xregs_state *xstate = &fpstate->regs.xsave;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
 
+	/* Must enforce XFD update here */
+
 	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
 		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 	else
-- 
2.17.1

