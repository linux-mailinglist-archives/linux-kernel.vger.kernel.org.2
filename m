Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1489B38D4BF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 11:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhEVJZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 05:25:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3655 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhEVJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 05:24:53 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FnHys3pBrzmWnS;
        Sat, 22 May 2021 17:21:09 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 17:23:27 +0800
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 22
 May 2021 17:23:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <sjenning@redhat.com>,
        <ddstreet@ieee.org>, <vitaly.wool@konsulko.com>
CC:     <bigeasy@linutronix.de>, <nathan@kernel.org>,
        <colin.king@canonical.com>, <tiantao6@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/3] mm/zswap.c: fix two bugs in zswap_writeback_entry()
Date:   Sat, 22 May 2021 17:22:42 +0800
Message-ID: <20210522092242.3233191-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210522092242.3233191-1-linmiaohe@huawei.com>
References: <20210522092242.3233191-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the ZSWAP_SWAPCACHE_FAIL and ZSWAP_SWAPCACHE_EXIST case, we forgot to
call zpool_unmap_handle() when zpool can't sleep. And we might sleep in
zswap_get_swap_cache_page() while zpool can't sleep. To fix all of these,
zpool_unmap_handle() should be done before zswap_get_swap_cache_page()
when zpool can't sleep.

Fixes: fc6697a89f56 ("mm/zswap: add the flag can_sleep_mapped")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/zswap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index c27ce9f2cdf8..7944e3e57e78 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -967,6 +967,13 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	spin_unlock(&tree->lock);
 	BUG_ON(offset != entry->offset);
 
+	src = (u8 *)zhdr + sizeof(struct zswap_header);
+	if (!zpool_can_sleep_mapped(pool)) {
+		memcpy(tmp, src, entry->length);
+		src = tmp;
+		zpool_unmap_handle(pool, handle);
+	}
+
 	/* try to allocate swap cache page */
 	switch (zswap_get_swap_cache_page(swpentry, &page)) {
 	case ZSWAP_SWAPCACHE_FAIL: /* no memory or invalidate happened */
@@ -982,17 +989,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
 		/* decompress */
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-
 		dlen = PAGE_SIZE;
-		src = (u8 *)zhdr + sizeof(struct zswap_header);
-
-		if (!zpool_can_sleep_mapped(pool)) {
-
-			memcpy(tmp, src, entry->length);
-			src = tmp;
-
-			zpool_unmap_handle(pool, handle);
-		}
 
 		mutex_lock(acomp_ctx->mutex);
 		sg_init_one(&input, src, entry->length);
-- 
2.23.0

