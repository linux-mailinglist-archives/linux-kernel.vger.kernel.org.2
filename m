Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A1E3FA027
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhH0T4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:56:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:26658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhH0T4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:56:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="218024427"
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="218024427"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:55:56 -0700
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="528422076"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:55:55 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 2/6] x86/sgx: Add infrastructure to identify SGX EPC pages
Date:   Fri, 27 Aug 2021 12:55:39 -0700
Message-Id: <20210827195543.1667168-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210827195543.1667168-1-tony.luck@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
 <20210827195543.1667168-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X86 machine check architecture reports a physical address when there
is a memory error. Handling that error requires a method to determine
whether the physical address reported is in any of the areas reserved
for EPC pages by BIOS.

SGX EPC pages do not have Linux "struct page" associated with them.

Keep track of the mapping from ranges of EPC pages to the sections
that contain them using an xarray.

Create a function sgx_is_epc_page() that simply reports whether an address
is an EPC page for use elsewhere in the kernel. The ACPI error injection
code needs this function and is typically built as a module, so export it.

Note that sgx_is_epc_page() will be slower than other similar "what type
is this page" functions that can simply check bits in the "struct page".
If there is some future performance critical user of this function it
may need to be implemented in a more efficient way.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 10 ++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h  |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4a5b51d16133..261f81b3f8af 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -20,6 +20,7 @@ struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
 static int sgx_nr_epc_sections;
 static struct task_struct *ksgxd_tsk;
 static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
+static DEFINE_XARRAY(epc_page_ranges);
 
 /*
  * These variables are part of the state of the reclaimer, and must be accessed
@@ -649,6 +650,9 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	}
 
 	section->phys_addr = phys_addr;
+	section->end_phys_addr = phys_addr + size - 1;
+	xa_store_range(&epc_page_ranges, section->phys_addr,
+		       section->end_phys_addr, section, GFP_KERNEL);
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
@@ -660,6 +664,12 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	return true;
 }
 
+bool sgx_is_epc_page(u64 paddr)
+{
+	return !!xa_load(&epc_page_ranges, paddr);
+}
+EXPORT_SYMBOL_GPL(sgx_is_epc_page);
+
 /**
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 8b1be10a46f6..6a55b1971956 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -54,6 +54,7 @@ struct sgx_numa_node {
  */
 struct sgx_epc_section {
 	unsigned long phys_addr;
+	unsigned long end_phys_addr;
 	void *virt_addr;
 	struct sgx_epc_page *pages;
 	struct sgx_numa_node *node;
-- 
2.29.2

