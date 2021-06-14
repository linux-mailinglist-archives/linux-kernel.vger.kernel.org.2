Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD03A6C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhFNQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbhFNQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08643C0613A3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:42 -0700 (PDT)
Message-Id: <20210614155358.277290739@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1A+rdrzCr24SbCzAOKAmEfMSvxh54YcsNwFR4gnZ6WY=;
        b=NjlZG9hzPqVkJZl7/ymmdC6ggJbFc2pau0AhNQUi+jbYHT2IUyd5mXxQ5SIsLuL4kD6pt1
        ttIBeiYP0yXX13JhGZAqY7AFTYjZrmm7YvU3fEPdQCjOmH/v41NCYAQ90CzLREIuJoB1xp
        nV+0UCpXDm+UOxQvroo3LoaeN6VLIaiT4/pRPTzm1kqS9inwx4PxpIDNyIP5RZO+TY8mMC
        Pzr6cA74tnBMDp+WFG/iCpTMaf9N8LsxZJjjFbJTvhsSOB7kAxoHduFYDlX4rUufKawURd
        Z5h/jmstqgbXM0Z4xakjvnFL8EJB5GCkEpTgj4VzVx1TsFqu5LNc3ETNLb9oYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1A+rdrzCr24SbCzAOKAmEfMSvxh54YcsNwFR4gnZ6WY=;
        b=2xRgB8unk4KzbbtepNwf3MBPFYGYylAIHT0PT0ZaeoJL2U4z0M3Qeefu+KsrhfoHIbyrjW
        zzDZcpOYHIkvSIAA==
Date:   Mon, 14 Jun 2021 17:44:53 +0200
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
Subject: [patch V2 45/52] x86/fpu: Dont restore PKRU in fpregs_restore_userspace()
References: <20210614154408.673478623@linutronix.de>
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
@@ -455,7 +455,17 @@ static inline void fpregs_restore_userre
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
@@ -470,7 +470,7 @@ void fpu__clear_user_states(struct fpu *
 	}
 
 	/* Reset user states in registers. */
-	load_fpregs_from_init_fpstate(xfeatures_mask_uabi());
+	load_fpregs_from_init_fpstate(xfeatures_mask_restore_user());
 
 	/*
 	 * Now all FPU registers have their desired values.  Inform the FPU

