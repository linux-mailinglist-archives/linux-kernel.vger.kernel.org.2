Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA03A6C09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhFNQki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbhFNQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:04 -0400
Message-Id: <20210614155355.033134539@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=DhgG+To0NPaV0bHYehzggyKCJz1+iIOLOOUQ4EIN+Qg=;
        b=10huUe0IgEP5CZR25eLN4KaNDg3iv3vS/rcFAy5Tw6+XbJLk+Mo1UDIkb/4VERQ79a/P7V
        fhx721221TKSQ5eZUmKa6BA829jZeFZWPqqFOi0jomOE1ZU5gxqcJ8UUogQoVpngUtVp6v
        ysckD4NDxlmE/Avy4PmR3oFrXKepm8dU7spqhZgLqRz3UA2KNkEUeMk+BqYJkA8gx4EORA
        vND0/vwig1YvxNcbZAjLUKfH3ELgVDc1Qp9G3BkSyC8PJy+1dA6YPyeQH7jI/dO/J5iMG7
        dkUKMs2tduBVJNwILWDwwJ1V5GtCpPTyy7tFOSzOgiaeiwLMK/8zYl8xH+zqfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=DhgG+To0NPaV0bHYehzggyKCJz1+iIOLOOUQ4EIN+Qg=;
        b=frGLo6tONW5ZKEX0rOOJxhC57WbqBGJ8HVHaSLWEtWELNooge6rCfhrbheg7xAvUV8qxuv
        Po6PC5vECix8hmAA==
Date:   Mon, 14 Jun 2021 17:44:21 +0200
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
Subject: [patch V2 13/52] x86/fpu: Clean up fpregs_set()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

fpregs_set() had unnecessary complexity to support short or nonzero-offset
writes and to handle the case in which a copy from userspace overwrites
some of the target buffer and then fails.  Support for partial writes is
useless -- just require that the write have offset 0 and the correct size,
and copy into a temporary kernel buffer to avoid clobbering the state if
the user access fails.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch. Picked up from Andy
---
 arch/x86/kernel/fpu/regset.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)
---
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -305,31 +305,32 @@ int fpregs_set(struct task_struct *targe
 	struct user_i387_ia32_struct env;
 	int ret;
 
-	fpu__prepare_write(fpu);
-	fpstate_sanitize_xstate(fpu);
+	/* No funny business with partial or oversized writes is permitted. */
+	if (pos != 0 || count != sizeof(struct user_i387_ia32_struct))
+		return -EINVAL;
 
 	if (!boot_cpu_has(X86_FEATURE_FPU))
 		return fpregs_soft_set(target, regset, pos, count, kbuf, ubuf);
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR))
-		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					  &fpu->state.fsave, 0,
-					  -1);
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
+	if (ret)
+		return ret;
 
-	if (pos > 0 || count < sizeof(env))
-		convert_from_fxsr(&env, target);
+	fpu__prepare_write(fpu);
 
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
-	if (!ret)
+	if (static_cpu_has(X86_FEATURE_FXSR))
 		convert_to_fxsr(&target->thread.fpu.state.fxsave, &env);
+	else
+		memcpy(&target->thread.fpu.state.fsave, &env, sizeof(env));
 
 	/*
-	 * update the header bit in the xsave header, indicating the
+	 * Update the header bit in the xsave header, indicating the
 	 * presence of FP.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
+	if (static_cpu_has(X86_FEATURE_XSAVE))
 		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FP;
-	return ret;
+
+	return 0;
 }
 
 #endif	/* CONFIG_X86_32 || CONFIG_IA32_EMULATION */

