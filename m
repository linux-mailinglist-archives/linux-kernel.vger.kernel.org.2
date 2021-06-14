Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422193A6C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhFNQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhFNQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:09 -0400
Message-Id: <20210614155355.450669490@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Zry/aCz6tZrob0Eu6Oq9myNlC+l2iPoXNdIeHzuizhQ=;
        b=tfRE8FWztq8YE4iZ6AQoNT1U8qpoatuZ375J+d6N91UgMpDCB5iosgSzAF5v4cYeRArpqf
        JQxPJjJBIR5hGAGuVQNZxo31YRNgSsvQiBdiwpz+Ca0ZQ8hifazyK7zMkG2X697BkRKSTh
        hFEw7jU2XbSDSK+wVKinzm6BKGxBFoEoihL1BRb9GWK1wtLBMvikSbp0tkgb2l373r59FK
        Nmgl33LKRRpTCyUc/g0E2PWxActJJLpbTJ7wUA394bFtx8SCNGERRqzP63IiR35u92VEIc
        k5nnUYEAI2GuWYcRPqLyzg3DdrFpYwoeTBPvpmTTHJPg8R3CFoHwCYNgnwjFTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Zry/aCz6tZrob0Eu6Oq9myNlC+l2iPoXNdIeHzuizhQ=;
        b=bJZdwfPM/xMa19qsJSzEpNEPLYoOBhDfKsLipV/Gvfk2iF8RQROZ8+QoEzaYzSN1h5pxmP
        ZipLsKaZxDQmbmAg==
Date:   Mon, 14 Jun 2021 17:44:25 +0200
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
Subject: [patch V2 17/52] x86/fpu: Remove fpstate_sanitize_xstate()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/fpu/internal.h |    2 
 arch/x86/kernel/fpu/xstate.c        |   79 ------------------------------------
 2 files changed, 81 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -87,8 +87,6 @@ extern void fpstate_init_soft(struct swr
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
 
-extern void fpstate_sanitize_xstate(struct fpu *fpu);
-
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -129,85 +129,6 @@ static bool xfeature_is_supervisor(int x
 }
 
 /*
- * When executing XSAVEOPT (or other optimized XSAVE instructions), if
- * a processor implementation detects that an FPU state component is still
- * (or is again) in its initialized state, it may clear the corresponding
- * bit in the header.xfeatures field, and can skip the writeout of registers
- * to the corresponding memory layout.
- *
- * This means that when the bit is zero, the state component might still contain
- * some previous - non-initialized register state.
- *
- * Before writing xstate information to user-space we sanitize those components,
- * to always ensure that the memory layout of a feature will be in the init state
- * if the corresponding header bit is zero. This is to ensure that user-space doesn't
- * see some stale state in the memory layout during signal handling, debugging etc.
- */
-void fpstate_sanitize_xstate(struct fpu *fpu)
-{
-	struct fxregs_state *fx = &fpu->state.fxsave;
-	int feature_bit;
-	u64 xfeatures;
-
-	if (!use_xsaveopt())
-		return;
-
-	xfeatures = fpu->state.xsave.header.xfeatures;
-
-	/*
-	 * None of the feature bits are in init state. So nothing else
-	 * to do for us, as the memory layout is up to date.
-	 */
-	if ((xfeatures & xfeatures_mask_all) == xfeatures_mask_all)
-		return;
-
-	/*
-	 * FP is in init state
-	 */
-	if (!(xfeatures & XFEATURE_MASK_FP)) {
-		fx->cwd = 0x37f;
-		fx->swd = 0;
-		fx->twd = 0;
-		fx->fop = 0;
-		fx->rip = 0;
-		fx->rdp = 0;
-		memset(fx->st_space, 0, sizeof(fx->st_space));
-	}
-
-	/*
-	 * SSE is in init state
-	 */
-	if (!(xfeatures & XFEATURE_MASK_SSE))
-		memset(fx->xmm_space, 0, sizeof(fx->xmm_space));
-
-	/*
-	 * First two features are FPU and SSE, which above we handled
-	 * in a special way already:
-	 */
-	feature_bit = 0x2;
-	xfeatures = (xfeatures_mask_user() & ~xfeatures) >> 2;
-
-	/*
-	 * Update all the remaining memory layouts according to their
-	 * standard xstate layout, if their header bit is in the init
-	 * state:
-	 */
-	while (xfeatures) {
-		if (xfeatures & 0x1) {
-			int offset = xstate_comp_offsets[feature_bit];
-			int size = xstate_sizes[feature_bit];
-
-			memcpy((void *)fx + offset,
-			       (void *)&init_fpstate.xsave + offset,
-			       size);
-		}
-
-		xfeatures >>= 1;
-		feature_bit++;
-	}
-}
-
-/*
  * Enable the extended processor state save/restore feature.
  * Called once per CPU onlining.
  */

