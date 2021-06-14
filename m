Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC913A6C20
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhFNQlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbhFNQkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:31 -0400
Message-Id: <20210614155357.263233420@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9QwN7jhQd4WnrDb9fTUBlYu57m1XCqQt5CMGmBh5Sq0=;
        b=Qt0heUxw0pukAy7KYlAi9KKAs36J7yOdtxC5t8Grzv2R0lG1CYgwYEZcGGG/rOk9kDZGEz
        73fHUh4DQMfW+0vGpsv54Obt8ABBl0HBs/+JYKLKLDHFEyfoHDTP1QqpgHASeu5aSkRdWN
        fQo8JxBlbzw7Yo3xj5RLVfCxGtqkpM0jdhk6skXC7xdv6bPC7fHcb/28eaf5eUgB3Yp7ND
        CvdgF7F3eLwh/eWKi1jx4IvNO7pcllXeWCPh7GnUmjqhQqN4kySvBl8I1s6S65JpnhZ2jV
        jIpr65LA1PEq9EnqdRf+ndmAFcB6jk3LyZk4YVIwzPcTIcVzQlNEkpl6N8tL+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9QwN7jhQd4WnrDb9fTUBlYu57m1XCqQt5CMGmBh5Sq0=;
        b=z1vD1JFF50chpVfahO4J5LEdYkoKeGY4DQXpFCz0i3nuakVBRT0UWfizAPX5vXIcifJiRS
        W7ug7h+oslro8oAQ==
Date:   Mon, 14 Jun 2021 17:44:43 +0200
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
Subject: [patch V2 35/52] x86/cpu: Sanitize X86_FEATURE_OSPKE
References: <20210614154408.673478623@linutronix.de>
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
 arch/x86/include/asm/pkeys.h |    8 ++++----
 arch/x86/include/asm/pkru.h  |    4 ++--
 arch/x86/kernel/cpu/common.c |   24 +++++++++++-------------
 arch/x86/kernel/fpu/core.c   |    2 +-
 arch/x86/kernel/fpu/xstate.c |    2 +-
 arch/x86/kernel/process_64.c |    2 +-
 arch/x86/mm/fault.c          |    2 +-
 7 files changed, 21 insertions(+), 23 deletions(-)

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
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -32,7 +32,7 @@ static inline bool __pkru_allows_write(u
 
 static inline u32 read_pkru(void)
 {
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return rdpkru();
 	return 0;
 }
@@ -41,7 +41,7 @@ static inline void write_pkru(u32 pkru)
 {
 	struct pkru_state *pk;
 
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return;
 
 	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -466,22 +466,20 @@ static bool pku_disabled;
 
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
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -377,7 +377,7 @@ static inline void load_fpregs_from_init
 	else
 		frstor_from_kernel(&init_fpstate.fsave);
 
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
 		copy_init_pkru_to_fpregs();
 }
 
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -915,7 +915,7 @@ int arch_set_user_pkey_access(struct tas
 	 * This check implies XSAVE support.  OSPKE only gets
 	 * set if we enable XSAVE and we enable PKU in XCR0.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return -EINVAL;
 
 	/*
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -137,7 +137,7 @@ void __show_regs(struct pt_regs *regs, e
 		       log_lvl, d3, d6, d7);
 	}
 
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
 		printk("%sPKRU: %08x\n", log_lvl, read_pkru());
 }
 
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

