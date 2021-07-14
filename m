Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666D23C93B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhGNWYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236789AbhGNWY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qiHbtSxpM+Odw+UliFXdE+ZYHxP5T/ev+d+bKicm4LE=;
        b=EhKhen8TIJn4waSulYTXh7eswdVdxUa5IKx4wPd/dW1Ucb20k0kqrQwlSq+AcDxwJsfTfD
        NBn9rBMx8edH0fY36xCJM5UCF9GruvmMQH31B6mOdFX8e1zHEGwY2WiMcStSTw9vdRxtAH
        wotjdvp4zMs/NDTuePmVEJE55C9Gr4g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-jXhsJuUpOJWlPxALF2970w-1; Wed, 14 Jul 2021 18:21:34 -0400
X-MC-Unique: jXhsJuUpOJWlPxALF2970w-1
Received: by mail-qv1-f72.google.com with SMTP id z93-20020a0ca5e60000b02902e558bb7a04so2683834qvz.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qiHbtSxpM+Odw+UliFXdE+ZYHxP5T/ev+d+bKicm4LE=;
        b=pncSmDcZGwZ/v9lbaqMhoO6NDJNJZbn2io6I97MeiNK8FYG7Vv//mAJwl73dbsOuqH
         s2tEyk6QIgYuvJkddtRxM6YsYH5XOCT97o9g8mOVEVBXgN5jcocB4hm/6x+gYipW3H0H
         2LO1yiDzhyNAkxCjo7PWGHllev9PUJL+eikFFfgDih309OUqLaMckeKR37UOocdGDvLE
         oxWMvDlJTxAOpnzqLzLllWzbHwHceQ4ipOmyBpd25cFtN7//4Dvc67vK//8Qc8k8o/6y
         wJsoQXTnWlzj/gyu302d/7grkQ/ZPv+9aVGVPEeqYIx1ipoyz/GhUj/3xJXSsA/mprx5
         fVGA==
X-Gm-Message-State: AOAM530jKFYWHDkwKpeH4RLtmcKFJ6q7nnhbm23JwNlGkKNBw6l7g0fu
        i2vi8wSUIy4nbGyPiE7tqd16pb6EeVtrX02tEugi2dA/JMsbC17wXEyJr4TsYb/MDy54jt4gveR
        ynjgcrn1ekvkiqQtIH/95Qy6VxeOcY240VieZW2hD9rGv6CFWTttcBjnyrzpPRpmViBiLuZ7Wwg
        ==
X-Received: by 2002:a05:622a:180e:: with SMTP id t14mr295696qtc.375.1626301293308;
        Wed, 14 Jul 2021 15:21:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNGf06mrGz5E8vMivuFkNGw2IaWWFm6VxJucFi8ZYzevcV28jRdodL7+fGsf4xJxP2fA6pRQ==
X-Received: by 2002:a05:622a:180e:: with SMTP id t14mr295658qtc.375.1626301293057;
        Wed, 14 Jul 2021 15:21:33 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b25sm1625854qka.123.2021.07.14.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:21:32 -0700 (PDT)
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
Subject: [PATCH v4 07/26] mm: Drop first_index/last_index in zap_details
Date:   Wed, 14 Jul 2021 18:20:58 -0400
Message-Id: <20210714222117.47648-8-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  2 --
 mm/memory.c        | 29 ++++++++++++++++-------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 57453dba41b9..795b3cd643ca 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1720,8 +1720,6 @@ extern void user_shm_unlock(size_t, struct ucounts *);
  */
 struct zap_details {
 	struct address_space *check_mapping;	/* Check page->mapping if set */
-	pgoff_t	first_index;			/* Lowest page->index to unmap */
-	pgoff_t last_index;			/* Highest page->index to unmap */
 	struct page *single_page;		/* Locked page to be unmapped */
 };
 
diff --git a/mm/memory.c b/mm/memory.c
index ba8033ca6682..4c269d7b3d83 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3322,20 +3322,20 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
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
 
@@ -3361,18 +3361,21 @@ void unmap_mapping_page(struct page *page)
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
 
@@ -3391,17 +3394,17 @@ void unmap_mapping_page(struct page *page)
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

