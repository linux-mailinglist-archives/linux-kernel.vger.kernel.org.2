Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F353E429A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhHIJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234422AbhHIJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628501274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfHPU67LehHq+MTe5KfOuH7Zeo3DrK09eoCaVDcP8j8=;
        b=ZpU5AUZX/HBBKIvj+cJQift4yZxAADezJ60Ly7rIQ1xpbrWZ3p7utBOk0EKNKF7zfyMCVv
        7kpcxTjN6sDXlb7OXk9n6hYMt5E9M5sLrDfmUsY6z1ElyWV5XyoksVGXt0a42ORZpnTut7
        jpOfTOFz2a7y+jpxWqwYx08oybPrBTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-FTC-c1AANfKfTCjZZ85luA-1; Mon, 09 Aug 2021 05:27:53 -0400
X-MC-Unique: FTC-c1AANfKfTCjZZ85luA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6013DF8A3;
        Mon,  9 Aug 2021 09:27:51 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-155.bne.redhat.com [10.64.54.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EAB15D6AD;
        Mon,  9 Aug 2021 09:27:45 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, vgupta@synopsys.com, akpm@linux-foundation.org,
        chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v6 06/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in migration and thp tests
Date:   Mon,  9 Aug 2021 17:26:25 +0800
Message-Id: <20210809092631.1888748-7-gshan@redhat.com>
In-Reply-To: <20210809092631.1888748-1-gshan@redhat.com>
References: <20210809092631.1888748-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in the migration and thp test
functions. It's notable that the pre-allocated page is used in
swap_migration_tests() as set_pte_at() is used there.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 849081a2099d..6df86555b191 100644
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
@@ -853,19 +853,18 @@ static void __init swap_migration_tests(void)
 	if (!IS_ENABLED(CONFIG_MIGRATION))
 		return;
 
-	pr_debug("Validating swap migration\n");
 	/*
 	 * swap_migration_tests() requires a dedicated page as it needs to
 	 * be locked before creating a migration entry from it. Locking the
 	 * page that actually maps kernel text ('start_kernel') can be real
-	 * problematic. Lets allocate a dedicated page explicitly for this
-	 * purpose that will be freed subsequently.
+	 * problematic. Lets use the allocated page explicitly for this
+	 * purpose.
 	 */
-	page = alloc_page(GFP_KERNEL);
-	if (!page) {
-		pr_err("page allocation failed\n");
+	page = (args->pte_pfn != ULONG_MAX) ? pfn_to_page(args->pte_pfn) : NULL;
+	if (!page)
 		return;
-	}
+
+	pr_debug("Validating swap migration\n");
 
 	/*
 	 * make_migration_entry() expects given page to be
@@ -884,7 +883,6 @@ static void __init swap_migration_tests(void)
 	WARN_ON(!is_migration_entry(swp));
 	WARN_ON(is_writable_migration_entry(swp));
 	__ClearPageLocked(page);
-	__free_page(page);
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -916,7 +914,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_thp_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -935,7 +933,7 @@ static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
 	 * needs to return true. pmd_present() should be true whenever
 	 * pmd_trans_huge() returns true.
 	 */
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
 	WARN_ON(!pmd_trans_huge(pmd_mkhuge(pmd)));
 
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
@@ -945,7 +943,7 @@ static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
+static void __init pud_thp_tests(struct pgtable_debug_args *args)
 {
 	pud_t pud;
 
@@ -953,7 +951,7 @@ static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PUD based THP\n");
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(args->fixed_pud_pfn, args->page_prot);
 	WARN_ON(!pud_trans_huge(pud_mkhuge(pud)));
 
 	/*
@@ -965,11 +963,11 @@ static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
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
@@ -1335,10 +1333,10 @@ static int __init debug_vm_pgtable(void)
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

