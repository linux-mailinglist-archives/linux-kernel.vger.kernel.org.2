Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C484C3C340C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhGJKGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 06:06:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6800 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhGJKGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 06:06:06 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GMQSW09Z6zXpcg;
        Sat, 10 Jul 2021 17:57:47 +0800 (CST)
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
Subject: [PATCH 2/5] mm/vmscan: remove misleading setting to sc->priority
Date:   Sat, 10 Jul 2021 18:03:26 +0800
Message-ID: <20210710100329.49174-3-linmiaohe@huawei.com>
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

The priority field of sc is used to control how many pages we should scan
at once while we always traverse the list to shrink the pages in these
functions. So these settings are unneeded and misleading.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6483fe0e2065..fbe53e60b248 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1702,7 +1702,6 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 {
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
-		.priority = DEF_PRIORITY,
 		.may_unmap = 1,
 	};
 	struct reclaim_stat stat;
@@ -2327,7 +2326,6 @@ unsigned long reclaim_pages(struct list_head *page_list)
 	unsigned int noreclaim_flag;
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
-		.priority = DEF_PRIORITY,
 		.may_writepage = 1,
 		.may_unmap = 1,
 		.may_swap = 1,
-- 
2.23.0

