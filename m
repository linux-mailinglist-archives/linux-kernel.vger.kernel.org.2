Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC8F373330
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhEEAdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:33:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:19823 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231515AbhEEAd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:33:26 -0400
IronPort-SDR: kUlkCz4bp08CkcdjSK1yp5gyGiWWsF0ia/aeIQRO48ECJK6f+dT64wdvrJuoK8pG0ciSPkmLgw
 JNbVd7mFiqIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="196058600"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="196058600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:30 -0700
IronPort-SDR: Sf+CtbfZdKtb+zNFY2nfkwYozuxaRBjEJydeFa6PYwqzirf3nIfEyhVZCqj7kiI2s4qnKfYwFX
 SbTMvYIpQM4Q==
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="429490816"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.26.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:29 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Cc:     ira.weiny@intel.com, rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 7/9] x86/mm/cpa: Add perm callbacks to grouped pages
Date:   Tue,  4 May 2021 17:30:30 -0700
Message-Id: <20210505003032.489164-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future patches will need to set permissions on pages in the cache, so
add some callbacks that let gouped page cache callers provide a callback
the component can call when replenishing the cache or free-ing pages via
the shrinker.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/set_memory.h |  8 +++++++-
 arch/x86/mm/pat/set_memory.c      | 26 +++++++++++++++++++++++---
 arch/x86/mm/pgtable.c             |  3 ++-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index a2bab1626fdd..b370a20681db 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -139,14 +139,20 @@ static inline int clear_mce_nospec(unsigned long pfn)
  */
 #endif
 
+typedef int (*gpc_callback)(struct page*, unsigned int);
+
 struct grouped_page_cache {
 	struct shrinker shrinker;
 	struct list_lru lru;
 	gfp_t gfp;
+	gpc_callback pre_add_to_cache;
+	gpc_callback pre_shrink_free;
 	atomic_t nid_round_robin;
 };
 
-int init_grouped_page_cache(struct grouped_page_cache *gpc, gfp_t gfp);
+int init_grouped_page_cache(struct grouped_page_cache *gpc, gfp_t gfp,
+			    gpc_callback pre_add_to_cache,
+			    gpc_callback pre_shrink_free);
 struct page *get_grouped_page(int node, struct grouped_page_cache *gpc);
 void free_grouped_page(struct grouped_page_cache *gpc, struct page *page);
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 29e61afb4a94..6387499c855d 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2356,6 +2356,9 @@ static void __dispose_pages(struct grouped_page_cache *gpc, struct list_head *he
 
 		list_del(cur);
 
+		if (gpc->pre_shrink_free)
+			gpc->pre_shrink_free(page, 1);
+
 		__free_pages(page, 0);
 	}
 }
@@ -2413,18 +2416,33 @@ static struct page *__replenish_grouped_pages(struct grouped_page_cache *gpc, in
 	int i;
 
 	page = __alloc_page_order(node, gpc->gfp, HUGETLB_PAGE_ORDER);
-	if (!page)
-		return __alloc_page_order(node, gpc->gfp, 0);
+	if (!page) {
+		page = __alloc_page_order(node, gpc->gfp, 0);
+		if (gpc->pre_add_to_cache)
+			gpc->pre_add_to_cache(page, 1);
+		return page;
+	}
 
 	split_page(page, HUGETLB_PAGE_ORDER);
 
+	/* If fail to prepare to be added, try to clean up and free */
+	if (gpc->pre_add_to_cache && gpc->pre_add_to_cache(page, hpage_cnt)) {
+		if (gpc->pre_shrink_free)
+			gpc->pre_shrink_free(page, hpage_cnt);
+		for (i = 0; i < hpage_cnt; i++)
+			__free_pages(&page[i], 0);
+		return NULL;
+	}
+
 	for (i = 1; i < hpage_cnt; i++)
 		free_grouped_page(gpc, &page[i]);
 
 	return &page[0];
 }
 
-int init_grouped_page_cache(struct grouped_page_cache *gpc, gfp_t gfp)
+int init_grouped_page_cache(struct grouped_page_cache *gpc, gfp_t gfp,
+			    gpc_callback pre_add_to_cache,
+			    gpc_callback pre_shrink_free)
 {
 	int err = 0;
 
@@ -2442,6 +2460,8 @@ int init_grouped_page_cache(struct grouped_page_cache *gpc, gfp_t gfp)
 	if (err)
 		list_lru_destroy(&gpc->lru);
 
+	gpc->pre_add_to_cache = pre_add_to_cache;
+	gpc->pre_shrink_free = pre_shrink_free;
 out:
 	return err;
 }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7ccd031d2384..bcef1f458b75 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -926,7 +926,8 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 #ifdef CONFIG_PKS_PG_TABLES
 static int __init pks_page_init(void)
 {
-	pks_page_en = !init_grouped_page_cache(&gpc_pks, GFP_KERNEL | PGTABLE_HIGHMEM);
+	pks_page_en = !init_grouped_page_cache(&gpc_pks, GFP_KERNEL | PGTABLE_HIGHMEM,
+					       NULL, NULL);
 
 out:
 	return !pks_page_en;
-- 
2.30.2

