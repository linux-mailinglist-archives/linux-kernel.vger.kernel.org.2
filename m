Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14293FA02A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhH0T4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:56:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:26658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhH0T4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:56:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="218024432"
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="218024432"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:55:56 -0700
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="528422084"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:55:56 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 5/6] x86/sgx: Hook sgx_memory_failure() into mainline code
Date:   Fri, 27 Aug 2021 12:55:42 -0700
Message-Id: <20210827195543.1667168-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210827195543.1667168-1-tony.luck@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
 <20210827195543.1667168-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a call inside memory_failure() to check if the address is an SGX
EPC page and handle it.

Note the SGX EPC pages do not have a "struct page" entry, so the hook
goes in at the same point as the device mapping hook.

Pull the call to acquire the mutex earlier so the SGX errors are also
protected.

Make set_mce_nospec() skip SGX pages when trying to adjust
the 1:1 map.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/set_memory.h |  4 ++++
 include/linux/mm.h                | 15 +++++++++++++++
 mm/memory-failure.c               | 19 +++++++++++++------
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 43fa081a1adb..801af8f30c83 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_SET_MEMORY_H
 #define _ASM_X86_SET_MEMORY_H
 
+#include <linux/mm.h>
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
 
@@ -98,6 +99,9 @@ static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 	unsigned long decoy_addr;
 	int rc;
 
+	/* SGX pages are not in the 1:1 map */
+	if (sgx_is_epc_page(pfn << PAGE_SHIFT))
+		return 0;
 	/*
 	 * We would like to just call:
 	 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..2ff599bcf8c2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3283,5 +3283,20 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 	return 0;
 }
 
+#ifdef CONFIG_X86_SGX
+int sgx_memory_failure(unsigned long pfn, int flags);
+bool sgx_is_epc_page(u64 paddr);
+#else
+static inline int sgx_memory_failure(unsigned long pfn, int flags)
+{
+	return -ENXIO;
+}
+
+static inline bool sgx_is_epc_page(u64 paddr)
+{
+	return false;
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 470400cc7513..ce04debd18f6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1632,21 +1632,28 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
 
+	mutex_lock(&mf_mutex);
+
 	p = pfn_to_online_page(pfn);
 	if (!p) {
+		res = sgx_memory_failure(pfn, flags);
+		if (res == 0)
+			goto unlock_mutex;
+
 		if (pfn_valid(pfn)) {
 			pgmap = get_dev_pagemap(pfn, NULL);
-			if (pgmap)
-				return memory_failure_dev_pagemap(pfn, flags,
-								  pgmap);
+			if (pgmap) {
+				res = memory_failure_dev_pagemap(pfn, flags,
+								 pgmap);
+				goto unlock_mutex;
+			}
 		}
 		pr_err("Memory failure: %#lx: memory outside kernel control\n",
 			pfn);
-		return -ENXIO;
+		res = -ENXIO;
+		goto unlock_mutex;
 	}
 
-	mutex_lock(&mf_mutex);
-
 try_again:
 	if (PageHuge(p)) {
 		res = memory_failure_hugetlb(pfn, flags);
-- 
2.29.2

