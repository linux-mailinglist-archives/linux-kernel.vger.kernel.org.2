Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D2B411783
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbhITOwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:52:00 -0400
Received: from mout.perfora.net ([74.208.4.196]:57401 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237966AbhITOvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:51:55 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M4aZ0-1mTyVd0kLu-001eN6;
 Mon, 20 Sep 2021 16:49:59 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] ARM: imx_v6_v7_defconfig: enable fb
Date:   Mon, 20 Sep 2021 16:49:31 +0200
Message-Id: <20210920144938.314588-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210920144938.314588-1-marcel@ziswiler.com>
References: <20210920144938.314588-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yebCBm5BG/l43LRJf+84rEt5j+YAKcMgsORhVDriP9lruRDnDJ2
 +wn1568LpzVPAj3NyNyb3AK/Q+1xWKZwsQ0GJ/znIxuZzZkd9JSPQ3oE82V3Q+ATppxE+OZ
 wPQeVVz7+tjr2TpQQzMfGL5rrEFc+LfTfucig0KBKhy7wRgtgQ6sTZEBMrjX9mToPa6aRb6
 jTGqgdfYGcI8HcAv+zE7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V1BecXKIRew=:5l9dEMbe86H+XOcEpoVxOF
 meu4fvNHtMai3Hojxa+q+EaiFCJD7/q3YksuoY+HsqSboxJy47Y1z7kWeIJLKGRPbZ7CTU82E
 ZBIl0EySqKOLD5mVo0hqxM+LN+kw9tclQFxbqWBm52QxVAUqmeRO7iBttdGz3CHBgJuY0BbfN
 YKExZGTtb7QNjMdGn0POxxVafBbJmbQHehbzsyKmxhldJhWjcvvL94xxAb0H631jbt4V18Sn2
 KLyowgbfK2Dyyt3pUX7per1qRHyAFt85+xtUV/JXYjBC5krk7hApQZVsB/q9P6ea598M00oFK
 3aCmu+B1LfH/JDWXmZbZ+ROtjA5N5t/UEkfFUJd/P4/3Z1CsrZACYf8SQ0PcJWx1pYouIOUc/
 lqZ8pe9RQVfni85KURIUsqj1cTk3ZlQ0BSOBDstSTex22Mptw5VuRhYM845p00/YbXMvQWw8J
 YN5ganTyLGa9rKwEi+2WR6XtDpMwOt7XzfJk0MH/xgfRV+AUuq6aDi8Wfb7wnOQ7ioFh223nA
 Xr37c4l/hKPFP77SuovDUvjdfqb2c+Nd6jSI9RswU6fLMbbXdNGdii+wbCcWQzg79YfiPy3/r
 n9ytjBPltZ0VFrHKrPQW4RpNqTT5wWZVFwLHrkfLyh9p32qRs4ixq7cSwKwHlWSVBuJ87i0Vm
 QKzz1jPsXu1cIPSJVEOO19Jwrl2rDXeqOujooYqDbS0d/n74AqMRm0M600qwbQOJhcSGziBG1
 IXrCoeKJ9hO2Dn/c46sdh4QxUQTm7ErOuJ38Sg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_FB which is nowadays required for CONFIG_DRM_PANEL_LVDS,
CONFIG_DRM_PANEL_SIMPLE, CONFIG_DRM_PANEL_SEIKO_43WVF1G,
CONFIG_FB_MODE_HELPERS, CONFIG_BACKLIGHT_PWM, CONFIG_BACKLIGHT_GPIO,
CONFIG_FRAMEBUFFER_CONSOLE, CONFIG_LOGO, CONFIG_FONTS, CONFIG_FONT_8x8
and CONFIG_FONT_8x16.

Fixes: f611b1e7624c ("drm: Avoid circular dependencies for CONFIG_FB")
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

(no changes since v3)

Changes in v3:
- Add Fabio's reviewed-by. Thanks!
- Added fixes tag as pointed out by Stefan and Fabio. Thanks!

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 70b3c377c4302..6618a009a105e 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -293,6 +293,7 @@ CONFIG_DRM_IMX_LDB=y
 CONFIG_DRM_IMX_HDMI=y
 CONFIG_DRM_ETNAVIV=y
 CONFIG_DRM_MXSFB=y
+CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
-- 
2.26.2

