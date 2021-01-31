Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5057A309B9F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 12:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhAaLd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 06:33:57 -0500
Received: from aruko.org ([45.79.249.221]:45562 "EHLO aruko.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhAaKD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 05:03:27 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Jan 2021 05:03:26 EST
Received: from localhost.localdomain (unknown [213.111.80.72])
        by aruko.org (Postfix) with ESMTPSA id 846097F490;
        Sun, 31 Jan 2021 09:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruko.org; s=mail;
        t=1612086979; bh=BR+v5+Lk98D4lDAW6A9QFAcr2Xt0wa+x6kocx5HNdWo=;
        h=From:To:Cc:Subject:Date;
        b=ivbh9MwRO2AXcUIv7cXD8CkWnS7ciFW5GM+j8AnnwD/ctqxV0yNwCfqLQFlh2QwC9
         KH0RvaaE2BaO0poU2GRdJesve11fj6CztTcH9LKwj+WsdyjgGrIBec0mXK0d2qEYfA
         ArQ6FoQd3nlPLjQEb/8sPSDTQRw0Fd278MZxzyXg=
From:   Mykyta Poturai <ddone@aruko.org>
Cc:     Mykyta Poturai <ddone@aruko.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/bridge: dw-hdmi: Add DT binding to disable hotplug detect
Date:   Sun, 31 Jan 2021 11:55:35 +0200
Message-Id: <20210131095537.962292-1-ddone@aruko.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "disable-hpd" boolean binding for the device tree. When this option
is turned on HPD-related IRQ is disabled and it is assumed that the HDMI
connector is connected all the time. This may be useful in systems where
it is impossible or undesirable to connect the HPD pin, or the
connection is broken.

Signed-off-by: Mykyta Poturai <ddone@aruko.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 0c79a9ba48bb..4ca0ac130beb 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -194,6 +194,7 @@ struct dw_hdmi {
 	unsigned int audio_cts;
 	unsigned int audio_n;
 	bool audio_enable;
+	bool disable_hpd;
 
 	unsigned int reg_shift;
 	struct regmap *regm;
@@ -1559,7 +1560,7 @@ static void dw_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
 enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
 					       void *data)
 {
-	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
+	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD || hdmi->disable_hpd ?
 		connector_status_connected : connector_status_disconnected;
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_phy_read_hpd);
@@ -1585,6 +1586,10 @@ void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
 	 * Configure the PHY RX SENSE and HPD interrupts polarities and clear
 	 * any pending interrupt.
 	 */
+
+	if (hdmi->disable_hpd)
+		return;
+
 	hdmi_writeb(hdmi, HDMI_PHY_HPD | HDMI_PHY_RX_SENSE, HDMI_PHY_POL0);
 	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
 		    HDMI_IH_PHY_STAT0);
@@ -3212,6 +3217,10 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 	mutex_init(&hdmi->cec_notifier_mutex);
 	spin_lock_init(&hdmi->audio_lock);
 
+	if (of_property_read_bool(np, "disable-hpd")) {
+		dev_info(hdmi->dev, "Disabling HPD\n");
+		hdmi->disable_hpd = true;
+	}
 	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
 	if (ddc_node) {
 		hdmi->ddc = of_get_i2c_adapter_by_node(ddc_node);
-- 
2.30.0

