Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9F3CF76C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhGTJ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 05:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbhGTJZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:25:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB378C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:06:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b2so6622661plx.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6dvoxU82sdq8hrtHo6MNtrAkdmF4Qfs1QHBwRf0tvA=;
        b=Cp59n2Cb272AzmErANtJnFMRXbhxIXwpy4y+lZNu4HXwA0rY3ycd0yal8gjH4KS/8B
         tX7HiQlqzbMpHXvkhj2/8EtDSZVA5KLyTBhW7d8tTrmJmBbNDOWpfkD76197FZBz7zti
         ydKpQM1bMd+Ia1gvMedLl7LNhCSltVNot4Bc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6dvoxU82sdq8hrtHo6MNtrAkdmF4Qfs1QHBwRf0tvA=;
        b=UMadiT6zY9aCforDIJJGqRohom3deyqym8I0aLNtBcSoZEpbgjcR+Li/PeHxdXAQuJ
         LhAd9qUkralnI3eicp0ngVBsKU35Jjnxm1KRsxxlAk0J7+YxCI2kgzMbQl7bXVA9VrKD
         3/dhcmKTLnLsQuNmQNPHr3zHu0ghVaqrqKmQD5oEqf7J3QkF9VsmhriCXrnXqKfwCfvt
         zNx5ItESAJVKLi4Bd3fF7TxjYfZgEpu7Sa4sr1H+JN3CQOK8ppzXazF1e5Ymn6va8jHw
         PmYPbGuK9SPbVHAjEsxXx1YyyWG6TYsPNCvO0ouqFV8Sj5VocXkLmnvxnVbqVngGOnvE
         mrng==
X-Gm-Message-State: AOAM532HsaJNmXM4CgmbXLtTUtlXHZoghLYbvTrN0mL9Rra2eR6O019H
        9yrLhbfxxT2gdj+UzFu/2Wf4sA==
X-Google-Smtp-Source: ABdhPJymK2i/4VfbrYc8qY2j3o9aCSyBSwL36wWIQBgl7jKUzWJ4Lv9BHbGe+7BeA9pC5I4dtFqRRw==
X-Received: by 2002:a17:90a:4302:: with SMTP id q2mr33210703pjg.189.1626775562319;
        Tue, 20 Jul 2021 03:06:02 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id y5sm22843830pfn.87.2021.07.20.03.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:06:01 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Xin Ji <xji@analogixsemi.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v2] drm/bridge: anx7625: Use pm_runtime_force_{suspend,resume}
Date:   Tue, 20 Jul 2021 18:05:21 +0800
Message-Id: <20210720100553.2340425-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pm_runtime_force_{suspend,resume} as system suspend/resume hook, to
ensure that anx7625 is always powered off on suspend.

Also add a device link between anx7625 driver and the encoder, to ensure
that bridge_disable will be called before suspend.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---

Changes from v1:
* Use device link to ensure suspend resume order, instead of manually
  calling force resume.

This is the second approach mentioned in v1 of this patch
(https://lore.kernel.org/patchwork/patch/1459569/#1655836).

An issue was found that the anx7625 driver won't power off when used as
eDP bridge on Asurada board if suspend is entered via VT2.

The reason is that in this case, anx7625_suspend won't power off anx7625
(since intp_irq is not set). And anx7625_bridge_disable is only called
indirectly by other driver's (mediatek-drm) suspend.
pm_runtime_put_sync won't do anything since it's already in system
suspend.

If not in VT2, the bridge disable is indirectly called when Chrome
stops, so anx7625 will be powered off correctly.

To fix the issue, the suspend resume hooks are changed to
pm_runtime_force_{suspend,resume} to ensure the runtime suspend / resume
is always called correctly when system suspend / resume.
(Note that IRQ no longer needs to be disabled on suspend after commit
f03ab6629c7b ("drm/bridge: anx7625: Make hpd workqueue freezable"))

Also adds a stateless device link to ensure that the bridge disable is
called before anx7625 is suspended.

---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 54 +++++++++--------------
 drivers/gpu/drm/bridge/analogix/anx7625.h |  1 +
 2 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 7519b7a0f29d..e248f0da2f8b 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1331,6 +1331,8 @@ static void anx7625_bridge_detach(struct drm_bridge *bridge)
 		mipi_dsi_detach(ctx->dsi);
 		mipi_dsi_device_unregister(ctx->dsi);
 	}
+	if (ctx->link)
+		device_link_del(ctx->link);
 }
 
 static int anx7625_bridge_attach(struct drm_bridge *bridge,
@@ -1355,6 +1357,13 @@ static int anx7625_bridge_attach(struct drm_bridge *bridge,
 		return err;
 	}
 
+	ctx->link = device_link_add(bridge->dev->dev, dev, DL_FLAG_STATELESS);
+	if (!ctx->link) {
+		DRM_DEV_ERROR(dev, "device link creation failed");
+		err = -EINVAL;
+		goto detach_dsi;
+	}
+
 	if (ctx->pdata.panel_bridge) {
 		err = drm_bridge_attach(bridge->encoder,
 					ctx->pdata.panel_bridge,
@@ -1362,13 +1371,22 @@ static int anx7625_bridge_attach(struct drm_bridge *bridge,
 		if (err) {
 			DRM_DEV_ERROR(dev,
 				      "Fail to attach panel bridge: %d\n", err);
-			return err;
+			goto remove_device_link;
 		}
 	}
 
 	ctx->bridge_attached = 1;
 
 	return 0;
+
+remove_device_link:
+	device_link_del(ctx->link);
+detach_dsi:
+	if (ctx->dsi) {
+		mipi_dsi_detach(ctx->dsi);
+		mipi_dsi_device_unregister(ctx->dsi);
+	}
+	return err;
 }
 
 static enum drm_mode_status
@@ -1705,39 +1723,9 @@ static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused anx7625_resume(struct device *dev)
-{
-	struct anx7625_data *ctx = dev_get_drvdata(dev);
-
-	if (!ctx->pdata.intp_irq)
-		return 0;
-
-	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
-		enable_irq(ctx->pdata.intp_irq);
-		anx7625_runtime_pm_resume(dev);
-	}
-
-	return 0;
-}
-
-static int __maybe_unused anx7625_suspend(struct device *dev)
-{
-	struct anx7625_data *ctx = dev_get_drvdata(dev);
-
-	if (!ctx->pdata.intp_irq)
-		return 0;
-
-	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
-		anx7625_runtime_pm_suspend(dev);
-		disable_irq(ctx->pdata.intp_irq);
-		flush_workqueue(ctx->workqueue);
-	}
-
-	return 0;
-}
-
 static const struct dev_pm_ops anx7625_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(anx7625_suspend, anx7625_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(anx7625_runtime_pm_suspend,
 			   anx7625_runtime_pm_resume, NULL)
 };
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 034c3840028f..c941b7a32859 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -385,6 +385,7 @@ struct anx7625_data {
 	struct drm_bridge bridge;
 	u8 bridge_attached;
 	struct mipi_dsi_device *dsi;
+	struct device_link *link;
 };
 
 #endif  /* __ANX7625_H__ */

base-commit: 3568c2c543e25d1a47bd97a607171511e7d44a45
-- 
2.32.0.402.g57bb445576-goog

