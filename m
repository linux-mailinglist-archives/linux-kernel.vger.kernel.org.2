Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB9C3CED40
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357036AbhGSRuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:50:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:51676 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382651AbhGSRjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:39:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211167003"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="211167003"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:20:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="509462743"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:20:15 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 4/6] x86/sgx: Add SGX infrastructure to recover from poison
Date:   Mon, 19 Jul 2021 11:20:07 -0700
Message-Id: <20210719182009.1409895-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210719182009.1409895-1-tony.luck@intel.com>
References: <20210708181423.1312359-1-tony.luck@intel.com>
 <20210719182009.1409895-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a recovery function sgx_memory_failure(). If the poison was
consumed synchronously then send a SIGBUS. Note that the virtual
address of the access is not included with the SIGBUS as is the case
for poison outside of SGX enclaves. This doesn't matter as addresses
of code/data inside an enclave is of little to no use to code executing
outside the (now dead) enclave.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 57 ++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index db77f62d6ef1..430d3214d21e 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -711,6 +711,63 @@ bool sgx_is_epc_page(u64 paddr)
 }
 EXPORT_SYMBOL_GPL(sgx_is_epc_page);
 
+/*
+ * Called in process context to handle a hardware reported
+ * error in an SGX EPC page.
+ * If the MF_ACTION_REQUIRED bit is set in flags, then the
+ * context is the task that consumed the poison data. Otherwise
+ * this is called from a kernel thread unrelated to the page.
+ */
+int sgx_memory_failure(unsigned long pfn, int flags)
+{
+	struct sgx_epc_page *page = sgx_paddr_to_page(pfn << PAGE_SHIFT);
+
+	/*
+	 * mm/memory-failure.c calls this routine for all errors
+	 * where there isn't a "struct page" for the address. But that
+	 * includes other address ranges besides SGX.
+	 */
+	if (!page)
+		return -ENXIO;
+
+	/*
+	 * If poison was consumed synchronously. Send a SIGBUS to
+	 * the task. Hardware has already exited the SGX enclave and
+	 * will not allow re-entry to an enclave that has a memory
+	 * error. The signal may help the task understand why the
+	 * enclave is broken.
+	 */
+	if (flags & MF_ACTION_REQUIRED)
+		force_sig(SIGBUS);
+
+	/* Already poisoned? Nothing more to do */
+	if (page->flags & SGX_EPC_PAGE_POISON)
+		return 0;
+
+	page->flags |= SGX_EPC_PAGE_POISON;
+	poison_page_count++;
+
+	/*
+	 * Nothing more to do here for dirty/free pages.
+	 * They will be added to the poison list when
+	 * they get to the head of their lists.
+	 */
+	if (!page->owner)
+		return 0;
+
+	/*
+	 * TBD: Add additional plumbing to enable pre-emptive
+	 * action for asynchronous poison notification. Until
+	 * then just hope that the poison:
+	 * a) is not accessed - sgx_free_epc_page() will deal with it
+	 *    when the user gives it back
+	 * b) results in a recoverable machine check rather than
+	 *    a fatal one
+	 */
+
+	return 0;
+}
+
 /**
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
-- 
2.29.2

