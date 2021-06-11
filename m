Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0913A46BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFKQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhFKQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:45:59 -0400
Message-Id: <20210611163111.288769102@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1hjUvCl5quL7agWfJGI8+VqW8V4fBq3GNa4tD2TDk18=;
        b=kVguTq6BGJpcU4u31I9A2rx/+4YEL+lt/HyWWDsBp+U/3U8KG/Cpwr03UOCAWMc8UljaFN
        I+OTHFhkwdog9APNWoeyf+U+HaGC98Vb4mSonXITQF1T9MoQu9i5TaeW9PWPx1/IA2rYwJ
        hpv7kCP78w65tqv5JChowwgxsvqycuuNlkRhZQuX11As8i2LPmkZYs7BCrh9H4kJvsJffD
        VIuNm//AeAACH2P84EExy5UrlQT/YScl74aO/sEGUA+WJVTKVkVc5UrwrvVQ2quuh27rx3
        rq1xkqM3y8nvAzgsWJ1Bwv3gAmmXRJZ5YBNNp12WL1TB3ukYYNRITTOb3VPahA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1hjUvCl5quL7agWfJGI8+VqW8V4fBq3GNa4tD2TDk18=;
        b=/gW4J3KC0HPMVPtsu5x1FHlUU1qROXWO4FXyBWheElD5JeRsA7g7XBqKmMj2UG3CDl39Jm
        sXwneIVX+x0Bi5Dg==
Date:   Fri, 11 Jun 2021 18:15:26 +0200
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
Subject: [patch 03/41] x86/fpu: Remove unused get_xsave_field_ptr()
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
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
@@ -955,36 +955,6 @@ void *get_xsave_addr(struct xregs_state
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

