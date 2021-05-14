Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297513803D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhENHAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:00:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2597 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhENHAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:00:05 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FhK7J14pszkWMp;
        Fri, 14 May 2021 14:56:12 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 14:58:44 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <pulehui@huawei.com>
Subject: [PATCH -next] mm/huge_memory.c: remove unused variable 'count'
Date:   Fri, 14 May 2021 14:59:12 +0800
Message-ID: <20210514065912.71734-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.98]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/huge_memory.c:2663:6: warning:
 variable ‘count’ set but not used [-Wunused-but-set-variable]
  2663 |  int count, mapcount, extra_pins, ret;
       |      ^~~~~

This variable is not used in function , this commit
remove it to fix the warning.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 mm/huge_memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 52ca04b905cf..a23a127302e9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2660,7 +2660,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
-	int count, mapcount, extra_pins, ret;
+	int mapcount, extra_pins, ret;
 	pgoff_t end;
 
 	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
@@ -2737,7 +2737,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
-	count = page_count(head);
 	mapcount = total_mapcount(head);
 	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
-- 
2.17.1

