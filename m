Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDA230F248
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhBDLdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:33:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12422 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbhBDLaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:30:55 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DWbsx3h30zjHsJ;
        Thu,  4 Feb 2021 19:29:09 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Feb 2021
 19:30:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hugetlb: use helper function range_in_vma() in page_table_shareable()
Date:   Thu, 4 Feb 2021 06:29:49 -0500
Message-ID: <20210204112949.43051-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We could use helper function range_in_vma() to check whether the vma is in
the desired range to simplify the code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cf82629319ed..442705be052a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5237,7 +5237,7 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	 */
 	if (pmd_index(addr) != pmd_index(saddr) ||
 	    vm_flags != svm_flags ||
-	    sbase < svma->vm_start || svma->vm_end < s_end)
+	    !range_in_vma(svma, sbase, s_end))
 		return 0;
 
 	return saddr;
-- 
2.19.1

