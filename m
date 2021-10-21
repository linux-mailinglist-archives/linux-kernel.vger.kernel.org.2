Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D87436DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhJUXHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:58059 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232036AbhJUXHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315380021"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315380021"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033265"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:21 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 05/23] x86/fpu: Add fpu_state_config::legacy_features
Date:   Thu, 21 Oct 2021 15:55:09 -0700
Message-Id: <20211021225527.10184-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The upcoming prctl() which is required to request the permission for a
dynamically enabled feature will also provide an option to retrieve the
supported features. If the CPU does not support xsave the supported
features would be 0 even when the CPU supports FP and SSE.

Provide separate storage for the legacy feature set to avoid that and fill
in the bits in the legacy init function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/include/asm/fpu/types.h | 7 +++++++
 arch/x86/kernel/fpu/init.c       | 9 ++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index d8b59e45dc25..d27ad4842fa1 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -500,6 +500,13 @@ struct fpu_state_config {
 	 * be requested by user space before usage.
 	 */
 	u64 default_features;
+	/*
+	 * @legacy_features:
+	 *
+	 * Features which can be reported back to user space
+	 * even without XSAVE support, i.e. legacy features FP + SSE
+	 */
+	u64 legacy_features;
 };
 
 /* FPU state configuration information */
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 7074154131e6..621f4b6cac4a 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -193,12 +193,15 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	 * Note that the size configuration might be overwritten later
 	 * during fpu__init_system_xstate().
 	 */
-	if (!cpu_feature_enabled(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
 		size = sizeof(struct swregs_state);
-	else if (cpu_feature_enabled(X86_FEATURE_FXSR))
+	} else if (cpu_feature_enabled(X86_FEATURE_FXSR)) {
 		size = sizeof(struct fxregs_state);
-	else
+		fpu_user_cfg.legacy_features = XFEATURE_MASK_FPSSE;
+	} else {
 		size = sizeof(struct fregs_state);
+		fpu_user_cfg.legacy_features = XFEATURE_MASK_FP;
+	}
 
 	fpu_kernel_cfg.max_size = size;
 	fpu_kernel_cfg.default_size = size;
-- 
2.17.1

