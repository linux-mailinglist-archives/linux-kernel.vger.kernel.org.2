Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617F73CD57F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbhGSM0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237210AbhGSM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626700052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENNkXGIRYiDy/ru5M0r9qIB4A7/qO5NMOK2fcC8ZYn8=;
        b=GHu7OKNd/O30uy2iWVy3I53PAx9WaHHKx92nY3+kzxSRDQIwpJdtNgZkl75AM3MPP/4hN6
        m2i70nNYq/XUsa8UMJowN8h7aBA1PanFLFHSNhc48utpesIApTBf54IX3iAfvhbk8d5JZP
        zDGK1lIFtXCjktB6nrMXzMdmeF7cFbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-qmRyHMRbMZGR8RWVb9qYvQ-1; Mon, 19 Jul 2021 09:07:30 -0400
X-MC-Unique: qmRyHMRbMZGR8RWVb9qYvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A3B636392;
        Mon, 19 Jul 2021 13:07:29 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A00205D6CF;
        Mon, 19 Jul 2021 13:07:26 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 03/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in leaf and savewrite tests
Date:   Mon, 19 Jul 2021 21:06:04 +0800
Message-Id: <20210719130613.334901-4-gshan@redhat.com>
In-Reply-To: <20210719130613.334901-1-gshan@redhat.com>
References: <20210719130613.334901-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in the leaf and savewrite test
functions.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 5f79d725f8d8..b4b33afae942 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -160,9 +160,9 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
 	WARN_ON(pte_young(pte));
 }
 
-static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_savedwrite_tests(struct pgtable_debug_args *args)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot_none);
 
 	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
 		return;
@@ -261,7 +261,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
 	pgtable = pgtable_trans_huge_withdraw(mm, pmdp);
 }
 
-static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_leaf_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -269,7 +269,7 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD leaf\n");
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
 
 	/*
 	 * PMD based THP is a leaf entry.
@@ -278,7 +278,7 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pmd_leaf(pmd));
 }
 
-static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -289,7 +289,7 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD saved write\n");
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot_none);
 	WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
 	WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
 }
@@ -387,7 +387,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 	pudp_huge_get_and_clear(mm, vaddr, pudp);
 }
 
-static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
+static void __init pud_leaf_tests(struct pgtable_debug_args *args)
 {
 	pud_t pud;
 
@@ -395,7 +395,7 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PUD leaf\n");
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(args->fixed_pud_pfn, args->page_prot);
 	/*
 	 * PUD based THP is a leaf entry.
 	 */
@@ -410,7 +410,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 				      pgprot_t prot)
 {
 }
-static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_leaf_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
 static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx) { }
@@ -427,9 +427,9 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 				      pgprot_t prot)
 {
 }
-static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_leaf_tests(struct pgtable_debug_args *args) { }
+static void __init pud_leaf_tests(struct pgtable_debug_args *args) { }
+static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
@@ -1249,11 +1249,11 @@ static int __init debug_vm_pgtable(void)
 	pgd_basic_tests();
 	hugetlb_basic_tests(&args);
 
-	pmd_leaf_tests(pmd_aligned, prot);
-	pud_leaf_tests(pud_aligned, prot);
+	pmd_leaf_tests(&args);
+	pud_leaf_tests(&args);
 
-	pte_savedwrite_tests(pte_aligned, protnone);
-	pmd_savedwrite_tests(pmd_aligned, protnone);
+	pte_savedwrite_tests(&args);
+	pmd_savedwrite_tests(&args);
 
 	pte_special_tests(pte_aligned, prot);
 	pte_protnone_tests(pte_aligned, protnone);
-- 
2.23.0

