Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30A3B19E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFWM0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhFWM0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:04 -0400
Message-Id: <20210623121452.214903673@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dPjwl3cpgjhs11cwwzdWDYGz9mDRahzeqRf22TQA69s=;
        b=IfMmfXUCqIBp1yHUmTAkmyX08O/cqrrjfwq+6PQA+iUwh1X+1foaEP4TZAwnawuk7th4DP
        6r1lRHMLg/wlol9jekkr2SY4KgeXH9NZ0j1a6TJcr8G/Oeh3F2BpbXyspt4CRPsFREdzeA
        OFX4SfjAr18z2IFhxtl2pkNNezbGrZardIKjfjBmYJ1HDrWledsLxXFP+m6qBvYKTNPzSQ
        LRSYwMrNn0wIcSFubT9x982Vx8ABAXwPIbpM+o/rQhEuAppA8fsISZq5KoWfWQaxswmGRm
        K+XvNV0sp8nvVuTh9J+tp2Ma8Cp/GpdNPGS7hApEEjrsQ93PM/a7Nqly5ci8zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dPjwl3cpgjhs11cwwzdWDYGz9mDRahzeqRf22TQA69s=;
        b=7cRxJl/O1uYz2qZ+Zg48VFEwQrGoo2HlmkEpBjOxWU26kTCxuUgcGSSeLtO52khJeTrK2Q
        cnDW4iqL5CkN0bCw==
Date:   Wed, 23 Jun 2021 14:01:36 +0200
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
Subject: [patch V4 09/65] x86/fpu: Sanitize xstateregs_set()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xstateregs_set() operates on a stopped task and tries to copy the provided
buffer into the task's fpu.state.xsave buffer.

Any error while copying or invalid state detected after copying results in
wiping the target task's FPU state completely including supervisor states.

That's just wrong. The caller supplied invalid data or has a problem with
unmapped memory, so there is absolutely no justification to corrupt the
target state.

Fix this with the following modifications:

 1) If data has to be copied from userspace, allocate a buffer and copy from
    user first.

 2) Use copy_kernel_to_xstate() unconditionally so that header checking
    works correctly.

 3) Return on error without corrupting the target state.

This prevents corrupting states and lets the caller deal with the problem
it caused in the first place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/xstate.h |    4 ---
 arch/x86/kernel/fpu/regset.c      |   44 +++++++++++++++-----------------------
 arch/x86/kernel/fpu/xstate.c      |   14 ++++++------
 3 files changed, 26 insertions(+), 36 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -111,8 +111,4 @@ void copy_supervisor_to_kernel(struct xr
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
-
-/* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_user_xstate_header(const struct xstate_header *hdr);
-
 #endif
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -2,11 +2,13 @@
 /*
  * FPU register's regset abstraction, for ptrace, core dumps, etc.
  */
+#include <linux/sched/task_stack.h>
+#include <linux/vmalloc.h>
+
 #include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
-#include <linux/sched/task_stack.h>
 
 /*
  * The xstateregs_active() routine is the same as the regset_fpregs_active() routine,
@@ -108,10 +110,10 @@ int xstateregs_set(struct task_struct *t
 		  const void *kbuf, const void __user *ubuf)
 {
 	struct fpu *fpu = &target->thread.fpu;
-	struct xregs_state *xsave;
+	struct xregs_state *tmpbuf = NULL;
 	int ret;
 
-	if (!boot_cpu_has(X86_FEATURE_XSAVE))
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
 	/*
@@ -120,32 +122,22 @@ int xstateregs_set(struct task_struct *t
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
+
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
@@ -543,7 +543,7 @@ int using_compacted_format(void)
 }
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_user_xstate_header(const struct xstate_header *hdr)
+static int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
 	if (hdr->xfeatures & ~xfeatures_mask_user())
@@ -1155,7 +1155,7 @@ void copy_xstate_to_kernel(struct membuf
 }
 
 /*
- * Convert from a ptrace standard-format kernel buffer to kernel XSAVES format
+ * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
  * and copy to the target thread. This is called from xstateregs_set().
  */
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
@@ -1202,14 +1202,16 @@ int copy_kernel_to_xstate(struct xregs_s
 	 */
 	xsave->header.xfeatures |= hdr.xfeatures;
 
+	/* mxcsr reserved bits must be masked to zero for historical reasons. */
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
+ * XSAVE[S] format and copy to the target thread. This is called from the
+ * sigreturn() and rt_sigreturn() system calls.
  */
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 {

