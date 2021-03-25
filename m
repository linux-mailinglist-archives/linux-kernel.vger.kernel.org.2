Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52525349377
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhCYN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:57:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14598 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhCYN5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:57:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5mpC6rNKz19HbB;
        Thu, 25 Mar 2021 21:55:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 21:57:24 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/3] khugepaged: remove unnecessary out label in collapse_huge_page()
Date:   Thu, 25 Mar 2021 09:56:46 -0400
Message-ID: <20210325135647.64106-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210325135647.64106-1-linmiaohe@huawei.com>
References: <20210325135647.64106-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The out label here is unneeded because it just goes to out_up_write label.
Remove it to make code more concise.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/khugepaged.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ad0444f3f487..58466af69e70 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1128,10 +1128,10 @@ static void collapse_huge_page(struct mm_struct *mm,
 	mmap_write_lock(mm);
 	result = hugepage_vma_revalidate(mm, address, &vma);
 	if (result)
-		goto out;
+		goto out_up_write;
 	/* check if the pmd is still valid */
 	if (mm_find_pmd(mm, address) != pmd)
-		goto out;
+		goto out_up_write;
 
 	anon_vma_lock_write(vma->anon_vma);
 
@@ -1171,7 +1171,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 		spin_unlock(pmd_ptl);
 		anon_vma_unlock_write(vma->anon_vma);
 		result = SCAN_FAIL;
-		goto out;
+		goto out_up_write;
 	}
 
 	/*
@@ -1215,8 +1215,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 		mem_cgroup_uncharge(*hpage);
 	trace_mm_collapse_huge_page(mm, isolated, result);
 	return;
-out:
-	goto out_up_write;
 }
 
 static int khugepaged_scan_pmd(struct mm_struct *mm,
-- 
2.19.1

