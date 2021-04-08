Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58395357F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhDHJiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:38:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16086 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhDHJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:38:38 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGGNZ4sb4z19KkT;
        Thu,  8 Apr 2021 17:36:14 +0800 (CST)
Received: from huawei.com (10.67.174.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 17:38:18 +0800
From:   Zhang Jianhua <zhangjianhua18@huawei.com>
To:     <adrien.grassein@gmail.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <johnny.chenyi@huawei.com>, <heying24@huawei.com>,
        <zhangjianhua18@huawei.com>
Subject: [PATCH -next v3] drm/bridge: lt8912b: Add header file <linux/gpio/consumer.h>
Date:   Thu, 8 Apr 2021 17:38:22 +0800
Message-ID: <20210408093822.207917-1-zhangjianhua18@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_LONTIUM_LT8912B=m, the following errors will be seen while
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
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
v2:
- add header file <linux/gpio/consumer.h> for lontium-lt8912b.c instead
  of add config dependence for CONFIG_DRM_LONTIUM_LT8912B
v3:
- change the #include in alphabetical order
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 61491615bad0..4f693123985b 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -5,6 +5,7 @@
 
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
-- 
2.17.1

