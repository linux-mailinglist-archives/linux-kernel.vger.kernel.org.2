Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92C3C34A6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 15:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhGJNM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 09:12:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:52358 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhGJNL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 09:11:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="209867335"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="209867335"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 06:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="488742430"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2021 06:09:10 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v7 26/26] x86/fpu/xstate: Add a sanity check for XFD state when saving XSTATE
Date:   Sat, 10 Jul 2021 06:03:13 -0700
Message-Id: <20210710130313.5072-27-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210710130313.5072-1-chang.seok.bae@intel.com>
References: <20210710130313.5072-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DEBUG sanity check that XFD state matches with XINUSE state.

Instead of reading MSR IA32_XFD directly, read a per-cpu value that is
recorded at every MSR write.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Added as a new patch. (Dave Hansen)
---
 arch/x86/include/asm/fpu/internal.h | 15 +++++++++++++++
 arch/x86/kernel/fpu/core.c          | 13 +++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index c9f1573f3ff8..1b3062d5f5a0 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -570,10 +570,25 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 
 /* The Extended Feature Disable (XFD) helpers: */
 
+#ifdef CONFIG_X86_DEBUG_FPU
+DECLARE_PER_CPU(u64, xfd_shadow);
+static inline u64 xfd_debug_shadow(void)
+{
+	return this_cpu_read(xfd_shadow);
+}
+
+static inline void xfd_write(u64 value)
+{
+	wrmsrl_safe(MSR_IA32_XFD, value);
+	this_cpu_write(xfd_shadow, value);
+}
+#else
+#define xfd_debug_shadow()	0
 static inline void xfd_write(u64 value)
 {
 	wrmsrl_safe(MSR_IA32_XFD, value);
 }
+#endif
 
 static inline u64 xfd_read(void)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index e8912b5b9369..1b1306488fb6 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -82,6 +82,10 @@ bool irq_fpu_usable(void)
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
+#ifdef CONFIG_X86_DEBUG_FPU
+DEFINE_PER_CPU(u64, xfd_shadow);
+#endif
+
 /*
  * Save the FPU register state in fpu->state. The register state is
  * preserved.
@@ -99,6 +103,15 @@ EXPORT_SYMBOL(irq_fpu_usable);
 void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
+		/*
+		 * If XFD is armed for an xfeature, XSAVE* will not save
+		 * its state. Verify XFD is clear for all features that
+		 * are in use before XSAVE*.
+		 */
+		if (IS_ENABLED(CONFIG_X86_DEBUG_FPU) && xfd_capable() &&
+		    boot_cpu_has(X86_FEATURE_XGETBV1))
+			WARN_ON_FPU(xgetbv(1) & xfd_debug_shadow());
+
 		os_xsave(&fpu->state->xsave, fpu->state_mask);
 
 		/*
-- 
2.17.1

