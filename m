Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390013F22BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhHSWKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:10:40 -0400
Received: from mout.perfora.net ([74.208.4.194]:37743 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236067AbhHSWKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:10:38 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MYh3k-1mcEjM1X86-00VTeX;
 Fri, 20 Aug 2021 00:09:26 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] ARM: imx_v6_v7_defconfig: enable mtd physmap
Date:   Fri, 20 Aug 2021 00:09:02 +0200
Message-Id: <20210819220910.586819-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819220910.586819-1-marcel@ziswiler.com>
References: <20210819220910.586819-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Tx2LXUjppl39seKmcnQp1iuWa4VKyEY+aorXnyfpaLWpCuvYo25
 9QYu2hmHHkO1DsE44PFGvF2bXWDLQYWIDwoqgbzCifK7yWtohJD+aYVA86CZt1Z7rO9LJXn
 CSLgRAlnUpenBlCDPdDYmhLmD8I9cHHU3GX8Pjh4I2sIwaoAqXQ6Zj3qvJaqeyuu/XDkAbI
 67R5nh+xy9Xlg7OZ0buPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d0gJMZm2pLY=:OI4vWzwfPuUmygX93U14xp
 kvNQSWAhnnQC0sllAF13440hYZinzq2WX+M4u9/8zciuOZZ5jPlPKzVC8OGlggfRcOqNwMJvj
 6r6sLpw8WT2OEY2lQwp5cwXVlunpiBSr0DL1Wn7e+MUmt2gDVwsYUA0BSOMWX5rrkJgv428uz
 CVEXWqlLlZqP+Zr6h2Oh2vPVZAnRQLgz8L3ArYCCQKgJ4p0mg1zmQn+2NlShZyXH/phX6Oug2
 xlQ4ulZlazEvLdlHNkLPbsFbdwwzT4c2w1n1VHCkxlGAn242CEf+TFh7sdt2ZcjCACGeWaE9s
 L7W+u3NxV23EDBjBjjuLn/8icZlc/+XFbYozIDG7brOKeXAtz87TAhN8TA0r25k9wyjwjrysc
 eeoviS1f0f8DLy+1dAsUcyow2Yu4CuKHlk2GqG81Jzl9qyyG4P8j2u9nUM4K9FMKxI8dSMRA3
 /f13zqteqef2Wz1mRtSsMWxnwUTpl9tH19n3voMVFM/v7nIwAJZNM53VEeBF6lIS4LKbxDh1z
 qr9DPbJcXkMHwVAcrYcphXIU/yfwFMGWVJn4s+4zyjaRpPt2sgVSZq7pgFDRmMdnPnu6t49lW
 mJrsgyPcLLsPZPXxEhPorBnK/aFGLeHg2rMf1uoQc6KVPpqUQHP3DirQXq3yHpYwJhbSO/f07
 88JklQALUNbrtTexKCf6/OmPt1vRBOBvln00FFvpkvdIyHU1c+v7ByVHV/Rc46u/qpZ92j7hU
 mtVeoD1S40ZzMF2UrHjkB/8z+C6WIt/Xx+OfUZi/GGTYvw6uErOXK81gztCW5dM2+nW82U3bf
 SpWs4eZyPrHXFtNqHOIVe3R9YNHQ+TMBVOksMJAimt6sW3UDsrf20eFyDXXABBaU5zZN0Er
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_MTD_PHYSMAP which is nowadays required for
CONFIG_MTD_PHYSMAP_OF.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

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

