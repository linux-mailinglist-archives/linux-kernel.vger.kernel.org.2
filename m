Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24ED32374D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 07:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhBXGRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 01:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhBXGO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 01:14:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF1CC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 22:14:19 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gm18so624844pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 22:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcXL6ghGrWU/EcdhOZgmILwIKx2zSAZW1x4HYG6YYds=;
        b=RuMeseMpQyiVCkqxrOxjMCen65b6QcPAfpNeXbpyWVBxihanFoczKzOuZhV28WflXQ
         iCJDL0/9CijA9i/aMIyiJWev6N7/iXe6WBbFgBZyL6GYesIGdrLv56gKBnExlvvaiEg7
         Xwu6MfTlUFHVPVueCS22iYsz8YxLLnM9uV1ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcXL6ghGrWU/EcdhOZgmILwIKx2zSAZW1x4HYG6YYds=;
        b=ukQ/CBH9RZugSZPrAJERwMI3NuRrdFFBTmwkZX4Xdg+QnGNiFhXJR0Zk+bgqqC8uEp
         azO3pOmQG6bnhXMV4z7DRK+qFyvZoQ11YXAnLz+zLFMqthSoT4Yx55hYBYN1r6b4IRFp
         4+2AR3Zwg4yHn63wOtDCXsDj5kV/b0w234C//eEAp8xTkwtXTieZF4qouULxiQ2jEDQM
         fJnE8gW1z87sAKYflAsC9yzIJyCmjQn4zOxG85TcEDuz6iCr45v7MQ/XSgSkA2a+JAz/
         F43VQOyw7+RUseqtRBmuvw2/w9tCpzg3sPai+ANWg2VcLXg/kHAnug8e90tCPCyuMelK
         wLAw==
X-Gm-Message-State: AOAM533iOXD/CjpV9SB5wegO0rC0gPXLolNzkJccJSU/2du6cgiGMTa6
        QxtHWq8eafrl++r9hh1LPxUdJzIoJk8Neg==
X-Google-Smtp-Source: ABdhPJyTaxLstQsHdMkgxVvRNtjSHlpksJ+CfdteUMUWLRtixBC6YQ3yybTeklEODTP5lqRDS3wcpA==
X-Received: by 2002:a17:90a:db11:: with SMTP id g17mr2817137pjv.114.1614147256631;
        Tue, 23 Feb 2021 22:14:16 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5003:b035:5243:160e])
        by smtp.gmail.com with ESMTPSA id r13sm1266765pfg.37.2021.02.23.22.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 22:14:16 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 2/2] drm/bridge: anx7625: disable regulators when power off
Date:   Wed, 24 Feb 2021 14:14:09 +0800
Message-Id: <20210224061409.3996755-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210224061409.3996755-1-hsinyi@chromium.org>
References: <20210224061409.3996755-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When suspending the driver, anx7625_power_standby() will be called to
turn off reset-gpios and enable-gpios. However, power supplies are not
disabled. To save power, the driver can get the power supply regulators
and turn off them in anx7625_power_standby().

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 34 +++++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 65cc05982f826..23283ba0c4f93 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -875,12 +876,25 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
 static void anx7625_power_on(struct anx7625_data *ctx)
 {
 	struct device *dev = &ctx->client->dev;
+	int ret, i;
 
 	if (!ctx->pdata.low_power_mode) {
 		DRM_DEV_DEBUG_DRIVER(dev, "not low power mode!\n");
 		return;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(ctx->pdata.supplies); i++) {
+		ret = regulator_enable(ctx->pdata.supplies[i].consumer);
+		if (ret < 0) {
+			DRM_DEV_DEBUG_DRIVER(dev, "cannot enable supply %d: %d\n",
+					     i, ret);
+			goto reg_err;
+		}
+		usleep_range(2000, 2100);
+	}
+
+	usleep_range(4000, 4100);
+
 	/* Power on pin enable */
 	gpiod_set_value(ctx->pdata.gpio_p_on, 1);
 	usleep_range(10000, 11000);
@@ -889,11 +903,16 @@ static void anx7625_power_on(struct anx7625_data *ctx)
 	usleep_range(10000, 11000);
 
 	DRM_DEV_DEBUG_DRIVER(dev, "power on !\n");
+	return;
+reg_err:
+	for (--i; i >= 0; i--)
+		regulator_disable(ctx->pdata.supplies[i].consumer);
 }
 
 static void anx7625_power_standby(struct anx7625_data *ctx)
 {
 	struct device *dev = &ctx->client->dev;
+	int ret;
 
 	if (!ctx->pdata.low_power_mode) {
 		DRM_DEV_DEBUG_DRIVER(dev, "not low power mode!\n");
@@ -904,6 +923,12 @@ static void anx7625_power_standby(struct anx7625_data *ctx)
 	usleep_range(1000, 1100);
 	gpiod_set_value(ctx->pdata.gpio_p_on, 0);
 	usleep_range(1000, 1100);
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->pdata.supplies),
+				     ctx->pdata.supplies);
+	if (ret < 0)
+		DRM_DEV_DEBUG_DRIVER(dev, "cannot disable supplies %d\n", ret);
+
 	DRM_DEV_DEBUG_DRIVER(dev, "power down\n");
 }
 
@@ -1742,6 +1767,15 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	platform->client = client;
 	i2c_set_clientdata(client, platform);
 
+	pdata->supplies[0].supply = "vdd10";
+	pdata->supplies[1].supply = "vdd18";
+	pdata->supplies[2].supply = "vdd33";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(pdata->supplies),
+				      pdata->supplies);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "fail to get power supplies: %d\n", ret);
+		return ret;
+	}
 	anx7625_init_gpio(platform);
 
 	atomic_set(&platform->power_status, 0);
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 193ad86c54503..e4a086b3a3d7b 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -350,6 +350,7 @@ struct s_edid_data {
 struct anx7625_platform_data {
 	struct gpio_desc *gpio_p_on;
 	struct gpio_desc *gpio_reset;
+	struct regulator_bulk_data supplies[3];
 	struct drm_bridge *panel_bridge;
 	int intp_irq;
 	u32 low_power_mode;
-- 
2.30.1.766.gb4fecdf3b7-goog

