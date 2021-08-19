Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637043F22C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbhHSWKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:10:51 -0400
Received: from mout.perfora.net ([74.208.4.196]:38185 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236292AbhHSWKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:10:43 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MfFYy-1mRDAP3uEk-00Opoz;
 Fri, 20 Aug 2021 00:09:32 +0200
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
Subject: [PATCH v2 3/9] ARM: imx_v6_v7_defconfig: change snd soc tlv320aic3x to i2c variant
Date:   Fri, 20 Aug 2021 00:09:04 +0200
Message-Id: <20210819220910.586819-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819220910.586819-1-marcel@ziswiler.com>
References: <20210819220910.586819-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TwIzRkxI8I1Aisdr6aq3wDNoO7A+dexxb1x8MHRnwLjFa3lSyhT
 sIx7AKkzDiFLVt/0PV5LkJ65sc/A7+ISXZunSPrTM4x10iMyf8M2Gx5kabI4C6Q0U784/YK
 TKXoU14qofDHIk0GO/a4qDhaQi7tGcStTSK5fY5N/TbJmv6tVV8cVt0BcSJ1BbJjD554/5o
 c1dQOn/DF0jewBOpWGa5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HkiqhnaEVaM=:QFhCEexkZO4b0QZtHHqerG
 hzvyoqSUuH85Dd3RtWi0XD998UYB6F4CEUgb0/507l7A9HQOBlUQCOd1FRdsLFonBFSk9t8Kc
 9SkeUKI4bPhqn7zSlyb3NBDSso2H5ZzGbbBxFBdgNpwasO+SeAGbkXVoxoaYL7dGCYgotNMeE
 7ZcVjofYaipms/F2NQxazyqejwZJWgo8V6Fs3lKR5WsXgjh9DMUxItgQNRso1C4N2fK+f/xF9
 sOT0A6/W4nq92gJukLmnA9unaAqWMB3K/T+d8pBBi3/R7R1dwUJnDPm7l25HWqQst6r/hAEDB
 WAh99FO0Lh3jAVV0dLb7MCMg1qcbKYhla+iMl/zn0riRUxHHFkb6s9LJnd+8CpJuKdznG8idN
 xJIeuDE8D7mfOueoME2ouZSdj6p9IB/T1ghFPn/QvaKDghvzQe7DixFz3emwOgQCCy6V+LWes
 wALvumh9y58c90Vkvy5JBxx9JLJjDrTfVcqBWwB/sjq3ovvGFQXYQpiaOXKz7cZcuLbdxNnjc
 WfNvdRe63W8deaEEc2M/CUpZfGXHO7ghlfsKT+Tk12GuRng8zdm8P9dPj1MBIHG9DknSvVjS3
 c+IaD6d7BSKjUFe+K4tqoWwBczJ0/4QUc911jqMtNKkZuyXG1wTdEDTXCjo9OEkB9CsoHZHrs
 h/wLz/4u5Xblkt7WSKH9R8Q0TYMQ65cILvIxdLKxRQCiBMavL3/BVld1OD/IRLcknULIZYSw1
 Cw8udrgbE90RlCkWZRMdLFvbd7fmyW2t84LlpV1/py+0Da0Prhsm+JRP8x/+IBYaY9S9zlKi+
 tWWTLlBFyMlbC6S2oHrjWz0AoaNs7KoncZ3wmvahrsTifIrvKfQ6BsS0FUxaFlGObQbFVp+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Change CONFIG_SND_SOC_TLV320AIC3X to CONFIG_SND_SOC_TLV320AIC3X_I2C.
I did double check all current mainline device trees and they are all
using the I2C rather than the SPI variant.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

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

