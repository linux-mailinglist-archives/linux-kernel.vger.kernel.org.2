Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECB038DCAD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhEWTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:31996 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231972AbhEWTj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:56 -0400
IronPort-SDR: WpZSVCeYAssANT61zDPb1mqh4L7Q4lv86gsFs28eO2rHQoZwj/f8vg74hIsLN8EBy5qpBxYs4T
 RTZHFBuUo6VQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198740677"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198740677"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:28 -0700
IronPort-SDR: qOyatUcvd7OIQdaGJ3P4DuLAcDCikKiAcNwOtEYE1bmWqHrSDdZoha/iY9WyZR3fav1XFozolk
 n9NW4Mccb9TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467073"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:27 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 05/28] x86/fpu/xstate: Add a new variable to indicate dynamic user states
Date:   Sun, 23 May 2021 12:32:36 -0700
Message-Id: <20210523193259.26200-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xstate per-task buffer is in preparation to be dynamic for user states.
Introduce a new mask variable to indicate the 'dynamic' user states. The
value is determined at boot-time.

The perf subsystem has a separate buffer to save some state only when
needed, not in every context switch. The states are named as 'dynamic'
supervisor states. Some define and helper are not named with dynamic
supervisor states, so rename them.

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Updated the changelog. (Borislav Petkov)
* Updated the code comment. (Borislav Petkov)

Changes from v2:
* Updated the changelog for clarification.
---
 arch/x86/include/asm/fpu/xstate.h | 12 ++++++-----
 arch/x86/kernel/fpu/xstate.c      | 33 ++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 24bf8d3f559a..6ce8350672c2 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -56,7 +56,7 @@
  * - Don't set the bit corresponding to the dynamic supervisor feature in
  *   IA32_XSS at run time, since it has been set at boot time.
  */
-#define XFEATURE_MASK_DYNAMIC (XFEATURE_MASK_LBR)
+#define XFEATURE_MASK_SUPERVISOR_DYNAMIC (XFEATURE_MASK_LBR)
 
 /*
  * Unsupported supervisor features. When a supervisor feature in this mask is
@@ -66,7 +66,7 @@
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
-				      XFEATURE_MASK_DYNAMIC | \
+				      XFEATURE_MASK_SUPERVISOR_DYNAMIC | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
 #ifdef CONFIG_X86_64
@@ -87,14 +87,16 @@ static inline u64 xfeatures_mask_user(void)
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
-static inline u64 xfeatures_mask_dynamic(void)
+static inline u64 xfeatures_mask_supervisor_dynamic(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_DYNAMIC & ~XFEATURE_MASK_LBR;
+		return XFEATURE_MASK_SUPERVISOR_DYNAMIC & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_DYNAMIC;
+	return XFEATURE_MASK_SUPERVISOR_DYNAMIC;
 }
 
+extern u64 xfeatures_mask_user_dynamic;
+
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b55771eb739f..34755612019c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -61,6 +61,12 @@ static short xsave_cpuid_features[] __initdata = {
  */
 u64 xfeatures_mask_all __read_mostly;
 
+/*
+ * This represents user xstates, a subset of xfeatures_mask_all, saved in a
+ * dynamic kernel XSAVE buffer.
+ */
+u64 xfeatures_mask_user_dynamic __read_mostly;
+
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
@@ -237,7 +243,7 @@ void fpu__init_cpu_xstate(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_supervisor_dynamic());
 	}
 }
 
@@ -615,8 +621,8 @@ static void check_xstate_against_struct(int nr)
  * how large the XSAVE buffer needs to be.  We are recalculating
  * it to be safe.
  *
- * Dynamic XSAVE features allocate their own buffers and are not
- * covered by these checks. Only the size of the buffer for task->fpu
+ * Dynamic supervisor XSAVE features allocate their own buffers and are
+ * not covered by these checks. Only the size of the buffer for task->fpu
  * is checked here.
  */
 static void do_extra_xstate_size_checks(void)
@@ -686,7 +692,7 @@ static unsigned int __init get_xsaves_size(void)
  */
 static unsigned int __init get_xsaves_size_no_dynamic(void)
 {
-	u64 mask = xfeatures_mask_dynamic();
+	u64 mask = xfeatures_mask_supervisor_dynamic();
 	unsigned int size;
 
 	if (!mask)
@@ -773,6 +779,7 @@ static int __init init_xstate_size(void)
 static void fpu__init_disable_system_xstate(void)
 {
 	xfeatures_mask_all = 0;
+	xfeatures_mask_user_dynamic = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 }
@@ -839,6 +846,8 @@ void __init fpu__init_system_xstate(void)
 	}
 
 	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
+	/* Do not support the dynamically allocated buffer yet. */
+	xfeatures_mask_user_dynamic = 0;
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -886,7 +895,7 @@ void fpu__resume_cpu(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_supervisor_dynamic());
 	}
 }
 
@@ -1327,8 +1336,8 @@ void copy_supervisor_to_kernel(struct fpu *fpu)
  * @mask: Represent the dynamic supervisor features saved into the xsave area
  *
  * Only the dynamic supervisor states sets in the mask are saved into the xsave
- * area (See the comment in XFEATURE_MASK_DYNAMIC for the details of dynamic
- * supervisor feature). Besides the dynamic supervisor states, the legacy
+ * area (See the comment in XFEATURE_MASK_SUPERVISOR_DYNAMIC for the details of
+ * dynamic supervisor feature). Besides the dynamic supervisor states, the legacy
  * region and XSAVE header are also saved into the xsave area. The supervisor
  * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
@@ -1337,7 +1346,7 @@ void copy_supervisor_to_kernel(struct fpu *fpu)
  */
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u64 dynamic_mask = xfeatures_mask_supervisor_dynamic() & mask;
 	u32 lmask, hmask;
 	int err;
 
@@ -1363,9 +1372,9 @@ void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
  * @mask: Represent the dynamic supervisor features restored from the xsave area
  *
  * Only the dynamic supervisor states sets in the mask are restored from the
- * xsave area (See the comment in XFEATURE_MASK_DYNAMIC for the details of
- * dynamic supervisor feature). Besides the dynamic supervisor states, the
- * legacy region and XSAVE header are also restored from the xsave area. The
+ * xsave area (See the comment in XFEATURE_MASK_SUPERVISOR_DYNAMIC for the
+ * details of dynamic supervisor feature). Besides the dynamic supervisor states,
+ * the legacy region and XSAVE header are also restored from the xsave area. The
  * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
  *
@@ -1373,7 +1382,7 @@ void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
  */
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u64 dynamic_mask = xfeatures_mask_supervisor_dynamic() & mask;
 	u32 lmask, hmask;
 	int err;
 
-- 
2.17.1

