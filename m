Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE163ACEA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhFRPXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:23:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbhFRPV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:57 -0400
Message-Id: <20210618143447.010786126@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GWHglKW7NFMg+Pcbxfd7rlWLYJlOgq9HHBZKtaeDj3g=;
        b=oYW7kW9++xRJ+t0QDo0XXWXyMKItw+2msmON+lOA6gsbvH2mXUAQXZNS0j7+0IUzJBb9Jm
        57s3Vq2mTwl8USIv6jYYIIUbhwu5ybDBfIApkGiWxuxi1Awdqj6K7dJV/dFIMWReC92ItM
        w6XXjPAqCVH2Fan4Zqkt9qkceg+n60NnWwqSZWJn+6YoDijFXt3mH5H4o0OEwOJ5QG3pXG
        HbTrjckIu7YbwMS2eA5sQbrAahCnAOl5eiYzFYd0J1zyJMa7i8+mOxSHB3lTrmC6ENHr9z
        Js6o1QhYKfOU2ih+uu23bL7PmsPav/OtLks9s5Q9pTzE7d6O44KFipK3mLlZMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GWHglKW7NFMg+Pcbxfd7rlWLYJlOgq9HHBZKtaeDj3g=;
        b=b49ufpRZRIkVoDw3HUCx99P1kB1gcPOcYEZL5/mUeKhND92AVI4h+nboaoYqEc2ZjsrKOT
        lsTh0eeDWKaVfwDw==
Date:   Fri, 18 Jun 2021 16:18:46 +0200
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
Subject: [patch V3 23/66] x86/fpu: Get rid of using_compacted_format()
References: <20210618141823.161158090@linutronix.de>
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

