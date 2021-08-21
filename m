Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C427A3F39F5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 11:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhHUJnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 05:43:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8759 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhHUJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:43:34 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GsD7P6PvpzYqXF;
        Sat, 21 Aug 2021 17:42:25 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 21
 Aug 2021 17:42:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <minchan@kernel.org>,
        <cgoldswo@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 1/3] mm/memory_hotplug: use helper zone_is_zone_device() to simplify the code
Date:   Sat, 21 Aug 2021 17:42:44 +0800
Message-ID: <20210821094246.10149-2-linmiaohe@huawei.com>
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

Use helper zone_is_zone_device() to simplify the code and remove some
explicit CONFIG_ZONE_DEVICE codes.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory_hotplug.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b287ff3d7229..d986d3791986 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -477,15 +477,13 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
 				 sizeof(struct page) * cur_nr_pages);
 	}
 
-#ifdef CONFIG_ZONE_DEVICE
 	/*
 	 * Zone shrinking code cannot properly deal with ZONE_DEVICE. So
 	 * we will not try to shrink the zones - which is okay as
 	 * set_zone_contiguous() cannot deal with ZONE_DEVICE either way.
 	 */
-	if (zone_idx(zone) == ZONE_DEVICE)
+	if (zone_is_zone_device(zone))
 		return;
-#endif
 
 	clear_zone_contiguous(zone);
 
-- 
2.23.0

