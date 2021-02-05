Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C874311A52
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhBFDjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:39:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:27740 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhBFCkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:40:32 -0500
IronPort-SDR: NUGktOea8d6OUVxcLl8S9OuXyfTvFNNr2nM3VVjNUvz2pfVlVMzRCZ8h8Qp3vdrzSyKalXeFWI
 y/eTj+0iUMYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650762"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:17 -0800
IronPort-SDR: H04b4hwdRKCyvow1fyg+DtTxt3m0hvCxdGBglzy13iOA+aimoR9eyHsH4L/dhJhxSJKTxXHD4S
 5Klc3InBRUYg==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183984"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:16 -0800
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
Subject: [RFC v1 24/26] x86/tdx: Add helper to do MapGPA TDVMALL
Date:   Fri,  5 Feb 2021 15:38:41 -0800
Message-Id: <4a85f938ca1f445870d72a99f1719b8cd3edf771.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/include/asm/tdx.h |  2 ++
 arch/x86/kernel/tdx.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 9bbfe6520ea4..efffdef35c78 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -105,5 +105,7 @@ long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
 		unsigned long p3, unsigned long p4);
 
 phys_addr_t tdx_shared_mask(void);
+
+int tdx_map_gpa(phys_addr_t gpa, int numpages, bool private);
 #endif
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 9681f4a0b4e0..f99fe54b4f88 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -14,6 +14,8 @@
 #include "tdx-kvm.c"
 #endif
 
+#define TDVMCALL_MAP_GPA	0x10001
+
 static struct {
 	unsigned int gpa_width;
 	unsigned long attributes;
@@ -66,6 +68,32 @@ static void tdx_get_info(void)
 	physical_mask &= ~tdx_shared_mask();
 }
 
+int tdx_map_gpa(phys_addr_t gpa, int numpages, bool private)
+{
+	register long r10 asm("r10") = TDVMCALL_STANDARD;
+	register long r11 asm("r11") = TDVMCALL_MAP_GPA;
+	register long r12 asm("r12") = gpa;
+	register long r13 asm("r13") = PAGE_SIZE * numpages;
+	register long rcx asm("rcx");
+	long ret;
+
+	if (!private)
+		r12 |= tdx_shared_mask();
+
+	/* Allow to pass R10, R11, R12 and R13 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
+			  "r"(r13)
+			: );
+
+	// Host kernel doesn't implement it yet.
+	// WARN_ON(ret || r10);
+	return ret || r10 ? -EIO : 0;
+}
+
 static __cpuidle void tdx_halt(void)
 {
 	register long r10 asm("r10") = TDVMCALL_STANDARD;
-- 
2.25.1

