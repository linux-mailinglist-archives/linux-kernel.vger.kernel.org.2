Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC22393704
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbhE0UXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235890AbhE0UXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5FCImkTLc8C+iW7llWT4B7oKe4vYYc/EBx9K8XBnj4=;
        b=gs1oKSZ7qYcixE4YEQLK4X3ILmfr+wxL0hsn/JslM9umnD+7VATGLU/nlpWp26wT/0pvEq
        +zEoAcFnlh0h6VG81lHiSf66KuFVyl0JhSz+sCuD2q+48FbtIcQXnaE04j7b9lEnSDRVcm
        b8/OcUl6fpUqlHF36RbjvqGvZoncrGE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-4CTW-jMONTWwoNthkamX6w-1; Thu, 27 May 2021 16:21:31 -0400
X-MC-Unique: 4CTW-jMONTWwoNthkamX6w-1
Received: by mail-qv1-f71.google.com with SMTP id z93-20020a0ca5e60000b02901ec19d8ff47so1029417qvz.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5FCImkTLc8C+iW7llWT4B7oKe4vYYc/EBx9K8XBnj4=;
        b=GNEChvycp0LPj3LJEXaukc6dxBkua9JAty2P+JGyc3krdnJEgw23omZywc6YkFLoZ0
         hi6gw1z3bJDB55i6ZyAX/i5+TiHqnogB+fmqtDxKWDxwAzboW81H8ZThyptJjoTpAj5P
         +qPPHaTASHaiTD2iz4xe/y1+VrnwBcAmRRGMYQBfDP+7uSaPoYc3th1OzfGYuT/dBe3r
         wQAIlcOPS9+sjGKUHvs6AviSgpRqpEl58mr3ffypF69TxnD04OmBYJnOKIme+IUIdTAA
         qlql3hJbhDz2l+vKMJwo6Bl/+kQx0QwHSrzEnf1rf/blaHU7pp440EfnY5XgSh9qLY/N
         qV1Q==
X-Gm-Message-State: AOAM532y57XLPT96ZdnxnYfTbnJhDG1RL7d1ZTKsH4XYHo+x5s6YgJyS
        qrmlraoKzVg/bt/BM+xcUVmJP5amJxnd4yfRTy0Apl9jXCEW5m5CKCWXiaKwevvusvgeZ9jFqOz
        X2RIG1dLw4CWhQ9Y8s8Wb9rgA
X-Received: by 2002:ac8:75d3:: with SMTP id z19mr362916qtq.44.1622146890383;
        Thu, 27 May 2021 13:21:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypIsqd4DUNG1ZqS0UQQmBuBbvTh9zi1M5X23Oonzevxam33oO8kSwmkp38m1qPCCeZl1p/ig==
X-Received: by 2002:ac8:75d3:: with SMTP id z19mr362893qtq.44.1622146890139;
        Thu, 27 May 2021 13:21:30 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id 42sm2070151qtf.37.2021.05.27.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:21:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 07/27] mm: Drop first_index/last_index in zap_details
Date:   Thu, 27 May 2021 16:21:26 -0400
Message-Id: <20210527202126.30790-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
index ef9ea6dfefff..db155be8e66c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1726,8 +1726,6 @@ extern void user_shm_unlock(size_t, struct user_struct *);
  */
 struct zap_details {
 	struct address_space *check_mapping;	/* Check page->mapping if set */
-	pgoff_t	first_index;			/* Lowest page->index to unmap */
-	pgoff_t last_index;			/* Highest page->index to unmap */
 };
 
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 45a2f71e447a..27cf8a6375c6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3305,20 +3305,20 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
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
 
@@ -3344,17 +3344,17 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
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

