Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF103B1A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhFWM2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37192 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhFWM1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:27:08 -0400
Message-Id: <20210623121457.377341297@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/p0tO5RvMAeA+4Jq9OGCTlZ3k05yi8T8fxRs8FjyXko=;
        b=z0ny//nloUVsWpixVfq7Rrt/Awd8rmWZLbdg/Ta7I/GVCpKdbGl7ipfy2V+1qrf/AjhkYP
        fnAM2Y53KMsfz+mRe1/tTHUThZxbPAZd+GlmUrQzot2lbF17t1S7hSJrF369kUC8GGGbKc
        kojNMNa+/1zqiTIt6Vuu5CGN3XI4RpSDZaSld09zpF6SWXJk/QkbFQNL504sySg9MggOs6
        zJzjBq/3+KjR51YPIcm2FxYMG6Gktt+OV933eJ0VD4VEL4YqpTsJNncPaaxDKTQRGuYOuM
        Lkx5eJ+1YFh2V7EtBAmJTDDI2wkWS/rJip7wgGS7axmb7BX1NnEQSMzoSQspPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/p0tO5RvMAeA+4Jq9OGCTlZ3k05yi8T8fxRs8FjyXko=;
        b=4/AqdNXt98JwqR3F5sLe/KDgVQyscxYbYou6WwN07IW34CEmVrh01y8r4wRCSustDXcCR9
        awjKfiLNWnpwXbAw==
Date:   Wed, 23 Jun 2021 14:02:28 +0200
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
Subject: [patch V4 61/65] x86/fpu/signal: Sanitize copy_user_to_fpregs_zeroing()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that user_xfeatures is correctly set when xsave is enabled, remove the
duplicated initialization of components.

Rename the function while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/signal.c |   36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -251,33 +251,27 @@ sanitize_restored_user_xstate(union fpre
 }
 
 /*
- * Restore the extended state if present. Otherwise, restore the FP/SSE state.
+ * Restore the FPU state directly from the userspace signal frame.
  */
-static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
-	u64 init_bv;
-	int r;
-
 	if (use_xsave()) {
-		if (fx_only) {
-			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
+		u64 init_bv = xfeatures_mask_uabi() & ~xrestore;
+		int ret;
 
-			r = fxrstor_from_user_sigframe(buf);
-			if (!r)
-				os_xrstor(&init_fpstate.xsave, init_bv);
-			return r;
-		} else {
-			init_bv = xfeatures_mask_uabi() & ~xbv;
-
-			r = xrstor_from_user_sigframe(buf, xbv);
-			if (!r && unlikely(init_bv))
-				os_xrstor(&init_fpstate.xsave, init_bv);
-			return r;
-		}
+		if (likely(!fx_only))
+			ret = xrstor_from_user_sigframe(buf, xrestore);
+		else
+			ret = fxrstor_from_user_sigframe(buf);
+
+		if (!ret && unlikely(init_bv))
+			os_xrstor(&init_fpstate.xsave, init_bv);
+		return ret;
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
-	} else
+	} else {
 		return frstor_from_user_sigframe(buf);
+	}
 }
 
 static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
@@ -314,7 +308,7 @@ static int __fpu_restore_sig(void __user
 		 */
 		fpregs_lock();
 		pagefault_disable();
-		ret = copy_user_to_fpregs_zeroing(buf_fx, user_xfeatures, fx_only);
+		ret = restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
 		pagefault_enable();
 		if (!ret) {
 

