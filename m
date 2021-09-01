Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3E33FE454
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbhIAU5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238818AbhIAU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630529794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyvbaiG0U5DtzGIoOe88A1mEk7hd6gPkepgpidPNJQ0=;
        b=MbCsp2yRNzBOfuLQRdHbd1btzQDBBYGxphPRR9d+oURAcRdjn5JBJ6KutjeuJ1AOdJiCLP
        BQZTc1Mu1GWKgw8rkGkMYd2aweyGUWOdOeeLNcRTSxIW20rUJEtnKN6vuoFwfgzK2SMDZP
        xm91vZ6IVPZqaFq/B9MT8nETTdHtJ/A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-D6TkGEtrNC-TOIrQUXP-ZA-1; Wed, 01 Sep 2021 16:56:34 -0400
X-MC-Unique: D6TkGEtrNC-TOIrQUXP-ZA-1
Received: by mail-qk1-f198.google.com with SMTP id 21-20020a370815000000b003d5a81a4d12so867117qki.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyvbaiG0U5DtzGIoOe88A1mEk7hd6gPkepgpidPNJQ0=;
        b=qVOlN76fXo20f+cjz3JnW5U/GwgKVoeILM6948RMH4ebPNJVwTBqBz+sB1eLFJtHtj
         AxXv08AxsfD1LwdY+k04sqdb0RhYTeevUUPMXZ25HjrdTgtbdCkYiedfFo54ZXoMXHMQ
         8HuhYCauNEt8dznSurW2h3zx0CGH4wWJmgZHHZ6fF6DBFXOqiVzV6pK0cUNEXCdeXPq/
         1xbeESE8ZeF+leVZjTMsJ/f3OgAqHumun3lwOZpTv2rpAzZVr5bl3QfNK1hiVuNe6t5O
         CgtGoZEJTpDZI4CAzSpLt4BiALMa+4P67WgOIr6lUjb5fdqUlwkEulJh9kSFbVPKRzA3
         51VA==
X-Gm-Message-State: AOAM530vUwcpi5pENRRzmRnou2noqz/z63g9Aqzq6K7aguvJQDjEzRpf
        F5P41VwcwTcRMReHsnJrnf3rHPks8Z9wepLQSXU+DMJAUlL9Q/nkerGCHGGEE6jpy32AmzibrLZ
        ppZBjC3vi41ubE44Qm5Tzt1Ytp74yRawIDnUjC1lD3hrP+wN5A0p+aTlp9V7cvqg9TOTGzK0MOQ
        ==
X-Received: by 2002:ac8:4d90:: with SMTP id a16mr1427483qtw.190.1630529792166;
        Wed, 01 Sep 2021 13:56:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzA6t7HDUB1HpglkSgCMBRTVio39DwymdQJ8VWpp6mifRs9LMiBKPHS8XxadRgIFxFNScBadw==
X-Received: by 2002:ac8:4d90:: with SMTP id a16mr1427452qtw.190.1630529791909;
        Wed, 01 Sep 2021 13:56:31 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id f3sm624865qti.65.2021.09.01.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:56:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 3/5] mm: Drop first_index/last_index in zap_details
Date:   Wed,  1 Sep 2021 16:56:20 -0400
Message-Id: <20210901205622.6935-4-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901205622.6935-1-peterx@redhat.com>
References: <20210901205622.6935-1-peterx@redhat.com>
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
index 204141e8a53d..3b860f6a51ac 100644
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

