Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820A33ACE96
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhFRPWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:22:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56454 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhFRPVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:48 -0400
Message-Id: <20210618143446.220042175@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=c7Vnp9WUzIhyGGrLzS8lOchago/0Qfb3JX1F5EBegqE=;
        b=ETVQiOT2kpuAHpr+fcjynxZcm5QZ1gG8Cdv+88MrHiYTX+nRJUty1MSS+t368UwcXCyJKK
        iF6j5ooMY0wrG0K/LeD40HZRd+FW7mky56KnkugMctETNvbBKrFngbuvzeQl7VAypoIC9f
        E07nEcK+eUMwm7eOLtMia7TRuNLh9zaeOEnBpHSG63WunpwBMwIkCN8jrMNMxO7dN8dlcN
        lH4Z7TbQIlEKLhR/e0D03gfx2HkC2jc26AUy9pcOg24YLR7wuzuv7DNgqMq7cJUe7AS9EG
        SmfQaPzU/by+xoUyJYZAMmHJPlIYt7CfZa5LukDk1uZfGTpgh537Ou8tBGYw6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=c7Vnp9WUzIhyGGrLzS8lOchago/0Qfb3JX1F5EBegqE=;
        b=WPS9W4FQJH3kqMoygVLAwsFHTYWzPQF1nT8Gfq/sAu6W3fJYocmueO/7sbyi0rtD/jpAkJ
        RVzjUzdkxSf8oXDQ==
Date:   Fri, 18 Jun 2021 16:18:39 +0200
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
Subject: [patch V3 16/66] x86/fpu: Clean up fpregs_set()
References: <20210618141823.161158090@linutronix.de>
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
---
V2: New patch. Picked up from Andy
---
 arch/x86/kernel/fpu/regset.c |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)
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
+	if (cpu_feature_enabled(X86_FEATURE_FXSR))
 		convert_to_fxsr(&target->thread.fpu.state.fxsave, &env);
+	else
+		memcpy(&target->thread.fpu.state.fsave, &env, sizeof(env));
 
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

