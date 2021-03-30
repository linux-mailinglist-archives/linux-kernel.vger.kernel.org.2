Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DD34E9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhC3ODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:03:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14639 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhC3ODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:03:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8rgr38ZTznWHt;
        Tue, 30 Mar 2021 22:00:40 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 22:03:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/4] ksm: remove redundant VM_BUG_ON_PAGE() on stable_tree_search()
Date:   Tue, 30 Mar 2021 10:02:25 -0400
Message-ID: <20210330140228.45635-2-linmiaohe@huawei.com>
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

The same VM_BUG_ON_PAGE() check is already done in the callee. Remove these
extra caller one to simplify code slightly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/ksm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 1f2c62e1d797..359afb3023b4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1771,7 +1771,6 @@ static struct page *stable_tree_search(struct page *page)
 	 * stable_node_dup is the dup to replace.
 	 */
 	if (stable_node_dup == stable_node) {
-		VM_BUG_ON(is_stable_node_chain(stable_node_dup));
 		VM_BUG_ON(is_stable_node_dup(stable_node_dup));
 		/* chain is missing so create it */
 		stable_node = alloc_stable_node_chain(stable_node_dup,
@@ -1785,7 +1784,6 @@ static struct page *stable_tree_search(struct page *page)
 	 * of the current nid for this page
 	 * content.
 	 */
-	VM_BUG_ON(!is_stable_node_chain(stable_node));
 	VM_BUG_ON(!is_stable_node_dup(stable_node_dup));
 	VM_BUG_ON(page_node->head != &migrate_nodes);
 	list_del(&page_node->list);
-- 
2.19.1

