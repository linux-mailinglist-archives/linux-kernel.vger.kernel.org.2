Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE93F39F6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 11:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhHUJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 05:43:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14310 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhHUJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:43:35 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GsD7l5vY0z87pK;
        Sat, 21 Aug 2021 17:42:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 21
 Aug 2021 17:42:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <minchan@kernel.org>,
        <cgoldswo@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 2/3] mm/memory_hotplug: fix potential permanent lru cache disable
Date:   Sat, 21 Aug 2021 17:42:45 +0800
Message-ID: <20210821094246.10149-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210821094246.10149-1-linmiaohe@huawei.com>
References: <20210821094246.10149-1-linmiaohe@huawei.com>
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

If offline_pages failed after lru_cache_disable(), it forgot to do
lru_cache_enable() in error path. So we would have lru cache disabled
permanently in this case.

Fixes: d479960e44f2 ("mm: disable LRU pagevec during the migration temporarily")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory_hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d986d3791986..9fd0be32a281 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2033,6 +2033,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 failed_removal_pcplists_disabled:
+	lru_cache_enable();
 	zone_pcp_enable(zone);
 failed_removal:
 	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
-- 
2.23.0

