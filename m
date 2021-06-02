Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8532398657
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhFBKVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhFBKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:20:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3C8C06134F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:59 -0700 (PDT)
Message-Id: <20210602101618.851242793@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622629077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NUo/8RczCbG1LUttufcHDujF4ig88QyWMBI5XJrKALE=;
        b=VmKVWu+60aBAAsoQqiTbbTnDSHlN41wsgZePTC8r0DQ8ePKTJ2XTxrIvtGHGILSDZM3Ijh
        cUbU83zc+R04zCFfaDo/FmYyDQ7ijS02HddoMmnVCw9S1/BQxLrbrxLJib+4kMKy9Y0dAH
        8V6wk9+CPpXr9t2Wn7NHlahCKdnlO5puEEmeXw6JKE5u/OXfBkdNqkebBMAfYK4Qf/Oqzo
        gXbWEzx+8qHbnq84FltuN1+1wVkRuYpQ/xqiWXo/t+hf/T97IxyOlDXk88ax/M/pb5Oa0C
        tJTEMBB2I1MRgRP8wb6sCAEWeQn9ag6tlF19cpnrkUnYuDcGrRus1U4fZrS6xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622629077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NUo/8RczCbG1LUttufcHDujF4ig88QyWMBI5XJrKALE=;
        b=oamAG9rK/rN+FG/Yr5EXi5SlBSBTrTCVqrmU9vp0FXOowFxZy7vXPV6y00tWCxAcHKujKh
        zawOMvr6xTnTgxBQ==
Date:   Wed, 02 Jun 2021 11:55:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [patch 5/8] x86/fpu: Sanitize xstateregs_set()
References: <20210602095543.149814064@linutronix.de>
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
 arch/x86/kernel/fpu/regset.c |   41 +++++++++++++++++------------------------
 arch/x86/kernel/fpu/xstate.c |   10 ++++++----
 2 files changed, 23 insertions(+), 28 deletions(-)

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

