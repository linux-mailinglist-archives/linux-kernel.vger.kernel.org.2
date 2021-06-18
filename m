Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE373AD590
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhFRXAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:00:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:13194 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235103AbhFRXAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:00:46 -0400
IronPort-SDR: 3ILaMeQbZvrt7oIQkrIWjw1MyPbg/qZ1YHpa+bHuIO8m2/ryxPqUVtvG1iI20HHHyMsinpbh9p
 rCjOPdW6plkg==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193763410"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193763410"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:36 -0700
IronPort-SDR: E59s8rgxIco6tfF6zq/ou6uM4z5dsPVtQzLSZbb5HCU4bJGMZvQVOsWhaYV4IZWJsURhh243xv
 GTkQIMtcBhIg==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="554874167"
Received: from shahdhav-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.6.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:35 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Date:   Fri, 18 Jun 2021 15:57:47 -0700
Message-Id: <20210618225755.662725-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU feature detection for Trusted Domain Extensions support. TDX
feature adds capabilities to keep guest register state and memory
isolated from hypervisor.

For TDX guest platforms, executing CPUID(eax=0x21, ecx=0) will return
following values in EAX, EBX, ECX and EDX.

EAX:  Maximum sub-leaf number:  0
EBX/EDX/ECX:  Vendor string:

EBX =  "Inte"
EDX =  "lTDX"
ECX =  "    "

So when above condition is true, set X86_FEATURE_TDX_GUEST feature cap
bit.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---

Changes since v2:
 * Fixed debug prints as per Borislav suggestion.

Changes since v1:
 * Fixed commit log issues reported by Borislav.
 * Moved header file include to the start of tdx.h.
 * Added pr_fmt for TDX.
 * Simplified cpuid_has_tdx_guest() implementation as per
   Borislav comments.

 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/tdx.h         | 20 ++++++++++++++++++++
 arch/x86/kernel/Makefile           |  1 +
 arch/x86/kernel/head64.c           |  3 +++
 arch/x86/kernel/tdx.c              | 29 +++++++++++++++++++++++++++++
 5 files changed, 54 insertions(+)
 create mode 100644 arch/x86/include/asm/tdx.h
 create mode 100644 arch/x86/kernel/tdx.c

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ac37830ae941..dddc3a27cc8a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -238,6 +238,7 @@
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
 #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted function */
+#define X86_FEATURE_TDX_GUEST		( 8*32+22) /* Trusted Domain Extensions Guest */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
new file mode 100644
index 000000000000..c738bde944d1
--- /dev/null
+++ b/arch/x86/include/asm/tdx.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 Intel Corporation */
+#ifndef _ASM_X86_TDX_H
+#define _ASM_X86_TDX_H
+
+#include <linux/cpufeature.h>
+
+#define TDX_CPUID_LEAF_ID	0x21
+
+#ifdef CONFIG_INTEL_TDX_GUEST
+
+void __init tdx_early_init(void);
+
+#else
+
+static inline void tdx_early_init(void) { };
+
+#endif /* CONFIG_INTEL_TDX_GUEST */
+
+#endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0f66682ac02a..af09ce93a641 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
 
 obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
 
 obj-$(CONFIG_EISA)		+= eisa.o
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de01903c3735..d1a4942ae160 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -40,6 +40,7 @@
 #include <asm/extable.h>
 #include <asm/trapnr.h>
 #include <asm/sev.h>
+#include <asm/tdx.h>
 
 /*
  * Manage page tables very early on.
@@ -491,6 +492,8 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 
 	kasan_early_init();
 
+	tdx_early_init();
+
 	idt_setup_early_handler();
 
 	copy_bootdata(__va(real_mode_data));
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
new file mode 100644
index 000000000000..b1492e076168
--- /dev/null
+++ b/arch/x86/kernel/tdx.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2020 Intel Corporation */
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "x86/tdx: " fmt
+
+#include <asm/tdx.h>
+
+static inline bool cpuid_has_tdx_guest(void)
+{
+	u32 eax, sig[3];
+
+	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID)
+		return false;
+
+	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[1], &sig[2]);
+
+	return !memcmp("IntelTDX    ", sig, 12);
+}
+
+void __init tdx_early_init(void)
+{
+	if (!cpuid_has_tdx_guest())
+		return;
+
+	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
+
+	pr_info("Guest initialized\n");
+}
-- 
2.25.1

