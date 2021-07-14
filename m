Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5CB3C93B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhGNWYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236834AbhGNWY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGgwjvpJa6wLNwtGExzq+9oKBigK+KwEv4SzKA2ZKkU=;
        b=e9j4PJ7fmO6xkfdXl7jM5K1S4A5TqUvNLvsi/2QNxJDycRvChr31fEsSYgOKx+eqYlSZof
        CUdj4Tfh8VEG/AEYlnEdAj+QmYXRKkUInX083il3X+H5jMrhMMuUfDPh3c6gZ+Uv/1YnR4
        V/mpUwPtvXYABQt9JwkEpG2F4YDrwIA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-YeYYwF95NHSMrV0FL-WL5w-1; Wed, 14 Jul 2021 18:21:36 -0400
X-MC-Unique: YeYYwF95NHSMrV0FL-WL5w-1
Received: by mail-qk1-f198.google.com with SMTP id bk12-20020a05620a1a0cb02903b899a4309cso2297615qkb.14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGgwjvpJa6wLNwtGExzq+9oKBigK+KwEv4SzKA2ZKkU=;
        b=sJlAzQVUUoLbU9oA6/G1fEy8HIrzokoT0sKYj8aw0hGCVhPtzCugX7ESK2udtR/z3x
         SoOWUYrk9mkJgnaTggNRtTZMYyqnCD3LaMCElHOGfqc03ey5g/xk/qvvfMjRykWpXlHk
         a+SAfqIpC+oZ2TIwE9zDZ2Yy2fOuJDAYK983KWQmk4VJBhU4bJtGzp+V2s83Y89aXk4+
         p/4Zsdhqkb1qWesEY7Di9rKjP0QTL0ghyIHJfowL/R4yvmpJmidpQ1+YAj/P9IWbXZSU
         XPP14adOz7CCPcI953ocbXwihFfLvw8jSOed9TibvqR7hhUuDBESPKXfGbXK29ys2scC
         ryzA==
X-Gm-Message-State: AOAM532x5R3Rsoyt38XOjhrb3MfFLehnWwkbZezA1NltDgubeSjkkzJ6
        0pUfzpHsCsqnZ/w4ZY4RAEW3Y+SV41cRinNZ4+JSF93eS1/luucSK+sP9Gjzwo9CxpjZAo2fMfp
        TZwA3P8n0xFauti3/oNdepqUHSVGNrhQYZ2cCfRU1gjbjebEF7JN6GXf0M9srvuaVcuH1Pag1MQ
        ==
X-Received: by 2002:a05:622a:606:: with SMTP id z6mr331760qta.274.1626301294991;
        Wed, 14 Jul 2021 15:21:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznmkYMfpfk9MyPUyGhCbV3tJ5/PwvweoAj+ICAnQortiwZdCkTLIHXggzx/+vr1Cu0MJIdoA==
X-Received: by 2002:a05:622a:606:: with SMTP id z6mr331721qta.274.1626301294698;
        Wed, 14 Jul 2021 15:21:34 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b25sm1625854qka.123.2021.07.14.15.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:21:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 08/26] mm: Introduce zap_details.zap_flags
Date:   Wed, 14 Jul 2021 18:20:59 -0400
Message-Id: <20210714222117.47648-9-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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

