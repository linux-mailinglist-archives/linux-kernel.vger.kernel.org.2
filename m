Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD65346064
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhCWNz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:55:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14510 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhCWNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:54:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4XqS6PyRzPkFt;
        Tue, 23 Mar 2021 21:52:20 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 21:54:45 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>, <aquini@redhat.com>,
        <david@redhat.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 4/5] mm/migrate.c: use helper migrate_vma_collect_skip() in migrate_vma_collect_hole()
Date:   Tue, 23 Mar 2021 09:54:04 -0400
Message-ID: <20210323135405.65059-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210323135405.65059-1-linmiaohe@huawei.com>
References: <20210323135405.65059-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more recommended to use helper function migrate_vma_collect_skip() to
skip the unexpected case and it also helps remove some duplicated codes.
Move migrate_vma_collect_skip() above migrate_vma_collect_hole() to avoid
compiler warning.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d372be3da9b2..5357a8527ca2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2315,44 +2315,38 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_DEVICE_PRIVATE
-static int migrate_vma_collect_hole(unsigned long start,
+static int migrate_vma_collect_skip(unsigned long start,
 				    unsigned long end,
-				    __always_unused int depth,
 				    struct mm_walk *walk)
 {
 	struct migrate_vma *migrate = walk->private;
 	unsigned long addr;
 
-	/* Only allow populating anonymous memory. */
-	if (!vma_is_anonymous(walk->vma)) {
-		for (addr = start; addr < end; addr += PAGE_SIZE) {
-			migrate->src[migrate->npages] = 0;
-			migrate->dst[migrate->npages] = 0;
-			migrate->npages++;
-		}
-		return 0;
-	}
-
 	for (addr = start; addr < end; addr += PAGE_SIZE) {
-		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
 		migrate->dst[migrate->npages] = 0;
-		migrate->npages++;
-		migrate->cpages++;
+		migrate->src[migrate->npages++] = 0;
 	}
 
 	return 0;
 }
 
-static int migrate_vma_collect_skip(unsigned long start,
+static int migrate_vma_collect_hole(unsigned long start,
 				    unsigned long end,
+				    __always_unused int depth,
 				    struct mm_walk *walk)
 {
 	struct migrate_vma *migrate = walk->private;
 	unsigned long addr;
 
+	/* Only allow populating anonymous memory. */
+	if (!vma_is_anonymous(walk->vma))
+		return migrate_vma_collect_skip(start, end, walk);
+
 	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
 		migrate->dst[migrate->npages] = 0;
-		migrate->src[migrate->npages++] = 0;
+		migrate->npages++;
+		migrate->cpages++;
 	}
 
 	return 0;
-- 
2.19.1

