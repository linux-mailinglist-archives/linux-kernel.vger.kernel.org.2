Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D68A3E1F68
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbhHEXbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:31:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:6546 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242395AbhHEXbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:31:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="201448378"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="201448378"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 16:31:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="481043918"
Received: from rmgular-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 16:31:09 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>
Subject: [PATCH v3 5/5] x86/tdx: Add option to override prot values
Date:   Thu,  5 Aug 2021 16:30:36 -0700
Message-Id: <20210805233036.2949674-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805233036.2949674-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210805233036.2949674-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The kernel internally uses prot_guest_has to configure various behavior
specific to confidential guests. Allow to clear a single value. This is
mainly useful for debugging and not very user friendly because the hex
values from the include file have to be used. But for debugging it's
good enough and it matches the existing clear_cpuid option.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 arch/x86/include/asm/tdx.h                      |  2 ++
 arch/x86/kernel/tdx.c                           | 15 +++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ba390be62f89..10776a743e74 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5573,6 +5573,14 @@
 
 	tdfx=		[HW,DRM]
 
+	tdx_prot_clear=val
+			Clear a prot setting for TDX. See
+			include/linux/protected_guest.h for the allowed
+			values. Only a single value can be overridden.
+			Note that invalid values here may break the TDX kernel,
+			this is mainly for debugging. Clearing protections
+			may cause security holes.
+
 	test_suspend=	[SUSPEND][,N]
 			Specify "mem" (for Suspend-to-RAM) or "standby" (for
 			standby suspend) or "freeze" (for suspend type freeze)
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 665c8cf57d5b..dd5459ece9aa 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,8 @@ enum tdx_map_type {
 
 #ifdef CONFIG_INTEL_TDX_GUEST
 
+extern unsigned int tdg_disable_prot;
+
 void __init tdx_early_init(void);
 
 bool tdx_prot_guest_has(unsigned long flag);
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 644e90dfa587..bfa168f3f09c 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -12,6 +12,7 @@
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/cmdline.h>
 #include <linux/sched/signal.h> /* force_sig_fault() */
 #include <linux/swiotlb.h>
 
@@ -41,6 +42,8 @@ static struct {
 	unsigned long attributes;
 } td_info __ro_after_init;
 
+unsigned int tdg_disable_prot = -1;
+
 /*
  * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
  * for TDCALL error.
@@ -111,6 +114,9 @@ static inline bool cpuid_has_tdx_guest(void)
 
 bool tdx_prot_guest_has(unsigned long flag)
 {
+	if (flag == tdg_disable_prot)
+		return false;
+
 	switch (flag) {
 	case PATTR_GUEST_TDX:
 	case PATTR_GUEST_UNROLL_STRING_IO:
@@ -555,6 +561,8 @@ __init bool tdg_early_handle_ve(struct pt_regs *regs)
 
 void __init tdx_early_init(void)
 {
+	char prot_clear[30];
+
 	if (!cpuid_has_tdx_guest())
 		return;
 
@@ -572,5 +580,12 @@ void __init tdx_early_init(void)
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdg:cpu_hotplug",
 			  NULL, tdg_cpu_offline_prepare);
 
+	if (cmdline_find_option(boot_command_line, "tdx_prot_clear",
+				prot_clear, sizeof(prot_clear))) {
+		if (kstrtouint(prot_clear, 0, &tdg_disable_prot))
+			pr_err("Unparsable tdx_prot_clear= option\n");
+		add_taint(TAINT_CONF_NO_LOCKDOWN, LOCKDEP_STILL_OK);
+	}
+
 	pr_info("Guest initialized\n");
 }
-- 
2.25.1

