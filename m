Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4193E38DCB5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhEWTkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:12061 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231992AbhEWTj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:57 -0400
IronPort-SDR: l1/x+35MkB/pojKyRVnv3sQxZxK1mP6Wj1cskhWVXp7z5R1oMM3Rrc9fU/lQq4yE45vwddGFdU
 7ABOkBGI+p4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="265703534"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265703534"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:29 -0700
IronPort-SDR: tjw+E9aV/y8NEgnQB1QS310Pbv0PDvaubJNaQOr0wJtfsWRb3l18ilSWSq+XiESWhbaVApGhPN
 B6HcieSX1RHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467106"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 15/28] x86/arch_prctl: Create ARCH_GET_XSTATE/ARCH_PUT_XSTATE
Date:   Sun, 23 May 2021 12:32:46 -0700
Message-Id: <20210523193259.26200-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

N.B. This interface is currently under active discussion on LKML. This v1
proposal implements a per-task system call with GET/PUT semantics. A
per-process system call without PUT semantics may be superior.

arch_prctl(ARCH_GET_XSTATE)
    Each user task requests access to the hardware features associated
    with the specified xstate bits.
    Return codes:
        0: success (including repeated calls)
        EPERM: requested feature is not a user-supported feature.
        EINVAL: too many GETs (>INT_MAX) without matching PUTS (reference
                counter overflow)
        ENOMEM: buffer or reference counter allocation failed.

arch_prctl(ARCH_PUT_XSTATE)
    User task tells the kernel that it is no longer using the features
    associated with the specified xstate bits.
    Return codes:
        0: success
        EINVAL: imbalance with preceding ARCH_GET_XSTATE calls

The kernel enforces access to the specified using XFD hardware support. By
default, XFD is armed and results in #NM traps on un-authorized access.
Upon successful ARCH_GET_XSTATE, XFD traps are dis-armed and the user is
free to access the feature.

On the last ARCH_PUT_XSTATE, the kernel re-arms XFD. However, as an
optimization, the kernel does not immediately free the xstate buffer.
A future enhancement could be made to identify and free allocated but
un-used xstate buffers under constrained memory conditions.

Rename the third argument for do_arch_prctl_common() to reflect its generic
use.

Free up the dynamically-allocated buffer as well as the reference counters
when the task terminates.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v4:
* Added as a new patch. (Andy Lutomirski, Thomas Gleixner, and et al)
---
 arch/x86/include/asm/fpu/internal.h |   2 +
 arch/x86/include/asm/fpu/types.h    |   8 +++
 arch/x86/include/asm/fpu/xstate.h   |   2 +
 arch/x86/include/asm/proto.h        |   2 +-
 arch/x86/include/uapi/asm/prctl.h   |   3 +
 arch/x86/kernel/fpu/core.c          |  14 ++++
 arch/x86/kernel/fpu/xstate.c        | 103 ++++++++++++++++++++++++++--
 arch/x86/kernel/process.c           |  13 +++-
 8 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index c250216320df..6460d52991ba 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -636,4 +636,6 @@ static inline void switch_fpu_finish(struct fpu *old_fpu, struct fpu *new_fpu)
 	update_pasid();
 }

+void free_fpu(struct fpu *fpu);
+
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 6fc707c14350..387b96e0b643 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -343,6 +343,14 @@ struct fpu {
 	 */
 	u64				state_mask;

+	/*
+	 * @refcount;
+	 *
+	 * Point a reference counter array for arch_prctl that tracks the xstate
+	 * use request.
+	 */
+	int				*refcount;
+
 	/*
 	 * @state:
 	 *
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index cbb4795d2b45..30f83eb0aef4 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -116,6 +116,8 @@ unsigned int get_xstate_size(u64 mask);
 int alloc_xstate_buffer(struct fpu *fpu, u64 mask);
 void free_xstate_buffer(struct fpu *fpu);

+long do_arch_prctl_xstate(struct fpu *fpu, int option, unsigned long mask);
+
 const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
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
index 5a6aac9fa41f..d3fce82845fd 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -10,6 +10,9 @@
 #define ARCH_GET_CPUID		0x1011
 #define ARCH_SET_CPUID		0x1012

+#define ARCH_GET_XSTATE		0x1021
+#define ARCH_PUT_XSTATE		0x1022
+
 #define ARCH_MAP_VDSO_X32	0x2001
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 25c9c7dad3f9..016c3adebec3 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -254,6 +254,8 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)

 	WARN_ON_FPU(src_fpu != &current->thread.fpu);

+	dst_fpu->refcount = NULL;
+
 	/*
 	 * The child does not inherit the dynamic states. Thus, use the buffer
 	 * embedded in struct task_struct, which has the minimum size.
@@ -541,3 +543,15 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
 	 */
 	return 0;
 }
+
+/**
+ * free_fpu() - Free up memory that belongs to the FPU context.
+ * @fpu:	A struct fpu * pointer
+ *
+ * Return:	Nothing
+ */
+void free_fpu(struct fpu *fpu)
+{
+	kfree(fpu->refcount);
+	free_xstate_buffer(fpu);
+}
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e60a20a1b24b..126c4a509669 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -21,6 +21,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cpufeature.h>
 #include <asm/trace/fpu.h>
+#include <asm/prctl.h>

 /*
  * Although we spell it out in here, the Processor Trace
@@ -78,6 +79,11 @@ static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] = { [ 0 ... XFE
  * byte boundary. Otherwise, it follows the preceding component immediately.
  */
 static bool xstate_aligns[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = false};
+/*
+ * Remember the index number in the reference counter array that supports
+ * access request. '-1' indicates that a state component does not support it.
+ */
+static unsigned int xstate_refcount_idx[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};

 /**
  * struct fpu_xstate_buffer_config - xstate per-task buffer configuration
@@ -969,8 +975,7 @@ void __init fpu__init_system_xstate(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 	static int on_boot_cpu __initdata = 1;
-	int err;
-	int i;
+	int err, i, j;

 	WARN_ON_FPU(!on_boot_cpu);
 	on_boot_cpu = 0;
@@ -1025,14 +1030,17 @@ void __init fpu__init_system_xstate(void)
 	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
 	xfeatures_mask_user_dynamic = 0;

-	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+	for (i = FIRST_EXTENDED_XFEATURE, j = 0; i < XFEATURE_MAX; i++) {
 		u64 feature_mask = BIT_ULL(i);

 		if (!(xfeatures_mask_user() & feature_mask))
 			continue;

-		if (xfd_supported(i))
+		if (xfd_supported(i)) {
 			xfeatures_mask_user_dynamic |= feature_mask;
+			xstate_refcount_idx[i] = j;
+			j++;
+		}
 	}

 	/* Enable xstate instructions to be able to continue with initialization: */
@@ -1339,6 +1347,93 @@ int alloc_xstate_buffer(struct fpu *fpu, u64 mask)
 	return 0;
 }

+/**
+ * do_arch_prctl_xstate() - Handle xstate-related arch_prctl requests.
+ *
+ * @fpu:	A struct fpu * pointer
+ * @option:	A subfunction of arch_prctl()
+ * @mask:	A xstate-component bitmap
+ *
+ * Return:	0 if successful; otherwise, return a relevant error code.
+ */
+long do_arch_prctl_xstate(struct fpu *fpu, int option, unsigned long mask)
+{
+	bool need_xfd_update = false;
+	int i;
+
+	switch (option) {
+	case ARCH_GET_XSTATE: {
+		int err = 0;
+
+		if (mask & ~xfeatures_mask_user())
+			return -EPERM;
+
+		if (!fpu->refcount) {
+			fpu->refcount = kcalloc(hweight64(xfeatures_mask_user_dynamic),
+						sizeof(int), GFP_KERNEL);
+			if (!fpu->refcount)
+				return -ENOMEM;
+		}
+
+		for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+			unsigned int idx = xstate_refcount_idx[i];
+
+			if ((idx == -1) || !(BIT_ULL(i) & mask))
+				continue;
+
+			if (fpu->refcount[idx] == INT_MAX)
+				return -EINVAL;
+
+			fpu->refcount[idx]++;
+		}
+
+		if ((mask & fpu->state_mask) == mask)
+			return 0;
+
+		err = alloc_xstate_buffer(fpu, mask);
+		if (!err)
+			need_xfd_update = true;
+		else
+			return err;
+		break;
+	}
+	case ARCH_PUT_XSTATE: {
+		if (mask & ~xfeatures_mask_user())
+			return -EPERM;
+
+		if (!fpu->refcount)
+			return -EINVAL;
+
+		for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+			int idx = xstate_refcount_idx[i];
+			u64 feature_mask = BIT_ULL(i);
+
+			if ((idx == -1) || !(feature_mask & mask))
+				continue;
+
+			if (fpu->refcount[idx] <= 0)
+				return -EINVAL;
+
+			fpu->refcount[idx]--;
+			if (!fpu->refcount[idx]) {
+				need_xfd_update = true;
+				fpu->state_mask &= ~(feature_mask);
+			}
+		}
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	if (need_xfd_update) {
+		u64 fpu_xfd_mask = fpu->state_mask & xfd_capable();
+
+		xfd_write(xfd_capable() ^ fpu_xfd_mask);
+	}
+	return 0;
+}
+
 static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
 {
 	if (*last >= offset)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5252464a27e3..c166243f64e4 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -98,6 +98,12 @@ void arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
 	*size = get_xstate_config(XSTATE_MIN_SIZE);
 }

+void arch_release_task_struct(struct task_struct *tsk)
+{
+	if (boot_cpu_has(X86_FEATURE_FPU))
+		free_fpu(&tsk->thread.fpu);
+}
+
 /*
  * Free thread data structures etc..
  */
@@ -990,13 +996,16 @@ unsigned long get_wchan(struct task_struct *p)
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
+	case ARCH_GET_XSTATE:
+	case ARCH_PUT_XSTATE:
+		return do_arch_prctl_xstate(&task->thread.fpu, option, arg2);
 	}

 	return -EINVAL;
--
2.17.1

