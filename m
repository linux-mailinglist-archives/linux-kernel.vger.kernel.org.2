Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68F3528D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhDBJdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:33:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14686 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDBJdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:33:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FBZYJ4bH1znYFG;
        Fri,  2 Apr 2021 17:31:00 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 17:33:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <n-horiguchi@ah.jp.nec.com>, <hillf.zj@alibaba-inc.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/4] mm/hugeltb: remove redundant VM_BUG_ON() in region_add()
Date:   Fri, 2 Apr 2021 05:32:46 -0400
Message-ID: <20210402093249.25137-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210402093249.25137-1-linmiaohe@huawei.com>
References: <20210402093249.25137-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same VM_BUG_ON() check is already done in the callee. Remove this extra
one to simplify the code slightly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c22111f3da20..a03a50b7c410 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -556,7 +556,6 @@ static long region_add(struct resv_map *resv, long f, long t,
 	resv->adds_in_progress -= in_regions_needed;
 
 	spin_unlock(&resv->lock);
-	VM_BUG_ON(add < 0);
 	return add;
 }
 
-- 
2.19.1

