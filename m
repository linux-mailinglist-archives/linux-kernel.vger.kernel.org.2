Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9F73BC666
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhGFGV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhGFGVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625552326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qHjYf26nDQF8IxrBuohCHfhS/U3Bnml2w07ftwA7X+w=;
        b=CaYmMvDYZwKPPIRq8fpqNNVBynOop5X4cX2pF+sahiGj4KO0fuQvg5zVqWsOVeorOwhfZ5
        1LZa8ek94dOGsvFNh21gEDdVpzygARHerzBLsTIXl8mLKIpJywq9uvLuO8OHSbnjp0hTx3
        hGQBHKvygLm5mFdMQToL+mfDMPpBFPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-Eo_T1f37OX6II2fr5ElcwA-1; Tue, 06 Jul 2021 02:18:45 -0400
X-MC-Unique: Eo_T1f37OX6II2fr5ElcwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73ECD100CEC0;
        Tue,  6 Jul 2021 06:18:44 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7399060583;
        Tue,  6 Jul 2021 06:18:41 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com, chuhu@redhat.com
Subject: [PATCH 12/12] mm/debug_vm_pgtable: Fix corrupted page flag
Date:   Tue,  6 Jul 2021 14:17:48 +0800
Message-Id: <20210706061748.161258-13-gshan@redhat.com>
In-Reply-To: <20210706061748.161258-1-gshan@redhat.com>
References: <20210706061748.161258-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In page table entry modifying tests, set_{pud, pmd, pte}_at() are
used to populate the page table entries. On ARM64, PG_arch_1 is
set to the target page flag if execution permission is given. The
page flag is kept when the page is free'd to buddy's free area
list. However, it will trigger page checking failure when it's
pulled from the buddy's free area list, as the following warning
messages indicate.

   BUG: Bad page state in process memhog  pfn:08000
   page:0000000015c0a628 refcount:0 mapcount:0 \
        mapping:0000000000000000 index:0x1 pfn:0x8000
   flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
   raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
   raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
   page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set

This fixes the issue by clearing PG_arch_1 through flush_dcache_page(),
right after set_{pud, pmd, pte}_at() is called.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1fd6d73d2152..de6f99382b4b 100644
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
 
@@ -110,6 +112,7 @@ static void __init pte_basic_tests(struct vm_pgtable_debug *debug, int idx)
 
 static void __init pte_advanced_tests(struct vm_pgtable_debug *debug)
 {
+	struct page *page;
 	pte_t pte;
 
 	/*
@@ -119,13 +122,17 @@ static void __init pte_advanced_tests(struct vm_pgtable_debug *debug)
 	 */
 
 	pr_debug("Validating PTE advanced\n");
-	if (debug->pte_pfn == ULONG_MAX) {
+
+	page = (debug->pte_pfn != ULONG_MAX) ?
+	       pfn_to_page(debug->pte_pfn) : NULL;
+	if (!page) {
 		pr_debug("%s: Skipped\n", __func__);
 		return;
 	}
 
 	pte = pfn_pte(debug->pte_pfn, debug->page_prot);
 	set_pte_at(debug->mm, debug->vaddr, debug->ptep, pte);
+	flush_dcache_page(page);
 	ptep_set_wrprotect(debug->mm, debug->vaddr, debug->ptep);
 	pte = ptep_get(debug->ptep);
 	WARN_ON(pte_write(pte));
@@ -137,6 +144,7 @@ static void __init pte_advanced_tests(struct vm_pgtable_debug *debug)
 	pte = pte_wrprotect(pte);
 	pte = pte_mkclean(pte);
 	set_pte_at(debug->mm, debug->vaddr, debug->ptep, pte);
+	flush_dcache_page(page);
 	pte = pte_mkwrite(pte);
 	pte = pte_mkdirty(pte);
 	ptep_set_access_flags(debug->vma, debug->vaddr, debug->ptep, pte, 1);
@@ -149,6 +157,7 @@ static void __init pte_advanced_tests(struct vm_pgtable_debug *debug)
 	pte = pfn_pte(debug->pte_pfn, debug->page_prot);
 	pte = pte_mkyoung(pte);
 	set_pte_at(debug->mm, debug->vaddr, debug->ptep, pte);
+	flush_dcache_page(page);
 	ptep_test_and_clear_young(debug->vma, debug->vaddr, debug->ptep);
 	pte = ptep_get(debug->ptep);
 	WARN_ON(pte_young(pte));
@@ -207,6 +216,7 @@ static void __init pmd_basic_tests(struct vm_pgtable_debug *debug, int idx)
 
 static void __init pmd_advanced_tests(struct vm_pgtable_debug *debug)
 {
+	struct page *page;
 	pmd_t pmd;
 	unsigned long vaddr = (debug->vaddr & HPAGE_PMD_MASK);
 
@@ -214,7 +224,10 @@ static void __init pmd_advanced_tests(struct vm_pgtable_debug *debug)
 		return;
 
 	pr_debug("Validating PMD advanced\n");
-	if (debug->pmd_pfn == ULONG_MAX) {
+
+	page = (debug->pmd_pfn != ULONG_MAX) ?
+	       pfn_to_page(debug->pmd_pfn) : NULL;
+	if (!page) {
 		pr_debug("%s: Skipped\n", __func__);
 		return;
 	}
@@ -223,6 +236,7 @@ static void __init pmd_advanced_tests(struct vm_pgtable_debug *debug)
 
 	pmd = pfn_pmd(debug->pmd_pfn, debug->page_prot);
 	set_pmd_at(debug->mm, vaddr, debug->pmdp, pmd);
+	flush_dcache_page(page);
 	pmdp_set_wrprotect(debug->mm, vaddr, debug->pmdp);
 	pmd = READ_ONCE(*(debug->pmdp));
 	WARN_ON(pmd_write(pmd));
@@ -234,6 +248,7 @@ static void __init pmd_advanced_tests(struct vm_pgtable_debug *debug)
 	pmd = pmd_wrprotect(pmd);
 	pmd = pmd_mkclean(pmd);
 	set_pmd_at(debug->mm, vaddr, debug->pmdp, pmd);
+	flush_dcache_page(page);
 	pmd = pmd_mkwrite(pmd);
 	pmd = pmd_mkdirty(pmd);
 	pmdp_set_access_flags(debug->vma, vaddr, debug->pmdp, pmd, 1);
@@ -246,6 +261,7 @@ static void __init pmd_advanced_tests(struct vm_pgtable_debug *debug)
 	pmd = pmd_mkhuge(pfn_pmd(debug->pmd_pfn, debug->page_prot));
 	pmd = pmd_mkyoung(pmd);
 	set_pmd_at(debug->mm, vaddr, debug->pmdp, pmd);
+	flush_dcache_page(page);
 	pmdp_test_and_clear_young(debug->vma, vaddr, debug->pmdp);
 	pmd = READ_ONCE(*(debug->pmdp));
 	WARN_ON(pmd_young(pmd));
@@ -332,6 +348,7 @@ static void __init pud_basic_tests(struct vm_pgtable_debug *debug, int idx)
 
 static void __init pud_advanced_tests(struct vm_pgtable_debug *debug)
 {
+	struct page *page;
 	unsigned long vaddr = (debug->vaddr & HPAGE_PUD_MASK);
 	pud_t pud;
 
@@ -339,13 +356,17 @@ static void __init pud_advanced_tests(struct vm_pgtable_debug *debug)
 		return;
 
 	pr_debug("Validating PUD advanced\n");
-	if (debug->pud_pfn == ULONG_MAX) {
+
+	page = (debug->pud_pfn != ULONG_MAX) ?
+	       pfn_to_page(debug->pud_pfn) : NULL;
+	if (!page) {
 		pr_debug("%s: Skipped\n", __func__);
 		return;
 	}
 
 	pud = pfn_pud(debug->pud_pfn, debug->page_prot);
 	set_pud_at(debug->mm, vaddr, debug->pudp, pud);
+	flush_dcache_page(page);
 	pudp_set_wrprotect(debug->mm, vaddr, debug->pudp);
 	pud = READ_ONCE(*(debug->pudp));
 	WARN_ON(pud_write(pud));
@@ -359,6 +380,7 @@ static void __init pud_advanced_tests(struct vm_pgtable_debug *debug)
 	pud = pud_wrprotect(pud);
 	pud = pud_mkclean(pud);
 	set_pud_at(debug->mm, vaddr, debug->pudp, pud);
+	flush_dcache_page(page);
 	pud = pud_mkwrite(pud);
 	pud = pud_mkdirty(pud);
 	pudp_set_access_flags(debug->vma, vaddr, debug->pudp, pud, 1);
@@ -374,6 +396,7 @@ static void __init pud_advanced_tests(struct vm_pgtable_debug *debug)
 	pud = pfn_pud(debug->pud_pfn, debug->page_prot);
 	pud = pud_mkyoung(pud);
 	set_pud_at(debug->mm, vaddr, debug->pudp, pud);
+	flush_dcache_page(page);
 	pudp_test_and_clear_young(debug->vma, vaddr, debug->pudp);
 	pud = READ_ONCE(*(debug->pudp));
 	WARN_ON(pud_young(pud));
@@ -588,10 +611,14 @@ static void __init pgd_populate_tests(struct vm_pgtable_debug *debug) { }
 
 static void __init pte_clear_tests(struct vm_pgtable_debug *debug)
 {
+	struct page *page;
 	pte_t pte;
 
 	pr_debug("Validating PTE clear\n");
-	if (debug->pte_pfn == ULONG_MAX) {
+
+	page = (debug->pte_pfn != ULONG_MAX) ?
+	       pfn_to_page(debug->pte_pfn) : NULL;
+	if (!page) {
 		pr_debug("%s: Skipped\n", __func__);
 		return;
 	}
@@ -601,6 +628,7 @@ static void __init pte_clear_tests(struct vm_pgtable_debug *debug)
 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
 #endif
 	set_pte_at(debug->mm, debug->vaddr, debug->ptep, pte);
+	flush_dcache_page(page);
 	barrier();
 	pte_clear(debug->mm, debug->vaddr, debug->ptep);
 	pte = ptep_get(debug->ptep);
-- 
2.23.0

