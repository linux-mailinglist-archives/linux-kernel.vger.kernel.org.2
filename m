Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE643926A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhE0E6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:58:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:29423 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233424AbhE0E6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:58:20 -0400
IronPort-SDR: /Un19rduIl/0g1gNalq8OTkfx7q50H35HM0OkSGs/lW+oL5MbTNm5YEIpBLgPx6B6G18ToWBqA
 NrXrhun+j5iw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202411868"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="202411868"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:56:45 -0700
IronPort-SDR: eTyRWFmly24HJWPrqsRiLIgtNJHdppHF4cp1Y4Pv9xZVOIr8tshTpBccaalr8WEHcrO+AjGKgk
 mqVkzzGUsvpg==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="633830957"
Received: from skgangad-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.33.45])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:56:45 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v1 1/1] x86/tdx: Add helper to do MapGPA hypercall
Date:   Wed, 26 May 2021 21:56:38 -0700
Message-Id: <20210527045638.3985072-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <57690b33-e7da-e345-dfae-b2e18f9a1467@linux.intel.com>
References: <57690b33-e7da-e345-dfae-b2e18f9a1467@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

MapGPA hypercall is used by TDX guests to request VMM convert
the existing mapping of given GPA address range between
private/shared.

tdx_hcall_gpa_intent() is the wrapper used for making MapGPA
hypercall.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2:
  * Renamed tdg_map_gpa() to tdx_hcall_gpa_intent().
  * Fixed commit log and comments as per review comments.

 arch/x86/include/asm/tdx.h | 17 +++++++++++++++++
 arch/x86/kernel/tdx.c      | 24 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a93528246595..eb9fa5f4d0e3 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -7,6 +7,15 @@
 
 #ifndef __ASSEMBLY__
 
+/*
+ * Page mapping type enum. This is software construct not
+ * part of any hardware or VMM ABI.
+ */
+enum tdx_map_type {
+	TDX_MAP_PRIVATE,
+	TDX_MAP_SHARED,
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 #include <asm/cpufeature.h>
@@ -119,6 +128,8 @@ do {									\
 #endif
 
 extern phys_addr_t tdg_shared_mask(void);
+extern int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
+				enum tdx_map_type map_type);
 
 #else // !CONFIG_INTEL_TDX_GUEST
 
@@ -143,6 +154,12 @@ static inline phys_addr_t tdg_shared_mask(void)
 {
 	return 0;
 }
+
+static inline int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
+				       enum tdx_map_type map_type)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #ifdef CONFIG_INTEL_TDX_GUEST_KVM
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 0c8b10b78f32..a8ebd2d10093 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -16,6 +16,9 @@
 #define TDINFO				1
 #define TDGETVEINFO			3
 
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
+
 #define VE_GET_IO_TYPE(exit_qual)      (((exit_qual) & 8) ? 0 : 1)
 #define VE_GET_IO_SIZE(exit_qual)      (((exit_qual) & 7) + 1)
 #define VE_GET_PORT_NUM(exit_qual)     ((exit_qual) >> 16)
@@ -122,6 +125,27 @@ static void tdg_get_info(void)
 	physical_mask &= ~tdg_shared_mask();
 }
 
+/*
+ * Inform the VMM of the guest's intent for this physical page:
+ * shared with the VMM or private to the guest.  The VMM is
+ * expected to change its mapping of the page in response.
+ *
+ * Note: shared->private conversions require further guest
+ * action to accept the page.
+ */
+int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
+			 enum tdx_map_type map_type)
+{
+	u64 ret;
+
+	if (map_type == TDX_MAP_SHARED)
+		gpa |= tdg_shared_mask();
+
+	ret = tdx_hypercall(TDVMCALL_MAP_GPA, gpa, PAGE_SIZE * numpages, 0, 0);
+
+	return ret ? -EIO : 0;
+}
+
 static __cpuidle void tdg_halt(void)
 {
 	u64 ret;
-- 
2.25.1

