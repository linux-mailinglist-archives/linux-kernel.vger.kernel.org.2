Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B093315C89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhBJBrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:47:18 -0500
Received: from mailoutvs47.siol.net ([185.57.226.238]:33213 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234605AbhBJABx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:01:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 7E74A5231C9;
        Tue,  9 Feb 2021 18:59:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 23598l2DK9XD; Tue,  9 Feb 2021 18:59:11 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 2DA245233C8;
        Tue,  9 Feb 2021 18:59:11 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id DD15D5231C9;
        Tue,  9 Feb 2021 18:59:08 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        Andre Heider <a.heider@gmail.com>
Subject: [PATCH v3 2/5] drm/sun4i: tcon: set sync polarity for tcon1 channel
Date:   Tue,  9 Feb 2021 18:58:57 +0100
Message-Id: <20210209175900.7092-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209175900.7092-1-jernej.skrabec@siol.net>
References: <20210209175900.7092-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Channel 1 has polarity bits for vsync and hsync signals but driver never
sets them. It turns out that with pre-HDMI2 controllers seemingly there
is no issue if polarity is not set. However, with HDMI2 controllers
(H6) there often comes to de-synchronization due to phase shift. This
causes flickering screen. It's safe to assume that similar issues might
happen also with pre-HDMI2 controllers.

Solve issue with setting vsync and hsync polarity. Note that display
stacks with tcon top have polarity bits actually in tcon0 polarity
register.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
index 6b9af4c08cd6..9f06dec0fc61 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -672,6 +672,30 @@ static void sun4i_tcon1_mode_set(struct sun4i_tcon *=
tcon,
 		     SUN4I_TCON1_BASIC5_V_SYNC(vsync) |
 		     SUN4I_TCON1_BASIC5_H_SYNC(hsync));
=20
+	/* Setup the polarity of multiple signals */
+	if (tcon->quirks->polarity_in_ch0) {
+		val =3D 0;
+
+		if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+			val |=3D SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
+
+		if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+			val |=3D SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
+
+		regmap_write(tcon->regs, SUN4I_TCON0_IO_POL_REG, val);
+	} else {
+		/* according to vendor driver, this bit must be always set */
+		val =3D SUN4I_TCON1_IO_POL_UNKNOWN;
+
+		if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+			val |=3D SUN4I_TCON1_IO_POL_HSYNC_POSITIVE;
+
+		if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+			val |=3D SUN4I_TCON1_IO_POL_VSYNC_POSITIVE;
+
+		regmap_write(tcon->regs, SUN4I_TCON1_IO_POL_REG, val);
+	}
+
 	/* Map output pins to channel 1 */
 	regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
 			   SUN4I_TCON_GCTL_IOMAP_MASK,
@@ -1500,6 +1524,7 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv=
_quirks =3D {
=20
 static const struct sun4i_tcon_quirks sun8i_r40_tv_quirks =3D {
 	.has_channel_1		=3D true,
+	.polarity_in_ch0	=3D true,
 	.set_mux		=3D sun8i_r40_tcon_tv_set_mux,
 };
=20
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/s=
un4i_tcon.h
index c5ac1b02482c..e624f6977eb8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -154,6 +154,11 @@
 #define SUN4I_TCON1_BASIC5_V_SYNC(height)		(((height) - 1) & 0x3ff)
=20
 #define SUN4I_TCON1_IO_POL_REG			0xf0
+/* there is no documentation about this bit */
+#define SUN4I_TCON1_IO_POL_UNKNOWN			BIT(26)
+#define SUN4I_TCON1_IO_POL_HSYNC_POSITIVE		BIT(25)
+#define SUN4I_TCON1_IO_POL_VSYNC_POSITIVE		BIT(24)
+
 #define SUN4I_TCON1_IO_TRI_REG			0xf4
=20
 #define SUN4I_TCON_ECC_FIFO_REG			0xf8
@@ -236,6 +241,7 @@ struct sun4i_tcon_quirks {
 	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
 	bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
 	bool	supports_lvds;   /* Does the TCON support an LVDS output? */
+	bool	polarity_in_ch0; /* some tcon1 channels have polarity bits in tcon=
0 pol register */
 	u8	dclk_min_div;	/* minimum divider for TCON0 DCLK */
=20
 	/* callback to handle tcon muxing options */
--=20
2.30.0

