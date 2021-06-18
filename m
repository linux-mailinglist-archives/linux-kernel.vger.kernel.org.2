Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6023ACED5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhFRP17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:27:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhFRPX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:23:26 -0400
Message-Id: <20210618143451.325530702@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=U/j+bLAYpwYzPFYIEqs7Lp0XE+O/VWJCLTVgfMDK3x8=;
        b=jXQGKyHKihkT+bLlTIXCN13EhtcgRZHislSegJaPdoEkLVv/GdlpFMqisq8BtXcOiGRz+F
        aZM9D/WITmn1mr7MK0mT//xbzinXbUk183SihQwM4H9BDB1JM+N3BhxZwRWFA3TM7Px+ao
        3pdrmSVzrf9xFwX05TFm1F2qW3FLW1D6kmjXTNpyLbrFSFd3/hGNmNRNwZbSssBhY5cTNI
        ovP3Zwbq/ecBgsRilN507lnDGqkOf3hDSkqrEACaZmj8uFJglckXq7vAaBQhtuSLrcGP19
        NB7uNFAz2/loR1aqDfqVxBAiMd70VG/cAkYh+Xdh9u80D7LdiLS/kkEuO5n8jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=U/j+bLAYpwYzPFYIEqs7Lp0XE+O/VWJCLTVgfMDK3x8=;
        b=/tOIgUri/5FOGbLUKkAIotyBiAytaXj9+nw1uINMEzkpmNmmhWZ0RZ66IpBgf2KuJx5ikW
        EKRJxZxIuQTs3LBg==
Date:   Fri, 18 Jun 2021 16:19:24 +0200
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
Subject: [patch V3 61/66] x86/fpu/signal: Sanitize the xstate check on sigframe
References: <20210618141823.161158090@linutronix.de>
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
---
 arch/x86/kernel/fpu/signal.c |   69 +++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -15,29 +15,29 @@
 #include <asm/sigframe.h>
 #include <asm/trace/fpu.h>
 
-static struct _fpx_sw_bytes fx_sw_reserved, fx_sw_reserved_ia32;
+static struct _fpx_sw_bytes fx_sw_reserved, fx_sw_reserved_ia32 __ro_after_init;
 
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
@@ -45,10 +45,18 @@ static inline int check_for_xstate(struc
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
 
@@ -213,21 +221,15 @@ int copy_fpstate_to_sigframe(void __user
 
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
-		 * Clear all features bit which are not set in
-		 * user_xfeatures and clear all extended features
-		 * for fx_only mode.
-		 */
-		u64 mask = fx_only ? XFEATURE_MASK_FPSSE : user_xfeatures;
-
-		/*
+		 * Clear all features bit which are not set in mask
+		 *
 		 * Supervisor state has to be preserved. The sigframe
 		 * restore can only modify user features, i.e. @mask
 		 * cannot contain them.
@@ -286,24 +288,19 @@ static int __fpu_restore_sig(void __user
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
@@ -403,8 +400,7 @@ static int __fpu_restore_sig(void __user
 		if (ret)
 			return ret;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
-					      fx_only);
+		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
 
 		fpregs_lock();
 		if (unlikely(init_bv))
@@ -422,8 +418,7 @@ static int __fpu_restore_sig(void __user
 		if (ret)
 			return -EFAULT;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
-					      fx_only);
+		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
 
 		fpregs_lock();
 		if (use_xsave()) {

