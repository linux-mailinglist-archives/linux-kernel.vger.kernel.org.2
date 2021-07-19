Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC09C3CCD8E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhGSFpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234471AbhGSFpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626673332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAAT3twkm8kFqvCnOeL174l1uYZhnlNo8Vm+dCqjiME=;
        b=hjYibXT5k3woqMf2NiI2RWBo0JIJh8iEFOfzmFAQOBSJUju+8mM2CyonEfkECu9akbDzkj
        O1Q/mC/KFIeDG07sFKtoNrmllJZKMXev4VNEGEihYHYWsGrQvWsJBM3rcexA2bWsgNUxs2
        yKzPKmf3WTAUwcEsctbI2WG+bs154NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-0ZvH-gkJMh2En1xhjQaBYg-1; Mon, 19 Jul 2021 01:42:11 -0400
X-MC-Unique: 0ZvH-gkJMh2En1xhjQaBYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A77C362F8;
        Mon, 19 Jul 2021 05:42:09 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50BB2369A;
        Mon, 19 Jul 2021 05:42:06 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 12/12] mm/debug_vm_pgtable: Fix corrupted page flag
Date:   Mon, 19 Jul 2021 13:41:38 +0800
Message-Id: <20210719054138.198373-13-gshan@redhat.com>
In-Reply-To: <20210719054138.198373-1-gshan@redhat.com>
References: <20210719054138.198373-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In page table entry modifying tests, set_xxx_at() are used to populate
the page table entries. On ARM64, PG_arch_1 is set to the target page
flag if execution permission is given. The page flag is kept when the
page is free'd to buddy's free area list. However, it will trigger page
checking failure when it's pulled from the buddy's free area list, as
the following warning messages indicate.

   BUG: Bad page state in process memhog  pfn:08000
   page:0000000015c0a628 refcount:0 mapcount:0 \
        mapping:0000000000000000 index:0x1 pfn:0x8000
   flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
   raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
   raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
   page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set

This fixes the issue by clearing PG_arch_1 through flush_dcache_page()
after set_xxx_at() is called.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 162a12c10aa8..926d5a78f8c7 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -29,6 +29,8 @@
 #include <linux/start_kernel.h>
 #include <linux/sched/mm.h>
 #include <linux/io.h>
+
+#include <asm/cacheflush.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
@@ -118,6 +120,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 
 static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 {
+	struct page *page;
 	pte_t pte;
 
 	/*
@@ -127,13 +130,16 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 	 */
 
 	pr_debug("Validating PTE advanced\n");
-	if (args->pte_pfn == ULONG_MAX) {
+	page = (args->pte_pfn != ULONG_MAX) ?
+	       pfn_to_page(args->pte_pfn) : NULL;
+	if (!page) {
 		pr_debug("%s: Skipped\n", __func__);
 		return;
 	}
 
 	pte = pfn_pte(args->pte_pfn, args->page_prot);
 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
+	flush_dcache_page(page);
 	ptep_set_wrprotect(args->mm, args->vaddr, args->ptep);
 	pte = ptep_get(args->ptep);
 	WARN_ON(pte_write(pte));
@@ -145,6 +151,7 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 	pte = pte_wrprotect(pte);
 	pte = pte_mkclean(pte);
 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
+	flush_dcache_page(page);
 	pte = pte_mkwrite(pte);
 	pte = pte_mkdirty(pte);
 	ptep_set_access_flags(args->vma, args->vaddr, args->ptep, pte, 1);
@@ -157,6 +164,7 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 	pte = pfn_pte(args->pte_pfn, args->page_prot);
 	pte = pte_mkyoung(pte);
 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
+	flush_dcache_page(page);
 	ptep_test_and_clear_young(args->vma, args->vaddr, args->ptep);
 	pte = ptep_get(args->ptep);
 	WARN_ON(pte_young(pte));
@@ -215,6 +223,7 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 
 static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 {
+	struct page *page;
 	pmd_t pmd;
 	unsigned long vaddr = (args->vaddr & HPAGE_PMD_MASK);
 
@@ -222,7 +231,9 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PMD advanced\n");
-	if (args->pmd_pfn == ULONG_MAX) {
+	page = (args->pmd_pfn != ULONG_MAX) ?
+	       pfn_to_page(args->pmd_pfn) : NULL;
+	if (!page) {
 		pr_debug("%s: Skipped\n", __func__);
 		return;
 	}
@@ -231,6 +242,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 
 	pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
 	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
+	flush_dcache_page(page);
 	pmdp_set_wrprotect(args->mm, vaddr, args->pmdp);
 	pmd = READ_ONCE(*(args->pmdp));
 	WARN_ON(pmd_write(pmd));
@@ -242,6 +254,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 	pmd = pmd_wrprotect(pmd);
 	pmd = pmd_mkclean(pmd);
 	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
+	flush_dcache_page(page);
 	pmd = pmd_mkwrite(pmd);
 	pmd = pmd_mkdirty(pmd);
 	pmdp_set_access_flags(args->vma, vaddr, args->pmdp, pmd, 1);
@@ -254,6 +267,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 	pmd = pmd_mkhuge(pfn_pmd(args->pmd_pfn, args->page_prot));
 	pmd = pmd_mkyoung(pmd);
 	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
+	flush_dcache_page(page);
 	pmdp_test_and_clear_young(args->vma, vaddr, args->pmdp);
 	pmd = READ_ONCE(*(args->pmdp));
 	WARN_ON(pmd_young(pmd));
@@ -340,6 +354,7 @@ static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
 
 static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 {
+	struct page *page;
 	unsigned long vaddr = (args->vaddr & HPAGE_PUD_MASK);
 	pud_t pud;
 
@@ -347,13 +362,16 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PUD advanced\n");
-	if (args->pud_pfn == ULONG_MAX) {
+	page = (args->pud_pfn != ULONG_MAX) ?
+	       pfn_to_page(args->pud_pfn) : NULL;
+	if (!page) {
 		pr_debug("%s: Skipped\n", __func__);
 		return;
 	}
 
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
+	flush_dcache_page(page);
 	pudp_set_wrprotect(args->mm, vaddr, args->pudp);
 	pud = READ_ONCE(*(args->pudp));
 	WARN_ON(pud_write(pud));
@@ -367,6 +385,7 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	pud = pud_wrprotect(pud);
 	pud = pud_mkclean(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
+	flush_dcache_page(page);
 	pud = pud_mkwrite(pud);
 	pud = pud_mkdirty(pud);
 	pudp_set_access_flags(args->vma, vaddr, args->pudp, pud, 1);
@@ -382,6 +401,7 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
 	pud = pud_mkyoung(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
+	flush_dcache_page(page);
 	pudp_test_and_clear_young(args->vma, vaddr, args->pudp);
 	pud = READ_ONCE(*(args->pudp));
 	WARN_ON(pud_young(pud));
@@ -595,10 +615,13 @@ static void __init pgd_populate_tests(struct pgtable_debug_args *args) { }
 
 static void __init pte_clear_tests(struct pgtable_debug_args *args)
 {
+	struct page *page;
 	pte_t pte;
 
 	pr_debug("Validating PTE clear\n");
-	if (args->pte_pfn == ULONG_MAX) {
+	page = (args->pte_pfn != ULONG_MAX) ?
+	       pfn_to_page(args->pte_pfn) : NULL;
+	if (!page) {
 		pr_debug("%s: Skipped\n", __func__);
 		return;
 	}
@@ -608,6 +631,7 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
 #endif
 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
+	flush_dcache_page(page);
 	barrier();
 	pte_clear(args->mm, args->vaddr, args->ptep);
 	pte = ptep_get(args->ptep);
-- 
2.23.0

