Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8506839D239
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhFFXcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:32:11 -0400
Received: from vps.xff.cz ([195.181.215.36]:45602 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhFFXcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1623022218; bh=GZvB4cKVUQepDY46C8gDXhb5mqbZg4ujUBa2NJqtOi8=;
        h=From:To:Cc:Subject:Date:From;
        b=CESemvH5PSjyLinFUeySjiEZiqsSPoo8Liw6gutud4BuOdJl0OloiW4ZnUVaUq/Zb
         IWEv4IMQce92KKk2437M/lb+O4R4XPqf5VsX2FFzrzCy+ekqrD/vZtmVLLpuo4lGJ6
         F/g8yg+x783J95I8OHH/j67jHnFVS0QA+FIMJMaY=
From:   Ondrej Jirman <megous@megous.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR ALLWINNER DE2
        AND DE3 ENGINE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
        linux-kernel@vger.kernel.org (open list)
Cc:     Saravana Kannan <saravanak@google.com>,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH] drm/sun4i: dw-hdmi: Make HDMI PHY into a platform device
Date:   Mon,  7 Jun 2021 01:30:16 +0200
Message-Id: <20210606233017.2730285-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

On sunxi boards that use HDMI output, HDMI device probe keeps being
avoided indefinitely with these repeated messages in dmesg:

  platform 1ee0000.hdmi: probe deferral - supplier 1ef0000.hdmi-phy
    not ready

There's a fwnode_link being created with fw_devlink=on between hdmi
and hdmi-phy nodes, because both nodes have 'compatible' property set.

Fw_devlink code assumes that nodes that have compatible property
set will also have a device associated with them by some driver
eventually. This is not the case with the current sun8i-hdmi-phy
driver.

This commit makes sun8i-hdmi-phy into a proper platform device
and fixes the display pipeline probe on sunxi boards that use HDMI.

More context: https://lkml.org/lkml/2021/5/16/203

Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  |  4 +--
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  3 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 42 +++++++++++++++++++++++---
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index bbdfd5e26ec88..e892a05e69e9b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -209,7 +209,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_clk_tmds;
 	}
 
-	ret = sun8i_hdmi_phy_probe(hdmi, phy_node);
+	ret = sun8i_hdmi_phy_get(hdmi, phy_node);
 	of_node_put(phy_node);
 	if (ret) {
 		dev_err(dev, "Couldn't get the HDMI PHY\n");
@@ -242,7 +242,6 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 
 cleanup_encoder:
 	drm_encoder_cleanup(encoder);
-	sun8i_hdmi_phy_remove(hdmi);
 err_disable_clk_tmds:
 	clk_disable_unprepare(hdmi->clk_tmds);
 err_assert_ctrl_reset:
@@ -263,7 +262,6 @@ static void sun8i_dw_hdmi_unbind(struct device *dev, struct device *master,
 	struct sun8i_dw_hdmi *hdmi = dev_get_drvdata(dev);
 
 	dw_hdmi_unbind(hdmi->hdmi);
-	sun8i_hdmi_phy_remove(hdmi);
 	clk_disable_unprepare(hdmi->clk_tmds);
 	reset_control_assert(hdmi->rst_ctrl);
 	gpiod_set_value(hdmi->ddc_en, 0);
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index d4b55af0592f8..8a8adef48be0f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -201,8 +201,7 @@ encoder_to_sun8i_dw_hdmi(struct drm_encoder *encoder)
 	return container_of(encoder, struct sun8i_dw_hdmi, encoder);
 }
 
-int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node);
-void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi);
+int sun8i_hdmi_phy_get(struct sun8i_dw_hdmi *hdmi, struct device_node *node);
 
 void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
 void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 9994edf675096..947b4231f6449 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -5,6 +5,7 @@
 
 #include <linux/delay.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 
 #include "sun8i_dw_hdmi.h"
 
@@ -597,10 +598,30 @@ static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 	{ /* sentinel */ }
 };
 
-int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
+int sun8i_hdmi_phy_get(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
+{
+	struct platform_device *pdev = of_find_device_by_node(node);
+	struct sun8i_hdmi_phy *phy;
+
+	if (!pdev)
+		return -EPROBE_DEFER;
+
+	phy = platform_get_drvdata(pdev);
+	if (!phy)
+		return -EPROBE_DEFER;
+
+	hdmi->phy = phy;
+
+	put_device(&pdev->dev);
+
+	return 0;
+}
+
+int sun8i_hdmi_phy_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
-	struct device *dev = hdmi->dev;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
 	struct sun8i_hdmi_phy *phy;
 	struct resource res;
 	void __iomem *regs;
@@ -704,7 +725,7 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 		clk_prepare_enable(phy->clk_phy);
 	}
 
-	hdmi->phy = phy;
+	platform_set_drvdata(pdev, phy);
 
 	return 0;
 
@@ -728,9 +749,9 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 	return ret;
 }
 
-void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
+int sun8i_hdmi_phy_remove(struct platform_device *pdev)
 {
-	struct sun8i_hdmi_phy *phy = hdmi->phy;
+	struct sun8i_hdmi_phy *phy = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(phy->clk_mod);
 	clk_disable_unprepare(phy->clk_bus);
@@ -744,4 +765,15 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
 	clk_put(phy->clk_pll1);
 	clk_put(phy->clk_mod);
 	clk_put(phy->clk_bus);
+	return 0;
 }
+
+static struct platform_driver sun8i_hdmi_phy_driver = {
+	.probe  = sun8i_hdmi_phy_probe,
+	.remove = sun8i_hdmi_phy_remove,
+	.driver = {
+		.name = "sun8i-hdmi-phy",
+		.of_match_table = sun8i_hdmi_phy_of_table,
+	},
+};
+module_platform_driver(sun8i_hdmi_phy_driver);
-- 
2.31.1

