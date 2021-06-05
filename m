Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE839CBE9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhFFAea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhFFAeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:34:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51567C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 17:32:31 -0700 (PDT)
Message-Id: <20210606001323.835578558@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622939550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vCDSvW2WWgWFE/1rk5H8IPIAmQawC5j8QKFBjGVgagQ=;
        b=nI81TUt3rx3fBtKQJ+IujwfLJyfMUvO8rHwA7WWluOLzc+NQNvVawNmIAI9ZQx8Ep333AF
        UjUOcIKVbHy1NFUqKRwpCz4IPzliuDeaP9Uw33A6lPRMYb4xe773tCNKdWEJaGLeta9qPa
        nKXN3JsA7nvrrHIv3b1vAqkL+ckcJl13u0mSF+jhyfXD1PxTupuNAHhiSQlGHt5pJdkG2D
        /hVA45lwfNEL4yPz24lY01st64GESSqN0j8nedH0AGMLgQ/rKMAftWqhFyuoD+Pi/CjrQI
        fFztCn+8wW8/E7tBzx5huA8piW7GiUIfMAjPkuQyStzbyW/msQSrBukQCStCxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622939550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vCDSvW2WWgWFE/1rk5H8IPIAmQawC5j8QKFBjGVgagQ=;
        b=hwmHcuGt+gPZ5yWXXl6NeO8TRK5cW8BhcQExqaBzn1dTh4hbMy7Q470IZVozpPsf/huP0g
        r6JzAZSb8lN/1dCQ==
Date:   Sun, 06 Jun 2021 01:47:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 09/14] x86/cpu: Sanitize X86_FEATURE_OSPKE
References: <20210605234742.712464974@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X86_FEATURE_OSPKE is enabled first on the boot CPU and the feature flag is
set. Secondary CPUs have to enable CR4.PKE as well and set their per CPU
feature flag. That's ineffective because all call sites have checks for
boot_cpu_data.

Make it smarter and force the feature flag when PKU is enabled on the boot
cpu which allows then to use cpu_feature_enabled(X86_FEATURE_OSPKE) all
over the place. That either compiles the code out when PKEY support is
disabled in Kconfig or uses a static_cpu_has() for the feature check which
makes a significant difference in hotpathes, e.g. context switch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/pgtable.h |    4 ++--
 arch/x86/include/asm/pkeys.h   |    8 ++++----
 arch/x86/kernel/cpu/common.c   |   24 +++++++++++-------------
 arch/x86/kernel/fpu/xstate.c   |    2 +-
 arch/x86/mm/fault.c            |    2 +-
 5 files changed, 19 insertions(+), 21 deletions(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -129,7 +129,7 @@ static inline int pte_dirty(pte_t pte)
 
 static inline u32 read_pkru(void)
 {
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return rdpkru();
 	return 0;
 }
@@ -138,7 +138,7 @@ static inline void write_pkru(u32 pkru)
 {
 	struct pkru_state *pk;
 
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return;
 
 	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -9,14 +9,14 @@
  * will be necessary to ensure that the types that store key
  * numbers and masks have sufficient capacity.
  */
-#define arch_max_pkey() (boot_cpu_has(X86_FEATURE_OSPKE) ? 16 : 1)
+#define arch_max_pkey() (cpu_feature_enabled(X86_FEATURE_OSPKE) ? 16 : 1)
 
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 
 static inline bool arch_pkeys_enabled(void)
 {
-	return boot_cpu_has(X86_FEATURE_OSPKE);
+	return cpu_feature_enabled(X86_FEATURE_OSPKE);
 }
 
 /*
@@ -26,7 +26,7 @@ static inline bool arch_pkeys_enabled(vo
 extern int __execute_only_pkey(struct mm_struct *mm);
 static inline int execute_only_pkey(struct mm_struct *mm)
 {
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return ARCH_DEFAULT_PKEY;
 
 	return __execute_only_pkey(mm);
@@ -37,7 +37,7 @@ extern int __arch_override_mprotect_pkey
 static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 		int prot, int pkey)
 {
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return 0;
 
 	return __arch_override_mprotect_pkey(vma, prot, pkey);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -465,22 +465,20 @@ static bool pku_disabled;
 
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
-	/* check the boot processor, plus compile options for PKU: */
-	if (!cpu_feature_enabled(X86_FEATURE_PKU))
-		return;
-	/* checks the actual processor's cpuid bits: */
-	if (!cpu_has(c, X86_FEATURE_PKU))
-		return;
-	if (pku_disabled)
+	if (c == &boot_cpu_data) {
+		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
+			return;
+		/*
+		 * Setting CR4.PKE will cause the X86_FEATURE_OSPKE cpuid
+		 * bit to be set.  Enforce it.
+		 */
+		setup_force_cpu_cap(X86_FEATURE_OSPKE);
+
+	} else if (!cpu_feature_enabled(X86_FEATURE_OSPKE)) {
 		return;
+	}
 
 	cr4_set_bits(X86_CR4_PKE);
-	/*
-	 * Setting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
-	 * cpuid bit to be set.  We need to ensure that we
-	 * update that bit in this CPU's "cpu_info".
-	 */
-	set_cpu_cap(c, X86_FEATURE_OSPKE);
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1002,7 +1002,7 @@ int arch_set_user_pkey_access(struct tas
 	 * This check implies XSAVE support.  OSPKE only gets
 	 * set if we enable XSAVE and we enable PKU in XCR0.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return -EINVAL;
 
 	/*
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -875,7 +875,7 @@ static inline bool bad_area_access_from_
 	/* This code is always called on the current mm */
 	bool foreign = false;
 
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return false;
 	if (error_code & X86_PF_PK)
 		return true;

