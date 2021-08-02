Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CDC3DD04C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhHBGF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232298AbhHBGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627884342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoUILadLHhOQBryPNfwcm5FRL8XomXmtqZt3gG0qBwk=;
        b=UPZnpBrzSo9wt/RtfA0RIHdHdWy4YN6WXhvt8OSx2vh2fm87rMlCDNxEVgaJoAEt+2sZl7
        VqrQdLhgXXasqvESm9JtTg6hiLKixe0WXAMcRc+P7+c4qDlAgCAXaeFl5d5woiP7IKHMdV
        13in9rqsvc5s+yxcWsVgrL+rZZ54zug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-F9D9-Hf1MRCMnwFvITdTww-1; Mon, 02 Aug 2021 02:05:39 -0400
X-MC-Unique: F9D9-Hf1MRCMnwFvITdTww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F2A987123E;
        Mon,  2 Aug 2021 06:05:37 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-184.bne.redhat.com [10.64.54.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11C4F69323;
        Mon,  2 Aug 2021 06:05:33 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, vgupta@synopsys.com, akpm@linux-foundation.org,
        chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 10/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in PGD and P4D modifying tests
Date:   Mon,  2 Aug 2021 14:04:17 +0800
Message-Id: <20210802060419.1360913-11-gshan@redhat.com>
In-Reply-To: <20210802060419.1360913-1-gshan@redhat.com>
References: <20210802060419.1360913-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in PGD/P4D modifying tests. No
allocated huge page is used in these tests. Besides, the unused
variable @saved_p4dp and @saved_pudp are dropped.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 86 +++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 460bf0101a49..3828d2bdf5de 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -518,27 +518,26 @@ static void __init pud_populate_tests(struct pgtable_debug_args *args) { }
 #endif /* PAGETABLE_PUD_FOLDED */
 
 #ifndef __PAGETABLE_P4D_FOLDED
-static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp)
+static void __init p4d_clear_tests(struct pgtable_debug_args *args)
 {
-	p4d_t p4d = READ_ONCE(*p4dp);
+	p4d_t p4d = READ_ONCE(*args->p4dp);
 
-	if (mm_pud_folded(mm))
+	if (mm_pud_folded(args->mm))
 		return;
 
 	pr_debug("Validating P4D clear\n");
 	p4d = __p4d(p4d_val(p4d) | RANDOM_ORVALUE);
-	WRITE_ONCE(*p4dp, p4d);
-	p4d_clear(p4dp);
-	p4d = READ_ONCE(*p4dp);
+	WRITE_ONCE(*args->p4dp, p4d);
+	p4d_clear(args->p4dp);
+	p4d = READ_ONCE(*args->p4dp);
 	WARN_ON(!p4d_none(p4d));
 }
 
-static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
-				      pud_t *pudp)
+static void __init p4d_populate_tests(struct pgtable_debug_args *args)
 {
 	p4d_t p4d;
 
-	if (mm_pud_folded(mm))
+	if (mm_pud_folded(args->mm))
 		return;
 
 	pr_debug("Validating P4D populate\n");
@@ -546,34 +545,33 @@ static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as p4d_bad().
 	 */
-	pud_clear(pudp);
-	p4d_clear(p4dp);
-	p4d_populate(mm, p4dp, pudp);
-	p4d = READ_ONCE(*p4dp);
+	pud_clear(args->pudp);
+	p4d_clear(args->p4dp);
+	p4d_populate(args->mm, args->p4dp, args->start_pudp);
+	p4d = READ_ONCE(*args->p4dp);
 	WARN_ON(p4d_bad(p4d));
 }
 
-static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp)
+static void __init pgd_clear_tests(struct pgtable_debug_args *args)
 {
-	pgd_t pgd = READ_ONCE(*pgdp);
+	pgd_t pgd = READ_ONCE(*(args->pgdp));
 
-	if (mm_p4d_folded(mm))
+	if (mm_p4d_folded(args->mm))
 		return;
 
 	pr_debug("Validating PGD clear\n");
 	pgd = __pgd(pgd_val(pgd) | RANDOM_ORVALUE);
-	WRITE_ONCE(*pgdp, pgd);
-	pgd_clear(pgdp);
-	pgd = READ_ONCE(*pgdp);
+	WRITE_ONCE(*args->pgdp, pgd);
+	pgd_clear(args->pgdp);
+	pgd = READ_ONCE(*args->pgdp);
 	WARN_ON(!pgd_none(pgd));
 }
 
-static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
-				      p4d_t *p4dp)
+static void __init pgd_populate_tests(struct pgtable_debug_args *args)
 {
 	pgd_t pgd;
 
-	if (mm_p4d_folded(mm))
+	if (mm_p4d_folded(args->mm))
 		return;
 
 	pr_debug("Validating PGD populate\n");
@@ -581,23 +579,17 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pgd_bad().
 	 */
-	p4d_clear(p4dp);
-	pgd_clear(pgdp);
-	pgd_populate(mm, pgdp, p4dp);
-	pgd = READ_ONCE(*pgdp);
+	p4d_clear(args->p4dp);
+	pgd_clear(args->pgdp);
+	pgd_populate(args->mm, args->pgdp, args->start_p4dp);
+	pgd = READ_ONCE(*args->pgdp);
 	WARN_ON(pgd_bad(pgd));
 }
 #else  /* !__PAGETABLE_P4D_FOLDED */
-static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp) { }
-static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp) { }
-static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
-				      pud_t *pudp)
-{
-}
-static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
-				      p4d_t *p4dp)
-{
-}
+static void __init p4d_clear_tests(struct pgtable_debug_args *args) { }
+static void __init pgd_clear_tests(struct pgtable_debug_args *args) { }
+static void __init p4d_populate_tests(struct pgtable_debug_args *args) { }
+static void __init pgd_populate_tests(struct pgtable_debug_args *args) { }
 #endif /* PAGETABLE_P4D_FOLDED */
 
 static void __init pte_clear_tests(struct pgtable_debug_args *args)
@@ -1199,8 +1191,8 @@ static int __init debug_vm_pgtable(void)
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	pgd_t *pgdp;
-	p4d_t *p4dp, *saved_p4dp;
-	pud_t *pudp, *saved_pudp;
+	p4d_t *p4dp;
+	pud_t *pudp;
 	pmd_t *pmdp, *saved_pmdp, pmd;
 	pte_t *ptep;
 	pgtable_t saved_ptep;
@@ -1245,8 +1237,6 @@ static int __init debug_vm_pgtable(void)
 	 * page table pages.
 	 */
 	pmd = READ_ONCE(*pmdp);
-	saved_p4dp = p4d_offset(pgdp, 0UL);
-	saved_pudp = pud_offset(p4dp, 0UL);
 	saved_pmdp = pmd_offset(pudp, 0UL);
 	saved_ptep = pmd_pgtable(pmd);
 
@@ -1325,15 +1315,15 @@ static int __init debug_vm_pgtable(void)
 	pud_populate_tests(&args);
 	spin_unlock(ptl);
 
-	spin_lock(&mm->page_table_lock);
-	p4d_clear_tests(mm, p4dp);
-	pgd_clear_tests(mm, pgdp);
-	p4d_populate_tests(mm, p4dp, saved_pudp);
-	pgd_populate_tests(mm, pgdp, saved_p4dp);
-	spin_unlock(&mm->page_table_lock);
+	spin_lock(&(args.mm->page_table_lock));
+	p4d_clear_tests(&args);
+	pgd_clear_tests(&args);
+	p4d_populate_tests(&args);
+	pgd_populate_tests(&args);
+	spin_unlock(&(args.mm->page_table_lock));
 
-	p4d_free(mm, saved_p4dp);
-	pud_free(mm, saved_pudp);
+	p4d_free(mm, p4d_offset(pgdp, 0UL));
+	pud_free(mm, pud_offset(p4dp, 0UL));
 	pmd_free(mm, saved_pmdp);
 	pte_free(mm, saved_ptep);
 
-- 
2.23.0

