Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BA3BA2B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhGBPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:25:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:1475 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231920AbhGBPZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:25:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10033"; a="269875057"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="269875057"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 08:23:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="482531792"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2021 08:23:15 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v6-fix 06/26] x86/fpu/xstate: Calculate and remember dynamic XSTATE buffer sizes
Date:   Fri,  2 Jul 2021 08:17:26 -0700
Message-Id: <20210702151726.27293-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7B6BF36A-E1C5-4D7C-96EC-2036AE27414B@intel.com>
References: <7B6BF36A-E1C5-4D7C-96EC-2036AE27414B@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XSTATE per-task buffer is currently embedded into struct fpu with
static size. To accommodate dynamic user XSTATEs, record the maximum and
minimum buffer sizes.

Rename the size calculation function. It calculates the maximum XSTATE size
and sanity checks it with CPUID. It also calculates the static embedded
buffer size by excluding the dynamic user states from the maximum size.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v6:
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
 arch/x86/kernel/fpu/xstate.c | 59 ++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e03853bb2603..75969f1ef4b3 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -590,24 +590,36 @@ static void check_xstate_against_struct(int nr)
 	}
 }
 
-/*
- * This essentially double-checks what the cpu told us about
- * how large the XSAVE buffer needs to be.  We are recalculating
- * it to be safe.
+/**
+ * calculate_xstate_sizes() - Calculate the xstate per-task buffer sizes.
+ *
+ * Record the minimum and double-check the maximum against what the CPU
+ * told.
  *
  * Independent XSAVE features allocate their own buffers and are not
  * covered by these checks. Only the size of the buffer for task->fpu
  * is checked here.
+ *
+ * Dynamic user states are stored in this per-task buffer. They account
+ * for the delta between the maximum and the minimum.
+ *
+ * Return: nothing.
  */
-static void do_extra_xstate_size_checks(void)
+static void calculate_xstate_sizes(void)
 {
-	int paranoid_xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
-	int i;
+	int xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	int xstate_size_no_dynamic, i;
+
+	xstate_size_no_dynamic = xstate_size;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		bool user_dynamic;
+
 		if (!xfeature_enabled(i))
 			continue;
 
+		user_dynamic = (xfeatures_mask_user_dynamic & BIT_ULL(i)) ? true : false;
+
 		check_xstate_against_struct(i);
 		/*
 		 * Supervisor state components can be managed only by
@@ -617,27 +629,39 @@ static void do_extra_xstate_size_checks(void)
 			XSTATE_WARN_ON(xfeature_is_supervisor(i));
 
 		/* Align from the end of the previous feature */
-		if (xfeature_is_aligned(i))
-			paranoid_xstate_size = ALIGN(paranoid_xstate_size, 64);
+		if (xfeature_is_aligned(i)) {
+			xstate_size = ALIGN(xstate_size, 64);
+			if (!user_dynamic)
+				xstate_size_no_dynamic = ALIGN(xstate_size_no_dynamic, 64);
+		}
 		/*
 		 * The offset of a given state in the non-compacted
 		 * format is given to us in a CPUID leaf.  We check
 		 * them for being ordered (increasing offsets) in
 		 * setup_xstate_features(). XSAVES uses compacted format.
 		 */
-		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
-			paranoid_xstate_size = xfeature_uncompacted_offset(i);
+		if (!cpu_feature_enabled(X86_FEATURE_XSAVES)) {
+			xstate_size = xfeature_uncompacted_offset(i);
+			if (!user_dynamic)
+				xstate_size_no_dynamic = xfeature_uncompacted_offset(i);
+		}
 		/*
 		 * The compacted-format offset always depends on where
 		 * the previous state ended.
 		 */
-		paranoid_xstate_size += xfeature_size(i);
+		xstate_size += xfeature_size(i);
+		if (!user_dynamic)
+			xstate_size_no_dynamic += xfeature_size(i);
 	}
+
 	/*
 	 * The size accounts for all the possible states reserved in the
 	 * per-task buffer.  Check against the maximum size.
 	 */
-	XSTATE_WARN_ON(paranoid_xstate_size != get_xstate_config(XSTATE_MAX_SIZE));
+	XSTATE_WARN_ON(xstate_size != get_xstate_config(XSTATE_MAX_SIZE));
+
+	/* Record the one without dynamic states as the minimum. */
+	set_xstate_config(XSTATE_MIN_SIZE, xstate_size_no_dynamic);
 }
 
 
@@ -738,14 +762,11 @@ static int __init init_xstate_size(void)
 	 */
 	set_xstate_config(XSTATE_MAX_SIZE, possible_xstate_size);
 
-	/* Perform an extra check for the maximum size. */
-	do_extra_xstate_size_checks();
-
 	/*
-	 * Set the minimum to be the same as the maximum. The dynamic
-	 * user states are not supported yet.
+	 * Calculate and double-check the maximum size. Calculate and record
+	 * the minimum size.
 	 */
-	set_xstate_config(XSTATE_MIN_SIZE, possible_xstate_size);
+	calculate_xstate_sizes();
 
 	/* Ensure the minimum size fits in the statically-allocated buffer: */
 	if (!is_supported_xstate_size(get_xstate_config(XSTATE_MIN_SIZE)))
-- 
2.17.1

