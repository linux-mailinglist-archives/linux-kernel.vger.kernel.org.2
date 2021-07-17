Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1683CC424
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhGQPia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:38:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:24186 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234926AbhGQPiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:38:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="210853830"
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="210853830"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2021 08:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="631386996"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2021 08:35:05 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v8 08/26] x86/fpu/xstate: Introduce helpers to manage the XSTATE buffer dynamically
Date:   Sat, 17 Jul 2021 08:28:45 -0700
Message-Id: <20210717152903.7651-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210717152903.7651-1-chang.seok.bae@intel.com>
References: <20210717152903.7651-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static XSTATE per-task buffer contains the extended register states --
but it is not expandable at runtime. Introduce runtime methods and a new
fpu struct field to support the expansion.

fpu->state_mask indicates which state components are reserved to be
saved in the XSTATE buffer.

alloc_xstate_buffer() uses vzalloc(). If use of this mechanism grows to
allocate buffers larger than 64KB, a more sophisticated allocation scheme
that includes purpose-built reclaim capability might be justified.

Introduce a new helper -- get_xstate_size() to calculate the buffer size.

Also, use the new field and helper to initialize the buffer.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Added to ensure XSAVES format with current in fpu_reset_fpstate() for new
  base code.

Changes from v3:
* Updated code comments. (Borislav Petkov)
* Used vzalloc() instead of vmalloc() with memset(). (Borislav Petkov)
* Removed the max size check for >64KB. (Borislav Petkov)
* Removed the allocation size check in the helper. (Borislav Petkov)
* Switched the function description in the kernel-doc style.
* Used them for buffer initialization -- moved from the next patch.

Changes from v2:
* Updated the changelog with task->fpu removed. (Borislav Petkov)
* Replaced 'area' with 'buffer' in the comments and the changelog.
* Updated the code comments.

Changes from v1:
* Removed unneeded interrupt masking (Andy Lutomirski)
* Added vmalloc() error tracing (Dave Hansen, PeterZ, and Andy Lutomirski)
---
 arch/x86/include/asm/fpu/types.h  |   8 ++
 arch/x86/include/asm/fpu/xstate.h |   3 +
 arch/x86/include/asm/trace/fpu.h  |   5 ++
 arch/x86/kernel/fpu/core.c        |  18 +++--
 arch/x86/kernel/fpu/xstate.c      | 127 ++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index c7826708f27f..c0192e16cadb 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -336,6 +336,14 @@ struct fpu {
 	 */
 	unsigned long			avx512_timestamp;
 
+	/*
+	 * @state_mask:
+	 *
+	 * The bitmap represents state components reserved to be saved in
+	 * ->state.
+	 */
+	u64				state_mask;
+
 	/*
 	 * @state:
 	 *
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index d722e774a9f9..45735441fbe8 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -146,6 +146,9 @@ extern unsigned int get_xstate_config(enum xstate_config cfg);
 void set_xstate_config(enum xstate_config cfg, unsigned int value);
 
 void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
+unsigned int get_xstate_size(u64 mask);
+int alloc_xstate_buffer(struct fpu *fpu, u64 mask);
+void free_xstate_buffer(struct fpu *fpu);
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct fpu *fpu, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct fpu *fpu, const void __user *ubuf);
diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index ef82f4824ce7..b691c2db47c7 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -89,6 +89,11 @@ DEFINE_EVENT(x86_fpu, x86_fpu_xstate_check_failed,
 	TP_ARGS(fpu)
 );
 
+DEFINE_EVENT(x86_fpu, x86_fpu_xstate_alloc_failed,
+	TP_PROTO(struct fpu *fpu),
+	TP_ARGS(fpu)
+);
+
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH asm/trace/
 #undef TRACE_INCLUDE_FILE
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 6390562516c9..16abc0357e2e 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -236,9 +236,8 @@ void fpstate_init(struct fpu *fpu)
 
 	if (likely(fpu)) {
 		state = fpu->state;
-		/* The dynamic user states are not prepared yet. */
-		mask = xfeatures_mask_all & ~xfeatures_mask_user_dynamic;
-		size = get_xstate_config(XSTATE_MIN_SIZE);
+		mask = fpu->state_mask;
+		size = get_xstate_size(fpu->state_mask);
 	} else {
 		state = &init_fpstate;
 		mask = xfeatures_mask_all;
@@ -274,14 +273,16 @@ int fpu_clone(struct task_struct *dst)
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return 0;
 
+	/*
+	 * The child does not inherit the dynamic states. Thus, use the
+	 * buffer embedded in struct task_struct, which has the minimum
+	 * size.
+	 */
+	dst_fpu->state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
 	dst_fpu->state = &dst_fpu->__default_state;
-
 	/*
 	 * Don't let 'init optimized' areas of the XSAVE area
 	 * leak into the child task:
-	 *
-	 * The child does not inherit the dynamic states. So,
-	 * the xstate buffer has the minimum size.
 	 */
 	memset(&dst_fpu->state->xsave, 0, get_xstate_config(XSTATE_MIN_SIZE));
 
@@ -380,6 +381,9 @@ static void fpu_reset_fpstate(void)
 	 * flush_thread().
 	 */
 	memcpy(fpu->state, &init_fpstate, init_fpstate_copy_size());
+	/* Adjust the xstate buffer format for current. */
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
+		fpstate_init_xstate(&fpu->state->xsave, fpu->state_mask);
 	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 }
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 5f58dca4c6b7..26f6d5e0f1ed 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -10,6 +10,7 @@
 #include <linux/pkeys.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/vmalloc.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
@@ -19,6 +20,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpufeature.h>
+#include <asm/trace/fpu.h>
 
 /*
  * Although we spell it out in here, the Processor Trace
@@ -76,6 +78,12 @@ static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+/*
+ * True if the buffer of the corresponding XFEATURE is located on the next 64
+ * byte boundary. Otherwise, it follows the preceding component immediately.
+ */
+static bool xstate_aligns[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = false};
 
 /**
  * struct fpu_xstate_buffer_config - xstate buffer configuration
@@ -174,6 +182,55 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
+/**
+ * get_xstate_size - Calculate an xstate buffer size
+ * @mask:	This bitmap tells which components reserved in the buffer.
+ *
+ * Available once those arrays for the offset, size, and alignment info are
+ * set up, by setup_xstate_features().
+ *
+ * Returns:	The buffer size
+ */
+unsigned int get_xstate_size(u64 mask)
+{
+	unsigned int size;
+	int i, nr;
+
+	if (!mask)
+		return 0;
+
+	/*
+	 * The minimum buffer size excludes the dynamic user state. When a
+	 * task uses the state, the buffer can grow up to the max size.
+	 */
+	if (mask == (xfeatures_mask_all & ~xfeatures_mask_user_dynamic))
+		return get_xstate_config(XSTATE_MIN_SIZE);
+	else if (mask == xfeatures_mask_all)
+		return get_xstate_config(XSTATE_MAX_SIZE);
+
+	nr = fls64(mask) - 1;
+
+	if (!boot_cpu_has(X86_FEATURE_XSAVES))
+		return xstate_offsets[nr] + xstate_sizes[nr];
+
+	if ((xfeatures_mask_all & (BIT_ULL(nr + 1) - 1)) == mask)
+		return xstate_comp_offsets[nr] + xstate_sizes[nr];
+
+	/*
+	 * With the given mask, no relevant size is found so far. So,
+	 * calculate it by summing up each state size.
+	 */
+	for (size = FXSAVE_SIZE + XSAVE_HDR_SIZE, i = FIRST_EXTENDED_XFEATURE; i <= nr; i++) {
+		if (!(mask & BIT_ULL(i)))
+			continue;
+
+		if (xstate_aligns[i])
+			size = ALIGN(size, 64);
+		size += xstate_sizes[i];
+	}
+	return size;
+}
+
 /*
  * Enable the extended processor state save/restore feature.
  * Called once per CPU onlining.
@@ -224,10 +281,12 @@ static void __init setup_xstate_features(void)
 	xstate_offsets[XFEATURE_FP]	= 0;
 	xstate_sizes[XFEATURE_FP]	= offsetof(struct fxregs_state,
 						   xmm_space);
+	xstate_aligns[XFEATURE_FP]	= true;
 
 	xstate_offsets[XFEATURE_SSE]	= xstate_sizes[XFEATURE_FP];
 	xstate_sizes[XFEATURE_SSE]	= sizeof_field(struct fxregs_state,
 						       xmm_space);
+	xstate_aligns[XFEATURE_SSE]	= true;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		if (!xfeature_enabled(i))
@@ -245,6 +304,7 @@ static void __init setup_xstate_features(void)
 			continue;
 
 		xstate_offsets[i] = ebx;
+		xstate_aligns[i] = (ecx & 2) ? true : false;
 
 		/*
 		 * In our xstate size checks, we assume that the highest-numbered
@@ -848,6 +908,9 @@ void __init fpu__init_system_xstate(void)
 	if (err)
 		goto out_disable;
 
+	/* Make sure init_task does not include the dynamic user states. */
+	current->thread.fpu.state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
@@ -1038,6 +1101,70 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 }
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+void free_xstate_buffer(struct fpu *fpu)
+{
+	/* Free up only the dynamically-allocated memory. */
+	if (fpu->state != &fpu->__default_state)
+		vfree(fpu->state);
+}
+
+/**
+ * alloc_xstate_buffer - Allocate a buffer with the size calculated from
+ *			 @mask.
+ *
+ * @fpu:	A struct fpu * pointer
+ * @mask:	The bitmap tells which components to be reserved in the new
+ *		buffer.
+ *
+ * Use vmalloc() simply here. If the task with a vmalloc()-allocated buffer
+ * tends to terminate quickly, vfree()-induced IPIs may be a concern.
+ * Caching may be helpful for this. But the task with large state is likely
+ * to live longer.
+ *
+ * Also, this method does not shrink or reclaim the buffer.
+ *
+ * Returns 0 on success, -ENOMEM on allocation error.
+ */
+int alloc_xstate_buffer(struct fpu *fpu, u64 mask)
+{
+	union fpregs_state *state;
+	unsigned int oldsz, newsz;
+	u64 state_mask;
+
+	state_mask = fpu->state_mask | mask;
+
+	oldsz = get_xstate_size(fpu->state_mask);
+	newsz = get_xstate_size(state_mask);
+
+	if (oldsz >= newsz)
+		return 0;
+
+	state = vzalloc(newsz);
+	if (!state) {
+		/*
+		 * When allocation requested from #NM, the error code may
+		 * not be populated well. Then, this tracepoint is useful
+		 * for providing the failure context.
+		 */
+		trace_x86_fpu_xstate_alloc_failed(fpu);
+		return -ENOMEM;
+	}
+
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
+		fpstate_init_xstate(&state->xsave, state_mask);
+
+	/*
+	 * As long as the register state is intact, save the xstate in the
+	 * new buffer at the next context copy/switch or potentially
+	 * ptrace-driven xstate writing.
+	 */
+
+	free_xstate_buffer(fpu);
+	fpu->state = state;
+	fpu->state_mask = state_mask;
+	return 0;
+}
+
 static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 			 void *init_xstate, unsigned int size)
 {
-- 
2.17.1

