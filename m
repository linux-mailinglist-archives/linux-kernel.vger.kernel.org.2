Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7110D30D225
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhBCDXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:23:21 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39741 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232897AbhBCDWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 22:22:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UNj9Q.4_1612322530;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNj9Q.4_1612322530)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 11:22:15 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bernie@plugable.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] video: udlfb: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Wed,  3 Feb 2021 11:22:09 +0800
Message-Id: <1612322529-40629-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/video/fbdev/udlfb.c:1452:8-16: WARNING: use scnprintf or
sprintf.

./drivers/video/fbdev/udlfb.c:1444:8-16: WARNING: use scnprintf or
sprintf.

./drivers/video/fbdev/udlfb.c:1436:8-16: WARNING: use scnprintf or
sprintf.

./drivers/video/fbdev/udlfb.c:1428:8-16: WARNING: use scnprintf or
sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/video/fbdev/udlfb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index f9b3c1c..d8c086d 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1425,32 +1425,28 @@ static ssize_t metrics_bytes_rendered_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			atomic_read(&dlfb->bytes_rendered));
+	return sysfs_emit(buf, "%u\n", atomic_read(&dlfb->bytes_rendered));
 }
 
 static ssize_t metrics_bytes_identical_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			atomic_read(&dlfb->bytes_identical));
+	return sysfs_emit(buf, "%u\n", atomic_read(&dlfb->bytes_identical));
 }
 
 static ssize_t metrics_bytes_sent_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			atomic_read(&dlfb->bytes_sent));
+	return sysfs_emit(buf, "%u\n", atomic_read(&dlfb->bytes_sent));
 }
 
 static ssize_t metrics_cpu_kcycles_used_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			atomic_read(&dlfb->cpu_kcycles_used));
+	return sysfs_emit(buf, "%u\n", atomic_read(&dlfb->cpu_kcycles_used));
 }
 
 static ssize_t edid_show(
-- 
1.8.3.1

