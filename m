Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6202240D738
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhIPKPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:15:33 -0400
Received: from mx24.baidu.com ([111.206.215.185]:52770 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235287AbhIPKP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:15:27 -0400
Received: from BC-Mail-Ex09.internal.baidu.com (unknown [172.31.51.49])
        by Forcepoint Email with ESMTPS id 32A1DCF101C6ADD723B3;
        Thu, 16 Sep 2021 18:14:05 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex09.internal.baidu.com (172.31.51.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 16 Sep 2021 18:14:05 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 16 Sep 2021 18:14:04 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/bridge/tc358775: Make use of the helper function dev_err_probe()
Date:   Thu, 16 Sep 2021 18:13:58 +0800
Message-ID: <20210916101359.9548-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex24.internal.baidu.com (172.31.51.18) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
And using dev_err_probe() can reduce code size, and the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/gpu/drm/bridge/tc358775.c | 32 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 2272adcc5b4a..39a5fda6a06a 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -676,32 +676,24 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return ret;
 
 	tc->vddio = devm_regulator_get(dev, "vddio-supply");
-	if (IS_ERR(tc->vddio)) {
-		ret = PTR_ERR(tc->vddio);
-		dev_err(dev, "vddio-supply not found\n");
-		return ret;
-	}
+	if (IS_ERR(tc->vddio))
+		return dev_err_probe(dev, PTR_ERR(tc->vddio),
+				     "vddio-supply not found\n");
 
 	tc->vdd = devm_regulator_get(dev, "vdd-supply");
-	if (IS_ERR(tc->vdd)) {
-		ret = PTR_ERR(tc->vdd);
-		dev_err(dev, "vdd-supply not found\n");
-		return ret;
-	}
+	if (IS_ERR(tc->vdd))
+		return dev_err_probe(dev, PTR_ERR(tc->vdd),
+				     "vdd-supply not found\n");
 
 	tc->stby_gpio = devm_gpiod_get(dev, "stby", GPIOD_OUT_HIGH);
-	if (IS_ERR(tc->stby_gpio)) {
-		ret = PTR_ERR(tc->stby_gpio);
-		dev_err(dev, "cannot get stby-gpio %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(tc->stby_gpio))
+		return dev_err_probe(dev, PTR_ERR(tc->stby_gpio),
+				     "cannot get stby-gpio\n");
 
 	tc->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(tc->reset_gpio)) {
-		ret = PTR_ERR(tc->reset_gpio);
-		dev_err(dev, "cannot get reset-gpios %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(tc->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(tc->reset_gpio),
+				     "cannot get reset-gpios\n");
 
 	tc->bridge.funcs = &tc_bridge_funcs;
 	tc->bridge.of_node = dev->of_node;
-- 
2.25.1

