Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC95A3F7996
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbhHYQBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:01:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:32696 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241403AbhHYQBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="204685705"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="204685705"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317238"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:42 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 07/28] x86/fpu/xstate: Calculate and remember dynamic XSTATE buffer sizes
Date:   Wed, 25 Aug 2021 08:53:52 -0700
Message-Id: <20210825155413.19673-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPUID instruction separately enumerates sizes and alignments of
individual xfeatures. It independently enumerates the required size of an
entire XSAVE buffer to store all enabled features.

calculate_xstate_sizes() currently uses the individual feature
size/alignment enumeration to independently recalculate the required XSAVE
buffer size.

The XSTATE per-task buffer is currently embedded into struct fpu with
static size. To accommodate dynamic user XSTATEs, record the maximum and
minimum buffer sizes.

Extend the function to accept an option to exclude dynamic states. With
that, calculate the maximum size that contains all the enabled states, and
the minimum size that fits in the embedded buffer by excluding them.

Also, move the size comparison with the CPUID value out to the call site.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v9:
* Update the changelog and the code comment. (Borislav Petkov)

Changes from v6:
* Simplify xstate size calculation code. (Dave Hansen)
* Updated the changelog. (Dave Hansen)
* Fixed the v6 changes.

Changes from v5:
* Re-adjusted some local variable names.

Changes from v4:
* Massaged the function description, in preparation for the change
  with a return value.

Changes from v3:
* Updated the changelog. (Borislav Petkov)
* Updated the code comment. (Borislav Petkov)
* Adjusted the calculation function naming.
* Moved out the new variable addition into a new patch.

Changes from v2:
* Updated the changelog with task->fpu removed. (Borislav Petkov)
* Renamed the in-line size variable.
* Updated some code comments.
---
 arch/x86/kernel/fpu/xstate.c | 61 ++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 058dc9df6b86..2e474fbdc241 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -548,24 +548,31 @@ static void check_xstate_against_struct(int nr)
 	}
 }
 
-/*
- * This essentially double-checks what the cpu told us about
- * how large the XSAVE buffer needs to be.  We are recalculating
- * it to be safe.
+/**
+ * calculate_xstate_size - Calculate the xstate per-task buffer size.
+ *
+ * This essentially double-checks what the CPU told us about how large the
+ * XSAVE buffer needs to be. We are recalculating it to be safe.
+ *
+ * Independent XSAVE features allocate their own buffers and are always
+ * excluded. Only the size of the buffer for task->fpu is checked here.
  *
- * Independent XSAVE features allocate their own buffers and are not
- * covered by these checks. Only the size of the buffer for task->fpu
- * is checked here.
+ * @include_dynamic_states:	A knob to include dynamic states or not.
+ *
+ * Return:			The calculated xstate size.
  */
-static void do_extra_xstate_size_checks(void)
+static unsigned int calculate_xstate_size(bool include_dynamic_states)
 {
-	int paranoid_xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	unsigned int xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int i;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		if (!xfeature_enabled(i))
 			continue;
 
+		if ((xfeatures_mask_user_dynamic & BIT_ULL(i)) && !include_dynamic_states)
+			continue;
+
 		check_xstate_against_struct(i);
 		/*
 		 * Supervisor state components can be managed only by
@@ -576,7 +583,7 @@ static void do_extra_xstate_size_checks(void)
 
 		/* Align from the end of the previous feature */
 		if (xfeature_is_aligned(i))
-			paranoid_xstate_size = ALIGN(paranoid_xstate_size, 64);
+			xstate_size = ALIGN(xstate_size, 64);
 		/*
 		 * The offset of a given state in the non-compacted
 		 * format is given to us in a CPUID leaf.  We check
@@ -584,20 +591,16 @@ static void do_extra_xstate_size_checks(void)
 		 * setup_xstate_features(). XSAVES uses compacted format.
 		 */
 		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
-			paranoid_xstate_size = xfeature_uncompacted_offset(i);
+			xstate_size = xfeature_uncompacted_offset(i);
 		/*
 		 * The compacted-format offset always depends on where
 		 * the previous state ended.
 		 */
-		paranoid_xstate_size += xfeature_size(i);
+		xstate_size += xfeature_size(i);
 	}
-	/*
-	 * The size accounts for all the possible states reserved in the
-	 * per-task buffer.  Check against the maximum size.
-	 */
-	XSTATE_WARN_ON(paranoid_xstate_size != fpu_buf_cfg.max_size);
-}
 
+	return xstate_size;
+}
 
 /*
  * Get total size of enabled xstates in XCR0 | IA32_XSS.
@@ -680,7 +683,7 @@ static bool is_supported_xstate_size(unsigned int test_xstate_size)
 static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
-	unsigned int possible_xstate_size;
+	unsigned int possible_xstate_size, xstate_size;
 	unsigned int xsave_size;
 
 	xsave_size = get_xsave_size();
@@ -691,24 +694,22 @@ static int __init init_xstate_size(void)
 		possible_xstate_size = xsave_size;
 
 	/*
-	 * The size accounts for all the possible states reserved in the
-	 * per-task buffer.  Set the maximum with this value.
+	 * Calculate the maximum xstate size, including the dynamic states.
 	 */
 	fpu_buf_cfg.max_size = possible_xstate_size;
-
-	/* Perform an extra check for the maximum size. */
-	do_extra_xstate_size_checks();
+	xstate_size = calculate_xstate_size(true);
+	XSTATE_WARN_ON(possible_xstate_size != xstate_size);
 
 	/*
-	 * Set the minimum to be the same as the maximum. The dynamic
-	 * user states are not supported yet.
+	 * Calculate the minimum xstate size, i.e., excluding the dynamic
+	 * xstates.
 	 */
-	fpu_buf_cfg.min_size = possible_xstate_size;
-
-	/* Ensure the minimum size fits in the statically-allocated buffer: */
-	if (!is_supported_xstate_size(fpu_buf_cfg.min_size))
+	xstate_size = calculate_xstate_size(false);
+	if (!is_supported_xstate_size(xstate_size))
 		return -EINVAL;
 
+	fpu_buf_cfg.min_size = xstate_size;
+
 	/*
 	 * User space is always in standard format.
 	 */
-- 
2.17.1

