Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B503CADAF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbhGOUSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238859AbhGOURj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnKyw7yDWXQofeLoBv2gn06czfrlb3UiiX/R37cvmsE=;
        b=FQ5ntK3JGFE1p6ohKasBnYeb6Yy+DlBoikXzPD4P7RrVFDpmU0FkDorZbtez/gDPYShiHf
        PiVBoqhjJQLRpil+jkuGDQpylt25JqDvPpeksUv2vngeJPQxHcO/z95SCVzQa8eNDqft2E
        WdxG5XLF6OnkQnnKZQuvXpPb8VCWyJU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-6RqMAmM_MTa3D2jWkPL11A-1; Thu, 15 Jul 2021 16:14:44 -0400
X-MC-Unique: 6RqMAmM_MTa3D2jWkPL11A-1
Received: by mail-qk1-f198.google.com with SMTP id q6-20020a05620a05a6b02903b8bd8b612eso4089739qkq.19
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnKyw7yDWXQofeLoBv2gn06czfrlb3UiiX/R37cvmsE=;
        b=gHrpsrWLEFomZkGfruX+xWLIXgaPgxM+qxbpxiL4aU+MC16Z7/E1L9kEGJtB30pdCZ
         KrHVXfV7ImnpYmARHh+H4wrdh+ysIvQLtPpZosANLisKwstwdToa2xVMiYo9ktvTVOH0
         NtoS3KHVlV+VPtpQDrIfrnFTYbqnWAzLv548gNODaxrQijl4gqNb6q7nmSMsYggU/93p
         aO9SNQ4MFFw38r2D7vVZTEqeCuGXxbM9E+ZlI/dssnWLJQVdZGdXiT37zydaW8ykyhd/
         dczA815btomywZlYl3gP29UmRSq9sWwgqNJc1VeaJJkhqbNCn9rzqhcCI5qbbHU9lLTb
         dtFQ==
X-Gm-Message-State: AOAM5310WWY/TLGX2DUa/V7DxQVVpI4sdljNSIprof7hhAzjUrKwtgDl
        eRPKI57OzYF2aCgznaxspaFbPFwxoDqa5kcBs4EwPyfgpegYy/EQSV5J3772WXrWHDbiJ8l0oIS
        1RgD2olCDTDAKePyPItMgDlEU
X-Received: by 2002:ac8:7e82:: with SMTP id w2mr5685676qtj.224.1626380083615;
        Thu, 15 Jul 2021 13:14:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmWCnHPdO+ZKQ8xVoo7D6usAgQbxNiauGFsJ1ILQyT59bSS4zu7gt2/U/wvfy323F7yD1UAQ==
X-Received: by 2002:ac8:7e82:: with SMTP id w2mr5685646qtj.224.1626380083343;
        Thu, 15 Jul 2021 13:14:43 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p64sm2915206qka.114.2021.07.15.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:14:42 -0700 (PDT)
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
Subject: [PATCH v5 09/26] mm: Introduce ZAP_FLAG_SKIP_SWAP
Date:   Thu, 15 Jul 2021 16:14:05 -0400
Message-Id: <20210715201422.211004-10-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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

