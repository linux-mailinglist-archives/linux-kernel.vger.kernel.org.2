Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C3335ABA2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhDJHZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:25:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16515 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbhDJHZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:25:04 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FHRJk5xzLzNvPW;
        Sat, 10 Apr 2021 15:21:58 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 10 Apr 2021
 15:24:38 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH v2 5/5] mm/hugetlb: remove unused variable pseudo_vma in remove_inode_hugepages()
Date:   Sat, 10 Apr 2021 03:23:48 -0400
Message-ID: <20210410072348.20437-6-linmiaohe@huawei.com>
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

The local variable pseudo_vma is not used anymore.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d81f52b87bd7..a2a42335e8fd 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -463,14 +463,11 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> huge_page_shift(h);
 	const pgoff_t end = lend >> huge_page_shift(h);
-	struct vm_area_struct pseudo_vma;
 	struct pagevec pvec;
 	pgoff_t next, index;
 	int i, freed = 0;
 	bool truncate_op = (lend == LLONG_MAX);
 
-	vma_init(&pseudo_vma, current->mm);
-	pseudo_vma.vm_flags = (VM_HUGETLB | VM_MAYSHARE | VM_SHARED);
 	pagevec_init(&pvec);
 	next = start;
 	while (next < end) {
-- 
2.19.1

