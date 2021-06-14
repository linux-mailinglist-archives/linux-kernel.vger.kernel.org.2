Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99A43A6C07
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhFNQkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55872 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhFNQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:02 -0400
Message-Id: <20210614155354.838654334@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Zlnu3oXw/gGrOr7JN4Prh2otZVqFGj60zTxD6qZJifc=;
        b=3Ymaj70jJJ9HxkNetdnbKt44JQjviUGw77kO6UB0G6neOME4DOPvjJRPIAHMHN3tpICqeO
        /V+eebrG+G2q6MZkHGctwQ9JhwtEluUNgauX/PgB1EilgVg47BZuizEmBrhOcYx2zo7Yf/
        ZjxD2/LJHVDr8KzyVLb6YplvT6mIAEF+u5uemBFvCZpDa0f9g0ILpu9KTgKnK0Ac84zgiT
        JiT+BFbzLq8YvkbiM4vhG57kHzGSEehf0wJO8ejb+8uSxV7Ius+zysW0fhF3jIy5VMp3Ff
        Un0muB9vz7n4fxl/n+c19TpMPhXd0jIpmQ4i75LqJsuJuX5jV95qVIJYSieEwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Zlnu3oXw/gGrOr7JN4Prh2otZVqFGj60zTxD6qZJifc=;
        b=ZWq6AGd5YWE6XKijCSN4OCEtHs+VgbMtiYJ4wxGO3h4XeLqSbNByqQCWxLk448pbrG5rLB
        YWmOjHfAa4QjmaCg==
Date:   Mon, 14 Jun 2021 17:44:19 +0200
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
Subject: [patch V2 11/52] x86/fpu: Rewrite xfpregs_set()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

xfpregs_set() was incomprehensible.  Almost all of the complexity was due
to trying to support nonsensically sized writes or -EFAULT errors that
would have partially or completely overwritten the destination before
failing.  Nonsensically sized input would only have been possible using
PTRACE_SETREGSET on REGSET_XFP.  Fortunately, it appears (based on Debian
code search results) that no one uses that API at all, let alone with the
wrong sized buffer.  Failed user access can be handled more cleanly by
first copying to kernel memory.

Just rewrite it to require sensible input.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch picked up from Andy
---
 arch/x86/kernel/fpu/regset.c |   40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -47,30 +47,40 @@ int xfpregs_set(struct task_struct *targ
 		const void *kbuf, const void __user *ubuf)
 {
 	struct fpu *fpu = &target->thread.fpu;
+	struct user32_fxsr_struct newstate;
 	int ret;
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR))
+	BUILD_BUG_ON(sizeof(newstate) != sizeof(struct fxregs_state));
+
+	if (!static_cpu_has(X86_FEATURE_FXSR))
 		return -ENODEV;
 
-	fpu__prepare_write(fpu);
-	fpstate_sanitize_xstate(fpu);
+	/* No funny business with partial or oversized writes is permitted. */
+	if (pos != 0 || count != sizeof(newstate))
+		return -EINVAL;
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 &fpu->state.fxsave, 0, -1);
+				 &newstate, 0, -1);
+	if (ret)
+		return ret;
+
+	/* Mask invalid MXCSR bits (for historical reasons). */
+	newstate.mxcsr &= mxcsr_feature_mask;
+
+	fpu__prepare_write(fpu);
+
+	/* Copy the state  */
+	memcpy(&fpu->state.fxsave, &newstate, sizeof(newstate));
+
+	/* Clear xmm8..15 */
+	BUILD_BUG_ON(sizeof(fpu->state.fxsave.xmm_space) != 16 * 16);
+	memset(&fpu->state.fxsave.xmm_space[8], 0, 8 * 16);
 
-	/*
-	 * mxcsr reserved bits must be masked to zero for security reasons.
-	 */
-	fpu->state.fxsave.mxcsr &= mxcsr_feature_mask;
-
-	/*
-	 * update the header bits in the xsave header, indicating the
-	 * presence of FP and SSE state.
-	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
+	/* Mark FP and SSE as in use when XSAVE is enabled */
+	if (use_xsave())
 		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
 
-	return ret;
+	return 0;
 }
 
 int xstateregs_get(struct task_struct *target, const struct user_regset *regset,

