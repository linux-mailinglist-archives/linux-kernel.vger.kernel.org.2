Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B694D3BC660
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhGFGVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230198AbhGFGVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625552307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ityYjh9siN+cqt37lMH9iM8Kf6RLNgbJQFwFFwEp1c=;
        b=bkDkH2tSP+U9vvsci5Roiiz1Sq75LYDU86AsQZstWu9eYHIvTkwNRbOVgDt0psn9F3qpzQ
        9LK/gCf8OGZ0uryAi3WMMwQbr1aLOJfALnCQb22Z9jSwdsMhpOy34xjvAjvwfiO7ErSig6
        TYjVJ27hMm9JyOZM3JgVarJVc9rZsPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-ZUYQh8yQMBeQUgTYI9qmEQ-1; Tue, 06 Jul 2021 02:18:26 -0400
X-MC-Unique: ZUYQh8yQMBeQUgTYI9qmEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 815EC1800D41;
        Tue,  6 Jul 2021 06:18:24 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A19260583;
        Tue,  6 Jul 2021 06:18:22 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com, chuhu@redhat.com
Subject: [PATCH 06/12] mm/debug_vm_pgtable: Use struct vm_pgtable_debug in migration and thp tests
Date:   Tue,  6 Jul 2021 14:17:42 +0800
Message-Id: <20210706061748.161258-7-gshan@redhat.com>
In-Reply-To: <20210706061748.161258-1-gshan@redhat.com>
References: <20210706061748.161258-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct vm_pgtable_debug in the migration and thp test
functions. It's notable that the pre-allocated page is used in
swap_migration_tests() as set_pte_at() is used there.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index eb0a836a73ad..757d2d9c4e93 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -844,7 +844,7 @@ static void __init pmd_swap_tests(struct vm_pgtable_debug *debug)
 static void __init pmd_swap_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-static void __init swap_migration_tests(void)
+static void __init swap_migration_tests(struct vm_pgtable_debug *debug)
 {
 	struct page *page;
 	swp_entry_t swp;
@@ -860,9 +860,10 @@ static void __init swap_migration_tests(void)
 	 * problematic. Lets allocate a dedicated page explicitly for this
 	 * purpose that will be freed subsequently.
 	 */
-	page = alloc_page(GFP_KERNEL);
+	page = (debug->pte_pfn != ULONG_MAX) ?
+	       pfn_to_page(debug->pte_pfn) : NULL;
 	if (!page) {
-		pr_err("page allocation failed\n");
+		pr_err("no page available\n");
 		return;
 	}
 
@@ -883,7 +884,6 @@ static void __init swap_migration_tests(void)
 	WARN_ON(!is_migration_entry(swp));
 	WARN_ON(is_writable_migration_entry(swp));
 	__ClearPageLocked(page);
-	__free_page(page);
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -915,7 +915,7 @@ static void __init hugetlb_basic_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_thp_tests(struct vm_pgtable_debug *debug)
 {
 	pmd_t pmd;
 
@@ -934,7 +934,7 @@ static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
 	 * needs to return true. pmd_present() should be true whenever
 	 * pmd_trans_huge() returns true.
 	 */
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(debug->fixed_pmd_pfn, debug->page_prot);
 	WARN_ON(!pmd_trans_huge(pmd_mkhuge(pmd)));
 
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
@@ -944,7 +944,7 @@ static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
+static void __init pud_thp_tests(struct vm_pgtable_debug *debug)
 {
 	pud_t pud;
 
@@ -952,7 +952,7 @@ static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PUD based THP\n");
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(debug->fixed_pud_pfn, debug->page_prot);
 	WARN_ON(!pud_trans_huge(pud_mkhuge(pud)));
 
 	/*
@@ -964,11 +964,11 @@ static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
 	 */
 }
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_thp_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_thp_tests(struct vm_pgtable_debug *debug) { }
+static void __init pud_thp_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static unsigned long __init get_random_vaddr(void)
@@ -1284,10 +1284,10 @@ static int __init debug_vm_pgtable(void)
 	pte_swap_tests(&debug);
 	pmd_swap_tests(&debug);
 
-	swap_migration_tests();
+	swap_migration_tests(&debug);
 
-	pmd_thp_tests(pmd_aligned, prot);
-	pud_thp_tests(pud_aligned, prot);
+	pmd_thp_tests(&debug);
+	pud_thp_tests(&debug);
 
 	/*
 	 * Page table modifying tests. They need to hold
-- 
2.23.0

