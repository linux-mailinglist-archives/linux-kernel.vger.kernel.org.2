Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE9340496
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCRL3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:29:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13191 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhCRL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:28:50 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1PqN00jHzmZSt;
        Thu, 18 Mar 2021 19:26:23 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Mar 2021
 19:28:38 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 5/5] mm/hugetlb: avoid calculating fault_mutex_hash in truncate_op case
Date:   Thu, 18 Mar 2021 07:28:06 -0400
Message-ID: <20210318112806.55774-1-linmiaohe@huawei.com>
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
v2->v3:
keep the initialization in case compilers produce a warning.
Sorry for make noise. :(

v1->v2:
remove unnecessary initialization for variable hash
collect Reviewed-by tag from Mike Kravetz
---
 fs/hugetlbfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c262566f7c5d..d81f52b87bd7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -482,10 +482,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 		for (i = 0; i < pagevec_count(&pvec); ++i) {
 			struct page *page = pvec.pages[i];
-			u32 hash;
+			u32 hash = 0;
 
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

