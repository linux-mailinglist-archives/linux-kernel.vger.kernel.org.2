Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B25B3B19E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhFWM0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhFWMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:25:58 -0400
Message-Id: <20210623121451.712803952@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vrpMyLAY/eHEL3V09LBJSXc3hXm7xzNWgtjWNbJVyTU=;
        b=KT4/FUdP9N8dOKW7rcaBB0pvfnWcIsWFvu7x/nXdkLoNMDk1uo0ZhPkjGOiwc+rf3ixkiZ
        CB1hJWtXCrwrfUJZ/4d5BwYpuf09uccQF6TlDDtUI8wZNgW6hHvGQrCPmR6q8+xI8+5Bl9
        uVNMuHGA2U0wAefVSZzkzlsfRWALLtB6OLnBuImElBOuW6mFq3RGkF6XGR6VSZNhdrOBaj
        ZPraiz6f0YCCOxXvrjj7jbC/9ubdpCi4cLE//623mYCXsG4f8Ec8zKWEC6IklujJ0TqSxS
        t61Ln5jIW1Fv+PRlOD19xXf0zYUAqlRKdtgnUObdbMkXOqlXeW1y4t7Hhn8MvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vrpMyLAY/eHEL3V09LBJSXc3hXm7xzNWgtjWNbJVyTU=;
        b=cK02rSadQcezpl/9DywbBWfJJWhMsAExaBBt35t3b6kD5ri4rnqFiwaE1OSE36LXl1+lzw
        0ssu8IerLUoc99Bw==
Date:   Wed, 23 Jun 2021 14:01:31 +0200
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
Subject: [patch V4 04/65] x86/fpu: Make xfeatures_mask_all __ro_after_init
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing has to modify this after init.

But of course there is code which unconditionallqy masks xfeatures_mask_all
on CPU hotplug. This goes unnoticed during boot hotplug because at that
point the variable is still RW mapped.

This is broken in several ways:

  1) Masking this in post init CPU hotplug means that any
     modification of this state goes unnoticed until actual hotplug
     happens.

  2) If that ever happens then these bogus feature bits are already
     populated all over the place and the system is in inconsistent state
     vs. the compacted XSTATE offsets. If at all then this has to panic the
     machine because the inconsistency cannot be undone anymore.

Make this a one time paranoia check in xstate init code and disable xsave
when this happens.

Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V3: New patch. Addresses the hotplug crash reported by Kan
---
 arch/x86/kernel/fpu/xstate.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -59,7 +59,7 @@ static short xsave_cpuid_features[] __in
  * This represents the full set of bits that should ever be set in a kernel
  * XSAVE buffer, both supervisor and user xstates.
  */
-u64 xfeatures_mask_all __read_mostly;
+u64 xfeatures_mask_all __ro_after_init;
 
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
@@ -213,19 +213,8 @@ void fpstate_sanitize_xstate(struct fpu
  */
 void fpu__init_cpu_xstate(void)
 {
-	u64 unsup_bits;
-
 	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
 		return;
-	/*
-	 * Unsupported supervisor xstates should not be found in
-	 * the xfeatures mask.
-	 */
-	unsup_bits = xfeatures_mask_all & XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
-	WARN_ONCE(unsup_bits, "x86/fpu: Found unsupported supervisor xstates: 0x%llx\n",
-		  unsup_bits);
-
-	xfeatures_mask_all &= ~XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
 
@@ -825,6 +814,7 @@ void __init fpu__init_system_xstate(void
 {
 	unsigned int eax, ebx, ecx, edx;
 	static int on_boot_cpu __initdata = 1;
+	u64 xfeatures;
 	int err;
 	int i;
 
@@ -879,6 +869,8 @@ void __init fpu__init_system_xstate(void
 	}
 
 	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
+	/* Store it for paranoia check at the end */
+	xfeatures = xfeatures_mask_all;
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -896,8 +888,18 @@ void __init fpu__init_system_xstate(void
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
 	setup_supervisor_only_offsets();
-	print_xstate_offset_size();
 
+	/*
+	 * Paranoia check whether something in the setup modified the
+	 * xfeatures mask.
+	 */
+	if (xfeatures != xfeatures_mask_all) {
+		pr_err("x86/fpu: xfeatures modified from 0x%016llx to 0x%016llx during init, disabling XSAVE\n",
+		       xfeatures, xfeatures_mask_all);
+		goto out_disable;
+	}
+
+	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		xfeatures_mask_all,
 		fpu_kernel_xstate_size,

