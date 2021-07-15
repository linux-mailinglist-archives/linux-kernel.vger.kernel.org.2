Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE93CADAD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbhGOUSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241125AbhGOURh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGgwjvpJa6wLNwtGExzq+9oKBigK+KwEv4SzKA2ZKkU=;
        b=ar/5nh/JH6uC36fsdGWAlqDv6KEhVYnhQv+rQHao0DU7uYjneSOicbQp/2InJRDLo4nBJr
        uftvNXQGpcnM+mPB4ageBPNqBcr+685KIic6KjdD4pYHyj/O3lyU6RXD5eFK0lJ4+DRncx
        tECEeuHGDOtLPenoxVFZGUHi4ygxPpk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-gBJ1xbFrM1iQ-P_DQVki4Q-1; Thu, 15 Jul 2021 16:14:42 -0400
X-MC-Unique: gBJ1xbFrM1iQ-P_DQVki4Q-1
Received: by mail-qv1-f70.google.com with SMTP id t15-20020a056214036fb02902dc72b5283dso4979550qvu.23
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGgwjvpJa6wLNwtGExzq+9oKBigK+KwEv4SzKA2ZKkU=;
        b=ZxoSpxLKGigUmen3goroYRTEiQ3cTGZB9dhRavjs9rDaVuEby2aC65v/46eSOf9nY0
         TCKLcQlZGcJ792BqWYlElz4WgXzjYDeDKAsklep8UnI6JOuYWiZpNdH1yqkr8HvQaSn1
         1frkVU1WmuME+GYvQnfhKuSZO5DobNOQwI3m5KK7xWz6ev+vqfj7fGshAX1qvga3Z+hw
         Khy0kEi2m/i8dCGKCbR7TGM3H2Z9q8iNFEcI8m5GA63yxxk3De8o65fTeIo9Hat1KsLh
         RjrMkNrQMd3UBV6bG/4eYcwJMObzd9bO95EPy+ggFUwnrC8OcGJmXHrrggtNR8ur1hFy
         xwbA==
X-Gm-Message-State: AOAM5314aQj2DrQe3tCQkXxww+/rI6qv+ppdkfwhoqe9KYvFoHerjV+c
        fy2tTHn5vTVrXRFV3+XqOgazkKD93+XO15fNQJawdc1YI5UeSBf65E3x3X2SEq0c49W30nwEOgH
        2reD+/I5h7csLlBASie+0TWKE
X-Received: by 2002:a37:8906:: with SMTP id l6mr5839104qkd.210.1626380081906;
        Thu, 15 Jul 2021 13:14:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzmQvRW3uZVFB4q2P9pOgOFySzWANZIh9kYKE2WT7dGRzDPmW0UN3xv6AJS7r6NDsxDkVHYA==
X-Received: by 2002:a37:8906:: with SMTP id l6mr5839071qkd.210.1626380081677;
        Thu, 15 Jul 2021 13:14:41 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p64sm2915206qka.114.2021.07.15.13.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:14:41 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>, peterx@redhat.com
Subject: [PATCH v5 08/26] mm: Introduce zap_details.zap_flags
Date:   Thu, 15 Jul 2021 16:14:04 -0400
Message-Id: <20210715201422.211004-9-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of trying to introduce one variable for every new zap_details fields,
let's introduce a flag so that it can start to encode true/false informations.

Let's start to use this flag first to clean up the only check_mapping variable.
Firstly, the name "check_mapping" implies this is a "boolean", but actually it
stores the mapping inside, just in a way that it won't be set if we don't want
to check the mapping.

To make things clearer, introduce the 1st zap flag ZAP_FLAG_CHECK_MAPPING, so
that we only check against the mapping if this bit set.  At the same time, we
can rename check_mapping into zap_mapping and set it always.

Since at it, introduce another helper zap_check_mapping_skip() and use it in
zap_pte_range() properly.

Some old comments have been removed in zap_pte_range() because they're
duplicated, and since now we're with ZAP_FLAG_CHECK_MAPPING flag, it'll be very
easy to grep this information by simply grepping the flag.

It'll also make life easier when we want to e.g. pass in zap_flags into the
callers like unmap_mapping_pages() (instead of adding new booleans besides the
even_cows parameter).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 19 ++++++++++++++++++-
 mm/memory.c        | 34 ++++++++++------------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 795b3cd643ca..26088174daab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1715,14 +1715,31 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct ucounts *);
 extern void user_shm_unlock(size_t, struct ucounts *);
 
+/* Whether to check page->mapping when zapping */
+#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
-	struct address_space *check_mapping;	/* Check page->mapping if set */
+	struct address_space *zap_mapping;
 	struct page *single_page;		/* Locked page to be unmapped */
+	unsigned long zap_flags;
 };
 
+/* Return true if skip zapping this page, false otherwise */
+static inline bool
+zap_skip_check_mapping(struct zap_details *details, struct page *page)
+{
+	if (!details || !page)
+		return false;
+
+	if (!(details->zap_flags & ZAP_FLAG_CHECK_MAPPING))
+		return false;
+
+	return details->zap_mapping != page_rmapping(page);
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 4c269d7b3d83..2a5a6650f069 100644
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
 
@@ -3369,8 +3352,9 @@ void unmap_mapping_page(struct page *page)
 	first_index = page->index;
 	last_index = page->index + thp_nr_pages(page) - 1;
 
-	details.check_mapping = mapping;
+	details.zap_mapping = mapping;
 	details.single_page = page;
+	details.zap_flags = ZAP_FLAG_CHECK_MAPPING;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
@@ -3395,9 +3379,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
-	struct zap_details details = { };
+	struct zap_details details = { .zap_mapping = mapping };
+
+	if (!even_cows)
+		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
 
-	details.check_mapping = even_cows ? NULL : mapping;
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
-- 
2.31.1

