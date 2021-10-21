Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE2436DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhJUXH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:58059 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232079AbhJUXHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315380033"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315380033"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033295"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:22 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 07/23] x86/fpu: Add basic helpers for dynamically enabled features
Date:   Thu, 21 Oct 2021 15:55:11 -0700
Message-Id: <20211021225527.10184-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

To allow building up the infrastructure required to support dynamically
enabled FPU features add:

 - XFEATURES_MASK_DYNAMIC

   This constant will hold xfeatures which can be dynamically enabled.

 - fpu_state_size_dynamic()

   A static branch for 64-bit and a simple 'return false' for 32-bit.

   This helper allows to add dynamic feature specific changes to common
   code which is shared between 32-bit and 64-bit without #ifdeffery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Changes from the tglx tree:
* Add the missing #ifdeffery. (Dave Hansen)
---
 arch/x86/include/asm/fpu/xstate.h | 14 ++++++++++++++
 arch/x86/kernel/fpu/core.c        |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 43ae89d4bcd2..023000e79348 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -43,6 +43,9 @@
 #define XFEATURE_MASK_USER_RESTORE	\
 	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
 
+/* Features which are dynamically enabled for a process on request */
+#define XFEATURE_MASK_USER_DYNAMIC	0ULL
+
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
 
@@ -96,4 +99,15 @@ int xfeature_size(int xfeature_nr);
 void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
 
+#ifdef CONFIG_X86_64
+DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
+#endif
+
+static __always_inline __pure bool fpu_state_size_dynamic(void)
+{
+	if (IS_ENABLED(CONFIG_X86_64))
+		return static_branch_unlikely(&__fpu_state_size_dynamic);
+	return false;
+}
+
 #endif
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index eb911c843386..ff7d239fe961 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -25,6 +25,10 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace/fpu.h>
 
+#ifdef CONFIG_X86_64
+DEFINE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
+#endif
+
 /* The FPU state configuration data for kernel and user space */
 struct fpu_state_config	fpu_kernel_cfg __ro_after_init;
 struct fpu_state_config fpu_user_cfg __ro_after_init;
-- 
2.17.1

