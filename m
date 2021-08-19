Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78F23F1B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhHSOLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:11:03 -0400
Received: from mout.perfora.net ([74.208.4.194]:52467 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240493AbhHSOLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:11:00 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M4G3R-1n7JP43YHr-00rpvI;
 Thu, 19 Aug 2021 16:04:06 +0200
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
Subject: [PATCH v1 3/7] ARM: imx_v6_v7_defconfig: change snd soc tlv320aic3x to i2c variant
Date:   Thu, 19 Aug 2021 16:03:41 +0200
Message-Id: <20210819140345.357167-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819140345.357167-1-marcel@ziswiler.com>
References: <20210819140345.357167-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UPicR0BkMYvVCCDZw/kB5FU2/zjtoEv2VGHknXQUeT989ebg7ZM
 WxXRxORdTB74mXWwgl5xkzMNkxdB/cTmxzMG0RZH1xcopK3uWHLtzIqvuhzdC1DVQIBEWQu
 dnvTKWia56ja9K0WkZLZ4qSWtH6sBjO3+oNWg+PRdR79WGzTyZMeGilDJVQwBD7apMRSD3Q
 hSBUS/iHJYJkG1n0iR74w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AaHogfsqsug=:2xZ/ETolfmP9qlRigGZ/Lu
 5BM5JHNvlxgqFh5hF9RM1PJdujnIkM5sUlnxPasfuyFq6cZh2C0lT0CUBh7932Z+O+M3dOESP
 oiRLuWXhpC1FHt9s8uoyiz3NDx5/Oq1VLR/o2sbXNh3JomURGKLIt2ymYxmWXGW51k5Iz6YHF
 HzfZdkkzwMj3w6Ymc5Eye760zv9VKMHj/bJubbddBNlss1zI8HA13E0i1vcM2x67jEJJ1oF/g
 dxGrmQIYCT+qHgrbbj5AR2aLrkFuW1W+rDGQLUqbtR8CsJSadrJLCCrkop9njiAWrtbZ2XDuA
 vKUnbcpjnvGZ+yMm6TWuXsOe6D14kwO5mWYU2pTayqcjpa6/bGmuReznzMAAKN/qWYHNQ/hRw
 zPqXlHJH0abH8Md4zuM2Uh8jbWAAyOzbhnRDEbat4SO6diPDB8p9CDxrKVxTYZcv9YAI6XXJP
 mQzB2e0tlPJoz/a4zks4+223nhL5BAupH5cTxCE52ofuHMtWMYslO3BFsEnA04wzd+5VQdfmr
 4HcJeAxtZEqyCNyeY2JPVE+4Uja/uK5iWiJfxhFX0ZvBMxUJKyZGN8zTsRIHd3tZ5JiAMK4e5
 U8Jldfi0xhJOmKmMvkf9RnA4Zdh5WxtADVdQ9kiMSXl9wd1/Iyl5WcpGlTjZj1zVo1C/hNm0o
 ocvQtLwYr6gdrx69eKwIZS2SfGgngWgcRh1HetqMdbCc7FEqWJwcXbOYc4x9Uu7UMmmG9B6ak
 8HJJ/VJWMZEHXrtHsqsparJAocC1VO7a6fFH4JhjxmyOf3On+G2yfKlsOchc1ooM1xtTESKC8
 w5ogwFokqtrWPvtEiNMKoq9GuzKDidFMAd4y78qcykcmqyRvHrb5rnfkEt3SKPOpF2Y6y70
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Change CONFIG_SND_SOC_TLV320AIC3X to CONFIG_SND_SOC_TLV320AIC3X_I2C. I
did double check all current mainline device trees and they are all
using the I2C rather than the SPI variant.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

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

