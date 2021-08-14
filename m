Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0646E3EC21E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhHNKwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:52:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8413 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbhHNKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:52:02 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gmxvn2jVRz7xGd;
        Sat, 14 Aug 2021 18:47:33 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 14
 Aug 2021 18:51:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <sfr@canb.auug.org.au>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 1/4] mm/hwpoison: remove unneeded variable unmap_success
Date:   Sat, 14 Aug 2021 18:51:28 +0800
Message-ID: <20210814105131.48814-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210814105131.48814-1-linmiaohe@huawei.com>
References: <20210814105131.48814-1-linmiaohe@huawei.com>
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

unmap_success is used to indicate whether page is successfully unmapped
but it's irrelated with ZONE_DEVICE page and unmap_success is always
true here. Remove this unneeded one.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 03f83e7d075b..052ec9ee7cf6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1512,7 +1512,6 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
-	const bool unmap_success = true;
 	unsigned long size = 0;
 	struct to_kill *tk;
 	LIST_HEAD(tokill);
@@ -1584,7 +1583,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		start = (page->index << PAGE_SHIFT) & ~(size - 1);
 		unmap_mapping_range(page->mapping, start, size, 0);
 	}
-	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
+	kill_procs(&tokill, flags & MF_MUST_KILL, false, pfn, flags);
 	rc = 0;
 unlock:
 	dax_unlock_page(page, cookie);
-- 
2.23.0

