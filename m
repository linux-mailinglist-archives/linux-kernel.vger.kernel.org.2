Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD83B19E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFWM0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhFWM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:08 -0400
Message-Id: <20210623121452.504234607@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BN+HkEBNdG9IVz2HZV4eUhIqaqw4+y6brDEW4/i3JZA=;
        b=OUGRPxSzOuVCjaKquCpClWOfamvPyt7onpGMAq4uWhQzSbC5HfAYEivmh9Cw/8nBC1Ve0I
        6wSUQvPtcT6HT5cO9xsjE7TbRy7sdo6KOprJpoB54i1IGI3AQ+spJ+/uhO5VQRJL2G8BBW
        /VOQG+jq3ASLgGtIBaFUovLTrWy4WQokEZJlg3lxfV8wyt2uyR+nM4XOG0ReLEwBV83vEy
        HPq/CzTvOxRgdRPIxjGzHA7qH5nGZw0MYcx21F/HMYdnTb7fc1f3oUY6hcVCzQmLwsJbTx
        NjpuADBs6feBFbwZSo+XO3NbWYYjvkNopuiCqq+UuKy0BgMSkXY0I0AymyDAPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BN+HkEBNdG9IVz2HZV4eUhIqaqw4+y6brDEW4/i3JZA=;
        b=iOVi3iZw75fBCqrr7/0BBpkg8OH0JD+aCnYSNmfifEqBtoCKZorBHZ0p1ngbjigpWnkRPv
        ahwsK1vbcLpuNDBg==
Date:   Wed, 23 Jun 2021 14:01:39 +0200
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
Subject: [patch V4 12/65] x86/fpu: Rewrite xfpregs_set()
References: <20210623120127.327154589@linutronix.de>
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
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V2: New patch picked up from Andy
---
 arch/x86/kernel/fpu/regset.c |   39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -47,30 +47,39 @@ int xfpregs_set(struct task_struct *targ
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
 
+	/* No funny business with partial or oversized writes is permitted. */
+	if (pos != 0 || count != sizeof(newstate))
+		return -EINVAL;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newstate, 0, -1);
+	if (ret)
+		return ret;
+
+	/* Mask invalid MXCSR bits (for historical reasons). */
+	newstate.mxcsr &= mxcsr_feature_mask;
+
 	fpu__prepare_write(fpu);
-	fpstate_sanitize_xstate(fpu);
 
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 &fpu->state.fxsave, 0, -1);
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

