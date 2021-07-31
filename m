Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA5A3DC414
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 08:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbhGaGjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 02:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbhGaGjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 02:39:51 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D85C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:39:45 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h5-20020a05620a0525b02903b861bec838so7066154qkh.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s0577KTBq5IlED9+d/p0HQ6fImhPZLxAV9d3Y4Mj78k=;
        b=JsVUi6Cshol7JqaiPbmWtb0jBltGUAsUiTVIAkPq4qgVoGDn1xiRYAtE4oBXOagapF
         /0GxHhToMBmydIM3KD3k7c2uP+4o8emDxZOiGctKHjaottgLMDVySrweoSc/w+nr7uUb
         RZGTrHqPjGUr+Wyc47IXMWwYVUgfr4F69xtVPMvjM9GI00Ksg6l28Er/PadABeWKSskr
         oo7hmuWX0afR/0Ic0x/VZllAoefoKxJ49eQd57XhVnaH5+hEiy64x3vMLwGO9GzRDzcz
         DYMrZQ255iWt6d5paa3o12LiMShT2eVbhTy5LZGP2Bh37a+PdOtLonW2cLC2rP9USxdO
         9w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s0577KTBq5IlED9+d/p0HQ6fImhPZLxAV9d3Y4Mj78k=;
        b=mYUGdBFSrmgMw+qJLW4qsQ4Y1fVDkwy3fmSfOZmDlHKpd05qVuDtPqoy23xjJQqGPd
         gW9CpFYpbd+Y36mjrd/wxLHRgQq/LQ4OBVVYUtvmwwH379mojhdR6YJAUQjeZbo9RT85
         2XBxmcnzQiMmmow234kd2tB5fQV8R3xg4f8vknofS0YqBIrmfoJvj8K21r33RAg/b/u2
         ldFr4vQexVe8vjGQMG+XUT5FBN1/jeiMoJ34jOTQlTdsmIsPnIMpEB7iS+n21LCrN//X
         d33NTKEcmCiXMFg/vRa5c1adggBk0fIoj2aQSKVB676p71mIS9P6aAXq2xJDY+IoSD71
         wZ5Q==
X-Gm-Message-State: AOAM532uK42vekl0/GlRWhlL369cEvSbGc5lyYSA19uMh34v9L1W9emv
        uAFMFClIfozcCTaraQXugln2Kc4Nk3s=
X-Google-Smtp-Source: ABdhPJwZP7YlPH3vs70t1yZZQWOCe9C003giGh5MAHM1tgng90zlEpAZNper6xgPE76HUjXVP2xdOMN7L1M=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:2b92:c131:b08a:84c7])
 (user=yuzhao job=sendgmr) by 2002:a05:6214:146c:: with SMTP id
 c12mr6778672qvy.44.1627713584655; Fri, 30 Jul 2021 23:39:44 -0700 (PDT)
Date:   Sat, 31 Jul 2021 00:39:37 -0600
In-Reply-To: <20210731063938.1391602-1-yuzhao@google.com>
Message-Id: <20210731063938.1391602-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH 2/3] mm: free zapped tail pages when splitting isolated thp
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Shuang Zhai <zhais@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a tail page has only two references left, one inherited from the
isolation of its head and the other from lru_add_page_tail() which we
are about to drop, it means this tail page was concurrently zapped.
Then we can safely free it and save page reclaim or migration the
trouble of trying it.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Shuang Zhai <zhais@google.com>
---
 include/linux/vm_event_item.h |  1 +
 mm/huge_memory.c              | 28 ++++++++++++++++++++++++++++
 mm/vmstat.c                   |  1 +
 3 files changed, 30 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index ae0dd1948c2b..829eeac84094 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -99,6 +99,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 		THP_SPLIT_PUD,
 #endif
+		THP_SPLIT_FREE,
 		THP_ZERO_PAGE_ALLOC,
 		THP_ZERO_PAGE_ALLOC_FAILED,
 		THP_SWPOUT,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d8b655856e79..5120478bca41 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2432,6 +2432,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
 	unsigned int nr = thp_nr_pages(head);
+	LIST_HEAD(pages_to_free);
+	int nr_pages_to_free = 0;
 	int i;
 
 	VM_BUG_ON_PAGE(list && PageLRU(head), head);
@@ -2506,6 +2508,25 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 			continue;
 		unlock_page(subpage);
 
+		/*
+		 * If a tail page has only two references left, one inherited
+		 * from the isolation of its head and the other from
+		 * lru_add_page_tail() which we are about to drop, it means this
+		 * tail page was concurrently zapped. Then we can safely free it
+		 * and save page reclaim or migration the trouble of trying it.
+		 */
+		if (list && page_ref_freeze(subpage, 2)) {
+			VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
+			VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
+			VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
+
+			ClearPageActive(subpage);
+			ClearPageUnevictable(subpage);
+			list_move(&subpage->lru, &pages_to_free);
+			nr_pages_to_free++;
+			continue;
+		}
+
 		/*
 		 * Subpages may be freed if there wasn't any mapping
 		 * like if add_to_swap() is running on a lru page that
@@ -2515,6 +2536,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		 */
 		put_page(subpage);
 	}
+
+	if (!nr_pages_to_free)
+		return;
+
+	mem_cgroup_uncharge_list(&pages_to_free);
+	free_unref_page_list(&pages_to_free);
+	count_vm_events(THP_SPLIT_FREE, nr_pages_to_free);
 }
 
 int total_mapcount(struct page *page)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b0534e068166..f486e5d98d96 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1300,6 +1300,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 	"thp_split_pud",
 #endif
+	"thp_split_free",
 	"thp_zero_page_alloc",
 	"thp_zero_page_alloc_failed",
 	"thp_swpout",
-- 
2.32.0.554.ge1b32706d8-goog

