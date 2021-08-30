Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C553FB791
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhH3OL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:11:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15232 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbhH3OLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:11:18 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gysdf3Pk2z1DF7l;
        Mon, 30 Aug 2021 22:09:42 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 30
 Aug 2021 22:10:21 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 2/6] mm/page_alloc.c: simplify the code by using macro K()
Date:   Mon, 30 Aug 2021 22:10:47 +0800
Message-ID: <20210830141051.64090-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210830141051.64090-1-linmiaohe@huawei.com>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro K() to convert the pages to the corresponding size.
Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
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

