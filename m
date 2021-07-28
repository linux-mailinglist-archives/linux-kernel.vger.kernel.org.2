Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62A43D96FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhG1UrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:47:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:60186 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231392AbhG1UrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:47:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="234634462"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="234634462"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 13:47:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="506679880"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 13:47:01 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 4/7] x86/sgx: Add SGX infrastructure to recover from poison
Date:   Wed, 28 Jul 2021 13:46:50 -0700
Message-Id: <20210728204653.1509010-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210728204653.1509010-1-tony.luck@intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
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
index 354f0abec12d..7d281dba707a 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -706,6 +706,63 @@ bool sgx_is_epc_page(u64 paddr)
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

