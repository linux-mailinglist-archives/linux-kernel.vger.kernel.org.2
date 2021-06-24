Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D6E3B2F38
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhFXMm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:42:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5071 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhFXMmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:42:51 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G9fjg38L2zXkNY;
        Thu, 24 Jun 2021 20:35:19 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 20:40:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <ngupta@vflare.org>
CC:     <senozhatsky@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 3/3] mm/zsmalloc.c: improve readability for async_free_zspage()
Date:   Thu, 24 Jun 2021 20:39:30 +0800
Message-ID: <20210624123930.1769093-4-linmiaohe@huawei.com>
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

The class is extracted from pool->size_class[class_idx] again before
calling __free_zspage(). It looks like class will change after we fetch
the class lock. But this is misleading as class will stay unchanged.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0b4b23740d78..8598ee07284b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2161,7 +2161,7 @@ static void async_free_zspage(struct work_struct *work)
 		VM_BUG_ON(fullness != ZS_EMPTY);
 		class = pool->size_class[class_idx];
 		spin_lock(&class->lock);
-		__free_zspage(pool, pool->size_class[class_idx], zspage);
+		__free_zspage(pool, class, zspage);
 		spin_unlock(&class->lock);
 	}
 };
-- 
2.23.0

