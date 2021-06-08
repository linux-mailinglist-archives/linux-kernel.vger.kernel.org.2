Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C453A063A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhFHVmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:42:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:45443 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhFHVmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:42:42 -0400
IronPort-SDR: FRTauGGX/Xfaz1/mbIJJf7nPV8vp1mSg/lsHzSO0agh66fcpImY3LPgCgE+G4HiodUSzB1+PGq
 O9RGYhC+5uUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="226309338"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="226309338"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:40:48 -0700
IronPort-SDR: leT4Y8a8gI8Nv71g8CwoxhN1ApYrtQ/b0MbaB6VSPG5YDxZY7hyf/3dIjKsqyWT1BIdqrghlhk
 syl1eWKEniaQ==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="448057500"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:40:48 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 4/4] x86/sgx: Add hook to error injection address validation
Date:   Tue,  8 Jun 2021 14:40:38 -0700
Message-Id: <20210608214038.1026259-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210608214038.1026259-1-tony.luck@intel.com>
References: <20210608214038.1026259-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGX reserved memory does not appear in the standard address maps.

Add hook to call into the SGX code to check if an address is located
in SGX memory.

There are other challenges in injecting errors into SGX. Update the
documentation with a sequence of operations to inject.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 19 +++++++++++++++++++
 drivers/acpi/apei/einj.c                      |  3 ++-
 include/linux/mm.h                            |  6 ++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index c042176e1707..55e2331a6438 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -181,5 +181,24 @@ You should see something like this in dmesg::
   [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
   [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
+Special notes for injection into SGX enclaves:
+
+There may be a separate BIOS setup option to enable SGX injection.
+
+The injection process consists of setting some special memory controller
+trigger that will inject the error on the next write to the target
+address. But the h/w prevents any software outside of an SGX enclave
+from accessing enclave pages (even BIOS SMM mode).
+
+The following sequence can be used:
+  1) Determine physical address of enclave page
+  2) Use "notrigger=1" mode to inject (this will setup
+     the injection address, but will not actually inject)
+  3) Enter the enclave
+  4) Store data to the virtual address matching physical address from step 1
+  5) Execute CLFLUSH for that virtual address
+  6) Spin delay for 250ms
+  7) Read from the virtual address. This will trigger the error
+
 For more information about EINJ, please refer to ACPI specification
 version 4.0, section 17.5 and ACPI 5.0, section 18.6.
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 328e8aeece6c..fb634219e232 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -544,7 +544,8 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	    ((region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
 				!= REGION_INTERSECTS) &&
 	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
-				!= REGION_INTERSECTS)))
+				!= REGION_INTERSECTS) &&
+	     !sgx_is_epc_page(base_addr)))
 		return -EINVAL;
 
 inject:
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ad4c513d4cc..d90523418b6c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3250,11 +3250,17 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 
 #ifdef CONFIG_X86_SGX
 int sgx_memory_failure(unsigned long pfn, int flags);
+bool sgx_is_epc_page(u64 paddr);
 #else
 static inline int sgx_memory_failure(unsigned long pfn, int flags)
 {
 	return -ENXIO;
 }
+
+static inline bool sgx_is_epc_page(u64 paddr)
+{
+	return false;
+}
 #endif
 
 #endif /* __KERNEL__ */
-- 
2.29.2

