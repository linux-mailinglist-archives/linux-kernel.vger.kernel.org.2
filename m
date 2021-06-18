Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B9E3ACE8B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhFRPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:21:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhFRPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:37 -0400
Message-Id: <20210618143445.206372999@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5JupwahYfRQZ8SWnTbdoqKaQYuUvpeMd+3vDe4dbkJQ=;
        b=H5AE58lqleXZmMnHOi+ATg4cVEse3s71lPGcElVehhQrdDxx9UVL1r09VXjsPbAFIgeYAT
        5J8j11+tEGQz9ceZLsnRDFYULCMXG0r7n5ngQnkVPUMDSecDEVHhk8Qhdh4kZ1NnE77StW
        HeABi8nDceYzSs6jpeZslxJ1qJnpRzTmevZtekPYhOQz+pUJkf1PP3z5wDok6zOBF5CahZ
        zO+cRX1K7XVJmgLvXSB3svvH0WsGuvKcxx93DURfr/y1whgq1B40sjGd3y945F2Qz/QsKy
        P2nh4QwZfNZLm466S+mPjPj8Dygos6YxymNcoVta/FhVcFNO6YLNFxGATVFO4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5JupwahYfRQZ8SWnTbdoqKaQYuUvpeMd+3vDe4dbkJQ=;
        b=E26XrYMNpA3tpJGw72GEdg6dWhUmo46Twg9s32EipPPq7wMh9oiR9Z0JfSZEMrPgSNm/qf
        G2wzPR5/MwZlozCw==
Date:   Fri, 18 Jun 2021 16:18:30 +0200
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
Subject: [patch V3 07/66] x86/fpu: Get rid of fpu__get_supported_xfeatures_mask()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is really not doing what the comment advertises:

 "Find supported xfeatures based on cpu features and command-line input.
  This must be called after fpu__init_parse_early_param() is called and
  xfeatures_mask is enumerated."

fpu__init_parse_early_param() does not exist anymore and the function just
returns a constant.

Remove it and fix the caller and get rid of further references to
fpu__init_parse_early_param().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch. Noticed when staring at the hotplug trainwreck.
---
 arch/x86/include/asm/fpu/internal.h |    1 -
 arch/x86/kernel/cpu/common.c        |    5 ++---
 arch/x86/kernel/fpu/init.c          |   11 -----------
 arch/x86/kernel/fpu/xstate.c        |    4 +++-
 4 files changed, 5 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -45,7 +45,6 @@ extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system(struct cpuinfo_x86 *c);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
-extern u64 fpu__get_supported_xfeatures_mask(void);
 
 /*
  * Debugging facility:
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1715,9 +1715,8 @@ void print_cpu_info(struct cpuinfo_x86 *
 }
 
 /*
- * clearcpuid= was already parsed in fpu__init_parse_early_param.
- * But we need to keep a dummy __setup around otherwise it would
- * show up as an environment variable for init.
+ * clearcpuid= was already parsed in cpu_parse_early_param().  This dummy
+ * function prevents it to become an environment variable for init.
  */
 static __init int setup_clearcpuid(char *arg)
 {
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -216,17 +216,6 @@ static void __init fpu__init_system_xsta
 	fpu_user_xstate_size = fpu_kernel_xstate_size;
 }
 
-/*
- * Find supported xfeatures based on cpu features and command-line input.
- * This must be called after fpu__init_parse_early_param() is called and
- * xfeatures_mask is enumerated.
- */
-u64 __init fpu__get_supported_xfeatures_mask(void)
-{
-	return XFEATURE_MASK_USER_SUPPORTED |
-	       XFEATURE_MASK_SUPERVISOR_SUPPORTED;
-}
-
 /* Legacy code to initialize eager fpu mode. */
 static void __init fpu__init_system_ctx_switch(void)
 {
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -868,7 +868,9 @@ void __init fpu__init_system_xstate(void
 			xfeatures_mask_all &= ~BIT_ULL(i);
 	}
 
-	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
+	xfeatures_mask_all &= XFEATURE_MASK_USER_SUPPORTED |
+			      XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+
 	/* Store it for paranoia check at the end */
 	xfeatures = xfeatures_mask_all;
 

