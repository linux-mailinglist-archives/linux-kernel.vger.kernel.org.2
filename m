Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE0D40CC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhIOSRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 14:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230482AbhIOSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631729739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DZHPDTQPmmT4S/5dP0KaRo8sVu/1OOr/SVcw78xFuwQ=;
        b=dCMxL97J4CXWEN4baYWnHzrFHRU9xJ/QvBfQa5KmGgPROI+lFXMIxHrSeDpytr2hS6xy5/
        mvZ13sUdc5sZsx4i0sC2F/SlG/19jE2niFpVqN1Zsx6L1p7jBvRHUIs/IWOYNLaU6HmbH2
        4a0CRyXtR/hr6BSPObPFd7pLcaYOf8k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-YIiItNocMHKdaZ8aQIkRyg-1; Wed, 15 Sep 2021 14:15:38 -0400
X-MC-Unique: YIiItNocMHKdaZ8aQIkRyg-1
Received: by mail-qk1-f197.google.com with SMTP id 23-20020a05620a071700b00426392c0e6eso6102432qkc.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZHPDTQPmmT4S/5dP0KaRo8sVu/1OOr/SVcw78xFuwQ=;
        b=tmfcJJJvLK2tDk613mvvsa6ufai8mbvilpmpc8cQW8cI6aG16qxcfZhEz3mXrLnKxf
         40YAJSwTBDW8fL1f05MykbV+koQj6gdgPDlnkDZt+hBjAaEQwuIbash8wRtotRQTvclu
         mK4W9+TtzYgl2Qk0aRu+8Y2VM7RWm71s6oE5D6k6K+EQqQCSFUCwYxXmD25tgZqiSGu6
         uUapnxU/UCqW70lAuoqWyY7it9NKNm/Cj79Jpxzca2zfktkUrRzkj5YQo+zW33SKkPJ0
         3ZhDAj2fcRV6g9AN8vu5Xgf2Qtx4omxASScjcyxDo9XUr5qY+onIpvI8BR6tBGRM5b/z
         jLaw==
X-Gm-Message-State: AOAM532EEVpWMPRQOgB0jZE40woW3mrre28Gb4FD4yNUYBbi4ci49LXX
        EzUziH71UZYvvnWNLrVXvJcoMY8Y5kxKgrAVGLmw1/TJyNuaYITkVVg1QFjOvmAPZT/j1DL4zl3
        iu4Zzj3hRgHzzVT1TI8nPqgnwSgrJsGudhqMr8crEwNijNun9QT0v77WGZMXt/q5bAV3rTt579Q
        ==
X-Received: by 2002:a05:620a:9c9:: with SMTP id y9mr1254089qky.207.1631729737946;
        Wed, 15 Sep 2021 11:15:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCDiDDdOWKMQa0nt8YhHUXf0hiyQUvKuJ0Xc/zbcBLQR8zWPpath9jFglOz4LhTP3RVO95bA==
X-Received: by 2002:a05:620a:9c9:: with SMTP id y9mr1254052qky.207.1631729737639;
        Wed, 15 Sep 2021 11:15:37 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id c15sm531826qka.46.2021.09.15.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:15:37 -0700 (PDT)
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
Subject: [PATCH v4 3/4] mm: Drop first_index/last_index in zap_details
Date:   Wed, 15 Sep 2021 14:15:35 -0400
Message-Id: <20210915181535.11238-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915181456.10739-1-peterx@redhat.com>
References: <20210915181456.10739-1-peterx@redhat.com>
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
Reviewed-by: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  2 --
 mm/memory.c        | 31 ++++++++++++++++++-------------
 2 files changed, 18 insertions(+), 15 deletions(-)

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
index 7b095f07c4ef..a7e427177817 100644
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
 
@@ -3360,18 +3360,22 @@ void unmap_mapping_page(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct zap_details details = { };
+	pgoff_t	first_index;
+	pgoff_t	last_index;
 
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
 
@@ -3391,16 +3395,17 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
 	struct zap_details details = { };
+	pgoff_t	first_index = start;
+	pgoff_t	last_index = start + nr - 1;
 
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

