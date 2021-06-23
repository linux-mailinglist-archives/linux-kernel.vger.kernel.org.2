Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011623B19E4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFWM0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36454 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhFWM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:02 -0400
Message-Id: <20210623121452.023118522@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1glffWmYal90SdCehK93TSvLeLHY88IdIWbPCpM1zfM=;
        b=XTLH4VjSVUSUJ43KIzE3xyIAqbli6oLBh8tUbxY9BHtUnvjKjQLonQoCiesVV3eyrq+lFh
        1i6xsWduobBQGNIuWUIwLPIABuOBCWqkmbF9P9dS09N6bkV+L/dnldabpJz6a0GkvgM/MH
        kaW15Y2KFVrDqd8Y3RwZ7P5FeGHBLywjK3nQMeY7QH/4rPWXo95tf1sQqREO/RSUHaNYSs
        AYw2/E/ZGj4gltHRtznlmxtCdb7aeEeEBr5d/l534lNIbFIDahhD1rY3UgSaHPwmxfQre2
        54W/tV6tBSkaue8E0hp4R244cUyBGHXYWaReecFpsgToAvx06keazZ2yuV7ShQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1glffWmYal90SdCehK93TSvLeLHY88IdIWbPCpM1zfM=;
        b=SBdOOi2D1r6o+oBIOIjtRA8I7orQ1bc5fM6OaVRHmEPrWbEUeB+1IHiYET0V8sJOy/1+zM
        1kf4DJkBdejLsBDQ==
Date:   Wed, 23 Jun 2021 14:01:34 +0200
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
Subject: [patch V4 07/65] x86/fpu: Move inlines where they belong
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are only used in fpstate_init() and there is no point to have them in
a header just to make reading the code harder.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h |   14 --------------
 arch/x86/kernel/fpu/core.c          |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -86,20 +86,6 @@ extern void fpstate_init_soft(struct swr
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
 
-static inline void fpstate_init_xstate(struct xregs_state *xsave)
-{
-	/*
-	 * XRSTORS requires these bits set in xcomp_bv, or it will
-	 * trigger #GP:
-	 */
-	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
-}
-
-static inline void fpstate_init_fxstate(struct fxregs_state *fx)
-{
-	fx->cwd = 0x37f;
-	fx->mxcsr = MXCSR_DEFAULT;
-}
 extern void fpstate_sanitize_xstate(struct fpu *fpu);
 
 #define user_insn(insn, output, input...)				\
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -181,6 +181,21 @@ void fpu__save(struct fpu *fpu)
 	fpregs_unlock();
 }
 
+static inline void fpstate_init_xstate(struct xregs_state *xsave)
+{
+	/*
+	 * XRSTORS requires these bits set in xcomp_bv, or it will
+	 * trigger #GP:
+	 */
+	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
+}
+
+static inline void fpstate_init_fxstate(struct fxregs_state *fx)
+{
+	fx->cwd = 0x37f;
+	fx->mxcsr = MXCSR_DEFAULT;
+}
+
 /*
  * Legacy x87 fpstate state init:
  */

