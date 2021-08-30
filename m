Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C9F3FB796
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhH3OLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:11:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8799 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhH3OLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:11:20 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gysdh18HSzYvS8;
        Mon, 30 Aug 2021 22:09:44 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 30
 Aug 2021 22:10:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 6/6] mm/page_alloc.c: avoid allocating highmem pages via alloc_pages_exact_nid()
Date:   Mon, 30 Aug 2021 22:10:51 +0800
Message-ID: <20210830141051.64090-7-linmiaohe@huawei.com>
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

Don't use with __GFP_HIGHMEM because page_address() cannot represent
highmem pages without kmap(). Newly allocated pages would leak as
page_address() will return NULL for highmem pages here. But It works
now because the only caller does not specify __GFP_HIGHMEM now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d87b7e6e9e6b..858fd45ecaea 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5639,7 +5639,7 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask)
 	if (WARN_ON_ONCE(gfp_mask & __GFP_COMP))
 		gfp_mask &= ~__GFP_COMP;
 
-	p = alloc_pages_node(nid, gfp_mask, order);
+	p = alloc_pages_node(nid, gfp_mask & ~__GFP_HIGHMEM, order);
 	if (!p)
 		return NULL;
 	return make_alloc_exact((unsigned long)page_address(p), order, size);
-- 
2.23.0

