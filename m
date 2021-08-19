Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32D03F1B46
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbhHSOKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:10:54 -0400
Received: from mout.perfora.net ([74.208.4.196]:35165 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240329AbhHSOKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:10:53 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Le6Sw-1mr8nn0t7k-00ptLX;
 Thu, 19 Aug 2021 16:04:11 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/7] ARM: imx_v6_v7_defconfig: build imx sdma driver as module
Date:   Thu, 19 Aug 2021 16:03:43 +0200
Message-Id: <20210819140345.357167-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819140345.357167-1-marcel@ziswiler.com>
References: <20210819140345.357167-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Zig9QhS2f2z4Qgnb9c5DWkjNCOxauwgAvnyWKpRGmKfD0taIeM9
 2Mzd5BDgPqz3/1mcwjpTuJZhx3vakxNOIcMTKFOooxoPnVJZhrnery9aiHVP0TqrkQCiMXp
 kpdYaeQiA1nLoyWa6dnAtc4U+zyvVQbni63TmolGEF1BqadMclngVQEVoVD28gEByzQeKxD
 OJeUZiECKNTwKbL2FcAYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tnA2hHTIvGk=:CYfUsnRWIILQG7jsV9oOdX
 9iHsJK6inRF25XzQZINXwrjT2M/3xXlLSyKZq5hFhVzC95NJD70mcHwgXAy1JZ0x2oZrxZ6dG
 kETL/v5MiHnceOWH6MOhZ8kX1YE5+PvEuDu08lzFMbny/9dPes6c/soqD1LIPULvErXutUL3m
 JVoCfnYaZ2YlwPv+McrmKFErFLeTGv2GirHyNyavHQ2biGqE18y2Ybx+DfMv+9D4PJ0wB2vFc
 HUmTOvu0azER4YaxYtb7K+MjRuYvnPsdC9ISqq8EdplhAFtOGbQ8+3xvCCXrYXFQzAdrRIqeF
 AxsPPtuTkLvmbKC9uNvMbzL81YfC7zvrOyOaek+ZK0/Qg+Qw5pRmb9yPMs/Pao6n6hCWjBRU4
 9Cb6RG2Jm/B03+Lz3o5VbxKa6GCdM0S7cVlelV3i/wL7BFRvYITk6L/fa7htiubdCjgvFWMQz
 Etu4hdk+lLuwLWzPL3cpSbDwfbm6Tis3T+38xi3nIt67rLGhgDCzg5+/kyAk2Gvm1qDwG1E6M
 HLRVGFUywUGnwwWDY85cFhueUyC+NYZB2J5itpocTmq1ocJQn18FUQyzRf2QiUKRM3wwW4TyI
 mgHFO6KwN8EHfyp7+hVMj2sMu2fB7Pa1xjNH2hhfDHMegSKy7WD2bB7Ix9ijIl/YY8njDX2gE
 3VELWvJl1l67viFKTKx0qbOYU0fqGIN9J2Ew1Qdf1wfyi1mkFNtEhn5OOQTnj22ldzVH2B4eH
 Oshi/u8hVeEn+omorChrE//dEjalZ+r42ae1eOC8f02i6y+A0eD2GDt9Ej+Fm9+ca6Mhl2FOj
 csDNZutxWRrBCPDRzP0ysfzzgQNlt6LacZl/FINm6O+gq4zyQ6fbA0Z5TqVp5BzNuuPiRFc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build CONFIG_IMX_SDMA as module to avoid the following boot issue:

[    5.214751] imx-sdma 20ec000.sdma: Direct firmware load for
 imx/sdma/sdma-imx6q.bin failed with error -2
[    5.215762] imx-sdma 20ec000.sdma: Falling back to sysfs fallback
 for: imx/sdma/sdma-imx6q.bin

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

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

