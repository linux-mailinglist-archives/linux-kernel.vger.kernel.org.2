Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C318C345429
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhCWAuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231245AbhCWAt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLKkf+ZPkMgUQMvwd6XDyh9qcQY+uJivyMkVgKqyvds=;
        b=ev4Rt5oyj18Oe188RyoCR2wS7a2qGXZaw4WJgiTw06jZ1PQJFyc+K2kJ/F4jWG7ZuSvFSq
        atVIyaFQ8jD6tScFrPzqS0DujIIF6yAMleYeuFCnbccEUn0ZA4KPUWbCpjU8HO0+OLWI9L
        NKHiCdU3+jSER0jRx0G1VuFWq1A5+58=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-oMKthI7PMUG2zTsSgJlvzQ-1; Mon, 22 Mar 2021 20:49:25 -0400
X-MC-Unique: oMKthI7PMUG2zTsSgJlvzQ-1
Received: by mail-qt1-f197.google.com with SMTP id r32so388191qtd.16
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLKkf+ZPkMgUQMvwd6XDyh9qcQY+uJivyMkVgKqyvds=;
        b=s9rirYP4fZUIs2/XErMwJZP77zYSJ7Sr8zV5jniyWTQs7Kp5lOrG89Zo2BHIF5Ghrz
         P2PX6D9VPHRrhZEznJVQu8Eq57nfIyGkmy+oyLcQ4Xo6RwkzM+bjZe6JIyBdWsAxRcoo
         uJJOfagoSGt5HaVeaELV7dDYBCN9ed4d6dJ3TkYDYgcoyEOvzRIJx5hABWpvPoy+nmJi
         BDkJ6Kjdm6FjIsp6mYunZ9cFN7e1c6rjJGfMLbf/rQ8Tm6a+M9GeleFPsxv+ovaK7VkF
         wgRTMcskXklsP4VbYMrQQhvLX097zNYSWfnaP/pqfJeAhtv4jPLOPdpOalb9DNWFuvUz
         FxPw==
X-Gm-Message-State: AOAM531U+zA921M+55R+bK+rWwobr5nHXezjoeEqa7RvOov6Tti1UQXP
        /o5BMoEDWfstym/Cj6xAKqtMvDGxSnv0l4pu6FEiQ8Ltm8dyV/xvRRF8f2Cq0hHnZtmnrImQV/u
        aAl4W211BgUEEcCV0r3nlel1LzJL/x7LAqjpfvPGUkmti20H60ws8eXL8+LZmOw6mBh8stnRrQA
        ==
X-Received: by 2002:a05:622a:38a:: with SMTP id j10mr2356397qtx.321.1616460564613;
        Mon, 22 Mar 2021 17:49:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWTu7ggSiwl9a2400ldzG7CNv+Tgn2StD4wlyGGg2tML5uryFjvwpa6kp0vQM/I+lvGp7Ilw==
X-Received: by 2002:a05:622a:38a:: with SMTP id j10mr2356368qtx.321.1616460564311;
        Mon, 22 Mar 2021 17:49:24 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 06/23] mm: Drop first_index/last_index in zap_details
Date:   Mon, 22 Mar 2021 20:48:55 -0400
Message-Id: <20210323004912.35132-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
index b78306eb7a63..389dd91134f9 100644
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
index b4ddba343abc..5e6175e00617 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3202,20 +3202,20 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
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
 
@@ -3241,17 +3241,17 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
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

