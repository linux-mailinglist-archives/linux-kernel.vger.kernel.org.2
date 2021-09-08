Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59E403DAA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349897AbhIHQho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349857AbhIHQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631118990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56oQXq3TKm+twCnaNWrYfutLR31xlw31ilsGJKLLAyo=;
        b=WCMCNcQYcXREfG38FvwMhADFuz63rk4tj7ziTmPdxDz1YJmaDbXvUjhXhcW5guqE//2Ne5
        Q1VzYNPQFCDcPkHFBQmyWCOsTayn2vaqc1VzBgUISg+ccbQ+4X9gKqdnrHbftzAEtCV6/C
        zUDH2zdsVCvvZgwFhAbF0McnE1494K8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-xSI-YI2cNNKGwLVFm6XCCw-1; Wed, 08 Sep 2021 12:36:29 -0400
X-MC-Unique: xSI-YI2cNNKGwLVFm6XCCw-1
Received: by mail-io1-f70.google.com with SMTP id a9-20020a5ec309000000b005baa3f77016so2395568iok.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56oQXq3TKm+twCnaNWrYfutLR31xlw31ilsGJKLLAyo=;
        b=b464zZpF+WshwXAn1Er6ASvB1H33ji99DiF3UHHm/LBpq2EeDTbDg9c5vy8mY9FcwV
         tGQPpdG91Yo5FGTGH3ecr9OzDb4e4leyDFq6ek+chRJHE+rtrX+VrsuPY4xtlF4+ulp9
         JhOkdbM5PfhJc2wA7i7xKwEu1Mr7l3PAXJZwQ1c5BAGqTx0rBlPl8hGX9uZFDaN595As
         OWy9IarMuPm6MiGY2odJwe79Lkcv6qt4A52d6N89LUZecYiolMOcCTnTSlwb6Pi2wd8/
         2biRax15ynBJHI7tKlq3h4eLGFZvrOKua+/DrvP6VmCqdHVAl/gjenSgAasAMN7WIACe
         vvMg==
X-Gm-Message-State: AOAM531Fhucw+1WyFWFS8Pa0MNuhUTYAo3xIHI38FyBS8cUj+YFF7pMN
        ySE1rITpglbTJywSI7Myl/chcKw8Ky4qt0nZ0Ps5kjJKJVUqtUZ2mUkjNiEc7xaZ25ZJlI7VwiE
        OlfEBJ6jnjIaQuRQvmOfdHZJXqJhBuUFyKY8M6vyiG9v7hal6VAtftfRQshe1he0BqWte14fDow
        ==
X-Received: by 2002:a02:ca0b:: with SMTP id i11mr4618056jak.84.1631118988033;
        Wed, 08 Sep 2021 09:36:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrX//krJNo8s8HBTqOX6r+b8T4NK3eiRYEGoQxukDEVUburkR0mXbCkaE95ZsNYN1utMzy5A==
X-Received: by 2002:a02:ca0b:: with SMTP id i11mr4618027jak.84.1631118987784;
        Wed, 08 Sep 2021 09:36:27 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id m10sm1399415ilg.20.2021.09.08.09.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:36:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>, peterx@redhat.com,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v3 4/5] mm: Add zap_skip_check_mapping() helper
Date:   Wed,  8 Sep 2021 12:36:25 -0400
Message-Id: <20210908163625.215001-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908163516.214441-1-peterx@redhat.com>
References: <20210908163516.214441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper for the checks.  Rename "check_mapping" into "zap_mapping"
because "check_mapping" looks like a bool but in fact it stores the mapping
itself.  When it's set, we check the mapping (it must be non-NULL).  When it's
cleared we skip the check, which works like the old way.

Move the duplicated comments to the helper too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 16 +++++++++++++++-
 mm/memory.c        | 29 ++++++-----------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d1126f731221..ed44f31615d9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1721,10 +1721,24 @@ extern void user_shm_unlock(size_t, struct ucounts *);
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
-	struct address_space *check_mapping;	/* Check page->mapping if set */
+	struct address_space *zap_mapping;	/* Check page->mapping if set */
 	struct page *single_page;		/* Locked page to be unmapped */
 };
 
+/*
+ * We set details->zap_mappings when we want to unmap shared but keep private
+ * pages. Return true if skip zapping this page, false otherwise.
+ */
+static inline bool
+zap_skip_check_mapping(struct zap_details *details, struct page *page)
+{
+	if (!details || !page)
+		return false;
+
+	return details->zap_mapping &&
+	    (details->zap_mapping != page_rmapping(page));
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 6bba3b9fef7c..e5ee8399d270 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1333,16 +1333,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			struct page *page;
 
 			page = vm_normal_page(vma, addr, ptent);
-			if (unlikely(details) && page) {
-				/*
-				 * unmap_shared_mapping_pages() wants to
-				 * invalidate cache without truncating:
-				 * unmap shared but keep private pages.
-				 */
-				if (details->check_mapping &&
-				    details->check_mapping != page_rmapping(page))
-					continue;
-			}
+			if (unlikely(zap_skip_check_mapping(details, page)))
+				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
@@ -1375,17 +1367,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		    is_device_exclusive_entry(entry)) {
 			struct page *page = pfn_swap_entry_to_page(entry);
 
-			if (unlikely(details && details->check_mapping)) {
-				/*
-				 * unmap_shared_mapping_pages() wants to
-				 * invalidate cache without truncating:
-				 * unmap shared but keep private pages.
-				 */
-				if (details->check_mapping !=
-				    page_rmapping(page))
-					continue;
-			}
-
+			if (unlikely(zap_skip_check_mapping(details, page)))
+				continue;
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
 
@@ -3368,7 +3351,7 @@ void unmap_mapping_page(struct page *page)
 	first_index = page->index;
 	last_index = page->index + thp_nr_pages(page) - 1;
 
-	details.check_mapping = mapping;
+	details.zap_mapping = mapping;
 	details.single_page = page;
 
 	i_mmap_lock_write(mapping);
@@ -3396,7 +3379,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 	pgoff_t	first_index = start, last_index = start + nr - 1;
 	struct zap_details details = { };
 
-	details.check_mapping = even_cows ? NULL : mapping;
+	details.zap_mapping = even_cows ? NULL : mapping;
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
-- 
2.31.1

