Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237A934E9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhC3ODp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:03:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15046 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhC3ODV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:03:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8rgq5jH7zPmt5;
        Tue, 30 Mar 2021 22:00:39 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 22:03:09 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/4] ksm: fix potential missing rmap_item for stable_node
Date:   Tue, 30 Mar 2021 10:02:28 -0400
Message-ID: <20210330140228.45635-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210330140228.45635-1-linmiaohe@huawei.com>
References: <20210330140228.45635-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When remove rmap_item from stable tree, STABLE_FLAG of rmap_item is cleared
with head reserved. So the following scenario might happen:
For ksm page with rmap_item1:
cmp_and_merge_page
  stable_node->head = &migrate_nodes;
  remove_rmap_item_from_tree, but head still equal to stable_node;
  try_to_merge_with_ksm_page failed;
  return;
For the same ksm page with rmap_item2, stable node migration succeed this
time. The stable_node->head does not equal to migrate_nodes now.
For ksm page with rmap_item1 again:
cmp_and_merge_page
 stable_node->head != &migrate_nodes && rmap_item->head == stable_node
 return;
We would miss the rmap_item for stable_node and might result in failed
rmap_walk_ksm(). Fix this by set rmap_item->head to NULL when rmap_item
is removed from stable tree.

Fixes: 4146d2d673e8 ("ksm: make !merge_across_nodes migration safe")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/ksm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index f9ca6d94bf7f..8609c67f04a2 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -791,6 +791,7 @@ static void remove_rmap_item_from_tree(struct rmap_item *rmap_item)
 		stable_node->rmap_hlist_len--;
 
 		put_anon_vma(rmap_item->anon_vma);
+		rmap_item->head = NULL;
 		rmap_item->address &= PAGE_MASK;
 
 	} else if (rmap_item->address & UNSTABLE_FLAG) {
-- 
2.19.1

