Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95E3107CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhBEJ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:26:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11684 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBEJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:23:21 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DX8zP4JHNzlH8q;
        Fri,  5 Feb 2021 17:20:49 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Feb 2021
 17:22:21 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hugetlb: use helper huge_page_size() to simplify the hugetlb_vm_op_pagesize()
Date:   Fri, 5 Feb 2021 04:22:09 -0500
Message-ID: <20210205092209.16024-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use helper huge_page_size() to get the size of the pages allocated
when backing a VMA directly to make the code more simplified.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 18628f8dbfb0..3eea2a34d9f5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3647,9 +3647,7 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 
 static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
 {
-	struct hstate *hstate = hstate_vma(vma);
-
-	return 1UL << huge_page_shift(hstate);
+	return huge_page_size(hstate_vma(vma));
 }
 
 /*
-- 
2.19.1

