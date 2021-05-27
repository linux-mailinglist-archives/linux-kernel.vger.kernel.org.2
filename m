Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE605393705
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhE0UX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236051AbhE0UXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2JdT0mH38cplAf1wx/5ANh95qkzxlwLzfafgEJNeGw=;
        b=BpcNqeCb2ubGSon2ITDA4Oh/Iie0DvCVvdOrN4xDF8isy8zdczt8QccI64F71HiaheHkuN
        /ZizvVI9zBTrTRqqyw2u8XTR5nzQ8e4EL7bStAzfS8+sPH+Iktn0LfDbw/EowkguFtDXXe
        odJ4TxE+zOEMqgdLpK5QYKE8DHjFAw4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-3QRsaFJnNA21sl4u4InCUA-1; Thu, 27 May 2021 16:21:35 -0400
X-MC-Unique: 3QRsaFJnNA21sl4u4InCUA-1
Received: by mail-qt1-f199.google.com with SMTP id d7-20020ac811870000b02901e65f85117bso846072qtj.18
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2JdT0mH38cplAf1wx/5ANh95qkzxlwLzfafgEJNeGw=;
        b=US9hTGg4m+Tzz8V1uWf1aRvYUuCMWMdmDxIvrQgB2aE0zMJW+IRhjAmkI7orwRFVyb
         j6Q9oAEW8ZIZMOu1s48Bv8H/zV/VvJPMYzwvQMz8y7z6ZOZWe56A+9CXmSAs2RxId3B6
         0tuJqRnLJZVA3qnik2vtTPBkHkGbJ+8OFKENJy4kkLtQ/iCBNEnBiRtbJLnrIby8lLTm
         rbyFxBhgttUXhm/PvxEWhkqnJJmWy138PbqQ9UoRZ+vrS1DSDlrsm9l/hzCOwlh/Wm8v
         M8dp1jVcP+vRbcX4u2oiOWYryud4V+qDxCFOGK1e8EF/zV8CrMJNoEabvUMqfvERGD+5
         L2cQ==
X-Gm-Message-State: AOAM531+CdWMRXx0Va1iYDZ0R1liN37aWj2lQo8LAAEI01/hI+4KEqrZ
        AYCuQqdFc8TxPjFwBFyc/ktxotnERjU1Hudwk/IRrhJmoR715hO6z8vw4eJPdX5nwHScudLtJQQ
        brQW8ZpIegy7CmsIi6Yc4XUjE
X-Received: by 2002:ac8:5e0e:: with SMTP id h14mr331675qtx.117.1622146894984;
        Thu, 27 May 2021 13:21:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoIpkNIQzO6Y2dcRvaoAmnmF0fwzYQWpYm5GB3jVmlkja21NwVMuJciLokF/MtY1ToQcNROA==
X-Received: by 2002:ac8:5e0e:: with SMTP id h14mr331647qtx.117.1622146894684;
        Thu, 27 May 2021 13:21:34 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id x9sm2001277qto.33.2021.05.27.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:21:34 -0700 (PDT)
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
Subject: [PATCH v3 08/27] mm: Introduce zap_details.zap_flags
Date:   Thu, 27 May 2021 16:21:30 -0400
Message-Id: <20210527202130.30840-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
index db155be8e66c..52d3ef2ed753 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1721,13 +1721,30 @@ static inline bool can_do_mlock(void) { return false; }
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
index 27cf8a6375c6..c9dc4e9e05b5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1330,16 +1330,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
@@ -1372,17 +1364,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		    is_device_exclusive_entry(entry)) {
 			struct page *page = pfn_swap_entry_to_page(entry);
 
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
 
@@ -3345,9 +3328,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
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
2.31.1

