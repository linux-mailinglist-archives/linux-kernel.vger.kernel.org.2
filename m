Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB13633CB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhCPC3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:29:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13959 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhCPC2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:28:41 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dzxxf74qLzrWhd;
        Tue, 16 Mar 2021 10:26:46 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Mar 2021
 10:28:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 5/5] mm/hugetlb: avoid calculating fault_mutex_hash in truncate_op case
Date:   Mon, 15 Mar 2021 22:27:58 -0400
Message-ID: <20210316022758.52993-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fault_mutex hashing overhead can be avoided in truncate_op case
because page faults can not race with truncation in this routine.  So
calculate hash for fault_mutex only in !truncate_op case to save some cpu
cycles.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
---
v1->v2:
remove unnecessary initialization for variable hash
collect Reviewed-by tag from Mike Kravetz
---
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c262566f7c5d..f7ec94bc7337 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -485,7 +485,6 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			u32 hash;
 
 			index = page->index;
-			hash = hugetlb_fault_mutex_hash(mapping, index);
 			if (!truncate_op) {
 				/*
 				 * Only need to hold the fault mutex in the
@@ -493,6 +492,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 				 * page faults.  Races are not possible in the
 				 * case of truncation.
 				 */
+				hash = hugetlb_fault_mutex_hash(mapping, index);
 				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			}
 
-- 
2.19.1

