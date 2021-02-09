Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B11C315C85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhBJBqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:46:44 -0500
Received: from mailoutvs3.siol.net ([185.57.226.194]:33221 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234579AbhBJABm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:01:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id BA37952342E;
        Tue,  9 Feb 2021 18:59:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SkxLcbFj0EGA; Tue,  9 Feb 2021 18:59:13 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 7BB21521274;
        Tue,  9 Feb 2021 18:59:13 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 3403052342E;
        Tue,  9 Feb 2021 18:59:11 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        Andre Heider <a.heider@gmail.com>
Subject: [PATCH v3 3/5] drm/sun4i: dw-hdmi: always set clock rate
Date:   Tue,  9 Feb 2021 18:58:58 +0100
Message-Id: <20210209175900.7092-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209175900.7092-1-jernej.skrabec@siol.net>
References: <20210209175900.7092-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As expected, HDMI controller clock should always match pixel clock. In
the past, changing HDMI controller rate would seemingly worsen
situation. However, that was the result of other bugs which are now
fixed.

Fix that by removing set_rate quirk and always set clock rate.

Fixes: 40bb9d3147b2 ("drm/sun4i: Add support for H6 DW HDMI controller")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 4 +---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.c
index 92add2cef2e7..23773a5e0650 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -21,8 +21,7 @@ static void sun8i_dw_hdmi_encoder_mode_set(struct drm_e=
ncoder *encoder,
 {
 	struct sun8i_dw_hdmi *hdmi =3D encoder_to_sun8i_dw_hdmi(encoder);
=20
-	if (hdmi->quirks->set_rate)
-		clk_set_rate(hdmi->clk_tmds, mode->crtc_clock * 1000);
+	clk_set_rate(hdmi->clk_tmds, mode->crtc_clock * 1000);
 }
=20
 static const struct drm_encoder_helper_funcs
@@ -295,7 +294,6 @@ static int sun8i_dw_hdmi_remove(struct platform_devic=
e *pdev)
=20
 static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks =3D {
 	.mode_valid =3D sun8i_dw_hdmi_mode_valid_a83t,
-	.set_rate =3D true,
 };
=20
 static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks =3D {
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.h
index d983746fa194..d4b55af0592f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -179,7 +179,6 @@ struct sun8i_dw_hdmi_quirks {
 	enum drm_mode_status (*mode_valid)(struct dw_hdmi *hdmi, void *data,
 					   const struct drm_display_info *info,
 					   const struct drm_display_mode *mode);
-	unsigned int set_rate : 1;
 	unsigned int use_drm_infoframe : 1;
 };
=20
--=20
2.30.0

