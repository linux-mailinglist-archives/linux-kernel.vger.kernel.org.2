Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069A7315B89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhBJApg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:45:36 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:48615 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233375AbhBIVOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:14:16 -0500
X-IronPort-AV: E=Sophos;i="5.81,166,1610406000"; 
   d="scan'208";a="492125955"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Feb 2021 22:13:10 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     David Airlie <airlied@linux.ie>
Cc:     kernel-janitors@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] drm: use getter/setter functions
Date:   Tue,  9 Feb 2021 22:13:04 +0100
Message-Id: <20210209211304.1261740-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use getter and setter functions, for platform_device structures and a
mipi_dsi_device structure.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c             |    2 +-
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c |    2 +-
 drivers/gpu/drm/panel/panel-lvds.c                  |    2 +-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c         |    4 ++--
 drivers/gpu/drm/panel/panel-simple.c                |    2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c            |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4e2dad314c79..9858079f9e14 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4800,7 +4800,7 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
 
 	err = mipi_dsi_attach(dsi);
 	if (err) {
-		struct panel_simple *panel = dev_get_drvdata(&dsi->dev);
+		struct panel_simple *panel = mipi_dsi_get_drvdata(dsi);
 
 		drm_panel_remove(&panel->base);
 	}
diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index 0ee508576231..3939b25e6666 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -267,7 +267,7 @@ static int seiko_panel_probe(struct device *dev,
 
 static int seiko_panel_remove(struct platform_device *pdev)
 {
-	struct seiko_panel *panel = dev_get_drvdata(&pdev->dev);
+	struct seiko_panel *panel = platform_get_drvdata(pdev);
 
 	drm_panel_remove(&panel->base);
 	drm_panel_disable(&panel->base);
@@ -277,7 +277,7 @@ static int seiko_panel_remove(struct platform_device *pdev)
 
 static void seiko_panel_shutdown(struct platform_device *pdev)
 {
-	struct seiko_panel *panel = dev_get_drvdata(&pdev->dev);
+	struct seiko_panel *panel = platform_get_drvdata(pdev);
 
 	drm_panel_disable(&panel->base);
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 654bc52d9ff3..bd5ba10822c2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -725,7 +725,7 @@ static int rockchip_lvds_probe(struct platform_device *pdev)
 
 static int rockchip_lvds_remove(struct platform_device *pdev)
 {
-	struct rockchip_lvds *lvds = dev_get_drvdata(&pdev->dev);
+	struct rockchip_lvds *lvds = platform_get_drvdata(pdev);
 
 	component_del(&pdev->dev, &rockchip_lvds_component_ops);
 	clk_unprepare(lvds->pclk);
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 457ec04950f7..c7707338bfdb 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -284,7 +284,7 @@ static int aspeed_gfx_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev_set_drvdata(&pdev->dev, priv);
+	platform_set_drvdata(pdev, priv);
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &aspeed_sysfs_attr_group);
 	if (ret)
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index d0c65610ebb5..989a05bc8197 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2457,7 +2457,7 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 
 static int cdns_mhdp_remove(struct platform_device *pdev)
 {
-	struct cdns_mhdp_device *mhdp = dev_get_drvdata(&pdev->dev);
+	struct cdns_mhdp_device *mhdp = platform_get_drvdata(pdev);
 	unsigned long timeout = msecs_to_jiffies(100);
 	bool stop_fw = false;
 	int ret;
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 66c7d765b8f7..59a8d99e777d 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -244,7 +244,7 @@ static int panel_lvds_probe(struct platform_device *pdev)
 
 static int panel_lvds_remove(struct platform_device *pdev)
 {
-	struct panel_lvds *lvds = dev_get_drvdata(&pdev->dev);
+	struct panel_lvds *lvds = platform_get_drvdata(pdev);
 
 	drm_panel_remove(&lvds->panel);
 

