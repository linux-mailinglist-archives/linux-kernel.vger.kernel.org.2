Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653563C340E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhGJKGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 06:06:15 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11252 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhGJKGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 06:06:07 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GMQSX59xtz1CGSP;
        Sat, 10 Jul 2021 17:57:48 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 10
 Jul 2021 18:03:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>, <alexs@kernel.org>,
        <apopple@nvidia.com>, <willy@infradead.org>, <minchan@kernel.org>,
        <david@redhat.com>, <shli@fb.com>, <hillf.zj@alibaba-inc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/5] mm/vmscan: add 'else' to remove check_pending label
Date:   Sat, 10 Jul 2021 18:03:28 +0800
Message-ID: <20210710100329.49174-5-linmiaohe@huawei.com>
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

We could add 'else' to remove the somewhat odd check_pending label to
make code core succinct.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c580bef6b885..a74760c48bd8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3428,18 +3428,14 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	 * blocked waiting on the same lock. Instead, throttle for up to a
 	 * second before continuing.
 	 */
-	if (!(gfp_mask & __GFP_FS)) {
+	if (!(gfp_mask & __GFP_FS))
 		wait_event_interruptible_timeout(pgdat->pfmemalloc_wait,
 			allow_direct_reclaim(pgdat), HZ);
+	else
+		/* Throttle until kswapd wakes the process */
+		wait_event_killable(zone->zone_pgdat->pfmemalloc_wait,
+			allow_direct_reclaim(pgdat));
 
-		goto check_pending;
-	}
-
-	/* Throttle until kswapd wakes the process */
-	wait_event_killable(zone->zone_pgdat->pfmemalloc_wait,
-		allow_direct_reclaim(pgdat));
-
-check_pending:
 	if (fatal_signal_pending(current))
 		return true;
 
-- 
2.23.0

