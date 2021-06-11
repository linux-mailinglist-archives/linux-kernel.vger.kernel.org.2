Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5413A46BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhFKQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFKQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:01 -0400
Message-Id: <20210611163111.406828009@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qSVDjbNO5y02GgNrAT9kH25AS5XkSDMABsCurwAAdRQ=;
        b=hYGcjvLUyyw4n7OhsgaW6NW5MVLCHNj6445CqCGSNxaye35K8h3EkkzImESqedYE//G66/
        323J/pTMoSdyg3qhHcd6aQdU74jZEoj76k6aXwieCXOrIH1eGuefMKVOS5QpRmkZR7ws85
        y0WWGLMEcg+m4EbCcOQJlaI0CbXnTsCPl8qacXQ+uQ9oP8tLY2o6jbfIJGjiDTooLjZ5TU
        egSIztc7nwz2CSxeTGeCqY0rCiksRWtNHcgN1+vHUrsso71XxV4xrxgCwQd3rL6qPEMG8V
        ZVe1jY0sU1CrG/S8b0lXHKvQvHcEqal0td7q5bPVLA8jCs9wSBGEgkoqtU1bqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qSVDjbNO5y02GgNrAT9kH25AS5XkSDMABsCurwAAdRQ=;
        b=naQoU5WyUTDzNCdZVmR5FGnbHzL4D0guKmLu1SYYCTP/Ig/MRq7GRXjZHVqXVuErwmx0WE
        qBQzErtixJdXOrCg==
Date:   Fri, 11 Jun 2021 18:15:27 +0200
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
Subject: [patch 04/41] x86/fpu: Move inlines where they belong
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are only used in fpstate_init() and there is no point to have them in
a header just to make reading the code harder.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
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

