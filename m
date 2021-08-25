Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DBF3F79B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbhHYQCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:02:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:25526 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241981AbhHYQBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="204750095"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="204750095"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317335"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:47 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 27/28] x86/fpu/xstate: Add a sanity check for XFD state when saving XSTATE
Date:   Wed, 25 Aug 2021 08:54:12 -0700
Message-Id: <20210825155413.19673-28-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
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
 arch/x86/kernel/traps.c             |  7 +++----
 4 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 0225ab63e5d1..8b1833243d4a 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -568,6 +568,26 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
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
@@ -584,7 +604,7 @@ static inline void xfd_switch(struct fpu *prev, struct fpu *next)
 	next_xfd_mask = next->state_mask & xfeatures_mask_user_dynamic;
 
 	if (unlikely(prev_xfd_mask != next_xfd_mask))
-		wrmsrl_safe(MSR_IA32_XFD, xfeatures_mask_user_dynamic ^ next_xfd_mask);
+		xfd_write(xfeatures_mask_user_dynamic ^ next_xfd_mask);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 02681cce1d4e..43f04b97d080 100644
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
index 375577d38f95..2c62872e4fef 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -268,7 +268,7 @@ void fpu__init_cpu_xstate(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_XFD))
-		wrmsrl(MSR_IA32_XFD, xfeatures_mask_user_dynamic);
+		xfd_write(xfeatures_mask_user_dynamic);
 }
 
 static bool xfeature_enabled(enum xfeature xfeature)
@@ -1093,9 +1093,8 @@ void fpu__resume_cpu(void)
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_XFD))
-		wrmsrl_safe(MSR_IA32_XFD, (current->thread.fpu.state_mask &
-					   xfeatures_mask_user_dynamic) ^
-					  xfeatures_mask_user_dynamic);
+		xfd_write((current->thread.fpu.state_mask & xfeatures_mask_user_dynamic) ^
+			  xfeatures_mask_user_dynamic);
 }
 
 /**
@@ -1353,9 +1352,8 @@ void reset_dynamic_state_perm(struct task_struct *tsk)
 	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
 		fpstate_init_xstate(&fpu->state->xsave, fpu->state_mask);
 
-	wrmsrl_safe(MSR_IA32_XFD,
-		    (fpu->state_mask & xfeatures_mask_user_dynamic) ^
-		    xfeatures_mask_user_dynamic);
+	xfd_write((fpu->state_mask & xfeatures_mask_user_dynamic) ^
+		  xfeatures_mask_user_dynamic);
 
 	fpu->dynamic_state_perm = 0;
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 334dd5dc1ed2..459ce7baa39b 100644
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
@@ -1143,9 +1143,8 @@ static __always_inline bool handle_xfd_event(struct fpu *fpu, struct pt_regs *re
 			    !WARN_ON(in_interrupt())) {
 				err = realloc_xstate_buffer(fpu, xfd_event);
 				if (!err)
-					wrmsrl_safe(MSR_IA32_XFD, (fpu->state_mask &
-								   xfeatures_mask_user_dynamic) ^
-								  xfeatures_mask_user_dynamic);
+					xfd_write((fpu->state_mask & xfeatures_mask_user_dynamic) ^
+						  xfeatures_mask_user_dynamic);
 			}
 
 			/* Raise a signal when it failed to handle. */
-- 
2.17.1

