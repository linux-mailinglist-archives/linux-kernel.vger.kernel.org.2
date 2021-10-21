Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2269436DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhJUXId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:08:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:4528 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhJUXID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:08:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="292634908"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="292634908"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033463"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 21/23] x86/fpu: Calculate the default sizes independently
Date:   Thu, 21 Oct 2021 15:55:25 -0700
Message-Id: <20211021225527.10184-22-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dynamically enabled states are supported the maximum and default sizes
for the kernel buffers and user space interfaces are not longer identical.

Put the necessary calculations in place which only take the default enabled
features into account.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Changes from the tglx tree:
* Fix to work when XSAVES is not available.
---
 arch/x86/kernel/fpu/xstate.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index df64b311119e..dcc1dd2d8f2d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -781,35 +781,40 @@ static bool __init is_supported_xstate_size(unsigned int test_xstate_size)
 static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
-	unsigned int user_size, kernel_size;
+	unsigned int user_size, kernel_size, kernel_default_size;
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
 
 	/* Uncompacted user space size */
 	user_size = get_xsave_size_user();
 
 	/*
 	 * XSAVES kernel size includes supervisor states and
-	 * uses compacted format.
+	 * uses compacted format when available.
 	 *
 	 * XSAVE does not support supervisor states so
 	 * kernel and user size is identical.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+	if (compacted)
 		kernel_size = get_xsaves_size_no_independent();
 	else
 		kernel_size = user_size;
 
-	/* Ensure we have the space to store all enabled features. */
-	if (!is_supported_xstate_size(kernel_size))
+	kernel_default_size =
+		xstate_calculate_size(fpu_kernel_cfg.default_features, compacted);
+
+	/* Ensure we have the space to store all default enabled features. */
+	if (!is_supported_xstate_size(kernel_default_size))
 		return -EINVAL;
 
 	if (!paranoid_xstate_size_valid(kernel_size))
 		return -EINVAL;
 
-	/* Keep it the same for now */
 	fpu_kernel_cfg.max_size = kernel_size;
-	fpu_kernel_cfg.default_size = kernel_size;
 	fpu_user_cfg.max_size = user_size;
-	fpu_user_cfg.default_size = user_size;
+
+	fpu_kernel_cfg.default_size = kernel_default_size;
+	fpu_user_cfg.default_size =
+		xstate_calculate_size(fpu_user_cfg.default_features, false);
 
 	return 0;
 }
@@ -894,15 +899,21 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
 	}
 
+	if (!cpu_feature_enabled(X86_FEATURE_XFD))
+		fpu_kernel_cfg.max_features &= ~XFEATURE_MASK_USER_DYNAMIC;
+
 	fpu_kernel_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED |
 			      XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 
 	fpu_user_cfg.max_features = fpu_kernel_cfg.max_features;
 	fpu_user_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED;
 
-	/* Identical for now */
+	/* Clean out dynamic features from default */
 	fpu_kernel_cfg.default_features = fpu_kernel_cfg.max_features;
+	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
+
 	fpu_user_cfg.default_features = fpu_user_cfg.max_features;
+	fpu_user_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
 
 	/* Store it for paranoia check at the end */
 	xfeatures = fpu_kernel_cfg.max_features;
@@ -913,6 +924,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	if (err)
 		goto out_disable;
 
+	/* Reset the state for the current task */
 	fpstate_reset(&current->thread.fpu);
 
 	/*
-- 
2.17.1

