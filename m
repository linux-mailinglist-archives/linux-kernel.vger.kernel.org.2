Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688763B1A24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhFWMaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhFWM3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:29:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD14C061A28
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:50 -0700 (PDT)
Message-Id: <20210623121457.277738268@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=sZA3KOnk7DgAyRmDyoNrO9Sm8LSNXCH3IuIcQc/UnoA=;
        b=3FaD+dzKIeP9kbtDEZj9FN3YjPgLwzO4r7ihmLIGSKr2uCgwMyaC1SSUro3NeiaQqhtoiw
        k3AnHyKbtsVBsBXze9k2i+5zmslDbQO8eq1H+oe+VEDLaPSiMhZxJwaNLZ0RfhXS7VA1Vc
        jO9hYnOQoieVc3iXhVpVZVU5Z8iBdtomwJIOOrIkm9map13jXfuK5y0988K60pfFSK0hap
        d9C/FFDEOJNYJbjQu6LfdQDJe53tDfgCbqdAX5MQ5XI8tunPhDO1XOxgEp1IHfNh1LWMbk
        kGGvFm3zC3uWk3Go1RZXO2ZaEd8dvrgb1OZIej/P559KkAgVIGtoG9IYUTxNGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=sZA3KOnk7DgAyRmDyoNrO9Sm8LSNXCH3IuIcQc/UnoA=;
        b=3n/RjSZQjPN1Y/x46yMvGnjhorBeKejyAVFIvD5RjUI4obsM4BG3TclA7eN9htOoKfuzQA
        acK3THs3rD0CJnDw==
Date:   Wed, 23 Jun 2021 14:02:27 +0200
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
Subject: [patch V4 60/65] x86/fpu/signal: Sanitize the xstate check on sigframe
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize the check for the extended state magic in the FX software reserved
bytes and set the parameters for restoring fx_only in the relevant members
of fw_sw_user.

This allows further cleanups on top because the data is consistent.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V4:  Add the missing __ro_after_init (Andrew)
---
 arch/x86/kernel/fpu/signal.c |   70 ++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -15,29 +15,30 @@
 #include <asm/sigframe.h>
 #include <asm/trace/fpu.h>
 
-static struct _fpx_sw_bytes fx_sw_reserved, fx_sw_reserved_ia32;
+static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
+static struct _fpx_sw_bytes fx_sw_reserved_ia32 __ro_after_init;
 
 /*
  * Check for the presence of extended state information in the
  * user fpstate pointer in the sigcontext.
  */
-static inline int check_for_xstate(struct fxregs_state __user *buf,
-				   void __user *fpstate,
-				   struct _fpx_sw_bytes *fx_sw)
+static inline int check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
+					   struct _fpx_sw_bytes *fx_sw)
 {
 	int min_xstate_size = sizeof(struct fxregs_state) +
 			      sizeof(struct xstate_header);
+	void __user *fpstate = fxbuf;
 	unsigned int magic2;
 
-	if (__copy_from_user(fx_sw, &buf->sw_reserved[0], sizeof(*fx_sw)))
-		return -1;
+	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
+		return -EFAULT;
 
 	/* Check for the first magic field and other error scenarios. */
 	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
 	    fx_sw->xstate_size < min_xstate_size ||
 	    fx_sw->xstate_size > fpu_user_xstate_size ||
 	    fx_sw->xstate_size > fx_sw->extended_size)
-		return -1;
+		goto setfx;
 
 	/*
 	 * Check for the presence of second magic word at the end of memory
@@ -45,10 +46,18 @@ static inline int check_for_xstate(struc
 	 * fpstate layout with out copying the extended state information
 	 * in the memory layout.
 	 */
-	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size))
-	    || magic2 != FP_XSTATE_MAGIC2)
-		return -1;
+	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
+		return -EFAULT;
 
+	if (likely(magic2 == FP_XSTATE_MAGIC2))
+		return 0;
+setfx:
+	trace_x86_fpu_xstate_check_failed(&current->thread.fpu);
+
+	/* Set the parameters for fx only state */
+	fx_sw->magic1 = 0;
+	fx_sw->xstate_size = sizeof(struct fxregs_state);
+	fx_sw->xfeatures = XFEATURE_MASK_FPSSE;
 	return 0;
 }
 
@@ -213,21 +222,15 @@ int copy_fpstate_to_sigframe(void __user
 
 static inline void
 sanitize_restored_user_xstate(union fpregs_state *state,
-			      struct user_i387_ia32_struct *ia32_env,
-			      u64 user_xfeatures, int fx_only)
+			      struct user_i387_ia32_struct *ia32_env, u64 mask)
 {
 	struct xregs_state *xsave = &state->xsave;
 	struct xstate_header *header = &xsave->header;
 
 	if (use_xsave()) {
 		/*
-		 * Clear all feature bits which are not set in
-		 * user_xfeatures and clear all extended features
-		 * for fx_only mode.
-		 */
-		u64 mask = fx_only ? XFEATURE_MASK_FPSSE : user_xfeatures;
-
-		/*
+		 * Clear all feature bits which are not set in mask.
+		 *
 		 * Supervisor state has to be preserved. The sigframe
 		 * restore can only modify user features, i.e. @mask
 		 * cannot contain them.
@@ -286,24 +289,19 @@ static int __fpu_restore_sig(void __user
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
 	u64 user_xfeatures = 0;
-	int fx_only = 0;
+	bool fx_only = false;
 	int ret = 0;
 
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
-		if (unlikely(check_for_xstate(buf_fx, buf_fx, &fx_sw_user))) {
-			/*
-			 * Couldn't find the extended state information in the
-			 * memory layout. Restore just the FP/SSE and init all
-			 * the other extended state.
-			 */
-			state_size = sizeof(struct fxregs_state);
-			fx_only = 1;
-			trace_x86_fpu_xstate_check_failed(fpu);
-		} else {
-			state_size = fx_sw_user.xstate_size;
-			user_xfeatures = fx_sw_user.xfeatures;
-		}
+
+		ret = check_xstate_in_sigframe(buf_fx, &fx_sw_user);
+		if (unlikely(ret))
+			return ret;
+
+		fx_only = !fx_sw_user.magic1;
+		state_size = fx_sw_user.xstate_size;
+		user_xfeatures = fx_sw_user.xfeatures;
 	}
 
 	if (!ia32_fxstate) {
@@ -403,8 +401,7 @@ static int __fpu_restore_sig(void __user
 		if (ret)
 			return ret;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
-					      fx_only);
+		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
 
 		fpregs_lock();
 		if (unlikely(init_bv))
@@ -422,8 +419,7 @@ static int __fpu_restore_sig(void __user
 		if (ret)
 			return -EFAULT;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
-					      fx_only);
+		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
 
 		fpregs_lock();
 		if (use_xsave()) {

