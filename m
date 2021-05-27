Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05543393706
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhE0UX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236108AbhE0UXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgZ4fuz9b2G4xHW7EB/zzIIXBN4xHF3mPH57XGKakgk=;
        b=OG3aUB09uPADI5neV7j7ORVBcmUr5kNBDt3p4xskDXxWtGTkE5wOq0xQqN6s5PKYInceOS
        C52ql+/fhArk6IbT0ajk2M7XFGOpQj6g21VwzsgKXw84l50Y8nK1J7cmlNhMJBxnx7fZK+
        ct5jLu4xil7EC+GDGaQdt5wTlCn2HOI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-sx4jW2wSNcu4exzGgJux5g-1; Thu, 27 May 2021 16:21:39 -0400
X-MC-Unique: sx4jW2wSNcu4exzGgJux5g-1
Received: by mail-qt1-f199.google.com with SMTP id f3-20020ac849830000b02901e0f0a55411so870709qtq.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tgZ4fuz9b2G4xHW7EB/zzIIXBN4xHF3mPH57XGKakgk=;
        b=iVPgddhfWjLnEH/9iVlEfh3F/cTyq71E8QICwA9Llxq5rVIw0hAtc9i8h3rtPu0rEd
         SHh7hAmH5cdyXgSm07dC6RG6/WmDOZKFw1HyZvpE/+gSDWY5cpnDzLe9bw9ov9XHtqKO
         XGl+5vRqYUJ9QNcrMOOwZ0GUyKIfMIFiFnqmGvqDBpjkfAeyPJo4QCJo+rIr8nMtD5Im
         oaJYu1eSunNRZOnvYlK85EhtLmgPulkT6wBf5EOLjsU9oDkbwC5wQtUWwAjs6AwAb/g5
         gU6oj5YnSMRSmeVHk9u+tWC6KLax62vikWIWgLZyQjD3JNBKYBYscsBSUSPsY1ot4gOt
         KSgg==
X-Gm-Message-State: AOAM5327tmutYcNH1A7PyNgRZuavDYkRdg+GW1nTIani8m3XuiNibsBY
        gkxtWjMACeIvRKWY6S+7tqnULpIdZwbIpZivd5f5OnnMLokQQnGS1V+rFqbMwHJh65EtIHUCvXe
        c8M6Mg2RdiJau8GW5ZO86Effd
X-Received: by 2002:a37:a45:: with SMTP id 66mr355739qkk.138.1622146899075;
        Thu, 27 May 2021 13:21:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWc8f/UGUmyATH0FVxTT8Qc+Z0pWOiLKfvX0NL7phglOJRhpW7nCQYZyntRo/3ZjxrKn8Cbg==
X-Received: by 2002:a37:a45:: with SMTP id 66mr355721qkk.138.1622146898781;
        Thu, 27 May 2021 13:21:38 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id a68sm2038889qkd.51.2021.05.27.13.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:21:38 -0700 (PDT)
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
Subject: [PATCH v3 09/27] mm: Introduce ZAP_FLAG_SKIP_SWAP
Date:   Thu, 27 May 2021 16:21:35 -0400
Message-Id: <20210527202135.30890-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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

This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
"details" parameter: the caller should explicitly set this to skip swap
entries, otherwise swap entries will always be considered (which is still the
major case here).

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 12 ++++++++++++
 mm/memory.c        |  8 +++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52d3ef2ed753..1adf313a01fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1723,6 +1723,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
 
 /* Whether to check page->mapping when zapping */
 #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+/* Whether to skip zapping swap entries */
+#define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
@@ -1745,6 +1747,16 @@ zap_check_mapping_skip(struct zap_details *details, struct page *page)
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
index c9dc4e9e05b5..8a3751be87ba 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1376,8 +1376,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
+		if (unlikely(zap_skip_swap(details)))
 			continue;
 
 		if (!non_swap_entry(entry))
@@ -3328,7 +3327,10 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
-	struct zap_details details = { .zap_mapping = mapping };
+	struct zap_details details = {
+		.zap_mapping = mapping,
+		.zap_flags = ZAP_FLAG_SKIP_SWAP,
+	};
 
 	if (!even_cows)
 		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
-- 
2.31.1

