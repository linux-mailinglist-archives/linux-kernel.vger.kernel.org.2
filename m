Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E3312C2E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBHIsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:48:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12486 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhBHIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:38:56 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYzs14QH2zjL2F;
        Mon,  8 Feb 2021 16:36:37 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Feb 2021
 16:37:52 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hugetlb: Remove redundant VM_BUG_ON_PAGE on putback_active_hugepage()
Date:   Mon, 8 Feb 2021 03:37:39 -0500
Message-ID: <20210208083739.33178-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PageHead(page) is implicitly checked in set_page_huge_active() via the
PageHeadHuge(page) check. So remove this explicit one.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6cdb59d8f663..bbbe013a3a2d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5577,7 +5577,6 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 
 void putback_active_hugepage(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageHead(page), page);
 	spin_lock(&hugetlb_lock);
 	SetHPageMigratable(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
-- 
2.19.1

