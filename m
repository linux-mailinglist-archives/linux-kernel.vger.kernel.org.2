Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6F35B65C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 19:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhDKRnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 13:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKRnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 13:43:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D45C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kAgzJlhbyWIXfrj43lqYLdnnq1g4NVB9wGiuobLD7Wg=; b=a1rq/DAz1kgztNkaEjD3zkx8eM
        9HysTcgYRTnI56FoYltxOY/snPJWEAqJULsYxaOVnQbETJ7/BWEy8p/WD2z/nuVCy6bE+lxkIyasC
        X1ww66VGlUu7jmXT4OyP2jnGwEB42C7ysuC1lycaDh050bL27l0/U7kCeCiacDyvSGHrVvAW0Pqz2
        dZl/hHuW8K/PWMk2ed0VGaCBoCz9qPGeNrJTul3glAojZTkNuBRwjOdfnb1GXxXX6Vl0lD0dDnvmq
        ecdM0RdBZHlQ0hdMxR+bOqvLm4YP5wOke3n8PiqqZ9AxznqjoHqWY5sHvyJLan1Z6pRg6ku4wsA7r
        /jBE+W2A==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVe7I-003EwI-ED; Sun, 11 Apr 2021 17:43:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH] mm: eliminate "expecting prototype" kernel-doc warnings
Date:   Sun, 11 Apr 2021 10:43:21 -0700
Message-Id: <20210411174321.7013-1-rdunlap@infradead.org>
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
---
 mm/mmu_gather.c |    2 +-
 mm/oom_kill.c   |    7 ++++---
 mm/shuffle.c    |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

--- linux-next-20210409.orig/mm/mmu_gather.c
+++ linux-next-20210409/mm/mmu_gather.c
@@ -250,7 +250,7 @@ void tlb_flush_mmu(struct mmu_gather *tl
 }
 
 /**
- * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
+ * __tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
  * @tlb: the mmu_gather structure to initialize
  * @mm: the mm_struct of the target address space
  * @fullmm: @mm is without users and we're going to destroy the full address
--- linux-next-20210409.orig/mm/oom_kill.c
+++ linux-next-20210409/mm/oom_kill.c
@@ -171,10 +171,11 @@ static bool oom_unkillable_task(struct t
 }
 
 /**
- * Check whether unreclaimable slab amount is greater than
- * all user memory(LRU pages).
+ * should_dump_unreclaim_slab - Check whether unreclaimable slab amount
+ * is greater than all user memory (LRU pages).
+ *
  * dump_unreclaimable_slab() could help in the case that
- * oom due to too much unreclaimable slab used by kernel.
+ * oom is due to too much unreclaimable slab used by kernel.
 */
 static bool should_dump_unreclaim_slab(void)
 {
--- linux-next-20210409.orig/mm/shuffle.c
+++ linux-next-20210409/mm/shuffle.c
@@ -148,7 +148,7 @@ void __meminit __shuffle_zone(struct zon
 }
 
 /**
- * shuffle_free_memory - reduce the predictability of the page allocator
+ * __shuffle_free_memory - reduce the predictability of the page allocator
  * @pgdat: node page data
  */
 void __meminit __shuffle_free_memory(pg_data_t *pgdat)
