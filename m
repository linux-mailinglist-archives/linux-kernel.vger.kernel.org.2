Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F7E430200
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 12:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbhJPKZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 06:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbhJPKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 06:24:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCB4C061769
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 03:22:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y12so49962341eda.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQxWHRxLlS8GB+mEPe7uBuP6Wvk6JtWdqezPMx1FAp8=;
        b=ZbrmSQysVOsDCgQE0R6U3t3cdzYpfABmpvw7lgZv+AatxUb2dgxqNNEbUwa4mFm2jC
         gKg/7phFpRe61dVUCU+eX8qf9CQ6OPy+jbszZFR/hc7uwNgJ9n1YeRljudbcmN0YR2uf
         9y81QaVInw28J2Rppwrr+MTcRq5lI6+W6y1uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQxWHRxLlS8GB+mEPe7uBuP6Wvk6JtWdqezPMx1FAp8=;
        b=MQTl+++1JIgeW8aMASQEgIYXxVbj7oLl43slBQnQdgTk0OThR2s7up57BDif3QX27Y
         AquWg+nv41kHLOFhTNMEwP3CJes/d4dJQefvCPAge0ZBZK3pgVKMBStb5C2bMDkgA78L
         KqVvpvhxn+RCnBQLWao8Owh8lWLT9YkA0ztCVdstd7Cba7+ATVd2iGSm7Wv/rQtDu+W3
         VIkHjx8XYKWmPDns7YOXyvVPOiGzEVNrLYIY0+BGuGhBOCtKgylPwPpXsEVUXzkFjC09
         oviAhMla7j6dBwDQM1IUaBX9REsk41ULImT2mprB/0/PDZC4da4ZSyPw92a22CIS168A
         Veow==
X-Gm-Message-State: AOAM532D6ysPg63mj2PhPM1f93Jnl8/KGLLGYdi1a0ODAyywNbmfBWZg
        iILp8PNBwyeseI7cIbW6rNuvNA==
X-Google-Smtp-Source: ABdhPJyo2efIjAHZdjigTFM3MOKnWgRMrDKspLEdjzUqBqA8mceLmTZXTMTW7XJRpja34WkdXfZSIA==
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr14071082ejc.62.1634379761781;
        Sat, 16 Oct 2021 03:22:41 -0700 (PDT)
Received: from panicking.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id la1sm6117361ejc.48.2021.10.16.03.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 03:22:41 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/bridge: dw-mipi-dsi: Fix dsi registration during drm probing
Date:   Sat, 16 Oct 2021 10:22:32 +0000
Message-Id: <20211016102232.202119-6-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211016102232.202119-1-michael@amarulasolutions.com>
References: <20211016102232.202119-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dsi registration is implemented in rockchip platform driver.
The attach can be called before the probe is terminated and therefore
we need to be sure that corresponding entry during attach is valid

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c   |  8 +++++++-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 12 ++++++++----
 include/drm/bridge/dw_mipi_dsi.h                |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index e44e18a0112a..44b211be15fc 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -362,8 +362,14 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 		dsi->device_found = true;
 	}
 
+	/*
+	 * NOTE: the dsi registration is implemented in
+	 * platform driver, that to say dsi would be exist after
+	 * probe is terminated. The call is done before the end of probe
+	 * so we need to pass the dsi to the platform driver.
+	 */
 	if (pdata->host_ops && pdata->host_ops->attach) {
-		ret = pdata->host_ops->attach(pdata->priv_data, device);
+		ret = pdata->host_ops->attach(pdata->priv_data, device, dsi);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index a2262bee5aa4..32ddc8642ec1 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -997,7 +997,8 @@ static const struct component_ops dw_mipi_dsi_rockchip_ops = {
 };
 
 static int dw_mipi_dsi_rockchip_host_attach(void *priv_data,
-					    struct mipi_dsi_device *device)
+					    struct mipi_dsi_device *device,
+					    struct dw_mipi_dsi *dmd)
 {
 	struct dw_mipi_dsi_rockchip *dsi = priv_data;
 	struct device *second;
@@ -1005,6 +1006,8 @@ static int dw_mipi_dsi_rockchip_host_attach(void *priv_data,
 
 	mutex_lock(&dsi->usage_mutex);
 
+	dsi->dmd = dmd;
+
 	if (dsi->usage_mode != DW_DSI_USAGE_IDLE) {
 		DRM_DEV_ERROR(dsi->dev, "dsi controller already in use\n");
 		mutex_unlock(&dsi->usage_mutex);
@@ -1280,6 +1283,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct dw_mipi_dsi *dmd;
 	struct dw_mipi_dsi_rockchip *dsi;
 	struct phy_provider *phy_provider;
 	struct resource *res;
@@ -1391,9 +1395,9 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 	if (IS_ERR(phy_provider))
 		return PTR_ERR(phy_provider);
 
-	dsi->dmd = dw_mipi_dsi_probe(pdev, &dsi->pdata);
-	if (IS_ERR(dsi->dmd)) {
-		ret = PTR_ERR(dsi->dmd);
+	dmd = dw_mipi_dsi_probe(pdev, &dsi->pdata);
+	if (IS_ERR(dmd)) {
+		ret = PTR_ERR(dmd);
 		if (ret != -EPROBE_DEFER)
 			DRM_DEV_ERROR(dev,
 				      "Failed to probe dw_mipi_dsi: %d\n", ret);
diff --git a/include/drm/bridge/dw_mipi_dsi.h b/include/drm/bridge/dw_mipi_dsi.h
index bda8aa7c2280..cf81f19806ad 100644
--- a/include/drm/bridge/dw_mipi_dsi.h
+++ b/include/drm/bridge/dw_mipi_dsi.h
@@ -41,7 +41,7 @@ struct dw_mipi_dsi_phy_ops {
 
 struct dw_mipi_dsi_host_ops {
 	int (*attach)(void *priv_data,
-		      struct mipi_dsi_device *dsi);
+		      struct mipi_dsi_device *dsi, struct dw_mipi_dsi *dmd);
 	int (*detach)(void *priv_data,
 		      struct mipi_dsi_device *dsi);
 };
-- 
2.25.1

