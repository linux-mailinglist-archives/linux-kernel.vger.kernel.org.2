Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A5941177F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbhITOv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:51:56 -0400
Received: from mout.perfora.net ([74.208.4.196]:50059 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhITOvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:51:54 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MqJRf-1nFQgR1qzb-00nPm9;
 Mon, 20 Sep 2021 16:49:56 +0200
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
Subject: [PATCH v4 1/9] ARM: imx_v6_v7_defconfig: enable mtd physmap
Date:   Mon, 20 Sep 2021 16:49:30 +0200
Message-Id: <20210920144938.314588-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210920144938.314588-1-marcel@ziswiler.com>
References: <20210920144938.314588-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+EzTPNIeR/zkUHJQxQyo9B0k3+Nd9/1lQeMsXavg0wHk2Gw+aSL
 kHD8Xzym1kgdHYYlTktkitVUPNz9fF11S9h2fk2T5HXArbaTV0BIrOirGrxC7piQNSuH8Os
 O4oRV44pxqlUk6A24wshvJGZopRpOMsV94stayRI9XdjCSoYcof8XodBzNOwh9j5K0w15Ui
 XXLak/lbvhqeOQ1+rKfWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xPcSVcmw1kI=:9YqEKc0hCzW6mMxzIg/Ptj
 EyQm6nx/q9ByTGclto33Hj2MmAegHbRln5G164DNwdvl1UUrPTwop6p5njzQ3lXR7/GCicyzm
 cVQNlJ4yhWxp/6v5c+mrcHdT2N00fW42KRI3AQUYfuQ2Mgusut8cjlWw87cRbV26sgTt1JE/D
 oFcCnnGJWlC+d0OefWtEyMTmGM0aR8ouC9ejUkgHjgsN3B/sYWxrA/6KxOEE4n9MVqH2N7M+Q
 qrtM18IG6OaYHrBtJQ0KI2eKHJoRfo7FF5LOYjqMOKNL5J9VqLpsybHxAsFsFLxPvvHdk4jW0
 wI3qtcCTuIlVtC21ij6xJjRyuQOtBuC02geXc8D5HVEL59UirHpDw8s/iGc2WhYHbSwORMcCH
 /ZAsR0ffxSVXgP5qB6kS+sIkxaC0xeuko9PasziCmV3Zf19hFoVr9sUTIDXSifGf2mZtijyw2
 WmMvimUnuORiZnOU59gSaObCUFbgsvK3ntM27L3VzdIPGUvUiSIbsD05eD8k6ZtVj9LyQZFHU
 JGDW5Tm8CrVJQYn6A0PgGhANHb2NH+VCjrEpRTleVye3AmteYVMF/zo2ZVuvoM2hguHucpw8P
 qMjOznvY9mEezuw6y4ip94/FGGq7IeCeVZAq0anGDFkohKp0mDgzp70mKSJUwKBMpVZAnRSo3
 mueyIqFz8Mtj+8vBEtyIckc7+iJs9+p9wP0oprtjKl3ORrN2fsi4YmMQZFMpP/N2xQMkgwIIe
 3dVObjKR+UmlXvq3uftK4a/RA4uScOyLGJhlRA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_MTD_PHYSMAP which is nowadays required for
CONFIG_MTD_PHYSMAP_OF.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

(no changes since v3)

Changes in v3:
- Add Fabio's reviewed-by. Thanks!

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index ccee86d0045dd..70b3c377c4302 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -97,6 +97,7 @@ CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_M25P80=y
-- 
2.26.2

