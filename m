Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10380403DA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349874AbhIHQhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349831AbhIHQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631118986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iu2AY6e6Zg6u66NXQnGBsoZxC9WFtdy2lzYxTQM+jPs=;
        b=P27iIgdaWo6d+RsLDDvarCQJoeYcv4M+PTm2aik4SoXuvvxL2mPl5niEvhK2dHb382L/ra
        Nl+LMHAY2bWFsBwT9z2ySwt30PvCmuUi16T6SIH/uCIsU5b/G+jXMxOesmCsPk5M5EMFnM
        +RohkMH3ibY1U8hpqDAIm9uflBagwGE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-vX5oMkI2NpC6xIFKNSm9kA-1; Wed, 08 Sep 2021 12:36:26 -0400
X-MC-Unique: vX5oMkI2NpC6xIFKNSm9kA-1
Received: by mail-io1-f72.google.com with SMTP id i78-20020a6b3b51000000b005b8dd0f9e76so2381855ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iu2AY6e6Zg6u66NXQnGBsoZxC9WFtdy2lzYxTQM+jPs=;
        b=dFjVssG8ug81xk9gFFOe68mrCBNuBD+sMnihfRkU4CJoM9uoQCVOx58fWUZZnLik+e
         /yLrl63XYHOMCT+RMEjbpdlOtNM5RLoRlRhp2bNbpqQomuaeGnfSxHfF2qL+/KWm6AUH
         s3Aos3TfTfQYmwsY8gRXml/XoiF1lIq08+5YkQGD88eROHSa5MzjvwGqSoWwzMHPTOGU
         ddHz3ctO+TbuXKu7owXYKN/Vi433myeGO0ewfgbADjfSPlhONk8z1BsXKsw1eiYWVTui
         Lt0g2ZK8jWCYBNHNyWu8DCwuOvoqDyenxqhiy5sfbZC3AgEgLEgDGl6HAE32xTqm9O6m
         j0qQ==
X-Gm-Message-State: AOAM531SlRE5wCjv0IpbRs9fjt1xmW+XTj20448VVvt5aW0NSWSX20xn
        ZqS5BfUaLuJphGbsU14THQKdWETlagE6ffBz0NYfSQ8O/ohAPNY1EoYcBrR+EgASwOl2D/zRe+g
        us9jFEp6o/CvIdJRlzxvzVcjs7przHOfgIH2A4SrmNNiIe1nWc8pz0Tlq2ZXAhSi8Vm+HblKnsg
        ==
X-Received: by 2002:a92:d646:: with SMTP id x6mr564603ilp.280.1631118985043;
        Wed, 08 Sep 2021 09:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYlGL1ZYPDtYUFtupEgcY3T/OH0AOHOi+Li/h9KZCbrHinuN5nXt6Vb53doT6b7HQ13cvx5A==
X-Received: by 2002:a92:d646:: with SMTP id x6mr564564ilp.280.1631118984685;
        Wed, 08 Sep 2021 09:36:24 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id t11sm1363966ilf.16.2021.09.08.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:36:24 -0700 (PDT)
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
Subject: [PATCH v3 3/5] mm: Drop first_index/last_index in zap_details
Date:   Wed,  8 Sep 2021 12:36:22 -0400
Message-Id: <20210908163622.214951-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908163516.214441-1-peterx@redhat.com>
References: <20210908163516.214441-1-peterx@redhat.com>
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
index 73a52aba448f..d1126f731221 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1722,8 +1722,6 @@ extern void user_shm_unlock(size_t, struct ucounts *);
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

