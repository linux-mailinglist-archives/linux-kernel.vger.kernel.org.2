Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C24410BA1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 14:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhISM6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 08:58:00 -0400
Received: from mout.perfora.net ([74.208.4.194]:41953 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232119AbhISM5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:57:54 -0400
Received: from localhost.localdomain ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mowvi-1nEz5s33S2-00qRdV;
 Sun, 19 Sep 2021 14:55:59 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] ARM: imx_v6_v7_defconfig: change snd soc tlv320aic3x to i2c variant
Date:   Sun, 19 Sep 2021 14:55:30 +0200
Message-Id: <20210919125536.117743-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210919125536.117743-1-marcel@ziswiler.com>
References: <20210919125536.117743-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S9b7b3QtLb7YYzwNrT4SXOW9B2N+3Vp3iRNGKqpuvhqtQPqqRsR
 0lRGaF88rfuz4xIbqc0STWlnOlb9bvYPo4MmF1uc306i921KhZ8kpLJ5oXDDmN1UfrvQNw3
 yt340ZphkDd/GY8ic4xM3NvGMsbYKC/+3aDbEGk8AN/+scLBAZ6WZ2piDxp19a62rRGnlr8
 wVuK2oJONv61g38lPzfrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QjgpBj+Dy0s=:JO1kZhoJfV/rgH1I7BFh1C
 tHDEhcWgwcrUdg9Er5eZ4QWn8SQbbFJRN7GSbNDQACJauuNU8LBvccGr7fGuqiic+kSTRRLnG
 hQxs2x97Rok6JTJUEWK89XjXYH2pbpXJvMzFFWPVgZ2eCIyYl+yB74KQYYSYr0ugv7EAE96td
 kQopFGSwkkhqoS0OZvGy5cl1EGlLJkyLvw8+m9+mBOOsvWr5BvKggfBnjAyJ2pxIbZcfKfqpu
 N+RFa8QNLFre4gJ8KR2t3flbngUDjypckamcsVTl5G0Tip/OYo/TVQFPEVK9F5vnTeBA9843M
 XQuDbZ7LAShyBcsN/AieXb/gYiiHokea70R9Mrx+jJaWVyTgMBQv3TpKQZUp1i/7dOF3X1TdP
 Mj2kZadcZuTOJx5FAe/vt/GYQyyDTRSL6mCa8Uy9jnNPyo3MxWMhJ9Kh+UBz8QJaTklcZVk97
 adSxIW/QiQtitwdJxfZ0vL8W0nU5VwJZDTZ+R2/BFYxhZYnXTX47mmqvuRBsFfKcF2/Yflq6z
 gn65D5wKgt0nQgJ3FhJxnMwNbGZ4iR8KDRpEQvLaNBOA9Zk1rvMV+qEuHpAuZ/gz5uDh8zJPU
 qzpwmgXAPJq/k2B2ndUMynV3aMsjQIcN8T3B38r8749IwpV8jiecMhvRbt1IXFo0NfsQpX9Mu
 G602AabMG9fpRWkazG4rBxgN3KyzalSKWVYljLiAGYHf1L7eeGTCpa4i+6P3SmP/Qm4YUSvX6
 SPuWU0zQxO8qDoGdxBePQ6A9AysA4x5TbS+JDA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Change CONFIG_SND_SOC_TLV320AIC3X to CONFIG_SND_SOC_TLV320AIC3X_I2C.
I did double check all current mainline device trees and they are all
using the I2C rather than the SPI variant.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes in v3:
- Add Fabio's reviewed-by. Thanks!

 arch/arm/configs/imx_v6_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6618a009a105e..90d6a5cf254e0 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -317,7 +317,7 @@ CONFIG_SND_SOC_IMX_MC13783=y
 CONFIG_SND_SOC_FSL_ASOC_CARD=y
 CONFIG_SND_SOC_AC97_CODEC=y
 CONFIG_SND_SOC_CS42XX8_I2C=y
-CONFIG_SND_SOC_TLV320AIC3X=y
+CONFIG_SND_SOC_TLV320AIC3X_I2C=y
 CONFIG_SND_SOC_WM8960=y
 CONFIG_SND_SOC_WM8962=y
 CONFIG_SND_SIMPLE_CARD=y
-- 
2.26.2

