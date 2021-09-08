Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF65403DAB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349954AbhIHQhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349887AbhIHQhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631118993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awAUVK0W17m50EUHlrWKEaUEucIpwyDPaQz4TREBEy8=;
        b=GxIGWNlHk2PmH2H40WXsXAr3jQDeYCG7oyXkltm9iCc2ubxO6Y72O6T+WNxqZ7bCZa04sq
        vh0Z8VvWBwz31QTWAkGgz5azXhmioMWhz/MPhTpSoYaiu5x1Jhozb0FDkJ+j4Qr6SPPTl/
        d3hFMx9T5/XW/ncDUmPwTCx3zEn+Qjs=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-Vb7iMGieNpKTDwAe4qY9_g-1; Wed, 08 Sep 2021 12:36:32 -0400
X-MC-Unique: Vb7iMGieNpKTDwAe4qY9_g-1
Received: by mail-io1-f71.google.com with SMTP id e18-20020a6b7312000000b005be766a70dbso2192290ioh.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awAUVK0W17m50EUHlrWKEaUEucIpwyDPaQz4TREBEy8=;
        b=HCvv7DxWvVZtQay29vByDFC1fBJ42JmofeBuI3iDdNHKtompewjdouGa0e+VcHOWZX
         QbG9jkdDN7r6EDeSHYFL/UMpO6CBYBNYJMwmJSPQmJisWxZMhBh0YF5eklD+HUb9TzmF
         2ipoLWkxlImwTMWser6gv6pJEqaN4mMFDu3nmk0AzUK/mD3Wv0rwwafB85iJzc4j0vdK
         Qcf2+mPJO1dfYz3X5KubD0hXqOTU3a2JjbJWCmbYRvP59l3HwT4CqfV3K8ZQ76bfkI6f
         WDIPcJBjAbv801HhS66iyk1fnjm2dgbCO1i1ldbAVZ3wLHHBonwSHRO96QwIfBwm6bDM
         tNWQ==
X-Gm-Message-State: AOAM530bclkW6iPrKGLPLrVMKIoNGcRj5vf2i6N4FvR8sjn9BvkKnpaX
        CmkOcnMOt0whvItjTKxws/R5bLnKKEBtMBMO/XK+YWIRhGTLJkfLyf54voXjIf00Q3aYkur5YKz
        JQ4Ya5hP/HCxQiLuzSSMLwm3+loB5S8qxWjJI2ByKwqLDwpYE9T0vkgWqv5M8EsuOYoCwYvFALw
        ==
X-Received: by 2002:a05:6602:38e:: with SMTP id f14mr679958iov.62.1631118991014;
        Wed, 08 Sep 2021 09:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPBgjnxcRmDnznmj8Z8D2m8laj1F/cKtZgajr2y1D7LR0ubX5FPyZ9OQcONNyn/24a8NcA/Q==
X-Received: by 2002:a05:6602:38e:: with SMTP id f14mr679909iov.62.1631118990674;
        Wed, 08 Sep 2021 09:36:30 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id q14sm1340458ilj.34.2021.09.08.09.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:36:30 -0700 (PDT)
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
Subject: [PATCH v3 5/5] mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags
Date:   Wed,  8 Sep 2021 12:36:28 -0400
Message-Id: <20210908163628.215052-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908163516.214441-1-peterx@redhat.com>
References: <20210908163516.214441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the comment in zap_pte_range() is misleading because it checks against
details rather than check_mappings, so it's against what the code did.

Meanwhile, there's no explicit reason why passing in the details pointer should
mean to skip all swap entries.  New user of zap_details could very possibly
miss this fact if they don't read deep until zap_pte_range() because there's no
comment at zap_details talking about it at all, so swap entries could be
erroneously skipped without being noticed.

This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
"details" parameter: the caller should explicitly set this to skip swap
entries, otherwise swap entries will always be considered (which should still
be the major case here).

We may want to look into when exactly we need ZAP_FLAG_SKIP_SWAP and we should
have it in a synchronous manner, e.g., currently even if ZAP_FLAG_SKIP_SWAP is
set we'll still look into swap pmds no matter what.  But that should be a
separate effort of this patch.

The flag introduced in this patch will be a preparation for more bits defined
in the future, e.g., for a new bit in flag to show whether to persist the
upcoming uffd-wp bit in pgtable entries.

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 16 ++++++++++++++++
 mm/memory.c        |  6 +++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ed44f31615d9..beb784ce35b9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1717,12 +1717,18 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct ucounts *);
 extern void user_shm_unlock(size_t, struct ucounts *);
 
+typedef unsigned int __bitwise zap_flags_t;
+
+/* Whether to skip zapping swap entries */
+#define  ZAP_FLAG_SKIP_SWAP  ((__force zap_flags_t) BIT(0))
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
 	struct address_space *zap_mapping;	/* Check page->mapping if set */
 	struct page *single_page;		/* Locked page to be unmapped */
+	zap_flags_t zap_flags;			/* Extra flags for zapping */
 };
 
 /*
@@ -1739,6 +1745,16 @@ zap_skip_check_mapping(struct zap_details *details, struct page *page)
 	    (details->zap_mapping != page_rmapping(page));
 }
 
+/* Return true if skip swap entries, false otherwise */
+static inline bool
+zap_skip_swap(struct zap_details *details)
+{
+	if (!details)
+		return false;
+
+	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index e5ee8399d270..26e37bef1888 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1379,8 +1379,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
+		if (unlikely(zap_skip_swap(details)))
 			continue;
 
 		if (!non_swap_entry(entry))
@@ -3353,6 +3352,7 @@ void unmap_mapping_page(struct page *page)
 
 	details.zap_mapping = mapping;
 	details.single_page = page;
+	details.zap_flags = ZAP_FLAG_SKIP_SWAP;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
@@ -3377,7 +3377,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
-	struct zap_details details = { };
+	struct zap_details details = { .zap_flags = ZAP_FLAG_SKIP_SWAP };
 
 	details.zap_mapping = even_cows ? NULL : mapping;
 	if (last_index < first_index)
-- 
2.31.1

