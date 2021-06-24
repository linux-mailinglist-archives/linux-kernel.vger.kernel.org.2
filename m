Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563913B2F36
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhFXMmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:42:54 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:8321 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhFXMmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:42:51 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G9fkv1ZgJz728K;
        Thu, 24 Jun 2021 20:36:23 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 20:40:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <ngupta@vflare.org>
CC:     <senozhatsky@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 2/3] mm/zsmalloc.c: combine two atomic ops in zs_pool_dec_isolated()
Date:   Thu, 24 Jun 2021 20:39:29 +0800
Message-ID: <20210624123930.1769093-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210624123930.1769093-1-linmiaohe@huawei.com>
References: <20210624123930.1769093-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic_long_dec_and_test() is equivalent to atomic_long_dec() and
atomic_long_read() == 0. Use it to make code more succinct.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/zsmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1476289b619f..0b4b23740d78 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1828,13 +1828,12 @@ static void putback_zspage_deferred(struct zs_pool *pool,
 static inline void zs_pool_dec_isolated(struct zs_pool *pool)
 {
 	VM_BUG_ON(atomic_long_read(&pool->isolated_pages) <= 0);
-	atomic_long_dec(&pool->isolated_pages);
 	/*
 	 * There's no possibility of racing, since wait_for_isolated_drain()
 	 * checks the isolated count under &class->lock after enqueuing
 	 * on migration_wait.
 	 */
-	if (atomic_long_read(&pool->isolated_pages) == 0 && pool->destroying)
+	if (atomic_long_dec_and_test(&pool->isolated_pages) && pool->destroying)
 		wake_up_all(&pool->migration_wait);
 }
 
-- 
2.23.0

