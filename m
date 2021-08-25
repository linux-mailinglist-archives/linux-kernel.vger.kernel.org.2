Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1B3F79AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbhHYQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:02:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:32825 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241260AbhHYQBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="281267294"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="281267294"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317288"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:45 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 18/28] x86/fpu/xstate: Disable XSTATE support if an inconsistent state is detected
Date:   Wed, 25 Aug 2021 08:54:03 -0700
Message-Id: <20210825155413.19673-19-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
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
index 28e4f3254487..10be7b833279 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -607,11 +607,11 @@ static void __xstate_dump_leaves(void)
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
 
@@ -620,7 +620,7 @@ static void __xstate_dump_leaves(void)
  * that our software representation matches what the CPU
  * tells us about the state's size.
  */
-static void check_xstate_against_struct(int nr)
+static int check_xstate_against_struct(int nr)
 {
 	/*
 	 * Ask the CPU for the size of the state.
@@ -648,9 +648,12 @@ static void check_xstate_against_struct(int nr)
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
@@ -663,13 +666,14 @@ static void check_xstate_against_struct(int nr)
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
@@ -678,7 +682,10 @@ static unsigned int calculate_xstate_size(bool include_dynamic_states)
 		if ((xfeatures_mask_user_dynamic & BIT_ULL(i)) && !include_dynamic_states)
 			continue;
 
-		check_xstate_against_struct(i);
+		err = check_xstate_against_struct(i);
+		if (err)
+			return err;
+
 		/*
 		 * Supervisor state components can be managed only by
 		 * XSAVES.
@@ -704,7 +711,9 @@ static unsigned int calculate_xstate_size(bool include_dynamic_states)
 		xstate_size += xfeature_size(i);
 	}
 
-	return xstate_size;
+	if (size)
+		*size = xstate_size;
+	return 0;
 }
 
 /*
@@ -790,6 +799,7 @@ static int __init init_xstate_size(void)
 	/* Recompute the context size for enabled features: */
 	unsigned int possible_xstate_size, xstate_size;
 	unsigned int xsave_size;
+	int err;
 
 	xsave_size = get_xsave_size();
 
@@ -802,14 +812,18 @@ static int __init init_xstate_size(void)
 	 * Calculate the maximum xstate size, including the dynamic states.
 	 */
 	fpu_buf_cfg.max_size = possible_xstate_size;
-	xstate_size = calculate_xstate_size(true);
+	err = calculate_xstate_size(true, &xstate_size);
+	if (err)
+		return err;
 	XSTATE_WARN_ON(possible_xstate_size != xstate_size);
 
 	/*
 	 * Calculate the minimum xstate size, i.e., excluding the dynamic
 	 * xstates.
 	 */
-	xstate_size = calculate_xstate_size(false);
+	err = calculate_xstate_size(false, &xstate_size);
+	if (err)
+		return err;
 	if (!is_supported_xstate_size(xstate_size))
 		return -EINVAL;
 
-- 
2.17.1

