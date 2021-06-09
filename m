Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB6C3A1414
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhFIMTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:19:18 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:35757 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239743AbhFIMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:19:10 -0400
Received: by mail-pj1-f45.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso1298199pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5gMWEv9tC8/vo4nEZxaNdZR95vKmKnlaLF90wl0oFU=;
        b=fF+rSzdrOYcR9ijjFVFrOhei1ZRjgv4y5N87LenL7irAqVNjAsEvLUOZbVHDTOBl27
         5GyM0gAB28wmHolfQQszATK2NLf0pC1NXbWBfc4O2tHsS5xwlTnj4pVa5e2cyPTow1Mi
         t750zb5lZNj4wElyK/c4dZJ0KZ406xm1z0oCfs6yn7A3LcrvojwLivhUbr+RT2meDfV6
         WdPy+xrxr7qLkGmoP4Ry12kceUi99PdX8EZlpknB36edvksdwxJ8We63qW2Arq2eCeTl
         2yZDbJiOrJU1Y2s9z4oM2CaR63D8ZK8+lR0FmeG8mAvgtTEfLiXm13+vG3J8R5SNq7To
         ZSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5gMWEv9tC8/vo4nEZxaNdZR95vKmKnlaLF90wl0oFU=;
        b=CVtOkQE3Bhw334oZH4QYQi8lvF7e7rtNTfEq2Liw7bmjcjR4oNW1e/TjdqNl4uiQTz
         obmfeyZd4RJtKS7R9cALbs9vnDAcaZHyhCVQWu8QM8h37vrsi3JbSL4+CIIxkvunyNwn
         o7oRaD2cmCDVuqUpC9Ixe2iC5/enaMlDXGZcmpJpBC9x8tkhaFfauriM3PUUm2+HaMv5
         s6ya/hupFC9Km99WGp3jeRtv9dqx+HMu5FumVFyprfTZlTC5s/asvaIxFyN7YY2NC1QT
         6GTm9GBMGJov+3fDMkktHz2lLR+6/HkGStv4KMBQES9ybmVxC9zEpFfoMJ/L4o7PNi5G
         nUsg==
X-Gm-Message-State: AOAM531H6MId7k7dAs8+auFEaCb+uDa/p3soxBbSwEXbMaCcpb8ltaDi
        QvduKEmhYzh3bY1Wi1ADNr5dXA==
X-Google-Smtp-Source: ABdhPJzOgyiAQiBObGnuElieU/iq/wW8CUGGkfOtZNVadqwy30FNgVSA44A84vH2Tc9oftskRcB8zw==
X-Received: by 2002:a17:902:d305:b029:10d:c8a3:657f with SMTP id b5-20020a170902d305b029010dc8a3657fmr4756404plc.0.1623240976435;
        Wed, 09 Jun 2021 05:16:16 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h16sm13689224pfk.119.2021.06.09.05.16.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 05:16:16 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/5] mm: hugetlb: introduce helpers to preallocate page tables from bootmem allocator
Date:   Wed,  9 Jun 2021 20:13:07 +0800
Message-Id: <20210609121310.62229-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210609121310.62229-1-songmuchun@bytedance.com>
References: <20210609121310.62229-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we want to split the huge PMD of vmemmap pages associated with each
gigantic page allocated from bootmem allocator, we should pre-allocate
the page tables from bootmem allocator. In this patch, we introduce
some helpers to preallocate page tables for gigantic pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb_vmemmap.c    | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    | 13 ++++++++++
 3 files changed, 79 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 03ca83db0a3e..c27a299c4211 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -622,6 +622,9 @@ struct hstate {
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	pte_t *vmemmap_pte;
+#endif
 };
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 628e2752714f..6f3a47b4ebd3 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -171,6 +171,7 @@
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
 #include <linux/list.h>
+#include <linux/memblock.h>
 #include <asm/pgalloc.h>
 
 #include "hugetlb_vmemmap.h"
@@ -263,6 +264,68 @@ int vmemmap_pgtable_prealloc(struct hstate *h, struct list_head *pgtables)
 	return -ENOMEM;
 }
 
+unsigned long __init gigantic_vmemmap_pgtable_prealloc(void)
+{
+	struct huge_bootmem_page *m, *tmp;
+	unsigned long nr_free = 0;
+
+	list_for_each_entry_safe(m, tmp, &huge_boot_pages, list) {
+		struct hstate *h = m->hstate;
+		unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+		unsigned long size;
+
+		if (!nr)
+			continue;
+
+		size = nr << PAGE_SHIFT;
+		m->vmemmap_pte = memblock_alloc_try_nid(size, PAGE_SIZE, 0,
+							MEMBLOCK_ALLOC_ACCESSIBLE,
+							NUMA_NO_NODE);
+		if (!m->vmemmap_pte) {
+			nr_free++;
+			list_del(&m->list);
+			memblock_free_early(__pa(m), huge_page_size(h));
+		}
+	}
+
+	return nr_free;
+}
+
+void __init gigantic_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+					  struct page *head)
+{
+	struct hstate *h = m->hstate;
+	unsigned long pte = (unsigned long)m->vmemmap_pte;
+	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+
+	if (!nr)
+		return;
+
+	/*
+	 * If we had gigantic hugepages allocated at boot time, we need
+	 * to restore the 'stolen' pages to totalram_pages in order to
+	 * fix confusing memory reports from free(1) and another
+	 * side-effects, like CommitLimit going negative.
+	 */
+	adjust_managed_page_count(head, nr);
+
+	/*
+	 * Use the huge page lru list to temporarily store the preallocated
+	 * pages. The preallocated pages are used and the list is emptied
+	 * before the huge page is put into use. When the huge page is put
+	 * into use by prep_new_huge_page() the list will be reinitialized.
+	 */
+	INIT_LIST_HEAD(&head->lru);
+
+	while (nr--) {
+		struct page *pte_page = virt_to_page(pte);
+
+		__ClearPageReserved(pte_page);
+		list_add(&pte_page->lru, &head->lru);
+		pte += PAGE_SIZE;
+	}
+}
+
 /*
  * Previously discarded vmemmap pages will be allocated and remapping
  * after this function returns zero.
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 306e15519da1..f6170720f183 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -16,6 +16,9 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 void hugetlb_vmemmap_init(struct hstate *h);
 int vmemmap_pgtable_prealloc(struct hstate *h, struct list_head *pgtables);
 void vmemmap_pgtable_free(struct list_head *pgtables);
+unsigned long gigantic_vmemmap_pgtable_prealloc(void);
+void gigantic_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+				   struct page *head);
 
 /*
  * How many vmemmap pages associated with a HugeTLB page that can be freed
@@ -45,6 +48,16 @@ static inline void vmemmap_pgtable_free(struct list_head *pgtables)
 {
 }
 
+static inline unsigned long gigantic_vmemmap_pgtable_prealloc(void)
+{
+	return 0;
+}
+
+static inline void gigantic_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+						 struct page *head)
+{
+}
+
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
 }
-- 
2.11.0

