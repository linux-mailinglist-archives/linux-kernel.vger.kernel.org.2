Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8538DCA9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhEWTkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:63960 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231963AbhEWTj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:56 -0400
IronPort-SDR: HTiqW0i4iyl7j+HUs6YaoYvYC5wfnvvjNTtmdVL6EFZ9H3GBfPqRyegKs/9VtEDPl5xkvIVKC7
 dKndo/+s4l6Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="189190137"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="189190137"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:28 -0700
IronPort-SDR: Bn1W1pp2NGHS09YfVUxp7cyQ4mtIrjfSqOkXuZmfOwakFy96jUmxjQh7hIQXt6/WtJoR4nhj0e
 XzFuMrUK7oqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467079"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:27 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 07/28] x86/fpu/xstate: Calculate and remember dynamic xstate buffer sizes
Date:   Sun, 23 May 2021 12:32:38 -0700
Message-Id: <20210523193259.26200-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xstate per-task buffer is currently embedded into struct fpu with
static size. To accommodate dynamic user xstates, record the maximum and
minimum buffer sizes.

Rename the size calculation function. It calculates the maximum xstate size
and sanity checks it with CPUID. It also calculates the static embedded
buffer size by excluding the dynamic user states from the maximum size.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
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
 arch/x86/kernel/fpu/xstate.c | 56 ++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1d6613751625..74e0892bd8ec 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -654,24 +654,32 @@ static void check_xstate_against_struct(int nr)
 	}
 }
 
-/*
- * This essentially double-checks what the cpu told us about
- * how large the XSAVE buffer needs to be.  We are recalculating
- * it to be safe.
+/**
+ * calculate_xstate_sizes() - Calculate the xstate per-task buffer sizes -- maximum and minimum.
+ *
+ * Record the minimum and double-check the maximum against what the CPU told.
  *
- * Dynamic supervisor XSAVE features allocate their own buffers and are
- * not covered by these checks. Only the size of the buffer for task->fpu
- * is checked here.
+ * Dynamic user states are stored in this per-task buffer. They account for the delta between the
+ * maximum and the minimum.
+ *
+ * Dynamic supervisor XSAVE features allocate their own buffers and are not covered by these checks.
+ *
+ * Return: nothing.
  */
-static void do_extra_xstate_size_checks(void)
+static void calculate_xstate_sizes(void)
 {
-	int paranoid_xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	int paranoid_min_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	int paranoid_max_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int i;
 
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
@@ -681,23 +689,32 @@ static void do_extra_xstate_size_checks(void)
 			XSTATE_WARN_ON(xfeature_is_supervisor(i));
 
 		/* Align from the end of the previous feature */
-		if (xfeature_is_aligned(i))
-			paranoid_xstate_size = ALIGN(paranoid_xstate_size, 64);
+		if (xfeature_is_aligned(i)) {
+			paranoid_max_size = ALIGN(paranoid_max_size, 64);
+			if (!user_dynamic)
+				paranoid_min_size = ALIGN(paranoid_min_size, 64);
+		}
 		/*
 		 * The offset of a given state in the non-compacted
 		 * format is given to us in a CPUID leaf.  We check
 		 * them for being ordered (increasing offsets) in
 		 * setup_xstate_features().
 		 */
-		if (!using_compacted_format())
-			paranoid_xstate_size = xfeature_uncompacted_offset(i);
+		if (!using_compacted_format()) {
+			paranoid_max_size = xfeature_uncompacted_offset(i);
+			if (!user_dynamic)
+				paranoid_min_size = xfeature_uncompacted_offset(i);
+		}
 		/*
 		 * The compacted-format offset always depends on where
 		 * the previous state ended.
 		 */
-		paranoid_xstate_size += xfeature_size(i);
+		paranoid_max_size += xfeature_size(i);
+		if (!user_dynamic)
+			paranoid_min_size += xfeature_size(i);
 	}
-	XSTATE_WARN_ON(paranoid_xstate_size != get_xstate_config(XSTATE_MAX_SIZE));
+	XSTATE_WARN_ON(paranoid_max_size != get_xstate_config(XSTATE_MAX_SIZE));
+	set_xstate_config(XSTATE_MIN_SIZE, paranoid_min_size);
 }
 
 
@@ -798,14 +815,11 @@ static int __init init_xstate_size(void)
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
 
 	/* Ensure the minimum size fits in the statically-alocated buffer: */
 	if (!is_supported_xstate_size(get_xstate_config(XSTATE_MIN_SIZE)))
-- 
2.17.1

