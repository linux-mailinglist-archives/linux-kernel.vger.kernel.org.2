Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496CF40E9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbhIPSha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:37:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:52266 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348118AbhIPShX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:37:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="286319720"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="286319720"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 11:36:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="545819388"
Received: from rswart-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.255.64.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 11:36:00 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v7 01/12] x86/tdx: Add Intel ARCH support to cc_platform_has()
Date:   Thu, 16 Sep 2021 11:35:39 -0700
Message-Id: <20210916183550.15349-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc_platform_has() can be used to check for specific active confidential
computing attributes, like memory encryption. For Intel platform like
Trusted Domain eXtensions (TDX) guest has need for using this function
to protect the TDX specific changes made in generic drivers.

So, extend cc_platform_has() and add support for Intel architecture
variant (intel_cc_platform_has())

This is a preparatory commit needed before adding TDX guest support
to intel_cc_platform_has().

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/intel_cc_platform.h | 15 +++++++++++++++
 arch/x86/kernel/cc_platform.c            |  5 +++++
 arch/x86/kernel/cpu/intel.c              |  9 +++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 arch/x86/include/asm/intel_cc_platform.h

diff --git a/arch/x86/include/asm/intel_cc_platform.h b/arch/x86/include/asm/intel_cc_platform.h
new file mode 100644
index 000000000000..73da3dc934d1
--- /dev/null
+++ b/arch/x86/include/asm/intel_cc_platform.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Intel Corporation */
+#ifndef _ASM_X86_INTEL_CC_PLATFORM_H
+#define _ASM_X86_INTEL_CC_PLATFORM_H
+
+#include <linux/cc_platform.h>
+
+#if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_ARCH_HAS_CC_PLATFORM)
+bool intel_cc_platform_has(enum cc_attr attr);
+#else
+static inline bool intel_cc_platform_has(enum cc_attr attr) { return false; }
+#endif
+
+#endif /* _ASM_X86_INTEL_CC_PLATFORM_H */
+
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 3c9bacd3c3f3..e83bc2f48efe 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -10,11 +10,16 @@
 #include <linux/export.h>
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
+#include <linux/processor.h>
+
+#include <asm/intel_cc_platform.h>
 
 bool cc_platform_has(enum cc_attr attr)
 {
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return intel_cc_platform_has(attr);
 
 	return false;
 }
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..5f45d51020b7 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -26,6 +26,7 @@
 #include <asm/resctrl.h>
 #include <asm/numa.h>
 #include <asm/thermal.h>
+#include <asm/intel_cc_platform.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -60,6 +61,14 @@ static u64 msr_test_ctrl_cache __ro_after_init;
  */
 static bool cpu_model_supports_sld __ro_after_init;
 
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+bool intel_cc_platform_has(enum cc_attr attr)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(intel_cc_platform_has);
+#endif
+
 /*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists
-- 
2.25.1

