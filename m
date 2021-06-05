Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12BB39CBE7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFFAe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:34:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhFFAeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:34:18 -0400
Message-Id: <20210606001323.738086101@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622939548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qSVDjbNO5y02GgNrAT9kH25AS5XkSDMABsCurwAAdRQ=;
        b=I6WMTXiG+tB5X2ElKlb0OL2DHWVYkymgtCZ+UiUjXB7MvgiTtDeT7uvyz5UVUneljVIvPW
        Kp+7JJmOnvSuwNrh/c1EzC7aQlDQrZAVsUQrblfdgo1sFXi6bktqxwQDXxRUonBGSyICAD
        MvQOinQg5t4Vg6XazEgJdNdAhn03qs17WbYqyhrLgyA/dIQiGjMcGKW8rhQnB5RouKh+Kf
        YafUQ2Swnohsz5MZ3zAULy76i9qHwcPcuShgwcEqhS8UNMdm/DlcCs/x3fEpDxE15kAo6A
        ziFUJZgCLgc9DV9jZzGV2X/bu3fKu3Y+6tJqffXJqswW4QiZ1ctfualQhQMIHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622939548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qSVDjbNO5y02GgNrAT9kH25AS5XkSDMABsCurwAAdRQ=;
        b=7RE2Q3MbGzM1BIhhR2FOqnFaH+UD0bUnpQ+6Lt5sey32mnn1h3SGhnC/vWBrK3aOAY7Nqo
        bdz3Qopo1tWVd6AA==
Date:   Sun, 06 Jun 2021 01:47:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 08/14] x86/fpu: Move inlines where they belong
References: <20210605234742.712464974@linutronix.de>
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

