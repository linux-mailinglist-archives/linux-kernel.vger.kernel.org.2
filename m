Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6784C3BC65F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhGFGVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230180AbhGFGVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625552304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fCFBqkpZgP/Z0/ZzWRbd+xN5AltcaGMWwLkPEJqMw/8=;
        b=e7GW83fvzFWRSgiahkS7lDfleqb7Q+apBARrlZcXbUFU9glYrUlQe2W89s/Zl6ZyapYR5T
        hMgoJ3DYR2hb6fP/DpbGzIGGzbqtIZXQP7/knt+rV/0owm3C7oHpnQsokGTYpDpTTYHTnN
        w5oPidnfy7C+7Dpa5Qbxc6HaxmJiYII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-1EuPmPaHOQCEGyRXK4qKzw-1; Tue, 06 Jul 2021 02:18:23 -0400
X-MC-Unique: 1EuPmPaHOQCEGyRXK4qKzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15B22800D62;
        Tue,  6 Jul 2021 06:18:22 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B56A60583;
        Tue,  6 Jul 2021 06:18:19 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com, chuhu@redhat.com
Subject: [PATCH 05/12] mm/vm_debug_pgtable: Use struct vm_pgtable_debug in soft_dirty and swap tests
Date:   Tue,  6 Jul 2021 14:17:41 +0800
Message-Id: <20210706061748.161258-6-gshan@redhat.com>
In-Reply-To: <20210706061748.161258-1-gshan@redhat.com>
References: <20210706061748.161258-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct vm_pgtable_debug in the soft_dirty and swap test
functions.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index cfb3dfb0447e..eb0a836a73ad 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -751,9 +751,9 @@ static void __init pmd_devmap_tests(struct vm_pgtable_debug *debug) { }
 static void __init pud_devmap_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
 
-static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_soft_dirty_tests(struct vm_pgtable_debug *debug)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(debug->fixed_pte_pfn, debug->page_prot);
 
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
@@ -763,9 +763,9 @@ static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(pte_soft_dirty(pte_clear_soft_dirty(pte)));
 }
 
-static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_swap_soft_dirty_tests(struct vm_pgtable_debug *debug)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(debug->fixed_pte_pfn, debug->page_prot);
 
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
@@ -776,7 +776,7 @@ static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_soft_dirty_tests(struct vm_pgtable_debug *debug)
 {
 	pmd_t pmd;
 
@@ -787,12 +787,12 @@ static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD soft dirty\n");
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(debug->fixed_pmd_pfn, debug->page_prot);
 	WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
 	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
 }
 
-static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_swap_soft_dirty_tests(struct vm_pgtable_debug *debug)
 {
 	pmd_t pmd;
 
@@ -804,31 +804,29 @@ static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD swap soft dirty\n");
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(debug->fixed_pmd_pfn, debug->page_prot);
 	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
 	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
 }
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
-{
-}
+static void __init pmd_soft_dirty_tests(struct vm_pgtable_debug *debug) { }
+static void __init pmd_swap_soft_dirty_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_swap_tests(struct vm_pgtable_debug *debug)
 {
 	swp_entry_t swp;
 	pte_t pte;
 
 	pr_debug("Validating PTE swap\n");
-	pte = pfn_pte(pfn, prot);
+	pte = pfn_pte(debug->fixed_pte_pfn, debug->page_prot);
 	swp = __pte_to_swp_entry(pte);
 	pte = __swp_entry_to_pte(swp);
-	WARN_ON(pfn != pte_pfn(pte));
+	WARN_ON(debug->fixed_pte_pfn != pte_pfn(pte));
 }
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_swap_tests(struct vm_pgtable_debug *debug)
 {
 	swp_entry_t swp;
 	pmd_t pmd;
@@ -837,13 +835,13 @@ static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD swap\n");
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(debug->fixed_pmd_pfn, debug->page_prot);
 	swp = __pmd_to_swp_entry(pmd);
 	pmd = __swp_entry_to_pmd(swp);
-	WARN_ON(pfn != pmd_pfn(pmd));
+	WARN_ON(debug->fixed_pmd_pfn != pmd_pfn(pmd));
 }
 #else  /* !CONFIG_ARCH_ENABLE_THP_MIGRATION */
-static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_swap_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
 static void __init swap_migration_tests(void)
@@ -1278,13 +1276,13 @@ static int __init debug_vm_pgtable(void)
 	pmd_devmap_tests(&debug);
 	pud_devmap_tests(&debug);
 
-	pte_soft_dirty_tests(pte_aligned, prot);
-	pmd_soft_dirty_tests(pmd_aligned, prot);
-	pte_swap_soft_dirty_tests(pte_aligned, prot);
-	pmd_swap_soft_dirty_tests(pmd_aligned, prot);
+	pte_soft_dirty_tests(&debug);
+	pmd_soft_dirty_tests(&debug);
+	pte_swap_soft_dirty_tests(&debug);
+	pmd_swap_soft_dirty_tests(&debug);
 
-	pte_swap_tests(pte_aligned, prot);
-	pmd_swap_tests(pmd_aligned, prot);
+	pte_swap_tests(&debug);
+	pmd_swap_tests(&debug);
 
 	swap_migration_tests();
 
-- 
2.23.0

