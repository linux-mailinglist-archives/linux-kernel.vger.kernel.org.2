Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F1377B88
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 07:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhEJFcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 01:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhEJFcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 01:32:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CE6C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 22:31:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h16so62792pfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 22:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D4U79Orfvm1F2D9PQGdwtK6XcE4CL3/UBkN8KNx8qTQ=;
        b=nL8OjTzrdx8e/20MIZrBbtIQ2dTKWhBmTJb1czR27+PiVinxEnR7kRUJaDrAEY8Lgf
         VWwOzFGm+Sg3Omc7WzomCY0c+6hwjGPMxKe56BWyb0pB6roo1Prt6vEdYU2Bqx7O8Tk4
         qLP3uuFiBgR4A17ZlSj4hTGXCSRPSMhsU/QMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D4U79Orfvm1F2D9PQGdwtK6XcE4CL3/UBkN8KNx8qTQ=;
        b=VJdbwIJ9mkw5NKgS3kYrNsNrupXrPaqagIUJagLlMe611GUxmnnCpLNqfWUYPGen23
         fFRx13dfhnD0arTw8nDfe7sQMGA0jttjr8TrfU3vJ/UhsJGkw4YWEBQ2qkrg4xR9uvb8
         WCYDBShhCXaeXuEKnSWzyosQPw9lx0JNvBS/mI95ri+piaOUpFwfG37Tl14FbRqRsmxe
         129w1dXtp1kGjLbNduy2IDu6y0/cCDQdYxH5kVQ7ZYWxROBdOLrMOQ+whgO0yGC3pkCa
         zHrC2qrycr7Pu7Elf74/2k8GJZJbguqTKqpzAKPJYYwyKR8Yqclfe+D7RvASTTZyxhZi
         q93g==
X-Gm-Message-State: AOAM531MtP0OkLBa2tHqF5rTykzctirnIRv7pRxxT5Cjl56Ks98mF20i
        3TQ6Mw2xEAZoy2uaYCR7sTwthA==
X-Google-Smtp-Source: ABdhPJxRhUSorSJpUte1N8pNM2SkxeUPq3DVw+/H5BdHH6q/ziyCK+X+COjwO9hkG3hAle7j7NQZpg==
X-Received: by 2002:aa7:985c:0:b029:2c4:b940:f77b with SMTP id n28-20020aa7985c0000b02902c4b940f77bmr621718pfq.73.1620624695292;
        Sun, 09 May 2021 22:31:35 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id w2sm10485834pfb.174.2021.05.09.22.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 22:31:34 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] drm/bridge: anx7625: refactor power control to use runtime PM framework
Date:   Mon, 10 May 2021 13:30:51 +0800
Message-Id: <20210510053125.1595659-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver originally use an atomic_t for keep track of the power
status, which makes the driver more complicated than needed, and has
some race condition as it's possible to have the power on and power off
sequence going at the same time.

This patch remove the usage of the atomic_t power_status, and use the
kernel runtime power management framework instead.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---

Changes from v2:
* Add missing .pm field to anx7625_driver.

---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 149 ++++++++++------------
 drivers/gpu/drm/bridge/analogix/anx7625.h |   1 -
 2 files changed, 64 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 23283ba0c4f9..e1bf31eafe22 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1005,33 +1006,6 @@ static void anx7625_power_on_init(struct anx7625_data *ctx)
 	}
 }
 
-static void anx7625_chip_control(struct anx7625_data *ctx, int state)
-{
-	struct device *dev = &ctx->client->dev;
-
-	DRM_DEV_DEBUG_DRIVER(dev, "before set, power_state(%d).\n",
-			     atomic_read(&ctx->power_status));
-
-	if (!ctx->pdata.low_power_mode)
-		return;
-
-	if (state) {
-		atomic_inc(&ctx->power_status);
-		if (atomic_read(&ctx->power_status) == 1)
-			anx7625_power_on_init(ctx);
-	} else {
-		if (atomic_read(&ctx->power_status)) {
-			atomic_dec(&ctx->power_status);
-
-			if (atomic_read(&ctx->power_status) == 0)
-				anx7625_power_standby(ctx);
-		}
-	}
-
-	DRM_DEV_DEBUG_DRIVER(dev, "after set, power_state(%d).\n",
-			     atomic_read(&ctx->power_status));
-}
-
 static void anx7625_init_gpio(struct anx7625_data *platform)
 {
 	struct device *dev = &platform->client->dev;
@@ -1061,9 +1035,6 @@ static void anx7625_stop_dp_work(struct anx7625_data *ctx)
 	ctx->hpd_status = 0;
 	ctx->hpd_high_cnt = 0;
 	ctx->display_timing_valid = 0;
-
-	if (ctx->pdata.low_power_mode == 0)
-		anx7625_disable_pd_protocol(ctx);
 }
 
 static void anx7625_start_dp_work(struct anx7625_data *ctx)
@@ -1105,49 +1076,26 @@ static void anx7625_hpd_polling(struct anx7625_data *ctx)
 	int ret, val;
 	struct device *dev = &ctx->client->dev;
 
-	if (atomic_read(&ctx->power_status) != 1) {
-		DRM_DEV_DEBUG_DRIVER(dev, "No need to poling HPD status.\n");
-		return;
-	}
-
 	ret = readx_poll_timeout(anx7625_read_hpd_status_p0,
 				 ctx, val,
 				 ((val & HPD_STATUS) || (val < 0)),
 				 5000,
 				 5000 * 100);
 	if (ret) {
-		DRM_DEV_ERROR(dev, "HPD polling timeout!\n");
-	} else {
-		DRM_DEV_DEBUG_DRIVER(dev, "HPD raise up.\n");
-		anx7625_reg_write(ctx, ctx->i2c.tcpc_client,
-				  INTR_ALERT_1, 0xFF);
-		anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
-				  INTERFACE_CHANGE_INT, 0);
+		DRM_DEV_ERROR(dev, "no hpd.\n");
+		return;
 	}
 
-	anx7625_start_dp_work(ctx);
-}
-
-static void anx7625_disconnect_check(struct anx7625_data *ctx)
-{
-	if (atomic_read(&ctx->power_status) == 0)
-		anx7625_stop_dp_work(ctx);
-}
-
-static void anx7625_low_power_mode_check(struct anx7625_data *ctx,
-					 int state)
-{
-	struct device *dev = &ctx->client->dev;
+	DRM_DEV_DEBUG_DRIVER(dev, "system status: 0x%x. HPD raise up.\n", val);
+	anx7625_reg_write(ctx, ctx->i2c.tcpc_client,
+			  INTR_ALERT_1, 0xFF);
+	anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
+			  INTERFACE_CHANGE_INT, 0);
 
-	DRM_DEV_DEBUG_DRIVER(dev, "low power mode check, state(%d).\n", state);
+	anx7625_start_dp_work(ctx);
 
-	if (ctx->pdata.low_power_mode) {
-		anx7625_chip_control(ctx, state);
-		if (state)
-			anx7625_hpd_polling(ctx);
-		else
-			anx7625_disconnect_check(ctx);
-	}
+	if (!ctx->pdata.panel_bridge && ctx->bridge_attached)
+		drm_helper_hpd_irq_event(ctx->bridge.dev);
 }
 
 static void anx7625_remove_edid(struct anx7625_data *ctx)
@@ -1180,9 +1128,6 @@ static int anx7625_hpd_change_detect(struct anx7625_data *ctx)
 	int intr_vector, status;
 	struct device *dev = &ctx->client->dev;
 
-	DRM_DEV_DEBUG_DRIVER(dev, "power_status=%d\n",
-			     (u32)atomic_read(&ctx->power_status));
-
 	status = anx7625_reg_write(ctx, ctx->i2c.tcpc_client,
 				   INTR_ALERT_1, 0xFF);
 	if (status < 0) {
@@ -1228,22 +1173,25 @@ static void anx7625_work_func(struct work_struct *work)
 						struct anx7625_data, work);
 
 	mutex_lock(&ctx->lock);
+
+	if (pm_runtime_suspended(&ctx->client->dev))
+		goto unlock;
+
 	event = anx7625_hpd_change_detect(ctx);
-	mutex_unlock(&ctx->lock);
 	if (event < 0)
-		return;
+		goto unlock;
 
 	if (ctx->bridge_attached)
 		drm_helper_hpd_irq_event(ctx->bridge.dev);
+
+unlock:
+	mutex_unlock(&ctx->lock);
 }
 
 static irqreturn_t anx7625_intr_hpd_isr(int irq, void *data)
 {
 	struct anx7625_data *ctx = (struct anx7625_data *)data;
 
-	if (atomic_read(&ctx->power_status) != 1)
-		return IRQ_NONE;
-
 	queue_work(ctx->workqueue, &ctx->work);
 
 	return IRQ_HANDLED;
@@ -1305,9 +1253,9 @@ static struct edid *anx7625_get_edid(struct anx7625_data *ctx)
 		return (struct edid *)edid;
 	}
 
-	anx7625_low_power_mode_check(ctx, 1);
+	pm_runtime_get_sync(dev);
 	edid_num = sp_tx_edid_read(ctx, p_edid->edid_raw_data);
-	anx7625_low_power_mode_check(ctx, 0);
+	pm_runtime_put(dev);
 
 	if (edid_num < 1) {
 		DRM_DEV_ERROR(dev, "Fail to read EDID: %d\n", edid_num);
@@ -1611,10 +1559,7 @@ static void anx7625_bridge_enable(struct drm_bridge *bridge)
 
 	DRM_DEV_DEBUG_DRIVER(dev, "drm enable\n");
 
-	anx7625_low_power_mode_check(ctx, 1);
-
-	if (WARN_ON(!atomic_read(&ctx->power_status)))
-		return;
+	pm_runtime_get_sync(dev);
 
 	anx7625_dp_start(ctx);
 }
@@ -1624,14 +1569,11 @@ static void anx7625_bridge_disable(struct drm_bridge *bridge)
 	struct anx7625_data *ctx = bridge_to_anx7625(bridge);
 	struct device *dev = &ctx->client->dev;
 
-	if (WARN_ON(!atomic_read(&ctx->power_status)))
-		return;
-
 	DRM_DEV_DEBUG_DRIVER(dev, "drm disable\n");
 
 	anx7625_dp_stop(ctx);
 
-	anx7625_low_power_mode_check(ctx, 0);
+	pm_runtime_put(dev);
 }
 
 static enum drm_connector_status
@@ -1735,6 +1677,39 @@ static void anx7625_unregister_i2c_dummy_clients(struct anx7625_data *ctx)
 	i2c_unregister_device(ctx->i2c.tcpc_client);
 }
 
+static int __maybe_unused anx7625_runtime_pm_suspend(struct device *dev)
+{
+	struct anx7625_data *ctx = dev_get_drvdata(dev);
+
+	mutex_lock(&ctx->lock);
+
+	anx7625_stop_dp_work(ctx);
+	anx7625_power_standby(ctx);
+
+	mutex_unlock(&ctx->lock);
+
+	return 0;
+}
+
+static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
+{
+	struct anx7625_data *ctx = dev_get_drvdata(dev);
+
+	mutex_lock(&ctx->lock);
+
+	anx7625_power_on_init(ctx);
+	anx7625_hpd_polling(ctx);
+
+	mutex_unlock(&ctx->lock);
+
+	return 0;
+}
+
+static const struct dev_pm_ops anx7625_pm_ops = {
+	SET_RUNTIME_PM_OPS(anx7625_runtime_pm_suspend,
+			   anx7625_runtime_pm_resume, NULL)
+};
+
 static int anx7625_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
@@ -1778,8 +1753,6 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	}
 	anx7625_init_gpio(platform);
 
-	atomic_set(&platform->power_status, 0);
-
 	mutex_init(&platform->lock);
 
 	platform->pdata.intp_irq = client->irq;
@@ -1809,9 +1782,11 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 		goto free_wq;
 	}
 
-	if (platform->pdata.low_power_mode == 0) {
+	pm_runtime_enable(dev);
+
+	if (!platform->pdata.low_power_mode) {
 		anx7625_disable_pd_protocol(platform);
-		atomic_set(&platform->power_status, 1);
+		pm_runtime_get_sync(dev);
 	}
 
 	/* Add work function */
@@ -1847,6 +1822,9 @@ static int anx7625_i2c_remove(struct i2c_client *client)
 	if (platform->pdata.intp_irq)
 		destroy_workqueue(platform->workqueue);
 
+	if (!platform->pdata.low_power_mode)
+		pm_runtime_put_sync_suspend(&client->dev);
+
 	anx7625_unregister_i2c_dummy_clients(platform);
 
 	kfree(platform);
@@ -1869,6 +1847,7 @@ static struct i2c_driver anx7625_driver = {
 	.driver = {
 		.name = "anx7625",
 		.of_match_table = anx_match_table,
+		.pm = &anx7625_pm_ops,
 	},
 	.probe = anx7625_i2c_probe,
 	.remove = anx7625_i2c_remove,
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index e4a086b3a3d7..034c3840028f 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -369,7 +369,6 @@ struct anx7625_i2c_client {
 
 struct anx7625_data {
 	struct anx7625_platform_data pdata;
-	atomic_t power_status;
 	int hpd_status;
 	int hpd_high_cnt;
 	/* Lock for work queue */

base-commit: e48661230cc35b3d0f4367eddfc19f86463ab917
-- 
2.31.1.607.g51e8a6a459-goog

