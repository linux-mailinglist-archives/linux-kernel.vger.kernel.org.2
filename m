Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F211311AE2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBFEaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:30:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:63380 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232432AbhBFDTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:19:21 -0500
IronPort-SDR: uf/lD20PbJEUvAPph0bKzutY8X+S70VqadNLhjDbnrnY71b4ubi4ikFhYyehRLs3bcGOCUg8i1
 teXyTmpH1JjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650713"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650713"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:05 -0800
IronPort-SDR: bGvalxL17+5//YyhKmU5p3ve6Giy7z041c9mrfSDfk5nTSsz9TufMc6fUpr24XaxMnTHx924Op
 OB1lw7NZZrPQ==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183872"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:05 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 04/26] x86/tdx: Get TD execution environment information via TDINFO
Date:   Fri,  5 Feb 2021 15:38:21 -0800
Message-Id: <a5757dafc54932a6661fc94f51e413467b61fecf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/tdx.h |  9 +++++++++
 arch/x86/kernel/tdx.c      | 27 +++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 0b9d571b1f95..f8cdc8eb1046 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -7,6 +7,15 @@
 
 #ifdef CONFIG_INTEL_TDX_GUEST
 
+/*
+ * TDCALL instruction is newly added in TDX architecture,
+ * used by TD for requesting the host VMM to provide
+ * (untrusted) services.
+ */
+#define TDCALL	".byte 0x66,0x0f,0x01,0xcc"
+
+#define TDINFO		1
+
 /* Common API to check TDX support in decompression and common kernel code. */
 bool is_tdx_guest(void);
 
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index e44e55d1e519..13303bfdfdd1 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -3,6 +3,14 @@
 
 #include <asm/tdx.h>
 #include <asm/cpufeature.h>
+#include <linux/cpu.h>
+#include <asm/tdx.h>
+#include <asm/vmx.h>
+
+static struct {
+	unsigned int gpa_width;
+	unsigned long attributes;
+} td_info __ro_after_init;
 
 static inline bool cpuid_has_tdx_guest(void)
 {
@@ -26,6 +34,23 @@ bool is_tdx_guest(void)
 }
 EXPORT_SYMBOL_GPL(is_tdx_guest);
 
+static void tdx_get_info(void)
+{
+	register long rcx asm("rcx");
+	register long rdx asm("rdx");
+	register long r8 asm("r8");
+	long ret;
+
+	asm volatile(TDCALL
+		     : "=a"(ret), "=c"(rcx), "=r"(rdx), "=r"(r8)
+		     : "a"(TDINFO)
+		     : "r9", "r10", "r11", "memory");
+	BUG_ON(ret);
+
+	td_info.gpa_width = rcx & GENMASK(5, 0);
+	td_info.attributes = rdx;
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
@@ -33,5 +58,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	tdx_get_info();
+
 	pr_info("TDX guest is initialized\n");
 }
-- 
2.25.1

