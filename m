Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF05349378
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCYN5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:57:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14597 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhCYN5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:57:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5mpC5K6nz19Hcc;
        Thu, 25 Mar 2021 21:55:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 21:57:24 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/3] khugepaged: use helper function range_in_vma() in collapse_pte_mapped_thp()
Date:   Thu, 25 Mar 2021 09:56:45 -0400
Message-ID: <20210325135647.64106-2-linmiaohe@huawei.com>
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

We could use helper function range_in_vma() to check whether the desired
range is inside the vma to simplify the code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b81521dfbb1a..ad0444f3f487 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1446,7 +1446,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	int i;
 
 	if (!vma || !vma->vm_file ||
-	    vma->vm_start > haddr || vma->vm_end < haddr + HPAGE_PMD_SIZE)
+	    !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
 		return;
 
 	/*
-- 
2.19.1

