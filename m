Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80B53CD581
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbhGSM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237210AbhGSM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626700061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7lAPaaXaAURk3R5/V6PSwC0JP8Tg4zF/Tm2ncfNDrI=;
        b=MnfTvQwJuXY2QeC6lYaRZAM+SlE4GXO24yqEPHwPHEvBG0COmThflGVacS5ON2+bL8Bnnt
        JqOPOgp+fLvtXzUvd2HKzk6UilldpkzEWi50+HQ3GUAVzlWckZU10KmhEVUzdEwfVYIEgc
        iSVvb2p4uH1D0Y/CXD90980ldALqDOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-v41SdsklPnuHSSjRUFiaVA-1; Mon, 19 Jul 2021 09:07:40 -0400
X-MC-Unique: v41SdsklPnuHSSjRUFiaVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CF32802E61;
        Mon, 19 Jul 2021 13:07:39 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 618635D6A1;
        Mon, 19 Jul 2021 13:07:33 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 05/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in soft_dirty and swap tests
Date:   Mon, 19 Jul 2021 21:06:06 +0800
Message-Id: <20210719130613.334901-6-gshan@redhat.com>
In-Reply-To: <20210719130613.334901-1-gshan@redhat.com>
References: <20210719130613.334901-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in the soft_dirty and swap test
functions.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1ae204831484..a20ed77bf05f 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -751,9 +751,9 @@ static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
 static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
 
-static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
 
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
@@ -763,9 +763,9 @@ static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(pte_soft_dirty(pte_clear_soft_dirty(pte)));
 }
 
-static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
 
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
@@ -776,7 +776,7 @@ static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -787,12 +787,12 @@ static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD soft dirty\n");
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
 	WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
 	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
 }
 
-static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -804,31 +804,29 @@ static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD swap soft dirty\n");
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
 	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
 	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
 }
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
-{
-}
+static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args) { }
+static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_swap_tests(struct pgtable_debug_args *args)
 {
 	swp_entry_t swp;
 	pte_t pte;
 
 	pr_debug("Validating PTE swap\n");
-	pte = pfn_pte(pfn, prot);
+	pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
 	swp = __pte_to_swp_entry(pte);
 	pte = __swp_entry_to_pte(swp);
-	WARN_ON(pfn != pte_pfn(pte));
+	WARN_ON(args->fixed_pte_pfn != pte_pfn(pte));
 }
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_swap_tests(struct pgtable_debug_args *args)
 {
 	swp_entry_t swp;
 	pmd_t pmd;
@@ -837,13 +835,13 @@ static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD swap\n");
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
 	swp = __pmd_to_swp_entry(pmd);
 	pmd = __swp_entry_to_pmd(swp);
-	WARN_ON(pfn != pmd_pfn(pmd));
+	WARN_ON(args->fixed_pmd_pfn != pmd_pfn(pmd));
 }
 #else  /* !CONFIG_ARCH_ENABLE_THP_MIGRATION */
-static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_swap_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
 static void __init swap_migration_tests(void)
@@ -1257,13 +1255,13 @@ static int __init debug_vm_pgtable(void)
 	pmd_devmap_tests(&args);
 	pud_devmap_tests(&args);
 
-	pte_soft_dirty_tests(pte_aligned, prot);
-	pmd_soft_dirty_tests(pmd_aligned, prot);
-	pte_swap_soft_dirty_tests(pte_aligned, prot);
-	pmd_swap_soft_dirty_tests(pmd_aligned, prot);
+	pte_soft_dirty_tests(&args);
+	pmd_soft_dirty_tests(&args);
+	pte_swap_soft_dirty_tests(&args);
+	pmd_swap_soft_dirty_tests(&args);
 
-	pte_swap_tests(pte_aligned, prot);
-	pmd_swap_tests(pmd_aligned, prot);
+	pte_swap_tests(&args);
+	pmd_swap_tests(&args);
 
 	swap_migration_tests();
 
-- 
2.23.0

