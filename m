Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF04398F79
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhFBQDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:03:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFBQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:02:58 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622649673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=36dsNpISSMuXFqYfQPbjUuPj07IxMjRA/6SmqodzER8=;
        b=QqKvEHSMqnGN1n0adovTmdj9SDIpBdhK+u2GyiDzNgTX6DdviDl9nYELyZp1cgbfONvLPN
        2SnjonKF5B6k/TVt8cUA9A3o14FvoEHOfXPJFGamyeqQ33vB5BrRwTR4v86yBLh0mPtWsN
        Pdh80MJwNLRSxwO3ojNSMzxCtKYeCmaaV8UJVvrCrUGUs8l0QUanhjbKkO1vv/2rLnaFAm
        SOya/UwN35DUA+wwPY672sjuVn4AtpnyKIFO0xB1j8lfMItkPeg1vxzFJisesa65LPPGiw
        4rbqpYNMh9HwYq1bhLovh0zb/AZslaKIv5WjQnXTDONQ0WUaSrmxtwIc/TIthQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622649673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=36dsNpISSMuXFqYfQPbjUuPj07IxMjRA/6SmqodzER8=;
        b=DWIiNcJZQPpQ5FTTQlIiksa7x/TYhb+DyyonYIfmvHaXDBrAPSwRHLM8JrUotSkyQD8vYi
        jomYlO+wxEPbwxCA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [patch V2 5/8] x86/fpu: Sanitize xstateregs_set()
In-Reply-To: <20210602101618.851242793@linutronix.de>
References: <20210602095543.149814064@linutronix.de> <20210602101618.851242793@linutronix.de>
Date:   Wed, 02 Jun 2021 18:01:13 +0200
Message-ID: <87sg20z25y.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xstateregs_set() operates on a stopped task and tries to copy the provided
buffer into the tasks fpu.state.xsave buffer.

Any error while copying or invalid state detected after copying results in
wiping the target tasks FPU state completely including supervisor states.

That's just wrong. The caller supplied invalid data or has a problem with
unmapped memory, so there is absolutely no justification to wreckage the
target.

Fix this with the following modifications:

 1) If data has to be copied from userspace, allocate a buffer and copy from
    user first.

 2) Use copy_kernel_to_xstate() unconditionally so that header checking
    works correctly.

 3) Return on error without wreckaging the target state.

This prevents corrupting supervisor states and lets the caller deal with
the problem it caused in the first place.

Make validate_user_xstate_header() static as this was the last user
outside of xstate.c

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Move the validate_user_xstate_header() static here
---
 arch/x86/include/asm/fpu/xstate.h |    4 ---
 arch/x86/kernel/fpu/regset.c      |   41 +++++++++++++++-----------------------
 arch/x86/kernel/fpu/xstate.c      |   12 ++++++-----
 3 files changed, 24 insertions(+), 33 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -112,8 +112,4 @@ void copy_supervisor_to_kernel(struct xr
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
-
-/* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_user_xstate_header(const struct xstate_header *hdr);
-
 #endif
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -6,8 +6,12 @@
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
+
+#include <linux/vmalloc.h>
+
 #include <linux/sched/task_stack.h>
 
+
 /*
  * The xstateregs_active() routine is the same as the regset_fpregs_active() routine,
  * as the "regset->n" for the xstate regset will be updated based on the feature
@@ -107,8 +111,8 @@ int xstateregs_set(struct task_struct *t
 		  unsigned int pos, unsigned int count,
 		  const void *kbuf, const void __user *ubuf)
 {
+	struct xregs_state *xsave, *xbuf = NULL;
 	struct fpu *fpu = &target->thread.fpu;
-	struct xregs_state *xsave;
 	int ret;
 
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
@@ -120,32 +124,21 @@ int xstateregs_set(struct task_struct *t
 	if (pos != 0 || count != fpu_user_xstate_size)
 		return -EFAULT;
 
-	xsave = &fpu->state.xsave;
-
-	fpu__prepare_write(fpu);
-
-	if (using_compacted_format()) {
-		if (kbuf)
-			ret = copy_kernel_to_xstate(xsave, kbuf);
-		else
-			ret = copy_user_to_xstate(xsave, ubuf);
-	} else {
-		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
-		if (!ret)
-			ret = validate_user_xstate_header(&xsave->header);
+	if (!kbuf) {
+		xbuf = vmalloc(count);
+		if (!xbuf)
+			return -ENOMEM;
+		ret = user_regset_copyin(&pos, &count, NULL, &ubuf, xbuf, 0, -1);
+		if (ret)
+			goto out;
 	}
 
-	/*
-	 * mxcsr reserved bits must be masked to zero for security reasons.
-	 */
-	xsave->i387.mxcsr &= mxcsr_feature_mask;
-
-	/*
-	 * In case of failure, mark all states as init:
-	 */
-	if (ret)
-		fpstate_init(&fpu->state);
+	xsave = &fpu->state.xsave;
+	fpu__prepare_write(fpu);
+	ret = copy_kernel_to_xstate(xsave, kbuf ? kbuf : xbuf);
 
+out:
+	vfree(xbuf);
 	return ret;
 }
 
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -515,7 +515,7 @@ int using_compacted_format(void)
 }
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_user_xstate_header(const struct xstate_header *hdr)
+static int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
 	if (hdr->xfeatures & ~xfeatures_mask_user())
@@ -1172,14 +1172,16 @@ int copy_kernel_to_xstate(struct xregs_s
 	 */
 	xsave->header.xfeatures |= hdr.xfeatures;
 
+	/* mxcsr reserved bits must be masked to zero for security reasons. */
+	xsave->i387.mxcsr &= mxcsr_feature_mask;
+
 	return 0;
 }
 
 /*
- * Convert from a ptrace or sigreturn standard-format user-space buffer to
- * kernel XSAVES format and copy to the target thread. This is called from
- * xstateregs_set(), as well as potentially from the sigreturn() and
- * rt_sigreturn() system calls.
+ * Convert from a sigreturn standard-format user-space buffer to kernel
+ * XSAVES format and copy to the target thread. This is called from the
+ * sigreturn() and rt_sigreturn() system calls.
  */
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 {
