Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31819354F6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbhDFJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:07:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15492 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244768AbhDFJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:07:48 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF1p1297Kzrd4Z;
        Tue,  6 Apr 2021 17:05:29 +0800 (CST)
Received: from huawei.com (10.67.174.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 17:07:30 +0800
From:   Zhang Jianhua <zhangjianhua18@huawei.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <johnny.chenyi@huawei.com>, <zhangjianhua18@huawei.com>,
        <heying24@huawei.com>
Subject: [PATCH -next] drm/bridge: lt8912b: DRM_LONTIUM_LT8912B select GPIOLIB
Date:   Tue, 6 Apr 2021 17:07:33 +0800
Message-ID: <20210406090733.169989-1-zhangjianhua18@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_LONTIUM_LT8912B=y, the following errors will be seen while
compiling lontium-lt8912b.c

drivers/gpu/drm/bridge/lontium-lt8912b.c: In function
‘lt8912_hard_power_on’:
drivers/gpu/drm/bridge/lontium-lt8912b.c:252:2: error: implicit
declaration of function ‘gpiod_set_value_cansleep’; did you mean
‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
  gpiod_set_value_cansleep(lt->gp_reset, 0);
  ^~~~~~~~~~~~~~~~~~~~~~~~
  gpio_set_value_cansleep
drivers/gpu/drm/bridge/lontium-lt8912b.c: In function ‘lt8912_parse_dt’:
drivers/gpu/drm/bridge/lontium-lt8912b.c:628:13: error: implicit
declaration of function ‘devm_gpiod_get_optional’; did you mean
‘devm_gpio_request_one’? [-Werror=implicit-function-declaration]
  gp_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
             ^~~~~~~~~~~~~~~~~~~~~~~
             devm_gpio_request_one
drivers/gpu/drm/bridge/lontium-lt8912b.c:628:51: error: ‘GPIOD_OUT_HIGH’
undeclared (first use in this function); did you mean ‘GPIOF_INIT_HIGH’?
  gp_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
                                                   ^~~~~~~~~~~~~~
                                                   GPIOF_INIT_HIGH

Signed-off-by: Zhang Jianhua <zhangjianhua18@huawei.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index dba62f92d051..caa9658ec933 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -67,6 +67,7 @@ config DRM_LONTIUM_LT8912B
 	select DRM_PANEL_BRIDGE
 	select DRM_KMS_HELPER
 	select REGMAP_I2C
+	select GPIOLIB
 	help
 	  Driver for Lontium LT8912B DSI to HDMI bridge
 	  chip driver.
-- 
2.17.1

