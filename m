Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA63A46E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhFKQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:47:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41348 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhFKQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:38 -0400
Message-Id: <20210611163114.798820793@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vyLcvvCr2N/bEKww4aIemcTa+xhhcPQ9C+cxPRdr8uA=;
        b=B5R8qq/GUjGv1NjRnKmcH7QYGdQkuWmlX76u2phdLjTmGYpqX4Ji6V5DEwsHNriObO9bQu
        LILvSRqx5nV1V5e4vT2ydhsiPR/h9pJqna26+62tb2S0QVWq6p8o+M12mg8igFZtaawNCh
        4DdmEwQMyq0yNLajzdSCOTFENBZuznRSSuVvZoWVdv4yHEWT7twgi6m0WSyM6N34qdaKok
        IWn6Pzh174G0k4HiiEGRkBx5yamKx3tvp9c0rRVw1Io2HOqfd49CYrqXg1yC/II7Wci3J5
        karKDvz+G4nl91dhwGuwb2WjOdzzbk85bQ8NgveLp28+CeiD0HGZIwHzfcRePQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vyLcvvCr2N/bEKww4aIemcTa+xhhcPQ9C+cxPRdr8uA=;
        b=atr1DLj3UmsL93VdtynEKnrFPOxxLbgZgD7V9c8piF0xpvEZnn6Bt3J9J181yFx/5fblm0
        2l7R+bzSFRF7Z2CA==
Date:   Fri, 11 Jun 2021 18:15:58 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch 35/41] x86/fpu: Dont restore PKRU in fpregs_restore_userspace()
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

switch_to(), flush_thread() write the task's PKRU value eagerly so the PKRU
value of current is always valid in the hardware.

That means there is no point in restoring PKRU on exit to user or when
reactivating the task's FPU registers in the signal frame setup path.

This allows to remove all the xstate buffer updates with PKRU values once
the PKRU state is stored in thread struct while a task is scheduled out.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |   12 +++++++++++-
 arch/x86/include/asm/fpu/xstate.h   |   19 +++++++++++++++++++
 arch/x86/kernel/fpu/core.c          |    2 +-
 3 files changed, 31 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -477,7 +477,17 @@ static inline void fpregs_restore_userre
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
-		restore_fpregs_from_fpstate(&fpu->state);
+		/*
+		 * This restores _all_ xstate which has not been
+		 * established yet.
+		 *
+		 * If PKRU is enabled, then the PKRU value is already
+		 * correct because it was either set in switch_to() or in
+		 * flush_thread(). So it is excluded because it might be
+		 * not up to date in current->thread.fpu.xsave state.
+		 */
+		__restore_fpregs_from_fpstate(&fpu->state,
+					      xfeatures_mask_restore_user());
 		fpregs_activate(fpu);
 		fpu->last_cpu = cpu;
 	}
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -35,6 +35,14 @@
 				      XFEATURE_MASK_BNDREGS | \
 				      XFEATURE_MASK_BNDCSR)
 
+/*
+ * Features which are restored when returning to user space.
+ * PKRU is not restored on return to user space because PKRU
+ * is switched eagerly in switch_to() and flush_thread()
+ */
+#define XFEATURE_MASK_USER_RESTORE	\
+	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
+
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
 
@@ -92,6 +100,17 @@ static inline u64 xfeatures_mask_uabi(vo
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
+/*
+ * The xfeatures which are restored by the kernel when returning to user
+ * mode. This is not necessarily the same as xfeatures_mask_uabi() as the
+ * kernel does not manage all XCR0 enabled features via xsave/xrstor as
+ * some of them have to be switched eagerly on context switch and exec().
+ */
+static inline u64 xfeatures_mask_restore_user(void)
+{
+	return xfeatures_mask_all & XFEATURE_MASK_USER_RESTORE;
+}
+
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -471,7 +471,7 @@ void fpu__clear_user_states(struct fpu *
 	}
 
 	/* Reset user states in registers. */
-	load_fpregs_from_init_fpstate(xfeatures_mask_uabi());
+	load_fpregs_from_init_fpstate(xfeatures_mask_restore_user());
 
 	/*
 	 * Now all FPU registers have their desired values.  Inform the FPU

