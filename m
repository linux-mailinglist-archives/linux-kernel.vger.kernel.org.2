Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9606436DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhJUXHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:4528 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232445AbhJUXHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="292634867"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="292634867"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033423"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:26 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 16/23] x86/fpu: Update XFD state where required
Date:   Thu, 21 Oct 2021 15:55:20 -0700
Message-Id: <20211021225527.10184-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IA32_XFD_MSR allows to arm #NM traps for XSTATE components which are
enabled in XCR0. The register has to be restored before the tasks XSTATE is
restored. The life time rules are the same as for FPU state.

XFD is updated on return to userspace only when the FPU state of the task
is not up to date in the registers. It's updated before the XRSTORS so
that eventually enabled dynamic features are restored as well and not
brought into init state.

Also in signal handling for restoring FPU state from user space the
correctness of the XFD state has to be ensured.

Add it to CPU initialization and resume as well.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/context.h |  2 ++
 arch/x86/kernel/fpu/core.c    | 25 +++++++++++++++++++++++++
 arch/x86/kernel/fpu/signal.c  |  2 ++
 arch/x86/kernel/fpu/xstate.c  | 12 ++++++++++++
 arch/x86/kernel/fpu/xstate.h  | 19 ++++++++++++++++++-
 5 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index a06ebf315d83..958accf2ccf0 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -69,6 +69,8 @@ static inline void fpregs_restore_userregs(void)
 		 * correct because it was either set in switch_to() or in
 		 * flush_thread(). So it is excluded because it might be
 		 * not up to date in current->thread.fpu.xsave state.
+		 *
+		 * XFD state is handled in restore_fpregs_from_fpstate().
 		 */
 		restore_fpregs_from_fpstate(fpu->fpstate, XFEATURE_MASK_FPSTATE);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index f4b02ed47034..f66beea2d1f8 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -155,6 +155,23 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 	}
 
 	if (use_xsave()) {
+		/*
+		 * Dynamically enabled features are enabled in XCR0, but
+		 * usage requires also that the corresponding bits in XFD
+		 * are cleared.  If the bits are set then using a related
+		 * instruction will raise #NM. This allows to do the
+		 * allocation of the larger FPU buffer lazy from #NM or if
+		 * the task has no permission to kill it which would happen
+		 * via #UD if the feature is disabled in XCR0.
+		 *
+		 * XFD state is following the same life time rules as
+		 * XSTATE and to restore state correctly XFD has to be
+		 * updated before XRSTORS otherwise the component would
+		 * stay in or go into init state even if the bits are set
+		 * in fpstate::regs::xsave::xfeatures.
+		 */
+		xfd_update_state(fpstate);
+
 		/*
 		 * Restoring state always needs to modify all features
 		 * which are in @mask even if the current task cannot use
@@ -244,7 +261,15 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest,
 
 	if (!cur_fps->is_confidential) {
 		restore_mask &= XFEATURE_MASK_FPSTATE;
+		/* Includes XFD update */
 		restore_fpregs_from_fpstate(cur_fps, restore_mask);
+	} else {
+		/*
+		 * XSTATE is restored by firmware from encrypted
+		 * memory. Make sure XFD state is correct while
+		 * running with guest fpstate
+		 */
+		xfd_update_state(cur_fps);
 	}
 
 	fpregs_mark_activate();
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a937980fd02b..f6461937c536 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -282,6 +282,8 @@ static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
 
 retry:
 	fpregs_lock();
+	/* Ensure that XFD is up to date */
+	xfd_update_state(fpu->fpstate);
 	pagefault_disable();
 	ret = __restore_fpregs_from_user(buf, fpu->fpstate->user_xfeatures,
 					 xrestore, fx_only);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c2cbe14aaa00..04f1f7aea93c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -136,6 +136,15 @@ void fpu__init_cpu_xstate(void)
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
 
+	/*
+	 * Must happen after CR4 setup and before xsetbv() to allow KVM
+	 * lazy passthrough.  Write independent of the dynamic state static
+	 * key as that does not work on the boot CPU. This also ensures
+	 * that any stale state is wiped out from XFD.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_XFD))
+		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+
 	/*
 	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
 	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
@@ -875,6 +884,9 @@ void fpu__resume_cpu(void)
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
 				     xfeatures_mask_independent());
 	}
+
+	if (fpu_state_size_dynamic())
+		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 29024244965b..e18210dff88c 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -136,6 +136,22 @@ extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor);
 static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor) { }
 #endif
 
+#ifdef CONFIG_X86_64
+static inline void xfd_update_state(struct fpstate *fpstate)
+{
+	if (fpu_state_size_dynamic()) {
+		u64 xfd = fpstate->xfd;
+
+		if (__this_cpu_read(xfd_state) != xfd) {
+			wrmsrl(MSR_IA32_XFD, xfd);
+			__this_cpu_write(xfd_state, xfd);
+		}
+	}
+}
+#else
+static inline void xfd_update_state(struct fpstate *fpstate) { }
+#endif
+
 /*
  * Save processor xstate to xsave area.
  *
@@ -247,7 +263,8 @@ static inline int os_xrstor_safe(struct fpstate *fpstate, u64 mask)
 	u32 hmask = mask >> 32;
 	int err;
 
-	/* Must enforce XFD update here */
+	/* Ensure that XFD is up to date */
+	xfd_update_state(fpstate);
 
 	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
 		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
-- 
2.17.1

