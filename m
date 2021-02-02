Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F80530BB3B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBBJmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:42:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12101 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBBJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:41:03 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVKWq2QL5z162cM;
        Tue,  2 Feb 2021 17:39:03 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 17:40:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Dehe Gu <gudehe@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Ge Qiu <qiuge@huawei.com>
Subject: [PATCH] f2fs: fix a wrong condition in __submit_bio
Date:   Tue, 2 Feb 2021 17:39:22 +0800
Message-ID: <20210202093922.64273-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dehe Gu <gudehe@huawei.com>

We should use !F2FS_IO_ALIGNED() to check and submit_io directly.

Fixes: 8223ecc456d0 ("f2fs: fix to add missing F2FS_IO_ALIGNED() condition")
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Dehe Gu <gudehe@huawei.com>
Signed-off-by: Ge Qiu <qiuge@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 38476d0d3916..1ee966a63df9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -470,7 +470,7 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 		if (f2fs_lfs_mode(sbi) && current->plug)
 			blk_finish_plug(current->plug);
 
-		if (F2FS_IO_ALIGNED(sbi))
+		if (!F2FS_IO_ALIGNED(sbi))
 			goto submit_io;
 
 		start = bio->bi_iter.bi_size >> F2FS_BLKSIZE_BITS;
-- 
2.29.2

