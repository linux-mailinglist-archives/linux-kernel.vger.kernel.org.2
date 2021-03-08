Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCBE330C61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhCHL30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:29:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13142 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhCHL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:28:50 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DvGJj1M5Xz17HFW;
        Mon,  8 Mar 2021 19:27:01 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Mar 2021
 19:28:40 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/5] mm/hugetlb: avoid calculating fault_mutex_hash in truncate_op case
Date:   Mon, 8 Mar 2021 06:28:09 -0500
Message-ID: <20210308112809.26107-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210308112809.26107-1-linmiaohe@huawei.com>
References: <20210308112809.26107-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fault_mutex hashing overhead can be avoided in truncate_op case because
page faults can not race with truncation in this routine. So calculate hash
for fault_mutex only in !truncate_op case to save some cpu cycles.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
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

