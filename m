Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEC7411788
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbhITOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:52:11 -0400
Received: from mout.perfora.net ([74.208.4.196]:33591 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240848AbhITOv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:51:58 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MPXEU-1mFjRc1hi6-00MdhE;
 Mon, 20 Sep 2021 16:50:06 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/9] ARM: imx_v6_v7_defconfig: build imx sdma driver as module
Date:   Mon, 20 Sep 2021 16:49:34 +0200
Message-Id: <20210920144938.314588-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210920144938.314588-1-marcel@ziswiler.com>
References: <20210920144938.314588-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LAiHB2tfvj4HCStczPgqT6XKBTFzelYtAi2DqRSawydwAmqKYQ9
 t9Hh+5fUYx99qFU0XMC4Jt0rhjM+Hn5+pU/JAFEeKldYhXC4zN8jkFCyNe05sKgeMkVcSCq
 zRkckn+ZgHDWgYSt2A3K+mSJEClXkxDJw1tDpVH23ZrJ2h8gm+SrmTRO35EqUGwtRm+NJN4
 mkrwG2xlg+Fzxm6WHJj0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kQCE7eyWWCY=:krvXzYauDRsTjOlCcO+yDz
 Cb4+OKA1AqHrEvR+0Ro60zc8HnwtAFFMfdSEaCmFyrQnboYYNnnJVyAqY6wTQj+hKAirlKMit
 y23/9+3HVC4ouxip0TAU8vdHE9G7lili9opkhySqnDYfTM8t8XRpmSaC8Y54+cs0xPTgPPXQg
 sd8GtxgMitKAeAz0n1YLG/ZDlkO2IApPlyk1GvBZTKw10Hg9RIooFkTc/rAdbOkVzHL05szHj
 soQHzflgCNl/1DDoXosgHptQNWr3AzPwC4QFSgfgfFOpIgCS/BfJr+C9F73GxiUV5WIKAa2MS
 8z5fjMWSeEHYcA8uow2w/dx7D4QFLnscCnJ7AMrmpSUhtxoELUxZY0EdiDlDIoDVzZK2+QX/A
 I0AqeQsQk/ckWwZSf6fkZUfChlFU5+gWs7ciwcVllNpZDp94+gc3OHMWVigW9AnwB3MD5/dfH
 DG34y7DKJNxAfmgLwWd6+rG6UPeG3hNYX3QcB13FPMH1zfOvhSU7eov6OeNN3jMGI4CNGpJIO
 gJXIvkHsvzip745OX1Tg19hu2DKvJTLRpk9hXUKzhwobfagNq618qC752d6Z3ef3ALGPX6wCc
 ukwO0jqvmQ5TqXy/wyBQ/uQUhLRKoZxp9ix0xue8emX5R00L9r+wfJ8hWe6eAEMUqDXlDzX9D
 7bDflVQ+t8NxXluHeLZnPAunPSXTqJU9GqEmqsL4IfajMfjArRzUZdbPu4jSzPIbcRM6NpHv/
 /Y4y3Q0S9LqLlEik4Adh6RFPnoi9qmlYheUQqA==
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

(no changes since v3)

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

