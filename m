Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6AF3F79B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhHYQDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:03:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:32818 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242131AbhHYQCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:02:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="281267329"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="281267329"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317341"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:48 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 28/28] x86/arch_prctl: ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE
Date:   Wed, 25 Aug 2021 08:54:13 -0700
Message-Id: <20210825155413.19673-29-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
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
 arch/x86/include/asm/fpu/xstate.h |  1 +
 arch/x86/include/uapi/asm/prctl.h | 23 ++++++++---------
 arch/x86/kernel/fpu/xstate.c      | 41 +++++++++++++++++++------------
 arch/x86/kernel/process.c         |  2 ++
 4 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 013478c1aa42..4aa7049cc079 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -194,6 +194,7 @@ static inline bool dynamic_state_permitted(struct task_struct *tsk, u64 state_ma
 }
 
 void reset_dynamic_state_perm(struct task_struct *tsk);
+u64 get_features_mask_uabi(void);
 long set_group_state_perm(struct task_struct *tsk, u64 state_perm);
 u64 get_group_state_perm(struct task_struct *tsk);
 
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
index 2c62872e4fef..6622366d51ae 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1297,6 +1297,25 @@ int realloc_xstate_buffer(struct fpu *fpu, u64 mask)
 	return 0;
 }
 
+/**
+ * get_features_mask_uabi - Get feature list that the kernel supports
+ * Return:	A bitmap to indicate which state is available
+ *
+ */
+u64 get_features_mask_uabi(void)
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
  * set_group_state_perm - Set a per-process permission for dynamic user
  *			  states.
@@ -1306,16 +1325,7 @@ int realloc_xstate_buffer(struct fpu *fpu, u64 mask)
  */
 long set_group_state_perm(struct task_struct *tsk, u64 state_perm)
 {
-	u64 features_mask;
-
-	if (!cpu_feature_enabled(X86_FEATURE_FPU))
-		features_mask = 0;
-	else if (use_xsave())
-		features_mask = xfeatures_mask_uabi();
-	else if (use_fxsr())
-		features_mask = XFEATURE_MASK_FPSSE;
-	else
-		features_mask = XFEATURE_MASK_FP;
+	u64 features_mask = get_features_mask_uabi();
 
 	if (state_perm & ~features_mask)
 		return -EINVAL;
@@ -1365,17 +1375,16 @@ void reset_dynamic_state_perm(struct task_struct *tsk)
  */
 u64 get_group_state_perm(struct task_struct *tsk)
 {
+	u64 mask = get_features_mask_uabi();
+
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return 0;
 
 	if (use_xsave())
-		return (xfeatures_mask_uabi() & ~xfeatures_mask_user_dynamic) |
+		return (mask & ~xfeatures_mask_user_dynamic) |
 		       get_group_dynamic_state_perm(tsk);
-
-	if (use_fxsr())
-		return XFEATURE_MASK_FPSSE;
-
-	return XFEATURE_MASK_FP;
+	else
+		return mask;
 }
 
 static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index beab1bf76d1a..544b0c4f3aed 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1023,6 +1023,8 @@ long do_arch_prctl_common(struct task_struct *task, int option,
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
 		return set_cpuid_mode(task, arg2);
+	case ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE:
+		return put_user(get_features_mask_uabi(), (unsigned long __user *)arg2);
 	case ARCH_SET_STATE_ENABLE:
 		return set_group_state_perm(task, arg2);
 	case ARCH_GET_STATE_ENABLE:
-- 
2.17.1

