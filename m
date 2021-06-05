Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91A39CBEB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhFFAec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:34:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33048 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhFFAeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:34:23 -0400
Message-Id: <20210606001324.146056754@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622939553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XNFwtMih6U/Ozo9FCWprZKn+0ZxLuPAZslcGXXi72vU=;
        b=a1VY/uJYlrvxAGNYUuBEZVmvsWuto353+5hzNpesPJdjyX3o/ya+ygtJXKQfsWF+U80hut
        JBIUrGxEtdHwNlJrV/JAFvqDNXUiQ/VFDXoYXIZYqeasYI+ITbOdLYtEcbcvx1zmgIHd00
        qbxbrzNK5f3IP40ORlXtue3knRBM469Dqe57pL0XrvkSRj7pT7opPrI2cj8diGMTBmEjlg
        X+hNfhkMOOZfxtz6iDPCruB64LODdS1uR39Gg25X5GEabcy3pIln66X1LRGEfW9DimNnJf
        VPi8TJReLnenB0UZvZQXeVM2ZiwUBMN956XAuq99gfBCpbXZCBwTkG5l5Ypmow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622939553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XNFwtMih6U/Ozo9FCWprZKn+0ZxLuPAZslcGXXi72vU=;
        b=p+NqGuTMs4GeK4AfdBZwyL3gr5+HxEe7U66CgreLITbE98nTxnEqIUt9bsyQRhbhbVbagu
        WHIoSEZWG5gmDBBg==
Date:   Sun, 06 Jun 2021 01:47:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 12/14] x86/fpu: Clean up the fpu__clear() variants
References: <20210605234742.712464974@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

fpu__clear() currently resets both register state and kernel XSAVE buffer
state.  It has two modes: one for all state (supervisor and user) and
another for user state only.  fpu__clear_all() uses the "all state"
(user_only=0) mode, while a number of signal paths use the user_only=1
mode.

Make fpu__clear() work only for user state (user_only=1) and remove the
"all state" (user_only=0) code.  Rename it to match so it can be used by
the signal paths.

Replace the "all state" (user_only=0) fpu__clear() functionality.  Use the
TIF_NEED_FPU_LOAD functionality instead of making any actual hardware
registers changes in this path.

Instead of invoking fpu__initialize() just memcpy() init_fpstate into the
tasks FPU state because that has already the correct format and in case of
PKRU also contains the default PKRU value. Move the actual PKRU write out
into flush_thread() where it belongs and where it will end up anyway when
Dave distangles PKRU and XSTATE.

[ Dave Hansen: Polished changelog ]
[ tglx: Fixed the PKRU fallout ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fixed PKRU fallout reported by Yu-Chen
---
 arch/x86/kernel/fpu/core.c |  101 +++++++++++++++++++++++++++++----------------
 arch/x86/kernel/process.c  |   12 +++++
 2 files changed, 78 insertions(+), 35 deletions(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -269,19 +269,6 @@ int fpu__copy(struct task_struct *dst, s
 }
 
 /*
- * Activate the current task's in-memory FPU context,
- * if it has not been used before:
- */
-static void fpu__initialize(struct fpu *fpu)
-{
-	WARN_ON_FPU(fpu != &current->thread.fpu);
-
-	set_thread_flag(TIF_NEED_FPU_LOAD);
-	fpstate_init(&fpu->state);
-	trace_x86_fpu_init_state(fpu);
-}
-
-/*
  * This function must be called before we read a task's fpstate.
  *
  * There's two cases where this gets called:
@@ -365,46 +352,90 @@ static inline void copy_init_fpstate_to_
 		copy_kernel_to_fregs(&init_fpstate.fsave);
 }
 
+static inline unsigned int init_fpstate_copy_size(void)
+{
+	if (!use_xsave())
+		return fpu_kernel_xstate_size;
+
+	/* XSAVE(S) without PKRU just needs the xstate part */
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return sizeof(init_fpstate.xsave);
+
+	/*
+	 * With PKRU it needs the PKRU component storage as well.  Just
+	 * copy the full size for now as this will go away soon when PKRU
+	 * has been distangled from XSTATE.
+	 */
+	return min((unsigned int)sizeof(init_fpstate), fpu_kernel_xstate_size);
+}
+
 /*
- * Clear the FPU state back to init state.
- *
- * Called by sys_execve(), by the signal handler code and by various
- * error paths.
+ * Reset current->fpu memory state to the init values.
  */
-static void fpu__clear(struct fpu *fpu, bool user_only)
+static void fpu_reset_fpstate(void)
+{
+	struct fpu *fpu= &current->thread.fpu;
+
+	fpregs_lock();
+	fpu__drop(fpu);
+	/*
+	 * This does not change the actual hardware registers. It just
+	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a
+	 * subsequent return to usermode will reload the registers from the
+	 * tasks memory image.
+	 *
+	 * Do not use fpstate_init() here. Just copy init_fpstate which has
+	 * the correct content already and if PKRU is enabled also contains
+	 * the default PKRU value.
+	 */
+	memcpy(&fpu->state, &init_fpstate, init_fpstate_copy_size());
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+	fpregs_unlock();
+}
+
+/*
+ * Reset current's user FPU states to the init states.  current's
+ * supervisor states, if any, are not modified by this function.  The
+ * caller guarantees that the XSTATE header in memory is intact.
+ */
+void fpu__clear_user_states(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
 	if (!static_cpu_has(X86_FEATURE_FPU)) {
-		fpu__drop(fpu);
-		fpu__initialize(fpu);
+		fpu_reset_fpstate();
 		return;
 	}
 
 	fpregs_lock();
-
-	if (user_only) {
-		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
-		    xfeatures_mask_supervisor())
-			copy_kernel_to_xregs(&fpu->state.xsave,
-					     xfeatures_mask_supervisor());
-		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
-	} else {
-		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
+	/*
+	 * Ensure that current's supervisor states are loaded into their
+	 * corresponding registers.
+	 */
+	if (xfeatures_mask_supervisor() &&
+	    !fpregs_state_valid(fpu, smp_processor_id())) {
+		copy_kernel_to_xregs(&fpu->state.xsave,
+				     xfeatures_mask_supervisor());
 	}
 
+	/* Reset user states in registers. */
+	copy_init_fpstate_to_fpregs(xfeatures_mask_user());
+
+	/*
+	 * Now all FPU registers have their desired values.  Inform the FPU
+	 * state machine that current's FPU registers are in the hardware
+	 * registers. The memory image does not need to be updated because
+	 * any operation relying on it has to save the registers first when
+	 * currents FPU is marked active.
+	 */
 	fpregs_mark_activate();
-	fpregs_unlock();
-}
 
-void fpu__clear_user_states(struct fpu *fpu)
-{
-	fpu__clear(fpu, true);
+	fpregs_unlock();
 }
 
 void fpu_flush_thread(void)
 {
-	fpu__clear(&current->thread.fpu, false);
+	fpu_reset_fpstate();
 }
 
 /*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -199,6 +199,17 @@ int copy_thread(unsigned long clone_flag
 	return ret;
 }
 
+static void pkru_flush_thread(void)
+{
+	/*
+	 * If PKRU is enabled the default PKRU value has to be loaded into
+	 * the hardware right here (similar to context switch). The XSAVE
+	 * state is already up to date.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
+		__write_pkru(pkru_get_init_value());
+}
+
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
@@ -207,6 +218,7 @@ void flush_thread(void)
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
 	fpu_flush_thread();
+	pkru_flush_thread();
 }
 
 void disable_TSC(void)

