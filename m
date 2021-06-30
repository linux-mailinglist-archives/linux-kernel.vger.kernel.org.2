Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D573B7D36
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhF3GLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:11:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:46949 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232414AbhF3GKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:10:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="195448578"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="195448578"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 23:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="455156545"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 29 Jun 2021 23:08:19 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v6 17/26] x86/fpu/xstate: Disable XSTATE support if an inconsistent state is detected
Date:   Tue, 29 Jun 2021 23:02:17 -0700
Message-Id: <20210630060226.24652-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210630060226.24652-1-chang.seok.bae@intel.com>
References: <20210630060226.24652-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has a sanity check between two methods to calculate XSTATE size.
In the unlikely event that they disagree, disable the use of XSTATE.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v4:
* Added as a new patch. (Thomas Gleixner)
---
 arch/x86/kernel/fpu/xstate.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3e71aa45c5b7..08be55ac1597 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -652,11 +652,11 @@ static void __xstate_dump_leaves(void)
 } while (0)
 
 #define XCHECK_SZ(sz, nr, nr_macro, __struct) do {			\
-	if ((nr == nr_macro) &&						\
-	    WARN_ONCE(sz != sizeof(__struct),				\
-		"%s: struct is %zu bytes, cpu state %d bytes\n",	\
-		__stringify(nr_macro), sizeof(__struct), sz)) {		\
+	if ((nr == nr_macro) &&	(sz != sizeof(__struct))) {		\
+		pr_err("%s: struct is %zu bytes, cpu state %d bytes\n",	\
+		       __stringify(nr_macro), sizeof(__struct), sz);	\
 		__xstate_dump_leaves();					\
+		return -EINVAL;						\
 	}								\
 } while (0)
 
@@ -665,7 +665,7 @@ static void __xstate_dump_leaves(void)
  * that our software representation matches what the CPU
  * tells us about the state's size.
  */
-static void check_xstate_against_struct(int nr)
+static int check_xstate_against_struct(int nr)
 {
 	/*
 	 * Ask the CPU for the size of the state.
@@ -693,9 +693,12 @@ static void check_xstate_against_struct(int nr)
 	    (nr >= XFEATURE_MAX) ||
 	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
 	    ((nr >= XFEATURE_RSRVD_COMP_11) && (nr <= XFEATURE_LBR))) {
-		WARN_ONCE(1, "no structure for xstate: %d\n", nr);
+		pr_err("no structure for xstate: %d\n", nr);
 		XSTATE_WARN_ON(1);
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 /**
@@ -711,9 +714,9 @@ static void check_xstate_against_struct(int nr)
  * Dynamic user states are stored in this per-task buffer. They account
  * for the delta between the maximum and the minimum.
  *
- * Return: nothing.
+ * Returns 0 on success, -EINVAL on state size mismatch.
  */
-static void calculate_xstate_sizes(void)
+static int calculate_xstate_sizes(void)
 {
 	int xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int xstate_size_no_dynamic, i;
@@ -722,13 +725,17 @@ static void calculate_xstate_sizes(void)
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		bool user_dynamic;
+		int err;
 
 		if (!xfeature_enabled(i))
 			continue;
 
 		user_dynamic = (xfeatures_mask_user_dynamic & BIT_ULL(i)) ? true : false;
 
-		check_xstate_against_struct(i);
+		err = check_xstate_against_struct(i);
+		if (err)
+			return err;
+
 		/*
 		 * Supervisor state components can be managed only by
 		 * XSAVES.
@@ -770,6 +777,8 @@ static void calculate_xstate_sizes(void)
 
 	/* Record the one without dynamic states as the minimum. */
 	set_xstate_config(XSTATE_MIN_SIZE, xstate_size_no_dynamic);
+
+	return 0;
 }
 
 
@@ -856,6 +865,7 @@ static int __init init_xstate_size(void)
 	/* Recompute the context size for enabled features: */
 	unsigned int possible_xstate_size;
 	unsigned int xsave_size;
+	int err;
 
 	xsave_size = get_xsave_size();
 
@@ -872,9 +882,11 @@ static int __init init_xstate_size(void)
 
 	/*
 	 * Calculate and double-check the maximum size. Calculate and record
-	 * the minimum size.
+	 * the minimum size. Emit the error when received.
 	 */
-	calculate_xstate_sizes();
+	err = calculate_xstate_sizes();
+	if (err)
+		return err;
 
 	/* Ensure the minimum size fits in the statically-allocated buffer: */
 	if (!is_supported_xstate_size(get_xstate_config(XSTATE_MIN_SIZE)))
-- 
2.17.1

