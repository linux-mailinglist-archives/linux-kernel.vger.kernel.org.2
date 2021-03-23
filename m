Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC734542D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhCWAuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231312AbhCWAtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fV3MtSOZBbfBia062YNmBOAWjcsiN3b7tgIAUmg+MOk=;
        b=bOgT16yrj7ryS2d6sU2fTD8cXP5K1VfJCMZGFCprvk0txfJa41bFt+QBH+n/bRpuW2mHv3
        btCFH89rzAgQw6Ik+P4Ou+NQnJMj2xJwWGESHMdd0S+HIB1s9YCIcIRXLa6i08w07YGKk1
        O3dACKIXFXSl02VCpCocLNMPA4o10wc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-OrQ7J-QmNiWxz22o21wgLg-1; Mon, 22 Mar 2021 20:49:30 -0400
X-MC-Unique: OrQ7J-QmNiWxz22o21wgLg-1
Received: by mail-qv1-f72.google.com with SMTP id n1so568280qvi.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fV3MtSOZBbfBia062YNmBOAWjcsiN3b7tgIAUmg+MOk=;
        b=slvGy/qU0Sfl7TcR4+adG2b6LQv4KaUDD7Aupl2QkADZAY1Ec6LPwF3GVTMR/luTEo
         R+D8KMmBCBVVamqi0LE80gZr8cPstLU6vZGUa9XJxzLpcnsMRQr4XdxvAlTASYwe561v
         hIBc5N7yKYwWq9vxY5yGnuLM7kG+VePs/XeFfOFyClnY0nWD0pa7IswNYtimbaHr2XKy
         yfxMcB3qQxANuEdTYFBJtazmZ0M+XjlS7r/25g1uzDXgEiTNC1L4NY0u7YgnTwMLMPym
         vkeqRv2OxIIbNJW/ON7u+VgeUTQqqTgzMrXSq2IuZuW8fYIvF+NPNDYBxUUXzdB0Wbdm
         N9QQ==
X-Gm-Message-State: AOAM530jAj31BYIshPTdMEs1yXyIoUVjYrkF4ji8aA0eHA7Jfn5c/aKp
        W4EhtAH4/XjW93Oi7jFee5XlYVST7UOBOl/OuAxy8aUXL2rgvh54tmZxVvOu8Df9uUw3MUIMUdm
        dLKiIF4aayhL3QuOopUlixOPuKelwYU0vmf+oCmF9oMSZDrAtTZAThNDzewFTYM6eBMEEfJLQTw
        ==
X-Received: by 2002:ae9:e64b:: with SMTP id x11mr2923252qkl.290.1616460566209;
        Mon, 22 Mar 2021 17:49:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq1QbH70CTFaHpcK8W1TcA+gRvt2O2nG2Ow+91rYU6OblOmJVrYvP9Ef+HtjDx0NsEGppiUg==
X-Received: by 2002:ae9:e64b:: with SMTP id x11mr2923216qkl.290.1616460565830;
        Mon, 22 Mar 2021 17:49:25 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:25 -0700 (PDT)
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
Subject: [PATCH 07/23] mm: Introduce zap_details.zap_flags
Date:   Mon, 22 Mar 2021 20:48:56 -0400
Message-Id: <20210323004912.35132-8-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
index 389dd91134f9..bb513a346beb 100644
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
+	struct address_space *zap_mapping;	/* Check page->mapping if set */
+	unsigned long zap_flags;		/* Special flags for zapping */
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
index 5e6175e00617..2e540b315481 100644
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
@@ -3242,9 +3225,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
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

