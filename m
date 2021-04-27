Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A2A36C949
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhD0QYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237541AbhD0QOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=79hgS/3VF19uL8B1KnbV12ieWH4dDf98xJSUkbEku0E=;
        b=OkuTzNgaRaTRgLlmHExgtebDM+WPSJ/OONeCW6rIen1OZfQfCV+RpDtxFhfbmig2uSwLcu
        hv/MiaMx/+XkSCV3pCJm+DIXiAmXoKYW3T9EdFqFsHNNrqIZofWbntoX18W5yZvBS+UABh
        izrA8Mq0/HVtuhKJ+t616VJJoEVfqj8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-7PLy6l9XM9Cp3KaZhvHCFg-1; Tue, 27 Apr 2021 12:13:34 -0400
X-MC-Unique: 7PLy6l9XM9Cp3KaZhvHCFg-1
Received: by mail-qv1-f70.google.com with SMTP id p20-20020a0ce1940000b02901be3272e620so1258266qvl.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79hgS/3VF19uL8B1KnbV12ieWH4dDf98xJSUkbEku0E=;
        b=PTictSJggz6Xxmkuf7aLxFyrdfvFQceuQfQWOvU+EtyChFrGdZM3HCyJWGIpt1ss2h
         eW9VyVduhJ52uYZ2XSqmBQpifxeLsEQ6uc8lY5ThpDHJ1sm41tKW/9OvKnAbqjfR4NFg
         YJNeB26zZW1/uL80qo5n/CXOvXjCm/wU7L5ffw0pZ7Ld/qmjXMQzsur0IG5q8hIiqp+E
         1ZXxQlfL1+YNrT30YuTSH/HRw0VdTdciG0pAcR0fXwvBteuc465RCGVqlawC0eUVqnLy
         qf4Np1Lsj2v2OiEKRkPw7qbwTU2Ri3U4K+F5VJOHoazOnx7poLK4AI4vNewbZD7Ogfgz
         luDQ==
X-Gm-Message-State: AOAM531L7VbfuU+kAQF3RhoCBYL6pQ8qxE6o6vdI03Iflw9hXj+rJ219
        0ztrkFE5BRZK0oUyJO8MRtTa5Ydc7zx6EdGEJ4c243zVYFBxB3rrurM+RcY2WOj7TI+qoXlUgvd
        u8PXlUzNZs+JLeA9rYszFEfgz
X-Received: by 2002:a0c:ab12:: with SMTP id h18mr11741084qvb.33.1619540013442;
        Tue, 27 Apr 2021 09:13:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuSIgswcmVwkMNc/apUchEgjfSAXm6CbKvjAhSKPYH54HMTCmY99nS8hMUF9WgKkHBYwHOQw==
X-Received: by 2002:a0c:ab12:: with SMTP id h18mr11741039qvb.33.1619540013117;
        Tue, 27 Apr 2021 09:13:33 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:32 -0700 (PDT)
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
Subject: [PATCH v2 07/24] mm: Introduce zap_details.zap_flags
Date:   Tue, 27 Apr 2021 12:13:00 -0400
Message-Id: <20210427161317.50682-8-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
 mm/memory.c        | 31 ++++++++-----------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9060b497f4d5c..39c944bf7ed3a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1702,13 +1702,30 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct user_struct *);
 extern void user_shm_unlock(size_t, struct user_struct *);
 
+/* Whether to check page->mapping when zapping */
+#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
-	struct address_space *check_mapping;	/* Check page->mapping if set */
+	struct address_space *zap_mapping;
+	unsigned long zap_flags;
 };
 
+/* Return true if skip zapping this page, false otherwise */
+static inline bool
+zap_check_mapping_skip(struct zap_details *details, struct page *page)
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
index bcbce803e6850..94954436544f7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1242,16 +1242,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
+			if (unlikely(zap_check_mapping_skip(details, page)))
+				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
@@ -1283,17 +1275,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (is_device_private_entry(entry)) {
 			struct page *page = device_private_entry_to_page(entry);
 
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
+			if (unlikely(zap_check_mapping_skip(details, page)))
+				continue;
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
 			page_remove_rmap(page, false);
@@ -3253,9 +3236,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
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
2.26.2

