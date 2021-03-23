Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA1345CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhCWLcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:32:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13667 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCWLb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:31:56 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4TfX4JfGznV8x;
        Tue, 23 Mar 2021 19:29:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 19:31:52 +0800
From:   qiulaibin <qiulaibin@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] f2fs: fix wrong comment of nat_tree_lock
Date:   Tue, 23 Mar 2021 19:41:30 +0800
Message-ID: <20210323114130.2288596-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do trivial comment fix of nat_tree_lock.

Signed-off-by: qiulaibin <qiulaibin@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 165bfe2a5a0e..eb154d9cb063 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -865,7 +865,7 @@ struct f2fs_nm_info {
 	/* NAT cache management */
 	struct radix_tree_root nat_root;/* root of the nat entry cache */
 	struct radix_tree_root nat_set_root;/* root of the nat set cache */
-	struct rw_semaphore nat_tree_lock;	/* protect nat_tree_lock */
+	struct rw_semaphore nat_tree_lock;	/* protect nat entry tree */
 	struct list_head nat_entries;	/* cached nat entry list (clean) */
 	spinlock_t nat_list_lock;	/* protect clean nat entry list */
 	unsigned int nat_cnt[MAX_NAT_STATE]; /* the # of cached nat entries */
-- 
2.25.1

