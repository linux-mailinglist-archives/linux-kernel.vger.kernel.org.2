Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2632C32F81A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 04:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCFDap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 22:30:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13478 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCFDaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 22:30:23 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dsqnc4N6TzjWtq;
        Sat,  6 Mar 2021 11:28:36 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 6 Mar 2021
 11:30:14 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>
CC:     <riel@redhat.com>, <ebru.akagunduz@gmail.com>,
        <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 1/4] khugepaged: remove unneeded return value of khugepaged_collapse_pte_mapped_thps()
Date:   Fri, 5 Mar 2021 22:29:44 -0500
Message-ID: <20210306032947.35921-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210306032947.35921-1-linmiaohe@huawei.com>
References: <20210306032947.35921-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of khugepaged_collapse_pte_mapped_thps() is never checked
since it's introduced. We should remove such unneeded return value.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a7d6cb912b05..d43812c5ce16 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1533,16 +1533,16 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	goto drop_hpage;
 }
 
-static int khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
+static void khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
 {
 	struct mm_struct *mm = mm_slot->mm;
 	int i;
 
 	if (likely(mm_slot->nr_pte_mapped_thp == 0))
-		return 0;
+		return;
 
 	if (!mmap_write_trylock(mm))
-		return -EBUSY;
+		return;
 
 	if (unlikely(khugepaged_test_exit(mm)))
 		goto out;
@@ -1553,7 +1553,6 @@ static int khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
 out:
 	mm_slot->nr_pte_mapped_thp = 0;
 	mmap_write_unlock(mm);
-	return 0;
 }
 
 static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
@@ -2057,9 +2056,8 @@ static void khugepaged_scan_file(struct mm_struct *mm,
 	BUILD_BUG();
 }
 
-static int khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
+static void khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
 {
-	return 0;
 }
 #endif
 
-- 
2.19.1

