Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDD36B8A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhDZSFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:05:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:20703 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234332AbhDZSDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:43 -0400
IronPort-SDR: /cLCCydUj5EWjQGJMDnSFAOEcEL/gNNM3dTyIZyywcgPmt8em8MDYw6Cr7yZg0XjK9ury13QHG
 5+3YG+Ey9S/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="257683621"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="257683621"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:57 -0700
IronPort-SDR: c7r8uBpw/DRcK2HKy1W1UJV7XGAIA7MmmcGl3XXUKt+HZP4hnsBqEMUBOCeqynRTx7H0ObSVdj
 Pr7k5Eb7UXNA==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353452"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:56 -0700
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
Subject: [RFC v2 29/32] x86/tdx: Add helper to do MapGPA TDVMALL
Date:   Mon, 26 Apr 2021 11:01:56 -0700
Message-Id: <7d43f57c3b178a905ef2505cef5313844c497984.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

MapGPA TDVMCALL requests the host VMM to map a GPA range as private or
shared memory mappings. Shared GPA mappings can be used for
communication beteen TD guest and host VMM, for example for
paravirtualized IO.

The new helper tdx_map_gpa() provides access to the operation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/tdx.h | 13 +++++++++++++
 arch/x86/kernel/tdx.c      | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index dc80cf7f7d08..4789798d7737 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -7,6 +7,11 @@
 
 #ifndef __ASSEMBLY__
 
+enum tdx_map_type {
+	TDX_MAP_PRIVATE,
+	TDX_MAP_SHARED,
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 #include <asm/cpufeature.h>
@@ -112,6 +117,8 @@ unsigned short tdg_inw(unsigned short port);
 unsigned int tdg_inl(unsigned short port);
 
 extern phys_addr_t tdg_shared_mask(void);
+extern int tdg_map_gpa(phys_addr_t gpa, int numpages,
+		       enum tdx_map_type map_type);
 
 #else // !CONFIG_INTEL_TDX_GUEST
 
@@ -155,6 +162,12 @@ static inline phys_addr_t tdg_shared_mask(void)
 {
 	return 0;
 }
+
+static inline int tdg_map_gpa(phys_addr_t gpa, int numpages,
+			      enum tdx_map_type map_type)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_INTEL_TDX_GUEST */
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 7e391cd7aa2b..074136473011 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -15,6 +15,8 @@
 #include "tdx-kvm.c"
 #endif
 
+#define TDVMCALL_MAP_GPA	0x10001
+
 static struct {
 	unsigned int gpa_width;
 	unsigned long attributes;
@@ -98,6 +100,17 @@ static void tdg_get_info(void)
 	physical_mask &= ~tdg_shared_mask();
 }
 
+int tdg_map_gpa(phys_addr_t gpa, int numpages, enum tdx_map_type map_type)
+{
+	u64 ret;
+
+	if (map_type == TDX_MAP_SHARED)
+		gpa |= tdg_shared_mask();
+
+	ret = tdvmcall(TDVMCALL_MAP_GPA, gpa, PAGE_SIZE * numpages, 0, 0);
+	return ret ? -EIO : 0;
+}
+
 static __cpuidle void tdg_halt(void)
 {
 	u64 ret;
-- 
2.25.1

