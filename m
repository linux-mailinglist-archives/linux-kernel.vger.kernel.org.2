Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6897541F7AD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355992AbhJAWr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:47:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:38097 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356236AbhJAWre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:47:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205756682"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="205756682"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565344029"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 15:44:20 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v11 27/29] x86/fpu/xstate: Add a sanity check for XFD state when saving XSTATE
Date:   Fri,  1 Oct 2021 15:37:26 -0700
Message-Id: <20211001223728.9309-28-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DEBUG sanity check that XFD state matches with XINUSE state.

Instead of reading MSR IA32_XFD directly, read a per-cpu value that is
recorded at every MSR write.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v9:
* Re-introduce xfd_write() to record every XFD write.
* Use cpu_feature_enabled() instead of boot_cpu_has(). (Borislav Petkov)

Changes from v5:
* Added as a new patch. (Dave Hansen)
---
 arch/x86/include/asm/fpu/internal.h | 22 +++++++++++++++++++++-
 arch/x86/kernel/fpu/core.c          | 13 +++++++++++++
 arch/x86/kernel/fpu/xstate.c        | 12 +++++-------
 arch/x86/kernel/traps.c             |  9 ++++-----
 4 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 5f013fa0b205..1129abc6ae06 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -556,6 +556,26 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  * Misc helper functions:
  */
 
+#ifdef CONFIG_X86_DEBUG_FPU
+DECLARE_PER_CPU(u64, xfd_shadow);
+static inline u64 xfd_debug_shadow(void)
+{
+	return this_cpu_read(xfd_shadow);
+}
+
+static inline void xfd_write(u64 value)
+{
+	wrmsrl_safe(MSR_IA32_XFD, value);
+	this_cpu_write(xfd_shadow, value);
+}
+#else
+#define xfd_debug_shadow()	0
+static inline void xfd_write(u64 value)
+{
+	wrmsrl_safe(MSR_IA32_XFD, value);
+}
+#endif
+
 /**
  * xfd_switch - Switches the MSR IA32_XFD context if needed.
  * @prev:	The previous task's struct fpu pointer
@@ -572,7 +592,7 @@ static inline void xfd_switch(struct fpu *prev, struct fpu *next)
 	next_xfd_mask = next->state_mask & xfeatures_mask_user_dynamic;
 
 	if (unlikely(prev_xfd_mask != next_xfd_mask))
-		wrmsrl_safe(MSR_IA32_XFD, xfeatures_mask_user_dynamic ^ next_xfd_mask);
+		xfd_write(xfeatures_mask_user_dynamic ^ next_xfd_mask);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index fdac0f430af3..be6c210c00d4 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -82,6 +82,10 @@ bool irq_fpu_usable(void)
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
+#ifdef CONFIG_X86_DEBUG_FPU
+DEFINE_PER_CPU(u64, xfd_shadow);
+#endif
+
 /*
  * Save the FPU register state in fpu->state. The register state is
  * preserved.
@@ -99,6 +103,15 @@ EXPORT_SYMBOL(irq_fpu_usable);
 void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
+		/*
+		 * If XFD is armed for an xfeature, XSAVE* will not save
+		 * its state. Verify XFD is clear for all features that
+		 * are in use before XSAVE*.
+		 */
+		if (IS_ENABLED(CONFIG_X86_DEBUG_FPU) && cpu_feature_enabled(X86_FEATURE_XFD) &&
+		    cpu_feature_enabled(X86_FEATURE_XGETBV1))
+			WARN_ON_FPU(xgetbv(1) & xfd_debug_shadow());
+
 		os_xsave(&fpu->state->xsave, fpu->state_mask);
 
 		/*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 43539893dd82..81566a18643b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -269,7 +269,7 @@ void fpu__init_cpu_xstate(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_XFD))
-		wrmsrl(MSR_IA32_XFD, xfeatures_mask_user_dynamic);
+		xfd_write(xfeatures_mask_user_dynamic);
 }
 
 static bool xfeature_enabled(enum xfeature xfeature)
@@ -1095,9 +1095,8 @@ void fpu__resume_cpu(void)
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_XFD))
-		wrmsrl_safe(MSR_IA32_XFD, (current->thread.fpu.state_mask &
-					   xfeatures_mask_user_dynamic) ^
-					  xfeatures_mask_user_dynamic);
+		xfd_write((current->thread.fpu.state_mask & xfeatures_mask_user_dynamic) ^
+			  xfeatures_mask_user_dynamic);
 }
 
 /**
@@ -1325,9 +1324,8 @@ void reset_state_perm(struct task_struct *tsk)
 	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
 		fpstate_init_xstate(&fpu->state->xsave, fpu->state_mask);
 
-	wrmsrl_safe(MSR_IA32_XFD,
-		    (fpu->state_mask & xfeatures_mask_user_dynamic) ^
-		    xfeatures_mask_user_dynamic);
+	xfd_write((fpu->state_mask & xfeatures_mask_user_dynamic) ^
+		  xfeatures_mask_user_dynamic);
 }
 
 /**
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index bbf30e73d156..cc19b570b322 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1129,7 +1129,7 @@ static __always_inline bool handle_xfd_event(struct fpu *fpu, struct pt_regs *re
 			 * unblock the task.
 			 */
 			rdmsrl_safe(MSR_IA32_XFD, &value);
-			wrmsrl_safe(MSR_IA32_XFD, value & ~xfd_err);
+			xfd_write(value & ~xfd_err);
 		} else {
 			struct fpu *fpu = &current->thread.fpu;
 			int err = -1;
@@ -1148,10 +1148,9 @@ static __always_inline bool handle_xfd_event(struct fpu *fpu, struct pt_regs *re
 				if (!WARN_ON(in_interrupt())) {
 					err = realloc_xstate_buffer(fpu, xfd_event);
 					if (!err)
-						wrmsrl_safe(MSR_IA32_XFD,
-							    (fpu->state_mask &
-							     xfeatures_mask_user_dynamic) ^
-							    xfeatures_mask_user_dynamic);
+						xfd_write((fpu->state_mask &
+							  xfeatures_mask_user_dynamic) ^
+							  xfeatures_mask_user_dynamic);
 				}
 
 				if (err)
-- 
2.17.1

