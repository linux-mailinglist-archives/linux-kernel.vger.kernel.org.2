Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CD03D06BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 04:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhGUBwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 21:52:13 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:38952 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhGUBv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:51:59 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee760f7871cfb3-4462d; Wed, 21 Jul 2021 10:31:56 +0800 (CST)
X-RM-TRANSID: 2ee760f7871cfb3-4462d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.134])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee960f787184d6-c2b18;
        Wed, 21 Jul 2021 10:31:56 +0800 (CST)
X-RM-TRANSID: 2ee960f787184d6-c2b18
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] drm/bridge/analogix/dp_core: Use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 21 Jul 2021 10:32:39 +0800
Message-Id: <20210721023239.29284-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() instead of
platform_get_resource() & devm_ioremap_resource().

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 76736fb8e..71537cf8c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1656,7 +1656,6 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct analogix_dp_device *dp;
-	struct resource *res;
 	unsigned int irq_flags;
 	int ret;
 
@@ -1710,9 +1709,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 
 	clk_prepare_enable(dp->clock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	dp->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	dp->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dp->reg_base))
 		return ERR_CAST(dp->reg_base);
 
-- 
2.20.1.windows.1



