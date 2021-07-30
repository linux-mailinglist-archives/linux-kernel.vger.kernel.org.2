Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2903DBE79
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 20:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhG3SoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 14:44:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:32176 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhG3SoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 14:44:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="235063394"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="235063394"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 11:44:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="508322533"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 11:44:01 -0700
Date:   Fri, 30 Jul 2021 11:44:00 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Message-ID: <20210730184400.GA1521057@agluck-desk2.amr.corp.intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-3-tony.luck@intel.com>
 <141602a3-ef61-01f0-4a3c-69f8e7012fcd@intel.com>
 <20210730003809.hp3nmqmgyysa45nz@kernel.org>
 <YQQsz/tvrQpqAbpX@google.com>
 <b7b6aabd-1f10-1b21-eaeb-102ead2989cd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7b6aabd-1f10-1b21-eaeb-102ead2989cd@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 09:50:59AM -0700, Dave Hansen wrote:
> On 7/30/21 9:46 AM, Sean Christopherson wrote:
> > Out of curiosity, on multi-socket systems, are EPC sections clustered in a single
> > address range, or are they interleaved with regular RAM?  If they're clustered,
> > you could track the min/max across all sections to optimize the common case that
> > an address isn't in any EPC section.
> 
> They're interleaved on the systems that I've seen:
> 
> 	Socket 0 - RAM
> 	Socket 0 - EPC
> 	Socket 1 - RAM
> 	Socket 1 - EPC
> 
> It would probably be pretty expensive in terms of the physical address
> remapping resources to cluster them.

I thought xarray was overkill ... and it is ... but it makes the code
considerably shorter/simpler!

I think I'm going to go with it. Thanks to Jarkko for the suggestion.

Also added comments based on Dave's feedback on why the function is
exported, and that sgx_is_epc_page() will be slower than people might
expect.

-Tony

From 7026de93f5bf370be9d067cdc068a4a2a54bbd3e Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Fri, 30 Jul 2021 11:39:45 -0700
Subject: [PATCH] x86/sgx: Add infrastructure to identify SGX EPC pages

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
 arch/x86/kernel/cpu/sgx/main.c | 21 +++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h  |  1 +
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 3d19bba3fa7e..d65787391b22 100644
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
@@ -660,6 +664,23 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	return true;
 }
 
+static struct sgx_epc_page *sgx_paddr_to_page(u64 paddr)
+{
+	struct sgx_epc_section *section;
+
+	section = xa_load(&epc_page_ranges, paddr);
+	if (!section)
+		return NULL;
+
+	return &section->pages[PFN_DOWN(paddr - section->phys_addr)];
+}
+
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

