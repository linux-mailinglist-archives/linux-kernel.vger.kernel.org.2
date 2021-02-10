Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6083315FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhBJHOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:14:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12888 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhBJHN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:13:58 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Db9tJ5LwXz7jRW;
        Wed, 10 Feb 2021 15:11:52 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Wed, 10 Feb 2021
 15:13:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hugetlb: optimize the surplus state transfer code in move_hugetlb_state()
Date:   Wed, 10 Feb 2021 02:12:51 -0500
Message-ID: <20210210071251.44084-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not transfer the per-node surplus state when we do not cross the
node in order to save some cpu cycles

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da347047ea10..4f2c92ddbca4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5632,6 +5632,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		SetHPageTemporary(oldpage);
 		ClearHPageTemporary(newpage);
 
+		/*
+		 * There is no need to transfer the per-node surplus state
+		 * when we do not cross the node.
+		 */
+		if (new_nid == old_nid)
+			return;
 		spin_lock(&hugetlb_lock);
 		if (h->surplus_huge_pages_node[old_nid]) {
 			h->surplus_huge_pages_node[old_nid]--;
-- 
2.19.1

