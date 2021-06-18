Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B458C3AD593
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhFRXA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:00:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:13196 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235182AbhFRXAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:00:50 -0400
IronPort-SDR: PazSkuHpfesoXmULStX1e/wfTHNYiOHNB+MEdJhsdZMFugGPG67oucG+xjvLkSBDzBUx5UEaAn
 ZlamDQU/3JTw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193763415"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193763415"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:40 -0700
IronPort-SDR: UNu4zuK7r2lH0OykgbY4DHttUTsBMpABlDyNiuzS4AcEN5ACxGBTIJf24Oi7pFRx+jIicPxIX3
 B0jtFUu2YvlQ==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="554874179"
Received: from shahdhav-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.6.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:39 -0700
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
Subject: [PATCH v3 06/11] x86/tdx: Get TD execution environment information via TDINFO
Date:   Fri, 18 Jun 2021 15:57:50 -0700
Message-Id: <20210618225755.662725-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/kernel/tdx.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 9e846b0d7353..98778f44bbc6 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -8,6 +8,14 @@
 
 #include <asm/tdx.h>
 
+/* TDX Module call Leaf IDs */
+#define TDINFO				1
+
+static struct {
+	unsigned int gpa_width;
+	unsigned long attributes;
+} td_info __ro_after_init;
+
 /*
  * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
  * for TDCALL error.
@@ -58,6 +66,19 @@ bool tdx_protected_guest_has(unsigned long flag)
 }
 EXPORT_SYMBOL_GPL(tdx_protected_guest_has);
 
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
@@ -65,5 +86,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	tdg_get_info();
+
 	pr_info("Guest initialized\n");
 }
-- 
2.25.1

