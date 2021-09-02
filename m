Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58E13FF4C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345795AbhIBUTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231559AbhIBUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630613919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TOAJdCsxdWRdNb0ovj0EkYvPsElPPpeSCrnOTkOMPhM=;
        b=XjQCkzNMLCexekIeO61t6fj9RVf3vUvDGpuLXZvaFaLzS7gcokrprinotyaFnEoP2eUvuN
        aP8LvwMuqRUqkiZxcP2g8b5lw8BLw1mRWO6W5CvOECAM9AMHrystzltIF3ZkoWVzOw7vzu
        B3MXDBgM5+MT4hv0IXhXgfzWEjb7kwA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-2Y618DpFPJuiXtA5UnfLXg-1; Thu, 02 Sep 2021 16:18:39 -0400
X-MC-Unique: 2Y618DpFPJuiXtA5UnfLXg-1
Received: by mail-qv1-f69.google.com with SMTP id w6-20020a0cfc46000000b00370b0997afeso3442457qvp.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOAJdCsxdWRdNb0ovj0EkYvPsElPPpeSCrnOTkOMPhM=;
        b=hce8FWb9dppyHZu8xCRNM1VKqpgoaiUYs+Eopi0bDr0wA0TVgQur4M74JXn3DlytFP
         u3XhhVz/EAczEiO1Ode0AmUjmbu0JVPcK65ZRehT4je9LCqWHQlduqhujUkFGqdIds1n
         BEghea31oRKoBtVydre7TLd3/+ALmSBtFZa38buioAfOWjLE+63OCO7hsRjWyEizbEVI
         pRKBfGmma+W5rOT3SgupVhEoANvD4YamQ/tEt/cGYIJPaW72DFyLt9p//7m9KNKEUN3r
         PyrzgsfluYBqehVKCcaTeFIZys5aKP0ZAzzErhWJBVp/lZFIoeO3RzWlFFOdfecC6uhM
         SGAw==
X-Gm-Message-State: AOAM530vY0W0H8ad/C5RGhpEXxswQRQ92CRe9JVRlO2oQO1ANVvhDuCO
        c8yt/KOg6RRRyTkBR+A6QnDZK8jaqB653EG8Zdg8KO4mz256OC73teReLD89l+hQATRMWgheA3p
        k81+BOliQIYH3r/2768DHcgnZ
X-Received: by 2002:ac8:6601:: with SMTP id c1mr143865qtp.179.1630613918575;
        Thu, 02 Sep 2021 13:18:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx++efQTIvasHbdh2PP0MzWi88Mh6mwdgtTP9JqFrJvmkxBs6mFuxVsRBJhqxz9qndbwxPGvg==
X-Received: by 2002:ac8:6601:: with SMTP id c1mr143838qtp.179.1630613918342;
        Thu, 02 Sep 2021 13:18:38 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id c4sm2381805qkf.122.2021.09.02.13.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:18:37 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 5/5] mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags
Date:   Thu,  2 Sep 2021 16:18:36 -0400
Message-Id: <20210902201836.53605-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210902201721.52796-1-peterx@redhat.com>
References: <20210902201721.52796-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the comment in zap_pte_range() is misleading because it checks against
details rather than check_mappings, so it's against what the code did.

Meanwhile, it's confusing too on not explaining why passing in the details
pointer would mean to skip all swap entries.  New user of zap_details could
very possibly miss this fact if they don't read deep until zap_pte_range()
because there's no comment at zap_details talking about it at all, so swap
entries could be errornously skipped without being noticed.

Actually very recently we introduced unmap_mapping_page() in 22061a1ffabd, I
think that should also look into swap entries.  Add a comment there.  IOW, this
patch will be a functional change to unmap_mapping_page() but hopefully in the
right way to do it.

This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
"details" parameter: the caller should explicitly set this to skip swap
entries, otherwise swap entries will always be considered (which should still
be the major case here).

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 16 ++++++++++++++++
 mm/memory.c        |  6 +++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 81e402a5fbc9..a7bcdb2ec956 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1716,12 +1716,18 @@ static inline bool can_do_mlock(void) { return false; }
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
@@ -1737,6 +1743,16 @@ zap_skip_check_mapping(struct zap_details *details, struct page *page)
 	return details->zap_mapping != page_rmapping(page);
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
index e5ee8399d270..4cb269ca8249 100644
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
@@ -3351,6 +3350,7 @@ void unmap_mapping_page(struct page *page)
 	first_index = page->index;
 	last_index = page->index + thp_nr_pages(page) - 1;
 
+	/* Keep ZAP_FLAG_SKIP_SWAP cleared because we're truncating */
 	details.zap_mapping = mapping;
 	details.single_page = page;
 
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

