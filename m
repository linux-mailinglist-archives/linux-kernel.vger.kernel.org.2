Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2F33F799B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbhHYQBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:01:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:15545 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241422AbhHYQBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="217271089"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="217271089"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317226"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:42 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 05/28] x86/fpu/xstate: Add a new variable to indicate dynamic user states
Date:   Wed, 25 Aug 2021 08:53:50 -0700
Message-Id: <20210825155413.19673-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XSTATE per-task buffer is in preparation to be dynamic for user states.
Introduce a new mask variable to indicate the 'dynamic' user states. The
value is determined at boot-time.

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Made the variable __ro_after_init.
* Dropped the perf's xstate buffer renaming, as renamed already.

Changes from v3:
* Updated the changelog. (Borislav Petkov)
* Updated the code comment. (Borislav Petkov)

Changes from v2:
* Updated the changelog for clarification.
---
 arch/x86/include/asm/fpu/xstate.h | 2 ++
 arch/x86/kernel/fpu/xstate.c      | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 2451bccc6cac..bc4cba62906b 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -129,6 +129,8 @@ static inline u64 xfeatures_mask_independent(void)
 	return XFEATURE_MASK_INDEPENDENT;
 }
 
+extern u64 xfeatures_mask_user_dynamic;
+
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0a59df0c48e7..6a658ef913bd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -62,6 +62,12 @@ static short xsave_cpuid_features[] __initdata = {
 u64 xfeatures_mask_all __ro_after_init;
 EXPORT_SYMBOL_GPL(xfeatures_mask_all);
 
+/*
+ * This represents user xstates, a subset of xfeatures_mask_all, saved in a
+ * dynamic kernel XSAVE buffer.
+ */
+u64 xfeatures_mask_user_dynamic __ro_after_init;
+
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
@@ -709,6 +715,7 @@ static int __init init_xstate_size(void)
 static void fpu__init_disable_system_xstate(void)
 {
 	xfeatures_mask_all = 0;
+	xfeatures_mask_user_dynamic = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 }
@@ -780,6 +787,8 @@ void __init fpu__init_system_xstate(void)
 
 	/* Store it for paranoia check at the end */
 	xfeatures = xfeatures_mask_all;
+	/* Do not support the dynamically allocated buffer yet. */
+	xfeatures_mask_user_dynamic = 0;
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
-- 
2.17.1

