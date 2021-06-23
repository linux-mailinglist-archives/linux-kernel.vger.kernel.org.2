Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36953B1A12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhFWM20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36808 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhFWM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:27:12 -0400
Message-Id: <20210623121457.804115017@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lxQiNshRMEz1wUQuKKb+ne9kj37Zxi6y6WEVTTrflSE=;
        b=OtJi4e5zQFgCDuIw3/sv6WdmxLaOyJ54pfdTuGshn7gJgsX+V+Ay7zyOwM60bVxhWaiTPr
        1LKiH/KU9l7NNyi/F3sF+8XNP9GE1lvCmcBmJOGvFpOdHgsI50TOpRmIRVsjA/CLhIGM1d
        RsnDupQ0oT7i9KSGpgVOI3fnbuA3gApgRKGtEB7X0koDICw2lIe3xMyn3c/vN53sKMdtfG
        kCdbK61GXGTmfFd3SAZcPHQyAApOLLQGnnNc2Ro+lq4+srjC/joct9Sazgn9YFTEcbOdw+
        CNlo0kkd0LWMSLKqtq8AzyojoneYIFY5iye3tbnBE1AJk190VgIhqw3SWLhC5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lxQiNshRMEz1wUQuKKb+ne9kj37Zxi6y6WEVTTrflSE=;
        b=0gcoAcekwywrMZYG7L/SgfzsqP3Y3TjazT+YSwl7zNlA9hgCXpFcL0OvJhU5PGej2M0Gsc
        CN+O5MpKcnprWJBA==
Date:   Wed, 23 Jun 2021 14:02:32 +0200
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
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 65/65] x86/fpu/signal: Let xrstor handle the features to init
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to do an extra XRSTOR from initfp_state for feature bits
which have been cleared by user space in the FX magic xfeatures storage.

Just clear them in the task's XSTATE header and do a full restore which
will put these cleared features into init state.

There is no real difference in performance because the current code already
does a full restore when the xfeatures bits are preserved as the signal
frame setup has stored them, which is the full UABI feature set.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/signal.c |   89 ++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 58 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -220,36 +220,6 @@ int copy_fpstate_to_sigframe(void __user
 	return 0;
 }
 
-static inline void
-sanitize_restored_user_xstate(union fpregs_state *state,
-			      struct user_i387_ia32_struct *ia32_env, u64 mask)
-{
-	struct xregs_state *xsave = &state->xsave;
-	struct xstate_header *header = &xsave->header;
-
-	if (use_xsave()) {
-		/*
-		 * Clear all feature bits which are not set in mask.
-		 *
-		 * Supervisor state has to be preserved. The sigframe
-		 * restore can only modify user features, i.e. @mask
-		 * cannot contain them.
-		 */
-		header->xfeatures &= mask | xfeatures_mask_supervisor();
-	}
-
-	if (use_fxsr()) {
-		/*
-		 * mscsr reserved bits must be masked to zero for security
-		 * reasons.
-		 */
-		xsave->i387.mxcsr &= mxcsr_feature_mask;
-
-		if (ia32_env)
-			convert_to_fxsr(&state->fxsave, ia32_env);
-	}
-}
-
 static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
 				      bool fx_only)
 {
@@ -352,6 +322,8 @@ static int __fpu_restore_sig(void __user
 		fx_only = !fx_sw_user.magic1;
 		state_size = fx_sw_user.xstate_size;
 		user_xfeatures = fx_sw_user.xfeatures;
+	} else {
+		user_xfeatures = XFEATURE_MASK_FPSSE;
 	}
 
 	if (likely(!ia32_fxstate)) {
@@ -395,54 +367,55 @@ static int __fpu_restore_sig(void __user
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
+	__cpu_invalidate_fpregs_state();
 	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask_uabi() & ~user_xfeatures;
-
 		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
 			return ret;
+	} else {
+		if (__copy_from_user(&fpu->state.fxsave, buf_fx,
+				     sizeof(fpu->state.fxsave)))
+			return -EFAULT;
 
-		sanitize_restored_user_xstate(&fpu->state, &env, user_xfeatures);
+		/* Reject invalid MXCSR values. */
+		if (fpu->state.fxsave.mxcsr & mxcsr_feature_mask)
+			return -EINVAL;
 
-		fpregs_lock();
-		if (unlikely(init_bv))
-			os_xrstor(&init_fpstate.xsave, init_bv);
+		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
+		if (use_xsave())
+			fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
+	}
+
+	/* Fold the legacy FP storage */
+	convert_to_fxsr(&fpu->state.fxsave, &env);
 
+	fpregs_lock();
+	if (use_xsave()) {
 		/*
-		 * Restore previously saved supervisor xstates along with
-		 * copied-in user xstates.
+		 * Remove all UABI feature bits not set in user_xfeatures
+		 * from the memory xstate header which makes the full
+		 * restore below bring them into init state. This works for
+		 * fx_only mode as well because that has only FP and SSE
+		 * set in user_xfeatures.
+		 *
+		 * Preserve supervisor states!
 		 */
-		ret = os_xrstor_safe(&fpu->state.xsave,
-				     user_xfeatures | xfeatures_mask_supervisor());
+		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
+		fpu->state.xsave.header.xfeatures &= mask;
+		ret = os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all);
 	} else {
-		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
-		if (ret)
-			return -EFAULT;
-
-		sanitize_restored_user_xstate(&fpu->state, &env, user_xfeatures);
-
-		fpregs_lock();
-		if (use_xsave()) {
-			u64 init_bv;
-
-			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
-			os_xrstor(&init_fpstate.xsave, init_bv);
-		}
-
 		ret = fxrstor_safe(&fpu->state.fxsave);
 	}
 
-	if (!ret)
+	if (likely(!ret))
 		fpregs_mark_activate();
-	else
-		fpregs_deactivate(fpu);
+
 	fpregs_unlock();
 	return ret;
 }
-
 static inline int xstate_sigframe_size(void)
 {
 	return use_xsave() ? fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE :

