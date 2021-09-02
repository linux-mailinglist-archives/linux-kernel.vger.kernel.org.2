Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5183FF4BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345799AbhIBUSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345860AbhIBUSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630613853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RIXlqNC3vu4lq1txSwh5vWDNYVkPD87pLVis9u4Q2wY=;
        b=LjbpwouDveM9vs0v7tp3wzUwzUMZoCUpIwUg70drx8pE2wYNJBRR83d2vs6crg/MvardD2
        K94lx7EwMxh0FjpSVVLX5Y2xqDcwX2VAcIJL4EagOZjtsJrkUPZ5eGmeQ6uQBdiaxm5Gfh
        Ie+dMqohuGfGCc5mD7dIXY20qRVBRUg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-NxNgtdtJOQClPuGuFKFJaw-1; Thu, 02 Sep 2021 16:17:32 -0400
X-MC-Unique: NxNgtdtJOQClPuGuFKFJaw-1
Received: by mail-qt1-f199.google.com with SMTP id r5-20020ac85e85000000b0029bd6ee5179so2804946qtx.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIXlqNC3vu4lq1txSwh5vWDNYVkPD87pLVis9u4Q2wY=;
        b=KsK0nxkZqGgsNzSQ8cCukwPI2Oe63es+ttfagK2PvFxY6jtdmVq2mJCRJvYzKMjNwg
         5ivy4TaFariV7i8QJTjT8sLj3pv/YI6HPzpF08SZNNdW9KatbZeUBWIZMPiQGFitAxx2
         kJ3by0r5BU8EDeny/sFDy3jATgVhmyvFWyeD36zasZUITUh5ltLVutokn61z1abkHRwV
         lXwvj9Cg7j/wlV0xYh52Svt/FqtaCDR/SlBEQEtzos+Znn+g9yPic81GeabWQo3ir5bu
         /E7rEPg+mWiRkgAb+QHk1LPEEAZ9veNUuJ+1fUQCXE8W25meVUfqjxS3+stVnmEVZsms
         10dg==
X-Gm-Message-State: AOAM530lmD3mgc+zH1eU37XXEUnJejX0AopnMEFwve6x8pEUvgLhbDZH
        G7olY8MbLBXFTWyc+WVz64cy/RNE4eJG+Z8Xv/5AC0d9lutqEigmf2Xx5Xys0iUaXi13NG6Fs28
        RLLeghix4/fNoRrIBtKgHQ3RzGIDHR6/doxSX7C2JaxlRBKOCuObF9IVVHHxxTDC7vOx0AWZMig
        ==
X-Received: by 2002:ac8:7516:: with SMTP id u22mr144398qtq.119.1630613849515;
        Thu, 02 Sep 2021 13:17:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiZpw2RoD+jqSjYVE5EubqqLTA6EzNyQnnsyCqxpeuFnkF3mZbnsg1EEivZeiha6W/LYzBQg==
X-Received: by 2002:ac8:7516:: with SMTP id u22mr144359qtq.119.1630613849206;
        Thu, 02 Sep 2021 13:17:29 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id m8sm2219962qkk.130.2021.09.02.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:17:28 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v2 3/5] mm: Drop first_index/last_index in zap_details
Date:   Thu,  2 Sep 2021 16:17:19 -0400
Message-Id: <20210902201721.52796-4-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210902201721.52796-1-peterx@redhat.com>
References: <20210902201721.52796-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first_index/last_index parameters in zap_details are actually only used in
unmap_mapping_range_tree().  At the meantime, this function is only called by
unmap_mapping_pages() once.  Instead of passing these two variables through the
whole stack of page zapping code, remove them from zap_details and let them
simply be parameters of unmap_mapping_range_tree(), which is inlined.

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  2 --
 mm/memory.c        | 29 ++++++++++++++++-------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..69259229f090 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1721,8 +1721,6 @@ extern void user_shm_unlock(size_t, struct ucounts *);
  */
 struct zap_details {
 	struct address_space *check_mapping;	/* Check page->mapping if set */
-	pgoff_t	first_index;			/* Lowest page->index to unmap */
-	pgoff_t last_index;			/* Highest page->index to unmap */
 	struct page *single_page;		/* Locked page to be unmapped */
 };
 
diff --git a/mm/memory.c b/mm/memory.c
index 7b095f07c4ef..6bba3b9fef7c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3321,20 +3321,20 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
 }
 
 static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
+					    pgoff_t first_index,
+					    pgoff_t last_index,
 					    struct zap_details *details)
 {
 	struct vm_area_struct *vma;
 	pgoff_t vba, vea, zba, zea;
 
-	vma_interval_tree_foreach(vma, root,
-			details->first_index, details->last_index) {
-
+	vma_interval_tree_foreach(vma, root, first_index, last_index) {
 		vba = vma->vm_pgoff;
 		vea = vba + vma_pages(vma) - 1;
-		zba = details->first_index;
+		zba = first_index;
 		if (zba < vba)
 			zba = vba;
-		zea = details->last_index;
+		zea = last_index;
 		if (zea > vea)
 			zea = vea;
 
@@ -3360,18 +3360,21 @@ void unmap_mapping_page(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct zap_details details = { };
+	pgoff_t	first_index, last_index;
 
 	VM_BUG_ON(!PageLocked(page));
 	VM_BUG_ON(PageTail(page));
 
+	first_index = page->index;
+	last_index = page->index + thp_nr_pages(page) - 1;
+
 	details.check_mapping = mapping;
-	details.first_index = page->index;
-	details.last_index = page->index + thp_nr_pages(page) - 1;
 	details.single_page = page;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
-		unmap_mapping_range_tree(&mapping->i_mmap, &details);
+		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
+					 last_index, &details);
 	i_mmap_unlock_write(mapping);
 }
 
@@ -3390,17 +3393,17 @@ void unmap_mapping_page(struct page *page)
 void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
+	pgoff_t	first_index = start, last_index = start + nr - 1;
 	struct zap_details details = { };
 
 	details.check_mapping = even_cows ? NULL : mapping;
-	details.first_index = start;
-	details.last_index = start + nr - 1;
-	if (details.last_index < details.first_index)
-		details.last_index = ULONG_MAX;
+	if (last_index < first_index)
+		last_index = ULONG_MAX;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
-		unmap_mapping_range_tree(&mapping->i_mmap, &details);
+		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
+					 last_index, &details);
 	i_mmap_unlock_write(mapping);
 }
 
-- 
2.31.1

