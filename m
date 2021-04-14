Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50135EA54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 03:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349026AbhDNBWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 21:22:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16908 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348988AbhDNBWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 21:22:10 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FKl5631RNzlY6m;
        Wed, 14 Apr 2021 09:19:54 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 09:21:37 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to cover allocate_segment() with lock
Date:   Wed, 14 Apr 2021 09:21:34 +0800
Message-ID: <20210414012134.128066-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we did for other cases, in fix_curseg_write_pointer(), let's
change as below:
- use callback function s_ops->allocate_segment() instead of
raw function allocate_segment_by_default();
- cover allocate_segment() with curseg_lock and sentry_lock.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b2ee6b7791b0..daf9531ec58f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4848,7 +4848,12 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 
 	f2fs_notice(sbi, "Assign new section to curseg[%d]: "
 		    "curseg[0x%x,0x%x]", type, cs->segno, cs->next_blkoff);
-	allocate_segment_by_default(sbi, type, true);
+
+	down_read(&SM_I(sbi)->curseg_lock);
+	down_write(&SIT_I(sbi)->sentry_lock);
+	SIT_I(sbi)->s_ops->allocate_segment(sbi, type, true);
+	up_write(&SIT_I(sbi)->sentry_lock);
+	up_read(&SM_I(sbi)->curseg_lock);
 
 	/* check consistency of the zone curseg pointed to */
 	if (check_zone_write_pointer(sbi, zbd, &zone))
-- 
2.29.2

