Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273C536C94A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhD0QYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237540AbhD0QOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gIgjn5S8tiLrRboG7Na97CFc3ZndoZkUNAZThQ2rzRU=;
        b=ZzoQAIhqzb05LqEiuBzuWVZMyGIm29wiO8BU/zFylYDlMLh7DOXG1MNK+lW9LO2MqQ0nwu
        7mg5lLoAzDZzTeB8VMrGlP14DO0mQaSabazrmUlW7aDWDiKrKsuvU6DvaAjoxVxeiDFvji
        hwcxHTF8B969ALkr80sx7Q/Zv/MVVqo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-wXbgffVQNnGfz1DbfMmYfw-1; Tue, 27 Apr 2021 12:13:31 -0400
X-MC-Unique: wXbgffVQNnGfz1DbfMmYfw-1
Received: by mail-qk1-f198.google.com with SMTP id v15-20020a05620a090fb02902e4d7d50ae2so1585427qkv.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIgjn5S8tiLrRboG7Na97CFc3ZndoZkUNAZThQ2rzRU=;
        b=qw0FvPy4aGKU+kWsF7ETDi1DdA7zcFkV1tcQApz4YeTQuj89rjBNpuX66xZ2aQfHu5
         VSVT2KVsiaQmBIZdV/iVEFWP1KEtgd90DalOfWHah61xi/LFyUL3/3Bx4b3L3HZaV3as
         N+Wq8g6T7o17Bpx0Oo3QKlS95yfgepYcz3/NHbjq/iTmc9PurWwWdRaORTzPo5m8nqGx
         g62LEYV7aV61n9dGDqXeR/WpficaKRx0aA7hFRe6Lfojn6Wn8pbDpcac/YySwP7n3qRv
         MiTdksmlc8jMvduR371OMGiDXMa1rP/4sLrlSt/U0l+SUg6tyYlz1BlFeHGIRsAELbJL
         WEeA==
X-Gm-Message-State: AOAM530OVJBAR7+/DjwR5TiS8bvj+gHREqEusaIrpOoBA7BlCa6PAiqu
        x/JNt3NH9vMjMnLwfEvj8K9f9AyZIFMj7mOCxDDTyNDty/EzrKKn0pMmcr2rFElYU22jxLcxeo2
        CHu4S+uZ4BK0okMe+FN0X0mqM
X-Received: by 2002:a05:620a:1387:: with SMTP id k7mr21581797qki.134.1619540011295;
        Tue, 27 Apr 2021 09:13:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW/1PVlT3w2la6TsTdJYih8T6xfjtv6F8WrSt8l1jAsJMc097j8PN/4aDHkK+EGk9Dc9uj4w==
X-Received: by 2002:a05:620a:1387:: with SMTP id k7mr21581769qki.134.1619540010984;
        Tue, 27 Apr 2021 09:13:30 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:30 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 06/24] mm: Drop first_index/last_index in zap_details
Date:   Tue, 27 Apr 2021 12:12:59 -0400
Message-Id: <20210427161317.50682-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  2 --
 mm/memory.c        | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 84fb1697b20ff..9060b497f4d5c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1707,8 +1707,6 @@ extern void user_shm_unlock(size_t, struct user_struct *);
  */
 struct zap_details {
 	struct address_space *check_mapping;	/* Check page->mapping if set */
-	pgoff_t	first_index;			/* Lowest page->index to unmap */
-	pgoff_t last_index;			/* Highest page->index to unmap */
 };
 
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 02db41bad3340..bcbce803e6850 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3213,20 +3213,20 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
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
 
@@ -3252,17 +3252,17 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
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
2.26.2

