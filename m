Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CED3CED41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357262AbhGSRvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:51:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:51680 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382657AbhGSRjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:39:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211167007"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="211167007"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:20:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="509462750"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:20:15 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 6/6] x86/sgx: Add hook to error injection address validation
Date:   Mon, 19 Jul 2021 11:20:09 -0700
Message-Id: <20210719182009.1409895-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210719182009.1409895-1-tony.luck@intel.com>
References: <20210708181423.1312359-1-tony.luck@intel.com>
 <20210719182009.1409895-1-tony.luck@intel.com>
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
 2 files changed, 21 insertions(+), 1 deletion(-)

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
index 2882450c443e..cd7cffc955bf 100644
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
-- 
2.29.2

