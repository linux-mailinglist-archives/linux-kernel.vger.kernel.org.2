Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5AC30F1E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhBDLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:17:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12421 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbhBDLQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:16:01 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DWbXl3GjZzjHn9;
        Thu,  4 Feb 2021 19:14:15 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Feb 2021
 19:15:12 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hugetlb: Remove obsolete comment in vma_has_reserves()
Date:   Thu, 4 Feb 2021 06:15:00 -0500
Message-ID: <20210204111500.24111-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared mappings are allowed to be created without reservations since
commit c37f9fb11c97 ("hugetlb: allow huge page mappings to be created
without reservations"). Remove this obsolete comment which may cause
confusing.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9501ec6ad517..cf82629319ed 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -998,7 +998,6 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 			return false;
 	}
 
-	/* Shared mappings always use reserves */
 	if (vma->vm_flags & VM_MAYSHARE) {
 		/*
 		 * We know VM_NORESERVE is not set.  Therefore, there SHOULD
-- 
2.19.1

