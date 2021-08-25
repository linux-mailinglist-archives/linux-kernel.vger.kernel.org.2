Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108B93F799D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbhHYQBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:01:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:15524 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241599AbhHYQBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="217271100"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="217271100"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317276"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:44 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 15/28] x86/arch_prctl: Create ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Date:   Wed, 25 Aug 2021 08:54:00 -0700
Message-Id: <20210825155413.19673-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_prctl(ARCH_SET_STATE_ENABLE, u64 bitmask)
    Some XSTATE features, such as AMX, are unavailable to applications
    until that process explicitly requests them via this call. Requests can
    be made for any number of valid user XSTATEs in a single call. This
    call is intended to be invoked very early in process initialization. A
    forked child inherits access, but permission is reset upon exec. There
    is no concept of un-requesting XSTATE access.
    Return codes:
        0: success (including repeated calls)
        EINVAL: no hardware feature for the request

arch_prctl(ARCH_GET_STATE_ENABLE, u64 *bitmask)
    Return the bitmask of permitted user XSTATE features. If XSAVE is
    disabled, the bitmask indicates only legacy states.

The permission is checked at every XSTATE buffer expansion: e.g.
XFD-induced #NM event, and ptracer's XSTATE injection. When no permission
is found, inform userspace via SIGSEGV or with error code.

The notion of granted permission is broadcast to all threads in a process.
But a new task may have a race condition. Reference the group leader's
permission only.

Rename the third argument for do_arch_prctl_common() to reflect its generic
use.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v9:
* Simplify and improve the implementation.
* Use cpu_feature_enabled() instead of boot_cpu_has(). (Borislav Petkov)

Changes from v8:
* Update arch_prctl prototype for consistency with other arch_prctl's. It
  now takes an address of return bitmask as a parameter.
* Optimize the reset function.

Changes from v7:
* Rename the syscalls. (Thiago Macieira and Dave Hansen)
* If XSAVE is disabled, assure that syscall correctly indicates legacy
  states. (Thiago Macieira and Dave Hansen)

Changes from v6:
* Add state bitmap param to proposed syscall. (Thiago Macieira)
* Add companion syscall to return the current permission bitmap.
* Update the ptrace path to return EFAULT when no permission to write
  XTILEDATA.
* Update do_arch_prctl_common().

Changes from v5:
* Switched to per-process permission. (Based on the discussion on LKML)
---
 arch/x86/include/asm/fpu/types.h  | 12 +++++
 arch/x86/include/asm/fpu/xstate.h | 31 ++++++++++++
 arch/x86/include/asm/proto.h      |  2 +-
 arch/x86/include/uapi/asm/prctl.h |  3 ++
 arch/x86/kernel/fpu/core.c        |  7 +--
 arch/x86/kernel/fpu/regset.c      | 17 ++++---
 arch/x86/kernel/fpu/xstate.c      | 83 +++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c         |  8 ++-
 arch/x86/kernel/process_64.c      |  4 ++
 arch/x86/kernel/traps.c           |  8 +--
 10 files changed, 159 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 0cc9f6c5a10c..51acc637ca98 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -336,6 +336,18 @@ struct fpu {
 	 */
 	unsigned long			avx512_timestamp;
 
+	/*
+	 * @state_perm:
+	 *
+	 * This bitmap indicates the permission for dynamic state
+	 * components, which should be the same in a process.
+	 *
+	 * Always reference group_leader's value via
+	 * get_group_dynamic_state_perm() as it readily represents the
+	 * process's state permission.
+	 */
+	u64				dynamic_state_perm;
+
 	/*
 	 * @state_mask:
 	 *
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index cbe19e05b5c9..450537b0b92f 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -157,6 +157,37 @@ unsigned int calculate_xstate_buf_size_from_mask(u64 mask);
 void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
 int realloc_xstate_buffer(struct fpu *fpu, u64 mask);
 void free_xstate_buffer(struct fpu *fpu);
+
+/**
+ * get_group_dynamic_state_perm - Get a per-process dynamic state perm
+ * @tsk:	A struct task_struct * pointer
+ * Return:	A bitmap to indicate which state permission is set.
+ */
+static inline u64 get_group_dynamic_state_perm(struct task_struct *tsk)
+{
+	return tsk->group_leader->thread.fpu.dynamic_state_perm;
+}
+
+/**
+ * dynamic_state_permitted - Check a task's permission for indicated
+ *			     features.
+ * @tsk:	A struct task_struct * pointer
+ * @state_mask:	A bitmap of queried features
+ * Return:	true if all of the queried features are permitted;
+ *		otherwise, false.
+ */
+static inline bool dynamic_state_permitted(struct task_struct *tsk, u64 state_mask)
+{
+	u64 dynamic_state_mask = state_mask & xfeatures_mask_user_dynamic;
+
+	return ((dynamic_state_mask & get_group_dynamic_state_perm(tsk)) ==
+		dynamic_state_mask);
+}
+
+void reset_dynamic_state_perm(struct task_struct *tsk);
+long set_group_state_perm(struct task_struct *tsk, u64 state_perm);
+u64 get_group_state_perm(struct task_struct *tsk);
+
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct fpu *fpu, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct fpu *fpu, const void __user *ubuf);
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 8c5d1910a848..feed36d44d04 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -40,6 +40,6 @@ void x86_report_nx(void);
 extern int reboot_force;
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled);
+			  unsigned long arg2);
 
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 5a6aac9fa41f..c73e141ce90a 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -10,6 +10,9 @@
 #define ARCH_GET_CPUID		0x1011
 #define ARCH_SET_CPUID		0x1012
 
+#define ARCH_SET_STATE_ENABLE	0x1021
+#define ARCH_GET_STATE_ENABLE	0x1022
+
 #define ARCH_MAP_VDSO_X32	0x2001
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 164e75c37dbb..74941a490200 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -274,10 +274,11 @@ int fpu_clone(struct task_struct *dst)
 		return 0;
 
 	/*
-	 * The child does not inherit the dynamic states. Thus, use the
-	 * buffer embedded in struct task_struct, which has the minimum
-	 * size.
+	 * The child does not inherit the dynamic states but permission.
+	 * Use the buffer embedded in struct task_struct, which has the
+	 * minimum size.
 	 */
+	dst_fpu->dynamic_state_perm = get_group_dynamic_state_perm(current);
 	dst_fpu->state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
 	dst_fpu->state = &dst_fpu->__default_state;
 	/*
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index c57ad37a95fe..443500bcbe5f 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -166,7 +166,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	/*
 	 * When a ptracer attempts to write any dynamic user state in the
 	 * target buffer but not sufficiently allocated, it dynamically
-	 * expands the buffer.
+	 * expands the buffer if permitted.
 	 */
 	if (xfeatures_mask_user_dynamic) {
 		u64 state_mask;
@@ -175,13 +175,16 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 		memcpy(&state_mask, (kbuf ?: tmpbuf) + offsetof(struct xregs_state, header),
 		       sizeof(u64));
 
-		/* Expand the xstate buffer based on the XSTATE_BV. */
-		state_mask &= xfeatures_mask_user_dynamic;
-		if (state_mask) {
-			ret = realloc_xstate_buffer(fpu, state_mask);
-			if (ret)
-				goto out;
+		/* Check the permission. */
+		if (!dynamic_state_permitted(target, state_mask)) {
+			ret = -EFAULT;
+			goto out;
 		}
+
+		/* Expand the xstate buffer based on the XSTATE_BV. */
+		ret = realloc_xstate_buffer(fpu, state_mask);
+		if (ret)
+			goto out;
 	}
 
 	fpu_force_restore(fpu);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1bcab5af0a5a..fefa6a139e96 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -925,6 +925,7 @@ void __init fpu__init_system_xstate(void)
 	 * Initially, the FPU buffer used is the static one, without
 	 * dynamic states.
 	 */
+	current->thread.fpu.dynamic_state_perm = 0;
 	current->thread.fpu.state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
 
 	/*
@@ -1186,6 +1187,88 @@ int realloc_xstate_buffer(struct fpu *fpu, u64 mask)
 	return 0;
 }
 
+/**
+ * set_group_state_perm - Set a per-process permission for dynamic user
+ *			  states.
+ * @tsk:	A struct task_struct * pointer
+ * @state_perm:	A bitmap to indicate which state's permission to be set.
+ * Return:	0 if successful; otherwise, error code.
+ */
+long set_group_state_perm(struct task_struct *tsk, u64 state_perm)
+{
+	u64 features_mask;
+
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
+		features_mask = 0;
+	else if (use_xsave())
+		features_mask = xfeatures_mask_uabi();
+	else if (use_fxsr())
+		features_mask = XFEATURE_MASK_FPSSE;
+	else
+		features_mask = XFEATURE_MASK_FP;
+
+	if (state_perm & ~features_mask)
+		return -EINVAL;
+
+	state_perm &= ~(get_group_state_perm(tsk));
+	if (!state_perm)
+		return 0;
+
+	tsk->group_leader->thread.fpu.dynamic_state_perm |= state_perm;
+	return 0;
+}
+
+/**
+ * reset_dynamic_state_perm - Reset a task's permission for dynamic user
+ *			      state
+ *
+ * It is expected to call at exec in which one task runs in a process.
+ *
+ * @task:	A struct task_struct * pointer
+ */
+void reset_dynamic_state_perm(struct task_struct *tsk)
+{
+	struct fpu *fpu = &tsk->thread.fpu;
+
+	if (!xfeatures_mask_user_dynamic ||
+	    !(fpu->state_mask & xfeatures_mask_user_dynamic))
+		return;
+
+	WARN_ON(tsk->signal->nr_threads > 1);
+
+	fpu->state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+	free_xstate_buffer(fpu);
+	fpu->state = &fpu->__default_state;
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		fpstate_init_xstate(&fpu->state->xsave, fpu->state_mask);
+
+	wrmsrl_safe(MSR_IA32_XFD,
+		    (fpu->state_mask & xfeatures_mask_user_dynamic) ^
+		    xfeatures_mask_user_dynamic);
+
+	fpu->dynamic_state_perm = 0;
+}
+
+/**
+ * get_group_state_perm - read the state permission
+ * @tsk:	A struct task_struct * pointer
+ * Return:	A bitmap to indicate which state's permission is set.
+ */
+u64 get_group_state_perm(struct task_struct *tsk)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
+		return 0;
+
+	if (use_xsave())
+		return (xfeatures_mask_uabi() & ~xfeatures_mask_user_dynamic) |
+		       get_group_dynamic_state_perm(tsk);
+
+	if (use_fxsr())
+		return XFEATURE_MASK_FPSSE;
+
+	return XFEATURE_MASK_FP;
+}
+
 static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 			 void *init_xstate, unsigned int size)
 {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 6cd4fb098f8f..beab1bf76d1a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1016,13 +1016,17 @@ unsigned long get_wchan(struct task_struct *p)
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled)
+			  unsigned long arg2)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
-		return set_cpuid_mode(task, cpuid_enabled);
+		return set_cpuid_mode(task, arg2);
+	case ARCH_SET_STATE_ENABLE:
+		return set_group_state_perm(task, arg2);
+	case ARCH_GET_STATE_ENABLE:
+		return put_user(get_group_state_perm(task), (unsigned long __user *)arg2);
 	}
 
 	return -EINVAL;
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 41c9855158d6..020e68d97245 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -678,6 +678,8 @@ void set_personality_64bit(void)
 	   so it's not too bad. The main problem is just that
 	   32bit children are affected again. */
 	current->personality &= ~READ_IMPLIES_EXEC;
+
+	reset_dynamic_state_perm(current);
 }
 
 static void __set_personality_x32(void)
@@ -723,6 +725,8 @@ void set_personality_ia32(bool x32)
 	/* Make sure to be in 32bit mode */
 	set_thread_flag(TIF_ADDR32);
 
+	reset_dynamic_state_perm(current);
+
 	if (x32)
 		__set_personality_x32();
 	else
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 8a608f0e107b..334dd5dc1ed2 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1135,10 +1135,12 @@ static __always_inline bool handle_xfd_event(struct fpu *fpu, struct pt_regs *re
 			int err = -1;
 
 			/*
-			 * Make sure not in interrupt context as handling a
-			 * trap from userspace.
+			 * Make sure that dynamic buffer expansion is permitted
+			 * and not in interrupt context as handling a trap from
+			 * userspace.
 			 */
-			if (!WARN_ON(in_interrupt())) {
+			if (dynamic_state_permitted(current, xfd_event) &&
+			    !WARN_ON(in_interrupt())) {
 				err = realloc_xstate_buffer(fpu, xfd_event);
 				if (!err)
 					wrmsrl_safe(MSR_IA32_XFD, (fpu->state_mask &
-- 
2.17.1

