Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FFA321244
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 09:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBVIty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 03:49:54 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35940 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229863AbhBVItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 03:49:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UPChVY1_1613983731;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UPChVY1_1613983731)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 16:48:57 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] vt: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Mon, 22 Feb 2021 16:48:49 +0800
Message-Id: <1613983729-101495-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/tty/vt/vt.c:3909:8-16: WARNING: use scnprintf or sprintf.
./drivers/tty/vt/vt.c:3917:8-16: WARNING: use scnprintf or sprintf

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/tty/vt/vt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 284b072..cdf8132 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3906,7 +3906,7 @@ static ssize_t show_bind(struct device *dev, struct device_attribute *attr,
 	bind = con_is_bound(con->con);
 	console_unlock();
 
-	return snprintf(buf, PAGE_SIZE, "%i\n", bind);
+	return sysfs_emit(buf, "%i\n", bind);
 }
 
 static ssize_t show_name(struct device *dev, struct device_attribute *attr,
@@ -3914,9 +3914,8 @@ static ssize_t show_name(struct device *dev, struct device_attribute *attr,
 {
 	struct con_driver *con = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s %s\n",
-			(con->flag & CON_DRIVER_FLAG_MODULE) ? "(M)" : "(S)",
-			 con->desc);
+	return sysfs_emit(buf, "%s %s\n", (con->flag & CON_DRIVER_FLAG_MODULE) ? "(M)" : "(S)",
+			  con->desc);
 
 }
 
-- 
1.8.3.1

