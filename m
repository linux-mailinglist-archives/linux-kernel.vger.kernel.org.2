Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE07D398659
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhFBKVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhFBKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:20:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72B6C0613CE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:18:01 -0700 (PDT)
Message-Id: <20210602101619.066082349@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622629080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XRwu2tBwbJbE66W8htkdqYDObArz5fBrfQZs42pzrI0=;
        b=JtSSUTWPqaNyQsZhzDxer5xGQ0x+tMWdOZiw6AhGpVlHeHeWw/Cwgql/5VsYEsBcsxkrRt
        3LyTHsbcIZmaJsZOr/jhgeyQ8errWJlWwbIC3vnN5y4mXmj7g3h+g/a+btVRaNecqO0Ngb
        +3BLsgUwwKL+t/P6VpHfTKUJeI7cwW3Nofry5OvlVDZJ337G58sA8wSHE+cAcsghFmwxPe
        /P1bUX8j9RYRu+Gr9KGc90eSe5mTvO/RbV/qItAjppgXc+0jtdX2xd0j25o/Kf0uqgodXP
        QEsg7fb1Jpib5Mm0Vx0KoCN46zu3jEMM9PXIR2OYF9Vio0X6LVXz2663/LDOyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622629080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XRwu2tBwbJbE66W8htkdqYDObArz5fBrfQZs42pzrI0=;
        b=rrpJ42+DFyvDoxxICb4NWT3D9hQANHPK5RFVCWy6ZigGYx7Jxbgw2FrRCAZ7mFWyuPqM+o
        ohFHauS+p21TnqBA==
Date:   Wed, 02 Jun 2021 11:55:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [patch 7/8] x86/fpu: Clean up the fpu__clear() variants
References: <20210602095543.149814064@linutronix.de>
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

[ Changelog polished by Dave Hansen ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/core.c |   62 ++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 20 deletions(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -354,45 +354,67 @@ static inline void copy_init_fpstate_to_
 }
 
 /*
- * Clear the FPU state back to init state.
- *
- * Called by sys_execve(), by the signal handler code and by various
- * error paths.
+ * Reset current's user FPU states to the init states.  current's
+ * supervisor states, if any, are not modified by this function.  The
+ * caller guarantees that the XSTATE header in memory is intact.
  */
-static void fpu__clear(struct fpu *fpu, bool user_only)
+void fpu__clear_user_states(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
 	if (!static_cpu_has(X86_FEATURE_FPU)) {
-		fpu__drop(fpu);
-		fpu__initialize(fpu);
+		fpu__clear_all(fpu);
 		return;
 	}
 
 	fpregs_lock();
 
-	if (user_only) {
-		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
-		    xfeatures_mask_supervisor())
-			copy_kernel_to_xregs(&fpu->state.xsave,
-					     xfeatures_mask_supervisor());
-		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
-	} else {
-		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
+	/*
+	 * Ensure that current's supervisor states are loaded into
+	 * their corresponding registers.
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
+	 * Now all FPU registers have their desired values.  Inform the
+	 * FPU state machine that current's FPU registers are in the
+	 * hardware registers.
+	 */
 	fpregs_mark_activate();
+
 	fpregs_unlock();
 }
 
-void fpu__clear_user_states(struct fpu *fpu)
-{
-	fpu__clear(fpu, true);
-}
 
+/*
+ * Reset current's FPU registers (user and supervisor) to their INIT values.
+ * This is used by execve(); out of an abundance of caution, it completely
+ * wipes and resets the XSTATE buffer in memory.
+ *
+ * Note that XSAVE (unlike XSAVES) expects the XSTATE buffer in memory to
+ * be valid, so there are certain forms of corruption of the XSTATE buffer
+ * in memory that would survive initializing the FPU registers and XSAVEing
+ * them to memory.
+ */
 void fpu__clear_all(struct fpu *fpu)
 {
-	fpu__clear(fpu, false);
+	fpregs_lock();
+	fpu__drop(fpu);
+	/*
+	 * This does not change the actual hardware registers; when
+	 * fpu__clear_all() returns, TIF_NEED_FPU_LOAD will be set, and a
+	 * subsequent exit to user mode will reload the hardware registers
+	 * from memory.
+	 */
+	fpu__initialize(fpu);
+	fpregs_unlock();
 }
 
 /*

