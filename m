Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD03A1F79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFIV5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:57:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:1785 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhFIV5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:57:49 -0400
IronPort-SDR: a0fFqKkGBi9XU5XubpkbRHdszykVbgj4Qy4YKCxjsPTZU2dPjcLTlIxPzrWRY7VhZsXTk7524o
 DNlB/XbYts3w==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205208546"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="205208546"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:55:53 -0700
IronPort-SDR: FQ0GNVlRiQh+UZXsC8BOiMvL0WdvrxEoQO51jcKNMmZlqAPH5/o9oZXzP0eBdJU6+ZCr9FW0Di
 mxaXFczVD7+Q==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="482555093"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:55:51 -0700
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
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/7] x86/tdx: Add helper to do MapGPA hypercall
Date:   Wed,  9 Jun 2021 14:55:34 -0700
Message-Id: <20210609215537.1956150-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/tdx.h | 17 +++++++++++++++++
 arch/x86/kernel/tdx.c      | 24 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 70e0931bbf52..f20b1f056cdd 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -5,6 +5,15 @@
 
 #define TDX_CPUID_LEAF_ID	0x21
 
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
@@ -123,6 +132,8 @@ do {									\
 #endif
 
 extern phys_addr_t tdg_shared_mask(void);
+extern int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
+				enum tdx_map_type map_type);
 
 #else // !CONFIG_INTEL_TDX_GUEST
 
@@ -147,6 +158,12 @@ static inline phys_addr_t tdg_shared_mask(void)
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
index 1cd572a35eea..591643abae88 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -17,6 +17,9 @@
 #define TDINFO				1
 #define TDGETVEINFO			3
 
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
+
 #define VE_IS_IO_OUT(exit_qual)		(((exit_qual) & 8) ? 0 : 1)
 #define VE_GET_IO_SIZE(exit_qual)	(((exit_qual) & 7) + 1)
 #define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
@@ -121,6 +124,27 @@ static void tdg_get_info(void)
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

