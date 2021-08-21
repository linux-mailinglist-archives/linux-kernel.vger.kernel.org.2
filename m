Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E293F39F7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhHUJnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 05:43:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14405 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhHUJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:43:35 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GsD3c0Pj9zdcDt;
        Sat, 21 Aug 2021 17:39:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 21
 Aug 2021 17:42:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <minchan@kernel.org>,
        <cgoldswo@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 3/3] mm/memory_hotplug: make HWPoisoned dirty swapcache pages unmovable
Date:   Sat, 21 Aug 2021 17:42:46 +0800
Message-ID: <20210821094246.10149-4-linmiaohe@huawei.com>
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

HWPoisoned dirty swapcache pages are kept for killing owner processes.
We should not offline these pages or do_swap_page() would access the
offline pages and lead to bad ending.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory_hotplug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9fd0be32a281..0488eed3327c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1664,6 +1664,12 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		 */
 		if (PageOffline(page) && page_count(page))
 			return -EBUSY;
+		/*
+		 * HWPoisoned dirty swapcache pages are definitely unmovable
+		 * because they are kept for killing owner processes.
+		 */
+		if (PageHWPoison(page) && PageSwapCache(page))
+			return -EBUSY;
 
 		if (!PageHuge(page))
 			continue;
-- 
2.23.0

