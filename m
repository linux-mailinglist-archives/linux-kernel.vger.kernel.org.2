Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2DA3492F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhCYNQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:16:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14593 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCYNQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:16:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5ltS4hvLz19HYk;
        Thu, 25 Mar 2021 21:14:08 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 21:16:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>, <aquini@redhat.com>,
        <david@redhat.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 1/5] mm/migrate.c: make putback_movable_page() static
Date:   Thu, 25 Mar 2021 09:15:20 -0400
Message-ID: <20210325131524.48181-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210325131524.48181-1-linmiaohe@huawei.com>
References: <20210325131524.48181-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The putback_movable_page() is just called by putback_movable_pages() and
we know the page is locked and both PageMovable() and PageIsolated() is
checked right before calling putback_movable_page(). So we make it static
and remove all the 3 VM_BUG_ON_PAGE().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/migrate.h | 1 -
 mm/migrate.c            | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index fdf65f23acec..1d8095069b1c 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -44,7 +44,6 @@ extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
 		unsigned long private, enum migrate_mode mode, int reason);
 extern struct page *alloc_migration_target(struct page *page, unsigned long private);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
-extern void putback_movable_page(struct page *page);
 
 extern void migrate_prep(void);
 extern void migrate_prep_local(void);
diff --git a/mm/migrate.c b/mm/migrate.c
index 47df0df8f21a..61e7f848b554 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -140,15 +140,10 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	return -EBUSY;
 }
 
-/* It should be called on page which is PG_movable */
-void putback_movable_page(struct page *page)
+static void putback_movable_page(struct page *page)
 {
 	struct address_space *mapping;
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(!PageMovable(page), page);
-	VM_BUG_ON_PAGE(!PageIsolated(page), page);
-
 	mapping = page_mapping(page);
 	mapping->a_ops->putback_page(page);
 	__ClearPageIsolated(page);
-- 
2.19.1

