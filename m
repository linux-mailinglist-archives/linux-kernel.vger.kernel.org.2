Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FED3F22BC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhHSWKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:10:39 -0400
Received: from mout.perfora.net ([74.208.4.194]:47913 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236077AbhHSWKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:10:38 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M5MRl-1mzRWY1XI7-00zY5A;
 Fri, 20 Aug 2021 00:09:29 +0200
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
Subject: [PATCH v2 2/9] ARM: imx_v6_v7_defconfig: enable fb
Date:   Fri, 20 Aug 2021 00:09:03 +0200
Message-Id: <20210819220910.586819-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819220910.586819-1-marcel@ziswiler.com>
References: <20210819220910.586819-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7xd3Sd3qWsw+mazVWnHW+WUBAx5e7dut5ppXhsdqU53L6Y0qScs
 qKRL54Pn7+Pe3e4Wo13zllsS983SFbvnrIBoSF7tKYQw2MOEIj88d9jszDbyfKgbDOHvFiy
 UsSfnkv3k7qArQM2knxa6+Q7G1/UZFg8emkXBpjVT1FlF3ezczuC2GbJsOD1eeWSQdzIuDD
 RUkwKI0jqcmA2vHyOOEzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gqrfid0y6mw=:7Kzktt8jy7uQ+1cxSGHd71
 iJIf531z0NGj1E0VF/l4P5Q0OPkFCETUMzJG/OvrZlpsFaM9AxkIbKZhYkvZ/U8+NmWnwz5zC
 h8xHtZ5RwQ9B0vXT07sRdGnSqg5mhkaofeXcx+h4HQ5mMwgnDHThnuBv4FX5G0HK09bZgxt8T
 UPI78Zlwbq9wyVblexifzDSnhW8Ddz9t5/O7/PnmxSvLW3w/2TksG6c7tB8CdMVw4TYMNP6qO
 W5uwnjChKz6tN6zHmpzZSu91MdSb20T9bSZ+aSIEgndI/AaxtZQZsIj/05zC9X5dLpzipH5+V
 6Rh29sPCRi5Y6vbA7hURSPxNjJOybKTEvCoWvsYlp7h8i7iiNehAwPN5eSyTdBuoMmfxibmv5
 ve6OtWAuQZnPhEF58kv3WETJ3nUmAQ+7cxWAc7Bq8cOVjaEK9bnFk5kWPrizMBDLJuASK+lXV
 NrK5+Xvk/JAY6ZUgitHCoQdE0Lj4N8+sTMhciitknaDWz2ufD0l1gUaEctm7KGZpVaduop78K
 BhEjcj3In7fCtW7PF4jRhMH4r8sKPHErOz56C5sHRir+UeKPxm57q7PtUUyRUsNzoySDLfql3
 AF7h0mI/MjdX/HeLIY5lzYtjzQeCR3kEpUF/iTHMwQaqw/rXtTZt4uEucjJVlYO75ezZdkYpx
 cCORKFv+7mvLePpxp1OAEgg5cdijdYXW+Ei8xm+WlD83Z16EQkjqWWdeDF5NQUO9eLoHrZMq+
 QqBHr6Sul/ZrIsxhe7qpJ9xp5H+VFyf4hhZo8KYUvqmep0W0XtxcDyk7SAs67wCjt4TkW8YeI
 k0afxscHF17CGEu6jUZaJa/Nt4H6gaEmErxytfzWNHPKjTo6/xHa5as0xne1/apVZLY4Vg9
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

(no changes since v1)

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

