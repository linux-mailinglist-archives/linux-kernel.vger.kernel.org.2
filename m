Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1E3DBBA1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbhG3PG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:06:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:52620 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239477AbhG3PGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:06:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="298699127"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="298699127"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 08:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="508154944"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2021 08:06:06 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v9 14/26] x86/arch_prctl: Create ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Date:   Fri, 30 Jul 2021 07:59:45 -0700
Message-Id: <20210730145957.7927-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210730145957.7927-1-chang.seok.bae@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
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
	EBUSY: error in updating all threads in the process

arch_prctl(ARCH_GET_STATE_ENABLE, u64 *bitmask)
    Return the bitmask of permitted user XSTATE features. If XSAVE
    is disabled, the bitmask indicates only legacy states.

The permission is checked at every XSTATE buffer expansion: e.g.
XFD-induced #NM event, and ptracer's XSTATE injection. When no permission
is found, inform userspace via SIGSEGV or with error code.

The notion of granted permission is broadcast to all threads in a process.
(This approach follows the PR_SET_FP_MODE prctl(2) implementation.)

Detect a fork race by aborting and returning -EBUSY if the number of
threads at the end of call changed.

[ An alternative implementation would not save the permission bitmap in
  every task. But instead would extend the per-process signal data, and
  that would not be subject to this race. ]

Rename the third argument for do_arch_prctl_common() to reflect its generic
use.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
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
 arch/x86/include/asm/fpu/types.h  |  8 +++
 arch/x86/include/asm/fpu/xstate.h |  5 ++
 arch/x86/include/asm/proto.h      |  2 +-
 arch/x86/include/uapi/asm/prctl.h |  3 +
 arch/x86/kernel/fpu/regset.c      | 17 ++++--
 arch/x86/kernel/fpu/xstate.c      | 96 +++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c         |  8 ++-
 arch/x86/kernel/process_64.c      |  6 ++
 arch/x86/kernel/traps.c           |  8 ++-
 9 files changed, 141 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index c0192e16cadb..03160a1a79ad 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -336,6 +336,14 @@ struct fpu {
 	 */
 	unsigned long			avx512_timestamp;
 
+	/*
+	 * @state_perm:
+	 *
+	 * The bitmap indicates the permission of using some state
+	 * components which are dynamically stored in the per-task buffer.
+	 */
+	u64				dynamic_state_perm;
+
 	/*
 	 * @state_mask:
 	 *
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 45735441fbe8..9fb6308aaf07 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -149,6 +149,11 @@ void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
 unsigned int get_xstate_size(u64 mask);
 int alloc_xstate_buffer(struct fpu *fpu, u64 mask);
 void free_xstate_buffer(struct fpu *fpu);
+
+long set_process_xstate_perm(struct task_struct *tsk, u64 state_perm);
+void reset_task_xstate_perm(struct task_struct *tsk);
+unsigned long get_task_state_perm(struct task_struct *tsk);
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
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 244e672c3e3d..ee71ffd7c221 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -166,22 +166,27 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	/*
 	 * When a ptracer attempts to write any dynamic user state in the
 	 * target buffer but not sufficiently allocated, it dynamically
-	 * expands the buffer.
+	 * expands the buffer if permitted.
 	 *
 	 * Check if the expansion is possibly needed.
 	 */
 	if (xfeatures_mask_user_dynamic &&
 	    ((fpu->state_mask & xfeatures_mask_user_dynamic) != xfeatures_mask_user_dynamic)) {
-		u64 state_mask;
+		u64 state_mask, dynstate_mask;
 
 		/* Retrieve XSTATE_BV. */
 		memcpy(&state_mask, (kbuf ?: tmpbuf) + offsetof(struct xregs_state, header),
 		       sizeof(u64));
 
-		/* Expand the xstate buffer based on the XSTATE_BV. */
-		state_mask &= xfeatures_mask_user_dynamic;
-		if (state_mask) {
-			ret = alloc_xstate_buffer(fpu, state_mask);
+		/* Check the permission and expand the xstate buffer. */
+		dynstate_mask = state_mask & xfeatures_mask_user_dynamic;
+		if (dynstate_mask) {
+			if ((dynstate_mask & fpu->dynamic_state_perm) != dynstate_mask) {
+				ret = -EFAULT;
+				goto out;
+			}
+
+			ret = alloc_xstate_buffer(fpu, dynstate_mask);
 			if (ret)
 				goto out;
 		}
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c6ff0575d87d..84dda445386e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -961,6 +961,7 @@ void __init fpu__init_system_xstate(void)
 		goto out_disable;
 
 	/* Make sure init_task does not include the dynamic user states. */
+	current->thread.fpu.dynamic_state_perm = 0;
 	current->thread.fpu.state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
 
 	/*
@@ -1233,6 +1234,101 @@ int alloc_xstate_buffer(struct fpu *fpu, u64 mask)
 	return 0;
 }
 
+/**
+ * set_process_xstate_perm - Set a per-process permission to use dynamic
+ *			     user xstates.
+ * @tsk:	A struct task_struct * pointer
+ * @state_perm:	A bitmap to indicate which state's permission to be set.
+ * Return:	0 if successful; otherwise, error code.
+ */
+long set_process_xstate_perm(struct task_struct *tsk, u64 state_perm)
+{
+	u64 req_dynstate_perm, old_dynstate_perm;
+	struct task_struct *t;
+	int nr_threads = 0;
+	u64 features_mask;
+
+	if (!boot_cpu_has(X86_FEATURE_FPU))
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
+	req_dynstate_perm = state_perm & xfeatures_mask_user_dynamic;
+	if (!req_dynstate_perm)
+		return 0;
+
+	old_dynstate_perm = tsk->thread.fpu.dynamic_state_perm;
+
+	for_each_thread(tsk, t) {
+		t->thread.fpu.dynamic_state_perm |= req_dynstate_perm;
+		nr_threads++;
+	}
+
+	if (nr_threads != tsk->signal->nr_threads) {
+		for_each_thread(tsk, t)
+			t->thread.fpu.dynamic_state_perm = old_dynstate_perm;
+		pr_err("x86/fpu: ARCH_XSTATE_PERM failed as thread number mismatched.\n");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+/**
+ * reset_task_xstate_perm - Reset a task's permission to use dynamic user
+ *			    xstates.
+ *
+ * It is expected to call at exec in which one task runs in a process.
+ *
+ * @task:	A struct task_struct * pointer
+ */
+void reset_task_xstate_perm(struct task_struct *tsk)
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
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
+		fpstate_init_xstate(&fpu->state->xsave, fpu->state_mask);
+
+	xfd_write(xfd_capable() ^ (fpu->state_mask & xfd_capable()));
+
+	fpu->dynamic_state_perm = 0;
+}
+
+/**
+ * get_task_state_perm - get the state permission bitmap
+ * @tsk:	A struct task_struct * pointer
+ * Return:	A bitmap to indicate which state's permission is set.
+ */
+unsigned long get_task_state_perm(struct task_struct *tsk)
+{
+	if (!boot_cpu_has(X86_FEATURE_FPU))
+		return 0;
+
+	if (use_xsave())
+		return (xfeatures_mask_uabi() & ~xfeatures_mask_user_dynamic) |
+		       tsk->thread.fpu.dynamic_state_perm;
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
index b85fa499f195..5b4f9b82aea1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1012,13 +1012,17 @@ unsigned long get_wchan(struct task_struct *p)
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
+		return set_process_xstate_perm(task, arg2);
+	case ARCH_GET_STATE_ENABLE:
+		return put_user(get_task_state_perm(task), (unsigned long __user *)arg2);
 	}
 
 	return -EINVAL;
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 41c9855158d6..065ea28328b9 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -678,6 +678,9 @@ void set_personality_64bit(void)
 	   so it's not too bad. The main problem is just that
 	   32bit children are affected again. */
 	current->personality &= ~READ_IMPLIES_EXEC;
+
+	/* Make sure to reset the dynamic state permission. */
+	reset_task_xstate_perm(current);
 }
 
 static void __set_personality_x32(void)
@@ -723,6 +726,9 @@ void set_personality_ia32(bool x32)
 	/* Make sure to be in 32bit mode */
 	set_thread_flag(TIF_ADDR32);
 
+	/* Make sure to reset the dynamic state permission. */
+	reset_task_xstate_perm(current);
+
 	if (x32)
 		__set_personality_x32();
 	else
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index dd66d528afd8..c94f3b76c126 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1132,10 +1132,12 @@ DEFINE_IDTENTRY(exc_device_not_available)
 				int err = -1;
 
 				/*
-				 * Make sure not in interrupt context as handling a
-				 * trap from userspace.
+				 * Make sure that dynamic buffer expansion is permitted
+				 * and not in interrupt context as handling a trap from
+				 * userspace.
 				 */
-				if (!WARN_ON(in_interrupt())) {
+				if (((xfd_event & fpu->dynamic_state_perm) == xfd_event) &&
+				    !WARN_ON(in_interrupt())) {
 					err = alloc_xstate_buffer(fpu, xfd_event);
 					if (!err)
 						xfd_write((fpu->state_mask & xfd_capable()) ^
-- 
2.17.1

