Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594B0320CF4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhBUTDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:03:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:37169 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhBUTCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:02:10 -0500
IronPort-SDR: K1CGpW/v/5dI4Mr6Jvd+dshdMZ3MJK0xsQNJ8lLW/6lyMMBso0hKBpZI/pIPVsMq3ANkbyBD/7
 WhPqckea8GoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="269192146"
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="269192146"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 11:01:28 -0800
IronPort-SDR: 4RBClKUTEV+N0T0zfQ2eMA/I7BMeRkLwu7s0+MG4Tf8PHsgjXWyHf7XJSSaIF6m2v0u4eN7A9s
 CljqdTvgO7Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="429792108"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2021 11:01:27 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v4 10/22] x86/fpu/xstate: Define the scope of the initial xstate data
Date:   Sun, 21 Feb 2021 10:56:25 -0800
Message-Id: <20210221185637.19281-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210221185637.19281-1-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_fpstate is used to record the initial xstate value and covers all the
states. But it is wasteful to cover large states all with trivial initial
data.

Limit init_fpstate by clarifying its size and coverage, which are all but
dynamic user states. The dynamic states are assumed to be large but having
initial data with zeros.

Expand copy_xregs_to_kernel_booting() to receive a mask argument of which
states to save.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Removed the helper functions. (Borislav Petkov)
* Removed 'no functional change' in the changelog. (Borislav Petkov)
* Updated the code comment.
* Moved out the other initialization changes into the previous patch.

Changes from v2:
* Updated the changelog for clarification.
* Updated the code comments.
---
 arch/x86/include/asm/fpu/internal.h |  3 +--
 arch/x86/kernel/fpu/core.c          | 13 ++++++++++---
 arch/x86/kernel/fpu/xstate.c        | 11 +++++++++--
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 46cb51ef4d17..e4afc1831e29 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -272,9 +272,8 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
  * This function is called only during boot time when x86 caps are not set
  * up and alternative can not be used yet.
  */
-static inline void copy_xregs_to_kernel_booting(struct xregs_state *xstate)
+static inline void copy_xregs_to_kernel_booting(struct xregs_state *xstate, u64 mask)
 {
-	u64 mask = xfeatures_mask_all;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 5debb1cd3c74..dc20eabb072d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -21,7 +21,10 @@
 
 /*
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
- * depending on the FPU hardware format:
+ * depending on the FPU hardware format.
+ *
+ * The dynamic user states are excluded as they are large but having initial
+ * values with zeros.
  */
 union fpregs_state init_fpstate __read_mostly;
 
@@ -206,9 +209,13 @@ void fpstate_init(struct fpu *fpu)
 		mask = fpu->state_mask;
 		size = get_xstate_size(fpu->state_mask);
 	} else {
+		/*
+		 * init_fpstate excludes the dynamic user states as they are
+		 * large but having initial values with zeros.
+		 */
 		state = &init_fpstate;
-		mask = xfeatures_mask_all;
-		size = get_xstate_config(XSTATE_MAX_SIZE);
+		mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+		size = get_xstate_config(XSTATE_MIN_SIZE);
 	}
 
 	if (!static_cpu_has(X86_FEATURE_FPU)) {
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 86251b947403..daf76108aa5f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -552,6 +552,7 @@ static void __init print_xstate_offset_size(void)
 static void __init setup_init_fpu_buf(void)
 {
 	static int on_boot_cpu __initdata = 1;
+	u64 mask;
 
 	WARN_ON_FPU(!on_boot_cpu);
 	on_boot_cpu = 0;
@@ -562,8 +563,14 @@ static void __init setup_init_fpu_buf(void)
 	setup_xstate_features();
 	print_xstate_features();
 
+	/*
+	 * Exclude the dynamic user states as they are large but having
+	 * initial values with zeros.
+	 */
+	mask = xfeatures_mask_all & ~xfeatures_mask_user_dynamic;
+
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		fpstate_init_xstate(&init_fpstate.xsave, xfeatures_mask_all);
+		fpstate_init_xstate(&init_fpstate.xsave, mask);
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
@@ -574,7 +581,7 @@ static void __init setup_init_fpu_buf(void)
 	 * Dump the init state again. This is to identify the init state
 	 * of any feature which is not represented by all zero's.
 	 */
-	copy_xregs_to_kernel_booting(&init_fpstate.xsave);
+	copy_xregs_to_kernel_booting(&init_fpstate.xsave, mask);
 }
 
 static int xfeature_uncompacted_offset(int xfeature_nr)
-- 
2.17.1

