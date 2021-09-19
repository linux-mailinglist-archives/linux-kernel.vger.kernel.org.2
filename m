Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94625410B9C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhISM5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 08:57:52 -0400
Received: from mout.perfora.net ([74.208.4.196]:49275 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhISM5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:57:50 -0400
Received: from localhost.localdomain ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MVdcm-1mI4yV21Ui-00RbWB;
 Sun, 19 Sep 2021 14:56:03 +0200
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
Subject: [PATCH v3 5/9] ARM: imx_v6_v7_defconfig: build imx sdma driver as module
Date:   Sun, 19 Sep 2021 14:55:32 +0200
Message-Id: <20210919125536.117743-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210919125536.117743-1-marcel@ziswiler.com>
References: <20210919125536.117743-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NKl4VZx5K07zmebyx3uvwqqSnIPuODWaKfhPxEAB7DvuUgdbDo7
 YtxQ32WjDqwXnFRTVVAC0Ef06ZOtipHJQIr89e3TfTYMZZhnBwDXnpIJxNhXnS11hCPZan5
 2V1+pLuog5wMSnfy7xjMB1PpEQRdEslBKsa+cnfKGZDdTVhoyyM6BBOyWFX9PW/+dHpdLYL
 BuLQ1/BlLhi6a3t/6Phmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D/2HG7l2S0Q=:TnXmGPt1YJqSU2n/8FFD48
 fzj89Y2j/8AasamCHxZ1+byrySPqdLMc1twTE/dYYOvPVg9kTdFiZ09J5U7akGG6fkGdzMgbX
 qM7M2OEmuyMzblekbaVWdxl7MCBp7NsgXyvMYQj90rONuDVmcs0aQo8F0uFWZMLCzepYSy6Oh
 pZ8ui35/XFeeeXm9qRpa/WMeJTj/ZsdUNH56ePsdO7rND6S5xfcQcELdRkIPM6URMP2F16f7d
 yr73Ga7qfkzStUvkBBKbU0sEhC0wsTwBSZ4hXT7N6Wi+pM1s2VZhn7VgkGSClRvEHdp+jtsv0
 3LQM0ulP7wq6rie4kzjyDtrLnPYzCJtWgs/+nMEo+ZlLS8Upy5xDH6LyYAWn3M2attECP9aDy
 1gSAJy0E7JtpraA41ANJy1Lu2Gq6o00HiUFcLBlf0RZ/7pniEPGEV0QKPWoX8Nsee0U1MUGrL
 oa8gzKFaUNsjaNs4SfBhncgWyCQ4T8J4YLjxZNaHrJB8vcTfSGAekwM99gTV3UnbwgqIoOuOc
 w9nPDYOm4BR2IN0XOyzTcllohzApk+O9vgT1xtuQB7SQJupHEvXftBJy2Siev+BbfuxMdzQqy
 ldDwe6FKnWZyUIhyOIqwf/BzQ0zA3ajAfi0b7RoSvAH1xueccPdghxNi0txB/1fRjTOxXRY76
 g5Eu36C/IGZpTr4chwRH2tL0KbF4nu+qk822zCPtjzNTLTEmUu3mAFN4zEW7wIUvWjznZ4XwP
 pT0Lrfk2DR4a0T4Tn5fnh+4ErC+81LBV/TKf+Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build CONFIG_IMX_SDMA as a module to avoid the following boot issue:

[    5.214751] imx-sdma 20ec000.sdma: Direct firmware load for
 imx/sdma/sdma-imx6q.bin failed with error -2
[    5.215762] imx-sdma 20ec000.sdma: Falling back to sysfs fallback
 for: imx/sdma/sdma-imx6q.bin

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes in v3:
- Add Fabio's reviewed-by. Thanks!

 arch/arm/configs/imx_v6_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 21803cd2d1ba7..c0008b7faf2ce 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -380,7 +380,7 @@ CONFIG_RTC_DRV_MXC_V2=y
 CONFIG_RTC_DRV_SNVS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
-CONFIG_IMX_SDMA=y
+CONFIG_IMX_SDMA=m
 CONFIG_MXS_DMA=y
 CONFIG_DMATEST=m
 CONFIG_STAGING=y
-- 
2.26.2

