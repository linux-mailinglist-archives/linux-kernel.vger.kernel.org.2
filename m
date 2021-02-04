Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FEC30ED95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhBDHlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:41:24 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:10652 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234750AbhBDHlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:41:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UNqzBz7_1612424421;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNqzBz7_1612424421)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Feb 2021 15:40:27 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] firewire: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Thu,  4 Feb 2021 15:40:20 +0800
Message-Id: <1612424420-96871-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/firewire/core-device.c:375:8-16: WARNING: use scnprintf or
sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  - Modified print format.

 drivers/firewire/core-device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 80db43a..25508a8 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -372,8 +372,7 @@ static ssize_t rom_index_show(struct device *dev,
 	struct fw_device *device = fw_device(dev->parent);
 	struct fw_unit *unit = fw_unit(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			(int)(unit->directory - device->config_rom));
+	return sysfs_emit(buf, "%td\n", unit->directory - device->config_rom);
 }
 
 static struct device_attribute fw_unit_attributes[] = {
@@ -403,8 +402,7 @@ static ssize_t guid_show(struct device *dev,
 	int ret;
 
 	down_read(&fw_device_rwsem);
-	ret = snprintf(buf, PAGE_SIZE, "0x%08x%08x\n",
-		       device->config_rom[3], device->config_rom[4]);
+	ret = sysfs_emit(buf, "0x%08x%08x\n", device->config_rom[3], device->config_rom[4]);
 	up_read(&fw_device_rwsem);
 
 	return ret;
-- 
1.8.3.1

