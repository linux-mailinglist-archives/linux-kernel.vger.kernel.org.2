Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAB3342C72
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCTLpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:45:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14835 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCTLpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:45:10 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F2bH72JBpz91CR;
        Sat, 20 Mar 2021 17:36:03 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 20 Mar 2021
 17:37:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/5] mm/migrate.c: use helper migrate_vma_collect_skip() in migrate_vma_collect_hole()
Date:   Sat, 20 Mar 2021 05:37:00 -0400
Message-ID: <20210320093701.12829-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210320093701.12829-1-linmiaohe@huawei.com>
References: <20210320093701.12829-1-linmiaohe@huawei.com>
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

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 271081b014cb..3e169b72d7b2 100644
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

