Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49D30D82A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhBCLII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:08:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58074 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhBCLIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:08:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 030BD1F454D3
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] drm/mediatek: Add missing MODULE_DEVICE_TABLE()
Date:   Wed,  3 Feb 2021 12:07:17 +0100
Message-Id: <20210203110717.686204-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

This patch adds the missing MODULE_DEVICE_TABLE definitions on different
Mediatek drivers which generates correct modalias for automatic loading
when these drivers are compiled as an external module.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/mediatek/mtk_cec.c      | 2 ++
 drivers/gpu/drm/mediatek/mtk_dpi.c      | 1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 1 +
 drivers/gpu/drm/mediatek/mtk_dsi.c      | 1 +
 drivers/gpu/drm/mediatek/mtk_hdmi.c     | 1 +
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c | 1 +
 6 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index cb29b649fcdb..3b86e626e459 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
@@ -247,6 +248,7 @@ static const struct of_device_id mtk_cec_of_ids[] = {
 	{ .compatible = "mediatek,mt8173-cec", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_cec_of_ids);
 
 struct platform_driver mtk_cec_driver = {
 	.probe = mtk_cec_probe,
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 52f11a63a330..2680370652fd 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -822,6 +822,7 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
 
 struct platform_driver mtk_dpi_driver = {
 	.probe = mtk_dpi_probe,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 5f49a809689b..e4645c8ae1c0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -470,6 +470,7 @@ static const struct of_device_id mtk_drm_of_ids[] = {
 	  .data = &mt8183_mmsys_driver_data},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
 
 static int mtk_drm_probe(struct platform_device *pdev)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 0527480c07be..c71ce62d1bec 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1193,6 +1193,7 @@ static const struct of_device_id mtk_dsi_of_match[] = {
 	  .data = &mt8183_dsi_driver_data },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);
 
 struct platform_driver mtk_dsi_driver = {
 	.probe = mtk_dsi_probe,
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 8ee55f9e2954..b4696a9d73f7 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1818,6 +1818,7 @@ static const struct of_device_id mtk_drm_hdmi_of_ids[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_drm_hdmi_of_ids);
 
 static struct platform_driver mtk_hdmi_driver = {
 	.probe = mtk_drm_hdmi_probe,
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
index 62dbad5675bb..6207eac88550 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
@@ -335,6 +335,7 @@ static const struct of_device_id mtk_hdmi_ddc_match[] = {
 	{ .compatible = "mediatek,mt8173-hdmi-ddc", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mtk_hdmi_ddc_match);
 
 struct platform_driver mtk_hdmi_ddc_driver = {
 	.probe = mtk_hdmi_ddc_probe,
-- 
2.30.0

