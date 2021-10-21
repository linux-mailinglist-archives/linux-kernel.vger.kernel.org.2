Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD1436DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhJUXIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:08:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:4522 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232560AbhJUXHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="292634873"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="292634873"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033430"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:27 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 17/23] x86/fpu/xstate: Add XFD #NM handler
Date:   Thu, 21 Oct 2021 15:55:21 -0700
Message-Id: <20211021225527.10184-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the XFD MSR has feature bits set then #NM will be raised when user space
attempts to use an instruction related to one of these features.

When the task has no permissions to use that feature, raise SIGILL, which
is the same behavior as #UD.

If the task has permissions, calculate the new buffer size for the extended
feature set and allocate a larger fpstate. In the unlikely case that
vzalloc() fails, SIGSEGV is raised.

The allocation function will be added in the next step. Provide a stub
which fails for now.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
[ tglx: Updated serialization ]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/include/asm/fpu/xstate.h |  2 ++
 arch/x86/kernel/fpu/xstate.c      | 47 +++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c           | 38 +++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 023000e79348..d23714132dbb 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -99,6 +99,8 @@ int xfeature_size(int xfeature_nr);
 void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
 
+int xfd_enable_feature(u64 xfd_err);
+
 #ifdef CONFIG_X86_64
 DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
 #endif
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 04f1f7aea93c..1b2fad6e4964 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1461,6 +1461,53 @@ static int xstate_request_perm(unsigned long idx)
 	spin_unlock_irq(&current->sighand->siglock);
 	return ret;
 }
+
+/* Place holder for now */
+static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
+			   unsigned int usize)
+{
+	return -ENOMEM;
+}
+
+int xfd_enable_feature(u64 xfd_err)
+{
+	u64 xfd_event = xfd_err & XFEATURE_MASK_USER_DYNAMIC;
+	unsigned int ksize, usize;
+	struct fpu *fpu;
+
+	if (!xfd_event) {
+		pr_err_once("XFD: Invalid xfd error: %016llx\n", xfd_err);
+		return 0;
+	}
+
+	/* Protect against concurrent modifications */
+	spin_lock_irq(&current->sighand->siglock);
+
+	/* If not permitted let it die */
+	if ((xstate_get_host_group_perm() & xfd_event) != xfd_event) {
+		spin_unlock_irq(&current->sighand->siglock);
+		return -EPERM;
+	}
+
+	fpu = &current->group_leader->thread.fpu;
+	ksize = fpu->perm.__state_size;
+	usize = fpu->perm.__user_state_size;
+	/*
+	 * The feature is permitted. State size is sufficient.  Dropping
+	 * the lock is safe here even if more features are added from
+	 * another task, the retrieved buffer sizes are valid for the
+	 * currently requested feature(s).
+	 */
+	spin_unlock_irq(&current->sighand->siglock);
+
+	/*
+	 * Try to allocate a new fpstate. If that fails there is no way
+	 * out.
+	 */
+	if (fpstate_realloc(xfd_event, ksize, usize))
+		return -EFAULT;
+	return 0;
+}
 #else /* CONFIG_X86_64 */
 static inline int xstate_request_perm(u64 permitted, u64 requested)
 {
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index bae7582c58f5..6ca1454a65d4 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1108,10 +1108,48 @@ DEFINE_IDTENTRY(exc_spurious_interrupt_bug)
 	 */
 }
 
+static bool handle_xfd_event(struct pt_regs *regs)
+{
+	u64 xfd_err;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_X86_64) || !cpu_feature_enabled(X86_FEATURE_XFD))
+		return false;
+
+	rdmsrl(MSR_IA32_XFD_ERR, xfd_err);
+	if (!xfd_err)
+		return false;
+
+	wrmsrl(MSR_IA32_XFD_ERR, 0);
+
+	/* Die if that happens in kernel space */
+	if (WARN_ON(!user_mode(regs)))
+		return false;
+
+	local_irq_enable();
+
+	err = xfd_enable_feature(xfd_err);
+
+	switch (err) {
+	case -EPERM:
+		force_sig_fault(SIGILL, ILL_ILLOPC, error_get_trap_addr(regs));
+		break;
+	case -EFAULT:
+		force_sig(SIGSEGV);
+		break;
+	}
+
+	local_irq_disable();
+	return true;
+}
+
 DEFINE_IDTENTRY(exc_device_not_available)
 {
 	unsigned long cr0 = read_cr0();
 
+	if (handle_xfd_event(regs))
+		return;
+
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
-- 
2.17.1

