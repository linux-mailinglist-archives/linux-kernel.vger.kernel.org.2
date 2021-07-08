Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04753C190D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 20:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhGHSRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 14:17:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:2094 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhGHSRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:17:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="231327148"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="231327148"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 11:14:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="482637383"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 11:14:35 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     tony.luck@intel.com
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] x86/sgx: Hook sgx_memory_failure() into mainline code
Date:   Thu,  8 Jul 2021 11:14:22 -0700
Message-Id: <20210708181423.1312359-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210708181423.1312359-1-tony.luck@intel.com>
References: <20210708181423.1312359-1-tony.luck@intel.com>
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
index 8ae31622deef..1b9d0912942a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3251,5 +3251,14 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
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
index 6f5f78885ab4..02b1c58729c1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1453,6 +1453,10 @@ int memory_failure(unsigned long pfn, int flags)
 
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

