Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C0338DCBB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhEWTlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:41:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:31996 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhEWTj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:57 -0400
IronPort-SDR: WXsJK0CTvuo55Immt8lsOXZeBKJpoOyzWUFqXswShg8/YDddUxjeAcVSw8XHCohokydbfrW9LS
 IYGpJjeOQNAw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198740684"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198740684"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:28 -0700
IronPort-SDR: 2XUdIKtNfTMb2crYlx8G05AN0mmuX+cYJo7vEEhczEkhXvIrlz3sPndpT2diCxW/mTnwt+2Jor
 hLGum87+HR9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467103"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of dynamic user state
Date:   Sun, 23 May 2021 12:32:45 -0700
Message-Id: <20210523193259.26200-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's Extended Feature Disable (XFD) feature is an extension of the XSAVE
architecture. XFD allows the kernel to enable a feature state in XCR0 and
to receive a #NM trap when a task uses instructions accessing that state.
In this way, Linux can control the access to that state.

XFD introduces two MSRs: IA32_XFD to enable/disable the feature and
IA32_XFD_ERR to assist the #NM trap handler. Both use the same
xstate-component bitmap format, used by XCR0.

Use XFD to detect unauthorized xstate access and raise a SIGSEGV.

Introduce helper functions:
    xfd_write()   - write IA32_XFD MSR
    xfd_read()    - read IA32_XFD MSR
    xfd_switch()  - switch IA32_XFD MSR
    xfd_capable() - indicate XFD-capable features

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v4:
* Changed to use XFD to support the access request policy. Updated #NM
  handler to raise a signal instead of buffer allocation.
* Updated helper functions.
* Updated function descriptions in a proper format.
* Updated some code comments.

Changes from v3:
* Removed 'no functional change' in the changelog. (Borislav Petkov)

Changes from v2:
* Changed to enable XFD only when the compacted format is used.
* Updated the changelog with task->fpu removed. (Borislav Petkov)

Changes from v1:
* Inlined the XFD-induced #NM handling code (Andy Lutomirski)
---
 arch/x86/include/asm/cpufeatures.h  |  1 +
 arch/x86/include/asm/fpu/internal.h | 45 ++++++++++++++++++++++++++++-
 arch/x86/include/asm/msr-index.h    |  2 ++
 arch/x86/kernel/cpu/cpuid-deps.c    |  1 +
 arch/x86/kernel/fpu/xstate.c        | 45 +++++++++++++++++++++++++++--
 arch/x86/kernel/process_32.c        |  2 +-
 arch/x86/kernel/process_64.c        |  2 +-
 arch/x86/kernel/traps.c             | 12 ++++++++
 8 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ac37830ae941..67a9e5282128 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -277,6 +277,7 @@
 #define X86_FEATURE_XSAVEC		(10*32+ 1) /* XSAVEC instruction */
 #define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX = 1 instruction */
 #define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
+#define X86_FEATURE_XFD			(10*32+ 4) /* eXtended Feature Disabling */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index f964f3efc92e..c250216320df 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -557,11 +557,52 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  * Misc helper functions:
  */
 
+/* The Extended Feature Disable (XFD) helpers: */
+
+static inline void xfd_write(u64 value)
+{
+	wrmsrl_safe(MSR_IA32_XFD, value);
+}
+
+static inline u64 xfd_read(void)
+{
+	u64 value;
+
+	rdmsrl_safe(MSR_IA32_XFD, &value);
+	return value;
+}
+
+static inline u64 xfd_capable(void)
+{
+	return xfeatures_mask_user_dynamic;
+}
+
+/**
+ * xfd_switch() - Switches the MSR IA32_XFD context if needed.
+ * @prev:	The previous task's struct fpu pointer
+ * @next:	The next task's struct fpu pointer
+ *
+ * Returns:	Nothing
+ */
+static inline void xfd_switch(struct fpu *prev, struct fpu *next)
+{
+	u64 prev_xfd_mask, next_xfd_mask;
+
+	if (!static_cpu_has(X86_FEATURE_XFD) || !xfd_capable())
+		return;
+
+	prev_xfd_mask = prev->state_mask & xfd_capable();
+	next_xfd_mask = next->state_mask & xfd_capable();
+
+	if (unlikely(prev_xfd_mask != next_xfd_mask))
+		xfd_write(xfd_capable() ^ next_xfd_mask);
+}
+
 /*
  * Load PKRU from the FPU context if available. Delay loading of the
  * complete FPU state until the return to userland.
  */
-static inline void switch_fpu_finish(struct fpu *new_fpu)
+static inline void switch_fpu_finish(struct fpu *old_fpu, struct fpu *new_fpu)
 {
 	u32 pkru_val = init_pkru_value;
 	struct pkru_state *pk;
@@ -571,6 +612,8 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 
 	set_thread_flag(TIF_NEED_FPU_LOAD);
 
+	xfd_switch(old_fpu, new_fpu);
+
 	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return;
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 211ba3375ee9..f9f92ab71fc1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -626,6 +626,8 @@
 #define MSR_IA32_BNDCFGS_RSVD		0x00000ffc
 
 #define MSR_IA32_XSS			0x00000da0
+#define MSR_IA32_XFD			0x000001c4
+#define MSR_IA32_XFD_ERR		0x000001c5
 
 #define MSR_IA32_APICBASE		0x0000001b
 #define MSR_IA32_APICBASE_BSP		(1<<8)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index defda61f372d..7f891d2eb52e 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -75,6 +75,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
+	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVE     },
 	{}
 };
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 299373669a5d..e60a20a1b24b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -175,6 +175,26 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
+/**
+ * xfd_supported() - Check if the feature supports Extended Feature Disable (XFD).
+ * @feature_nr:	The feature number.
+ *
+ * Returns:	Nothing
+ */
+static bool xfd_supported(int feature_nr)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (!boot_cpu_has(X86_FEATURE_XFD))
+		return false;
+
+	/*
+	 * If state component 'i' supports XFD, ECX[2] return 1; otherwise, 0.
+	 */
+	cpuid_count(XSTATE_CPUID, feature_nr, &eax, &ebx, &ecx, &edx);
+	return ecx & 4;
+}
+
 /**
  * get_xstate_comp_offset() - Find the feature's offset in the compacted format
  * @mask:	This bitmap tells which components reserved in the format.
@@ -366,6 +386,9 @@ void fpu__init_cpu_xstate(void)
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
 				     xfeatures_mask_supervisor_dynamic());
 	}
+
+	if (boot_cpu_has(X86_FEATURE_XFD))
+		xfd_write(xfd_capable());
 }
 
 static bool xfeature_enabled(enum xfeature xfeature)
@@ -565,8 +588,9 @@ static void __init print_xstate_offset_size(void)
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		if (!xfeature_enabled(i))
 			continue;
-		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
-			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
+		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d (%s)\n",
+			i, xstate_comp_offsets[i], i, xstate_sizes[i],
+			(xfeatures_mask_user_dynamic & BIT_ULL(i)) ? "dynamic" : "default");
 	}
 }
 
@@ -999,9 +1023,18 @@ void __init fpu__init_system_xstate(void)
 	}
 
 	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
-	/* Do not support the dynamically allocated buffer yet. */
 	xfeatures_mask_user_dynamic = 0;
 
+	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		u64 feature_mask = BIT_ULL(i);
+
+		if (!(xfeatures_mask_user() & feature_mask))
+			continue;
+
+		if (xfd_supported(i))
+			xfeatures_mask_user_dynamic |= feature_mask;
+	}
+
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
 	err = init_xstate_size();
@@ -1053,6 +1086,12 @@ void fpu__resume_cpu(void)
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
 				     xfeatures_mask_supervisor_dynamic());
 	}
+
+	if (boot_cpu_has(X86_FEATURE_XFD)) {
+		u64 fpu_xfd_mask = current->thread.fpu.state_mask & xfd_capable();
+
+		xfd_write(xfd_capable() ^ fpu_xfd_mask);
+	}
 }
 
 /**
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4f2f54e1281c..7bd5d08eeb41 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -213,7 +213,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	this_cpu_write(current_task, next_p);
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish(prev_fpu, next_fpu);
 
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d08307df69ad..5375a869f3f3 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -594,7 +594,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish(prev_fpu, next_fpu);
 
 	/* Reload sp0. */
 	update_task_stack(next_p);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 853ea7a80806..7482448fcdca 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1111,6 +1111,18 @@ DEFINE_IDTENTRY(exc_device_not_available)
 {
 	unsigned long cr0 = read_cr0();
 
+	if (boot_cpu_has(X86_FEATURE_XFD)) {
+		u64 event_mask;
+
+		rdmsrl_safe(MSR_IA32_XFD_ERR, &event_mask);
+		wrmsrl_safe(MSR_IA32_XFD_ERR, 0);
+
+		if (event_mask) {
+			force_sig(SIGSEGV);
+			return;
+		}
+	}
+
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
-- 
2.17.1

