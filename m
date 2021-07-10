Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758F73C340B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhGJKGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 06:06:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10462 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhGJKGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 06:06:05 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GMQW852kdzcbC7;
        Sat, 10 Jul 2021 18:00:04 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 10
 Jul 2021 18:03:18 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>, <alexs@kernel.org>,
        <apopple@nvidia.com>, <willy@infradead.org>, <minchan@kernel.org>,
        <david@redhat.com>, <shli@fb.com>, <hillf.zj@alibaba-inc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to anonymous LRU list
Date:   Sat, 10 Jul 2021 18:03:25 +0800
Message-ID: <20210710100329.49174-2-linmiaohe@huawei.com>
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

If the MADV_FREE pages are redirtied before they could be reclaimed, put
the pages back to anonymous LRU list by setting SwapBacked flag and the
pages will be reclaimed in normal swapout way. Otherwise MADV_FREE pages
won't be reclaimed as expected.

Fixes: 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a7602f71ec04..6483fe0e2065 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1628,6 +1628,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			if (!page_ref_freeze(page, 1))
 				goto keep_locked;
 			if (PageDirty(page)) {
+				SetPageSwapBacked(page);
 				page_ref_unfreeze(page, 1);
 				goto keep_locked;
 			}
-- 
2.23.0

