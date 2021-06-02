Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA8397EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhFBCXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:23:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:19500 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230162AbhFBCXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:23:30 -0400
IronPort-SDR: rZNJdNR7dGUETxC9E0rRx03kLkPqmuP7MC1K0DFRLTzo/OuGKmcspA8U64XVz21g3TWARFdzS1
 vQVqGie0/ggg==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="264865326"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="264865326"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:21:48 -0700
IronPort-SDR: daAaICWQ3rPOfD6C31TEsKygK+LZ3HpMKgm3FqR3Oi6w6XCg9j9O75x0Rc+6ypKsH+KaqXBB+B
 BI31ADb1d1Dw==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="633069211"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:21:47 -0700
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v1 06/11] x86/tdx: Get TD execution environment information via TDINFO
Date:   Tue,  1 Jun 2021 19:21:31 -0700
Message-Id: <20210602022136.2186759-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Per Guest-Host-Communication Interface (GHCI) for Intel Trust
Domain Extensions (Intel TDX) specification, sec 2.4.2,
TDCALL[TDINFO] provides basic TD execution environment information, not
provided by CPUID.

Call TDINFO during early boot to be used for following system
initialization.

The call provides info on which bit in pfn is used to indicate that the
page is shared with the host and attributes of the TD, such as debug.

Information about the number of CPUs need not be saved because there are
no users so far for it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 97b54317f799..e4383b416ef3 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -4,6 +4,17 @@
 #define pr_fmt(fmt) "TDX: " fmt
 
 #include <asm/tdx.h>
+#include <asm/vmx.h>
+
+#include <linux/cpu.h>
+
+/* TDX Module call Leaf IDs */
+#define TDINFO				1
+
+static struct {
+	unsigned int gpa_width;
+	unsigned long attributes;
+} td_info __ro_after_init;
 
 /*
  * Wrapper for simple hypercalls that only return a success/error code.
@@ -63,6 +74,19 @@ bool is_tdx_guest(void)
 }
 EXPORT_SYMBOL_GPL(is_tdx_guest);
 
+static void tdg_get_info(void)
+{
+	u64 ret;
+	struct tdx_module_output out = {0};
+
+	ret = __tdx_module_call(TDINFO, 0, 0, 0, 0, &out);
+
+	BUG_ON(ret);
+
+	td_info.gpa_width = out.rcx & GENMASK(5, 0);
+	td_info.attributes = out.rdx;
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
@@ -70,5 +94,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	tdg_get_info();
+
 	pr_info("TDX guest is initialized\n");
 }
-- 
2.25.1

