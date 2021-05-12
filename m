Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0637F37B45C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhELDCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:02:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2448 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:02:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ffzxv3PLgzCrPN;
        Wed, 12 May 2021 10:58:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:01:02 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 3/3] mm/debug: Check page poisoned firstly in dump_page()
Date:   Wed, 12 May 2021 11:10:57 +0800
Message-ID: <20210512031057.13580-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210512031057.13580-1-wangkefeng.wang@huawei.com>
References: <20210512031057.13580-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If page is poisoned, it will crash when we call some page related
functions, so must check whether the page is poisoned or not firstly.

Fixes: 6197ab984b41 ("mm: improve dump_page() for compound pages")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/debug.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 84cdcd0f7bd3..cf84cd9df527 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -44,20 +44,19 @@ const struct trace_print_flags vmaflag_names[] = {
 
 static void __dump_page(struct page *page, const char *reason)
 {
-	struct page *head = compound_head(page);
+	struct page *head = NULL;
 	struct address_space *mapping;
-	bool page_poisoned = PagePoisoned(page);
-	bool compound = PageCompound(page);
+	bool compound;
 	/*
 	 * Accessing the pageblock without the zone lock. It could change to
 	 * "isolate" again in the meantime, but since we are just dumping the
 	 * state for debugging, it should be fine to accept a bit of
 	 * inaccuracy here due to racing.
 	 */
-	bool page_cma = is_migrate_cma_page(page);
+	bool page_cma;
 	int mapcount;
 	char *type = "";
-
+	bool page_poisoned = PagePoisoned(page);
 	/*
 	 * If struct page is poisoned don't access Page*() functions as that
 	 * leads to recursive loop. Page*() check for poisoned pages, and calls
@@ -68,6 +67,10 @@ static void __dump_page(struct page *page, const char *reason)
 		goto hex_only;
 	}
 
+	head = compound_head(page);
+	page_poisoned = PagePoisoned(page);
+	page_cma = is_migrate_cma_page(page);
+
 	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
 		/*
 		 * Corrupt page, so we cannot call page_mapping. Instead, do a
@@ -178,7 +181,7 @@ static void __dump_page(struct page *page, const char *reason)
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
-	if (head != page)
+	if (head && head != page)
 		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), head,
 			sizeof(struct page), false);
-- 
2.26.2

