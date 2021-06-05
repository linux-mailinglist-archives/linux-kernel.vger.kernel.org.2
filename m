Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5BB39C6AF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 09:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFEHyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 03:54:19 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4317 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFEHyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 03:54:17 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FxsDY6ZV8z1BGkY;
        Sat,  5 Jun 2021 15:47:41 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 5 Jun
 2021 15:52:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <sjenning@redhat.com>,
        <ddstreet@ieee.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/2] mm/zbud: reuse unbuddied[0] as buddied in zbud_pool
Date:   Sat, 5 Jun 2021 15:51:40 +0800
Message-ID: <20210605075141.1359969-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210605075141.1359969-1-linmiaohe@huawei.com>
References: <20210605075141.1359969-1-linmiaohe@huawei.com>
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

Since commit 9d8c5b5284e4 ("mm: zbud: fix condition check on allocation
size"), zbud_pool.unbuddied[0] is always unused. We can reuse it as buddied
field to save some possible memory.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/zbud.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zbud.c b/mm/zbud.c
index a200121da400..91543be47e3d 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -96,7 +96,7 @@
 struct zbud_pool {
 	spinlock_t lock;
 	struct list_head unbuddied[NCHUNKS];
-	struct list_head buddied;
+#define buddied unbuddied[0]
 	struct list_head lru;
 	u64 pages_nr;
 	const struct zbud_ops *ops;
-- 
2.23.0

