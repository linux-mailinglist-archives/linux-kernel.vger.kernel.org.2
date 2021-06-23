Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E49F3B19F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhFWM0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhFWM0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E3C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:02 -0700 (PDT)
Message-Id: <20210623121453.425493349@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GWHglKW7NFMg+Pcbxfd7rlWLYJlOgq9HHBZKtaeDj3g=;
        b=NFstme2EaiLF557te9s6QGgkuUqesDjsKCpexCdQXLShtrZ9lt5ETCW+gj75PsueivTFNI
        SdxPyYR8yt7UCxFPyaxP+WCh96o1fczNJy5XhxD8Lw7lyCjdyxa6EOLckEnQXfj24/Mzx3
        9qhDgh2iEFxw/OvVso2KmU+zO2E9J7Uc/7eZb+734ivrtoGkXQ8SJxy+zCjwiLI/baclS1
        lBOgYLm/sL+7c6bWOj1wWogPhLOQqP0u7682SYUBt4/CTL+os1VXSwdFruitgUG4NyPm5D
        ydCM92UwnT377GjNRgsXOcjPsXKAHLIwkUAMtHpHUa1Mlsyof4uRXxdfvn3m8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GWHglKW7NFMg+Pcbxfd7rlWLYJlOgq9HHBZKtaeDj3g=;
        b=yMVawOT3Ml/gFYmq7ESMdfvrA2DPJmtDxtkezuIszY7Wvzq/PslmBeMUlntITRu2/T8Nih
        3cMc+ivv0Nw23pBw==
Date:   Wed, 23 Jun 2021 14:01:48 +0200
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
Subject: [patch V4 21/65] x86/fpu: Get rid of using_compacted_format()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is pointlessly global and a complete misnomer because it's
usage is related to both supervisor state checks and compacted format
checks. Remove it and just make the conditions check the XSAVES feature.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V2: New patch.
---
 arch/x86/include/asm/fpu/xstate.h |    1 -
 arch/x86/kernel/fpu/xstate.c      |   22 ++++------------------
 2 files changed, 4 insertions(+), 19 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -101,7 +101,6 @@ extern void __init update_regset_xstate_
 					     u64 xstate_mask);
 
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
-int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -449,20 +449,6 @@ int xfeature_size(int xfeature_nr)
 	return eax;
 }
 
-/*
- * 'XSAVES' implies two different things:
- * 1. saving of supervisor/system state
- * 2. using the compacted format
- *
- * Use this function when dealing with the compacted format so
- * that it is obvious which aspect of 'XSAVES' is being handled
- * by the calling code.
- */
-int using_compacted_format(void)
-{
-	return boot_cpu_has(X86_FEATURE_XSAVES);
-}
-
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
 static int validate_user_xstate_header(const struct xstate_header *hdr)
 {
@@ -581,9 +567,9 @@ static void do_extra_xstate_size_checks(
 		check_xstate_against_struct(i);
 		/*
 		 * Supervisor state components can be managed only by
-		 * XSAVES, which is compacted-format only.
+		 * XSAVES.
 		 */
-		if (!using_compacted_format())
+		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
 			XSTATE_WARN_ON(xfeature_is_supervisor(i));
 
 		/* Align from the end of the previous feature */
@@ -593,9 +579,9 @@ static void do_extra_xstate_size_checks(
 		 * The offset of a given state in the non-compacted
 		 * format is given to us in a CPUID leaf.  We check
 		 * them for being ordered (increasing offsets) in
-		 * setup_xstate_features().
+		 * setup_xstate_features(). XSAVES uses compacted format.
 		 */
-		if (!using_compacted_format())
+		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
 			paranoid_xstate_size = xfeature_uncompacted_offset(i);
 		/*
 		 * The compacted-format offset always depends on where

