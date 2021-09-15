Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0606640CC6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhIOSRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 14:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231231AbhIOSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631729742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoZpGeMMIEvvXfo6qC7dlVaUPLxDIKE3MfxvS4uRdds=;
        b=FrQ+pv5j1Cd7qRSkLARGpBWb0SJC18QKyhq0bYL2GHZTCcLFcjdMvEa0ie/HSsNVZMelbK
        mZCphxZ+dZ5BjWH5gqTa9EVs0oNHmTF7lQDTmxpTh9BVm1AfTVTkRcwMFxf1r6PtgDwTHp
        nIOFLtkfKjkgtWugvPik+hPC34sCqjA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-tNCUMMdcPLyN5nL1dgwY6w-1; Wed, 15 Sep 2021 14:15:41 -0400
X-MC-Unique: tNCUMMdcPLyN5nL1dgwY6w-1
Received: by mail-qk1-f200.google.com with SMTP id g73-20020a379d4c000000b003d3ed03ca28so6004290qke.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoZpGeMMIEvvXfo6qC7dlVaUPLxDIKE3MfxvS4uRdds=;
        b=gToK3/LxCov4CCsARd7jQO6P+mn5Jnz5al0bwI2tkhqLWr6O3NmY6f6B1M3+VUVZXO
         9FtDJGepkwubpwW3LN9NMQn6p/5Q+lLuPyUWE/oD06CSVCssTf+cz5IEQT13Kh4oI7et
         Sg7koiLsB0ou5vEW1JuGvy39Ml5aNuPJTZqXfcc6HF9wWmzouZiDwtOxbE3LYE2Xe8HV
         +ca0jHidqBharpvvDjZstiEtrwurf31K6vKJWplymQq40Cpu1h8n/DSLKeQjY0odmsRj
         nVXxVWKSMOuzonuuZN5D2uDI5IMydHeW1Mq+/4WaKxoX52GCuPVBZEJq2YOh4Ryi8gzA
         I/Gw==
X-Gm-Message-State: AOAM531RlEPWlvKN36HK1OVT+w5gUTQ0lCw3TgLPs09ppYpDKsdBOTzk
        PZcctOq8g8JlAJp4cGkOBMq4m1d9whwJRKH7b6F+mwS5dm1CU8ZJGhsVb4w7/PMW4qf4Klb7enG
        hSH8k4BNXi5Pjiwnbl13m69EM+aGjHCkjWj40/THpIl5wLOnlWcFbhZVRIgjKve2n7qU4cJG2vw
        ==
X-Received: by 2002:a0c:dd87:: with SMTP id v7mr1295515qvk.45.1631729740399;
        Wed, 15 Sep 2021 11:15:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6Lyt46ecPogmobxQZSQVhoZPuKmRpDao/8QgvngGXdt4WSs2hAmQxzkWJfSwJwCmhKbjYdA==
X-Received: by 2002:a0c:dd87:: with SMTP id v7mr1295473qvk.45.1631729740083;
        Wed, 15 Sep 2021 11:15:40 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id 13sm534908qka.56.2021.09.15.11.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:15:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v4 4/4] mm: Add zap_skip_check_mapping() helper
Date:   Wed, 15 Sep 2021 14:15:38 -0400
Message-Id: <20210915181538.11288-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915181456.10739-1-peterx@redhat.com>
References: <20210915181456.10739-1-peterx@redhat.com>
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

Reviewed-by: Alistair Popple <apopple@nvidia.com>
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
index a7e427177817..8db8ce0ca6ce 100644
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
 
@@ -3369,7 +3352,7 @@ void unmap_mapping_page(struct page *page)
 	first_index = page->index;
 	last_index = page->index + thp_nr_pages(page) - 1;
 
-	details.check_mapping = mapping;
+	details.zap_mapping = mapping;
 	details.single_page = page;
 
 	i_mmap_lock_write(mapping);
@@ -3398,7 +3381,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 	pgoff_t	first_index = start;
 	pgoff_t	last_index = start + nr - 1;
 
-	details.check_mapping = even_cows ? NULL : mapping;
+	details.zap_mapping = even_cows ? NULL : mapping;
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
-- 
2.31.1

