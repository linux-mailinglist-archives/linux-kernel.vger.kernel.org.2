Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7753F79A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242109AbhHYQCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:02:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:32696 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241670AbhHYQBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="204685717"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="204685717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317248"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:43 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 09/28] x86/fpu/xstate: Introduce helpers to manage the XSTATE buffer dynamically
Date:   Wed, 25 Aug 2021 08:53:54 -0700
Message-Id: <20210825155413.19673-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static XSTATE per-task buffer contains the extended register states --
but it is not expandable at runtime. Introduce runtime methods and a new
fpu struct field to support the expansion.

fpu->state_mask indicates which state components are to be saved in the
XSTATE buffer.

realloc_xstate_buffer() uses vzalloc(). If use of this mechanism grows to
re-allocate buffers larger than 64KB, a more sophisticated allocation
scheme that includes purpose-built reclaim capability might be justified.

Introduce a new helper -- calculate_xstate_buf_size_from_mask() to
calculate the buffer size.

Also, use the new field and helper to initialize the buffer.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v9:
* Rename and simplify helpers. (Borislav Petkov)
* Add and fix the code comment and the variable name. (Borislav Petkov)
* Use cpu_feature_enabled() instead of boot_cpu_has(). (Borislav Petkov)
* Use fpu->state_mask to ensure states to be written in
  copy_uabi_to_xstate() -- moved from Patch11. (Borislav Petkov)

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
 arch/x86/include/asm/fpu/types.h  |   7 ++
 arch/x86/include/asm/fpu/xstate.h |   3 +
 arch/x86/kernel/fpu/core.c        |  19 +++--
 arch/x86/kernel/fpu/xstate.c      | 123 ++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index ad5cbf922e30..0cc9f6c5a10c 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -336,6 +336,13 @@ struct fpu {
 	 */
 	unsigned long			avx512_timestamp;
 
+	/*
+	 * @state_mask:
+	 *
+	 * The bitmap represents state components to be saved in ->state.
+	 */
+	u64				state_mask;
+
 	/*
 	 * @state:
 	 *
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index c4a0914b7717..cbe19e05b5c9 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -153,7 +153,10 @@ struct fpu_xstate_buffer_config {
 
 extern struct fpu_xstate_buffer_config fpu_buf_cfg;
 
+unsigned int calculate_xstate_buf_size_from_mask(u64 mask);
 void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
+int realloc_xstate_buffer(struct fpu *fpu, u64 mask);
+void free_xstate_buffer(struct fpu *fpu);
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct fpu *fpu, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct fpu *fpu, const void __user *ubuf);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 6b55b8c651f6..2941d03912db 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -236,9 +236,8 @@ void fpstate_init(struct fpu *fpu)
 
 	if (likely(fpu)) {
 		state = fpu->state;
-		/* The dynamic user states are not prepared yet. */
-		mask = xfeatures_mask_all & ~xfeatures_mask_user_dynamic;
-		size = fpu_buf_cfg.min_size;
+		mask = fpu->state_mask;
+		size = calculate_xstate_buf_size_from_mask(fpu->state_mask);
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
 	memset(&dst_fpu->state->xsave, 0, fpu_buf_cfg.min_size);
 
@@ -380,6 +381,10 @@ static void fpu_reset_fpstate(void)
 	 * flush_thread().
 	 */
 	memcpy(fpu->state, &init_fpstate, init_fpstate_copy_size());
+	/* Adjust the xstate buffer format for current. */
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		fpstate_init_xstate(&fpu->state->xsave, fpu->state_mask);
+
 	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 }
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4496750208a8..f56db3f77282 100644
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
+static bool xstate_64byte_aligned[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = false};
 
 struct fpu_xstate_buffer_config fpu_buf_cfg __ro_after_init;
 EXPORT_SYMBOL_GPL(fpu_buf_cfg);
@@ -131,6 +139,58 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
+/**
+ * calculate_xstate_buf_size_from_mask - Calculate an xstate buffer size
+ * @mask:	A bitmap to tell which components to be saved in the buffer.
+ *
+ * Available once those arrays for the offset, size, and alignment info are
+ * set up, by setup_xstate_features().
+ *
+ * Returns:	The buffer size
+ */
+unsigned int calculate_xstate_buf_size_from_mask(u64 mask)
+{
+	unsigned int size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
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
+		return fpu_buf_cfg.min_size;
+	else if (mask == xfeatures_mask_all)
+		return fpu_buf_cfg.max_size;
+
+	nr = fls64(mask) - 1;
+	if (nr < FIRST_EXTENDED_XFEATURE)
+		return size;
+
+	/*
+	 * Each state offset in the non-compacted format is fixed. Take the
+	 * size from the last feature 'nr'.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
+		return xstate_offsets[nr] + xstate_sizes[nr];
+
+	/*
+	 * With the given mask, no relevant size is found so far. So,
+	 * calculate it by summing up each state size.
+	 */
+	for (i = FIRST_EXTENDED_XFEATURE; i <= nr; i++) {
+		if (!(mask & BIT_ULL(i)))
+			continue;
+
+		if (xstate_64byte_aligned[i])
+			size = ALIGN(size, 64);
+		size += xstate_sizes[i];
+	}
+	return size;
+}
+
 /*
  * Enable the extended processor state save/restore feature.
  * Called once per CPU onlining.
@@ -202,6 +262,7 @@ static void __init setup_xstate_features(void)
 			continue;
 
 		xstate_offsets[i] = ebx;
+		xstate_64byte_aligned[i] = (ecx & 2) ? true : false;
 
 		/*
 		 * In our xstate size checks, we assume that the highest-numbered
@@ -805,6 +866,12 @@ void __init fpu__init_system_xstate(void)
 	if (err)
 		goto out_disable;
 
+	/*
+	 * Initially, the FPU buffer used is the static one, without
+	 * dynamic states.
+	 */
+	current->thread.fpu.state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
@@ -995,6 +1062,60 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 }
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+void free_xstate_buffer(struct fpu *fpu)
+{
+	vfree(fpu->state);
+}
+
+/**
+ * realloc_xstate_buffer - Re-alloc a buffer with the size calculated from
+ *			   @mask.
+ *
+ * @fpu:	A struct fpu * pointer
+ * @mask:	The bitmap tells which components to be reserved in the new
+ *		buffer.
+ *
+ * It deals with enlarging the xstate buffer with dynamic states.
+ *
+ * Use vzalloc() simply here. If the task with a vzalloc()-allocated buffer
+ * tends to terminate quickly, vfree()-induced IPIs may be a concern.
+ * Caching may be helpful for this. But the task with large state is likely
+ * to live longer.
+ *
+ * Also, this method does not shrink or reclaim the buffer.
+ *
+ * Returns 0 on success, -ENOMEM on allocation error.
+ */
+int realloc_xstate_buffer(struct fpu *fpu, u64 mask)
+{
+	union fpregs_state *state;
+	u64 state_mask;
+
+	state_mask = fpu->state_mask | mask;
+	if ((state_mask & fpu->state_mask) == state_mask)
+		return 0;
+
+	state = vzalloc(calculate_xstate_buf_size_from_mask(state_mask));
+	if (!state)
+		return -ENOMEM;
+
+	/*
+	 * As long as the register state is intact, save the xstate in the
+	 * new buffer at the next context switch or ptrace's context
+	 * injection.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		fpstate_init_xstate(&state->xsave, state_mask);
+
+	/* Free the old buffer */
+	if (fpu->state != &fpu->__default_state)
+		free_xstate_buffer(fpu);
+
+	fpu->state = state;
+	fpu->state_mask = state_mask;
+	return 0;
+}
+
 static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 			 void *init_xstate, unsigned int size)
 {
@@ -1147,6 +1268,8 @@ static int copy_uabi_to_xstate(struct fpu *fpu, const void *kbuf,
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
+	hdr.xfeatures &= fpu->state_mask;
+
 	/* Validate MXCSR when any of the related features is in use */
 	mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
 	if (hdr.xfeatures & mask) {
-- 
2.17.1

