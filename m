Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8FF3B19E3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhFWM0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhFWM0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:00 -0400
Message-Id: <20210623121451.915614415@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UBvSc2WQ1Fmt4yMeq1/GQgGSIQyJ/U35yq8DktMsJmk=;
        b=RzS8NRvlHlMMplVrFzHxjJete1J7bzRP732lUFmV7MGNBCbxBFBHgg70jzZKJNql7S6VtO
        pnGKHkFipdwW93OYsqg4lj5K/71OwR7ZIbfsXiCAtRHFcEyDkecvdd05aOZeSnvmYRTug2
        43jlObTlevM/e/LOrA7H5cjc4CHk5k2R4yeqavek8X5/is2nTQYWzYE/4v60S9w2/9sPEq
        SephaGXjypNEpDf3TkanwEd0alpzZtBFRwo459AMwulJ18B91exJNJnbkZA9lQnBANEd56
        YKaBya6JItJKqFrbgJ16mLx7b4NIushdsdMRrOI/KbG9MdUa30qa7QOGxTLa6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UBvSc2WQ1Fmt4yMeq1/GQgGSIQyJ/U35yq8DktMsJmk=;
        b=8xz4wBGo2ojQR0ubP1OPi071YxtWmQEpIz/heqM/6saMxpBVsQ9YsS7ZngdvmpSl4TLzJ5
        wvVHrRKoWDX83sCQ==
Date:   Wed, 23 Jun 2021 14:01:33 +0200
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
Subject: [patch V4 06/65] x86/fpu: Remove unused get_xsave_field_ptr()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/xstate.h |    1 -
 arch/x86/kernel/fpu/xstate.c      |   30 ------------------------------
 2 files changed, 31 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -101,7 +101,6 @@ extern void __init update_regset_xstate_
 					     u64 xstate_mask);
 
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
-const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
 struct membuf;
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -998,36 +998,6 @@ void *get_xsave_addr(struct xregs_state
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
 
-/*
- * This wraps up the common operations that need to occur when retrieving
- * data from xsave state.  It first ensures that the current task was
- * using the FPU and retrieves the data in to a buffer.  It then calculates
- * the offset of the requested field in the buffer.
- *
- * This function is safe to call whether the FPU is in use or not.
- *
- * Note that this only works on the current task.
- *
- * Inputs:
- *	@xfeature_nr: state which is defined in xsave.h (e.g. XFEATURE_FP,
- *	XFEATURE_SSE, etc...)
- * Output:
- *	address of the state in the xsave area or NULL if the state
- *	is not present or is in its 'init state'.
- */
-const void *get_xsave_field_ptr(int xfeature_nr)
-{
-	struct fpu *fpu = &current->thread.fpu;
-
-	/*
-	 * fpu__save() takes the CPU's xstate registers
-	 * and saves them off to the 'fpu memory buffer.
-	 */
-	fpu__save(fpu);
-
-	return get_xsave_addr(&fpu->state.xsave, xfeature_nr);
-}
-
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
 /*

