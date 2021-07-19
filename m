Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC13CD580
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbhGSM05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237210AbhGSM04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626700055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8STkjFvB9HMKry+BzIxuWMd76072UKDSlZGe+F8TAo=;
        b=af+pE9Na/RSgum/bu3cVUgTF/oVFIhEISVExogou14PzGKJEFaxlqvGwWAUsMREug1vs+d
        D0yFmfoQHncqVRXhTjZ5KWU12xzzsv3UFmF2dGcv4kVPI4EVtnV9TYwzPfLkG/fdZZSyaZ
        sIjSW5z2ZNCfLbI7pEWFP61nF4+dr5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-28hAG4RWPeax5zVAOZpI4g-1; Mon, 19 Jul 2021 09:07:34 -0400
X-MC-Unique: 28hAG4RWPeax5zVAOZpI4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 028AF1084F40;
        Mon, 19 Jul 2021 13:07:33 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7F915D6A1;
        Mon, 19 Jul 2021 13:07:29 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 04/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in protnone and devmap tests
Date:   Mon, 19 Jul 2021 21:06:05 +0800
Message-Id: <20210719130613.334901-5-gshan@redhat.com>
In-Reply-To: <20210719130613.334901-1-gshan@redhat.com>
References: <20210719130613.334901-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in protnone and devmap test
functions. After that, the unused variable @protnone in debug_vm_pgtable()
is dropped.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 58 +++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index b4b33afae942..1ae204831484 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -661,9 +661,9 @@ static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
 	WARN_ON(pmd_bad(pmd));
 }
 
-static void __init pte_special_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_special_tests(struct pgtable_debug_args *args)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL))
 		return;
@@ -672,9 +672,9 @@ static void __init pte_special_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pte_special(pte_mkspecial(pte)));
 }
 
-static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_protnone_tests(struct pgtable_debug_args *args)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot_none);
 
 	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
 		return;
@@ -685,7 +685,7 @@ static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_protnone_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -696,25 +696,25 @@ static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD protnone\n");
-	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
+	pmd = pmd_mkhuge(pfn_pmd(args->fixed_pmd_pfn, args->page_prot_none));
 	WARN_ON(!pmd_protnone(pmd));
 	WARN_ON(!pmd_present(pmd));
 }
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_protnone_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_devmap_tests(struct pgtable_debug_args *args)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
 
 	pr_debug("Validating PTE devmap\n");
 	WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_devmap_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -722,12 +722,12 @@ static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD devmap\n");
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
 	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
+static void __init pud_devmap_tests(struct pgtable_debug_args *args)
 {
 	pud_t pud;
 
@@ -735,20 +735,20 @@ static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PUD devmap\n");
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(args->fixed_pud_pfn, args->page_prot);
 	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
 }
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
+static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #else
-static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pte_devmap_tests(struct pgtable_debug_args *args) { }
+static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
+static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
 
 static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
@@ -1154,7 +1154,7 @@ static int __init debug_vm_pgtable(void)
 	pmd_t *pmdp, *saved_pmdp, pmd;
 	pte_t *ptep;
 	pgtable_t saved_ptep;
-	pgprot_t prot, protnone;
+	pgprot_t prot;
 	phys_addr_t paddr;
 	unsigned long vaddr, pte_aligned, pmd_aligned;
 	unsigned long pud_aligned;
@@ -1174,12 +1174,6 @@ static int __init debug_vm_pgtable(void)
 		return 1;
 	}
 
-	/*
-	 * __P000 (or even __S000) will help create page table entries with
-	 * PROT_NONE permission as required for pxx_protnone_tests().
-	 */
-	protnone = __P000;
-
 	vma = vm_area_alloc(mm);
 	if (!vma) {
 		pr_err("vma allocation failed\n");
@@ -1255,13 +1249,13 @@ static int __init debug_vm_pgtable(void)
 	pte_savedwrite_tests(&args);
 	pmd_savedwrite_tests(&args);
 
-	pte_special_tests(pte_aligned, prot);
-	pte_protnone_tests(pte_aligned, protnone);
-	pmd_protnone_tests(pmd_aligned, protnone);
+	pte_special_tests(&args);
+	pte_protnone_tests(&args);
+	pmd_protnone_tests(&args);
 
-	pte_devmap_tests(pte_aligned, prot);
-	pmd_devmap_tests(pmd_aligned, prot);
-	pud_devmap_tests(pud_aligned, prot);
+	pte_devmap_tests(&args);
+	pmd_devmap_tests(&args);
+	pud_devmap_tests(&args);
 
 	pte_soft_dirty_tests(pte_aligned, prot);
 	pmd_soft_dirty_tests(pmd_aligned, prot);
-- 
2.23.0

