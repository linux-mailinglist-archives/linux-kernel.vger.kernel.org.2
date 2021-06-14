Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9A3A6C02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhFNQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhFNQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:39:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82161C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:37:55 -0700 (PDT)
Message-Id: <20210614155354.324260159@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=39OPt5zc3Ydg6LChmulu0TZUhl+DeY7yUJ0+EAOJmqc=;
        b=f+IzlcxjoeXI/Xeh0+OMXB7kfizRFDEkCBAeNE2k5bmejaPkaFr8KJ8/OtMlb14272OOWq
        04iAf8Cp8e+CUuzt9FH6IWLy2t2nUOVbQ6oxRf3nmcVAjimTQLSljtgoPcheH2gcwVXaWc
        suoRnzdadxAWxPxIMTVT1Fo0l1CdpmB+KLMZMGglJv+vRCzIQyo9Nka2qPuIKEqFegPxSy
        UJ1GjbY9bru5xZb9NH6x7f4YyPLhh8vbNzQjlMx4FYcZQ2BbVM5CiWkd1GJf2VQGrxTVuT
        fUA9VNbIG0PiqZ8FSHN0f3dbiHo+XIhJUN6MTGpHKuwFkL5aA5EBw5Y3UoU8zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=39OPt5zc3Ydg6LChmulu0TZUhl+DeY7yUJ0+EAOJmqc=;
        b=OpZZj0/U+rY2WnTcwAvLyAEUvgMFvD74x+bJfEpr2wbt74WFImPbVM5ND2yWgLv/ZLmzPU
        RcUm4eNMnQBc+RCg==
Date:   Mon, 14 Jun 2021 17:44:14 +0200
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
Subject: [patch V2 06/52] x86/fpu: Move inlines where they belong
References: <20210614154408.673478623@linutronix.de>
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
@@ -87,20 +87,6 @@ extern void fpstate_init_soft(struct swr
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

