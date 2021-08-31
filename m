Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E03FBFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhHaABh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:01:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:50155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239206AbhHaAA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:00:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218381528"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218381528"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530712916"
Received: from ajinkyak-mobl2.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.240.95])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:03 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 10/19] x86/mm: Use alloc_table() for fill_pte(), etc
Date:   Mon, 30 Aug 2021 16:59:18 -0700
Message-Id: <20210830235927.6443-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fill_pte(), set_pte_vaddr(), etc allocate page tables with
spp_getpage(). Use alloc_table() for these allocations in order to get
tables from the cache of protected pages when needed.

Opportunistically, fix a stale comment.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/mm/init_64.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3c0323ad99da..de5a785ee89f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -220,16 +220,19 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 
 /*
  * NOTE: This function is marked __ref because it calls __init function
- * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
+ * (memblock_alloc). It's safe to do it ONLY when after_bootmem == 0.
  */
 static __ref void *spp_getpage(void)
 {
 	void *ptr;
 
-	if (after_bootmem)
-		ptr = (void *) get_zeroed_page(GFP_ATOMIC);
-	else
+	if (after_bootmem) {
+		struct page *page = alloc_table(GFP_ATOMIC | __GFP_ZERO);
+
+		ptr = page ? page_address(page) : NULL;
+	} else {
 		ptr = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+	}
 
 	if (!ptr || ((unsigned long)ptr & ~PAGE_MASK)) {
 		panic("set_pte_phys: cannot allocate page data %s\n",
-- 
2.17.1

