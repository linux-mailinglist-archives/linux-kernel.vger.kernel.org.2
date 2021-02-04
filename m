Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054F130EAC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhBDDPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:15:40 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60160 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231177AbhBDDPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:15:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UNozVIY_1612408478;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNozVIY_1612408478)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Feb 2021 11:14:52 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     hca@linux.ibm.com
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] s390: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Thu,  4 Feb 2021 11:14:37 +0800
Message-Id: <1612408477-27437-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/s390/char/raw3270.c:1066:8-16: WARNING: use scnprintf or
sprintf.

./drivers/s390/char/raw3270.c:1058:8-16: WARNING: use scnprintf or
sprintf.

./drivers/s390/char/raw3270.c:1050:8-16: WARNING: use scnprintf or
sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/s390/char/raw3270.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 646ec796..5d23e49 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1047,24 +1047,21 @@ struct raw3270_view *
 static ssize_t
 raw3270_model_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
-			((struct raw3270 *) dev_get_drvdata(dev))->model);
+	return sysfs_emit(buf, "%i\n", ((struct raw3270 *) dev_get_drvdata(dev))->model);
 }
 static DEVICE_ATTR(model, 0444, raw3270_model_show, NULL);
 
 static ssize_t
 raw3270_rows_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
-			((struct raw3270 *) dev_get_drvdata(dev))->rows);
+	return sysfs_emit(buf, "%i\n", ((struct raw3270 *) dev_get_drvdata(dev))->rows);
 }
 static DEVICE_ATTR(rows, 0444, raw3270_rows_show, NULL);
 
 static ssize_t
 raw3270_columns_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
-			((struct raw3270 *) dev_get_drvdata(dev))->cols);
+	return sysfs_emit(buf, "%i\n", ((struct raw3270 *) dev_get_drvdata(dev))->cols);
 }
 static DEVICE_ATTR(columns, 0444, raw3270_columns_show, NULL);
 
-- 
1.8.3.1

