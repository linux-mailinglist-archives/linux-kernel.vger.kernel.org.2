Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B223A063E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhFHVmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:42:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:45443 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234370AbhFHVmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:42:43 -0400
IronPort-SDR: TtTxie9xQisHr/y7pCF0y7ZXqsREK3uSlHCNe77ZyUBv4ArBC7zUmPCDX3G0oUyL/YAOfkM7cC
 iB3eiiY9YPWA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="226309336"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="226309336"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:40:48 -0700
IronPort-SDR: rX10nWWudcUkwV+N31oSqMdZNruLG1K3urV94+n+wfV/INYwAL7+sqDgCQWmRniNq/C2gnI1xI
 LNpaIX+ozAjw==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="448057497"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:40:48 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 3/4] x86/sgx: Hook sgx_memory_failure() into mainline code
Date:   Tue,  8 Jun 2021 14:40:37 -0700
Message-Id: <20210608214038.1026259-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210608214038.1026259-1-tony.luck@intel.com>
References: <20210608214038.1026259-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a call inside memory_failure() to check if the address is an SGX
EPC page and handle it.

Note the SGX EPC pages do not have a "struct page" entry, so the hook
goes in at the same point as the device mapping hook.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/mm.h  | 9 +++++++++
 mm/memory-failure.c | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c274f75efcf9..8ad4c513d4cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3248,5 +3248,14 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 	return 0;
 }
 
+#ifdef CONFIG_X86_SGX
+int sgx_memory_failure(unsigned long pfn, int flags);
+#else
+static inline int sgx_memory_failure(unsigned long pfn, int flags)
+{
+	return -ENXIO;
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 85ad98c00fd9..c2ade18fd8d5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1413,6 +1413,10 @@ int memory_failure(unsigned long pfn, int flags)
 
 	p = pfn_to_online_page(pfn);
 	if (!p) {
+		res = sgx_memory_failure(pfn, flags);
+		if (res == 0)
+			return 0;
+
 		if (pfn_valid(pfn)) {
 			pgmap = get_dev_pagemap(pfn, NULL);
 			if (pgmap)
-- 
2.29.2

