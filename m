Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6181A3CC19A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 08:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhGQHCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 03:02:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7024 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhGQHCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 03:02:09 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GRf2d6sLkzYcwP;
        Sat, 17 Jul 2021 14:53:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 17
 Jul 2021 14:59:10 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>, <alexs@kernel.org>,
        <apopple@nvidia.com>, <willy@infradead.org>, <minchan@kernel.org>,
        <david@redhat.com>, <shli@fb.com>, <hillf.zj@alibaba-inc.com>,
        <yuzhao@google.com>, <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 1/4] mm/vmscan: remove the PageDirty check after MADV_FREE pages are page_ref_freezed
Date:   Sat, 17 Jul 2021 14:59:08 +0800
Message-ID: <20210717065911.61497-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210717065911.61497-1-linmiaohe@huawei.com>
References: <20210717065911.61497-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the MADV_FREE pages are redirtied before they could be reclaimed,
put the pages back to anonymous LRU list by setting SwapBacked flag
and the pages will be reclaimed in normal swapout way. But as Yu Zhao
pointed out, "The page has only one reference left, which is from the
isolation. After the caller puts the page back on lru and drops the
reference, the page will be freed anyway. It doesn't matter which lru
it goes." So we don't bother checking PageDirty here.

[Yu Zhao's comment is also quoted in the code.]

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a7602f71ec04..92a515e82b1b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1627,11 +1627,14 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			/* follow __remove_mapping for reference */
 			if (!page_ref_freeze(page, 1))
 				goto keep_locked;
-			if (PageDirty(page)) {
-				page_ref_unfreeze(page, 1);
-				goto keep_locked;
-			}
-
+			/*
+			 * The page has only one reference left, which is
+			 * from the isolation. After the caller puts the
+			 * page back on lru and drops the reference, the
+			 * page will be freed anyway. It doesn't matter
+			 * which lru it goes. So we don't bother checking
+			 * PageDirty here.
+			 */
 			count_vm_event(PGLAZYFREED);
 			count_memcg_page_event(page, PGLAZYFREED);
 		} else if (!mapping || !__remove_mapping(mapping, page, true,
-- 
2.23.0

