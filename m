Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689983B19F3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhFWM0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhFWM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF7CC06124C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:03 -0700 (PDT)
Message-Id: <20210623121453.541037562@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=MOoCipyUPUSuz7nAW1zwlopmeSmXAqoVGwOdF+2iuZA=;
        b=SoqkcpnPyrPHJt6NuR1b1wn0J4KemCjtwfKmC8cLrAzH+tZJiaIbVQqJuMazV+Qv82e2XO
        0LQFwxzPX+k3qXGQbeJ7RwslSJBhSJH2p2M5OMRbmbhzarRdUvQAu5glZre2c1k0jbi5Hk
        FDsKztkV1vMsh8m1Km6BtDlZP7FKP46ffdJ9F42cSTUMEmGOH6rlm8evBg6SCyRrkoubo1
        uxrvDBaQG6GJGJbTNiklIv82vXcqfx1r7XShqYzOaYQ3ikaE4Mut+LgkOrW0NPKRwUWJ1m
        vu/ilOqDVEix737i9D35xZWsBKolEutK1kBLMOWLs6AkD0GemcnChTAxj/ej8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=MOoCipyUPUSuz7nAW1zwlopmeSmXAqoVGwOdF+2iuZA=;
        b=h4uNxp6W4JGzU4nbLLoglS+YWGpl5p9knTKfL7555INBje+rSA4SSQoa/tO34CruN3r4dz
        /0a96os4ymqz0FBw==
Date:   Wed, 23 Jun 2021 14:01:49 +0200
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
Subject: [patch V4 22/65] x86/kvm: Avoid looking up PKRU in XSAVE buffer
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

PKRU is being removed from the kernel XSAVE/FPU buffers.  This removal
will probably include warnings for code that look up PKRU in those
buffers.

KVM currently looks up the location of PKRU but doesn't even use the
pointer that it gets back.  Rework the code to avoid calling
get_xsave_addr() except in cases where its result is actually used.

This makes the code more clear and also avoids the inevitable PKRU
warnings.

This is probably a good cleanup and could go upstream idependently
of any PKRU rework.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kvm/x86.c |   41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4589,20 +4589,21 @@ static void fill_xsave(u8 *dest, struct
 	 */
 	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
+		u32 size, offset, ecx, edx;
 		u64 xfeature_mask = valid & -valid;
 		int xfeature_nr = fls64(xfeature_mask) - 1;
-		void *src = get_xsave_addr(xsave, xfeature_nr);
+		void *src;
 
-		if (src) {
-			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, xfeature_nr,
-				    &size, &offset, &ecx, &edx);
-			if (xfeature_nr == XFEATURE_PKRU)
-				memcpy(dest + offset, &vcpu->arch.pkru,
-				       sizeof(vcpu->arch.pkru));
-			else
-				memcpy(dest + offset, src, size);
+		cpuid_count(XSTATE_CPUID, xfeature_nr,
+			    &size, &offset, &ecx, &edx);
 
+		if (xfeature_nr == XFEATURE_PKRU) {
+			memcpy(dest + offset, &vcpu->arch.pkru,
+			       sizeof(vcpu->arch.pkru));
+		} else {
+			src = get_xsave_addr(xsave, xfeature_nr);
+			if (src)
+				memcpy(dest + offset, src, size);
 		}
 
 		valid -= xfeature_mask;
@@ -4632,18 +4633,20 @@ static void load_xsave(struct kvm_vcpu *
 	 */
 	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
+		u32 size, offset, ecx, edx;
 		u64 xfeature_mask = valid & -valid;
 		int xfeature_nr = fls64(xfeature_mask) - 1;
-		void *dest = get_xsave_addr(xsave, xfeature_nr);
 
-		if (dest) {
-			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, xfeature_nr,
-				    &size, &offset, &ecx, &edx);
-			if (xfeature_nr == XFEATURE_PKRU)
-				memcpy(&vcpu->arch.pkru, src + offset,
-				       sizeof(vcpu->arch.pkru));
-			else
+		cpuid_count(XSTATE_CPUID, xfeature_nr,
+			    &size, &offset, &ecx, &edx);
+
+		if (xfeature_nr == XFEATURE_PKRU) {
+			memcpy(&vcpu->arch.pkru, src + offset,
+			       sizeof(vcpu->arch.pkru));
+		} else {
+			void *dest = get_xsave_addr(xsave, xfeature_nr);
+
+			if (dest)
 				memcpy(dest, src + offset, size);
 		}
 

