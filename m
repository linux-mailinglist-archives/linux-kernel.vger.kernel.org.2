Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF613A6C26
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhFNQmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbhFNQkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:39 -0400
Message-Id: <20210614155357.866249780@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7NF9lv7+8T3S83dp7UYFCt4ZIxSJjsR6E1HjZxDULwc=;
        b=pjLi3pX0Ry+CjbaXdlYauEaECCLrR+zUPanJQs+tZykdYAel2WzrKrUOoqUvOYrMohyGZg
        rn+e/h9kAitgFlCBKASiylGTVOXC2AQ4Mefnm4fEjj3fEOX4th1ODI6m0S4llhRkVrI23g
        wwIpe5aQNe0EK1+hbjq9N9h2qloqGEoqv9aePeCg3xnH5yDB4oVIcEQq8ggepNGFStTxre
        shgYkcNgM4FQH7ta8lM3FD21dETJ+Udc/VzF6cTE5gFm+3/pV9Lz/KmGk2YhGBrAnkVXS7
        ijeCG6XlzVf6T2KrZVa+MIMOQ+0mrDtEh/M9+jAeYd/egIiqrx32D184GBv5Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7NF9lv7+8T3S83dp7UYFCt4ZIxSJjsR6E1HjZxDULwc=;
        b=//D+eLdqATu34tqSLZZYKjU/Jn6rEoNYLam5R/r09gLmeoYWrjy20dNmjxlpcHrmHtKU/d
        AIwbqIB2fpSsmyBw==
Date:   Mon, 14 Jun 2021 17:44:49 +0200
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
Subject: [patch V2 41/52] x86/fpu: Clean up the fpu__clear() variants
References: <20210614154408.673478623@linutronix.de>
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
PKRU and XSTATE have been distangled.

For bisectability a workaround is required which stores the PKRU value in
the xstate memory until PKRU is distangled from XSTATE for context
switching and return to user.

[ Dave Hansen: Polished changelog ]
[ tglx: Fixed the PKRU fallout ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/core.c |  113 ++++++++++++++++++++++++++++++---------------
 arch/x86/kernel/process.c  |   10 +++
 2 files changed, 87 insertions(+), 36 deletions(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -283,19 +283,6 @@ int fpu__copy(struct task_struct *dst, s
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
@@ -381,46 +368,100 @@ static inline void load_fpregs_from_init
 	pkru_write_default();
 }
 
+static inline unsigned int init_fpstate_copy_size(void)
+{
+	if (!use_xsave())
+		return fpu_kernel_xstate_size;
+
+	/* XSAVE(S) just needs the legacy and the xstate header part */
+	return sizeof(init_fpstate.xsave);
+}
+
+/* Temporary workaround. Will be removed once PKRU and XSTATE are distangled. */
+static inline void pkru_set_default_in_xstate(struct xregs_state *xsave)
+{
+	struct pkru_state *pk;
+
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+	/*
+	 * Force XFEATURE_PKRU to be set in the header otherwise
+	 * get_xsave_addr() does not work and it also needs to be set to
+	 * make XRSTOR(S) load it.
+	 */
+	xsave->header.xfeatures |= XFEATURE_MASK_PKRU;
+	pk = get_xsave_addr(xsave, XFEATURE_PKRU);
+	pk->pkru = pkru_get_init_value();
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
+	 * the correct content already except for PKRU.
+	 */
+	memcpy(&fpu->state, &init_fpstate, init_fpstate_copy_size());
+	pkru_set_default_in_xstate(&fpu->state.xsave);
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
 
+	fpregs_lock();
 	if (!static_cpu_has(X86_FEATURE_FPU)) {
-		fpu__drop(fpu);
-		fpu__initialize(fpu);
+		fpu_reset_fpstate();
+		fpregs_unlock();
 		return;
 	}
 
-	fpregs_lock();
-
-	if (user_only) {
-		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
-		    xfeatures_mask_supervisor())
-			xrstor_from_kernel(&fpu->state.xsave,
-					     xfeatures_mask_supervisor());
-		load_fpregs_from_init_fpstate(xfeatures_mask_user());
-	} else {
-		load_fpregs_from_init_fpstate(xfeatures_mask_all);
+	/*
+	 * Ensure that current's supervisor states are loaded into their
+	 * corresponding registers.
+	 */
+	if (xfeatures_mask_supervisor() &&
+	    !fpregs_state_valid(fpu, smp_processor_id())) {
+		xrstor_from_kernel(&fpu->state.xsave,
+				   xfeatures_mask_supervisor());
 	}
 
+	/* Reset user states in registers. */
+	load_fpregs_from_init_fpstate(xfeatures_mask_user());
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
@@ -199,6 +199,15 @@ int copy_thread(unsigned long clone_flag
 	return ret;
 }
 
+static void pkru_flush_thread(void)
+{
+	/*
+	 * If PKRU is enabled the default PKRU value has to be loaded into
+	 * the hardware right here (similar to context switch).
+	 */
+	pkru_write_default();
+}
+
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
@@ -207,6 +216,7 @@ void flush_thread(void)
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
 	fpu_flush_thread();
+	pkru_flush_thread();
 }
 
 void disable_TSC(void)

