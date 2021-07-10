Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA6C3C340D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhGJKGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 06:06:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10463 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhGJKGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 06:06:06 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GMQWB1cN3zcbFD;
        Sat, 10 Jul 2021 18:00:06 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 10
 Jul 2021 18:03:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>, <alexs@kernel.org>,
        <apopple@nvidia.com>, <willy@infradead.org>, <minchan@kernel.org>,
        <david@redhat.com>, <shli@fb.com>, <hillf.zj@alibaba-inc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/5] mm/vmscan: remove unneeded return value of kswapd_run()
Date:   Sat, 10 Jul 2021 18:03:27 +0800
Message-ID: <20210710100329.49174-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210710100329.49174-1-linmiaohe@huawei.com>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of kswapd_run() is unused now. Clean it up.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap.h | 2 +-
 mm/vmscan.c          | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6f5a43251593..717e6e500929 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -408,7 +408,7 @@ static inline bool node_reclaim_enabled(void)
 
 extern void check_move_unevictable_pages(struct pagevec *pvec);
 
-extern int kswapd_run(int nid);
+extern void kswapd_run(int nid);
 extern void kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fbe53e60b248..c580bef6b885 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4284,23 +4284,20 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
  * This kswapd start function will be called by init and node-hot-add.
  * On node-hot-add, kswapd will moved to proper cpus if cpus are hot-added.
  */
-int kswapd_run(int nid)
+void kswapd_run(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
-	int ret = 0;
 
 	if (pgdat->kswapd)
-		return 0;
+		return;
 
 	pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
 	if (IS_ERR(pgdat->kswapd)) {
 		/* failure at boot is fatal */
 		BUG_ON(system_state < SYSTEM_RUNNING);
 		pr_err("Failed to start kswapd on node %d\n", nid);
-		ret = PTR_ERR(pgdat->kswapd);
 		pgdat->kswapd = NULL;
 	}
-	return ret;
 }
 
 /*
-- 
2.23.0

