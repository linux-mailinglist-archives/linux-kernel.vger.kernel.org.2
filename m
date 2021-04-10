Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB93A35AB9D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhDJHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:25:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17304 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhDJHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:24:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FHRKK0tJvz9xLy;
        Sat, 10 Apr 2021 15:22:29 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 10 Apr 2021
 15:24:36 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH v2 2/5] mm/hugeltb: simplify the return code of __vma_reservation_common()
Date:   Sat, 10 Apr 2021 03:23:45 -0400
Message-ID: <20210410072348.20437-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210410072348.20437-1-linmiaohe@huawei.com>
References: <20210410072348.20437-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's guaranteed that the vma is associated with a resv_map, i.e. either
VM_MAYSHARE or HPAGE_RESV_OWNER, when the code reaches here or we would
have returned via !resv check above. So it's unneeded to check whether
HPAGE_RESV_OWNER is set here. Simplify the return code to make it more
clear.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a03a50b7c410..9b4c05699a90 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2163,27 +2163,26 @@ static long __vma_reservation_common(struct hstate *h,
 
 	if (vma->vm_flags & VM_MAYSHARE)
 		return ret;
-	else if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) && ret >= 0) {
-		/*
-		 * In most cases, reserves always exist for private mappings.
-		 * However, a file associated with mapping could have been
-		 * hole punched or truncated after reserves were consumed.
-		 * As subsequent fault on such a range will not use reserves.
-		 * Subtle - The reserve map for private mappings has the
-		 * opposite meaning than that of shared mappings.  If NO
-		 * entry is in the reserve map, it means a reservation exists.
-		 * If an entry exists in the reserve map, it means the
-		 * reservation has already been consumed.  As a result, the
-		 * return value of this routine is the opposite of the
-		 * value returned from reserve map manipulation routines above.
-		 */
-		if (ret)
-			return 0;
-		else
-			return 1;
-	}
-	else
-		return ret < 0 ? ret : 0;
+	/*
+	 * We know private mapping must have HPAGE_RESV_OWNER set.
+	 *
+	 * In most cases, reserves always exist for private mappings.
+	 * However, a file associated with mapping could have been
+	 * hole punched or truncated after reserves were consumed.
+	 * As subsequent fault on such a range will not use reserves.
+	 * Subtle - The reserve map for private mappings has the
+	 * opposite meaning than that of shared mappings.  If NO
+	 * entry is in the reserve map, it means a reservation exists.
+	 * If an entry exists in the reserve map, it means the
+	 * reservation has already been consumed.  As a result, the
+	 * return value of this routine is the opposite of the
+	 * value returned from reserve map manipulation routines above.
+	 */
+	if (ret > 0)
+		return 0;
+	if (ret == 0)
+		return 1;
+	return ret;
 }
 
 static long vma_needs_reservation(struct hstate *h,
-- 
2.19.1

