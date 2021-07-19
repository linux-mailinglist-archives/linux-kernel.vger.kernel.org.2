Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3438F3CED3E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353679AbhGSRub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:50:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:51676 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382646AbhGSRji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:39:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211167000"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="211167000"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:20:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="509462737"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:20:15 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 2/6] x86/sgx: Add infrastructure to identify SGX EPC pages
Date:   Mon, 19 Jul 2021 11:20:05 -0700
Message-Id: <20210719182009.1409895-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210719182009.1409895-1-tony.luck@intel.com>
References: <20210708181423.1312359-1-tony.luck@intel.com>
 <20210719182009.1409895-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X86 machine check architecture reports a physical address when there
is a memory error. Handling that error requires a method to determine
whether the physical address reported is in any of the areas reserved
for EPC pages by BIOS.

Add an end_phys_addr field to the sgx_epc_section structure and a
new function sgx_paddr_to_page() that searches all such structures
and returns the struct sgx_epc_page pointer if the address is an EPC
page. This function is only intended for use within SGX code.

Export a function sgx_is_epc_page() that simply reports whether an
address is an EPC page for use elsewhere in the kernel.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 24 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h  |  1 +
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d61bc1f635a1..41753f81a071 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -654,6 +654,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	}
 
 	section->phys_addr = phys_addr;
+	section->end_phys_addr = phys_addr + size - 1;
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
@@ -665,6 +666,29 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	return true;
 }
 
+static struct sgx_epc_page *sgx_paddr_to_page(u64 paddr)
+{
+	struct sgx_epc_section *section;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
+		section = &sgx_epc_sections[i];
+
+		if (paddr < section->phys_addr || paddr > section->end_phys_addr)
+			continue;
+
+		return &section->pages[PFN_DOWN(paddr - section->phys_addr)];
+	}
+
+	return NULL;
+}
+
+bool sgx_is_epc_page(u64 paddr)
+{
+	return !!sgx_paddr_to_page(paddr);
+}
+EXPORT_SYMBOL_GPL(sgx_is_epc_page);
+
 /**
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 4e1a410b8a62..226b081a4d05 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -50,6 +50,7 @@ struct sgx_numa_node {
  */
 struct sgx_epc_section {
 	unsigned long phys_addr;
+	unsigned long end_phys_addr;
 	void *virt_addr;
 	struct sgx_epc_page *pages;
 	struct sgx_numa_node *node;
-- 
2.29.2

