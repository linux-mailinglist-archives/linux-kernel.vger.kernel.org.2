Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529FF30EC8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 07:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhBDGjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 01:39:18 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52396 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231592AbhBDGjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:39:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UNpw7Hg_1612420709;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNpw7Hg_1612420709)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Feb 2021 14:38:34 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     james.qian.wang@arm.com
Cc:     liviu.dudau@arm.com, mihail.atanassov@arm.com,
        brian.starkey@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/komeda: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Thu,  4 Feb 2021 14:38:28 +0800
Message-Id: <1612420708-25297-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/gpu/drm/arm/display/komeda/komeda_dev.c:97:8-16: WARNING: use
scnprintf or sprintf.

./drivers/gpu/drm/arm/display/komeda/komeda_dev.c:88:8-16: WARNING: use
scnprintf or sprintf.

./drivers/gpu/drm/arm/display/komeda/komeda_dev.c:65:8-16: WARNING: use
scnprintf or sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index ca891ae..cc7664c 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -62,7 +62,7 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
 {
 	struct komeda_dev *mdev = dev_to_mdev(dev);
 
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", mdev->chip.core_id);
+	return sysfs_emit(buf, "0x%08x\n", mdev->chip.core_id);
 }
 static DEVICE_ATTR_RO(core_id);
 
@@ -85,7 +85,7 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
 		if (pipe->layers[i]->layer_type == KOMEDA_FMT_RICH_LAYER)
 			config_id.n_richs++;
 	}
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", config_id.value);
+	return sysfs_emit(buf, "0x%08x\n", config_id.value);
 }
 static DEVICE_ATTR_RO(config_id);
 
@@ -94,7 +94,7 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
 {
 	struct komeda_dev *mdev = dev_to_mdev(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", clk_get_rate(mdev->aclk));
+	return sysfs_emit(buf, "%lu\n", clk_get_rate(mdev->aclk));
 }
 static DEVICE_ATTR_RO(aclk_hz);
 
-- 
1.8.3.1

