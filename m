Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D13BC664
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhGFGVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230221AbhGFGVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625552321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiK7WbmZHUKFR/bsDbzja/cvbEFXN86BsWzUPyPwIkM=;
        b=bkvzOTNOKSIMcODdyI7YiIz9Aj/Lg9QJh+awUZjt1tCaWuo6awfTDklQml6oP+vbQnnKaW
        uRzKeXAqb0oQrLKWBJjdJgKu8nfoXqSa05t/VqLGnfq1D+Tplrv4Jg1cIsQEfMGowsTvIe
        5SOLqz9BcRgBiYWnXgURX/FMhRn5sy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-w--MKDzAOdODqUO_ItzE6w-1; Tue, 06 Jul 2021 02:18:39 -0400
X-MC-Unique: w--MKDzAOdODqUO_ItzE6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C6E8015C6;
        Tue,  6 Jul 2021 06:18:38 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B07F360583;
        Tue,  6 Jul 2021 06:18:34 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com, chuhu@redhat.com
Subject: [PATCH 10/12] mm/debug_vm_pgtable: Use struct vm_pgtable_debug in PGD and P4D modifying tests
Date:   Tue,  6 Jul 2021 14:17:46 +0800
Message-Id: <20210706061748.161258-11-gshan@redhat.com>
In-Reply-To: <20210706061748.161258-1-gshan@redhat.com>
References: <20210706061748.161258-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct vm_pgtable_debug in PGD/P4D modifying tests. No
allocated huge page is used in these tests.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 76 +++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 59fd9440ab12..7bc26808033c 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -520,27 +520,26 @@ static void __init pud_populate_tests(struct vm_pgtable_debug *debug) { }
 #endif /* PAGETABLE_PUD_FOLDED */
 
 #ifndef __PAGETABLE_P4D_FOLDED
-static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp)
+static void __init p4d_clear_tests(struct vm_pgtable_debug *debug)
 {
-	p4d_t p4d = READ_ONCE(*p4dp);
+	p4d_t p4d = READ_ONCE(*(debug->p4dp));
 
-	if (mm_pud_folded(mm))
+	if (mm_pud_folded(debug->mm))
 		return;
 
 	pr_debug("Validating P4D clear\n");
 	p4d = __p4d(p4d_val(p4d) | RANDOM_ORVALUE);
-	WRITE_ONCE(*p4dp, p4d);
-	p4d_clear(p4dp);
-	p4d = READ_ONCE(*p4dp);
+	WRITE_ONCE(*(debug->p4dp), p4d);
+	p4d_clear(debug->p4dp);
+	p4d = READ_ONCE(*(debug->p4dp));
 	WARN_ON(!p4d_none(p4d));
 }
 
-static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
-				      pud_t *pudp)
+static void __init p4d_populate_tests(struct vm_pgtable_debug *debug)
 {
 	p4d_t p4d;
 
-	if (mm_pud_folded(mm))
+	if (mm_pud_folded(debug->mm))
 		return;
 
 	pr_debug("Validating P4D populate\n");
@@ -548,34 +547,33 @@ static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as p4d_bad().
 	 */
-	pud_clear(pudp);
-	p4d_clear(p4dp);
-	p4d_populate(mm, p4dp, pudp);
-	p4d = READ_ONCE(*p4dp);
+	pud_clear(debug->pudp);
+	p4d_clear(debug->p4dp);
+	p4d_populate(debug->mm, debug->p4dp, debug->start_pudp);
+	p4d = READ_ONCE(*(debug->p4dp));
 	WARN_ON(p4d_bad(p4d));
 }
 
-static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp)
+static void __init pgd_clear_tests(struct vm_pgtable_debug *debug)
 {
-	pgd_t pgd = READ_ONCE(*pgdp);
+	pgd_t pgd = READ_ONCE(*(debug->pgdp));
 
-	if (mm_p4d_folded(mm))
+	if (mm_p4d_folded(debug->mm))
 		return;
 
 	pr_debug("Validating PGD clear\n");
 	pgd = __pgd(pgd_val(pgd) | RANDOM_ORVALUE);
-	WRITE_ONCE(*pgdp, pgd);
-	pgd_clear(pgdp);
-	pgd = READ_ONCE(*pgdp);
+	WRITE_ONCE(*(debug->pgdp), pgd);
+	pgd_clear(debug->pgdp);
+	pgd = READ_ONCE(*(debug->pgdp));
 	WARN_ON(!pgd_none(pgd));
 }
 
-static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
-				      p4d_t *p4dp)
+static void __init pgd_populate_tests(struct vm_pgtable_debug *debug)
 {
 	pgd_t pgd;
 
-	if (mm_p4d_folded(mm))
+	if (mm_p4d_folded(debug->mm))
 		return;
 
 	pr_debug("Validating PGD populate\n");
@@ -583,23 +581,17 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pgd_bad().
 	 */
-	p4d_clear(p4dp);
-	pgd_clear(pgdp);
-	pgd_populate(mm, pgdp, p4dp);
-	pgd = READ_ONCE(*pgdp);
+	p4d_clear(debug->p4dp);
+	pgd_clear(debug->pgdp);
+	pgd_populate(debug->mm, debug->pgdp, debug->start_p4dp);
+	pgd = READ_ONCE(*(debug->pgdp));
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
+static void __init p4d_clear_tests(struct vm_pgtable_debug *debug) { }
+static void __init pgd_clear_tests(struct vm_pgtable_debug *debug) { }
+static void __init p4d_populate_tests(struct vm_pgtable_debug *debug) { }
+static void __init pgd_populate_tests(struct vm_pgtable_debug *debug) { }
 #endif /* PAGETABLE_P4D_FOLDED */
 
 static void __init pte_clear_tests(struct vm_pgtable_debug *debug)
@@ -1300,12 +1292,12 @@ static int __init debug_vm_pgtable(void)
 	pud_populate_tests(&debug);
 	spin_unlock(ptl);
 
-	spin_lock(&mm->page_table_lock);
-	p4d_clear_tests(mm, p4dp);
-	pgd_clear_tests(mm, pgdp);
-	p4d_populate_tests(mm, p4dp, saved_pudp);
-	pgd_populate_tests(mm, pgdp, saved_p4dp);
-	spin_unlock(&mm->page_table_lock);
+	spin_lock(&(debug.mm->page_table_lock));
+	p4d_clear_tests(&debug);
+	pgd_clear_tests(&debug);
+	p4d_populate_tests(&debug);
+	pgd_populate_tests(&debug);
+	spin_unlock(&(debug.mm->page_table_lock));
 
 	p4d_free(mm, saved_p4dp);
 	pud_free(mm, saved_pudp);
-- 
2.23.0

