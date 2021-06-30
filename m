Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2D3B7D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhF3GLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:11:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:46949 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232389AbhF3GKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:10:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="195448573"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="195448573"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 23:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="455156534"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 29 Jun 2021 23:08:18 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v6 14/26] x86/arch_prctl: Create ARCH_ENABLE_XSTATE
Date:   Tue, 29 Jun 2021 23:02:14 -0700
Message-Id: <20210630060226.24652-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210630060226.24652-1-chang.seok.bae@intel.com>
References: <20210630060226.24652-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v2] Move to per-process, as discussed on LKML, use name suggested by
Boris.

arch_prctl(ARCH_ENABLE_XSTATE)
    Some XSTATE features, such as AMX, are unavailable to applications
    until that process explicitly requests them via this call. This call is
    intended to be invoked very early in process initialization. A forked
    child inherits access, but permission is reset upon exec. There is no
    concept of un-requesting XSTATE access.
    Return codes:
        0: success (including repeated calls)
        EINVAL: no hardware feature for the request
	EBUSY: error in updating all threads in the process

The permission is checked at every XSTATE buffer expansion, e.g.
XFD-induced #NM event, and ptracer's XSTATE injection.

The notion of granted permission is broadcast to all threads in a process.

Detect a fork race by aborting and returning -EBUSY if the number of
threads at the end of call changed.

(This approach follows the PR_SET_FP_MODE prctl(2) implementation.)

[ An alternative implementation would not save this flag in every task. But
  instead would extend the per-process signal data, and that would not be
  subject to this race. ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Switched to per-process permission. (Based on the discussion on LKML)
---
 arch/x86/include/asm/fpu/xstate.h  |  4 +++
 arch/x86/include/asm/thread_info.h |  2 ++
 arch/x86/include/uapi/asm/prctl.h  |  2 ++
 arch/x86/kernel/fpu/regset.c       |  4 +--
 arch/x86/kernel/fpu/xstate.c       | 56 ++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c          |  2 ++
 arch/x86/kernel/process_64.c       |  6 ++++
 arch/x86/kernel/traps.c            |  8 +++--
 8 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 45735441fbe8..813510e827a6 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -149,6 +149,10 @@ void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
 unsigned int get_xstate_size(u64 mask);
 int alloc_xstate_buffer(struct fpu *fpu, u64 mask);
 void free_xstate_buffer(struct fpu *fpu);
+
+long set_process_xstate_perm(struct task_struct *task);
+void reset_task_xstate_perm(struct task_struct *task);
+
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct fpu *fpu, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct fpu *fpu, const void __user *ubuf);
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index de406d93b515..aa28e3ad5335 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -93,6 +93,7 @@ struct thread_info {
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_XSTATE_PERM		23	/* allow a process to use dynamic user xstate */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
@@ -115,6 +116,7 @@ struct thread_info {
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
+#define _TIF_XSTATE_PERM	(1 << TIF_XSTATE_PERM)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 5a6aac9fa41f..57e5e8629070 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -10,6 +10,8 @@
 #define ARCH_GET_CPUID		0x1011
 #define ARCH_SET_CPUID		0x1012
 
+#define ARCH_ENABLE_XSTATE	0x1020
+
 #define ARCH_MAP_VDSO_X32	0x2001
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 0e067c6684e2..0cd09bc5c174 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -165,11 +165,11 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 
 	/*
 	 * When a ptracer attempts to write any dynamic user state in the target buffer but not
-	 * sufficiently allocated, it dynamically expands the buffer.
+	 * sufficiently allocated, it dynamically expands the buffer if permitted.
 	 *
 	 * Check if the expansion is possibly needed.
 	 */
-	if (xfeatures_mask_user_dynamic &&
+	if (xfeatures_mask_user_dynamic && test_tsk_thread_flag(target, TIF_XSTATE_PERM) &&
 	    ((fpu->state_mask & xfeatures_mask_user_dynamic) != xfeatures_mask_user_dynamic)) {
 		u64 state_mask;
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 743621d87700..9b16ae2fca85 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1247,6 +1247,62 @@ int alloc_xstate_buffer(struct fpu *fpu, u64 mask)
 	return 0;
 }
 
+/**
+ * set_process_xstate_perm() - Set a per-process permission to use dynamic user xstates.
+ * @task:	A struct task_struct * pointer
+ * Return:	0 if successful; otherwise, return a relevant error code.
+ */
+long set_process_xstate_perm(struct task_struct *tsk)
+{
+	struct task_struct *t;
+	int nr_threads = 0;
+
+	if (!xfeatures_mask_user_dynamic)
+		return -EINVAL;
+
+	for_each_thread(tsk, t) {
+		if (!test_tsk_thread_flag(t, TIF_XSTATE_PERM))
+			set_tsk_thread_flag(t, TIF_XSTATE_PERM);
+		nr_threads++;
+	}
+
+	if (nr_threads != tsk->signal->nr_threads) {
+		for_each_thread(tsk, t)
+			clear_tsk_thread_flag(t, TIF_XSTATE_PERM);
+		pr_err("x86/fpu: ARCH_XSTATE_PERM failed as thread number mismatched.\n");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+/**
+ * reset_task_xstate_perm() - Reset a task's permission to use dynamic user xstates.
+ *
+ * It is expected to call at exec in which one task runs in a process.
+ *
+ * @task:       A struct task_struct * pointer
+ * Return:	None
+ */
+void reset_task_xstate_perm(struct task_struct *tsk)
+{
+	struct fpu *fpu = &tsk->thread.fpu;
+
+	if (!xfeatures_mask_user_dynamic)
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
+	clear_tsk_thread_flag(tsk, TIF_XSTATE_PERM);
+}
+
 static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 			 void *init_xstate, unsigned int size)
 {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 42a8712f90a5..bc854e1243cf 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1019,6 +1019,8 @@ long do_arch_prctl_common(struct task_struct *task, int option,
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
 		return set_cpuid_mode(task, cpuid_enabled);
+	case ARCH_ENABLE_XSTATE:
+		return set_process_xstate_perm(task);
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
index 8c213777ce4d..d8cb44319989 100644
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
-				if (!WARN_ON(in_interrupt()))
+				if (test_thread_flag(TIF_XSTATE_PERM) &&
+				    !WARN_ON(in_interrupt()))
 					err = alloc_xstate_buffer(fpu, xfd_event);
 
 				/*
-- 
2.17.1

