Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70F530A342
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhBAIZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:25:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11651 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhBAIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:25:16 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTgtH4B55z162Vx;
        Mon,  1 Feb 2021 16:22:47 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 16:23:55 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] hugetlbfs: rework calculation code of Hugepage size in hugetlbfs_show_options()
Date:   Mon, 1 Feb 2021 03:23:25 -0500
Message-ID: <20210201082325.33875-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework calculation code of the Hugepage size to make it more readable and
straightforward.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3a08fbae3b53..1be18de4b537 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1014,11 +1014,12 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
 	if (sbinfo->max_inodes != -1)
 		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
 
-	hpage_size /= 1024;
-	mod = 'K';
-	if (hpage_size >= 1024) {
-		hpage_size /= 1024;
+	if (hpage_size >= SZ_1M) {
+		hpage_size /= SZ_1M;
 		mod = 'M';
+	} else {
+		hpage_size /= SZ_1K;
+		mod = 'K';
 	}
 	seq_printf(m, ",pagesize=%lu%c", hpage_size, mod);
 	if (spool) {
-- 
2.19.1

