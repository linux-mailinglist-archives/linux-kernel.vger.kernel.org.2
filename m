Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC3E38DCA5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhEWTkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:63960 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231932AbhEWTjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:55 -0400
IronPort-SDR: WiCYnF+PpRG2w0iSVYFpkpXjGDPve3302gEzhuqIlzcAajquyb+C8KNctogyk1okHnMkvnKEj0
 RlNQmpwyZdyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="189190139"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="189190139"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:28 -0700
IronPort-SDR: CRfdJP4uAotZ6enrdFjfz4FfRJTbjiZgKApS29CVYuQ5bZ6BvUBbg/g3FgotVJjpuJzrnuMpcl
 48YQQfo9p8KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467089"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 10/28] x86/fpu/xstate: Define the scope of the initial xstate data
Date:   Sun, 23 May 2021 12:32:41 -0700
Message-Id: <20210523193259.26200-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
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
index 918930553290..2584a2922fea 100644
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
 
@@ -213,9 +216,13 @@ void fpstate_init(struct fpu *fpu)
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
index 0e3f93b03b3f..773f594bd730 100644
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

