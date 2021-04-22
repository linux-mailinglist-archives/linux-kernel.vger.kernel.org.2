Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15482367E84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhDVKU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:20:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16150 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhDVKUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:20:24 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FQtcv0LT0zpZh0;
        Thu, 22 Apr 2021 18:16:47 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 22 Apr 2021 18:19:38 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: drop inplace IO if fs status is abnormal
Date:   Thu, 22 Apr 2021 18:19:25 +0800
Message-ID: <20210422101925.108345-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If filesystem has cp_error or need_fsck status, let's drop inplace IO
to avoid further corruption of fs data.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6e740ecf0814..3de119e5c934 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3551,7 +3551,13 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: incorrect segment(%u) type, run fsck to fix.",
 			  __func__, segno);
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto drop_bio;
+	}
+
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_cp_error(sbi)) {
+		err = -EIO;
+		goto drop_bio;
 	}
 
 	stat_inc_inplace_blocks(fio->sbi);
@@ -3565,6 +3571,15 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
 	}
 
+	return err;
+drop_bio:
+	if (fio->bio) {
+		struct bio *bio = *(fio->bio);
+
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+		fio->bio = NULL;
+	}
 	return err;
 }
 
-- 
2.29.2

