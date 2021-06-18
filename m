Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07753ACE97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhFRPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbhFRPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF6BC0617AE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:19:37 -0700 (PDT)
Message-Id: <20210618143445.984906200@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1cs3mepo/5CrXrzjgShQ1ktmG5wNGEsMNOA0mUiWjLM=;
        b=c+jDi69l4OhU5ZtrrjAWEIMSlr9/MIlxEcBJ71I86BoRChA4OAOlYLhORq/2o0SHk5qvKG
        /Xa4TZ8oLeD8aiIVGdYccJZZIz0fXO3R2SZ+05ixTy9usJDGQCtZFaUqkTtJWZY9/AamXo
        yHd73IMG1W9kdxDr7cSaPvmoUQWns1PY4hyMeOOzK9bPiPft7cUOpGDS6N+9hRaaLwWwMw
        d1PluiuVmeC/IlQfKXPTTIkAeKyTSItcZU6z4y7aZds3eYCNG/+62r8wiwp+7bd7invBiF
        21boYk42VmdkrigvadJ+ZkqeHjNo5YMdj3AYEvwGa9/OCX2fsHT2G30vQMRfCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1cs3mepo/5CrXrzjgShQ1ktmG5wNGEsMNOA0mUiWjLM=;
        b=pdOTqaWKtoDrhoWBNL1xHHoOv0wJtRjWvmraBfoEaBQmj8hnWL1arkbt/7WXUXKhXQBfNx
        qy+30A5q1BmU3YDQ==
Date:   Fri, 18 Jun 2021 16:18:37 +0200
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
Subject: [patch V3 14/66] x86/fpu: Rewrite xfpregs_set()
References: <20210618141823.161158090@linutronix.de>
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
+	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
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

