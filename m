Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05DF3CADAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbhGOUSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241162AbhGOURh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qiHbtSxpM+Odw+UliFXdE+ZYHxP5T/ev+d+bKicm4LE=;
        b=Cg/fa5MVo0vZn8POdD1bK6/4ayX0DnpAzUCGbh6FzYYUTDy8MuU2V0l7+GSYne6SCOxL8O
        AxjRd2BmJe20p3aQZ4qTGnk4THUA/C3BRAWDV1d+SkE3XCC8IZFca6xcu9xLTLqeh3q0dO
        VBZx4mQF2jgEbObMUNULlI8JK+XoQMo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-4iet7YxoMIifcQA8pmy9Hg-1; Thu, 15 Jul 2021 16:14:40 -0400
X-MC-Unique: 4iet7YxoMIifcQA8pmy9Hg-1
Received: by mail-qt1-f198.google.com with SMTP id q1-20020a05622a0301b029025f76cabdfcso1859927qtw.15
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qiHbtSxpM+Odw+UliFXdE+ZYHxP5T/ev+d+bKicm4LE=;
        b=s8QgWolR6/hfAnfSfVf6ZMdXC/ajwAk6vE0GZm3gdS9isHn2i2uC5F1HygmjmsUs+m
         hmwA20VgU3wWthSnowv1Eac7cumIMDAteAx6vkLN35vEuOzw7O0OQwyAThtW6KjXGj3o
         nvNFK9JQmsw5PkGpfWaSKFcNmN5gYb5pZDTGm13zLZrcEkjBDlKupJKQFeS3HPRDGG9P
         27vXVc1+cgeHADIpOejKAjQUwjBmUTiHeoSvsG18Y4Sdw5WqWxB84YUAikRjfJZlcr4f
         aBaqhyVkRvV+dHgrmDz1OD7WfqNXTi9iOVO0WPrs7nz2hrlsUmxo6QVo59garVK26y9S
         ggmQ==
X-Gm-Message-State: AOAM533wXVX/weFG3Ghe0OsgQLLMERbFGv8fQxktoZf4pZz3yP1NX5It
        ExlNlCOYcEIJdO3/GTKe5FX/GR0LDDpUTIqaDqVgUmLQP/7e4ddF7YyMQYQS4gr7SepuRE9RjrE
        7/CxAzheNh3PtVgDhBM2LW/xZ
X-Received: by 2002:ac8:5896:: with SMTP id t22mr5666455qta.18.1626380079974;
        Thu, 15 Jul 2021 13:14:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB1gUdSpg3BrfWWugP1tDP6eQWlvDj6gvn/hVXSSf7iM7kH8tsrmgmDrSYq93BmVDO25tm4A==
X-Received: by 2002:ac8:5896:: with SMTP id t22mr5666435qta.18.1626380079728;
        Thu, 15 Jul 2021 13:14:39 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p64sm2915206qka.114.2021.07.15.13.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:14:39 -0700 (PDT)
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
Subject: [PATCH v5 07/26] mm: Drop first_index/last_index in zap_details
Date:   Thu, 15 Jul 2021 16:14:03 -0400
Message-Id: <20210715201422.211004-8-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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

