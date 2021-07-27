Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BA23D6EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbhG0GPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235799AbhG0GOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627366495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w57AtsGV+VWVX+2p99w37D6abcXCDtVokuSHgy/pQSE=;
        b=C64mqNlZwyRoRUld8ke27C1+/TPbk3iIXHASAWuQanlDO3T3UxsDjxv/jyEeyDZYbsD0Tc
        mJPt/8aaU205mFZ+oRupZDVLw2xJYazxFTu69QGN6HQfmF5+0UrZV9IFagUfuFLLGNEl1C
        m/epS6rqu4/rDlIochrzWnXMg+gaoSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-LyWJzTQpNYeVQKnMzkGU3g-1; Tue, 27 Jul 2021 02:14:52 -0400
X-MC-Unique: LyWJzTQpNYeVQKnMzkGU3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D3E88799F3;
        Tue, 27 Jul 2021 06:14:50 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BC549C8C3;
        Tue, 27 Jul 2021 06:14:46 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v4 06/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in migration and thp tests
Date:   Tue, 27 Jul 2021 14:13:55 +0800
Message-Id: <20210727061401.592616-7-gshan@redhat.com>
In-Reply-To: <20210727061401.592616-1-gshan@redhat.com>
References: <20210727061401.592616-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in the migration and thp test
functions. It's notable that the pre-allocated page is used in
swap_migration_tests() as set_pte_at() is used there.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index bc153cad9045..9136195efde3 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -845,7 +845,7 @@ static void __init pmd_swap_tests(struct pgtable_debug_args *args)
 static void __init pmd_swap_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-static void __init swap_migration_tests(void)
+static void __init swap_migration_tests(struct pgtable_debug_args *args)
 {
 	struct page *page;
 	swp_entry_t swp;
@@ -861,9 +861,10 @@ static void __init swap_migration_tests(void)
 	 * problematic. Lets allocate a dedicated page explicitly for this
 	 * purpose that will be freed subsequently.
 	 */
-	page = alloc_page(GFP_KERNEL);
+	page = (args->pte_pfn != ULONG_MAX) ?
+	       pfn_to_page(args->pte_pfn) : NULL;
 	if (!page) {
-		pr_err("page allocation failed\n");
+		pr_err("no page available\n");
 		return;
 	}
 
@@ -884,7 +885,6 @@ static void __init swap_migration_tests(void)
 	WARN_ON(!is_migration_entry(swp));
 	WARN_ON(is_writable_migration_entry(swp));
 	__ClearPageLocked(page);
-	__free_page(page);
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -916,7 +916,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_thp_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -935,7 +935,7 @@ static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
 	 * needs to return true. pmd_present() should be true whenever
 	 * pmd_trans_huge() returns true.
 	 */
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
 	WARN_ON(!pmd_trans_huge(pmd_mkhuge(pmd)));
 
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
@@ -945,7 +945,7 @@ static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
+static void __init pud_thp_tests(struct pgtable_debug_args *args)
 {
 	pud_t pud;
 
@@ -953,7 +953,7 @@ static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PUD based THP\n");
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(args->fixed_pud_pfn, args->page_prot);
 	WARN_ON(!pud_trans_huge(pud_mkhuge(pud)));
 
 	/*
@@ -965,11 +965,11 @@ static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
 	 */
 }
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_thp_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_thp_tests(struct pgtable_debug_args *args) { }
+static void __init pud_thp_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static unsigned long __init get_random_vaddr(void)
@@ -1345,10 +1345,10 @@ static int __init debug_vm_pgtable(void)
 	pte_swap_tests(&args);
 	pmd_swap_tests(&args);
 
-	swap_migration_tests();
+	swap_migration_tests(&args);
 
-	pmd_thp_tests(pmd_aligned, prot);
-	pud_thp_tests(pud_aligned, prot);
+	pmd_thp_tests(&args);
+	pud_thp_tests(&args);
 
 	hugetlb_basic_tests(&args);
 
-- 
2.23.0

