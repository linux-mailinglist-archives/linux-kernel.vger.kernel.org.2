Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4E358438
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhDHNJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:09:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16418 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhDHNJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:09:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGM4L1YkKzkjgH;
        Thu,  8 Apr 2021 21:07:30 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:09:09 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <vbabka@suse.cz>, <alex.shi@linux.alibaba.com>,
        <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <ying.huang@intel.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/5] mm/swap_state: fix get_shadow_from_swap_cache() race with swapoff
Date:   Thu, 8 Apr 2021 09:08:18 -0400
Message-ID: <20210408130820.48233-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210408130820.48233-1-linmiaohe@huawei.com>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function get_shadow_from_swap_cache() can race with swapoff, though
it's only called by do_swap_page() now.

Fixes: aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_state.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 272ea2108c9d..709c260d644a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -83,11 +83,14 @@ void show_swap_cache_info(void)
 
 void *get_shadow_from_swap_cache(swp_entry_t entry)
 {
-	struct address_space *address_space = swap_address_space(entry);
-	pgoff_t idx = swp_offset(entry);
+	struct swap_info_struct *si;
 	struct page *page;
 
-	page = xa_load(&address_space->i_pages, idx);
+	si = get_swap_device(entry);
+	if (!si)
+		return NULL;
+	page = xa_load(&swap_address_space(entry)->i_pages, swp_offset(entry));
+	put_swap_device(si);
 	if (xa_is_value(page))
 		return page;
 	return NULL;
-- 
2.19.1

