Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975B433D414
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhCPMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:41:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13966 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhCPMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:40:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F0CX43NrQzrXBF;
        Tue, 16 Mar 2021 20:39:00 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Mar 2021
 20:40:45 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <willy@infradead.org>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <peterx@redhat.com>, <yulei.kernel@gmail.com>, <walken@google.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <thomas_os@shipmail.org>, <yang.shi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 2/6] mm/huge_memory.c: make get_huge_zero_page() return bool
Date:   Tue, 16 Mar 2021 08:40:03 -0400
Message-ID: <20210316124007.20474-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210316124007.20474-1-linmiaohe@huawei.com>
References: <20210316124007.20474-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's guaranteed that huge_zero_page will not be NULL if huge_zero_refcount
is increased successfully. When READ_ONCE(huge_zero_page) is returned,
there must be a huge_zero_page and it can be replaced with returning 'true'
when we do not care about the value of huge_zero_page. We can thus make it
return bool to save READ_ONCE cpu cycles as the return value is just used
to check if huge_zero_page exists.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e943ccbdc9dd..caad9942c693 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -77,18 +77,18 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
-static struct page *get_huge_zero_page(void)
+static bool get_huge_zero_page(void)
 {
 	struct page *zero_page;
 retry:
 	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
-		return READ_ONCE(huge_zero_page);
+		return true;
 
 	zero_page = alloc_pages((GFP_TRANSHUGE | __GFP_ZERO) & ~__GFP_MOVABLE,
 			HPAGE_PMD_ORDER);
 	if (!zero_page) {
 		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
-		return NULL;
+		return false;
 	}
 	count_vm_event(THP_ZERO_PAGE_ALLOC);
 	preempt_disable();
@@ -101,7 +101,7 @@ static struct page *get_huge_zero_page(void)
 	/* We take additional reference here. It will be put back by shrinker */
 	atomic_set(&huge_zero_refcount, 2);
 	preempt_enable();
-	return READ_ONCE(huge_zero_page);
+	return true;
 }
 
 static void put_huge_zero_page(void)
-- 
2.19.1

