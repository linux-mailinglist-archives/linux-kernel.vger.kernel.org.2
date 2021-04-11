Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3835B6F3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 23:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhDKVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDKVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 17:07:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579E5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KSOODlkgpdnRgt3LOWGEZg2uUc3EPHr5m9tZXVxjRAk=; b=NiTiiSIJO61ApgVCHeGhJh7DZx
        xAZMDCNErqSTX2ryyGeaKI6xph6AWEMjADYyLtsQoJPAlM0e705Bv78LJNvzqKAqyBhPVksuRvU12
        7Zr6v5c3ceLHEaQGVWTCctYNASExz07cq0iK8ndnuimCQM4zwPsAtz8pgcYblnW1NhBqsC06BeuBy
        SYrGjs0oda9WYSDICfQXVZpcVfV0RvTx2OubOOK4QaKwgeRQCnJeEI6etzHBx3WDM30ROaaoy2f01
        Wk4+/RsUO0FT7Kox6jMWtPKA8f7ZUErcjYSfvO8OKkBecKAKRAjvVivCNTuoVQ2jjxD23kYFa2vQm
        iIPyyT0w==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVhI6-003Q7l-0W; Sun, 11 Apr 2021 21:06:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] mm: eliminate "expecting prototype" kernel-doc warnings
Date:   Sun, 11 Apr 2021 14:06:42 -0700
Message-Id: <20210411210642.11362-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix stray kernel-doc warnings in mm/ due to mis-typed or missing
function names.

Quietens these kernel-doc warnings:

../mm/mmu_gather.c:264: warning: expecting prototype for tlb_gather_mmu(). Prototype was for __tlb_gather_mmu() instead
../mm/oom_kill.c:180: warning: expecting prototype for Check whether unreclaimable slab amount is greater than(). Prototype was for should_dump_unreclaim_slab() instead
../mm/shuffle.c:155: warning: expecting prototype for shuffle_free_memory(). Prototype was for __shuffle_free_memory() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>
---
v2: Move/add kernel-doc in mmu_gather.c. Demote kernel-doc in oom_kill.c
    and shuffle.c to normal comments. (All suggested by Matthew.)

 mm/mmu_gather.c |   29 +++++++++++++++++++----------
 mm/oom_kill.c   |    2 +-
 mm/shuffle.c    |    4 ++--
 3 files changed, 22 insertions(+), 13 deletions(-)

--- linux-next-20210409.orig/mm/mmu_gather.c
+++ linux-next-20210409/mm/mmu_gather.c
@@ -249,16 +249,6 @@ void tlb_flush_mmu(struct mmu_gather *tl
 	tlb_flush_mmu_free(tlb);
 }
 
-/**
- * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
- * @tlb: the mmu_gather structure to initialize
- * @mm: the mm_struct of the target address space
- * @fullmm: @mm is without users and we're going to destroy the full address
- *	    space (exit/execve)
- *
- * Called to initialize an (on-stack) mmu_gather structure for page-table
- * tear-down from @mm.
- */
 static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 			     bool fullmm)
 {
@@ -283,11 +273,30 @@ static void __tlb_gather_mmu(struct mmu_
 	inc_tlb_flush_pending(tlb->mm);
 }
 
+/**
+ * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
+ * @tlb: the mmu_gather structure to initialize
+ * @mm: the mm_struct of the target address space
+ *
+ * Called to initialize an (on-stack) mmu_gather structure for page-table
+ * tear-down from @mm.
+ */
 void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm)
 {
 	__tlb_gather_mmu(tlb, mm, false);
 }
 
+/**
+ * tlb_gather_mmu_fullmm - initialize an mmu_gather structure for page-table tear-down
+ * @tlb: the mmu_gather structure to initialize
+ * @mm: the mm_struct of the target address space
+ *
+ * In this case, @mm is without users and we're going to destroy the
+ * full address space (exit/execve).
+ *
+ * Called to initialize an (on-stack) mmu_gather structure for page-table
+ * tear-down from @mm.
+ */
 void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
 {
 	__tlb_gather_mmu(tlb, mm, true);
--- linux-next-20210409.orig/mm/oom_kill.c
+++ linux-next-20210409/mm/oom_kill.c
@@ -170,7 +170,7 @@ static bool oom_unkillable_task(struct t
 	return false;
 }
 
-/**
+/*
  * Check whether unreclaimable slab amount is greater than
  * all user memory(LRU pages).
  * dump_unreclaimable_slab() could help in the case that
--- linux-next-20210409.orig/mm/shuffle.c
+++ linux-next-20210409/mm/shuffle.c
@@ -147,8 +147,8 @@ void __meminit __shuffle_zone(struct zon
 	spin_unlock_irqrestore(&z->lock, flags);
 }
 
-/**
- * shuffle_free_memory - reduce the predictability of the page allocator
+/*
+ * __shuffle_free_memory - reduce the predictability of the page allocator
  * @pgdat: node page data
  */
 void __meminit __shuffle_free_memory(pg_data_t *pgdat)
