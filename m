Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED92241F7AC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356205AbhJAWr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:47:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:38094 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356103AbhJAWr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:47:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205756681"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="205756681"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565343998"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 15:44:17 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v11 15/29] x86/arch_prctl: Create ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Date:   Fri,  1 Oct 2021 15:37:14 -0700
Message-Id: <20211001223728.9309-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
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
is found, inform userspace via SIGILL or with error code.

For "dynamic" XSTATE features that have XFD hardware support, the kernel
can enforce that users can not touch state without permission. For state
that has no XFD support, the kernel can not prevent a user from touching
that state.

The notion of granted permission is recorded in the group leader only. A
new task copies its permission bitmask.

Rename the third argument for do_arch_prctl_common() to reflect its generic
use.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v10:
* Expand permission-required states rather than just XFD-protected states.
* Simplify syscall implementation - no functional change.
* Fix the changelog and the comment for ARCH_SET_STATE_ENABLE.

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
 arch/x86/include/asm/fpu/types.h  | 11 +++++
 arch/x86/include/asm/fpu/xstate.h | 35 +++++++++++++
 arch/x86/include/asm/proto.h      |  2 +-
 arch/x86/include/uapi/asm/prctl.h |  3 ++
 arch/x86/kernel/fpu/core.c        |  7 +--
 arch/x86/kernel/fpu/regset.c      | 17 ++++---
 arch/x86/kernel/fpu/xstate.c      | 81 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/process.c         |  7 ++-
 arch/x86/kernel/process_64.c      |  4 ++
 arch/x86/kernel/traps.c           | 35 ++++++++-----
 10 files changed, 175 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 0cc9f6c5a10c..617184b0afec 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -336,6 +336,17 @@ struct fpu {
 	 */
 	unsigned long			avx512_timestamp;
 
+	/*
+	 * @state_perm:
+	 *
+	 * This bitmap indicates the permission for state components.
+	 *
+	 * Always reference group_leader's value via
+	 * get_group_state_perm() as it readily represents the process's
+	 * state permission.
+	 */
+	u64				state_perm;
+
 	/*
 	 * @state_mask:
 	 *
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 9574ee20c6aa..1f62a38e4ae1 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -8,6 +8,7 @@
 #include <asm/processor.h>
 #include <asm/fpu/api.h>
 #include <asm/user.h>
+#include <asm/prctl.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
 #define XFEATURE_MASK_EXTEND	(~(XFEATURE_MASK_FPSSE | (1ULL << 63)))
@@ -35,6 +36,9 @@
 				      XFEATURE_MASK_BNDREGS | \
 				      XFEATURE_MASK_BNDCSR)
 
+/* Require ARCH_SET_STATE_ENABLE for future features  */
+#define XFEATURE_MASK_PERMISSION_REQUIRED GENMASK_ULL(63, XFEATURE_MAX)
+
 /*
  * Features which are restored when returning to user space.
  * PKRU is not restored on return to user space because PKRU
@@ -100,6 +104,11 @@ static inline u64 xfeatures_mask_uabi(void)
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
+static inline u64 xfeatures_mask_user_perm(void)
+{
+	return xfeatures_mask_uabi() & XFEATURE_MASK_PERMISSION_REQUIRED;
+}
+
 /*
  * The xfeatures which are restored by the kernel when returning to user
  * mode. This is not necessarily the same as xfeatures_mask_uabi() as the
@@ -157,6 +166,32 @@ unsigned int calculate_xstate_buf_size_from_mask(u64 mask);
 void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
 int realloc_xstate_buffer(struct fpu *fpu, u64 mask);
 void free_xstate_buffer(union fpregs_state *state);
+
+/**
+ * get_group_state_perm - Get a per-process state permission
+ * @tsk:	A struct task_struct * pointer
+ * Return:	A bitmap to indicate state permission.
+ */
+static inline u64 get_group_state_perm(struct task_struct *tsk)
+{
+	return tsk->group_leader->thread.fpu.state_perm;
+}
+
+/**
+ * state_permitted - Check a task's permission for indicated features.
+ * @tsk:	A struct task_struct * pointer
+ * @state_mask:	A bitmap of queried features
+ * Return:	True if all of the queried features are permitted;
+ *		otherwise, false.
+ */
+static inline bool state_permitted(struct task_struct *tsk, u64 state_mask)
+{
+	return ((state_mask & get_group_state_perm(tsk)) == state_mask);
+}
+
+void reset_state_perm(struct task_struct *tsk);
+long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2);
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
index 164e75c37dbb..b722360d2a85 100644
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
+	dst_fpu->state_perm = get_group_state_perm(current);
 	dst_fpu->state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
 	dst_fpu->state = &dst_fpu->__default_state;
 	/*
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index c57ad37a95fe..14bfbf380015 100644
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
+		if (!state_permitted(target, state_mask)) {
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
index a519fe143adf..38c003f840b4 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -912,7 +912,8 @@ void __init fpu__init_system_xstate(void)
 		if (!(xfeatures_mask_uabi() & feature_mask))
 			continue;
 
-		if (xfeature_supports_xfd(i))
+		/* The kernel needs to mandate the dynamic state. */
+		if (xfeature_supports_xfd(i) && (feature_mask & xfeatures_mask_user_perm()))
 			xfeatures_mask_user_dynamic |= feature_mask;
 	}
 
@@ -927,6 +928,7 @@ void __init fpu__init_system_xstate(void)
 	 * dynamic states.
 	 */
 	current->thread.fpu.state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+	current->thread.fpu.state_perm = (xfeatures_mask_all & ~xfeatures_mask_user_perm());
 
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
@@ -1187,6 +1189,83 @@ int realloc_xstate_buffer(struct fpu *fpu, u64 mask)
 	return 0;
 }
 
+/**
+ * reset_state_perm - Reset a task's permission for dynamic user state
+ *
+ * It is expected to call at exec in which one task runs in a process.
+ *
+ * @task:	A struct task_struct * pointer
+ */
+void reset_state_perm(struct task_struct *tsk)
+{
+	struct fpu *fpu = &tsk->thread.fpu;
+
+	fpu->state_perm = xfeatures_mask_all & ~xfeatures_mask_user_perm();
+
+	if (!xfeatures_mask_user_dynamic ||
+	    !(fpu->state_mask & xfeatures_mask_user_dynamic))
+		return;
+
+	WARN_ON(tsk->signal->nr_threads > 1);
+
+	fpu->state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+	free_xstate_buffer(fpu->state);
+	fpu->state = &fpu->__default_state;
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		fpstate_init_xstate(&fpu->state->xsave, fpu->state_mask);
+
+	wrmsrl_safe(MSR_IA32_XFD,
+		    (fpu->state_mask & xfeatures_mask_user_dynamic) ^
+		    xfeatures_mask_user_dynamic);
+}
+
+/**
+ * do_arch_prctl_state - Read or write the state permission.
+ * @fpu:	A struct task_struct * pointer
+ * @option:	A subfunction of arch_prctl()
+ * @arg2:	Either a pointer to userspace memory or state-component
+ *		bitmap value.
+ * Return:	0 if successful; otherwise, return a relevant error code.
+ */
+long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2)
+{
+	u64 features_mask;
+
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
+		features_mask = 0;
+	else if (use_fxsr())
+		features_mask = XFEATURE_MASK_FPSSE;
+	else
+		features_mask = XFEATURE_MASK_FP;
+
+	switch (option) {
+	case ARCH_SET_STATE_ENABLE: {
+		u64 state_perm = arg2;
+
+		if (use_xsave())
+			features_mask = xfeatures_mask_uabi();
+
+		if (state_perm & ~features_mask)
+			return -EINVAL;
+
+		state_perm &= xfeatures_mask_user_perm();
+		if (!state_perm)
+			return 0;
+
+		tsk->group_leader->thread.fpu.state_perm |= state_perm;
+		return 0;
+	}
+	case ARCH_GET_STATE_ENABLE: {
+		if (use_xsave())
+			features_mask = get_group_state_perm(tsk);
+
+		return put_user(features_mask, (unsigned long __user *)arg2);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
 static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 			 void *init_xstate, unsigned int size)
 {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 7471102e2bed..b43e2b0f52f2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1016,13 +1016,16 @@ unsigned long get_wchan(struct task_struct *p)
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
+	case ARCH_GET_STATE_ENABLE:
+		return do_arch_prctl_state(task, option, arg2);
 	}
 
 	return -EINVAL;
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 41c9855158d6..7aceff54a818 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -678,6 +678,8 @@ void set_personality_64bit(void)
 	   so it's not too bad. The main problem is just that
 	   32bit children are affected again. */
 	current->personality &= ~READ_IMPLIES_EXEC;
+
+	reset_state_perm(current);
 }
 
 static void __set_personality_x32(void)
@@ -723,6 +725,8 @@ void set_personality_ia32(bool x32)
 	/* Make sure to be in 32bit mode */
 	set_thread_flag(TIF_ADDR32);
 
+	reset_state_perm(current);
+
 	if (x32)
 		__set_personality_x32();
 	else
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 08fb461fc3e5..bbf30e73d156 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1108,7 +1108,7 @@ DEFINE_IDTENTRY(exc_spurious_interrupt_bug)
 	 */
 }
 
-static __always_inline bool handle_xfd_event(struct fpu *fpu)
+static __always_inline bool handle_xfd_event(struct fpu *fpu, struct pt_regs *regs)
 {
 	bool handled = false;
 	u64 xfd_err;
@@ -1135,19 +1135,28 @@ static __always_inline bool handle_xfd_event(struct fpu *fpu)
 			int err = -1;
 
 			/*
-			 * Make sure not in interrupt context as handling a
-			 * trap from userspace.
+			 * Make sure that dynamic buffer expansion is permitted
+			 * and not in interrupt context as handling a trap from
+			 * userspace.
+			 *
+			 * Raise SIGILL with insufficient permission and SIGSEGV
+			 * with the buffer allocation failure.
 			 */
-			if (!WARN_ON(in_interrupt())) {
-				err = realloc_xstate_buffer(fpu, xfd_event);
-				if (!err)
-					wrmsrl_safe(MSR_IA32_XFD, (fpu->state_mask &
-								   xfeatures_mask_user_dynamic) ^
-								  xfeatures_mask_user_dynamic);
+			if (!state_permitted(current, xfd_event)) {
+				force_sig_fault(SIGILL, ILL_ILLOPC, error_get_trap_addr(regs));
+			} else {
+				if (!WARN_ON(in_interrupt())) {
+					err = realloc_xstate_buffer(fpu, xfd_event);
+					if (!err)
+						wrmsrl_safe(MSR_IA32_XFD,
+							    (fpu->state_mask &
+							     xfeatures_mask_user_dynamic) ^
+							    xfeatures_mask_user_dynamic);
+				}
+
+				if (err)
+					force_sig(SIGSEGV);
 			}
-
-			if (err)
-				force_sig(SIGSEGV);
 		}
 		handled = true;
 	}
@@ -1158,7 +1167,7 @@ DEFINE_IDTENTRY(exc_device_not_available)
 {
 	unsigned long cr0 = read_cr0();
 
-	if (handle_xfd_event(&current->thread.fpu))
+	if (handle_xfd_event(&current->thread.fpu, regs))
 		return;
 
 #ifdef CONFIG_MATH_EMULATION
-- 
2.17.1

