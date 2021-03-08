Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1C330C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhCHL3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:29:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13143 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhCHL2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:28:49 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DvGJj182xz16Hlh;
        Mon,  8 Mar 2021 19:27:01 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Mar 2021
 19:28:37 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/5] mm/hugetlb: optimize the surplus state transfer code in move_hugetlb_state()
Date:   Mon, 8 Mar 2021 06:28:06 -0500
Message-ID: <20210308112809.26107-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210308112809.26107-1-linmiaohe@huawei.com>
References: <20210308112809.26107-1-linmiaohe@huawei.com>
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

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 33a3edf79022..695603071f2c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5621,6 +5621,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
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

