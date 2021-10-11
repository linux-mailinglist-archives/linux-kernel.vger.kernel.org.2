Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C457428E68
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhJKNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:45:18 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59622 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237363AbhJKNoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:44:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B4438FB04;
        Mon, 11 Oct 2021 15:41:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ULF1ka445KeL; Mon, 11 Oct 2021 15:41:44 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ondrej Jirman <megous@megous.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/5] drm: mxsfb: Set fallback bus format when the bridge doesn't provide one
Date:   Mon, 11 Oct 2021 15:41:27 +0200
Message-Id: <781f0352052cc50c823c199ef5f53c84902d0580.1633959458.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633959458.git.agx@sigxcpu.org>
References: <cover.1633959458.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a bridge doesn't do any bus format handling MEDIA_BUS_FMT_FIXED is
returned. Fallback to a reasonable default (MEDIA_BUS_FMT_RGB888_1X24) in
that case.

This unbreaks e.g. using mxsfb with the nwl bridge and mipi dsi panels.

Reported-by: Martin Kepplinger <martink@posteo.de>
Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index d6abd2077114..e3fbb8b58d5d 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -369,6 +369,12 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
 			drm_atomic_get_new_bridge_state(state,
 							mxsfb->bridge);
 		bus_format = bridge_state->input_bus_cfg.format;
+		if (bus_format == MEDIA_BUS_FMT_FIXED) {
+			dev_warn_once(drm->dev,
+				      "Bridge does not provide bus format, assuming MEDIA_BUS_FMT_RGB888_1X24.\n"
+				      "Please fix bridge driver by handling atomic_get_input_bus_fmts.\n");
+			bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+		}
 	}
 
 	/* If there is no bridge, use bus format from connector */
-- 
2.33.0

