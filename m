Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61CA3FED94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344290AbhIBMNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:13:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8999 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbhIBMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:13:24 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H0ft54lrJzYvGW;
        Thu,  2 Sep 2021 20:11:41 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 2 Sep
 2021 20:12:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 5/5] mm/page_alloc.c: avoid allocating highmem pages via alloc_pages_exact[_nid]
Date:   Thu, 2 Sep 2021 20:12:42 +0800
Message-ID: <20210902121242.41607-6-linmiaohe@huawei.com>
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

Don't use with __GFP_HIGHMEM because page_address() cannot represent
highmem pages without kmap(). Newly allocated pages would leak as
page_address() will return NULL for highmem pages here. But It works
now because the callers do not specify __GFP_HIGHMEM now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9c09dcb24149..e1d0e27d005a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5614,8 +5614,8 @@ void *alloc_pages_exact(size_t size, gfp_t gfp_mask)
 	unsigned int order = get_order(size);
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(gfp_mask & __GFP_COMP))
-		gfp_mask &= ~__GFP_COMP;
+	if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
+		gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
 
 	addr = __get_free_pages(gfp_mask, order);
 	return make_alloc_exact(addr, order, size);
@@ -5639,8 +5639,8 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask)
 	unsigned int order = get_order(size);
 	struct page *p;
 
-	if (WARN_ON_ONCE(gfp_mask & __GFP_COMP))
-		gfp_mask &= ~__GFP_COMP;
+	if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
+		gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
 
 	p = alloc_pages_node(nid, gfp_mask, order);
 	if (!p)
-- 
2.23.0

