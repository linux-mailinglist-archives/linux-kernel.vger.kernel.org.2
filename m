Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA6833ED9F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCQJ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:56:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14390 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhCQJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:56:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F0lr913WxzkZvM;
        Wed, 17 Mar 2021 17:54:49 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 17:56:11 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: don't start checkpoint thread in readonly mountpoint
Date:   Wed, 17 Mar 2021 17:56:03 +0800
Message-ID: <20210317095604.125820-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In readonly mountpoint, there should be no write IOs include checkpoint
IO, so that it's not needed to create kernel checkpoint thread.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ce88db0170fa..6716af216dca 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2091,8 +2091,10 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
-	if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
-			test_opt(sbi, MERGE_CHECKPOINT)) {
+	if ((*flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
+			!test_opt(sbi, MERGE_CHECKPOINT)) {
+		f2fs_stop_ckpt_thread(sbi);
+	} else {
 		err = f2fs_start_ckpt_thread(sbi);
 		if (err) {
 			f2fs_err(sbi,
@@ -2100,8 +2102,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			    err);
 			goto restore_gc;
 		}
-	} else {
-		f2fs_stop_ckpt_thread(sbi);
 	}
 
 	/*
@@ -3857,7 +3857,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* setup checkpoint request control and start checkpoint issue thread */
 	f2fs_init_ckpt_req_control(sbi);
-	if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
+	if (!f2fs_readonly(sb) && !test_opt(sbi, DISABLE_CHECKPOINT) &&
 			test_opt(sbi, MERGE_CHECKPOINT)) {
 		err = f2fs_start_ckpt_thread(sbi);
 		if (err) {
-- 
2.29.2

