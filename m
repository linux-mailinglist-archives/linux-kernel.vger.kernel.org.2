Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966533ACE8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhFRPVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:21:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56328 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbhFRPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:36 -0400
Message-Id: <20210618143445.104177935@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=N9ju3zKYKNsFSMeCJGVjbzq++teoOw1o95TdaYtFUXk=;
        b=Ycldk1SqVcqfwh65yyMKltZpRerQsGUlT0DKJMuULdhjrm89TNbrXojdvoWF5/54EIsp6a
        POpaav1+J8X+K+CTn48Pr+lErJEvTEpBrpEkRvlqDbEKICGxgfWb1v4KX8a2zSGRH2mj3f
        hiAE/GM+vPJQkV223rYwo23zrphTPl/3SaPn+k0EAnUeDAVWxmIbaPowApMCdvJhpov6mR
        hrkWaNFAIVXX7nSRJ03hDjxru9MXKsJlkWKNHeVH7jt7iVHpG+Qx5QDHgdW/ZBJlwob7nP
        97ylO46UckqHUlNSRzax/U2xQ11IHMp8PoIZ+09xu0sprWJfmuTZecLsuOA1Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=N9ju3zKYKNsFSMeCJGVjbzq++teoOw1o95TdaYtFUXk=;
        b=tanwUxdD2Hn223CqtQX9VFQZKJXsXbQhbbkmGDF7JHK0vHgSYfsC54i9YskFVQrn/B4T/W
        d6B9T2Aoq0qg6WCQ==
Date:   Fri, 18 Jun 2021 16:18:29 +0200
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
Subject: [patch V3 06/66] x86/fpu: Make xfeatures_mask_all __ro_after_init
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing has to modify this after init.

But of course there is code which unconditionaly masks xfeatures_mask_all
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
-u64 xfeatures_mask_all;
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
+		pr_err("x86/fpu: xfeatures modified during init %016llx %016llx, disabling XSAVE\n",
+		       xfeatures, xfeatures_mask_all);
+		goto out_disable;
+	}
+
+	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		xfeatures_mask_all,
 		fpu_kernel_xstate_size,

