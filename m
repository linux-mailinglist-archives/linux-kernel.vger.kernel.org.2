Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8865C332204
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhCIJcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:32:32 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39145 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhCIJcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:32:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UR4aFol_1615282321;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UR4aFol_1615282321)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 17:32:02 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     agk@redhat.com
Cc:     snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] dm: remove unneeded variable 'sz'
Date:   Tue,  9 Mar 2021 17:32:00 +0800
Message-Id: <1615282320-28246-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/md/dm-ps-service-time.c:85:10-12: Unneeded variable: "sz".
Return "0" on line 105

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/md/dm-ps-service-time.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-ps-service-time.c b/drivers/md/dm-ps-service-time.c
index 9cfda66..12dd5ce 100644
--- a/drivers/md/dm-ps-service-time.c
+++ b/drivers/md/dm-ps-service-time.c
@@ -82,7 +82,6 @@ static void st_destroy(struct path_selector *ps)
 static int st_status(struct path_selector *ps, struct dm_path *path,
 		     status_type_t type, char *result, unsigned maxlen)
 {
-	unsigned sz = 0;
 	struct path_info *pi;
 
 	if (!path)
@@ -102,7 +101,7 @@ static int st_status(struct path_selector *ps, struct dm_path *path,
 		}
 	}
 
-	return sz;
+	return 0;
 }
 
 static int st_add_path(struct path_selector *ps, struct dm_path *path,
-- 
1.8.3.1

