Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD498411780
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240839AbhITOv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:51:57 -0400
Received: from mout.perfora.net ([74.208.4.194]:41219 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232166AbhITOvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:51:54 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MQMJR-1mFSSe1ud7-00MMiN;
 Mon, 20 Sep 2021 16:50:01 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/9] ARM: imx_v6_v7_defconfig: change snd soc tlv320aic3x to i2c variant
Date:   Mon, 20 Sep 2021 16:49:32 +0200
Message-Id: <20210920144938.314588-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210920144938.314588-1-marcel@ziswiler.com>
References: <20210920144938.314588-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TfvZDmoo1qiCLyZsuVYscf4Vt0ciUzyB9Blmd28w7fdD6Nc5e6W
 h+tYJl8gm0bUbdNtcVz4y4p4rcvqQsgPFUW9eq/j0ZBNdn8ZP/JxsS9KoVc5CgLFHxZpsUh
 x5n0kmTW4r7Grw0LG9r6b7+6GMxmgHLPOlJMQVE4eFVP5qzyLb/WVEyVDKZ9/ma/C9efzZT
 iSKACSWEwVKvcUFVMkf0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L2v23sQPcqs=:bmZ6z3FtTrKyGlst5SugAj
 iijVem61umlPPzoNaQHnzgBXpH/7W3Hqn6rpYmvqY92ocvqAwu/CkCyOtqatmf9u4gGu+qvpE
 i9c09Tkybj0lQVhY9gys1ZXGv3EkJWSGQoQutVjXXK3SzsAjQsnBBTnqw/HA9s03KLOD8X7WL
 nlcrFbYJuBQXzNNDb1l4rdlbhN3U4kd1capNb8Qfz022NU+wQ3jZDa9/Ud4S4MsqR+HtQUWVy
 9iqfDw17EG/Sm1ThG76nucEFIZSiqyqFvBHN/I3VKd6yiak2Ve7dxL9wzuLWfQTdSZmpyJ5Y/
 e/rRrOKfs5FmOHSMHw/UnA635qwzh1x72a+j54+KIU7I/VgH0qE9BswcEJ4SU1MEQFJTQJ5G5
 vUXGWPjI/3xZVGHFNV2kRBiImTfWgiwWOx6d5bhjGLpAEE9koiLfr/paxEaymm4vtSYCVPT5I
 1731eqn2DKCamNfaxAsbWm7eeNthK9T32buZqZEwfSNwjmIvb8MxGCCtsFzhDJxoj/iB5IpZc
 GhcgSdVAcms3FWF83YNDPUhMvj5nd0y7ohrOf54oZ/ZcKb6wiXA2cNiSNtHUchf+g0gqYf5Ol
 IBP6tJG3tGv7oOwSLcGitt8ygM2H38HVX2LrBlhcNqqmuc5Cygm3GWjKF0zIK73Ym5kB2E0Eq
 OcHBWfPpm4l3z7tWTLA18PjcSTbbchoOt7UPT/JZBJoxd3eSK9saUh17a1itoJOVGyJnjEHzO
 awkMDObGRKq+yCJxrOtPzXe+8nNPQEN/nDLaiQ==
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

(no changes since v3)

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

