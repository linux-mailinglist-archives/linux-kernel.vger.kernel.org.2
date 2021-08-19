Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8CE3F1B48
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhHSOK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:10:57 -0400
Received: from mout.perfora.net ([74.208.4.196]:55299 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240471AbhHSOK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:10:56 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MMksD-1m8llE0zsN-008XyC;
 Thu, 19 Aug 2021 16:04:03 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/7] ARM: imx_v6_v7_defconfig: enable fb
Date:   Thu, 19 Aug 2021 16:03:40 +0200
Message-Id: <20210819140345.357167-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819140345.357167-1-marcel@ziswiler.com>
References: <20210819140345.357167-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W4KhQt9MZgq0YOYGEjYcEXsHohJrG9BIMdGsx3Oa2d2+UeezvBe
 +T2H3NPjayKRuSe0CyCYP1YgOmwXANgQ/dX5cf7GoCyQGGYLIHSfIyYhtmXfxSp2KOlMGdE
 NlfzsktRk13iPif1IqdABxhOrHU0mE7ontPjh+uzFqJJnzZCAqc//0iKqyalpdYKi9bG9zI
 4RRWx2JI6VpB8YC7oSPnQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ecurjJR373I=:TbaOCtKrrQqeB/UYU/mpmd
 CewnXWlhRstRJsM5SuBGtVgd4douKieNyi8kj+CbA5IHI+PrYoXot5GOrJQb2RXfLBvUeY8Pz
 FRI9k7er6hBSXZDJVjiS/PR35z3ktq7XF9mZFGxCn/N3jccsCgwn8DljNy4ypfnPnr2zHj4DP
 5i+AzX0HneDYZ7bI1EsPBXR9M/OeDMslHEyi6FAeVN0WeBNwFrSXrzE+ho8MKAFIjovKQ4s8S
 oERIwtaWA6K6P/Lg7k4xpyyUgJDuwu+RhQnZ4/QcxsUHiKlgA8RXk0Ek5/88WrkXuxUUOlAGC
 eaOaZerH5DLmYQYq+YugZnG7fsCEeudHbmvi3YVDQUqWdiL6x0894SU5XMtGovNIMg5Tdlp2R
 xJ/Z8pCrjux9MXMQhwaIeOs5PDtCUCMaFUOkXk5ig8iRov10JAiKJsAwOJCKPcXvBMCrh2Uqu
 TpshZHvGz9+UIGdgDaXlvfmRVvJrVa1ElWTAouZuLNlEYFJaWc6nBvKXP6gzLYOBf+K0ZDbOa
 pZY+QYXjieYWq0923eBcSAAN5lNMbUBc+MpqVlNW7/0gDBp0EG9Lg1n049/QjNjjkRSZaAfkK
 amnYT3nlUkUi6zwLXmWubt18ecemwhgVZbU4iAeHfppv7gUVb6pd94t/bDSCKCL+Tzeo1qMsB
 QMPtZ4qMdBGREij83WV+jXABKxOqtW4GPPSzh7AarkZJUnptKLTsHv/PXpGSN61oiu6ta2nII
 L6peFJo9e+utaMKKx3ZWNc+355pTkmYIlytDEQUMSEHUrGibdCTnhnYBh/Ho+6Ttck/2mbb9T
 YUown5NAq/Px6i2KjWyNVWoO59oH2vtxn9QH2UnwkVvQwKP/zOQR7yCZ4SgOzZX2sOUxumV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_FB which is nowadays required for CONFIG_DRM_PANEL_LVDS,
CONFIG_DRM_PANEL_SIMPLE, CONFIG_DRM_PANEL_SEIKO_43WVF1G,
CONFIG_FB_MODE_HELPERS, CONFIG_BACKLIGHT_PWM, CONFIG_BACKLIGHT_GPIO,
CONFIG_FRAMEBUFFER_CONSOLE, CONFIG_LOGO, CONFIG_FONTS, CONFIG_FONT_8x8
and CONFIG_FONT_8x16.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

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

