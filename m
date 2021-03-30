Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67F034E9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhC3ODo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:03:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15044 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhC3ODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:03:22 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8rgq6MTlzPmtV;
        Tue, 30 Mar 2021 22:00:39 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 22:03:08 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/4] ksm: use GET_KSM_PAGE_NOLOCK to get ksm page in remove_rmap_item_from_tree()
Date:   Tue, 30 Mar 2021 10:02:26 -0400
Message-ID: <20210330140228.45635-3-linmiaohe@huawei.com>
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

It's unnecessary to lock the page when get ksm page if we're going to
remove the rmap item as page migration is irrelevant in this case. Use
GET_KSM_PAGE_NOLOCK instead to save some page lock cycles.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/ksm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 359afb3023b4..5650a282da3e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -778,12 +778,11 @@ static void remove_rmap_item_from_tree(struct rmap_item *rmap_item)
 		struct page *page;
 
 		stable_node = rmap_item->head;
-		page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
+		page = get_ksm_page(stable_node, GET_KSM_PAGE_NOLOCK);
 		if (!page)
 			goto out;
 
 		hlist_del(&rmap_item->hlist);
-		unlock_page(page);
 		put_page(page);
 
 		if (!hlist_empty(&stable_node->hlist))
-- 
2.19.1

