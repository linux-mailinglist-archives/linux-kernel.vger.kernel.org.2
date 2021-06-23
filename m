Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A553B19EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhFWM03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhFWM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C058CC061787
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:23:53 -0700 (PDT)
Message-Id: <20210623121452.710467587@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UOpPkyQs/j+l5ncunUdJfiwaY+GtMwoO2vkssn61ybM=;
        b=wWRj1SmHwUoM5+A2W/lw6X/IVCmrGypJF4n30qDIdkrsNx4g+dxwFidz3oZuZKloVDUSPD
        VL+0Eo4l82x2kojyiSrZE8Sn4Qnlti6xQKW6zCni5w5gPCveuIR6BRUBEJ5vzJG8kZWEtG
        6fKA91U/4gXlWmPqg3PlpkuKbac73sms0AxxUsvYJFMYcU0yLC/k/8iyLDNGVZhtQkcd+f
        96b8/kt9aWJ2dNr+B3xCZpK8QfOu1YVvSVWA3KKF377WeTfqSunozlW/EEeHy2PzDkt1pC
        fYJv+2ilHOR/FlSAkRr4xyNm3fVw341zTplI/9FtphyT+rgZ8dvntuqHwJ98ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UOpPkyQs/j+l5ncunUdJfiwaY+GtMwoO2vkssn61ybM=;
        b=GDxlC54HqlJVPEvoMEHpgLxUPCmytWd3x03avWJ8OE2cxHSIUDL1eNi15b90Qb13lGxLms
        Trv/fQOuaEmGj9Ag==
Date:   Wed, 23 Jun 2021 14:01:41 +0200
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
Subject: [patch V4 14/65] x86/fpu: Clean up fpregs_set()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

fpregs_set() has unnecessary complexity to support short or nonzero-offset
writes and to handle the case in which a copy from userspace overwrites
some of the target buffer and then fails.  Support for partial writes is
useless -- just require that the write have offset 0 and the correct size,
and copy into a temporary kernel buffer to avoid clobbering the state if
the user access fails.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V2: New patch. Picked up from Andy
---
 arch/x86/kernel/fpu/regset.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)
---
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -304,31 +304,32 @@ int fpregs_set(struct task_struct *targe
 	struct user_i387_ia32_struct env;
 	int ret;
 
-	fpu__prepare_write(fpu);
-	fpstate_sanitize_xstate(fpu);
+	/* No funny business with partial or oversized writes is permitted. */
+	if (pos != 0 || count != sizeof(struct user_i387_ia32_struct))
+		return -EINVAL;
 
-	if (!boot_cpu_has(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
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
-		convert_to_fxsr(&target->thread.fpu.state.fxsave, &env);
+	if (cpu_feature_enabled(X86_FEATURE_FXSR))
+		convert_to_fxsr(&fpu->state.fxsave, &env);
+	else
+		memcpy(&fpu->state.fsave, &env, sizeof(env));
 
 	/*
-	 * update the header bit in the xsave header, indicating the
+	 * Update the header bit in the xsave header, indicating the
 	 * presence of FP.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
+	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
 		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FP;
-	return ret;
+
+	return 0;
 }
 
 #endif	/* CONFIG_X86_32 || CONFIG_IA32_EMULATION */

