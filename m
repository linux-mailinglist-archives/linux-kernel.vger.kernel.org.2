Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217A3427797
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 07:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbhJIFkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 01:40:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:29176 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244326AbhJIFjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 01:39:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="225410049"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="225410049"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 22:37:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="569280221"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 22:37:58 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Date:   Fri,  8 Oct 2021 22:37:39 -0700
Message-Id: <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
---

Changes since v9:
 * Added inline definition of is_tdx_guest() for !CONFIG_INTEL_TDX_GUEST case.

Changes since v8:
 * Changed is_tdx_guest variable to is_tdx_guest() function.
 * Added -fno-stack-protector and -pg for tdx.c
 * Fixed tdx_early_init() related comments in x86_64_start_kernel()
   as per review suggestion.

Changes since v7:
 * Add comments for the order of tdx_early_init() call.
 * Similar to AMD (sme_me_mask) added a global variable
   is_tdx_guest for Intel TDX related checks.
 * Changed pr_fmt from "x86/tdx: " to "tdx:"

 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/tdx.h         | 22 +++++++++++++++++
 arch/x86/kernel/Makefile           |  4 ++++
 arch/x86/kernel/head64.c           |  9 +++++++
 arch/x86/kernel/tdx.c              | 38 ++++++++++++++++++++++++++++++
 5 files changed, 74 insertions(+)
 create mode 100644 arch/x86/include/asm/tdx.h
 create mode 100644 arch/x86/kernel/tdx.c

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d0ce5cfd3ac1..84997abeb401 100644
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
index 000000000000..96ffce7bc530
--- /dev/null
+++ b/arch/x86/include/asm/tdx.h
@@ -0,0 +1,22 @@
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
+bool is_tdx_guest(void);
+void __init tdx_early_init(void);
+
+#else
+
+static inline bool is_tdx_guest(void) { return false; }
+static inline void tdx_early_init(void) { };
+
+#endif /* CONFIG_INTEL_TDX_GUEST */
+
+#endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2ff3e600f426..8c9a9214dd34 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -22,6 +22,7 @@ CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
 CFLAGS_REMOVE_cc_platform.o = -pg
+CFLAGS_REMOVE_tdx.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
@@ -31,6 +32,7 @@ KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 KASAN_SANITIZE_sev.o					:= n
 KASAN_SANITIZE_cc_platform.o				:= n
+KASAN_SANITIZE_tdx.o					:= n
 
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
@@ -50,6 +52,7 @@ KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
+CFLAGS_tdx.o		+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
@@ -130,6 +133,7 @@ obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
 
 obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
 
 obj-$(CONFIG_EISA)		+= eisa.o
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index fc5371a7e9d1..a5ee90df2aba 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -40,6 +40,7 @@
 #include <asm/extable.h>
 #include <asm/trapnr.h>
 #include <asm/sev.h>
+#include <asm/tdx.h>
 
 /*
  * Manage page tables very early on.
@@ -500,6 +501,14 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 
 	copy_bootdata(__va(real_mode_data));
 
+	/*
+	 * A future dependency on cmdline parameters is expected (for
+	 * adding debug options). So the order of calling it should be
+	 * after copy_bootdata() (in which command line parameter is
+	 * initialized).
+	 */
+	tdx_early_init();
+
 	/*
 	 * Load microcode early on BSP.
 	 */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
new file mode 100644
index 000000000000..88bf12788684
--- /dev/null
+++ b/arch/x86/kernel/tdx.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2020 Intel Corporation */
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "tdx: " fmt
+
+#include <asm/tdx.h>
+
+bool is_tdx_guest(void)
+{
+	static int tdx_guest = -1;
+	u32 eax, sig[3];
+
+	if (tdx_guest >= 0)
+		goto done;
+
+	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID) {
+		tdx_guest = 0;
+		goto done;
+	}
+
+	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);
+
+	tdx_guest = !memcmp("IntelTDX    ", sig, 12);
+
+done:
+	return !!tdx_guest;
+}
+
+void __init tdx_early_init(void)
+{
+	if (!is_tdx_guest())
+		return;
+
+	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
+
+	pr_info("Guest initialized\n");
+}
-- 
2.25.1

