Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8393FF4C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhIBUTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231559AbhIBUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630613903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qa2t+mRnex8UWtPa+3EibP8DEZqC9c+ivTe+/7D5DBg=;
        b=fWUhd+H0bo5jjAacZwjAv4vDCaDx+oVPtULr9TyvtCz9nPdXJI21N0QgSP8nhdWjygsprB
        jW75MFdkj7c0psxlRzexiYpmWCmspW3m+uL2VQaJWFW8WLNh/yb6IZK6G4t1i4s4g3KW5l
        RUb5/GHQllQYThpgegT0z9V+osgObUE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-CPBeZTh7Opu31KAEmbSXVg-1; Thu, 02 Sep 2021 16:18:22 -0400
X-MC-Unique: CPBeZTh7Opu31KAEmbSXVg-1
Received: by mail-qt1-f199.google.com with SMTP id t2-20020ac87382000000b002a0c1c918c3so2349403qtp.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qa2t+mRnex8UWtPa+3EibP8DEZqC9c+ivTe+/7D5DBg=;
        b=BvfRpYu9LFNOGrHQNXYWsfP3FBas97kuOHfIVTU5MQ6xbzb+4c9P7sY7UNT0bIoXml
         lehubhzcIb3VLrHv1tT9acDxrmNDd8grFQatcJRPFwqompAe8IxRB4oaGtSrK2HGvuky
         vraQS2RJ+ho26G/CIox7sckthRADYiHRQzUnTElL6TDjB/aPfcEwoLan2wQpZzp6uXaM
         AuRSv0OGrAl676UIWH4qkLGlKu3wH7vUz7xPEZR6QvpYnKdTLttvdZDDGSmBkbH7Scjs
         vcIayssnqPZRkLeNLfiVEqjTXqiCxnE0zh26akVZKzUn4Jj/G5PCTM7o1Q7syfK3R6Vw
         Ycsw==
X-Gm-Message-State: AOAM533gCBW1jgGy+bSDyivCaeeldNqNVhrmSbmLS8Wl18t30UIjiYJ4
        e6zHx0IlXpUSsyRJKJ/i3NVvgxD0KT8B8yFWywS6nERBCmwFXWGCdjdmY51qvo07Mm/sAh+v877
        zEysu7Bij3ghYFHn1rOa3heBN
X-Received: by 2002:a05:620a:9dc:: with SMTP id y28mr4818026qky.456.1630613901840;
        Thu, 02 Sep 2021 13:18:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxSSUlX72Wtt37bFhaHAG9fsAucLiqInaoLBA2qPxUGl8ambA+3CiEsyV5pXsHgu6akQvj9g==
X-Received: by 2002:a05:620a:9dc:: with SMTP id y28mr4818012qky.456.1630613901634;
        Thu, 02 Sep 2021 13:18:21 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id x29sm1677629qtv.74.2021.09.02.13.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:18:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 4/5] mm: Add zap_skip_check_mapping() helper
Date:   Thu,  2 Sep 2021 16:18:19 -0400
Message-Id: <20210902201819.53343-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210902201721.52796-1-peterx@redhat.com>
References: <20210902201721.52796-1-peterx@redhat.com>
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
 include/linux/mm.h | 15 ++++++++++++++-
 mm/memory.c        | 29 ++++++-----------------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 69259229f090..81e402a5fbc9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1720,10 +1720,23 @@ extern void user_shm_unlock(size_t, struct ucounts *);
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
+	return details->zap_mapping != page_rmapping(page);
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

