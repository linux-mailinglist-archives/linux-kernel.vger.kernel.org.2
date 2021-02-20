Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA53204C4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhBTJjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:39:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12628 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTJji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:39:38 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DjNdc0V3Dz1695F;
        Sat, 20 Feb 2021 17:37:24 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 17:38:46 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: update comments for explicit memory barrier
Date:   Sat, 20 Feb 2021 17:38:43 +0800
Message-ID: <20210220093843.64379-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210220093843.64379-1-yuchao0@huawei.com>
References: <20210220093843.64379-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more detailed comments for explicit memory barrier used by
f2fs, in order to enhance code readability.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 6 +++++-
 fs/f2fs/segment.c    | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 174a0819ad96..c75866cd72fa 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1818,7 +1818,11 @@ int f2fs_issue_checkpoint(struct f2fs_sb_info *sbi)
 	llist_add(&req.llnode, &cprc->issue_list);
 	atomic_inc(&cprc->queued_ckpt);
 
-	/* update issue_list before we wake up issue_checkpoint thread */
+	/*
+	 * update issue_list before we wake up issue_checkpoint thread,
+	 * this smp_mb() pairs with another barrier in ___wait_event(),
+	 * see more details in comments of waitqueue_active().
+	 */
 	smp_mb();
 
 	if (waitqueue_active(&cprc->ckpt_wait_queue))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2190910c68b0..2d5a82c4ca15 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -663,7 +663,11 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 
 	llist_add(&cmd.llnode, &fcc->issue_list);
 
-	/* update issue_list before we wake up issue_flush thread */
+	/*
+	 * update issue_list before we wake up issue_flush thread, this
+	 * smp_mb() pairs with another barrier in ___wait_event(), see
+	 * more details in comments of waitqueue_active().
+	 */
 	smp_mb();
 
 	if (waitqueue_active(&fcc->flush_wait_queue))
-- 
2.29.2

