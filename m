Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE53FED92
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbhIBMNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:13:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19002 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbhIBMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:13:24 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H0fpM6FHQzblXS;
        Thu,  2 Sep 2021 20:08:27 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 2 Sep
 2021 20:12:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 2/5] mm/page_alloc.c: simplify the code by using macro K()
Date:   Thu, 2 Sep 2021 20:12:39 +0800
Message-ID: <20210902121242.41607-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210902121242.41607-1-linmiaohe@huawei.com>
References: <20210902121242.41607-1-linmiaohe@huawei.com>
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

Use helper macro K() to convert the pages to the corresponding size.
Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dbb3338d9287..d3983244f56f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8134,8 +8134,7 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 	}
 
 	if (pages && s)
-		pr_info("Freeing %s memory: %ldK\n",
-			s, pages << (PAGE_SHIFT - 10));
+		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
 
 	return pages;
 }
@@ -8180,14 +8179,13 @@ void __init mem_init_print_info(void)
 		", %luK highmem"
 #endif
 		")\n",
-		nr_free_pages() << (PAGE_SHIFT - 10),
-		physpages << (PAGE_SHIFT - 10),
+		K(nr_free_pages()), K(physpages),
 		codesize >> 10, datasize >> 10, rosize >> 10,
 		(init_data_size + init_code_size) >> 10, bss_size >> 10,
-		(physpages - totalram_pages() - totalcma_pages) << (PAGE_SHIFT - 10),
-		totalcma_pages << (PAGE_SHIFT - 10)
+		K(physpages - totalram_pages() - totalcma_pages),
+		K(totalcma_pages)
 #ifdef	CONFIG_HIGHMEM
-		, totalhigh_pages() << (PAGE_SHIFT - 10)
+		, K(totalhigh_pages())
 #endif
 		);
 }
-- 
2.23.0

