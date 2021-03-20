Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084D8342C74
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhCTLpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:45:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14833 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhCTLpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:45:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F2bH71zxzz919q;
        Sat, 20 Mar 2021 17:36:03 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 20 Mar 2021
 17:37:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/5] mm/migrate.c: fix potential deadlock in NUMA balancing shared exec THP case
Date:   Sat, 20 Mar 2021 05:37:01 -0400
Message-ID: <20210320093701.12829-6-linmiaohe@huawei.com>
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

Since commit c77c5cbafe54 ("mm: migrate: skip shared exec THP for NUMA
balancing"), the NUMA balancing would skip shared exec transhuge page.
But this enhancement is not suitable for transhuge page. Because it's
required that page_mapcount() must be 1 due to no migration pte dance
is done here. On the other hand, the shared exec transhuge page will
leave the migrate_misplaced_page() with pte entry untouched and page
locked. Thus pagefault for NUMA will be triggered again and deadlock
occurs when we start waiting for the page lock held by ourselves.

Fixes: c77c5cbafe54 ("mm: migrate: skip shared exec THP for NUMA balancing")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 3e169b72d7b2..67a941c52b6d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2192,9 +2192,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	int page_lru = page_is_file_lru(page);
 	unsigned long start = address & HPAGE_PMD_MASK;
 
-	if (is_shared_exec_page(vma, page))
-		goto out;
-
 	new_page = alloc_pages_node(node,
 		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
 		HPAGE_PMD_ORDER);
@@ -2306,7 +2303,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 
 out_unlock:
 	unlock_page(page);
-out:
 	put_page(page);
 	return 0;
 }
-- 
2.19.1

