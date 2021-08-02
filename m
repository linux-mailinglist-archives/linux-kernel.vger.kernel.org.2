Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D943DD04D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhHBGGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232339AbhHBGF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627884347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//lqv5+n7G0mjAPjt2ULvJkinLzgDemy9RFLT1ZNdAw=;
        b=hYSc8Vv2vXH5zCr7NOQn4qCLFBXNArThbqvhg7UJzmU0L2W09KPAj6n6V4ov1DsauUWREf
        TqTXeM4JJZkLrP82dbXSKW0ysGUnk+bZU2WRaXXGIakg1G1R2U8NLykhoWRY9kpwLgrGQI
        sdRwvf4VgGmkZk+A4aPch8ubqPHkYGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-Yh9wT8TCPXKCFA0NY7XHgQ-1; Mon, 02 Aug 2021 02:05:43 -0400
X-MC-Unique: Yh9wT8TCPXKCFA0NY7XHgQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE725107ACF5;
        Mon,  2 Aug 2021 06:05:41 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-184.bne.redhat.com [10.64.54.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D54D91ABD8;
        Mon,  2 Aug 2021 06:05:37 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, vgupta@synopsys.com, akpm@linux-foundation.org,
        chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 11/12] mm/debug_vm_pgtable: Remove unused code
Date:   Mon,  2 Aug 2021 14:04:18 +0800
Message-Id: <20210802060419.1360913-12-gshan@redhat.com>
In-Reply-To: <20210802060419.1360913-1-gshan@redhat.com>
References: <20210802060419.1360913-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables used by old implementation isn't needed as we switched
to "struct pgtable_debug_args". Lets remove them and related code in
debug_vm_pgtable().

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 54 -------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 3828d2bdf5de..b4fdc63a60f0 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1188,15 +1188,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 static int __init debug_vm_pgtable(void)
 {
 	struct pgtable_debug_args args;
-	struct vm_area_struct *vma;
-	struct mm_struct *mm;
-	pgd_t *pgdp;
-	p4d_t *p4dp;
-	pud_t *pudp;
-	pmd_t *pmdp, *saved_pmdp, pmd;
 	pte_t *ptep;
-	pgtable_t saved_ptep;
-	unsigned long vaddr;
 	spinlock_t *ptl = NULL;
 	int idx, ret;
 
@@ -1205,41 +1197,6 @@ static int __init debug_vm_pgtable(void)
 	if (ret)
 		return ret;
 
-	vaddr = get_random_vaddr();
-	mm = mm_alloc();
-	if (!mm) {
-		pr_err("mm_struct allocation failed\n");
-		return 1;
-	}
-
-	vma = vm_area_alloc(mm);
-	if (!vma) {
-		pr_err("vma allocation failed\n");
-		return 1;
-	}
-
-	pgdp = pgd_offset(mm, vaddr);
-	p4dp = p4d_alloc(mm, pgdp, vaddr);
-	pudp = pud_alloc(mm, p4dp, vaddr);
-	pmdp = pmd_alloc(mm, pudp, vaddr);
-	/*
-	 * Allocate pgtable_t
-	 */
-	if (pte_alloc(mm, pmdp)) {
-		pr_err("pgtable allocation failed\n");
-		return 1;
-	}
-
-	/*
-	 * Save all the page table page addresses as the page table
-	 * entries will be used for testing with random or garbage
-	 * values. These saved addresses will be used for freeing
-	 * page table pages.
-	 */
-	pmd = READ_ONCE(*pmdp);
-	saved_pmdp = pmd_offset(pudp, 0UL);
-	saved_ptep = pmd_pgtable(pmd);
-
 	/*
 	 * Iterate over the protection_map[] to make sure that all
 	 * the basic page table transformation validations just hold
@@ -1322,17 +1279,6 @@ static int __init debug_vm_pgtable(void)
 	pgd_populate_tests(&args);
 	spin_unlock(&(args.mm->page_table_lock));
 
-	p4d_free(mm, p4d_offset(pgdp, 0UL));
-	pud_free(mm, pud_offset(p4dp, 0UL));
-	pmd_free(mm, saved_pmdp);
-	pte_free(mm, saved_ptep);
-
-	vm_area_free(vma);
-	mm_dec_nr_puds(mm);
-	mm_dec_nr_pmds(mm);
-	mm_dec_nr_ptes(mm);
-	mmdrop(mm);
-
 	destroy_args(&args);
 	return 0;
 }
-- 
2.23.0

