Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E603436DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhJUXHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:58072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhJUXHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315380045"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315380045"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033338"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:23 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 10/23] x86/fpu: Prepare fpu_clone() for dynamically enabled features
Date:   Thu, 21 Oct 2021 15:55:14 -0700
Message-Id: <20211021225527.10184-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The default portion of the parent's FPU state is saved in a child task.
With dynamic features enabled, the non-default portion is not saved in a
child's fpstate because these register states are defined to be
caller-saved. The new task's fpstate is therefore the default buffer.

Fork inherits the permission of the parent.

Also, do not use memcpy() when TIF_NEED_FPU_LOAD is set because it is
invalid when the parent has dynamic features.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Changes from the tglx tree:
* Add the changelog.
* Update comments. (Dave Hansen)
---
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/kernel/fpu/core.c       | 35 +++++++++++++++++++++++---------
 arch/x86/kernel/process.c        |  2 +-
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index cdb78d590c86..99a8820e8cc4 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -11,7 +11,7 @@
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 extern void fpu__drop(struct fpu *fpu);
-extern int  fpu_clone(struct task_struct *dst);
+extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags);
 extern void fpu_flush_thread(void);
 
 /*
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ff7d239fe961..177f27687261 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -426,8 +426,20 @@ void fpstate_reset(struct fpu *fpu)
 	fpu->perm.__user_state_size	= fpu_user_cfg.default_size;
 }
 
+static inline void fpu_inherit_perms(struct fpu *dst_fpu)
+{
+	if (fpu_state_size_dynamic()) {
+		struct fpu *src_fpu = &current->group_leader->thread.fpu;
+
+		spin_lock_irq(&current->sighand->siglock);
+		/* Fork also inherits the permissions of the parent */
+		dst_fpu->perm = src_fpu->perm;
+		spin_unlock_irq(&current->sighand->siglock);
+	}
+}
+
 /* Clone current's FPU state on fork */
-int fpu_clone(struct task_struct *dst)
+int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 {
 	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
@@ -458,17 +470,20 @@ int fpu_clone(struct task_struct *dst)
 	}
 
 	/*
-	 * If the FPU registers are not owned by current just memcpy() the
-	 * state.  Otherwise save the FPU registers directly into the
-	 * child's FPU context, without any memory-to-memory copying.
+	 * Save the default portion of the current FPU state into the
+	 * clone. Assume all dynamic features to be defined as caller-
+	 * saved, which enables skipping both the expansion of fpstate
+	 * and the copying of any dynamic state.
+	 *
+	 * Do not use memcpy() when TIF_NEED_FPU_LOAD is set because
+	 * copying is not valid when current uses non-default states.
 	 */
 	fpregs_lock();
-	if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		memcpy(&dst_fpu->fpstate->regs, &src_fpu->fpstate->regs,
-		       dst_fpu->fpstate->size);
-	} else {
-		save_fpregs_to_fpstate(dst_fpu);
-	}
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		fpregs_restore_userregs();
+	save_fpregs_to_fpstate(dst_fpu);
+	if (!(clone_flags & CLONE_THREAD))
+		fpu_inherit_perms(dst_fpu);
 	fpregs_unlock();
 
 	trace_x86_fpu_copy_src(src_fpu);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 97fea1649a5e..99025e32f105 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
 
-	fpu_clone(p);
+	fpu_clone(p, clone_flags);
 
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
-- 
2.17.1

