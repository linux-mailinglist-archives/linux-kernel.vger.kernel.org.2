Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0CD32CDDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhCDHoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:44:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13430 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhCDHng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:43:36 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DrjVM2BJyzjV7R;
        Thu,  4 Mar 2021 15:41:31 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Mar 2021
 15:42:44 +0800
From:   Zhou Guanghui <zhouguanghui1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <hannes@cmpxchg.org>, <hughd@google.com>,
        <kirill.shutemov@linux.intel.com>, <npiggin@gmail.com>,
        <ziy@nvidia.com>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>, <dingtianhong@huawei.com>,
        <chenweilong@huawei.com>, <rui.xiang@huawei.com>
Subject: [PATCH v2 2/2] mm/memcg: set memcg when split page
Date:   Thu, 4 Mar 2021 07:40:53 +0000
Message-ID: <20210304074053.65527-3-zhouguanghui1@huawei.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210304074053.65527-1-zhouguanghui1@huawei.com>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the split_page function comment, for the non-compound
high order page, the sub-pages must be freed individually. If the
memcg of the fisrt page is valid, the tail pages cannot be uncharged
when be freed.

For example, when alloc_pages_exact is used to allocate 1MB continuous
physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
set). When make_alloc_exact free the unused 1MB and free_pages_exact
free the applied 1MB, actually, only 4KB(one page) is uncharged.

Therefore, the memcg of the tail page needs to be set when split page.

Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..3ed783e25c3c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3310,6 +3310,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, 1 << order);
+	split_page_memcg(page, 1 << order);
 }
 EXPORT_SYMBOL_GPL(split_page);
 
-- 
2.25.0

