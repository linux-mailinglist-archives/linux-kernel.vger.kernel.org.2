Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502663A6C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhFNQkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhFNQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217BC0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:04 -0700 (PDT)
Message-Id: <20210614155355.143470533@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EWaRMSqejDftiNy92lRUsUGuuW/s+IngIiC5Pv1YPC0=;
        b=dCkFmNIVCJOH9roM6dkZLlEg0H2qS1S5kS2aiEpJfeCzoQvqjrp2syTIZihgLPsjN4puFd
        2P1STAANPtQ3R1xHMjJNsVzCxjCVtha2O1ubWDjMAXhcxH6nKYa1+6F1G+lRdji7aRE9We
        6x+PUquBL/pq5OrvwwFR3o34T/NRSPn0X7uXYRHEaJ96PVZUqyg1/Qgndbi+5aXuJ4xicv
        3sZsB9L9zhpTYPqyi5HDYTDNOKvm0O2aQ6IyH7EKqYyM5Y+LERdJCwjDEu2rxDCxuAOP0a
        vggGALUMMaZtIwR3/JkfPA9pOXDbACWRqOpE2Qwnmz/3sT9mThRbbdAo1GkXTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EWaRMSqejDftiNy92lRUsUGuuW/s+IngIiC5Pv1YPC0=;
        b=9TEfEBUASUdHAV/iq/UNnrYSTpmPUgv8sFAF/0HcCT6hIJPCUdp6RM8zFp0q2tIirMWSJn
        WUXUAgV+yHuyu1Ag==
Date:   Mon, 14 Jun 2021 17:44:22 +0200
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
Subject: [patch V2 14/52] x86/fpu: Make copy_xstate_to_kernel() usable for
 [x]fpregs_get()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When xsave with init state optimiziation is used then a component's state
in the task's xsave buffer can be stale when the corresponding feature bit
is not set.

fpregs_get() and xfpregs_get() invoke fpstate_sanitize_xstate() to update
the task's xsave buffer before retrieving the FX or FP state. That's just
duplicated code as copy_xstate_to_kernel() already handles this correctly.

Add a copy mode argument to the function which allows to restrict the state
copy to the FP and SSE features.

Also rename the function to copy_uabi_xstate_to_membuf() so the name
reflects what it is doing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
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
+void copy_uabi_xstate_to_membuf(struct membuf to, struct xregs_state *xsave,
+				enum xstate_copy_mode mode);
+
 #endif
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -94,7 +94,7 @@ int xstateregs_get(struct task_struct *t
 
 	fpu__prepare_read(fpu);
 
-	copy_xstate_to_kernel(to, &fpu->state.xsave);
+	copy_uabi_xstate_to_membuf(to, &fpu->state.xsave, XSTATE_COPY_XSAVE);
 	return 0;
 }
 
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1062,14 +1062,20 @@ static void copy_feature(bool from_xstat
 	membuf_write(to, from_xstate ? xstate : init_xstate, size);
 }
 
-/*
- * Convert from kernel XSAVE or XSAVES compacted format to UABI
- * non-compacted format and copy to a kernel-space ptrace buffer.
+/**
+ * copy_uabi_xstate_to_membuf - Copy kernel saved xstate to a UABI buffer
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
+void copy_uabi_xstate_to_membuf(struct membuf to, struct xregs_state *xsave,
+				enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
 	struct xregs_state *xinit = &init_fpstate.xsave;
@@ -1077,12 +1083,22 @@ void copy_xstate_to_kernel(struct membuf
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
@@ -1103,6 +1119,9 @@ void copy_xstate_to_kernel(struct membuf
 		     &to, &xsave->i387.xmm_space, &xinit->i387.xmm_space,
 		     16 * 16);
 
+	if (copy_mode != XSTATE_COPY_XSAVE)
+		goto out;
+
 	/* Zero the padding area */
 	membuf_zero(&to, sizeof(xsave->i387.padding));
 
@@ -1144,6 +1163,7 @@ void copy_xstate_to_kernel(struct membuf
 		zerofrom = xstate_offsets[i] + xstate_sizes[i];
 	}
 
+out:
 	if (to.left)
 		membuf_zero(&to, to.left);
 }

