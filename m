Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6733C340F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhGJKGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 06:06:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10464 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhGJKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 06:06:08 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GMQWC5ClWzcbNn;
        Sat, 10 Jul 2021 18:00:07 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 10
 Jul 2021 18:03:21 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>, <alexs@kernel.org>,
        <apopple@nvidia.com>, <willy@infradead.org>, <minchan@kernel.org>,
        <david@redhat.com>, <shli@fb.com>, <hillf.zj@alibaba-inc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/5] mm/vmscan: fix misleading comment in isolate_lru_pages()
Date:   Sat, 10 Jul 2021 18:03:29 +0800
Message-ID: <20210710100329.49174-6-linmiaohe@huawei.com>
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

We couldn't know whether the page is being freed elsewhere until we failed
to increase the page count.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a74760c48bd8..6e26b3c93242 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1891,7 +1891,6 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		 */
 		scan += nr_pages;
 		if (!__isolate_lru_page_prepare(page, mode)) {
-			/* It is being freed elsewhere */
 			list_move(&page->lru, src);
 			continue;
 		}
@@ -1901,6 +1900,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		 * page release code relies on it.
 		 */
 		if (unlikely(!get_page_unless_zero(page))) {
+			/* It is being freed elsewhere. */
 			list_move(&page->lru, src);
 			continue;
 		}
-- 
2.23.0

