Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE00030935A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhA3J2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:28:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12368 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhA3JYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:24:14 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSSsf6G7Rz7d9g;
        Sat, 30 Jan 2021 17:03:02 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Sat, 30 Jan 2021
 17:03:48 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] hugetlbfs: show pagesize in unit of GB if possible
Date:   Sat, 30 Jan 2021 04:03:39 -0500
Message-ID: <20210130090339.4378-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugepage size in unit of GB is supported. We could show pagesize in unit of
GB to make it more friendly to read. Also rework the calculation code of
page size unit to make it more readable.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3a08fbae3b53..40a9795f250a 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1014,11 +1014,15 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
 	if (sbinfo->max_inodes != -1)
 		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
 
-	hpage_size /= 1024;
-	mod = 'K';
-	if (hpage_size >= 1024) {
-		hpage_size /= 1024;
+	if (hpage_size >= SZ_1G) {
+		hpage_size /= SZ_1G;
+		mod = 'G';
+	} else if (hpage_size >= SZ_1M) {
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

