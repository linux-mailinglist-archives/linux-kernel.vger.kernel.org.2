Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C10230D828
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhBCLHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhBCLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:07:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D1C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:06:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DEF791F454BD
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] phy: mediatek: Add missing MODULE_DEVICE_TABLE()
Date:   Wed,  3 Feb 2021 12:06:30 +0100
Message-Id: <20210203110631.686003-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

This patch adds the missing MODULE_DEVICE_TABLE definitions on different
Mediatek phy drivers which generates correct modalias for automatic loading
when these drivers are compiled as an external module.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/phy/mediatek/phy-mtk-hdmi.c     | 1 +
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index 45be8aa724f3..8313bd517e4c 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -201,6 +201,7 @@ static const struct of_device_id mtk_hdmi_phy_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, mtk_hdmi_phy_match);
 
 static struct platform_driver mtk_hdmi_phy_driver = {
 	.probe = mtk_hdmi_phy_probe,
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
index 18c481251f04..9c7815bb9000 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -233,6 +233,7 @@ static const struct of_device_id mtk_mipi_tx_match[] = {
 	  .data = &mt8183_mipitx_data },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, mtk_mipi_tx_match);
 
 struct platform_driver mtk_mipi_tx_driver = {
 	.probe = mtk_mipi_tx_probe,
-- 
2.30.0

