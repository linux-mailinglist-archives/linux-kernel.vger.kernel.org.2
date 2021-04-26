Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DB536B88C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhDZSDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:03:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:31731 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234253AbhDZSDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:25 -0400
IronPort-SDR: P0fxBA2nhGMJai/yrHCly/vKj6yXC8KBqoZQSHJxU3cjxXU/cE4g3jxM5HuN5+9EUAj6wnv7UV
 eM/WPJDHPMWg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="195934028"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="195934028"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:43 -0700
IronPort-SDR: Xvmcw8Mk+YpE2jfSj1VRmh8UdnmmtQLmXrQCfp9YXc3AnR5r9hZQhsUS6RdMNNqe49KwAiguJy
 mPfUNGKsPv9A==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353349"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:42 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 06/32] x86/tdx: Get TD execution environment information via TDINFO
Date:   Mon, 26 Apr 2021 11:01:33 -0700
Message-Id: <867d88656607d2f572d382e158318dc19d44564c.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

We don't save information about the number of cpus as there's no users
so far.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/tdx.h |  2 ++
 arch/x86/kernel/tdx.c      | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 6c3c71bb57a0..c5a870cef0ae 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -10,6 +10,8 @@
 #include <asm/cpufeature.h>
 #include <linux/types.h>
 
+#define TDINFO			1
+
 struct tdcall_output {
 	u64 rcx;
 	u64 rdx;
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 29c52128b9c0..b63275db1db9 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -4,6 +4,14 @@
 #define pr_fmt(fmt) "TDX: " fmt
 
 #include <asm/tdx.h>
+#include <asm/vmx.h>
+
+#include <linux/cpu.h>
+
+static struct {
+	unsigned int gpa_width;
+	unsigned long attributes;
+} td_info __ro_after_init;
 
 /*
  * Wrapper for use case that checks for error code and print warning message.
@@ -61,6 +69,19 @@ bool is_tdx_guest(void)
 }
 EXPORT_SYMBOL_GPL(is_tdx_guest);
 
+static void tdg_get_info(void)
+{
+	u64 ret;
+	struct tdcall_output out = {0};
+
+	ret = __tdcall(TDINFO, 0, 0, 0, 0, &out);
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
@@ -68,5 +89,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	tdg_get_info();
+
 	pr_info("TDX guest is initialized\n");
 }
-- 
2.25.1

