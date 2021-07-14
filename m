Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37403C93B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhGNWYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236692AbhGNWYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnKyw7yDWXQofeLoBv2gn06czfrlb3UiiX/R37cvmsE=;
        b=W6poVT01o9m8NtqBJyJODcZy3oT+2AT1vsDa7e7XzfJRZ1XcPyx8Czc1vU3/J4kioGHWR+
        f4X8NhRerxbC/JNaShWX0rtJOUbQmlEYl3VeFoNHGuOv5Sn6KwfBuzDjimgUr7hSdQCquM
        3wj2Opfq7b6ClzfwsjJpiDHTs5TISDA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62--iZ_muG3NLO5sBHrYUzSLA-1; Wed, 14 Jul 2021 18:21:37 -0400
X-MC-Unique: -iZ_muG3NLO5sBHrYUzSLA-1
Received: by mail-qv1-f69.google.com with SMTP id l4-20020a0ce8440000b02902d89f797d08so2670553qvo.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnKyw7yDWXQofeLoBv2gn06czfrlb3UiiX/R37cvmsE=;
        b=aqGhVzrg4gCxsYsAThiFseF3ZAGiw7M+51R3fBZoXv57nWGZTpD9ehclhc5LqxYeoP
         1defCxICV9Rm7151DGK2VTDo8NjkWj2H8XjJg9m9wb/rmX3W73P7ChedOn4eSMK+n9Si
         fEs0KhCVWfGTxUvWvm8h6yAQgLDjzeL8uBLyapAeVPLoGMaJr8+Ijl0O+NOwp8esSCWt
         aTJmC1MjihGN0nakW4nFiOevybkAcsp0QauQp59uTNRuV0Z7yjl2ULjIiwXqSI4eGbGJ
         DU3AV+AiPfQG6iK7FkfaqRX3Ji2D0IFAZMnHvppVLirvCi82Epp5weZqFEF7nqHhRF7p
         uO5Q==
X-Gm-Message-State: AOAM533VdWQo9+4s84Pe3k7Hy0XuKQ3ry1sgppFxrXLwUJoHfQBUxANV
        md4P87quLCI7Yr/icNlk8OzX/uvCvoEFvztYCmlx8uT/K3zL3oitkiEY9up0J4ZszvpwoTHZbNE
        93U18IvZBZ4KRrpBtQbAkmTYpdgpw7oOzmtjBfLCLhV4388Hs52EMgn4I32JPTRrRdx/xdjO1wA
        ==
X-Received: by 2002:ae9:e911:: with SMTP id x17mr189391qkf.371.1626301296760;
        Wed, 14 Jul 2021 15:21:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3A2Wvg6inICIbbeHBjb+ttmIrgQi5IfcXgb8Oye1uuRPIVOvrfqGI3ZbgjTSbv8g+Jmw2JA==
X-Received: by 2002:ae9:e911:: with SMTP id x17mr189360qkf.371.1626301296471;
        Wed, 14 Jul 2021 15:21:36 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b25sm1625854qka.123.2021.07.14.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:21:35 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 09/26] mm: Introduce ZAP_FLAG_SKIP_SWAP
Date:   Wed, 14 Jul 2021 18:21:00 -0400
Message-Id: <20210714222117.47648-10-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 12 ++++++++++++
 mm/memory.c        |  8 +++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 26088174daab..62a75e4414e3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1717,6 +1717,8 @@ extern void user_shm_unlock(size_t, struct ucounts *);
 
 /* Whether to check page->mapping when zapping */
 #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+/* Whether to skip zapping swap entries */
+#define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
@@ -1740,6 +1742,16 @@ zap_skip_check_mapping(struct zap_details *details, struct page *page)
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
index 2a5a6650f069..d6b1adbf29e4 100644
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
@@ -3379,7 +3378,10 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
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

