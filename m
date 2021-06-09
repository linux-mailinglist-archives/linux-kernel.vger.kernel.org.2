Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0620F3A1D92
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFITT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:19:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56264 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFITT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:19:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623266280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5sNRFP1KV+rOIYzbCpaJEKjJuak0xUka9hlv38KL3dg=;
        b=Tg4SLznAK17OnD5CYCLAD3Cs5/Behe/rGareg/4Pg3DbaFaaEEtIt+LCNemnROc0QGXS3H
        2+4ndUrrAD6/M8Cbzc/hrQeLIH2DjjvZ9ff49HnYouz5Q4Gay57Elfe7KtGq+s7Rypl3dd
        sOnQT0DnMe87fDf3nIAkVhKAd+i2vBNmtB/C7PF/eZENGJgHGFlbNtKz7KecM/h0ISB3PF
        eucw9rUJokRNdbe3DaHpsqFcLlr5QUYtzjLIBlRyKxMdCbUihEnHAVVb9aM2G11jLM1rUQ
        z0nqhvZru14emSHHa4R0Bk6oJpj/ffPlxltSnEY7/3/2n6E3h+iBkSIC0AsacQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623266280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5sNRFP1KV+rOIYzbCpaJEKjJuak0xUka9hlv38KL3dg=;
        b=9rIFt1pwa2vVW9slijE4uuGrCdkr8JCb7YbZ4cvcC8bdFCxNI3Q3vhQMJvYXQ3CQtaNZtW
        inUQk/YCWKka5nBw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/fpu: Reset state for all signal restore failures
References: <20210608143617.565868844@linutronix.de>
Date:   Wed, 09 Jun 2021 21:18:00 +0200
Message-ID: <87mtryyhhz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If access_ok() or fpregs_soft_set() fails in __fpu__restore_sig() then the
function just returns but does not clear the FPU state as it does for all
other fatal failures.

Clear the FPU state for these failures as well.

Fixes: 72a671ced66d ("x86, fpu: Unify signal handling code paths for x86 and x86_64 kernels")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/fpu/signal.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -307,13 +307,17 @@ static int __fpu__restore_sig(void __use
 		return 0;
 	}
 
-	if (!access_ok(buf, size))
-		return -EACCES;
+	if (!access_ok(buf, size)) {
+		ret = -EACCES;
+		goto out;
+	}
 
-	if (!static_cpu_has(X86_FEATURE_FPU))
-		return fpregs_soft_set(current, NULL,
-				       0, sizeof(struct user_i387_ia32_struct),
-				       NULL, buf) != 0;
+	if (!static_cpu_has(X86_FEATURE_FPU)) {
+		ret = fpregs_soft_set(current, NULL, 0,
+				      sizeof(struct user_i387_ia32_struct),
+				      NULL, buf);
+		goto out;
+	}
 
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
@@ -377,7 +381,7 @@ static int __fpu__restore_sig(void __use
 		 */
 		ret = __copy_from_user(&env, buf, sizeof(env));
 		if (ret)
-			goto err_out;
+			goto out;
 		envp = &env;
 	}
 
@@ -434,7 +438,7 @@ static int __fpu__restore_sig(void __use
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
 		if (ret) {
 			ret = -EFAULT;
-			goto err_out;
+			goto out;
 		}
 
 		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
@@ -452,7 +456,7 @@ static int __fpu__restore_sig(void __use
 	} else {
 		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
 		if (ret)
-			goto err_out;
+			goto out;
 
 		fpregs_lock();
 		ret = copy_kernel_to_fregs_err(&fpu->state.fsave);
@@ -463,7 +467,7 @@ static int __fpu__restore_sig(void __use
 		fpregs_deactivate(fpu);
 	fpregs_unlock();
 
-err_out:
+out:
 	if (ret)
 		fpu__clear_user_states(fpu);
 	return ret;
