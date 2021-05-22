Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A79138D4BE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhEVJZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 05:25:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5664 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhEVJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 05:24:52 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FnHyG402Pz1BPQs;
        Sat, 22 May 2021 17:20:38 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 17:23:26 +0800
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
Subject: [PATCH 2/3] mm/zswap.c: avoid unnecessary copy-in at map time
Date:   Sat, 22 May 2021 17:22:41 +0800
Message-ID: <20210522092242.3233191-3-linmiaohe@huawei.com>
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

The buf mapped via zpool_map_handle() is only used to store compressed
page buffer and there is no information to extract from it. So we could
use ZPOOL_MM_WO instead to avoid unnecessary copy-in at map time.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index e93459319fdb..c27ce9f2cdf8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1203,7 +1203,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		zswap_reject_alloc_fail++;
 		goto put_dstmem;
 	}
-	buf = zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_RW);
+	buf = zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_WO);
 	memcpy(buf, &zhdr, hlen);
 	memcpy(buf + hlen, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-- 
2.23.0

