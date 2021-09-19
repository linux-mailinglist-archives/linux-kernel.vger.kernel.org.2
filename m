Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6142C410B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhISM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 08:57:54 -0400
Received: from mout.perfora.net ([74.208.4.196]:35825 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhISM5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:57:50 -0400
Received: from localhost.localdomain ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N95Jb-1muyAl0cxL-016B4G;
 Sun, 19 Sep 2021 14:55:56 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>, Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] ARM: imx_v6_v7_defconfig: enable fb
Date:   Sun, 19 Sep 2021 14:55:29 +0200
Message-Id: <20210919125536.117743-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210919125536.117743-1-marcel@ziswiler.com>
References: <20210919125536.117743-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L+cKcL6Pet9lI5Tn8BZN8F8pw5L0usnMYBsc7ux+h+QilqElK+I
 99yYuls5NbahGXiKDvG5Cc/WOM0S6xZF/6GGWLT6bYyB2rIBoxGcTRbbFrjI03aXQg/lpuB
 6J48Nt8nBeSTIe++Nr3m8GybcBbkRk5ARbLqKcb/gTcndXIwRdzLcZSspNQua468JS4WSFD
 gAz/pmwpD8TS2WNzPUH7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q4ECm4XIbas=:OIJMeMBw4NUeFfaBd9YFOr
 rUo2qlMjDAkpVM++K/3gGqUxYJqbDEKDwNZCNcfWSLBzmTcavXw2TiK86ezuH595Dpgfosyk9
 Ov0C+iroKgfpNexsztCAyG7GedLXi+4SpCNIAB6O7yLrgvIS5hsEgwQalhxrvLVxGXOOKSpel
 MRHY32l9rBL6iLbhaeCUNEtkC0BrH6/0Ynh6tSro9a5pD7fthnbtGxgQCEHXASGaeOc36XlUj
 EH3gF9gYtkPuYd4o7U018lSxkE9COi7i2RNwubVqQTZABTtfu7geKbOCuOGb4Wb/2u2TeSvz2
 vbPB/wmf7MJ7qZCl69IYDKu/8iAG5xZsKvTcmXcjz0t3AueY/66cyym03yTot4z3mxCgN9wYR
 DQ22mq9b/vrX05Mw6fub0OcXKRR7Cody/BQOKUz9Xc5dOaaGEVCOabhH+xtKAW2dNpyeLREQO
 YU/q+2zfXaV38vluhCvvac2D4GUFsc8lt0uHS4ekrelpWIfwi3sl/C05DJS6ZQGaOtftMwofX
 a33xnPpxMIwmx+pCRP/K84to2sfIkflzw3y736tv7amHVRZLWPJA4ABHAXjEWHLG/M+iYJw25
 GPJ1jhqnAtndSFmog/2NC453NsaSy6g53pVl33eCWiqTtRS0O90xjjTaEYbyCIlEDQDZTZSCB
 wpbz8YdV1VnPSIPf9ZeJsBWXMf6/corpsP1v0wc6XMFxuRL4mNJlQMgT7AxBG5mMCKHE2AU4e
 Q14UnAZaRH4u98VbumRVeZJEXXUhgDHJbqCPwg==
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

