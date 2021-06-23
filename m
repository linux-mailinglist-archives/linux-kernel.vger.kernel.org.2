Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5993B19EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFWM0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhFWM0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DDAC0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:23:55 -0700 (PDT)
Message-Id: <20210623121452.805327286@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Kmbt6E+mVkDsbmVbrnwpwdJxLTX7f6bLSJV9dbGQ5WE=;
        b=hQFnR/cw4SrovZqpEuXxBMjRGoDljVpGtGe/hDL/gO8S4UbZFDb9GGh/8dlcOZmLeBys8/
        N4c0MfzGVbdXfMA24RI2kTdMw5pPi7dvdI8aPNBZIRBIeahBeYnn3OiE5p3Kmz6Sb6FGsP
        nE/rmd+KweFsas6yZgsi/bs0hgA7s1ON/zw4TUgST4Q33ho7JXKysaNwfKUoHeZORH7GqI
        vHnEwC3p2mgnsWWNZCpNMKfJxQNDSd1e3a+bglGF9mAWGuVjzBeFNw2RELKMSExNiNLdyE
        M75BceIVpNQ8w4V7F/XwmYb1SoiypNZqOI47AO5IV1CzVXSvUaWRg4We3hFVtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Kmbt6E+mVkDsbmVbrnwpwdJxLTX7f6bLSJV9dbGQ5WE=;
        b=q3ogPcXHbylorX+SEk5GnlKdcz6AdmtKaIuRYAbvA3jsX1laEgydnzTrMsSdXBIAYsFG4b
        BceSrIHnBvK+DnCg==
Date:   Wed, 23 Jun 2021 14:01:42 +0200
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
Subject: [patch V4 15/65] x86/fpu: Make copy_xstate_to_kernel() usable for
 [x]fpregs_get()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When xsave with init state optimization is used then a component's state
in the task's xsave buffer can be stale when the corresponding feature bit
is not set.

fpregs_get() and xfpregs_get() invoke fpstate_sanitize_xstate() to update
the task's xsave buffer before retrieving the FX or FP state. That's just
duplicated code as copy_xstate_to_kernel() already handles this correctly.

Add a copy mode argument to the function which allows to restrict the state
copy to the FP and SSE features.

Also rename the function to copy_xstate_to_uabi_buf() so the name reflects
what it is doing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V3: Rename to copy_xstate_to_uabi_buf() - Boris
V2: New patch
---
 arch/x86/include/asm/fpu/xstate.h |   12 +++++++++-
 arch/x86/kernel/fpu/regset.c      |    2 -
 arch/x86/kernel/fpu/xstate.c      |   42 ++++++++++++++++++++++++++++----------
 3 files changed, 42 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -103,12 +103,20 @@ extern void __init update_regset_xstate_
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
-struct membuf;
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 void copy_supervisor_to_kernel(struct xregs_state *xsave);
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
+enum xstate_copy_mode {
+	XSTATE_COPY_FP,
+	XSTATE_COPY_FX,
+	XSTATE_COPY_XSAVE,
+};
+
+struct membuf;
+void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+			     enum xstate_copy_mode mode);
+
 #endif
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -94,7 +94,7 @@ int xstateregs_get(struct task_struct *t
 
 	fpu__prepare_read(fpu);
 
-	copy_xstate_to_kernel(to, &fpu->state.xsave);
+	copy_xstate_to_uabi_buf(to, &fpu->state.xsave, XSTATE_COPY_XSAVE);
 	return 0;
 }
 
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1068,14 +1068,20 @@ static void copy_feature(bool from_xstat
 	membuf_write(to, from_xstate ? xstate : init_xstate, size);
 }
 
-/*
- * Convert from kernel XSAVE or XSAVES compacted format to UABI
- * non-compacted format and copy to a kernel-space ptrace buffer.
+/**
+ * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
+ * @to:		membuf descriptor
+ * @xsave:	The kernel xstate buffer to copy from
+ * @copy_mode:	The requested copy mode
  *
- * It supports partial copy but pos always starts from zero. This is called
- * from xstateregs_get() and there we check the CPU has XSAVE.
+ * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
+ * format, i.e. from the kernel internal hardware dependent storage format
+ * to the requested @mode. UABI XSTATE is always uncompacted!
+ *
+ * It supports partial copy but @to.pos always starts from zero.
  */
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
+void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+			     enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
 	struct xregs_state *xinit = &init_fpstate.xsave;
@@ -1083,12 +1089,22 @@ void copy_xstate_to_kernel(struct membuf
 	unsigned int zerofrom;
 	int i;
 
-	/*
-	 * The destination is a ptrace buffer; we put in only user xstates:
-	 */
-	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= xfeatures_mask_user();
+
+	/* Mask out the feature bits depending on copy mode */
+	switch (copy_mode) {
+	case XSTATE_COPY_FP:
+		header.xfeatures &= XFEATURE_MASK_FP;
+		break;
+
+	case XSTATE_COPY_FX:
+		header.xfeatures &= XFEATURE_MASK_FP | XFEATURE_MASK_SSE;
+		break;
+
+	case XSTATE_COPY_XSAVE:
+		header.xfeatures &= xfeatures_mask_user();
+		break;
+	}
 
 	/* Copy FP state up to MXCSR */
 	copy_feature(header.xfeatures & XFEATURE_MASK_FP, &to, &xsave->i387,
@@ -1109,6 +1125,9 @@ void copy_xstate_to_kernel(struct membuf
 		     &to, &xsave->i387.xmm_space, &xinit->i387.xmm_space,
 		     sizeof(xsave->i387.xmm_space));
 
+	if (copy_mode != XSTATE_COPY_XSAVE)
+		goto out;
+
 	/* Zero the padding area */
 	membuf_zero(&to, sizeof(xsave->i387.padding));
 
@@ -1150,6 +1169,7 @@ void copy_xstate_to_kernel(struct membuf
 		zerofrom = xstate_offsets[i] + xstate_sizes[i];
 	}
 
+out:
 	if (to.left)
 		membuf_zero(&to, to.left);
 }

