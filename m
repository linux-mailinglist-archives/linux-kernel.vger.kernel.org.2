Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5943D6F02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhG0GP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235808AbhG0GPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627366514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5mXCBOskGR2LD9tHZeCy0Xw8ZVaVC4Z766R79xzPbE=;
        b=JtTdH605cQTTZZob0D6B3vrVL2DyD8N6CDLD2TU5vQsXbzLcJ/eoHZrX8f3Bj5aLlzHjYe
        cEEv4V7FD8JoqDmexTw8vr6OjCto3YiWAZujKcyiUSaQx6D1y71pw3lujW4LiyDapqC0FT
        fBrT6YW43jIQpBh43rejbAjqWFCX3vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-RDDG-WtbP-qM6ga3Tn3t4Q-1; Tue, 27 Jul 2021 02:15:12 -0400
X-MC-Unique: RDDG-WtbP-qM6ga3Tn3t4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FD768799EB;
        Tue, 27 Jul 2021 06:15:11 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A37BE9C8C3;
        Tue, 27 Jul 2021 06:15:07 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v4 10/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in PGD and P4D modifying tests
Date:   Tue, 27 Jul 2021 14:13:59 +0800
Message-Id: <20210727061401.592616-11-gshan@redhat.com>
In-Reply-To: <20210727061401.592616-1-gshan@redhat.com>
References: <20210727061401.592616-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in PGD/P4D modifying tests. No
allocated huge page is used in these tests. Besides, the unused
variable @saved_p4dp and @saved_pudp are dropped.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 86 +++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 863871e70268..0611b5f31e89 100644
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
@@ -1212,8 +1204,8 @@ static int __init debug_vm_pgtable(void)
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
@@ -1258,8 +1250,6 @@ static int __init debug_vm_pgtable(void)
 	 * page table pages.
 	 */
 	pmd = READ_ONCE(*pmdp);
-	saved_p4dp = p4d_offset(pgdp, 0UL);
-	saved_pudp = pud_offset(p4dp, 0UL);
 	saved_pmdp = pmd_offset(pudp, 0UL);
 	saved_ptep = pmd_pgtable(pmd);
 
@@ -1338,15 +1328,15 @@ static int __init debug_vm_pgtable(void)
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

