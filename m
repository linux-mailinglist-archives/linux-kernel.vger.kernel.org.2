Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70F23A6BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhFNQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55786 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbhFNQjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:39:54 -0400
Message-Id: <20210614155354.114428348@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=g1o84IQr44hfp1gYhCcMh8Equkbyo8cGktWQcjPZC8I=;
        b=fptLMgXz0EJ+4vzqKWr7O/C63RbjTK30aNz/MCObuNluBGBEQXYMBjqs+Moj5H0D5uEzag
        YkdXSp7bzN4Yga7oboGqCa1/nJ/+fcoIYX9Wf0qlqBADXSdQ8OxwC6YT60LSQ9+Yq7PXYZ
        2r6+uzXDHap3bEwDjwgItgKaNHwFgHJD6BSU0S6Og3duytq+i3pA4Q2tZPZay5jjdbD+19
        koDULe30lQ74tzmszVDmpiv1W5d1Lo4HKRBs/VrjHvXJUv1OdVNaqij46EU7mL9UHGMtjE
        lhcqO1Ju23EF5lvu0IcXJV/KCnhjUt0F+Ulr1MB9aHtwk0QktQ70c5E4QzFf4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=g1o84IQr44hfp1gYhCcMh8Equkbyo8cGktWQcjPZC8I=;
        b=DzN2a8yOz85kWFE9B/i5n0+XX2Z3oXL2UmBuhsVpBBU9uWwrYMngLgw148t5PEi0td6udu
        LaSsECSZCIdOagDg==
Date:   Mon, 14 Jun 2021 17:44:12 +0200
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
Subject: [patch V2 04/52] x86/fpu: Mark various FPU states __ro_after_init
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing modifies these after booting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/fpu/init.c   |    4 ++--
 arch/x86/kernel/fpu/xstate.c |   16 ++++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -89,7 +89,7 @@ static void fpu__init_system_early_gener
 /*
  * Boot time FPU feature detection code:
  */
-unsigned int mxcsr_feature_mask __read_mostly = 0xffffffffu;
+unsigned int mxcsr_feature_mask __ro_after_init = 0xffffffffu;
 EXPORT_SYMBOL_GPL(mxcsr_feature_mask);
 
 static void __init fpu__init_system_mxcsr(void)
@@ -135,7 +135,7 @@ static void __init fpu__init_system_gene
  * This is inherent to the XSAVE architecture which puts all state
  * components into a single, continuous memory block:
  */
-unsigned int fpu_kernel_xstate_size;
+unsigned int fpu_kernel_xstate_size __ro_after_init;
 EXPORT_SYMBOL_GPL(fpu_kernel_xstate_size);
 
 /* Get alignment of the TYPE. */
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -59,19 +59,23 @@ static short xsave_cpuid_features[] __in
  * This represents the full set of bits that should ever be set in a kernel
  * XSAVE buffer, both supervisor and user xstates.
  */
-u64 xfeatures_mask_all __read_mostly;
+u64 xfeatures_mask_all __ro_after_init;
 
-static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
  * it is always in standard format for user mode. This is the user
  * mode standard format size used for signal and ptrace frames.
  */
-unsigned int fpu_user_xstate_size;
+unsigned int fpu_user_xstate_size __ro_after_init;
 
 /*
  * Return whether the system supports a given xfeature.

