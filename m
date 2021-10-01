Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BAA41F7AE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356296AbhJAWsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:48:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:38078 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356232AbhJAWre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:47:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205756685"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="205756685"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565344031"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 15:44:20 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v11 28/29] x86/arch_prctl: ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE
Date:   Fri,  1 Oct 2021 15:37:27 -0700
Message-Id: <20211001223728.9309-29-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_prctl(ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE, u64 *bitmask)
    Return the bitmask of the kernel-supported features. If XSAVE is
    disabled, the bitmask indicates only legacy states.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v9:
* Add as a new patch. (Thiago Macieira and Borislav Petkov)
---
 arch/x86/include/uapi/asm/prctl.h | 23 +++++++++++----------
 arch/x86/kernel/fpu/xstate.c      | 34 ++++++++++++++++++++-----------
 arch/x86/kernel/process.c         |  1 +
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index c73e141ce90a..6912d5fe85f3 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -2,19 +2,20 @@
 #ifndef _ASM_X86_PRCTL_H
 #define _ASM_X86_PRCTL_H
 
-#define ARCH_SET_GS		0x1001
-#define ARCH_SET_FS		0x1002
-#define ARCH_GET_FS		0x1003
-#define ARCH_GET_GS		0x1004
+#define ARCH_SET_GS					0x1001
+#define ARCH_SET_FS					0x1002
+#define ARCH_GET_FS					0x1003
+#define ARCH_GET_GS					0x1004
 
-#define ARCH_GET_CPUID		0x1011
-#define ARCH_SET_CPUID		0x1012
+#define ARCH_GET_CPUID					0x1011
+#define ARCH_SET_CPUID					0x1012
 
-#define ARCH_SET_STATE_ENABLE	0x1021
-#define ARCH_GET_STATE_ENABLE	0x1022
+#define ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE	0x1020
+#define ARCH_SET_STATE_ENABLE				0x1021
+#define ARCH_GET_STATE_ENABLE				0x1022
 
-#define ARCH_MAP_VDSO_X32	0x2001
-#define ARCH_MAP_VDSO_32	0x2002
-#define ARCH_MAP_VDSO_64	0x2003
+#define ARCH_MAP_VDSO_X32				0x2001
+#define ARCH_MAP_VDSO_32				0x2002
+#define ARCH_MAP_VDSO_64				0x2003
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 81566a18643b..75db4def5ec5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1299,6 +1299,24 @@ int realloc_xstate_buffer(struct fpu *fpu, u64 mask)
 	return 0;
 }
 
+/**
+ * get_features_mask_uabi - Get a feature list that the kernel supports
+ * Return:	A bitmap that indicates which state the kernel enabled.
+ */
+static u64 get_features_mask_uabi(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
+		return 0;
+
+	if (use_xsave())
+		return xfeatures_mask_uabi();
+
+	if (use_fxsr())
+		return XFEATURE_MASK_FPSSE;
+
+	return XFEATURE_MASK_FP;
+}
+
 /**
  * reset_state_perm - Reset a task's permission for dynamic user state
  *
@@ -1329,7 +1347,7 @@ void reset_state_perm(struct task_struct *tsk)
 }
 
 /**
- * do_arch_prctl_state - Read or write the state permission.
+ * do_arch_prctl_state - Handle xstate-related buffer or usage control
  * @fpu:	A struct task_struct * pointer
  * @option:	A subfunction of arch_prctl()
  * @arg2:	Either a pointer to userspace memory or state-component
@@ -1338,22 +1356,14 @@ void reset_state_perm(struct task_struct *tsk)
  */
 long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2)
 {
-	u64 features_mask;
-
-	if (!cpu_feature_enabled(X86_FEATURE_FPU))
-		features_mask = 0;
-	else if (use_fxsr())
-		features_mask = XFEATURE_MASK_FPSSE;
-	else
-		features_mask = XFEATURE_MASK_FP;
+	u64 features_mask = get_features_mask_uabi();
 
 	switch (option) {
+	case ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE:
+		return put_user(features_mask, (unsigned long __user *)arg2);
 	case ARCH_SET_STATE_ENABLE: {
 		u64 state_perm = arg2;
 
-		if (use_xsave())
-			features_mask = xfeatures_mask_uabi();
-
 		if (state_perm & ~features_mask)
 			return -EINVAL;
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b43e2b0f52f2..ae53ffd76882 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1023,6 +1023,7 @@ long do_arch_prctl_common(struct task_struct *task, int option,
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
 		return set_cpuid_mode(task, arg2);
+	case ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE:
 	case ARCH_SET_STATE_ENABLE:
 	case ARCH_GET_STATE_ENABLE:
 		return do_arch_prctl_state(task, option, arg2);
-- 
2.17.1

