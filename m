Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248F241F7A0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356157AbhJAWrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:47:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:38097 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356139AbhJAWqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:46:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205756656"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="205756656"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565344002"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 15:44:17 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v11 16/29] x86/fpu/xstate: Support both legacy and expanded signal XSTATE size
Date:   Fri,  1 Oct 2021 15:37:15 -0700
Message-Id: <20211001223728.9309-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to support two XSTATE sizes on the signal stack -- legacy and
expanded. Legacy programs have not requested access to the
permission-required features, and the XSTATE on their signal stack can
include up through the PKRU state.

Programs that request access to opt-in features will have an uncompacted
XSTATE that includes those features. If such program that also use the
sigaltstack, they must assure that their sigaltstack is large enough to
handle that full XSTATE format. (This is most easily done by using signal.h
from glibc 2.34 or later) If the sigaltstack(2) precedes the permission
system call and uses an insufficient size, the kernel will not grant
permission to access the feature.

Introduce a new XSTATE size variable for the legacy stack and some helpers.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v10:
* Expand permission-required states rather than just XFD-protected state.
* Add sanity checks to sigaltstack() and ARCH_SET_STATE_ENABLE syscalls
  (Thomas Gleixner)
* Fix to access fpu->state_mask via the helper.

Changes from v9:
* Use get_group_state_perm() to check the permission.

Changes from v6:
* Massage the code comments.

Changes form v5:
* Added as a new patch.
---
 arch/x86/include/asm/fpu/internal.h | 25 ++++++++++--
 arch/x86/include/asm/fpu/xstate.h   | 23 ++++++++++-
 arch/x86/kernel/fpu/init.c          |  1 +
 arch/x86/kernel/fpu/signal.c        | 63 ++++++++++++++++++++---------
 arch/x86/kernel/fpu/xstate.c        | 29 +++++++++++++
 kernel/signal.c                     |  8 ++++
 6 files changed, 124 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 1aa8bc75b24d..06be4c247c97 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -337,15 +337,32 @@ static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
  */
 static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
+	u32 lmask, hmask;
+	u64 mask;
+	int err;
+
 	/*
 	 * Include the features which are not xsaved/rstored by the kernel
 	 * internally, e.g. PKRU. That's user space ABI and also required
 	 * to allow the signal handler to modify PKRU.
 	 */
-	u64 mask = xfeatures_mask_uabi();
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
-	int err;
+	mask = xfeatures_mask_uabi();
+
+	/* Include the permission-required states only when used. */
+	if (xfeatures_mask_user_perm()) {
+		u64 uabi_mask = mask;
+
+		mask = uabi_mask & ~xfeatures_mask_user_perm();
+
+		if (sig_xstate_expanded(current)) {
+			u64 cur_uabi_mask = uabi_mask & current->thread.fpu.state_mask;
+
+			mask |= cur_uabi_mask & xfeatures_mask_user_perm();
+		}
+	}
+
+	lmask = mask;
+	hmask = mask >> 32;
 
 	/*
 	 * Clear the xsave header first, so that reserved fields are
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 1f62a38e4ae1..e0437dfd897b 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -9,6 +9,7 @@
 #include <asm/fpu/api.h>
 #include <asm/user.h>
 #include <asm/prctl.h>
+#include <asm/elf.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
 #define XFEATURE_MASK_EXTEND	(~(XFEATURE_MASK_FPSSE | (1ULL << 63)))
@@ -154,10 +155,13 @@ extern void __init update_regset_xstate_info(unsigned int size,
  *				contains all the enabled state components.
  * @user_size:			The size of user-space buffer for signal and
  *				ptrace frames, in the non-compacted format.
+ * @user_minsig_size:		The non-compacted legacy xstate size for signal.
+ *				Legacy programs do not request to access dynamic
+ *				states.
  */
 struct fpu_xstate_buffer_config {
 	unsigned int min_size, max_size;
-	unsigned int user_size;
+	unsigned int user_size, user_minsig_size;
 };
 
 extern struct fpu_xstate_buffer_config fpu_buf_cfg;
@@ -189,6 +193,23 @@ static inline bool state_permitted(struct task_struct *tsk, u64 state_mask)
 	return ((state_mask & get_group_state_perm(tsk)) == state_mask);
 }
 
+/**
+ * sig_xstate_expanded - Check if a task's xstate in sigframe is expanded.
+ *
+ * If a user thread is successful with ARCH_SET_STATE_ENABLE, its sigstack
+ * has to be at least AT_MINSIGSTKSZ. The sigframe's xstate size can
+ * include all the feature state.
+ *
+ * @tsk:	A struct task_struct * pointer
+ * Return:	True if the xstate is expanded; otherwise, false.
+ */
+static inline bool sig_xstate_expanded(struct task_struct *tsk)
+{
+	return ((get_group_state_perm(tsk) & xfeatures_mask_user_perm()) > 0);
+}
+
+extern bool arch_enough_sigaltstack(struct task_struct *tsk, size_t ss_size);
+
 void reset_state_perm(struct task_struct *tsk);
 long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2);
 
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index cd1f3114f3ca..75bacda2ab87 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -210,6 +210,7 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_buf_cfg.min_size = xstate_size;
 	fpu_buf_cfg.max_size = xstate_size;
 	fpu_buf_cfg.user_size = xstate_size;
+	fpu_buf_cfg.user_minsig_size = xstate_size;
 }
 
 /* Legacy code to initialize eager fpu mode. */
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index fe2732db6d6b..3025346d8168 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -15,9 +15,25 @@
 #include <asm/sigframe.h>
 #include <asm/trace/fpu.h>
 
+/*
+ * Record the signal xstate size and feature bits. Exclude dynamic user
+ * states. See fpu__init_prepare_fx_sw_frame(). The opt-in tasks will
+ * dynamically adjust the data.
+ */
 static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
 static struct _fpx_sw_bytes fx_sw_reserved_ia32 __ro_after_init;
 
+static unsigned int current_sig_xstate_size(void)
+{
+	return sig_xstate_expanded(current) ?
+	       fpu_buf_cfg.user_size : fpu_buf_cfg.user_minsig_size;
+}
+
+static inline int extend_sig_xstate_size(unsigned int size)
+{
+	return use_xsave() ? size + FP_XSTATE_MAGIC2_SIZE : size;
+}
+
 /*
  * Check for the presence of extended state information in the
  * user fpstate pointer in the sigcontext.
@@ -36,7 +52,7 @@ static inline int check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	/* Check for the first magic field and other error scenarios. */
 	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
 	    fx_sw->xstate_size < min_xstate_size ||
-	    fx_sw->xstate_size > fpu_buf_cfg.user_size ||
+	    fx_sw->xstate_size > current_sig_xstate_size() ||
 	    fx_sw->xstate_size > fx_sw->extended_size)
 		goto setfx;
 
@@ -94,20 +110,32 @@ static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
 
 static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 {
+	unsigned int current_xstate_size = current_sig_xstate_size();
 	struct xregs_state __user *x = buf;
-	struct _fpx_sw_bytes *sw_bytes;
+	struct _fpx_sw_bytes sw_bytes;
 	u32 xfeatures;
 	int err;
 
-	/* Setup the bytes not touched by the [f]xsave and reserved for SW. */
-	sw_bytes = ia32_frame ? &fx_sw_reserved_ia32 : &fx_sw_reserved;
-	err = __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));
+	/*
+	 * Setup the bytes not touched by the [f]xsave and reserved for SW.
+	 *
+	 * Use the recorded values if it matches with the current task. Otherwise,
+	 * adjust it.
+	 */
+	sw_bytes = ia32_frame ? fx_sw_reserved_ia32 : fx_sw_reserved;
+	if (sw_bytes.xstate_size != current_xstate_size) {
+		unsigned int default_xstate_size = sw_bytes.xstate_size;
+
+		sw_bytes.xfeatures = xfeatures_mask_uabi();
+		sw_bytes.xstate_size = current_xstate_size;
+		sw_bytes.extended_size += (current_xstate_size - default_xstate_size);
+	}
+	err = __copy_to_user(&x->i387.sw_reserved, &sw_bytes, sizeof(sw_bytes));
 
 	if (!use_xsave())
 		return err;
 
-	err |= __put_user(FP_XSTATE_MAGIC2,
-			  (__u32 __user *)(buf + fpu_buf_cfg.user_size));
+	err |= __put_user(FP_XSTATE_MAGIC2, (__u32 __user *)(buf + current_xstate_size));
 
 	/*
 	 * Read the xfeatures which we copied (directly from the cpu or
@@ -144,7 +172,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 	else
 		err = fnsave_to_user_sigframe((struct fregs_state __user *) buf);
 
-	if (unlikely(err) && __clear_user(buf, fpu_buf_cfg.user_size))
+	if (unlikely(err) && __clear_user(buf, current_sig_xstate_size()))
 		err = -EFAULT;
 	return err;
 }
@@ -205,7 +233,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	fpregs_unlock();
 
 	if (ret) {
-		if (!fault_in_pages_writeable(buf_fx, fpu_buf_cfg.user_size))
+		if (!fault_in_pages_writeable(buf_fx, current_sig_xstate_size()))
 			goto retry;
 		return -EFAULT;
 	}
@@ -418,18 +446,13 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	fpregs_unlock();
 	return ret;
 }
-static inline int xstate_sigframe_size(void)
-{
-	return use_xsave() ? fpu_buf_cfg.user_size + FP_XSTATE_MAGIC2_SIZE :
-			fpu_buf_cfg.user_size;
-}
 
 /*
  * Restore FPU state from a sigframe:
  */
 int fpu__restore_sig(void __user *buf, int ia32_frame)
 {
-	unsigned int size = xstate_sigframe_size();
+	unsigned int size = extend_sig_xstate_size(current_sig_xstate_size());
 	struct fpu *fpu = &current->thread.fpu;
 	void __user *buf_fx = buf;
 	bool ia32_fxstate = false;
@@ -476,7 +499,7 @@ unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size)
 {
-	unsigned long frame_size = xstate_sigframe_size();
+	unsigned long frame_size = extend_sig_xstate_size(current_sig_xstate_size());
 
 	*buf_fx = sp = round_down(sp - frame_size, 64);
 	if (ia32_frame && use_fxsr()) {
@@ -491,7 +514,7 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 unsigned long fpu__get_fpstate_size(void)
 {
-	unsigned long ret = xstate_sigframe_size();
+	unsigned long ret = extend_sig_xstate_size(fpu_buf_cfg.user_size);
 
 	/*
 	 * This space is needed on (most) 32-bit kernels, or when a 32-bit
@@ -516,12 +539,12 @@ unsigned long fpu__get_fpstate_size(void)
  */
 void fpu__init_prepare_fx_sw_frame(void)
 {
-	int ext_size = fpu_buf_cfg.user_size + FP_XSTATE_MAGIC2_SIZE;
-	int xstate_size = fpu_buf_cfg.user_size;
+	int ext_size = fpu_buf_cfg.user_minsig_size + FP_XSTATE_MAGIC2_SIZE;
+	int xstate_size = fpu_buf_cfg.user_minsig_size;
 
 	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
 	fx_sw_reserved.extended_size = ext_size;
-	fx_sw_reserved.xfeatures = xfeatures_mask_uabi();
+	fx_sw_reserved.xfeatures = xfeatures_mask_uabi() & ~xfeatures_mask_user_perm();
 	fx_sw_reserved.xstate_size = xstate_size;
 
 	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 38c003f840b4..5905857fbbc0 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -821,6 +821,21 @@ static int __init init_xstate_size(void)
 	 * User space is always in standard format.
 	 */
 	fpu_buf_cfg.user_size = xsave_size;
+
+	/*
+	 * The minimum signal xstate size is for legacy user threads
+	 * that do not access dynamic states.
+	 */
+	if (xfeatures_mask_user_perm()) {
+		int nr = fls64(xfeatures_mask_uabi() & ~xfeatures_mask_user_perm()) - 1;
+		unsigned int size, offset, ecx, edx;
+
+		cpuid_count(XSTATE_CPUID, nr, &size, &offset, &ecx, &edx);
+		fpu_buf_cfg.user_minsig_size = offset + size;
+	} else {
+		fpu_buf_cfg.user_minsig_size = xsave_size;
+	}
+
 	return 0;
 }
 
@@ -1252,6 +1267,13 @@ long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2
 		if (!state_perm)
 			return 0;
 
+		/*
+		 * Disallow when sigaltstack is not enough for the
+		 * AT_MINSIGSTKSZ value.
+		 */
+		if (tsk->sas_ss_size > 0 && tsk->sas_ss_size < get_sigframe_size())
+			return -EPERM;
+
 		tsk->group_leader->thread.fpu.state_perm |= state_perm;
 		return 0;
 	}
@@ -1266,6 +1288,13 @@ long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2
 	}
 }
 
+bool arch_enough_sigaltstack(struct task_struct *tsk, size_t ss_size)
+{
+	if (sig_xstate_expanded(tsk))
+		return ss_size >= get_sigframe_size();
+	return true;
+}
+
 static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 			 void *init_xstate, unsigned int size)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index 952741f6d0f9..9a516b6e795e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4151,6 +4151,11 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	return 0;
 }
 
+bool __weak arch_enough_sigaltstack(struct task_struct *tsk, size_t ss_size)
+{
+	return true;
+}
+
 static int
 do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
 		size_t min_ss_size)
@@ -4187,6 +4192,9 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
 				return -ENOMEM;
 		}
 
+		if (!arch_enough_sigaltstack(t, ss_size))
+			return -EINVAL;
+
 		t->sas_ss_sp = (unsigned long) ss_sp;
 		t->sas_ss_size = ss_size;
 		t->sas_ss_flags = ss_flags;
-- 
2.17.1

