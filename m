Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B1532A3CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382546AbhCBJjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:39:45 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:52435 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1837957AbhCBJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:16:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UQ4OqHi_1614676527;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQ4OqHi_1614676527)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Mar 2021 17:15:28 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rpeterso@redhat.com
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] gfs2: Remove unneeded return variable
Date:   Tue,  2 Mar 2021 17:15:26 +0800
Message-Id: <1614676526-102967-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unneeded return variables, using only
'0' instead.
It fixes the following warning detected by coccinelle:
./fs/gfs2/super.c:592:5-10: Unneeded variable: "error". Return "0" on
line 628

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/gfs2/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 861ed5f..fe2dae4 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -589,7 +589,6 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 
 int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 {
-	int error = 0;
 	int log_write_allowed = test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 
 	gfs2_flush_delete_work(sdp);
@@ -625,7 +624,7 @@ int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 	if (!log_write_allowed)
 		sdp->sd_vfs->s_flags |= SB_RDONLY;
 
-	return error;
+	return 0;
 }
 
 /**
-- 
1.8.3.1

