Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5DD3A08E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhFIBMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:12:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:4545 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhFIBMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:12:33 -0400
IronPort-SDR: NWGxnZYkjaV3BXAmIzhqpx5+yWe3Dp6cE5B55HCyDCXtBnLA/tH2trUEw7ZFmIneFsqFaG8vjv
 VNaMB4Zi3qaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="204945263"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="204945263"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 18:10:36 -0700
IronPort-SDR: utZxyyNe3y7pg7wb9UwrXKbm43aoJ5qnhu2hF7ABjYpQoJhziEJIBYO6XRQfISgnAtQMzxQCGh
 NfD33/Yed3Nw==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="402269682"
Received: from ticela-az-103.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.36.77])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 18:10:35 -0700
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
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
Date:   Tue,  8 Jun 2021 18:10:30 -0700
Message-Id: <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current TDX spec does not have support to emulate the WBINVD
instruction. If any feature that uses WBINVD is enabled/used
in TDX guest, it will lead to un-handled #VE exception, which
will be handled as #GP fault.

ACPI drivers also uses WBINVD instruction for cache flushes in
reboot or shutdown code path. Since TDX guest has requirement
to support shutdown feature, skip WBINVD instruction usage
in ACPI drivers for TDX guest.

Since cache is always coherent in TDX guests, making wbinvd as
noop should not cause any issues in above mentioned code path.
The end-behavior is the same as KVM guest (treat as noops).

In future, once TDX guest specification adds support for WBINVD
hypercall, we can pass the handle to KVM to handle it.
   
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2-fix-v3:
 * Fixed commit log as per review comments.
 * Instead of fixing all usages of ACPI_FLUSH_CPU_CACHE(),
   created TDX specific exception for it in its implementation.

Changes since RFC v2-fix-v2:
 * Instead of handling WBINVD #VE exception as nop, we skip its
   usage in currently enabled drivers.
 * Adapted commit log for above change.

 arch/x86/include/asm/acenv.h    | 7 ++++++-
 arch/x86/kernel/tdx.c           | 1 +
 include/linux/protected_guest.h | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
index 9aff97f0de7f..36c87b69366b 100644
--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -10,10 +10,15 @@
 #define _ASM_X86_ACENV_H
 
 #include <asm/special_insns.h>
+#include <linux/protected_guest.h>
 
 /* Asm macros */
 
-#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
+#define ACPI_FLUSH_CPU_CACHE()				\
+do {							\
+	if (!prot_guest_has(PR_GUEST_DISABLE_WBINVD))	\
+		wbinvd();				\
+} while (0)
 
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 06fcbca402cb..fd27cf651f0b 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -92,6 +92,7 @@ bool tdx_protected_guest_has(unsigned long flag)
 	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
 	case PR_GUEST_UNROLL_STRING_IO:
 	case PR_GUEST_SHARED_MAPPING_INIT:
+	case PR_GUEST_DISABLE_WBINVD:
 		return true;
 	}
 
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
index adfa62e2615e..0ec4dab86f67 100644
--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -18,6 +18,8 @@
 #define PR_GUEST_HOST_MEM_ENCRYPT		0x103
 /* Support for shared mapping initialization (after early init) */
 #define PR_GUEST_SHARED_MAPPING_INIT		0x104
+/* Support to disable WBINVD */
+#define PR_GUEST_DISABLE_WBINVD			0x105
 
 #if defined(CONFIG_INTEL_TDX_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
 
-- 
2.25.1

