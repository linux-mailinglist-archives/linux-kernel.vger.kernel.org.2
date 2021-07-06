Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5353BC65E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhGFGVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230138AbhGFGVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625552304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2fHwz8f+R11Ghnan8DHffCQMDEr89Mbu17MGhyW0ZQ=;
        b=FuC1tWvqt46OVxttkqzegOlqIkGjBcq+5xkiVAZh0CBrndM7ivRFchCd0CaMZDuBqgnpqu
        00cprU0pD3bjTWyb1ukMPb0ziViLo9t2OjCJYjJT/SCfqpuACBTDrltkagP+571Ai/lDUJ
        ctvKGpsKTdsfxrtBnBGngI7rhI+Lu1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-nLFyZ7y_PlKbdhtAOMivIw-1; Tue, 06 Jul 2021 02:18:20 -0400
X-MC-Unique: nLFyZ7y_PlKbdhtAOMivIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71D95804302;
        Tue,  6 Jul 2021 06:18:19 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C5E560583;
        Tue,  6 Jul 2021 06:18:15 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com, chuhu@redhat.com
Subject: [PATCH 04/12] mm/debug_vm_pgtable: Use struct vm_pgtable_debug in protnone and devmap tests
Date:   Tue,  6 Jul 2021 14:17:40 +0800
Message-Id: <20210706061748.161258-5-gshan@redhat.com>
In-Reply-To: <20210706061748.161258-1-gshan@redhat.com>
References: <20210706061748.161258-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct vm_pgtable_debug in protnone and devmap test
functions.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 00ddce30c6ca..cfb3dfb0447e 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -661,9 +661,9 @@ static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
 	WARN_ON(pmd_bad(pmd));
 }
 
-static void __init pte_special_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_special_tests(struct vm_pgtable_debug *debug)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(debug->fixed_pte_pfn, debug->page_prot);
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL))
 		return;
@@ -672,9 +672,9 @@ static void __init pte_special_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pte_special(pte_mkspecial(pte)));
 }
 
-static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_protnone_tests(struct vm_pgtable_debug *debug)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(debug->fixed_pte_pfn, debug->page_prot_none);
 
 	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
 		return;
@@ -685,7 +685,7 @@ static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_protnone_tests(struct vm_pgtable_debug *debug)
 {
 	pmd_t pmd;
 
@@ -696,25 +696,25 @@ static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD protnone\n");
-	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
+	pmd = pmd_mkhuge(pfn_pmd(debug->fixed_pmd_pfn, debug->page_prot_none));
 	WARN_ON(!pmd_protnone(pmd));
 	WARN_ON(!pmd_present(pmd));
 }
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_protnone_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_devmap_tests(struct vm_pgtable_debug *debug)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(debug->fixed_pte_pfn, debug->page_prot);
 
 	pr_debug("Validating PTE devmap\n");
 	WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_devmap_tests(struct vm_pgtable_debug *debug)
 {
 	pmd_t pmd;
 
@@ -722,12 +722,12 @@ static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD devmap\n");
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(debug->fixed_pmd_pfn, debug->page_prot);
 	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
+static void __init pud_devmap_tests(struct vm_pgtable_debug *debug)
 {
 	pud_t pud;
 
@@ -735,20 +735,20 @@ static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PUD devmap\n");
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(debug->fixed_pud_pfn, debug->page_prot);
 	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
 }
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_devmap_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_devmap_tests(struct vm_pgtable_debug *debug) { }
+static void __init pud_devmap_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #else
-static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pte_devmap_tests(struct vm_pgtable_debug *debug) { }
+static void __init pmd_devmap_tests(struct vm_pgtable_debug *debug) { }
+static void __init pud_devmap_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
 
 static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
@@ -1270,13 +1270,13 @@ static int __init debug_vm_pgtable(void)
 	pte_savedwrite_tests(&debug);
 	pmd_savedwrite_tests(&debug);
 
-	pte_special_tests(pte_aligned, prot);
-	pte_protnone_tests(pte_aligned, protnone);
-	pmd_protnone_tests(pmd_aligned, protnone);
+	pte_special_tests(&debug);
+	pte_protnone_tests(&debug);
+	pmd_protnone_tests(&debug);
 
-	pte_devmap_tests(pte_aligned, prot);
-	pmd_devmap_tests(pmd_aligned, prot);
-	pud_devmap_tests(pud_aligned, prot);
+	pte_devmap_tests(&debug);
+	pmd_devmap_tests(&debug);
+	pud_devmap_tests(&debug);
 
 	pte_soft_dirty_tests(pte_aligned, prot);
 	pmd_soft_dirty_tests(pmd_aligned, prot);
-- 
2.23.0

