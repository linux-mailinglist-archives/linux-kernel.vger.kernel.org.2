Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A703CC431
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhGQPjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:39:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:24192 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235150AbhGQPiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:38:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="210853865"
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="210853865"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2021 08:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="631387035"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2021 08:35:09 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v8 17/26] x86/fpu/xstate: Disable XSTATE support if an inconsistent state is detected
Date:   Sat, 17 Jul 2021 08:28:54 -0700
Message-Id: <20210717152903.7651-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210717152903.7651-1-chang.seok.bae@intel.com>
References: <20210717152903.7651-1-chang.seok.bae@intel.com>
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
 arch/x86/kernel/fpu/xstate.c | 40 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 375a2c51f02f..787d192667b4 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -654,11 +654,11 @@ static void __xstate_dump_leaves(void)
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
 
@@ -667,7 +667,7 @@ static void __xstate_dump_leaves(void)
  * that our software representation matches what the CPU
  * tells us about the state's size.
  */
-static void check_xstate_against_struct(int nr)
+static int check_xstate_against_struct(int nr)
 {
 	/*
 	 * Ask the CPU for the size of the state.
@@ -695,9 +695,12 @@ static void check_xstate_against_struct(int nr)
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
@@ -707,13 +710,14 @@ static void check_xstate_against_struct(int nr)
  * excluded. Only the size of the buffer for task->fpu is checked here.
  *
  * @include_dynamic_states:	A knob to include dynamic states or not.
+ * @size:			A pointer to record the size.
  *
- * Return:			The calculated xstate size.
+ * Return:			0 if successful; otherwise, error code.
  */
-static unsigned int calculate_xstate_size(bool include_dynamic_states)
+static int calculate_xstate_size(bool include_dynamic_states, unsigned int *size)
 {
 	unsigned int xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
-	int i;
+	int i, err;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		if (!xfeature_enabled(i))
@@ -722,7 +726,10 @@ static unsigned int calculate_xstate_size(bool include_dynamic_states)
 		if (!include_dynamic_states && (xfeatures_mask_user_dynamic & BIT_ULL(i)))
 			continue;
 
-		check_xstate_against_struct(i);
+		err = check_xstate_against_struct(i);
+		if (err)
+			return err;
+
 		/*
 		 * Supervisor state components can be managed only by
 		 * XSAVES.
@@ -748,7 +755,9 @@ static unsigned int calculate_xstate_size(bool include_dynamic_states)
 		xstate_size += xfeature_size(i);
 	}
 
-	return xstate_size;
+	if (size)
+		*size = xstate_size;
+	return 0;
 }
 
 
@@ -835,6 +844,7 @@ static int __init init_xstate_size(void)
 	/* Recompute the context size for enabled features: */
 	unsigned int possible_xstate_size, xstate_size;
 	unsigned int xsave_size;
+	int err;
 
 	xsave_size = get_xsave_size();
 
@@ -848,7 +858,9 @@ static int __init init_xstate_size(void)
 	 * 'true' to include dynamic states. Cross-check with the CPUID-
 	 * provided size and record it.
 	 */
-	xstate_size = calculate_xstate_size(true);
+	err = calculate_xstate_size(true, &xstate_size);
+	if (err)
+		return err;
 	XSTATE_WARN_ON(possible_xstate_size != xstate_size);
 	set_xstate_config(XSTATE_MAX_SIZE, possible_xstate_size);
 
@@ -857,7 +869,9 @@ static int __init init_xstate_size(void)
 	 * 'false' to exclude dynamic states. Ensure the size fits in
 	 * the statically-allocated buffer and record it.
 	 */
-	xstate_size = calculate_xstate_size(false);
+	err = calculate_xstate_size(false, &xstate_size);
+	if (err)
+		return err;
 	if (!is_supported_xstate_size(xstate_size))
 		return -EINVAL;
 	set_xstate_config(XSTATE_MIN_SIZE, xstate_size);
-- 
2.17.1

