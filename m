Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBCD41F7B1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356225AbhJAWsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:48:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:38076 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355831AbhJAWry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:47:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205756686"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="205756686"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565344032"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 15:44:21 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v11 29/29] x86/arch_prctl: ARCH_SET_STATE_ENABLE_ALLOC
Date:   Fri,  1 Oct 2021 15:37:28 -0700
Message-Id: <20211001223728.9309-30-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_prctl(ARCH_SET_STATE_ENABLE, u64 bitmask, ARCH_SET_STATE_ENABLE_ALLOC)
    ARCH_SET_STATE_ENABLE_ALLOC causes the kernel to synchronously allocate
    XSTATE for the current process for the state specified by the given
    bitmask. ARCH_SET_STATE_ENABLE users may optionally ask the kernel to
    allocate enough XSTATE buffer for the requested states by specifying
    ARCH_SET_STATE_ENABLE_ALLOC in the 3rd parameter. ARCH_SET_STATE_ENABLE
    must be successful to return success. If the kernel has an allocation
    failure in this call, no buffers are allocated, no permission is
    granted, and the system call returns an error.
    Return codes:
        0: success (including repeated calls)
        ENOMEM: memory allocation failure

The buffers are pre-allocated and saved in the state field of struct
fpu_prealloc to prevent a race with context switch use of the buffers.
Context switch (or XFD trap) check for pre-allocated buffers and actually
install the struct fpu_prealloc's state pointer.

This allocation attribute is represented in a new thread flag --
TIF_FPU_PREALLOC. The code always references the group leader's to limit
race conditions.

Expand the arch_prctl prototype to receive this option.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v10:
* New patch: add static allocation feature flag:
  ARCH_SET_STATE_ENABLE_ALLOC. (Thomas Gleixner)
---
 arch/x86/include/asm/fpu/internal.h |   2 +
 arch/x86/include/asm/fpu/types.h    |  23 +++++
 arch/x86/include/asm/fpu/xstate.h   |   5 +-
 arch/x86/include/asm/proto.h        |   2 +-
 arch/x86/include/asm/thread_info.h  |   3 +
 arch/x86/include/uapi/asm/prctl.h   |   1 +
 arch/x86/kernel/fpu/core.c          |  29 ++++--
 arch/x86/kernel/fpu/regset.c        |   3 +
 arch/x86/kernel/fpu/xstate.c        | 148 +++++++++++++++++++++++++---
 arch/x86/kernel/process.c           |   5 +-
 arch/x86/kernel/process_32.c        |   5 +-
 arch/x86/kernel/process_64.c        |  10 +-
 arch/x86/kernel/traps.c             |   3 +
 13 files changed, 207 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 1129abc6ae06..20ebbcfeb2a0 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -537,6 +537,8 @@ static inline void fpregs_restore_userregs(void)
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
+		if (old_fpu->prealloc.state)
+			activate_xstate_prealloc_buffer(old_fpu);
 		save_fpregs_to_fpstate(old_fpu);
 		/*
 		 * The save operation preserved register state, so the
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 1e0a6f73d8a9..ebbb33f6500a 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -336,6 +336,21 @@ union fpregs_state {
 	u8 __padding[PAGE_SIZE];
 };
 
+/**
+ * struct fpu_prealloc - Records a new buffer, that is pre-allocated
+ *			 remotely, which the owner picks at the context
+ *			 switch or at the buffer expansion.
+ * @lock:		A spinlock to orderly update the preallocation
+ * @state:		A pointer to the new buffer.
+ * @mask:		A state mask to indicate which state component to
+ *			be saved in the new buffer.
+ */
+struct fpu_prealloc {
+	spinlock_t			lock;
+	union fpregs_state		*state;
+	u64				mask;
+};
+
 /*
  * Highest level per task FPU state data structure that
  * contains the FPU register state plus various FPU
@@ -399,6 +414,14 @@ struct fpu {
 	 */
 	union fpregs_state		*state;
 
+	/*
+	 * @prealloc:
+	 *
+	 * Pre-allocated memory by ARCH_SET_STATE_ENABLE_ALLOC. A task may
+	 * check this and use on next context switch.
+	 */
+	struct fpu_prealloc		prealloc;
+
 	/*
 	 * @__default_state:
 	 *
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 0b337e913423..152bfe4939cd 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -174,8 +174,10 @@ extern struct fpu_xstate_buffer_config fpu_buf_cfg;
 
 unsigned int calculate_xstate_buf_size_from_mask(u64 mask);
 void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
+union fpregs_state *alloc_xstate_buffer(unsigned int size);
 int realloc_xstate_buffer(struct fpu *fpu, u64 mask);
 void free_xstate_buffer(union fpregs_state *state);
+void activate_xstate_prealloc_buffer(struct fpu *fpu);
 
 /**
  * get_group_state_perm - Get a per-process state permission
@@ -217,7 +219,8 @@ static inline bool sig_xstate_expanded(struct task_struct *tsk)
 extern bool arch_enough_sigaltstack(struct task_struct *tsk, size_t ss_size);
 
 void reset_state_perm(struct task_struct *tsk);
-long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2);
+long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2,
+			 unsigned long arg3);
 
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct fpu *fpu, const void *kbuf);
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index feed36d44d04..83a77fc85e44 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -40,6 +40,6 @@ void x86_report_nx(void);
 extern int reboot_force;
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long arg2);
+			  unsigned long arg2, unsigned long arg3);
 
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index cf132663c219..ba9e83d6da08 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -97,6 +97,8 @@ struct thread_info {
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
+#define TIF_FPU_PREALLOC	28	/* FPU buffer can be preallocated. */
+					/* Always reference group_leader's value, not each task's */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
@@ -120,6 +122,7 @@ struct thread_info {
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
+#define _TIF_FPU_PREALLOC	(1 << TIF_FPU_PREALLOC)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
 
 /* flags to check in __switch_to() */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 6912d5fe85f3..7fc9f161b93d 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -12,6 +12,7 @@
 
 #define ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE	0x1020
 #define ARCH_SET_STATE_ENABLE				0x1021
+# define ARCH_SET_STATE_ENABLE_ALLOC			1
 #define ARCH_GET_STATE_ENABLE				0x1022
 
 #define ARCH_MAP_VDSO_X32				0x2001
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index be6c210c00d4..d55d80c2e194 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -279,6 +279,7 @@ int fpu_clone(struct task_struct *dst)
 {
 	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
+	unsigned int size;
 
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
@@ -288,17 +289,33 @@ int fpu_clone(struct task_struct *dst)
 
 	/*
 	 * The child does not inherit the dynamic states but permission.
-	 * Use the buffer embedded in struct task_struct, which has the
-	 * minimum size.
+	 * Expand the buffer enough for the permitted features if allowed.
+	 * Otherwise, use the buffer embedded in struct task_struct, which
+	 * has the minimum size.
 	 */
 	dst_fpu->state_perm = get_group_state_perm(current);
-	dst_fpu->state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
-	dst_fpu->state = &dst_fpu->__default_state;
+	if (test_tsk_thread_flag(current->group_leader, TIF_FPU_PREALLOC)) {
+		size = calculate_xstate_buf_size_from_mask(dst_fpu->state_perm);
+		dst_fpu->state = alloc_xstate_buffer(size);
+		if (!dst_fpu->state)
+			return -ENOMEM;
+		dst_fpu->state_mask = dst_fpu->state_perm;
+		set_tsk_thread_flag(dst, TIF_FPU_PREALLOC);
+	} else {
+		size = fpu_buf_cfg.min_size;
+		dst_fpu->state = &dst_fpu->__default_state;
+		dst_fpu->state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+		clear_tsk_thread_flag(dst, TIF_FPU_PREALLOC);
+	}
 	/*
 	 * Don't let 'init optimized' areas of the XSAVE area
 	 * leak into the child task:
 	 */
-	memset(&dst_fpu->state->xsave, 0, fpu_buf_cfg.min_size);
+	memset(&dst_fpu->state->xsave, 0, size);
+
+	spin_lock_init(&dst_fpu->prealloc.lock);
+	dst_fpu->prealloc.state = NULL;
+	dst_fpu->prealloc.mask = 0;
 
 	/*
 	 * If the FPU registers are not owned by current just memcpy() the
@@ -307,7 +324,7 @@ int fpu_clone(struct task_struct *dst)
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		memcpy(dst_fpu->state, src_fpu->state, fpu_buf_cfg.min_size);
+		memcpy(dst_fpu->state, src_fpu->state, size);
 
 	else
 		save_fpregs_to_fpstate(dst_fpu);
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 14bfbf380015..3d1131bde10d 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -181,6 +181,9 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 			goto out;
 		}
 
+		if (fpu->prealloc.state)
+			activate_xstate_prealloc_buffer(fpu);
+
 		/* Expand the xstate buffer based on the XSTATE_BV. */
 		ret = realloc_xstate_buffer(fpu, state_mask);
 		if (ret)
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 75db4def5ec5..03dc576792a2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1251,14 +1251,9 @@ void free_xstate_buffer(union fpregs_state *state)
 }
 
 /**
- * realloc_xstate_buffer - Re-alloc a buffer with the size calculated from
- *			   @mask.
+ * alloc_xstate_buffer - Allocate an xstate buffer with the given size
  *
- * @fpu:	A struct fpu * pointer
- * @mask:	The bitmap tells which components to be saved in the new
- *		buffer.
- *
- * It deals with enlarging the xstate buffer with dynamic states.
+ * @size:	The memory size to be allocated
  *
  * Use vzalloc() simply here. If the task with a vzalloc()-allocated buffer
  * tends to terminate quickly, vfree()-induced IPIs may be a concern.
@@ -1267,23 +1262,41 @@ void free_xstate_buffer(union fpregs_state *state)
  *
  * Also, this method does not shrink or reclaim the buffer.
  *
+ * Returns a pointer to the new buffer.
+ */
+union fpregs_state *alloc_xstate_buffer(unsigned int size)
+{
+	return vzalloc(size);
+}
+
+/**
+ * realloc_xstate_buffer - Re-allocate a buffer with the size calculated
+ *			   from @mask
+ *
+ * It deals with enlarging the xstate buffer with dynamic states.
+ *
+ * @fpu:	A struct fpu * pointer
+ * @mask:	The bitmap tells which components to be saved in the new
+ *		buffer.
  * Returns 0 on success, -ENOMEM on allocation error.
  */
 int realloc_xstate_buffer(struct fpu *fpu, u64 mask)
 {
 	union fpregs_state *state;
-	u64 state_mask;
+	unsigned int size;
 
-	state_mask = fpu->state_mask | mask;
-	if ((state_mask & fpu->state_mask) == state_mask)
+	if ((mask & fpu->state_mask) == mask)
 		return 0;
 
-	state = vzalloc(calculate_xstate_buf_size_from_mask(state_mask));
+	mask |= fpu->state_mask;
+	size = calculate_xstate_buf_size_from_mask(mask);
+
+	state = alloc_xstate_buffer(size);
 	if (!state)
 		return -ENOMEM;
 
 	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
-		fpstate_init_xstate(&state->xsave, state_mask);
+		fpstate_init_xstate(&state->xsave, mask);
 
 	/* Free the old buffer */
 	if (fpu->state != &fpu->__default_state)
@@ -1295,10 +1308,81 @@ int realloc_xstate_buffer(struct fpu *fpu, u64 mask)
 	 * injection.
 	 */
 	fpu->state = state;
-	fpu->state_mask = state_mask;
+	fpu->state_mask = mask;
+	return 0;
+}
+
+/**
+ * prealloc_xstate_buffer - Pre-allocate a buffer with the size calculated
+ *			    from @mask
+ *
+ * The pre-allocation is recorded in @task->thread.fpu.prealloc and will be
+ * used later. The caller is expected to lock the fiels in struct
+ * fpu_prealloc.
+ *
+ * @task:	A struct fpu * pointer
+ * @mask:	The bitmap tells which components to be saved in the new
+ *		buffer.
+ * Returns 0 on success, -ENOMEM on allocation error.
+ */
+static int prealloc_xstate_buffer(struct task_struct *tsk, u64 mask)
+{
+	struct fpu *fpu = &tsk->thread.fpu;
+	union fpregs_state *state;
+	unsigned int size;
+
+	mask |= get_group_state_perm(tsk);
+	size = calculate_xstate_buf_size_from_mask(mask);
+
+	state = alloc_xstate_buffer(size);
+	if (!state)
+		return -ENOMEM;
+
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		fpstate_init_xstate(&state->xsave, mask);
+
+	free_xstate_buffer(fpu->prealloc.state);
+	fpu->prealloc.state = state;
+	fpu->prealloc.mask = mask;
 	return 0;
 }
 
+/**
+ * activate_xstate_prealloc_buffer - Activate the preallocated xstate
+ *                                   buffer.
+ *
+ * @fpu:	A struct fpu * pointer
+ */
+void activate_xstate_prealloc_buffer(struct fpu *fpu)
+{
+	spin_lock_irq(&fpu->prealloc.lock);
+
+	if (fpu->state != &fpu->__default_state)
+		free_xstate_buffer(fpu->state);
+
+	fpu->state = fpu->prealloc.state;
+	fpu->state_mask = fpu->prealloc.mask;
+	fpu->prealloc.state = NULL;
+	fpu->prealloc.mask = 0;
+
+	spin_unlock_irq(&fpu->prealloc.lock);
+}
+
+/**
+ * free_xstate_prealloc_buffer - Free up the preallocated buffer
+ *
+ * The caller needs to make sure of locking state and mask fields of struct
+ * fpu_prealloc.
+ *
+ * @fpu:	A struct fpu * pointer
+ */
+static void free_xstate_prealloc_buffer(struct fpu *fpu)
+{
+	free_xstate_buffer(fpu->prealloc.state);
+	fpu->prealloc.state = NULL;
+	fpu->prealloc.mask = 0;
+}
+
 /**
  * get_features_mask_uabi - Get a feature list that the kernel supports
  * Return:	A bitmap that indicates which state the kernel enabled.
@@ -1328,20 +1412,26 @@ void reset_state_perm(struct task_struct *tsk)
 {
 	struct fpu *fpu = &tsk->thread.fpu;
 
+	WARN_ON(tsk->signal->nr_threads > 1);
+
 	fpu->state_perm = xfeatures_mask_all & ~xfeatures_mask_user_perm();
 
+	clear_tsk_thread_flag(tsk, TIF_FPU_PREALLOC);
+
 	if (!xfeatures_mask_user_dynamic ||
 	    !(fpu->state_mask & xfeatures_mask_user_dynamic))
 		return;
 
-	WARN_ON(tsk->signal->nr_threads > 1);
-
 	fpu->state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
 	free_xstate_buffer(fpu->state);
 	fpu->state = &fpu->__default_state;
 	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
 		fpstate_init_xstate(&fpu->state->xsave, fpu->state_mask);
 
+	spin_lock_irq(&fpu->prealloc.lock);
+	free_xstate_prealloc_buffer(fpu);
+	spin_unlock_irq(&fpu->prealloc.lock);
+
 	xfd_write((fpu->state_mask & xfeatures_mask_user_dynamic) ^
 		  xfeatures_mask_user_dynamic);
 }
@@ -1352,9 +1442,11 @@ void reset_state_perm(struct task_struct *tsk)
  * @option:	A subfunction of arch_prctl()
  * @arg2:	Either a pointer to userspace memory or state-component
  *		bitmap value.
+ * @arg3:	A sub-option for ARCH_SET_STATE_ENABLE
  * Return:	0 if successful; otherwise, return a relevant error code.
  */
-long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2)
+long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2,
+			 unsigned long arg3)
 {
 	u64 features_mask = get_features_mask_uabi();
 
@@ -1362,7 +1454,9 @@ long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2
 	case ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE:
 		return put_user(features_mask, (unsigned long __user *)arg2);
 	case ARCH_SET_STATE_ENABLE: {
+		struct task_struct *t;
 		u64 state_perm = arg2;
+		int err = 0;
 
 		if (state_perm & ~features_mask)
 			return -EINVAL;
@@ -1378,7 +1472,29 @@ long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2
 		if (tsk->sas_ss_size > 0 && tsk->sas_ss_size < get_sigframe_size())
 			return -EPERM;
 
+		if (arg3 != ARCH_SET_STATE_ENABLE_ALLOC) {
+			tsk->group_leader->thread.fpu.state_perm |= state_perm;
+			return 0;
+		}
+
+		for_each_thread(tsk, t) {
+			spin_lock_irq(&t->thread.fpu.prealloc.lock);
+			if (!err)
+				err = prealloc_xstate_buffer(t, state_perm);
+		}
+
+		for_each_thread(tsk, t) {
+			if (err)
+				free_xstate_prealloc_buffer(&t->thread.fpu);
+			spin_unlock_irq(&t->thread.fpu.prealloc.lock);
+		}
+
+		if (err)
+			return -ENOMEM;
+
 		tsk->group_leader->thread.fpu.state_perm |= state_perm;
+		set_tsk_thread_flag(tsk->group_leader, TIF_FPU_PREALLOC);
+		activate_xstate_prealloc_buffer(&current->thread.fpu);
 		return 0;
 	}
 	case ARCH_GET_STATE_ENABLE: {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ae53ffd76882..9d07ec5f08f5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -105,6 +105,7 @@ void arch_release_task_struct(struct task_struct *task)
 	/* Free up only the dynamically-allocated memory. */
 	if (task->thread.fpu.state != &task->thread.fpu.__default_state)
 		free_xstate_buffer(task->thread.fpu.state);
+	free_xstate_buffer(task->thread.fpu.prealloc.state);
 }
 
 /*
@@ -1016,7 +1017,7 @@ unsigned long get_wchan(struct task_struct *p)
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long arg2)
+			  unsigned long arg2, unsigned long arg3)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
@@ -1026,7 +1027,7 @@ long do_arch_prctl_common(struct task_struct *task, int option,
 	case ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE:
 	case ARCH_SET_STATE_ENABLE:
 	case ARCH_GET_STATE_ENABLE:
-		return do_arch_prctl_state(task, option, arg2);
+		return do_arch_prctl_state(task, option, arg2, arg3);
 	}
 
 	return -EINVAL;
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 7bd5d08eeb41..41f1410b37f8 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -221,7 +221,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	return prev_p;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+SYSCALL_DEFINE3(arch_prctl, int, option, unsigned long, arg2,
+		unsigned long, arg3)
 {
-	return do_arch_prctl_common(current, option, arg2);
+	return do_arch_prctl_common(current, option, arg2, arg3);
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7aceff54a818..76d23d9ac5c5 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -843,21 +843,23 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	return ret;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+SYSCALL_DEFINE3(arch_prctl, int, option, unsigned long, arg2,
+		unsigned long, arg3)
 {
 	long ret;
 
 	ret = do_arch_prctl_64(current, option, arg2);
 	if (ret == -EINVAL)
-		ret = do_arch_prctl_common(current, option, arg2);
+		ret = do_arch_prctl_common(current, option, arg2, arg3);
 
 	return ret;
 }
 
 #ifdef CONFIG_IA32_EMULATION
-COMPAT_SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+COMPAT_SYSCALL_DEFINE3(arch_prctl, int, option, unsigned long, arg2,
+		       unsigned long, arg3)
 {
-	return do_arch_prctl_common(current, option, arg2);
+	return do_arch_prctl_common(current, option, arg2, arg3);
 }
 #endif
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index cc19b570b322..b0b365084cec 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1145,6 +1145,9 @@ static __always_inline bool handle_xfd_event(struct fpu *fpu, struct pt_regs *re
 			if (!state_permitted(current, xfd_event)) {
 				force_sig_fault(SIGILL, ILL_ILLOPC, error_get_trap_addr(regs));
 			} else {
+				if (fpu->prealloc.state)
+					activate_xstate_prealloc_buffer(fpu);
+
 				if (!WARN_ON(in_interrupt())) {
 					err = realloc_xstate_buffer(fpu, xfd_event);
 					if (!err)
-- 
2.17.1

