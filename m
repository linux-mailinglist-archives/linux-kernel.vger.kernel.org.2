Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D323AD8FF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhFSJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 05:35:20 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8282 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhFSJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 05:34:59 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G6VnT0plNz1BP8L;
        Sat, 19 Jun 2021 17:27:41 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 19
 Jun 2021 17:32:45 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vitalywool@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 4/6] mm/z3fold: remove unused function handle_to_z3fold_header()
Date:   Sat, 19 Jun 2021 17:31:49 +0800
Message-ID: <20210619093151.1492174-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210619093151.1492174-1-linmiaohe@huawei.com>
References: <20210619093151.1492174-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle_to_z3fold_header() is unused now. So we can remove it. As a result,
get_z3fold_header() becomes the only caller of __get_z3fold_header() and
the argument lock is always true. Therefore we could further fold the
__get_z3fold_header() into get_z3fold_header() with lock = true.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 988d57c143fd..bab08c08bf19 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -255,9 +255,8 @@ static inline void z3fold_page_unlock(struct z3fold_header *zhdr)
 	spin_unlock(&zhdr->page_lock);
 }
 
-
-static inline struct z3fold_header *__get_z3fold_header(unsigned long handle,
-							bool lock)
+/* return locked z3fold page if it's not headless */
+static inline struct z3fold_header *get_z3fold_header(unsigned long handle)
 {
 	struct z3fold_buddy_slots *slots;
 	struct z3fold_header *zhdr;
@@ -271,13 +270,12 @@ static inline struct z3fold_header *__get_z3fold_header(unsigned long handle,
 			read_lock(&slots->lock);
 			addr = *(unsigned long *)handle;
 			zhdr = (struct z3fold_header *)(addr & PAGE_MASK);
-			if (lock)
-				locked = z3fold_page_trylock(zhdr);
+			locked = z3fold_page_trylock(zhdr);
 			read_unlock(&slots->lock);
 			if (locked)
 				break;
 			cpu_relax();
-		} while (lock);
+		} while (true);
 	} else {
 		zhdr = (struct z3fold_header *)(handle & PAGE_MASK);
 	}
@@ -285,18 +283,6 @@ static inline struct z3fold_header *__get_z3fold_header(unsigned long handle,
 	return zhdr;
 }
 
-/* Returns the z3fold page where a given handle is stored */
-static inline struct z3fold_header *handle_to_z3fold_header(unsigned long h)
-{
-	return __get_z3fold_header(h, false);
-}
-
-/* return locked z3fold page if it's not headless */
-static inline struct z3fold_header *get_z3fold_header(unsigned long h)
-{
-	return __get_z3fold_header(h, true);
-}
-
 static inline void put_z3fold_header(struct z3fold_header *zhdr)
 {
 	struct page *page = virt_to_page(zhdr);
-- 
2.23.0

