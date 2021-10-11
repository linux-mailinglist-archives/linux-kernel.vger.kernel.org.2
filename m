Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC564428E66
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhJKNpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:45:00 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59534 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237309AbhJKNoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:44:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E2588FB05;
        Mon, 11 Oct 2021 15:41:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NpBdlXM3dTqi; Mon, 11 Oct 2021 15:41:42 +0200 (CEST)
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
Subject: [PATCH v3 4/5] drm: mxsfb: Print failed bus format in hex
Date:   Mon, 11 Oct 2021 15:41:26 +0200
Message-Id: <c84b34855abbb85cd25bbb5126db302f88327640.1633959458.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633959458.git.agx@sigxcpu.org>
References: <cover.1633959458.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

media-bus-formats.h has them in hexadecimal as well so matching with
that file saves one conversion when debugging.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index af6c620adf6e..d6abd2077114 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -89,7 +89,7 @@ static void mxsfb_set_formats(struct mxsfb_drm_private *mxsfb,
 		ctrl |= CTRL_BUS_WIDTH_24;
 		break;
 	default:
-		dev_err(drm->dev, "Unknown media bus format %d\n", bus_format);
+		dev_err(drm->dev, "Unknown media bus format 0x%x\n", bus_format);
 		break;
 	}
 
-- 
2.33.0

