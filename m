Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC839CBE5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFFAeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:34:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhFFAeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:34:15 -0400
Message-Id: <20210606001323.528989427@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622939546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NisK4QL4JxeQMe3rybJHkGhP8/ccYudX8CkJOaQNias=;
        b=hLArUe86CWWlgnJ68N6luFy+/HGsB3VOgm5k/Iy+ZOMnD0rWa8IIv4v9dfN+3rRWG1FGqV
        HAc8nKLfCtIYi98GYKZN7k+oL3rF8G+6ZnHoLjm3tDFD3bqLEYQljVMEalXdFRMR4QL6ep
        QddVf9TfITXrqr82wJV2kWe81Ug2SUfpozc59mN3Emi9nxUn9y0IZldjckyj7qO+4P/oqL
        unW+GyScEKNNbdskQsOZzUs9HcS16WWb6MoDothUN2E00WhebYrXQKfRZvCmK/dDg0Xpz2
        6BSzQL8gTdtLT6YDyDlPLbZ6MRH+s/VrDqd9Ka82e7mmj4eDXH+2/y77tZogUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622939546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NisK4QL4JxeQMe3rybJHkGhP8/ccYudX8CkJOaQNias=;
        b=4PAkn2dmXIrav43m1TzhekiVvsQpTKnrFNGSntw/wRSNZKPYWkBI/NxBUP6PwoO6r2sQ/w
        WNAnmPpcXoy+C+AA==
Date:   Sun, 06 Jun 2021 01:47:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 06/14] x86/fpu: Sanitize xstateregs_set()
References: <20210605234742.712464974@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Move the validate_user_xstate_header() static here - Borislav
    Use copy_from_user() - Dave, Yu
    Rename xbuf to tmpbuf - Borislav
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
@@ -108,7 +112,7 @@ int xstateregs_set(struct task_struct *t
 		  const void *kbuf, const void __user *ubuf)
 {
 	struct fpu *fpu = &target->thread.fpu;
-	struct xregs_state *xsave;
+	struct xregs_state *tmpbuf = NULL;
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
+		tmpbuf = vmalloc(count);
+		if (!tmpbuf)
+			return -ENOMEM;
+		if (copy_from_user(tmpbuf, ubuf, count)) {
+			ret = -EFAULT;
+			goto out;
+		}
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
+	fpu__prepare_write(fpu);
+	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
 
+out:
+	vfree(tmpbuf);
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

