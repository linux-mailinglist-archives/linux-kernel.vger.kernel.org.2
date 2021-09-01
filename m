Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE20F3FE458
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbhIAU61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231340AbhIAU60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630529848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hq9ANBDJCBArw0iPPGA88rqVQpepBRZET67OXkoqBVo=;
        b=TwY5Ql6xfwiArfjGLHYStbc4R68P3OzjThebrnm6X5di4DK6YdD7CwawlpR0XKOfkOeDLw
        5xcb+N+b6cGhnobfLgnoEvzJNS9eZqsuxuvkKJHeOkyLHh3S3aLDRMm/gEgIxCvfQrLvq0
        qad24tWHNeFakGbAoUisI7Qx72GT3ho=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-icRmAvYPMDG3V80KQag1qQ-1; Wed, 01 Sep 2021 16:57:28 -0400
X-MC-Unique: icRmAvYPMDG3V80KQag1qQ-1
Received: by mail-qk1-f198.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so900371qkd.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hq9ANBDJCBArw0iPPGA88rqVQpepBRZET67OXkoqBVo=;
        b=MHPRdCB1Yaf5/PP2aB9OmfPrW7r1KRaIYy6U8R6lInk+xO7qFw/Fti2UXcRe94sqpx
         a60oCR6qDAymD5CIxYUgIVdXxqN6QpqUcjo53BUMDW5l+J8mT2K6R1YVYwVt5yvwinaF
         CnmQ6XSQ8KxFYAwzBXW1vNd1n7OZWXbSB2a16YZ9y+olGXSZkH26RHeq8LFMQcI4Emra
         r6ZAQZQk7eELNfOogExuq9bVDLePju/ysPLcUJ1ctrFXvEiz9I5gsOk/o0xi0rJganfu
         kFQzS25h/hHE0ZQG6/5B8jHPb6L58fTR8+5+xkxI4tXlunAz3opBw9F5eHrl8MD0Ljlf
         SVUg==
X-Gm-Message-State: AOAM531xrpLfzy0SEMD3+Po+gS8wqzidPlDyzjw5oPcoBn3sKhDtPLru
        h9Kx/3x4NtZnjhHATkaA4wOwsKGxfOnaOCLJfUpzIxDslTd/YTTjyo8sXiWR2OzPqIpCk0jLd7D
        8510uV13dXuIVFB7vV/ZuAO+IN91KfIyI7Z+pzns0/UcH6wQ6JBdsbfUf5pamVj/MwSSYLwZvXg
        ==
X-Received: by 2002:a05:6214:c23:: with SMTP id a3mr1816168qvd.34.1630529845556;
        Wed, 01 Sep 2021 13:57:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5+HjiwKW042yLAjnBDFXBymG7aWJsJmhLIvkEnkATvTWvbu1mTRN3D2vspZ0i+cjMM8yc8Q==
X-Received: by 2002:a05:6214:c23:: with SMTP id a3mr1816129qvd.34.1630529845236;
        Wed, 01 Sep 2021 13:57:25 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id t28sm529163qkt.70.2021.09.01.13.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:57:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 4/5] mm: Introduce zap_details.zap_flags
Date:   Wed,  1 Sep 2021 16:57:22 -0400
Message-Id: <20210901205722.7328-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901205622.6935-1-peterx@redhat.com>
References: <20210901205622.6935-1-peterx@redhat.com>
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
 mm/memory.c        | 34 ++++++++++------------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 69259229f090..fcbc1c4f8e8e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1716,14 +1716,31 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct ucounts *);
 extern void user_shm_unlock(size_t, struct ucounts *);
 
+/* Whether to check page->mapping when zapping */
+#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
-	struct address_space *check_mapping;	/* Check page->mapping if set */
+	struct address_space *zap_mapping;
 	struct page *single_page;		/* Locked page to be unmapped */
+	unsigned long zap_flags;
 };
 
+/* Return true if skip zapping this page, false otherwise */
+static inline bool
+zap_skip_check_mapping(struct zap_details *details, struct page *page)
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
index 3b860f6a51ac..05ccacda4fe9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1333,16 +1333,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
+			if (unlikely(zap_skip_check_mapping(details, page)))
+				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
@@ -1375,17 +1367,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
+			if (unlikely(zap_skip_check_mapping(details, page)))
+				continue;
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
 
@@ -3369,8 +3352,9 @@ void unmap_mapping_page(struct page *page)
 	first_index = page->index;
 	last_index = page->index + thp_nr_pages(page) - 1;
 
-	details.check_mapping = mapping;
+	details.zap_mapping = mapping;
 	details.single_page = page;
+	details.zap_flags = ZAP_FLAG_CHECK_MAPPING;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
@@ -3395,9 +3379,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
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

