Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1563596E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhDIHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:55:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16497 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhDIHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:55:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGr1r4z9tzPpRb;
        Fri,  9 Apr 2021 15:52:00 +0800 (CST)
Received: from huawei.com (10.67.174.37) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 15:54:39 +0800
From:   Chen Hui <clare.chenhui@huawei.com>
To:     <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
        <john.stultz@linaro.org>, <kong.kongxinwei@hisilicon.com>,
        <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/hisilicon/kirin: Remove redundant DRM_ERROR call in dsi_parse_dt()
Date:   Fri, 9 Apr 2021 15:54:44 +0800
Message-ID: <20210409075444.225388-1-clare.chenhui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the DRM_ERROR call to avoid redundant
error message.

Signed-off-by: Chen Hui <clare.chenhui@huawei.com>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index 00e87c290796..bc19ce318c62 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -836,10 +836,8 @@ static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ctx->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(ctx->base)) {
-		DRM_ERROR("failed to remap dsi io region\n");
+	if (IS_ERR(ctx->base))
 		return PTR_ERR(ctx->base);
-	}
 
 	return 0;
 }
-- 
2.17.1

