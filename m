Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D17312301
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhBGJLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:11:04 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37563 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhBGJKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:10:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UO3U.MZ_1612689002;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UO3U.MZ_1612689002)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Feb 2021 17:10:09 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     a.hajda@samsung.com
Cc:     narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm: bridge: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Sun,  7 Feb 2021 17:10:00 +0800
Message-Id: <1612689000-64577-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/gpu/drm/bridge/lontium-lt9611uxc.c:858:8-16: WARNING: use
scnprintf or sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index fee2795..3cac16d 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -855,7 +855,7 @@ static ssize_t lt9611uxc_firmware_show(struct device *dev, struct device_attribu
 {
 	struct lt9611uxc *lt9611uxc = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%02x\n", lt9611uxc->fw_version);
+	return sysfs_emit(buf, "%02x\n", lt9611uxc->fw_version);
 }
 
 static DEVICE_ATTR_RW(lt9611uxc_firmware);
-- 
1.8.3.1

