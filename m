Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBACF38DCB4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhEWTkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:12053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhEWTj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:57 -0400
IronPort-SDR: jbsoInzT4LO+SZieE1j/kevIaz+FQiiH2+UigEZDeTFbqVpL9qBSsYewe06F9e9lihLkOECGxK
 jKpCxVivyA6Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="265703538"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265703538"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:29 -0700
IronPort-SDR: BbFsWm+00TbNFcJYuXTXLipm6qWPfChQj721iXnSpG9SqD/qop8eQhwxNzYQXbO9oPulW1yyMc
 osmJvp1GwQNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467115"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 18/28] x86/fpu/xstate: Disable xstate support if an inconsistent state is detected
Date:   Sun, 23 May 2021 12:32:49 -0700
Message-Id: <20210523193259.26200-19-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has a sanity check between two methods to calculate xstate size.
In the unlikely event that they disagree, disable the use of xstate.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v4:
* Added as a new patch. (Thomas Gleixner)
---
 arch/x86/kernel/fpu/xstate.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1cf5888210aa..544e35a9d777 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -730,11 +730,11 @@ static void __xstate_dump_leaves(void)
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
 
@@ -743,7 +743,7 @@ static void __xstate_dump_leaves(void)
  * that our software representation matches what the CPU
  * tells us about the state's size.
  */
-static void check_xstate_against_struct(int nr)
+static int check_xstate_against_struct(int nr)
 {
 	/*
 	 * Ask the CPU for the size of the state.
@@ -771,9 +771,12 @@ static void check_xstate_against_struct(int nr)
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
@@ -786,9 +789,9 @@ static void check_xstate_against_struct(int nr)
  *
  * Dynamic supervisor XSAVE features allocate their own buffers and are not covered by these checks.
  *
- * Return: nothing.
+ * Returns 0 on success, -EINVAL on state size mismatch.
  */
-static void calculate_xstate_sizes(void)
+static int calculate_xstate_sizes(void)
 {
 	int paranoid_min_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int paranoid_max_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
@@ -796,13 +799,17 @@ static void calculate_xstate_sizes(void)
 
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
 		 * XSAVES, which is compacted-format only.
@@ -837,6 +844,7 @@ static void calculate_xstate_sizes(void)
 	}
 	XSTATE_WARN_ON(paranoid_max_size != get_xstate_config(XSTATE_MAX_SIZE));
 	set_xstate_config(XSTATE_MIN_SIZE, paranoid_min_size);
+	return 0;
 }
 
 
@@ -923,6 +931,7 @@ static int __init init_xstate_size(void)
 	/* Recompute the context size for enabled features: */
 	unsigned int possible_xstate_size;
 	unsigned int xsave_size;
+	int err;
 
 	xsave_size = get_xsave_size();
 
@@ -939,9 +948,11 @@ static int __init init_xstate_size(void)
 
 	/*
 	 * Calculate and double-check the maximum size. Calculate and record
-	 * the minimum size.
+	 * the minimum size. Emit the error when received.
 	 */
-	calculate_xstate_sizes();
+	err = calculate_xstate_sizes();
+	if (err)
+		return err;
 
 	/* Ensure the minimum size fits in the statically-alocated buffer: */
 	if (!is_supported_xstate_size(get_xstate_config(XSTATE_MIN_SIZE)))
-- 
2.17.1

