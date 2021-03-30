Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6034E740
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhC3MNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:13:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15397 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhC3MNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:13:42 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F8pGS1D3fznTpw;
        Tue, 30 Mar 2021 20:12:00 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 20:13:34 +0800
From:   Chengyang Fan <cy.fan@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cy.fan@huawei.com>
Subject: [PATCH] mm/ksm: remove unused parameter from remove_trailing_rmap_items()
Date:   Tue, 30 Mar 2021 20:13:20 +0800
Message-ID: <20210330121320.1693474-1-cy.fan@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6514d511dbe5 ("ksm: singly-linked rmap_list") was
merged, remove_trailing_rmap_items() doesn't use the 'mm_slot'
parameter. So remove it, and update caller accordingly.

Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
---
 mm/ksm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 9694ee2c71de..dd69f030c8c0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -817,8 +817,7 @@ static void remove_rmap_item_from_tree(struct rmap_item *rmap_item)
 	cond_resched();		/* we're called from many long loops */
 }
 
-static void remove_trailing_rmap_items(struct mm_slot *mm_slot,
-				       struct rmap_item **rmap_list)
+static void remove_trailing_rmap_items(struct rmap_item **rmap_list)
 {
 	while (*rmap_list) {
 		struct rmap_item *rmap_item = *rmap_list;
@@ -989,7 +988,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 				goto error;
 		}
 
-		remove_trailing_rmap_items(mm_slot, &mm_slot->rmap_list);
+		remove_trailing_rmap_items(&mm_slot->rmap_list);
 		mmap_read_unlock(mm);
 
 		spin_lock(&ksm_mmlist_lock);
@@ -2337,7 +2336,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 	 * Nuke all the rmap_items that are above this current rmap:
 	 * because there were no VM_MERGEABLE vmas with such addresses.
 	 */
-	remove_trailing_rmap_items(slot, ksm_scan.rmap_list);
+	remove_trailing_rmap_items(ksm_scan.rmap_list);
 
 	spin_lock(&ksm_mmlist_lock);
 	ksm_scan.mm_slot = list_entry(slot->mm_list.next,
-- 
2.25.1

