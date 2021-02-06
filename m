Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F683311D87
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 14:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBFNvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 08:51:13 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49114 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhBFNvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 08:51:07 -0500
Received: from p508fcd06.dip0.t-ipconnect.de ([80.143.205.6] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l8Nyg-0007o1-Ae; Sat, 06 Feb 2021 14:50:22 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] drm/panel: kd35t133: allow using non-continuous dsi clock
Date:   Sat,  6 Feb 2021 14:50:20 +0100
Message-Id: <20210206135020.1991820-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel is able to work when dsi clock is non-continuous, thus
the system power consumption can be reduced using such feature.

Add MIPI_DSI_CLOCK_NON_CONTINUOUS to panel's mode_flags.

Also the flag actually becomes necessary after
commit c6d94e37bdbb ("drm/bridge/synopsys: dsi: add support for non-continuous HS clock")
and without it the panel only emits stripes instead of output.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/panel/panel-elida-kd35t133.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index bc36aa3c1123..fe5ac3ef9018 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -265,7 +265,8 @@ static int kd35t133_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = 1;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_EOT_PACKET;
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_EOT_PACKET |
+			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
 	drm_panel_init(&ctx->panel, &dsi->dev, &kd35t133_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
-- 
2.29.2

